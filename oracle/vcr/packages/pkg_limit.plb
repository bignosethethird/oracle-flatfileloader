CREATE OR REPLACE PACKAGE BODY vcr.pkg_limit AS
-------------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_limit.plb 1.3.1.10 2005/10/26 15:35:14BST apenney DEV  $
-------------------------------------------------------------------------------------
-- Allows you to query limit info
  
  FUNCTION get_measure_rule_dropdown_list RETURN utl.global.t_result_set
  AS
    cur_mr_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_measure_rule_dropdown_list',null);
    
    OPEN cur_mr_list FOR
      SELECT mr.measure_id, mr.rule_id, get_measure_description(mr.measure_id) || ' ' || get_rule_description(mr.rule_id) description
      FROM   measure_rule mr
      ORDER BY 3;

    dbms_application_info.set_module(null,null);

    RETURN cur_mr_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_measure_rule_dropdown_list;

  FUNCTION get_measure_rule_dropdown_cnt RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_measure_rule_dropdown_count',null);
    
    SELECT COUNT (*)
    INTO   v_count
    FROM   measure_rule;

    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_measure_rule_dropdown_cnt;
  
  -- returns a textual description of a limit
  FUNCTION get_description(p_limit_id IN limit.limit_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_description',null);
    
    v_description := get_measure_rule_description(p_limit_id)||':'||replace(get_header_summary(p_limit_id),utl.pkg_constants.gc_cr);
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle; 
      RAISE; 
  END get_description;
  
  -- returns value of a limit version parameter value
  FUNCTION get_version_value(p_limit_id      IN limit_version.limit_id%TYPE,
                             p_limit_version IN limit_version.limit_version%TYPE,
                             p_rule_parameter_id IN limit_param_value.rule_parameter_id%TYPE) RETURN NUMBER
  AS
    v_value NUMBER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_version_value',null);
      
    SELECT decode(vm.units,pkg_ref_object.gc_percentage_vcr_type, 100, 1) * lpv.value
    INTO   v_value
    FROM   limit_param_value lpv, validation_measure vm, limit l
    WHERE  lpv.limit_id          = p_limit_id
    AND    lpv.limit_version     = p_limit_version
    AND    lpv.rule_parameter_id = p_rule_parameter_id
    AND    lpv.limit_id          = l.limit_id
    AND    l.measure_id          = vm.measure_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_value;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_version_value;
  
  -- returns values of a limit version
  FUNCTION get_version_values(p_limit_id      IN limit_version.limit_id%TYPE,
                              p_limit_version IN limit_version.limit_version%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
    
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_version_values',null);
      
    FOR rec_limit_val IN (
                          SELECT decode(vm.units,pkg_ref_object.gc_percentage_vcr_type, 100, 1) * lpv.value value, vrp.name, vm.format, vm.units
                          FROM   limit_param_value lpv, validation_rule_parameter vrp, validation_measure vm, limit l
                          WHERE  lpv.limit_id          = p_limit_id
                          AND    lpv.limit_version     = p_limit_version
                          AND    vrp.rule_parameter_id = lpv.rule_parameter_id
                          AND    lpv.limit_id          = l.limit_id
                          AND    l.measure_id          = vm.measure_id
                          ORDER BY vrp.seq_id
                         )
    LOOP
      IF v_count != 0
      THEN
        v_description := v_description || '/';
      END IF;
      
      v_description := v_description || trim(leading ' ' from to_char(rec_limit_val.value,rec_limit_val.format));
      
      IF rec_limit_val.units = pkg_ref_object.gc_percentage_vcr_type
      THEN
        v_description := v_description || '%';
      END IF;
      
      v_count := v_count + 1;  
    END LOOP;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_version_values;
   
  -- returns a textual description of a limit version
  FUNCTION get_version_description(p_limit_id      IN limit_version.limit_id%TYPE,
                                   p_limit_version IN limit_version.limit_version%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_version_description',null);
    
    SELECT 'From '||to_char(lv.start_date,'dd-MON-yyyy')|| ' ' || decode(lv.end_date,null,'onwards','to '||to_char(lv.end_date,'dd-MON-yyyy'))||': '
    INTO   v_description
    FROM   limit_version lv
    WHERE  lv.limit_id      = p_limit_id
    AND    lv.limit_version = p_limit_version;
    
    v_description := v_description || get_version_values(p_limit_id, p_limit_version);
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_version_description;
  
  FUNCTION get_rule_description(p_rule_id IN validation_rule.rule_id%TYPE) RETURN VARCHAR2 
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_rule_description',null);
    
    SELECT vr.name
    INTO   v_description
    FROM   validation_rule vr
    WHERE  vr.rule_id = p_rule_id;
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_rule_description;
  
  FUNCTION get_measure_description(p_measure_id IN validation_measure.measure_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_measure_description',null);
    
    SELECT vm.name
    INTO   v_description
    FROM   validation_measure vm
    WHERE  vm.measure_id = p_measure_id;
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_measure_description;
  
  FUNCTION get_rule_parameter_description(p_rule_parameter_id IN validation_rule_parameter.rule_parameter_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_rule_parameter_description',null);
    
    SELECT vrp.name
    INTO   v_description
    FROM   validation_rule_parameter vrp
    WHERE  vrp.rule_parameter_id = p_rule_parameter_id;
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_rule_parameter_description;
  
  FUNCTION get_measure_rule_description(p_limit_id IN limit.limit_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_measure_rule_description',null);
    
    SELECT get_measure_description(l.measure_id) || ' ' || get_rule_description(l.rule_id)
    INTO   v_description
    FROM   limit l
    WHERE  l.limit_id = p_limit_id;
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle; 
      RAISE; 
  END get_measure_rule_description;
  
  FUNCTION get_header_description(p_header_parameter_id IN limit_header_parameter.header_parameter_id%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_description',null);
    
    SELECT lhp.parameter_name
    INTO   v_description
    FROM   limit_header_parameter lhp
    WHERE  lhp.header_parameter_id = p_header_parameter_id;
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_header_description;
  
  FUNCTION get_header_value_description(p_header_parameter_id IN limit_header_parameter.header_parameter_id%TYPE,
                                        p_value               IN limit_header_value.value%TYPE) RETURN VARCHAR2
  AS
    v_description VARCHAR2(4000);
    
    v_get_desc_procedure limit_header_parameter.get_desc_procedure%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_value_description',null);
    
    SELECT lhp.get_desc_procedure
    INTO   v_get_desc_procedure
    FROM   limit_header_parameter lhp
    WHERE  lhp.header_parameter_id = p_header_parameter_id;
                               
    EXECUTE IMMEDIATE v_get_desc_procedure USING OUT v_description, IN p_value;

    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
    
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_header_value_description;
                              
  FUNCTION get_header_summary(p_limit_id IN limit_version.limit_id%TYPE) RETURN VARCHAR2
  AS
    v_summary     VARCHAR2(4000);
    v_description VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_summary',null);
    
    FOR rec_param IN (
                      SELECT lhv.value, lhp.get_desc_procedure, lhp.parameter_name
                      FROM   limit_header_value lhv, limit_header_parameter lhp
                      WHERE  lhv.limit_id = p_limit_id
                      AND    lhv.header_parameter_id = lhp.header_parameter_id
                      ORDER BY lhp.parameter_name
                     )
    LOOP                       
      EXECUTE IMMEDIATE rec_param.get_desc_procedure USING OUT v_description, IN rec_param.value;
      
      v_summary := v_summary || ' ' || rec_param.parameter_name ||'='|| v_description||utl.pkg_constants.gc_cr;
    END LOOP;

    dbms_application_info.set_module(null,null);

    return nvl(v_summary,'Common');
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      RAISE; 
  END get_header_summary;
  
  FUNCTION get_header_param_list(p_measure_rule_id IN VARCHAR2) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
    
    v_measure_id validation_measure.measure_id%TYPE;
    v_rule_id    validation_rule.rule_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_param_list',null);
   
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    
    -- we assume there will never be more than 10 header parameters
    -- the struts form has to have a static set of properties
    OPEN cur_list
    FOR
    SELECT mr_hp.column_name, mr_hp.parameter_name, mr_hp.parent_column_name, all_hp.header_parameter_id, mr_hp.hp_seq, mr_hp.parent_source, mr_hp.parent_ie
    FROM
    (
      SELECT lhp.column_name, lhp.parameter_name, lhp.parent_column_name, lhp.header_parameter_id, rownum hp_seq, decode(lhp.parent_column_name, null, 'N', decode(instr(lhp.parent_column_name,'source_id'),0,'N','Y')) parent_source, decode(lhp.parent_column_name, null, 'N', decode(instr(lhp.parent_column_name,'ie_id'),0,'N','Y')) parent_ie
      FROM  measure_rule_limit_head_param mrlhp, limit_header_parameter lhp
      WHERE mrlhp.measure_id = v_measure_id
      AND   mrlhp.rule_id    = v_rule_id
      AND   mrlhp.header_parameter_id = lhp.header_parameter_id
    ) mr_hp,
    (
      SELECT rownum header_parameter_id
      FROM   all_objects 
      WHERE  rownum <= 10
     ) all_hp
     WHERE all_hp.header_parameter_id = mr_hp.header_parameter_id (+)
     ORDER BY all_hp.header_parameter_id;
    
    dbms_application_info.set_module(null,null);

    return cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
            
      RAISE; 
  END get_header_param_list;
  
  FUNCTION get_header_value_count RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_value_count',null);
   
    SELECT COUNT(*)
    INTO v_count
    FROM
    (
      SELECT null
      FROM   source_fund
      UNION ALL
      SELECT null
      FROM   source_strategy
      UNION ALL 
      SELECT null
      FROM   ie_instrument_type
      UNION ALL 
      SELECT null
      FROM   source
      UNION ALL 
      SELECT null
      FROM   investment_engine
    );
    
    dbms_application_info.set_module(null,null);

    return v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
            
      RAISE; 
  END get_header_value_count;    
  
  FUNCTION get_header_value_list RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_header_value_list',null);
   
    OPEN cur_list
    FOR
    SELECT 'source_fund_id' column_name,
           to_char(source_fund_id)   param_value,
           fund             param_description,
           to_char(source_id)        parent_source,
           ie_id                     parent_ie
    FROM   source_fund
    UNION
    SELECT 'source_strategy_id'             column_name,
           to_char(ss.source_strategy_id)   param_value,
           sf.fund||' '||ss.strategy        param_description,
           to_char(ss.source_id)            parent_source,
           sf.ie_id                         parent_ie
    FROM   source_strategy ss, source_fund sf
    WHERE  ss.fund      = sf.fund
    AND    ss.source_id = sf.source_id
    UNION  
    SELECT 'ie_instrument_type_id'    column_name,
           to_char(ieit.ie_instrument_type_id) param_value,
           ieit.ie_instrument_type    param_description,
           null                       parent_source,
           ieit.ie_id                 parent_ie
    FROM   ie_instrument_type ieit
    UNION  
    SELECT 'source_id'   column_name,
           to_char(s.source_id)   param_value,
           s.source_name param_description,
           null          parent_source,
           null          parent_ie 
    FROM   source s
    UNION  
    SELECT 'ie_id'        column_name,
           ie.ie_id       param_value,
           ie.description param_description,
           null           parent_source,
           null           parent_ie 
    FROM   investment_engine ie
    ORDER BY 3;
    
    dbms_application_info.set_module(null,null);

    return cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_header_value_list;
    
  FUNCTION get_list_sql (p_measure_rule_id IN VARCHAR2,
                         p_header_values   IN VARCHAR2) RETURN VARCHAR2
  AS
    v_sql           VARCHAR2(32000);
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;
    
    t_values        dbms_sql.varchar2_table;
    v_header_values VARCHAR2(200);
    v_in_clause     VARCHAR2(32000);                     
    
    v_header_parameter_id limit_header_parameter.header_parameter_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit.get_list_sql',null);
   
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    
     -- lose the comma at the start of the value list
    v_header_values := substr(p_header_values,2);
    
    -- get a tableof fund ids
    t_values := utl.pkg_string.string2varchar2_table(v_header_values,utl.pkg_constants.gc_comma);
    
    IF t_values.COUNT <> 0
    THEN
      FOR i IN t_values.FIRST..t_values.LAST 
      LOOP
        IF t_values(i) IS NOT NULL
        THEN
          SELECT header_parameter_id
          INTO   v_header_parameter_id
          FROM   (
                  SELECT rownum seq,
                         header_parameter_id
                  FROM   measure_rule_limit_head_param
                  WHERE  measure_id = v_measure_id
                  AND    rule_id    = v_rule_id
                  ORDER BY header_parameter_id
                 )
          WHERE seq = i;
          
          v_in_clause := v_in_clause || ' AND l.limit_id IN (
                                                             SELECT lhv.limit_id
                                                             FROM   limit_header_value lhv, limit l
                                                             WHERE  lhv.header_parameter_id = '||v_header_parameter_id||'
                                                             AND    lhv.value               = '''||t_values(i)||'''
                                                             AND    lhv.limit_id            = l.limit_id
                                                             AND    l.measure_id            = '||v_measure_id||'
                                                             AND    l.rule_id               = '||v_rule_id||'
                                                            )';
        END IF;
      END LOOP;
    END IF;
    
    v_sql := 
     '
     FROM  limit l
     WHERE ((NOT EXISTS(
                        SELECT DISTINCT 1
                        FROM limit_header_parameter lhp, measure_rule_limit_head_param mrlhp
                        WHERE lhp.header_parameter_id = mrlhp.header_parameter_id
                        AND   lhp.column_name IN (''source_fund_id'')
                        AND   mrlhp.measure_id = '||v_measure_id||'
                        AND   mrlhp.rule_id    = '||v_rule_id||'                                      
                       )      
             OR l.limit_id IN (
                        SELECT lhv.limit_id 
                        FROM  limit_header_value lhv, limit_header_parameter lhp, source_fund sf, limit l
                        WHERE lhp.column_name         = ''source_fund_id''
                        AND   lhp.header_parameter_id = lhv.header_parameter_id
                        AND   to_number(lhv.value)    = sf.source_fund_id
                        AND   (:1 is null or sf.source_id = to_number(:2))
                        AND   (:3 is null or sf.ie_id = :4)
                        AND   lhv.limit_id            = l.limit_id
                        AND   l.measure_id            = '||v_measure_id||'
                        AND   l.rule_id               = '||v_rule_id||'
                       )) 
     AND  (:5 IS NULL OR NOT EXISTS(
                                    SELECT DISTINCT 1
                                    FROM limit_header_parameter lhp, measure_rule_limit_head_param mrlhp
                                    WHERE lhp.header_parameter_id = mrlhp.header_parameter_id
                                    AND   lhp.column_name IN (''ie_instrument_type_id'')
                                    AND   mrlhp.measure_id = '||v_measure_id||'
                                    AND   mrlhp.rule_id    = '||v_rule_id||'
                                   )      
              OR l.limit_id IN (
                                    SELECT lhv.limit_id 
                                    FROM limit_header_value lhv, limit_header_parameter lhp, ie_instrument_type ieit, limit l
                                    WHERE lhp.column_name         = ''ie_instrument_type_id''
                                    AND   lhp.header_parameter_id = lhv.header_parameter_id
                                    AND   to_number(lhv.value)    = ieit.ie_instrument_type_id
                                    AND   ieit.ie_id              = :6
                                    AND   lhv.limit_id            = l.limit_id
                                    AND   l.measure_id            = '||v_measure_id||'
                                    AND   l.rule_id               = '||v_rule_id||'
                                   ))
           )
     AND   l.measure_id            = :7
     AND   l.rule_id               = :8
     '||v_in_clause;
      
    dbms_application_info.set_module(null,null);

    RETURN v_sql;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
            
      RAISE; 
  END get_list_sql;
  
  FUNCTION get_list(p_measure_rule_id IN VARCHAR2,
                    p_source_id       IN source.source_id%TYPE,
                    p_ie_id           IN investment_engine.ie_id%TYPE,
                    p_header_values   IN VARCHAR2) RETURN utl.global.t_result_set
  AS
    v_sql VARCHAR2(32000);
    
    cur_list utl.global.t_result_set;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;    
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_list',null);
    
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    
    v_sql := get_list_sql(p_measure_rule_id, p_header_values);
    
    v_sql := 'SELECT DISTINCT l.limit_id,
                     (
                      SELECT MAX(lv.limit_version)
                      FROM   limit_version lv
                      WHERE  l.limit_id = lv.limit_id
                     ) latest_version,
                     (
                      SELECT lv.limit_version
                      FROM   limit_version lv
                      WHERE  l.limit_id = lv.limit_id
                      AND    trunc(sysdate) between lv.start_date and nvl(lv.end_date,to_date(''5373484'',''j''))
                     ) current_version
              '|| v_sql;

    v_sql := 'SELECT l.limit_id, 
                     l.current_version,
                     nvl(pkg_limit.get_header_summary(l.limit_id),''Common''),
                     decode(l.current_version,null,null,pkg_limit.get_version_values(l.limit_id, l.current_version)),
                     to_char(current_version.start_date,''dd-MON-yyyy''),
                     to_char(current_version.end_date,''dd-MON-yyyy''),
                     to_char(latest_version.end_date,''dd-MON-yyyy''),
                     l.latest_version
              FROM   ('||v_sql||') l, limit_version current_version, limit_version latest_version
              WHERE  l.limit_id        = current_version.limit_id (+)
              AND    l.current_version = current_version.limit_version (+)
              AND    l.limit_id        = latest_version.limit_id (+)
              AND    l.latest_version  = latest_version.limit_version (+)
              ORDER BY 3';
 
    OPEN  cur_list
    FOR   v_sql 
    USING p_source_id, p_source_id, p_ie_id, p_ie_id, p_ie_id, p_ie_id, v_measure_id, v_rule_id;
                   
    dbms_application_info.set_module(null,null);

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_list;  
  
  FUNCTION get_count(p_measure_rule_id IN VARCHAR2,
                    p_source_id       IN source.source_id%TYPE,
                    p_ie_id           IN investment_engine.ie_id%TYPE,
                    p_header_values   IN VARCHAR2) RETURN INTEGER
  AS
    v_sql VARCHAR2(32000);
    
    v_count INTEGER;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;    
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_count',null);
    
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    
    v_sql := get_list_sql(p_measure_rule_id, p_header_values);
    
    v_sql := 'SELECT COUNT(DISTINCT l.limit_id)
              '|| v_sql;
    
    EXECUTE IMMEDIATE v_sql INTO v_count USING p_source_id, p_source_id, p_ie_id, p_ie_id, p_ie_id, p_ie_id, v_measure_id, v_rule_id;
                   
    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_count;  
  
  FUNCTION get_version_list(p_limit_id IN limit_version.limit_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_version_list',null);
    
    OPEN cur_list
    FOR
    SELECT lv.limit_version, 
           pkg_limit.get_version_values(lv.limit_id,lv.limit_version),
           to_char(lv.start_date,'dd-MON-yyyy'),
           to_char(lv.end_date,'dd-MON-yyyy')
    FROM   limit_version lv
    WHERE  lv.limit_id = p_limit_id;
                 
    dbms_application_info.set_module(null,null);

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_version_list;  
  
  FUNCTION get_version_count(p_limit_id IN limit_version.limit_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_version_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   limit_version lv
    WHERE  lv.limit_id = p_limit_id;
                 
    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_version_count;  
  
  FUNCTION get_detail(p_limit_id IN limit_version.limit_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_version_list',null);
    
    OPEN cur_list
    FOR
    SELECT nvl(pkg_limit.get_header_summary(l.limit_id),'Common'),
           lv.start_date,
           lv.end_date,
           lv.limit_version
    FROM   limit l, limit_version lv
    WHERE  l.limit_id = p_limit_id
    AND    l.limit_id = lv.limit_id
    AND    lv.limit_version = (SELECT MAX(latest.limit_version) FROM limit_version latest WHERE latest.limit_id = l.limit_id);
    
    dbms_application_info.set_module(null,null);

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_detail;  
 
  FUNCTION get_rule_param_list(p_measure_rule_id IN VARCHAR2) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;    
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_rule_param_list',null);
    
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
     
    OPEN cur_list
    FOR
    SELECT vrp.name || ' ' || decode(vm.units,pkg_ref_object.gc_percentage_vcr_type,'%',null),
           vrp.rule_parameter_id
    FROM   validation_rule_parameter vrp, validation_measure vm
    WHERE  vrp.rule_id = v_rule_id
    AND    vm.measure_id = v_measure_id
    ORDER BY vrp.seq_id;
                 
    dbms_application_info.set_module(null,null);

    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_rule_param_list;  
  
  FUNCTION get_rule_param_count(p_measure_rule_id IN VARCHAR2) RETURN INTEGER
  AS
    v_count INTEGER;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE; 
  BEGIN 
    dbms_application_info.set_module('vcr.pkg_limit.get_rule_param_count',null);
    
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   validation_rule_parameter vrp
    WHERE  vrp.rule_id = v_rule_id;
                 
    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      RAISE; 
  END get_rule_param_count;    
END pkg_limit;
/
