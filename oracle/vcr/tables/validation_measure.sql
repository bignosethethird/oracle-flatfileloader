------------------------------------------------------------------------------
-- $Header: vcr/tables/validation_measure.sql 1.6 2005/08/23 12:25:39BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.VALIDATION_MEASURE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:59
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @validation_measure.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.VALIDATION_MEASURE

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
     and object_name = upper('VALIDATION_MEASURE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.VALIDATION_MEASURE already exists. Dropping it');
    execute immediate 'drop table VCR.VALIDATION_MEASURE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.VALIDATION_MEASURE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.VALIDATION_MEASURE
(
  MEASURE_ID                      NUMBER     not null
, NAME                            VARCHAR2  (200) not null
, CALC_LEVEL                      VARCHAR2  (100)
, UNITS                           VARCHAR2  (20)
, FORMAT                          VARCHAR2  (30) default '000.9999'  not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.VALIDATION_MEASURE is
  'a measure calculated for validation purposes e.g. daily % change of p an l';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.VALIDATION_MEASURE.CALC_LEVEL is
  'level at which calculation is defined e.g. ie_id';
comment on column VCR.VALIDATION_MEASURE.UNITS is
  'e.g. days, percent';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_MEASURE
  add constraint PK_VALIDATION_MEASURE
  primary key (MEASURE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_MEASURE
  add constraint UK_VALIDATION_MEASURE
  unique (NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

