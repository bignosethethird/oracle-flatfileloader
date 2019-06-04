------------------------------------------------------------------------------
-- $Header: vcr/sequences/sq_security_price_request.sql 1.2 2005/08/22 18:56:37BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for sequence VCR.SQ_SECURITY_PRICE_REQUEST
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 18:48:01
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @sq_security_price_request.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating sequence VCR.SQ_SECURITY_PRICE_REQUEST

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
     and object_name = upper('SQ_SECURITY_PRICE_REQUEST');
  if(v_count>0)then
    execute immediate 'drop sequence VCR.SQ_SECURITY_PRICE_REQUEST';
  end if;
end;
/
------------------------------------------------------------------------------
-- Create sequence
------------------------------------------------------------------------------

create sequence VCR.SQ_SECURITY_PRICE_REQUEST
  minvalue 1 
  maxvalue 9999999999999999999999999999
  increment by 1
  nocycle
  nocache
  noorder
;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

