create or replace package body vcr.pkg_source_file_type_mod as
-- $Header: vcr/packages/pkg_source_file_type_mod.plb 1.1 2005/07/29 16:56:41BST ghoekstra DEV  $

  procedure delete_detail(
    p_source_file_type         in source_file_type.source_file_type%type,
    --p_source_id                in source_file_type.source_id%type,
    --p_file_type                in source_file_type.file_type%type, 
    --p_no_of_files              in source_file_type.no_of_files%type, 
    p_change_reason            in source_file_type.change_reason%type
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
    update source_file_type
       set change_reason=p_change_reason
     where p_source_file_type=source_file_type;
    delete source_file_type
     where p_source_file_type=source_file_type;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;

  procedure insert_detail(
    p_source_file_type         in source_file_type.source_file_type%type,
    p_source_id                in source_file_type.source_id%type,
    p_file_type                in source_file_type.file_type%type, 
    p_no_of_files              in source_file_type.no_of_files%type, 
    p_change_reason            in source_file_type.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into source_file_type(    
           source_file_type,         
           source_id,        
           file_type,       
           no_of_files,       
           change_reason)
    values(p_source_file_type,         
           p_source_id,        
           p_file_type,       
           p_no_of_files,       
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
    p_source_file_type         in source_file_type.source_file_type%type,
    p_source_id                in source_file_type.source_id%type,
    p_file_type                in source_file_type.file_type%type, 
    p_no_of_files              in source_file_type.no_of_files%type, 
    p_change_reason            in source_file_type.change_reason%type
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
    update source_file_type
       set source_id = p_source_id,
           file_type = p_file_type,
           no_of_files = p_no_of_files,
           change_reason=p_change_reason
     where p_source_file_type=source_file_type;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_source_file_type_mod;      
/
