CREATE OR REPLACE PACKAGE BODY
---------------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_fund_mod.plb 1.9 2005/03/02 10:42:27GMT apenney PRODUCTION  $
---------------------------------------------------------------------------------------
-- Allows you to update fund info
 vcr.pkg_source_fund_mod AS

  -- Updates a source_fund record for parameters
  --         p_source_fund_id PK of source_fund
  --         p_ie_id investment engine of fund
  --         p_active_ind, whether or not fund is active (Y or N)
  --         p_change_reason - resson for update
  --         p_me_fund_id, id of fund reference in manager estimate source
  --         p_me_benchmark_fund_id, id of benchmark fund reference in manager estimate source
  --         p_ie_platform, optional investment engine platform
  PROCEDURE update_detail(p_source_fund_id       IN source_fund.source_fund_id%TYPE,
                          p_ie_id                IN source_fund.ie_id%TYPE,
                          p_active_ind           IN source_fund.active_ind%TYPE,
                          p_change_reason        IN source_fund.change_reason%TYPE,
                          p_me_fund_id           IN source_fund.me_fund_id%TYPE DEFAULT NULL,
                          p_me_benchmark_fund_id IN source_fund.me_benchmark_fund_id%TYPE DEFAULT NULL,
                          p_ie_platform          IN source_fund.ie_platform%TYPE DEFAULT NULL) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_fund_mod.update_detail',null);
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    UPDATE source_fund
    SET    ie_id                = decode(p_ie_id,utl.pkg_constants.gc_unmapped_key,null,p_ie_id),
           active_ind           = p_active_ind,
           me_fund_id           = decode(p_me_fund_id,utl.pkg_constants.gc_unmapped_key,null,p_me_fund_id),
           me_benchmark_fund_id = decode(p_me_benchmark_fund_id,utl.pkg_constants.gc_unmapped_key,null,p_me_benchmark_fund_id),
           ie_platform          = decode(p_ie_platform,utl.pkg_constants.gc_unmapped_key,null,p_ie_platform),
           change_reason        = p_change_reason
    WHERE  source_fund_id       = p_source_fund_id;

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
END pkg_source_fund_mod;
/
