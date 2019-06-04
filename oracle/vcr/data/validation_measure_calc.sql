------------------------------------------------------------------------------
-- $Header: vcr/data/validation_measure_calc.sql 1.2.1.6 2005/10/19 10:29:10BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.validation_measure_calc

-- Truncate the table:
delete from vcr.validation_measure_calc;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(5,'1',null,'CASE this.as_of_date WHEN utl.pkg_date.check_fwdom(this.as_of_date) THEN this.mtd_ror ELSE NVL2(last.as_of_date,0,(this.mtd_ror - last.mtd_ror)) END','vw_validation_fund this, vw_validation_fund last, ','and this.source_fund_id = last.source_fund_id (+) ','All','DECODE(this.mtd_ror,null,''No MTD RoR ''|| this.mtd_ror_error,null)');

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(6,'1',null,'(this.ref_mtd_ror-this.mtd_ror)','vw_validation_fund this, vw_validation_fund last,','and this.source_fund_id = last.source_fund_id (+) and this.me_fund_id IS NOT NULL','All','decode(this.ref_mtd_ror,null,''No manager estimate of MTD RoR'',decode(this.mtd_ror,null,''No MTD RoR '' || this.mtd_ror_error,null))');

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(7,
      '1',
      NULL,
      '(this.ref_mtd_ror-this.mtd_ror)',
      'vw_validation_strategy this, vw_validation_strategy last,',
      'and this.source_strategy_id = last.source_strategy_id (+) and this.me_strategy_id IS NOT NULL',
      'All',
      'decode(this.ref_mtd_ror,null,''No manager estimate of MTD RoR'',decode(this.mtd_ror,null,''No MTD RoR '' || this.mtd_ror_error,decode(this.as_of_date,this.ref_mtd_ror_aod,null,''Different manager estimate as of date'')))'
      );
      
insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(8,
       '1',
       null,
       'NVL(this.instrument_price_local,0)','vw_validation_position this, vw_validation_position last,','and this.key = last.key (+) and this.seq_id = last.seq_id (+) and this.instrument_holding <> 0',
       'All',
       null
       );
       
insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(9,'this.fund_abs_pnl_daily',null,'this.total_pnl_daily','vw_validation_position_w_fund this, vw_validation_position last,','and this.key = last.key (+) and this.seq_id = last.seq_id (+)','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(10,'1',null,'(this.instrument_value - last.instrument_value) - this.total_pnl_daily','vw_validation_fund this, vw_validation_fund last,','and this.source_fund_id = last.source_fund_id and this.as_of_date != utl.pkg_date.check_fwdom(this.as_of_date)','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(11,'last.instrument_price_local',null,'ABS(this.instrument_price_local - last.instrument_price_local)','vw_validation_position this,  vw_validation_position last,','and this.key = last.key and this.seq_id = last.seq_id and this.instrument_price_local <> 0 and this.instrument_holding<>0','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(12,'ABS(this.fund_instrument_value - this.fund_total_pnl_mtd)','IN (''RMF'',''Glenwood'',''HFV'')','this.total_pnl_mtd','vw_validation_position_w_fund this, vw_validation_position last,','and this.seq_id = last.seq_id (+) and this.key = last.key (+)','RMF or Glenwood',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(12,'this.ref_notional','= ''MGS''','this.total_pnl_mtd','vw_validation_position this,  vw_validation_position last,','and this.seq_id = last.seq_id (+) and this.key = last.key (+)','MGS',null);


insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(13,'last.fund_instrument_value','IN (''RMF'',''Glenwood'',''HFV'')','(this.instrument_value - last.instrument_value)','vw_validation_position this, vw_validation_position_w_fund last,','and this.seq_id = last.seq_id and this.key = last.key and this.instrument_holding<>0','RMF or Glenwood',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(13,'this.ref_notional','= ''MGS''','(this.instrument_value - last.instrument_value)','vw_validation_position this,  vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key and this.instrument_holding<>0','MGS',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(14,'DECODE(TO_CHAR(this.as_of_date,''YYYYMM''),TO_CHAR(last.as_of_date,''YYYYMM''),last.fund_instrument_value,this.fund_instrument_value)','IN (''RMF'',''Glenwood'',''HFV'')','(this.total_pnl_mtd - DECODE(TO_CHAR(this.as_of_date,''YYYYMM''),TO_CHAR(last.as_of_date,''YYYYMM''),last.total_pnl_mtd,0) )','vw_validation_position_w_fund this, vw_validation_position_w_fund last,','and this.seq_id = last.seq_id and this.key = last.key','RMF or Glenwood',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(14,'this.ref_notional','= ''MGS''','(this.total_pnl_mtd - DECODE( TO_CHAR(this.as_of_date,''YYYYMM'') ,TO_CHAR(last.as_of_date,''YYYYMM'') ,last.total_pnl_mtd,0) )','vw_validation_position this,  vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key ','MGS',null);


insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(15,'last.instrument_value','IN (''EQUITY'',''BOND'')','(this.instrument_value - (( last.instrument_value / last.instrument_holding    ) * this.instrument_holding))','vw_validation_position this, vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key and this.instrument_holding<>0','Equities and Bonds','DECODE(last.instrument_holding,NULL,''No instrument holding value'',0,''Zero instrument holding value'',null)');

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(15,'last.instrument_value','NOT IN (''EQUITY'',''BOND'')','(this.instrument_value - last.instrument_value)','vw_validation_position this,  vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key and this.instrument_holding<>0','Not Equities or Bonds',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(20,'1',null,'NVL2(last.as_of_date,0,1)','vw_validation_position_hpad this, vw_validation_position last, ','and this.seq_id = last.seq_id (+) and this.key = last.key (+)','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(21,'1',null,'1','vw_validation_missing_position this, vw_validation_position last, ','and this.seq_id = last.seq_id (+) and this.key = last.key (+)','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(22,'this.instrument_price_local',null,'(this.bb_price - this.instrument_price_local)','vw_validation_position this, vw_validation_position last, ','and this.seq_id = last.seq_id (+) and this.key = last.key (+) and this.bb_price is not null','All',null);

insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(23,'1',null,'((this.instrument_price_local - this.stale_check_price_local)+(this.instrument_price_local - last.instrument_price_local))','vw_validation_stale_position this, vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key and this.instrument_holding<>0','All',null);

commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

