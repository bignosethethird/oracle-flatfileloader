------------------------------------------------------------------------------
-- $Header: vcr/tables/morephase3_limitexceptionchanges.sql 1.1 2005/10/07 08:36:55BST apenney DEV  $
------------------------------------------------------------------------------

------------------------------------------------------------------------------
set feedback off;

Prompt increasing size of limit_exception.class

alter table vcr.limit_exception modify (class varchar2(20));
set feedback on;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

