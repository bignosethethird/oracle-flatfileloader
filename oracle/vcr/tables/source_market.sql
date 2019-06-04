------------------------------------------------------------------------------
-- $Header: vcr/tables/source_market.sql 1.5 2005/08/23 12:25:44BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_MARKET
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:47
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_market.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_MARKET

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
     and object_name = upper('SOURCE_MARKET');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_MARKET already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_MARKET';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_MARKET cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_MARKET
(
  MARKET_NAME                     VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER    (22) not null
, EXCHANGE_CODE                   VARCHAR2  (2)
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_MARKET.MARKET_NAME is
  'Market name from source';
comment on column VCR.SOURCE_MARKET.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_MARKET.EXCHANGE_CODE is
  'mapped BB exchange code (2 characters)';
comment on column VCR.SOURCE_MARKET.CHANGE_REASON is
  'reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_MARKET
  add constraint PK_SOURCE_MARKET
  primary key (SOURCE_ID,MARKET_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_MARKET
  add constraint FK_SOURCE_MARKET_EXCH_CODE
  foreign key (EXCHANGE_CODE)
  references VCR.EXCHANGE_CODE(EXCHANGE_CODE)
;
alter table VCR.SOURCE_MARKET
  add constraint FK_SOURCE_MARKET_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

