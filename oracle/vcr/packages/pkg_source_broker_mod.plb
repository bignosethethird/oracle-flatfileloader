create or replace package body vcr.pkg_source_broker_mod as
-- $Header: vcr/packages/pkg_source_broker_mod.plb 1.1.1.3 2005/09/27 15:17:26BST apenney DEV  $
    
  procedure update_detail(
   p_source_broker_id in source_broker.source_broker_id%type,  
   p_prime_broker_id  in prime_broker.prime_broker_id%type,
   p_change_reason    in prime_broker.change_reason%type
  )
  is 
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.update_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
     
    update source_broker
       set prime_broker_id = decode(p_prime_broker_id,to_number(utl.pkg_constants.gc_unmapped_key),null,p_prime_broker_id),
           change_reason   = p_change_reason
     where source_broker_id = p_source_broker_id;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_source_broker_mod;      
/
