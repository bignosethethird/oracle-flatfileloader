------------------------------------------------------------------------------
-- $Header: vcr/tables/calculated_mtd_ror.sql 1.1.1.1 2005/08/23 13:55:55BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.CALCULATED_MTD_ROR
--
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.CALCULATED_MTD_ROR

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
     and object_name = upper('CALCULATED_MTD_ROR');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.CALCULATED_MTD_ROR already exists. Dropping it');
    execute immediate 'drop table VCR.CALCULATED_MTD_ROR';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.CALCULATED_MTD_ROR cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.CALCULATED_MTD_ROR
(
  SOURCE_ID                        NUMBER    (22) not null
, AS_OF_DATE                       DATE       not null
, BASIS                            VARCHAR2  (30) not null
, SOURCE_OBJECT_ID                 NUMBER    (22) not null
, SOURCE_OBJECT_TYPE               VARCHAR2  (10) not null
, VALUE                            NUMBER
, VALUE_ON_NOTIONAL_CHANGE         NUMBER
, CALCULATION_ERROR                VARCHAR2  (500)
, CREATED_DATE                     DATE
, CREATED_BY                       VARCHAR2  (100)
) TABLESPACE VCR_DATA_MED
logging
;

------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------

comment on column VCR.CALCULATED_MTD_ROR.SOURCE_ID is
  'source';
comment on column VCR.CALCULATED_MTD_ROR.AS_OF_DATE is
  'as of date of ror';
comment on column VCR.CALCULATED_MTD_ROR.BASIS is
  'basis of ror';
comment on column VCR.CALCULATED_MTD_ROR.SOURCE_OBJECT_ID is
  'source fund or strategy id';
comment on column VCR.CALCULATED_MTD_ROR.SOURCE_OBJECT_TYPE is
  'FUND or STRATEGY';
comment on column VCR.CALCULATED_MTD_ROR.VALUE is
  'MTD RoR calculated from VSP data';
comment on column VCR.CALCULATED_MTD_ROR.VALUE_ON_NOTIONAL_CHANGE is
  'MTD RoR calculated from VSP data when notional last changed - only when denominator is notional';
comment on column VCR.CALCULATED_MTD_ROR.CALCULATION_ERROR is
  'description of any error in calculating source value';


------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.CALCULATED_MTD_ROR
  add constraint PK_CALCULATED_MTD_ROR
  primary key (SOURCE_ID,AS_OF_DATE,BASIS,SOURCE_OBJECT_TYPE,SOURCE_OBJECT_ID)
  using index tablespace VCR_IDX_MED
;

------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.CALCULATED_MTD_ROR
  add constraint FK_MTD_ROR_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
alter table VCR.CALCULATED_MTD_ROR
  add constraint FK_MTD_ROR_BASIS
  foreign key (BASIS)
  references VCR.SOURCE_BASIS(BASIS)
;
alter table VCR.CALCULATED_MTD_ROR
  add constraint CHK_MTD_ROR_OBJECT_TYPE
  check (SOURCE_OBJECT_TYPE IN ('FUND','STRATEGY'))
;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

