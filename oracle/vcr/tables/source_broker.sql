------------------------------------------------------------------------------
-- $Header: vcr/tables/source_broker.sql 1.9 2005/08/23 12:25:51BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_BROKER
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:37
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_broker.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_BROKER

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
     and object_name = upper('SOURCE_BROKER');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_BROKER already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_BROKER';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_BROKER cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_BROKER
(
  SOURCE_BROKER_ID                NUMBER     not null
, BROKER                          VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER     not null
, PRIME_BROKER_ID                 NUMBER    
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_BROKER.SOURCE_BROKER_ID is
  'Allocated from sequence';
comment on column VCR.SOURCE_BROKER.BROKER is
  'broker on position';
comment on column VCR.SOURCE_BROKER.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_BROKER.PRIME_BROKER_ID is
  'Related common broker';
comment on column VCR.SOURCE_BROKER.CHANGE_REASON is
  'reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BROKER
  add constraint PK_SOURCE_BROKER
  primary key (SOURCE_BROKER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BROKER
  add constraint FK_BROKER_PRIME_BROKER
  foreign key (PRIME_BROKER_ID)
  references VCR.PRIME_BROKER(PRIME_BROKER_ID)
;
alter table VCR.SOURCE_BROKER
  add constraint FK_BROKER_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_BROKER
  add constraint UK_SOURCE_BROKER
  unique (SOURCE_ID,BROKER)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

