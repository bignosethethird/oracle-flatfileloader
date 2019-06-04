CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_source_strategy_mod.plb 1.1.1.1 2005/05/10 15:26:52BST apenney DEV  $
--------------------------------------------------------------------------
-- Allows you to update strategy information
 vcr.pkg_source_strategy_mod AS

  -- Updates a source_strategy record for parameters
  --         p_source_strategy_id - PK of source_strategy
  --         p_me_strategy_id     - id of strategy reference in manager estimate source
  --         p_change_reason      - reason for update

  PROCEDURE update_detail(p_source_strategy_id IN source_strategy.source_strategy_id%TYPE,
                          p_change_reason      IN source_strategy.change_reason%TYPE,
                          p_me_strategy_id     IN source_strategy.me_strategy_id%TYPE DEFAULT NULL)
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_strategy_mod.update_detail',null);
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    UPDATE source_strategy
    SET    me_strategy_id = decode(p_me_strategy_id,utl.pkg_constants.gc_unmapped_key,null,p_me_strategy_id),
           change_reason  = p_change_reason
    WHERE  source_strategy_id = p_source_strategy_id;

    dbms_application_info.set_module(null,null);
    
    COMMIT;
  EXCEPTION
    WHEN utl.pkg_exceptions.e_no_change_reason THEN
      RAISE;
    
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_detail;
END pkg_source_strategy_mod;
/
