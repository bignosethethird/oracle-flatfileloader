------------------------------------------------------------------------------
-- $Header: vcr/tables/ref_source.sql 1.5.1.6 2005/08/23 12:25:46BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.REF_SOURCE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:32
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ref_source.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.REF_SOURCE

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
     and object_name = upper('REF_SOURCE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.REF_SOURCE already exists. Dropping it');
    execute immediate 'drop table VCR.REF_SOURCE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.REF_SOURCE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.REF_SOURCE
(
  REF_SOURCE                      VARCHAR2  (30) not null
, REF_SOURCE_TYPE                 VARCHAR2  (30) not null
, GET_PROCEDURE                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.REF_SOURCE.REF_SOURCE is
  'Unique mnemonic e.g. PRICE COLLECTION or WEBMARK';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.REF_SOURCE
  add constraint PK_REF_SOURCE
  primary key (REF_SOURCE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

