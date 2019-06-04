------------------------------------------------------------------------------
-- $Header: vcr/tables/file_type_field.sql 1.9 2005/08/23 12:25:48BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.FILE_TYPE_FIELD
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:18
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @file_type_field.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.FILE_TYPE_FIELD

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
     and object_name = upper('FILE_TYPE_FIELD');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.FILE_TYPE_FIELD already exists. Dropping it');
    execute immediate 'drop table VCR.FILE_TYPE_FIELD';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.FILE_TYPE_FIELD cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.FILE_TYPE_FIELD
(
  FILE_TYPE                       VARCHAR2  (30) not null
, FIELD_NAME                      VARCHAR2  (100) not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.FILE_TYPE_FIELD is
  'A field in a particular file type.';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.FILE_TYPE_FIELD.FILE_TYPE is
  'parent file type';
comment on column VCR.FILE_TYPE_FIELD.FIELD_NAME is
  'As it appears in the source_staging_area.staging_record delimited set of name/value pairs';
comment on column VCR.FILE_TYPE_FIELD.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.FILE_TYPE_FIELD
  add constraint PK_FILE_TYPE_FIELD
  primary key (FILE_TYPE,FIELD_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

