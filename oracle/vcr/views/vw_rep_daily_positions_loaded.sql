------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_daily_positions_loaded.sql 1.4 2005/08/22 17:46:26BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_DAILY_POSITIONS_LOADED
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_daily_positions_loaded.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_DAILY_POSITIONS_LOADED

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_DAILY_POSITIONS_LOADED (
  BASIS
, AS_OF_DATE
, INVESTMENT_ENGINE
, SOURCE
, FUND
, STRATEGY
, INSTRUMENT_TYPE
, TOTAL_DAILY_POS
) as 
SELECT   x.basis 
        ,x.as_of_date 
        ,x.investment_engine 
        ,x.source 
        ,x.fund 
        ,x.strategy 
        ,NVL(z.ie_instrument_type,z.src_instrument_type) instrument_type -- picks src_inst_type or preferably ie_inst_type 
        ,COUNT(*)                       total_daily_pos 
FROM     (SELECT   sp.basis 
                  ,sp.as_of_date 
                  ,sf.ie_id             investment_engine 
                  ,s.source_name        source 
                  ,sp.fund 
                  ,sp.strategy 
                  ,sp.instrument_type   src_instrument_type 
                  ,sp.source_id 
          FROM     source_position      sp 
                  ,source_fund          sf 
                  ,source               s 
          WHERE    sp.source_id       = s.source_id 
          AND      sp.fund            = sf.fund 
          AND      sp.source_id       = sf.source_id 
         ) x 
        ,(SELECT sit.instrument_type           src_instrument_type 
                ,sit.source_id 
                ,iit.ie_instrument_type 
                ,iit.ie_id                     investment_engine 
          FROM   source_instrument_type        sit 
                ,source_ie_ins_type            siet 
                ,ie_instrument_type            iit 
          WHERE  sit.source_instrument_type_id = siet.source_instrument_type_id (+) 
          AND    siet.ie_instrument_type_id    = iit.ie_instrument_type_id      (+) 
         ) z 
WHERE    x.source_id                  = z.source_id             (+) 
AND      x.src_instrument_type        = z.src_instrument_type   (+) 
AND      NVL(x.investment_engine,'!') = NVL(z.investment_engine (+),'!') 
GROUP BY x.basis 
        ,x.as_of_date 
        ,x.investment_engine 
        ,x.source 
        ,x.fund 
        ,x.strategy 
        ,NVL(z.ie_instrument_type,z.src_instrument_type) ;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

