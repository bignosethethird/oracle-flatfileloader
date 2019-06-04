------------------------------------------------------------------------------
-- $Header: vcr/views/vw_std_exception_report_param.sql 1.4 2005/08/22 17:46:44BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_STD_EXCEPTION_REPORT_PARAM
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:57
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_std_exception_report_param.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_STD_EXCEPTION_REPORT_PARAM

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_STD_EXCEPTION_REPORT_PARAM (
  SOURCE_NAME
, LOAD_RUN_ID
, IE_ID
, FILE_NAME
) as 
SELECT 
last_slr.source_name, 
last_slr.load_run_id, 
slr_ie.ie_id, 
lower(last_slr.source_name)||'_'||lower(slr_ie.basis)||'_'||to_char(slr_ie.as_of_date,'YYYYMMDD')||'_'||slr_ie.load_run_no||'_'||lower(slr_ie.ie_id) file_name
from   
(
    SELECT s.source_name, MAX(slr.load_run_id) load_run_id
    FROM   source_load_run slr, source s
    WHERE  slr.source_id      = s.source_id
    AND    slr.status         = 'COM'
    GROUP BY s.source_name
) last_slr, 
(
    SELECT DISTINCT nvl(sf.ie_id,'undefined') ie_id, slr.load_run_id, slr.basis, slr.load_run_no, slr.as_of_date
    FROM   source_fund sf, source_load_run slr
    WHERE  slr.source_id   = sf.source_id
) slr_ie
WHERE slr_ie.load_run_id = last_slr.load_run_id
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

