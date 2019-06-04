------------------------------------------------------------------------------
-- $Header: vcr/tables/source_fund.sql 1.9 2005/08/23 12:25:41BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_FUND
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:40
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_fund.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_FUND

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
     and object_name = upper('SOURCE_FUND');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_FUND already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_FUND';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_FUND cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_FUND
(
  SOURCE_FUND_ID                  NUMBER     not null
, FUND                            VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER     not null
, IE_ID                           VARCHAR2  (30)
, IE_PLATFORM                     VARCHAR2  (30)
, ME_FUND_ID                      NUMBER    
, ACTIVE_IND                      CHAR      (1) default 'Y'  not null
, ME_BENCHMARK_FUND_ID            NUMBER    
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_FUND.SOURCE_FUND_ID is
  'Allocated from sequence';
comment on column VCR.SOURCE_FUND.FUND is
  'Fund field from source';
comment on column VCR.SOURCE_FUND.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_FUND.IE_ID is
  'mapped investment engine';
comment on column VCR.SOURCE_FUND.IE_PLATFORM is
  'mapped investment engine platform';
comment on column VCR.SOURCE_FUND.ME_FUND_ID is
  'Identifier of fund in Webmark or RMF Price Collection';
comment on column VCR.SOURCE_FUND.ACTIVE_IND is
  'Y (default) or N';
comment on column VCR.SOURCE_FUND.ME_BENCHMARK_FUND_ID is
  'Identifier of benchmark fund in webmark or price collection systems';
comment on column VCR.SOURCE_FUND.CHANGE_REASON is
  'reason for latest change';
 
------------------------------------------------------------------------------
-- Create/Recreate check constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND
  add constraint CHECK_SOURCE_FUND_ACTIVE_IND
  check ()
  ENABLED;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND
  add constraint PK_SOURCE_FUND
  primary key (SOURCE_FUND_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND
  add constraint FK_SOURCE_FUND_BMARK
  foreign key (ME_BENCHMARK_FUND_ID)
  references VCR.REF_OBJECT(REF_OBJECT_ID)
;
alter table VCR.SOURCE_FUND
  add constraint FK_SOURCE_FUND_IE
  foreign key (IE_ID)
  references VCR.INVESTMENT_ENGINE(IE_ID)
;
alter table VCR.SOURCE_FUND
  add constraint FK_SOURCE_FUND_IE_PLATFORM
  foreign key (IE_ID,IE_PLATFORM)
  references VCR.IE_PLATFORM(IE_ID,IE_PLATFORM)
;
alter table VCR.SOURCE_FUND
  add constraint FK_SOURCE_FUND_ME
  foreign key (ME_FUND_ID)
  references VCR.REF_OBJECT(REF_OBJECT_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND
  add constraint UK_SOURCE_FUND
  unique (SOURCE_ID,FUND)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

