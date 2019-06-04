------------------------------------------------------------------------------
-- $Header: vcr/tables/source_staging_area.sql 1.11 2005/08/23 12:25:42BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_STAGING_AREA
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:56
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_staging_area.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_STAGING_AREA

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
     and object_name = upper('SOURCE_STAGING_AREA');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_STAGING_AREA already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_STAGING_AREA';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_STAGING_AREA cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_STAGING_AREA
(
  SOURCE_FILE_TYPE                VARCHAR2  (30) not null
, FILE_ID                         VARCHAR2  (30) not null
, STAGING_RECORD                  CLOB       not null
)
  partition by LIST(SOURCE_FILE_TYPE)(
    partition BOB values ('bob')
      tablespace VCR_DATA_MED
  , partition CAH values ('cah')
      tablespace VCR_DATA_MED
  , partition GFSMGS values ('gfsmgs')
      tablespace VCR_DATA_MED
  , partition GLOBEOPRMF values ('globeoprmf')
      tablespace VCR_DATA_MED
  , partition IFS values ('ifs')
      tablespace VCR_DATA_MED
  , partition SS values ('ss')
      tablespace VCR_DATA_MED
  , partition SSC values ('ssc')
      tablespace VCR_DATA_MED
  , partition TYK values ('tyk')
      tablespace VCR_DATA_MED
  )
;
 
------------------------------------------------------------------------------
-- Create/Recreate indexes 
------------------------------------------------------------------------------
create index VCR.IX_SOURCE_STAGING_AREA_1 on VCR.SOURCE_STAGING_AREA(SOURCE_FILE_TYPE,FILE_ID)
  local
  (
    partition GFSMGS tablespace VCR_IDX_MED
  , partition BOB tablespace VCR_IDX_MED
  , partition SSC tablespace VCR_IDX_MED
  , partition IFS tablespace VCR_IDX_MED
  , partition SS tablespace VCR_IDX_MED
  , partition TYK tablespace VCR_IDX_MED
  , partition CAH tablespace VCR_IDX_MED
  , partition GLOBEOPRMF tablespace VCR_IDX_MED
  )
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

