CREATE OR REPLACE PACKAGE BODY vcr.pkg_instrument_type_mod IS
  -----------------------------------------------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_instrument_type_mod.plb 1.7.1.2 2005/09/27 13:15:58BST apenney DEV  $
  -----------------------------------------------------------------------------------------------------------------
  -- Purpose : Provide routines to add and update instrument type data
  --
  -- Creates a mapping between a source instrument type and an investment engine instrument type
  -- If a mapping already exists for the source instrument type for the investment engine of the IE ins trument type
  -- this is deleted and replaced with a new one for the specified IE instrument type
  -- if the ie_instrument_type_id is set to unmapped the mapping is deleted
  PROCEDURE update_source_ie_detail(p_source_instrument_type_id IN source_ie_ins_type.source_instrument_type_id%TYPE,
                                    p_ie_instrument_type_id     IN source_ie_ins_type.ie_instrument_type_id%TYPE,
                                    p_ie_id                     IN investment_engine.ie_id%TYPE,
                                    p_change_reason             IN source_ie_ins_type.change_reason%TYPE) 
  AS 
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type_mod.update_source_ie_detail',null);  

    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    -- mark any other mapping for this instrument type and IE with the change reason 
    UPDATE source_ie_ins_type sieit
    SET    sieit.change_reason = p_change_reason
    WHERE  sieit.source_instrument_type_id = p_source_instrument_type_id
    AND    sieit.ie_instrument_type_id IN
           (SELECT ie_instrument_type_id
             FROM   ie_instrument_type
             WHERE  ie_id = p_ie_id
             AND    ie_instrument_type_id != p_ie_instrument_type_id);
    
    -- then delete it! the change reason is picked up by the trigger
    DELETE FROM source_ie_ins_type sieit
    WHERE  sieit.source_instrument_type_id = p_source_instrument_type_id
    AND    sieit.ie_instrument_type_id IN
           (SELECT ie_instrument_type_id
             FROM   ie_instrument_type
             WHERE  ie_id = p_ie_id
             AND    ie_instrument_type_id != p_ie_instrument_type_id);
  
    -- create the new mapping unless it already exists or this is an unmapping
    IF p_ie_instrument_type_id != utl.pkg_constants.gc_unmapped_key
    THEN
      BEGIN
        INSERT 
        INTO source_ie_ins_type
        (
          ie_instrument_type_id,
          source_instrument_type_id,
          change_reason
        )
        VALUES
        (
          p_ie_instrument_type_id,
          p_source_instrument_type_id,
          p_change_reason
        );
      EXCEPTION
        WHEN dup_val_on_index THEN
          NULL;
        WHEN OTHERS THEN
          utl.pkg_errorhandler.handle;
          RAISE;
      END;
    END IF;
  
    COMMIT;

    dbms_application_info.set_module(null,null);  

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
    
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_source_ie_detail;

  -- Adds a new investment engine instrument type
  -- raises an application error if the instrument type already exists     
  -- returns allocated id                   
  FUNCTION add_ie_instrument_type(p_ie_id              IN ie_instrument_type.ie_id%TYPE,
                                  p_ie_instrument_type IN ie_instrument_type.ie_instrument_type%TYPE,
                                  p_category           IN ie_instrument_type.category%TYPE,
                                  p_change_reason      IN ie_instrument_type.change_reason%TYPE,
                                  p_stale_price_period IN ie_instrument_type.stale_price_period%TYPE) RETURN INTEGER
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    v_ie_instrument_type_id INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type_mod.add_ie_instrument_type',null);  
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    INSERT INTO ie_instrument_type
    (
       ie_instrument_type_id,
       ie_id,
       ie_instrument_type,
       category,
       change_reason,
       stale_price_period
    )
    VALUES
    (  
       sq_ie_instrument_type.NEXTVAL,
       p_ie_id,
       p_ie_instrument_type,
       p_category,
       p_change_reason,
       p_stale_price_period
    ) RETURNING ie_instrument_type_id INTO v_ie_instrument_type_id;
  
    COMMIT;

    dbms_application_info.set_module(null,null);  
    
    RETURN v_ie_instrument_type_id;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      raise_application_error(utl.pkg_exceptions.gc_ie_ins_type_err,
                              'Instrument Type '|| p_ie_instrument_type ||
                              ' already exists for ' || p_ie_id);
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END add_ie_instrument_type;

  -- Updates an investment engine instrument type
  PROCEDURE update_ie_instrument_type(p_ie_instrument_type_id IN ie_instrument_type.ie_instrument_type_id%TYPE,
                                      p_ie_instrument_type    IN ie_instrument_type.ie_instrument_type%TYPE,
                                      p_category              IN ie_instrument_type.category%TYPE,
                                      p_change_reason         IN ie_instrument_type.change_reason%TYPE,
                                      p_stale_price_period    IN ie_instrument_type.stale_price_period%TYPE) 
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_instrument_type_mod.update_ie_instrument_type',null);  
    
    IF p_change_reason IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_change_reason, 'A change reason must be entered');
    END IF;
    
    UPDATE ie_instrument_type
    SET    ie_instrument_type = p_ie_instrument_type,
           change_reason      = p_change_reason,
           category           = p_category,
           stale_price_period = p_stale_price_period
    WHERE  ie_instrument_type_id = p_ie_instrument_type_id;
          
    COMMIT;
    
    dbms_application_info.set_module(null,null);  
  EXCEPTION
    WHEN utl.pkg_exceptions.e_ie_ins_type THEN
      RAISE;
    
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END update_ie_instrument_type;
END pkg_instrument_type_mod;
/
