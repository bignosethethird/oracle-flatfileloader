CREATE OR REPLACE PACKAGE BODY vcr.pkg_source_position
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_source_position.plb 1.1.1.7 2005/10/07 10:57:12BST apenney DEV  $
--------------------------------------------------------------------------
-- Provides routines to query source positions
AS
  -- returns list of positions for the following parameters
  -- 
  FUNCTION get_list(p_source_id             IN source_position.source_id%TYPE,
                    p_as_of_date            IN source_position.as_of_date%TYPE,
                    p_basis                 IN source_position.basis%TYPE,
                    p_load_run_id           IN source_position.load_run_id%TYPE DEFAULT NULL,
                    p_ie_id                 IN source_fund.ie_id%TYPE DEFAULT NULL,
                    p_fund                  IN source_position.fund%TYPE DEFAULT NULL,
                    p_strategy              IN source_position.strategy%TYPE DEFAULT NULL,
                    p_sub_strategy          IN source_position.sub_strategy%TYPE DEFAULT NULL,
                    p_ie_platform           IN source_fund.ie_platform%TYPE DEFAULT NULL,
                    p_instrument_type       IN source_position.instrument_type%TYPE DEFAULT NULL,
                    p_instrument_id         IN source_position.instrument_id%TYPE DEFAULT NULL,
                    p_instrument            IN source_position.instrument%TYPE DEFAULT NULL,
                    p_broker                IN source_position.broker%TYPE DEFAULT NULL,
                    p_key                   IN source_position.key%TYPE DEFAULT NULL,
                    p_seq_id                IN source_position.seq_id%TYPE DEFAULT NULL) RETURN utl.global.t_result_set
  AS
    cur_position_list utl.global.t_result_set;
    
    v_as_of_date      varchar2(11);
    v_last_as_of_date varchar2(11);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_position.get_list',null);
 
    v_as_of_date       := to_char(p_as_of_date,'dd-MON-yyyy');

    SELECT to_char(MAX(slr.as_of_date),'dd-MON-yyyy')
    INTO   v_last_as_of_date
    FROM   source_load_run slr
    WHERE  slr.source_id     = p_source_id
    AND    slr.basis         = p_basis
    AND    slr.as_of_date    < p_as_of_date
    AND    slr.status        = pkg_source_load_run.gc_run_status_complete;
    
    OPEN   cur_position_list
    FOR
    SELECT /*+ FIRST_ROWS */ 
           sp.fund,
           sp.strategy,
           sp.sub_strategy,
           sp.instrument_id,
           sp.instrument,
           sp.broker,
           sp.instrument_type,
           sp.currency,
           to_char(sp.instrument_holding,'FM999,999,999,999,990.00'),
           to_char(sp.instrument_price_local,'FM999,999,999,999,990.00'),
           to_char(sp.instrument_value,'FM999,999,999,999,990.00'),
           to_char(sp.total_pnl_mtd,'FM999,999,999,999,990.00'),
           sp.key,
           sp.seq_id,
           sp.source_id,
           to_char(sp.as_of_date,'yyyy-mm-dd') as_of_date,
           sp.basis,
           slr.load_run_no,
           ie.description,
           iep.description ie_platform_description,
           sp.position_sign,
           slrf.filename,
           sp.country,
           sp.isin,
           sp.cusip,
           sp.sedol,
           sp.bloomberg_id,
           sp.reporting_currency, 
           sp.industry_classification, 
           sp.industry_group, 
           sp.industry, 
           sp.sector, 
           sp.region, 
           sp.yield_curve_name, 
           sp.market_index_name, 
           sp.market_name, 
           sp.yield_curve_type, 
           sp.issuer_name, 
           sp.rating_bloomberg, 
           sp.rating_moody, 
           sp.rating_sp, 
           sp.rating_category, 
           sp.asset_class, 
           sp.maturity_bucket, 
           sp.maturity_bucket_detail, 
           sp.underlying_instrument, 
           sp.underlying_base_instrument, 
           sp.underlying_swap_tenor, 
           sp.price_source, 
           sp.futures_category, 
           sp.maturity_date, 
           sp.strike, 
           sp.call_put, 
           sp.expiration_date, 
           to_char(sp.option_multiplyer,'FM999,999,999,999,990.00'),
           sp.first_call_or_put_date, 
           sp.counterparty, 
           sp.basis_swap_index_pay, 
           sp.basis_swap_index_receive, 
           sp.bid_floating_rate_swap, 
           sp.ask_floating_rate_swap, 
           to_char(sp.future_contract_value,'FM999,999,999,999,990.00'),
           to_char(sp.instrument_unit_cost_local,'FM999,999,999,999,990.00'),
           to_char(sp.instrument_value,'FM999,999,999,999,990.00'),
           to_char(sp.total_pnl_daily,'FM999,999,999,999,990.00'),
           to_char(sp.total_pnl_ytd,'FM999,999,999,999,990.00'),
           to_char(sp.total_income_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.total_income_mtd,'FM999,999,999,999,990.00'),
           to_char(sp.total_income_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_dividends_daily,'FM999,999,999,999,990.00'),
           to_char(sp.unrealised_dividends_mtd,'FM999,999,999,999,990.00'),
           to_char(sp.unrealised_dividends_ytd,'FM999,999,999,999,990.00'),
           to_char(sp.unrealised_acc_interest_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_acc_interest_mtd,'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_acc_interest_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_dividends_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_dividends_mtd,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_dividends_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_acc_interest_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_acc_interest_mtd,'FM999,999,999,999,990.00'), 
           to_char(sp.realised_acc_interest_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.total_mtm_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.total_mtm_mtd,'FM999,999,999,999,990.00'),
           to_char(sp.total_mtm_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.total_fx_daily,'FM999,999,999,999,990.00'), 
           to_char(sp.total_fx_mtd,'FM999,999,999,999,990.00'), 
           to_char(sp.total_fx_ytd,'FM999,999,999,999,990.00'), 
           to_char(sp.total_misc_rev_exp_daily, 'FM999,999,999,999,990.00'), 
           to_char(sp.total_misc_rev_exp_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.total_misc_rev_exp_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_mtm_daily, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_mtm_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_mtm_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_fx_daily, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_fx_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.realised_fx_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_mtm_daily, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_mtm_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_mtm_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_fx_daily, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_fx_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.unrealised_fx_ytd, 'FM999,999,999,999,990.00'), 
           sp.date_of_price, 
           sp.bb_date_of_price, 
           to_char(sp.bid, 'FM999,999,999,999,990.00'), 
           to_char(sp.ask, 'FM999,999,999,999,990.00'), 
           to_char(sp.last, 'FM999,999,999,999,990.00'), 
           sp.shares_outstanding,
           sp.market_capitalisation, 
           sp.volume,
           sp.bid_size, 
           sp.ask_size, 
           sp.daily_trades,
           sp.daily_turnovers, 
           to_char(sp.fx_rate, 'FM999,999,999,999,990.00'), 
           to_char(sp.nominal_amount, 'FM999,999,999,999,990.00'), 
           to_char(sp.delta, 'FM999,999,999,999,990.00'), 
           to_char(sp.underlying_price, 'FM999,999,999,999,990.00'), 
           sp.tax_lot_id, 
           sp.transaction_id, 
           to_char(sp.beg_book_acc_interest, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_coupon, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_unrealised_income, 'FM999,999,999,999,990.00'), 
           to_char(sp.end_local_cost, 'FM999,999,999,999,990.00'), 
           sp.invalid_type_attributes, 
           sp.unmapped_attributes,
           (
            SELECT to_char(rmv.value,'FM999,999,999,999,990.00')
            FROM   ref_measure_value rmv, source_fund sf
            WHERE  rmv.measure       = pkg_ref_object.gc_notional_vcr_type
            AND    rmv.as_of_date    = v_as_of_date
            AND    rmv.ref_object_id = sf.me_fund_id
            AND    sf.fund           = sp.fund
            AND    sf.source_id      = p_source_id
           ) notional,
           ( 
            SELECT pb.description
            FROM   prime_broker pb, source_broker sb
            WHERE  pb.prime_broker_id = sb.prime_broker_id
            AND    sb.source_id       = p_source_id
            AND    sb.broker          = sp.broker
           ) prime_broker_description, 
           (
            SELECT ieit.ie_instrument_type
            FROM   ie_instrument_type ieit, source_ie_ins_type sieit, source_instrument_type sit, source_fund sf
            WHERE  ieit.ie_instrument_type_id = sieit.ie_instrument_type_id
            AND    ieit.ie_id                 = sf.ie_id
            AND    sieit.source_instrument_type_id = sit.source_instrument_type_id
            AND    sit.source_id                   = p_source_id
            AND    sit.instrument_type             = sp.instrument_type
            AND    sf.source_id                    = p_source_id
            AND    sf.fund                         = sp.fund
           ) ie_instrument_type,
           (
            SELECT s.source_name
            FROM   source s
            WHERE  s.source_id = p_source_id
           ) source_name,
           to_char(sp.as_of_date,'dd-MON-yyyy') as_of_date_display,
           ( 
            SELECT to_char((sp.total_pnl_mtd-last_sp.total_pnl_mtd),'FM999,999,999,999,990.00')
            FROM   source_position last_sp
            WHERE  v_last_as_of_date  = last_sp.as_of_date
            AND    p_source_id        = last_sp.source_id
            AND    p_basis            = last_sp.basis
            AND    sp.key             = last_sp.key
            AND    sp.seq_id          = last_sp.seq_id
           ) daily_pnl_move,
           (SELECT to_char(pr.price,'FM999,999,999,999,990.00')
            FROM   security_price pr, source_position_security_price spsp
            WHERE  spsp.source_id  = p_source_id
            AND    spsp.as_of_date = v_as_of_date
            AND    spsp.basis      = p_basis
            AND    spsp.key        = sp.key
            AND    spsp.seq_id     = sp.seq_id
            AND    spsp.as_of_date = pr.as_of_date
            AND    spsp.request_id = pr.request_id
            AND    spsp.request_seq  = pr.request_seq
           ) price, 
           to_char(sp.pos_adjusted_delta,'FM999,999,999,999,990.00'), 
           to_char(sp.delta_value_k,'FM999,999,999,999,990.00'), 
           to_char(sp.exposure,'FM999,999,999,999,990.00'), 
           to_char(sp.total_income_mtd_local,'FM999,999,999,999,990.00'), 
           to_char(sp.yield_to_maturity,'FM999,999,999,999,990.00'), 
           sp.modified_duration,
           to_char(sp.yield_to_worst,'FM999,999,999,999,990.00'), 
           sp.rule_144a,
           sp.private_placement,
           sp.rating_fitch,
           to_char(sp.current_yield,'FM999,999,999,999,990.00'), 
           to_char(sp.interest_rate,'FM999,999,999,999,990.00'), 
           to_char(sp.beg_book_acc_interest_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_coupon_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_unrealised_income_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.end_local_cost_mtd, 'FM999,999,999,999,990.00'), 
           to_char(sp.beg_book_acc_interest_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_coupon_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.book_unrealised_income_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.end_local_cost_ytd, 'FM999,999,999,999,990.00'), 
           to_char(sp.accrued_interest_local_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.accrued_interest_hy, 'FM999,999,999,999,990.00'), 
           sp.loan_identifier_hy, 
           sp.loan_effective_date_hy, 
           to_char(sp.instrument_price_change_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.instrument_value_change_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.paid_interest_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.total_committed_amount_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.total_funded_amount_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.base_rate_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.spread_rate_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.paid_fees_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.accrued_instrument_fees_hy, 'FM999,999,999,999,990.00'), 
           to_char(sp.instrument_cost_value_hy,'FM999,999,999,999,990.00')
    FROM   source_position sp, 
           source_load_run slr,
           source_fund     sf,
           ie_platform            iep,
           investment_engine      ie,
           source_load_run_file   slrf
    WHERE  sp.as_of_date      = v_as_of_date
    AND    sp.source_id       = p_source_id
    AND    sp.basis           = p_basis
    AND    sp.load_run_id     = slr.load_run_id
    AND    sp.source_id       = sf.source_id (+)
    AND    sp.fund            = sf.fund (+)
    AND    sf.ie_platform     = iep.ie_platform (+)
    AND    sf.ie_id           = iep.ie_id (+)
    AND    sf.ie_id           = ie.ie_id (+)
    AND    sp.load_run_id     = slrf.load_run_id
    AND    sp.file_id         = slrf.file_id
    AND    sp.file_type       = slrf.file_type
    AND   ((p_load_run_id IS NULL)     OR (p_load_run_id IS NOT NULL AND sp.load_run_id = p_load_run_id))
    AND   ((p_ie_id IS NULL)           OR (p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id))
    AND   ((p_fund IS NULL)            OR (p_fund IS NOT NULL AND sp.fund = p_fund))
    AND   ((p_strategy IS NULL)        OR (p_strategy IS NOT NULL AND sp.strategy = p_strategy))
    AND   ((p_sub_strategy IS NULL)    OR (p_sub_strategy IS NOT NULL AND sp.sub_strategy LIKE p_sub_strategy))
    AND   ((p_ie_platform IS NULL)     OR (p_ie_platform IS NOT NULL AND sf.ie_platform = p_ie_platform))
    AND   ((p_instrument_type IS NULL) OR (p_instrument_type IS NOT NULL AND sp.instrument_type = p_instrument_type))
    AND   ((p_instrument_id IS NULL)   OR (p_instrument_id IS NOT NULL AND sp.instrument_id LIKE p_instrument_id))
    AND   ((p_instrument IS NULL)      OR (p_instrument IS NOT NULL AND sp.instrument LIKE p_instrument))
    AND   ((p_broker IS NULL)          OR (p_broker IS NOT NULL AND sp.broker = p_broker))
    AND   ((p_key IS NULL)             OR (p_key IS NOT NULL AND sp.key = p_key AND sp.seq_id = p_seq_id));
    
    dbms_application_info.set_module(null,null);
    
    RETURN cur_position_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_list;
  
  -- returns count of positions for the following parameters
  -- 
  FUNCTION get_count(p_source_id             IN source_position.source_id%TYPE,
                     p_as_of_date            IN source_position.as_of_date%TYPE,
                     p_basis                 IN source_position.basis%TYPE,
                     p_load_run_id           IN source_position.load_run_id%TYPE DEFAULT NULL,
                     p_ie_id                 IN source_fund.ie_id%TYPE DEFAULT NULL,
                     p_fund                  IN source_position.fund%TYPE DEFAULT NULL,
                     p_strategy              IN source_position.strategy%TYPE DEFAULT NULL,
                     p_sub_strategy          IN source_position.sub_strategy%TYPE DEFAULT NULL,
                     p_ie_platform           IN source_fund.ie_platform%TYPE DEFAULT NULL,
                     p_instrument_type       IN source_position.instrument_type%TYPE DEFAULT NULL,
                     p_instrument_id         IN source_position.instrument_id%TYPE DEFAULT NULL,
                     p_instrument            IN source_position.instrument%TYPE DEFAULT NULL,
                     p_broker                IN source_position.broker%TYPE DEFAULT NULL,
                     p_key                   IN source_position.key%TYPE DEFAULT NULL,
                     p_seq_id                IN source_position.seq_id%TYPE DEFAULT NULL) RETURN INTEGER
  AS
    v_count      INTEGER;
    
    v_as_of_date DATE;

  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_position.get_count',null);
    
    v_as_of_date := to_char(p_as_of_date,'dd-MON-yyyy');
  
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_position sp, 
           source_fund     sf
    WHERE  sp.as_of_date      = v_as_of_date
    AND    sp.source_id       = p_source_id
    AND    sp.basis           = p_basis
    AND    sp.source_id       = sf.source_id (+)
    AND    sp.fund            = sf.fund (+)
    AND   ((p_load_run_id IS NULL)     OR (p_load_run_id IS NOT NULL AND sp.load_run_id = p_load_run_id))
    AND   ((p_ie_id IS NULL)           OR (p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id))
    AND   ((p_fund IS NULL)            OR (p_fund IS NOT NULL AND sp.fund = p_fund))
    AND   ((p_strategy IS NULL)        OR (p_strategy IS NOT NULL AND sp.strategy = p_strategy))
    AND   ((p_sub_strategy IS NULL)    OR (p_sub_strategy IS NOT NULL AND sp.sub_strategy LIKE p_sub_strategy))
    AND   ((p_ie_platform IS NULL)     OR (p_ie_platform IS NOT NULL AND sf.ie_platform = p_ie_platform))
    AND   ((p_instrument_type IS NULL) OR (p_instrument_type IS NOT NULL AND sp.instrument_type = p_instrument_type))
    AND   ((p_instrument_id IS NULL)   OR (p_instrument_id IS NOT NULL AND sp.instrument_id LIKE p_instrument_id))
    AND   ((p_instrument IS NULL)      OR (p_instrument IS NOT NULL AND sp.instrument LIKE p_instrument))
    AND   ((p_broker IS NULL)          OR (p_broker IS NOT NULL AND sp.broker = p_broker))
    AND   ((p_key IS NULL)             OR (p_key IS NOT NULL AND sp.key = p_key AND sp.seq_id = p_seq_id));

    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
END pkg_source_position;
/
