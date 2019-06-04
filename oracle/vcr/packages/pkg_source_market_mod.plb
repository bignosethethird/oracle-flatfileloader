create or replace package body vcr.pkg_source_market_mod as
-- $Header: vcr/packages/pkg_source_market_mod.plb 1.2 2005/09/27 15:26:46BST apenney DEV  $
    
  procedure update_detail(
   p_market_name   in source_market.market_name%type,  
   p_source_id     in source_market.source_id%type,
   p_exchange_code in source_market.exchange_code%type,
   p_change_reason in source_market.change_reason%type
  )
  is 
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.update_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
     
    update source_market
       set exchange_code = decode(p_exchange_code,utl.pkg_constants.gc_unmapped_key,null,p_exchange_code),
           change_reason = p_change_reason
     where market_name = p_market_name
     and   source_id   = p_source_id;
     
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_source_market_mod;      
/
