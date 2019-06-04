create or replace trigger VCR.TR_AR_SOURCE_MARKET
  after insert or update on VCR.SOURCE_MARKET
  referencing new as new old as old
  for each row
--------------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_market.sql 1.1 2005/09/16 15:13:00BST apenney DEV  $
-- Trigger to create audit trail entries after changes have been made to source_market table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Source Market';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Market: '||:NEW.market_name||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Exchange Code: '||:NEW.exchange_code);
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Market: '||:OLD.market_name||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Exchange Code: '||:OLD.exchange_code,
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Market: '||:OLD.market_name||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Exchange Code: '||:OLD.exchange_code,
                                          'Market: '||:NEW.market_name||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Exchange Code: '||:NEW.exchange_code);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_market;
/

