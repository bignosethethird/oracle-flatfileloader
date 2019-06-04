------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_daily_exceptions.sql 1.5 2005/10/07 13:00:05BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_DAILY_EXCEPTIONS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_daily_exceptions.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_DAILY_EXCEPTIONS

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_DAILY_EXCEPTIONS (
  BASIS
, INVESTMENT_ENGINE
, SOURCE
, FUND
, STRATEGY
, INSTRUMENT_TYPE
, AS_OF_DATE
, TOTAL_DAILY_EXCEPTIONS
) as 
SELECT    x.basis 
         ,x.investment_engine 
         ,x.SOURCE 
         ,x.fund 
         ,x.strategy          
         ,NVL(z.ie_instrument_type,z.src_instrument_type) instrument_type 
         ,x.AS_OF_DATE 
         ,COUNT(*)                                        TOTAL_DAILY_EXCEPTIONS 
FROM     (SELECT   s.source_name    source 
                  ,le.as_of_date 
                  ,le.basis 
                  ,sf.fund 
                  ,(SELECT ss.strategy FROM source_strategy ss WHERE ss.source_strategy_id = le.source_strategy_id) strategy
                  ,(SELECT sit.instrument_type FROM source_instrument_type sit WHERE sit.source_instrument_type_id = le.source_instrument_type_id) src_instrument_type
                  ,sf.ie_id           investment_engine 
                  ,le.source_id 
          FROM     limit_exception                 le 
                  ,source                          s 
                  ,source_fund                     sf 
          WHERE    le.source_fund_id  = sf.source_fund_id (+)
          AND      le.source_id       = s.source_id 
          ) x 
         ,(SELECT sit.instrument_type     src_instrument_type 
                 ,sit.source_id 
                 ,iit.ie_instrument_type 
                 ,iit.ie_id               investment_engine 
          FROM    source_instrument_type  sit 
                 ,source_ie_ins_type      siet 
                 ,ie_instrument_type      iit 
          WHERE   sit.source_instrument_type_id = siet.source_instrument_type_id (+) 
          AND     siet.ie_instrument_type_id    = iit.ie_instrument_type_id      (+) 
          ) z 
WHERE     x.source_id                  = z.source_id             (+) 
AND       x.src_instrument_type        = z.src_instrument_type   (+) 
AND       NVL(x.investment_engine,'!') = NVL(z.investment_engine (+),'!') 
GROUP BY  x.source 
         ,x.as_of_date 
         ,x.basis 
         ,x.fund 
         ,x.strategy 
         ,x.investment_engine 
         ,NVL(z.ie_instrument_type,z.src_instrument_type) ;

/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

