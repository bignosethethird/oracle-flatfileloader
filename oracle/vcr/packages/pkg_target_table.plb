create or replace package body vcr.pkg_target_table as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_target_table.plb 1.2 2005/09/27 13:15:57BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
    
  -- Dropdown list    
  function get_dropdown_list
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
      select t.table_name
        from target_table t
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_dropdown_list;

  function get_dropdown_count
  return pls_integer
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);
    select count(*) 
      into v_count
      from target_table;
    dbms_application_info.set_module(null, null);      
    return v_count;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_dropdown_count;

 function get_col_dropdown_list(p_table_name IN target_table.table_name%TYPE)
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_col_dropdown_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
      select t.column_name,
             t.column_name
        from target_column t
        where t.table_name = p_table_name         
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_col_dropdown_list;

  function get_col_dropdown_count(p_table_name IN target_table.table_name%TYPE)
  return pls_integer
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_col_dropdown_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);
    select count(*) 
      into v_count
      from target_column t
      where t.table_name = p_table_name;
        
    dbms_application_info.set_module(null, null);      
    return v_count;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_col_dropdown_count;  
end pkg_target_table;
/
