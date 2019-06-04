create or replace trigger VCR.TR_AR_SOURCE_STRATEGY
  after insert or update on VCR.SOURCE_STRATEGY
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_strategy.sql 1.6 2005/08/03 16:53:39BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to source_strategy table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Source Strategy';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Source Strategy Id: '||:NEW.source_strategy_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:NEW.fund||utl.pkg_constants.gc_cr||
                                         'Strategy: '||:NEW.strategy||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'ME Strategy: '||pkg_ref_object.get_description(:NEW.me_strategy_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Source Strategy Id: '||:OLD.source_strategy_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:OLD.fund||utl.pkg_constants.gc_cr||
                                         'Strategy: '||:OLD.strategy||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'ME Strategy: '||pkg_ref_object.get_description(:OLD.me_strategy_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Source Strategy Id: '||:OLD.source_strategy_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:OLD.fund||utl.pkg_constants.gc_cr||
                                         'Strategy: '||:OLD.strategy||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'ME Strategy: '||pkg_ref_object.get_description(:OLD.me_strategy_id),
                                          'Source Strategy Id: '||:NEW.source_strategy_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:NEW.fund||utl.pkg_constants.gc_cr||
                                         'Strategy: '||:NEW.strategy||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'ME Strategy: '||pkg_ref_object.get_description(:NEW.me_strategy_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_strategy;
/
