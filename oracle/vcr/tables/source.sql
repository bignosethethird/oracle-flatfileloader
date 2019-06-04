------------------------------------------------------------------------------
-- $Header: vcr/tables/source.sql 1.5.1.6 2005/08/23 12:25:44BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:36
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE

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
     and object_name = upper('SOURCE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE
(
  SOURCE_ID                       NUMBER     not null
, SOURCE_NAME                     VARCHAR2  (100) not null
, EMAIL_ADDRESS                   VARCHAR2  (500)
, SECURE_MESSAGE_ID               VARCHAR2  (30)
, TPLUS1_OFFSET                   NUMBER     default 24
 not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE is
  'A source of data  e.g. a service provider or a manager';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE.SOURCE_ID is
  'unique numeric identifier';
comment on column VCR.SOURCE.SOURCE_NAME is
  'unqiue description - used for messages, screens, reports etc';
comment on column VCR.SOURCE.EMAIL_ADDRESS is
  'source contact email addresses';
comment on column VCR.SOURCE.SECURE_MESSAGE_ID is
  'id for sending secure messages to this source';
comment on column VCR.SOURCE.TPLUS1_OFFSET is
  'no of hours after midnight on as of date that tplus 1 file should have arrived by';
comment on column VCR.SOURCE.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE
  add constraint PK_SOURCE
  primary key (SOURCE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE
  add constraint UK_SOURCE_NAME
  unique (SOURCE_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

