------------------------------------------------------------------------------
-- $Header: vcr/data/phase3measure_rule.sql 1.2 2005/09/27 14:02:30BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.measure_rule.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------


insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(8,3
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(9,1
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(10,1
      );
      
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(11,2
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(12,1
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(13,1
      );      
      
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(14,1
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(15,1
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(20,2
      );
      
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(21,2
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(22,1
      );
insert into vcr.measure_rule
      (MEASURE_ID,RULE_ID)
values(23,3
      );      
            
commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

