CREATE OR REPLACE PACKAGE BODY vcr.pkg_bloomberg AS

  ------------------------------------------------------------------------
  --  $Header: vcr/packages/pkg_bloomberg.plb 1.2 2005/10/21 17:14:20BST apenney DEV  $
  --------------------------------------------------------------------------
  --  A package to perform calculations specific to a target table
  -- e.g. calculate mtd ror for funds based on P&L position data
  ------------------------------------------------------------------------
 
  PROCEDURE set_request_status(p_request_id IN security_price_request.request_id%TYPE,
                               p_status     IN security_price_request.status%TYPE)
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.set_request_status', null);
        
    UPDATE security_price_request 
    SET    status     = p_status
    WHERE  request_id = p_request_id;
    
    COMMIT;
    
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Set status of Bloomberg price request '|| p_request_id ||' to ' || p_status);
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN    
      ROLLBACK;
      utl.pkg_errorhandler.handle;

      RAISE;
  END set_request_status;    
  
  -- deletes any matches thave been created for positions for this load run
  
  PROCEDURE purge_matches(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_as_of_date       DATE;
    v_source_id        source.source_id%TYPE;
    v_basis            source_basis.basis%TYPE;
    
    v_count            NUMBER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.purge_matches', null);
        
    SELECT slr.as_of_date,
           slr.source_id,
           slr.basis
    INTO   v_as_of_date,
           v_source_id,
           v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id = p_load_run_id;      
       
    DELETE 
    FROM   source_position_security_price spsp
    WHERE  EXISTS (SELECT sp.key
                   FROM   source_position sp
                   WHERE  sp.as_of_date  = v_as_of_date
                   AND    sp.source_id   = v_source_id
                   AND    sp.basis       = v_basis
                   AND    sp.load_run_id = p_load_run_id
                   AND    sp.as_of_date  = spsp.as_of_date
                   AND    sp.source_id   = spsp.source_id
                   AND    sp.basis       = spsp.basis
                   AND    sp.key         = spsp.key
                   AND    sp.seq_id      = spsp.seq_id)
    AND    spsp.as_of_date = v_as_of_date
    AND    spsp.source_id  = v_source_id
    AND    spsp.basis      = v_basis;

    v_count := SQL%ROWCOUNT;
    
    COMMIT;
    
    IF v_count <> 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Purged ' || v_count || ' matches between positions and Bloomberg prices for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
     
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN    
      ROLLBACK;
      utl.pkg_errorhandler.handle;

      RAISE;
  END purge_matches;
  
  -- match prices to position
  -- in each case we only match successfully retrieved prices
  -- positions that have been matched already are ignored 
  -- matching is done in isin, cusp, sedol then bloomberg ticker precedence
  -- if multiple prices have been obtained the latest is used
  PROCEDURE match_to_positions(p_load_run_id IN source_load_run.load_run_id%TYPE)
  AS
    v_as_of_date       DATE;
    v_source_id        source.source_id%TYPE;
    v_basis            source_basis.basis%TYPE;
    
    v_count            NUMBER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.match_to_positions', null);
    
    SELECT slr.as_of_date,
           slr.source_id,
           slr.basis
    INTO   v_as_of_date,
           v_source_id,
           v_basis
    FROM   source_load_run slr
    WHERE  slr.load_run_id = p_load_run_id;      
    
    -- match isin prices to positions
    INSERT
    INTO   source_position_security_price
    (
           as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    )
    SELECT as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    FROM
    (
      SELECT sp.as_of_date,
             sp.source_id,
             sp.basis,
             sp.key,
             sp.seq_id,
             pr.request_id,
             pr.request_seq,
             (row_number() over (partition by sp.as_of_date, sp.source_id, sp.basis, sp.key, sp.seq_id order by pr.request_id desc)) as request_order
      FROM   source_position sp, security_price pr, source_market sm, source_position_security_price existing_map
      WHERE  sp.as_of_date   = v_as_of_date -- for all positions in this load run with an isin
      AND    sp.source_id    = v_source_id
      AND    sp.basis        = v_basis
      AND    sp.load_run_id  = p_load_run_id
      AND    sp.isin         IS NOT NULL
      AND    sp.source_id    = sm.source_id (+) -- get the mapped exchange code if there is one
      AND    sp.market_name  = sm.market_name (+)
      AND    sp.isin||decode(sm.exchange_code,null,null,' '||sm.exchange_code) = pr.security_code -- combine with isin prices using the exchange code if we found one
      AND    sp.as_of_date   = pr.as_of_date
      AND    pr.return_code  = vcr.pkg_bloomberg.gc_return_code_success -- if the price has been successfully retrieved
      AND    pr.price        IS NOT NULL
      AND    pr.security_code_type = vcr.pkg_bloomberg.gc_security_code_type_isin
      AND    sp.source_id    = existing_map.source_id (+) -- if the position is not already mapped to a price
      AND    sp.as_of_date   = existing_map.as_of_date (+)
      AND    sp.basis        = existing_map.basis (+)
      AND    sp.key          = existing_map.key (+)
      AND    sp.seq_id       = existing_map.seq_id (+)
      AND    existing_map.request_seq IS NULL
    ) 
    WHERE request_order = 1;
    
    v_count := v_count + SQL%ROWCOUNT;
    
    -- match cusip prices to positions
    INSERT
    INTO   source_position_security_price
    (
           as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    )
    SELECT as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    FROM
    (
      SELECT sp.as_of_date,
             sp.source_id,
             sp.basis,
             sp.key,
             sp.seq_id,
             pr.request_id,
             pr.request_seq,
             (row_number() over (partition by sp.as_of_date, sp.source_id, sp.basis, sp.key, sp.seq_id order by pr.request_id desc)) as request_order
      FROM   source_position sp, security_price pr, source_position_security_price existing_map
      WHERE  sp.as_of_date   = v_as_of_date -- for all positions in this load run with a cusip
      AND    sp.source_id    = v_source_id
      AND    sp.basis        = v_basis
      AND    sp.load_run_id  = p_load_run_id
      AND    sp.cusip         IS NOT NULL
      AND    sp.cusip        = pr.security_code -- combine with cusip prices
      AND    sp.as_of_date   = pr.as_of_date
      AND    pr.return_code  = vcr.pkg_bloomberg.gc_return_code_success -- if the price has been successfully retrieved
      AND    pr.price        IS NOT NULL
      AND    pr.security_code_type = vcr.pkg_bloomberg.gc_security_code_type_cusip
      AND    sp.source_id    = existing_map.source_id (+) -- if the position is not already mapped to a price
      AND    sp.as_of_date   = existing_map.as_of_date (+)
      AND    sp.basis        = existing_map.basis (+)
      AND    sp.key          = existing_map.key (+)
      AND    sp.seq_id       = existing_map.seq_id (+)
      AND    existing_map.request_seq IS NULL
    ) 
    WHERE request_order = 1;
    
    v_count := v_count + SQL%ROWCOUNT;

    -- match sedol prices to positions
    INSERT
    INTO   source_position_security_price
    (
           as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    )
    SELECT as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    FROM
    (
      SELECT sp.as_of_date,
             sp.source_id,
             sp.basis,
             sp.key,
             sp.seq_id,
             pr.request_id,
             pr.request_seq,
             (row_number() over (partition by sp.as_of_date, sp.source_id, sp.basis, sp.key, sp.seq_id order by pr.request_id desc)) as request_order
      FROM   source_position sp, security_price pr, source_position_security_price existing_map
      WHERE  sp.as_of_date   = v_as_of_date -- for all positions in this load run with a sedol
      AND    sp.source_id    = v_source_id
      AND    sp.basis        = v_basis
      AND    sp.load_run_id  = p_load_run_id
      AND    sp.sedol         IS NOT NULL
      AND    sp.sedol        = pr.security_code -- combine with sedol prices
      AND    sp.as_of_date   = pr.as_of_date
      AND    pr.return_code  = vcr.pkg_bloomberg.gc_return_code_success -- if the price has been successfully retrieved
      AND    pr.price        IS NOT NULL
      AND    pr.security_code_type = vcr.pkg_bloomberg.gc_security_code_type_sedol
      AND    sp.source_id    = existing_map.source_id (+) -- if the position is not already mapped to a price
      AND    sp.as_of_date   = existing_map.as_of_date (+)
      AND    sp.basis        = existing_map.basis (+)
      AND    sp.key          = existing_map.key (+)
      AND    sp.seq_id       = existing_map.seq_id (+)
      AND    existing_map.request_seq IS NULL
    ) 
    WHERE request_order = 1;
    
    v_count := v_count + SQL%ROWCOUNT;

    -- match ticker prices to positions
    INSERT
    INTO   source_position_security_price
    (
           as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    )
    SELECT as_of_date,
           source_id,
           basis,
           key,
           seq_id,
           request_id,
           request_seq
    FROM
    (
      SELECT sp.as_of_date,
             sp.source_id,
             sp.basis,
             sp.key,
             sp.seq_id,
             pr.request_id,
             pr.request_seq,
             (row_number() over (partition by sp.as_of_date, sp.source_id, sp.basis, sp.key, sp.seq_id order by pr.request_id desc)) as request_order
      FROM   source_position sp, security_price pr, source_position_security_price existing_map
      WHERE  sp.as_of_date   = v_as_of_date -- for all positions in this load run with a bb ticker
      AND    sp.source_id    = v_source_id
      AND    sp.basis        = v_basis
      AND    sp.load_run_id  = p_load_run_id
      AND    sp.bloomberg_id IS NOT NULL
      AND    sp.bloomberg_id = pr.security_code -- combine with bb ticker prices
      AND    sp.as_of_date   = pr.as_of_date
      AND    pr.return_code   = vcr.pkg_bloomberg.gc_return_code_success -- if the price has been successfully retrieved
      AND    pr.price        IS NOT NULL
      AND    pr.security_code_type = vcr.pkg_bloomberg.gc_security_code_type_bbticker
      AND    sp.source_id    = existing_map.source_id (+) -- if the position is not already mapped to a price
      AND    sp.as_of_date   = existing_map.as_of_date (+)
      AND    sp.basis        = existing_map.basis (+)
      AND    sp.key          = existing_map.key (+)
      AND    sp.seq_id       = existing_map.seq_id (+)
      AND    existing_map.request_seq IS NULL
    ) 
    WHERE request_order = 1;
    
    v_count := v_count + SQL%ROWCOUNT;                
    
    COMMIT;
    
    IF v_count <> 0
    THEN
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Matched ' || v_count || ' positions to closing prices from Bloomberg for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
    END IF;
    
    -- gather stats on the subpartition just populated
    pkg_housekeeping.gather_run_table_stats(p_load_run_id,'source_position_security_price',null);
    
    dbms_application_info.set_module(null, null);
  EXCEPTION
    WHEN OTHERS THEN    
      ROLLBACK;
      utl.pkg_errorhandler.handle;

      RAISE;
  END match_to_positions; 
      
  FUNCTION generate_request(p_load_run_id IN source_load_run.load_run_id%TYPE) RETURN security_price_request.request_id%TYPE
  AS
    v_request_id       security_price_request.request_id%TYPE;
    
    v_last_sequence_id NUMBER;
    
    v_as_of_date       DATE;
    v_source_name      source.source_name%TYPE;
    v_source_id        source.source_id%TYPE;
    v_basis            source_basis.basis%TYPE;
        
    v_count            NUMBER := 0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.generate_request', null);  

    -- get a count of the number of requests so far for the source and as of date
    SELECT COUNT(*) 
    INTO   v_last_sequence_id
    FROM   security_price_request spr, source_load_run other_slr, source_load_run this_slr
    WHERE  spr.load_run_id      = other_slr.load_run_id
    AND    this_slr.load_run_id = p_load_run_id
    AND    this_slr.source_id   = other_slr.source_id
    AND    this_slr.as_of_date  = other_slr.as_of_date;
    
    SELECT slr.as_of_date,
           lower(s.source_name),
           slr.source_id,
           slr.basis
    INTO   v_as_of_date,
           v_source_name,
           v_source_id,
           v_basis
    FROM   source_load_run slr, source s
    WHERE  s.source_id     = slr.source_id
    AND    slr.load_run_id = p_load_run_id;      

    -- create the request
    INSERT
    INTO  security_price_request spr
    (
          spr.request_id,
          spr.load_run_id,
          request_file_name,
          response_file_name,
          request_date_time,
          status
    )
    VALUES
    ( 
          sq_security_price_request.nextval,
          p_load_run_id,
          'cp.'||v_source_name||'.'||to_char(v_as_of_date,'YYYYMMDD')||'.'||trim(leading ' ' from to_char(v_last_sequence_id+1,'009'))||'.req',
          'cp.'||v_source_name||'.'||to_char(v_as_of_date,'YYYYMMDD')||'.'||trim(leading ' ' from to_char(v_last_sequence_id+1,'009'))||'.resp',
           sysdate,
           vcr.pkg_bloomberg.gc_request_status_initial
    )
    RETURNING request_id INTO v_request_id;
     
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Initialised Bloomberg price request ' || v_request_id || ' for ' ||
                       pkg_source_load_run.get_description(p_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);   
                       
    -- create the request lines
    
    INSERT
    INTO   security_price sp
    (
           as_of_date,
           security_code,
           security_code_type,
           request_id,
           request_seq
    )
    SELECT v_as_of_date as_of_date,
           new_sp.security_code,
           new_sp.security_code_type,
           v_request_id request_id,
           rownum request_seq
    FROM
    (
      SELECT DISTINCT 
             decode(security_code.type, vcr.pkg_bloomberg.gc_security_code_type_isin,  position_codes.isin,
                                        vcr.pkg_bloomberg.gc_security_code_type_cusip, position_codes.cusip,
                                        vcr.pkg_bloomberg.gc_security_code_type_sedol, position_codes.sedol,
                                        vcr.pkg_bloomberg.gc_security_code_type_bbticker, position_codes.bbticker) security_code,
             security_code.type                                                                                    security_code_type
      FROM
      (
        SELECT DISTINCT decode(sp.isin,null,null,sp.isin||decode(sm.exchange_code,null,null,' '||sm.exchange_code)) isin, sp.cusip, sp.sedol, sp.bloomberg_id bbticker
        FROM   source_position sp, source_position_security_price existing_map, source_market sm
        WHERE  sp.as_of_date  = v_as_of_date                -- for all positions for the load run
        AND    sp.source_id   = v_source_id
        AND    sp.basis       = v_basis
        AND    sp.load_run_id = p_load_run_id
        AND    sp.market_name = sm.market_name (+)          -- get the source market
        AND    sp.source_id   = sm.source_id (+)
        AND    sp.source_id    = existing_map.source_id (+) -- if the position is not already mapped to a price
        AND    sp.as_of_date   = existing_map.as_of_date (+)
        AND    sp.basis        = existing_map.basis (+)
        AND    sp.key          = existing_map.key (+)
        AND    sp.seq_id       = existing_map.seq_id (+)
        AND    existing_map.request_seq IS NULL
      ) position_codes,
      (
        SELECT vcr.pkg_bloomberg.gc_security_code_type_isin type
        FROM  DUAL
        UNION
        SELECT vcr.pkg_bloomberg.gc_security_code_type_cusip type
        FROM  DUAL
        UNION
        SELECT vcr.pkg_bloomberg.gc_security_code_type_sedol type
        FROM  DUAL
        UNION
        SELECT vcr.pkg_bloomberg.gc_security_code_type_bbticker type
        FROM  DUAL
      ) security_code
      WHERE (position_codes.isin IS NOT NULL AND security_code.type = vcr.pkg_bloomberg.gc_security_code_type_isin)
      OR    (position_codes.cusip IS NOT NULL AND security_code.type = vcr.pkg_bloomberg.gc_security_code_type_cusip)
      OR    (position_codes.sedol IS NOT NULL AND security_code.type = vcr.pkg_bloomberg.gc_security_code_type_sedol)
      OR    (position_codes.bbticker IS NOT NULL AND security_code.type = vcr.pkg_bloomberg.gc_security_code_type_bbticker)
    ) new_sp, -- list of security codes for positions not mapped to any price
    (
     SELECT pr.security_code,
            pr.security_code_type
     FROM   security_price pr
     WHERE  pr.as_of_date = v_as_of_date
     AND    pr.return_code IS NOT NULL
    ) existing_sp -- list of security prices already requested for which a response has been received
    WHERE new_sp.security_code      = existing_sp.security_code (+)
    AND   new_sp.security_code_type = existing_sp.security_code_type (+)
    AND   existing_sp.security_code IS NULL;
 
    v_count := SQL%ROWCOUNT;
    
    COMMIT;    
    
    IF v_count = 0 -- if there are no prices needed cancel the request
    THEN
      set_request_status(v_request_id, pkg_bloomberg.gc_request_status_cancelled);
      
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Cancelled Bloomberg price request '||v_request_id||' - no prices required' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);
                         
      v_request_id := null; --- set the request id to null to signify no further action is required
    ELSE -- otherwise create the request file
      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Added ' || v_count || ' securities to Bloomberg price request '||v_request_id||' for ' ||
                         pkg_source_load_run.get_description(p_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         p_load_run_id);  
                  
      create_request_file(v_request_id);
    END IF;
    
    dbms_application_info.set_module(null, null);  
 
    RETURN v_request_id;
  EXCEPTION
    WHEN OTHERS THEN    
      ROLLBACK;
      utl.pkg_errorhandler.handle;

      RAISE;
  END generate_request;
  
  -- formats Bloomberg Data Licence request file for a specified request id
  PROCEDURE create_request_file(p_request_id IN security_price_request.request_id%TYPE)
  AS
    v_request_file_name  security_price_request.request_file_name%TYPE;
    v_response_file_name security_price_request.response_file_name%TYPE;
    v_as_of_date         DATE;
    v_load_run_id        source_load_run.load_run_id%TYPE;
    
    v_file_handle   utl_file.file_type;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.create_request_file', null);  

    SELECT spr.request_file_name, 
           slr.as_of_date, 
           spr.response_file_name, 
           spr.load_run_id
    INTO   v_request_file_name, 
           v_as_of_date, 
           v_response_file_name, 
           v_load_run_id
    FROM   security_price_request spr, source_load_run slr
    WHERE  spr.request_id  = p_request_id
    AND    spr.load_run_id = slr.load_run_id;
    
    -- open request file
    v_file_handle := utl_file.fopen(pkg_bloomberg.gc_outgoing_directory, v_request_file_name, 'w', 32767);

    -- format header
    utl_file.put_line(v_file_handle, 'START-OF-FILE');
    utl_file.put_line(v_file_handle, 'FIRMNAME='||utl.pkg_config.get_variable_string(pkg_bloomberg.gc_firm_name_config_key));
    utl_file.put_line(v_file_handle, 'PROGRAMFLAG=oneshot');
    utl_file.put_line(v_file_handle, 'REPLYFILENAME='||v_response_file_name);
    utl_file.put_line(v_file_handle, 'PROGRAMNAME=getdata');
    utl_file.put_line(v_file_handle, 'CLOSINGVALUES=yes');
    utl_file.new_line(v_file_handle);
    utl_file.put_line(v_file_handle, 'START-OF-FIELDS');            
    utl_file.put_line(v_file_handle, 'MHIS_CLOSE_ON_PX:'||to_char(v_as_of_date,'YYYYMMDD')||':P');
    utl_file.put_line(v_file_handle, 'CRNCY');
    utl_file.put_line(v_file_handle, 'ID_BB_UNIQUE');
    utl_file.put_line(v_file_handle, 'END-OF-FIELDS');            
    utl_file.new_line(v_file_handle);
    utl_file.put_line(v_file_handle, 'START-OF-DATA');            

    FOR rec_security_price IN (
                               SELECT   security_code, security_code_type, request_seq
                               FROM     security_price 
                               WHERE    request_id = p_request_id
                               AND      as_of_date = v_as_of_date
                               ORDER BY request_seq
                              )
    LOOP
      -- format two lines for each security
      -- comment line with sequence number
      utl_file.put_line(v_file_handle, '# '||rec_security_price.request_seq);
      -- security code 
      utl_file.put(v_file_handle, rec_security_price.security_code);
      -- and type (if not ticker)
      IF rec_security_price.security_code_type != pkg_bloomberg.gc_security_code_type_bbticker
      THEN
        utl_file.put(v_file_handle, '|'||rec_security_price.security_code_type);
      END IF;
      
      utl_file.new_line(v_file_handle);
    END LOOP;

    -- format footer records
    utl_file.put_line(v_file_handle, 'END-OF-DATA');    
    utl_file.put_line(v_file_handle, 'END-OF-FILE');    
  
    -- close file
    utl_file.fclose(v_file_handle);
    
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Create Bloomberg price request file ' || v_request_file_name || ' for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
                       
    -- set status to waiting
    set_request_status(p_request_id, pkg_bloomberg.gc_request_status_waiting);
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      
      utl_file.fclose(v_file_handle);
      
      set_request_status(p_request_id,pkg_bloomberg.gc_request_status_error);
      
      RAISE;
  END create_request_file;                      

  -- wait for Bloomberg Data Licence response file for a specified request id
  PROCEDURE process_response(p_request_id IN security_price_request.request_id%TYPE)
  AS
    v_response_file_name security_price_request.response_file_name%TYPE;
    v_as_of_date         DATE;
    v_load_run_id        source_load_run.load_run_id%TYPE;
    
    v_file_handle        utl_file.file_type;
    
    v_count              NUMBER:=0;
    
    v_poll_interval      NUMBER;
    v_poll_attempts      NUMBER;
    
    v_record             VARCHAR2(32767);
    
    v_request_seq        security_price.request_seq%TYPE;
    v_security_code      security_price.security_code%TYPE;
    v_currency           security_price.currency%TYPE;
    v_unique_security_id security_price.unique_security_id%TYPE;    
    v_return_code        security_price.return_code%TYPE;    
    v_price              security_price.price%TYPE;
    
    t_rec_fields         dbms_sql.varchar2s;
    
    v_timefinished       security_price_request.response_time_finished%TYPE;
    v_timestarted        security_price_request.response_time_started%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.process_response', null);  

    SELECT slr.as_of_date, 
           spr.response_file_name,
           spr.load_run_id
    INTO   v_as_of_date, 
           v_response_file_name,
           v_load_run_id
    FROM   security_price_request spr, source_load_run slr
    WHERE  spr.request_id  = p_request_id
    AND    spr.load_run_id = slr.load_run_id;
    
    v_poll_interval := nvl(utl.pkg_config.get_variable_int(pkg_bloomberg.gc_poll_interval_config_key),10);
    v_poll_attempts := nvl(utl.pkg_config.get_variable_int(pkg_bloomberg.gc_poll_attempts_config_key),6);
    
    LOOP 
      sys.dbms_lock.sleep(v_poll_interval);
      
      BEGIN 
        -- try to open response file
        v_file_handle := utl_file.fopen(pkg_bloomberg.gc_incoming_directory, v_response_file_name, 'r', 32767);
        
        EXIT;
      EXCEPTION
        WHEN utl_file.invalid_path OR utl_file.invalid_operation THEN -- on failure try again
          v_count := v_count + 1;
          utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                            'Polling attempt '||v_count||' failed for file '||v_response_file_name,
                            pkg_source_load_run.gc_log_message_parent_table,
                            v_load_run_id);
                                         
        WHEN OTHERS THEN -- handle other errors as normal but set request to ERROR
          utl.pkg_errorhandler.handle;
      
          RAISE;
      END;

      IF v_count > v_poll_attempts -- if all poll attempts are used up then log an error and set request to error
      THEN
        set_request_status(p_request_id,pkg_bloomberg.gc_request_status_error);
        utl.pkg_logger.log(utl.pkg_logger.gc_log_message_info,
                          'Polling attempt '||v_count||' failed for file '||v_response_file_name,
                          pkg_source_load_run.gc_log_message_parent_table,
                          v_load_run_id);
       
        EXIT;
      END IF; 
    END LOOP;        
    
    IF v_count <= v_poll_attempts -- if we have found the file
    THEN
      BEGIN
        LOOP -- read each record
          BEGIN
            utl_file.get_line(v_file_handle, v_record);
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              utl.pkg_errorhandler.log_error(utl.pkg_exceptions.gc_bb_format_err,
                                             'Bloomberg response file '||v_response_file_name||' not in expected format - processing of VSP data will continue without new price data from Bloomberg.',
                                             pkg_source_load_run.gc_log_message_parent_table,
                                             v_load_run_id);
            
              RAISE utl.pkg_exceptions.e_bb_format;
            WHEN OTHERS THEN 
              RAISE;
          END;
         
          IF substr(v_record,1,11) = 'TIMESTARTED' -- record the time the response generation started
          THEN 
            v_timestarted := substr(v_record,instr(v_record,'=')+1);
          END IF;
          
          IF v_record = 'START-OF-DATA' -- if we get to the start of the list of securities
          THEN            
            v_count := 0;
            
            LOOP
              utl_file.get_line(v_file_handle, v_record); -- read each record until the end-of-data record
                           
              IF v_record = 'END-OF-DATA'
              THEN
                EXIT;
              END IF;
                         
              -- extract the request seq number
              v_request_seq := to_number(substr(v_record,instr(v_record,'# ')+2));
              
              utl_file.get_line(v_file_handle, v_record);
  
              -- from the next record get all the fields
              t_rec_fields := utl.pkg_string.string2list(v_record,'|');
            
              v_security_code := t_rec_fields(1);
              v_return_code   := t_rec_fields(2);
              v_currency      := t_rec_fields(5);
              v_unique_security_id := t_rec_fields(6);
              
              -- if the price is unobtainable use null
              IF t_rec_fields(4) = pkg_bloomberg.gc_not_subscribed
              OR t_rec_fields(4) = pkg_bloomberg.gc_not_applicable
              OR t_rec_fields(4) = pkg_bloomberg.gc_not_available
              OR t_rec_fields(4) = pkg_bloomberg.gc_not_downloadable
              OR t_rec_fields(4) = pkg_bloomberg.gc_field_unknown
              THEN
                v_price := null;
              ELSE
                v_price := to_number(t_rec_fields(4));
              END IF;
              
              -- if we have a valid price
              IF v_price IS NOT NULL 
              THEN
                -- record the response 
                UPDATE security_price sp
                SET    sp.currency           = v_currency,
                       sp.price              = v_price,
                       sp.return_code        = v_return_code,
                       sp.unique_security_id = v_unique_security_id
                WHERE  sp.as_of_date         = v_as_of_date
                AND    sp.request_id         = p_request_id
                AND    sp.request_seq        = v_request_seq
                AND    sp.security_code      = v_security_code;
             
                -- if the update doesnt succeed log an error 
                IF SQL%ROWCOUNT <> 1
                THEN
                  utl.pkg_errorhandler.log_error(utl.pkg_exceptions.gc_bb_format_err,
                                                 'Security code '||v_security_code||' in response file '||v_response_file_name||' is not in the expected position ('||v_request_seq||') - processing of VSP data will continue without new price data from Bloomberg.',
                                                 pkg_source_load_run.gc_log_message_parent_table,
                                                 v_load_run_id);
                  
                  RAISE utl.pkg_exceptions.e_bb_format;
                END IF;
                
                v_count := v_count + 1; 
              END IF;
            END LOOP;
          END IF;
          
          IF substr(v_record,1,12) = 'TIMEFINISHED'
          THEN 
            v_timefinished := substr(v_record,instr(v_record,'=')+1);
          END IF;
          
          IF v_record = 'END-OF-FILE'
          THEN
            EXIT;
          END IF;
        END LOOP;
        
        -- if the file has not been as we expect log an error
        IF v_timestarted IS NULL
        OR v_timefinished IS NULL
        THEN
          utl.pkg_errorhandler.log_error(utl.pkg_exceptions.gc_bb_format_err,
                                         'Bloomberg response file '||v_response_file_name||' not in expected format - processing of VSP data will continue without new price data from Bloomberg.',
                                         pkg_source_load_run.gc_log_message_parent_table,
                                         v_load_run_id);
                                               
          RAISE utl.pkg_exceptions.e_bb_format;
        END IF;
        
        UPDATE security_price_request spr
        SET    spr.response_time_started  = v_timestarted,
               spr.response_time_finished = v_timefinished,
               spr.status                 = pkg_bloomberg.gc_request_status_complete
        WHERE  spr.request_id             = p_request_id;
        
        COMMIT;
        
        IF v_count <> 0
        THEN
          utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                             'Processed Bloomberg response file '||v_response_file_name||' loading '||v_count||' security prices for '||
                             pkg_source_load_run.get_description(v_load_run_id),
                             pkg_source_load_run.gc_log_message_parent_table,
                             v_load_run_id);
        END IF;
        
      EXCEPTION
        WHEN utl.pkg_exceptions.e_bb_format THEN
          ROLLBACK;
          set_request_status(p_request_id,pkg_bloomberg.gc_request_status_error);
        WHEN OTHERS THEN
          RAISE;
      END;

      utl_file.fclose(v_file_handle);
      
      -- move the file to the archive directory when we have the rights
      --utl_file.frename(pkg_bloomberg.gc_incoming_directory, v_response_file_name, pkg_bloomberg.gc_archive_directory, v_response_file_name);
    END IF;

    dbms_stats.gather_table_stats('vcr',
                                  'security_price',
                                  pkg_housekeeping.get_date_partition(v_as_of_date,'security_price'),
                                  dbms_stats.auto_sample_size,
                                  FALSE,
                                  'FOR ALL INDEXED COLUMNS SIZE SKEWONLY',
                                  NULL,
                                  'PARTITION',
                                  TRUE,
                                  NULL,
                                  NULL,
                                  NULL,
                                  FALSE);
                                  
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
    
      utl.pkg_errorhandler.handle;
      
      utl_file.fclose(v_file_handle);
      
      set_request_status(p_request_id,pkg_bloomberg.gc_request_status_error);
      
      RAISE;
  END process_response;    

  -- this procedure gets closing prices for positions for the latest load run for the parameter set
  PROCEDURE get_closing_prices(p_source_name IN source.source_name%TYPE,
                               p_basis       IN source_basis.basis%TYPE,
                               p_as_of_date  IN DATE) 
  AS
    v_load_run_id source_load_run.load_run_id%TYPE;
    
    v_request_id  security_price_request.request_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_bloomberg.get_closing_prices', null);  

    -- get the id of this load run
    v_load_run_id := pkg_source_load_run.get_load_run(p_source_name,
                                                      p_basis,
                                                      p_as_of_date);
  
    IF v_load_run_id IS NULL
    THEN
      raise_application_error(utl.pkg_exceptions.gc_no_load_run_err,
                              'No load run exists for ' || p_source_name ||', '||p_basis||', '||to_char(p_as_of_date,'dd-MON-yyyy'));
    END IF;
    
    pkg_source_load_run_mod.update_status(v_load_run_id,
                                          pkg_source_load_run.gc_run_status_in_progress);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Started getting closing prices for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
    
    -- do a prelim match to see how many positions can be matched to existing prices
    match_to_positions(v_load_run_id);  
    
    -- then figure out what prices we need to request and create the request file
    v_request_id := generate_request(v_load_run_id);
    
    -- no request id means that nofile has been created and there is no need to process a response
    IF v_request_id IS NOT NULL
    THEN
      -- wait for and process the response file
      process_response(v_request_id);
      -- match the new prices to unmatched positions
      match_to_positions(v_load_run_id);

      utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                         'Completed getting closing prices for ' ||
                         pkg_source_load_run.get_description(v_load_run_id),
                         pkg_source_load_run.gc_log_message_parent_table,
                         v_load_run_id);
    END IF;
    
    dbms_application_info.set_module(null, null);  
  EXCEPTION
    WHEN OTHERS THEN    
      utl.pkg_errorhandler.handle;
      pkg_source_load_run_mod.log_sqlerror(v_load_run_id);

      RAISE;
    
  END get_closing_prices;
END pkg_bloomberg;
/
