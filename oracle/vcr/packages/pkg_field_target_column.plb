create or replace package body vcr.pkg_field_target_column as
------------------------------------------------------------------------------
-- $Header: vcr/packages/pkg_field_target_column.plb 1.2 2005/09/27 13:16:07BST apenney DEV  $
------------------------------------------------------------------------------
  
  -- GUI Interface
  -- Gets resultset that fit search criteria.
  -- If no search criteria are specified, returns the entire recordset.
  -- Where necessary, we break long strings up with carriage returns.
  function get_list(p_file_type                  in field_target_column.file_type%type,        
                    p_field_name                 in field_target_column.field_name%type,       
                    p_table_name                 in field_target_column.table_name%type,       
                    p_column_name                in field_target_column.column_name%type)
  return utl.global.t_result_set 
  is
    c_proc_name constant varchar2(100) := pc_schema||'.'||pc_package||'.get_list';
    cur_list    utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);        
    open cur_list for    
       select f.file_type,
              f.field_name,              
              f.table_name,
              f.column_name,              
              decode(ft.accounting_period_field, null, null, nvl(f.accounting_period,'ALL')),
              f.in_unique_key              
         from field_target_column f, file_type ft
        where (p_file_type is null or f.file_type = p_file_type)
          and (p_field_name is null or f.field_name = p_field_name)
          and (p_table_name is null or f.table_name = p_table_name)
          and (p_column_name is null or f.column_name = p_column_name)
          and f.file_type = ft.file_type
       order by 4,1,2 asc;
    dbms_application_info.set_module(null, null);      
    return cur_list; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_list;
  
  function get_count(p_file_type                  in field_target_column.file_type%type,        
                     p_field_name                 in field_target_column.field_name%type,       
                     p_table_name                 in field_target_column.table_name%type,       
                     p_column_name                in field_target_column.column_name%type)
  return integer 
  is
    c_proc_name constant varchar2(100) := pc_schema||'.'||pc_package||'.get_count';
    v_count     integer;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    select count(*)
      into v_count
      from field_target_column f
     where (p_file_type is null or f.file_type = p_file_type)
          and (p_field_name is null or f.field_name = p_field_name)
          and (p_table_name is null or f.table_name = p_table_name)
          and (p_column_name is null or f.column_name = p_column_name);
    dbms_application_info.set_module(null, null);      
    return v_count; 
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;
  end get_count;
  
  function get_detail(p_file_type                in field_target_column.file_type%type,        
                    p_field_name                 in field_target_column.field_name%type,       
                    p_table_name                 in field_target_column.table_name%type,       
                    p_column_name                in field_target_column.column_name%type)
  return utl.global.t_result_set 
  is 
    c_proc_name constant varchar2(100) := pc_schema||'.'||pc_package||'.get_detail';
    cur_detail  utl.global.t_result_set;
  begin
    dbms_application_info.set_module(c_proc_name, null);    
    open cur_detail for
       select ftc.file_type,
              ftc.field_name,              
              ftc.table_name,
              ftc.column_name,
              ftc.accounting_period,
              ftc.in_unique_key,
              ft.accounting_period_field
         from field_target_column ftc, file_type ft
        where ftc.file_type = p_file_type
          and ftc.field_name = p_field_name
          and ftc.table_name = p_table_name
          and ftc.column_name = p_column_name
          and ftc.file_type = ft.file_type;
    dbms_application_info.set_module(null, null);      
    return cur_detail;
  exception
    when others then
      utl.pkg_errorhandler.handle;
      utl.pkg_errorhandler.log_sqlerror(p_incident=>false);
      raise;  
  end get_detail;
end pkg_field_target_column;
/
