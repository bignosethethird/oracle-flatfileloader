CREATE OR REPLACE PACKAGE BODY vcr.pkg_purger AS
  --------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_purger.plb 1.7 2005/03/02 10:42:21GMT apenney PRODUCTION  $
  --------------------------------------------------------------------------
  --  A package to purge various forms of data from a source 
  --------------------------------------------------------------------------

  c_fund_field CONSTANT CHAR(4) := 'fund';

  -- purge staging area for a source 
  PROCEDURE purge_staging_area(p_source_name IN source.source_name%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_purger.purge_staging_area',null);

    FOR rec_source_file_type IN (SELECT DISTINCT sft.source_file_type
                                 FROM   source_file_type sft, source s
                                 WHERE  upper(s.source_name) = upper(p_source_name)
                                 AND    s.source_id          = sft.source_id)
    LOOP
      EXECUTE IMMEDIATE 'ALTER TABLE source_staging_area TRUNCATE PARTITION ' ||
                        rec_source_file_type.source_file_type;
                        
      -- log purging
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Purged '||rec_source_file_type.source_file_type||' staging area');
    END LOOP;

    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;

      RAISE;
  END purge_staging_area;

  -- purge from source_position the positions to be replaced by a particular load run 
  PROCEDURE purge_positions(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
    v_load_run_no source_load_run.load_run_no%TYPE;
    v_as_of_date  DATE;
    v_source_id   source.source_id%TYPE;
    v_basis       source_basis.basis%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_purger.purge_positions',null);

    SELECT load_run_no, as_of_date, source_id, basis
    INTO   v_load_run_no, v_as_of_date, v_source_id, v_basis
    FROM   source_load_run
    WHERE  load_run_id = p_load_run_id;
  
    -- if this is not the first run purge only those positions for funds for which we have positions for in this run
    IF v_load_run_no <> 1
    THEN
      DELETE FROM source_position
      WHERE  source_id = v_source_id
      AND    as_of_date = v_as_of_date
      AND    basis = v_basis
      AND    fund IN (SELECT DISTINCT pkg_loader.get_value(ftc.field_name,
                                                           ssa.staging_record)
                      FROM   source_staging_area  ssa,
                             field_target_column  ftc,
                             file_type            ft,
                             source_load_run_file slrf,
                             source_file_type     sft,
                             source_load_run      slr
                      WHERE  slr.load_run_id      = p_load_run_id
                      AND    slr.load_run_id      = slrf.load_run_id
                      AND    sft.source_id        = slr.source_id
                      AND    sft.file_type        = slrf.file_type
                      AND    ssa.source_file_type = sft.source_file_type
                      AND    ssa.file_id          = slrf.file_id
                      AND    ft.file_type         = sft.file_type
                      AND    ftc.file_type        = ft.file_type
                      AND    ftc.table_name       = ft.table_name
                      AND    lower(ftc.column_name) = c_fund_field);
    ELSE
      DELETE FROM source_position
      WHERE  source_id = v_source_id
      AND    as_of_date = v_as_of_date
      AND    basis = v_basis;
    END IF;
  
    -- log number of records purged
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Purged ' || SQL%ROWCOUNT ||
                       ' records from source_position for run ' ||
                       pkg_source_load_run.get_description(p_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);
                  
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END purge_positions;

  -- purge from the target table(s) that data to be replaced by new data from a load run
  PROCEDURE purge_target_table(p_load_run_id IN source_load_run.load_run_id%TYPE) AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_purger.purge_target_table',null);

    -- for each corresponding target table for the files that have been loaded to the staging area
    -- call the defined purge procedure passing the load run id
    FOR rec_pp IN (SELECT DISTINCT tt.purge_procedure
                   FROM   target_table         tt,
                          source_load_run_file slrf,
                          file_type            ft
                   WHERE  slrf.load_run_id = p_load_run_id
                   AND    slrf.file_type   = ft.file_type
                   AND    ft.table_name    = tt.table_name)
    LOOP
      -- call each purge procedure 
      EXECUTE IMMEDIATE 'call ' || rec_pp.purge_procedure || '(' ||
                        p_load_run_id || ')';
    END LOOP;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END purge_target_table;
END pkg_purger;
/
