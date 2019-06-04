------------------------------------------------------------------------------
-- $Header: vcr/tables/ref_type_map.sql 1.6 2005/08/23 12:25:50BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.REF_TYPE_MAP
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:32
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ref_type_map.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.REF_TYPE_MAP

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
     and object_name = upper('REF_TYPE_MAP');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.REF_TYPE_MAP already exists. Dropping it');
    execute immediate 'drop table VCR.REF_TYPE_MAP';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.REF_TYPE_MAP cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.REF_TYPE_MAP
(
  REF_SOURCE                      VARCHAR2  (30) not null
, MAP                             VARCHAR2  (30) not null
, SOURCE_TYPE                     VARCHAR2  (100) not null
, VCR_TYPE                        VARCHAR2  (100) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.REF_TYPE_MAP is
  'maps reference source specific types to VCR types';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.REF_TYPE_MAP.REF_SOURCE is
  'e.g. WEBMARK';
comment on column VCR.REF_TYPE_MAP.MAP is
  'e.g. OBJECT';
comment on column VCR.REF_TYPE_MAP.SOURCE_TYPE is
  'e.g. FUNDM';
comment on column VCR.REF_TYPE_MAP.VCR_TYPE is
  'e.g MEFUND';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.REF_TYPE_MAP
  add constraint PK_REF_TYPE_MAP
  primary key (REF_SOURCE,MAP,SOURCE_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.REF_TYPE_MAP
  add constraint FK_REF_TYPE_MAP_SOURCE
  foreign key (REF_SOURCE)
  references VCR.REF_SOURCE(REF_SOURCE)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

