CREATE OR REPLACE PACKAGE BODY vcr.pkg_limit_exception_mod
------------------------------------------------------------------------
--  $Header: vcr/packages/pkg_limit_exception_mod.plb 1.2 2005/10/17 15:29:09BST apenney DEV  $
--------------------------------------------------------------------------
-- Provides routines to update limit exceptions
AS
   -- Updates an limit exception record for parameters
  PROCEDURE update_detail(p_as_of_date             IN limit_exception.as_of_date%TYPE,
                          p_source_id              IN limit_exception.source_fund_id%TYPE,
                          p_exception_id           IN limit_exception.exception_id%TYPE,
                          p_status                 IN limit_exception.status%TYPE,
                          p_class                  IN limit_exception.class%TYPE,
                          p_comments               IN limit_exception.comments%TYPE,
                          p_action_description     IN limit_exception.action_description%TYPE,
                          p_resolution_description IN limit_exception.resolution_description%TYPE) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_limit_exception_mod.update_detail',null);
       
    UPDATE limit_exception le
    SET    le.status                 = p_status,
           le.class                  = p_class,
           le.comments               = decode(p_status,pkg_validator.gc_exception_status_tbr,p_comments,le.comments),
           le.action_description     = p_action_description,
           le.resolution_description = decode(p_status,pkg_validator.gc_exception_status_resolved,decode(p_status,le.status,le.resolution_description,p_resolution_description),le.resolution_description),
           le.to_be_resolved_ind     = decode(p_status,pkg_validator.gc_exception_status_tbr,decode(p_status,le.status,le.to_be_resolved_ind,'Y'),le.to_be_resolved_ind),
           le.resolution_date        = decode(p_status,pkg_validator.gc_exception_status_resolved,decode(p_status,le.status,le.resolution_date,sysdate),le.resolution_date),
           le.resolution_user        = decode(p_status,pkg_validator.gc_exception_status_resolved,decode(p_status,le.status,le.resolution_user,user),le.resolution_user),
           le.last_updated_date      = sysdate,
           le.last_updated_by        = user
    WHERE  le.source_id    = p_source_id
    AND    le.as_of_date   = p_as_of_date
    AND    le.exception_id = p_exception_id;

    dbms_application_info.set_module(null,null);
    
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_detail;
END pkg_limit_exception_mod;
/
