create or replace package body vcr.pkg_source_mod as
-- $Header: vcr/packages/pkg_source_mod.plb 1.2 2005/08/16 14:45:09BST ghoekstra DEV  $

  procedure insert_detail(
    p_source_name           in source.source_name%type,      
    p_email_address         in source.email_address%type,    
    p_secure_message_id     in source.secure_message_id%type,
    p_tplus1_offset         in source.tplus1_offset%type,    
    p_change_reason         in source.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into source(    
           source_id,
           source_name,      
           email_address,    
           secure_message_id,
           tplus1_offset,    
           change_reason)
    values(sq_source.nextval,
           p_source_name,       
           p_email_address,     
           p_secure_message_id, 
           p_tplus1_offset,     
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
    p_source_id             in source.source_id%type,       
    p_source_name           in source.source_name%type,      
    p_email_address         in source.email_address%type,    
    p_secure_message_id     in source.secure_message_id%type,
    p_tplus1_offset         in source.tplus1_offset%type,    
    p_change_reason         in source.change_reason%type
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
    update source
       set source_name             = p_source_name,      
           email_address           = p_email_address,    
           secure_message_id       = p_secure_message_id,
           tplus1_offset           = p_tplus1_offset,    
           change_reason           = p_change_reason   
     where source_id               = p_source_id;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_source_mod;      
/
