create or replace trigger VCR.TR_AR_SOURCE_BROKER
  after insert or update on VCR.SOURCE_BROKER
  referencing new as new old as old
  for each row
--------------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_broker.sql 1.7 2005/09/27 13:18:11BST apenney DEV  $
-- Trigger to create audit trail entries after changes have been made to source_broker table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Source Broker';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Source Broker Id: '||:NEW.source_broker_id||utl.pkg_constants.gc_cr||
                                         'Broker: '||:NEW.broker||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Prime Broker: '||pkg_prime_broker.get_description(:NEW.prime_broker_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Source Broker Id: '||:OLD.source_broker_id||utl.pkg_constants.gc_cr||
                                         'Broker: '||:OLD.broker||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Prime Broker: '||pkg_prime_broker.get_description(:OLD.prime_broker_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Source Broker Id: '||:OLD.source_broker_id||utl.pkg_constants.gc_cr||
                                         'Broker: '||:OLD.broker||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Prime Broker: '||pkg_prime_broker.get_description(:OLD.prime_broker_id),
                                          'Source Broker Id: '||:NEW.source_broker_id||utl.pkg_constants.gc_cr||
                                         'Broker: '||:NEW.broker||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Prime Broker: '||pkg_prime_broker.get_description(:NEW.prime_broker_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_broker;
/

