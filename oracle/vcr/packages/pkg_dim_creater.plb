CREATE OR REPLACE PACKAGE BODY vcr.pkg_dim_creater AS

  --------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_dim_creater.plb 1.8.1.2 2005/07/21 14:21:10BST apenney DEV  $
  --------------------------------------------------------------------------
  --  A package to maintain distinct lists of dimensions for loaded source data 
  -- e.g. a distinct list of funds for which positions have been loaded 
  ------------------------------------------------------------------------
  
  -- this procedure adds any new markets that there are positions for in a specific run
  -- it formats and returns a list of the new markets added
  FUNCTION create_markets(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_market_list  VARCHAR2(32000);
    v_new_market_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_markets', null);  

    FOR rec_new_market IN (SELECT DISTINCT sp.market_name, sp.source_id
                            FROM   source_position sp,
                                   source_load_run slr,
                                   source_market  sc
                            WHERE  slr.load_run_id = p_load_run_id
                            AND    sp.as_of_date = slr.as_of_date
                            AND    sp.source_id = slr.source_id
                            AND    sp.basis = slr.basis
                            AND    sp.load_run_id = p_load_run_id
                            AND    sp.source_id = sc.source_id(+)
                            AND    sp.market_name = sc.market_name(+)
                            AND    sp.market_name IS NOT NULL
                            AND    sc.market_name IS NULL)
    LOOP
      INSERT INTO source_market
        (market_name,
         source_id,
         exchange_code,
         change_reason)
      VALUES
        (rec_new_market.market_name,
         rec_new_market.source_id,
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_market_list := v_new_market_list || utl.pkg_constants.gc_cr ||
                            'Market: ' || rec_new_market.market_name;
    
      v_new_market_count := v_new_market_count + 1;
    END LOOP;
  
    IF v_new_market_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_market_count ||
                         ' new markets from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
 
    RETURN v_new_market_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_markets;
  
  -- this procedure adds any new countries that there are positions for in a specific run
  -- it formats and returns a list of the new countries added
  FUNCTION create_countries(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_country_list  VARCHAR2(32000);
    v_new_country_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_countries', null);  

    FOR rec_new_country IN (SELECT DISTINCT sp.country, sp.source_id
                            FROM   source_position sp,
                                   source_load_run slr,
                                   source_country  sc
                            WHERE  slr.load_run_id = p_load_run_id
                            AND    sp.as_of_date = slr.as_of_date
                            AND    sp.source_id = slr.source_id
                            AND    sp.basis = slr.basis
                            AND    sp.load_run_id = p_load_run_id
                            AND    sp.source_id = sc.source_id(+)
                            AND    sp.country = sc.country(+)
                            AND    sp.country IS NOT NULL
                            AND    sc.country IS NULL)
    LOOP
      INSERT INTO source_country
        (country,
         source_id,
         iso_country_code,
         change_reason)
      VALUES
        (rec_new_country.country,
         rec_new_country.source_id,
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_country_list := v_new_country_list || utl.pkg_constants.gc_cr ||
                            'Country: ' || rec_new_country.country;
    
      v_new_country_count := v_new_country_count + 1;
    END LOOP;
  
    IF v_new_country_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_country_count ||
                         ' new countries from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
 
    RETURN v_new_country_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_countries;

  -- this procedure adds any new currencies that there are positions for in a specific run
  -- it formats and returns a list of the new currencies added
  FUNCTION create_currencies(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_currency_list  VARCHAR2(32000);
    v_new_currency_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_currencies', null);  

    FOR rec_new_currency IN (SELECT DISTINCT sp.currency, sp.source_id
                             FROM   source_position sp,
                                    source_load_run slr,
                                    source_currency sc
                             WHERE  slr.load_run_id = p_load_run_id
                             AND    sp.as_of_date = slr.as_of_date
                             AND    sp.source_id = slr.source_id
                             AND    sp.basis = slr.basis
                             AND    sp.load_run_id = p_load_run_id
                             AND    sp.source_id = sc.source_id(+)
                             AND    sp.currency = sc.currency(+)
                             AND    sp.currency IS NOT NULL
                             AND    sc.currency IS NULL)
    LOOP
      INSERT INTO source_currency
        (currency,
         source_id,
         iso_currency_code,
         change_reason)
      VALUES
        (rec_new_currency.currency,
         rec_new_currency.source_id,
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_currency_list := v_new_currency_list || utl.pkg_constants.gc_cr ||
                             'Currency: ' || rec_new_currency.currency;
    
      v_new_currency_count := v_new_currency_count + 1;
    END LOOP;
  
    IF v_new_currency_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_currency_count ||
                         ' new currencies from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);   
 
    RETURN v_new_currency_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_currencies;

  -- this procedure adds any new brokers that there are positions for in a specific run
  -- it formats and returns a list of the new brokers added
  FUNCTION create_brokers(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_broker_list  VARCHAR2(32000);
    v_new_broker_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_brokers', null);  

    FOR rec_new_broker IN (SELECT DISTINCT sp.broker, sp.source_id
                           FROM   source_position sp,
                                  source_load_run slr,
                                  source_broker   sb
                           WHERE  slr.load_run_id = p_load_run_id
                           AND    sp.as_of_date = slr.as_of_date
                           AND    sp.source_id = slr.source_id
                           AND    sp.basis = slr.basis
                           AND    sp.load_run_id = p_load_run_id
                           AND    sp.source_id = sb.source_id(+)
                           AND    sp.broker = sb.broker(+)
                           AND    sp.broker IS NOT NULL
                           AND    sb.broker IS NULL)
    LOOP
      INSERT INTO source_broker
        (source_broker_id,
         broker,
         source_id,
         prime_broker_id,
         change_reason)
      VALUES
        (sq_source_broker.NEXTVAL,
         rec_new_broker.broker,
         rec_new_broker.source_id,
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_broker_list := v_new_broker_list || utl.pkg_constants.gc_cr ||
                           'Broker: ' || rec_new_broker.broker;
    
      v_new_broker_count := v_new_broker_count + 1;
    END LOOP;
  
    IF v_new_broker_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_broker_count ||
                         ' new brokers from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
  
    RETURN v_new_broker_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_brokers;

  -- this procedure adds any new instrument types that there are positions for in a specific run
  -- it formats and returns a list of the new instrument types added
  FUNCTION create_instrument_types(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_ins_type_list  VARCHAR2(32000);
    v_new_ins_type_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_instrument_types', null);  

    FOR rec_new_ins_type IN (SELECT DISTINCT sp.instrument_type,
                                             sp.source_id
                             FROM   source_position        sp,
                                    source_load_run        slr,
                                    source_instrument_type sit
                             WHERE  slr.load_run_id = p_load_run_id
                             AND    sp.as_of_date = slr.as_of_date
                             AND    sp.source_id = slr.source_id
                             AND    sp.basis = slr.basis
                             AND    sp.load_run_id = p_load_run_id
                             AND    sp.source_id = sit.source_id(+)
                             AND    sp.instrument_type =
                                    sit.instrument_type(+)
                             AND    sp.instrument_type IS NOT NULL
                             AND    sit.instrument_type IS NULL)
    LOOP
      INSERT INTO source_instrument_type
        (source_instrument_type_id,
         instrument_type,
         source_id,
         change_reason)
      VALUES
        (sq_source_instrument_type.NEXTVAL,
         rec_new_ins_type.instrument_type,
         rec_new_ins_type.source_id,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_ins_type_list := v_new_ins_type_list || utl.pkg_constants.gc_cr ||
                             'Instrument Type: ' ||
                             rec_new_ins_type.instrument_type;
    
      v_new_ins_type_count := v_new_ins_type_count + 1;
    END LOOP;
  
    IF v_new_ins_type_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_ins_type_count ||
                         ' new instrument types from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
  
    RETURN v_new_ins_type_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_instrument_types;
  
  -- this procedure adds any new strategies that there are positions for in a specific run
  -- it formats and returns a list of the new strategies added
  FUNCTION create_strategies(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_strategy_list  VARCHAR2(32000);
    v_new_strategy_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_strategies', null);  

    FOR rec_new_strategy IN (SELECT DISTINCT sp.fund,
                                             sp.strategy,
                                             sp.source_id
                             FROM   source_position sp,
                                    source_load_run slr,
                                    source_strategy ss
                             WHERE  slr.load_run_id = p_load_run_id
                             AND    sp.as_of_date = slr.as_of_date
                             AND    sp.source_id = slr.source_id
                             AND    sp.basis = slr.basis
                             AND    sp.load_run_id = p_load_run_id
                             AND    sp.source_id = ss.source_id(+)
                             AND    sp.fund = ss.fund(+)
                             AND    sp.strategy = ss.strategy(+)
                             AND    sp.fund IS NOT NULL
                             AND    sp.strategy IS NOT NULL
                             AND    ss.strategy IS NULL)
    LOOP
      INSERT INTO source_strategy
        (source_strategy_id,
         strategy,
         fund,
         source_id,
         me_strategy_id,
         change_reason)
      VALUES
        (sq_source_strategy.NEXTVAL,
         rec_new_strategy.strategy,
         rec_new_strategy.fund,
         rec_new_strategy.source_id,
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_strategy_list := v_new_strategy_list || utl.pkg_constants.gc_cr ||
                             'Strategy: ' || rec_new_strategy.fund || ' ' ||
                             rec_new_strategy.strategy;
    
      v_new_strategy_count := v_new_strategy_count + 1;
    END LOOP;
  
    IF v_new_strategy_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_strategy_count ||
                         ' new strategies from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
 
    RETURN v_new_strategy_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_strategies;
  
  -- this procedure adds any new funds that there are positions for in a specific run
  -- it formats and returns a list of the new funds added
  FUNCTION create_funds(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_new_fund_list  VARCHAR2(32000);
    v_new_fund_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_funds', null);  

    FOR rec_new_fund IN (SELECT DISTINCT sp.fund, sp.source_id
                         FROM   source_position sp,
                                source_load_run slr,
                                source_fund     sf
                         WHERE  slr.load_run_id = p_load_run_id
                         AND    sp.as_of_date = slr.as_of_date
                         AND    sp.source_id = slr.source_id
                         AND    sp.basis = slr.basis
                         AND    sp.load_run_id = p_load_run_id
                         AND    sp.source_id = sf.source_id(+)
                         AND    sp.fund = sf.fund(+)
                         AND    sp.fund IS NOT NULL
                         AND    sf.fund IS NULL)
    LOOP
      INSERT INTO source_fund
        (source_fund_id,
         fund,
         source_id,
         ie_id,
         ie_platform,
         me_fund_id,
         active_ind,
         me_benchmark_fund_id,
         change_reason)
      VALUES
        (sq_source_fund.NEXTVAL,
         rec_new_fund.fund,
         rec_new_fund.source_id,
         NULL,
         NULL,
         NULL,
         'Y',
         NULL,
         'Created by '||pkg_source_load_run.get_description(p_load_run_id));
    
      v_new_fund_list := v_new_fund_list || utl.pkg_constants.gc_cr ||
                         'Fund: ' || rec_new_fund.fund;
    
      v_new_fund_count := v_new_fund_count + 1;
    END LOOP;
  
    IF v_new_fund_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Created ' || v_new_fund_count ||
                         ' new funds from run ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;

    dbms_application_info.set_module(null, null);  
  
    RETURN v_new_fund_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END create_funds;

  -- this procedure creates the dimensions specified for the target table(s) of
  -- the data loaded for the parameter values
  PROCEDURE create_dims(p_source_name IN source.source_name%TYPE,
                        p_basis       IN source_basis.basis%TYPE,
                        p_as_of_date  IN DATE) AS
    v_load_run_id source_load_run.load_run_id%TYPE;
  
    v_this_list    VARCHAR2(32000);
    v_new_dim_list VARCHAR2(32000);
  
    v_notification_subject VARCHAR2(1000);
    v_notification_message VARCHAR2(32000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_dim_creater.create_dims', null);  

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
                       'Started dimension creation for ' ||
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
    
    -- for each dimension for the corresponding target tables for the files that have been loaded 
    -- in this run call the defined dim build procedure passing the load run id
    FOR rec_dbp IN (SELECT DISTINCT ttd.dim_build_procedure
                    FROM   target_table_dimension ttd,
                           source_load_run_file   slrf,
                           file_type              ft
                    WHERE  slrf.load_run_id = v_load_run_id
                    AND    slrf.file_type   = ft.file_type
                    AND    ft.table_name    = ttd.table_name)
    LOOP
      -- call each dimension creation procedure 
      EXECUTE IMMEDIATE 'begin :x := ' || rec_dbp.dim_build_procedure ||
                        '(:y);end;'
        USING OUT v_this_list, IN v_load_run_id;
    
      v_new_dim_list := v_new_dim_list || v_this_list;
    END LOOP;
  
    IF v_new_dim_list IS NOT NULL
    THEN
      -- send notification
      v_notification_subject := pkg_source_load_run.get_description(v_load_run_id) ||
                                ' new dimension values';
      v_notification_message := pkg_source_load_run.get_description(v_load_run_id) ||
                                ' contains the following new dimension values:' ||
                                utl.pkg_constants.gc_cr ||
                                utl.pkg_constants.gc_cr || v_new_dim_list;
    
      pkg_notifications.notify_admin(v_notification_subject,
                                     v_notification_message,
                                     NULL,
                                     NULL,
                                     v_load_run_id);
    END IF;
  
    COMMIT;
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Completed dimension creation for ' ||
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
    
  END create_dims;
END pkg_dim_creater;
/
