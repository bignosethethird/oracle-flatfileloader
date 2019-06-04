------------------------------------------------------------------------------
-- $Header: vcr/tables/target_table.sql 1.5.1.6 2005/08/23 12:25:36BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.TARGET_TABLE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:58
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @target_table.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.TARGET_TABLE

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
     and object_name = upper('TARGET_TABLE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.TARGET_TABLE already exists. Dropping it');
    execute immediate 'drop table VCR.TARGET_TABLE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.TARGET_TABLE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.TARGET_TABLE
(
  TABLE_NAME                      VARCHAR2  (100) not null
, PURGE_PROCEDURE                 VARCHAR2  (100) not null
, CHECK_PROCEDURE                 VARCHAR2  (100)
, CALCULATION_PROCEDURE           VARCHAR2  (100)
, MONTHS_RETAINED                 NUMBER     default 3 not null
, DISCARD_PROCEDURE               VARCHAR2  (100)
, DESCRIPTION                     VARCHAR2  (100)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.TARGET_TABLE is
  'Usually we have one table per data type';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.TARGET_TABLE.PURGE_PROCEDURE is
  'name of PL/SQL procedure used to purge data';
comment on column VCR.TARGET_TABLE.CHECK_PROCEDURE is
  'Name of PL/SQL procedure used to check data after load';
comment on column VCR.TARGET_TABLE.MONTHS_RETAINED is
  'number of months of data retained in target table e.g. 3 months';
comment on column VCR.TARGET_TABLE.DESCRIPTION is
  'Describes the type of data in this table';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.TARGET_TABLE
  add constraint PK_TARGET_TABLE
  primary key (TABLE_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

