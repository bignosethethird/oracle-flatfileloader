------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_param_value.sql 1.7 2005/08/23 12:25:40BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.LIMIT_PARAM_VALUE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:29
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_param_value.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.LIMIT_PARAM_VALUE

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
     and object_name = upper('LIMIT_PARAM_VALUE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_PARAM_VALUE already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_PARAM_VALUE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_PARAM_VALUE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.LIMIT_PARAM_VALUE
(
  LIMIT_ID                        NUMBER     not null
, LIMIT_VERSION                   NUMBER     not null
, RULE_PARAMETER_ID               NUMBER     not null
, VALUE                           NUMBER     not null
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.LIMIT_PARAM_VALUE is
  'value of a rule parameter for a limit version';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_PARAM_VALUE
  add constraint PK_LIMIT_PARAM_VALUE
  primary key (LIMIT_ID,LIMIT_VERSION,RULE_PARAMETER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

