------------------------------------------------------------------------------
-- $Header: vcr/tables/source_instrument_type.sql 1.9 2005/08/23 12:25:43BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_INSTRUMENT_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:43
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_instrument_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_INSTRUMENT_TYPE

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
     and object_name = upper('SOURCE_INSTRUMENT_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_INSTRUMENT_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_INSTRUMENT_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_INSTRUMENT_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_INSTRUMENT_TYPE
(
  SOURCE_INSTRUMENT_TYPE_ID       NUMBER     not null
, INSTRUMENT_TYPE                 VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER     not null
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_INSTRUMENT_TYPE.SOURCE_INSTRUMENT_TYPE_ID is
  'Allocated from sequence';
comment on column VCR.SOURCE_INSTRUMENT_TYPE.INSTRUMENT_TYPE is
  'Instrument type field from source';
comment on column VCR.SOURCE_INSTRUMENT_TYPE.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_INSTRUMENT_TYPE.CHANGE_REASON is
  'reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_INSTRUMENT_TYPE
  add constraint PK_SOURCE_INSTRUMENT_TYPE
  primary key (SOURCE_INSTRUMENT_TYPE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_INSTRUMENT_TYPE
  add constraint FK_INSTRUMENT_TYPE_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_INSTRUMENT_TYPE
  add constraint UK_SOURCE_INSTRUMENT_TYPE
  unique (SOURCE_ID,INSTRUMENT_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

