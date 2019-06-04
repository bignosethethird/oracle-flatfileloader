------------------------------------------------------------------------------
-- $Header: vcr/sequences/sq_attachment_id.sql 1.1 2005/09/27 15:12:04BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for sequence vcr.sq_attachment_id
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @sq_attachment_id.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating sequence vcr.sq_attachment_id

-- Drop type if it already exists
-- Note that the contents of the table will also be deleted.
declare
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'SEQUENCE'
     and owner = upper('vcr')
     and object_name = upper('sq_attachment_id');
  if(v_count>0)then
    execute immediate 'drop sequence vcr.sq_attachment_id';
  end if;
end;
/
------------------------------------------------------------------------------
-- Create sequence
------------------------------------------------------------------------------

create sequence vcr.sq_attachment_id
  minvalue 1
  maxvalue 9999999999999999999999999999
  increment by 1
  nocycle
  nocache
  noorder
;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

