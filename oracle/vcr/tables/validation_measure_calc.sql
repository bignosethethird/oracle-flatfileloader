------------------------------------------------------------------------------
-- $Header: vcr/tables/validation_measure_calc.sql 1.6 2005/08/23 12:25:41BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.VALIDATION_MEASURE_CALC
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:59
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @validation_measure_calc.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.VALIDATION_MEASURE_CALC

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
     and object_name = upper('VALIDATION_MEASURE_CALC');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.VALIDATION_MEASURE_CALC already exists. Dropping it');
    execute immediate 'drop table VCR.VALIDATION_MEASURE_CALC';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.VALIDATION_MEASURE_CALC cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.VALIDATION_MEASURE_CALC
(
  MEASURE_ID                      NUMBER     not null
, DENOMINATOR                     VARCHAR2  (500)
, LEVEL_TEST                      VARCHAR2  (200)
, NUMERATOR                       VARCHAR2  (500) not null
, VIEW_LIST                       VARCHAR2  (500) not null
, JOINS                           VARCHAR2  (500)
, DESCRIPTION                     VARCHAR2  (100) not null
, ERROR_TEST                      VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.VALIDATION_MEASURE_CALC is
  'defines calculation for a measure';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.VALIDATION_MEASURE_CALC.DENOMINATOR is
  'calculation of denominator';
comment on column VCR.VALIDATION_MEASURE_CALC.LEVEL_TEST is
  'test to validate_measure.calc_level column e.g. ='MGS' or IN (1,2) or NOT IN (1,2)';
comment on column VCR.VALIDATION_MEASURE_CALC.NUMERATOR is
  'calculation of numerator';
comment on column VCR.VALIDATION_MEASURE_CALC.VIEW_LIST is
  'views and their aliases used for the calculation';
comment on column VCR.VALIDATION_MEASURE_CALC.JOINS is
  'if multiple aliases of the numerator view are used what columns are they joined on';
comment on column VCR.VALIDATION_MEASURE_CALC.DESCRIPTION is
  'description of calculation level e.g. RMF  or Equities and Bonds';
comment on column VCR.VALIDATION_MEASURE_CALC.ERROR_TEST is
  'decode statement that returns null if all columns are valid for calc or an error description';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_MEASURE_CALC
  add constraint PK_VALIDATION_MEASURE_CALC
  primary key (MEASURE_ID,DESCRIPTION)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

