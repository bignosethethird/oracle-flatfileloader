------------------------------------------------------------------------------
-- $Header: vcr/views/vw_prm_position_latest.sql 1.8 2005/08/22 17:46:25BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_PRM_POSITION_LATEST
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:55
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_prm_position_latest.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_PRM_POSITION_LATEST

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_PRM_POSITION_LATEST (
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
p.*
FROM vw_prm_position_all p,
     (SELECT source_name, basis, MAX(as_of_date) as_of_date FROM vw_source_load_run_status GROUP BY source_name, basis) latest
WHERE p.as_of_date = latest.as_of_date
AND   p.source_name = latest.source_name
AND   p.basis = latest.basis
;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

