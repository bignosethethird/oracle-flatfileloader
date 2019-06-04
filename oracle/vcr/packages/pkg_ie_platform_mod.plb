create or replace package body vcr.pkg_ie_platform_mod as
-- $Header: vcr/packages/pkg_ie_platform_mod.plb 1.1 2005/07/29 16:56:36BST ghoekstra DEV  $

  /*
  procedure delete_detail(
    p_ie_id               in ie_platform.ie_id%type,        
    p_ie_platform         in ie_platform.ie_platform%type,  
    p_change_reason       in ie_platform.change_reason%type
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
    update ie_platform
       set change_reason=p_change_reason
     where ie_id=p_ie_id
       and ie_platform = p_ie_platform;
    delete ie_platform
     where ie_id=p_ie_id
       and ie_platform = p_ie_platform;
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
    p_ie_id               in ie_platform.ie_id%type,        
    p_ie_platform         in ie_platform.ie_platform%type,  
    p_email_address       in ie_platform.email_address%type,
    p_description         in ie_platform.description%type,
    p_change_reason       in ie_platform.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into ie_platform(    
           ie_id,                
           ie_platform,          
           email_address,            
           description,        
           change_reason)
    values(p_ie_id,                
           p_ie_platform,          
           p_email_address,            
           p_description,        
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
    p_ie_id               in ie_platform.ie_id%type,        
    p_ie_platform         in ie_platform.ie_platform%type,  
    p_email_address       in ie_platform.email_address%type,
    p_description         in ie_platform.description%type,
    p_change_reason       in ie_platform.change_reason%type
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
    update ie_platform
       set email_address         = p_email_address,            
           description           = p_description,              
           change_reason           = p_change_reason          
     where ie_id=p_ie_id
       and ie_platform = p_ie_platform;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_ie_platform_mod;      
/
