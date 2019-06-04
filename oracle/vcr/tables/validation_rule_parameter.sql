------------------------------------------------------------------------------
-- $Header: vcr/tables/validation_rule_parameter.sql 1.6 2005/08/23 12:25:43BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.VALIDATION_RULE_PARAMETER
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:23:00
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @validation_rule_parameter.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.VALIDATION_RULE_PARAMETER

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
     and object_name = upper('VALIDATION_RULE_PARAMETER');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.VALIDATION_RULE_PARAMETER already exists. Dropping it');
    execute immediate 'drop table VCR.VALIDATION_RULE_PARAMETER';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.VALIDATION_RULE_PARAMETER cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.VALIDATION_RULE_PARAMETER
(
  RULE_ID                         NUMBER     not null
, SEQ_ID                          NUMBER     default 1  not null
, NAME                            VARCHAR2  (30) not null
, RULE_PARAMETER_ID               NUMBER     not null
, OPERATOR                        VARCHAR2  (200) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.VALIDATION_RULE_PARAMETER is
  'parameter required for validation rule';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.VALIDATION_RULE_PARAMETER.RULE_ID is
  'parent rule';
comment on column VCR.VALIDATION_RULE_PARAMETER.SEQ_ID is
  'sequence number 1..n of parameters for a rule';
comment on column VCR.VALIDATION_RULE_PARAMETER.NAME is
  'description of parameter (e.g. Maximum)';
comment on column VCR.VALIDATION_RULE_PARAMETER.RULE_PARAMETER_ID is
  'pk';
comment on column VCR.VALIDATION_RULE_PARAMETER.OPERATOR is
  'to test whether a limit has been broken e.g. >';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_RULE_PARAMETER
  add constraint PK_VALIDATION_RULE_PARAMETER
  primary key (RULE_PARAMETER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_RULE_PARAMETER
  add constraint UK_VALIDATION_RULE_PARAMETER
  unique (RULE_ID,SEQ_ID)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

