create or replace trigger VCR.TR_AR_LIMIT_HEADER_VALUE
  after insert or update or delete on VCR.LIMIT_HEADER_VALUE
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- Trigger to create audit trail entries after changes have been made to limit_header_value table
-- $Header: vcr/triggers/tr_ar_limit_header_value.sql 1.2 2005/08/03 16:53:38BST ghoekstra DEV  $
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Limit Criteria';
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
                                         'Description: '||pkg_limit.get_measure_rule_description(:NEW.limit_id)||utl.pkg_constants.gc_cr||
                     'Criteria: '||pkg_limit.get_header_description(:NEW.header_parameter_id)||utl.pkg_constants.gc_cr||
                     'Value: '||pkg_limit.get_header_value_description(:NEW.header_parameter_id,:NEW.value)
                                         );
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                     'Id: '||:OLD.limit_id||utl.pkg_constants.gc_cr||
                                         'Limit: '||pkg_limit.get_measure_rule_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                     'Criteria: '||pkg_limit.get_header_description(:OLD.header_parameter_id)||utl.pkg_constants.gc_cr||
                     'Value: '||pkg_limit.get_header_value_description(:OLD.header_parameter_id,:OLD.value),
                     NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                     'Id: '||:OLD.limit_id||utl.pkg_constants.gc_cr||
                                         'Limit: '||pkg_limit.get_measure_rule_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                     'Criteria: '||pkg_limit.get_header_description(:OLD.header_parameter_id)||utl.pkg_constants.gc_cr||
                     'Value: '||pkg_limit.get_header_value_description(:OLD.header_parameter_id,:OLD.value),
                           'Id: '||:NEW.limit_id||utl.pkg_constants.gc_cr||
                                         'Limit: '||pkg_limit.get_measure_rule_description(:NEW.limit_id)||utl.pkg_constants.gc_cr||
                     'Criteria: '||pkg_limit.get_header_description(:NEW.header_parameter_id)||utl.pkg_constants.gc_cr||
                     'Value: '||pkg_limit.get_header_value_description(:NEW.header_parameter_id,:NEW.value));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END TR_AR_LIMIT_VERSION;
/

