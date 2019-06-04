------------------------------------------------------------------------------
-- $Header: vcr/data/source_file_type.sql 1.15 2005/10/18 11:57:37BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.source_file_type.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @source_file_type.sql
-- This file was generated from database instance VCRD1.
--   Database Time    : 03AUG2005 16:07:06
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.source_file_type.

delete from vcr.source_staging_area;
-- empty the table:
delete from vcr.source_file_type;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'bob',4,
      'bobvcr',3,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'gfsmgs',1,
      'gfsolap',1,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'gfsch',11,
      'gfsch',2,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'ifs',2,
      'ifsvcr',18,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'ss',5,
      'sshy',1,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'ssc',6,
      'sscvcr',9,NULL
      );

insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'tyk',3,
      'tykvcr',5,NULL
      );
insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'bns',7,
      'bnshy',1,NULL
      ); 
insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'tranaut',9,
      'tranautvcr',1,NULL
      ); 
insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'citco',10,
      'citcopnl',1,NULL
      ); 
insert into vcr.source_file_type
      (SOURCE_FILE_TYPE,SOURCE_ID,FILE_TYPE,NO_OF_FILES,CHANGE_REASON)
values(
      'sscmonth',8,
      'sscvcr',1,NULL
      );	
	      	  
commit;

set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

