------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_header_parameter.sql 1.2.1.1.1.5 2005/08/23 12:25:42BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.LIMIT_HEADER_PARAMETER
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:28
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_header_parameter.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.LIMIT_HEADER_PARAMETER

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
     and object_name = upper('LIMIT_HEADER_PARAMETER');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_HEADER_PARAMETER already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_HEADER_PARAMETER';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_HEADER_PARAMETER cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.LIMIT_HEADER_PARAMETER
(
  PARAMETER_NAME                  VARCHAR2  (30) not null
, COLUMN_NAME                     VARCHAR2  (30) not null
, HEADER_PARAMETER_ID             NUMBER     not null
, GET_DESC_PROCEDURE              VARCHAR2  (100) not null
, PARENT_COLUMN_NAME              VARCHAR2  (30)
)
tablespace VCR_DATA_SMALL
;
 
------------------------------------------------------------------------------
-- Table comment:
------------------------------------------------------------------------------
comment on table VCR.LIMIT_HEADER_PARAMETER is
  'a type of attribute of the header of a limit e.g. instrument type';
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.LIMIT_HEADER_PARAMETER.COLUMN_NAME is
  'column in validation view e.g. ie_instrument_type_id';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_HEADER_PARAMETER
  add constraint PK_LIMIT_HEADER_PARAMETER
  primary key (HEADER_PARAMETER_ID)
  using index
  tablespace VCR_IDX_SMALL
;
 
------------------------------------------------------------------------------
-- Create/Recreate unique key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_HEADER_PARAMETER
  add constraint UK_LIMIT_HEADER_PARAMETER_1
  unique (PARAMETER_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
alter table VCR.LIMIT_HEADER_PARAMETER
  add constraint UK_LIMIT_HEADER_PARAMETER_2
  unique (COLUMN_NAME)
  using index
  tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

