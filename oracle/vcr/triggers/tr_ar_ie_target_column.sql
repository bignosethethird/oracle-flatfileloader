create or replace trigger vcr.tr_ar_ie_target_column
  after insert or update or delete on vcr.ie_target_column
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_ie_target_column.sql 1.3 2005/10/26 13:21:51BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'IE Mandatory Attribute';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'IE Id:      '||:new.ie_id||utl.pkg_string.gc_nl||
      'Table Name: '||:new.table_name||utl.pkg_string.gc_nl||
      'Column Name:'||:new.column_name||utl.pkg_string.gc_nl
      );
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'IE Id:      '||:old.ie_id||utl.pkg_string.gc_nl||
      'Table Name: '||:old.table_name||utl.pkg_string.gc_nl||
      'Column Name:'||:old.column_name||utl.pkg_string.gc_nl,
      null);  -- new new value
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_ie_target_column;
/
