CREATE OR REPLACE PACKAGE BODY
-------------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_source.plb 1.20 2005/09/27 13:15:57BST apenney DEV  $
-------------------------------------------------------------------------------------
-- Allows you to query source info

vcr.pkg_source AS
  
  -- returns comma delimited list of the source_file_ids that are valid for the parameter source_name
  function get_source_file_types(p_source_name in source.source_name%type) return varchar2
  is
    t_source_file_types dbms_sql.varchar2_table;
    
    i pls_integer := 0;
  begin
    dbms_application_info.set_module('vcr.pkg_source.get_source_file_types',null);

    for rec_source_file_type in (select sft.source_file_type
                                 from   source_file_type sft, source s
                                 where  upper(s.source_name) = upper(p_source_name)
                                 and    sft.source_id = s.source_id)
    loop
      i := i + 1;
      
      t_source_file_types(i) := rec_source_file_type.source_file_type;
    end loop;
    
    dbms_application_info.set_module(null,null);
                            
    return utl.pkg_string.table2string(t_source_file_types);
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror;   
      raise; 
  end get_source_file_types;

  -- Retuns a PIPE-delimited list of the following:
  -- Frieldly source name
  -- no_data_files
  -- col_delimiter
  -- line_delimiter
  -- skip_lines_to_header
  -- data_descriptor
  --   - for the source_file_id. This relates directly to an actual part of the 
  --     loaded file name, hence it is CaSeSeNsItIvE
  function get_source_details(p_source_file_type in source_file_type.source_file_type%type,
                              p_source_name      in source.source_name%type
  ) return varchar2 
  is
    v_details varchar2(400);
  begin
    dbms_application_info.set_module('vcr.pkg_source.get_source_details',null);
    select s.source_name||'|'||
           sft.no_of_files||'|'||
           ft.delimiter||'|'||
           ft.end_of_line||'|'||
           ft.ignore_records||'|'||
           lower(ft.document_name)||'|'||
           ft.date_format||'|'||
           ft.string_encloser
      into v_details
      from source s 
     inner join source_file_type sft on s.source_id = sft.source_id
     inner join file_type ft on ft.file_type = sft.file_type
     where upper(s.source_name) = upper(p_source_name)
       and sft.source_file_type = p_source_file_type;
    dbms_application_info.set_module(null,null);
    return v_details;
  exception
    when no_data_found then
      return null;
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror;   
      raise;
  end get_source_details;
  
  
  -- GUI Interface   
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list
  return utl.global.t_result_set
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
      select s.source_name,
             nvl(s.email_address,'Undefined'),
             nvl(s.secure_message_id,'Undefined'),
             s.tplus1_offset,
             s.source_id
        from source s
       order by 1 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  
  function get_count
  return integer
  is
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    select count(*)
      into v_count
      from source;
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_source_id in source.source_id%type)
  return utl.global.t_result_set
  is 
    c_proc_name  constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
      select s.source_name,
             s.email_address,
             s.secure_message_id,
             s.tplus1_offset
        from source s
       where s.source_id = p_source_id;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;  
  
  -- Dropdown lists 
  -- returns a ref cursor for a result set of the id and name of all sources
  -- for use in dropdown lists in user interface
  FUNCTION get_dropdown_list RETURN utl.global.t_result_set 
  AS
    cur_source_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_dropdown_list',null);

    OPEN cur_source_list FOR
      SELECT source_id, source_name FROM source ORDER BY 2;
  
    dbms_application_info.set_module(null,null);

    RETURN cur_source_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_list;
  
  -- returns a count of the number of sources
  FUNCTION get_dropdown_count RETURN INTEGER 
  AS
    v_count INTEGER:=0;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_dropdown_count',null);

    SELECT COUNT(*)
    INTO   v_count 
    FROM source;
  
    dbms_application_info.set_module(null,null);

    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_dropdown_count;
  
  -- returns count of the valid source file types for a source_id
  FUNCTION get_file_type_dropdown_count(p_source_id IN source.source_id%TYPE) RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_file_type_dropdown_count',null);

    SELECT COUNT(*)
    INTO   v_count
    FROM   source_file_type 
    WHERE  ((p_source_id is null) or (p_source_id is not null and source_id = p_source_id));
  
    dbms_application_info.set_module(null,null);
  
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_file_type_dropdown_count;
   
  -- returns dropdown list of the valid source file types for a source_id
  FUNCTION get_file_type_dropdown_list(p_source_id IN source.source_id%TYPE) RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_file_type_dropdown_list',null);

    OPEN cur_list FOR
      SELECT source_file_type, source_file_type||' ('||file_type||')' 
      FROM   source_file_type 
      WHERE  ((p_source_id is null) or (p_source_id is not null and source_id = p_source_id))
      ORDER BY source_file_type;
  
    dbms_application_info.set_module(null,null);
  
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_file_type_dropdown_list;

  -- returns count of the valid source basii
  FUNCTION get_basis_dropdown_count RETURN INTEGER
  AS
    v_count INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_basis_dropdown_count',null);

    SELECT COUNT(*)
    INTO   v_count
    FROM   source_basis;
  
    dbms_application_info.set_module(null,null);
  
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_basis_dropdown_count;
   
  -- returns dropdown list of source basii
  FUNCTION get_basis_dropdown_list RETURN utl.global.t_result_set
  AS
    cur_list utl.global.t_result_set;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_basis_dropdown_list',null);

    OPEN cur_list FOR
      SELECT sb.basis, sb.description
      FROM   source_basis sb 
      ORDER BY sb.description;
  
    dbms_application_info.set_module(null,null);
  
    RETURN cur_list;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>FALSE);
    
      RAISE;
  END get_basis_dropdown_list;
  
    -- returns name of source for parameter source id
  FUNCTION get_source_name(p_source_id IN source.source_id%TYPE) RETURN VARCHAR2
  AS
    v_source_name source.source_name%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_source.get_source_name',null);

    SELECT source_name
    INTO   v_source_name
    FROM   source
    WHERE  source_id = p_source_id;

    dbms_application_info.set_module(null,null);
    
    RETURN v_source_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_source_name;
END pkg_source;
/
