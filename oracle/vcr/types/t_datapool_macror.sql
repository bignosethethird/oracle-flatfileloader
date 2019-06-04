------------------------------------------------------------------------------
-- $Header: vcr/types/t_datapool_macror.sql 1.1.3.1 2005/08/19 17:11:13BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for type VCR.T_DATAPOOL_MACROR
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 19AUG2005 16:46:39
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @t_datapool_macror.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating type VCR.T_DATAPOOL_MACROR

-- Drop type if it already exists
-- Note that the database objects dependent on this type will become unusable
-- You will be warned when this happens.
declare 
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'TYPE'
     and owner = upper('VCR')
     and object_name = upper('T_DATAPOOL_MACROR');
  if(v_count>0)then
    execute immediate 'drop type VCR.T_DATAPOOL_MACROR validate';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('WARNING: There are database objects dependent on VCR.T_DATAPOOL_MACROR');
      execute immediate 'drop type VCR.T_DATAPOOL_MACROR force';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create type
------------------------------------------------------------------------------
create or replace type t_datapool_macror as object(
  mac_entity_id	              INTEGER,
  mac_entity	                VARCHAR2(200),
  mac_ror_mtd                 NUMBER,
  mac_as_of_date              DATE,
  mac_entered_on	            DATE,
  benchmark_entity_id	        INTEGER,
  benchmark_entity	          VARCHAR2(200),
  benchmark_ror_mtd           NUMBER,
  benchmark_as_of_date        DATE,
  benchmark_entered_on	      DATE
)
;
/
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

