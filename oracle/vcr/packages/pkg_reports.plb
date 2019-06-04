CREATE OR REPLACE PACKAGE BODY vcr.pkg_reports AS
  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_reports.plb 1.4 2005/08/17 17:49:13BST apenney DEV  $
  --------------------------------------------------------------------------
  --  A package to generate requests to Crystal to run reports
  ------------------------------------------------------------------------
   
  -- generate a request to run the std exception report for a load run 
  -- generally called when completing a load run
  -- if an existing outstanding request is detected an error is logged but no exception is raised
  PROCEDURE request_std_exception(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_source_name                 source.source_name%TYPE;
    
    v_request_file_name           VARCHAR2(100);
    
    v_file_handle                 utl_file.file_type;            
  BEGIN
    dbms_application_info.set_module('vcr.pkg_reports.request_std_exception', null);  

    SELECT s.source_name
    INTO   v_source_name
    FROM   source s, source_load_run slr, source_basis sb
    WHERE  slr.load_run_id = p_load_run_id
    AND    slr.source_id   = s.source_id
    AND    slr.basis       = sb.basis;

    v_request_file_name := lower(v_source_name) || '_vcr_std_exception_param.bat';

    BEGIN
      -- open request file to see if one exists already
      v_file_handle := utl_file.fopen(pkg_reports.gc_param_directory, v_request_file_name, 'r', 32767);

      -- if so close the file and raise an error
      utl_file.fclose(v_file_handle);
      
      utl.pkg_errorhandler.log_error(utl.pkg_exceptions.gc_report_req_exists,
                                     'Standard exception report request parameter file '||v_request_file_name||' already exists. Standard exception reports will not be produced for '||pkg_source_load_run.get_description(p_load_run_id),
                                      pkg_source_load_run.gc_log_message_parent_table,
                                      p_load_run_id);
                         
      RETURN;
    EXCEPTION
      WHEN utl_file.invalid_path OR utl_file.invalid_operation THEN
        NULL;
      WHEN OTHERS THEN
        utl.pkg_errorhandler.handle;
        RAISE;
    END;

    -- create new request file
    v_file_handle := utl_file.fopen(pkg_reports.gc_param_directory, v_request_file_name, 'w', 32767);      
    
    utl_file.put_line(v_file_handle, utl.pkg_config.get_variable_string(pkg_reports.gc_crystal_vc_path_cfg_key)||'standardexceptionreport-'||v_source_name||'.rpt"');
    utl_file.fclose(v_file_handle);
    
    dbms_application_info.set_module(null, null);          
  EXCEPTION
    WHEN OTHERS THEN    
      utl.pkg_errorhandler.handle;
      pkg_source_load_run_mod.log_sqlerror(p_load_run_id);

      utl_file.fclose(v_file_handle);
      RAISE;
  
  END request_std_exception;

END pkg_reports;
/
