------------------------------------------------------------------------------
-- $Header: vcr/tables/iso_currency_code.sql 1.9 2005/08/23 12:25:37BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.ISO_CURRENCY_CODE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:21
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @iso_currency_code.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.ISO_CURRENCY_CODE

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
     and object_name = upper('ISO_CURRENCY_CODE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.ISO_CURRENCY_CODE already exists. Dropping it');
    execute immediate 'drop table VCR.ISO_CURRENCY_CODE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.ISO_CURRENCY_CODE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.ISO_CURRENCY_CODE
(
  ISO_CURRENCY_CODE               VARCHAR2  (3) not null
, DESCRIPTION                     VARCHAR2  (200) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.ISO_CURRENCY_CODE
  add constraint PK_ISO_CURRENCY_CODE
  primary key (ISO_CURRENCY_CODE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

