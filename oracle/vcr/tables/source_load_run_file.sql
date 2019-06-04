------------------------------------------------------------------------------
-- $Header: vcr/tables/source_load_run_file.sql 1.10 2005/08/23 12:25:43BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_LOAD_RUN_FILE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:45
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_load_run_file.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_LOAD_RUN_FILE

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
     and object_name = upper('SOURCE_LOAD_RUN_FILE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_LOAD_RUN_FILE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_LOAD_RUN_FILE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_LOAD_RUN_FILE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_LOAD_RUN_FILE
(
  LOAD_RUN_ID                     NUMBER    (22) not null
, FILE_ID                         VARCHAR2  (30) not null
, FILENAME                        VARCHAR2  (500) not null
, PATHNAME                        VARCHAR2  (500) not null
, NO_OF_RECORDS                   NUMBER    (22)
, LOAD_SQL                        CLOB      
, REPORTING_DATE                  DATE       not null
, FILE_TYPE                       VARCHAR2  (30) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_LOAD_RUN_FILE is
  'Records the file or files associated with a particular instance of the load process.';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_LOAD_RUN_FILE.LOAD_RUN_ID is
  'unique id of run the file was loaded for';
comment on column VCR.SOURCE_LOAD_RUN_FILE.FILE_ID is
  'the sequence id of the file in its filename';
comment on column VCR.SOURCE_LOAD_RUN_FILE.FILENAME is
  'the filename of the file';
comment on column VCR.SOURCE_LOAD_RUN_FILE.PATHNAME is
  'the directory the file was loaded from';
comment on column VCR.SOURCE_LOAD_RUN_FILE.NO_OF_RECORDS is
  'Redundant count of number of records loaded from file';
comment on column VCR.SOURCE_LOAD_RUN_FILE.LOAD_SQL is
  'Generated SQL for load';
comment on column VCR.SOURCE_LOAD_RUN_FILE.REPORTING_DATE is
  'date source claims file was produced as defined in the file naming convention';
comment on column VCR.SOURCE_LOAD_RUN_FILE.FILE_TYPE is
  'the type of the file';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_RUN_FILE
  add constraint PK_SOURCE_LOAD_RUN_FILE
  primary key (LOAD_RUN_ID,FILE_TYPE,FILE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_RUN_FILE
  add constraint FK_FILE_SOURCE_LOAD_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

