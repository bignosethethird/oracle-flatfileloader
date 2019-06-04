------------------------------------------------------------------------------
-- $Header: vcr/data/ie_instrument_type.sql 1.2.1.2 2005/08/16 17:05:28BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.ie_instrument_type.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @ie_instrument_type.sql
-- This file was generated from database instance VCRU1.
--   Database Time    : 07APR2005 10:49:47
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.ie_instrument_type.

-- empty the table:
delete from vcr.ie_instrument_type;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

-- MGS values

insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'BASIS_SWAP',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'BOND',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'BOND_FUTURE',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'BOND_FUTURE_OPTION',
      'MGS',
      'Initial UAT mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'BOND_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CAPFLOOR',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CASHFLOW',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CFD_EQUITY',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CONVERT_ASSETSWAP_OPT',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CONVERT_TRRSWAP',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CONVERTIBLE_BOND',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'CONVERTIBLE_PREFERRED',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'DEFAULT_SWAP',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EQUITY',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EQUITY_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EQUITY_SWAP',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EQUITY_WARRANT',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FRA',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FRN',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_FORWARD',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_FUTURE',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_FUTURE_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_PAIR',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX_SWAP',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'IAM',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'INDEX_FUTURE',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'INDEX_FUTURE_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'INDEX_LINKER',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'INDEX_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'IR_FUTURE',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'IR_FUTURE_OPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'IRS',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'REPO',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'SECURITIES_LENDING',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'SWAPTION',
      'MGS',
      'Initial UAT Mapping'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'UNKNOWN',
      'MGS',
      'Initial UAT Mapping'
      );
-- RMF types

insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Amortizing Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Asset Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Debt',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Deposit',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Loan',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bankers Acceptance',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Basis Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Future Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Index',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Callable Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cap/Floor',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cash',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Certificate of Deposit',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collar',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Bond Obligation',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Debt Obligation',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Loan Obligation',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Mortgage Obligation',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commercial Paper',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Call Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Future Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Put Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Common Stock',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Contract for Difference',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Preferred',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Stock',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Corporate Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Crack Spread Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Credit Default Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Credit Spread Options',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Currency Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Defaulted Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Depositary Receipt',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Distressed Security',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Call Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Contract For Difference',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Default Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Call Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Put Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Put Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Right',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Stock Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Warrant',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EuroCCY Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Exchange Traded Fund',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Financing',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Fixed Rate Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Floating Rate Note',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Floor',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Forward Rate Agreement',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Forward Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Future Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Call Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Contract For Difference',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Forward',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Put Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Call Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Contract For Difference',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Linked Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Put Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Interest Rate Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Interest Rate Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Loan',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Money Market Future',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Money Market Future Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - IO',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - PO',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - TBA',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Municipal Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Option',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Overnight Index Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Preferred Stock',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Private Placement',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Real Estate Investment Trust',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Repo',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Repo/Reverse Repo',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Reverse Repo',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Swaption',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Total Return Swap',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Treasury Bill',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Treasury Bond',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Warrant',
      'RMF',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Zero Coupon Bond',
      'RMF',
      'Data setup'
      );
-- Glenwood types

insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Amortizing Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Asset Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Debt',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Deposit',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bank Loan',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bankers Acceptance',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Basis Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Future Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Index',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Bond Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Callable Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cap/Floor',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Cash',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Certificate of Deposit',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collar',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Bond Obligation',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Debt Obligation',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Loan Obligation',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Collateralized Mortgage Obligation',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commercial Paper',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Call Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Future Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Put Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Commodity Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Common Stock',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Contract for Difference',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Preferred',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Convertible Stock',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Corporate Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Crack Spread Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Credit Default Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Credit Spread Options',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Currency Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Defaulted Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Depositary Receipt',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Distressed Security',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Call Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Contract For Difference',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Default Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Call Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Put Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Index Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Put Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Right',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Stock Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Equity Warrant',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'EuroCCY Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Exchange Traded Fund',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Financing',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Fixed Rate Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Floating Rate Note',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Floor',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Forward Rate Agreement',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Forward Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Future Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Call Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Contract For Difference',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Forward',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'FX Put Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Call Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Contract For Difference',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Linked Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Index Put Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Interest Rate Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Interest Rate Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Loan',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Money Market Future',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Money Market Future Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - IO',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - PO',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Mortgage Backed Security - TBA',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Municipal Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Option',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Overnight Index Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Preferred Stock',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Private Placement',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Real Estate Investment Trust',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Repo',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Repo/Reverse Repo',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Reverse Repo',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Swaption',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Total Return Swap',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Treasury Bill',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Treasury Bond',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Warrant',
      'Glenwood',
      'Data setup'
      );
insert into vcr.ie_instrument_type
      (IE_INSTRUMENT_TYPE_ID,IE_INSTRUMENT_TYPE,IE_ID,CHANGE_REASON)
values(vcr.sq_ie_instrument_type.nextval,
      'Zero Coupon Bond',
      'Glenwood',
      'Data setup'
      );
commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

