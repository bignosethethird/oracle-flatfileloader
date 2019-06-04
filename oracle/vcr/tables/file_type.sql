------------------------------------------------------------------------------
-- $Header: vcr/tables/file_type.sql 1.7.1.6 2005/08/23 12:25:35BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.FILE_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:17
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @file_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.FILE_TYPE

-- Drop table if it already exists
-- Note that the contents of the table will also be deleted
--  and that referential constraints will also be dropped.
-- You will be warned when this happens.
declare 
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'TABLE'
     and owner = upper('VCR')
     and object_name = upper('FILE_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.FILE_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.FILE_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.FILE_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.FILE_TYPE
(
  FILE_TYPE                       VARCHAR2  (30) not null
, TABLE_NAME                      VARCHAR2  (100) not null
, DELIMITER                       VARCHAR2  (12) not null
, IGNORE_RECORDS                  NUMBER    (22) not null
, ACCOUNTING_PERIOD_FIELD         VARCHAR2  (100)
, DESCRIPTION                     VARCHAR2  (100) not null
, DOCUMENT_NAME                   VARCHAR2  (100) not null
, DATE_FORMAT                     VARCHAR2  (100) default 'MM/DD/YYYY'   not null
, END_OF_LINE                     VARCHAR2  (10)
, STRING_ENCLOSER                 VARCHAR2  (20) default 'SINGLEQUOTES'

, CHECK_TYPE                      CHAR      (1) default 'N'  not null
, PRESERVE_UNMAPPED               CHAR      (1) default 'Y'  not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.FILE_TYPE is
  'a file format with associated mappings';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.FILE_TYPE.FILE_TYPE is
  'Unique mnemonic';
comment on column VCR.FILE_TYPE.TABLE_NAME is
  'table data from this type fo file is loaded to';
comment on column VCR.FILE_TYPE.DELIMITER is
  'Column delimiting character. This can be one of the following values TAB, SPACE, PIPE, COMMA, PERIOD, DOUBLESPACE';
comment on column VCR.FILE_TYPE.IGNORE_RECORDS is
  'Number of rows in source file to ignore before first header record starts. Default 0.';
comment on column VCR.FILE_TYPE.ACCOUNTING_PERIOD_FIELD is
  'Defines the field that contains the accounting period. If not populated the data is not by accounting period.';
comment on column VCR.FILE_TYPE.DOCUMENT_NAME is
  'the file prefix used for this file in the naming convention e.g. dailypnl';
comment on column VCR.FILE_TYPE.DATE_FORMAT is
  'The canonical format in which dates are expected to appear in this file type, ie. this would include the time spec too.';
comment on column VCR.FILE_TYPE.END_OF_LINE is
  'Record delimiting character. This can be one of the following values: LF (UNIX), CR (APPLE) or CRLF (Windows)';
comment on column VCR.FILE_TYPE.STRING_ENCLOSER is
  'String quote marks for enclosing strings  - either SINGLEQUOTES or DOUBLEQUOTES';
comment on column VCR.FILE_TYPE.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.FILE_TYPE
  add constraint PK_FILE_TYPE
  primary key (FILE_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.FILE_TYPE
  add constraint FK_FILE_TYPE_TARGET_TABLE
  foreign key (TABLE_NAME)
  references VCR.TARGET_TABLE(TABLE_NAME)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

