------------------------------------------------------------------------------
-- $Header: vcr/tables/source_basis_measure_rule.sql 1.6 2005/08/23 12:25:55BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_BASIS_MEASURE_RULE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:37
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_basis_measure_rule.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_BASIS_MEASURE_RULE

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
     and object_name = upper('SOURCE_BASIS_MEASURE_RULE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_BASIS_MEASURE_RULE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_BASIS_MEASURE_RULE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_BASIS_MEASURE_RULE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_BASIS_MEASURE_RULE
(
  MEASURE_ID                      NUMBER     not null
, RULE_ID                         NUMBER     not null
, BASIS                           VARCHAR2  (30) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_BASIS_MEASURE_RULE is
  'Defines what basii a measure rule is applied for';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BASIS_MEASURE_RULE
  add constraint PK_SOURCE_BASIS_MEASURE_RULE
  primary key (MEASURE_ID,RULE_ID,BASIS)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BASIS_MEASURE_RULE
  add constraint FK_SBMR_BASIS
  foreign key (BASIS)
  references VCR.SOURCE_BASIS(BASIS)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

