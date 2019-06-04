create or replace package body vcr.pkg_file_type_field as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_file_type_field.plb 1.2 2005/09/27 13:15:50BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list(  p_file_type    in file_type_field.file_type%type,
                      p_field_name   in file_type_field.field_name%type)
  return utl.global.t_result_set
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_field_name);  
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select f.file_type,
              f.field_name
         from file_type_field f
        where field_name like v_searchterm||'%'
        and   (p_file_type is null or file_type = p_file_type)
       order by 1,2 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count( p_file_type    in file_type_field.file_type%type,
                      p_field_name   in file_type_field.field_name%type) 
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_field_name);
  begin
    dbms_application_info.set_module(c_proc_name, null);    

    select count(*) 
      into v_count
      from file_type_field f
     where field_name like v_searchterm||'%'
     and   (p_file_type is null or file_type = p_file_type);
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;

 function get_dropdown_list(p_file_type    in file_type_field.file_type%type)
  return utl.global.t_result_set
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select f.field_name
         from file_type_field f
        where file_type = p_file_type
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_dropdown_list;
  
  function get_dropdown_count( p_file_type    in file_type_field.file_type%type) 
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);    

    select count(*) 
      into v_count
      from file_type_field f
        where file_type = p_file_type;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_dropdown_count;
    
  function get_detail(p_file_type    in file_type_field.file_type%type,
                      p_field_name   in file_type_field.field_name%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for    
      select f.file_type,
             f.field_name
        from file_type_field f
       where field_name = p_field_name
         and file_type = p_file_type;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  

end pkg_file_type_field;
/
