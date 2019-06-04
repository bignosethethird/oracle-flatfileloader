------------------------------------------------------------------------------
-- $Header: vcr/tables/source_position.sql 1.11.1.2.1.8 2005/08/23 12:25:38BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_POSITION
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:47
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_position.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_POSITION

-- Drop table if it already exists
-- Note that the contents of the table will also be deleted
--  and that referential constraints will also be dropped.
-- You will be warned when this happens.
declare 
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'TABLE'
     and owner = upper('VCR')
     and object_name = upper('SOURCE_POSITION');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_POSITION already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_POSITION';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_POSITION cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_POSITION
(
  SOURCE_ID                       NUMBER     not null
, AS_OF_DATE                      DATE       not null
, BASIS                           VARCHAR2  (30) not null
, KEY                             VARCHAR2  (4000) not null
, POSITION_SIGN                   VARCHAR2  (2000)
, LOAD_RUN_ID                     NUMBER     not null
, FILE_ID                         VARCHAR2  (30) not null
, FUND                            VARCHAR2  (2000)
, SUB_STRATEGY                    VARCHAR2  (2000)
, INSTRUMENT_TYPE                 VARCHAR2  (2000)
, INSTRUMENT_ID                   VARCHAR2  (2000)
, STRATEGY                        VARCHAR2  (2000)
, COUNTRY                         VARCHAR2  (2000)
, CURRENCY                        VARCHAR2  (2000)
, INSTRUMENT                      VARCHAR2  (2000)
, ISIN                            VARCHAR2  (2000)
, CUSIP                           VARCHAR2  (2000)
, SEDOL                           VARCHAR2  (2000)
, BLOOMBERG_ID                    VARCHAR2  (2000)
, REPORTING_CURRENCY              VARCHAR2  (2000)
, INDUSTRY_CLASSIFICATION         VARCHAR2  (2000)
, INDUSTRY_GROUP                  VARCHAR2  (2000)
, INDUSTRY                        VARCHAR2  (2000)
, SECTOR                          VARCHAR2  (2000)
, REGION                          VARCHAR2  (2000)
, YIELD_CURVE_NAME                VARCHAR2  (2000)
, MARKET_INDEX_NAME               VARCHAR2  (2000)
, MARKET_NAME                     VARCHAR2  (2000)
, YIELD_CURVE_TYPE                VARCHAR2  (2000)
, ISSUER_NAME                     VARCHAR2  (2000)
, RATING_BLOOMBERG                VARCHAR2  (2000)
, RATING_MOODY                    VARCHAR2  (2000)
, RATING_SP                       VARCHAR2  (2000)
, RATING_CATEGORY                 VARCHAR2  (2000)
, ASSET_CLASS                     VARCHAR2  (2000)
, MATURITY_BUCKET                 VARCHAR2  (2000)
, MATURITY_BUCKET_DETAIL          VARCHAR2  (2000)
, UNDERLYING_INSTRUMENT           VARCHAR2  (2000)
, UNDERLYING_BASE_INSTRUMENT      VARCHAR2  (2000)
, UNDERLYING_SWAP_TENOR           VARCHAR2  (2000)
, PRICE_SOURCE                    VARCHAR2  (2000)
, BROKER                          VARCHAR2  (2000)
, FUTURES_CATEGORY                VARCHAR2  (2000)
, MATURITY_DATE                   DATE      
, STRIKE                          VARCHAR2  (2000)
, CALL_PUT                        VARCHAR2  (2000)
, EXPIRATION_DATE                 DATE      
, OPTION_MULTIPLYER               VARCHAR2  (2000)
, FIRST_CALL_OR_PUT_DATE          DATE      
, COUNTERPARTY                    VARCHAR2  (2000)
, BASIS_SWAP_INDEX_PAY            VARCHAR2  (2000)
, BASIS_SWAP_INDEX_RECEIVE        VARCHAR2  (2000)
, BID_FLOATING_RATE_SWAP          VARCHAR2  (2000)
, ASK_FLOATING_RATE_SWAP          VARCHAR2  (2000)
, FUTURE_CONTRACT_VALUE           NUMBER    
, INSTRUMENT_HOLDING              NUMBER    
, INSTRUMENT_PRICE_LOCAL          NUMBER    
, INSTRUMENT_UNIT_COST_LOCAL      NUMBER    
, INSTRUMENT_PRICE                NUMBER    
, INSTRUMENT_VALUE                NUMBER    
, TOTAL_PNL_DAILY                 NUMBER    
, TOTAL_PNL_MTD                   NUMBER    
, TOTAL_PNL_YTD                   NUMBER    
, TOTAL_INCOME_DAILY              NUMBER    
, TOTAL_INCOME_MTD                NUMBER    
, TOTAL_INCOME_YTD                NUMBER    
, UNREALISED_DIVIDENDS_DAILY      NUMBER    
, UNREALISED_DIVIDENDS_MTD        NUMBER    
, UNREALISED_DIVIDENDS_YTD        NUMBER    
, UNREALISED_ACC_INTEREST_DAILY   NUMBER    
, UNREALISED_ACC_INTEREST_MTD     NUMBER    
, UNREALISED_ACC_INTEREST_YTD     NUMBER    
, REALISED_DIVIDENDS_DAILY        NUMBER    
, REALISED_DIVIDENDS_MTD          NUMBER    
, REALISED_DIVIDENDS_YTD          NUMBER    
, REALISED_ACC_INTEREST_DAILY     NUMBER    
, REALISED_ACC_INTEREST_MTD       NUMBER    
, REALISED_ACC_INTEREST_YTD       NUMBER    
, TOTAL_MTM_DAILY                 NUMBER    
, TOTAL_MTM_MTD                   NUMBER    
, TOTAL_MTM_YTD                   NUMBER    
, TOTAL_FX_DAILY                  NUMBER    
, TOTAL_FX_MTD                    NUMBER    
, TOTAL_FX_YTD                    NUMBER    
, TOTAL_MISC_REV_EXP_DAILY        NUMBER    
, TOTAL_MISC_REV_EXP_MTD          NUMBER    
, TOTAL_MISC_REV_EXP_YTD          NUMBER    
, REALISED_MTM_DAILY              NUMBER    
, REALISED_MTM_MTD                NUMBER    
, REALISED_MTM_YTD                NUMBER    
, REALISED_FX_DAILY               NUMBER    
, REALISED_FX_MTD                 NUMBER    
, REALISED_FX_YTD                 NUMBER    
, UNREALISED_MTM_DAILY            NUMBER    
, UNREALISED_MTM_MTD              NUMBER    
, UNREALISED_MTM_YTD              NUMBER    
, UNREALISED_FX_DAILY             NUMBER    
, UNREALISED_FX_MTD               NUMBER    
, UNREALISED_FX_YTD               NUMBER    
, LOCAL_MARKET_VALUE              NUMBER    
, DATE_OF_PRICE                   DATE      
, BB_DATE_OF_PRICE                DATE      
, BID                             NUMBER    
, ASK                             NUMBER    
, LAST                            NUMBER    
, SHARES_OUTSTANDING              NUMBER    
, MARKET_CAPITALISATION           NUMBER    
, VOLUME                          NUMBER    
, BID_SIZE                        NUMBER    
, ASK_SIZE                        NUMBER    
, DAILY_TRADES                    NUMBER    
, DAILY_TURNOVERS                 NUMBER    
, FX_RATE                         NUMBER    
, NOMINAL_AMOUNT                  NUMBER    
, DELTA                           NUMBER    
, UNDERLYING_PRICE                NUMBER    
, TAX_LOT_ID                      VARCHAR2  (4000)
, SEQ_ID                          NUMBER     default 1  not null
, TRANSACTION_ID                  VARCHAR2  (4000)
, FILE_TYPE                       VARCHAR2  (30) not null
, BEG_BOOK_ACC_INTEREST           NUMBER    
, BOOK_COUPON                     NUMBER    
, BOOK_UNREALISED_INCOME          NUMBER    
, END_LOCAL_COST                  NUMBER    
, INVALID_TYPE_ATTRIBUTES         VARCHAR2  (4000)
, UNMAPPED_ATTRIBUTES             VARCHAR2  (4000)
, POS_ADJUSTED_DELTA              NUMBER    
, DELTA_VALUE_K                   NUMBER    
, EXPOSURE                        NUMBER    
, TOTAL_INCOME_MTD_LOCAL          NUMBER    
, YIELD_TO_MATURITY               NUMBER    
, MODIFIED_DURATION               NUMBER    
, YIELD_TO_WORST                  NUMBER    
, RULE_144A                       VARCHAR2  (2000)
, PRIVATE_PLACEMENT               VARCHAR2  (2000)
, RATING_FITCH                    VARCHAR2  (2000)
, CURRENT_YIELD                   NUMBER    
, INTEREST_RATE                   NUMBER    
)
  partition by RANGE(AS_OF_DATE)(
    partition AUG_01_05 values less than (TO_DATE(' 2005-08-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_01_05_1 values (1)
      , partition AUG_01_05_2 values (2)
      , partition AUG_01_05_3 values (3)
      , partition AUG_01_05_4 values (4)
      , partition AUG_01_05_5 values (5)
      , partition AUG_01_05_6 values (6)
      , partition AUG_01_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_02_05 values less than (TO_DATE(' 2005-08-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_02_05_1 values (1)
      , partition AUG_02_05_2 values (2)
      , partition AUG_02_05_3 values (3)
      , partition AUG_02_05_4 values (4)
      , partition AUG_02_05_5 values (5)
      , partition AUG_02_05_6 values (6)
      , partition AUG_02_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_03_05 values less than (TO_DATE(' 2005-08-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_03_05_1 values (1)
      , partition AUG_03_05_2 values (2)
      , partition AUG_03_05_3 values (3)
      , partition AUG_03_05_4 values (4)
      , partition AUG_03_05_5 values (5)
      , partition AUG_03_05_6 values (6)
      , partition AUG_03_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_04_05 values less than (TO_DATE(' 2005-08-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_04_05_1 values (1)
      , partition AUG_04_05_2 values (2)
      , partition AUG_04_05_3 values (3)
      , partition AUG_04_05_4 values (4)
      , partition AUG_04_05_5 values (5)
      , partition AUG_04_05_6 values (6)
      , partition AUG_04_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_05_05 values less than (TO_DATE(' 2005-08-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_05_05_1 values (1)
      , partition AUG_05_05_2 values (2)
      , partition AUG_05_05_3 values (3)
      , partition AUG_05_05_4 values (4)
      , partition AUG_05_05_5 values (5)
      , partition AUG_05_05_6 values (6)
      , partition AUG_05_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_08_05 values less than (TO_DATE(' 2005-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_08_05_1 values (1)
      , partition AUG_08_05_2 values (2)
      , partition AUG_08_05_3 values (3)
      , partition AUG_08_05_4 values (4)
      , partition AUG_08_05_5 values (5)
      , partition AUG_08_05_6 values (6)
      , partition AUG_08_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_09_05 values less than (TO_DATE(' 2005-08-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_09_05_1 values (1)
      , partition AUG_09_05_2 values (2)
      , partition AUG_09_05_3 values (3)
      , partition AUG_09_05_4 values (4)
      , partition AUG_09_05_5 values (5)
      , partition AUG_09_05_6 values (6)
      , partition AUG_09_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_10_05 values less than (TO_DATE(' 2005-08-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_10_05_1 values (1)
      , partition AUG_10_05_2 values (2)
      , partition AUG_10_05_3 values (3)
      , partition AUG_10_05_4 values (4)
      , partition AUG_10_05_5 values (5)
      , partition AUG_10_05_6 values (6)
      , partition AUG_10_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_11_05 values less than (TO_DATE(' 2005-08-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_11_05_1 values (1)
      , partition AUG_11_05_2 values (2)
      , partition AUG_11_05_3 values (3)
      , partition AUG_11_05_4 values (4)
      , partition AUG_11_05_5 values (5)
      , partition AUG_11_05_6 values (6)
      , partition AUG_11_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_12_05 values less than (TO_DATE(' 2005-08-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_12_05_1 values (1)
      , partition AUG_12_05_2 values (2)
      , partition AUG_12_05_3 values (3)
      , partition AUG_12_05_4 values (4)
      , partition AUG_12_05_5 values (5)
      , partition AUG_12_05_6 values (6)
      , partition AUG_12_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_15_05 values less than (TO_DATE(' 2005-08-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_15_05_1 values (1)
      , partition AUG_15_05_2 values (2)
      , partition AUG_15_05_3 values (3)
      , partition AUG_15_05_4 values (4)
      , partition AUG_15_05_5 values (5)
      , partition AUG_15_05_6 values (6)
      , partition AUG_15_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_16_05 values less than (TO_DATE(' 2005-08-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_16_05_1 values (1)
      , partition AUG_16_05_2 values (2)
      , partition AUG_16_05_3 values (3)
      , partition AUG_16_05_4 values (4)
      , partition AUG_16_05_5 values (5)
      , partition AUG_16_05_6 values (6)
      , partition AUG_16_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_17_05 values less than (TO_DATE(' 2005-08-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_17_05_1 values (1)
      , partition AUG_17_05_2 values (2)
      , partition AUG_17_05_3 values (3)
      , partition AUG_17_05_4 values (4)
      , partition AUG_17_05_5 values (5)
      , partition AUG_17_05_6 values (6)
      , partition AUG_17_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_18_05 values less than (TO_DATE(' 2005-08-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_18_05_1 values (1)
      , partition AUG_18_05_2 values (2)
      , partition AUG_18_05_3 values (3)
      , partition AUG_18_05_4 values (4)
      , partition AUG_18_05_5 values (5)
      , partition AUG_18_05_6 values (6)
      , partition AUG_18_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition AUG_19_05 values less than (TO_DATE(' 2005-08-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_19_05_1 values (1)
      , partition AUG_19_05_2 values (2)
      , partition AUG_19_05_3 values (3)
      , partition AUG_19_05_4 values (4)
      , partition AUG_19_05_5 values (5)
      , partition AUG_19_05_6 values (6)
      )
      tablespace VCR_DATA_MED
  , partition AUG_22_05 values less than (TO_DATE(' 2005-08-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition AUG_22_05_1 values (1)
      , partition AUG_22_05_2 values (2)
      , partition AUG_22_05_3 values (3)
      , partition AUG_22_05_4 values (4)
      , partition AUG_22_05_5 values (5)
      , partition AUG_22_05_6 values (6)
      )
      tablespace VCR_DATA_MED
  , partition JUL_27_05 values less than (TO_DATE(' 2005-07-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition JUL_27_05_1 values (1)
      , partition JUL_27_05_2 values (2)
      , partition JUL_27_05_3 values (3)
      , partition JUL_27_05_4 values (4)
      , partition JUL_27_05_5 values (5)
      , partition JUL_27_05_6 values (6)
      , partition JUL_27_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition JUL_28_05 values less than (TO_DATE(' 2005-07-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition JUL_28_05_1 values (1)
      , partition JUL_28_05_2 values (2)
      , partition JUL_28_05_3 values (3)
      , partition JUL_28_05_4 values (4)
      , partition JUL_28_05_5 values (5)
      , partition JUL_28_05_6 values (6)
      , partition JUL_28_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  , partition JUL_29_05 values less than (TO_DATE(' 2005-07-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
      subpartition by (AS_OF_DATE)(
        partition JUL_29_05_1 values (1)
      , partition JUL_29_05_2 values (2)
      , partition JUL_29_05_3 values (3)
      , partition JUL_29_05_4 values (4)
      , partition JUL_29_05_5 values (5)
      , partition JUL_29_05_6 values (6)
      , partition JUL_29_05_9 values (9)
      )
      tablespace VCR_DATA_MED
  )
;
 
------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.SOURCE_POSITION.SOURCE_ID is
  'id of source position is from';
comment on column VCR.SOURCE_POSITION.AS_OF_DATE is
  'date of valuation';
comment on column VCR.SOURCE_POSITION.BASIS is
  'version of position';
comment on column VCR.SOURCE_POSITION.KEY is
  'delimited name/value pairs that constitute uk of position with source_id, as_of_date, basis';
comment on column VCR.SOURCE_POSITION.LOAD_RUN_ID is
  'run this positions was loaded in';
comment on column VCR.SOURCE_POSITION.FILE_ID is
  'file id of file this position was loaded in';
comment on column VCR.SOURCE_POSITION.SEQ_ID is
  'if multiple source positions exist for the same key value this numeric sequence defines each unique position';
 
------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_POSITION
  add constraint PK_SOURCE_POSITION
  primary key (SOURCE_ID,AS_OF_DATE,BASIS,KEY,SEQ_ID)
  using index
  local
  (
    partition AUG_01_05 tablespace 'VCR_DATA_MED'
,   partition AUG_02_05 tablespace 'VCR_DATA_MED'
,   partition AUG_03_05 tablespace 'VCR_DATA_MED'
,   partition AUG_04_05 tablespace 'VCR_DATA_MED'
,   partition AUG_05_05 tablespace 'VCR_DATA_MED'
,   partition AUG_08_05 tablespace 'VCR_DATA_MED'
,   partition AUG_09_05 tablespace 'VCR_DATA_MED'
,   partition AUG_10_05 tablespace 'VCR_DATA_MED'
,   partition AUG_11_05 tablespace 'VCR_DATA_MED'
,   partition AUG_12_05 tablespace 'VCR_DATA_MED'
,   partition AUG_15_05 tablespace 'VCR_DATA_MED'
,   partition AUG_16_05 tablespace 'VCR_DATA_MED'
,   partition AUG_17_05 tablespace 'VCR_DATA_MED'
,   partition AUG_18_05 tablespace 'VCR_DATA_MED'
,   partition AUG_19_05 tablespace 'VCR_DATA_MED'
,   partition AUG_22_05 tablespace 'VCR_DATA_MED'
,   partition JUL_27_05 tablespace 'VCR_DATA_MED'
,   partition JUL_28_05 tablespace 'VCR_DATA_MED'
,   partition JUL_29_05 tablespace 'VCR_DATA_MED'
  )
;
 
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_POSITION
  add constraint FK_POSITION_LOAD_RUN_FILE
  foreign key (LOAD_RUN_ID,FILE_TYPE,FILE_ID)
  references VCR.SOURCE_LOAD_RUN_FILE(LOAD_RUN_ID,FILE_TYPE,FILE_ID)
;
alter table VCR.SOURCE_POSITION
  add constraint FK_SOURCE_POSITION_BASIS
  foreign key (BASIS)
  references VCR.SOURCE_BASIS(BASIS)
;
alter table VCR.SOURCE_POSITION
  add constraint FK_SOURCE_POSITION_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
 
------------------------------------------------------------------------------
-- Create/Recreate indexes 
------------------------------------------------------------------------------
create index VCR.IX_SOURCE_POSITION_FILE on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,LOAD_RUN_ID,FILE_ID)
  local
  (
    partition JUL_27_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_28_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_29_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_01_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_02_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_03_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_04_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_05_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_08_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_09_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_10_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_11_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_12_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_15_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_16_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_17_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_18_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_19_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_22_05 tablespace VCR_IDX_MED
    (
      )
  )
;
create index VCR.IX_SOURCE_POSITION_FUND on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,BASIS,FUND)
  local
  (
    partition JUL_27_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_28_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_29_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_01_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_02_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_03_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_04_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_05_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_08_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_09_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_10_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_11_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_12_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_15_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_16_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_17_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_18_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_19_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_22_05 tablespace VCR_IDX_MED
    (
      )
  )
;
create index VCR.IX_SOURCE_POSITION_STRATEGY on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,BASIS,FUND,STRATEGY)
  local
  (
    partition JUL_27_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_28_05 tablespace VCR_IDX_MED
    (
      )
  , partition JUL_29_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_01_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_02_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_03_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_04_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_05_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_08_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_09_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_10_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_11_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_12_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_15_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_16_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_17_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_18_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_19_05 tablespace VCR_IDX_MED
    (
      )
  , partition AUG_22_05 tablespace VCR_IDX_MED
    (
      )
  )
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

