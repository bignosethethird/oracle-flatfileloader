------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_header_value.sql 1.6 2005/08/23 12:25:41BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.LIMIT_HEADER_VALUE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:28
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_header_value.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.LIMIT_HEADER_VALUE

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
     and object_name = upper('LIMIT_HEADER_VALUE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_HEADER_VALUE already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_HEADER_VALUE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_HEADER_VALUE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.LIMIT_HEADER_VALUE
(
  LIMIT_ID                        NUMBER     not null
, VALUE                           VARCHAR2  (100) not null
, HEADER_PARAMETER_ID             NUMBER     not null
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.LIMIT_HEADER_VALUE is
  'a specific value of a header param for particular limit ';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.LIMIT_HEADER_VALUE.VALUE is
  'value of parameter for the limit header';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_HEADER_VALUE
  add constraint PK_LIMIT_HEADER_VALUE
  primary key (LIMIT_ID,HEADER_PARAMETER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

