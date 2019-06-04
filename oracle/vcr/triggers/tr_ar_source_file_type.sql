create or replace trigger vcr.tr_ar_source_file_type
  after insert or update or delete on vcr.source_file_type
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_file_type.sql 1.4 2005/10/26 13:21:51BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Source/File Type';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'Source File Type:'||:new.source_file_type||utl.pkg_string.gc_nl||
      'Source Id:       '||:new.source_id||utl.pkg_string.gc_nl||
      'File type:       '||:new.file_type||utl.pkg_string.gc_nl||
      'No. of files:    '||:new.no_of_files||utl.pkg_string.gc_nl
      );
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'Source File Type:'||:old.source_file_type||utl.pkg_string.gc_nl||
      'Source Id:       '||:old.source_id||utl.pkg_string.gc_nl||
      'File type:       '||:old.file_type||utl.pkg_string.gc_nl||
      'No. of files:    '||:old.no_of_files||utl.pkg_string.gc_nl,
      null);  -- new new value
  elsif updating then
    if(:new.source_id <> :old.source_id or 
       :new.file_type <> :old.file_type or
       :new.no_of_files <> :old.no_of_files) 
    then       
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
        gc_object_name,
        gc_owner_name,
        :new.change_reason,      
        'Source File Type:'||:old.source_file_type||utl.pkg_string.gc_nl||
        'Source Id:       '||:old.source_id||utl.pkg_string.gc_nl||
        'File type:       '||:old.file_type||utl.pkg_string.gc_nl||
        'No. of files:    '||:old.no_of_files||utl.pkg_string.gc_nl,
        'Source File Type:'||:new.source_file_type||utl.pkg_string.gc_nl||
        'Source Id:       '||:new.source_id||utl.pkg_string.gc_nl||
        'File type:       '||:new.file_type||utl.pkg_string.gc_nl||
        'No. of files:    '||:new.no_of_files||utl.pkg_string.gc_nl);      
    end if;
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_source_file_type;
/
