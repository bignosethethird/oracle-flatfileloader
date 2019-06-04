------------------------------------------------------------------------------
-- $Header: vcr/views/vw_source_load_run_fund_status.sql 1.5 2005/10/07 11:50:20BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_SOURCE_LOAD_RUN_FUND_STATUS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:57
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_source_load_run_fund_status.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_SOURCE_LOAD_RUN_FUND_STATUS

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_SOURCE_LOAD_RUN_FUND_STATUS (
  AS_OF_DATE
, SOURCE_ID
, SOURCE_NAME
, BASIS
, STATUS
, STATUS_NAME
, LOAD_RUN_NO
, LOAD_RUN_ID
, FUND
, RELEASED_ON
, LOADED_ON
) as 
SELECT 
slrf.as_of_date, 
slrf.source_id, 
slrf.source_name, 
slrf.basis, 
nvl2(sfr.released_by,'R',slrf.status) status,
nvl2(sfr.released_by,'RELEASED',slrf.status_name) status_name,
slrf.load_run_no, 
slrf.load_run_id,
slrf.fund,
sfr.released_on,
slr.end_time loaded_on
FROM (
      SELECT slrs.as_of_date, 
             slrs.source_id, 
             slrs.source_name, 
             slrs.basis, 
             slrs.status, 
             slrs.status_name, 
             slrs.load_run_no, 
             slrs.load_run_id,
             sf.fund,
             sf.source_fund_id
      FROM   
             (
              SELECT slr.as_of_date, 
                     s.source_id, 
                     s.source_name, 
                     slr.basis, 
                     decode(slr.status, 'COM', 'A', 'P') status, 
                     decode(slr.status, 'COM', 'AVAILABLE', 'PENDING') status_name, 
                     latest.load_run_no, 
                     latest.source_fund_id,
                     slr.load_run_id
              FROM source_load_run slr, source s,
              (
                SELECT slr.as_of_date, slr.basis, slr.source_id, sf.source_fund_id, MAX(slr.load_run_no) load_run_no
                FROM   source_fund_release sfr, source_load_run slr, source_fund sf
                WHERE  sfr.load_run_id    = slr.load_run_id
                AND    sf.source_fund_id  = sfr.source_fund_id
                AND    sf.ie_id           = 'MGS'
                GROUP BY slr.as_of_date, slr.source_id, slr.basis, sf.source_fund_id
              ) latest
              WHERE latest.source_id   = slr.source_id
              AND   latest.as_of_date  = slr.as_of_date
              AND   latest.basis       = slr.basis
              AND   latest.load_run_no = slr.load_run_no
              AND	  slr.source_id      = s.source_id             
             ) slrs,
             source_fund sf
      WHERE  slrs.source_fund_id = sf.source_fund_id
     ) slrf,
     source_fund_release sfr,
     source_load_run slr
WHERE slrf.source_fund_id = sfr.source_fund_id (+)
AND   slrf.load_run_id    = sfr.load_run_id (+)
AND   slrf.load_run_id    = slr.load_run_id
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

