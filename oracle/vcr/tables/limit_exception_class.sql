------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_exception_class.sql 1.5 2005/08/23 12:25:48BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.LIMIT_EXCEPTION_CLASS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:28
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_exception_class.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.LIMIT_EXCEPTION_CLASS

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
     and object_name = upper('LIMIT_EXCEPTION_CLASS');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_EXCEPTION_CLASS already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_EXCEPTION_CLASS';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_EXCEPTION_CLASS cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.LIMIT_EXCEPTION_CLASS
(
  CLASS                           VARCHAR2  (20) not null
, DESCRIPTION                     VARCHAR2  (100) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_EXCEPTION_CLASS
  add constraint PK_LIMIT_EXCEPTION_CLASS
  primary key (CLASS)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

