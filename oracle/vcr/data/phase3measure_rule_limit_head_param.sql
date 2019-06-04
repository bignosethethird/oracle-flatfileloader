------------------------------------------------------------------------------
-- $Header: vcr/data/phase3measure_rule_limit_head_param.sql 1.1 2005/08/22 12:07:59BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.measure_rule_limit_head_param.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------


insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(11,2,4
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(12,1,1
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(12,1,4
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(13,1,1
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(13,1,4
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(14,1,1
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(14,1,4
      );
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(15,1,4
      );     
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(22,1,4
      );      
commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

