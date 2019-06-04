------------------------------------------------------------------------------
-- $Header: vcr/tables/source_load_run.sql 1.5.1.2.1.5 2005/08/23 12:25:47BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_LOAD_RUN
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:45
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_load_run.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_LOAD_RUN

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
     and object_name = upper('SOURCE_LOAD_RUN');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_LOAD_RUN already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_LOAD_RUN';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_LOAD_RUN cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_LOAD_RUN
(
  LOAD_RUN_ID                     NUMBER     not null
, LOAD_RUN_NO                     NUMBER     not null
, SOURCE_ID                       NUMBER     not null
, AS_OF_DATE                      DATE       not null
, BASIS                           VARCHAR2  (30) not null
, START_TIME                      DATE       not null
, END_TIME                        DATE      
, STATUS                          CHAR      (3) not null
, VSP_ERR_LOG_SENT_BY             VARCHAR2  (30)
, VSP_ERR_LOG_SENT_ON             DATE      
, CHECK_FIELDS_SQL                CLOB      
, NO_OF_EXCEPTIONS                NUMBER    (22)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_LOAD_RUN is
  'An instance of the load process for a source, as of date and basis.';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_LOAD_RUN.LOAD_RUN_ID is
  'unique numeric pk';
comment on column VCR.SOURCE_LOAD_RUN.LOAD_RUN_NO is
  'Redundant unique sequence within as of date, source and basis';
comment on column VCR.SOURCE_LOAD_RUN.SOURCE_ID is
  'source run is for';
comment on column VCR.SOURCE_LOAD_RUN.AS_OF_DATE is
  'as of date run is for';
comment on column VCR.SOURCE_LOAD_RUN.BASIS is
  'basis run is for';
comment on column VCR.SOURCE_LOAD_RUN.START_TIME is
  'when we started waiting for the file for this run';
comment on column VCR.SOURCE_LOAD_RUN.END_TIME is
  'when we published the data for this run';
comment on column VCR.SOURCE_LOAD_RUN.STATUS is
  'status is either complete, waiting, in progress or error';
comment on column VCR.SOURCE_LOAD_RUN.VSP_ERR_LOG_SENT_BY is
  'who sent the vsp error log for this run';
comment on column VCR.SOURCE_LOAD_RUN.VSP_ERR_LOG_SENT_ON is
  'when was the vsp error log sent for this run';
comment on column VCR.SOURCE_LOAD_RUN.CHECK_FIELDS_SQL is
  'the sql used to check the data for mandatory field population';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_RUN
  add constraint PK_SOURCE_LOAD_RUN
  primary key (LOAD_RUN_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_RUN
  add constraint FK_SOURCE_LOAD_RUN_BASIS
  foreign key (BASIS)
  references VCR.SOURCE_BASIS(BASIS)
;
alter table VCR.SOURCE_LOAD_RUN
  add constraint FK_SOURCE_LOAD_RUN_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_LOAD_RUN
  add constraint UK_SOURCE_LOAD_RUN
  unique (AS_OF_DATE,BASIS,SOURCE_ID,LOAD_RUN_NO)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

