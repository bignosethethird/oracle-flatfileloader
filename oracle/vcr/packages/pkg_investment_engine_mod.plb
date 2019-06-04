create or replace package body vcr.pkg_investment_engine_mod as
-- $Header: vcr/packages/pkg_investment_engine_mod.plb 1.2 2005/08/08 17:21:41BST ghoekstra DEV  $

  /*
  procedure delete_detail(
    p_ie_id                     in investment_engine.ie_id%type,                
    --p_description               in investment_engine.description%type,          
    --p_me_source                 in investment_engine.me_source%type,            
    --p_email_address             in investment_engine.email_address%type,        
    --p_ignore_zero_positions     in investment_engine.ignore_zero_positions%type,
    --p_ror_calc_denominator      in investment_engine.ror_calc_denominator%type, 
    p_change_reason             in investment_engine.change_reason%type        
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.delete_detail';
    pragma autonomous_transaction;
  begin  
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    -- Ditry trick: Update change reason before deletion
    update investment_engine
       set change_reason=p_change_reason
     where ie_id=p_ie_id;
    delete investment_engine
     where ie_id=p_ie_id;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;
  */

  procedure insert_detail(
    p_ie_id                     in investment_engine.ie_id%type,                
    p_description               in investment_engine.description%type,          
    p_me_source                 in investment_engine.me_source%type,            
    p_email_address             in investment_engine.email_address%type,        
    p_ignore_zero_positions     in investment_engine.ignore_zero_positions%type,
    p_ror_calc_denominator      in investment_engine.ror_calc_denominator%type, 
    p_change_reason             in investment_engine.change_reason%type        
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into investment_engine(    
           ie_id,                
           description,          
           me_source,            
           email_address,        
           ignore_zero_positions,
           ror_calc_denominator, 
           change_reason)
    values(p_ie_id,                
           p_description,          
           p_me_source,            
           p_email_address,        
           p_ignore_zero_positions,
           p_ror_calc_denominator, 
           p_change_reason);
    commit;
    dbms_application_info.set_module(null, null);    
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end insert_detail;
    
  procedure update_detail(
    p_ie_id                     in investment_engine.ie_id%type,                
    p_description               in investment_engine.description%type,          
    p_me_source                 in investment_engine.me_source%type,            
    p_email_address             in investment_engine.email_address%type,        
    p_ignore_zero_positions     in investment_engine.ignore_zero_positions%type,
    p_ror_calc_denominator      in investment_engine.ror_calc_denominator%type, 
    p_change_reason             in investment_engine.change_reason%type        
  )
  is 
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.update_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    -- Update non-PK values      
    update investment_engine
       set description             = p_description,            
           me_source               = p_me_source,              
           email_address           = p_email_address,          
           ignore_zero_positions   = p_ignore_zero_positions,  
           ror_calc_denominator    = p_ror_calc_denominator,   
           change_reason           = p_change_reason          
     where ie_id=p_ie_id;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_investment_engine_mod;      
/
