CREATE OR REPLACE PACKAGE BODY
  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_ie_man_attribute.plb 1.2 2005/09/27 13:15:56BST apenney DEV  $
  --------------------------------------------------------------------------
  -- Allows you to query investment engine mandatory attributes
 vcr.pkg_ie_man_attribute
 AS

  -- GUI list display based on partial name search string 
  -- If none specified, return all.
  function get_list(p_ie_id      in investment_engine.ie_id%type)
  return utl.global.t_result_set
  AS
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module(c_proc_name,null);
    
    OPEN cur_list FOR
    SELECT ietc.ie_id, ietc.table_name, ietc.column_name
    FROM   ie_target_column ietc
    WHERE  (p_ie_id is null or ietc.ie_id = p_ie_id)
    ORDER BY 3;
    
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_list;
  
  -- returns the number of investment engines including/excluding the undefined investment engine

  FUNCTION get_count(p_ie_id in investment_engine.ie_id%type) RETURN INTEGER
  AS
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module(c_proc_name,null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   ie_target_column ietc
    WHERE  (p_ie_id is null or ietc.ie_id = p_ie_id);
        
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_count;

end pkg_ie_man_attribute;
/
