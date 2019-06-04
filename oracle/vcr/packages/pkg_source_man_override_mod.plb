create or replace package body vcr.pkg_source_man_override_mod as
-- $Header: vcr/packages/pkg_source_man_override_mod.plb 1.2 2005/09/27 13:15:51BST apenney DEV  $

  procedure delete_detail(
    p_source_object_id             in source_mandatory_override.source_object_id%type,  
    p_source_object_type           in source_mandatory_override.source_object_type%type,
    p_table_name                   in source_mandatory_override.table_name%type,        
    p_column_name                  in source_mandatory_override.column_name%type,       
    p_change_reason                in source_mandatory_override.change_reason%type
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
    update source_mandatory_override
       set change_reason=p_change_reason
     where source_object_id=p_source_object_id
       and source_object_type = p_source_object_type
       and table_name = p_table_name
       and column_name = p_column_name;
    delete source_mandatory_override
     where source_object_id=p_source_object_id
       and source_object_type = p_source_object_type
       and table_name = p_table_name
       and column_name = p_column_name;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;

  procedure insert_detail(
    p_source_object_id             in source_mandatory_override.source_object_id%type,  
    p_source_object_type           in source_mandatory_override.source_object_type%type,
    p_table_name                   in source_mandatory_override.table_name%type,        
    p_column_name                  in source_mandatory_override.column_name%type,       
    p_mandatory_ind                in source_mandatory_override.mandatory_ind%type,     
    p_change_reason                in source_mandatory_override.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into source_mandatory_override(    
           source_object_id,  
           source_object_type,
           table_name,        
           column_name,       
           mandatory_ind,     
           change_reason)
    values(p_source_object_id,  
           p_source_object_type,
           p_table_name,        
           p_column_name,       
           p_mandatory_ind,     
           p_change_reason);
    commit;
    dbms_application_info.set_module(null, null);    
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end insert_detail; 
end pkg_source_man_override_mod;      
/
