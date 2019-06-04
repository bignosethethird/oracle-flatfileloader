------------------------------------------------------------------------------
-- $Header: vcr/tables/field_target_column.sql 1.9 2005/08/23 12:25:46BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.FIELD_TARGET_COLUMN
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:16
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @field_target_column.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.FIELD_TARGET_COLUMN

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
     and object_name = upper('FIELD_TARGET_COLUMN');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.FIELD_TARGET_COLUMN already exists. Dropping it');
    execute immediate 'drop table VCR.FIELD_TARGET_COLUMN';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.FIELD_TARGET_COLUMN cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.FIELD_TARGET_COLUMN
(
  FILE_TYPE                       VARCHAR2  (30) not null
, FIELD_NAME                      VARCHAR2  (100) not null
, TABLE_NAME                      VARCHAR2  (100) not null
, COLUMN_NAME                     VARCHAR2  (100) not null
, ACCOUNTING_PERIOD               VARCHAR2  (2000)
, IN_UNIQUE_KEY                   CHAR      (1) default 'N' 
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.FIELD_TARGET_COLUMN is
  'A field in a particular file type and its corresponding column on the target table';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.FIELD_TARGET_COLUMN.FILE_TYPE is
  'Unique id of the file type ';
comment on column VCR.FIELD_TARGET_COLUMN.FIELD_NAME is
  'name of the field as it appears in source_staging_area.staging_record that this mapping is for';
comment on column VCR.FIELD_TARGET_COLUMN.TABLE_NAME is
  'table data will be written to';
comment on column VCR.FIELD_TARGET_COLUMN.COLUMN_NAME is
  'column that field contents should be written to on table';
comment on column VCR.FIELD_TARGET_COLUMN.ACCOUNTING_PERIOD is
  'If the file is defined to be accounting period this defines which accounting period this mapping is for';
comment on column VCR.FIELD_TARGET_COLUMN.IN_UNIQUE_KEY is
  'Defaults to N - defines whether the corresponding column for this field should be added to the unique key of the position';
comment on column VCR.FIELD_TARGET_COLUMN.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate check constraints
------------------------------------------------------------------------------
alter table VCR.FIELD_TARGET_COLUMN
  add constraint CHECK_FIELD_IN_UNIQUE_KEY
  check ()
  ENABLED;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.FIELD_TARGET_COLUMN
  add constraint PK_FIELD_TARGET_COLUMN
  primary key (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.FIELD_TARGET_COLUMN
  add constraint FK_FTC_FILE_TYPE_FIELD
  foreign key (FILE_TYPE,FIELD_NAME)
  references VCR.FILE_TYPE_FIELD(FILE_TYPE,FIELD_NAME)
;
alter table VCR.FIELD_TARGET_COLUMN
  add constraint FK_FTC_TARGET_COLUMN
  foreign key (TABLE_NAME,COLUMN_NAME)
  references VCR.TARGET_COLUMN(TABLE_NAME,COLUMN_NAME)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

