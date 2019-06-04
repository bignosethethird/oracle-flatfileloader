------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_std_exception.sql 1.5 2005/08/22 17:46:43BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_STD_EXCEPTION
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:57
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_std_exception.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_STD_EXCEPTION

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_STD_EXCEPTION (
  LIMIT_ID
, RULE
, AS_OF_DATE
, VSP
, BASIS
, INVESTMENT_ENGINE
, RUN_DTTM
, RUN_ID
, RUN_NO
, FUND
, STRATEGY
, SUB_STRATEGY
, INSTRUMENT_ID
, INSTRUMENT_DESCRIPTION
, BROKER
, CURRENCY
, INSTRUMENT_TYPE
, CURRENT_QUANTITY
, CURRENT_LOCAL_PRICE
, CURRENT_BASE_MV
, CURRENT_MTD_PNL
, CURRENT_BB_PRICE
, PRIOR_QUANTITY
, PRIOR_LOCAL_PRICE
, PRIOR_BASE_MV
, PRIOR_MTD_PNL
, PRIOR_BB_PRICE
, DAILY_PNL_MV
, CURRENT_MONTH_NOTIONAL
, LIMIT_VALUE
, BREAK_VALUE
, STATUS
) as 
SELECT le.limit_id                                                         limit_id 
      ,pkg_limit.get_measure_rule_description(le.limit_id)                 rule 
      ,le.as_of_date                                                       as_of_date 
      ,s.source_name                                                       vsp 
      ,le.basis                                                            basis 
      ,NVL(ie.ie_id,'undefined')                                           investment_engine 
      ,slr.start_time                                                      run_dttm 
      ,slr.load_run_id                                                     run_id 
      ,slr.load_run_no                                                     run_no 
      ,sf.fund                                                             fund 
      ,ss.strategy                                                         strategy 
      ,le.sub_strategy                                                     sub_strategy 
      ,le.instrument_id                                                    instrument_id 
      ,le.instrument                                                       instrument_description 
      ,sb.broker                                                           broker 
      ,currency                                                            currency 
      ,type                                                                instrument_type 
      ,current_instrument_holding                                          current_quantity 
      ,current_instrument_price_local                                      current_local_price 
      ,current_instrument_value                                            current_base_mv 
      ,current_pnl_mtd                                                     current_mtd_pnl 
      ,current_bb_price                                                    current_bb_price 
      ,prior_instrument_holding                                            prior_quantity 
      ,prior_instrument_price_local                                        prior_local_price 
      ,prior_instrument_value                                              prior_base_mv 
      ,prior_pnl_mtd                                                       prior_mtd_pnl 
      ,prior_bb_price                                                      prior_bb_price 
      ,daily_pnl_change                                                    daily_pnl_mv 
      ,current_month_notional                                              current_month_notional 
      ,pkg_limit.get_version_values(le.limit_id,le.limit_version)          limit_value 
      ,CASE UPPER(type) 
          WHEN  'CALCULATION ERROR'        THEN exception_description 
          WHEN  'LIMIT BREAK'       THEN TO_CHAR(DECODE(fmt.units 
                                                       ,'PERCENTAGE',validation_measure_value * 100 
                                                       ,validation_measure_value) 
                                                ,fmt.format) 
          ELSE NULL 
       END break_value 
      ,NVL2(le.resolution_date,TO_CHAR(resolution_date,'DD/MM/RRRR HH24:MI:SS'),le.status) status 
FROM   LIMIT_EXCEPTION   le 
      ,SOURCE            s 
      ,SOURCE_LOAD_RUN   slr 
      ,SOURCE_FUND       sf 
      ,SOURCE_STRATEGY   ss 
      ,INVESTMENT_ENGINE ie 
      ,SOURCE_BROKER     sb 
      ,(SELECT l.limit_id,vm.units,vm.format 
        FROM   validation_measure vm 
              ,limit l 
        WHERE  vm.measure_id = l.measure_id ) fmt 
WHERE le.source_id          = s.source_id 
AND   le.load_run_id        = slr.load_run_id 
AND   le.source_fund_id     = sf.source_fund_id 
AND   sf.ie_id              = ie.ie_id              (+) 
AND   le.source_strategy_id = ss.source_strategy_id (+) 
AND   le.source_broker_id   = sb.source_broker_id   (+) 
AND   le.limit_id           = fmt.limit_id          (+) ;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

