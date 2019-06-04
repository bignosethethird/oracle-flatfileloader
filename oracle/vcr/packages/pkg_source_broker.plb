create or replace package body vcr.pkg_source_broker as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source_broker.plb 1.3 2005/09/27 13:15:44BST apenney DEV  $
------------------------------------------------------------------------------

  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list(p_broker          in source_broker.broker%type,
                    p_source_id       in source_broker.source_id%type,
                    p_prime_broker_id in source_broker.prime_broker_id%type)
  return utl.global.t_result_set 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
      select b.broker,
             s.source_name,
             decode(b.prime_broker_id,
                    null,utl.pkg_constants.gc_unmapped_desc,
                    p.description),
             b.source_broker_id
        from source_broker b, source s, prime_broker p
        WHERE  b.source_id = s.source_id
        AND    b.prime_broker_id = p.prime_broker_id (+)
        AND    ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
        AND    ((p_broker IS NULL) OR
               (p_broker IS NOT NULL and b.broker LIKE p_broker))
        AND    ((p_prime_broker_id IS NULL) OR
               (p_prime_broker_id = to_number(utl.pkg_constants.gc_unmapped_key) AND b.prime_broker_id IS NULL) OR
                (p_prime_broker_id IS NOT NULL AND b.prime_broker_id = p_prime_broker_id)              )
        order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count(p_broker         in source_broker.broker%type,
                     p_source_id       in source_broker.source_id%type,
                     p_prime_broker_id in source_broker.prime_broker_id%type) 
  return integer 
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    select count(*) 
      into v_count
      from source_broker b, source s, prime_broker p
      WHERE  b.source_id = s.source_id
      AND    b.prime_broker_id = p.prime_broker_id (+)
      AND    ((p_source_id IS NULL) OR (s.source_id = p_source_id AND p_source_id IS NOT NULL))
      AND    ((p_broker IS NULL) OR
               (p_broker IS NOT NULL and b.broker LIKE p_broker))
       AND    ((p_prime_broker_id IS NULL) OR
               (p_prime_broker_id = to_number(utl.pkg_constants.gc_unmapped_key) AND b.prime_broker_id IS NULL) OR
                (p_prime_broker_id IS NOT NULL AND b.prime_broker_id = p_prime_broker_id)              );
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_source_broker_id IN source_broker.source_broker_id%TYPE) 
  return utl.global.t_result_set 
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
      select b.broker,
             b.source_broker_id,
             s.source_name,
             b.prime_broker_id
        from source_broker b, source s            
       where b.source_id = s.source_id
         and b.source_broker_id = p_source_broker_id;
     dbms_application_info.set_module(null, null);      
     return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
  
  -- returns a ref cursor for a result set of source brokers with the following columns
  --         source_broker.source_broker_id
  --         source_broker.broker
  -- Parameters:
  --         p_source_id mandatory id of source 
  -- used in position and exception list screens
  FUNCTION get_dropdown_list(p_source_id IN source.source_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_broker_list utl.global.t_result_set;
  BEGIN                 
    dbms_application_info.set_module('vcr.pkg_source_broker.get_dropdown_list',null);
    
    OPEN cur_broker_list FOR
      SELECT sb.source_broker_id,
             sb.broker
      FROM   source_broker   sb
      WHERE  sb.source_id = p_source_id
      ORDER BY sb.broker;
  
    dbms_application_info.set_module(null,null);
    
    RETURN cur_broker_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_list;

  -- returns a count of brokers which meet the parameter criteria
  -- Parameters:
  --         p_source_id mandatory id of source providing data 
  -- used in position and exception list screens
  FUNCTION get_dropdown_count(p_source_id IN source.source_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source_broker.get_dropdown_count',null);
    
    SELECT COUNT(*)
    INTO   v_count
    FROM   source_broker   sb
    WHERE  sb.source_id = p_source_id;
    
    dbms_application_info.set_module(null,null);
    
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_count;
end pkg_source_broker;
/
