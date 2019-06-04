CREATE OR REPLACE PACKAGE BODY vcr.pkg_filter AS
  --------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_filter.plb 1.5.1.2 2005/07/21 14:21:04BST apenney DEV  $
  --------------------------------------------------------------------------
  --  A package to discard unwanted records from a target table
  --------------------------------------------------------------------------

  PROCEDURE filter_positions(p_load_run_id IN source_load_run.load_run_id%TYPE) 
  AS
    v_source_id  source_load_run.source_id%TYPE;
    v_as_of_date source_load_run.as_of_date%TYPE;
    v_basis      source_load_run.basis%TYPE;
    
    v_count      INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_filter.filter_positions', null);  

    SELECT as_of_date, source_id, basis
    INTO   v_as_of_date, v_source_id, v_basis
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
    
    FOR rec_ie IN (SELECT ie_id
                   FROM   investment_engine ie
                   WHERE  ie.ignore_zero_positions = 'Y')
    LOOP
      v_count := 0;
    
      DELETE FROM source_position sp
      WHERE  sp.source_id   = v_source_id
      AND    sp.as_of_date  = v_as_of_date
      AND    sp.basis       = v_basis
      AND    sp.load_run_id = p_load_run_id
      AND    sp.fund        IN (SELECT sf.fund FROM source_fund sf WHERE sf.ie_id = rec_ie.ie_id AND sf.source_id = v_source_id)
      AND    (sp.instrument_holding = 0 OR sp.instrument_holding IS NULL)
      AND    (sp.total_pnl_daily = 0    OR sp.total_pnl_daily IS NULL)
      AND    (sp.total_pnl_mtd = 0      OR sp.total_pnl_mtd IS NULL)
      AND    (sp.instrument_value = 0   OR sp.instrument_value IS NULL);
   
      v_count := SQL%ROWCOUNT;
      
      IF v_count <> 0
      THEN
        -- log number of records filtered
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                           'Removed ' || SQL%ROWCOUNT ||
                           ' '||rec_ie.ie_id||' YTD position records from source_position for run ' ||
                           pkg_source_load_run.get_description(p_load_run_id),
                           pkg_source_load_run.gc_log_message_parent_table,
                           p_load_run_id);

        -- update source load run file to correct record counts                           
        FOR rec_file IN (
                         SELECT sp.file_id, sp.file_type, count(*) no_of_records
                         FROM   source_position sp
                         WHERE  sp.source_id   = v_source_id
                         AND    sp.as_of_date  = v_as_of_date
                         AND    sp.basis       = v_basis
                         AND    sp.load_run_id = p_load_run_id
                         GROUP BY sp.file_id, sp.file_type
                        )
        LOOP
          pkg_source_load_run_mod.update_no_of_records(p_load_run_id,rec_file.file_id, rec_file.file_type, rec_file.no_of_records);
        END LOOP;
      END IF;
    END LOOP;

    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END filter_positions;

  PROCEDURE filter_target_table(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_filter.filter_target_table', null);  

    -- for each corresponding target table for the files that have been loaded to the staging area
    -- call the defined filter/discard procedure passing the load run id
    FOR rec_dp IN (SELECT DISTINCT tt.discard_procedure
                   FROM   target_table     tt,
                          source_load_run_file  slrf,
                          file_type        ft
                   WHERE  slrf.load_run_id = p_load_run_id
                   AND    slrf.file_type   = ft.file_type
                   AND    ft.table_name    = tt.table_name
                   AND    tt.discard_procedure IS NOT NULL)
    LOOP
      -- call each discard procedure 
      EXECUTE IMMEDIATE 'call ' || rec_dp.discard_procedure || '(' ||
                        p_load_run_id || ')';
    END LOOP;
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END filter_target_table;
END pkg_filter;
/
