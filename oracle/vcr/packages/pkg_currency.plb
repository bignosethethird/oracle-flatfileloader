CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_currency.plb 1.4 2005/03/02 10:41:54GMT apenney PRODUCTION  $
--------------------------------------------------------------------------
-- Allows you to query currency information (both source and iso)
 vcr.pkg_currency AS

  -- returns a ref cursor for a result set of source currencies for the specified 
  -- source id p_source_id for use in dropdown lists in user interface
  FUNCTION get_source_dropdown_list(p_source_id IN source.source_id%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_source_dropdown_list', null);  

    OPEN cur_list FOR
      SELECT currency
      FROM   source_currency
      WHERE  source_id = p_source_id
      ORDER BY currency;

    dbms_application_info.set_module(null, null);  

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_dropdown_list;
  
  -- returns a count of the number of ISO currency codes for use in dropdown lists in user interface
  FUNCTION get_iso_dropdown_count(p_include_undefined IN CHAR DEFAULT 'Y') RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_iso_dropdown_count', null);  
    
    SELECT COUNT(*) + decode(p_include_undefined, 'Y', 1, 0)
    INTO   v_count
    FROM   iso_currency_code icc;
      
    dbms_application_info.set_module(null, null);  
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_iso_dropdown_count;
  
  -- returns a ref cursor for a result set of ISO currency codes for use in dropdown lists in user interface
  FUNCTION get_iso_dropdown_list(p_include_undefined IN CHAR DEFAULT 'Y') RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_iso_dropdown_list', null);  
    
    OPEN cur_list FOR
    SELECT code, description
    FROM
    (
      SELECT icc.iso_currency_code code, 
             icc.iso_currency_code || ' ' || icc.description description, 2
      FROM   iso_currency_code icc
      UNION
      SELECT utl.pkg_constants.gc_unmapped_key code, utl.pkg_constants.gc_unmapped_desc description, 1
      FROM   dual
      WHERE p_include_undefined = 'Y'
      ORDER BY 3,2
    );
      
    dbms_application_info.set_module(null, null);  
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_iso_dropdown_list;
  
  -- returns a count of the number of currencies that meet the following criteria
  -- Parameters:
  --         p_source_id          optional id of source
  --         p_currency            optional currency used for LIKE
  --         p_iso_currency_code   optional iso currency code
  -- used in currency list screen
  
  FUNCTION get_count(p_source_id        IN source.source_id%TYPE,
                     p_currency          IN source_currency.currency%TYPE,
                     p_iso_currency_code IN source_currency.iso_currency_code%TYPE)
    RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_count', null);  
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source s, source_currency sc
    WHERE  ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
    AND    s.source_id = sc.source_id
    AND    ((p_currency IS NULL) OR
           (p_currency IS NOT NULL and sc.currency LIKE p_currency))
    AND    ((p_iso_currency_code IS NULL) OR
           (p_iso_currency_code = utl.pkg_constants.gc_unmapped_key AND sc.iso_currency_code IS NULL) OR
            (p_iso_currency_code IS NOT NULL AND sc.iso_currency_code = p_iso_currency_code)              );

    dbms_application_info.set_module(null, null);      

    RETURN v_count; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
  
  -- returns a ref cursor for a result set of currencies with the following columns
  --         source.source_id "Source"
  --         source_currency.currency "currency"
  --         source_currency.iso_currency_code "ISO currency Code"
  --         source.source_name
  -- Parameters:
  --         p_source_id          optional id of source
  --         p_currency            optional currency used for LIKE
  --         p_iso_currency_code   optional iso currency code
  -- used in currency list screen
  
  FUNCTION get_list(p_source_id        IN source.source_id%TYPE,
                    p_currency          IN source_currency.currency%TYPE,
                    p_iso_currency_code IN source_currency.iso_currency_code%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_list', null);  
    
    OPEN cur_list FOR
      SELECT s.source_id         "Source",
             sc.currency          "currency", 
             decode(sc.iso_currency_code,
                    null,utl.pkg_constants.gc_unmapped_desc,
                    sc.iso_currency_code||' '||icc.description) "ISO currency Code",
             s.source_name       "Source Name"
      FROM   source s, source_currency sc, iso_currency_code icc
      WHERE  ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
      AND    s.source_id = sc.source_id
      AND    ((p_currency IS NULL) OR
              (p_currency IS NOT NULL and sc.currency LIKE p_currency))
      AND    ((p_iso_currency_code IS NULL) OR
              (p_iso_currency_code = utl.pkg_constants.gc_unmapped_key AND sc.iso_currency_code IS NULL) OR
              (p_iso_currency_code IS NOT NULL AND sc.iso_currency_code = p_iso_currency_code)              )
      AND     sc.iso_currency_code = icc.iso_currency_code (+)
      ORDER BY sc.currency, s.source_name;    

    dbms_application_info.set_module(null, null);      

    RETURN cur_list; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;    
  END get_list;
  
  -- returns a ref cursor for a result set of one currency the following columns
  --         source.source_name "Source"
  --         source_currency.currency "currency"
  --         source_currency.iso_currency_code "ISO currency Code"
  -- Parameters:
  --         p_source_id mandatory id of source
  --         p_currency   mandatory currency
  -- used in currency detail screen
  
  FUNCTION get_detail(p_source_id IN source.source_id%TYPE,
                      p_currency   IN source_currency.currency%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency.get_detail', null);  
    
    OPEN cur_detail FOR
      SELECT s.source_name       "Source",
             sc.currency          "currency", 
             sc.iso_currency_code "ISO currency Code"
      FROM   source s, source_currency sc
      WHERE  s.source_id  = sc.source_id
      AND    sc.source_id = p_source_id
      AND    sc.currency   = p_currency;

    dbms_application_info.set_module(null, null);    
      
    RETURN cur_detail; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;    
  END get_detail;
END pkg_currency;
/
