create or replace trigger VCR.TR_AR_IE_INSTRUMENT_TYPE
  after insert or update or delete on VCR.IE_INSTRUMENT_TYPE
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_ie_instrument_type.sql 1.6 2005/09/27 13:18:10BST apenney DEV  $
-----------------------------------------------------------------------------------
-- Trigger to create audit trail entries after changes have been made to ie_instrument_type table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(100) := 'Investment Engine Instrument Type';
 gc_owner_name  CONSTANT VARCHAR2(10)  := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'IE Instrument Type Id: '||:NEW.ie_instrument_type_id||utl.pkg_constants.gc_cr||
                                         'IE Instrument Type: '||:NEW.ie_instrument_type||utl.pkg_constants.gc_cr||
                                         'Category: '||:NEW.category||utl.pkg_constants.gc_cr||
                                         'Stale Price Days: '||:NEW.stale_price_period||utl.pkg_constants.gc_cr||
                                         'Investment Engine: '||pkg_investment_engine.get_description(:NEW.ie_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'IE Instrument Type Id: '||:OLD.ie_instrument_type_id||utl.pkg_constants.gc_cr||
                                         'IE Instrument Type: '||:OLD.ie_instrument_type||utl.pkg_constants.gc_cr||
                                         'Category: '||:OLD.category||utl.pkg_constants.gc_cr||    
                                         'Stale Price Days: '||:OLD.stale_price_period||utl.pkg_constants.gc_cr||                                     
                                         'Investment Engine: '||pkg_investment_engine.get_description(:OLD.ie_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'IE Instrument Type Id: '||:OLD.ie_instrument_type_id||utl.pkg_constants.gc_cr||
                                         'IE Instrument Type: '||:OLD.ie_instrument_type||utl.pkg_constants.gc_cr||
                                         'Category: '||:OLD.category||utl.pkg_constants.gc_cr||
                                         'Stale Price Days: '||:OLD.stale_price_period||utl.pkg_constants.gc_cr||      
                                         'Investment Engine: '||pkg_investment_engine.get_description(:OLD.ie_id),
                                         'IE Instrument Type Id: '||:NEW.ie_instrument_type_id||utl.pkg_constants.gc_cr||
                                         'IE Instrument Type: '||:NEW.ie_instrument_type||utl.pkg_constants.gc_cr||
                                         'Category: '||:NEW.category||utl.pkg_constants.gc_cr||
                                         'Stale Price Days: '||:NEW.stale_price_period||utl.pkg_constants.gc_cr||      
                                         'Investment Engine: '||pkg_investment_engine.get_description(:NEW.ie_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_ie_instrument_type;
/
