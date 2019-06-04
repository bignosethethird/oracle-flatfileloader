create or replace trigger vcr.tr_ar_file_type_field
  after insert or update or delete on vcr.file_type_field
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_file_type_field.sql 1.3 2005/10/26 13:21:51BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Field';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'File Type:  '||:new.file_type||utl.pkg_string.gc_nl||
      'Field Name: '||:new.field_name||utl.pkg_string.gc_nl);
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'File Type:  '||:old.file_type||utl.pkg_string.gc_nl||
      'Field Name: '||:old.field_name||utl.pkg_string.gc_nl,
      null);  -- new new value
  elsif updating then
    if(:old.file_type<>:new.file_type or 
       :old.field_name<>:new.field_name)then
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
        gc_object_name,
        gc_owner_name,
        :new.change_reason,      
        'File Type:  '||:old.file_type||utl.pkg_string.gc_nl||
        'Field Name: '||:old.field_name||utl.pkg_string.gc_nl,
        'File Type:  '||:new.file_type||utl.pkg_string.gc_nl||
        'Field Name: '||:new.field_name||utl.pkg_string.gc_nl);
    end if;        
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_file_type_field;
/
