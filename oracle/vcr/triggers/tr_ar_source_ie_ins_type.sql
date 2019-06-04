create or replace trigger VCR.TR_AR_SOURCE_IE_INS_TYPE
  after insert or delete on VCR.SOURCE_IE_INS_TYPE
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_ie_ins_type.sql 1.6 2005/08/03 16:53:38BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to ie_instrument_type table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(100) := 'Source/Investment Engine Instrument Type Mapping';
 gc_owner_name  CONSTANT VARCHAR2(10)  := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'IE Instrument Type: '||pkg_instrument_type.get_ie_description(:NEW.ie_instrument_type_id)||utl.pkg_constants.gc_cr||
                                         'Source Instrument Type: '||pkg_instrument_type.get_source_description(:NEW.source_instrument_type_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'IE Instrument Type: '||pkg_instrument_type.get_ie_description(:OLD.ie_instrument_type_id)||utl.pkg_constants.gc_cr||
                                         'Source Instrument Type: '||pkg_instrument_type.get_source_description(:OLD.source_instrument_type_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'IE Instrument Type: '||pkg_instrument_type.get_ie_description(:OLD.ie_instrument_type_id)||utl.pkg_constants.gc_cr||
                                         'Source Instrument Type: '||pkg_instrument_type.get_source_description(:OLD.source_instrument_type_id),
                                         'IE Instrument Type Id: '||:NEW.ie_instrument_type_id||utl.pkg_constants.gc_cr||
                                         'IE Instrument Type: '||pkg_instrument_type.get_ie_description(:NEW.ie_instrument_type_id)||utl.pkg_constants.gc_cr||
                                         'Source Instrument Type: '||pkg_instrument_type.get_source_description(:NEW.source_instrument_type_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_ie_ins_type;
/

