CREATE OR REPLACE PACKAGE BODY vcr.pkg_source_load_run AS
  ------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_source_load_run.plb 1.17.1.2.1.5 2005/10/03 07:39:02BST apenney DEV  $
  ------------------------------------------------------------------------
  -- Provides routines to obtain information on source load runs 
  ------------------------------------------------------------------------

  -- get the as of date of the last complete load run for the same source and basis
  -- return null if there is no previous run
  FUNCTION get_last_as_of_date(p_load_run_id IN source_load_run.load_run_id%TYPE) RETURN DATE
  AS
    v_last_as_of_date DATE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_last_as_of_date',null);
    
    SELECT MAX(lastrun.as_of_date)
    INTO   v_last_as_of_date
    FROM   source_load_run thisrun, source_load_run lastrun
    WHERE  thisrun.load_run_id   = p_load_run_id
    AND    thisrun.source_id     = lastrun.source_id
    AND    thisrun.basis         = lastrun.basis
    AND    thisrun.as_of_date    > lastrun.as_of_date
    AND    lastrun.status        = gc_run_status_complete;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_last_as_of_date;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;

      RAISE;
  END get_last_as_of_date;
  
  -- get the id of the previous complete load run to this one if it exists (otherwise return NULL)
  -- for the current runs as of date, source and basis
  FUNCTION get_last_load_run(p_load_run_id IN source_load_run.load_run_id%TYPE) RETURN NUMBER
  AS
    v_last_load_run_id source_load_run.load_run_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_last_load_run',null);
    
    SELECT lastrun.load_run_id
    INTO   v_last_load_run_id
    FROM   source_load_run thisrun, source_load_run lastrun
    WHERE  thisrun.load_run_id   = p_load_run_id
    AND    thisrun.source_id     = lastrun.source_id (+)
    AND    thisrun.as_of_date    = lastrun.as_of_date (+)
    AND    thisrun.basis         = lastrun.basis (+)
    AND    thisrun.load_run_no-1 = lastrun.load_run_no (+)
    AND    gc_run_status_complete = lastrun.status (+);
    
    dbms_application_info.set_module(null,null);    
    
    RETURN v_last_load_run_id;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;

      RAISE;
  END get_last_load_run;

  ----------------------------------------------------------------------------------
  -- generates a summary of a source load run for completion/status notifications
  ----------------------------------------------------------------------------------
  FUNCTION get_summary(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_summary VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_summary',null);
    
    SELECT 'Run:'|| utl.pkg_constants.gc_tab ||utl.pkg_constants.gc_tab||utl.pkg_constants.gc_tab || get_description(slr.load_run_id) ||
           utl.pkg_constants.gc_cr || 'Status:' || utl.pkg_constants.gc_tab ||
           utl.pkg_constants.gc_tab ||
           utl.pkg_config.get_variable_string('vcr.runstatus.' ||
                                              slr.status) ||
           utl.pkg_constants.gc_cr || 'Started:' ||
           utl.pkg_constants.gc_tab || utl.pkg_constants.gc_tab ||
           to_char(slr.start_time, 'dd-MON-yyyy hh24:mi:ss') ||
           utl.pkg_constants.gc_cr || 'Ended:' || utl.pkg_constants.gc_tab ||
           utl.pkg_constants.gc_tab ||
           to_char(slr.end_time, 'dd-MON-yyyy hh24:mi:ss') ||
           utl.pkg_constants.gc_cr || 'Files Loaded:' ||
           utl.pkg_constants.gc_tab || nvl(COUNT(slrf.file_id),0) ||
           utl.pkg_constants.gc_cr || 'Files Expected:' ||
           utl.pkg_constants.gc_tab || nvl(sft.no_of_files,0) ||
           utl.pkg_constants.gc_cr || 'Records Loaded:' ||
           utl.pkg_constants.gc_tab || SUM(nvl(slrf.no_of_records, 0)) ||
           utl.pkg_constants.gc_cr || 'Exceptions:' ||
           utl.pkg_constants.gc_tab||utl.pkg_constants.gc_tab || nvl(slr.no_of_exceptions,0)
    INTO   v_summary
    FROM   source_load_run slr, source_load_run_file slrf, 
           (
            SELECT   source_id, SUM(no_of_files) no_of_files
            FROM     source_file_type
            GROUP BY source_id
           ) sft
    WHERE  slr.load_run_id = p_load_run_id
    AND    slr.load_run_id = slrf.load_run_id (+) 
    AND    slr.source_id   = sft.source_id (+)
    GROUP BY slr.start_time, slr.end_time, slr.status, slr.load_run_id, sft.no_of_files, slr.no_of_exceptions;
  
    dbms_application_info.set_module(null,null);
  
    RETURN v_summary;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END;

  -- send notification of files in data directory
  PROCEDURE send_data_file_list
  AS
    v_message CLOB;
        
    t_file utl.t_varchar2;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.send_data_file_list',null);
    
    t_file := scheduler.scheduler_gui.get_data_file_table(null);
    
    FOR i IN t_file.FIRST .. t_file.LAST
    LOOP     
      v_message := v_message || utl.pkg_constants.gc_cr || t_file(i);
    END LOOP;
    
    IF v_message IS NOT NULL
    THEN
      pkg_notifications.notify_admin('Unprocessed File Notification',
                                     'The files listed in the attachment have not been processed by VCR. If any of these files are for a previous as of date and should be loaded into VCR, or if any should be archived, please contact the Helpdesk.',
                                     'vcr-unprocessfilelist.txt',
                                     v_message);
    END IF;
                                                                         
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      utl.pkg_errorhandler.log_sqlerror;
    
      RAISE;
  END send_data_file_list;
  
  -- for p_basis and p_as_of_date formats and sends a notification to all investment engine staff
  -- summarising the status of the latest loads for all sources
  PROCEDURE send_status_update(p_basis      IN source_basis.basis%TYPE,
                               p_as_of_date IN source_load_run.as_of_date%TYPE) AS
    v_message VARCHAR2(4000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.send_status_update',null);
    
    FOR rec_load_run IN (SELECT utl.pkg_constants.gc_cr ||
                                get_summary(slr.load_run_id) ||
                                utl.pkg_constants.gc_cr summary
                         FROM   source_load_run slr, source s
                         WHERE  slr.load_run_id =
                                get_load_run(s.source_name,
                                             p_basis,
                                             p_as_of_date))
    LOOP
      v_message := v_message || rec_load_run.summary;
    END LOOP;
    
    IF v_message is null
    THEN
      v_message := utl.pkg_constants.gc_cr || 'No data has been loaded for this as of date and basis.';
    END IF;
      
    pkg_notifications.notify_ie('%',
                                'Source status update for as of date ' ||
                                to_char(p_as_of_date, 'dd-MON-yyyy') ||
                                ' and basis ' || p_basis,
                                v_message);
                                
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      utl.pkg_errorhandler.log_sqlerror;
    
      RAISE;
  END send_status_update;

  -- for p_source, p_basis, p_from_date and p_to_date check that data was processed
  -- for all weekdays between and including the from and to date
  -- notify admin team of status of latest job for each as of date
  PROCEDURE check_period_complete(p_source_name IN source.source_name%TYPE,
                                  p_basis       IN source_basis.basis%TYPE,
                                  p_from_date   IN date,
                                  p_to_date     IN date) AS
    v_message      VARCHAR2(4000);
    
    v_current_date DATE;    
    v_last_date    DATE;
    
    v_date_message VARCHAR2(100);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.check_period_complete',null);
    
    v_current_date := to_date(to_char(p_from_date,'dd-MON-YYYY'),'dd-MON-YYYY');
    v_last_date    := to_date(to_char(p_to_date,'dd-MON-YYYY'),'dd-MON-YYYY');
    
    WHILE (v_current_date <= v_last_date)
    LOOP
      IF (utl.pkg_date.is_week_day(v_current_date))
      THEN
        BEGIN
          SELECT to_char(slr.as_of_date,'dd-MON-yyyy') || ' ' ||
                 utl.pkg_config.get_variable_string('vcr.runstatus.' || slr.status) || 
                 ' #'||slr.load_run_no
          INTO   v_date_message
          FROM   source_load_run slr
          WHERE  slr.load_run_id = get_load_run(p_source_name,
                                                p_basis,
                                                v_current_date);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            v_date_message := to_char(v_current_date,'dd-MON-yyyy') || ' Missing';
        END;
        
        v_message := v_message || utl.pkg_constants.gc_cr|| utl.pkg_constants.gc_tab || v_date_message;
      END IF;
      
      v_current_date := v_current_date + 1;
    END LOOP;
    
    pkg_notifications.notify_admin('Completeness check for ' || p_source_name || 
                                     ' ' || p_basis || 
                                     ' between ' || to_char(p_from_date,'dd-MON-YYYY') ||
                                     ' and ' || to_char(p_to_date,'dd-MON-YYYY'),
                                     'Status of last run for each as of date is as follows:'|| utl.pkg_constants.gc_cr||v_message);
                                    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      utl.pkg_errorhandler.log_sqlerror;
    
      RAISE;
  END check_period_complete;
  
  -- return the id of the latest run for the specified parameters
  -- if as of date is null get the latest run for the current as of date
  FUNCTION get_load_run(p_source_name IN source.source_name%TYPE,
                        p_basis       IN source_basis.basis%TYPE,
                        p_as_of_date  IN DATE) RETURN NUMBER 
  AS
    v_load_run_id source_load_run.load_run_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_load_run',null);
    
    SELECT MAX(slr.load_run_id)
    INTO   v_load_run_id
    FROM   source_load_run slr, source s
    WHERE  upper(s.source_name) = upper(p_source_name)
    AND    slr.source_id = s.source_id
    AND    upper(slr.basis) = upper(p_basis)
    AND    slr.as_of_date = p_as_of_date;
  
    dbms_application_info.set_module(null,null);
  
    RETURN v_load_run_id;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_load_run;

  -- checks if there are runs for this source in progress before starting a new one
  FUNCTION is_source_loading(p_source_name IN source.source_name%TYPE)
    RETURN BOOLEAN AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.is_source_loading',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run slr, source s
    WHERE  slr.status           = gc_run_status_in_progress
    AND    slr.source_id        = s.source_id
    AND    upper(s.source_name) = upper(p_source_name);
    
    dbms_application_info.set_module(null,null);
    
    IF v_count > 0
    THEN
      RETURN TRUE;
    ELSE       
      RETURN FALSE;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      utl.pkg_errorhandler.log_sqlerror;
    
      RAISE;
  END is_source_loading;

  -- checks if there are runs for this source in progress other than the parameter run
  FUNCTION is_source_loading(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN BOOLEAN AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.is_source_loading',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run thisslr, source_load_run otherslr
    WHERE  otherslr.status    = gc_run_status_in_progress
    AND    otherslr.source_id = thisslr.source_id
    AND    otherslr.load_run_id != thisslr.load_run_id
    AND    thisslr.load_run_id = p_load_run_id;
  
    dbms_application_info.set_module(null,null);
    
    IF v_count > 0
    THEN
      RETURN TRUE;
    ELSE       
      RETURN FALSE;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END is_source_loading;

  -- gets a description of the load run id for logging purposes
  FUNCTION get_description(p_load_run_id IN source_load_run.load_run_id%TYPE)
    RETURN VARCHAR2 AS
    v_description VARCHAR2(500);
  BEGIN
     dbms_application_info.set_module('vcr.pkg_source_load_run.get_description',null);
 
    SELECT '[' || s.source_name || ' ' || slr.basis || ' ' ||
           to_char(slr.as_of_date, 'DD-MON-YYYY') || ' #' ||
           slr.load_run_no || ']'
    INTO   v_description
    FROM   source_load_run slr, source s
    WHERE  slr.load_run_id = p_load_run_id
    AND    slr.source_id = s.source_id;

    dbms_application_info.set_module(null,null);
    
    RETURN v_description;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;

      RAISE;
  END get_description;

 -- get a count of load runs for a source, as of date and basis
  FUNCTION get_filter_dropdown_count (p_source_id   IN source.source_id%TYPE,
                                      p_basis       IN source_basis.basis%TYPE,
                                      p_as_of_date  IN DATE)RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_filter_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run slr
    WHERE  slr.source_id = p_source_id
    AND    upper(slr.basis) = upper(p_basis)
    AND    slr.as_of_date = p_as_of_date;
    
    dbms_application_info.set_module(null,null); 
   
    RETURN v_count;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_filter_dropdown_count; 
  
  -- get a result set of load runs for a source, as of date and basis
  -- returns a result set
  --     source_load_run.load_run_id            unique id of run
  --     load_run_description   description of run to be displayed in dropdown list
  FUNCTION get_filter_dropdown_list  (p_source_id   IN source.source_id%TYPE,
                                      p_basis       IN source_basis.basis%TYPE,
                                      p_as_of_date  IN DATE) RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_filter_dropdown_list',null);
    
    OPEN cur_list FOR
      SELECT slr.load_run_id, get_description(slr.load_run_id) description
      FROM   source_load_run slr
      WHERE  slr.source_id = p_source_id
      AND    upper(slr.basis) = upper(p_basis)
      AND    slr.as_of_date = p_as_of_date
      ORDER BY slr.load_run_no DESC;
    
    dbms_application_info.set_module(null,null); 
   
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_filter_dropdown_list;
                             
  -- get a count of load runs 
  FUNCTION get_dropdown_count RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run slr;
    
    dbms_application_info.set_module(null,null); 
   
    RETURN v_count;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END; 
  
  -- get a result set of load runs 
  -- returns a result set
  --     source_load_run.load_run_id            unique id of run
  --     load_run_description   description of run to be displayed in dropdown list
  FUNCTION get_dropdown_list RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_dropdown_list',null);
    
    OPEN cur_list FOR
      SELECT slr.load_run_id, get_description(slr.load_run_id) description
      FROM   source_load_run slr
      ORDER BY slr.load_run_id DESC;
    
    dbms_application_info.set_module(null,null); 
   
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END;
                             
  -- get a result set of load runs for the parameters
  FUNCTION get_run_list(p_source_id         IN source_load_run.source_id%TYPE,
                        p_as_of_date        IN source_load_run.as_of_date%TYPE,
                        p_basis             IN source_load_run.basis%TYPE,
                        p_status            IN source_load_run.status%TYPE, 
                        p_latest            IN VARCHAR2 DEFAULT 'N',
                        p_part_release_only IN VARCHAR2 DEFAULT 'N'
                        ) RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
    
    v_sql    VARCHAR2(32000);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_run_list',null);
    
    v_sql := 
      'SELECT slr.load_run_id,
             s.source_name,
             slr.load_run_no,
             to_char(slr.as_of_date, ''dd-MON-yyyy''),
             sb.description,
             to_char(slr.start_time, ''dd-MON-yyyy hh24:mi:ss''),
             to_char(slr.end_time, ''dd-MON-yyyy hh24:mi:ss''),
             utl.pkg_config.get_variable_string(''vcr.runstatus.''||slr.status),
             COUNT(slrf.file_id),
             SUM(nvl(slrf.no_of_records, 0)),
             s.source_id,
             nvl(slr.no_of_exceptions,0),
             slr.vsp_err_log_sent_by,
             to_char(slr.vsp_err_log_sent_on, ''dd-MON-yyyy hh24:mi:ss''), null';
        
    FOR rec_ie IN (
                   SELECT   ie_id
                   FROM     investment_engine
                   ORDER BY description
                  )
    LOOP
      v_sql := v_sql || ' || nvl(release_status.'||rec_ie.ie_id||',''NA'') || ''|''';
    END LOOP;        
    
    v_sql := v_sql || ',null';
     
    FOR rec_ie IN (
                   SELECT   ie_id
                   FROM     investment_engine
                   ORDER BY description
                  )
    LOOP
      v_sql := v_sql || ' || '''||rec_ie.ie_id||''' || ''|''';
    END LOOP;     
             
    v_sql := v_sql ||       
      ' FROM source_basis sb,
             source_load_run slr,
             source s,
             source_load_run_file slrf,
             (SELECT slr.source_id, MAX(slr.load_run_id) load_run_id
              FROM   source_load_run slr
              WHERE  ((:1 IS NULL) OR
                      (:1 IS NOT NULL AND slr.source_id = :1))
              AND    ((:2 IS NULL) OR
                      (:2 IS NOT NULL AND slr.as_of_date = :2))
              AND    ((:3 IS NULL) OR
                      (:3 IS NOT NULL AND slr.basis = :3))
              AND    ((:4 IS NULL) OR
                      (:4 IS NOT NULL AND slr.status = :4))
              GROUP  BY source_id) latest_slr,
             (
              SELECT load_run_id';
              
    FOR rec_ie IN (
                  SELECT   ie_id
                  FROM     investment_engine
                  ORDER BY description
                 )
    LOOP
      v_sql := v_sql || ',MIN(decode(ie_id,'''||rec_ie.ie_id||''',status,null)) '||rec_ie.ie_id||' ';
    END LOOP;             
        
    v_sql := v_sql || ' FROM 
              (
               SELECT load_run_id, ie_id, decode(fund_count, 0, null, release_count, ''Done'', decode(release_count,0,''Release'',''Partial'')) status
               FROM
               (
                 SELECT sfr.load_run_id, 
                        sf.ie_id,
                        COUNT(sfr.source_fund_id) fund_count,
                        SUM(NVL2(sfr.released_by,1,0)) release_count  
                 FROM   source_fund_release sfr, 
                        source_fund sf
                 WHERE  sf.source_fund_id = sfr.source_fund_id
                 GROUP BY sfr.load_run_id, sf.ie_id
               )
              ) GROUP BY load_run_id
             ) release_status
      WHERE  ((:1 IS NULL) OR
             (:1 IS NOT NULL AND slr.source_id = :1))
      AND    ((:2 IS NULL) OR
            (:2 IS NOT NULL AND slr.as_of_date = :2))
      AND    ((:3 IS NULL) OR
            (:3 IS NOT NULL AND slr.basis = :3))
      AND    ((:4 IS NULL) OR
            (:4 IS NOT NULL AND slr.status = :4))
      AND    slr.source_id = s.source_id
      AND    slr.load_run_id = slrf.load_run_id(+)
      AND    slr.basis       = sb.basis
      AND    ((nvl(:5, ''N'') = ''Y'' AND
            slr.source_id = latest_slr.source_id AND
            slr.load_run_id = latest_slr.load_run_id) OR
            (nvl(:5, ''N'') = ''N'' AND
            slr.source_id = latest_slr.source_id))
      AND   ((nvl(:6,''N'') = ''N'') OR (nvl(:6,''N'') = ''Y''';
      
    v_sql := v_sql ||  'AND (1=0 ';
    
    FOR rec_ie IN (
                  SELECT   ie_id
                  FROM     investment_engine
                  ORDER BY description
                 )
    LOOP
      v_sql := v_sql || ' OR release_status.'||rec_ie.ie_id||' IN (''Partial'',''Release'')';
    END LOOP;
    
    v_sql := v_sql || ')))
      AND   slr.load_run_id = release_status.load_run_id (+)
      GROUP  BY slr.load_run_id,
                s.source_name,
                slr.load_run_no,
                slr.as_of_date,
                sb.description,
                slr.start_time,
                slr.end_time,
                slr.status,
                s.source_id,
                slr.no_of_exceptions,
                slr.vsp_err_log_sent_on,
                slr.vsp_err_log_sent_by';
    
    FOR rec_ie IN (
                   SELECT   ie_id
                   FROM     investment_engine
                   ORDER BY description
                  )
    LOOP
      v_sql := v_sql || ',release_status.'||rec_ie.ie_id;
    END LOOP;            
                
    v_sql := v_sql || ' ORDER  BY slr.start_time DESC';
    
    OPEN cur_list FOR v_sql USING p_source_id,p_source_id, p_source_id,  p_as_of_date, p_as_of_date,p_as_of_date,p_basis,p_basis,p_basis, p_status, p_status,p_status,p_source_id,p_source_id, p_source_id,  p_as_of_date, p_as_of_date,p_as_of_date,p_basis,p_basis,p_basis, p_status, p_status,p_status,p_latest,p_latest,p_part_release_only,p_part_release_only;
      
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_run_list;

  -- get a count load runs for the parameters
  --     p_source_id optional source
  --     p_as_of_date optional as of date
  --     p_basis optional basis
  --     p_status optional status
  --     p_latest - either 'N' or 'Y'. If Y get the latest runs only for the selected parameters  
  --     p_part_release_only -- if 'Y' gets only load runs which have not been fully released

  FUNCTION get_run_count(p_source_id IN source_load_run.source_id%TYPE,
                        p_as_of_date IN source_load_run.as_of_date%TYPE,
                        p_basis      IN source_load_run.basis%TYPE,
                        p_status     IN source_load_run.status%TYPE, 
                        p_latest     IN VARCHAR2 DEFAULT 'N',
                        p_part_release_only IN VARCHAR2 DEFAULT 'N'
                        ) RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_run_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run slr,
           (SELECT source_id, MAX(load_run_no) load_run_no
            FROM   source_load_run
            GROUP  BY source_id) latest_slr -- list of latest load run ids by source
    WHERE  ((p_source_id IS NULL) OR
           (p_source_id IS NOT NULL AND slr.source_id = p_source_id))
    AND    ((p_as_of_date IS NULL) OR
          (p_as_of_date IS NOT NULL AND slr.as_of_date = p_as_of_date))
    AND    ((p_basis IS NULL) OR
          (p_basis IS NOT NULL AND slr.basis = p_basis))
    AND    ((p_status IS NULL) OR
          (p_status IS NOT NULL AND slr.status = p_status))
    AND    ((nvl(p_latest, 'N') = 'Y'               AND -- if latest runs are required join to max load run id for source
           slr.source_id = latest_slr.source_id      AND
           slr.load_run_no = latest_slr.load_run_no) OR
           (nvl(p_latest, 'N') = 'N'                 AND -- if all runs are required do not join to the latest load run id
           slr.source_id = latest_slr.source_id))
    AND   ((nvl(p_part_release_only,'N') = 'N') OR (nvl(p_part_release_only,'N') = 'Y' AND (vcr.pkg_source_load_run.get_ie_release_status(slr.load_run_id, null) IN ('Partial','Release'))));     
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_run_count;
  
  -- get a result set of loaded files for the parameter
  --     p_load_run_id -- the parent load run, mandatory
  -- returns a result set
  --     source_load_run_file.file_id "Id"
  --     source_load_run_file.pathname "Pathname"
  --     source_load_run_file.filename "Filename"
  --     source_load_run_file.no_of_records "Records"
  --     source_load_run_file.reporting_date "Reporting Date"     
  --     file_type.description "Type"
  -- used in source load file list screen      
  
  FUNCTION get_file_list(p_load_run_id IN source_load_run.load_run_id%TYPE) RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_file_count',null);
     
    OPEN cur_list FOR
      SELECT slrf.file_id       "Id",
             slrf.pathname      "Pathname",
             slrf.filename      "Filename",
             slrf.no_of_records "Records",
             to_char(slrf.reporting_date, 'dd-MON-yyyy') "Reporting Date",
             ft.description "Type"
      FROM   source_load_run_file slrf, file_type ft
      WHERE  slrf.load_run_id = p_load_run_id
      AND    slrf.file_type   = ft.file_type
      ORDER BY slrf.file_id;

    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_file_list;
  
  -- get a count of loaded files for the parameter
  --     p_load_run_id -- the parent load run, mandatory
  -- used in source load file list screen      
  
  FUNCTION get_file_count(p_load_run_id IN source_load_run.load_run_id%TYPE) RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_file_list',null);
     
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_load_run_file slrf, file_type ft
    WHERE  slrf.load_run_id = p_load_run_id
    AND    slrf.file_type   = ft.file_type;

    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_file_count;
  
  -- gets a count of load run statii 
  FUNCTION get_status_dropdown_count RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_status_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM
    (
      SELECT DISTINCT status
      FROM   source_load_run
    );
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_status_dropdown_count;
  
    -- gets a list of load run statii 
  FUNCTION get_status_dropdown_list RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_status_dropdown_list',null);
    
    OPEN cur_list FOR
      SELECT DISTINCT status,
             utl.pkg_config.get_variable_string('vcr.runstatus.'||status)
      FROM   source_load_run;
      
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_status_dropdown_list;
  
  -- gets a count of load run as of dates 
  FUNCTION get_as_of_date_dropdown_count RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_as_of_date_dropdown_count',null);
    
    SELECT COUNT(DISTINCT as_of_date)
    INTO   v_count
    FROM   source_load_run;
      
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_as_of_date_dropdown_count;
  
  -- gets a list of load run as of dates 
  FUNCTION get_as_of_date_dropdown_list RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_as_of_date_dropdown_list',null);
    
    OPEN cur_list FOR
    SELECT aod, to_char(as_of_date, 'dd/mm/yyyy')
    FROM
    (
      SELECT DISTINCT to_char(as_of_date,'yyyy-mm-dd') aod, as_of_date
      FROM   source_load_run
      ORDER BY as_of_date DESC
    );
      
    dbms_application_info.set_module(null,null);
    
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_as_of_date_dropdown_list;

  -- gets a count of load run basii 
  FUNCTION get_basis_dropdown_count RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_basis_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM
    (
      SELECT DISTINCT slr.basis
      FROM   source_load_run slr
    );

    dbms_application_info.set_module(null,null);

    RETURN v_count;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_basis_dropdown_count;
  
  -- gets a list of load run basii 
  FUNCTION get_basis_dropdown_list RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_basis_dropdown_list',null);
    
    OPEN cur_list FOR
      SELECT DISTINCT slr.basis,
             sb.description
      FROM   source_load_run slr, source_basis sb
      WHERE  slr.basis = sb.basis
      ORDER BY sb.description;

    dbms_application_info.set_module(null,null);

    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_basis_dropdown_list;

  -- get a count of log entries for
  --     p_load_run_id -- the run the log entries are for
 
  FUNCTION get_log_count(p_load_run_id IN source_load_run.load_run_id%TYPE,
                         p_from_date   IN DATE,
                         p_to_date     IN DATE) RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_log_count',null);

    SELECT COUNT(*)
    INTO   v_count
    FROM   utl.log_message lm
    WHERE  ((p_load_run_id IS NOT NULL AND lm.parent_id = p_load_run_id AND lm.parent_table = gc_log_message_parent_table) OR (p_load_run_id IS NULL))
    AND    lm.log_date > nvl(to_date(to_char(p_from_date,'dd-MON-yyyy'),'dd-MON-yyyy'), to_date('1','j'))
    AND    lm.log_date < decode(p_to_date, null, to_date('5373484','j'), to_date(to_char(p_to_date,'dd-MON-yyyy'),'dd-MON-yyyy') + 1);

    dbms_application_info.set_module(null,null);
      
    RETURN v_count;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_log_count;
  
  -- get a result set of log entries, optionally for
  --     p_load_run_id -- the run the log entries are for
  --     p_from_date   -- between two dates
  --     p_to_date
  -- returns a result set
  --     utl.log_message.message_text "Message"
  --     utl.log_message.message_type "Type"
  --     utl.log_message.program_name "Program"
  --     utl.log_message.error_code "Error Code"
  --     utl.log_message.log_date   "Date/Time"
  --     utl.error_codes.message
  --     utl.error_codes.explanation
  --     load run description
  --     utl.log_message.log_user
  -- ordered by sequence_id descending
  FUNCTION get_log_list(p_load_run_id IN source_load_run.load_run_id%TYPE,
                        p_from_date   IN DATE,
                        p_to_date     IN DATE) RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_log_list',null);
    
    OPEN cur_list FOR
      SELECT lm.message_text,
             lm.message_type,
             lm.program_name,
             lm.error_code,
             to_char(lm.log_date, 'dd-MON-yyyy hh24:mi:ss') log_date,
             decode(lm.error_code, null, null,
                    utl.pkg_errorhandler.get_message(lm.error_code)) error_message, 
             decode(lm.error_code, null, null,
                    utl.pkg_errorhandler.get_explanation(lm.error_code)) error_explanation,
             decode(lower(lm.parent_table), gc_log_message_parent_table, decode(lm.parent_id, null, null, get_description(lm.parent_id)), null) load_run,
             lm.log_user
      FROM   utl.log_message lm
      WHERE  ((p_load_run_id IS NOT NULL AND lm.parent_id = p_load_run_id AND lm.parent_table = gc_log_message_parent_table) OR (p_load_run_id IS NULL))
      AND    lm.log_date > nvl(to_date(to_char(p_from_date,'dd-MON-yyyy'),'dd-MON-yyyy'), to_date('1','j'))
      AND    lm.log_date < decode(p_to_date, null, to_date('5373484','j'), to_date(to_char(p_to_date,'dd-MON-yyyy'),'dd-MON-yyyy') + 1)
      ORDER BY lm.sequence_id DESC;
    
    dbms_application_info.set_module(null,null);
      
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_log_list;
  
  -- get release status for for a load run and ie
  FUNCTION get_ie_release_status(p_load_run_id IN source_fund_release.load_run_id%TYPE,
                                 p_ie_id       IN investment_engine.ie_id%TYPE) RETURN VARCHAR2
  IS   
    v_fund_count    INTEGER;
    v_release_count INTEGER;
    v_status        VARCHAR2(10);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_ie_release_list',null);
    
    SELECT COUNT(sfr.source_fund_id) fund_count,
           SUM(NVL2(sfr.released_by,1,0)) release_count
    INTO   v_fund_count,
           v_release_count
    FROM   source_fund_release sfr, 
           source_fund sf
    WHERE  sf.source_fund_id = sfr.source_fund_id
    AND    p_load_run_id     = sfr.load_run_id
    AND    ((p_ie_id IS NULL AND sf.ie_id IS NOT NULL) OR (p_ie_id IS NOT NULL AND sf.ie_id = p_ie_id));
    
    IF v_fund_count = 0
    THEN
      v_status := 'NA';
    ELSIF v_fund_count = v_release_count
    THEN
      v_status := 'Done';
    ELSIF v_release_count = 0
    THEN
      v_status := 'Release';
    ELSE
      v_status := 'Partial';
    END IF;
    
    dbms_application_info.set_module(null,null);
      
    RETURN v_status;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_ie_release_status; 
  
  -- get list of funds in this load run for an investment engine and their release information
  FUNCTION get_fund_release_list(p_load_run_id IN source_fund_release.load_run_id%TYPE,
                                 p_ie_id       IN investment_engine.ie_id%TYPE) RETURN utl.global.t_result_set
  IS
    cur_list utl.global.t_result_set;
    
    v_as_of_date source_load_run.as_of_date%TYPE;
    v_source_id  source_load_run.source_id%TYPE;
    v_basis      source_load_run.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_fund_release_list',null);
    
    SELECT as_of_date,
           basis,
           source_id
    INTO   v_as_of_date,
           v_basis,
           v_source_id
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
           
    OPEN cur_list FOR
      SELECT sf.fund,
             sf.source_id,
             sf.source_fund_id,
             sfr.released_by,
             to_char(sfr.released_on, 'dd-MON-yyyy hh24:mi:ss'),
             last_sfr.released_by last_released_by,
             to_char(last_sfr.released_on, 'dd-MON-yyyy hh24:mi:ss')last_released_on,
             last_sfr.load_run_desc last_release_load_run
      FROM   source_fund_release sfr, 
             source_fund sf,
             (
              SELECT sfr.source_fund_id, sfr.load_run_id, sfr.released_by, sfr.released_on, get_description(sfr.load_run_id) load_run_desc
              FROM
              (
                SELECT sfr.source_fund_id, MAX(sfr.load_run_id) load_run_id
                FROM   source_fund_release sfr, source_load_run slr
                WHERE  slr.as_of_date = v_as_of_date
                AND    slr.basis      = v_basis
                AND    slr.source_id  = v_source_id
                AND    slr.load_run_id  < p_load_run_id
                AND    slr.status       = pkg_source_load_run.gc_run_status_complete
                AND    slr.load_run_id  = sfr.load_run_id
                GROUP BY sfr.source_fund_id
              ) last_release, source_fund_release sfr
              WHERE last_release.source_fund_id = sfr.source_fund_id
              AND   last_release.load_run_id    = sfr.load_run_id
             ) last_sfr
      WHERE  sf.ie_id          = p_ie_id
      AND    sf.source_fund_id = sfr.source_fund_id
      AND    p_load_run_id     = sfr.load_run_id
      AND    sfr.source_fund_id = last_sfr.source_fund_id (+)
      ORDER BY sf.fund;
    
    dbms_application_info.set_module(null,null);
      
    RETURN cur_list;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_fund_release_list; 
  
  -- get count of funds in this load run for an investment engine
  FUNCTION get_fund_release_count(p_load_run_id IN source_fund_release.load_run_id%TYPE,
                                  p_ie_id       IN investment_engine.ie_id%TYPE) RETURN INTEGER
  IS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_load_run.get_fund_release_count',null);
            
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_fund_release sfr, 
           source_fund sf
    WHERE  sf.ie_id          = p_ie_id
    AND    sf.source_fund_id = sfr.source_fund_id
    AND    p_load_run_id     = sfr.load_run_id;
    
    dbms_application_info.set_module(null,null);
      
    RETURN v_count;  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
      RAISE;
  END get_fund_release_count; 
  
END pkg_source_load_run;
/
