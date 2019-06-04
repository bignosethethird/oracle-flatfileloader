------------------------------------------------------------------------------
-- $Header: vcr/types/t_datapool_macror_list.sql 1.1.3.1 2005/08/19 17:11:14BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for type VCR.T_DATAPOOL_MACROR_LIST
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 19AUG2005 16:46:39
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @t_datapool_macror_list.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating type VCR.T_DATAPOOL_MACROR_LIST

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
     and object_name = upper('T_DATAPOOL_MACROR_LIST');
  if(v_count>0)then
    execute immediate 'drop type VCR.T_DATAPOOL_MACROR_LIST validate';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('WARNING: There are database objects dependent on VCR.T_DATAPOOL_MACROR_LIST');
      execute immediate 'drop type VCR.T_DATAPOOL_MACROR_LIST force';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create type
------------------------------------------------------------------------------
create or replace type t_datapool_macror_list as table of vcr.t_datapool_macror;
;
/
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

