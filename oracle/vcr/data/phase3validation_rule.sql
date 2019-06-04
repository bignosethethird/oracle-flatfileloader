------------------------------------------------------------------------------
-- $Header: vcr/data/phase3validation_rule.sql 1.1 2005/08/22 12:08:00BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating 2 records into table vcr.validation_rule.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.validation_rule
      (RULE_ID,NAME,BREAK_MESSAGE)
values(2,
      'Maximum Check',
      'Above Maximum Limit'
      );
insert into vcr.validation_rule
      (RULE_ID,NAME,BREAK_MESSAGE)
values(3,
      'Minimum Check',
      'Below Minimum Limit'
      );



commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

