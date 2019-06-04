create or replace trigger VCR.TR_AR_SOURCE_FUND
  after insert or update on VCR.SOURCE_FUND
  referencing new as new old as old
  for each row
-----------------------------------------------------------------------------------
-- $Header: vcr/triggers/tr_ar_source_fund.sql 1.8 2005/08/03 16:53:34BST ghoekstra DEV  $
-- Trigger to create audit trail entries after changes have been made to source_fund table
--------------------------------------------------------------------------------------
DECLARE
 gc_object_name CONSTANT VARCHAR2(20) := 'Source Fund';
 gc_owner_name  CONSTANT VARCHAR2(10) := 'VCR';
BEGIN
  IF INSERTING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_insert,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         NULL,
                                         'Source Fund Id: '||:NEW.source_fund_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:NEW.fund||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Investment Engine: '||pkg_investment_engine.get_description(:NEW.ie_id)||utl.pkg_constants.gc_cr||
                                         'ME Fund: '||pkg_ref_object.get_description(:NEW.me_fund_id)||utl.pkg_constants.gc_cr||
                                         'Active?: '||:NEW.active_ind||utl.pkg_constants.gc_cr||
                                         'Benchmark Fund: '||pkg_ref_object.get_description(:NEW.me_benchmark_fund_id));
  ELSIF DELETING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_delete,
                                         gc_object_name,
                                         gc_owner_name,
                                         :OLD.change_reason,
                                         'Source Fund Id: '||:OLD.source_fund_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:OLD.fund||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Investment Engine: '||pkg_investment_engine.get_description(:OLD.ie_id)||utl.pkg_constants.gc_cr||
                                         'ME Fund: '||pkg_ref_object.get_description(:OLD.me_fund_id)||utl.pkg_constants.gc_cr||
                                         'Active?: '||:OLD.active_ind||utl.pkg_constants.gc_cr||
                                         'Benchmark Fund: '||pkg_ref_object.get_description(:OLD.me_benchmark_fund_id),
                                         NULL);
  ELSIF UPDATING
  THEN
    utl.pkg_audit_trail_mod.insert_entry(utl.pkg_audit_trail.gc_action_update,
                                         gc_object_name,
                                         gc_owner_name,
                                         :NEW.change_reason,
                                         'Source Fund Id: '||:OLD.source_fund_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:OLD.fund||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:OLD.source_id)||utl.pkg_constants.gc_cr||
                                         'Investment Engine: '||pkg_investment_engine.get_description(:OLD.ie_id)||utl.pkg_constants.gc_cr||
                                         'ME Fund: '||pkg_ref_object.get_description(:OLD.me_fund_id)||utl.pkg_constants.gc_cr||
                                         'Active?: '||:OLD.active_ind||utl.pkg_constants.gc_cr||
                                         'Benchmark Fund: '||pkg_ref_object.get_description(:OLD.me_benchmark_fund_id),
                                         'Source Fund Id: '||:NEW.source_fund_id||utl.pkg_constants.gc_cr||
                                         'Fund: '||:NEW.fund||utl.pkg_constants.gc_cr||
                                         'Source: '||pkg_source.get_source_name(:NEW.source_id)||utl.pkg_constants.gc_cr||
                                         'Investment Engine: '||pkg_investment_engine.get_description(:NEW.ie_id)||utl.pkg_constants.gc_cr||
                                         'ME Fund: '||pkg_ref_object.get_description(:NEW.me_fund_id)||utl.pkg_constants.gc_cr||
                                         'Active?: '||:NEW.active_ind||utl.pkg_constants.gc_cr||
                                         'Benchmark Fund: '||pkg_ref_object.get_description(:NEW.me_benchmark_fund_id));
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    utl.pkg_errorhandler.handle;

    RAISE;
END tr_ar_source_fund;
/
