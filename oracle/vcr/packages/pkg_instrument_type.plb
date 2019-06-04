CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_instrument_type.plb 1.8.1.2.1.3 2005/10/18 16:50:01BST apenney DEV  $
--------------------------------------------------------------------------
-- Allows you to query instrument type information
 vcr.pkg_instrument_type 
 AS

  -- returns a count of the number of source instrument types for the specified
  -- source id p_source_id for use in dropdown lists in user interface
  FUNCTION get_source_dropdown_count(p_source_id IN source.source_id%TYPE) RETURN INTEGER
  AS   
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_dropdown_count',null);  

    SELECT COUNT(*)
    INTO   v_count
    FROM   source_instrument_type
    WHERE  p_source_id IS NOT NULL 
    AND    source_id = p_source_id;

    dbms_application_info.set_module(null,null);  
  
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_dropdown_count;
 
  -- returns a ref cursor for a result set of source instrument types for the specified
  -- source id p_source_id for use in dropdown lists in user interface
  FUNCTION get_source_dropdown_list(p_source_id IN source.source_id%TYPE)
    RETURN utl.global.t_result_set AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_dropdown_list',null);  
    
   -- select a list of instrument types for the source 
    OPEN cur_list FOR
      SELECT source_instrument_type_id, instrument_type
      FROM   source_instrument_type
      WHERE  p_source_id IS NOT NULL 
      AND    source_id = p_source_id
      ORDER  BY instrument_type;

    dbms_application_info.set_module(null,null);  
  
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_dropdown_list;

 -- returns a count of the number of IE instrument types for the specified
  -- investment engine for use in dropdown lists in user interface
  FUNCTION get_ie_dropdown_count(p_ie_id             IN investment_engine.ie_id%TYPE,
                                 p_include_undefined IN CHAR DEFAULT 'Y')
    RETURN INTEGER
  AS 
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_dropdown_count',null);  

    SELECT COUNT(*) + decode(p_include_undefined, 'Y', 1, 0)
    INTO   v_count
    FROM   ie_instrument_type
    WHERE  p_ie_id IS NOT NULL
    AND    ie_id = p_ie_id;
  
    dbms_application_info.set_module(null,null);  

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_dropdown_count;

  -- returns a ref cursor for a result set of IE instrument types for the specified
  -- investment engine p_ie_id for use in dropdown lists in user interface
  FUNCTION get_ie_dropdown_list(p_ie_id             IN investment_engine.ie_id%TYPE,
                                p_include_undefined IN CHAR DEFAULT 'Y')
    RETURN utl.global.t_result_set AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_dropdown_list',null);  

    -- select a list of instrument types for the investment engine
    OPEN cur_list FOR
      SELECT ie_instrument_type_id, ie_instrument_type
      FROM
      (
        SELECT ie_instrument_type_id, ie_instrument_type, 2
        FROM   ie_instrument_type
        WHERE  p_ie_id IS NOT NULL
        AND    ie_id = p_ie_id
        UNION
        SELECT to_number(utl.pkg_constants.gc_unmapped_key),
               utl.pkg_constants.gc_unmapped_desc,
               1
        FROM   dual
        WHERE  p_include_undefined = 'Y'
        ORDER  BY 3, 2
      );
  
    dbms_application_info.set_module(null,null);  

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_dropdown_list;

  -- returns a count of the source instrument type/investment engine combinations that meet the following parameters
  -- Parameters:
  --         p_source_id optional id of source 
  --         p_ie_id optional id of investment engine 
  --         p_source_instrument_type_id optional 
  --         p_ie_instrument_type_id optional
  -- used in source instrument type list screen

  FUNCTION get_source_ie_count(p_source_id                 IN source.source_id%TYPE,
                               p_ie_id                     IN investment_engine.ie_id%TYPE,
                               p_source_instrument_type_id IN source_instrument_type.source_instrument_type_id%TYPE,
                               p_ie_instrument_type_id     IN ie_instrument_type.ie_instrument_type_id%TYPE)
    RETURN INTEGER 
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_ie_count',null);  

    -- select a cartesian join between source instrument types for the specified source
    -- and all investment engines outer joined to the corresponding ie instrument type 
    -- (inline view ieit) if one has been defined 
    -- then filter this list if required by investment engine, source instrument  type 
    -- and ie instrument type
   
    SELECT COUNT(*)
    INTO   v_count
    FROM   (SELECT s.source_name,
                   ie.ie_id,
                   sit.instrument_type,
                   sit.source_instrument_type_id,
                   ie.description ie_description
            FROM   source                 s,
                   source_instrument_type sit,
                   investment_engine      ie
            WHERE  (p_source_id IS NULL OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
            AND    s.source_id = sit.source_id) sit,
           (SELECT ieit.ie_id,
                   ieit.ie_instrument_type,
                   sieit.source_instrument_type_id,
                   ieit.ie_instrument_type_id
            FROM   ie_instrument_type ieit, source_ie_ins_type sieit
            WHERE  ieit.ie_instrument_type_id =
                   sieit.ie_instrument_type_id) ieit
    WHERE  sit.source_instrument_type_id =
           ieit.source_instrument_type_id(+)
    AND    sit.ie_id = ieit.ie_id(+)
    AND    ((p_ie_id IS NOT NULL AND sit.ie_id = p_ie_id) OR
          (p_ie_id IS NULL))
    AND    ((p_source_instrument_type_id IS NOT NULL AND
          sit.source_instrument_type_id = p_source_instrument_type_id) OR
          (p_source_instrument_type_id IS NULL))
    AND    ((p_ie_instrument_type_id = utl.pkg_constants.gc_unmapped_key AND
          ieit.ie_instrument_type_id IS NULL) OR
          (p_ie_instrument_type_id IS NOT NULL AND
          ieit.ie_instrument_type_id = p_ie_instrument_type_id) OR
          (p_ie_instrument_type_id IS NULL));

    dbms_application_info.set_module(null,null);  

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_ie_count;
  
  -- returns a ref cursor for a result set of source/ie instrument type mappings
  -- with the following columns
  --         source_instrument_type.source_instrument_type_id
  --         investment_engine.ie_id
  --         source.source_name "Source"
  --         source_instrument_type.instrument_type "Source Instrument Type"
  --         investment_engine.description "Investment Engine"
  --         ie_instrument_type.ie_instrument_type "IE Instrument Type"
  -- Parameters:
  --         p_source_id optional id of source 
  --         p_ie_id optional id of investment engine 
  --         p_source_instrument_type_id optional 
  --         p_ie_instrument_type_id optional
  -- used in source instrument type list screen

  FUNCTION get_source_ie_list(p_source_id                 IN source.source_id%TYPE,
                              p_ie_id                     IN investment_engine.ie_id%TYPE,
                              p_source_instrument_type_id IN source_instrument_type.source_instrument_type_id%TYPE,
                              p_ie_instrument_type_id     IN ie_instrument_type.ie_instrument_type_id%TYPE)
    RETURN utl.global.t_result_set AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_ie_list',null);  

    -- select a cartesian join between source instrument types for the specified source
    -- and all investment engines outer joined to the corresponding ie instrument type 
    -- (inline view ieit) if one has been defined 
    -- then filter this list if required by investment engine, source instrument  type 
    -- and ie instrument type
    OPEN cur_list FOR
      SELECT sit.source_instrument_type_id,
             sit.ie_id,
             sit.source_name "Source",
             sit.instrument_type "Source Instrument Type",
             nvl(ieit.ie_instrument_type,
                 utl.pkg_constants.gc_unmapped_desc) "IE Instrument Type",
             sit.ie_description "Investment Engine"
      FROM   (SELECT DISTINCT s.source_name,
                     sf.ie_id,
                     sit.instrument_type,
                     sit.source_instrument_type_id,
                     (SELECT description FROM investment_engine WHERE ie_id = sf.ie_id) ie_description
              FROM   source                 s,
                     source_instrument_type sit,
                     source_fund            sf
              WHERE  (p_source_id IS NULL OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
              AND    s.source_id = sit.source_id
              AND    s.source_id = sf.source_id
              AND    sf.ie_id    IS NOT NULL) sit,
             (SELECT ieit.ie_id,
                     ieit.ie_instrument_type,
                     sieit.source_instrument_type_id,
                     ieit.ie_instrument_type_id
              FROM   ie_instrument_type ieit, source_ie_ins_type sieit
              WHERE  ieit.ie_instrument_type_id =
                     sieit.ie_instrument_type_id) ieit
      WHERE  sit.source_instrument_type_id =
             ieit.source_instrument_type_id(+)
      AND    sit.ie_id = ieit.ie_id(+)
      AND    ((p_ie_id IS NOT NULL AND sit.ie_id = p_ie_id) OR
            (p_ie_id IS NULL))
      AND    ((p_source_instrument_type_id IS NOT NULL AND
            sit.source_instrument_type_id = p_source_instrument_type_id) OR
            (p_source_instrument_type_id IS NULL))
      AND    ((p_ie_instrument_type_id = utl.pkg_constants.gc_unmapped_key AND
            ieit.ie_instrument_type_id IS NULL) OR
            (p_ie_instrument_type_id IS NOT NULL AND
            ieit.ie_instrument_type_id = p_ie_instrument_type_id) OR
            (p_ie_instrument_type_id IS NULL))
      ORDER  BY sit.source_name, sit.instrument_type, sit.ie_description;

    dbms_application_info.set_module(null,null);  

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_ie_list;

  -- returns a ref cursor for a single row result set of a source/ie instrument type mapping
  -- with the following columns
  --         investment_engine.ie_id
  --         source_instrument_type.source_instrument_type_id
  --         source.source_name "Source"
  --         source_instrument_type.instrument_type "Source Instrument Type"
  --         investment_engine.description "Investment Engine"
  --         ie_instrument_type.ie_instrument_type_id "IE Instrument Type"
  -- Parameters:
  --         p_source_instrument_type_id PK of source_instrument_type
  --         p_ie_id PK of investment engine
  -- used in source instrument type list screen

  FUNCTION get_source_ie_detail(p_source_instrument_type_id IN source_instrument_type.source_instrument_type_id%TYPE,
                                p_ie_id                     IN investment_engine.ie_id%TYPE)
    RETURN utl.global.t_result_set AS
    cur_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_ie_detail',null);  

    OPEN cur_detail FOR
      SELECT sit.ie_id,
             sit.source_instrument_type_id,
             sit.source_name            "Source",
             sit.instrument_type        "Source Instrument Type",
             sit.ie_description         "Investment Engine",
             ieit.ie_instrument_type_id "IE Instrument Type"
      FROM   (SELECT s.source_name,
                     ie.ie_id,
                     sit.instrument_type,
                     sit.source_instrument_type_id,
                     ie.description ie_description
              FROM   source                 s,
                     source_instrument_type sit,
                     investment_engine      ie
              WHERE  sit.source_instrument_type_id = p_source_instrument_type_id
              AND    s.source_id                   = sit.source_id 
              AND    ie.ie_id                      = p_ie_id) sit,
             (SELECT ieit.ie_id,
                     ieit.ie_instrument_type,
                     sieit.source_instrument_type_id,
                     ieit.ie_instrument_type_id
              FROM   ie_instrument_type ieit, source_ie_ins_type sieit
              WHERE  ieit.ie_instrument_type_id =
                     sieit.ie_instrument_type_id) ieit
      WHERE  sit.source_instrument_type_id =
             ieit.source_instrument_type_id(+)
      AND    sit.ie_id = ieit.ie_id(+);
  
    dbms_application_info.set_module(null,null);  

    RETURN cur_detail;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_source_ie_detail;
  
 -- returns a count of the ie instrument types that meet the following parameters
  -- Parameters:
  --         p_ie_id mandatory id of investment engine 
  --         p_ie_instrument_type optional - used for LIKE 
  -- used in IE instrument type list screen

  FUNCTION get_ie_count(p_ie_id              IN ie_instrument_type.ie_id%TYPE,
                        p_ie_instrument_type IN ie_instrument_type.ie_instrument_type%TYPE)
    RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_count',null);  

    SELECT COUNT(*)
    INTO   v_count
    FROM   investment_engine ie, ie_instrument_type iet
    WHERE  ((p_ie_id IS NULL) OR (p_ie_id IS NOT NULL AND ie.ie_id = p_ie_id))
    AND    iet.ie_id         = ie.ie_id
    AND    ((p_ie_instrument_type IS NULL) OR
            (p_ie_instrument_type IS NOT NULL AND
            iet.ie_instrument_type LIKE p_ie_instrument_type));

    dbms_application_info.set_module(null,null);  
 
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_count; 
  
  -- returns a ref cursor for a result set of ie instrument types
  -- with the following columns
  --         investment_engine.ie_id
  --         ie_instrument_type.ie_instrument_type_id
  --         investment_engine.description "Investment Engine"
  --         ie_instrument_type.ie_instrument_type "IE Instrument Type"
  -- Parameters:
  --         p_ie_id optional id of investment engine 
  --         p_ie_instrument_type optional - used for LIKE 
  -- used in IE instrument type list screen

  FUNCTION get_ie_list(p_ie_id              IN ie_instrument_type.ie_id%TYPE,
                       p_ie_instrument_type IN ie_instrument_type.ie_instrument_type%TYPE)
    RETURN utl.global.t_result_set 
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_list',null);  

    OPEN cur_list FOR
      SELECT ie.ie_id,
             iet.ie_instrument_type_id,
             ie.description "Investment Engine",
             iet.ie_instrument_type "IE Instrument Type",
             iet.category,
             iet.stale_price_period
      FROM   investment_engine ie, ie_instrument_type iet
      WHERE  ((p_ie_id IS NULL) OR (p_ie_id IS NOT NULL AND ie.ie_id = p_ie_id))
      AND    iet.ie_id         = ie.ie_id
      AND    ((p_ie_instrument_type IS NULL) OR
            (p_ie_instrument_type IS NOT NULL AND
            iet.ie_instrument_type LIKE p_ie_instrument_type))
      ORDER  BY iet.ie_instrument_type;

    dbms_application_info.set_module(null,null);  
 
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_list;

  -- returns a ref cursor for a single row result set for an ie instrument type
  -- with the following columns
  --         investment_engine.ie_id "Investment Engine"
  --         ie_instrument_type.ie_instrument_type "IE Instrument Type"
  -- Parameters:
  --         p_ie_instrument_type_id PK of source_instrument_type
  -- used in source instrument type list screen

  FUNCTION get_ie_detail(p_ie_instrument_type_id IN ie_instrument_type.ie_instrument_type_id%TYPE)
    RETURN utl.global.t_result_set 
  AS
    cur_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_detail',null);  

    OPEN cur_detail FOR
      SELECT ie.ie_id         "Investment Engine",
             iet.ie_instrument_type "IE Instrument Type",
             iet.category,
             iet.stale_price_period
      FROM   investment_engine ie, ie_instrument_type iet
      WHERE  ie.ie_id = iet.ie_id
      AND    iet.ie_instrument_type_id = p_ie_instrument_type_id;

    dbms_application_info.set_module(null,null);  
  
    RETURN cur_detail;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_detail;
  
  -- get textual description of an investment engine instrument type
  FUNCTION get_ie_description(p_ie_instrument_type_id IN ie_instrument_type.ie_instrument_type_id%TYPE)
    RETURN VARCHAR2
  AS
    v_description VARCHAR2(1000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_ie_description',null);  

    SELECT ieit.ie_instrument_type||' ('||ie.description||')'
    INTO   v_description
    FROM   investment_engine ie, ie_instrument_type ieit
    WHERE  ie.ie_id = ieit.ie_id
    AND    ieit.ie_instrument_type_id = p_ie_instrument_type_id;

    dbms_application_info.set_module(null,null);  
    
    RETURN v_description;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      
      RAISE;
  END get_ie_description;
  
  -- get textual description of a source instrument type
  FUNCTION get_source_description(p_source_instrument_type_id IN source_instrument_type.source_instrument_type_id%TYPE)
    RETURN VARCHAR2
  AS
    v_description VARCHAR2(1000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type.get_source_description',null);  

    SELECT sit.instrument_type ||' ('|| s.source_name ||')'
    INTO   v_description
    FROM   source s, source_instrument_type sit
    WHERE  sit.source_id = s.source_id
    AND    sit.source_instrument_type_id = p_source_instrument_type_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      
      RAISE;
  END get_source_description;
END pkg_instrument_type;
/
