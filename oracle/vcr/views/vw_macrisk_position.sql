------------------------------------------------------------------------------
-- $Header: vcr/views/vw_macrisk_position.sql 1.9 2005/10/18 17:42:19BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_MACRISK_POSITION
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:54
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_macrisk_position.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_MACRISK_POSITION

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_MACRISK_POSITION (
  AS_OF_DATE
, SOURCE_NAME
, BASIS
, KNOWLEDGE_DATE
, RELEASED_ON
, INVESTMENT_ENGINE
, FUND
, STRATEGY
, SUB_STRATEGY
, COUNTRY
, INSTRUMENT
, INSTRUMENT_ID
, CURRENCY
, POSITION_SIGN
, ISIN
, CUSIP
, SEDOL
, BLOOMBERG_ID
, REPORTING_CURRENCY
, INSTRUMENT_TYPE
, INDUSTRY_CLASSIFICATION
, INDUSTRY_GROUP
, INDUSTRY
, SECTOR
, REGION
, YIELD_CURVE_NAME
, MARKET_INDEX_NAME
, MARKET_NAME
, YIELD_CURVE_TYPE
, ISSUER_NAME
, RATING_BLOOMBERG
, RATING_MOODY
, RATING_SP
, RATING_CATEGORY
, ASSET_CLASS
, MATURITY_BUCKET
, MATURITY_BUCKET_DETAIL
, UNDERLYING_INSTRUMENT
, UNDERLYING_BASE_INSTRUMENT
, UNDERLYING_SWAP_TENOR
, PRICE_SOURCE
, BROKER
, FUTURES_CATEGORY
, MATURITY_DATE
, STRIKE
, CALL_PUT
, EXPIRATION_DATE
, OPTION_MULTIPLYER
, FIRST_CALL_OR_PUT_DATE
, COUNTERPARTY
, BASIS_SWAP_INDEX_PAY
, BASIS_SWAP_INDEX_RECEIVE
, BID_FLOATING_RATE_SWAP
, ASK_FLOATING_RATE_SWAP
, FUTURE_CONTRACT_VALUE
, INSTRUMENT_PRICE_LOCAL
, INSTRUMENT_UNIT_COST_LOCAL
, INSTRUMENT_PRICE
, INSTRUMENT_VALUE
, TOTAL_PNL_DAILY
, TOTAL_PNL_MTD
, TOTAL_PNL_YTD
, TOTAL_INCOME_DAILY
, TOTAL_INCOME_MTD
, TOTAL_INCOME_YTD
, UNREALISED_DIVIDENDS_DAILY
, UNREALISED_DIVIDENDS_MTD
, UNREALISED_DIVIDENDS_YTD
, UNREALISED_ACC_INTEREST_DAILY
, UNREALISED_ACC_INTEREST_MTD
, UNREALISED_ACC_INTEREST_YTD
, REALISED_DIVIDENDS_DAILY
, REALISED_DIVIDENDS_MTD
, REALISED_DIVIDENDS_YTD
, REALISED_ACC_INTEREST_DAILY
, REALISED_ACC_INTEREST_MTD
, REALISED_ACC_INTEREST_YTD
, TOTAL_MTM_DAILY
, TOTAL_MTM_MTD
, TOTAL_MTM_YTD
, TOTAL_FX_DAILY
, TOTAL_FX_MTD
, TOTAL_FX_YTD
, TOTAL_MISC_REV_EXP_DAILY
, TOTAL_MISC_REV_EXP_MTD
, TOTAL_MISC_REV_EXP_YTD
, REALISED_MTM_DAILY
, REALISED_MTM_MTD
, REALISED_MTM_YTD
, REALISED_FX_DAILY
, REALISED_FX_MTD
, REALISED_FX_YTD
, UNREALISED_MTM_DAILY
, UNREALISED_MTM_MTD
, UNREALISED_MTM_YTD
, UNREALISED_FX_DAILY
, UNREALISED_FX_MTD
, UNREALISED_FX_YTD
, LOCAL_MARKET_VALUE
, DATE_OF_PRICE
, BB_DATE_OF_PRICE
, BID
, ASK
, LAST
, SHARES_OUTSTANDING
, MARKET_CAPITALISATION
, VOLUME
, BID_SIZE
, ASK_SIZE
, DAILY_TRADES
, DAILY_TURNOVERS
, FX_RATE
, DELTA
, UNDERLYING_PRICE
, UNMAPPED_ATTRIBUTES
, KEY
, SEQ_ID
, TAX_LOT_ID
, TRANSACTION_ID
, INSTRUMENT_HOLDING
, NOMINAL_AMOUNT
, BEG_BOOK_ACC_INTEREST
, BOOK_COUPON
, BOOK_UNREALISED_INCOME
, END_LOCAL_COST
, POS_ADJUSTED_DELTA
, DELTA_VALUE_K
, FILENAME
, ISO_COUNTRY_CODE
, ISO_CURRENCY_CODE
, IE_INSTRUMENT_TYPE
, EXPOSURE
,total_income_mtd_local
,yield_to_maturity
,modified_duration
,yield_to_worst
,rule_144a
,private_placement
,rating_fitch
,current_yield
,interest_rate
,accrued_interest_local_hy
,accrued_interest_hy
,loan_identifier_hy
,loan_effective_date_hy
,instrument_price_change_hy
,instrument_value_change_hy
,paid_interest_hy
,total_committed_amount_hy
,total_funded_amount_hy
,base_rate_hy
,spread_rate_hy
,paid_fees_hy
,accrued_instrument_fees_hy
,instrument_cost_value_hy
) as 
SELECT 
p.as_of_date,
p.source_name,
p.basis,
p.knowledge_date,
p.released_on,
p.investment_engine,
p.fund,
p.strategy,
p.sub_strategy,
p.country,
p.instrument,
p.instrument_id,
p.currency,
p.position_sign,
p.isin, 
p.cusip, 
p.sedol, 
p.bloomberg_id, 
p.reporting_currency, 
p.instrument_type,
p.industry_classification, 
p.industry_group, 
p.industry, 
p.sector, 
p.region, 
p.yield_curve_name, 
p.market_index_name, 
p.market_name, 
p.yield_curve_type, 
p.issuer_name, 
p.rating_bloomberg, 
p.rating_moody, 
p.rating_sp, 
p.rating_category, 
p.asset_class, 
p.maturity_bucket, 
p.maturity_bucket_detail, 
p.underlying_instrument, 
p.underlying_base_instrument, 
p.underlying_swap_tenor, 
p.price_source, 
p.broker, 
p.futures_category, 
p.maturity_date, 
p.strike, 
p.call_put, 
p.expiration_date, 
p.option_multiplyer, 
p.first_call_or_put_date, 
p.counterparty, 
p.basis_swap_index_pay, 
p.basis_swap_index_receive, 
p.bid_floating_rate_swap, 
p.ask_floating_rate_swap, 
p.future_contract_value, 
p.instrument_price_local, 
p.instrument_unit_cost_local, 
p.instrument_price, 
p.instrument_value,
p.total_pnl_daily, 
p.total_pnl_mtd, 
p.total_pnl_ytd,
p.total_income_daily,
p.total_income_mtd,
p.total_income_ytd, 
p.unrealised_dividends_daily,
p.unrealised_dividends_mtd,
p.unrealised_dividends_ytd,
p.unrealised_acc_interest_daily,
p.unrealised_acc_interest_mtd,
p.unrealised_acc_interest_ytd, 
p.realised_dividends_daily,
p.realised_dividends_mtd,
p.realised_dividends_ytd, 
p.realised_acc_interest_daily,
p.realised_acc_interest_mtd,
p.realised_acc_interest_ytd, 
p.total_mtm_daily,
p.total_mtm_mtd,
p.total_mtm_ytd,
p.total_fx_daily,
p.total_fx_mtd,
p.total_fx_ytd,
p.total_misc_rev_exp_daily,
p.total_misc_rev_exp_mtd,
p.total_misc_rev_exp_ytd,
p.realised_mtm_daily,
p.realised_mtm_mtd,
p.realised_mtm_ytd,
p.realised_fx_daily,
p.realised_fx_mtd,
p.realised_fx_ytd,
p.unrealised_mtm_daily,
p.unrealised_mtm_mtd,
p.unrealised_mtm_ytd,
p.unrealised_fx_daily,
p.unrealised_fx_mtd,
p.unrealised_fx_ytd,
p.local_market_value,
p.date_of_price, 
p.bb_date_of_price, 
p.bid, 
p.ask, 
p.last, 
p.shares_outstanding, 
p.market_capitalisation, 
p.volume, 
p.bid_size, 
p.ask_size, 
p.daily_trades, 
p.daily_turnovers, 
p.fx_rate,
p.delta, 
p.underlying_price, 
p.unmapped_attributes,
p.key,
p.seq_id,
p.tax_lot_id,
p.transaction_id,
p.instrument_holding,
p.nominal_amount,
p.beg_book_acc_interest,
p.book_coupon,
p.book_unrealised_income,
p.end_local_cost,
p.pos_adjusted_delta,
p.delta_value_k,
p.filename,
cou.iso_country_code2 iso_country_code,
cur.iso_currency_code,
sieit.ie_instrument_type,
p.exposure,
p.total_income_mtd_local,
p.yield_to_maturity,
p.modified_duration,
p.yield_to_worst,
p.rule_144a,
p.private_placement,
p.rating_fitch,
p.current_yield,
p.interest_rate,
p.accrued_interest_local_hy,
p.accrued_interest_hy,
p.loan_identifier_hy,
p.loan_effective_date_hy,
p.instrument_price_change_hy,
p.instrument_value_change_hy,
p.paid_interest_hy,
p.total_committed_amount_hy,
p.total_funded_amount_hy,
p.base_rate_hy,
p.spread_rate_hy,
p.paid_fees_hy,
p.accrued_instrument_fees_hy,
p.instrument_cost_value_hy
FROM
(    
     SELECT 
     p.source_id,
     p.as_of_date,
     f.source_name,
     p.basis,
     slrf.reporting_date knowledge_date,
     f.released_on,
     f.ie_id investment_engine,
     p.fund,
     p.strategy,
     p.sub_strategy,
     p.country,
     p.instrument,
     p.instrument_id,
     p.currency,
     p.position_sign,
     p.isin, 
     p.cusip, 
     p.sedol, 
     p.bloomberg_id, 
     p.reporting_currency, 
     p.instrument_type,
     p.industry_classification, 
     p.industry_group, 
     p.industry, 
     p.sector, 
     p.region, 
     p.yield_curve_name, 
     p.market_index_name, 
     p.market_name, 
     p.yield_curve_type, 
     p.issuer_name, 
     p.rating_bloomberg, 
     p.rating_moody, 
     p.rating_sp, 
     p.rating_category, 
     p.asset_class, 
     p.maturity_bucket, 
     p.maturity_bucket_detail, 
     p.underlying_instrument, 
     p.underlying_base_instrument, 
     p.underlying_swap_tenor, 
     p.price_source, 
     p.broker, 
     p.futures_category, 
     p.maturity_date, 
     p.strike, 
     p.call_put, 
     p.expiration_date, 
     p.option_multiplyer, 
     p.first_call_or_put_date, 
     p.counterparty, 
     p.basis_swap_index_pay, 
     p.basis_swap_index_receive, 
     p.bid_floating_rate_swap, 
     p.ask_floating_rate_swap, 
     p.future_contract_value, 
     p.instrument_price_local, 
     p.instrument_unit_cost_local, 
     p.instrument_price, 
     p.instrument_value,
     p.total_pnl_daily, 
     p.total_pnl_mtd, 
     p.total_pnl_ytd,
     p.total_income_daily,
     p.total_income_mtd,
     p.total_income_ytd, 
     p.unrealised_dividends_daily,
     p.unrealised_dividends_mtd,
     p.unrealised_dividends_ytd,
     p.unrealised_acc_interest_daily,
     p.unrealised_acc_interest_mtd,
     p.unrealised_acc_interest_ytd, 
     p.realised_dividends_daily,
     p.realised_dividends_mtd,
     p.realised_dividends_ytd, 
     p.realised_acc_interest_daily,
     p.realised_acc_interest_mtd,
     p.realised_acc_interest_ytd, 
     p.total_mtm_daily,
     p.total_mtm_mtd,
     p.total_mtm_ytd,
     p.total_fx_daily,
     p.total_fx_mtd,
     p.total_fx_ytd,
     p.total_misc_rev_exp_daily,
     p.total_misc_rev_exp_mtd,
     p.total_misc_rev_exp_ytd,
     p.realised_mtm_daily,
     p.realised_mtm_mtd,
     p.realised_mtm_ytd,
     p.realised_fx_daily,
     p.realised_fx_mtd,
     p.realised_fx_ytd,
     p.unrealised_mtm_daily,
     p.unrealised_mtm_mtd,
     p.unrealised_mtm_ytd,
     p.unrealised_fx_daily,
     p.unrealised_fx_mtd,
     p.unrealised_fx_ytd,
     p.local_market_value,
     p.date_of_price, 
     p.bb_date_of_price, 
     p.bid, 
     p.ask, 
     p.last, 
     p.shares_outstanding, 
     p.market_capitalisation, 
     p.volume, 
     p.bid_size, 
     p.ask_size, 
     p.daily_trades, 
     p.daily_turnovers, 
     p.fx_rate,
     p.delta, 
     p.underlying_price, 
     p.unmapped_attributes,
     p.key,
     p.seq_id,
     p.tax_lot_id,
     p.transaction_id,
     p.instrument_holding, 
     p.nominal_amount,
  	 p.beg_book_acc_interest,
  	 p.book_coupon,
  	 p.book_unrealised_income,
  	 p.end_local_cost,
     p.pos_adjusted_delta,
     p.delta_value_k,
     slrf.filename,
     p.exposure,
     p.total_income_mtd_local,
     p.yield_to_maturity,
     p.modified_duration,
     p.yield_to_worst,
     p.rule_144a,
     p.private_placement,
     p.rating_fitch,
     p.current_yield,
     p.interest_rate,
     p.accrued_interest_local_hy,
     p.accrued_interest_hy,
     p.loan_identifier_hy,
     p.loan_effective_date_hy,
     p.instrument_price_change_hy,
     p.instrument_value_change_hy,
     p.paid_interest_hy,
     p.total_committed_amount_hy,
     p.total_funded_amount_hy,
     p.base_rate_hy,
     p.spread_rate_hy,
     p.paid_fees_hy,
     p.accrued_instrument_fees_hy,
     p.instrument_cost_value_hy
     FROM source_position p, 
          (
            SELECT slr_fund.ie_id, slr_fund.as_of_date, slr_fund.basis, slr_fund.source_id, slr_fund.fund, sfr.released_on, s.source_name
            FROM 
            (
              SELECT sf.ie_id, slr.as_of_date, slr.basis, slr.source_id, sf.fund, sf.source_fund_id, MAX(slr.load_run_id) load_run_id
              FROM   source_fund_release sfr, source_load_run slr, source_fund sf
              WHERE  sfr.load_run_id    = slr.load_run_id
              AND    slr.status         = 'COM'
              AND    sf.source_fund_id  = sfr.source_fund_id
              AND    sf.ie_id           IN ('RMF','Glenwood','HFV')
              GROUP BY sf.ie_id, slr.as_of_date, slr.source_id, slr.basis, sf.fund, sf.source_fund_id
            ) slr_fund,
            source_fund_release sfr,
            source s
            WHERE sfr.load_run_id    = slr_fund.load_run_id
            AND   sfr.source_fund_id = slr_fund.source_fund_id
            AND   sfr.released_on IS NOT NULL
            AND   slr_fund.source_id = s.source_id                   
          ) f, -- list of released funds for MACrisk
          source_load_run_file slrf
     WHERE p.as_of_date = f.as_of_date
     AND   p.source_id  = f.source_id
     AND   p.basis      = f.basis
     AND   p.fund       = f.fund
     AND   p.load_run_id = slrf.load_run_id
     AND   p.file_id     = slrf.file_id
     AND   p.file_type   = slrf.file_type
 ) p,  
 (
     SELECT sit.source_id, sit.instrument_type, sieit.source_instrument_type_id, ieit.ie_instrument_type
     FROM   source_ie_ins_type sieit, source_instrument_type sit, ie_instrument_type ieit
     WHERE  sieit.ie_instrument_type_id   = ieit.ie_instrument_type_id
     AND    sit.source_instrument_type_id = sieit.source_instrument_type_id
     AND    ieit.ie_id                    IN ('RMF','Glenwood','HFV')
 ) sieit,
 source_currency cur, 
 (                
     SELECT cou.country, cou.source_id, icc.iso_country_code2
     FROM   source_country cou, iso_country_code icc
     WHERE  cou.iso_country_code = icc.iso_country_code3 (+)
 ) cou
 WHERE p.instrument_type                = sieit.instrument_type (+)
 AND   p.source_id                      = sieit.source_id (+)
 AND   p.country                        = cou.country (+)
 AND   p.source_id                      = cou.source_id (+)
 AND   p.currency                       = cur.currency (+)
 AND   p.source_id                      = cur.source_id (+)
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

