create or replace package body vcr.pkg_file_type_field_mod as
-- $Header: vcr/packages/pkg_file_type_field_mod.plb 1.2 2005/09/27 13:16:03BST apenney DEV  $

  procedure delete_detail(
    p_file_type                in file_type_field.file_type%type,
    p_field_name               in file_type_field.field_name%type,
    p_change_reason            in file_type_field.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.delete_detail';
    pragma autonomous_transaction;
    
    v_count PLS_INTEGER;
  begin  
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   field_target_column ftc
    WHERE  ftc.file_type = p_file_type
    AND    ftc.field_name = p_field_name;
    
    IF v_count <> 0
    THEN
      RAISE utl.pkg_exceptions.e_field_mapped;
    END IF;
    
    -- Ditry trick: Update change reason before deletion
    update file_type_field
       set change_reason=p_change_reason
     where p_file_type=file_type
       and p_field_name=field_name;
    delete file_type_field
     where p_file_type=file_type
       and p_field_name=field_name;
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;

  procedure insert_detail(
    p_file_type                in file_type_field.file_type%type,
    p_field_name               in file_type_field.field_name%type,
    p_change_reason            in file_type_field.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into file_type_field(
           file_type,
           field_name,
           change_reason)
    values(p_file_type,          
           upper(p_field_name),
           p_change_reason);
    commit;
    dbms_application_info.set_module(null, null);    
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end insert_detail;
  
end pkg_file_type_field_mod;      
/
