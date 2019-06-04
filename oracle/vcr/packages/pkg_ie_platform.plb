create or replace package body vcr.pkg_ie_platform as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_ie_platform.plb 1.2.1.3 2005/10/07 13:19:13BST apenney DEV  $
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
       select e.ie_id   as "Investment Engine",
              p.ie_platform   as "Shortcode",
              p.email_address as "Contact",
              p.description   as "IE Platform"              
         from ie_platform p
        inner join investment_engine e on e.ie_id = p.ie_id
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
      from ie_platform p
     inner join investment_engine e on e.ie_id = p.ie_id;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_ie_id         in ie_platform.ie_id%type,
                      p_ie_platform   in ie_platform.ie_platform%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
       select e.ie_id   as "Investment Engine",
              p.ie_platform   as "Shortcode",              
              p.email_address as "Contact",
              p.description   as "IE Platform"
         from ie_platform p
        inner join investment_engine e on e.ie_id = p.ie_id
        where p.ie_id = p_ie_id
          and p.ie_platform = p_ie_platform;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
    
end pkg_ie_platform;
/
