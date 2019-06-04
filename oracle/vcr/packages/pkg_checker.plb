CREATE OR REPLACE PACKAGE BODY vcr.pkg_checker AS
  -------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_checker.plb 1.10.1.3 2005/10/18 13:26:48BST apenney DEV  $
  -------------------------------------------------------------------------
  --  A package to perform preliminary post load checks on data loaded from
  --  a source prior to validation process running
  -------------------------------------------------------------------------
  
  -- if any active fund for the source being loaded doesnt have positions in this load
  -- send a notification with a list of funds with missing positions
  PROCEDURE check_active_funds(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
    v_missing_active_funds VARCHAR2(4000);
  
    v_notification_subject VARCHAR2(1000);
    v_notification_message VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.check_active_funds',null);
    
    FOR rec_fund IN (SELECT active_funds.fund
                     FROM   (SELECT DISTINCT sp.fund
                             FROM   source_position sp, source_load_run slr
                             WHERE  slr.load_run_id = p_load_run_id
                             AND    sp.source_id = slr.source_id
                             AND    sp.as_of_date = slr.as_of_date
                             AND    sp.basis = slr.basis
                             AND    sp.load_run_id = p_load_run_id) loaded_funds,
                            (SELECT sf.fund
                             FROM   source_fund sf, source_load_run slr
                             WHERE  slr.load_run_id = p_load_run_id
                             AND    sf.source_id = slr.source_id
                             AND    sf.active_ind = 'Y') active_funds
                     WHERE  active_funds.fund = loaded_funds.fund(+)
                     AND    loaded_funds.fund IS NULL)
    LOOP
      -- generate a list of all the active funds that positions have not been loaded for
      v_missing_active_funds := v_missing_active_funds ||
                                utl.pkg_constants.gc_cr || rec_fund.fund;
    END LOOP;
  
    IF v_missing_active_funds IS NOT NULL
    THEN
      -- send notification to admin team
      v_notification_subject := pkg_source_load_run.get_description(p_load_run_id) ||
                                ' missing active funds';
      v_notification_message := pkg_source_load_run.get_description(p_load_run_id) ||
                                ' does not contain positions for the following active funds:' ||
                                utl.pkg_constants.gc_cr ||
                                utl.pkg_constants.gc_cr ||
                                v_missing_active_funds;
    
      pkg_notifications.notify_admin(v_notification_subject,
                                     v_notification_message,
                                     NULL,
                                     NULL,
                                     p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END check_active_funds;

  -- casts a string to a date, returning null if the string is invalid
  FUNCTION to_date_or_null(p_field IN VARCHAR2, p_format IN VARCHAR2)
    RETURN DATE DETERMINISTIC AS
  BEGIN
    IF is_a_date(p_field, p_format) = 1
    THEN
      RETURN to_date(p_field, p_format);
    ELSE
      RETURN to_date(NULL, p_format);
    END IF;
  END to_date_or_null;
  --  returns false if the parameter string is not a date
  FUNCTION is_a_date(p_field IN VARCHAR2, p_format IN VARCHAR2)
    RETURN INTEGER DETERMINISTIC AS
    v_ignore DATE;
  
  BEGIN
    BEGIN
      v_ignore := to_date(p_field, p_format);
    EXCEPTION
      WHEN OTHERS THEN
        RETURN 0;
    END;
    RETURN 1;
  END is_a_date;

  -- casts a string to a number, returning null if the string is invalid
  FUNCTION to_number_or_null(p_field IN VARCHAR2) RETURN NUMBER DETERMINISTIC AS
  BEGIN
    IF is_a_number(p_field) = 1
    THEN
      RETURN to_number(p_field);
    ELSE
      RETURN to_number(NULL);
    END IF;
  END to_number_or_null;

  --  returns false if the parameter string is not a number
  FUNCTION is_a_number(p_field IN VARCHAR2) RETURN INTEGER DETERMINISTIC AS
    v_ignore NUMBER;
 
  BEGIN
    BEGIN
      v_ignore := to_number(p_field);
    EXCEPTION
      WHEN invalid_number THEN
        RETURN 0;
      WHEN value_error THEN
        RETURN 0;
      WHEN OTHERS THEN
        RAISE;
    END;
    RETURN 1;
  END is_a_number;

  -- executes parameter sql and formats a list of positions which failed the check in question
  FUNCTION get_check_failures(p_check_fields_sql  IN VARCHAR2,
                              p_check_failures    IN OUT CLOB) RETURN INTEGER
  AS
    TYPE ref_cursor IS REF CURSOR;
  
    cur_check_fields ref_cursor;
  
    v_keys     VARCHAR2(4000);
    v_messages VARCHAR2(4000);
    v_file_ids VARCHAR2(4000);
  
    v_position_key     VARCHAR2(4000) := NULL;
    v_position_message VARCHAR2(4000) := NULL;
    v_file_id          VARCHAR2(100)  := NULL;
    
    i                  PLS_INTEGER    := 0;
    
    v_check_failures   VARCHAR2(32000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.get_check_failures',null);
    
    IF gv_max_checks = 0
    THEN
      RETURN 0;
    ELSE
      OPEN cur_check_fields FOR p_check_fields_sql;
    
      LOOP       
        IF i = gv_max_checks
        THEN
          EXIT;
        END IF;
        
        FETCH cur_check_fields INTO v_position_key, v_position_message, v_file_id;
        
        EXIT WHEN cur_check_fields%NOTFOUND;
        
        i := i + 1;
        
        -- if we are near to filling up the varchar append to the clob (for performance reasons)
        IF length(v_check_failures) > 31000
        THEN
          p_check_failures := p_check_failures || v_check_failures;
          
          v_check_failures := null;
        END IF;
               
        v_check_failures :=  v_check_failures || CHR(10) || 'File Id: '||v_file_id||' Position: '|| v_position_key || CHR(10) || v_position_message;                        
      END LOOP;
    
      CLOSE cur_check_fields;
      
      -- append the varchar to the clob for the last and maybe first time 
      p_check_failures := p_check_failures || v_check_failures;
      
      dbms_application_info.set_module(null,null);
      
      RETURN i;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_check_failures;

  -- if any record has an invalid type fields 
  -- send a notification with a list of those records
  PROCEDURE check_inv_type_pos_fields(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
    v_check_fields_sql VARCHAR2(32000) := NULL;
  
    v_problem_positions CLOB := NULL;
  
    v_notification_subject VARCHAR2(1000);
    v_notification_message VARCHAR2(32000);
  
    v_source_id  source_load_run.source_id%TYPE;
    v_as_of_date source_load_run.as_of_date%TYPE;
    v_basis      source_load_run.basis%TYPE;
    
    v_count      INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.check_inv_type_pos_fields',null);
    
    SELECT source_id, basis, as_of_date
    INTO   v_source_id, v_basis, v_as_of_date
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
  
    v_check_fields_sql := 'SELECT sp.key, sp.invalid_type_attributes position_message, sp.file_id ' ||
                          'FROM   source_position sp ' ||
                          'WHERE  sp.load_run_id  = ' || p_load_run_id || ' ' ||
                          'AND	 sp.as_of_date	 = ''' || v_as_of_date ||
                          ''' ' || 'AND	 sp.basis		 = ''' || v_basis ||
                          ''' ' || 'AND	 sp.source_id	 = ' || v_source_id || ' ' ||
                          'AND	 sp.invalid_type_attributes IS NOT NULL';
  
    v_count := get_check_failures(v_check_fields_sql, v_problem_positions);
  
    IF v_count <> 0
    THEN
      -- send notification to admin team
      v_notification_subject := pkg_source_load_run.get_description(p_load_run_id) ||
                                ' invalid type fields';
      v_notification_message := 'The attached file contains '||v_count||' positions from ' ||
                                pkg_source_load_run.get_description(p_load_run_id) ||
                                ' with invalid type fields. A maximum of '||gv_max_checks||
                                ' positions with invalid type fields will be reported';
    
      pkg_notifications.notify_admin(v_notification_subject,
                                     v_notification_message,
                                     REPLACE(v_notification_subject, ' ') ||
                                     '.txt',
                                     v_problem_positions,
                                     p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END check_inv_type_pos_fields;

  -- if any position has an empty mandatory field 
  -- send a notification with a list of those positions

  PROCEDURE check_mand_position_fields(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
    v_null_mand_checks VARCHAR2(32000) := NULL;
    v_ins_type_checks  VARCHAR2(32000) := NULL;
    v_check_fields_sql VARCHAR2(32000) := NULL;
    v_count_sql        VARCHAR2(32000) := NULL;
  
    v_problem_positions CLOB := NULL;
  
    v_notification_subject VARCHAR2(1000);
    v_notification_message VARCHAR2(32000);
  
    v_source_id  source_load_run.source_id%TYPE;
    v_as_of_date source_load_run.as_of_date%TYPE;
    v_basis      source_load_run.basis%TYPE;
    
    v_count       INTEGER := 0;
    v_purge_count INTEGER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.check_mand_position_fields',null);
  
    -- purge counts of mand field failures
    DELETE 
    FROM   source_load_ins_type
    WHERE  load_run_id = p_load_run_id;
    
    v_purge_count := SQL%ROWCOUNT;
      
    IF v_purge_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Purged ' || v_purge_count || ' instrument type counts of mandatory field check failures ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
    
    SELECT source_id, basis, as_of_date
    INTO   v_source_id, v_basis, v_as_of_date
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
  
    FOR rec_ie IN (SELECT ie_id FROM investment_engine)
    LOOP
      v_null_mand_checks := NULL;
    
      -- list all fields and whether they are mandatory or not for the ie, source or instrument types
      FOR rec_null_mand IN (
                            SELECT tc.column_name, decode(ietc.ie_id,null,'N','Y') reqd_for_ie, smo.mandatory_ind reqd_for_source, decode(it_rule.column_name,null,'N','Y') it_rules
                            FROM   target_column tc, 
                                   ie_target_column ietc, 
                                   source_mandatory_override smo, 
                                   (
                                    SELECT DISTINCT smo.column_name
                                    FROM   source_mandatory_override smo, source_instrument_type sit 
                                    WHERE  'INSTRUMENTTYPE'      = smo.source_object_type 
                                    AND    upper(smo.table_name) = 'SOURCE_POSITION'
                                    AND    smo.source_object_id  = sit.source_instrument_type_id 
                                    AND    sit.source_id         = v_source_id 
                                    GROUP BY smo.column_name
                                   ) it_rule
                            WHERE  upper(tc.table_name) = 'SOURCE_POSITION'
                            AND    rec_ie.ie_id         = ietc.ie_id (+)
                            AND    tc.column_name       = ietc.column_name (+)
                            AND    tc.table_name        = ietc.table_name (+)
                            AND    'SOURCE'             = smo.source_object_type (+)
                            AND    v_source_id          = smo.source_object_id (+)
                            AND    tc.column_name       = smo.column_name (+)
                            AND    tc.table_name        = smo.table_name (+)
                            AND    tc.column_name       = it_rule.column_name (+)
                           )
      LOOP      
        IF rec_null_mand.it_rules = 'Y'-- if the field is defined to mandatory or optional for some instrument types
        THEN
          v_ins_type_checks := null;
                
          -- for each instrument type a rule is defined for
          FOR rec_it IN (
                         SELECT sit.instrument_type, smo.mandatory_ind
                         FROM   source_mandatory_override smo, source_instrument_type sit 
                         WHERE  'INSTRUMENTTYPE'      = smo.source_object_type 
                         AND    upper(smo.table_name) = 'SOURCE_POSITION'
                         AND    smo.source_object_id  = sit.source_instrument_type_id 
                         AND    smo.column_name       = rec_null_mand.column_name
                         AND    sit.source_id         = v_source_id
                        )
          LOOP
            IF rec_it.mandatory_ind = 'Y' -- if the field is required for the ins type, check whether it is null or not
            THEN
              v_ins_type_checks := v_ins_type_checks || 
                                    ','''||rec_it.instrument_type||''',decode('||
                                    rec_null_mand.column_name || ',null,''|' ||
                                    rec_null_mand.column_name || '=empty'',null)';
            ELSIF (rec_it.mandatory_ind = 'N' AND rec_null_mand.reqd_for_source = 'Y')
            OR   (rec_it.mandatory_ind = 'N' AND rec_null_mand.reqd_for_ie = 'Y' AND rec_null_mand.reqd_for_source IS NULL)    
            THEN --if the field is optional but required by the source or ie do not check for it
              v_ins_type_checks := v_ins_type_checks || 
                                    ','''||rec_it.instrument_type||''',null';
            END IF;
          END LOOP;
          
          IF v_ins_type_checks IS NOT NULL -- if there are instrument type dependent checks
          THEN
            v_null_mand_checks := v_null_mand_checks || '||decode(sp.instrument_type' || v_ins_type_checks;
                   
            IF rec_null_mand.reqd_for_source = 'Y' -- if the field is required for the source 
            OR (rec_null_mand.reqd_for_ie = 'Y' AND rec_null_mand.reqd_for_source IS NULL) -- or is reqd for the ie and not optional for the source
            THEN
              -- the default is to check if there is no investment type rule
              v_null_mand_checks := v_null_mand_checks || ',decode('||
                                    rec_null_mand.column_name || ',null,''|' ||
                                    rec_null_mand.column_name || '=empty'',null))';
            ELSE
              -- otherwise the default is to do nothing
              v_null_mand_checks := v_null_mand_checks || ',null)';
            END IF;
          ELSE -- otherwise do the check if reqd by ie or source
            IF rec_null_mand.reqd_for_source = 'Y' -- if the field is required for the source 
            OR (rec_null_mand.reqd_for_ie = 'Y' AND rec_null_mand.reqd_for_source IS NULL) -- or is reqd for the ie and not optional for the source
            THEN
              -- the default is to check if there is no investment type rule
              v_null_mand_checks := v_null_mand_checks || '||decode(sp.' ||
                              rec_null_mand.column_name || ',null,''|' ||
                              rec_null_mand.column_name || '=empty'',null)';
            END IF;
          END IF;
        ELSE -- if there no instrument type rules defined
          IF rec_null_mand.reqd_for_source = 'Y' -- if the field is required for the source 
          OR (rec_null_mand.reqd_for_ie = 'Y' AND rec_null_mand.reqd_for_source IS NULL) -- or is reqd for the ie and not optional for the source
          THEN
            v_null_mand_checks := v_null_mand_checks || '||decode(sp.' ||
                              rec_null_mand.column_name || ',null,''|' ||
                              rec_null_mand.column_name || '=empty'',null)';
          END IF;    
        END IF;        
      END LOOP;
    
      v_check_fields_sql := 'SELECT key, substr(position_message,2) position_message, file_id, instrument_type ' || 'FROM ( ' ||
                            'SELECT sp.key, sp.file_id, null' || v_null_mand_checks ||
                            ' position_message, sp.instrument_type ' ||
                            'FROM   source_position sp, source_fund sf ' ||
                            'WHERE  sp.load_run_id  = ' || p_load_run_id || ' ' ||
                            'AND	 sp.as_of_date	 = ''' || v_as_of_date ||
                            ''' ' || 'AND	 sp.basis		 = ''' || v_basis ||
                            ''' ' || 'AND	 sp.source_id	 = ' || v_source_id || ' ' ||
                            'AND	 sp.source_id	 = sf.source_id ' ||
                            'AND	 sp.fund		 = sf.fund ' ||
                            'AND    sf.ie_id        = ''' || rec_ie.ie_id ||
                            ''') WHERE position_message IS NOT NULL';
    
      pkg_source_load_run_mod.update_check_fields_sql(p_load_run_id,
                                                      v_check_fields_sql);
    
      v_count := v_count + get_check_failures(v_check_fields_sql, v_problem_positions);
      
      -- maintain count of check failures by instrument type
      IF v_count <> 0
      THEN
        v_count_sql := 'MERGE INTO source_load_ins_type it USING ' || utl.pkg_constants.gc_cr ||
                       '(SELECT '||p_load_run_id||' load_run_id, instrument_type, SUM(utl.pkg_string.substr_count(position_message,''empty'')) no_of_mand_fields_missing FROM '||utl.pkg_constants.gc_cr ||
                       '('||v_check_fields_sql||') GROUP BY '||p_load_run_id||', instrument_type) new_it '||utl.pkg_constants.gc_cr ||
                       'ON (it.load_run_id = new_it.load_run_id AND it.instrument_type = new_it.instrument_type) '||utl.pkg_constants.gc_cr ||
                       'WHEN MATCHED THEN UPDATE SET it.no_of_mand_fields_missing = it.no_of_mand_fields_missing + new_it.no_of_mand_fields_missing '||utl.pkg_constants.gc_cr ||
                       'WHEN NOT MATCHED THEN INSERT (it.load_run_id, it.instrument_type, it.no_of_mand_fields_missing) VALUES (new_it.load_run_id, new_it.instrument_type, new_it.no_of_mand_fields_missing)';
  
        EXECUTE IMMEDIATE v_count_sql;
        
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Recorded ' || SQL%ROWCOUNT || ' instrument type counts of mandatory field check failures for ' || rec_ie.ie_id || ' ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
      END IF;
    END LOOP;
  
    IF v_count <> 0
    THEN
      -- send notification to admin team
      v_notification_subject := pkg_source_load_run.get_description(p_load_run_id) ||
                                ' mandatory field check failures';
      v_notification_message := 'The attached file contains '||v_count||' positions from ' ||
                                pkg_source_load_run.get_description(p_load_run_id) ||
                                ' with missing mandatory fields. A maximum of '||gv_max_checks||
                                ' positions with missing mandatory fields will be reported for each investment engine.';
    
      pkg_notifications.notify_admin(v_notification_subject,
                                     v_notification_message,
                                     REPLACE(v_notification_subject, ' ') ||
                                     '.txt',
                                     v_problem_positions,
                                     p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END check_mand_position_fields;

  -- perform the preliminary data checks on the positions loaded in a particular load run
  PROCEDURE check_positions(p_load_run_id IN source_load_run.load_run_id%TYPE) 
  AS
    v_load_run_no source_load_run.load_run_no%TYPE;
    
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.check_positions',null);
    
    SELECT load_run_no
    INTO   v_load_run_no
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
  
    -- if this is the scheduled run perform the active funds check
    IF v_load_run_no = 1
    THEN
      check_active_funds(p_load_run_id);
    END IF;
  
    SELECT COUNT(*)
    INTO   v_count
    FROM   file_type ft, source_load_run_file slrf
    WHERE  slrf.load_run_id     = p_load_run_id
    AND    slrf.file_type       = ft.file_type
    AND    upper(ft.check_type) = 'Y';
    
    -- if any file types in this load are gonfiured for type checking
    -- notify of any invalid type fields on each position
    IF v_count > 0
    THEN
      check_inv_type_pos_fields(p_load_run_id);
    END IF;
  
    -- check mandatory fields on each position
    IF utl.pkg_config.get_variable_string(gc_mand_check_yn_cfg_key) = 'Y'
    THEN
      check_mand_position_fields(p_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END check_positions;

  -- perform the post load data checks on the data loaded in target tables(s) for a particular load run
  PROCEDURE check_target_table(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_checker.check_target_table',null);
    
    -- set max number of checks
    gv_max_checks := nvl(utl.pkg_config.get_variable_int(gc_max_checks_cfg_key),gv_max_checks);
    -- for each corresponding target table for the files that have been loaded to the staging area
    -- call the defined post load check procedure passing the load run id
    FOR rec_cp IN (SELECT DISTINCT tt.check_procedure
                   FROM   target_table         tt,
                          source_load_run_file slrf,
                          file_type            ft
                   WHERE  slrf.load_run_id = p_load_run_id
                   AND    slrf.file_type   = ft.file_type
                   AND    ft.table_name    = tt.table_name
                   AND    tt.check_procedure IS NOT NULL)
    LOOP
      -- call each check procedure
      EXECUTE IMMEDIATE 'call ' || rec_cp.check_procedure || '(' ||
                        p_load_run_id || ')';
    END LOOP;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END check_target_table;

END pkg_checker;
/
