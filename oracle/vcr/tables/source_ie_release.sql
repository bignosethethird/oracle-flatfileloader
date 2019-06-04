------------------------------------------------------------------------------
-- $Header: vcr/tables/source_ie_release.sql 1.5 2005/03/02 07:49:28GMT apenney PRODUCTION  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_IE_RELEASE
--
-- This file was generated from database instance CPAD.
--   Database Time    : 28FEB2005 16:42:03
--   IP address       : 192.5.20.64
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : ahl64
--   O/S user         : vcr
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_ie_release.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.SOURCE_IE_RELEASE

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
     and object_name = upper('SOURCE_IE_RELEASE');
  if(v_count>0)then
    execute immediate 'drop table VCR.SOURCE_IE_RELEASE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('WARNING: Dropping referential constraints to VCR.SOURCE_IE_RELEASE');
      execute immediate 'drop table VCR.SOURCE_IE_RELEASE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_IE_RELEASE
(
  LOAD_RUN_ID                     NUMBER    (22) not null
, IE_ID                           VARCHAR2  (30) not null
, RELEASED_BY                     VARCHAR2  (30) not null
, RELEASED_ON                     DATE       not null
)
tablespace VCR_DATA_SMALL
  logging
  parallel
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_IE_RELEASE is
  'The release of a particular dataset to an investment engine';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_IE_RELEASE
  add constraint PK_SOURCE_IE_RELEASE
  primary key (LOAD_RUN_ID,IE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_IE_RELEASE
  add constraint FK_IE_RELEASE_IE
  foreign key (IE_ID)
  references VCR.INVESTMENT_ENGINE(IE_ID)
;
alter table VCR.SOURCE_IE_RELEASE
  add constraint FK_IE_RELEASE_SOURCE_LOAD_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

