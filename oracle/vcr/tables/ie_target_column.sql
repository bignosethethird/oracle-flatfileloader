------------------------------------------------------------------------------
-- $Header: vcr/tables/ie_target_column.sql 1.9 2005/08/23 12:25:35BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.IE_TARGET_COLUMN
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:19
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @ie_target_column.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.IE_TARGET_COLUMN

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
     and object_name = upper('IE_TARGET_COLUMN');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.IE_TARGET_COLUMN already exists. Dropping it');
    execute immediate 'drop table VCR.IE_TARGET_COLUMN';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.IE_TARGET_COLUMN cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.IE_TARGET_COLUMN
(
  IE_ID                           VARCHAR2  (30) not null
, TABLE_NAME                      VARCHAR2  (100) not null
, COLUMN_NAME                     VARCHAR2  (100) not null
, CHANGE_REASON                   VARCHAR2  (500)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.IE_TARGET_COLUMN is
  'Defines whether a source_position column is mandatory for an investment engine';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.IE_TARGET_COLUMN.IE_ID is
  'investment engine key';
comment on column VCR.IE_TARGET_COLUMN.TABLE_NAME is
  'target table';
comment on column VCR.IE_TARGET_COLUMN.COLUMN_NAME is
  'mandatory column';
comment on column VCR.IE_TARGET_COLUMN.CHANGE_REASON is
  'Reason for last change';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.IE_TARGET_COLUMN
  add constraint PK_IE_TARGET_COLUMN
  primary key (IE_ID,TABLE_NAME,COLUMN_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.IE_TARGET_COLUMN
  add constraint FK_IE_TARGET_COLUMN
  foreign key (TABLE_NAME,COLUMN_NAME)
  references VCR.TARGET_COLUMN(TABLE_NAME,COLUMN_NAME)
;
alter table VCR.IE_TARGET_COLUMN
  add constraint FK_IE_TARGET_COLUMN_IE
  foreign key (IE_ID)
  references VCR.INVESTMENT_ENGINE(IE_ID)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

