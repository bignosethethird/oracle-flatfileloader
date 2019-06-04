create or replace trigger vcr.tr_ar_investment_engine
  after insert or update or delete on vcr.investment_engine
  referencing new as new old as old
  for each row
------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_investment_engine.sql 1.3 2005/10/19 14:37:10BST apenney DEV  $  
-- Audit trail for indicated table
------------------------------------------------------------------------------
declare
  gc_object_name constant varchar2(100) := 'Investment Engine';
  gc_owner_name  constant varchar2(10)  := 'vcr';
begin 
  if inserting then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,
      null,  -- no old value
      'IE Id:           '||:new.ie_id||utl.pkg_string.gc_nl||
      'Description:     '||:new.description||utl.pkg_string.gc_nl||
      'ME Source:       '||:new.me_source||utl.pkg_string.gc_nl||
      'Email Addr:      '||:new.email_address||utl.pkg_string.gc_nl||
      'Ignore Zero Pos: '||:new.ignore_zero_positions||utl.pkg_string.gc_nl||
      'ROR-calc denom''tr:'||:new.ror_calc_denominator||utl.pkg_string.gc_nl
      );
  elsif deleting then
    if(:new.description           <> :old.description or
       :new.me_source             <> :old.me_source   or
       :new.email_address         <> :old.email_address or
       :new.ignore_zero_positions <> :old.ignore_zero_positions or
       :new.ror_calc_denominator  <> :old.ror_calc_denominator)      
    then
      utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
        gc_object_name,
        gc_owner_name,
        :old.change_reason,
        'IE Id:           '||:old.ie_id||utl.pkg_string.gc_nl||
        'Description:     '||:old.description||utl.pkg_string.gc_nl||
        'ME Source:       '||:old.me_source||utl.pkg_string.gc_nl||
        'Email Addr:      '||:old.email_address||utl.pkg_string.gc_nl||
        'Ignore Zero Pos: '||:old.ignore_zero_positions||utl.pkg_string.gc_nl||
        'ROR-calc denom''tr:'||:old.ror_calc_denominator||utl.pkg_string.gc_nl,
        null);  -- new new value
     end if;
  elsif updating then
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
      gc_object_name,
      gc_owner_name,
      :new.change_reason,      
      'IE Id:           '||:old.ie_id||utl.pkg_string.gc_nl||
      'Description:     '||:old.description||utl.pkg_string.gc_nl||
      'ME Source:       '||:old.me_source||utl.pkg_string.gc_nl||
      'Email Addr:      '||:old.email_address||utl.pkg_string.gc_nl||
      'Ignore Zero Pos: '||:old.ignore_zero_positions||utl.pkg_string.gc_nl||
      'ROR-calc denom''tr:'||:old.ror_calc_denominator||utl.pkg_string.gc_nl,
      'IE Id:           '||:new.ie_id||utl.pkg_string.gc_nl||
      'Description:     '||:new.description||utl.pkg_string.gc_nl||
      'ME Source:       '||:new.me_source||utl.pkg_string.gc_nl||
      'Email Addr:      '||:new.email_address||utl.pkg_string.gc_nl||
      'Ignore Zero Pos: '||:new.ignore_zero_positions||utl.pkg_string.gc_nl||
      'ROR-calc denom''tr:'||:new.ror_calc_denominator||utl.pkg_string.gc_nl
    );      
  end if;
exception 
  when others then
    utl.pkg_errorhandler.handle;    
    raise;  
end tr_ar_investment_engine;
/
