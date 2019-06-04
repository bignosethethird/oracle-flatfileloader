create or replace trigger vcr.tr_ar_source_man_override
  after insert or update or delete on vcr.source_mandatory_override
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_man_override.sql 1.4 2005/10/26 13:21:50BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Mandatory Attribute Override';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'Source obj Id:  '||:new.source_object_id||utl.pkg_string.gc_nl||
      'Source obj type:'||:new.source_object_type||utl.pkg_string.gc_nl||
      'Table name:     '||:new.table_name||utl.pkg_string.gc_nl||
      'Column name:    '||:new.column_name||utl.pkg_string.gc_nl||
      'Mandatory ind:  '||:new.mandatory_ind||utl.pkg_string.gc_nl
      );
  elsif deleting then
    if(:new.mandatory_ind <> :old.mandatory_ind)then
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
        gc_object_name,
        gc_owner_name,
        :old.change_reason,
        'Source obj Id:  '||:old.source_object_id||utl.pkg_string.gc_nl||
        'Source obj type:'||:old.source_object_type||utl.pkg_string.gc_nl||
        'Table name:     '||:old.table_name||utl.pkg_string.gc_nl||
        'Column name:    '||:old.column_name||utl.pkg_string.gc_nl||
        'Mandatory ind:  '||:old.mandatory_ind||utl.pkg_string.gc_nl,
        null);  -- new new value
      end if;
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_source_man_override;
/
