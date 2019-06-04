------------------------------------------------------------------------------
-- $Header: vcr/tables/investment_engine.sql 1.6.1.6 2005/08/23 12:25:55BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.INVESTMENT_ENGINE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:20
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @investment_engine.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.INVESTMENT_ENGINE

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
     and object_name = upper('INVESTMENT_ENGINE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.INVESTMENT_ENGINE already exists. Dropping it');
    execute immediate 'drop table VCR.INVESTMENT_ENGINE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.INVESTMENT_ENGINE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.INVESTMENT_ENGINE
(
  IE_ID                           VARCHAR2  (30) not null
, DESCRIPTION                     VARCHAR2  (100) not null
, ME_SOURCE                       VARCHAR2  (30)
, EMAIL_ADDRESS                   VARCHAR2  (500)
, IGNORE_ZERO_POSITIONS           CHAR      (1) default 'N'  not null
, ROR_CALC_DENOMINATOR            VARCHAR2  (20) default null  not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.INVESTMENT_ENGINE is
  'A MI content business areas - a client for collated and reviewed P&L position data. e.g. MGS, RMF or Glenwood';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.INVESTMENT_ENGINE.IE_ID is
  'Unique mnemonic';
comment on column VCR.INVESTMENT_ENGINE.ME_SOURCE is
  'e.g. WEBMARK or PRICE COLLECTION';
comment on column VCR.INVESTMENT_ENGINE.EMAIL_ADDRESS is
  'Associated IE staff email addresses';
comment on column VCR.INVESTMENT_ENGINE.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate check constraints
------------------------------------------------------------------------------
alter table VCR.INVESTMENT_ENGINE
  add constraint CHK_ROR_CALC_DENOMINATOR
  check ()
  ENABLED;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.INVESTMENT_ENGINE
  add constraint PK_INVESTMENT_ENGINE
  primary key (IE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.INVESTMENT_ENGINE
  add constraint FK_ME_SOURCE
  foreign key (ME_SOURCE)
  references VCR.REF_SOURCE(REF_SOURCE)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

