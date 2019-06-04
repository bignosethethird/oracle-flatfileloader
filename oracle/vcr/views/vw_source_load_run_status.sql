------------------------------------------------------------------------------
-- $Header: vcr/views/vw_source_load_run_status.sql 1.2.1.1.1.3 2005/08/22 17:46:44BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_SOURCE_LOAD_RUN_STATUS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:57
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_source_load_run_status.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_SOURCE_LOAD_RUN_STATUS

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_SOURCE_LOAD_RUN_STATUS (
  AS_OF_DATE
, SOURCE_ID
, SOURCE_NAME
, BASIS
, STATUS
, STATUS_NAME
, LOAD_RUN_NO
, LOAD_RUN_ID
) as 
SELECT slr.as_of_date, s.source_id, s.source_name, slr.basis, decode(slr.status, 'COM', 'A', 'P') status, decode(slr.status, 'COM', 'AVAILABLE', 'PENDING') status_name, latest.load_run_no, slr.load_run_id
FROM source_load_run slr, source s,
(
SELECT source_id, as_of_date, basis, MAX(load_run_no) load_run_no
FROM   source_load_run
GROUP BY source_id, as_of_date, basis
) latest
WHERE latest.source_id   = slr.source_id
AND   latest.as_of_date  = slr.as_of_date
AND   latest.basis       = slr.basis
AND   latest.load_run_no = slr.load_run_no
AND	  slr.source_id      = s.source_id
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

