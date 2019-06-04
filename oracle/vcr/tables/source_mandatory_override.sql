------------------------------------------------------------------------------
-- $Header: vcr/tables/source_mandatory_override.sql 1.1.1.1 2005/08/23 13:57:54BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_MANDATORY_OVERRIDE
--
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.SOURCE_MANDATORY_OVERRIDE

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
     and object_name = upper('SOURCE_MANDATORY_OVERRIDE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_MANDATORY_OVERRIDE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_MANDATORY_OVERRIDE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_MANDATORY_OVERRIDE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_MANDATORY_OVERRIDE
(
  SOURCE_OBJECT_ID             NUMBER    (22) not null
, SOURCE_OBJECT_TYPE       VARCHAR2  (100) not null
, TABLE_NAME               VARCHAR2  (100) not null
, COLUMN_NAME              VARCHAR2  (100) not null
, CHANGE_REASON                VARCHAR2  (500) not null
, MANDATORY_IND                CHAR      (1) not null
) TABLESPACE VCR_DATA_SMALL
logging
;

------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------

comment on column VCR.SOURCE_MANDATORY_OVERRIDE.SOURCE_OBJECT_ID is
  'source or source instrument type';
comment on column VCR.SOURCE_MANDATORY_OVERRIDE.SOURCE_OBJECT_TYPE is
  'either SOURCE or INSTRUMENTTYPE';
comment on column VCR.SOURCE_MANDATORY_OVERRIDE.TABLE_NAME is
  'table of column override is for';
comment on column VCR.SOURCE_MANDATORY_OVERRIDE.COLUMN_NAME is
  'column override is for';
comment on column VCR.SOURCE_MANDATORY_OVERRIDE.CHANGE_REASON is
  'reason for changes';
comment on column VCR.SOURCE_MANDATORY_OVERRIDE.MANDATORY_IND is
  'Y if column is mandatory for the specified source and instrument type, N if it is not';


------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_MANDATORY_OVERRIDE
  add constraint PK_SOURCE_MANDATORY_OVERRIDE
  primary key (SOURCE_OBJECT_ID,SOURCE_OBJECT_TYPE,TABLE_NAME,COLUMN_NAME)
  using index tablespace VCR_IDX_SMALL
;

------------------------------------------------------------------------------
-- Create/Recreate foreign/check constraints
------------------------------------------------------------------------------

alter table VCR.SOURCE_MANDATORY_OVERRIDE
  add constraint FK_MANDATORY_OVERRIDE_COLUMN
  foreign key (TABLE_NAME,COLUMN_NAME)
  references VCR.TARGET_COLUMN(TABLE_NAME,COLUMN_NAME)
;
alter table VCR.SOURCE_MANDATORY_OVERRIDE
  add constraint CHK_MANDATORY_OVERRIDE_IND
  check (MANDATORY_IND IN ('Y','N'))
;
alter table VCR.SOURCE_MANDATORY_OVERRIDE
  add constraint CHK_MANDATORY_OVERRIDE_TYPE
  check (SOURCE_OBJECT_TYPE IN ('SOURCE','INSTRUMENTTYPE'))
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

