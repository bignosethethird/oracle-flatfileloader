------------------------------------------------------------------------------
-- $Header: vcr/data/phase3source.sql 1.2 2005/10/07 15:59:58BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.source.

alter table vcr.source_file_type disable constraint fk_source_file_type_source;
-- empty table:
delete from vcr.source where source_id between 7 and 11;
------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------



insert into vcr.source
  (SOURCE_ID,SOURCE_NAME)
  values
  (7,'BNS');
insert into vcr.source
  (SOURCE_ID,SOURCE_NAME)
  values
  (8,'SSCMON');
insert into vcr.source
  (SOURCE_ID,SOURCE_NAME)
  values
  (9,'TRANAUT');  
insert into vcr.source
  (SOURCE_ID,SOURCE_NAME)
  values
  (10,'CITCO');
insert into vcr.source
  (SOURCE_ID,SOURCE_NAME)
  values
  (11,'GFSCH');  
commit;

alter table vcr.source_file_type enable constraint fk_source_file_type_source;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

