CREATE OR REPLACE PACKAGE BODY
-------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_fund.plb 1.9.1.3.1.3 2005/08/16 11:54:24BST apenney DEV  $
-------------------------------------------------------------------------------
-- Allows you to query fund info

 vcr.pkg_source_fund AS

  -- returns description of a source fund
  FUNCTION get_description(p_source_fund_id IN source_fund.source_fund_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(2000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_description',null);

    SELECT f.fund || ' (' || s.source_name || ')'
    INTO   v_description
    FROM   source_fund f, source s
    WHERE  f.source_fund_id = p_source_fund_id
    AND    f.source_id      = s.source_id;

    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_description;
  
    -- returns a ref cursor for a result set with the following columns
  -- source_fund_id
  -- fund
  -- for use in dropdown lists in user interface
  -- if source_id, ie_id or ie_platform are specified just get the relavant funds
  FUNCTION get_filter_dropdown_list(p_source_id   IN source.source_id%TYPE,
                                    p_ie_id       IN investment_engine.ie_id%TYPE DEFAULT NULL,
                                    p_ie_platform IN ie_platform.ie_platform%TYPE DEFAULT NULL)
    RETURN utl.global.t_result_set AS
    cur_fund_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_dropdown_list',null);
    
    OPEN cur_fund_list FOR
      SELECT sf.source_fund_id, sf.fund
      FROM   source_fund sf
      WHERE  sf.source_id = p_source_id
      AND    (p_ie_id       IS NULL OR p_ie_id = sf.ie_id)
      AND    (p_ie_platform IS NULL OR p_ie_platform = sf.ie_platform)
      ORDER BY fund;

    dbms_application_info.set_module(null,null);

    RETURN cur_fund_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_filter_dropdown_list;
  
  -- returns a count of funds
  -- for use in dropdown lists in user interface
  -- if source_id, ie_id or ie_platform are specified just get the relavant funds
  FUNCTION get_filter_dropdown_count(p_source_id   IN source.source_id%TYPE,
                                     p_ie_id       IN investment_engine.ie_id%TYPE DEFAULT NULL,
                                     p_ie_platform IN ie_platform.ie_platform%TYPE DEFAULT NULL)
    RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_fund sf
    WHERE  sf.source_id = p_source_id
    AND    (p_ie_id       IS NULL OR p_ie_id = sf.ie_id)
    AND    (p_ie_platform IS NULL OR p_ie_platform = sf.ie_platform);
    
    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_filter_dropdown_count;  
    
  -- returns a ref cursor for a result set with the following columns
  -- source_fund_id
  -- fund
  -- for use in dropdown lists in user interface
  -- if load run id is specified just get funds for the source of the load run
  FUNCTION get_dropdown_list(p_load_run_id IN source_load_run.load_run_id%TYPE DEFAULT NULL)
    RETURN utl.global.t_result_set AS
    cur_fund_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_dropdown_list',null);
    
    OPEN cur_fund_list FOR
      SELECT sf.source_fund_id, sf.fund
      FROM   source_fund sf, source s
      WHERE  s.source_id = sf.source_id
      AND    ((p_load_run_id IS NULL) OR 
              (p_load_run_id IS NOT NULL AND 
               sf.source_id = (SELECT source_id FROM source_load_run WHERE load_run_id = p_load_run_id)))
      ORDER BY fund;

    dbms_application_info.set_module(null,null);

    RETURN cur_fund_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_list;
  
  -- returns a count of funds
  -- for use in dropdown lists in user interface
  -- if load run id is specified just get funds for the source of the load run
  FUNCTION get_dropdown_count(p_load_run_id IN source_load_run.load_run_id%TYPE DEFAULT NULL)
    RETURN INTEGER 
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_fund
    WHERE  ((p_load_run_id IS NULL) OR 
            (p_load_run_id IS NOT NULL AND 
             source_id = (SELECT source_id FROM source_load_run WHERE load_run_id = p_load_run_id)));

    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_count;

  -- returns a ref cursor for a result set of funds with the following columns
  --         source_fund.source_fund_id "source_fund_id"
  --         source.source_name "Source"
  --         source_fund.fund "Fund"
  --         investment_engine.description "Investment Engine"
  --         source_fund.active_ind "Active"
  --         investment_engine.me_source "ME Source"
  --         ref_object.ref_object_description "Fund in ME Source"
  --         ie_platform.description "Platform"
  --         ref_object.ref_object_description "Benchmark Fund"
  --         count of strategies
  -- Parameters:
  --         p_source_id  id of source providing data for fund
  --         p_ie_id optional id of investment engine 
  --         p_fund  optional fund code
  -- used in fund list screen
  FUNCTION get_list(p_source_id IN source.source_id%TYPE,
                    p_ie_id     IN investment_engine.ie_id%TYPE,
                    p_fund      IN source_fund.fund%TYPE) RETURN utl.global.t_result_set 
  AS
    cur_fund_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_list',null);
    
    OPEN cur_fund_list FOR
      SELECT sf.source_fund_id,
             s.source_name,
             sf.fund,
             nvl(ie.description, utl.pkg_constants.gc_unmapped_desc) ie_description,
             sf.active_ind,
             ie.me_source,
             decode(ie.ie_id,
                    NULL,
                    NULL,
                    nvl(me_fund.ref_object_description,
                        utl.pkg_constants.gc_unmapped_desc)) "me_fund",
             decode(ie.ie_id,
                    NULL,
                    NULL,
                    nvl(iep.description, utl.pkg_constants.gc_unmapped_desc)) "ie_platform",
             decode(ie.ie_id,
                    NULL,
                    NULL,
                    nvl(bm_fund.ref_object_description,
                        utl.pkg_constants.gc_unmapped_desc)) "benchmark_fund",
             nvl(sfs.strategy_count,0) "strategy_count",
             sf.source_id
      FROM   source_fund       sf ,
             source            s,
             investment_engine ie,
             ie_platform       iep,
             ref_object        me_fund,
             ref_object        bm_fund,
             (
              SELECT ss.source_id, ss.fund, COUNT(*) strategy_count
              FROM   source_strategy ss
              GROUP BY ss.source_id, ss.fund
             ) sfs
      WHERE  ((sf.source_id      = to_number(p_source_id)) OR p_source_id IS NULL)
      AND    s.source_id       = sf.source_id
      AND    sf.ie_id          = ie.ie_id(+)
      AND    sf.ie_platform    = iep.ie_platform(+)
      AND    sf.ie_id          = iep.ie_id(+)
      AND    sf.me_fund_id     = me_fund.ref_object_id(+)
      AND    sf.me_benchmark_fund_id = bm_fund.ref_object_id(+)
      AND    ((p_ie_id = utl.pkg_constants.gc_unmapped_key AND
            sf.ie_id IS NULL) OR
            (p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id) OR
            (p_ie_id IS NULL))
      AND    ((p_fund IS NOT NULL AND sf.fund LIKE p_fund) OR
            (p_fund IS NULL))
      AND   sf.source_id = sfs.source_id (+)
      AND   sf.fund      = sfs.fund (+)
      ORDER BY sf.fund;
  
    dbms_application_info.set_module(null,null);
    
    RETURN cur_fund_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_list;

  -- returns a count of the number of funds for the parameters
  -- Parameters:
  --         p_source_id id of source providing data for fund
  --         p_ie_id optional id of investment engine 
  --         p_fund  optional fund code
  -- used in fund list screen
  
  FUNCTION get_count(p_source_id IN source.source_id%TYPE,
                     p_ie_id     IN investment_engine.ie_id%TYPE,
                     p_fund      IN source_fund.fund%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_fund       sf,
           source            s,
           investment_engine ie,
           ie_platform       iep,
           ref_object        me_fund,
           ref_object        bm_fund
    WHERE  ((sf.source_id      = to_number(p_source_id)) OR p_source_id IS NULL)
    AND    s.source_id       = sf.source_id
    AND    sf.ie_id          = ie.ie_id(+)
    AND    sf.ie_platform    = iep.ie_platform(+)
    AND    sf.ie_id          = iep.ie_id(+)
    AND    sf.me_fund_id     = me_fund.ref_object_id(+)
    AND    sf.me_benchmark_fund_id = bm_fund.ref_object_id(+)
    AND    ((p_ie_id = utl.pkg_constants.gc_unmapped_key AND
          sf.ie_id IS NULL) OR
          (p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id) OR
          (p_ie_id IS NULL))
    AND    ((p_fund IS NOT NULL AND sf.fund LIKE p_fund) OR
          (p_fund IS NULL));
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
                      
  

  -- returns a ref cursor for a result set of one fund the following columns
  --         source.source_name "Source"
  --         source_fund.fund "Fund"
  --         investment_engine.ie_id "Investment Engine"
  --         source_fund.active_ind "Active"
  --         investment_engine.me_source "ME Source"
  --         ref_object.ref_object_id "Fund in ME Source"
  --         ie_platform.ie_platform "Platform"
  --         ref_object.ref_object_id "Benchmark Fund"
  -- Parameters:
  --         p_source_fund_id PK of source_fund
  -- used in fund detail screen
  FUNCTION get_detail(p_source_fund_id IN source_fund.source_fund_id%TYPE)
    RETURN utl.global.t_result_set AS
    cur_fund_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund.get_detail',null);

    OPEN cur_fund_detail FOR
      SELECT s.source_name "Source",
             sf.fund "Fund",
             ie.ie_id "Investment Engine",
             sf.active_ind "Active",
             ie.me_source "ME Source",
             me_fund.ref_object_id "Fund in ME Source",
             iep.ie_platform "Platform",
             bm_fund.ref_object_id "Benchmark Fund",
             sf.source_fund_id,
             sf.source_id
      FROM   source_fund       sf,
             source            s,
             investment_engine ie,
             ie_platform       iep,
             ref_object        me_fund,
             ref_object        bm_fund
      WHERE  s.source_id = sf.source_id
      AND    sf.ie_id = ie.ie_id(+)
      AND    sf.ie_platform = iep.ie_platform(+)
      AND    sf.ie_id = iep.ie_id(+)
      AND    sf.me_fund_id = me_fund.ref_object_id(+)
      AND    sf.me_benchmark_fund_id = bm_fund.ref_object_id(+)
      AND    sf.source_fund_id = p_source_fund_id;
  
    dbms_application_info.set_module(null,null);

    RETURN cur_fund_detail;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_detail;
END pkg_source_fund;
/
