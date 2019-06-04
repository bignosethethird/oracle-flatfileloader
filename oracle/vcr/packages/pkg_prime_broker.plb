create or replace package body vcr.pkg_prime_broker as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_prime_broker.plb 1.3 2005/09/27 13:15:50BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list(p_description      in prime_broker.description%type)
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_description);  
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
      select p.description,
             p.prime_broker_id
        from prime_broker p
       where upper(p.description) like v_searchterm||'%'
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count(p_description      in prime_broker.description%type) 
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_description);
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    select count(*) 
      into v_count
      from prime_broker p
     where upper(p.description) like v_searchterm||'%';
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_prime_broker_id   in prime_broker.prime_broker_id%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
      select p.description
        from prime_broker p
       where prime_broker_id = p_prime_broker_id;
     dbms_application_info.set_module(null, null);      
     return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  
  -- Dropdown list    
  function get_dropdown_list(p_include_undefined IN CHAR DEFAULT 'Y')
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);     
    
    open cur_list for
    SELECT code, description
    FROM
    (
      select p.prime_broker_id code,
             p.description description,
             2
      from   prime_broker p
      UNION
      SELECT to_number(utl.pkg_constants.gc_unmapped_key) code, utl.pkg_constants.gc_unmapped_desc description, 1
      FROM   dual
      WHERE p_include_undefined = 'Y'
      ORDER BY 3,2
    );  

    dbms_application_info.set_module(null, null);      
    return cur_list;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_dropdown_list;

  function get_dropdown_count(p_include_undefined IN CHAR DEFAULT 'Y')
  return pls_integer
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_dropdown_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);
    select count(*) + decode(p_include_undefined, 'Y', 1, 0)
      into v_count
      from prime_broker p;
    dbms_application_info.set_module(null, null);      
    return v_count;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_dropdown_count;  

  function get_description(p_prime_broker_id IN prime_broker.prime_broker_id%TYPE) RETURN VARCHAR2
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_description';

    v_description prime_broker.description%TYPE;
  begin
    dbms_application_info.set_module(c_proc_name, null);
    
    begin
      select p.description
      into   v_description
        from prime_broker p
       where p.prime_broker_id = p_prime_broker_id;
    exception
      when no_data_found then
        return null;
      when others then
        raise;
    end;
    
    dbms_application_info.set_module(null, null);      
    return v_description;  
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_description;  
end pkg_prime_broker;
/
