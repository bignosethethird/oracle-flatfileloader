CREATE OR REPLACE PACKAGE BODY
  -----------------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_ref_object.plb 1.8.1.1.1.1 2005/03/02 10:42:24GMT apenney DEV  $
  -----------------------------------------------------------------------------------
  -- Allows you to query reference object information 
  -- e.g. funds or strategies for which estimates are obtained from external sources
 vcr.pkg_ref_object AS
    
  -- returns a ref cursor for a result set of the id and description of all 
  -- objects for use in dropdown lists in user interface
  -- for the parameter source (e.g. webmark) and object type (e.g. benchmark fund)
  FUNCTION get_dropdown_list (p_ref_source      IN ref_object.ref_source%TYPE, 
                              p_ref_object_type IN ref_object.ref_object_type%TYPE) RETURN utl.global.t_result_set
  AS
    cur_ref_object utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_ref_object.get_dropdown_list',null);

    OPEN cur_ref_object FOR
    SELECT ref_object_id, ref_object_description
    FROM
    (
      SELECT ro.ref_object_id, ro.ref_object_description, 2
      FROM ref_object ro
      WHERE ro.ref_source = p_ref_source
      AND   p_ref_source IS NOT NULL AND ro.ref_object_type = p_ref_object_type
      UNION
      SELECT to_number(utl.pkg_constants.gc_unmapped_key), utl.pkg_constants.gc_unmapped_desc, 1
      FROM   dual
      ORDER BY 3,2
    );
        
    dbms_application_info.set_module(null,null);
    
    RETURN cur_ref_object;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_dropdown_list;
  
  -- returns a count of all 
  -- objects for use in dropdown lists in user interface
  -- for the parameter source (e.g. webmark) and object type (e.g. benchmark fund)
  FUNCTION get_dropdown_count (p_ref_source      IN ref_object.ref_source%TYPE, 
                               p_ref_object_type IN ref_object.ref_object_type%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_ref_object.get_dropdown_count',null);

    SELECT COUNT(*)
    INTO   v_count
    FROM   ref_object ro
    WHERE  p_ref_source IS NOT NULL 
    AND    ro.ref_source = p_ref_source
    AND    ro.ref_object_type = p_ref_object_type;
    
    v_count := v_count + 1;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_dropdown_count;
  
  -- returns reference object description for parameter id
  FUNCTION get_description(p_ref_object_id IN ref_object.ref_object_id%TYPE) RETURN VARCHAR2
  AS
    v_description ref_object.ref_object_description%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_ref_object.get_description',null);

    SELECT ref_object_description
    INTO   v_description
    FROM   ref_object
    WHERE  ref_object_id = p_ref_object_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      
      RAISE;
  END get_description;
END pkg_ref_object;
/
