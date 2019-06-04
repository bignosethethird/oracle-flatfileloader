------------------------------------------------------------------------------
-- $Header: vcr/data/file_type.sql 1.6.1.8 2005/10/07 15:59:57BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.file_type.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @file_type.sql
-- This file was generated from database instance VCRD1.
--   Database Time    : 03AUG2005 15:39:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.file_type.


alter table vcr.file_type_field disable constraint fk_field_file_type;
alter table vcr.source_file_type disable constraint fk_source_file_type_ft;
alter table vcr.source_load_run_file disable constraint fk_file_file_type;

-- empty the table:
delete from vcr.file_type;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('gfsolap','source_position','PIPE',0,'ACCOUNTINGPERIOD','GlobeOp Legacy PNL Format','dailypnl','MM/DD/RRRR','LF','SINGLEQUOTES','N','N');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('ifsvcr','source_position','COMMA',0,NULL,'IFS VCR Format','dailypnl','YYYYMMDD','LF','DOUBLEQUOTES','Y','Y');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('tykvcr','source_position','PIPE',0,NULL,'Tykhe VCR Format','dailypnl','YYYYMMDD','LF','SINGLEQUOTES','Y','Y');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('bobvcr','source_position','PIPE',0,NULL,'Bank of Bermuda VCR Format','dailypnl','MM/DD/RRRR','LF','SINGLEQUOTES','Y','Y');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('sscvcr','source_position','PIPE',0,NULL,'SS'||chr(38)||'C VCR Format','dailypnl','MM/DD/RRRR','LF','SINGLEQUOTES','Y','Y');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('sshy','source_position','COMMA',7,NULL,'Statestreet Highyield File Format','dailypnl','MM/DD/RRRR','LF','DOUBLEQUOTES','Y','Y');
insert into vcr.file_type
      (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED,CHANGE_REASON)
values(
      'gfsch',
      'source_position',
      'PIPE',5,NULL,
      'GlobeOp Format for CH risk managed content engines',
      'dailypnl',
      'MM/DD/RRRR',
      'LF',
      'SINGLEQUOTES',
      'Y',
      'Y',NULL
      );
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('tranautvcr','source_position','PIPE',0,NULL,'Tranaut VCR Format','dailypnl','MM/DD/RRRR','LF','SINGLEQUOTES','Y','Y');
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('citcopnl','source_position','COMMA',0,NULL,'CITCO P'||chr(38)||'L Extract Format','dailypnl','YYYYMMDD','LF','SINGLEQUOTES','Y','N');  
insert into vcr.file_type
  (FILE_TYPE,TABLE_NAME,DELIMITER,IGNORE_RECORDS,ACCOUNTING_PERIOD_FIELD,DESCRIPTION,DOCUMENT_NAME,DATE_FORMAT,END_OF_LINE,STRING_ENCLOSER,CHECK_TYPE,PRESERVE_UNMAPPED)
  values
  ('bnshy','source_position','COMMA',0,NULL,'Bank of Nova Scotia Highyield File Format','weeklypnl','Mon-DD-YYYY','LF','DOUBLEQUOTES','Y','Y');

commit;

alter table vcr.file_type_field enable constraint fk_field_file_type;
alter table vcr.source_file_type enable constraint fk_source_file_type_ft;
alter table vcr.source_load_run_file enable constraint fk_file_file_type;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

