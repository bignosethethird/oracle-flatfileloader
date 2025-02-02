------------------------------------------------------------------------------
-- $Header: vcr/sequences/sq_prime_broker.sql 1.1 2005/08/22 18:50:50BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for sequence VCR.SQ_PRIME_BROKER
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 18:48:01
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @sq_prime_broker.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating sequence VCR.SQ_PRIME_BROKER

-- Drop type if it already exists
-- Note that the contents of the table will also be deleted.
declare 
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'SEQUENCE'
     and owner = upper('VCR')
     and object_name = upper('SQ_PRIME_BROKER');
  if(v_count>0)then
    execute immediate 'drop sequence VCR.SQ_PRIME_BROKER';
  end if;
end;
/
------------------------------------------------------------------------------
-- Create sequence
------------------------------------------------------------------------------

create sequence VCR.SQ_PRIME_BROKER
  minvalue 1 
  maxvalue 9999999999999999999999999999
  increment by 1
  nocycle
  cache 20
  noorder
;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

