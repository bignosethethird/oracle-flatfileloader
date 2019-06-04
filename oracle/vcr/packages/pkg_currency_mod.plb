CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_currency_mod.plb 1.4 2005/03/02 10:41:50GMT apenney PRODUCTION  $
--------------------------------------------------------------------------
-- Allows you to update currency information
 vcr.pkg_currency_mod AS

  -- Updates a source_currency record for parameters
  --         p_source_id - source that currency is from
  --         p_currency
  --         p_iso_currency_code  - assigned iso currency code
  --         p_change_reason   - textual rational for change
  PROCEDURE update_detail(p_source_id         IN source_currency.source_id%TYPE,
                          p_currency          IN source_currency.currency%TYPE,
                          p_iso_currency_code IN source_currency.iso_currency_code%TYPE,
                          p_change_reason     IN source_currency.change_reason%TYPE)
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_currency_mod.update_detail', null);  

    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
  
    UPDATE source_currency
    SET    iso_currency_code = decode(p_iso_currency_code,utl.pkg_constants.gc_unmapped_key,null,p_iso_currency_code),
           change_reason     = p_change_reason
    WHERE  source_id         = p_source_id
    AND    currency          = p_currency;
    
    COMMIT;

    dbms_application_info.set_module(null, null);  

  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_detail;
END pkg_currency_mod;
/
