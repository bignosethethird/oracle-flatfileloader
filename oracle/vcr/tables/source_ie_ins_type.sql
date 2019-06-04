------------------------------------------------------------------------------
-- $Header: vcr/tables/source_ie_ins_type.sql 1.9 2005/08/23 12:25:47BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_IE_INS_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:43
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_ie_ins_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_IE_INS_TYPE

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
     and object_name = upper('SOURCE_IE_INS_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_IE_INS_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_IE_INS_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_IE_INS_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_IE_INS_TYPE
(
  IE_INSTRUMENT_TYPE_ID           NUMBER     not null
, SOURCE_INSTRUMENT_TYPE_ID       NUMBER     not null
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_IE_INS_TYPE is
  'records mapping of an investment engine instrument type to a source instrument type';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_IE_INS_TYPE.IE_INSTRUMENT_TYPE_ID is
  'investment engine instrument type pk';
comment on column VCR.SOURCE_IE_INS_TYPE.SOURCE_INSTRUMENT_TYPE_ID is
  'source instrument type pk';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_IE_INS_TYPE
  add constraint PK_SOURCE_IE_INS_TYPE
  primary key (IE_INSTRUMENT_TYPE_ID,SOURCE_INSTRUMENT_TYPE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_IE_INS_TYPE
  add constraint FK_SOURCE_IE_IT_IE_IT
  foreign key (IE_INSTRUMENT_TYPE_ID)
  references VCR.IE_INSTRUMENT_TYPE(IE_INSTRUMENT_TYPE_ID)
;
alter table VCR.SOURCE_IE_INS_TYPE
  add constraint FK_SOURCE_IE_IT_SOURCE_IT
  foreign key (SOURCE_INSTRUMENT_TYPE_ID)
  references VCR.SOURCE_INSTRUMENT_TYPE(SOURCE_INSTRUMENT_TYPE_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

