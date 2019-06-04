------------------------------------------------------------------------------
-- $Header: vcr/sequences/sq_source_broker.sql 1.4 2005/03/04 16:14:17GMT apenney PRODUCTION  $
------------------------------------------------------------------------------
-- Creation script for sequence VCR.SQ_SOURCE_BROKER
--
-- This file was generated from database instance CPAD.
--   Database Time    : 28FEB2005 17:10:20
--   IP address       : 192.5.20.64
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : ahl64
--   O/S user         : vcr
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @sq_source_broker.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating sequence VCR.SQ_SOURCE_BROKER

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
     and object_name = upper('SQ_SOURCE_BROKER');
  if(v_count>0)then
    execute immediate 'drop sequence VCR.SQ_SOURCE_BROKER';
  end if;
end;
/
------------------------------------------------------------------------------
-- Create sequence
------------------------------------------------------------------------------

create sequence VCR.SQ_SOURCE_BROKER
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

