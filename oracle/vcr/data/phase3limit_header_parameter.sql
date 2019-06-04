------------------------------------------------------------------------------
-- $Header: vcr/data/phase3limit_header_parameter.sql 1.1 2005/08/22 12:07:58BST apenney DEV  $
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.limit_header_parameter.


------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------


insert into vcr.limit_header_parameter
      (PARAMETER_NAME,COLUMN_NAME,HEADER_PARAMETER_ID,GET_DESC_PROCEDURE)
values(
      'Source',
      'source_id',5,
      'begin :1 := vcr.pkg_source.get_source_name(to_number(:2); end;'
      );

update vcr.limit_header_parameter
set parent_column_name = 'source_id' where header_parameter_id in (1,3);

update vcr.limit_header_parameter
set parent_column_name = 'ie_id' where header_parameter_id in (4);

commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

