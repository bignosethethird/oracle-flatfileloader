create or replace package body vcr.pkg_field_target_column_mod as
-- $Header: vcr/packages/pkg_field_target_column_mod.plb 1.2 2005/09/27 13:15:46BST apenney DEV  $

  procedure delete_detail(
    p_file_type                in field_target_column.file_type%type,
    p_field_name               in field_target_column.field_name%type,
    p_table_name               in field_target_column.table_name%type, 
    p_column_name              in field_target_column.column_name%type, 
    p_change_reason            in field_target_column.change_reason%type
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
    update field_target_column
       set change_reason=p_change_reason
     where p_file_type=file_type
       and p_field_name=field_name
       and p_table_name=table_name
       and p_column_name=column_name;
    delete field_target_column
     where p_file_type=file_type
       and p_field_name=field_name
       and p_table_name=table_name
       and p_column_name=column_name;       
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end delete_detail;

  procedure insert_detail(
    p_file_type                in field_target_column.file_type%type,
    p_field_name               in field_target_column.field_name%type,
    p_table_name               in field_target_column.table_name%type, 
    p_column_name              in field_target_column.column_name%type, 
    p_accounting_period        in field_target_column.accounting_period%type,
    p_in_unique_key            in field_target_column.in_unique_key%type,
    p_change_reason            in field_target_column.change_reason%type
  )
  is
    c_proc_name   constant varchar2(100) := pc_schema||'.'||pc_package||'.insert_detail';
    pragma autonomous_transaction;
  begin
    dbms_application_info.set_module(c_proc_name, null);  
    if p_change_reason is null then
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    end if;
    insert into field_target_column(    
           file_type,         
           field_name,        
           table_name,       
           column_name,       
           accounting_period, 
           in_unique_key,     
           change_reason)
    values(p_file_type,         
           p_field_name,        
           p_table_name,       
           p_column_name,       
           p_accounting_period, 
           p_in_unique_key,     
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
    p_file_type                in field_target_column.file_type%type,
    p_field_name               in field_target_column.field_name%type,
    p_table_name               in field_target_column.table_name%type, 
    p_column_name              in field_target_column.column_name%type, 
    p_accounting_period        in field_target_column.accounting_period%type,
    p_in_unique_key            in field_target_column.in_unique_key%type,
    p_change_reason            in field_target_column.change_reason%type
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
    update field_target_column
       set accounting_period   = p_accounting_period,
           in_unique_key       = p_in_unique_key,    
           change_reason       = p_change_reason
     where p_file_type=file_type
       and p_field_name=field_name
       and p_table_name=table_name
       and p_column_name=column_name;       
    commit;
    dbms_application_info.set_module(null, null);  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end update_detail;  
  
end pkg_field_target_column_mod;      
/
