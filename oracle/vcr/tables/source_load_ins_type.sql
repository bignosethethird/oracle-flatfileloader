------------------------------------------------------------------------------
-- $Header: vcr/tables/source_load_ins_type.sql 1.5 2005/08/23 12:25:53BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_LOAD_INS_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:44
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_load_ins_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_LOAD_INS_TYPE

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
     and object_name = upper('SOURCE_LOAD_INS_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_LOAD_INS_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_LOAD_INS_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_LOAD_INS_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_LOAD_INS_TYPE
(
  LOAD_RUN_ID                     NUMBER    (22) not null
, INSTRUMENT_TYPE                 VARCHAR2  (2000) not null
, NO_OF_MAND_FIELDS_MISSING       NUMBER    (22) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_LOAD_INS_TYPE is
  'Records the number of mandatory field check failures by load run and instrument type.';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_LOAD_INS_TYPE.LOAD_RUN_ID is
  'unique id of run the file was loaded for';
comment on column VCR.SOURCE_LOAD_INS_TYPE.INSTRUMENT_TYPE is
  'an instrument type';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_INS_TYPE
  add constraint PK_SOURCE_LOAD_INS_TYPE
  primary key (LOAD_RUN_ID,INSTRUMENT_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_INS_TYPE
  add constraint FK_INS_TYPE_SOURCE_LOAD_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

