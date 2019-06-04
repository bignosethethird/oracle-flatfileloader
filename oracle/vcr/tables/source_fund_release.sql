------------------------------------------------------------------------------
-- $Header: vcr/tables/source_fund_release.sql 1.5 2005/08/23 12:25:52BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_FUND_RELEASE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:42
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_fund_release.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_FUND_RELEASE

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
     and object_name = upper('SOURCE_FUND_RELEASE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_FUND_RELEASE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_FUND_RELEASE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_FUND_RELEASE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_FUND_RELEASE
(
  LOAD_RUN_ID                     NUMBER    (22) not null
, SOURCE_FUND_ID                  NUMBER    (22) not null
, RELEASED_BY                     VARCHAR2  (30)
, RELEASED_ON                     DATE      
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_FUND_RELEASE is
  'The release of the data for a fund to an investment engine for a particular load of data';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND_RELEASE
  add constraint PK_SOURCE_FUND_RELEASE
  primary key (LOAD_RUN_ID,SOURCE_FUND_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_FUND_RELEASE
  add constraint FK_SF_RELEASE_SF
  foreign key (SOURCE_FUND_ID)
  references VCR.SOURCE_FUND(SOURCE_FUND_ID)
;
alter table VCR.SOURCE_FUND_RELEASE
  add constraint FK_SF_RELEASE_SOURCE_LOAD_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

