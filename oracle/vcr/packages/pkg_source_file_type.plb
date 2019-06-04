create or replace package body vcr.pkg_source_file_type as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_file_type.plb 1.3 2005/09/27 13:15:59BST apenney DEV  $
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
       select sf.source_file_type,
              s.source_name,
              sf.file_type,
              sf.no_of_files
         from source_file_type sf
        inner join source s on s.source_id = sf.source_id
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
      from source_file_type sf
     inner join source s on s.source_id = sf.source_id;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_source_file_type         in source_file_type.source_file_type%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
       select sf.source_file_type,
              s.source_id,
              sf.file_type,
              sf.no_of_files
         from source_file_type sf
        inner join source s on s.source_id = sf.source_id
        where sf.source_file_type = p_source_file_type;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  
end pkg_source_file_type;
/
