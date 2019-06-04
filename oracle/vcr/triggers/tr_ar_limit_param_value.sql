create or replace trigger VCR.TR_AR_LIMIT_PARAM_VALUE
  after insert or update or delete on VCR.LIMIT_PARAM_VALUE
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_limit_param_value.sql 1.3 2005/08/03 16:53:35BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to limit_param_value table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Limit Value';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Limit: '||pkg_limit.get_description(:NEW.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:NEW.limit_version||utl.pkg_constants.gc_cr||
                                         'Value: '||to_char(:NEW.value,'000.9999')||utl.pkg_constants.gc_cr||
                                         'Rule Parameter: '||pkg_limit.get_rule_parameter_description(:NEW.rule_parameter_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Limit: '||pkg_limit.get_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:OLD.limit_version||utl.pkg_constants.gc_cr||
                                         'Value: '||to_char(:OLD.value,'000.9999')||utl.pkg_constants.gc_cr||
                                         'Rule Parameter: '||pkg_limit.get_rule_parameter_description(:OLD.rule_parameter_id),
                     NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Limit: '||pkg_limit.get_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:OLD.limit_version||utl.pkg_constants.gc_cr||
                                         'Value: '||to_char(:OLD.value,'000.9999')||utl.pkg_constants.gc_cr||
                                         'Rule Parameter: '||pkg_limit.get_rule_parameter_description(:OLD.rule_parameter_id),
                                          'Limit: '||pkg_limit.get_description(:NEW.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:NEW.limit_version||utl.pkg_constants.gc_cr||
                                         'Value: '||to_char(:NEW.value,'000.9999')||utl.pkg_constants.gc_cr||
                                         'Rule Parameter: '||pkg_limit.get_rule_parameter_description(:NEW.rule_parameter_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END TR_AR_LIMIT_PARAM_VALUE;
/
