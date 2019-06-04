------------------------------------------------------------------------------
-- $Header: vcr/data/stalepriceconfig.sql 1.1 2005/09/27 14:02:57BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Configuring stale price check


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.validation_measure (MEASURE_ID,NAME,CALC_LEVEL,UNITS,FORMAT)
values (23,'Difference Current/Previous/Old Price (Stale Price)',null,null,'FM990.00');


insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(23,3
      );      
            
insert into vcr.validation_measure_calc
      (MEASURE_ID,DENOMINATOR,LEVEL_TEST,NUMERATOR,VIEW_LIST,JOINS,DESCRIPTION,ERROR_TEST)
values(23,'1',null,'((this.instrument_price_local - this.stale_check_price_local)+(this.instrument_price_local - last.instrument_price_local))','vw_validation_stale_position this, vw_validation_position last, ','and this.seq_id = last.seq_id and this.key = last.key','All',null);

insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(23,3,
      'TPLUS1'
      );   
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(23,3,
      'TCLEAN'
      );   

commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

