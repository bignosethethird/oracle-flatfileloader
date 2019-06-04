------------------------------------------------------------------------------
-- $Header: vcr/data/phase3validation_measure.sql 1.5 2005/10/17 15:55:10BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.validation_measure.

-- Truncate the table:


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

update vcr.validation_measure set format = 'FM990.00',calc_level = null,units='PERCENTAGE' where measure_id in (5,6,7);

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (8,'Zero/Near Zero Price',null,null,'FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (9,'Impact of Position Daily PnL on Fund Daily PnL',null,'PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (10,'Difference of Fund Daily Market Value Change/Daily PnL',null,null,'FM9999999999990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (11,'Daily Price Change',null,'PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (12,'Position MTD PnL Contribution','ie_id','PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (13,'Impact of Daily Position Market Value Change','ie_id','PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (14,'Impact of Daily Position MTD PnL Change','ie_id','PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (15,'Daily Position Valuation Change','category','PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (20,'New Position',null,null,'9');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (21,'Missing Position',null,null,'9');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (22,'Difference VSP/Bloomberg Price',null,'PERCENTAGE','FM990.00');

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (23,'Difference Current/Previous/Old Price (Stale Price)',null,null,'FM990.00');

commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

