CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_country.plb 1.5 2005/03/22 15:54:38GMT apenney PRODUCTION  $
--------------------------------------------------------------------------
-- Allows you to query country information (both source and iso)
 vcr.pkg_country AS

  -- returns a ref cursor for a result set of source countries for the specified 
  -- source id p_source_id for use in dropdown lists in user interface
  FUNCTION get_source_dropdown_list(p_source_id IN source.source_id%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_source_dropdown_list', null);  

    OPEN cur_list FOR
      SELECT country
      FROM   source_country
      WHERE  source_id = p_source_id
      ORDER BY country;

    dbms_application_info.set_module(null, null);  

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_dropdown_list;
  
  -- returns a count of the number of ISO country codes for use in dropdown lists in user interface
  FUNCTION get_iso_dropdown_count(p_include_undefined IN CHAR DEFAULT 'Y') RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_iso_dropdown_count', null);  
    
    SELECT COUNT(*) + decode(p_include_undefined, 'Y', 1, 0)
    INTO   v_count
    FROM   iso_country_code icc;
      
    dbms_application_info.set_module(null, null);  
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_iso_dropdown_count;
  
  -- returns a ref cursor for a result set of ISO country codes for use in dropdown lists in user interface
  FUNCTION get_iso_dropdown_list(p_include_undefined IN CHAR DEFAULT 'Y') RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_iso_dropdown_list', null);  
    
    OPEN cur_list FOR
    SELECT code, description
    FROM
    (
      SELECT icc.iso_country_code3 code, 
             icc.description || ' ' || icc.iso_country_code2 || ' ' || icc.iso_country_code3 description, 2
      FROM   iso_country_code icc
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
  
  -- returns a count of the number of countries that meet the following criteria
  -- Parameters:
  --         p_source_id          optional id of source
  --         p_country            optional country used for LIKE
  --         p_iso_country_code   optional iso country code
  -- used in country list screen
  
  FUNCTION get_count(p_source_id        IN source.source_id%TYPE,
                     p_country          IN source_country.country%TYPE,
                     p_iso_country_code IN source_country.iso_country_code%TYPE)
    RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_count', null);  
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source s, source_country sc
    WHERE  ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
    AND    s.source_id = sc.source_id
    AND    ((p_country IS NULL) OR
           (p_country IS NOT NULL and sc.country LIKE p_country))
    AND    ((p_iso_country_code IS NULL) OR
           (p_iso_country_code = utl.pkg_constants.gc_unmapped_key AND sc.iso_country_code IS NULL) OR
            (p_iso_country_code IS NOT NULL AND sc.iso_country_code = p_iso_country_code)              );

    dbms_application_info.set_module(null, null);      

    RETURN v_count; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
  
  -- returns a ref cursor for a result set of countries with the following columns
  --         source.source_id "Source"
  --         source_country.country "Country"
  --         source_country.iso_country_code "ISO Country Code"
  --         source.source_name
  -- Parameters:
  --         p_source_id          optional id of source
  --         p_country            optional country used for LIKE
  --         p_iso_country_code   optional iso country code
  -- used in country list screen
  
  FUNCTION get_list(p_source_id        IN source.source_id%TYPE,
                    p_country          IN source_country.country%TYPE,
                    p_iso_country_code IN source_country.iso_country_code%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_list', null);  
    
    OPEN cur_list FOR
      SELECT s.source_id         "Source",
             sc.country          "Country", 
             decode(sc.iso_country_code,
                    null,utl.pkg_constants.gc_unmapped_desc,
                    icc.description||' '||icc.iso_country_code2||' '||sc.iso_country_code) "ISO Country Code",
             s.source_name       "Source Name"
      FROM   source s, source_country sc, iso_country_code icc
      WHERE  ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
      AND    s.source_id = sc.source_id
      AND    ((p_country IS NULL) OR
              (p_country IS NOT NULL and sc.country LIKE p_country))
      AND    ((p_iso_country_code IS NULL) OR
              (p_iso_country_code = utl.pkg_constants.gc_unmapped_key AND sc.iso_country_code IS NULL) OR
              (p_iso_country_code IS NOT NULL AND sc.iso_country_code = p_iso_country_code)              )
      AND     sc.iso_country_code = icc.iso_country_code3 (+)
      ORDER BY sc.country, s.source_name;    

    dbms_application_info.set_module(null, null);      

    RETURN cur_list; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;    
  END get_list;
  
  -- returns a ref cursor for a result set of one country the following columns
  --         source.source_name "Source"
  --         source_country.country "Country"
  --         source_country.iso_country_code "ISO Country Code"
  -- Parameters:
  --         p_source_id mandatory id of source
  --         p_country   mandatory country
  -- used in country detail screen
  
  FUNCTION get_detail(p_source_id IN source.source_id%TYPE,
                      p_country   IN source_country.country%TYPE)
    RETURN utl.global.t_result_set
  AS
    cur_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country.get_detail', null);  
    
    OPEN cur_detail FOR
      SELECT s.source_name       "Source",
             sc.country          "Country", 
             sc.iso_country_code "ISO Country Code"
      FROM   source s, source_country sc
      WHERE  s.source_id  = sc.source_id
      AND    sc.source_id = p_source_id
      AND    sc.country   = p_country;

    dbms_application_info.set_module(null, null);    
      
    RETURN cur_detail; 
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;    
  END get_detail;
END pkg_country;
/
