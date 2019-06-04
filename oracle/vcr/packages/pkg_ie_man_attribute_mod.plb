CREATE OR REPLACE PACKAGE BODY
  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_ie_man_attribute_mod.plb 1.1 2005/09/27 13:12:11BST apenney DEV  $
  --------------------------------------------------------------------------
  -- Allows you to update investment engine mandatory attributes
 vcr.pkg_ie_man_attribute_mod
 AS
  procedure delete_detail
  (
    p_ie_id                     in investment_engine.ie_id%type,                
    p_table_name                in ie_target_column.table_name%type, 
    p_column_name               in ie_target_column.column_name%type,     
    p_change_reason             in ie_target_column.change_reason%type        
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
    update ie_target_column ietc
       set change_reason=p_change_reason
     where ietc.ie_id=p_ie_id
       and ietc.table_name = p_table_name
       and ietc.column_name = p_column_name;
       
    delete ie_target_column ietc
    where ietc.ie_id=p_ie_id
       and ietc.table_name = p_table_name
       and ietc.column_name = p_column_name;
       
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;

  procedure insert_detail(
    p_ie_id                     in investment_engine.ie_id%type,                
    p_table_name                in ie_target_column.table_name%type, 
    p_column_name               in ie_target_column.column_name%type,     
    p_change_reason             in ie_target_column.change_reason%type        
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;        
    insert into ie_target_column(    
           ie_id,                
           table_name,          
           column_name, 
           change_reason)
    values(p_ie_id,                
           p_table_name,          
           p_column_name, 
           p_change_reason);
    commit;
    dbms_application_info.set_module(null, null);    
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end insert_detail;
end pkg_ie_man_attribute_mod;
/
