CREATE OR REPLACE PACKAGE BODY
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_country_mod.plb 1.4 2005/03/02 10:41:44GMT apenney PRODUCTION  $
--------------------------------------------------------------------------
-- Allows you to update country information
 vcr.pkg_country_mod AS

  -- Updates a source_country record for parameters
  --         p_source_id - source that country is from
  --         p_country
  --         p_iso_country_code  - assigned iso country code
  --         p_change_reason   - textual rational for change
  PROCEDURE update_detail(p_source_id        IN source_country.source_id%TYPE,
                          p_country          IN source_country.country%TYPE,
                          p_iso_country_code IN source_country.iso_country_code%TYPE,
                          p_change_reason    IN source_country.change_reason%TYPE)
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_country_mod.update_detail', null);  
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    UPDATE source_country
    SET    iso_country_code = decode(p_iso_country_code,utl.pkg_constants.gc_unmapped_key,null,p_iso_country_code),
           change_reason    = p_change_reason
    WHERE  source_id        = p_source_id
    AND    country          = p_country;
  
    COMMIT;

    dbms_application_info.set_module(null, null);  

  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_detail;
END pkg_country_mod;
/
