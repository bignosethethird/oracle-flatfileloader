------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_exception.sql 1.3.1.3.1.1 2005/08/23 13:39:37BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.LIMIT_EXCEPTION
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22APR2005 10:59:05
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_exception.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.LIMIT_EXCEPTION

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
     and object_name = upper('LIMIT_EXCEPTION');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_EXCEPTION already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_EXCEPTION';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_EXCEPTION cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.LIMIT_EXCEPTION
(
  SOURCE_ID                       NUMBER    (22) not null
, AS_OF_DATE                      DATE       not null
, BASIS                           VARCHAR2  (30) not null
, EXCEPTION_ID                    NUMBER    (22) not null
, LOAD_RUN_ID                     NUMBER    (22) not null
, LIMIT_ID                        NUMBER    (22) not null
, LIMIT_VERSION                   NUMBER    (22) not null
, KEY                             VARCHAR2  (4000)
, PRIOR_AS_OF_DATE                DATE
, SOURCE_FUND_ID                  NUMBER    (22)
, SOURCE_BROKER_ID                NUMBER    (22)
, SOURCE_STRATEGY_ID              NUMBER    (22)
, SOURCE_INSTRUMENT_TYPE_ID       NUMBER    (22)
, SUB_STRATEGY                    VARCHAR2  (2000)
, CURRENCY                        VARCHAR2  (2000)
, INSTRUMENT                      VARCHAR2  (2000)
, INSTRUMENT_ID                   VARCHAR2  (2000)
, CURRENT_INSTRUMENT_HOLDING      NUMBER
, CURRENT_INSTRUMENT_PRICE_LOCAL  NUMBER
, CURRENT_INSTRUMENT_VALUE        NUMBER
, CURRENT_PNL_MTD                 NUMBER
, CURRENT_BB_PRICE                NUMBER
, PRIOR_INSTRUMENT_HOLDING        NUMBER
, PRIOR_INSTRUMENT_PRICE_LOCAL    NUMBER
, PRIOR_INSTRUMENT_VALUE          NUMBER
, PRIOR_PNL_MTD                   NUMBER
, PRIOR_BB_PRICE                  NUMBER
, CURRENT_MONTH_NOTIONAL          NUMBER
, DAILY_PNL_CHANGE                NUMBER
, VALIDATION_MEASURE_VALUE        NUMBER
, CLASS                           VARCHAR2  (20)
, TYPE                            VARCHAR2  (20) not null
, STATUS                          VARCHAR2  (10) not null
, EXCEPTION_DESCRIPTION           VARCHAR2  (500)
, RESOLUTION_DATE                 DATE
, RESOLUTION_DESCRIPTION          VARCHAR2  (500)
, RESOLUTION_USER                 VARCHAR2  (30)
, LAST_UPDATED_DATE               DATE
, LAST_UPDATED_BY                 VARCHAR2  (100)
, COMMENTS                        VARCHAR2  (500)
, ACTION_DESCRIPTION              VARCHAR2  (500)
, SEQ_ID                          NUMBER    (22),
  TO_BE_RESOLVED_IND              CHAR(1) default 'N' not null
)
PARTITION BY RANGE (as_of_date)
SUBPARTITION BY LIST (source_id)
(
  PARTITION MAY_05_05 VALUES LESS THAN (TO_DATE('05-MAY-2005', 'DD-MON-YYYY'))
  (
    SUBPARTITION MAY_05_05_1 VALUES (1),
    SUBPARTITION MAY_05_05_2 VALUES (2),
    SUBPARTITION MAY_05_05_3 VALUES (3),
    SUBPARTITION MAY_05_05_4 VALUES (4),
    SUBPARTITION MAY_05_05_5 VALUES (5),
    SUBPARTITION MAY_05_05_6 VALUES (6),
    SUBPARTITION MAY_05_05_7 VALUES (7),
    SUBPARTITION MAY_05_05_8 VALUES (8),
    SUBPARTITION MAY_05_05_9 VALUES (9),
    SUBPARTITION MAY_05_05_10 VALUES (10)
  )
) TABLESPACE VCR_DATA_MED
;

------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------
comment on column VCR.LIMIT_EXCEPTION.SOURCE_ID is
  'source of data that caused exception';
comment on column VCR.LIMIT_EXCEPTION.AS_OF_DATE is
  'as of date of data that caused exception';
comment on column VCR.LIMIT_EXCEPTION.BASIS is
  'basis of data that caused exception';
comment on column VCR.LIMIT_EXCEPTION.EXCEPTION_ID is
  'allocated from sequence';
comment on column VCR.LIMIT_EXCEPTION.LIMIT_ID is
  'limit exception is for';
comment on column VCR.LIMIT_EXCEPTION.LIMIT_VERSION is
  'limit version exception is for';
comment on column VCR.LIMIT_EXCEPTION.KEY is
  'if position level exception this key defines which position it is for in conjunction with seq_id';
comment on column VCR.LIMIT_EXCEPTION.PRIOR_AS_OF_DATE is
  'as of date that prior figures have been obtained for';
comment on column VCR.LIMIT_EXCEPTION.SOURCE_FUND_ID is
  'related fund';
comment on column VCR.LIMIT_EXCEPTION.SOURCE_BROKER_ID is
  'related broker';
comment on column VCR.LIMIT_EXCEPTION.SOURCE_STRATEGY_ID is
  'related strategy';
comment on column VCR.LIMIT_EXCEPTION.SOURCE_INSTRUMENT_TYPE_ID is
  'related instrument type';
comment on column VCR.LIMIT_EXCEPTION.SUB_STRATEGY is
  'sub strategy of position level exception';
comment on column VCR.LIMIT_EXCEPTION.CURRENCY is
  'currency of position level exception';
comment on column VCR.LIMIT_EXCEPTION.INSTRUMENT is
  'instrument description of position level exception';
comment on column VCR.LIMIT_EXCEPTION.INSTRUMENT_ID is
  'instrument id of position level exception';
comment on column VCR.LIMIT_EXCEPTION.CURRENT_INSTRUMENT_HOLDING is
  'instrument holding for current as of date';
comment on column VCR.LIMIT_EXCEPTION.CURRENT_INSTRUMENT_PRICE_LOCAL is
  'instrument price in local currency for current as of date';
comment on column VCR.LIMIT_EXCEPTION.CURRENT_INSTRUMENT_VALUE is
  'instrument_value for current as of date';
comment on column VCR.LIMIT_EXCEPTION.CURRENT_PNL_MTD is
  'total_pnl_mtd for current as of date';
comment on column VCR.LIMIT_EXCEPTION.PRIOR_INSTRUMENT_HOLDING is
  'instrument holding for prior as of date';
comment on column VCR.LIMIT_EXCEPTION.PRIOR_INSTRUMENT_PRICE_LOCAL is
  'instrument price in local currency for prior as of date';
comment on column VCR.LIMIT_EXCEPTION.PRIOR_INSTRUMENT_VALUE is
  'instrument_value for prior as of date';
comment on column VCR.LIMIT_EXCEPTION.PRIOR_PNL_MTD is
  'total_pnl_mtd for prior as of date';
comment on column VCR.LIMIT_EXCEPTION.CURRENT_MONTH_NOTIONAL is
  'notional assigned to fund for the current month';
comment on column VCR.LIMIT_EXCEPTION.DAILY_PNL_CHANGE is
  'change in total_pnl_daily between current and prior as of date';
comment on column VCR.LIMIT_EXCEPTION.VALIDATION_MEASURE_VALUE is
  'calculated value that has given rise to this exception if limit break';
comment on column VCR.LIMIT_EXCEPTION.CLASS is
  'manually assigned classification';
comment on column VCR.LIMIT_EXCEPTION.TYPE is
  'either limit break or calculation error';
comment on column VCR.LIMIT_EXCEPTION.STATUS is
  'current status';
comment on column VCR.LIMIT_EXCEPTION.EXCEPTION_DESCRIPTION is
  'generated exception description ';
comment on column VCR.LIMIT_EXCEPTION.RESOLUTION_DATE is
  'date exception marked as resolved';
comment on column VCR.LIMIT_EXCEPTION.RESOLUTION_USER is
  'user recording exception resolution';
comment on column VCR.LIMIT_EXCEPTION.COMMENTS is
  'free format comments';
comment on column VCR.LIMIT_EXCEPTION.ACTION_DESCRIPTION is
  'description of action taken to investigate exception';
comment on column VCR.LIMIT_EXCEPTION.SEQ_ID is
  'if position level exception defines which position it is for in conjunction with position_key';

------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_EXCEPTION
  add constraint PK_LIMIT_EXCEPTION
  primary key (SOURCE_ID,AS_OF_DATE,EXCEPTION_ID)
  using index tablespace VCR_IDX_MED
  local
;

------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_EXCEPTION_LIMIT_VERSION
  foreign key (LIMIT_ID,LIMIT_VERSION)
  references VCR.LIMIT_VERSION(LIMIT_ID,LIMIT_VERSION)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_BASIS
  foreign key (BASIS)
  references VCR.SOURCE_BASIS(BASIS)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_BROKER
  foreign key (SOURCE_BROKER_ID)
  references VCR.SOURCE_BROKER(SOURCE_BROKER_ID)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_CURRENCY
  foreign key (SOURCE_ID,CURRENCY)
  references VCR.SOURCE_CURRENCY(SOURCE_ID,CURRENCY)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_FUND
  foreign key (SOURCE_FUND_ID)
  references VCR.SOURCE_FUND(SOURCE_FUND_ID)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_INS_TYPE
  foreign key (SOURCE_INSTRUMENT_TYPE_ID)
  references VCR.SOURCE_INSTRUMENT_TYPE(SOURCE_INSTRUMENT_TYPE_ID)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_SOURCE
  foreign key (SOURCE_ID)
  references VCR.SOURCE(SOURCE_ID)
;
alter table VCR.LIMIT_EXCEPTION
  add constraint FK_LIMIT_EXCEPTION_STRATEGY
  foreign key (SOURCE_STRATEGY_ID)
  references VCR.SOURCE_STRATEGY(SOURCE_STRATEGY_ID)
;

------------------------------------------------------------------------------
-- Create/Recreate indexes
------------------------------------------------------------------------------
create index VCR.IX_LIMIT_EXCEPTION_1 on VCR.LIMIT_EXCEPTION(SOURCE_ID,AS_OF_DATE,LOAD_RUN_ID)
  tablespace VCR_IDX_MED local
;
create index VCR.IX_LIMIT_EXCEPTION_2 on VCR.LIMIT_EXCEPTION(SOURCE_ID,AS_OF_DATE,LOAD_RUN_ID,SOURCE_FUND_ID)
  tablespace VCR_IDX_MED local
;
-- Create/Recreate check constraints
alter table LIMIT_EXCEPTION
  add constraint CHK_EXCEPTION_TBR_IND
  check (TO_BE_RESOLVED_IND IN ('Y','N'));
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

