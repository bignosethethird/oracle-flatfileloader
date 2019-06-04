------------------------------------------------------------------------------
-- $Header: vcr/tables/measure_rule.sql 1.6 2005/08/23 12:25:38BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.MEASURE_RULE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:29
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @measure_rule.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.MEASURE_RULE

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
     and object_name = upper('MEASURE_RULE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.MEASURE_RULE already exists. Dropping it');
    execute immediate 'drop table VCR.MEASURE_RULE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.MEASURE_RULE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.MEASURE_RULE
(
  MEASURE_ID                      NUMBER     not null
, RULE_ID                         NUMBER     not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.MEASURE_RULE is
  'A specific application of a rule to a measure';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.MEASURE_RULE
  add constraint PK_MEASURE_RULE
  primary key (MEASURE_ID,RULE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

