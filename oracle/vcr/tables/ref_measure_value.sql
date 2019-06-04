------------------------------------------------------------------------------
-- $Header: vcr/tables/ref_measure_value.sql 1.3.1.6 2005/08/23 12:25:45BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.REF_MEASURE_VALUE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:31
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ref_measure_value.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.REF_MEASURE_VALUE

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
     and object_name = upper('REF_MEASURE_VALUE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.REF_MEASURE_VALUE already exists. Dropping it');
    execute immediate 'drop table VCR.REF_MEASURE_VALUE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.REF_MEASURE_VALUE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.REF_MEASURE_VALUE
(
  AS_OF_DATE                      DATE       not null
, REF_OBJECT_ID                   NUMBER    (22) not null
, MEASURE                         VARCHAR2  (100) not null
, VALUE                           NUMBER     not null
, UPDATED_DATE_TIME               DATE       not null
, UNIT                            VARCHAR2  (30) not null
, KNOWLEDGE_DATE                  DATE       not null
, ACTUAL_AS_OF_DATE               DATE       not null
, VALUE_TYPE                      CHAR      (1) default 'S'  not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.REF_MEASURE_VALUE is
  'A value from a reference source for a reference object e.g. a fund RoR';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.REF_MEASURE_VALUE.AS_OF_DATE is
  'validation as of date that this measure will be used for';
comment on column VCR.REF_MEASURE_VALUE.REF_OBJECT_ID is
  'reference object that measure is for ';
comment on column VCR.REF_MEASURE_VALUE.MEASURE is
  'type of measure e.g. NOTIONAL';
comment on column VCR.REF_MEASURE_VALUE.VALUE is
  'measure value';
comment on column VCR.REF_MEASURE_VALUE.UPDATED_DATE_TIME is
  'date value was inserted or updated in VCR';
comment on column VCR.REF_MEASURE_VALUE.UNIT is
  'e.g USD';
comment on column VCR.REF_MEASURE_VALUE.KNOWLEDGE_DATE is
  'date value was entered in reference source';
comment on column VCR.REF_MEASURE_VALUE.ACTUAL_AS_OF_DATE is
  'actual as of date measure was recorded for in reference source';
comment on column VCR.REF_MEASURE_VALUE.VALUE_TYPE is
  'whether the value is from the reference source (S) or calculated (C)';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.REF_MEASURE_VALUE
  add constraint PK_REF_MEASURE_VALUE
  primary key (AS_OF_DATE,REF_OBJECT_ID,MEASURE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.REF_MEASURE_VALUE
  add constraint FK_REF_MEASURE_VALUE_OBJECT
  foreign key (REF_OBJECT_ID)
  references VCR.REF_OBJECT(REF_OBJECT_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate indexes 
------------------------------------------------------------------------------
create index VCR.IX_REF_MEASURE_VALUE_1 on VCR.REF_MEASURE_VALUE(REF_OBJECT_ID,MEASURE)
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

