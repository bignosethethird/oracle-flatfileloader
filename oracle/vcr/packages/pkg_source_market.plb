create or replace package body vcr.pkg_source_market as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_market.plb 1.3 2005/10/21 11:00:13BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list(  p_source_id      in source_market.source_id%type,
                      p_market_name    in source_market.market_name%type,
                      p_exchange_code  in source_market.exchange_code%type)
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_market_name);  
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select m.market_name,
              decode(m.exchange_code,
                    null,utl.pkg_constants.gc_unmapped_desc,
                    e.exchange_code||' '||e.description),
              s.source_name,
              m.source_id
         from source_market m, source s, exchange_code e
        where m.source_id = s.source_id
        and   m.exchange_code = e.exchange_code (+)
        and   (p_market_name is null or upper(m.market_name) like v_searchterm||'%')
        and   (p_exchange_code is null or (p_exchange_code = utl.pkg_constants.gc_unmapped_key and m.exchange_code is null) or m.exchange_code = p_exchange_code)
        and   (p_source_id is null or m.source_id = p_source_id)
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count(  p_source_id      in source_market.source_id%type,
                      p_market_name    in source_market.market_name%type,
                      p_exchange_code  in source_market.exchange_code%type)
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
    v_searchterm varchar2(100):=utl.pkg_string.clean4query(p_market_name);
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    
    select count(*) 
      into v_count
       from source_market m
        where (p_market_name is null or upper(m.market_name) like v_searchterm||'%')
        and   (p_exchange_code is null or (p_exchange_code = utl.pkg_constants.gc_unmapped_key and m.exchange_code is null) or m.exchange_code = p_exchange_code)
        and   (p_source_id is null or m.source_id = p_source_id);
        
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_market_name    in source_market.market_name%type,
                      p_source_id      in source_market.source_id%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
       select m.exchange_code,
              s.source_name
         from source_market m, source s
        where upper(p_market_name) = upper(m.market_name)
          and s.source_id = p_source_id
          and s.source_id = m.source_id;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  
  function get_exch_dropdown_list(p_include_undefined IN CHAR DEFAULT 'Y')
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_exch_dropdown_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
    SELECT code, description
    FROM
    (
      SELECT e.exchange_code code, 
             e.exchange_code || ' ' || e.description description, 2, e.description d2
      FROM   exchange_code e
      UNION
      SELECT utl.pkg_constants.gc_unmapped_key code, utl.pkg_constants.gc_unmapped_desc description, 1, utl.pkg_constants.gc_unmapped_desc d2
      FROM   dual
      WHERE p_include_undefined = 'Y'
      ORDER BY 3,4
    );
    
    dbms_application_info.set_module(null, null);      
    return cur_list;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_exch_dropdown_list;

  function get_exch_dropdown_count(p_include_undefined IN CHAR DEFAULT 'Y')
  return pls_integer
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_exch_dropdown_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);
    SELECT COUNT(*) + decode(p_include_undefined, 'Y', 1, 0)
    INTO   v_count
    FROM   exchange_code;
    dbms_application_info.set_module(null, null);      
    return v_count;     
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;    
  end get_exch_dropdown_count;    

end pkg_source_market;
/
