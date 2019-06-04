------------------------------------------------------------------------------
-- $Header: vcr/tables/prime_broker.sql 1.10 2005/09/27 13:17:57BST apenney DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.PRIME_BROKER
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:30
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @prime_broker.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.PRIME_BROKER

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
     and object_name = upper('PRIME_BROKER');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.PRIME_BROKER already exists. Dropping it');
    execute immediate 'drop table VCR.PRIME_BROKER';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.PRIME_BROKER cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.PRIME_BROKER
(
  PRIME_BROKER_ID                 NUMBER     not null
, DESCRIPTION                     VARCHAR2  (500) not null
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.PRIME_BROKER
  add constraint PK_PRIME_BROKER
  primary key (PRIME_BROKER_ID)
  using index
  tablespace VCR_IDX_SMALL
;

alter table VCR.PRIME_BROKER
  add constraint UK_PRIME_BROKER
  unique (DESCRIPTION)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

