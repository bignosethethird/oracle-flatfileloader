create or replace trigger VCR.TR_AR_SOURCE_CURRENCY
  after insert or update on VCR.SOURCE_CURRENCY
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_currency.sql 1.6 2005/08/03 16:53:32BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to source_currency table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(100) := 'Source Currency';
 gc_owner_name  CONSTANT VARCHAR2(10)  := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Currency: '||:NEW.currency||utl.pkg_constants.gc_cr||
                                         'ISO Currency Code: '||:NEW.iso_currency_code||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Currency: '||:OLD.currency||utl.pkg_constants.gc_cr||
                                         'ISO Currency Code: '||:OLD.iso_currency_code||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Currency: '||:OLD.currency||utl.pkg_constants.gc_cr||
                                         'ISO Currency Code: '||:OLD.iso_currency_code||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id),
                                         'Currency: '||:NEW.currency||utl.pkg_constants.gc_cr||
                                         'ISO Currency Code: '||:NEW.iso_currency_code||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_currency;
/
