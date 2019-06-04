create or replace trigger VCR.TR_AR_PRIME_BROKER
  after insert or update on VCR.PRIME_BROKER
  referencing new as new old as old
  for each row
--------------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_prime_broker.sql 1.1 2005/09/16 12:08:03BST apenney DEV  $
-- Trigger to create audit trail entries after changes have been made to source_broker table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Prime Broker';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Prime Broker Id: '||:NEW.prime_broker_id||utl.pkg_constants.gc_cr||
                                         'Description: '||:NEW.description);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Prime Broker Id: '||:OLD.prime_broker_id||utl.pkg_constants.gc_cr||
                                         'Description: '||:OLD.description,
                                          'Prime Broker Id: '||:NEW.prime_broker_id||utl.pkg_constants.gc_cr||
                                         'Description: '||:NEW.description);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_broker;
/

