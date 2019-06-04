CREATE OR REPLACE PACKAGE BODY vcr.pkg_calculator AS

  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_calculator.plb 1.5 2005/09/28 09:39:24BST apenney DEV  $
  --------------------------------------------------------------------------
  --  A package to perform calculations specific to a target table
  -- e.g. calculate mtd ror for funds based on P&L position data
  ------------------------------------------------------------------------
 
  -- deletes any mtd ror calculations created for the load runs source, as of date and basis
  PROCEDURE purge_mtd_ror(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_source_id           source_load_run.source_id%TYPE;
    v_as_of_date          source_load_run.as_of_date%TYPE;
    v_basis               source_load_run.basis%TYPE;
    
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_calculator.purge_mtd_ror',null);
    
    -- get this load runs as of date, basis, source
    SELECT as_of_date,
           basis,
           source_id
    INTO   v_as_of_date,
           v_basis,
           v_source_id
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
    
    DELETE 
    FROM   calculated_mtd_ror cmr
    WHERE  cmr.source_id      = v_source_id
    AND    cmr.as_of_date     = v_as_of_date
    AND    cmr.basis          = v_basis;
    
    v_count := SQL%ROWCOUNT;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Purged ' || v_count || ' MTD rate of return calculations for ' ||
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
    
  END purge_mtd_ror;
  
 -- calculates the ror for a fund or strategy using the notional
  -- for a particular as of date
  --                  as of date that last ror calculation was for
  --                  notional 
  --                  last notional
  --                  mtd pnl
  --                  daily pnl
  --                  the RoR value for the last as of date
  --                  the RoR value before the notional last changed
  --                  either the latest ror or the ror before the last time the notional changed
  FUNCTION calc_mtd_ror_notional_denom(p_as_of_date     DATE,
                                       p_last_as_of_date DATE,
                                       p_notional       NUMBER,
                                       p_last_notional  NUMBER,
                                       p_mtd_pnl        NUMBER,
                                       p_last_mtd_pnl   NUMBER,
                                       p_last_mtd_ror   NUMBER,
                                       p_change_mtd_ror NUMBER,
                                       p_last_change    CHAR) RETURN NUMBER
  AS
    v_mtd_ror   NUMBER := 0.0;
    v_daily_pnl NUMBER := 0.0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_calculator.calc_mtd_ror_notional_denom', null);

    IF p_as_of_date = utl.pkg_date.get_weekday(to_date(to_char(p_as_of_date,'YYYYMM')||'01','YYYYMMDD'),1)
    OR p_last_mtd_pnl IS NULL
    THEN
      v_daily_pnl := p_mtd_pnl;
    ELSE
      v_daily_pnl := p_mtd_pnl-p_last_mtd_pnl;
    END IF;  
    
    -- if there is no notional return null 
    IF p_notional IS NULL 
    OR p_notional = 0
    THEN
      v_mtd_ror := null;
    ELSE  
      -- if as of date is first weekday in the current month
      -- (when first of mon th is not a weekday or is)
      IF p_as_of_date = utl.pkg_date.check_fwdom(p_as_of_date)
      THEN
        IF p_last_change = 'Y' -- the ror before the last time the notional changed this month is zero
        THEN
          v_mtd_ror := 0;
        ELSE -- the current ror is the mtd pnl over the notional
          v_mtd_ror := p_mtd_pnl/p_notional;
        END IF;
      ELSIF p_last_as_of_date IS NULL -- if we have no previous calculation 
      OR    p_last_as_of_date < to_date(to_char(p_as_of_date,'YYYYMM')||'01','YYYYMMDD') -- or it is for the previous month
      THEN
        IF p_last_change = 'Y'  -- the ror before the last time the notional changed this month is zero
        THEN
          v_mtd_ror := 0;
        ELSE -- the current ror is the mtd pnl over the notional
          v_mtd_ror :=  p_mtd_pnl/p_notional;
        END IF;
      ELSIF p_notional = p_last_notional
      THEN
        IF p_last_mtd_ror IS NULL  -- if the previous calculation didnt work this one wont either - return null
        AND p_change_mtd_ror IS NULL
        THEN
          v_mtd_ror := NULL;
        ELSIF p_last_change = 'Y'  -- the ror before the last time the notional changed is the same as last time
        THEN
          v_mtd_ror := p_change_mtd_ror;
        ELSE -- calculate the new ror using this 
          v_mtd_ror := ((v_daily_pnl/p_notional)*(1 + p_change_mtd_ror))+p_last_mtd_ror;
        END IF;
      ELSE -- the notional has changed
        IF p_last_mtd_ror IS NULL  -- if the previous calculation didnt work this one wont either - return null
        AND p_change_mtd_ror IS NULL
        THEN
          v_mtd_ror := NULL;
        ELSIF p_last_change = 'Y'  -- the ror last time the notional changed is the last ror calculation
        THEN
          v_mtd_ror := p_last_mtd_ror;
        ELSE -- calculate the new ror using this 
          v_mtd_ror := ((1 + (v_daily_pnl/p_notional))*(1 + p_last_mtd_ror))-1;
        END IF;
      END IF;
    END IF;
    
    dbms_application_info.set_module(null, null);  
    
    RETURN v_mtd_ror;
  END calc_mtd_ror_notional_denom;    
    
  -- calculate mtd ror for funds based on P&L position data loaded in a run
  PROCEDURE calculate_mtd_ror(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_source_id           source_load_run.source_id%TYPE;
    v_as_of_date          source_load_run.as_of_date%TYPE;
    v_basis               source_load_run.basis%TYPE;
    
    v_last_as_of_date     DATE;
    
    v_count               INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_calculator.calculate_mtd_ror', null);  

    purge_mtd_ror(p_load_run_id);
    
    -- get this load runs as of date, basis, source
    SELECT as_of_date,
           basis,
           source_id
    INTO   v_as_of_date,
           v_basis,
           v_source_id
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;

    -- get the last as of date
    v_last_as_of_date := pkg_source_load_run.get_last_as_of_date(p_load_run_id);
    
    -- calculate and store ror for funds which use the prior market value denominator method
    INSERT 
    INTO   calculated_mtd_ror cmr
    (
           source_id, 
           as_of_date, 
           basis, 
           source_object_id, 
           source_object_type, 
           value, 
           value_on_notional_change, 
           calculation_error, 
           created_date, 
           created_by
    ) 
    SELECT v_source_id,
           v_as_of_date,
           v_basis,
           source_aod.source_fund_id,
           'FUND',
           decode(source_aod.prior_month_value,null,null,0,null,source_aod.mtd_pnl/source_aod.prior_month_value),
           null, -- not required as no reference is made to the last as of date ror
           decode(source_aod.prior_month_value,null,'Fund value or MTD PnL unknown',0,'Fund value - MTD PnL equals zero',null),
           sysdate,
           pkg_source_load_run.get_description(p_load_run_id)
    FROM   (
            SELECT sf.fund, 
                   sf.source_fund_id,
                   SUM(sp.total_pnl_mtd) mtd_pnl,
                   ABS(SUM(sp.instrument_value-sp.total_pnl_mtd)) prior_month_value
            FROM   source_position sp, source_fund sf, investment_engine ie
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_mkt_val
            GROUP BY sf.fund, sf.source_fund_id
           ) source_aod;
    
    v_count := SQL%ROWCOUNT;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Saved ' || v_count || ' fund MTD rate of return calculations using prior market value denominator for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF; 
      
    -- calculate and store ror for strategies for funds which use the prior market value denominator method
    INSERT 
    INTO   calculated_mtd_ror cmr
    (
           source_id, 
           as_of_date, 
           basis, 
           source_object_id, 
           source_object_type, 
           value, 
           value_on_notional_change, 
           calculation_error, 
           created_date, 
           created_by
    ) 
    SELECT v_source_id,
           v_as_of_date,
           v_basis,
           source_aod.source_strategy_id,
           'STRATEGY',
           decode(source_aod.prior_month_value,null,null,0,null,source_aod.mtd_pnl/source_aod.prior_month_value),
           null, -- not required as no reference is made to the last as of date ror
           decode(source_aod.prior_month_value,null,'Unknown prior month value',0,'Zero prior month value',null),
           sysdate,
           pkg_source_load_run.get_description(p_load_run_id)
    FROM   (
            SELECT ss.fund,
                   ss.strategy, 
                   ss.source_strategy_id,
                   SUM(sp.total_pnl_mtd) mtd_pnl,
                   ABS(SUM(sp.instrument_value-sp.total_pnl_mtd)) prior_month_value
            FROM   source_position sp, 
                   source_fund sf, 
                   source_strategy ss, 
                   investment_engine ie
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    sp.source_id    = ss.source_id
            AND    sp.fund         = ss.fund
            AND    sp.strategy     = ss.strategy
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_mkt_val
            GROUP BY ss.fund, ss.strategy, ss.source_strategy_id
           ) source_aod;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Saved ' || v_count || ' strategy MTD rate of return calculations using prior market value denominator for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF; 
    
   -- calculate and store ror for funds which use the current notional denominator method
    INSERT 
    INTO   calculated_mtd_ror cmr
    (
           source_id, 
           as_of_date, 
           basis, 
           source_object_id, 
           source_object_type, 
           value, 
           value_on_notional_change, 
           calculation_error, 
           created_date, 
           created_by
    ) 
    SELECT v_source_id,
           v_as_of_date,
           v_basis,
           source_aod.source_fund_id,
           'FUND',
           pkg_calculator.calc_mtd_ror_notional_denom(v_as_of_date,
                                                      cmr.as_of_date,
                                                      notional.value,
                                                      last_notional.value,
                                                      source_aod.mtd_pnl,
                                                      source_last_aod.mtd_pnl,
                                                      cmr.value,
                                                      cmr.value_on_notional_change,
                                                      'N'),
           pkg_calculator.calc_mtd_ror_notional_denom(v_as_of_date,
                                                      cmr.as_of_date,
                                                      notional.value,
                                                      last_notional.value,
                                                      source_aod.mtd_pnl,
                                                      source_last_aod.mtd_pnl,
                                                      cmr.value,
                                                      cmr.value_on_notional_change,
                                                      'Y'),
           decode(notional.value, null, 'Unknown Notional',
                                  0,    'Zero Notional',
                                  decode(cmr.value,null,'Previous RoR unknown',null)),
           sysdate,
           pkg_source_load_run.get_description(p_load_run_id)
    FROM   (
            SELECT sf.fund,
                   sf.source_fund_id,
                   sf.me_fund_id,
                   SUM(sp.total_pnl_mtd) mtd_pnl
            FROM   source_position sp, source_fund sf, investment_engine ie
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_notional
            GROUP BY sf.fund, sf.source_fund_id, sf.me_fund_id
           ) source_aod,
           (
            SELECT sf.fund,
                   sf.source_fund_id,
                   sf.me_fund_id,
                   SUM(sp.total_pnl_mtd) mtd_pnl
            FROM   source_position sp, source_fund sf, investment_engine ie
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_last_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    sp.as_of_date   >= utl.pkg_date.get_weekday(to_date(to_char(v_as_of_date,'YYYYMM')||'01','YYYYMMDD'),1)
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_notional
            GROUP BY sf.fund, sf.source_fund_id, sf.me_fund_id
           ) source_last_aod,       
           ref_measure_value  notional,
           ref_measure_value  last_notional,
           calculated_mtd_ror cmr
    WHERE source_aod.me_fund_id               = notional.ref_object_id (+)
    AND   v_as_of_date                        = notional.as_of_date (+)
    AND   pkg_ref_object.gc_notional_vcr_type = notional.measure (+)
    AND   source_aod.me_fund_id               = last_notional.ref_object_id (+)
    AND   v_last_as_of_date                   = last_notional.as_of_date (+)
    AND   pkg_ref_object.gc_notional_vcr_type = last_notional.measure (+)
    AND   v_last_as_of_date                   = cmr.as_of_date (+)
    AND   v_basis                             = cmr.basis (+)
    AND   v_source_id                         = cmr.source_id (+)
    AND   source_aod.source_fund_id           = cmr.source_object_id (+)
    AND   'FUND'                              = cmr.source_object_type (+)
    AND   source_aod.source_fund_id           = source_last_aod.source_fund_id (+);
    
    v_count := SQL%ROWCOUNT;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Saved ' || v_count || ' fund MTD rate of return calculations using current notional denominator for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF; 

   -- calculate and store ror for strategies of funds which use the current notional denominator method
    INSERT 
    INTO   calculated_mtd_ror cmr
    (
           source_id, 
           as_of_date, 
           basis, 
           source_object_id, 
           source_object_type, 
           value, 
           value_on_notional_change, 
           calculation_error, 
           created_date, 
           created_by
    ) 
    SELECT v_source_id,
           v_as_of_date,
           v_basis,
           source_aod.source_strategy_id,
           'STRATEGY',
           pkg_calculator.calc_mtd_ror_notional_denom(v_as_of_date,
                                                      cmr.as_of_date,
                                                      notional.value,
                                                      last_notional.value,
                                                      source_aod.mtd_pnl,
                                                      source_last_aod.mtd_pnl,
                                                      cmr.value,
                                                      cmr.value_on_notional_change,
                                                      'N'),
           pkg_calculator.calc_mtd_ror_notional_denom(v_as_of_date,
                                                      cmr.as_of_date,
                                                      notional.value,
                                                      last_notional.value,
                                                      source_aod.mtd_pnl,
                                                      source_last_aod.mtd_pnl,
                                                      cmr.value,
                                                      cmr.value_on_notional_change,
                                                      'Y'),
           decode(notional.value, null, 'Unknown Notional',
                                  0,    'Zero Notional',
                                  decode(cmr.value,null,'Previous RoR unknown',null)),
           sysdate,
           pkg_source_load_run.get_description(p_load_run_id)
    FROM   (
            SELECT ss.fund, 
                   ss.strategy,
                   ss.source_strategy_id,
                   ss.me_strategy_id,
                   SUM(sp.total_pnl_daily) daily_pnl,
                   SUM(sp.total_pnl_mtd) mtd_pnl
            FROM   source_position sp, source_strategy ss, investment_engine ie, source_fund sf
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = ss.source_id
            AND    sp.fund         = ss.fund
            AND    sp.strategy     = ss.strategy
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_notional
            GROUP BY ss.fund, 
                     ss.strategy,
                     ss.source_strategy_id,
                     ss.me_strategy_id
           ) source_aod,
           (
            SELECT ss.fund, 
                   ss.strategy,
                   ss.source_strategy_id,
                   ss.me_strategy_id,
                   SUM(sp.total_pnl_daily) daily_pnl,
                   SUM(sp.total_pnl_mtd) mtd_pnl
            FROM   source_position sp, source_strategy ss, investment_engine ie, source_fund sf
            WHERE  sp.source_id    = v_source_id
            AND    sp.as_of_date   = v_last_as_of_date
            AND    sp.basis        = v_basis
            AND    sp.source_id    = ss.source_id
            AND    sp.fund         = ss.fund
            AND    sp.strategy     = ss.strategy
            AND    sp.source_id    = sf.source_id
            AND    sp.fund         = sf.fund
            AND    sf.ie_id        = ie.ie_id
            AND    sp.as_of_date   >= utl.pkg_date.get_weekday(to_date(to_char(v_as_of_date,'YYYYMM')||'01','YYYYMMDD'),1)
            AND    ie.ror_calc_denominator = pkg_investment_engine.gc_ror_calc_denom_notional
            GROUP BY ss.fund, 
                     ss.strategy,
                     ss.source_strategy_id,
                     ss.me_strategy_id
           ) source_last_aod,         
           ref_measure_value  notional,
           ref_measure_value  last_notional,
           calculated_mtd_ror cmr
    WHERE source_aod.me_strategy_id           = notional.ref_object_id (+)
    AND   v_as_of_date                        = notional.as_of_date (+)
    AND   pkg_ref_object.gc_notional_vcr_type = notional.measure (+)
    AND   source_aod.me_strategy_id           = last_notional.ref_object_id (+)
    AND   v_last_as_of_date                   = last_notional.as_of_date (+)
    AND   pkg_ref_object.gc_notional_vcr_type = last_notional.measure (+)
    AND   v_last_as_of_date                   = cmr.as_of_date (+)
    AND   v_basis                             = cmr.basis (+)
    AND   v_source_id                         = cmr.source_id (+)
    AND   source_aod.source_strategy_id       = cmr.source_object_id (+)
    AND   'STRATEGY'                          = cmr.source_object_type (+)
    AND   source_aod.source_strategy_id       = source_last_aod.source_strategy_id (+);
    
    v_count := SQL%ROWCOUNT;
      
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Saved ' || v_count || ' strategy MTD rate of return calculations using current notional denominator for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF; 
            
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN    
      utl.pkg_errorhandler.handle;

      RAISE;
  END calculate_mtd_ror;
  
  -- this procedure performs the calculations specified for the target table(s) of
  -- the data loaded for the parameter values
  PROCEDURE calculate(p_source_name IN source.source_name%TYPE,
                      p_basis       IN source_basis.basis%TYPE,
                      p_as_of_date  IN DATE) 
  AS
    v_load_run_id source_load_run.load_run_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_calculator.calculate', null);  

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
                       'Started calculations for ' ||
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
    
    -- for each target table for the files that have been loaded 
    -- in this run call the defined calculation procedure passing the load run id
    FOR rec_cp IN (SELECT DISTINCT tt.calculation_procedure
                    FROM   target_table tt,
                           source_file_type   sft,
                           file_type          ft,
                           source_load_run    slr
                    WHERE  slr.load_run_id = v_load_run_id
                    AND    slr.source_id   = sft.source_id
                    AND    sft.file_type   = ft.file_type
                    AND    ft.table_name    = tt.table_name
                    AND    tt.calculation_procedure IS NOT NULL)
    LOOP
      -- call each dimension creation procedure 
      EXECUTE IMMEDIATE 'begin ' || rec_cp.calculation_procedure ||
                        '(:x);end;'
        USING IN v_load_run_id;
    END LOOP;
  
    COMMIT;
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Completed calculations for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);

    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN    
      ROLLBACK;
      utl.pkg_errorhandler.handle;
      pkg_source_load_run_mod.log_sqlerror(v_load_run_id);

      RAISE;
    
  END calculate;
END pkg_calculator;
/
