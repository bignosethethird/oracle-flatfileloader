------------------------------------------------------------------------------
-- $Header: vcr/tables/source_basis.sql 1.9 2005/08/23 12:25:54BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_BASIS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:37
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_basis.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_BASIS

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
     and object_name = upper('SOURCE_BASIS');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_BASIS already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_BASIS';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_BASIS cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_BASIS
(
  BASIS                           VARCHAR2  (30) not null
, DESCRIPTION                     VARCHAR2  (100) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_BASIS is
  'The basis of a position - whether it is valued as soon as possible after the as of date ("tplus1") or as part of a month end valuation signed off by Man ("tclean").';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BASIS
  add constraint PK_SOURCE_BASIS
  primary key (BASIS)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

