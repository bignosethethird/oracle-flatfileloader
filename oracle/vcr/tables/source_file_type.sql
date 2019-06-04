------------------------------------------------------------------------------
-- $Header: vcr/tables/source_file_type.sql 1.8 2005/08/23 12:25:44BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_FILE_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:40
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_file_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_FILE_TYPE

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
     and object_name = upper('SOURCE_FILE_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_FILE_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_FILE_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_FILE_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_FILE_TYPE
(
  SOURCE_FILE_TYPE                VARCHAR2  (30) not null
, SOURCE_ID                       NUMBER    
, FILE_TYPE                       VARCHAR2  (30)
, NO_OF_FILES                     NUMBER     default NULL  not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_FILE_TYPE is
  'defines the different types of files a source provides';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_FILE_TYPE.SOURCE_FILE_TYPE is
  'unique id of source/file type relationship - part of the file naming convention';
comment on column VCR.SOURCE_FILE_TYPE.SOURCE_ID is
  'related source';
comment on column VCR.SOURCE_FILE_TYPE.FILE_TYPE is
  'related file type';
comment on column VCR.SOURCE_FILE_TYPE.NO_OF_FILES is
  'number of tplus1 files of this type and source exected daily';
comment on column VCR.SOURCE_FILE_TYPE.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FILE_TYPE
  add constraint PK_SOURCE_FILE_TYPE
  primary key (SOURCE_FILE_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FILE_TYPE
  add constraint FK_SOURCE_FILE_TYPE_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FILE_TYPE
  add constraint UK_SOURCE_FILE_TYPE
  unique (SOURCE_ID,FILE_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

