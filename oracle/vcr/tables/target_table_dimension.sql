------------------------------------------------------------------------------
-- $Header: vcr/tables/target_table_dimension.sql 1.9 2005/08/23 12:25:40BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.TARGET_TABLE_DIMENSION
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:59
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @target_table_dimension.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.TARGET_TABLE_DIMENSION

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
     and object_name = upper('TARGET_TABLE_DIMENSION');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.TARGET_TABLE_DIMENSION already exists. Dropping it');
    execute immediate 'drop table VCR.TARGET_TABLE_DIMENSION';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.TARGET_TABLE_DIMENSION cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.TARGET_TABLE_DIMENSION
(
  TABLE_NAME                      VARCHAR2  (100) not null
, DIM_BUILD_PROCEDURE             VARCHAR2  (100) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.TARGET_TABLE_DIMENSION is
  'the pl/sql procedures that maintain dimensions of target table';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.TARGET_TABLE_DIMENSION
  add constraint PK_TARGET_TABLE_DIMENSION
  primary key (TABLE_NAME,DIM_BUILD_PROCEDURE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.TARGET_TABLE_DIMENSION
  add constraint FK_TARGET_TABLE_NAME
  foreign key (TABLE_NAME)
  references VCR.TARGET_TABLE(TABLE_NAME)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

