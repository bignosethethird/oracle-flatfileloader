------------------------------------------------------------------------------
-- $Header: vcr/data/morephase3measure_rule_limit_head_param.sql 1.1 2005/09/30 08:31:29BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.measure_rule_limit_head_param.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(9,1,1
      );         
insert into vcr.measure_rule_limit_head_param
      (MEASURE_ID,RULE_ID,HEADER_PARAMETER_ID)
values(9,1,4
      );            
commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

