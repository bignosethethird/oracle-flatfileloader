------------------------------------------------------------------------------
-- $Header: vcr/tables/source_currency.sql 1.9 2005/08/23 12:25:36BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_CURRENCY
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:39
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_currency.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_CURRENCY

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
     and object_name = upper('SOURCE_CURRENCY');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_CURRENCY already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_CURRENCY';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_CURRENCY cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_CURRENCY
(
  CURRENCY                        VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER     not null
, ISO_CURRENCY_CODE               VARCHAR2  (3)
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_CURRENCY.CURRENCY is
  'currency from source';
comment on column VCR.SOURCE_CURRENCY.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_CURRENCY.CHANGE_REASON is
  'reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_CURRENCY
  add constraint PK_SOURCE_CURRENCY
  primary key (SOURCE_ID,CURRENCY)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_CURRENCY
  add constraint FK_SOURCE_CURRENCY_ISO_CODE
  foreign key (ISO_CURRENCY_CODE)
  references VCR.ISO_CURRENCY_CODE(ISO_CURRENCY_CODE)
;
alter table VCR.SOURCE_CURRENCY
  add constraint FK_SOURCE_CURRENCY_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

