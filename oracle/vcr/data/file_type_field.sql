------------------------------------------------------------------------------
-- $Header: vcr/data/file_type_field.sql 1.11 2005/10/06 15:23:43BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.file_type_field.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @file_type_field.sql
-- This file was generated from database instance CPAD.
--   Database Time    : 28FEB2005 17:04:43
--   IP address       : 192.5.20.64
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : ahl64
--   O/S user         : vcr
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.file_type_field.


alter table vcr.field_target_column disable constraint fk_ftc_file_type_field; 
-- empty table:
delete from vcr.file_type_field;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- bob fields
------------------------------------------------------------------------------

insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ASK');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ASK_FLOAT_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ASK_SIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ASSET_CLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BASIS_SWAP_INDEX_PAY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BASIS_SWAP_INDEX_RECEIVE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BB_DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BID_FLOAT_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BID_SIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BLOOMBERG_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','BROKER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','CALLPUT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','CALL_PUT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','COUNTERPARTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','COUNTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','CUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','DAILY_TRADES');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','DAILY_TURNOVERS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','DELTA');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','EXPIRATION_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','FIRST_CALL_OR_PUT_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','FUND');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','FUTURES_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','FUTURE_CONTRACT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','FX_RATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INDUSTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INDUSTRY_CLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INDUSTRY_GROUP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_HOLDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_PRICE_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_TYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_UNIT_COST_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','INSTRUMENT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','ISSUER_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','LAST');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','LOCAL_MARKET_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MARKET_CAPITALIZATION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MARKET_INDEX_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MARKET_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MATURITY_BUCKET');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MATURITY_BUCKET_DETAIL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','MATURITY_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','NOMINAL_AMOUNT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','OPTION_MULTIPLIER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','POSITION_SIGN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','PRICE_SOURCE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','RATING_-_BLOOMBERG');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','RATING_-_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','RATING_-_MOODY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','RATING_-_S_P');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_DIVIDENDS-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_DIVIDENDS-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_DIVIDENDS-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_FX-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_FX-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_FX-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_MTM-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_MTM-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REALIZED_MTM-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REGION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','REPORTING_CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','SECTOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','SEDOL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','SHARES_OUTSTANDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','STRIKE_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','SUB-STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_FX-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_FX-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_FX-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_INCOME-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_INCOME-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_INCOME-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MTM-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MTM-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_MTM-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_P_L-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_P_L-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','TOTAL_P_L-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNDERLYING_BASE_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNDERLYING_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNDERLYING_INSTRUMENT_CODE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNDERLYING_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNDERLYING_SWAP_TENOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_FX-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_FX-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_FX-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_MTM-DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_MTM-MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','UNREALIZED_MTM-YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','VOLUME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','YIELD_CURVE_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('bobvcr','YIELD_CURVE_TYPE');

------------------------------------------------------------------------------
-- gfsolap fields
------------------------------------------------------------------------------

insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BEGBOOKAI');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKCOUPON');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKMISCREVEXP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKREALDIV');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKREALFXGL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKREALMTM');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKUNREALDIV');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKUNREALFXGL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKUNREALINCOME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','BOOKUNREALMTM');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDBOOKAI');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDBOOKMARKETPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDBOOKMV');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDFXRATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDLOCALCOST');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDLOCALMARKETPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDLOCALMV');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDPRICEDATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','ENDQTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','FUND');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','GFSTRANID1');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVASSETTYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVCCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVCUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVDESC');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVGFSDEFINED1');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVGFSDEFINED2');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVGFSDEFINED3');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVISSUECOUNTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVISSUER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','INVTYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','LOCALUNITCOST');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','LONGSHORTINDICATOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','PORT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','RESTATEMENTCCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','STRAT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','TAXLOTID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','TOTALBOOKFXGL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','TOTALBOOKINCOME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','TOTALBOOKMTM');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('gfsolap','TOTALBOOKPL');

------------------------------------------------------------------------------
-- ifs fields
------------------------------------------------------------------------------

insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ASK');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ASK_SIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ASK_FLOATING_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ASSET_CLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BASIS_SWAP_INDEX_PAY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BASIS_SWAP_INDEX_RECEIVE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BB_DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BID_SIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BID_FLOATING_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BLOOMBERG_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','BROKER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','CALLPUT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','COUNTERPARTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','COUNTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','CUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','DAILY_TRADES');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','DAILY_TURNOVERS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','DELTA');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','EXPIRATION_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','FIRST_CALL_PUT_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','FUND');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','FUTURES_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','FUTURE_CONTRACT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','FX_RATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INDUSTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INDUSTRY_CLASSIFICATION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INDUSTRY_GROUP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_HOLDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_COST_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_PRICE_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_TYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_UNIT_COST_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','INSTRUMENT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','ISSUER_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','LAST');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','LOCAL_MARKET_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MARKET_CAPITALISATION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MARKET_INDEX_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MARKET_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MATURITY_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MATURITY_BUCKET');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','MATURITY_BUCKET_DETAIL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','NOMINAL_AMOUNT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','OPTION_MULTIPLYER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','POSITION_SIGN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','PRICE_SOURCE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RATING_BLOOMBERG');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RATING_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RATING_MOODY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RATING_SNP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_DIVIDENDS_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_DIVIDENDS_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_DIVIDENDS_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','RLZD_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','REGION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','REPORTING_CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','SECTOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','SEDOL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','SHARES_OUTSTANDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','STRIKE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','SUB_STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_INCOME_DAILY');
commit;
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_INCOME_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_INCOME_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_PL_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_PL_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','TOTAL_PL_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','UNDERLYING_BASE_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','UNDERLYING_INSTRUMENT_CODE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','UNDERLYING_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','UNDERLYING_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','_UNDERLYING_SWAP_TENOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_DIVIDENDS_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_DIVIDENDS_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_DIVIDENDS_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','URLZD_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','VOLUME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','YIELD_CURVE_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('ifsvcr','YIELD_CURVE_TYPE');


------------------------------------------------------------------------------
-- ssc fields
------------------------------------------------------------------------------

insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ASKPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ASKSIZE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ASKFLOATRATESWAP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ASSETCLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BASISSWAPINDEXPAY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BASISSWAPINDEXRECEIVE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BLOOMBERGDATEOFPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BIDPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BIDSIZE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BIDFLOATRATESWAP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BLOOMBERGID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','BROKER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','CALLPUT_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','COUNTERPARTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','COUNTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','CUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','DAILYTRADES_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','DAILYTURNOVERS_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','DATEOFPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','DELTA');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','EXPIRATIONDATE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','FIRSTCALLORPUTDATE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','FUND');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','FUTURESCATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','FUTURECONTRACTVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','FXRATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INDUSTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INDUSTRYCLASSIFICATION_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INDUSTRYGROUP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTHOLDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTPRICELOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTTYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTUNITCOSTLOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','INSTRUMENTVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','ISSUERNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','LASTPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','LOCALMARKETVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MARKETCAPITALIZATION_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MARKETINDEXNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MARKETNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MATURITYDATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MATURITYBUCKET_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','MATURITYBUCKETDETAIL_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','NOMINALAMOUNT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','OPTIONMULTIPLIER_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','POSITIONSIGN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','PRICESOURCE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','RATINGBLOOMBERG_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','RATINGCATEGORY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','RATINGMOODY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','RATINGSANDP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDDIVIDENDSDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDDIVIDENDSMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDDIVIDENDSYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEDFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REALIZEMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REGION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','REPORTINGCURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','SECTOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','SEDOL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','SHARESOUTSTANDING_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','STRATEGEY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','STRIKE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','SUBSTRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALINCOMEDAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALINCOMEMTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALINCOMEYTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMISCREVANDEXPDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMISCREVANDEXPMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMISCREVANDEXPYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALPANDLDAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALPANDLMTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','TOTALPANDLYTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNDERLYINGBASEINSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNDERLYINGINSTRUMENTCODE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNDERLYINGINSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNDERLYINGPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNDERLYINGSWAPTENOR_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEDFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','VOLUME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','YIELDCURVENAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('sscvcr','YIELDCURVETYPE_OPTIONAL');

------------------------------------------------------------------------------
-- tykhe fields
------------------------------------------------------------------------------


insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ASK');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ASKSIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ASK_FLOATING_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ASSET_CLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BASIS_SWAP_INDEX_PAY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BASIS_SWAP_INDEX_RECEIVE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BB_DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BIDSIZE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BID_FLOATING_RATE_SWAP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BLOOMBERG_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','BROKER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','CALLPUT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','COUNTERPARTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','COUNTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','CUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','DAILYTRADES');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','DAILYTURNOVERS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','DATE_OF_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','DELTA');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','EXPIRATION_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','FIRST_CALL_OR_PUT_DATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','FUND');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','FUTURES_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','FUTURE_CONTRACT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','FX_RATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INDUSTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INDUSTRY_CLASSIFICATION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INDUSTRY_GROUP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_HOLDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_ID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_PRICE_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_TYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_UNIT_COST_LOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','INSTRUMENT_VALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','ISSUER_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','LAST');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','LOCALMARKETVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MARKETCAPITALISATION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MARKET_INDEX_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MARKET_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MATURITYDATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MATURITY_BUCKET');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','MATURITY_BUCKET_DETAIL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','NOMINAL_AMOUNT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','OPTION_MULTIPLYER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','POSITION_SIGN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','PRICE_SOURCE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','RATING_-_BLOOMBERG');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','RATING_-_CATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','RATING_-_MOODY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','RATING_-_S_P');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_DIVIDENDS_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_DIVIDENDS_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_DIVIDENDS_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REALISED_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REGION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','REPORTING_CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','SECTOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','SEDOL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','SHARESOUTSTANDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','STRIKE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','SUB_STRATEGY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_INCOME_DAILY');
commit;
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_INCOME_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_INCOME_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_P_L_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_P_L_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','TOTAL_P_L_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNDERLYING_BASE_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNDERLYING_INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNDERLYING_PRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNDERLYING_SWAP_TENOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_FX_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_FX_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_FX_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_MTM_DAILY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_MTM_MTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','UNREALISED_MTM_YTD');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','VOLUME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','YIELD_CURVE_NAME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tykvcr','YIELD_CURVE_TYPE');


------------------------------------------------------------------------------
-- globeopprmf fields
------------------------------------------------------------------------------


INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','FUND'                    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVDESC'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVASSETTYPE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVTYPE'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVCCY'                  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CUSTNAME'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVISSUECOUNTRY'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','INVID'                   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYENDQTY'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYENDLOCALMARKETPRICE',NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYENDLOCALMV'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYENDBOOKMARKETPRICE' ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYENDBOOKMV'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTOTALBOOKPL'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTOTALBOOKFXGL'      ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTOTALBOOKMTM'       ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTOTALBOOKINCOME'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDENDQTY'               ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDENDLOCALMARKETPRICE'  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDENDLOCALMV'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDENDBOOKMARKETPRICE'   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDENDBOOKMV'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDTOTALBOOKPL'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDTOTALBOOKFXGL'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDTOTALBOOKMTM'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MTDTOTALBOOKINCOME'      ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','ISIN'                    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CUSIP'                   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','SEDOL'                   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','COUNTRY'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CURRENCY'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MATURITYDATE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','RATING1'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','RATING2'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','RATING3'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','RATING4'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CLASSIFICATION1'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CLASSIFICATION2'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','CLASSIFICATION3'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','BID'                     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','ASK'                     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','LAST'                    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','SHARESOUTSTANDING'       ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','MARKETCAPITALISATION'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','VOLUME'                  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','BIDSIZE'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','ASKSIZE'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTRADES'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DAILYTURNOVER'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','FUTURECONTRACTVALUE'     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','FUTURECATEGORY'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONCONTRACTSIZE'      ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONMULTIPLIER'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONUNDERLYINGISIN'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONDELTA'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONUNDERLYINGPRICE'   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','OPTIONUNDERLYINGCURRENCY',NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','NPVRECEIVE'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','NPVPAY'                  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','NPV'                     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','FXRATECURRENCY'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','FXRATE'                  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DATATIME'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','RISKMATURITY'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','NOMINAL'                 ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','POSADJUSTEDDELTA'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DELTAVALUEK'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DELTA'                   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','DELTAEQPOS'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','UNDERPRICE'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','AMOUNTOUTSTANDING'       ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','ISSUEAMOUNT'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','VOLUMEAVG5DAY'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('gfsch','BETA'                    ,NULL);

------------------------------------------------------------------------------
-- state street high yield fields
------------------------------------------------------------------------------

INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','FUND_NAME'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','CUSIP_NUMBER'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','ISIN_NUMBER'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','SECURITY_NAME'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','MATURITY_DATE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','SHARESPAR_VALUE'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','LOCAL_MARKET_VALUE'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','BASE_MARKET_VALUE'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','INVESTMENT_TYPE_NAME'      ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','LOCAL_NET_INCOME'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','BASE_NET_INCOME_AMOUNT'     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','PRICE_EXCHANGE_RATE'       ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','ISSUER_NAME'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','BID_PRICE'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','ASK_PRICE'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','LAST_PRICE'               ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','YIELD_TO_MATURITY'         ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','MODIFIED_DURATION'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','SEDOL'                   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','MARKET_CAPITALIZATION'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','CURRENCY_CODE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','CALL_DATE'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','CAL_PRICE'               ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','YIELD_TO_WORST'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','RULE_144A'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','PRIVATE_PLACEMENT_FLAG'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','INDUSTRY_SECTOR'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','COUNTRY_CODE'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','DAILY_TURNOVER'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','CURRENT_YIELD'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','PRICE_SOURCE'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','INTEREST_RATE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','MOODY_RATING'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','S_P_RATING'                ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('sshy','FITCH_RATING'             ,NULL);

------------------------------------------------------------------------------
-- BNS high yield fields
------------------------------------------------------------------------------

INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','TRANSID'          	   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','CA_DESCRIPTION'          ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','LOAN_MATURITY_DATE'      ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','FUNDED_AMOUNT'		   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','BOOK_VALUE'              ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','PRODUCT_TYPE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','INTEREST_ACCRUAL'        ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','MARKET_PRICE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','OBLIGOR_NAME'      	   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','CUR_ID'          		   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','MOODYS'     			   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','S_P'       			   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','INDUSTRY_CODE'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','COUNTRY_CODE'            ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','ALL_IN_RATE'             ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','OBLIGATION_NUMBER'       ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','OBLIGATION_DESCRIPTION_LIN#',NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','LOAN_EFFECTIVE_DATE'     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','INITIAL_PRICE'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','PRICE_CHANGE'    		   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','CHANGE_IN_LOAN_VALUE'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','INTEREST_PAID'           ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','TOTAL_COMMITTED_AMOUNT'  ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','TOTAL_FUNDED_AMOUNT'     ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','BASE_RATE'               ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','SPREAD_RATE'    		   ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','FEE_PAID_AT_CA_LEVEL'    ,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('bnshy','FEE_ACCRUAL_AT_CA_LEVEL' ,NULL);

------------------------------------------------------------------------------
-- tranaut fields
------------------------------------------------------------------------------

insert into vcr.file_type_field  (FILE_TYPE,FIELD_NAME)  values  ('tranautvcr','FUND');
insert into vcr.file_type_field  (FILE_TYPE,FIELD_NAME)  values  ('tranautvcr','STRATEGY');  
insert into vcr.file_type_field  (FILE_TYPE,FIELD_NAME)  values  ('tranautvcr','STRAT');    
insert into vcr.file_type_field  (FILE_TYPE,FIELD_NAME)  values  ('tranautvcr','REGION');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','COUNTRY');  
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ASSETCLASS');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTTYPE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','POSITIONSIGN');  
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ISIN');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ASKPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ASKSIZE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ASKFLOATRATESWAP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BASISSWAPINDEXPAY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BASISSWAPINDEXRECEIVE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BLOOMBERGDATEOFPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BIDPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BIDSIZE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BIDFLOATRATESWAP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BLOOMBERGID');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','BROKER');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','CALLPUT_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','COUNTERPARTY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','CURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','CUSIP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','DAILYTRADES_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','DAILYTURNOVERS_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','DATEOFPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','DELTA');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','EXPIRATIONDATE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','FIRSTCALLORPUTDATE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','FUTURESCATEGORY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','FUTURECONTRACTVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','FXRATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INDUSTRY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INDUSTRYCLASSIFICATION_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INDUSTRYGROUP');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTHOLDING');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTPRICE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTPRICELOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTUNITCOSTLOCAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTCOSTLOCAL');  
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','INSTRUMENTVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','ISSUERNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','LASTPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','LOCALMARKETVALUE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MARKETCAPITALIZATION_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MARKETINDEXNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MARKETNAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MATURITYDATE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MATURITYBUCKET_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','MATURITYBUCKETDETAIL_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','NOMINALAMOUNT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','OPTIONMULTIPLIER_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','PRICESOURCE');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','RATINGBLOOMBERG_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','RATINGCATEGORY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','RATINGMOODY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','RATINGSANDP_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDDIVIDENDSDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDDIVIDENDSMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDDIVIDENDSYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEDFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REALIZEMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','REPORTINGCURRENCY');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','SECTOR');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','SEDOL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','SHARESOUTSTANDING_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','STRIKE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALDAILYINCOME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMTDINCOME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALYTDINCOME');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMISCREVANDEXPDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMISCREVANDEXPMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMISCREVANDEXPYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALDAILYPNL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALMTDPNL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','TOTALYTDPNL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNDERLYINGBASEINSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNDERLYINGINSTRUMENT');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNDERLYINGPRICE_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNDERLYINGSWAPTENOR_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDFXDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDFXMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEDFXYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETDAILY_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETMTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETYTD_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','VOLUME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','YIELDCURVENAME_OPTIONAL');
insert into vcr.file_type_field
  (FILE_TYPE,FIELD_NAME)
  values
  ('tranautvcr','YIELDCURVETYPE_OPTIONAL');

------------------------------------------------------------------------------
-- CITCO PNL extract fields
------------------------------------------------------------------------------

INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','LONGSHORT'            		  	 					,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','FUND'      										,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','STRATEGY'		   									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','SECURITY_ASSET_NAME'              					,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','CITCO_SECURITY_ID'            						,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','TRADER'        									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','COUNTRY_CODE'            							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','ISSUE_CCY'      	   								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','SECURITY_DESCRIPTION'          		   			,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','ISIN'     			   								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','CUSIP'       			   							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','SEDOL'           									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','BLOOMBERG_CODE'            						,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','BASE_CCY'             								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','INDUSTRY'       									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','INDUSTRY_SECTOR'									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','REGION'     										,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','EXCHANGE'           								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','SECURITY_ASSET_CLASS'    		   					,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','UNDERLYING_SECURITY_DESCRIPTION'    				,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','PRIME_BROKERCLEARING_BROKER'           			,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','MATURITY_DATE'  									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','OPTION_STRIKE_PRICE'     							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','OPTION_PUTCALL_FLAG'               				,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','OPTION_EXPIRATION_DATE'    		   				,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','CONTRACT_SIZE'    									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','QUANTITY(END)' 										,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','ISSUE_PRICE'     									,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','ISSUE_AVERAGE_UNIT_COST'           				,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','BASE_PRICE'    		   							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','BASE_MARKET_VALUE'    								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','DAILY_BASE_PL'           							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','MTD_BASE_PL'  										,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','YEARLY_BASE_PL'     								,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','DAILY_BASE_INCOME'               					,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','MONTHLY_BASE_INCOME'    		   					,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','YEARLY_BASE_INCOME'    							,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','BASE_BOND_ACCRUED_INTEREST'   	   		   	   	 	,NULL);  
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','MTD_BASE_START_BOND_ACCRUED_INTEREST'     	   	 	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','YTD_BASE_START_BOND_ACCRUED_INTEREST'           	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','ISSUE_MARKET_VALUE'  							 	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','SPOT_FX_RATE'     	  							 	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','TOTAL_FUND_CAPITAL'               				 	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','OPTION_DELTA'    		   		   				 	,NULL);
INSERT INTO VCR.FILE_TYPE_FIELD (FILE_TYPE,FIELD_NAME,CHANGE_REASON) VALUES ('citcopnl','COUPON_RATE'    		   						 	,NULL);  
  
commit;


alter table vcr.field_target_column enable constraint fk_ftc_file_type_field; 

set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

