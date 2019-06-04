------------------------------------------------------------------------------
-- $Header: vcr/tables/validation_rule.sql 1.6 2005/08/23 12:25:37BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.VALIDATION_RULE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:23:00
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @validation_rule.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.VALIDATION_RULE

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
     and object_name = upper('VALIDATION_RULE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.VALIDATION_RULE already exists. Dropping it');
    execute immediate 'drop table VCR.VALIDATION_RULE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.VALIDATION_RULE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.VALIDATION_RULE
(
  RULE_ID                         NUMBER     not null
, NAME                            VARCHAR2  (30) not null
, BREAK_MESSAGE                   VARCHAR2  (200)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.VALIDATION_RULE is
  'defines the type of validation applied to a measure';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.VALIDATION_RULE.NAME is
  'e.g. less than, between';
comment on column VCR.VALIDATION_RULE.BREAK_MESSAGE is
  'description of break of this rule e.g. is greater than, is not between';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_RULE
  add constraint PK_VALIDATION_RULE
  primary key (RULE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.VALIDATION_RULE
  add constraint UK_VALIDATION_RULE
  unique (NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

