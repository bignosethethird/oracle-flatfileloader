create or replace trigger VCR.TR_AR_LIMIT
  after insert or update or delete on VCR.LIMIT
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_limit.sql 1.2 2005/08/03 16:53:40BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to limit table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Limit';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Id: '||:NEW.limit_id||utl.pkg_constants.gc_cr||
                     'Measure: '||pkg_limit.get_measure_description(:NEW.measure_id)||utl.pkg_constants.gc_cr||
                     'Rule: '||pkg_limit.get_rule_description(:NEW.rule_id)
                                         );
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Id: '||:OLD.limit_id||utl.pkg_constants.gc_cr||
                     'Measure: '||pkg_limit.get_measure_description(:OLD.measure_id)||utl.pkg_constants.gc_cr||
                     'Rule: '||pkg_limit.get_rule_description(:OLD.rule_id),
                     NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Id: '||:OLD.limit_id||utl.pkg_constants.gc_cr||
                     'Measure: '||pkg_limit.get_measure_description(:OLD.measure_id)||utl.pkg_constants.gc_cr||
                     'Rule: '||pkg_limit.get_rule_description(:OLD.rule_id),
                                         'Id: '||:NEW.limit_id||utl.pkg_constants.gc_cr||
                     'Measure: '||pkg_limit.get_measure_description(:NEW.measure_id)||utl.pkg_constants.gc_cr||
                     'Rule: '||pkg_limit.get_rule_description(:NEW.rule_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END TR_AR_LIMIT_VERSION;
/
