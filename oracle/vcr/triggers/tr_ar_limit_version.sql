create or replace trigger VCR.TR_AR_LIMIT_VERSION
  after insert or update or delete on VCR.LIMIT_VERSION
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_limit_version.sql 1.2 2005/08/03 16:53:33BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to limit_versiontable
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Limit Version';
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
                                         'Start Date: '||to_char(:NEW.start_date,'dd-MON-yyyy')||utl.pkg_constants.gc_cr||
                                         'End Date: '||to_char(:NEW.end_date,'dd-MON-yyyy'));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Limit: '||pkg_limit.get_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:OLD.limit_version||utl.pkg_constants.gc_cr||
                                         'Start Date: '||to_char(:OLD.start_date,'dd-MON-yyyy')||utl.pkg_constants.gc_cr||
                                         'End Date: '||to_char(:OLD.end_date,'dd-MON-yyyy'),
                     NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Limit: '||pkg_limit.get_description(:OLD.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:OLD.limit_version||utl.pkg_constants.gc_cr||
                                         'Start Date: '||to_char(:OLD.start_date,'dd-MON-yyyy')||utl.pkg_constants.gc_cr||
                                         'End Date: '||to_char(:OLD.end_date,'dd-MON-yyyy'),
                                         'Limit: '||pkg_limit.get_description(:NEW.limit_id)||utl.pkg_constants.gc_cr||
                                         'Version: '||:NEW.limit_version||utl.pkg_constants.gc_cr||
                                         'Start Date: '||to_char(:NEW.start_date,'dd-MON-yyyy')||utl.pkg_constants.gc_cr||
                                         'End Date: '||to_char(:NEW.end_date,'dd-MON-yyyy'));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END TR_AR_LIMIT_VERSION;
/
