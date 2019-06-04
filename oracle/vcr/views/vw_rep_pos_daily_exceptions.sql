------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_pos_daily_exceptions.sql 1.4 2005/08/22 17:46:42BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_POS_DAILY_EXCEPTIONS
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:56
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_pos_daily_exceptions.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_POS_DAILY_EXCEPTIONS

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_POS_DAILY_EXCEPTIONS (
  SOURCE
, AS_OF_DATE
, BASIS
, FUND
, STRATEGY
, INVESTMENT_ENGINE
, INSTRUMENT_TYPE
, TOTAL_DAILY_POSITION
) as 
SELECT    x.source 
         ,x.as_of_date 
         ,x.basis 
         ,x.fund 
         ,x.strategy 
         ,x.investment_engine 
         ,NVL(z.ie_instrument_type,z.src_instrument_type) instrument_type 
         ,COUNT(*)                                        total_daily_position 
FROM     (SELECT   s.source_name    source 
                  ,sp.as_of_date 
                  ,sp.basis 
                  ,sp.fund 
                  ,sp.strategy 
                  ,sp.instrument_type src_instrument_type 
                  ,sf.ie_id           investment_engine 
                  ,sp.source_id 
          FROM     source_position                 sp 
                  ,source                          s 
                  ,source_fund                     sf 
          WHERE               (sp.source_id,sp.as_of_date,sp.basis,sp.key,sp.seq_id) 
                   IN (SELECT  le.source_id,le.as_of_date,le.basis,le.key,le.seq_id 
                       FROM    limit_exception le 
                       WHERE   sp.source_id  = le.source_id 
                       AND     sp.as_of_date = le.as_of_date 
                       AND     sp.basis      = le.basis 
                       AND     sp.key        = le.key 
                       AND     sp.seq_id     = le.seq_id 
                      ) 
          AND      sp.fund            = sf.fund 
          AND      sp.source_id       = sf.source_id 
          AND      sp.source_id       = s.source_id 
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

