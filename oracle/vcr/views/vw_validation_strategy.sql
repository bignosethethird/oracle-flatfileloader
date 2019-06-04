------------------------------------------------------------------------------
-- $Header: vcr/views/vw_validation_strategy.sql 1.2.1.6 2005/08/22 17:46:46BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_VALIDATION_STRATEGY
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:58
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_validation_strategy.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_VALIDATION_STRATEGY

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_VALIDATION_STRATEGY (
  SOURCE_ID
, AS_OF_DATE
, BASIS
, KEY
, SEQ_ID
, SOURCE_STRATEGY_ID
, IE_ID
, ME_STRATEGY_ID
, SOURCE_FUND_ID
, SOURCE_BROKER_ID
, SOURCE_INSTRUMENT_TYPE_ID
, SUB_STRATEGY
, CURRENCY
, INSTRUMENT
, INSTRUMENT_ID
, INSTRUMENT_HOLDING
, INSTRUMENT_PRICE_LOCAL
, INSTRUMENT_VALUE
, TOTAL_PNL_MTD
, TOTAL_PNL_DAILY
, IE_INSTRUMENT_TYPE_ID
, BB_PRICE
, REF_NOTIONAL
, REF_MTD_ROR
, MTD_ROR
, MTD_ROR_ERROR
, REF_NOTIONAL_AOD
, REF_MTD_ROR_AOD
) as 
select sp.source_id,
sp.as_of_date, 
sp.basis, 
null key,
null seq_id,
(
  SELECT ss.source_strategy_id 
  FROM   source_strategy ss
  WHERE  ss.source_id = sp.source_id 
  AND    ss.fund = sp.fund
  AND    ss.strategy = sp.strategy
) source_strategy_id, 
(
  SELECT sf.ie_id 
  FROM   source_fund sf 
  WHERE  sf.source_id = sp.source_id 
  AND    sf.fund = sp.fund
) ie_id,
(
  SELECT ss.me_strategy_id 
  FROM   source_strategy ss
  WHERE  ss.source_id = sp.source_id 
  AND    ss.fund = sp.fund
  AND    ss.strategy = sp.strategy
) me_strategy_id,
(
  SELECT sf.source_fund_id 
  FROM   source_fund sf 
  WHERE  sf.source_id = sp.source_id 
  AND    sf.fund = sp.fund
) source_fund_id,
null source_broker_id,
null source_instrument_type_id, 
null sub_strategy,
null currency,
null instrument,
null instrument_id,
null instrument_holding,
null instrument_price_local,
sum(sp.instrument_value) instrument_value,
sum(sp.total_pnl_mtd) total_pnl_mtd,
sum(sp.total_pnl_daily) total_pnl_daily,
null ie_instrument_type_id, 
null bb_price, 
(
  select rmv.value
  from   ref_measure_value rmv, source_strategy ss
  where  rmv.measure = 'NOTIONAL'
  and    rmv.as_of_date = sp.as_of_date
  and    ss.fund        = sp.fund
  and    ss.strategy    = sp.strategy
  and    ss.source_id   = sp.source_id
  and    ss.me_strategy_id  = rmv.ref_object_id
) ref_notional, 
(
  select rmv.value
  from   ref_measure_value rmv, source_strategy ss
  where  rmv.measure = 'MTDROR'
  and    rmv.as_of_date = sp.as_of_date
  and    ss.fund        = sp.fund
  and    ss.strategy    = sp.strategy
  and    ss.source_id   = sp.source_id
  and    ss.me_strategy_id  = rmv.ref_object_id
) ref_mtd_ror, 
(
  select cmr.value 
  from   calculated_mtd_ror cmr, source_strategy ss
  where  cmr.source_id = sp.source_id
  and    cmr.as_of_date = sp.as_of_date
  and    cmr.basis = sp.basis
  and    cmr.source_object_id = ss.source_strategy_id
  and    cmr.source_object_type = 'STRATEGY'
  AND    ss.fund                = sp.fund
  AND    ss.strategy            = sp.strategy
  and    ss.source_id           = sp.source_id
) mtd_ror, 
(
  select cmr.calculation_error 
  from   calculated_mtd_ror cmr, source_strategy ss
  where  cmr.source_id = sp.source_id
  and    cmr.as_of_date = sp.as_of_date
  and    cmr.basis = sp.basis
  and    cmr.source_object_id = ss.source_strategy_id
  and    cmr.source_object_type = 'STRATEGY'
  AND    ss.fund                = sp.fund
  AND    ss.strategy            = sp.strategy
  and    ss.source_id           = sp.source_id
) mtd_ror_error, 
(
  select rmv.actual_as_of_date
  from   ref_measure_value rmv, source_strategy ss
  where  rmv.measure = 'NOTIONAL'
  and    rmv.as_of_date = sp.as_of_date
  and    ss.fund        = sp.fund
  and    ss.strategy    = sp.strategy
  and    ss.source_id   = sp.source_id
  and    ss.me_strategy_id  = rmv.ref_object_id
) ref_notional_aod,  
(
  select rmv.actual_as_of_date
  from   ref_measure_value rmv, source_strategy ss
  where  rmv.measure = 'MTDROR'
  and    rmv.as_of_date = sp.as_of_date
  and    ss.fund        = sp.fund
  and    ss.strategy    = sp.strategy
  and    ss.source_id   = sp.source_id
  and    ss.me_strategy_id  = rmv.ref_object_id
) ref_mtd_ror_aod
from  source_position sp
group by sp.source_id, sp.as_of_date, sp.basis, sp.fund, sp.strategy
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

