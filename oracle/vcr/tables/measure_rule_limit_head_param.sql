------------------------------------------------------------------------------
-- $Header: vcr/tables/measure_rule_limit_head_param.sql 1.6 2005/08/23 12:25:50BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:30
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @measure_rule_limit_head_param.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM

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
     and object_name = upper('MEASURE_RULE_LIMIT_HEAD_PARAM');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM already exists. Dropping it');
    execute immediate 'drop table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM
(
  MEASURE_ID                      NUMBER     not null
, RULE_ID                         NUMBER     not null
, HEADER_PARAMETER_ID             NUMBER     not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM is
  'defines which types of attribute it is valid to define limits for, for a measure rule e.g. fund and instrument type';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.MEASURE_RULE_LIMIT_HEAD_PARAM
  add constraint PK_MEASURE_RULE_LIM_HEAD_PARAM
  primary key (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

