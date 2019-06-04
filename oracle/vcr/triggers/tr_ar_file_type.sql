create or replace trigger vcr.tr_ar_file_type
  after insert or update or delete on vcr.file_type
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_file_type.sql 1.2 2005/10/26 13:21:50BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'File Type';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'File Type:      '||:new.file_type||utl.pkg_string.gc_nl||
      'Table Name:     '||:new.table_name||utl.pkg_string.gc_nl||
      'Delimiter:      '||:new.delimiter||utl.pkg_string.gc_nl||
      'Ignore Records: '||:new.ignore_records||utl.pkg_string.gc_nl||
      'AccPeriod Field:'||:new.accounting_period_field||utl.pkg_string.gc_nl||
      'Description:    '||:new.description||utl.pkg_string.gc_nl||
      'Document name:  '||:new.document_name||utl.pkg_string.gc_nl||
      'Date Formate:   '||:new.date_format||utl.pkg_string.gc_nl||
      'EndOfLine:      '||:new.end_of_line||utl.pkg_string.gc_nl||
      'String Encloser:'||:new.string_encloser||utl.pkg_string.gc_nl||
      'Check Type:     '||:new.check_type||utl.pkg_string.gc_nl||
      'Preserve unmapped:'||:new.preserve_unmapped);
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'File Type:      '||:old.file_type||utl.pkg_string.gc_nl||
      'Table Name:     '||:old.table_name||utl.pkg_string.gc_nl||
      'Delimiter:      '||:old.delimiter||utl.pkg_string.gc_nl||
      'Ignore Records: '||:old.ignore_records||utl.pkg_string.gc_nl||
      'AccPeriod Field:'||:old.accounting_period_field||utl.pkg_string.gc_nl||
      'Description:    '||:old.description||utl.pkg_string.gc_nl||
      'Document name:  '||:old.document_name||utl.pkg_string.gc_nl||
      'Date Formate:   '||:old.date_format||utl.pkg_string.gc_nl||
      'EndOfLine:      '||:old.end_of_line||utl.pkg_string.gc_nl||
      'String Encloser:'||:old.string_encloser||utl.pkg_string.gc_nl||
      'Check Type:     '||:old.check_type||utl.pkg_string.gc_nl||
      'Preserve unmapped:'||:old.preserve_unmapped,
      null);  -- new new value
  elsif updating then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,      
      'File Type:      '||:old.file_type||utl.pkg_string.gc_nl||
      'Table Name:     '||:old.table_name||utl.pkg_string.gc_nl||
      'Delimiter:      '||:old.delimiter||utl.pkg_string.gc_nl||
      'Ignore Records: '||:old.ignore_records||utl.pkg_string.gc_nl||
      'AccPeriod Field:'||:old.accounting_period_field||utl.pkg_string.gc_nl||
      'Description:    '||:old.description||utl.pkg_string.gc_nl||
      'Document name:  '||:old.document_name||utl.pkg_string.gc_nl||
      'Date Formate:   '||:old.date_format||utl.pkg_string.gc_nl||
      'EndOfLine:      '||:old.end_of_line||utl.pkg_string.gc_nl||
      'String Encloser:'||:old.string_encloser||utl.pkg_string.gc_nl||
      'Check Type:     '||:old.check_type||utl.pkg_string.gc_nl||
      'Preserve unmapped:'||:old.preserve_unmapped,
      'File Type:      '||:new.file_type||utl.pkg_string.gc_nl||
      'Table Name:     '||:new.table_name||utl.pkg_string.gc_nl||
      'Delimiter:      '||:new.delimiter||utl.pkg_string.gc_nl||
      'Ignore Records: '||:new.ignore_records||utl.pkg_string.gc_nl||
      'AccPeriod Field:'||:new.accounting_period_field||utl.pkg_string.gc_nl||
      'Description:    '||:new.description||utl.pkg_string.gc_nl||
      'Document name:  '||:new.document_name||utl.pkg_string.gc_nl||
      'Date Formate:   '||:new.date_format||utl.pkg_string.gc_nl||
      'EndOfLine:      '||:new.end_of_line||utl.pkg_string.gc_nl||
      'String Encloser:'||:new.string_encloser||utl.pkg_string.gc_nl||
      'Check Type:     '||:new.check_type||utl.pkg_string.gc_nl||
      'Preserve unmapped:'||:new.preserve_unmapped);
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_file_type;
/
