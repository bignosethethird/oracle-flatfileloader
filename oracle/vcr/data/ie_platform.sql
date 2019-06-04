------------------------------------------------------------------------------
-- $Header: vcr/data/ie_platform.sql 1.1 2005/08/19 11:54:28BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating 1 records into table vcr.ie_platform

-- empty table:
delete from vcr.ie_platform;

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.ie_platform
  (IE_ID,ie_platform, email_address,DESCRIPTION,change_reason)
  values
  ('RMF','HFV',null,'Hedge Fund Ventures',null);

commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

