CREATE OR REPLACE PACKAGE BODY vcr.pkg_limit_mod AS
-------------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_limit_mod.plb 1.7 2005/10/25 14:27:22BST apenney DEV  $
-------------------------------------------------------------------------------------
-- Allows you to update limit info
  
  PROCEDURE notify_change(p_limit_id      IN limit.limit_id%TYPE,
                          p_limit_version IN limit_version.limit_version%TYPE,
                          p_change        IN VARCHAR2,
                          p_change_reason IN VARCHAR2)
  AS
    v_count  INTEGER;
    v_notify BOOLEAN;       
    
    v_notification_body VARCHAR2(2000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_mod.notify_change',null);
    
    FOR rec_ie IN (
                   SELECT ie_id
                   FROM   investment_engine
                  )
    LOOP
      SELECT COUNT(*)
      INTO   v_count
      FROM   limit_header_value lhv
      WHERE  lhv.limit_id = p_limit_id;
      
      IF v_count > 0 -- if this limit is not common to all data
      THEN   
        SELECT COUNT(*)
        INTO   v_count
        FROM
        (
          SELECT lhv.header_parameter_id
          FROM   limit_header_value lhv, limit_header_parameter lhp
          WHERE  lhv.limit_id            = p_limit_id
          AND    lhv.header_parameter_id = lhp.header_parameter_id
          AND    lhp.column_name         = 'ie_id'
          AND    lhv.value               = rec_ie.ie_id
          UNION
          SELECT lhv.header_parameter_id
          FROM   limit_header_value lhv, limit_header_parameter lhp, source_fund sf
          WHERE  lhv.limit_id            = p_limit_id
          AND    lhv.header_parameter_id = lhp.header_parameter_id
          AND    lhp.column_name         = 'source_fund_id'
          AND    to_number(lhv.value)    = sf.source_fund_id
          AND    sf.ie_id                = rec_ie.ie_id
          UNION
          SELECT lhv.header_parameter_id
          FROM   limit_header_value lhv, limit_header_parameter lhp, ie_instrument_type ieit
          WHERE  lhv.limit_id            = p_limit_id
          AND    lhv.header_parameter_id = lhp.header_parameter_id
          AND    lhp.column_name         = 'ie_instrument_type_id'
          AND    to_number(lhv.value)    = ieit.ie_instrument_type_id
          AND    ieit.ie_id              = rec_ie.ie_id
          UNION
          SELECT lhv.header_parameter_id
          FROM   limit_header_value lhv, limit_header_parameter lhp, source_fund sf, source_strategy ss
          WHERE  lhv.limit_id            = p_limit_id
          AND    lhv.header_parameter_id = lhp.header_parameter_id
          AND    lhp.column_name         = 'source_strategy_id'
          AND    to_number(lhv.value)    = ss.source_strategy_id
          AND    ss.fund                 = sf.fund
          AND    ss.source_id            = sf.source_id
          AND    sf.ie_id                = rec_ie.ie_id
          UNION
          SELECT lhv.header_parameter_id
          FROM   limit_header_value lhv, limit_header_parameter lhp
          WHERE  lhv.limit_id            = p_limit_id
          AND    lhv.header_parameter_id = lhp.header_parameter_id
          AND    lhp.column_name         = 'source_id'
        );
      
        -- and has aheader value that is for this investment engine
        IF v_count > 0
        THEN
          v_notify := TRUE; -- notify
        ELSE
          v_notify := FALSE; -- otherwise dont
        END IF;
      ELSE -- always notify for global limits
        v_notify := TRUE;
      END IF;
      
      IF v_notify
      THEN
        v_notification_body := p_change || utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||
                               'Description:'||utl.pkg_constants.gc_tab||pkg_limit.get_description(p_limit_id) || utl.pkg_constants.gc_cr ||
                               'Version:'||utl.pkg_constants.gc_tab||utl.pkg_constants.gc_tab||pkg_limit.get_version_description(p_limit_id,p_limit_version) || utl.pkg_constants.gc_cr || 
                               'Reason:'||utl.pkg_constants.gc_tab||utl.pkg_constants.gc_tab||p_change_reason;
      
        pkg_notifications.notify_ie(rec_ie.ie_id,
                                    p_change,
                                    v_notification_body);
      END IF;            
    END LOOP;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      ROLLBACK;
      RAISE;    
  END notify_change;
                                                    
  -- update an existing limit
  PROCEDURE update_limit(p_limit_id      IN limit.limit_id%TYPE,
                         p_start_date    IN limit_version.start_date%TYPE,
                         p_rpvalues      IN VARCHAR2,
                         p_change_reason IN limit_version.change_reason%TYPE)
  AS
    v_prev_version limit_version.limit_version%TYPE;
    v_next_version limit_version.limit_version%TYPE;
    
    v_end_date     limit_version.end_date%TYPE;
    v_start_date   limit_version.start_date%TYPE;
    
    t_rpvalues     dbms_sql.varchar2_table;
    
    v_rule_parameter_id limit_param_value.rule_parameter_id%TYPE;
    
    v_units         validation_measure.units%TYPE;
    v_divisor       INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_mod.update_limit',null);
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    IF p_start_date < to_date(to_char(sysdate,'dd-MON-yyyy'),'dd-MON-yyyy')
    THEN
      RAISE utl.pkg_exceptions.e_lim_date;
    END IF;
    
    BEGIN
      SELECT lv.limit_version,
             lv.end_date,
             lv.start_date
      INTO   v_prev_version,
             v_end_date,
             v_start_date
      FROM   limit_version lv
      WHERE  lv.limit_id      = p_limit_id
      AND    lv.limit_version = (SELECT MAX(limit_version) FROM limit_version WHERE limit_id = p_limit_id);
   
      v_next_version := v_prev_version + 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_next_version := 1;
      WHEN OTHERS THEN
        RAISE;
    END;
    
    IF v_prev_version IS NOT NULL -- if there is a previous version
    THEN
      IF v_end_date IS NULL -- that is not closed
      THEN
        -- if new start date less than or equal to old one raise an error
        IF v_start_date >= p_start_date
        THEN
          RAISE utl.pkg_exceptions.e_lim_date;
        END IF;
      
        -- close it
        UPDATE limit_version lv
        SET    lv.end_date      = p_start_date - 1,
               lv.change_reason = p_change_reason
        WHERE  lv.limit_id      = p_limit_id
        AND    lv.limit_version = v_prev_version;
      ELSE
        -- if new start date less than or equal to old end date raise an error
        
        IF v_end_date >= p_start_date
        THEN
          RAISE utl.pkg_exceptions.e_lim_date;
        END IF;
      END IF;
    END IF;
     
    SELECT vm.units
    INTO   v_units
    FROM   validation_measure vm, limit l
    WHERE  vm.measure_id = l.measure_id
    AND    l.limit_id    = p_limit_id;
    
    IF v_units = pkg_ref_object.gc_percentage_vcr_type
    THEN
      v_divisor := 100;
    ELSE
      v_divisor := 1;
    END IF;     
    -- create new version
    INSERT 
    INTO   limit_version
    (
           limit_id,
           limit_version,
           start_date,
           end_date,
           change_reason
    )
    VALUES
    (
          p_limit_id,
          v_next_version,
          p_start_date,
          NULL,
          p_change_reason
    );
      
    -- get a table of rule parameter values
    t_rpvalues := utl.pkg_string.string2varchar2_table(substr(p_rpvalues,2),utl.pkg_constants.gc_comma);
    
    IF t_rpvalues.COUNT <> 0
    THEN
      FOR i IN t_rpvalues.FIRST..t_rpvalues.LAST 
      LOOP
        IF t_rpvalues(i) IS NOT NULL
        THEN
          -- get corresponding rule parameter id
          SELECT vrp.rule_parameter_id
          INTO   v_rule_parameter_id
          FROM   validation_rule_parameter vrp, limit l
          WHERE  vrp.rule_id = l.rule_id
          AND    l.limit_id  = p_limit_id
          AND    vrp.seq_id  = i;
          
          -- create limit parameter value
          INSERT 
          INTO   limit_param_value lpv
          (
                 limit_id,
                 limit_version,
                 rule_parameter_id,
                 value,
                 change_reason
          )
          VALUES
          (
                p_limit_id,
                v_next_version,
                v_rule_parameter_id,
                t_rpvalues(i)/v_divisor,
                p_change_reason
          );
        END IF;
      END LOOP;
    END IF;
    
    COMMIT;
    
    notify_change(p_limit_id, v_next_version, 'Limit Updated By '||user, p_change_reason);
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      ROLLBACK;
      RAISE;
  END update_limit;

  -- close an existing limit
  PROCEDURE close_limit(p_limit_id IN limit.limit_id%TYPE,
                        p_end_date IN limit_version.start_date%TYPE,
                        p_change_reason IN limit_version.change_reason%TYPE)
  AS 
    v_limit_version limit_version.limit_version%TYPE; 
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_mod.close_limit',null);
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;    
    
    IF p_end_date < to_date(to_char(sysdate,'dd-MON-yyyy'),'dd-MON-yyyy')
    THEN
      RAISE utl.pkg_exceptions.e_lim_date;
    END IF;    
    
    BEGIN
      SELECT MAX(limit_version) 
      INTO   v_limit_version
      FROM   limit_version 
      WHERE  limit_id = p_limit_id;
      
      -- close it
      UPDATE limit_version lv
      SET    lv.end_date      = p_end_date,
             lv.change_reason = p_change_reason
      WHERE  lv.limit_id      = p_limit_id
      AND    lv.limit_version = v_limit_version
      AND    lv.end_date      IS NULL;            
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE utl.pkg_exceptions.e_lim_close;
      WHEN OTHERS THEN
        RAISE;
    END;
   
    COMMIT;
    
    notify_change(p_limit_id, v_limit_version, 'Limit Closed By '||user, p_change_reason);
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN     
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      
      ROLLBACK;    
      RAISE;
  END close_limit;  

  -- loads a new limit based on a textual set of header values
  FUNCTION load_limit(p_measure_rule_id IN VARCHAR2,
                      p_start_date    IN limit_version.start_date%TYPE,
                      p_hvalues       IN VARCHAR2,
                      p_rpvalues      IN VARCHAR2) RETURN VARCHAR2
  AS
    t_hvalues  dbms_sql.varchar2_table; 
  
    t_rpvalues dbms_sql.varchar2_table;
    
    t_hvalue_ids  dbms_sql.varchar2_table;    

    v_rule_parameter_id   limit_param_value.rule_parameter_id%TYPE;
    v_header_parameter_id limit_header_value.header_parameter_id%TYPE;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;    
    v_limit_id      limit.limit_id%TYPE;
    
    v_units         validation_measure.units%TYPE;
    v_divisor       INTEGER;
        
    v_existing_hvalues VARCHAR2(1000);
    v_hvalue_ids       VARCHAR2(1000):=null;
    v_hvalue_id        VARCHAR2(100);
    
    j               INTEGER:=0;
    
    e_invalid_limit_header EXCEPTION;
    
    v_change_reason VARCHAR2(100) := 'Limit Data Load';
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_mod.load_limit',null);

    IF p_measure_rule_id IS NULL
    OR p_start_date is null
    OR p_rpvalues IS NULL
    THEN    
      RETURN 'Failed to create limit due to incomplete parameters: '||p_measure_rule_id||' '||p_start_date||' '||p_hvalues||' '||p_rpvalues;
    END IF;
    
    BEGIN
      v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
      v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
      
      IF p_hvalues IS NOT NULL
      THEN
        -- get a table of header parameter values
        t_hvalues := utl.pkg_string.string2varchar2_table(p_hvalues,utl.pkg_constants.gc_comma);   
    
        FOR rec_header_param IN (
                                 SELECT lhp.column_name
                                 FROM   measure_rule_limit_head_param mrlhp, limit_header_parameter lhp
                                 WHERE  mrlhp.header_parameter_id = lhp.header_parameter_id
                                 AND    mrlhp.measure_id          = v_measure_id
                                 AND    mrlhp.rule_id             = v_rule_id
                                )
        LOOP     
          j := j + 1;
          
          IF rec_header_param.column_name = 'ie_instrument_type_id'
          THEN
            BEGIN
              SELECT to_char(ie_instrument_type_id)
              INTO   v_hvalue_id
              FROM   ie_instrument_type ieit
              WHERE  ieit.ie_id              = substr(t_hvalues(j),1,instr(t_hvalues(j),':')-1)
              AND    ieit.ie_instrument_type = substr(t_hvalues(j),instr(t_hvalues(j),':')+1);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   RAISE e_invalid_limit_header;
              WHEN OTHERS THEN RAISE;
            END;
          ELSIF rec_header_param.column_name = 'source_fund_id'
          THEN
            BEGIN
              SELECT to_char(source_fund_id)
              INTO   v_hvalue_id
              FROM   source_fund sf, source s
              WHERE  s.source_name           = substr(t_hvalues(j),1,instr(t_hvalues(j),':')-1)
              AND    sf.fund                 = substr(t_hvalues(j),instr(t_hvalues(j),':')+1)
              AND    sf.source_id            = s.source_id;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   RAISE e_invalid_limit_header;
              WHEN OTHERS THEN RAISE;
            END;
          ELSIF rec_header_param.column_name = 'source_id'
          THEN
            BEGIN
              SELECT to_char(source_id)
              INTO   v_hvalue_id
              FROM   source s
              WHERE  s.source_name = t_hvalues(j);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   RAISE e_invalid_limit_header;
              WHEN OTHERS THEN RAISE;
            END;
          ELSIF rec_header_param.column_name = 'ie_id'
          THEN
            BEGIN
              SELECT ie_id
              INTO   v_hvalue_id
              FROM   investment_engine ie
              WHERE  ie.ie_id = t_hvalues(j);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                   RAISE e_invalid_limit_header;
              WHEN OTHERS THEN RAISE;
            END;
          ELSE
            RAISE e_invalid_limit_header;
          END IF;  
          
          v_hvalue_ids := v_hvalue_ids || ',' || v_hvalue_id;
        END LOOP;
      END IF;
      
      FOR rec_existing_limit IN (SELECT limit_id
                                 FROM   limit l
                                 WHERE  l.measure_id = v_measure_id
                                 AND    l.rule_id    = v_rule_id)
      LOOP
        v_existing_hvalues := null;
        
        FOR rec_existing_limit_hv IN (SELECT lhv.value
                                      FROM   limit_header_value lhv
                                      WHERE  lhv.limit_id = rec_existing_limit.limit_id
                                      ORDER BY lhv.header_parameter_id)
        LOOP
          v_existing_hvalues := v_existing_hvalues || ',' || rec_existing_limit_hv.value;
        END LOOP;   
        
        IF v_hvalue_ids = v_existing_hvalues
        OR (v_hvalue_ids IS NULL AND v_existing_hvalues IS NULL)
        THEN
          RAISE utl.pkg_exceptions.e_lim_duplicate;
        END IF;  
      END LOOP;  
                                      
      -- create the limit
      INSERT 
      INTO   limit l
      (
             limit_id,
             measure_id,
             rule_id,
             change_reason
      )
      VALUES
      (
            sq_limit.nextval,
            v_measure_id,
            v_rule_id,
            v_change_reason
      )
      RETURNING l.limit_id INTO v_limit_id;
  
      -- get a table of header parameter ids
      t_hvalue_ids := utl.pkg_string.string2varchar2_table(substr(v_hvalue_ids,2),utl.pkg_constants.gc_comma);   
      
      IF t_hvalue_ids.COUNT <> 0
      THEN
        FOR i IN t_hvalue_ids.FIRST..t_hvalue_ids.LAST 
        LOOP
          IF t_hvalue_ids(i) IS NOT NULL
          THEN
            -- get corresponding header parameter id
            SELECT header_parameter_id
            INTO   v_header_parameter_id
            FROM   (
                    SELECT rownum seq,
                           header_parameter_id
                    FROM   measure_rule_limit_head_param mrlhp
                    WHERE  mrlhp.measure_id = v_measure_id
                    AND    mrlhp.rule_id    = v_rule_id
                    ORDER BY header_parameter_id
                   )
            WHERE seq = i;
                     
            -- create header value
            INSERT 
            INTO   limit_header_value lhv
            (
                   limit_id,
                   header_parameter_id,
                   value,
                   change_reason
            )
            VALUES
            (
                  v_limit_id,
                  v_header_parameter_id,
                  t_hvalue_ids(i),
                  v_change_reason
            );
          END IF;
        END LOOP;
      END IF;
      
      SELECT vm.units
      INTO   v_units
      FROM   validation_measure vm
      WHERE  vm.measure_id = v_measure_id;
      
      IF v_units = pkg_ref_object.gc_percentage_vcr_type
      THEN
        v_divisor := 100;
      ELSE
        v_divisor := 1;
      END IF;  
        
      -- create first version
      INSERT 
      INTO   limit_version
      (
             limit_id,
             limit_version,
             start_date,
             end_date,
             change_reason
      )
      VALUES
      (
            v_limit_id,
            1,
            p_start_date,
            NULL,
            v_change_reason
      );
        
      -- get a table of rule parameter values
      t_rpvalues := utl.pkg_string.string2varchar2_table(p_rpvalues,utl.pkg_constants.gc_comma);
      
      IF t_rpvalues.COUNT <> 0
      THEN
        FOR i IN t_rpvalues.FIRST..t_rpvalues.LAST 
        LOOP
          IF t_rpvalues(i) IS NOT NULL
          THEN
            -- get corresponding rule parameter ids
            SELECT vrp.rule_parameter_id
            INTO   v_rule_parameter_id
            FROM   validation_rule_parameter vrp
            WHERE  vrp.rule_id = v_rule_id
            AND    vrp.seq_id  = i;
            
            -- create each param value
            INSERT 
            INTO   limit_param_value lpv
            (
                   limit_id,
                   limit_version,
                   rule_parameter_id,
                   value,
                   change_reason
            )
            VALUES
            (
                  v_limit_id,
                  1,
                  v_rule_parameter_id,
                  t_rpvalues(i)/v_divisor,
                  v_change_reason
            );
          END IF;
        END LOOP;
      END IF;
    EXCEPTION
      WHEN e_invalid_limit_header THEN
        RETURN 'Failed to create limit due to invalid header values: '||pkg_limit.get_measure_description(v_measure_id)|| ' '||pkg_limit.get_rule_description(v_rule_id)|| ' ' ||p_hvalues;
        
      WHEN utl.pkg_exceptions.e_lim_duplicate THEN
        RETURN 'Failed to create limit - limit already exists: '||pkg_limit.get_measure_description(v_measure_id)|| ' '||pkg_limit.get_rule_description(v_rule_id)|| ' ' ||p_hvalues;       

      WHEN OTHERS THEN RAISE;
    END;
      
    dbms_application_info.set_module(null,null);
    
    RETURN 'Created limit: '||pkg_limit.get_description(v_limit_id) || ' ' || pkg_limit.get_version_values(v_limit_id,1);
  EXCEPTION
    WHEN OTHERS THEN   
      RAISE;
  END load_limit;
  
  -- add a limit
  PROCEDURE add_limit(p_measure_rule_id IN VARCHAR2,
                      p_start_date    IN limit_version.start_date%TYPE,
                      p_hvalues       IN VARCHAR2,
                      p_rpvalues      IN VARCHAR2,
                      p_change_reason IN limit_version.change_reason%TYPE)
  AS
    t_hvalues  dbms_sql.varchar2_table;    
    t_rpvalues dbms_sql.varchar2_table;
    
    v_rule_parameter_id   limit_param_value.rule_parameter_id%TYPE;
    v_header_parameter_id limit_header_value.header_parameter_id%TYPE;
    
    v_measure_id    validation_measure.measure_id%TYPE;
    v_rule_id       validation_rule.rule_id%TYPE;    
    v_limit_id      limit.limit_id%TYPE;
    
    v_units         validation_measure.units%TYPE;
    v_divisor       INTEGER;
        
    v_existing_hvalues VARCHAR2(1000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_mod.add_limit',null);
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;    

    IF p_start_date < to_date(to_char(sysdate,'dd-MON-yyyy'),'dd-MON-yyyy')
    THEN
      RAISE utl.pkg_exceptions.e_lim_date;
    END IF;
    
    v_measure_id := substr(p_measure_rule_id, 1, instr(p_measure_rule_id,':')-1);
    v_rule_id    := substr(p_measure_rule_id, instr(p_measure_rule_id,':')+1);
    -- get a table of header parameter values
    t_hvalues := utl.pkg_string.string2varchar2_table(substr(p_hvalues,2),utl.pkg_constants.gc_comma);   

    FOR rec_existing_limit IN (SELECT limit_id
                               FROM   limit l
                               WHERE  l.measure_id = v_measure_id
                               AND    l.rule_id    = v_rule_id)
    LOOP
      v_existing_hvalues := null;
      
      FOR rec_existing_limit_hv IN (SELECT lhv.value
                                    FROM   limit_header_value lhv
                                    WHERE  lhv.limit_id = rec_existing_limit.limit_id
                                    ORDER BY lhv.header_parameter_id)
      LOOP
        v_existing_hvalues := v_existing_hvalues || ',' || rec_existing_limit_hv.value;
      END LOOP;   
      
      IF p_hvalues = v_existing_hvalues
      OR (p_hvalues IS NULL AND v_existing_hvalues IS NULL)
      THEN
        RAISE utl.pkg_exceptions.e_lim_duplicate;
      END IF;  
    END LOOP;  
                                    
    -- create the limit
    INSERT 
    INTO   limit l
    (
           limit_id,
           measure_id,
           rule_id,
           change_reason
    )
    VALUES
    (
          sq_limit.nextval,
          v_measure_id,
          v_rule_id,
          p_change_reason
    )
    RETURNING l.limit_id INTO v_limit_id;

    IF t_hvalues.COUNT <> 0
    THEN
      FOR i IN t_hvalues.FIRST..t_hvalues.LAST 
      LOOP
        IF t_hvalues(i) IS NOT NULL
        THEN
          -- get corresponding header parameter id
          SELECT header_parameter_id
          INTO   v_header_parameter_id
          FROM   (
                  SELECT rownum seq,
                         header_parameter_id
                  FROM   measure_rule_limit_head_param mrlhp
                  WHERE  mrlhp.measure_id = v_measure_id
                  AND    mrlhp.rule_id    = v_rule_id
                  ORDER BY header_parameter_id
                 )
          WHERE seq = i;
                   
          -- create header value
          INSERT 
          INTO   limit_header_value lhv
          (
                 limit_id,
                 header_parameter_id,
                 value,
                 change_reason
          )
          VALUES
          (
                v_limit_id,
                v_header_parameter_id,
                t_hvalues(i),
                p_change_reason
          );
        END IF;
      END LOOP;
    END IF;
    
    SELECT vm.units
    INTO   v_units
    FROM   validation_measure vm
    WHERE  vm.measure_id = v_measure_id;
    
    IF v_units = pkg_ref_object.gc_percentage_vcr_type
    THEN
      v_divisor := 100;
    ELSE
      v_divisor := 1;
    END IF;  
      
    -- create first version
    INSERT 
    INTO   limit_version
    (
           limit_id,
           limit_version,
           start_date,
           end_date,
           change_reason
    )
    VALUES
    (
          v_limit_id,
          1,
          p_start_date,
          NULL,
          p_change_reason
    );
      
    -- get a table of rule parameter values
    t_rpvalues := utl.pkg_string.string2varchar2_table(substr(p_rpvalues,2),utl.pkg_constants.gc_comma);
    
    IF t_rpvalues.COUNT <> 0
    THEN
      FOR i IN t_rpvalues.FIRST..t_rpvalues.LAST 
      LOOP
        IF t_rpvalues(i) IS NOT NULL
        THEN
          -- get corresponding rule parameter ids
          SELECT vrp.rule_parameter_id
          INTO   v_rule_parameter_id
          FROM   validation_rule_parameter vrp
          WHERE  vrp.rule_id = v_rule_id
          AND    vrp.seq_id  = i;
          
          -- create each param value
          INSERT 
          INTO   limit_param_value lpv
          (
                 limit_id,
                 limit_version,
                 rule_parameter_id,
                 value,
                 change_reason
          )
          VALUES
          (
                v_limit_id,
                1,
                v_rule_parameter_id,
                t_rpvalues(i)/v_divisor,
                p_change_reason
          );
        END IF;
      END LOOP;
    END IF;
    
    COMMIT;
    
    notify_change(v_limit_id, 1, 'Limit Added By '||user, p_change_reason);    
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      ROLLBACK;
      RAISE;
  END add_limit;
  
END pkg_limit_mod;
/
