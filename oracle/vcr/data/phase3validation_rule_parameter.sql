------------------------------------------------------------------------------
-- $Header: vcr/data/phase3validation_rule_parameter.sql 1.1 2005/08/22 12:08:01BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating 2 records into table vcr.validation_rule_parameter.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------


insert into vcr.validation_rule_parameter
      (RULE_ID,SEQ_ID,NAME,RULE_PARAMETER_ID,OPERATOR)
values(2,1,
      'Max Limit',3,
      '>'
      );
insert into vcr.validation_rule_parameter
      (RULE_ID,SEQ_ID,NAME,RULE_PARAMETER_ID,OPERATOR)
values(3,1,
      'Min Limit',4,
      '<='
      );


commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

