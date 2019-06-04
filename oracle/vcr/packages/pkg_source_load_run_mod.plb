CREATE OR REPLACE PACKAGE BODY vcr.pkg_source_load_run_mod AS
  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_source_load_run_mod.plb 1.12.1.2.1.7 2005/10/17 09:39:23BST apenney DEV  $
  ------------------------------------------------------------------------
  --  A package to create and maintain load run data  
  ------------------------------------------------------------------------
  
  -- maintains for the specified load run a concatenated list of the sql statements executed to check 
  -- whether the mandatory fields for the positions investment engine are not null 
  PROCEDURE update_check_fields_sql(p_load_run_id      IN source_load_run.load_run_id%TYPE,
                                    p_check_fields_sql IN source_load_run.check_fields_sql%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.update_check_fields_sql', null);  
    
    UPDATE source_load_run
    SET    check_fields_sql = check_fields_sql || utl.pkg_constants.gc_cr ||
                              p_check_fields_sql
    WHERE  load_run_id = p_load_run_id;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END update_check_fields_sql;

  -- remove any info on loading or checking from a load run (e.g. no of records or sql)
  PROCEDURE clear_info(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.clear_info', null);  
    
    UPDATE source_load_run
    SET    check_fields_sql = NULL
    WHERE  load_run_id = p_load_run_id;
  
    UPDATE source_load_run_file
    SET    load_sql      = NULL,
           no_of_records = NULL
    WHERE  load_run_id = p_load_run_id;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END clear_info;

  -- saves the sql used to load data for a specified load run and file
  PROCEDURE update_load_sql(p_load_run_id IN source_load_run.load_run_id%TYPE,
                            p_file_id     IN source_load_run_file.file_id%TYPE,
                            p_file_type   IN source_load_run_file.file_type%TYPE,
                            p_load_sql    IN source_load_run_file.load_sql%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.update_load_sql', null);
    
    UPDATE source_load_run_file
    SET    load_sql    = p_load_sql
    WHERE  load_run_id = p_load_run_id
    AND    file_id     = p_file_id
    AND    file_type   = p_file_type;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END update_load_sql;

  PROCEDURE update_status(p_load_run_id IN source_load_run.load_run_id%TYPE,
                          p_status      IN source_load_run.status%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.update_status', null);
    
    UPDATE source_load_run
    SET    status = p_status
    WHERE  load_run_id = p_load_run_id;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END update_status;
  
 -- log the handled sql error for a specific load run
  -- sets load run status to ERROR
  PROCEDURE log_sqlerror(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.log_sqlerror', null);
    
    utl.pkg_errorhandler.log_sqlerror(pkg_source_load_run.gc_log_message_parent_table,
                                      p_load_run_id);
  
    update_status(p_load_run_id, pkg_source_load_run.gc_run_status_error);
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END log_sqlerror;
  
  -- log a generic error for a specific load run
  -- sets load run status to ERROR
  PROCEDURE log_error(p_error_code    IN NUMBER,
                      p_error_message IN VARCHAR2,
                      p_load_run_id   IN source_load_run.load_run_id%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.log_error', null);
 
    utl.pkg_errorhandler.log_error(p_error_code,
                                   p_error_message,
                                   pkg_source_load_run.gc_log_message_parent_table,
                                   p_load_run_id);
  
    update_status(p_load_run_id, pkg_source_load_run.gc_run_status_error);
     
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      log_sqlerror(p_load_run_id);
    
      RAISE;
  END log_error;

 -- record the numbers of exceptions created by the validation step of this load run
  PROCEDURE update_no_of_exceptions(p_load_run_id      IN source_load_run.load_run_id%TYPE,
                                    p_no_of_exceptions IN source_load_run.no_of_exceptions%TYPE) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.update_no_of_exceptions', null);
 
    UPDATE source_load_run
    SET    no_of_exceptions = nvl(p_no_of_exceptions, 0)
    WHERE  load_run_id      = p_load_run_id;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END update_no_of_exceptions;
  
  -- record the numbers of records loaded for a specific load run and file
  PROCEDURE update_no_of_records(p_load_run_id   IN source_load_run.load_run_id%TYPE,
                                 p_file_id       IN source_load_run_file.file_id%TYPE,
                                 p_file_type   IN source_load_run_file.file_type%TYPE,
                                 p_no_of_records IN source_load_run_file.no_of_records%TYPE) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.update_no_of_records', null);
 
    UPDATE source_load_run_file
    SET    no_of_records = nvl(p_no_of_records, 0)
    WHERE  load_run_id = p_load_run_id
    AND    file_id     = p_file_id
    AND    file_type   = p_file_type;
  
    COMMIT;
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END update_no_of_records;
  
  -- add a file to a load run  
  PROCEDURE add_file(p_load_run_id      IN source_load_run.load_run_id%TYPE,
                     p_source_file_type IN source_file_type.source_file_type%TYPE,
                     p_file_id          IN source_load_run_file.file_id%TYPE,
                     p_filename         IN source_load_run_file.filename%TYPE,
                     p_pathname         IN source_load_run_file.filename%TYPE,
                     p_reporting_date   IN source_load_run_file.reporting_date%TYPE DEFAULT sysdate) 
  AS
    v_file_type file_type.file_type%TYPE;
    
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.add_file', null);
 
    SELECT file_type 
    INTO   v_file_type
    FROM   source_file_type 
    WHERE  source_file_type = p_source_file_type;
    
    INSERT INTO source_load_run_file
      (load_run_id,
       file_id,
       filename,
       pathname,
       reporting_date,
       file_type)
    VALUES
      (p_load_run_id,
       p_file_id,
       p_filename,
       p_pathname,
       p_reporting_date,
       v_file_type);
  
    COMMIT;
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Added file ' || p_file_id || ' of type '|| v_file_type || ' to ' ||
                       pkg_source_load_run.get_description(p_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);
                       
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      log_sqlerror(p_load_run_id);
    
      RAISE;
  END add_file;

  -- overloaded procedure of function 
  PROCEDURE create_load_run(p_as_of_date  IN DATE,
                           p_source_name IN source.source_name%TYPE,
                           p_basis       IN source_basis.basis%TYPE)
  AS
    v_ignore INTEGER;
  BEGIN
    v_ignore := create_load_run(p_as_of_date, p_source_name, p_basis);
  END;
  
  -- start a load run recording its unique identifiers 
  -- Sets initial status to IN PROGRESS
  FUNCTION create_load_run(p_as_of_date  IN DATE,
                           p_source_name IN source.source_name%TYPE,
                           p_basis       IN source_basis.basis%TYPE) RETURN source_load_run.load_run_id%TYPE 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  
    v_load_run_id source_load_run.load_run_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.create_load_run', null);
    
    INSERT INTO source_load_run
      (load_run_id,
       load_run_no,
       source_id,
       as_of_date,
       basis,
       start_time,
       end_time,
       status)
      SELECT sq_source_load_run.NEXTVAL,
             s.load_run_no + 1,
             s.source_id,
             p_as_of_date,
             upper(p_basis),
             SYSDATE,
             NULL,
             pkg_source_load_run.gc_run_status_in_progress
      FROM   (SELECT s.source_id, MAX(nvl(slr.load_run_no, 0)) load_run_no
              FROM   source_load_run slr, source s
              WHERE  slr.as_of_date(+) = p_as_of_date
              AND    slr.basis (+) = upper(p_basis)
              AND    slr.source_id(+) = s.source_id
              AND    upper(s.source_name) = upper(p_source_name)
              GROUP  BY s.source_id) s;
  
    commit;
    
    v_load_run_id := pkg_source_load_run.get_load_run(upper(p_source_name),
                                                      upper(p_basis),
                                                      p_as_of_date);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Started ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
    
    dbms_application_info.set_module(null, null);

    return v_load_run_id;
  exception
    when others then
      utl.pkg_errorhandler.handle;   
      utl.pkg_errorhandler.log_sqlerror;   
      raise;
  end create_load_run;
  
  -- release funds for a load run
  PROCEDURE release_funds(p_load_run_id IN source_load_run.load_run_id%TYPE,
                          p_ie_id       IN investment_engine.ie_id%TYPE,
                          p_funds       IN VARCHAR2) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    v_count INTEGER :=0;
    
    t_fund_ids dbms_sql.varchar2_table;
    
    v_source_fund_ids  VARCHAR2(500);
    v_fund_names       VARCHAR2(4000);
    v_fund_ids         VARCHAR2(4000);
    
    v_fund             source_fund.fund%TYPE;
    
    cur_ie_platform    utl.global.t_result_set;
    
    v_ie_platform      ie_platform.ie_platform%TYPE;
    v_iep_description  ie_platform.description%TYPE;
    
    v_tbr_error_log      CLOB := null;
    v_resolved_error_log CLOB := null;
    
    v_sql                VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.release_funds', null);
    
    -- lose the comma at the start of the fund id list
    v_source_fund_ids := substr(p_funds,2);
    
    -- get a tableof fund ids
    t_fund_ids := utl.pkg_string.string2varchar2_table(v_source_fund_ids,utl.pkg_constants.gc_comma);
    
    -- for each fund id
    FOR i IN t_fund_ids.FIRST..t_fund_ids.LAST 
    LOOP
 
      -- add the funds name to a comma delimited list
      SELECT fund 
      INTO   v_fund
      FROM   source_fund
      WHERE  source_fund_id = t_fund_ids(i);

      v_fund_ids   := v_fund_ids || ',' || t_fund_ids(i);      
      v_fund_names := v_fund_names || ',' || v_fund;
    END LOOP; 
    
    -- lose leading comma
    v_fund_ids := substr(v_fund_ids,2);
        
    -- set fund as released for this load run
    v_sql :=   'UPDATE source_fund_release sfr
                SET    sfr.released_by = user,
                       sfr.released_on = sysdate
                WHERE  sfr.load_run_id = :1
                AND    sfr.source_fund_id IN ('||v_fund_ids||')
                AND    sfr.released_by IS NULL
                AND    sfr.released_on IS NULL';
      
    EXECUTE IMMEDIATE v_sql USING p_load_run_id;
      
    -- keep a count of funds released
    v_count := SQL%ROWCOUNT;
    
    COMMIT;
    
    -- log the number of funds released    
    IF v_count > 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Released ' || v_count || ' fund(s) from ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    
      -- lose leading comma
      v_fund_names := substr(v_fund_names,2);
  
      -- generate an error log of TBR exceptions for this as of date
      v_tbr_error_log := vcr.pkg_limit_exception.format_ie_error_log(p_load_run_id,
                                                                     null,
                                                                     v_source_fund_ids,
                                                                     p_ie_id,
                                                                     v_fund_names,
                                                                     pkg_validator.gc_exception_status_tbr,
                                                                     0);
      
      -- generate an error log of resolved exceptions for this as of date and the previous four as of dates
      v_resolved_error_log := vcr.pkg_limit_exception.format_ie_error_log(p_load_run_id,
                                                                          null,
                                                                          v_source_fund_ids,
                                                                          p_ie_id,
                                                                          v_fund_names,
                                                                          pkg_validator.gc_exception_status_resolved,
                                                                          4);
      
      -- send an email to the investment engine with logs attached
      pkg_notifications.notify_ie(p_ie_id,
                                  'Funds from ' || pkg_source_load_run.get_description(p_load_run_id)||' released to '||p_ie_id,
                                  'The following funds have been released to '||p_ie_id||':'||utl.pkg_constants.gc_cr||utl.pkg_constants.gc_cr||
                                  replace(v_fund_names,utl.pkg_constants.gc_comma,utl.pkg_constants.gc_cr)||utl.pkg_constants.gc_cr||utl.pkg_constants.gc_cr||
                                  'The attached error log files show To Be Resolved exceptions, and exceptions resolved in the last 5 days',
                                  replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_'||p_ie_id||'_tbr_error_log.xls',
                                  v_tbr_error_log,
                                  p_load_run_id,
                                  replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_'||p_ie_id||'_resolved_error_log.xls',
                                  v_resolved_error_log);
                                  
      OPEN cur_ie_platform FOR 'SELECT DISTINCT sf.ie_platform FROM source_fund sf WHERE  sf.ie_id = :1 AND sf.ie_platform IS NOT NULL AND sf.source_fund_id IN ('||v_source_fund_ids||')' USING p_ie_id;
      
      -- for each ie platform for which funds have been released
      LOOP
        FETCH cur_ie_platform INTO v_ie_platform;
        
        EXIT WHEN cur_ie_platform%NOTFOUND;
        
        v_fund_names := null;
        
        -- generate a comma delimited list of funds released for the ie platform
        FOR i IN t_fund_ids.FIRST..t_fund_ids.LAST 
        LOOP
          BEGIN
            SELECT fund 
            INTO   v_fund
            FROM   source_fund
            WHERE  source_fund_id = t_fund_ids(i)
            AND    ie_id          = p_ie_id
            AND    ie_platform    = v_ie_platform;
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
             EXIT;
           WHEN OTHERS THEN 
             RAISE;
          END;
          
          v_fund_names := v_fund_names || ',' || v_fund;
        END LOOP; 
        
        IF v_fund_names IS NULL
        THEN 
          EXIT;
        END IF;
        
        -- get the platform description
        SELECT iep.description
        INTO   v_iep_description
        FROM   ie_platform iep
        WHERE  iep.ie_id               = p_ie_id
        AND    iep.ie_platform         = v_ie_platform;
        
        v_fund_names := substr(v_fund_names,2);
   
        -- generate an error log of TBR exceptions for this as of date     
        v_tbr_error_log := vcr.pkg_limit_exception.format_ie_error_log(p_load_run_id,
                                                                       v_ie_platform,
                                                                       v_source_fund_ids,
                                                                       p_ie_id,
                                                                       v_fund_names,
                                                                       pkg_validator.gc_exception_status_tbr,
                                                                       0);
                                                                       
        -- generate an error log of resolved exceptions for this as of date and the previous four as of dates
        v_resolved_error_log := vcr.pkg_limit_exception.format_ie_error_log(p_load_run_id,
                                                                            v_ie_platform,
                                                                            v_source_fund_ids,
                                                                            p_ie_id,
                                                                            v_fund_names,
                                                                            pkg_validator.gc_exception_status_resolved,
                                                                            4);
        -- send email with attached logs to ie platform staff
        pkg_notifications.notify_ie_platform(p_ie_id,
                                             v_ie_platform,
                                             v_iep_description ||' funds from ' || pkg_source_load_run.get_description(p_load_run_id)||' released to '||p_ie_id,
                                             'The following '||v_iep_description||' funds have been released to '||p_ie_id||':'||utl.pkg_constants.gc_cr||utl.pkg_constants.gc_cr||
                                             replace(v_fund_names,utl.pkg_constants.gc_comma,utl.pkg_constants.gc_cr)||utl.pkg_constants.gc_cr||utl.pkg_constants.gc_cr||
                                             'The attached error log files show To Be Resolved exceptions, and exceptions resolved in the last 5 days',
                                             replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_'||p_ie_id||'_'||v_ie_platform||'_TBR_error_log.xls',
                                             v_tbr_error_log,
                                             p_load_run_id,
                                             replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_'||p_ie_id||'_'||v_ie_platform||'_resolved_error_log.xls',
                                             v_resolved_error_log);
      END LOOP;
        
      CLOSE cur_ie_platform;
      
      COMMIT;
    END IF;
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      
      IF cur_ie_platform%ISOPEN
      THEN
        CLOSE cur_ie_platform;
      END IF;
      
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident => FALSE);
      
      RAISE;
  END release_funds;
                     
  -- send error log for a load run
  PROCEDURE send_error_log(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    v_tbr_error_log CLOB :=  null;
    
    v_source_id          source_load_run.source_id%TYPE;
    v_as_of_date         source_load_run.as_of_date%TYPE;
    
    v_email_address      source.email_address%TYPE;
    v_secure_message_id  source.secure_message_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.send_error_log', null);
    
    UPDATE source_load_run slr
    SET    slr.vsp_err_log_sent_by = user,
           slr.vsp_err_log_sent_on = sysdate
    WHERE  slr.load_run_id         = p_load_run_id
    RETURNING slr.source_id, slr.as_of_date INTO v_source_id, v_as_of_date;
    
    UPDATE limit_exception le
    SET    le.status                 = pkg_validator.gc_exception_status_resolved,
           le.resolution_date        = sysdate,
           le.resolution_user        = user,
           le.resolution_description = pkg_source_load_run.get_description(p_load_run_id)||' error log sent to source. Exception status set to resolved.',
           le.last_updated_date      = sysdate,
           le.last_updated_by        = user
    WHERE  le.status                 = pkg_validator.gc_exception_status_new
    AND    le.source_id              = v_source_id
    AND    le.as_of_date             = v_as_of_date
    AND    le.load_run_id            = p_load_run_id;
    
    -- generate an error log of TBR exceptions for this load run
    v_tbr_error_log := vcr.pkg_limit_exception.format_source_error_log(p_load_run_id);

    SELECT s.email_address,
           s.secure_message_id
    INTO   v_email_address,
           v_secure_message_id
    FROM   source s
    WHERE  s.source_id = v_source_id;

    IF  v_secure_message_id IS NULL -- if no moveit login defined and there is an email address
    AND v_email_address IS NOT NULL
    THEN
      -- send error log a direct email with attachment
      pkg_notifications.notify_source(v_source_id,
                                      'To be resolved exceptions detected in Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id),
                                      'The attached file contains to be resolved exceptions detected when loading Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id)||'.'||
                                      utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||'This is an automated email sent by Man Investments. Please do not reply to this email. To respond please email '||lower(user)||'@maninvestments.com or '||utl.pkg_config.get_variable_string('vcr.notification.error_log_response')||'.',
                                      replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_error_log.xls',
                                      v_tbr_error_log,
                                      p_load_run_id);
      -- copy admin team
      pkg_notifications.notify_admin('Source error log sent for ' || pkg_source_load_run.get_description(p_load_run_id),
                                     'Source error log email sent by '||user||' with the attached file containing to be resolved exceptions detected when loading Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id),
                                     replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_error_log.xls',
                                     v_tbr_error_log,
                                     p_load_run_id);                                               
    ELSIF v_secure_message_id IS NOT NULL -- if there is a moveit login
    THEN
      -- send error log using secure messaging
      pkg_notifications.notify_source_securely(v_source_id,
                                      'To be resolved exceptions detected in Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id),
                                      'The attached file contains to be resolved exceptions detected when loading Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id)||'.'||
                                      utl.pkg_constants.gc_cr || utl.pkg_constants.gc_cr ||'To respond please email '||lower(user)||'@maninvestments.com or '||utl.pkg_config.get_variable_string('vcr.notification.error_log_response')||'.',
                                      replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_error_log.xls',
                                      v_tbr_error_log,
                                      p_load_run_id);      
      -- copy admin team                                      
      pkg_notifications.notify_admin('Source error log sent for ' || pkg_source_load_run.get_description(p_load_run_id),
                                     'Source error log secure message sent by '||user||' with the attached file containing to be resolved exceptions detected when loading Daily P'||utl.pkg_string.gc_ampersand||'L data for ' || pkg_source_load_run.get_description(p_load_run_id),
                                     replace(pkg_source_load_run.get_description(p_load_run_id),' ')||'_error_log.xls',
                                     v_tbr_error_log,
                                     p_load_run_id);                                              
    ELSE
      RAISE utl.pkg_exceptions.e_no_source_address;
    END IF;  
    
    COMMIT;
    
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       user ||' has sent error log for ' ||
                       pkg_source_load_run.get_description(p_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);
                       
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
            
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident => FALSE);
      
      RAISE;
  END send_error_log;
  
  -- set status of load run to COMPLETE and send any notifications to admin, support and IE staff
  -- the status if the load run must be IN PROGRESS for this to suceed 
  -- if this is the completion of a revalidation then notifications differ slightly
  PROCEDURE set_complete(p_load_run_id IN source_load_run.load_run_id%TYPE,
                         p_reval_ind   IN VARCHAR2 DEFAULT 'N') 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    v_count           INTEGER;
    v_positions_count INTEGER;
    
    v_description VARCHAR2(100);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run_mod.set_complete', null);

    UPDATE source_load_run
    SET    status   = pkg_source_load_run.gc_run_status_complete,
           end_time = SYSDATE
    WHERE  load_run_id = p_load_run_id
    AND    status = pkg_source_load_run.gc_run_status_in_progress;
  
    IF SQL%ROWCOUNT = 1
    THEN
      -- purge previously created release records 
      DELETE source_fund_release sfr WHERE sfr.load_run_id= p_load_run_id;
      
      v_count := SQL%ROWCOUNT;
      
      IF v_count <> 0
      THEN
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                           'Purged ' || v_count || ' fund releases records for ' ||
                           pkg_source_load_run.get_description(p_load_run_id),
                           pkg_source_load_run.gc_log_message_parent_table,
                           p_load_run_id);
      END IF;
      
      -- create fund release records 
      -- one for every fund for which data has been loaded in this run
           
      SELECT SUM(slrf.no_of_records)
      INTO   v_positions_count
      FROM   source_load_run_file slrf
      WHERE  slrf.load_run_id = p_load_run_id;
      
      IF v_positions_count <> 0
      THEN                   
        INSERT 
        INTO   source_fund_release sfr
        (
               sfr.load_run_id,
               sfr.source_fund_id
        )
        SELECT DISTINCT p_load_run_id, sf.source_fund_id
        FROM   source_fund sf, source_load_run slr, source_position sp
        WHERE  slr.load_run_id = p_load_run_id
        AND    slr.as_of_date  = sp.as_of_date
        AND    slr.source_id   = sp.source_id
        AND    slr.basis       = sp.basis
        AND    sp.source_id    = sf.source_id
        AND    sp.fund         = sf.fund
        AND    sp.load_run_id  = p_load_run_id;
      ELSE
        -- or if this is a revalidation
        -- one for every fund for which data has been loaded in all previous runs
        INSERT 
        INTO   source_fund_release sfr
        (
               sfr.load_run_id,
               sfr.source_fund_id
        )
        SELECT DISTINCT p_load_run_id, sf.source_fund_id
        FROM   source_fund sf, source_load_run slr, source_position sp, source_load_run other_slr
        WHERE  slr.load_run_id = p_load_run_id
        AND    slr.as_of_date  = other_slr.as_of_date
        AND    slr.source_id   = other_slr.source_id
        AND    slr.basis       = other_slr.basis
        AND    slr.load_run_no > other_slr.load_run_no
        AND    other_slr.as_of_date = sp.as_of_date
        AND    other_slr.source_id  = sp.source_id
        AND    other_slr.basis      = sp.basis
        AND    sp.source_id         = sf.source_id
        AND    sp.fund              = sf.fund;
      END IF;
      
      v_count := SQL%ROWCOUNT;
      
      IF v_count <> 0
      THEN
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                           'Created ' || v_count || ' fund releases records for ' ||
                           pkg_source_load_run.get_description(p_load_run_id),
                           pkg_source_load_run.gc_log_message_parent_table,
                           p_load_run_id);
      END IF;
      
      COMMIT;
      
      IF p_reval_ind = 'Y'
      THEN 
        v_description := ' revalidation complete';
      ELSE
        v_description := ' processing complete';
      END IF;
      
      pkg_notifications.notify_admin_and_support(pkg_source_load_run.get_description(p_load_run_id) ||
                                                 v_description,
                                                 pkg_source_load_run.get_summary(p_load_run_id),
                                                 NULL,
                                                 NULL,
                                                 p_load_run_id);
                                                 
      FOR rec_ie IN (SELECT DISTINCT nvl(sf.ie_id,'undefined') ie_id
                     FROM   source_fund sf, source_load_run slr, source_position sp
                     WHERE  slr.load_run_id = p_load_run_id
                     AND    slr.as_of_date  = sp.as_of_date
                     AND    slr.source_id   = sp.source_id
                     AND    slr.basis       = sp.basis
                     AND    sp.source_id    = sf.source_id
                     AND    sp.fund         = sf.fund
                     AND    sp.load_run_id  = p_load_run_id)
      LOOP
        IF rec_ie.ie_id != 'undefined'
        THEN
          pkg_notifications.notify_ie(rec_ie.ie_id,
                                      pkg_source_load_run.get_description(p_load_run_id) ||
                                      v_description,
                                      pkg_source_load_run.get_summary(p_load_run_id),
                                      NULL,
                                      NULL,
                                      p_load_run_id);
        END IF;
      END LOOP;
        
      -- send parameter file to Crystal environment to trigger std exception report
      pkg_reports.request_std_exception(p_load_run_id);
      
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         pkg_source_load_run.get_description(p_load_run_id) || v_description,
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    ELSE
      dbms_application_info.set_module(null, null); 
      
      raise_application_error(utl.pkg_exceptions.gc_load_not_in_progress_err,
                              pkg_source_load_run.get_description(p_load_run_id) ||
                              ' is not IN PROGRESS and therefore cannot be set to COMPLETE');
    END IF;
    
    dbms_application_info.set_module(null, null); 
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      utl.pkg_errorhandler.handle;
      log_sqlerror(p_load_run_id);
      
      RAISE;
  END set_complete;

END pkg_source_load_run_mod;
/
