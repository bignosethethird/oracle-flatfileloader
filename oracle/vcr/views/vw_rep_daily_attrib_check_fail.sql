------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_daily_attrib_check_fail.sql 1.4 2005/08/22 17:46:25BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_DAILY_ATTRIB_CHECK_FAIL
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_daily_attrib_check_fail.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_DAILY_ATTRIB_CHECK_FAIL

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_DAILY_ATTRIB_CHECK_FAIL (
  AS_OF_DATE
, BASIS
, SOURCE_NAME
, INSTRUMENT_TYPE
, DAILY_TOT_MAN_FIELDS_MISSING
) as 
SELECT    slr.as_of_date 
         ,slr.basis 
         ,s.source_name 
         ,slit.instrument_type 
         ,SUM(slit.no_of_mand_fields_missing) daily_tot_man_fields_missing 
FROM      source_load_run      slr 
         ,source_load_ins_type slit 
         ,source               s 
WHERE     slit.load_run_id = slr.load_run_id 
AND       slr.source_id    = s.source_id 
AND       slr.load_run_no  = 1 
GROUP BY  slr.as_of_date 
         ,slr.basis 
         ,s.source_name 
         ,slit.instrument_type
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

