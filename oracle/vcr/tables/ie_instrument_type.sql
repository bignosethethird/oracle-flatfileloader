------------------------------------------------------------------------------
-- $Header: vcr/tables/ie_instrument_type.sql 1.5.1.8 2005/09/27 13:16:50BST apenney DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.IE_INSTRUMENT_TYPE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:18
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ie_instrument_type.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.IE_INSTRUMENT_TYPE

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
     and object_name = upper('IE_INSTRUMENT_TYPE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.IE_INSTRUMENT_TYPE already exists. Dropping it');
    execute immediate 'drop table VCR.IE_INSTRUMENT_TYPE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.IE_INSTRUMENT_TYPE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.IE_INSTRUMENT_TYPE
(
  IE_INSTRUMENT_TYPE_ID           NUMBER     not null
, IE_INSTRUMENT_TYPE              VARCHAR2  (500) not null
, IE_ID                           VARCHAR2  (30) not null
, CHANGE_REASON                   VARCHAR2  (500) not null
, CATEGORY                        VARCHAR2  (30) default 'OTHER' not null
, STALE_PRICE_PERIOD	          NUMBER
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.IE_INSTRUMENT_TYPE is
  'An investment engine instrument type. Each investment engine will have its own distinct list of instrument types.';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.IE_INSTRUMENT_TYPE.IE_INSTRUMENT_TYPE_ID is
  'unique id';
comment on column VCR.IE_INSTRUMENT_TYPE.IE_INSTRUMENT_TYPE is
  'textual description of instrument type';
comment on column VCR.IE_INSTRUMENT_TYPE.IE_ID is
  'parent investment engine';
comment on column VCR.IE_INSTRUMENT_TYPE.CHANGE_REASON is
  'reason for addition, deletion etc';
 
------------------------------------------------------------------------------
-- Create/Recreate check constraints
------------------------------------------------------------------------------
alter table VCR.IE_INSTRUMENT_TYPE
  add constraint CK_INS_TYPE_CATEGORY
  check ()
  ENABLED;
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.IE_INSTRUMENT_TYPE
  add constraint PK_IE_INSTRUMENT_TYPE
  primary key (IE_INSTRUMENT_TYPE_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.IE_INSTRUMENT_TYPE
  add constraint FK_INSTRUMENT_TYPE_IE
  foreign key (IE_ID)
  references VCR.INVESTMENT_ENGINE(IE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.IE_INSTRUMENT_TYPE
  add constraint UK_IE_INSTRUMENT_TYPE
  unique (IE_ID,IE_INSTRUMENT_TYPE)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

