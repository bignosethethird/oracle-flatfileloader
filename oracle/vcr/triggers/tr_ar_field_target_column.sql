create or replace trigger vcr.tr_ar_field_target_column
  after insert or update or delete on vcr.field_target_column
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_field_target_column.sql 1.4 2005/10/26 13:21:52BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Field Attribute Mapping';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'File Type:   '||:new.file_type||utl.pkg_string.gc_nl||
      'Field Name:  '||:new.field_name||utl.pkg_string.gc_nl||
      'Table Name:  '||:new.table_name||utl.pkg_string.gc_nl||
      'Column Name: '||:new.column_name||utl.pkg_string.gc_nl||
      'Acc Period:  '||:new.accounting_period||utl.pkg_string.gc_nl||
      'In unique key:'||:new.in_unique_key||utl.pkg_string.gc_nl
      );
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'File Type:   '||:old.file_type||utl.pkg_string.gc_nl||
      'Field Name:  '||:old.field_name||utl.pkg_string.gc_nl||
      'Table Name:  '||:old.table_name||utl.pkg_string.gc_nl||
      'Column Name: '||:old.column_name||utl.pkg_string.gc_nl||
      'Acc Period:  '||:old.accounting_period||utl.pkg_string.gc_nl||
      'In unique key:'||:old.in_unique_key||utl.pkg_string.gc_nl,      
      null);  -- new new value
  elsif updating then
    if(:new.accounting_period<>:old.accounting_period or
       :new.in_unique_key<>:old.in_unique_key)then
      -- only trail if there has been a change
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
        gc_object_name,
        gc_owner_name,
        :new.change_reason,      
        'File Type:   '||:old.file_type||utl.pkg_string.gc_nl||
        'Field Name:  '||:old.field_name||utl.pkg_string.gc_nl||
        'Table Name:  '||:old.table_name||utl.pkg_string.gc_nl||
        'Column Name: '||:old.column_name||utl.pkg_string.gc_nl||
        'Acc Period:  '||:old.accounting_period||utl.pkg_string.gc_nl||
        'In unique key:'||:old.in_unique_key||utl.pkg_string.gc_nl,
        'File Type:   '||:new.file_type||utl.pkg_string.gc_nl||
        'Field Name:  '||:new.field_name||utl.pkg_string.gc_nl||
        'Table Name:  '||:new.table_name||utl.pkg_string.gc_nl||
        'Column Name: '||:new.column_name||utl.pkg_string.gc_nl||
        'Acc Period:  '||:new.accounting_period||utl.pkg_string.gc_nl||
        'In unique key:'||:new.in_unique_key||utl.pkg_string.gc_nl
      );      
    end if;
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_field_target_column;
/
