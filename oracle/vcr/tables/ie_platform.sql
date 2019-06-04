------------------------------------------------------------------------------
-- $Header: vcr/tables/ie_platform.sql 1.9 2005/08/23 12:25:36BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.IE_PLATFORM
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:19
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ie_platform.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.IE_PLATFORM

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
     and object_name = upper('IE_PLATFORM');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.IE_PLATFORM already exists. Dropping it');
    execute immediate 'drop table VCR.IE_PLATFORM';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.IE_PLATFORM cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.IE_PLATFORM
(
  IE_ID                           VARCHAR2  (30) not null
, IE_PLATFORM                     VARCHAR2  (30) not null
, EMAIL_ADDRESS                   VARCHAR2  (500)
, DESCRIPTION                     VARCHAR2  (100) not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.IE_PLATFORM is
  'an organisation unit within an investment engine that a fund may optionally be defined to belong to - for notification purposes';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.IE_PLATFORM.IE_ID is
  'parent investment engine';
comment on column VCR.IE_PLATFORM.IE_PLATFORM is
  'Unique mnemonic';
comment on column VCR.IE_PLATFORM.EMAIL_ADDRESS is
  'Associated IE platform staff email addresses';
comment on column VCR.IE_PLATFORM.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.IE_PLATFORM
  add constraint PK_IE_PLATFORM
  primary key (IE_ID,IE_PLATFORM)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.IE_PLATFORM
  add constraint FK_IE_PLATFORM_IE
  foreign key (IE_ID)
  references VCR.INVESTMENT_ENGINE(IE_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

