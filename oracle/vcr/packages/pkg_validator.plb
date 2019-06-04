CREATE OR REPLACE PACKAGE BODY vcr.pkg_validator is
  ------------------------------------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_validator.plb 1.3.1.6 2005/10/28 13:58:32BST apenney DEV  $
  ------------------------------------------------------------------------------------------------------
  --  A package to apply validation measure rules to VCR data to generate exception records
  ------------------------------------------------------------------------------------------------------
   
  -- loads a temporary table for looking up limits
  PROCEDURE load_limit_lookup(p_measure_id IN validation_measure.measure_id%type,
                              p_rule_id    IN validation_rule.rule_id%type,
                              p_as_of_date IN DATE)
  AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.load_limit_lookup',null);
    
    delete from limit_lookup;
    
    insert
    into  limit_lookup
    (
           limit_id,
           limit_version,
           header_value_1,
           header_value_2,
           header_value_3,
           header_value_4,
           header_value_5,
           param_value_1,
           param_value_2,
           param_value_3,
           param_value_4,           
           break_message
    )
    select lv.limit_id,
           lv.limit_version,
           (select lhv.value from limit_header_value lhv where lhv.limit_id = lv.limit_id and lhv.header_parameter_id =1) header_value_1,
           (select lhv.value from limit_header_value lhv where lhv.limit_id = lv.limit_id and lhv.header_parameter_id =2) header_value_2,
           (select lhv.value from limit_header_value lhv where lhv.limit_id = lv.limit_id and lhv.header_parameter_id =3) header_value_3,
           (select lhv.value from limit_header_value lhv where lhv.limit_id = lv.limit_id and lhv.header_parameter_id =4) header_value_4,
           (select lhv.value from limit_header_value lhv where lhv.limit_id = lv.limit_id and lhv.header_parameter_id =5) header_value_5,
           (select lpv.value from limit_param_value lpv where lpv.limit_id = lv.limit_id and lpv.limit_version = lv.limit_version and lpv.rule_parameter_id = 1) param_value_1,
           (select lpv.value from limit_param_value lpv where lpv.limit_id = lv.limit_id and lpv.limit_version = lv.limit_version and lpv.rule_parameter_id = 2) param_value_2,
           (select lpv.value from limit_param_value lpv where lpv.limit_id = lv.limit_id and lpv.limit_version = lv.limit_version and lpv.rule_parameter_id = 3) param_value_3,
           (select lpv.value from limit_param_value lpv where lpv.limit_id = lv.limit_id and lpv.limit_version = lv.limit_version and lpv.rule_parameter_id = 4) param_value_4,
           vr.break_message
    from   limit_version lv, validation_rule vr, limit l
    where  lv.limit_id = l.limit_id
    and    l.rule_id = vr.rule_id
    and    l.measure_id = p_measure_id
    and    l.rule_id = p_rule_id
    and    p_as_of_date between lv.start_date and nvl(lv.end_date,to_date('5373484','j'));
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN   
      utl.pkg_errorhandler.handle;
    
      RAISE;
    
  END load_limit_lookup; 
  -- formats sql to perform a particular measure calculation and compare the
  -- the results against rule limits
  -- generating exceptions
  FUNCTION get_validation_sql(p_load_run_id IN source_load_run.load_run_id%TYPE,
                              p_measure_id  IN measure_rule.measure_id%TYPE,
                              p_rule_id     IN measure_rule.rule_id%TYPE,
                              p_calc_desc   IN validation_measure_calc.description%TYPE) RETURN VARCHAR2
  AS
    v_sql VARCHAR2(32000);
    
    v_denominator         validation_measure_calc.denominator%TYPE;
    v_numerator           validation_measure_calc.numerator%TYPE;
    v_calc_level          validation_measure.calc_level%TYPE;
    v_views               validation_measure_calc.view_list%TYPE;
    v_joins               validation_measure_calc.joins%TYPE;
    v_level_test          validation_measure_calc.level_test%TYPE;
    v_error_test          validation_measure_calc.error_test%TYPE;
    
    v_last_load_run_id    source_load_run.load_run_id%TYPE;
    
    v_source_id           source_load_run.source_id%TYPE;
    v_as_of_date          source_load_run.as_of_date%TYPE;
    v_basis               source_load_run.basis%TYPE;
        
    CURSOR cur_limit_header_param (p_measure_id IN measure_rule.measure_id%TYPE,
                                   p_rule_id    IN measure_rule.rule_id%TYPE)
    IS 
    SELECT lhp.column_name,
           lhp.header_parameter_id,
           lhp.parameter_name
    FROM   measure_rule_limit_head_param mrlhp, limit_header_parameter lhp
    WHERE  mrlhp.measure_id          = p_measure_id
    AND    mrlhp.rule_id             = p_rule_id
    AND    mrlhp.header_parameter_id = lhp.header_parameter_id
    ORDER BY mrlhp.header_parameter_id;
    
    CURSOR cur_limit_rule_param (p_rule_id IN measure_rule.rule_id%TYPE)
    IS 
    SELECT vrp.operator,
           vrp.rule_parameter_id,
           vrp.seq_id,
           vrp.name
    FROM   validation_rule_parameter vrp
    WHERE  vrp.rule_id = p_rule_id
    ORDER BY vrp.seq_id;
    
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.get_validation_sql',null);
    
    -- retrieve details of measure calculation
    
    SELECT vmc.denominator,
           vmc.numerator,
           vmc.view_list,
           vmc.joins,
           vmc.level_test,
           vmc.error_test,
           vm.calc_level
    INTO   v_denominator,
           v_numerator,
           v_views,
           v_joins,
           v_level_test,
           v_error_test,
           v_calc_level
    FROM   validation_measure_calc vmc, validation_measure vm
    WHERE  vmc.measure_id  = p_measure_id
    AND    vmc.description = p_calc_desc
    AND    vm.measure_id   = vmc.measure_id;
  
    -- get this load runs as of date, basis, source
    SELECT as_of_date,
           basis,
           source_id
    INTO   v_as_of_date,
           v_basis,
           v_source_id
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;

    -- load the limit lookup temp table           
    load_limit_lookup(p_measure_id, p_rule_id, v_as_of_date);      
    
   -- get the last load run id
    v_last_load_run_id := pkg_source_load_run.get_last_load_run(p_load_run_id);
    
    -- format static part of insert statement
    v_sql := 
      'insert into limit_exception
      (
       exception_id, 
       source_id, 
       as_of_date, 
       basis, 
       load_run_id, 
       limit_id, 
       limit_version, 
       key, 
       prior_as_of_date, 
       source_fund_id, 
       source_broker_id, 
       source_strategy_id, 
       source_instrument_type_id, 
       sub_strategy, 
       currency, 
       instrument, 
       instrument_id, 
       current_instrument_holding, 
       current_instrument_price_local, 
       current_instrument_value, 
       current_pnl_mtd,
       current_bb_price,
       prior_instrument_holding, 
       prior_instrument_price_local, 
       prior_instrument_value, 
       prior_pnl_mtd, 
       prior_bb_price,
       current_month_notional, 
       daily_pnl_change, 
       validation_measure_value, 
       exception_description, 
       type,
       last_updated_date, 
       last_updated_by, 
       seq_id,
       status,
       comments,
       action_description,
       class,
       resolution_date,
       resolution_description,
       resolution_user
      )
      select sq_limit_exception.nextval exception_id,
             newexception.*,';
       
    -- if there is a prior load run for the same source ,as of date and basis
    -- outer join to limit_exception to see if the new exception should have a status of reopened
    --    if this exception already exists for a prior load run 
    --    set status to TO BE RESOLVED if it the old status was TO BE RESOLVED
    --    set status to RESOLVED if old status was RESOLVED and instrument value is unchanged
    -- else status is NEW
    
    IF v_last_load_run_id IS NOT NULL
    THEN
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               'decode(oldexception.status, null,'''||gc_exception_status_new||''','''||gc_exception_status_tbr||''','''||gc_exception_status_tbr||''','''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,'''||gc_exception_status_resolved||''','''||gc_exception_status_new||'''),'''||gc_exception_status_new||''') status,
                decode(oldexception.status, null, null,'''||gc_exception_status_tbr||''',oldexception.comments,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.comments,null),null) comments,
                decode(oldexception.status, null, null,'''||gc_exception_status_tbr||''',oldexception.action_description,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.action_description,null),null) action_description,
                decode(oldexception.status, null, null,'''||gc_exception_status_tbr||''',oldexception.class,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.class,null),null) class,
                decode(oldexception.status, null, null,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.resolution_date,null),null) resolution_date,
                decode(oldexception.status, null, null,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.resolution_description,null),null) resolution_description,
                decode(oldexception.status, null, null,'''||gc_exception_status_resolved||''',decode(oldexception.current_instrument_value,newexception.current_instrument_value,oldexception.resolution_user,null),null) resolution_user
                from (select load_run_id,
                             as_of_date,
                             source_id,
                             basis,
                             exception_id,
                             limit_id,
                             type,
                             status,
                             current_instrument_value,
                             comments,
                             action_description,
                             class,
                             resolution_date,
                             resolution_description,
                             resolution_user,
                             nvl(source_fund_id,0) source_fund_id,
                             nvl(source_strategy_id,0) source_strategy_id,
                             nvl(key,''NOKEY'') key,
                             nvl(seq_id,0) seq_id
                      from   limit_exception
                      where  '''||v_as_of_date||'''  = as_of_date
                      and   '||v_source_id||'        = source_id
                      and   '||v_last_load_run_id||' = load_run_id) oldexception,
                     (';
    ELSE
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               ''''||gc_exception_status_new||''' status,
               null comments,
               null action_description,
               null class,
               null resolution_date,
               null resolution_description,
               null resolution_user
                from (';
    END IF;    
    
    v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
      'select 
       this.source_id,
       this.as_of_date,
       this.basis,'||
       utl.pkg_constants.gc_cr || 
       p_load_run_id || ',' ||
       utl.pkg_constants.gc_cr || 
       'l.limit_id,
       l.limit_version,
       this.key,
       last.as_of_date prior_as_of_date,
       this.source_fund_id,
       this.source_broker_id,
       this.source_strategy_id,
       this.source_instrument_type_id,
       this.sub_strategy,
       this.currency,
       this.instrument,
       this.instrument_id,
       this.instrument_holding current_instrument_holding,
       this.instrument_price_local current_instrument_price_local,
       this.instrument_value current_instrument_value,
       this.total_pnl_mtd current_pnl_mtd,
       this.bb_price      current_bb_price,
       last.instrument_holding prior_instrument_holding,
       last.instrument_price_local prior_instrument_price_local,
       last.instrument_value prior_instrument_value,
       last.total_pnl_mtd prior_pnl_mtd,
       last.bb_price      prior_bb_price,
       this.ref_notional,
       decode(last.total_pnl_mtd,null,null,this.total_pnl_mtd-last.total_pnl_mtd),';
    
    -- if there is a configured test for a calculation error
    -- format sql to set validation measure to null if test returns an error
    -- in all cases if the denominator is null or zero set the validation measure to null
    IF v_error_test IS NOT NULL
    THEN
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               'decode('||v_error_test||',null,decode('||v_denominator||',null,null,0,null,'||v_numerator || '/' || v_denominator || '),null),';
    ELSE
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               'decode('||v_denominator||',null,null,0,null,'||v_numerator || '/' || v_denominator || '),';
    END IF;
    
    -- if there is a configured test for a calculation error
    -- format sql to set description to show error
    -- in all cases if the denominator is null or zero set the description to show this
    -- if there is no error the description should the the measure name and rule break description concatenated
    
    IF v_error_test IS NOT NULL
    THEN
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               'nvl('||v_error_test||',decode('||v_denominator||',null,''Null denominator'',0,''Zero denominator'',l.break_message)),
                decode('||v_error_test||',null,decode('||v_denominator||',null,'''||gc_exception_type_calc_error||''',0,'''||gc_exception_type_calc_error||''','''||gc_exception_type_limit_break||'''),'''||gc_exception_type_calc_error||''') type,';
    ELSE
      v_sql := v_sql || 
               utl.pkg_constants.gc_cr || 
               'decode('||v_denominator||',null,''Null denominator'',0,''Zero denominator'',l.break_message),
                decode('||v_denominator||',null,'''||gc_exception_type_calc_error||''',0,'''||gc_exception_type_calc_error||''','''||gc_exception_type_limit_break||''') type,';
    END IF;
    
    v_sql := v_sql || 
             utl.pkg_constants.gc_cr || 
             'sysdate,
              vcr.pkg_source_load_run.get_description('||p_load_run_id||'),
              this.seq_id';
              
    -- format from clause element of insert statement

    v_sql := v_sql || utl.pkg_constants.gc_cr || 'from ' ||
             utl.pkg_constants.gc_cr || 
             v_views ||
             utl.pkg_constants.gc_cr || 
             'limit_lookup l';

   -- always select rows in this and last views for this load run and the one before it
    v_sql := v_sql || utl.pkg_constants.gc_cr ||
             'where to_date('''||to_char(v_as_of_date,'DD-MON-YYYY')||''',''dd-MON-yyyy'') = this.as_of_date
              and   '||v_source_id||'      = this.source_id
              and   '''||v_basis||'''      = this.basis
              and   '||v_source_id||'      = last.source_id (+)
              and   '''||v_basis||'''      = last.basis (+)
              and   to_date('''||to_char(pkg_source_load_run.get_last_as_of_date(p_load_run_id),'DD-MON-YYYY')||''',''dd-MON-yyyy'') = last.as_of_date (+)';

    -- add the calculation specific joins to the where clause
    v_sql := v_sql || utl.pkg_constants.gc_cr || v_joins;

    -- if a seperate denominator view is for the current as of date
    -- add the necessary joins (assumption is a thisd row will exist for a this row)
    IF instr(v_views,' thisd,') != 0
    THEN
      v_sql := v_sql || utl.pkg_constants.gc_cr ||
               'and   to_date('''||to_char(v_as_of_date,'DD-MON-YYYY')||''',''dd-MON-yyyy'')  = thisd.as_of_date
                and   '||v_source_id||'       = thisd.source_id
                and   '''||v_basis||'''       = thisd.basis';
    END IF;

    -- if a seperate denominator view is for the last as of date
    -- add the necessary joins(assumption is a lastd row may exist for a this row - therefore an outer join is used)
    IF instr(v_views,' lastd,') != 0
    THEN
      v_sql := v_sql || utl.pkg_constants.gc_cr ||
               'and   '||v_source_id||'         = lastd.source_id (+)
                and   '''||v_basis||'''         = lastd.basis (+)
                and   to_date('''||to_char(pkg_source_load_run.get_last_as_of_date(p_load_run_id),'DD-MON-YYYY')||''',''dd-MON-yyyy'') = lastd.as_of_date (+)';
    END IF;
       
    -- for each limit header parameter defined for the measure rule
    -- join to the aliased limit_header_value
    FOR rec_limit_header_param2 IN cur_limit_header_param(p_measure_id, p_rule_id)                                                   
    LOOP
      v_sql := v_sql ||
               utl.pkg_constants.gc_cr || 
               'and this.'||rec_limit_header_param2.column_name||' = l.header_value_'||rec_limit_header_param2.header_parameter_id;                
    END LOOP;                

    v_sql := v_sql ||
               utl.pkg_constants.gc_cr || 
               'and (';
    -- for each parameter defined for the rule
    -- compare the validation measure value to the parameter value using the configured operator
    FOR rec_limit_rule_param3 IN cur_limit_rule_param(p_rule_id)                                                   
    LOOP
      IF cur_limit_rule_param%ROWCOUNT > 1
      THEN 
            v_sql := v_sql ||
               utl.pkg_constants.gc_cr || 
               'or ';
      END IF;
    -- if there is a configured test for a calculation error
    -- format sql to set validation measure to null if test returns an error
    -- in all cases if the denominator is null or zero set the validation measure to null
      IF v_error_test IS NOT NULL
      THEN
        v_sql := v_sql || 
                 utl.pkg_constants.gc_cr || 
                 '((decode('||v_error_test||',null,decode('||v_denominator||',null,null,0,null,'||v_numerator || '/' || v_denominator || '),null) '||rec_limit_rule_param3.operator||' l.param_value_'||rec_limit_rule_param3.rule_parameter_id||') or 
                   (decode('||v_denominator||',null,1,0,1,0) = 1) or
                   ('||v_error_test||' is not null))';
      ELSE
        v_sql := v_sql || 
                 utl.pkg_constants.gc_cr || 
                 '((decode('||v_denominator||',null,null,0,null,'||v_numerator || '/' || v_denominator || ') '||rec_limit_rule_param3.operator||' l.param_value_'||rec_limit_rule_param3.rule_parameter_id||') or 
                   (decode('||v_denominator||',null,1,0,1,0) = 1))';      
      END IF;
    END LOOP;
    
    v_sql := v_sql ||
             utl.pkg_constants.gc_cr || 
             ')';
    
    -- only select those rows for the defined level of this calculation e.g. specific investment engine
    -- if no calc level is defined select all rows
    
    IF v_calc_level IS NOT NULL
    THEN
        v_sql := v_sql || 
                 utl.pkg_constants.gc_cr ||     
                 'and this.'||v_calc_level||' '||v_level_test;
    END IF;

    -- if there has been an earlier run outer join to limit_exception to see if the same exception has been generated before
    IF v_last_load_run_id IS NOT NULL
    THEN
      v_sql := v_sql ||
               utl.pkg_constants.gc_cr ||
               ') newexception
               where newexception.source_id               = oldexception.source_id (+)
               and newexception.as_of_date                = oldexception.as_of_date (+)
               and newexception.basis                     = oldexception.basis (+)
               and '||v_last_load_run_id||'               = oldexception.load_run_id (+)
               and newexception.limit_id                  = oldexception.limit_id (+)
               and newexception.type                      = oldexception.type (+) 
               and nvl(newexception.source_fund_id,0)     = oldexception.source_fund_id (+)
               and nvl(newexception.source_strategy_id,0) = oldexception.source_strategy_id (+)
               and nvl(newexception.key,''NOKEY'')        = oldexception.key (+)
               and nvl(newexception.seq_id,0)             = oldexception.seq_id (+)';
    ELSE
      v_sql := v_sql ||
               utl.pkg_constants.gc_cr ||
               ') newexception';
    END IF;
   
    -- write sql to log
    utl.pkg_logger.log_debug(v_sql);
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_sql;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;

      RAISE;
  END get_validation_sql;
  
  FUNCTION run_validation_sql(p_sql VARCHAR2) RETURN INTEGER
  AS
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.run_validation_sql',null);
    
    EXECUTE IMMEDIATE p_sql;

    v_count := SQL%ROWCOUNT;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;

      RAISE;
  END run_validation_sql;
  
  -- validates the data for specified load run
  -- against the parameter measure rule calculation
  -- returning the number of exceptions generated
  FUNCTION validate_measure_rule_calc(p_load_run_id IN source_load_run.load_run_id%TYPE, 
                                      p_measure_id IN measure_rule.measure_id%TYPE,
                                      p_rule_id    IN measure_rule.rule_id%TYPE,
                                      p_calc_desc  IN validation_measure_calc.description%TYPE) RETURN INTEGER
  AS
    v_measure_name   validation_measure.name%TYPE;
    v_rule_name      validation_rule.name%TYPE;
    
    v_validation_sql VARCHAR2(32000);
    
    v_count          INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.validate_measure_rule_calc',null);
    
    -- get measure and rule names
    SELECT vr.name
    INTO   v_rule_name
    FROM   validation_rule vr
    WHERE  vr.rule_id = p_rule_id;
  
    SELECT vm.name
    INTO   v_measure_name
    FROM   validation_measure vm
    WHERE  vm.measure_id = p_measure_id;
   
    -- format sql to create limit exception records
    v_validation_sql := get_validation_sql(p_load_run_id, p_measure_id, p_rule_id, p_calc_desc);

    -- run this sql
    v_count := run_validation_sql(v_validation_sql);
    
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Created '||v_count||' exception(s) validating ' || v_measure_name || ' ('||p_calc_desc||') ' || v_rule_name || ' for ' ||
                       pkg_source_load_run.get_description(p_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);
                       
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;

      RAISE;
  END validate_measure_rule_calc;
 
  -- deletes any exceptions created for this load run
  PROCEDURE purge_exceptions(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
   v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.purge_exceptions',null);
    
    DELETE 
    FROM   limit_exception le
    WHERE  le.load_run_id = p_load_run_id;
    
    v_count := SQL%ROWCOUNT;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Purged ' || v_count || ' exception(s) for re-run of ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;
    
      RAISE;
    
  END purge_exceptions;
  
  -- sets the status of any exceptions created for the last load run to CLOSED
  PROCEDURE close_prior_exceptions(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_last_load_run_id source_load_run.load_run_id%TYPE;
    
    v_as_of_date DATE;
    v_source_id  source.source_id%TYPE;
    
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.close_prior_exceptions',null);
    
    v_last_load_run_id := pkg_source_load_run.get_last_load_run(p_load_run_id);
    
    -- if this is not the first run close all the previous runs exceptions that are not marked resolved
    IF v_last_load_run_id IS NOT NULL
    THEN    
      SELECT slr.as_of_date,
             slr.source_id
      INTO   v_as_of_date,
             v_source_id
      FROM   source_load_run slr
      WHERE  load_run_id = v_last_load_run_id;
    
      UPDATE limit_exception le
      SET    le.status            = gc_exception_status_closed,
             le.last_updated_date = sysdate,
             le.last_updated_by   = pkg_source_load_run.get_description(p_load_run_id)
      WHERE  le.load_run_id = v_last_load_run_id
      AND    le.as_of_date  = v_as_of_date
      AND    le.source_id   = v_source_id;
    
      v_count := SQL%ROWCOUNT;
      
      IF v_count > 0
      THEN
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                           'Closed ' || v_count || ' exception(s) from ' ||
                           pkg_source_load_run.get_description(v_last_load_run_id) || ' for ' || 
                           pkg_source_load_run.get_description(p_load_run_id),
                           pkg_source_load_run.gc_log_message_parent_table,
                           p_load_run_id);
      END IF;
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;
    
      RAISE;
    
  END close_prior_exceptions;
  
  -- this procedure creates records in the limit_exception table
  -- by applying the validation measure rules applicable for
  -- the parameter source, basis and as of date
  -- raises the exception utl.pkg_exceptions.e_source_is_loading if the source is already being loaded 

  PROCEDURE validate(p_source_name IN source.source_name%TYPE,
                     p_basis       IN source_basis.basis%TYPE,
                     p_as_of_date  IN DATE)
  AS
    v_load_run_id source_load_run.load_run_id%TYPE;
    
    v_count       INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_validator.validate',null);
    -- get the id of this load run
    v_load_run_id := pkg_source_load_run.get_load_run(p_source_name,
                                                      p_basis,
                                                      p_as_of_date);
  
    IF v_load_run_id IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_load_run_err,
                              'No load run exists for ' || p_source_name ||', '||p_basis||', '||to_char(p_as_of_date,'dd-MON-yyyy'));
    END IF;
    
    pkg_source_load_run_mod.update_status(v_load_run_id,
                                          pkg_source_load_run.gc_run_status_in_progress);           
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Started validation of ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
  
    -- if another load run for the same source is in progress then raise exception e_source_in_progress
    IF pkg_source_load_run.is_source_loading(v_load_run_id)
    THEN
      raise_application_error(utl.pkg_exceptions.gc_source_is_loading_err,
                              'Source ' || p_source_name ||
                              ' is in progress');
    END IF;

    pkg_housekeeping.start_transaction(v_load_run_id);
    
    -- purge any exceptions already created for this load run
    purge_exceptions(v_load_run_id);
    
    -- for each measure rule for this basis retrieve all defined calculations
    FOR rec_measure_rule_calc IN (SELECT sbmr.measure_id, sbmr.rule_id, vmc.description
                                  FROM   source_basis_measure_rule sbmr, validation_measure_calc vmc
                                  WHERE  vmc.measure_id = sbmr.measure_id
                                  AND    sbmr.basis = p_basis)
    LOOP
      -- validate the loaded data for each measure rule calculation
      v_count := v_count + validate_measure_rule_calc(v_load_run_id,
                                                      rec_measure_rule_calc.measure_id,
                                                      rec_measure_rule_calc.rule_id,
                                                      rec_measure_rule_calc.description);
    END LOOP;
    
    -- end transaction
    COMMIT;
  
    -- record against source_load_run number of exceptions generated
    
    pkg_source_load_run_mod.update_no_of_exceptions(v_load_run_id, v_count);
    
    -- set the status of any exceptions for the last load run to CLOSED
    close_prior_exceptions(v_load_run_id);
    
    -- gather stats on the subpartition just populated
    pkg_housekeeping.gather_run_table_stats(v_load_run_id,'limit_exception',null);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Completed validation of ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
                       
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;
    
      pkg_source_load_run_mod.log_sqlerror(v_load_run_id);

      RAISE;
    
  END validate;

END pkg_validator;
/
