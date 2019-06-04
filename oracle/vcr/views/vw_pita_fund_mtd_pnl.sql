------------------------------------------------------------------------------
-- $Header: vcr/views/vw_pita_fund_mtd_pnl.sql 1.6 2005/10/24 08:04:48BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_PITA_FUND_MTD_PNL
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:54
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_pita_fund_mtd_pnl.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_PITA_FUND_MTD_PNL

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_PITA_FUND_MTD_PNL (
  AS_OF_DATE
, SOURCE_NAME
, RELEASED_ON
, FUND
, SOURCE_FUND_ID
, MTD_PNL
, CURRENCY
) as 
select fund.as_of_date, fund.source_name, fund.released_on, fund.fund, fund.source_fund_id, SUM(sp.total_pnl_mtd) mtd_pnl, 'USD' currency
from   
(
    SELECT slr_fund.as_of_date, slr_fund.basis, slr_fund.source_id, slr_fund.fund, sfr.released_on, sfr.source_fund_id, s.source_name
    FROM 
    (
      SELECT slr.as_of_date, slr.basis, slr.source_id, sf.fund, sf.source_fund_id, MAX(slr.load_run_id) load_run_id
      FROM   source_fund_release sfr, source_load_run slr, source_fund sf
      WHERE  sfr.load_run_id    = slr.load_run_id
      AND    slr.basis          = 'TPLUS1'
      AND    slr.status         = 'COM'
      AND    sf.source_fund_id  = sfr.source_fund_id
      GROUP BY slr.as_of_date, slr.source_id, slr.basis, sf.fund, sf.source_fund_id
    ) slr_fund,
    source_fund_release sfr,
    source s
    WHERE sfr.load_run_id    = slr_fund.load_run_id
    AND   sfr.source_fund_id = slr_fund.source_fund_id
    AND   sfr.released_on IS NOT NULL
    AND   slr_fund.source_id = s.source_id
) fund, 
source_position sp
WHERE fund.as_of_date = sp.as_of_date
AND   fund.source_id  = sp.source_id
AND   fund.basis      = sp.basis
AND   fund.fund       = sp.fund
GROUP BY fund.as_of_date, fund.source_name, fund.released_on, fund.fund, fund.source_fund_id
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

