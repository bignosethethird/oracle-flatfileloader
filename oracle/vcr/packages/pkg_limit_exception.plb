CREATE OR REPLACE PACKAGE BODY vcr.pkg_limit_exception
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_limit_exception.plb 1.4.1.11 2005/10/26 15:20:26BST apenney DEV  $
--------------------------------------------------------------------------
-- Provides routines to query limit exceptions
AS
  -- returns a list of exception classes
  FUNCTION get_class_dropdown_list RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_class_dropdown_list',null);
    
    OPEN   cur_list
    FOR
    SELECT lec.class,
           lec.description
    FROM   limit_exception_class lec
    ORDER BY lec.description;
         
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_class_dropdown_list;
  
  -- returns a count of exception classes
  FUNCTION get_class_dropdown_count RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_class_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   limit_exception_class;
         
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_class_dropdown_count;
  
  -- returns details of an exception for updating
  FUNCTION get_detail(p_as_of_date   IN limit_exception.as_of_date%TYPE,
                      p_source_id    IN limit_exception.source_id%TYPE,
                      p_exception_id IN limit_exception.exception_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_detail utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_detail',null);
    
    OPEN   cur_detail
    FOR
    SELECT le.type,
           le.status,
           le.comments,
           le.class,
           le.action_description,
           le.resolution_description,
           le.last_updated_by,
           to_char(le.last_updated_date, 'dd-MON-yyyy hh24:mi:ss'),
           le.resolution_user,
           to_char(le.resolution_date, 'dd-MON-yyyy hh24:mi:ss'),
           sf.fund,
           ss.strategy,
           pkg_limit.get_version_values(le.limit_id,le.limit_version) limit_value,
           to_char(decode(vm.units,pkg_ref_object.gc_percentage_vcr_type, 100, 1) * le.validation_measure_value,vm.format) break_value,
           pkg_limit.get_measure_rule_description(le.limit_id) measure_rule,
           le.exception_description,          
           le.basis,
           to_char(le.as_of_date, 'dd-MON-yyyy'),
           s.source_name,
           le.key,
           le.seq_id,
           pkg_source_load_run.get_description(le.load_run_id) load_run_desc
    FROM   source_fund sf,
           source_strategy ss,
           limit_exception le,
           limit l,
           validation_measure vm,
           source s
    WHERE  le.as_of_date         = p_as_of_date
    AND    le.source_id          = p_source_id
    AND    le.exception_id       = p_exception_id
    AND    le.source_id          = s.source_id
    AND    le.source_fund_id     = sf.source_fund_id (+)
    AND    le.source_strategy_id = ss.source_strategy_id (+)
    AND    le.limit_id           = l.limit_id
    AND    l.measure_id          = vm.measure_id;
         
    dbms_application_info.set_module(null,null);
    
    RETURN cur_detail;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_detail;
  -- returns list of exceptions 
  FUNCTION get_list(p_source_fund_id     IN limit_exception.source_fund_id%TYPE,
                    p_source_strategy_id IN limit_exception.source_strategy_id%TYPE,
                    p_sub_strategy       IN limit_exception.sub_strategy%TYPE,
                    p_source_broker_id   IN limit_exception.source_broker_id%TYPE,
                    p_source_instrument_type_id IN limit_exception.source_instrument_type_id%TYPE,
                    p_ie_id              IN investment_engine.ie_id%TYPE,
                    p_ie_platform        IN ie_platform.ie_platform%TYPE,
                    p_measure_rule_id    IN VARCHAR2,
                    p_status             IN limit_exception.status%TYPE,
                    p_type               IN limit_exception.type%TYPE,
                    p_resolution_from_date IN DATE,
                    p_resolution_to_date IN DATE,
                    p_load_run_id        IN limit_exception.load_run_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;

    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    
    v_measure_id validation_measure.measure_id%TYPE;
    v_rule_id    validation_rule.rule_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_list',null);

    SELECT slr.as_of_date, slr.source_id
    INTO   v_as_of_date, v_source_id
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;

    IF p_measure_rule_id IS NOT NULL
    AND length(p_measure_rule_id) > 0
    THEN
      v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
      v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    ELSE
      v_measure_id := null;
      v_rule_id    := null;
    END IF;
    
    OPEN   cur_list
    FOR
    SELECT /*+ FIRST_ROWS */ 
           sf.fund,
           (
            SELECT ss.strategy
            FROM   source_strategy ss
            WHERE  ss.source_id = v_source_id
            AND    ss.source_strategy_id = le.source_strategy_id
           ) strategy,
           to_char(le.current_instrument_value,'FM999,999,999,999,990.00'),
           to_char(le.current_pnl_mtd,'FM999,999,999,999,990.00'),
           to_char(le.prior_instrument_value,'FM999,999,999,999,990.00'),
           to_char(le.prior_pnl_mtd,'FM999,999,999,999,990.00'),
           to_char(le.daily_pnl_change,'FM999,999,999,999,990.00'),
           to_char(le.current_month_notional,'FM999,999,999,999,990.00'),
           pkg_limit.get_version_values(le.limit_id,le.limit_version) limit_value,
           to_char(decode(vm.units,pkg_ref_object.gc_percentage_vcr_type, 100, 1) * le.validation_measure_value,vm.format) break_value,
           le.type,            
           le.status, 
           pkg_limit.get_measure_rule_description(le.limit_id) measure_rule,
           le.exception_description,          
           (
            SELECT sb.broker
            FROM   source_broker sb
            WHERE  sb.source_id = v_source_id
            AND    sb.source_broker_id = le.source_broker_id
           ) broker,
           (
            SELECT sit.instrument_type
            FROM   source_instrument_type sit
            WHERE  sit.source_id = v_source_id
            AND    sit.source_instrument_type_id = le.source_instrument_type_id
           ) instrument_type,
           le.instrument_id,
           le.instrument,
           le.currency,
           to_char(le.current_instrument_holding,'FM999,999,999,999,990.00'),
           to_char(le.current_instrument_price_local,'FM999,999,999,999,990.00'),
           to_char(le.current_bb_price,'FM999,999,999,999,990.00'),
           to_char(le.prior_instrument_holding,'FM999,999,999,999,990.00'),
           to_char(le.prior_instrument_price_local,'FM999,999,999,999,990.00'),
           to_char(le.prior_bb_price,'FM999,999,999,999,990.00'),
           to_char(le.as_of_date,'yyyy-mm-dd') as_of_date,
           to_char(le.prior_as_of_date,'yyyy-mm-dd') prior_as_of_date,          
           le.basis,
           le.source_id,
           le.key,
           le.seq_id,
           le.limit_id,
           le.limit_version,
           le.comments,
           lec.description,
           le.action_description,
           le.resolution_description,
           le.last_updated_by,
           to_char(le.last_updated_date, 'dd-MON-yyyy hh24:mi:ss'),
           le.resolution_user,
           to_char(le.resolution_date, 'dd-MON-yyyy hh24:mi:ss'),
           le.sub_strategy,
           le.exception_id
    FROM   source_fund sf,
           limit_exception le,
           limit l,
           validation_measure vm,
           limit_exception_class lec
    WHERE  le.as_of_date         = v_as_of_date
    AND    le.source_id          = v_source_id
    AND    le.load_run_id        = p_load_run_id
    AND    ((le.source_fund_id = p_source_fund_id AND p_source_fund_id IS NOT NULL) OR (p_source_fund_id IS NULL))
    AND    ((le.source_strategy_id = p_source_strategy_id AND p_source_strategy_id IS NOT NULL) OR (p_source_strategy_id IS NULL))
    AND    ((le.source_broker_id = p_source_broker_id AND p_source_broker_id IS NOT NULL) OR (p_source_broker_id IS NULL))
    AND    ((le.source_instrument_type_id = p_source_instrument_type_id AND p_source_instrument_type_id IS NOT NULL) OR (p_source_instrument_type_id IS NULL))
    AND    ((le.sub_strategy LIKE p_sub_strategy AND p_sub_strategy IS NOT NULL) OR (p_sub_strategy IS NULL))
    AND    ((sf.ie_id = p_ie_id AND p_ie_id IS NOT NULL) OR (p_ie_id IS NULL))
    AND    ((sf.ie_platform = p_ie_platform AND p_ie_platform IS NOT NULL) OR (p_ie_platform IS NULL))
    AND    ((le.status = p_status AND p_status IS NOT NULL) OR (p_status IS NULL))
    AND    ((le.type = p_type AND p_type IS NOT NULL) OR (p_type IS NULL))
    AND    ((l.measure_id = v_measure_id AND l.rule_id = v_rule_id) OR (v_measure_id IS NULL AND v_rule_id IS NULL))
    AND    ((le.resolution_date >= p_resolution_from_date AND le.resolution_date <= p_resolution_to_date AND p_resolution_from_date IS NOT NULL AND p_resolution_to_date IS NOT NULL) OR
            (le.resolution_date >= p_resolution_from_date AND p_resolution_from_date IS NOT NULL AND p_resolution_to_date IS NULL)                                                    OR
            (le.resolution_date <= p_resolution_to_date AND p_resolution_from_date IS NULL AND p_resolution_to_date IS NOT NULL)                                                      OR
            (p_resolution_from_date IS NULL AND p_resolution_to_date IS NULL)                                                                                                           )
    AND    le.source_fund_id     = sf.source_fund_id (+)
    AND    le.limit_id           = l.limit_id
    AND    l.measure_id          = vm.measure_id
    AND    le.class              = lec.class (+)
    ORDER BY 1,2;
         
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_list;
  
-- returns count of exceptions
  FUNCTION get_count(p_source_fund_id     IN limit_exception.source_fund_id%TYPE,
                    p_source_strategy_id IN limit_exception.source_strategy_id%TYPE,
                    p_sub_strategy       IN limit_exception.sub_strategy%TYPE,
                    p_source_broker_id   IN limit_exception.source_broker_id%TYPE,
                    p_source_instrument_type_id IN limit_exception.source_instrument_type_id%TYPE,
                    p_ie_id              IN investment_engine.ie_id%TYPE,
                    p_ie_platform        IN ie_platform.ie_platform%TYPE,
                    p_measure_rule_id    IN VARCHAR2,
                    p_status             IN limit_exception.status%TYPE,
                    p_type               IN limit_exception.type%TYPE,
                    p_resolution_from_date IN DATE,
                    p_resolution_to_date IN DATE,
                    p_load_run_id        IN limit_exception.load_run_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
    
    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    
    v_measure_id validation_measure.measure_id%TYPE;
    v_rule_id    validation_rule.rule_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_count',null);
    
    SELECT slr.as_of_date, slr.source_id
    INTO   v_as_of_date, v_source_id
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;

    IF p_measure_rule_id IS NOT NULL
    AND length(p_measure_rule_id) > 0
    THEN
      v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
      v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    ELSE
      v_measure_id := null;
      v_rule_id    := null;
    END IF;
        
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_fund sf,
           limit_exception le,
           limit l
    WHERE  le.as_of_date         = v_as_of_date
    AND    le.source_id          = v_source_id
    AND    le.load_run_id        = p_load_run_id
    AND    ((le.source_fund_id = p_source_fund_id AND p_source_fund_id IS NOT NULL) OR (p_source_fund_id IS NULL))
    AND    ((le.source_strategy_id = p_source_strategy_id AND p_source_strategy_id IS NOT NULL) OR (p_source_strategy_id IS NULL))
    AND    ((le.source_broker_id = p_source_broker_id AND p_source_broker_id IS NOT NULL) OR (p_source_broker_id IS NULL))
    AND    ((le.source_instrument_type_id = p_source_instrument_type_id AND p_source_instrument_type_id IS NOT NULL) OR (p_source_instrument_type_id IS NULL))
    AND    ((le.sub_strategy LIKE p_sub_strategy AND p_sub_strategy IS NOT NULL) OR (p_sub_strategy IS NULL))
    AND    ((sf.ie_id = p_ie_id AND p_ie_id IS NOT NULL) OR (p_ie_id IS NULL))
    AND    ((sf.ie_platform = p_ie_platform AND p_ie_platform IS NOT NULL) OR (p_ie_platform IS NULL))
    AND    ((le.status = p_status AND p_status IS NOT NULL) OR (p_status IS NULL))
    AND    ((le.type = p_type AND p_type IS NOT NULL) OR (p_type IS NULL))
    AND    ((l.measure_id = v_measure_id AND l.rule_id = v_rule_id) OR (v_measure_id IS NULL AND v_rule_id IS NULL))
    AND    ((le.resolution_date >= p_resolution_from_date AND le.resolution_date <= p_resolution_to_date AND p_resolution_from_date IS NOT NULL AND p_resolution_to_date IS NOT NULL) OR
            (le.resolution_date >= p_resolution_from_date AND p_resolution_from_date IS NOT NULL AND p_resolution_to_date IS NULL)                                                    OR
            (le.resolution_date <= p_resolution_to_date AND p_resolution_from_date IS NULL AND p_resolution_to_date IS NOT NULL)                                                      OR
            (p_resolution_from_date IS NULL AND p_resolution_to_date IS NULL)                                                                                                           )
    AND    le.source_fund_id     = sf.source_fund_id (+)
    AND    le.limit_id           = l.limit_id;
         
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_count;
  
  -- returns a fund level list of exception and position information
  FUNCTION get_fund_summary_list(p_load_run_id IN limit_exception.load_run_id%TYPE,
                                 p_ie_id       IN investment_engine.ie_id%TYPE) RETURN utl.global.t_result_set
                                     
  AS
    cur_fund_load_run_summary utl.global.t_result_set;
    
    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    v_basis      source_basis.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_fund_summary_list',null);
    
    SELECT slr.as_of_date, slr.source_id, slr.basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;
    
    OPEN   cur_fund_load_run_summary
    FOR
    SELECT source_fund_id,
           fund,
           investment_engine,
           position_count,
           exception_count,
           source_mtd_ror,
           manager_mtd_ror,
           manager_as_of_date,
           fund_mtd_ror,
           fund_as_of_date,
           tolerance_level,
           as_of_date_display,
           as_of_date,
           source_id,
           basis,
           load_run_id,
           rorpdf
    FROM
    (       
      SELECT sf.source_fund_id,
             sf.fund,
             nvl(ie.description,'Undefined') investment_engine,
             ( 
              SELECT COUNT(sp.key)
              FROM   source_position sp
              WHERE  sp.as_of_date     = v_as_of_date
              AND    sp.source_id      = v_source_id
              AND    sp.basis          = v_basis
              AND    sp.fund           = sf.fund
             ) position_count,
             ( 
              SELECT COUNT(le.exception_id)
              FROM   limit_exception le
              WHERE  v_source_id       = le.source_id
              AND    v_as_of_date      = le.as_of_date
              AND    p_load_run_id     = le.load_run_id
              AND    sf.source_fund_id = le.source_fund_id
             ) exception_count,
             decode(cmr.value, null, cmr.calculation_error, to_char(100*cmr.value,'FM990.00')) source_mtd_ror,
             decode(sf.me_fund_id, null, null, nvl(to_char(100*refmtdror_me.value,'FM990.00'),'Unknown')) manager_mtd_ror,
             to_char(refmtdror_me.actual_as_of_date,'dd-MON-yyyy') manager_as_of_date,
             decode(sf.me_benchmark_fund_id, null, null, nvl(to_char(100*refmtdror_bmark.value,'FM990.00'),'Unknown')) fund_mtd_ror,
             to_char(refmtdror_bmark.actual_as_of_date,'dd-MON-yyyy') fund_as_of_date,
             tol_level.value tolerance_level,
             to_char(v_as_of_date,'dd-MON-yyyy') as_of_date_display,
             to_char(v_as_of_date,'yyyy-mm-dd') as_of_date,
             v_source_id source_id,
             v_basis basis,
             p_load_run_id load_run_id,
             utl.pkg_config.get_variable_string(pkg_reports.gc_crystal_output_url_cfg_key)||'/RoR_'||s.source_name||'-'||sf.fund||'.pdf' rorpdf,
             sf.active_ind
      FROM source_fund sf,
           (
            SELECT rmv.as_of_date, rmv.ref_object_id, rmv.value, rmv.actual_as_of_date 
            FROM   ref_measure_value rmv
            WHERE  rmv.measure = pkg_ref_object.gc_mtdror_vcr_type
           ) refmtdror_me,
           (
            SELECT rmv.as_of_date, rmv.ref_object_id, rmv.value, rmv.actual_as_of_date 
            FROM   ref_measure_value rmv
            WHERE  rmv.measure = pkg_ref_object.gc_mtdror_vcr_type
           ) refmtdror_bmark,
           calculated_mtd_ror cmr,
           investment_engine ie,
           ( -- inline view of "tolerance level" limits by source fund id
            SELECT sf.source_fund_id, 
                   pkg_limit.get_version_values(l.limit_id, lv.limit_version) value
            FROM   limit l, 
                   limit_version lv, 
                   limit_header_value lhv,
                   limit_header_parameter lhp,
                   source_fund sf
            WHERE  l.measure_id            = utl.pkg_config.get_variable_int(gc_tol_lev_measure_id_cfg_key)
            AND    l.rule_id               = utl.pkg_config.get_variable_int(gc_tol_lev_rule_id_cfg_key)
            AND    l.limit_id              = lv.limit_id
            AND    v_as_of_date between lv.start_date and  nvl(lv.end_date,to_date('5373484','j'))
            AND    lhv.limit_id            = l.limit_id
            AND    lhp.header_parameter_id = lhv.header_parameter_id
            AND    ((lhp.column_name       = 'source_fund_id' AND
                     lhv.value             = sf.source_fund_id   ) OR
                    (lhp.column_name       = 'ie_id'          AND
                     lhv.value             = sf.ie_id            )   )     
           ) tol_level,
           source s
      WHERE v_as_of_date            = refmtdror_bmark.as_of_date (+)
      AND   sf.me_benchmark_fund_id = refmtdror_bmark.ref_object_id (+)
      AND   v_as_of_date            = refmtdror_me.as_of_date (+)
      AND   sf.me_fund_id           = refmtdror_me.ref_object_id (+)
      AND   v_as_of_date            = cmr.as_of_date (+)
      AND   v_basis                 = cmr.basis (+)
      AND   v_source_id             = cmr.source_id (+)
      AND   'FUND'                  = cmr.source_object_type (+)
      AND   sf.source_fund_id       = cmr.source_object_id (+)
      AND   sf.ie_id                = ie.ie_id (+)
      AND   sf.source_id            = v_source_id
      AND   ((p_ie_id IS NULL) OR (p_ie_id IS NOT NULL AND p_ie_id = sf.ie_id))
      AND   sf.source_fund_id       = tol_level.source_fund_id (+)
      AND   s.source_id             = v_source_id
    )
    WHERE active_ind = 'Y'
    OR    position_count <> 0
    ORDER BY fund;

    dbms_application_info.set_module(null,null);
    
    RETURN cur_fund_load_run_summary;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_fund_summary_list;

  -- returns a fund level count of exception and position information
  FUNCTION get_fund_summary_count(p_load_run_id IN limit_exception.load_run_id%TYPE,
                                  p_ie_id       IN investment_engine.ie_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
    
    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    v_basis      source_basis.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_fund_summary_count',null);
    
    SELECT slr.as_of_date, slr.source_id, slr.basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;
    
    SELECT COUNT(*)
    INTO   v_count
    FROM
    ( 
      SELECT ( 
              SELECT COUNT(sp.key)
              FROM   source_position sp
              WHERE  sp.as_of_date     = v_as_of_date
              AND    sp.source_id      = v_source_id
              AND    sp.basis          = v_basis
              AND    sp.fund           = sf.fund
             ) position_count,
             active_ind
      FROM  source_fund sf
      WHERE sf.source_id            = v_source_id
      AND   ((p_ie_id IS NULL) OR (p_ie_id IS NOT NULL AND p_ie_id = sf.ie_id))
    )
    WHERE active_ind = 'Y'
    OR    position_count <> 0;
    

    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_fund_summary_count;
  
    -- returns count of exceptions for IE error log export
  FUNCTION get_ie_error_log_export_list(p_load_run_id         IN limit_exception.load_run_id%TYPE,
                                        p_source_fund_id_list IN VARCHAR2) RETURN utl.global.t_result_set
  AS
  BEGIN
    RETURN get_ie_error_log(p_load_run_id, null, substr(p_source_fund_id_list,2),null,vcr.pkg_validator.gc_exception_status_tbr,0);
  END get_ie_error_log_export_list;
  
  -- returns count of exceptions for IE error log export
  FUNCTION get_ie_error_log_export_count(p_load_run_id         IN limit_exception.load_run_id%TYPE,
                                         p_source_fund_id_list IN VARCHAR2) RETURN INTEGER
  AS
    v_count INTEGER;
    
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    
    v_sql   VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_ie_error_log_export_count',null);

    SELECT slr.as_of_date, slr.source_id
    INTO   v_as_of_date, v_source_id
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;
    
    v_sql := 
    'SELECT COUNT(*)
     FROM   limit_exception le, source_fund_release sfr
     WHERE  le.source_id   = :1
     AND    le.as_of_date  = :2
     AND    le.load_run_id = :3
     AND    le.load_run_id = sfr.load_run_id
     AND    le.source_fund_id = sfr.source_fund_id
     AND    sfr.released_by IS NOT NULL
     AND    le.source_fund_id IN ('||substr(p_source_fund_id_list,2)||')
     AND    le.status = '''||vcr.pkg_validator.gc_exception_status_tbr||'''';
     
    EXECUTE IMMEDIATE v_sql INTO v_count USING v_source_id, v_as_of_date, p_load_run_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_ie_error_log_export_count;

  -- returns list of exceptions for IE error log
  -- that have been considered genuine problems (to_be_resolved_ind = Y)
  FUNCTION get_ie_error_log(p_load_run_id         IN limit_exception.load_run_id%TYPE,
                            p_ie_platform         IN ie_platform.ie_platform%TYPE,
                            p_source_fund_id_list IN VARCHAR2,
                            p_ie_id               IN investment_engine.ie_id%TYPE,
                            p_status              IN limit_exception.status%TYPE,
                            p_no_of_prior_dates   IN INTEGER DEFAULT 0) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;

    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    v_basis      source_basis.basis%TYPE;
    v_from_date  DATE:=NULL;
    v_sql        VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_ie_error_log',null);
    
    SELECT slr.as_of_date, slr.source_id, slr.basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;
    
    IF p_no_of_prior_dates > 0
    THEN
      v_from_date := v_as_of_date;
     
      FOR i IN 1..p_no_of_prior_dates
      LOOP
        v_from_date := utl.pkg_date.get_weekday(v_from_date,-1);
      END LOOP;
    END IF;

    v_sql := 
    'SELECT /*+ ALL_ROWS */ 
           to_char(le.as_of_date,''dd-MON-yyyy'') as_of_date,
           sf.fund,
           ss.strategy,
           le.sub_strategy,
           le.instrument_id,
           le.instrument,
           sb.broker,
           sit.instrument_type,
           pkg_limit.get_version_values(le.limit_id,le.limit_version) limit_value,
           to_char(decode(vm.units,'''||pkg_ref_object.gc_percentage_vcr_type||''', 100, 1) * le.validation_measure_value,vm.format) break_value,
           le.exception_description,    
           to_char(le.current_instrument_value,''FM999,999,999,999,990.00''),
           to_char(le.current_pnl_mtd,''FM999,999,999,999,990.00''),
           to_char(le.current_instrument_holding,''FM999,999,999,999,990.00''),
           to_char(le.current_instrument_price_local,''FM999,999,999,999,990.00''),
           to_char(le.current_bb_price,''FM999,999,999,999,990.00''),
           to_char(le.prior_instrument_value,''FM999,999,999,999,990.00''),
           to_char(le.prior_pnl_mtd,''FM999,999,999,999,990.00''),
           to_char(le.prior_instrument_holding,''FM999,999,999,999,990.00''),
           to_char(le.prior_instrument_price_local,''FM999,999,999,999,990.00''),
           to_char(le.prior_bb_price,''FM999,999,999,999,990.00''),
           to_char(le.daily_pnl_change,''FM999,999,999,999,990.00''),
           to_char(le.current_month_notional,''FM999,999,999,999,990.00''),
           le.comments,
           lec.description,
           le.type,
           pkg_limit.get_measure_rule_description(le.limit_id) measure_rule,
           le.action_description,
           le.resolution_description,           
           le.last_updated_by,
           to_char(le.last_updated_date, ''dd-MON-yyyy hh24:mi:ss''),
           le.resolution_user,
           to_char(le.resolution_date, ''dd-MON-yyyy hh24:mi:ss''),
           le.currency
    FROM   source_fund sf,
           source_strategy ss,
           limit_exception le,
           limit l,
           source_broker sb,
           source_instrument_type sit,
           validation_measure vm,
           limit_exception_class lec
    WHERE  ((:1 IS NULL     AND le.as_of_date = :2) OR
            (:1 IS NOT NULL AND le.as_of_date BETWEEN :1 AND :2))
    AND    le.source_id          = :3
    AND    ((le.load_run_id = :4 AND le.as_of_date = :2) OR (le.as_of_date < :2))
    AND    ((sf.ie_platform = :5 AND sf.ie_id = :6 AND :5 IS NOT NULL) OR (:5 IS NULL))
    AND    le.status = :7
    AND    le.source_fund_id IN ('||p_source_fund_id_list||') 
    AND    le.source_fund_id     = sf.source_fund_id (+)
    AND    le.source_strategy_id = ss.source_strategy_id (+)
    AND    le.source_broker_id   = sb.source_broker_id (+)
    AND    le.source_instrument_type_id = sit.source_instrument_type_id (+)
    AND    le.limit_id           = l.limit_id
    AND    l.measure_id          = vm.measure_id
    AND    le.class              = lec.class (+)   
    AND    le.to_be_resolved_ind = ''Y''
    ORDER BY le.as_of_date DESC, sf.fund, ss.strategy';
    
    OPEN cur_list FOR v_sql USING v_from_date, v_as_of_date, v_from_date, v_from_date, v_as_of_date, v_source_id, p_load_run_id, v_as_of_date, v_as_of_date, p_ie_platform,p_ie_id,p_ie_platform,p_ie_platform,p_status;
   
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_ie_error_log;                                 
  
  -- formats error log CLOB for sending as an attachment
  FUNCTION format_ie_error_log(p_load_run_id         IN limit_exception.load_run_id%TYPE,
                               p_ie_platform         IN ie_platform.ie_platform%TYPE,
                               p_source_fund_id_list IN VARCHAR2,
                               p_ie_id               IN investment_engine.ie_id%TYPE,
                               p_fund_names          IN VARCHAR2,
                               p_status              IN limit_exception.status%TYPE,
                               p_no_of_prior_dates   IN INTEGER DEFAULT 0) RETURN CLOB
  AS
    cur_log utl.global.t_result_set;
    
    v_error_log CLOB := NULL;
    
    v_as_of_date                     VARCHAR2(11);
    v_fund                           source_fund.fund%TYPE;
    v_strategy                       source_strategy.strategy%TYPE;
    v_sub_strategy                   limit_exception.sub_strategy%TYPE;
    v_instrument_id                  limit_exception.instrument_id%TYPE;
    v_instrument                     limit_exception.instrument%TYPE;
    v_broker                         source_broker.broker%TYPE;
    v_instrument_type                source_instrument_type.instrument_type%TYPE;
    v_currency                       limit_exception.currency%TYPE;
    v_limit_value                    VARCHAR2(4000);
    v_break_value                    VARCHAR2(4000);
    v_description                    limit_exception.exception_description%TYPE;
    v_current_instrument_value       VARCHAR2(4000);
    v_current_pnl_mtd                VARCHAR2(4000);
    v_current_instrument_holding     VARCHAR2(4000);
    v_current_ins_price_local        VARCHAR2(4000);
    v_current_bb_price               VARCHAR2(4000);
    v_prior_instrument_value         VARCHAR2(4000);
    v_prior_pnl_mtd                  VARCHAR2(4000);
    v_prior_instrument_holding       VARCHAR2(4000);
    v_prior_instrument_price_local   VARCHAR2(4000);
    v_prior_bb_price                 VARCHAR2(4000);
    v_daily_pnl_change               VARCHAR2(4000);
    v_current_month_notional         VARCHAR2(4000);
    v_comments                       limit_exception.comments%TYPE;
    v_class                          limit_exception_class.description%TYPE;
    v_type                           limit_exception.type%TYPE;
    v_measure_rule                   VARCHAR2(4000);
    v_action_description             limit_exception.action_description%TYPE;
    v_resolution_description         limit_exception.resolution_description%TYPE;
    v_last_updated_by                limit_exception.last_updated_by%TYPE;
    v_last_updated_date              VARCHAR2(24);
    v_resolution_user                limit_exception.resolution_user%TYPE;
    v_resolution_date                VARCHAR2(24);
    
    v_iep_description                ie_platform.description%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.format_ie_error_log',null);
  
    -- get cursor of exceptions record that meet criteria  
    cur_log := get_ie_error_log(p_load_run_id, p_ie_platform,p_source_fund_id_list,p_ie_id,p_status,p_no_of_prior_dates);

    -- format  records
    v_error_log := 'Load Run:'||utl.pkg_constants.gc_tab||pkg_source_load_run.get_description(p_load_run_id)||utl.pkg_constants.gc_cr;
    v_error_log := v_error_log || 'Investment Engine:'||utl.pkg_constants.gc_tab||p_ie_id||utl.pkg_constants.gc_cr;
    
    IF p_ie_platform IS NOT NULL
    THEN
      SELECT iep.description
      INTO   v_iep_description
      FROM   ie_platform iep
      WHERE  iep.ie_id               = p_ie_id
      AND    iep.ie_platform         = p_ie_platform;
      
      v_error_log := v_error_log || 'Investment Engine Platform:'||utl.pkg_constants.gc_tab||v_iep_description||utl.pkg_constants.gc_cr;
    END IF;
    
    v_error_log := v_error_log || 'Funds:'||utl.pkg_constants.gc_tab||p_fund_names||utl.pkg_constants.gc_cr;
    v_error_log := v_error_log || 'Status:'||utl.pkg_constants.gc_tab||p_status||utl.pkg_constants.gc_cr;
 
    IF p_no_of_prior_dates > 0
    THEN
      v_error_log := v_error_log || 'Number of Prior As Of Dates:'||utl.pkg_constants.gc_tab||p_no_of_prior_dates||utl.pkg_constants.gc_cr;
    END IF;
    
    v_error_log := v_error_log || 'Report Date/Time:'||utl.pkg_constants.gc_tab||to_char(sysdate,'dd-MON-yyyy hh24:mi:ss')||utl.pkg_constants.gc_cr;
 
    v_error_log := v_error_log || utl.pkg_constants.gc_cr;
    
    -- format each data record
    LOOP
      FETCH cur_log 
      INTO 
      v_as_of_date,
      v_fund,
      v_strategy,
      v_sub_strategy,
      v_instrument_id,
      v_instrument,
      v_broker,
      v_instrument_type,
      v_limit_value,
      v_break_value,
      v_description,
      v_current_instrument_value,
      v_current_pnl_mtd,
      v_current_instrument_holding,
      v_current_ins_price_local,
      v_current_bb_price,
      v_prior_instrument_value,
      v_prior_pnl_mtd,
      v_prior_instrument_holding,
      v_prior_instrument_price_local,
      v_prior_bb_price,
      v_daily_pnl_change,
      v_current_month_notional,
      v_comments,
      v_class,
      v_type,
      v_measure_rule,
      v_action_description,
      v_resolution_description,
      v_last_updated_by,
      v_last_updated_date,
      v_resolution_user,
      v_resolution_date,
      v_currency;
      
      EXIT WHEN cur_log%NOTFOUND;
   
      -- if first record format a list of column names
      IF cur_log%ROWCOUNT = 1
      THEN
        v_error_log := v_error_log || 
                     'As Of Date' || utl.pkg_constants.gc_tab ||
                     'Fund'       || utl.pkg_constants.gc_tab ||
                     'Strategy'   || utl.pkg_constants.gc_tab ||
                     'Sub-strategy' || utl.pkg_constants.gc_tab ||
                     'Instrument Id' || utl.pkg_constants.gc_tab ||
                     'Instrument' || utl.pkg_constants.gc_tab ||
                     'Broker' || utl.pkg_constants.gc_tab ||
                     'Instrument Type' || utl.pkg_constants.gc_tab ||
                     'Currency' || utl.pkg_constants.gc_tab ||
                     'Measure Rule' || utl.pkg_constants.gc_tab ||
                     'Type' || utl.pkg_constants.gc_tab ||
                     'Description' || utl.pkg_constants.gc_tab ||
                     'Limit' || utl.pkg_constants.gc_tab ||
                     'Break' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Value' || utl.pkg_constants.gc_tab ||
                     'Current MTD PnL' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Holding' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Local Price' || utl.pkg_constants.gc_tab ||
                     'Current Bloomberg Price' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Value' || utl.pkg_constants.gc_tab ||
                     'Prior MTD PnL' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Holding' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Local Price' || utl.pkg_constants.gc_tab ||
                     'Prior Bloomberg Price' || utl.pkg_constants.gc_tab ||
                     'Daily PnL Move' || utl.pkg_constants.gc_tab ||
                     'Current Month Notional' || utl.pkg_constants.gc_tab ||
                     'Comments'  || utl.pkg_constants.gc_tab ||
                     'Classification'  || utl.pkg_constants.gc_tab ||
                     'Action' || utl.pkg_constants.gc_tab ||
                     'Resolution' || utl.pkg_constants.gc_tab ||
                     'Last Updated By' || utl.pkg_constants.gc_tab ||
                     'Last Updated On' || utl.pkg_constants.gc_tab ||
                     'Resolved By' || utl.pkg_constants.gc_tab ||
                     'Resolved On' || utl.pkg_constants.gc_cr;
      END IF;
      
      v_error_log := v_error_log || 
                     v_as_of_date || utl.pkg_constants.gc_tab ||
                     v_fund       || utl.pkg_constants.gc_tab ||
                     v_strategy   || utl.pkg_constants.gc_tab ||
                     v_sub_strategy || utl.pkg_constants.gc_tab ||
                     v_instrument_id || utl.pkg_constants.gc_tab ||
                     v_instrument || utl.pkg_constants.gc_tab ||
                     v_broker || utl.pkg_constants.gc_tab ||
                     v_instrument_type || utl.pkg_constants.gc_tab ||
                     v_currency || utl.pkg_constants.gc_tab ||
                     v_measure_rule || utl.pkg_constants.gc_tab ||
                     v_type || utl.pkg_constants.gc_tab ||
                     v_description || utl.pkg_constants.gc_tab ||
                     v_limit_value || utl.pkg_constants.gc_tab ||
                     v_break_value || utl.pkg_constants.gc_tab ||
                     v_current_instrument_value || utl.pkg_constants.gc_tab ||
                     v_current_pnl_mtd || utl.pkg_constants.gc_tab ||
                     v_current_instrument_holding || utl.pkg_constants.gc_tab ||
                     v_current_ins_price_local || utl.pkg_constants.gc_tab ||
                     v_current_bb_price || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_value || utl.pkg_constants.gc_tab ||
                     v_prior_pnl_mtd || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_holding || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_price_local || utl.pkg_constants.gc_tab ||
                     v_prior_bb_price || utl.pkg_constants.gc_tab ||
                     v_daily_pnl_change || utl.pkg_constants.gc_tab ||
                     v_current_month_notional || utl.pkg_constants.gc_tab ||
                     v_comments  || utl.pkg_constants.gc_tab ||
                     v_class  || utl.pkg_constants.gc_tab ||
                     v_action_description || utl.pkg_constants.gc_tab ||
                     v_resolution_description || utl.pkg_constants.gc_tab ||
                     v_last_updated_by || utl.pkg_constants.gc_tab ||
                     v_last_updated_date || utl.pkg_constants.gc_tab ||
                     v_resolution_user || utl.pkg_constants.gc_tab ||
                     v_resolution_date || utl.pkg_constants.gc_cr;
      
    END LOOP;

    -- if there were no data records say so
    IF cur_log%ROWCOUNT = 0
    THEN
       v_error_log := v_error_log || 'NO DATA';
    END IF;
    
    CLOSE cur_log;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_error_log;
  EXCEPTION
    WHEN OTHERS THEN
      IF cur_log%ISOPEN
      THEN
        CLOSE cur_log;
      END IF;
      
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END format_ie_error_log;

 -- returns list of exceptions for source error log
  FUNCTION get_source_error_log_list(p_load_run_id IN limit_exception.load_run_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;

    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    v_basis      source_basis.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_source_error_log_list',null);
    
    SELECT slr.as_of_date, slr.source_id, slr.basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;

    -- cursor designed to return same number of columns as get_ie_error_log
    -- so that the same ViewObject in jdev can be extended for each one
    OPEN   cur_list
    FOR
    SELECT to_char(le.as_of_date,'dd-MON-yyyy') as_of_date,
           sf.fund,
           ss.strategy,
           le.sub_strategy,
           le.instrument_id,
           le.instrument,
           sb.broker,
           sit.instrument_type,
           null limit_value,
           to_char(decode(vm.units,pkg_ref_object.gc_percentage_vcr_type, 100, 1) * le.validation_measure_value,vm.format) break_value,
           le.exception_description,    
           to_char(le.current_instrument_value,'FM999,999,999,999,990.00'),
           to_char(le.current_pnl_mtd,'FM999,999,999,999,990.00'),
           to_char(le.current_instrument_holding,'FM999,999,999,999,990.00'),
           to_char(le.current_instrument_price_local,'FM999,999,999,999,990.00'),
           null current_bb_price,
           to_char(le.prior_instrument_value,'FM999,999,999,999,990.00'),
           to_char(le.prior_pnl_mtd,'FM999,999,999,999,990.00'),
           to_char(le.prior_instrument_holding,'FM999,999,999,999,990.00'),
           to_char(le.prior_instrument_price_local,'FM999,999,999,999,990.00'),
           null prior_bb_price,
           to_char(le.daily_pnl_change,'FM999,999,999,999,990.00'),
           to_char(le.current_month_notional,'FM999,999,999,999,990.00'),
           le.comments,
           null description,
           le.type,
           pkg_limit.get_measure_rule_description(le.limit_id) measure_rule,
           null action_description,
           null resolution_description,
           null last_updated_by,
           null last_updated_on,
           null resolved_by, 
           null resolved_on,
           le.currency
    FROM   source_fund sf,
           source_strategy ss,
           limit_exception le,
           limit l,
           source_broker sb,
           source_instrument_type sit,
           validation_measure vm
    WHERE  le.load_run_id = p_load_run_id
    AND    le.as_of_date  = v_as_of_date
    AND    le.source_id   = v_source_id
    AND    le.basis       = v_basis
    AND    le.source_fund_id = sf.source_fund_id (+)
    AND    le.source_strategy_id = ss.source_strategy_id (+)
    AND    le.source_broker_id   = sb.source_broker_id (+)
    AND    le.source_instrument_type_id = sit.source_instrument_type_id (+)
    AND    le.limit_id = l.limit_id
    AND    l.measure_id = vm.measure_id
    AND    le.status = pkg_validator.gc_exception_status_tbr
    ORDER BY sf.fund, ss.strategy;
     
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_source_error_log_list;     
  
  -- returns count of exceptions for source error log
  FUNCTION get_source_error_log_count(p_load_run_id IN limit_exception.load_run_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
    
    -- variables to hold literals for where clause 
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    v_basis      source_basis.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.get_source_error_log_count',null);
    
    SELECT slr.as_of_date, slr.source_id, slr.basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id  = p_load_run_id;

    SELECT COUNT(*)
    INTO   v_count
    FROM   limit_exception le
    WHERE  le.load_run_id = p_load_run_id
    AND    le.as_of_date  = v_as_of_date
    AND    le.source_id   = v_source_id
    AND    le.basis       = v_basis
    AND    le.status      = pkg_validator.gc_exception_status_tbr;
     
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE;
  END get_source_error_log_count;     
  
   -- formats source error log CLOB for sending as an attachment
  FUNCTION format_source_error_log(p_load_run_id IN limit_exception.load_run_id%TYPE) RETURN CLOB
  AS
    cur_log utl.global.t_result_set;
    
    v_error_log CLOB := NULL;
    
    v_as_of_date                     VARCHAR2(11);
    v_fund                           source_fund.fund%TYPE;
    v_strategy                       source_strategy.strategy%TYPE;
    v_sub_strategy                   limit_exception.sub_strategy%TYPE;
    v_instrument_id                  limit_exception.instrument_id%TYPE;
    v_instrument                     limit_exception.instrument%TYPE;
    v_broker                         source_broker.broker%TYPE;
    v_instrument_type                source_instrument_type.instrument_type%TYPE;
    v_currency                       limit_exception.currency%TYPE;
    v_limit_value                    VARCHAR2(4000);
    v_break_value                    VARCHAR2(4000);
    v_description                    limit_exception.exception_description%TYPE;
    v_current_instrument_value       VARCHAR2(4000);
    v_current_pnl_mtd                VARCHAR2(4000);
    v_current_instrument_holding     VARCHAR2(4000);
    v_current_ins_price_local        VARCHAR2(4000);
    v_current_bb_price               VARCHAR2(4000);
    v_prior_instrument_value         VARCHAR2(4000);
    v_prior_pnl_mtd                  VARCHAR2(4000);
    v_prior_instrument_holding       VARCHAR2(4000);
    v_prior_instrument_price_local   VARCHAR2(4000);
    v_prior_bb_price                 VARCHAR2(4000);
    v_daily_pnl_change               VARCHAR2(4000);
    v_current_month_notional         VARCHAR2(4000);
    v_comments                       limit_exception.comments%TYPE;
    v_class                          limit_exception_class.description%TYPE;
    v_type                           limit_exception.type%TYPE;
    v_measure_rule                   VARCHAR2(4000);
    v_action_description             limit_exception.action_description%TYPE;
    v_resolution_description         limit_exception.resolution_description%TYPE;
    v_last_updated_by                limit_exception.last_updated_by%TYPE;
    v_last_updated_date              VARCHAR2(24);
    v_resolution_user                limit_exception.resolution_user%TYPE;
    v_resolution_date                VARCHAR2(24);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception.format_source_error_log',null);
  
    -- get cursor of exceptions record that meet criteria  
    cur_log := get_source_error_log_list(p_load_run_id);

    -- format  records
    v_error_log := 'Load Run:'||utl.pkg_constants.gc_tab||pkg_source_load_run.get_description(p_load_run_id)||utl.pkg_constants.gc_cr;   
    v_error_log := v_error_log || 'Report Date/Time:'||utl.pkg_constants.gc_tab||to_char(sysdate,'dd-MON-yyyy hh24:mi:ss')||utl.pkg_constants.gc_cr;
 
    v_error_log := v_error_log || utl.pkg_constants.gc_cr;
    
    -- format each data record
    LOOP
      FETCH cur_log 
      INTO 
      v_as_of_date,
      v_fund,
      v_strategy,
      v_sub_strategy,
      v_instrument_id,
      v_instrument,
      v_broker,
      v_instrument_type,
      v_limit_value,
      v_break_value,
      v_description,
      v_current_instrument_value,
      v_current_pnl_mtd,
      v_current_instrument_holding,
      v_current_ins_price_local,
      v_current_bb_price,
      v_prior_instrument_value,
      v_prior_pnl_mtd,
      v_prior_instrument_holding,
      v_prior_instrument_price_local,
      v_prior_bb_price,
      v_daily_pnl_change,
      v_current_month_notional,
      v_comments,
      v_class,
      v_type,
      v_measure_rule,
      v_action_description,
      v_resolution_description,
      v_last_updated_by,
      v_last_updated_date,
      v_resolution_user,
      v_resolution_date,
      v_currency;
      
      EXIT WHEN cur_log%NOTFOUND;
   
      -- if first record format a list of column names
      IF cur_log%ROWCOUNT = 1
      THEN
        v_error_log := v_error_log || 
                     'As Of Date' || utl.pkg_constants.gc_tab ||
                     'Fund'       || utl.pkg_constants.gc_tab ||
                     'Strategy'   || utl.pkg_constants.gc_tab ||
                     'Sub-strategy' || utl.pkg_constants.gc_tab ||
                     'Instrument Id' || utl.pkg_constants.gc_tab ||
                     'Instrument' || utl.pkg_constants.gc_tab ||
                     'Broker' || utl.pkg_constants.gc_tab ||
                     'Instrument Type' || utl.pkg_constants.gc_tab ||
                     'Currency' || utl.pkg_constants.gc_tab ||
                     'Measure Rule' || utl.pkg_constants.gc_tab ||
                     'Type' || utl.pkg_constants.gc_tab ||
                     'Description' || utl.pkg_constants.gc_tab ||
                     'Break' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Value' || utl.pkg_constants.gc_tab ||
                     'Current MTD PnL' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Holding' || utl.pkg_constants.gc_tab ||
                     'Current Instrument Local Price' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Value' || utl.pkg_constants.gc_tab ||
                     'Prior MTD PnL' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Holding' || utl.pkg_constants.gc_tab ||
                     'Prior Instrument Local Price' || utl.pkg_constants.gc_tab ||
                     'Daily PnL Move' || utl.pkg_constants.gc_tab ||
                     'Current Month Notional' || utl.pkg_constants.gc_tab ||
                     'Comments' || utl.pkg_constants.gc_cr;
                     
      END IF;
      
      v_error_log := v_error_log || 
                     v_as_of_date || utl.pkg_constants.gc_tab ||
                     v_fund       || utl.pkg_constants.gc_tab ||
                     v_strategy   || utl.pkg_constants.gc_tab ||
                     v_sub_strategy || utl.pkg_constants.gc_tab ||
                     v_instrument_id || utl.pkg_constants.gc_tab ||
                     v_instrument || utl.pkg_constants.gc_tab ||
                     v_broker || utl.pkg_constants.gc_tab ||
                     v_instrument_type || utl.pkg_constants.gc_tab ||
                     v_currency || utl.pkg_constants.gc_tab ||
                     v_measure_rule || utl.pkg_constants.gc_tab ||
                     v_type || utl.pkg_constants.gc_tab ||
                     v_description || utl.pkg_constants.gc_tab ||
                     v_break_value || utl.pkg_constants.gc_tab ||
                     v_current_instrument_value || utl.pkg_constants.gc_tab ||
                     v_current_pnl_mtd || utl.pkg_constants.gc_tab ||
                     v_current_instrument_holding || utl.pkg_constants.gc_tab ||
                     v_current_ins_price_local || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_value || utl.pkg_constants.gc_tab ||
                     v_prior_pnl_mtd || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_holding || utl.pkg_constants.gc_tab ||
                     v_prior_instrument_price_local || utl.pkg_constants.gc_tab ||
                     v_daily_pnl_change || utl.pkg_constants.gc_tab ||
                     v_current_month_notional || utl.pkg_constants.gc_tab ||
                     v_comments || utl.pkg_constants.gc_cr;
    END LOOP;

    -- if there were no data records say so
    IF cur_log%ROWCOUNT = 0
    THEN
       v_error_log := v_error_log || 'NO DATA';
    END IF;
    
    CLOSE cur_log;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_error_log;
  EXCEPTION
    WHEN OTHERS THEN
      IF cur_log%ISOPEN
      THEN
        CLOSE cur_log;
      END IF;
      
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END format_source_error_log;

  
END pkg_limit_exception;
/
