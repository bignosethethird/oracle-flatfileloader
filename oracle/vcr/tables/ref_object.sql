------------------------------------------------------------------------------
-- $Header: vcr/tables/ref_object.sql 1.5.1.6 2005/08/23 12:25:39BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.REF_OBJECT
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:31
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ref_object.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.REF_OBJECT

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
     and object_name = upper('REF_OBJECT');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.REF_OBJECT already exists. Dropping it');
    execute immediate 'drop table VCR.REF_OBJECT';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.REF_OBJECT cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.REF_OBJECT
(
  REF_OBJECT_ID                   NUMBER     not null
, REF_SOURCE                      VARCHAR2  (30) not null
, REF_OBJECT_TYPE                 VARCHAR2  (30) not null
, REF_OBJECT_CODE                 VARCHAR2  (100) not null
, REF_OBJECT_DESCRIPTION          VARCHAR2  (500) not null
, UPDATED_DATE_TIME               DATE       not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.REF_OBJECT.REF_OBJECT_ID is
  'Allocated from sequence';
comment on column VCR.REF_OBJECT.REF_OBJECT_TYPE is
  'Unique mnemonic e.g. BENCHMARK FUND, MAC, STRATEGY';
comment on column VCR.REF_OBJECT.REF_OBJECT_CODE is
  'Unique identifier of measured object e,g, fund';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.REF_OBJECT
  add constraint PK_REF_OBJECT
  primary key (REF_OBJECT_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.REF_OBJECT
  add constraint FK_REF_OBJECT_SOURCE
  foreign key (REF_SOURCE)
  references VCR.REF_SOURCE(REF_SOURCE)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.REF_OBJECT
  add constraint UK_REF_OBJECT
  unique (REF_SOURCE,REF_OBJECT_TYPE,REF_OBJECT_CODE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

