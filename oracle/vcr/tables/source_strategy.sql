------------------------------------------------------------------------------
-- $Header: vcr/tables/source_strategy.sql 1.10 2005/08/23 12:25:38BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_STRATEGY
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:57
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_strategy.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_STRATEGY

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
     and object_name = upper('SOURCE_STRATEGY');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_STRATEGY already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_STRATEGY';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_STRATEGY cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_STRATEGY
(
  SOURCE_STRATEGY_ID              NUMBER     not null
, FUND                            VARCHAR2  (2000) not null
, STRATEGY                        VARCHAR2  (2000) not null
, SOURCE_ID                       NUMBER     not null
, ME_STRATEGY_ID                  NUMBER    
, CHANGE_REASON                   VARCHAR2  (500) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.SOURCE_STRATEGY is
  'A strategy for which P&L positions from a VSP source have been received';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_STRATEGY.SOURCE_STRATEGY_ID is
  'Allocated from sequence';
comment on column VCR.SOURCE_STRATEGY.FUND is
  'Fund field from source - the parent fund of the strategy';
comment on column VCR.SOURCE_STRATEGY.STRATEGY is
  'Strategy field from source';
comment on column VCR.SOURCE_STRATEGY.SOURCE_ID is
  'parent source';
comment on column VCR.SOURCE_STRATEGY.ME_STRATEGY_ID is
  'id of the strategy in webmark or price collection - the source of manager estimates for the stratgies investment engine';
comment on column VCR.SOURCE_STRATEGY.CHANGE_REASON is
  'reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_STRATEGY
  add constraint PK_SOURCE_STRATEGY
  primary key (SOURCE_STRATEGY_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_STRATEGY
  add constraint FK_SOURCE_STRATEGY_ME
  foreign key (ME_STRATEGY_ID)
  references VCR.REF_OBJECT(REF_OBJECT_ID)
;
alter table VCR.SOURCE_STRATEGY
  add constraint FK_SOURCE_STRATEGY_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_STRATEGY
  add constraint UK_SOURCE_STRATEGY
  unique (SOURCE_ID,FUND,STRATEGY)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

