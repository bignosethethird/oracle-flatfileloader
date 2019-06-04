------------------------------------------------------------------------------
-- $Header: vcr/views/vw_prm_position_all.sql 1.9 2005/09/30 10:44:02BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_PRM_POSITION_ALL
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_prm_position_all.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_PRM_POSITION_ALL

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_PRM_POSITION_ALL (
  KEY
, ACCOUNTING_PERIOD
, SOURCE_ID
, SOURCE_NAME
, AS_OF_DATE
, BASIS
, POSITION_SIGN
, FUND
, STRATEGY
, SUB_STRATEGY
, INSTRUMENT_TYPE
, INSTRUMENT_ID
, INSTRUMENT
, CURRENCY
, COUNTRY
, TRANSACTION_ID
, ISIN
, CUSIP
, SEDOL
, BLOOMBERG_ID
, REPORTING_CURRENCY
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
, INSTRUMENT_HOLDING
, INSTRUMENT_PRICE_LOCAL
, INSTRUMENT_UNIT_COST_LOCAL
, INSTRUMENT_PRICE
, INSTRUMENT_VALUE
, TOTAL_PNL
, TOTAL_INCOME
, UNREALISED_DIVIDENDS
, UNREALISED_ACC_INTEREST
, REALISED_DIVIDENDS
, REALISED_ACC_INTEREST
, TOTAL_MTM
, TOTAL_FX
, TOTAL_MISC_REV_EXP
, REALISED_MTM
, REALISED_FX
, UNREALISED_MTM
, UNREALISED_FX
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
, NOMINAL_AMOUNT
, DELTA
, UNDERLYING_PRICE
, UNMAPPED_ATTRIBUTES
, BEG_BOOK_ACC_INTEREST
, BOOK_COUPON
, BOOK_UNREALISED_INCOME
, END_LOCAL_COST
) as 
SELECT
p.key,
p.accounting_period,
p.source_id,
p.source_name,
p.as_of_date,
p.basis,
p.position_sign,
p.fund,
p.strategy,
p.sub_strategy,
nvl(sieit.ie_instrument_type, p.instrument_type) instrument_type,
p.instrument_id,
p.instrument,
nvl(cur.iso_currency_code, p.currency) currency,
nvl(cou.iso_country_code2, p.country) country,
p.transaction_id,
p.isin,
p.cusip,
p.sedol,
p.bloomberg_id,
p.reporting_currency,
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
p.instrument_holding,
p.instrument_price_local,
p.instrument_unit_cost_local,
p.instrument_price,
p.instrument_value,
p.total_pnl,
p.total_income,
p.unrealised_dividends,
p.unrealised_acc_interest,
p.realised_dividends,
p.realised_acc_interest,
p.total_mtm,
p.total_fx,
p.total_misc_rev_exp,
p.realised_mtm,
p.realised_fx,
p.unrealised_mtm,
p.unrealised_fx,
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
p.nominal_amount,
p.delta,
p.underlying_price,
p.unmapped_attributes,
p.beg_book_acc_interest,
p.book_coupon,
p.book_unrealised_income,
p.end_local_cost
FROM
(
     SELECT
     p.position_sign,
     p.isin,
     p.cusip,
     p.sedol,
     p.bloomberg_id,
     p.reporting_currency,
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
     p.source_id,
     ap.period accounting_period,
     slrs.source_name,
     p.as_of_date,
     p.basis,
     p.fund,
     p.sub_strategy,
     p.instrument_id,
     p.strategy,
     p.key,
     p.instrument,
     p.currency,
     p.country,
     p.transaction_id,
     decode(ap.period, 'DAILY', p.total_pnl_daily, 'MTD', p.total_pnl_mtd, 'YTD', p.total_pnl_ytd) total_pnl,
     decode(ap.period, 'DAILY', p.total_income_daily, 'MTD', p.total_income_mtd, 'YTD', p.total_income_ytd) total_income,
     decode(ap.period, 'DAILY', p.unrealised_dividends_daily, 'MTD', p.unrealised_dividends_mtd, 'YTD', p.unrealised_dividends_ytd) unrealised_dividends,
     decode(ap.period, 'DAILY', p.unrealised_acc_interest_daily, 'MTD', p.unrealised_acc_interest_mtd, 'YTD', p.unrealised_acc_interest_ytd) unrealised_acc_interest,
     decode(ap.period, 'DAILY', p.realised_dividends_daily, 'MTD', p.realised_dividends_mtd, 'YTD', realised_dividends_ytd) realised_dividends,
     decode(ap.period, 'DAILY', p.realised_acc_interest_daily, 'MTD', p.realised_acc_interest_mtd, 'YTD', p.realised_acc_interest_ytd) realised_acc_interest,
     decode(ap.period, 'DAILY', p.total_mtm_daily, 'MTD', p.total_mtm_mtd, 'YTD', p.total_mtm_ytd) total_mtm,
     decode(ap.period, 'DAILY', p.total_fx_daily, 'MTD', p.total_fx_mtd, 'YTD', p.total_fx_ytd) total_fx,
     decode(ap.period, 'DAILY', p.total_misc_rev_exp_daily, 'MTD', p.total_misc_rev_exp_mtd, 'YTD', p.total_misc_rev_exp_ytd) total_misc_rev_exp,
     decode(ap.period, 'DAILY', p.realised_mtm_daily, 'MTD', p.realised_mtm_mtd, 'YTD', p.realised_mtm_ytd) realised_mtm,
     decode(ap.period, 'DAILY', p.realised_fx_daily, 'MTD', p.realised_fx_mtd, 'YTD', p.realised_fx_ytd) realised_fx,
     decode(ap.period, 'DAILY', p.unrealised_mtm_daily, 'MTD', p.unrealised_mtm_mtd, 'YTD', p.unrealised_mtm_ytd) unrealised_mtm,
     decode(ap.period, 'DAILY', p.unrealised_fx_daily, 'MTD', p.unrealised_fx_mtd, 'YTD', p.unrealised_fx_ytd) unrealised_fx,
     p.instrument_holding,
     p.instrument_value,
     p.local_market_value,
     p.nominal_amount,
     p.instrument_type,
     decode(ap.period, 'DAILY', p.beg_book_acc_interest, 'MTD', p.beg_book_acc_interest_mtd, 'YTD', p.beg_book_acc_interest_ytd) beg_book_acc_interest,
     decode(ap.period, 'DAILY', p.book_coupon, 'MTD', p.book_coupon_mtd, 'YTD', p.book_coupon_ytd) book_coupon,
	   decode(ap.period, 'DAILY', p.book_unrealised_income, 'MTD', p.book_unrealised_income_mtd, 'YTD', p.book_unrealised_income_ytd) book_unrealised_income,
	   decode(ap.period, 'DAILY', p.end_local_cost, 'MTD', p.end_local_cost_mtd, 'YTD', p.end_local_cost_ytd) end_local_cost
     FROM source_position p,
          source_fund f,
          (SELECT 'DAILY' period FROM DUAL UNION SELECT 'MTD' period FROM DUAL UNION SELECT 'YTD' period FROM DUAL) ap,
          vw_source_load_run_status slrs
     WHERE f.ie_id           = 'MGS'
     AND   f.source_id       = p.source_id
     AND   f.fund            = p.fund
     AND   slrs.source_id    = p.source_id
     AND   slrs.as_of_date   = p.as_of_date
     AND   slrs.basis        = p.basis
     AND   slrs.status       = 'A'
 ) p,
 (
     SELECT sit.source_id, sit.instrument_type, sieit.source_instrument_type_id, ieit.ie_instrument_type
     FROM   source_ie_ins_type sieit, source_instrument_type sit, ie_instrument_type ieit
     WHERE  sieit.ie_instrument_type_id   = ieit.ie_instrument_type_id
     AND    sit.source_instrument_type_id = sieit.source_instrument_type_id
     AND    ieit.ie_id                    = 'MGS'
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

