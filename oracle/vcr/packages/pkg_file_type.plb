create or replace package body vcr.pkg_file_type as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_file_type.plb 1.2 2005/09/27 13:16:04BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;    
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select f.file_type,
              f.table_name,
              f.delimiter,
              f.ignore_records,
              f.accounting_period_field,
              f.description,
              f.document_name,
              f.date_format,
              f.end_of_line,
              f.string_encloser,
              f.check_type,
              f.preserve_unmapped
         from file_type f
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    select count(*) 
      into v_count
      from file_type;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_file_type    in file_type.file_type%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
      select f.file_type,
             f.table_name,
             f.delimiter,
             f.ignore_records,
             f.accounting_period_field,
             f.description,
             f.document_name,
             f.date_format,
             f.end_of_line,
             f.string_encloser,
             f.check_type,
             f.preserve_unmapped
        from file_type f
       where f.file_type = p_file_type;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  

end pkg_file_type;
/
