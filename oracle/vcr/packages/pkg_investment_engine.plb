CREATE OR REPLACE PACKAGE BODY vcr.pkg_investment_engine
----------------------------------------------------
-- $Header: vcr/packages/pkg_investment_engine.plb 1.9.1.1.1.4 2005/09/27 13:15:53BST apenney DEV  $
----------------------------------------------------
AS
  -- returns a ref cursor for a result set of the id and description of all 
  -- investment engines for use in dropdown lists in user interface

  FUNCTION get_dropdown_list(p_include_undefined IN CHAR DEFAULT 'Y') RETURN utl.global.t_result_set
  AS
    cur_ie_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_dropdown_list',null);
    
    OPEN cur_ie_list FOR
    SELECT ie_id, description
    FROM
    (
      SELECT ie_id, description, 2
      FROM   investment_engine
      UNION
      SELECT utl.pkg_constants.gc_unmapped_key, utl.pkg_constants.gc_unmapped_desc, 1
      FROM   dual
      WHERE  p_include_undefined = 'Y'
      ORDER BY 3,2
    );
    
    dbms_application_info.set_module(null,null);
    
    RETURN cur_ie_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_dropdown_list;
  
  -- returns the number of investment engines including/excluding the undefined investment engine

  FUNCTION get_dropdown_count(p_include_undefined IN CHAR DEFAULT 'Y') RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_dropdown_count',null);
    
    SELECT COUNT(*) + decode(p_include_undefined, 'Y', 1, 0)
    INTO   v_count
    FROM   investment_engine;
        
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_dropdown_count;
  
  -- returns a count of the  
  -- investment engine platforms for an investment engine 
  -- for use in dropdown lists in user interface
  FUNCTION get_platform_dropdown_count(p_ie_id IN ie_platform.ie_id%TYPE,
                                       p_include_undefined IN CHAR DEFAULT 'Y') RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_platform_dropdown_count',null);

    SELECT COUNT(*) 
    INTO   v_count
    FROM   ie_platform
    WHERE  p_ie_id IS NOT NULL AND ie_id = p_ie_id;

    IF p_include_undefined = 'Y'
    THEN
      v_count := v_count + 1;
    END IF;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_platform_dropdown_count;
  
  -- returns a ref cursor for a result set of the id and description of all 
  -- investment engine platforms for an investment engine 
  -- for use in dropdown lists in user interface
  FUNCTION get_platform_dropdown_list(p_ie_id IN ie_platform.ie_id%TYPE,
                                      p_include_undefined IN CHAR DEFAULT 'Y') RETURN utl.global.t_result_set
  AS
    cur_iep_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_platform_dropdown_list',null);

    OPEN   cur_iep_list FOR
    SELECT ie_platform, description
    FROM
    (
      SELECT ie_platform, description, 2
      FROM   ie_platform
      WHERE  p_ie_id IS NOT NULL AND ie_id = p_ie_id
      UNION
      SELECT utl.pkg_constants.gc_unmapped_key, utl.pkg_constants.gc_unmapped_desc, 1
      FROM   dual
      WHERE  p_include_undefined = 'Y'
      ORDER BY 3,2
    );

    dbms_application_info.set_module(null,null);
    
    RETURN cur_iep_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_platform_dropdown_list;
  
  -- returns investment engine description for parameter id
  FUNCTION get_description(p_ie_id IN investment_engine.ie_id%TYPE) RETURN VARCHAR2
  AS
    v_description investment_engine.description%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_description',null);

    SELECT description
    INTO   v_description
    FROM   investment_engine
    WHERE  ie_id = p_ie_id;

    dbms_application_info.set_module(null,null);    
   
    RETURN v_description;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      
      RAISE;
  END get_description;
  
  -- returns the manager estimate source for the specified investment engine
  FUNCTION get_me_source(p_ie_id IN investment_engine.ie_id%TYPE) RETURN VARCHAR2
  AS
    v_me_source investment_engine.me_source%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_investment_engine.get_me_source',null);

    BEGIN
      SELECT me_source
      INTO   v_me_source
      FROM   investment_engine
      WHERE  ie_id = p_ie_id;
    EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        v_me_source := null;
      WHEN OTHERS THEN
        RAISE;
    END;
    
    dbms_application_info.set_module(null,null);    
   
    RETURN v_me_source;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_me_source;
  
  
  -- GUI list display based on partial name search string 
  -- If none specified, return all.
  function get_list
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select ie.ie_id,
              ie.description,
              ie.me_source,
              nvl(ie.email_address,'Undefined'),
              ie.ignore_zero_positions,
              ie.ror_calc_denominator
         from investment_engine ie        
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
      from investment_engine;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_ie_id in investment_engine.ie_id%type)
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
      select ie.ie_id,
             ie.description,
             ie.me_source,
             ie.email_address,
             ie.ignore_zero_positions,
             ie.ror_calc_denominator
        from investment_engine ie
       where upper(ie.ie_id)= upper(p_ie_id);
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;  
  
end pkg_investment_engine;
/
