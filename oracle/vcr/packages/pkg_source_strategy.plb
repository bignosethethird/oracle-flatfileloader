CREATE OR REPLACE PACKAGE BODY
-------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_strategy.plb 1.2.1.2 2005/08/11 13:40:17BST apenney DEV  $
-------------------------------------------------------------------------------
-- Allows you to query strategy info

 vcr.pkg_source_strategy AS

  -- returns description of a source strategy
  FUNCTION get_description(p_source_strategy_id IN source_strategy.source_strategy_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(2000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_description',null);

    SELECT st.fund || ' ' || st.strategy ||' (' || s.source_name || ')'
    INTO   v_description
    FROM   source s, source_strategy st
    WHERE  st.source_strategy_id = p_source_strategy_id
    AND    st.source_id          = s.source_id;

    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_description;
  
  -- returns a ref cursor for a result set of strategies with the following columns
  --         source_strategy.source_strategy_id
  --         source_strategy.strategy
  --         source_strategy.fund 
  -- Parameters:
  --         p_source_fund_id mandatory 
  -- used in position and exception list screens
  FUNCTION get_dropdown_list(p_source_fund_id IN source_fund.source_fund_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_strategy_list utl.global.t_result_set;
  BEGIN                 
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_dropdown_list',null);
    
    OPEN cur_strategy_list FOR
      SELECT ss.source_strategy_id,
             ss.fund,
             ss.strategy
      FROM   source_strategy   ss,
             source_fund       sf
      WHERE  ss.source_id      = sf.source_id
      AND    ss.fund           = sf.fund
      AND    sf.source_fund_id = p_source_fund_id
      ORDER BY ss.strategy;
  
    dbms_application_info.set_module(null,null);
    
    RETURN cur_strategy_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_list;

  -- returns a count of strategies which meet the parameter criteria
  -- Parameters:
  --         p_source_fund_id mandatory 
  -- used in position and exception list screens
  FUNCTION get_dropdown_count(p_source_fund_id IN source_fund.source_fund_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_strategy   ss,
           source_fund       sf
    WHERE  ss.source_id      = sf.source_id
    AND    ss.fund           = sf.fund
    AND    sf.source_fund_id = p_source_fund_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_count;
  
  -- returns a ref cursor for a result set of strategies with the following columns
  --         source_strategy.source_strategy_id
  --         source_strategy.strategy
  --         source_strategy.fund 
  -- Parameters:
  --         p_source_id mandatory id of source providing data for fund
  --         p_fund mandatory
  -- used in position and exception list screens
  FUNCTION get_dropdown_list(p_source_id      IN source.source_id%TYPE,
                             p_fund           IN source_strategy.fund%TYPE) RETURN utl.global.t_result_set
  AS
    cur_strategy_list utl.global.t_result_set;
  BEGIN                 
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_dropdown_list',null);
    
    OPEN cur_strategy_list FOR
      SELECT ss.source_strategy_id,
             ss.fund,
             ss.strategy
      FROM   source_strategy   ss
      WHERE  ss.source_id      = p_source_id
      AND    ss.fund           = p_fund
      ORDER BY ss.strategy;
  
    dbms_application_info.set_module(null,null);
    
    RETURN cur_strategy_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_list;

  -- returns a count of strategies which meet the parameter criteria
  -- Parameters:
  --         p_source_id mandatory id of source providing data for fund
  --         p_fund mandatory
  -- used in position and exception list screens
  FUNCTION get_dropdown_count(p_source_id      IN source.source_id%TYPE,
                              p_fund           IN source_strategy.fund%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_strategy   ss
    WHERE  ss.source_id      = p_source_id
    AND    ss.fund           = p_fund;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_count;
  
  -- returns a ref cursor for a result set of strategies with the following columns
  --         source_strategy.source_strategy_id
  --         source_strategy.strategy
  --         source.source_name 
  --         source_strategy.fund 
  --         investment_engine.description "Investment Engine"
  --         investment_engine.me_source "ME Source"
  --         ref_object.ref_object_description "Strategy in ME Source"
  -- Parameters:
  --         p_source_id optional id of source providing data for fund
  --         p_ie_id optional id of investment engine 
  --         p_fund            optional fund
  --         p_strategy        optional strategy description
  -- used in strategy list screen
  FUNCTION get_list(p_source_id      IN source.source_id%TYPE,
                    p_ie_id          IN investment_engine.ie_id%TYPE,
                    p_fund           IN source_strategy.fund%TYPE,
                    p_strategy       IN source_strategy.strategy%TYPE) RETURN utl.global.t_result_set
  AS
    cur_strategy_list utl.global.t_result_set;
  BEGIN                 
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_list',null);
    
    OPEN cur_strategy_list FOR
      SELECT ss.source_strategy_id,
             ss.strategy,
             s.source_name,
             ss.fund,
             nvl(ie.description, utl.pkg_constants.gc_unmapped_desc) ie_description,
             ie.me_source,
             decode(ie.ie_id,
                    NULL,
                    NULL,
                    nvl(me_strategy.ref_object_description,
                        utl.pkg_constants.gc_unmapped_desc))
      FROM   source_strategy   ss ,
             source            s,
             investment_engine ie,
             ref_object        me_strategy,
             source_fund       sf
      WHERE  ((ss.source_id    = p_source_id) OR p_source_id IS NULL)
      AND    s.source_id       = ss.source_id
      AND    ss.source_id      = sf.source_id
      AND    ss.fund           = sf.fund
      AND    sf.ie_id          = ie.ie_id(+)
      AND    ss.me_strategy_id = me_strategy.ref_object_id(+)
      AND    ((p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id) OR (p_ie_id IS NULL))
      AND    ((p_fund IS NOT NULL AND ss.fund LIKE p_fund) OR (p_fund IS NULL))
      AND    ((p_strategy IS NOT NULL AND ss.strategy LIKE p_strategy) OR (p_strategy IS NULL))
      ORDER BY s.source_name, ss.fund, ss.strategy;
  
    dbms_application_info.set_module(null,null);
    
    RETURN cur_strategy_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_list;

  -- returns a count of strategies which meet the parameter criteria
  -- Parameters:
  --         p_source_id optional id of source providing data for fund
  --         p_ie_id optional id of investment engine 
  --         p_fund            optional fund
  --         p_strategy        optional strategy description
  -- used in strategy list screen
  FUNCTION get_count(p_source_id      IN source.source_id%TYPE,
                     p_ie_id          IN investment_engine.ie_id%TYPE,
                     p_fund           IN source_strategy.fund%TYPE,
                     p_strategy       IN source_strategy.strategy%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_strategy   ss ,
           source            s,
           investment_engine ie,
           ref_object        me_strategy,
           source_fund       sf
    WHERE  ((ss.source_id    = p_source_id) OR p_source_id IS NULL)
    AND    s.source_id       = ss.source_id
    AND    ss.source_id      = sf.source_id
    AND    ss.fund           = sf.fund
    AND    sf.ie_id          = ie.ie_id(+)
    AND    ss.me_strategy_id = me_strategy.ref_object_id(+)
    AND    ((p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id) OR (p_ie_id IS NULL))
    AND    ((p_fund IS NOT NULL AND ss.fund LIKE p_fund) OR (p_fund IS NULL))
    AND    ((p_strategy IS NOT NULL AND ss.strategy LIKE p_strategy) OR (p_strategy IS NULL));
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
                     
  -- returns a ref cursor for a result set of one strategy with the following columns
  --         source.source_name
  --         source_strategy.strategy
  --         source_strategy.fund
  --         investment_engine.description "Investment Engine"
  --         investment_engine.me_source "ME Source"
  --         ref_object.ref_object_id "Fund in ME Source"

  -- Parameters:
  --         p_source_strategy_id PK of source_strategy
  -- used in strategy detail screen
  FUNCTION get_detail(p_source_strategy_id IN source_strategy.source_strategy_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_strategy_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy.get_detail',null);

    OPEN cur_strategy_detail FOR
      SELECT s.source_name,
             ss.strategy,
             ss.fund,
             nvl(ie.description, utl.pkg_constants.gc_unmapped_desc) ie_description,
             ie.me_source,
             me_strategy.ref_object_id
      FROM   source_fund       sf,
             source            s,
             source_strategy   ss,
             investment_engine ie,
             ref_object        me_strategy
      WHERE  s.source_id           = ss.source_id
      AND    ss.fund               = sf.fund
      AND    ss.source_id          = sf.source_id
      AND    sf.ie_id              = ie.ie_id(+)
      AND    ss.me_strategy_id     = me_strategy.ref_object_id(+)
      AND    ss.source_strategy_id = p_source_strategy_id;
  
    dbms_application_info.set_module(null,null);

    RETURN cur_strategy_detail;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_detail;
END pkg_source_strategy;
/
