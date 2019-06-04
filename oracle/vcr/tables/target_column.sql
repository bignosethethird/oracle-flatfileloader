------------------------------------------------------------------------------
-- $Header: vcr/tables/target_column.sql 1.9 2005/08/23 12:25:48BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.TARGET_COLUMN
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:58
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @target_column.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.TARGET_COLUMN

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
     and object_name = upper('TARGET_COLUMN');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.TARGET_COLUMN already exists. Dropping it');
    execute immediate 'drop table VCR.TARGET_COLUMN';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.TARGET_COLUMN cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.TARGET_COLUMN
(
  TABLE_NAME                      VARCHAR2  (100) not null
, COLUMN_NAME                     VARCHAR2  (100) not null
, COLUMN_DESCRIPTION              VARCHAR2  (200) not null
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.TARGET_COLUMN is
  'A known column on a target table';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.TARGET_COLUMN.TABLE_NAME is
  'target table for records loaded by VCR e.g. source_position';
comment on column VCR.TARGET_COLUMN.COLUMN_NAME is
  'column on target table';
comment on column VCR.TARGET_COLUMN.COLUMN_DESCRIPTION is
  'textual description of column';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.TARGET_COLUMN
  add constraint PK_TARGET_COLUMN
  primary key (TABLE_NAME,COLUMN_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.TARGET_COLUMN
  add constraint FK_TARGET_COLUMN_TABLE
  foreign key (TABLE_NAME)
  references VCR.TARGET_TABLE(TABLE_NAME)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

