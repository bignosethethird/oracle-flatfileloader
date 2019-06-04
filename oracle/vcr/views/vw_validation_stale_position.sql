------------------------------------------------------------------------------
-- $Header: vcr/views/vw_validation_stale_position.sql 1.4 2005/10/19 17:49:29BST apenney DEV  $
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_VALIDATION_STALE_POSITION

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_VALIDATION_STALE_POSITION (
  SOURCE_ID
, AS_OF_DATE
, BASIS
, KEY
, SEQ_ID
, SOURCE_FUND_ID
, IE_ID
, SOURCE_STRATEGY_ID
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
, BB_PRICE
, REF_NOTIONAL
, IE_INSTRUMENT_TYPE_ID
, CATEGORY
, stale_check_price_local
, stale_as_of_date
) as 
SELECT  sp.source_id,
        sp.as_of_date,
        sp.basis,
        sp.key,
        sp.seq_id,
        sf.source_fund_id,
        sf.ie_id,
        (
         SELECT ss.source_strategy_id
         FROM   source_strategy ss
         WHERE  sp.source_id = ss.source_id
         AND    sp.fund      = ss.fund
         AND     sp.strategy = ss.strategy
        ) source_strategy_id,
        (
         SELECT sb.source_broker_id
         FROM   source_broker sb
         WHERE  sb.source_id = sp.source_id
         AND    sb.broker    = sp.broker
        ) source_broker_id,
        sit.source_instrument_type_id,
        sp.sub_strategy,
        sp.currency,
        sp.instrument,
        sp.instrument_id,
        sp.instrument_holding,
        sp.instrument_price_local,
        sp.instrument_value,
        sp.total_pnl_mtd,
        sp.total_pnl_daily,
       (
        SELECT pr.price
        FROM   source_position_security_price spsp, security_price pr
        WHERE  spsp.as_of_date   = pr.as_of_date
        AND    spsp.request_id   = pr.request_id
        AND    spsp.request_seq  = pr.request_seq
        AND    sp.as_of_date     = spsp.as_of_date
        AND    sp.source_id      = spsp.source_id
        AND    sp.basis          = spsp.basis 
        AND    sp.key            = spsp.key   
        AND    sp.seq_id         = spsp.seq_id
       ) bb_price,
       ( 
        SELECT rmv.value
        FROM   ref_measure_value rmv, source_fund sf
        WHERE  rmv.as_of_date = sp.as_of_date
        AND    rmv.ref_object_id = sf.me_fund_id
        AND    rmv.measure = 'NOTIONAL'
        AND    sf.source_id = sp.source_id
        AND    sf.fund      = sp.fund
       ) ref_notional,
       ieit.ie_instrument_type_id,
       category,
       oldp.instrument_price_local stale_check_price_local,
       oldp.as_of_date stale_as_of_date
       FROM source_position sp, ie_instrument_type ieit, source_fund sf, source_ie_ins_type sieit, source_instrument_type sit, source_position oldp
       WHERE  sf.fund      = sp.fund
       AND    sf.source_id = sp.source_id
       AND    sf.ie_id     = ieit.ie_id
       AND    sit.source_id  = sp.source_id
       AND    sit.instrument_type = sp.instrument_type
       AND    sit.source_instrument_type_id = sieit.source_instrument_type_id
       AND    sieit.ie_instrument_type_id = ieit.ie_instrument_type_id
       AND    ieit.stale_price_period IS NOT NULL
       AND    utl.pkg_date.calc_weekday(sp.as_of_date, ieit.stale_price_period*-1) = oldp.as_of_date
       AND    sp.source_id  = oldp.source_id
       AND    sp.basis      = oldp.basis
       AND    sp.key        = oldp.key
       AND    sp.seq_id     = oldp.seq_id
;
/
