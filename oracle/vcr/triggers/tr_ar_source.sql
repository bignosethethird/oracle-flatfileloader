create or replace trigger vcr.tr_ar_source
  after insert or update or delete on vcr.source
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source.sql 1.4 2005/10/19 14:37:11BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Source';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'Source Id:    '||:new.source_id||utl.pkg_string.gc_nl||
      'Source Name:  '||:new.source_name||utl.pkg_string.gc_nl||
      'Email Addr:   '||:new.email_address||utl.pkg_string.gc_nl||
      'Secure Msg Id:'||:new.secure_message_id||utl.pkg_string.gc_nl||
      'TPLUS1 Offset:'||:new.tplus1_offset||utl.pkg_string.gc_nl
      );
  elsif deleting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
      gc_object_name,
      gc_owner_name,
      :old.change_reason,
      'Source Id:    '||:old.source_id||utl.pkg_string.gc_nl||
      'Source Name:  '||:old.source_name||utl.pkg_string.gc_nl||
      'Email Addr:   '||:old.email_address||utl.pkg_string.gc_nl||
      'Secure Msg Id:'||:old.secure_message_id||utl.pkg_string.gc_nl||
      'TPLUS1 Offset:'||:old.tplus1_offset||utl.pkg_string.gc_nl,
      null);  -- new new value
  elsif updating then
    if(:new.source_name <> :old.source_name or
       :new.email_address <> :old.email_address or
       :new.secure_message_id <> :old.secure_message_id or
       :new.tplus1_offset <> :old.tplus1_offset
     )then
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
        gc_object_name,
        gc_owner_name,
        :new.change_reason,      
        'Source Id:    '||:old.source_id||utl.pkg_string.gc_nl||
        'Source Name:  '||:old.source_name||utl.pkg_string.gc_nl||
        'Email Addr:   '||:old.email_address||utl.pkg_string.gc_nl||
        'Secure Msg Id:'||:old.secure_message_id||utl.pkg_string.gc_nl||
        'TPLUS1 Offset:'||:old.tplus1_offset||utl.pkg_string.gc_nl,
        'Source Id:    '||:new.source_id||utl.pkg_string.gc_nl||
        'Source Name:  '||:new.source_name||utl.pkg_string.gc_nl||
        'Email Addr:   '||:new.email_address||utl.pkg_string.gc_nl||
        'Secure Msg Id:'||:new.secure_message_id||utl.pkg_string.gc_nl||
        'TPLUS1 Offset:'||:new.tplus1_offset||utl.pkg_string.gc_nl
      );      
    end if;
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_source;
/
