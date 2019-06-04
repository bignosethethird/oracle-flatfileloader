------------------------------------------------------------------------------
-- $Header: vcr/data/field_target_column.sql 1.6.1.10 2005/10/07 15:59:58BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.field_target_column.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @field_target_column.sql
-- This file was generated from database instance CPAD.
--   Database Time    : 28FEB2005 17:04:42
--   IP address       : 192.5.20.64
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : ahl64
--   O/S user         : vcr
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.field_target_column.


alter table vcr.field_target_column disable constraint FK_FTC_FILE_TYPE_FIELD;
-- empty table:
delete from vcr.field_target_column;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

-- gfsolap mappings

insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVDESC','source_position','instrument',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVGFSDEFINED2','source_position','isin',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVGFSDEFINED3','source_position','sedol',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALMTM','source_position','unrealised_mtm_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVASSETTYPE','source_position','asset_class',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVTYPE','source_position','instrument_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVISSUER','source_position','issuer_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVISSUECOUNTRY','source_position','country',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVCCY','source_position','currency',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVGFSDEFINED1','source_position','cusip',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALMTM','source_position','unrealised_mtm_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALMTM','source_position','unrealised_mtm_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TAXLOTID','source_position','tax_lot_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','FUND','source_position','fund',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','PORT','source_position','strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','STRAT','source_position','sub_strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','INVID','source_position','instrument_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','RESTATEMENTCCY','source_position','reporting_currency',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDLOCALMV','source_position','local_market_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDBOOKMV','source_position','instrument_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDBOOKMARKETPRICE','source_position','instrument_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDLOCALMARKETPRICE','source_position','instrument_price_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDFXRATE','source_position','fx_rate',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDQTY','source_position','instrument_holding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','LOCALUNITCOST','source_position','instrument_unit_cost_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKPL','source_position','total_pnl_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKPL','source_position','total_pnl_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKPL','source_position','total_pnl_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALMTM','source_position','realised_mtm_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALMTM','source_position','realised_mtm_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALMTM','source_position','realised_mtm_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKMTM','source_position','total_mtm_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKMTM','source_position','total_mtm_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKMTM','source_position','total_mtm_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALFXGL','source_position','unrealised_fx_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALFXGL','source_position','unrealised_fx_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALFXGL','source_position','unrealised_fx_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALFXGL','source_position','realised_fx_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALFXGL','source_position','realised_fx_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALFXGL','source_position','realised_fx_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKFXGL','source_position','total_fx_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKFXGL','source_position','total_fx_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKFXGL','source_position','total_fx_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALDIV','source_position','unrealised_dividends_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALDIV','source_position','unrealised_dividends_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALDIV','source_position','unrealised_dividends_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALDIV','source_position','realised_dividends_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALDIV','source_position','realised_dividends_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKREALDIV','source_position','realised_dividends_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDBOOKAI','source_position','unrealised_acc_interest_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDBOOKAI','source_position','unrealised_acc_interest_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDBOOKAI','source_position','unrealised_acc_interest_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKINCOME','source_position','total_income_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKINCOME','source_position','total_income_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','TOTALBOOKINCOME','source_position','total_income_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKMISCREVEXP','source_position','total_misc_rev_exp_daily','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKMISCREVEXP','source_position','total_misc_rev_exp_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKMISCREVEXP','source_position','total_misc_rev_exp_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','LONGSHORTINDICATOR','source_position','position_sign',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDPRICEDATE','source_position','date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','GFSTRANID1','source_position','transaction_id',NULL,'Y');
  
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BEGBOOKAI','source_position','beg_book_acc_interest','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDLOCALCOST','source_position','end_local_cost','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALINCOME','source_position','book_unrealised_income','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKCOUPON','source_position','book_coupon','DAILY','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BEGBOOKAI','source_position','beg_book_acc_interest_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDLOCALCOST','source_position','end_local_cost_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALINCOME','source_position','book_unrealised_income_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKCOUPON','source_position','book_coupon_mtd','MTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BEGBOOKAI','source_position','beg_book_acc_interest_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','ENDLOCALCOST','source_position','end_local_cost_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKUNREALINCOME','source_position','book_unrealised_income_ytd','YTD','N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('gfsolap','BOOKCOUPON','source_position','book_coupon_ytd','YTD','N');  
  
-- ssc mappings

insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ASKPRICE_OPTIONAL','source_position','ask',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ASKSIZE_OPTIONAL','source_position','ask_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ASKFLOATRATESWAP_OPTIONAL','source_position','ask_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ASSETCLASS','source_position','asset_class',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BASISSWAPINDEXPAY_OPTIONAL','source_position','basis_swap_index_pay',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BASISSWAPINDEXRECEIVE_OPTIONAL','source_position','basis_swap_index_receive',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BLOOMBERGDATEOFPRICE_OPTIONAL','source_position','bb_date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BIDPRICE_OPTIONAL','source_position','bid',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BIDSIZE_OPTIONAL','source_position','bid_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BIDFLOATRATESWAP_OPTIONAL','source_position','bid_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BLOOMBERGID','source_position','bloomberg_id',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','BROKER','source_position','broker',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','CALLPUT_OPTIONAL','source_position','call_put',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','COUNTERPARTY','source_position','counterparty',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','COUNTRY','source_position','country',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','CURRENCY','source_position','currency',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','CUSIP','source_position','cusip',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','DAILYTRADES_OPTIONAL','source_position','daily_trades',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','DAILYTURNOVERS_OPTIONAL','source_position','daily_turnovers',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','DATEOFPRICE','source_position','date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','DELTA','source_position','delta',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','EXPIRATIONDATE_OPTIONAL','source_position','expiration_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','FIRSTCALLORPUTDATE_OPTIONAL','source_position','first_call_or_put_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','FUND','source_position','fund',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','FUTURESCATEGORY','source_position','futures_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','FUTURECONTRACTVALUE','source_position','future_contract_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','FXRATE','source_position','fx_rate',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INDUSTRY','source_position','industry',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INDUSTRYCLASSIFICATION_OPTIONAL','source_position','industry_classification',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INDUSTRYGROUP','source_position','industry_group',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENT','source_position','instrument',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTHOLDING','source_position','instrument_holding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTID','source_position','instrument_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTPRICE','source_position','instrument_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTPRICELOCAL','source_position','instrument_price_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTTYPE','source_position','instrument_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTUNITCOSTLOCAL','source_position','instrument_unit_cost_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','INSTRUMENTVALUE','source_position','instrument_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ISIN','source_position','isin',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','ISSUERNAME_OPTIONAL','source_position','issuer_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','LASTPRICE_OPTIONAL','source_position','last',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','LOCALMARKETVALUE','source_position','local_market_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MARKETCAPITALIZATION_OPTIONAL','source_position','market_capitalisation',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MARKETINDEXNAME_OPTIONAL','source_position','market_index_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MARKETNAME_OPTIONAL','source_position','market_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MATURITYDATE','source_position','maturity_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MATURITYBUCKET_OPTIONAL','source_position','maturity_bucket',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','MATURITYBUCKETDETAIL_OPTIONAL','source_position','maturity_bucket_detail',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','NOMINALAMOUNT','source_position','nominal_amount',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','OPTIONMULTIPLIER_OPTIONAL','source_position','option_multiplyer',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','POSITIONSIGN','source_position','position_sign',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','PRICESOURCE','source_position','price_source',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','RATINGBLOOMBERG_OPTIONAL','source_position','rating_bloomberg',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','RATINGCATEGORY_OPTIONAL','source_position','rating_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','RATINGMOODY_OPTIONAL','source_position','rating_moody',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','RATINGSANDP_OPTIONAL','source_position','rating_sp',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTDAILY_OPTIONAL','source_position','realised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTMTD_OPTIONAL','source_position','realised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDACCRUEDINTERESTYTD_OPTIONAL','source_position','realised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDDIVIDENDSDAILY_OPTIONAL','source_position','realised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDDIVIDENDSMTD_OPTIONAL','source_position','realised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDDIVIDENDSYTD_OPTIONAL','source_position','realised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDFXDAILY_OPTIONAL','source_position','realised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDFXMTD_OPTIONAL','source_position','realised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEDFXYTD_OPTIONAL','source_position','realised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEMARKTOMARKETDAILY_OPTIONAL','source_position','realised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEMARKTOMARKETMTD_OPTIONAL','source_position','realised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REALIZEMARKTOMARKETYTD_OPTIONAL','source_position','realised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REGION','source_position','region',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','REPORTINGCURRENCY','source_position','reporting_currency',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','SECTOR','source_position','sector',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','SEDOL','source_position','sedol',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','SHARESOUTSTANDING_OPTIONAL','source_position','shares_outstanding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','STRATEGEY','source_position','strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','STRIKE_OPTIONAL','source_position','strike',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','SUBSTRATEGY','source_position','sub_strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALFXDAILY_OPTIONAL','source_position','total_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALFXMTD_OPTIONAL','source_position','total_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALFXYTD_OPTIONAL','source_position','total_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALINCOMEDAILY','source_position','total_income_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALINCOMEMTD','source_position','total_income_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALINCOMEYTD','source_position','total_income_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMISCREVANDEXPDAILY_OPTIONAL','source_position','total_misc_rev_exp_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMISCREVANDEXPMTD_OPTIONAL','source_position','total_misc_rev_exp_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMISCREVANDEXPYTD_OPTIONAL','source_position','total_misc_rev_exp_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMARKTOMARKETDAILY_OPTIONAL','source_position','total_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMARKTOMARKETMTD_OPTIONAL','source_position','total_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALMARKTOMARKETYTD_OPTIONAL','source_position','total_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALPANDLDAILY','source_position','total_pnl_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALPANDLMTD','source_position','total_pnl_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','TOTALPANDLYTD','source_position','total_pnl_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNDERLYINGBASEINSTRUMENT','source_position','underlying_base_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNDERLYINGINSTRUMENT','source_position','underlying_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNDERLYINGPRICE_OPTIONAL','source_position','underlying_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNDERLYINGSWAPTENOR_OPTIONAL','source_position','underlying_swap_tenor',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTDAILY_OPTIONAL','source_position','unrealised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
    (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTMTD_OPTIONAL','source_position','unrealised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDACCRUEDINTERESTYTD_OPTIONAL','source_position','unrealised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSDAILY_OPTIONAL','source_position','unrealised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSMTD_OPTIONAL','source_position','unrealised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDDIVIDENDSYTD_OPTIONAL','source_position','unrealised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDFXDAILY_OPTIONAL','source_position','unrealised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDFXMTD_OPTIONAL','source_position','unrealised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEDFXYTD_OPTIONAL','source_position','unrealised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
    (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETDAILY_OPTIONAL','source_position','unrealised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETMTD_OPTIONAL','source_position','unrealised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','UNREALIZEMARKTOMARKETYTD_OPTIONAL','source_position','unrealised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','VOLUME_OPTIONAL','source_position','volume',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','YIELDCURVENAME_OPTIONAL','source_position','yield_curve_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('sscvcr','YIELDCURVETYPE_OPTIONAL','source_position','yield_curve_type',NULL,'N');

-- ifs mappings

insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ASK','source_position','ask',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ASK_SIZE','source_position','ask_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ASK_FLOATING_RATE_SWAP','source_position','ask_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ASSET_CLASS','source_position','asset_class',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BASIS_SWAP_INDEX_PAY','source_position','basis_swap_index_pay',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BASIS_SWAP_INDEX_RECEIVE','source_position','basis_swap_index_receive',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BB_DATE_OF_PRICE','source_position','bb_date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BID','source_position','bid',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BID_SIZE','source_position','bid_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BID_FLOATING_RATE_SWAP','source_position','bid_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BLOOMBERG_ID','source_position','bloomberg_id',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','BROKER','source_position','broker',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','CALLPUT','source_position','call_put',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','COUNTERPARTY','source_position','counterparty',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','COUNTRY','source_position','country',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','CURRENCY','source_position','currency',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','CUSIP','source_position','cusip',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','DAILY_TRADES','source_position','daily_trades',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','DAILY_TURNOVERS','source_position','daily_turnovers',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','DATE_OF_PRICE','source_position','date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','DELTA','source_position','delta',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','EXPIRATION_DATE','source_position','expiration_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','FIRST_CALL_PUT_DATE','source_position','first_call_or_put_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','FUND','source_position','fund',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','FUTURES_CATEGORY','source_position','futures_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','FUTURE_CONTRACT_VALUE','source_position','future_contract_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','FX_RATE','source_position','fx_rate',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INDUSTRY','source_position','industry',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INDUSTRY_CLASSIFICATION','source_position','industry_classification',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INDUSTRY_GROUP','source_position','industry_group',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT','source_position','instrument',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_HOLDING','source_position','instrument_holding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_ID','source_position','instrument_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_PRICE','source_position','instrument_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_COST_LOCAL','source_position','end_local_cost',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_PRICE_LOCAL','source_position','instrument_price_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_TYPE','source_position','instrument_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_UNIT_COST_LOCAL','source_position','instrument_unit_cost_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','INSTRUMENT_VALUE','source_position','instrument_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ISIN','source_position','isin',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','ISSUER_NAME','source_position','issuer_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','LAST','source_position','last',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','LOCAL_MARKET_VALUE','source_position','local_market_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MARKET_CAPITALISATION','source_position','market_capitalisation',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MARKET_INDEX_NAME','source_position','market_index_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MARKET_NAME','source_position','market_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MATURITY_DATE','source_position','maturity_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MATURITY_BUCKET','source_position','maturity_bucket',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','MATURITY_BUCKET_DETAIL','source_position','maturity_bucket_detail',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','NOMINAL_AMOUNT','source_position','nominal_amount',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','OPTION_MULTIPLYER','source_position','option_multiplyer',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','POSITION_SIGN','source_position','position_sign',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','PRICE_SOURCE','source_position','price_source',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RATING_BLOOMBERG','source_position','rating_bloomberg',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RATING_CATEGORY','source_position','rating_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RATING_MOODY','source_position','rating_moody',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RATING_SNP','source_position','rating_sp',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_DAILY','source_position','realised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_MTD','source_position','realised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_ACCRUED_INTEREST_YTD','source_position','realised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_DIVIDENDS_DAILY','source_position','realised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_DIVIDENDS_MTD','source_position','realised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_DIVIDENDS_YTD','source_position','realised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_FX_DAILY','source_position','realised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_FX_MTD','source_position','realised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_FX_YTD','source_position','realised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_MTM_DAILY','source_position','realised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_MTM_MTD','source_position','realised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','RLZD_MTM_YTD','source_position','realised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','REGION','source_position','region',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','REPORTING_CURRENCY','source_position','reporting_currency',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','SECTOR','source_position','sector',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','SEDOL','source_position','sedol',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','SHARES_OUTSTANDING','source_position','shares_outstanding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','STRATEGY','source_position','strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','STRIKE','source_position','strike',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','SUB_STRATEGY','source_position','sub_strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_FX_DAILY','source_position','total_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_FX_MTD','source_position','total_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_FX_YTD','source_position','total_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_INCOME_DAILY','source_position','total_income_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_INCOME_MTD','source_position','total_income_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_INCOME_YTD','source_position','total_income_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_DAILY','source_position','total_misc_rev_exp_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_MTD','source_position','total_misc_rev_exp_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MISC_REV_EXP_YTD','source_position','total_misc_rev_exp_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MTM_DAILY','source_position','total_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MTM_MTD','source_position','total_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_MTM_YTD','source_position','total_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_PL_DAILY','source_position','total_pnl_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_PL_MTD','source_position','total_pnl_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','TOTAL_PL_YTD','source_position','total_pnl_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','UNDERLYING_BASE_INSTRUMENT','source_position','underlying_base_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','UNDERLYING_INSTRUMENT','source_position','underlying_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','UNDERLYING_PRICE','source_position','underlying_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','_UNDERLYING_SWAP_TENOR','source_position','underlying_swap_tenor',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_DAILY','source_position','unrealised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
    (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_MTD','source_position','unrealised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_ACCRUED_INTEREST_YTD','source_position','unrealised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_DIVIDENDS_DAILY','source_position','unrealised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_DIVIDENDS_MTD','source_position','unrealised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_DIVIDENDS_YTD','source_position','unrealised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_FX_DAILY','source_position','unrealised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_FX_MTD','source_position','unrealised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_FX_YTD','source_position','unrealised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
    (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_MTM_DAILY','source_position','unrealised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_MTM_MTD','source_position','unrealised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','URLZD_MTM_YTD','source_position','unrealised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','VOLUME','source_position','volume',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','YIELD_CURVE_NAME','source_position','yield_curve_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('ifsvcr','YIELD_CURVE_TYPE','source_position','yield_curve_type',NULL,'N');

-- tykhe mappings

insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ASKSIZE','source_position','ask_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ASK_FLOATING_RATE_SWAP','source_position','ask_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ASSET_CLASS','source_position','asset_class',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BB_DATE_OF_PRICE','source_position','bb_date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BASIS_SWAP_INDEX_PAY','source_position','basis_swap_index_pay',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BASIS_SWAP_INDEX_RECEIVE','source_position','basis_swap_index_receive',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BIDSIZE','source_position','bid_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BID_FLOATING_RATE_SWAP','source_position','bid_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BLOOMBERG_ID','source_position','bloomberg_id',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BROKER','source_position','broker',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','CUSIP','source_position','cusip',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','CALLPUT','source_position','call_put',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','COUNTERPARTY','source_position','counterparty',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','COUNTRY','source_position','country',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','CURRENCY','source_position','currency',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','DAILYTRADES','source_position','daily_trades',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','DAILYTURNOVERS','source_position','daily_turnovers',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','DATE_OF_PRICE','source_position','date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','DELTA','source_position','delta',NULL,'N');
 insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','EXPIRATION_DATE','source_position','expiration_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','FX_RATE','source_position','fx_rate',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','FIRST_CALL_OR_PUT_DATE','source_position','first_call_or_put_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','FUND','source_position','fund',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','FUTURE_CONTRACT_VALUE','source_position','future_contract_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','FUTURES_CATEGORY','source_position','futures_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ISIN','source_position','isin',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INDUSTRY','source_position','industry',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INDUSTRY_CLASSIFICATION','source_position','industry_classification',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INDUSTRY_GROUP','source_position','industry_group',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT','source_position','instrument',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_ID','source_position','instrument_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_TYPE','source_position','instrument_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_HOLDING','source_position','instrument_holding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_PRICE','source_position','instrument_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_PRICE_LOCAL','source_position','instrument_price_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_UNIT_COST_LOCAL','source_position','instrument_unit_cost_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','INSTRUMENT_VALUE','source_position','instrument_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ISSUER_NAME','source_position','issuer_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','LOCALMARKETVALUE','source_position','local_market_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MARKET_INDEX_NAME','source_position','market_index_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MARKET_NAME','source_position','market_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MATURITYDATE','source_position','maturity_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MATURITY_BUCKET','source_position','maturity_bucket',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MATURITY_BUCKET_DETAIL','source_position','maturity_bucket_detail',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','NOMINAL_AMOUNT','source_position','nominal_amount',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','OPTION_MULTIPLYER','source_position','option_multiplyer',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','POSITION_SIGN','source_position','position_sign',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','PRICE_SOURCE','source_position','price_source',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','RATING_-_BLOOMBERG','source_position','rating_bloomberg',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','RATING_-_MOODY','source_position','rating_moody',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','RATING_-_S_P','source_position','rating_sp',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','RATING_-_CATEGORY','source_position','rating_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_FX_DAILY','source_position','realised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_FX_MTD','source_position','realised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_FX_YTD','source_position','realised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_MTM_DAILY','source_position','realised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_MTM_MTD','source_position','realised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_MTM_YTD','source_position','realised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_DAILY','source_position','realised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_MTD','source_position','realised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_ACCRUED_INTEREST_YTD','source_position','realised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_DIVIDENDS_DAILY','source_position','realised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_DIVIDENDS_MTD','source_position','realised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REALISED_DIVIDENDS_YTD','source_position','realised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REGION','source_position','region',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','REPORTING_CURRENCY','source_position','reporting_currency',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','SEDOL','source_position','sedol',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','SECTOR','source_position','sector',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','STRATEGY','source_position','strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','STRIKE','source_position','strike',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','SUB_STRATEGY','source_position','sub_strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_FX_DAILY','source_position','total_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_FX_MTD','source_position','total_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_FX_YTD','source_position','total_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_INCOME_DAILY','source_position','total_income_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_INCOME_MTD','source_position','total_income_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_INCOME_YTD','source_position','total_income_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MTM_DAILY','source_position','total_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MTM_MTD','source_position','total_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MTM_YTD','source_position','total_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_P_L_DAILY','source_position','total_pnl_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_P_L_MTD','source_position','total_pnl_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_P_L_YTD','source_position','total_pnl_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_DAILY','source_position','total_misc_rev_exp_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_MTD','source_position','total_misc_rev_exp_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','TOTAL_MISC_REV_EXP_YTD','source_position','total_misc_rev_exp_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNDERLYING_BASE_INSTRUMENT','source_position','underlying_base_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNDERLYING_INSTRUMENT','source_position','underlying_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNDERLYING_PRICE','source_position','underlying_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNDERLYING_SWAP_TENOR','source_position','underlying_swap_tenor',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_FX_DAILY','source_position','unrealised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_FX_MTD','source_position','unrealised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_FX_YTD','source_position','unrealised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_MTM_DAILY','source_position','unrealised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_MTM_MTD','source_position','unrealised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_MTM_YTD','source_position','unrealised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_DAILY','source_position','unrealised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_MTD','source_position','unrealised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_ACCRUED_INTEREST_YTD','source_position','unrealised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_DAILY','source_position','unrealised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_MTD','source_position','unrealised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','UNREALISED_DIVIDENDS_YTD','source_position','unrealised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','YIELD_CURVE_NAME','source_position','yield_curve_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','YIELD_CURVE_TYPE','source_position','yield_curve_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','ASK','source_position','ask',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','BID','source_position','bid',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','LAST','source_position','last',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','MARKETCAPITALISATION','source_position','market_capitalisation',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','SHARESOUTSTANDING','source_position','shares_outstanding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('tykvcr','VOLUME','source_position','volume',NULL,'N');

-- bob mappings

insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ASK','source_position','ask',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ASK_FLOAT_RATE_SWAP','source_position','ask_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ASK_SIZE','source_position','ask_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ASSET_CLASS','source_position','asset_class',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BASIS_SWAP_INDEX_RECEIVE','source_position','basis_swap_index_receive',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BB_DATE_OF_PRICE','source_position','bb_date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BID','source_position','bid',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BID_FLOAT_RATE_SWAP','source_position','bid_floating_rate_swap',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BID_SIZE','source_position','bid_size',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BLOOMBERG_ID','source_position','bloomberg_id',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BROKER','source_position','broker',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','COUNTERPARTY','source_position','counterparty',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','COUNTRY','source_position','country',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','CURRENCY','source_position','currency',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','CUSIP','source_position','cusip',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','DAILY_TRADES','source_position','daily_trades',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','DAILY_TURNOVERS','source_position','daily_turnovers',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','DATE_OF_PRICE','source_position','date_of_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','DELTA','source_position','delta',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','EXPIRATION_DATE','source_position','expiration_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','FIRST_CALL_OR_PUT_DATE','source_position','first_call_or_put_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','FUND','source_position','fund',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','FUTURES_CATEGORY','source_position','futures_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','FUTURE_CONTRACT_VALUE','source_position','future_contract_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','FX_RATE','source_position','fx_rate',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INDUSTRY','source_position','industry',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INDUSTRY_CLASS','source_position','industry_classification',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INDUSTRY_GROUP','source_position','industry_group',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT','source_position','instrument',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_HOLDING','source_position','instrument_holding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_ID','source_position','instrument_id',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_PRICE','source_position','instrument_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_PRICE_LOCAL','source_position','instrument_price_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_TYPE','source_position','instrument_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_UNIT_COST_LOCAL','source_position','instrument_unit_cost_local',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','INSTRUMENT_VALUE','source_position','instrument_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ISIN','source_position','isin',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','ISSUER_NAME','source_position','issuer_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','LAST','source_position','last',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','LOCAL_MARKET_VALUE','source_position','local_market_value',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MARKET_CAPITALIZATION','source_position','market_capitalisation',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MARKET_INDEX_NAME','source_position','market_index_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MARKET_NAME','source_position','market_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MATURITY_BUCKET','source_position','maturity_bucket',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MATURITY_BUCKET_DETAIL','source_position','maturity_bucket_detail',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','MATURITY_DATE','source_position','maturity_date',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','NOMINAL_AMOUNT','source_position','nominal_amount',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','OPTION_MULTIPLIER','source_position','option_multiplyer',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','POSITION_SIGN','source_position','position_sign',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','PRICE_SOURCE','source_position','price_source',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','RATING_-_BLOOMBERG','source_position','rating_bloomberg',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','RATING_-_CATEGORY','source_position','rating_category',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','RATING_-_MOODY','source_position','rating_moody',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','RATING_-_S_P','source_position','rating_sp',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-DAILY','source_position','realised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-MTD','source_position','realised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_ACCRUED_INT-YTD','source_position','realised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_DIVIDENDS-DAILY','source_position','realised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_DIVIDENDS-MTD','source_position','realised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_DIVIDENDS-YTD','source_position','realised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_FX-DAILY','source_position','realised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_FX-MTD','source_position','realised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_FX-YTD','source_position','realised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_MTM-DAILY','source_position','realised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_MTM-MTD','source_position','realised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REALIZED_MTM-YTD','source_position','realised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REGION','source_position','region',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','REPORTING_CURRENCY','source_position','reporting_currency',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','SECTOR','source_position','sector',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','SEDOL','source_position','sedol',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','SHARES_OUTSTANDING','source_position','shares_outstanding',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','STRATEGY','source_position','strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','STRIKE_PRICE','source_position','strike',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','SUB-STRATEGY','source_position','sub_strategy',NULL,'Y');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_FX-DAILY','source_position','total_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_FX-MTD','source_position','total_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_FX-YTD','source_position','total_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_INCOME-DAILY','source_position','total_income_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_INCOME-MTD','source_position','total_income_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_INCOME-YTD','source_position','total_income_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-DAILY','source_position','total_misc_rev_exp_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-MTD','source_position','total_misc_rev_exp_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MISC_REVEXP-YTD','source_position','total_misc_rev_exp_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MTM-DAILY','source_position','total_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MTM-MTD','source_position','total_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_MTM-YTD','source_position','total_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_P_L-DAILY','source_position','total_pnl_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_P_L-MTD','source_position','total_pnl_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','TOTAL_P_L-YTD','source_position','total_pnl_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNDERLYING_BASE_INSTRUMENT','source_position','underlying_base_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNDERLYING_INSTRUMENT','source_position','underlying_instrument',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNDERLYING_PRICE','source_position','underlying_price',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNDERLYING_SWAP_TENOR','source_position','underlying_swap_tenor',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-DAILY','source_position','unrealised_acc_interest_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-MTD','source_position','unrealised_acc_interest_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_ACCRUED_INT-YTD','source_position','unrealised_acc_interest_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-DAILY','source_position','unrealised_dividends_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-MTD','source_position','unrealised_dividends_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_DIVIDENDS-YTD','source_position','unrealised_dividends_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_FX-DAILY','source_position','unrealised_fx_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_FX-MTD','source_position','unrealised_fx_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_FX-YTD','source_position','unrealised_fx_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_MTM-DAILY','source_position','unrealised_mtm_daily',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_MTM-MTD','source_position','unrealised_mtm_mtd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','UNREALIZED_MTM-YTD','source_position','unrealised_mtm_ytd',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','VOLUME','source_position','volume',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','YIELD_CURVE_NAME','source_position','yield_curve_name',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','YIELD_CURVE_TYPE','source_position','yield_curve_type',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','CALLPUT','source_position','call_put',NULL,'N');
insert into vcr.field_target_column
  (FILE_TYPE,FIELD_NAME,TABLE_NAME,COLUMN_NAME,ACCOUNTING_PERIOD,IN_UNIQUE_KEY)
  values
  ('bobvcr','BASIS_SWAP_INDEX_PAY','source_position','basis_swap_index_pay',NULL,'N');

-- gfsch

INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','FUND'                     ,'source_position','fund'                      ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVDESC'                  ,'source_position','instrument'                ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVASSETTYPE'             ,'source_position','asset_class'               ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVTYPE'                  ,'source_position','instrument_type'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVCCY'                   ,'source_position','currency'                  ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','CUSTNAME'                 ,'source_position','broker'                    ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVISSUECOUNTRY'          ,'source_position','country'                   ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','INVID'                    ,'source_position','instrument_id'             ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYENDQTY'              ,'source_position','instrument_holding'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYENDLOCALMARKETPRICE' ,'source_position','instrument_price_local'    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYENDLOCALMV'          ,'source_position','local_market_value'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYENDBOOKMARKETPRICE'  ,'source_position','instrument_price'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYENDBOOKMV'           ,'source_position','instrument_value'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTOTALBOOKPL'         ,'source_position','total_pnl_daily'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTOTALBOOKFXGL'       ,'source_position','total_fx_daily'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTOTALBOOKMTM'        ,'source_position','total_mtm_daily'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTOTALBOOKINCOME'     ,'source_position','total_income_daily'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MTDTOTALBOOKPL'           ,'source_position','total_pnl_mtd'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MTDTOTALBOOKFXGL'         ,'source_position','total_fx_mtd'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MTDTOTALBOOKMTM'          ,'source_position','total_mtm_mtd'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MTDTOTALBOOKINCOME'       ,'source_position','total_income_mtd'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','ISIN'                     ,'source_position','isin'                      ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','CUSIP'                    ,'source_position','cusip'                     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','SEDOL'                    ,'source_position','sedol'                     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MATURITYDATE'             ,'source_position','maturity_date'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','RATING1'                  ,'source_position','rating_sp'                 ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','RATING2'                  ,'source_position','rating_moody'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','RATING3'                  ,'source_position','rating_bloomberg'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','CLASSIFICATION1'          ,'source_position','industry_group'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','CLASSIFICATION2'          ,'source_position','industry'                  ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','CLASSIFICATION3'          ,'source_position','sector'                    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','BID'                      ,'source_position','bid'                       ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','ASK'                      ,'source_position','ask'                       ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','LAST'                     ,'source_position','last'                      ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','SHARESOUTSTANDING'        ,'source_position','shares_outstanding'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','MARKETCAPITALISATION'     ,'source_position','market_capitalisation'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','VOLUME'                   ,'source_position','volume'                    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','BIDSIZE'                  ,'source_position','bid_size'                  ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','ASKSIZE'                  ,'source_position','ask_size'                  ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTRADES'              ,'source_position','daily_trades'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DAILYTURNOVER'            ,'source_position','daily_turnovers'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','FUTURECONTRACTVALUE'      ,'source_position','future_contract_value'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','FUTURECATEGORY'           ,'source_position','futures_category'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','OPTIONCONTRACTSIZE'       ,'source_position','option_multiplyer'         ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','OPTIONUNDERLYINGISIN'     ,'source_position','underlying_instrument'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','OPTIONDELTA'              ,'source_position','delta'                     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','OPTIONUNDERLYINGPRICE'    ,'source_position','underlying_price'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','FXRATE'                   ,'source_position','fx_rate'                   ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DATATIME'                 ,'source_position','date_of_price'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','RISKMATURITY'             ,'source_position','expiration_date'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','NOMINAL'                  ,'source_position','nominal_amount'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','POSADJUSTEDDELTA'         ,'source_position','pos_adjusted_delta'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('gfsch','DELTAVALUEK'              ,'source_position','delta_value_k'             ,NULL,'N',NULL);

-- state street high yield

INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','FUND_NAME'                   ,'source_position','fund'                  ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','CUSIP_NUMBER'                ,'source_position','cusip'                 ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','ISIN_NUMBER'                 ,'source_position','isin'                  ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','SECURITY_NAME'               ,'source_position','instrument'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','MATURITY_DATE'               ,'source_position','maturity_date'         ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','SHARESPAR_VALUE'             ,'source_position','instrument_holding'    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','LOCAL_MARKET_VALUE'           ,'source_position','local_market_value'    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','BASE_MARKET_VALUE'            ,'source_position','instrument_value'      ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','INVESTMENT_TYPE_NAME'         ,'source_position','instrument_type'       ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','LOCAL_NET_INCOME'             ,'source_position','accrued_interest_local_hy',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','BASE_NET_INCOME_AMOUNT'        ,'source_position','accrued_interest_hy'      ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','PRICE_EXCHANGE_RATE'          ,'source_position','instrument_price_local',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','ISSUER_NAME'                 ,'source_position','issuer_name'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','BID_PRICE'                   ,'source_position','bid'                   ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','ASK_PRICE'                   ,'source_position','ask'                   ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','LAST_PRICE'                  ,'source_position','last'                  ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','YIELD_TO_MATURITY'            ,'source_position','yield_to_maturity'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','MODIFIED_DURATION'           ,'source_position','modified_duration'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','SEDOL'                      ,'source_position','sedol'                 ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','MARKET_CAPITALIZATION'       ,'source_position','market_capitalisation' ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','CURRENCY_CODE'               ,'source_position','currency'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','CALL_DATE'                   ,'source_position','first_call_or_put_date',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','CAL_PRICE'                  ,'source_position','strike'                ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','YIELD_TO_WORST'               ,'source_position','yield_to_worst'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','RULE_144A'                   ,'source_position','rule_144a'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','PRIVATE_PLACEMENT_FLAG'       ,'source_position','private_placement'     ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','INDUSTRY_SECTOR'             ,'source_position','industry_group'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','COUNTRY_CODE'                ,'source_position','country'               ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','DAILY_TURNOVER'              ,'source_position','daily_turnovers'       ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','CURRENT_YIELD'               ,'source_position','current_yield'         ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','PRICE_SOURCE'                ,'source_position','price_source'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','INTEREST_RATE'               ,'source_position','interest_rate'         ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','MOODY_RATING'                ,'source_position','rating_moody'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','S_P_RATING'                   ,'source_position','rating_sp'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('sshy','FITCH_RATING'                ,'source_position','rating_fitch'          ,NULL,'N',NULL);


------------------------------------------------------------------------------
-- BNS high yield fields
------------------------------------------------------------------------------


INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','TRANSID'          		  ,'source_position','fund'                  ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','CA_DESCRIPTION'          ,'source_position','instrument'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','LOAN_MATURITY_DATE'      ,'source_position','maturity_date'         ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','FUNDED_AMOUNT'		   	  ,'source_position','instrument_holding'    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','BOOK_VALUE'              ,'source_position','instrument_cost_value_hy',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','PRODUCT_TYPE'            ,'source_position','instrument_type'       ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','INTEREST_ACCRUAL'        ,'source_position','accrued_interest_hy'      ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','MARKET_PRICE'            ,'source_position','instrument_price_local',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','OBLIGOR_NAME'      	  ,'source_position','issuer_name'           ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','CUR_ID'          		  ,'source_position','currency'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','MOODYS'     			  ,'source_position','rating_moody'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','S_P'       			  ,'source_position','rating_sp'             ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','INDUSTRY_CODE'           ,'source_position','industry_group'        ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','COUNTRY_CODE'            ,'source_position','country'               ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','ALL_IN_RATE'             ,'source_position','interest_rate'         ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','OBLIGATION_NUMBER'       ,'source_position','instrument_id'         ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','OBLIGATION_DESCRIPTION_LIN#','source_position','loan_identifier_hy' ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','LOAN_EFFECTIVE_DATE'     ,'source_position','loan_effective_date_hy',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','INITIAL_PRICE'           ,'source_position','instrument_unit_cost_local',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','PRICE_CHANGE'    		  ,'source_position','instrument_price_change_hy',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','CHANGE_IN_LOAN_VALUE'    ,'source_position','instrument_value_change_hy',NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','INTEREST_PAID'           ,'source_position','paid_interest_hy'          ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','TOTAL_COMMITTED_AMOUNT'  ,'source_position','total_committed_amount_hy' ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','TOTAL_FUNDED_AMOUNT'     ,'source_position','total_funded_amount_hy'    ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','BASE_RATE'               ,'source_position','base_rate_hy'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','SPREAD_RATE'    		  ,'source_position','spread_rate_hy'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','FEE_PAID_AT_CA_LEVEL'    ,'source_position','paid_fees_hy'              ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('bnshy','FEE_ACCRUAL_AT_CA_LEVEL' ,'source_position','accrued_instrument_fees_hy',NULL,'N',NULL);

------------------------------------------------------------------------------
-- CITCO PNL extract fields
------------------------------------------------------------------------------

INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','LONGSHORT'            	,'source_position','position_sign'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','FUND'      				,'source_position','fund'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','STRATEGY'		   		,'source_position','sub_strategy'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','SECURITY_ASSET_NAME'    ,'source_position','instrument_type'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','CITCO_SECURITY_ID'      ,'source_position','instrument_id'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','TRADER'        			,'source_position','strategy'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','COUNTRY_CODE'           ,'source_position','country'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','ISSUE_CCY'      	   	,'source_position','currency'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','SECURITY_DESCRIPTION'   ,'source_position','instrument'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','ISIN'     			   	,'source_position','isin'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','CUSIP'       			,'source_position','cusip'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','SEDOL'           		,'source_position','sedol'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','BLOOMBERG_CODE'         ,'source_position','bloomberg_id'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','BASE_CCY'             	,'source_position','reporting_currency'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','INDUSTRY'       		,'source_position','industry_group'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','INDUSTRY_SECTOR'		,'source_position','industry'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','REGION'     			,'source_position','region'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','EXCHANGE'           	,'source_position','market_name'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','SECURITY_ASSET_CLASS'   ,'source_position','asset_class'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','UNDERLYING_SECURITY_DESCRIPTION','source_position','underlying_instrument'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','PRIME_BROKERCLEARING_BROKER','source_position','broker'            ,NULL,'Y',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','MATURITY_DATE'  		,'source_position','maturity_date'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','OPTION_STRIKE_PRICE'    ,'source_position','strike'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','OPTION_PUTCALL_FLAG'    ,'source_position','call_put'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','OPTION_EXPIRATION_DATE' ,'source_position','expiration_date'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','CONTRACT_SIZE'    		,'source_position','future_contract_value'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','QUANTITY(END)' 			,'source_position','instrument_holding'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','ISSUE_PRICE'     		,'source_position','instrument_price_local'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','ISSUE_AVERAGE_UNIT_COST','source_position','instrument_unit_cost_local'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','BASE_PRICE'    		   	,'source_position','instrument_price'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','BASE_MARKET_VALUE'    	,'source_position','instrument_value'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','DAILY_BASE_PL'          ,'source_position','total_pnl_daily'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','MTD_BASE_PL'  			,'source_position','total_pnl_mtd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','YEARLY_BASE_PL'     	,'source_position','total_pnl_ytd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','DAILY_BASE_INCOME'      ,'source_position','total_income_daily'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','MONTHLY_BASE_INCOME'    ,'source_position','total_income_mtd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','YEARLY_BASE_INCOME'     ,'source_position','total_income_ytd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','BASE_BOND_ACCRUED_INTEREST','source_position','unrealised_acc_interest_daily'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','MTD_BASE_START_BOND_ACCRUED_INTEREST','source_position','unrealised_acc_interest_mtd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','YTD_BASE_START_BOND_ACCRUED_INTEREST','source_position','unrealised_acc_interest_ytd'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','ISSUE_MARKET_VALUE'  	,'source_position','local_market_value'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','SPOT_FX_RATE'     	  	,'source_position','fx_rate'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','TOTAL_FUND_CAPITAL'     ,'source_position','nominal_amount'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','OPTION_DELTA'    		,'source_position','delta'            ,NULL,'N',NULL);
INSERT INTO VCR.FIELD_TARGET_COLUMN (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason) VALUES ('citcopnl','COUPON_RATE'    		,'source_position','book_coupon'            ,NULL,'N',NULL);


insert into vcr.field_target_column  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)  values  ('tranautvcr','FUND','source_position','fund'            ,NULL,'Y',NULL);
insert into vcr.field_target_column  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)  values  ('tranautvcr','STRATEGY','source_position','strategy'            ,NULL,'Y',NULL);  
insert into vcr.field_target_column  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)  values  ('tranautvcr','STRAT','source_position','sub_strategy'            ,NULL,'Y',NULL);    
insert into vcr.field_target_column  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)  values  ('tranautvcr','REGION','source_position','region'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','COUNTRY','source_position','country'            ,NULL,'N',NULL);  
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ASSETCLASS','source_position','instrument_type'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENT','source_position','instrument'            ,NULL,'Y',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTID','source_position','instrument_id'            ,NULL,'Y',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','POSITIONSIGN','source_position','position_sign'            ,NULL,'N',NULL);  
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ISIN','source_position','isin'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ASKPRICE_OPTIONAL','source_position','ask'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ASKSIZE_OPTIONAL','source_position','ask_size'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ASKFLOATRATESWAP_OPTIONAL','source_position','ask_floating_rate_swap'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BASISSWAPINDEXPAY_OPTIONAL','source_position','basis_swap_index_pay'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BASISSWAPINDEXRECEIVE_OPTIONAL','source_position','basis_swap_index_receive'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BLOOMBERGDATEOFPRICE_OPTIONAL','source_position','bb_date_of_price'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BIDPRICE_OPTIONAL','source_position','bid'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BIDSIZE_OPTIONAL','source_position','bid_size'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BIDFLOATRATESWAP_OPTIONAL','source_position','bid_floating_rate_swap'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BLOOMBERGID','source_position','bloomberg_id'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','BROKER','source_position','broker'            ,NULL,'Y',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','CALLPUT_OPTIONAL','source_position','call_put'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','COUNTERPARTY','source_position','counterparty'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','CURRENCY','source_position','currency'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','CUSIP','source_position','cusip'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','DAILYTRADES_OPTIONAL','source_position','daily_trades'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','DAILYTURNOVERS_OPTIONAL','source_position','daily_turnovers'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','DATEOFPRICE','source_position','date_of_price'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','DELTA','source_position','delta'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','EXPIRATIONDATE_OPTIONAL','source_position','expiration_date'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','FIRSTCALLORPUTDATE_OPTIONAL','source_position','first_call_or_put_date'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','FUTURESCATEGORY','source_position','futures_category'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','FUTURECONTRACTVALUE','source_position','future_contract_value'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','FXRATE','source_position','fx_rate'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INDUSTRY','source_position','industry'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INDUSTRYCLASSIFICATION_OPTIONAL','source_position','industry_classification'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INDUSTRYGROUP','source_position','industry_group'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTHOLDING','source_position','instrument_holding'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTPRICE','source_position','instrument_price'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTPRICELOCAL','source_position','instrument_price_local'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTUNITCOSTLOCAL','source_position','instrument_unit_cost_local'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','INSTRUMENTVALUE','source_position','instrument_value'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','ISSUERNAME_OPTIONAL','source_position','issuer_name'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','LASTPRICE_OPTIONAL','source_position','last'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','LOCALMARKETVALUE','source_position','local_market_value'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MARKETCAPITALIZATION_OPTIONAL','source_position','market_capitalisation'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MARKETINDEXNAME_OPTIONAL','source_position','market_index_name'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MARKETNAME_OPTIONAL','source_position','market_name'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MATURITYDATE','source_position','maturity_date'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MATURITYBUCKET_OPTIONAL','source_position','maturity_bucket'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','MATURITYBUCKETDETAIL_OPTIONAL','source_position','maturity_bucket_detail'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','NOMINALAMOUNT','source_position','nominal_amount'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','OPTIONMULTIPLIER_OPTIONAL','source_position','option_multiplyer'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','PRICESOURCE','source_position','price_source'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','RATINGBLOOMBERG_OPTIONAL','source_position','rating_bloomberg'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','RATINGCATEGORY_OPTIONAL','source_position','rating_category'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','RATINGMOODY_OPTIONAL','source_position','rating_moody'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','RATINGSANDP_OPTIONAL','source_position','rating_sp'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTDAILY_OPTIONAL','source_position','realised_acc_interest_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTMTD_OPTIONAL','source_position','realised_acc_interest_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDACCRUEDINTERESTYTD_OPTIONAL','source_position','realised_acc_interest_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDDIVIDENDSDAILY_OPTIONAL','source_position','realised_dividends_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDDIVIDENDSMTD_OPTIONAL','source_position','realised_dividends_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDDIVIDENDSYTD_OPTIONAL','source_position','realised_dividends_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDFXDAILY_OPTIONAL','source_position','realised_fx_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDFXMTD_OPTIONAL','source_position','realised_fx_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEDFXYTD_OPTIONAL','source_position','realised_fx_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEMARKTOMARKETDAILY_OPTIONAL','source_position','realised_mtm_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEMARKTOMARKETMTD_OPTIONAL','source_position','realised_mtm_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REALIZEMARKTOMARKETYTD_OPTIONAL','source_position','realised_mtm_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','REPORTINGCURRENCY','source_position','reporting_currency'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','SECTOR','source_position','sector'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','SEDOL','source_position','sedol'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','SHARESOUTSTANDING_OPTIONAL','source_position','shares_outstanding'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','STRIKE_OPTIONAL','source_position','strike'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALFXDAILY_OPTIONAL','source_position','total_fx_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALFXMTD_OPTIONAL','source_position','total_fx_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALFXYTD_OPTIONAL','source_position','total_fx_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALDAILYINCOME','source_position','total_income_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMTDINCOME','source_position','total_income_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALYTDINCOME','source_position','total_income_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMISCREVANDEXPDAILY_OPTIONAL','source_position','total_misc_rev_exp_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMISCREVANDEXPMTD_OPTIONAL','source_position','total_misc_rev_exp_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMISCREVANDEXPYTD_OPTIONAL','source_position','total_misc_rev_exp_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMARKTOMARKETDAILY_OPTIONAL','source_position','total_mtm_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMARKTOMARKETMTD_OPTIONAL','source_position','total_mtm_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMARKTOMARKETYTD_OPTIONAL','source_position','total_mtm_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALDAILYPNL','source_position','total_pnl_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALMTDPNL','source_position','total_pnl_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','TOTALYTDPNL','source_position','total_pnl_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNDERLYINGBASEINSTRUMENT','source_position','underlying_base_instrument'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNDERLYINGINSTRUMENT','source_position','underlying_instrument'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNDERLYINGPRICE_OPTIONAL','source_position','underlying_price'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNDERLYINGSWAPTENOR_OPTIONAL','source_position','underlying_swap_tenor'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTDAILY_OPTIONAL','source_position','unrealised_acc_interest_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTMTD_OPTIONAL','source_position','unrealised_acc_interest_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDACCRUEDINTERESTYTD_OPTIONAL','source_position','unrealised_acc_interest_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSDAILY_OPTIONAL','source_position','unrealised_dividends_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSMTD_OPTIONAL','source_position','unrealised_dividends_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDDIVIDENDSYTD_OPTIONAL','source_position','unrealised_dividends_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDFXDAILY_OPTIONAL','source_position','unrealised_fx_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDFXMTD_OPTIONAL','source_position','unrealised_fx_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEDFXYTD_OPTIONAL','source_position','unrealised_fx_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETDAILY_OPTIONAL','source_position','unrealised_mtm_daily'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETMTD_OPTIONAL','source_position','unrealised_mtm_mtd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','UNREALIZEMARKTOMARKETYTD_OPTIONAL','source_position','unrealised_mtm_ytd'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','VOLUME_OPTIONAL','source_position','volume'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','YIELDCURVENAME_OPTIONAL','source_position','yield_curve_name'            ,NULL,'N',NULL);
insert into vcr.field_target_column
  (file_type,field_name,table_name,column_name,accounting_period,in_unique_key,change_reason)
  values
  ('tranautvcr','YIELDCURVETYPE_OPTIONAL','source_position','yield_curve_type'            ,NULL,'N',NULL);

commit;

alter table vcr.field_target_column enable constraint FK_FTC_FILE_TYPE_FIELD;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

