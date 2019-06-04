#!/usr/bin/perl
# Change this to suit the environment
#
#

use 5.6.0;
use strict;
use Env;
use Getopt::Long;
use Pod::Usage;
use Term::ANSIColor qw(:constants);
use File::Basename;
use DBI qw(:sql_types);
use Errno;

my $start_time=time();            # Start time
my $file_count:=0;                # Simple statistics
my $progname=$0;                  # This program name

#   Exits with the return codes:
my $err_success       = 0;
my $err_source_file_type = 208;
my $err_wait_files    = 209;
my $err_inv_date      = 210;
my $err_no_files      = 220;
my $err_source_lock   = 221;
my $err_inv_param     = 222;
my $err_inv_env       = 223;
my $err_inv_data      = 224;
my $err_oracle_proc   = 225;


my $dbh;                            # DB connection handle

my %map_delimiters = (
  "SPACE"       => " ",
  "DOUBLESPACE" => "  ",
  "TAB"         => "\t",
  "PIPE"        => "|",
  "LF"          => "\n",
  "CR"          => "\r",
  "CRLF"        => "\r\n",
  "PERIOD"      => ".",
  "COMMA"       => ",",
  "DOUBLEQUOTES" => "\"",
  "SINGLEQUOTES" => "'");

# global parameters
my ($load_run_id,$file_id,$ad_hoc, @data_file_glob);
# Commandline and configuration parameters
my ($user,$inst,$pswd,$source_name,$source_file_type,$jap_as_of_date,$data_basis,$debug,$verbose,$quiet,$help,$man,$file_name,$version,$release,$notify);

##############################################################################
# Print information if verbose mode is on
# error is called on a die, so we add a helpful 'Exiting...' message.
sub error {
  print RED, @_, "Exiting $progname with error: $!", RESET, "\n";
}
sub warning {
  print BLUE, @_, RESET;
}
sub info {
  print GREEN, @_, RESET if $verbose;
}
sub debug {
  print YELLOW, @_, RESET if $debug;
}

##############################################################################
# Creates a name-value Tuple file based on the format of the text file
# that it reads. The names of the tuples are specified in the first data
# line of the text file, which is not necessarily the first line in the file.
# The created tuple file is wrapped in the format:
# Name=value|Name=value|......|Name=value
# Name=value|Name=value|......|Name=value
# Name=value|Name=value|......|Name=value
# ....
#
# Assumption: Values will not contain a '|' character.
#
# Feed2Tuple([datafilepath],[skiplines],[column_delimiter],
#            [line_delimiter],[string_encloser]);
# where:
#  1. Entire Data file path. Mandatory
#  2. Number of lines to skip in data file. Default 0
#  3. Column delimiter character. Default ','
#  4. Line delimiting character. Default '\\n'
#  5. String enclosing character. Default '"'
#
# Feed2Tuple creates <filename>.tup for an input <filename>.<ext>.
#
# Returns tuple file name if successful
sub Feed2Tuple {
  my $data_file_name        =shift;
  my $skip_lines_to_header  =shift||0;
  my $col_delimiter         =shift||"COMMA";
  my $line_delimiter        =shift||"CR";
  my $string_encloser       =shift||"SINGLEQUOTES";

  debug "Feed2Tuple([$data_file_name],[$skip_lines_to_header],[$col_delimiter],[$line_delimiter],[$string_encloser])\n";

  # Map delimiters to actual chars:
  $col_delimiter  =$map_delimiters{$col_delimiter};
  $line_delimiter =$map_delimiters{$line_delimiter};
  $string_encloser=$map_delimiters{$string_encloser};

  # Dealing with column delimiter that are special characters in regexes
  # Make up a comprehensive regex for parsing columns with:
  my $esc_col_delimiter     =  $col_delimiter;
  $esc_col_delimiter        =~ s/\||\\|\/|\(|\)|\[|\]|\./\\$&/g;
  my $re_col_delimiter      =  qr/$esc_col_delimiter/;

  if(!defined($data_file_name)){
    # Print function usage
    $!=$err_inv_param;
    die error("Feed2Tuple: Data filename not defined");
  }

  my $tuple_delimiter='|';

  # When the delimiter character is a comma, we need to deal with special cases
  #      where commas are imbedded in text fields
  #      e.g. "A, B" or "A, B, C" or "A, B, C, D"
  #      Limitation: Can't deal with a field that has more than 3 embedded commas
  #      e.g. "A, B, C, D, E"
  # The same applies for when the delimiter is any character and that character
  # appears inside a string
  my $anti_col_delimiter    = ($col_delimiter eq ","?"|":",");
  my $re_anti_col_delimiter = ($col_delimiter eq ","?qr/\|/:qr/,/);
  # column delimiter appears twice in quoted string to parse out "A,B,C,D"
  my $re_quoted_col_delimiter_occurs_3 = qr/$string_encloser([[:alnum:][:space:]]+)$esc_col_delimiter([[:alnum:][:space:]]*)$esc_col_delimiter([[:alnum:][:space:]]*)$esc_col_delimiter([[:alnum:][:space:]]+)$string_encloser/;
  # column delimiter appears twice in quoted string to parse out "A,B,C"
  my $re_quoted_col_delimiter_occurs_2 = qr/$string_encloser([[:alnum:][:space:]]+)$esc_col_delimiter([[:alnum:][:space:]]*)$esc_col_delimiter([[:alnum:][:space:]]+)$string_encloser/;
  # column delimiter appears once in quoted string to parse out "A,B"
  my $re_quoted_col_delimiter_occurs_1 = qr/$string_encloser([[:alnum:][:space:]]+)$esc_col_delimiter([[:alnum:][:space:]]+)$string_encloser/;
  # column delimiter does not appear and the string is unnecessarily quoted
  my $re_quoted_col_delimiter_occurs_0 = qr/$string_encloser([[:alnum:][:space:]]+)$string_encloser/;

  # Dealing with comma-separated 1000's in numberical fields,
  # e.g. 3,554,234,123.00 which should become 3554234123.00
  my $re_1000_seperator = qr/,(\d\d\d)/;

  # Dealing with interesting column header names:
  # Case 1: Space becomes an underscore
  my $re_spaces=qr/ +/;
  # Case 2: Ampersand becomes an underscore
  my $re_amp=qr/&/;
  # Case 3: Double underscore becomes single
  my $re_double_underscore=qr/__/;
  # Case 4: Wrapped in single or double quotes
  my $re_quotes=qr/^$string_encloser(.*)$string_encloser$/;
  # Case 5: Empty string
  my $re_empty=qr/^ +$/;

  # Makeup file name for SQLLDR
  # Do in long way to deal with files names with no extension
  my $tup_file=$data_file_name;
  $tup_file=~s/(.+)\..*$/$1/;
  $tup_file.='.tup';

  # Get line with header after skipped line
  my $header_line;
  my @staging_cols;
  my @staging_cols_;
  my @data_cols;
  # Input file
  open(FEED,"$data_file_name") || die "Could not open $data_file_name for reading. $!\n";
  # Output file in temp directory
  open(TUP,"> $tup_file") || die "Could not open $tup_file for writing. $!\n";
  # Make the file writable so that other users can remove it on error
  chmod(0666,$tup_file);

  $/ = $line_delimiter;

  # Statistics:
  my $empty_rows=0;
  my $full_rows=0;

  while(<FEED>){
    chomp;
    if($.==($skip_lines_to_header+1)){
      # Get columns from HEADER
      debug("HEADER line:\n$_\n");
      s/$re_amp/_/g;
      # Remap column headers that have column delimiter chars embedded in them
      s/$re_quoted_col_delimiter_occurs_3/$1_$2_$3_$4/g;
      s/$re_quoted_col_delimiter_occurs_2/$1_$2_$3/g;
      s/$re_quoted_col_delimiter_occurs_1/$1_$2/g;
      s/$re_quoted_col_delimiter_occurs_0/$1/g;

      # Split de-ambiguated line
      @staging_cols_=split /$re_col_delimiter/;
      foreach my $col (@staging_cols_){
        # Clean up column name
        # Remove '\'
        $col=~s/\///g;
        # Convert spaces to underscores
        $col=~s/$re_spaces/_/g while $col=~/$re_spaces/;
        # Rationalize underscores
        $col=~s/$re_double_underscore/_/g while $col=~/$re_double_underscore/;
        $col=~s/\n//g;
        $col=~s/$re_quotes/$1/;
        # Fix any previously obliterated commas in data
        $col=~s/$re_anti_col_delimiter/$col_delimiter/g;
        # Remove surrounding quotes
        $col=~s/$re_quotes/$1/;
        # Uppercase the column name
        push @staging_cols,uc($col);
      }
      if((scalar @staging_cols)<1){
        $!=$err_inv_data;
        die error(" * No columns found in the file header of\n * $data_file_name.\n * Was the column delimiter or the preamble length correctly specified?\n* The column delimiter should be a $col_delimiter.\n");
      }
    }

    if($.>($skip_lines_to_header+1)){
      debug("DATA line:\n$_\n");
      # If the column delimiter is a comma and we have data fields like ...,"Consumer, Cyclical",...
      # then replace ',' inside "..." with '|' before splitting to disambiguate it. We can use '|' because '|' is normally stipped out.
      # Later replace '|' back with ',' (= $anti_col_delimiter='|')
      # We expect at most 3 embedded commas in such a field
      if($col_delimiter eq ','){
        # Disambiguate for 3 embedded commas:
        s/$re_quoted_col_delimiter_occurs_3/$1$anti_col_delimiter$2$anti_col_delimiter$3$anti_col_delimiter$4/
          while m/$re_quoted_col_delimiter_occurs_3/;
        # Disambiguate for 2 embedded commas:
        s/$re_quoted_col_delimiter_occurs_2/$1$anti_col_delimiter$2$anti_col_delimiter$3/
          while m/$re_quoted_col_delimiter_occurs_2/;
        # Disambiguate for 1 embedded commas:
        s/$re_quoted_col_delimiter_occurs_1/$1$anti_col_delimiter$2/
          while m/$re_quoted_col_delimiter_occurs_1/;
        # Disambiguate for 0 embedded commas but the string is unnecessarily quoted:
        s/$re_quoted_col_delimiter_occurs_0/$1/
          while m/$re_quoted_col_delimiter_occurs_0/;
      }

      # Split (possibly disambiguated) line
      @data_cols = split /$re_col_delimiter/;

      # Special case: If the LAST one or more columns contain no data, split would not have seen it.
      # So add empty elements to avoid later discrepancies.
      push @data_cols, "" while (scalar @data_cols) < (scalar @staging_cols);

      # Make up staging record
      my $staging_record;
      my $index=0;
      my $populated_cols=0;
      my $one_shot=0;
      foreach my $col (@data_cols){
        # Only show data for columns for which corresponding column headers had text
        if(length($staging_cols[$index])>0){
          # Fix any previously quoted & temporarily-changed col delimiters
          if($col_delimiter eq ','){
            $col=~s/$re_anti_col_delimiter/$col_delimiter/g;
          }
          # Remove surrounding quotes
          $col=~s/$re_quotes/$1/;
          # Squash strings that contain only spaces
          $col=~s/$re_empty//;
          # Trim spaces
          $col=~s/^ +//;
          $col=~s/ +$//;
          # Remove 1000's seperators
          $col=~s/$re_1000_seperator/$1/g;
          # Delimiter between tuples
          $staging_record.=$tuple_delimiter if($one_shot>0);
          $one_shot=1;
          # Add tuple to row
          $staging_record.="$staging_cols[$index]=$col";
          # Keep track of number of populated columns in row
          $populated_cols++ if(length($col)!=0);
        }
        $index++;
      }
      # Add record if at least one tuple had data in it, else we ignore it.
      if($populated_cols>0){
        print TUP "$staging_record\n";
        $full_rows++;
      }else{
        $empty_rows++;
      }
    }
  }

  close(FEED);
  close(TUP);
  debug " - Created $tup_file\n";
  debug "   which contained $full_rows populated rows\n";
  debug "   and $empty_rows empty rows.\n" if($empty_rows);
  return $tup_file;
}

##############################################################################
# Get Config Parameter
sub GetConfigParameter{
  my $param=shift;
  my $rv;
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv := utl.pkg_config.get_variable_string(:parameter1);
      end;
    });
    $cursor->bind_param(":parameter1",$param);
    $cursor->bind_param_inout(":rv", \$rv, SQL_VARCHAR);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error getting configuration parameter '$param'\n$DBI::errstr\n");
  }
  debug "Config Parameter [$param] is set to [$rv]\n";
  return $rv;
}
sub GetConfigParameterInt{
  my $param=shift;
  my $rv;
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv := utl.pkg_config.get_variable_int(:parameter1);
      end;
    });
    $cursor->bind_param(":parameter1",$param);
    $cursor->bind_param_inout(":rv", \$rv, SQL_INTEGER);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error getting configuration parameter '$param'\n$DBI::errstr\n");
  }
  debug "Config Parameter [$param] is set to [$rv]\n";
  return $rv;
}

##############################################################################
# Register the start of this run
# Returns $load_run_id
sub CreateLoadRun {
  my ($source_name,$data_basis,$jap_as_of_date) = @_;
  debug "CreateLoadRun('$source_name','$data_basis','$jap_as_of_date')\n";
  my $rv;
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv:=vcr.pkg_source_load_run_mod.create_load_run(to_date(:jap_as_of_date,'YYYYMMDD'),:source_name,:data_basis);
      end;
    });
    $cursor->bind_param(":source_name",$source_name);
    $cursor->bind_param(":data_basis",$data_basis);
    $cursor->bind_param(":jap_as_of_date",$jap_as_of_date);
    $cursor->bind_param_inout(":rv", \$rv, SQL_INTEGER);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error registering a new load run for source '$source_name'.\n$DBI::errstr\n");
  }
  info " - New Load run [$rv] registered\n";
  return $rv;
}

##############################################################################
# Purges the staging area for the give source file id
# Returns $load_run_id
sub PurgeStagingArea {
  my $source_name = shift;
  debug "PurgeStagingArea('$source_name')\n";
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        vcr.pkg_purger.purge_staging_area(:source_name);
      end;
    });
    $cursor->bind_param(":source_name",$source_name);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error purging the staging area for source '$source_name'.\n$DBI::errstr\n");
  }
}

##############################################################################
# Check if this source is already running for the given source name
# Returns 1 if true, 0 if false
sub IsSourceLoading {
  my $source_name = shift;
  debug "IsSourceLoading('$source_name')\n";

  my $rv;
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv := utl.pkg_math.bool2num(vcr.pkg_source_load_run.is_source_loading(:source_name));
      end;
    });
    $cursor->bind_param(":source_name",$source_name);
    $cursor->bind_param_inout(":rv", \$rv, SQL_INTEGER);
    $cursor->execute || die;
    $cursor->finish;
  };

  if($@){
    $!=$err_oracle_proc;
    die error("Error checking if source '$source_name' is currently loading.\n$DBI::errstr\n");
  }
  debug " - source '$source_name' is ",$rv==0?"not ":"","loading.\n";
  return $rv;
}

##############################################################################
# Gets sufficient details about the source file type to load it via SQLLDR
sub GetSourceFileTypeDetails {
  my $source_file_type = shift;
  my $source_name=shift;
  debug "GetSourceFileTypeDetails('$source_file_type','$source_name')\n";
  my $rv='                                                                                                          '; # Dirty trick!
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv := vcr.pkg_source.get_source_details(:source_file_type,:source_name);
      end;
    });
    $cursor->bind_param(":source_file_type",$source_file_type);
    $cursor->bind_param(":source_name",$source_name);
    $cursor->bind_param_inout(":rv", \$rv, SQL_VARCHAR);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error getting details about source file type '$source_file_type' for source '$source_name'\n$DBI::errstr\n");
  }
  debug " - [$rv]\n";
  return $rv;
}

##############################################################################
# Register the loading of each file load with the VCR
sub AddFile {
  my ($load_run_id, $source_file_type, $file_id, $file_name, $dir_name, $gen_date)=@_;
  debug "AddFile($load_run_id, '$source_file_type', '$file_id','$file_name','$dir_name','$gen_date')\n";
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        vcr.pkg_source_load_run_mod.add_file(:load_run_id,:source_file_type,:file_id,:file_name,:dir_name,to_date(:gen_date,'YYYYMMDD'));
      end;
    });
    $cursor->bind_param(":load_run_id", $load_run_id);
    $cursor->bind_param(":source_file_type",$source_file_type);
    $cursor->bind_param(":file_id",     $file_id);
    $cursor->bind_param(":file_name",   $file_name);
    $cursor->bind_param(":dir_name",    $dir_name);
    $cursor->bind_param(":gen_date",    $gen_date);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error registering a new file '$source_file_type'\n$DBI::errstr\n");
  }
}

##############################################################################
# Globs a file. Using the glob function invokes a sub-shell that causes
# memory error on HP-UX.
# This emulates the behaviour of File::Glob and <...>
sub Glob {
  my $source_file_glob = shift;
  $source_file_glob=~/^.*\//;
  debug "Glob('$source_file_glob')\n - [$&][$']\n";
  my $dir_glob  = $&;
  # Escape RegEx chars
  my $file_glob = $';
  $file_glob=~s/\./\\\./g;          # periods
  $file_glob=~s/\?/\./g;            # question marks
  $file_glob=~s/\*/[[:word:]]+/g;   # identifiers
  debug " - File globbing RegEx: $file_glob\n";

  my $re_file_glob=qr/$file_glob$/;  # Add an end of line (escaped $ since qr//) so that .md5 file are ignored
  if(!opendir(DIR,$dir_glob)){
    $!=$err_oracle_proc;
    die error("Could not open directory $dir_glob: $!");
  }

  debug "The following files were found in $dir_glob:\n";
  my @all_files = grep !/^\.+/, readdir DIR;
  #my @all_files = readdir DIR;
  my @files;
  foreach my $file (@all_files){
    if($file=~m/$re_file_glob/){
      $file="$dir_glob$file";
      debug "  $file\n";
      push @files,$file;
    }
  }
  if(scalar @files==0){
    debug "  * none *\n";
  }

  close DIR;
  return @files;
}

##############################################################################
# Returns a comma delimited list of source_file_type e.g. gfsmgs, gfsrmf
# for the given source name
sub GetSourceFileTypes {
  my $source_name = shift;
  debug "GetSourceFileTypes('$source_name')\n";
  my $rv;
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        :rv:=vcr.pkg_source.get_source_file_types(:source_name);
      end;
    });
    $cursor->bind_param(":source_name", $source_name);
    $cursor->bind_param_inout(":rv", \$rv, SQL_VARCHAR);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error getting source file types for source '$source_name'\n$DBI::errstr\n");
  }
  debug " - $rv\n";
  return $rv;
}

##############################################################################
# Attempt to extract generated date from filename
# If this cannot be found, look at the file timestamp and use this
# Returns the result in YYYYMMDD Japanese Format
sub GetFileGenerationDate {
  my $file_path = shift;  # Need to specify pull file path as we might need to look at the file system
  debug "GetFileGenerationDate($file_path)\n";
  # Try formal file name convention:
  my $gen_date=($file_path=~/\.gen\.(20[0-9][0-9][0-1][0-9][0-3][0-9])\./);
  if($gen_date){
    $gen_date=$1;
  }else{
    # Did not manage to extact the generation stamp from the file name:
    # Get the file generation stamp from the system file stamp
    my @stats;
    my ($d,$m,$y);
    eval{
      @stats=stat($file_path);
    };
    if(!$@){
      # Get file system time stamp
      ($d,$m,$y)=(localtime($stats[9]))[3..5];
    }else{
      # Could not get file stats - get system time
      ($d,$m,$y)=(localtime(time()))[3..5];
    }
    $y+=1900;
    $m++;
    $m=(length($m)==1)?"0$m":"$m";
    $d=(length($d)==1)?"0$d":"$d";
    $gen_date="$y$m$d";
  }
  debug " - $gen_date\n";
  return  $gen_date;
}

##############################################################################
# If there are import errors because of missing files send a notification to the admin team
sub NotifyAdmin {
  my ($error_message,$source_name,$source_file_type,$jap_as_of_date,$data_basis)=@_;
  debug "NotifyAdmin('$error_message','$source_name','$source_file_type','$jap_as_of_date','$data_basis')\n";
  # Make up error message
  my $subject="Missing files for Source=$source_name, Source File Type=$source_file_type, As-of-date=$jap_as_of_date, Data basis=$data_basis";
  $error_message=~s/ *\n/ /g; # Replace new lines with spaces
  eval {
    my $cursor=$dbh->prepare(q{
      begin
        vcr.pkg_notifications.notify_admin(p_subject=>:subject,p_body=>:error_message);
      end;
    });
    $cursor->bind_param(":subject", $subject);
    $cursor->bind_param(":error_message", $error_message);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error notifying Admin. Intended error message:\n$error_message\n$DBI::errstr\n");
  }
}

##############################################################################
# Log error to Remedy
sub NotifyRemedy {
  my ($error_code,$error_message,$source_name,$source_file_type,$jap_as_of_date,$data_basis)=@_;
  debug "NotifyRemedy($error_code,'$error_message','$source_name','$source_file_type','$jap_as_of_date','$data_basis')\n";
  $error_message.="Missing files for Source=$source_name, Source File Type=$source_file_type, As-of-date=$jap_as_of_date, Data basis=$data_basis.\n";

  eval {
    my $cursor=$dbh->prepare(q{
      begin
        utl.pkg_errorhandler.log_error(:error_code,:error_message);
      end;
    });
    $cursor->bind_param(":error_code", $error_code);
    $cursor->bind_param(":error_message", $error_message);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error notifying Remedy. Intended error message:\n$error_message\n$DBI::errstr\n");
  }
}

##############################################################################
# If the import errors because of missing files send a notification to the admin team
sub LogError {
  my ($error_code,$error_message,$load_run_id)=@_;
  $load_run_id="NULL" if !defined($load_run_id);
  debug "LogError($error_code,'$error_message',$load_run_id)\n";

  eval {
    my $cursor=$dbh->prepare(q{
      begin
        vcr.pkg_source_load_run_mod.log_error(:error_code,:error_message,:load_run_id);
      end;
    });
    $cursor->bind_param(":error_code", $error_code);
    $cursor->bind_param(":error_message", $error_message);
    $cursor->bind_param(":load_run_id", $load_run_id);
    $cursor->execute || die;
    $cursor->finish;
  };
  if($@){
    $!=$err_oracle_proc;
    die error("Error logging error. Intended error message:\n$error_message\n$DBI::errstr\n");
  }
}

##############################################################################
# Main Program
##############################################################################

# Parse commandline parameters
GetOptions( 'instance|i=s'          =>\$inst,
            'user|u=s'              =>\$user,
            'password|p=s'          =>\$pswd,
            'source_name|s=s'       =>\$source_name,
            'file_name|f=s'         =>\$file_name,
            'as_of_date|a=s'        =>\$jap_as_of_date,
            'data_basis|b=s'        =>\$data_basis,
            'source_file_type|sf=s' =>\$source_file_type,
            'debug|d'               =>\$debug,
            'verbose'               =>\$verbose,
            'release|r'             =>\$release,
            'version|v=s'           =>\$version,
            'quiet'                 =>\$quiet,
            'help|?'                =>\$help,
            'man|m'                 =>\$man,
            'release'               =>\$release,
            'notify|n'              =>\$notify) ||
  pod2usage(-exitstatus=>$err_inv_param, -verbose=>1);
pod2usage(-exitstatus=>$err_inv_param, -verbose=>0) if $help;
pod2usage(-exitstatus=>$err_inv_param, -verbose=>2) if $man;
debug '$Header: Feed2Oracle.pl 1.43 2005/10/28 10:13:43BST ghoekstra DEV  $',"\n";
if(defined($release)){
  print '$Header: Feed2Oracle.pl 1.43 2005/10/28 10:13:43BST ghoekstra DEV  $',"\n";
  exit 0;
}

# Check commandline parameters and set defaults
# Default help for no parameters
if(!defined($jap_as_of_date) && !defined($source_name) && !defined($data_basis)){
  pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
}

# Missing parameters
if(!defined($jap_as_of_date)){
  warn "As-of-date not specified";
  pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
}
if(!defined($source_name)){
  warn "Source file identifyer is not specified";
  pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
}
if(!defined($data_basis)){
  warn "Data Basis is not specified";
  pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
}

# Control output to STDOUT
$verbose=1 if(defined($debug));
if(defined($quiet)){$verbose=0;$debug=0;}

# Specifying a version implies ad-hoc mode
if(defined($version)){
  if(defined($file_name)){
    warn "Specified a version with an explicit file name.";
    pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
  }
  $version=~s/^([0-9])$/00$1/;
  $version=~s/^([0-9][0-9])$/0$1/;
  if(length($version)==3){
    $ad_hoc=1;
  }else{
    warn "The version parameter must be specified in the format [0-9][0-9][0-9] with leading zero's.";
    pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
  }
  if(defined($file_name)){
    warn "Cannot specify both a version number and a specific file name";
    pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
  }
}else{
  if(defined($file_name)){
    if(!defined($source_file_type)){
      warn "Did not define a Source File Type when defining an explicit file name or glob.";
      pod2usage(-exitstatus=>$err_inv_param, -verbose=>0);
    }
    $ad_hoc=1;
  }else{
    $version="001";
  }
}
info($ad_hoc?"Ad-Hoc mode\n":"Automated mode\n");


# Check date format
my $as_of_date;
eval{
  use Time::Local;
  $as_of_date=timelocal(0,0,0,substr($jap_as_of_date,6,2),substr($jap_as_of_date,4,2)-1,substr($jap_as_of_date,0,4));
};
if($@){
  warn "Invalid date specified: $jap_as_of_date";
  pod2usage(-exitstatus=>$err_inv_date, -verbose=>0);
}

# Check if environment variables are defined
if(!defined $ENV{APP_HOME}){
  $!=$err_inv_env;
  die error("Environment variable APP_HOME is not defined. Exiting...");
}
if(!defined $ENV{ORACLE_SID}){
  $!=$err_inv_env;
  die error("Environment variable ORACLE_SID is not defined. Exiting...");
}

$inst=$ENV{ORACLE_SID};

# Connect to the database
debug "Connecting to Database $inst...";
$dbh = DBI->connect("dbi:Oracle:$inst", $user, $pswd)
  || die error("Unable to connect to $inst: $DBI::errstr\n");
debug "Connected.\n";

# Check if source is loading
if(IsSourceLoading($source_name)==1){
  $!=$err_source_lock;
  die error("Another process is currently operating on the '$source_name' source.\n");
}

# Get SQLLDR Directory to load files from
my $SQLLDRData=GetConfigParameter('SQLLDRData')||'data';

# Get SQLLDR Archive Directory to move loaded files to
my $SQLLDRArchive=GetConfigParameter('SQLLDRArchive')||'archive';

# Get SQLLDR Log Directory to move loaded files to
my $SQLLDRLog=GetConfigParameter('SQLLDRLog')||'log';

# Get SQLLDR Control file Directory to move loaded files to
my $SQLLDRControl=GetConfigParameter('SQLLDRControl')||'tmp';

# Get Maximum wait time in minutes for a file
my $SQLLDRMaxWaitTime=GetConfigParameterInt('SQLLDRMaxWaitTime')||5;
my $end_time=$start_time+($SQLLDRMaxWaitTime*60);

# Get Maximum SQLLDR errors
my $SQLLDRMaxErrors=GetConfigParameterInt('SQLLDRMaxErrors')||0;


my $total_number_of_files_expected=0;

# Get all the possible source file types for the source name
my @source_file_types;
if(!$source_file_type){
  # source file type is not specified, so we process all source file types
  # for the given source
  my $row=GetSourceFileTypes($source_name);
  die error("No Source File Types for source $source_name could be retrieved.\n") if(!defined($row));
  @source_file_types=split /,/, $row;
}else{
  push @source_file_types,$source_file_type;
}
foreach $source_file_type (@source_file_types){
  info "Collecting files of Source File Type [$source_file_type] from source [$source_name]:\n";

  # Get all details for given source_file_type
  # This injects a leading carriage return
  my $row=GetSourceFileTypeDetails($source_file_type,$source_name);
  die error("No details for Source File Type $source_file_type could be retrieved.\n") if(!defined($row));
  my ($dummy,$num_data_files_req,$col_delimiter,$line_delimiter,
      $skip_lines_to_header,$data_descriptor,$date_format,$string_encloser)=split(/\|/, $row);
  # Add to the total number of files that are to be expected
  $total_number_of_files_expected+=$num_data_files_req;

  # Make up globbing spec in the format
  # description.source.asof.date.gen.date.basis.serial_no.file_id.version_no.dat
  my $data_file_glob_spec=((defined $file_name)?$file_name:"$data_descriptor.$source_file_type.asof.$jap_as_of_date.gen.*.$data_basis.*.$version.dat");
  my $data_file_glob_path="$ENV{APP_HOME}/$SQLLDRData/$data_file_glob_spec";
  info "Globbing for $data_file_glob_path\n";

  # Get all the files
  if(defined($ad_hoc)){
    # Take all that we see
    @data_file_glob = ( @data_file_glob, Glob($data_file_glob_path) );
  }else{
    # Automated mode
    info "Polling for files until time expires\n";
    my $num_data_files_so_far=0;
    while($num_data_files_so_far<$num_data_files_req){
      # Look up files and add to global list
      my @data_file_glob_ = Glob($data_file_glob_path);
      $num_data_files_so_far=scalar @data_file_glob_;

      if($num_data_files_so_far<$num_data_files_req){
        if(time()>$end_time){
          # Timed out
          $!=$err_wait_files;

          # Determine which files could not be found - but only if we use sequence numbers
          my @missing_files;
          $data_file_glob[0]=~/$data_descriptor\.$source_file_type\.asof\.$jap_as_of_date\.gen\..*\.$data_basis\.([0-9][0-9][0-9])\.$version\.dat$/;
          my $sequence_number_in_file=(int($1)!=0);
          if($sequence_number_in_file){
            # We are using sequence numbers
            for(my $seq_no=1; $seq_no<=$num_data_files_req; $seq_no++){
              my $found=0;
              foreach (sort {$a<=>$b} @data_file_glob){
                /$data_descriptor\.$source_file_type\.asof\.$jap_as_of_date\.gen\..*\.$data_basis\.([0-9][0-9][0-9])\.$version\.dat$/;
                if(int($seq_no)==$1){
                  $found=1;
                  last;
                }
              }
              if(!$found){
                # Pad out $seq_no
                $seq_no=~s/^([0-9])$/00$1/;
                $seq_no=~s/^([0-9][0-9])$/0$1/;
                push @missing_files, "$data_descriptor.$source_file_type.asof.$jap_as_of_date.gen.*.$data_basis.$seq_no.$version.dat";
              }
            }
          }else{
            # Not using numbers in sequence number, so cannot determine which files are missing
            push @missing_files, $data_file_glob_spec;
          }
          my $error_message ="Found only ".scalar @data_file_glob." file(s) out of a total of $num_data_files_req files.\n";
          $error_message   .="Missing a total of ".scalar @missing_files. " file(s)." if($sequence_number_in_file);
          debug "$error_message\n";
          debug "Found:".join("\n",@data_file_glob)."\n";
          debug "Missing:".join("\n",@missing_files)."\n" if($sequence_number_in_file);
          NotifyAdmin($error_message,$source_name,$source_file_type,$jap_as_of_date,$data_basis) if($notify);
          NotifyRemedy($err_wait_files,$error_message,$source_name,$source_file_type,$jap_as_of_date,$data_basis) if($notify);
          die error(" * Wait time of $SQLLDRMaxWaitTime minutes exceeded.\n");
        }
        # Not all the files are there. Sleep a little
        info <<EOF;
* Not all of the required $num_data_files_req files matching the pattern
* "$data_file_glob_spec"
* in directory "$ENV{APP_HOME}/$SQLLDRData" have yet been found.
* Waiting...
EOF
        sleep(60);
      }else{
        # Have complete set for this source file type
        @data_file_glob = ( @data_file_glob,@data_file_glob_);
        debug("Files for source file type $source_file_type:\n",join("\n  ",@data_file_glob_),"\n");
        last;
      }
    }
  }
}

# Evaluate our file collection
if(scalar @data_file_glob==0){
  info("No files were found for source name [$source_name].\n");
}

# Collected all the possible files that we could get
if($ad_hoc){
  # For ad hoc, we cannot determine how many files we may require
  if(scalar @data_file_glob==0){
    $!=$err_no_files;
    die error("No ad-hoc files were found for source name [$source_name].\n");
  }
}else{
  if($total_number_of_files_expected > scalar @data_file_glob){
    debug("Total files found for source name [$source_name]:\n",join("\n  ",@data_file_glob),"\n");
    $!=$err_wait_files;
    die error("Not all the required files for source name [$source_name] load were found.\n",
           ($total_number_of_files_expected-scalar(@data_file_glob))," are missing\n");
  }
}
debug("Total files found for source name [$source_name]:\n",join("\n  ",@data_file_glob),"\n");

# Register the start of a loading run
# This also sets the load run state to WAI(TING)
PurgeStagingArea($source_name);
$load_run_id=CreateLoadRun($source_name,$data_basis,$jap_as_of_date); # Set the state of the load run in the database

foreach $source_file_type (@source_file_types){
  info "Processing files of Source File Type [$source_file_type] from source [$source_name]:\n";

  # Get all details for given source_file_type
  # This injects a leading carriage return
  my $row=GetSourceFileTypeDetails($source_file_type,$source_name);
  if(!defined($row)){
    my $error_message="No details for Source File Type $source_file_type could be retrieved";
    LogError($err_source_file_type,$error_message,$load_run_id);
    die error($error_message."\n")
  }
  my ($dummy, $num_data_files_req,$col_delimiter,$line_delimiter,
      $skip_lines_to_header,$data_descriptor,$date_format,$string_encloser)=split(/\|/, $row);

  # Process each file in the glob
  my @tup_files;
  my $index=0;
  my $num_data_files_so_far=0;

  foreach my $data_file_name (@data_file_glob){

    # Extract source file type and see if it matches:
    my $basename=basename($data_file_name);
    #$basename=~/^[a-z]+\.([a-z0-9]+)\./;
    #if($1 eq $source_file_type){
      $index++;
      info "   [$index]: $data_file_name\n";
      $num_data_files_so_far++;
      # Process the file: Read the file and convert it to tuples
      my $tup_file_name=Feed2Tuple($data_file_name, $skip_lines_to_header, $col_delimiter, $line_delimiter, $string_encloser);
      if(!defined($tup_file_name)){
        $!=$err_source_lock;
        my $error_message="Could not convert $data_file_name to a name-value tuple file.";
        LogError($err_source_lock,$error_message,$load_run_id);
        die error($error_message,"\n");
      }

      # Make up file names
      # Do in long way to deal with files names with no extension

      my $base_name = $data_file_name;
      $base_name=~s/(.+)\..*$/$1/;
      $base_name=~s/.*\///;
      my $bad_file_name       ="$ENV{APP_HOME}/$SQLLDRData/$base_name.bad";
      my $disc_file_name      ="$ENV{APP_HOME}/$SQLLDRData/$base_name.dsc";
      my $log_file_name       ="$ENV{APP_HOME}/$SQLLDRLog/$base_name.log";
      my $control_file_name   ="$ENV{APP_HOME}/$SQLLDRControl/$base_name.ctl";

      unlink $bad_file_name;
      unlink $disc_file_name;
      unlink $control_file_name;
      unlink $log_file_name;

      # Exract file Id or Make it up
      if($ad_hoc){
        # If ad-hoc, then we should not assume that the sequence number (a.k.a file Id)
        # is parseable from the name.
        # We try once, and if it fails we start at 001 and increment each time
        if(!$file_id){
          # Extract file_id or default to 001
          $base_name=~/\.(.+)\..+$/;
          $file_id=$2||'001';
          debug "Extracted file Id [$file_id]\n";
        }else{
          # Increment file_id & pad
          $file_id+=1;
          $file_id=~s/^[0-9]$/00$&/;
          $file_id=~s/^[0-9]{2}$/0$&/;
          debug "Calculated file Id [$file_id]\n";
        }
      }else{
        # Automated mode: Extract file_id or default to 001
        $base_name=~/.+\.(.+)\..+$/;
        $file_id=$1||'001';
        debug "Extracted file Id [$file_id]\n";
      }

      # Attempt to extract generated date from filename
      my $gen_date=GetFileGenerationDate($data_file_name);

      # Make up SQLLDR control file
      open (C,"+> $control_file_name") || die error("Could not create the control file $control_file_name\n");
      print C <<EOF;
-- Control file to load data into table vcr.source_staging_area
load data
append
into table vcr.source_staging_area
(
  source_file_type  constant "$source_file_type",
  file_id           constant "$file_id",
  staging_record    position(1) char(4000)
)
EOF
      close(C);

      # Execute SQLLDR
      my $cmd=qq{sqlldr USERID=$user/$pswd\@$inst LOG=$log_file_name DATA=$tup_file_name BAD=$bad_file_name DISCARD=$disc_file_name ERRORS=$SQLLDRMaxErrors CONTROL=$control_file_name DIRECT=TRUE > /dev/null};
      #my $cmd=qq{sqlldr USERID=$user/$pswd\@$inst LOG=$log_file_name DATA=$tup_file_name BAD=$bad_file_name DISCARD=$disc_file_name ERRORS=$SQLLDRMaxErrors CONTROL=$control_file_name > /dev/null};
      #my $cmd=qq{sqlldr USERID=$user/$pswd\@$inst DATA=$tup_file_name CONTROL=$control_file_name};
      debug "$cmd\n";
      my $retcode=system($cmd);
      if($retcode!=0){
        $!=$err_oracle_proc;
        my $error_message="SQLLDR Error [$retcode] loading $tup_file_name.";
        LogError($err_source_lock,$error_message,$load_run_id);
        die error($error_message,"\n");
      }

      # Register the loading of each file load with the VCR only at the end of this successful operation
      # This set the state to ERR if the data was flawed and rolls the data back in the staging area
      AddFile($load_run_id, $source_file_type, $file_id, $base_name.".dat","$ENV{APP_HOME}/$SQLLDRData", $gen_date);
      $file_count++;  # Update statistics

      # The file has been loaded to Oracle - move data file for archive and delete temp files
      # All log files are deleted by an external process when they have reached a certain age.
      # All archive files are deleted when they are backed up to tape.
      info "Moving $data_file_name to $ENV{APP_HOME}/$SQLLDRArchive\n";
      `mv $data_file_name $ENV{APP_HOME}/$SQLLDRArchive/.`;
      unlink $tup_file_name if ! $debug;
      unlink $control_file_name;
    #}
  }
}

END:{
# Disconnect
  if(defined $dbh){
    debug "Disconnecting...";
    $dbh->disconnect() || die error("Failed to disconnect from $inst. ".$dbh->errstr()."\n");
    debug "Done.\n";
  }
  my $proc_time=time()-$start_time;
  debug "Loaded $file_count file(s) in the staging area in $proc_time seconds.\n";
  exit($err_success);
}


__END__

=head1 NAME

Feed2Oracle - Creates a data feed file and loads it into an Oracle staging table

For a given source file Id and file basis (e.g. 'bob' and 'tplus1') and an as-of-date,
(in the format YYYYMMDD) a preset number of files are polled for in the
C<$APP_HOME/data> data directory. Each data file is processed on a one-by-one basis
as soon as the file is seen in the data directotry. This scripts waits for a
predefined time until all the required files have arrived.

Files that have not arrived after the wait time has expired cause the script
to exit with an error. The script will need to be manually called later again,
in the hope that the remaining files have arrived, ad nauseum.

Files are moved from the C<$APP_HOME/data> data directory to the
C<$APP_HOME/archive> archive directory after they have been successfully
loaded into the Oracle database.

This script connects to the Oracle database as set in the current $ORACLE_SID
environment variable as and OPS$-user (i.e. if you are running as shell user
VCR it will connect as Oracle user OPS$VCR). All packages that this script calls
need to grant execution rights to the relevant Oracle user.

All file type details are stored in the VCR database. Refer to the VCR
documentation for more information about configuring file types, source types
and file basis.

=head1 MODES OF OPERATION

The script runs in one of two modes:

=head2 Automatic Mode

This is the default operation. The script polls for a set of files that match the given
input parameters. Further details of the file name are retrieved from the database,
including the number of files that are expected.

Only once all the files have been found is the loading process is registered on the databass.
The staging area is cleared and the files are loaded and archived one by one and the script exits.

The file name convention that the script polls files for is:

=over 4

    description.vsp.asof.yyyymmdd.gen.yyyymmdd.basis.sss.vvv.dat

where:

=item B<description>

Business-based descriptive name of the data content, e.g. dailypnl

=item B<vsp>

A 3-letter unique source Id that the file originates from.

=item B<asof.yyyymmdd>

The 'as of' date (closing date or period end date) that
the valuations are for.

=item B<gen.yyyymmdd>

The date that the file was generated. This date is normally
later than the 'as of' date.

=item B<basis>

The basis on which the file was created. Examples: 'tplus1 if the
file is one delivered to MI as soon as possible after the as-of date (usually
two days after the as of date - trade date plus one extract day to reconcile
the account) or tclean if this file is delivered at the end of month as a final
version for an official end of month valuation. Other possible values, but not
limited to, are daily, hourly, monthly, annually.

=item B<sss>

A zero-padded three digit sequence number allocated to each individual file
in the set of files sent for a VSP, as-of date and basis. The numbers start
at 001 and a set of files is contiguously numbered. The intention is that
the sequence number provides a unique file name, and allows operational staff
to determine which file in a set is missing.

Is is possible to specify something other than a string a digits.

=item B<vvv>

A three digit version number. If multiple versions of a file
have to be produced to resolve exceptions then this number will reflect that
version. For the first file or set of files sent for a given VSP, as-of date
and basis, this would be 001.

This value must be 001 for the default operation of this script. If it is anything else,
then the script will perform an ad-hoc file load (see L<Ad-hoc Mode|Ad-hoc Mode> below).

=back

Only once the required number of files have been found,
the loading process is registered, the staging area is cleared
and the files are loaded and archived one by one.

The script polls for the required set of files for a predefined period only.
This period is configured in the utl.config table on the VCR database.
If this process times out because the required number of files are not
present on the input directory, this scripts exits with an error.

Note:
The script does not start processing files until the full set of required
files for the data load has presented itself.


=head2 Ad-hoc Mode

The script runs in the ad-hoc file load mode when either the B<-f> file name
or the B<-v> version number greater than 001 has been specified on the
command line.

When the file name is specified, any file name is acceptable.
When the version number is specified, the standard file naming convention is assumed.
Note that the mandatory parameters still need to be specified, as they provide data context.

The usual number of files that are required for automatic operation are
ignored and only the files that are present in the C<$APP_HOME/data>
directory that match the file criteria at the time that the script is run are
loaded into the database. Also, unlike the automatic operation, the script
does not wait for the arrival of any files. If no files have been processed,
the script exits with an exit code.

If one or more files are found, the loading process is registered on the
database, the staging area is cleared, the files are loaded and archived one
by one onto the target database.

There is no restriction on the maximum number of files duing an ad-hoc load.
However, if no files are found at all, the script exits with an error code.

=head2 Error recovery

Should this scipt fail for any reason, it will terminate immediately with an
exit code (See L<Error Codes|ERROR CODES> below).

=head1 SYNOPSIS

=over 4

=item C<B<Feed2Oracle> B<-s> bob B<-a> 20040817 B<-b> tplus1>

Most common format. Loads all files similarly named to this:

    dailypnl.bob.asof.20040817.gen.20040820.tplus1.001.001.dat
    dailypnl.bob.asof.20040817.gen.20040820.tplus1.002.001.dat
    dailypnl.bob.asof.20040817.gen.20040820.tplus1.003.001.dat
    etc., until the required set is done or timed out.

=item C<B<Feed2Oracle> B<-s> bob B<-a> 20040817 B<-b> tplus1 B<-v> 002>

Ad-hoc load of files with specified version number:

    dailypnl.bob.asof.20040817.gen.20040820.tplus1.001.002.dat
    dailypnl.bob.asof.20040817.gen.20040820.tplus1.002.002.dat
    dailypnl.bob.asof.20040817.gen.20040820.tplus1.003.002.dat
    etc., until no further files are left.

=item C<B<Feed2Oracle> B<-s> bob B<-a> 20040817 B<-b> tplus1 B<-f> emergencyfix.dat>

Ad-hoc load of single file C<emergencyfix.dat> for the specified criteria.

=item C<B<Feed2Oracle> B<-s> gfs B<-a> 20040817 B<-b> tplus1 B<-f> a*.dat B<-sf> gfsmgs>

Ad-hoc load of all the files that match the file criteria C<a*.dat> that
should be mapped to the source provider 'gfs' and the has a source file type
known on the target database as 'gfsmgs'

=item C<B<Feed2Oracle> B<--help>>

Display this text.

=item C<B<Feed2Oracle> B<--man>>

Detailed description in 'man' page format.

=back

=head1 OPTIONS

B<Feed2Oracle> [B<-p> db_passwd] B<-s> source_name B<-a> as_of_date B<-b> data_basis

  or

B<Feed2Oracle> [B<-p> db_passwd] B<-s> source_name B<-a> as_of_date B<-b> data_basis B<-v> version

  or

B<Feed2Oracle> [B<-p> db_passwd] B<-s> source_name B<-a> as_of_date B<-b> data_basis B<-f> file_name B<-sf> source_file_type


=head2 Mandatory

=over 4

=item B<-s|--source_file_name Source File Name>

The Source Name as defined in the table vcr.source

=item B<-a|--as_of_date File's As of Date>

Japanese format YYYYMMDD of the As Of Date in the file name

=item B<-b|--data_basis Feed file Data Basis>

Feed file's Basis of the data, e.g. tplus, tclean, daily, monthly, etc..

=back

=head2 Optional

=over 4

=item B<-v|--version Version Number, format [0-9][0-9][0-9] with leading 0's>

The version number of the file. If not specified, it defaults to '001'.

When a version is specified, the script assumes that this is an
ad-hoc file load (see L<Ad-hoc Mode|Ad-hoc Mode> above).


=item B<-f|--file_name File name>

Exact file criteria to load. Use this option when doing an ad-hoc file load
(see L<Ad-hoc Mode|Ad-hoc Mode> above).

=item B<-sf|--source_file_type Source File Type>

This option needs to be specified when an explicit file name (-f) is specified
that does not comply to the agreed file convention, which means that pertinent
details about the data cannot be extracted from the name.
It specifies the type of file organisation that is to be expected against
the given source name.

=item B<-?|--help>

Displays simple help

=item B<-m|--man>

Displays this in a man-page format.

=item B<--verbose>

Prints running details to STDOUT in green.

=item B<-n|--notify>

Sends notification messages to the Remedy email system. This disabled by default.

=item B<-d|--debug>

Prints very verbose running details to STDOUT in yellow.

=item B<-r|--release>

Prints the source control header to STDOUT.

=back

=head1 SYSTEM CONFIGURATION

=over 4

The following global parameters are defined in the VCR database's configuration
table, utl.config.

=item B<SQLLDRData>

Relative Directory off $APP_HOME that SQLLDR will load files from. Default: data. No leading or trailing slashes!

=item B<SQLLDRArchive>

Relative Directory off $APP_HOME that processed files will be moved to after loading. Default: archive

=item B<SQLLDRLog>

Relative directory off $APP_HOME that log files are written to. Default: log

=item B<SQLLDRControl>

Relative directory off $APP_HOME that control files are written to. Default: tmp

=item B<SQLLDRMaxErrors>

Maximum number of faulty records tolerated by SQLLDR. Default: 0

=item B<SQLLDRMaxWaitTime>

Maximum wait time in MINUTES for a complete set of files to be processed; Default: 5 minutes

=back

=head1 ERROR CODES

=over 4

This script returns the following error codes:

B<0> Successful execution.

B<208> Source file type attributed could not be retrieved

For the given source file type, no attributes where defined in the
meta data in the database.

B<209> The script timed out waiting for files.

Feed2Oracle waits for a configurable number of minutes for all the
required data files to arrive before starting the file loading operation.
At least one file failed to arrive.

B<210> An invalid date was encountered

The format of dates in the data files are configured for
each source file tyle. An unexpected date format was encountered.


B<220> No files were processed.

A specific file name or a specific file version (other than 001) was
specified as a parameter. Feed2Oracle failed to find any file that
matches this criteria.

B<221> An object that the script needs to operate on is locked by another process

Another process is currently operating on the data source. It could be that
a previous attempt failed halfway through, in which case a manual intervention
is required to remove the lock.

B<222> An invalid parameter or combination of parameters was supplied to the script

Refer to this man page for parameters for Feed2Oracle.

B<223> Error in the runtime environment

Crucial environment variables such as APP_HOME or ORACLE_SID are not defined.

B<224> Error in the data format of the object that the script operates on

No columns found in the file header of the given data file. Check if the column
delimiter or the preamble length correctly specified?

B<225> A subprocess that the script calls caused an error

Feed2Oracle calls a number of Oracle processes and one of these processes
caused an error. These processes generate their own errors, so you should
be able to determine the cause of this error by looking at the preceeding
errors in the log.

=back

You may now safely destroy your computer and dispose of it in an environmentally-friendly way.

=cut
