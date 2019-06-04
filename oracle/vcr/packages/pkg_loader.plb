CREATE OR REPLACE PACKAGE BODY vcr.pkg_loader AS
  ------------------------------------------------------------------------------------------------------
  -- $Header: vcr/packages/pkg_loader.plb 1.17.1.2.1.5 2005/10/17 16:01:04BST apenney DEV  $
  ------------------------------------------------------------------------------------------------------
  --  A package to load source data from a staging area to specific table where the data is persisted
  ------------------------------------------------------------------------------------------------------

  -- formats which columns need to be populated by insert or merge
  PROCEDURE get_target_col(p_insert_cols      IN OUT CLOB,
                           p_update_cols      IN OUT CLOB,
                           p_values_cols      IN OUT CLOB,
                           p_column_name      IN target_column.column_name%TYPE,
                           p_acc_period       IN field_target_column.accounting_period%TYPE,
                           p_acc_period_field IN file_type.accounting_period_field%TYPE) 
  AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_target_col',null);
    
    -- if this is a column on the target table add it to the list of columns to be inserted to
    IF p_column_name IS NOT NULL
    THEN
      p_insert_cols := p_insert_cols || ',t.' || p_column_name;
    
      IF p_acc_period_field IS NOT NULL -- if the file is by accounting period
      THEN
        IF p_acc_period IS NOT NULL -- and this field is accounting period specific 
        THEN
          -- format the merge update clause
          p_update_cols := p_update_cols || ',t.' || p_column_name ||
                           ' = nvl(s.' || p_column_name || ',t.' ||
                           p_column_name || ')';
        END IF;
      
        -- format the merge insert clause
        p_values_cols := p_values_cols || ',s.' || p_column_name;
      END IF;
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_target_col;

  -- format assignment of any fields in staging area that are not mapped to a column on the target table
  -- as a fragment of xml to be written to the target tables unmapped_attributes column
  PROCEDURE get_unmapped_col(p_unmapped_cols    IN OUT CLOB,
                             p_column_name      IN field_target_column.column_name%TYPE,
                             p_field_name       IN field_target_column.field_name%TYPE,
                             p_acc_period_field IN file_type.accounting_period_field%TYPE) 
  AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_unmapped_col',null);
    
    IF p_column_name IS NULL -- if the field is not mapped to a column
       AND p_field_name IS NOT NULL -- if the field is in the staging area and is not the accounting period field
       AND
       (p_acc_period_field IS NULL OR p_field_name != p_acc_period_field)
    THEN
      p_unmapped_cols := p_unmapped_cols || '||''|' || p_field_name ||
                         '=''||pkg_loader.get_value(''' ||
                         p_field_name || ''',ssa.staging_record)';
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_unmapped_col;

  -- format assignment of any fields in staging area that are mapped to be in the unique key 
  -- as a delimited list of name value pairs
  -- to be written to the target tables key field  

  PROCEDURE get_unique_col(p_unique_cols   IN OUT CLOB,
                           p_column_name   IN field_target_column.column_name%TYPE,
                           p_field_name    IN field_target_column.field_name%TYPE,
                           p_in_unique_key IN field_target_column.in_unique_key%TYPE) 
  AS
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_unique_col',null);
    
    IF p_column_name IS NOT NULL -- if the field is mapped to a column
       AND p_in_unique_key = 'Y' -- if this field is part of the unique key
    THEN
      -- if the field is in the staging area
      IF p_field_name IS NOT NULL
      THEN
        p_unique_cols := p_unique_cols || '||''|' || p_column_name ||
                         '=''||pkg_loader.get_value(''' ||
                         p_field_name || ''',ssa.staging_record)';
      ELSE
        -- not in the staging area format empty element 
        p_unique_cols := p_unique_cols || '||''|' || p_column_name || '=''';
      END IF;
    END IF;
    
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_unique_col;

  -- format the list of columns to be selected from source_staging_area that corresponds to the list of target columns
  -- also formats the assignment of any fields with invalid type to a invalid_type_attributes column

  PROCEDURE get_mapped_col(p_mapped_cols       IN OUT CLOB,
                           p_invalid_type_cols IN OUT CLOB,
                           p_column_name       IN field_target_column.column_name%TYPE,
                           p_field_name        IN field_target_column.field_name%TYPE,
                           p_acc_period        IN field_target_column.accounting_period%TYPE,
                           p_acc_period_field  IN file_type.accounting_period_field%TYPE,
                           p_data_type         IN all_tab_columns.data_type%TYPE,
                           p_date_format       IN file_type.date_format%TYPE,
                           p_check_type        IN file_type.check_type%TYPE) 
  AS
    v_extract     VARCHAR2(4000);
    v_mapped_col  VARCHAR2(4000);
    v_invalid_col VARCHAR2(4000);
    
    v_typecheck_yn VARCHAR2(5);
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_mapped_col',null);
    
    v_typecheck_yn := upper(p_check_type);
    
    -- if the field is mapped to a column
    IF p_column_name IS NOT NULL
    THEN
      IF p_field_name IS NOT NULL -- if the field is in the staging area
      THEN
        -- if the file type is defined to not be by accounting period
        -- or this file is by accounting period but the field is not accounting field specific
        IF (p_acc_period IS NULL AND p_acc_period_field IS NOT NULL)
           OR p_acc_period_field IS NULL
        THEN
          v_extract := 'pkg_loader.get_value(''' || p_field_name ||
                       ''',ssa.staging_record)';
        ELSE
          -- by accounting period
          -- field mapping specific to accounting period e.g. PnL to MTD PnL
          -- assign the value if the column mapping accounting period maps that of the record selected
          v_extract := 'decode(pkg_loader.get_value(''' ||
                       p_acc_period_field || ''',ssa.staging_record),''' ||
                       p_acc_period || ''',pkg_loader.get_value(''' ||
                       p_field_name || ''',ssa.staging_record),null)';
        END IF;
      
        IF  p_data_type = 'NUMBER'
        THEN
          IF v_typecheck_yn = 'Y'
          THEN
            v_mapped_col := 'pkg_checker.to_number_or_null(' ||
                          v_extract || ')';
          
            v_invalid_col := 'pkg_checker.is_a_number(' || v_extract || ')';
          ELSE
            v_mapped_col := 'to_number('||v_extract||')';
          END IF;
        ELSIF p_data_type = 'DATE'
        THEN
          IF v_typecheck_yn = 'Y'
          THEN
            v_mapped_col := 'pkg_checker.to_date_or_null(' ||
                          v_extract || ',''' || p_date_format || ''')';
          
            v_invalid_col := 'pkg_checker.is_a_date(' || v_extract ||
                           ',''' || p_date_format || ''')';
          ELSE
            v_mapped_col := 'to_date('||v_extract||',''' || p_date_format || ''')';
          END IF;
        ELSE
          v_mapped_col := v_extract;
        END IF;
      
        p_mapped_cols := p_mapped_cols || ',' || v_mapped_col || ' ' ||
                         p_column_name;
      
        IF (p_data_type = 'DATE' OR p_data_type = 'NUMBER') 
        AND v_typecheck_yn = 'Y'
        THEN
          --null;
          p_invalid_type_cols := p_invalid_type_cols || '||decode(' ||
                                 v_invalid_col || ',0,''|' || p_field_name ||
                                 '=''||' || v_extract || ',null)';
        END IF;
      ELSE
        -- field not present - therefore set column to be null
        p_mapped_cols := p_mapped_cols || ',null ' || p_column_name;
      END IF;
    END IF;

    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_mapped_col;

  -- extracts value of field from staging record
  FUNCTION get_value(p_field_name IN VARCHAR2, p_record IN VARCHAR2)
    RETURN VARCHAR2 PARALLEL_ENABLE DETERMINISTIC AS
    v_start_name BINARY_INTEGER;
    v_start_val  BINARY_INTEGER;
    v_end_val    BINARY_INTEGER;
    v_length     BINARY_INTEGER;
  BEGIN  
    -- get starting position of field name assuming it is not the first field and hence is preceded with the delimiter 
  
    v_start_name := instr(p_record,
                          '|' || p_field_name || '=');
  
    -- if the field is not found, the field must be the first one and therefore not preceded by the delimiter 
  
    IF v_start_name = 0
    THEN
      v_start_name := instr(p_record,
                            p_field_name || '=');
    
      IF v_start_name <> 1 -- if the position of the field name is not at the beginning of the record then it is not the right field
      THEN
        RETURN NULL; -- return nothing
      END IF;
    ELSE
      v_start_name := v_start_name + 1; -- increment start pos 1 to skip delimiter
    END IF;
  
    v_start_val := instr(p_record,
                         '=',
                         v_start_name); -- search for the position of the equals sign after the field name
  
    IF v_start_val = 0 -- if we dont find one return nothing
    THEN
      RETURN NULL;
    ELSE
      -- if we do skip to the start of the value
      v_start_val := v_start_val + 1;
    END IF;
  
    -- gets end position of value by looking for the first delimiter after the value start
    v_end_val := instr(p_record, '|', v_start_val);
  
    -- if this is the last value in the record set the end position accordingly
    IF v_end_val = 0
    THEN
      v_end_val := length(p_record) + 1;
    END IF;
  
    v_length := v_end_val - v_start_val;
  
    RETURN substr(p_record, v_start_val, v_length);
  END get_value;

  -- creates a nested table listing the field names found in the file 
  FUNCTION get_field_names(p_load_run_id IN source_load_run.load_run_id%TYPE,
                           p_file_id     IN source_load_run_file.file_id%TYPE,
                           p_file_type   IN source_load_run_file.file_type%TYPE)
    RETURN utl.t_varchar2 AS
    v_staging_record CLOB;
    t_field_names    utl.t_varchar2 := utl.t_varchar2();
    v_field_start    BINARY_INTEGER := 0;
    v_field_count    BINARY_INTEGER := 0;
    v_field_end      BINARY_INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_field_names',null);
    
    BEGIN
      SELECT ssa.staging_record
      INTO   v_staging_record
      FROM   source_staging_area ssa, source_load_run_file slrf, source_file_type sft, source_load_run slr
      WHERE  slr.load_run_id      = p_load_run_id
      AND    sft.source_id        = slr.source_id
      AND    sft.file_type        = p_file_type
      AND    ssa.source_file_type = sft.source_file_type
      AND    ssa.file_id          = p_file_id
      AND    rownum               = 1;
    EXCEPTION
      WHEN no_data_found THEN
        dbms_application_info.set_module(null,null);

        RETURN NULL;
    END;
  
    LOOP
      IF v_field_start = 0
      THEN
        v_field_end := instr(v_staging_record, utl.pkg_constants.gc_equals);
      ELSE
        v_field_end := instr(v_staging_record,
                             utl.pkg_constants.gc_equals,
                             v_field_start);
      END IF;
    
      IF v_field_end = 0
      THEN
        EXIT;
      END IF;
    
      v_field_count := v_field_count + 1;
      v_field_start := v_field_start + 1;
      t_field_names.EXTEND(1);
      t_field_names(v_field_count) := substr(v_staging_record,
                                             v_field_start,
                                             v_field_end - v_field_start);
    
      v_field_start := instr(v_staging_record,
                             utl.pkg_constants.gc_pipe,
                             v_field_end);
    
      IF v_field_start = 0
      THEN
        EXIT;
      END IF;
    END LOOP;
    
    dbms_application_info.set_module(null,null);

    RETURN t_field_names;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_field_names;

  FUNCTION append_clob(p_original_clob IN CLOB, p_appended_clob IN CLOB)
    RETURN CLOB DETERMINISTIC AS
    v_new_clob CLOB;
  BEGIN
    v_new_clob := p_original_clob;
  
    dbms_lob.append(v_new_clob, p_appended_clob);
  
    RETURN v_new_clob;
  END append_clob;

  -- function to format merge or insert statement from parameter fragments
  FUNCTION get_load_sql(p_file_id           IN source_load_run_file.file_id%TYPE,
                        p_file_type         IN source_load_run_file.file_type%TYPE,
                        p_load_run_id       IN source_load_run.load_run_id%TYPE,
                        p_acc_period_field  IN file_type.accounting_period_field%TYPE,
                        p_table_name        IN file_type.table_name%TYPE,
                        p_insert_cols       IN CLOB,
                        p_update_cols       IN CLOB,
                        p_values_cols       IN CLOB,
                        p_mapped_cols       IN CLOB,
                        p_unique_cols       IN CLOB,
                        p_unmapped_cols     IN CLOB,
                        p_invalid_type_cols IN CLOB) RETURN CLOB 
  AS
    v_fromwhere_clause VARCHAR2(500);
  
    v_insert_cols CLOB;
    v_update_cols CLOB; -- for merge
    v_values_cols CLOB; -- for merge
    v_select_cols CLOB;
    v_load_sql    CLOB;
  
    -- variables to hold literals for where clause 
    v_as_of_date       DATE;
    v_basis            source_basis.basis%TYPE;
    v_source_id        source.source_id%TYPE;
    v_source_file_type source_file_type.source_file_type%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.get_load_sql',null);
    
    SELECT slr.as_of_date, slr.source_id, sft.source_file_type, slr.basis
    INTO   v_as_of_date, v_source_id, v_source_file_type, v_basis
    FROM   source_load_run slr, source_file_type sft
    WHERE  slr.load_run_id  = p_load_run_id
    AND    slr.source_id    = sft.source_id
    AND    sft.file_type    = p_file_type;
  
    -- format standard where clause
    v_fromwhere_clause := ' FROM source_staging_area ssa' ||
                          ' WHERE ssa.source_file_type = ''' || v_source_file_type || '''' ||
                          ' AND   ssa.file_id	  = ''' || p_file_id || '''';
  
    -- top and tail target list of columns with std stuff   
    v_insert_cols := 't.source_id, t.as_of_date, t.basis, t.load_run_id, t.file_id, t.file_type' ||
                     p_insert_cols ||
                     ',t.key,t.unmapped_attributes,t.invalid_type_attributes,t.seq_id';
  
    -- construct select clause 
    v_select_cols := v_source_id  || ' source_id, to_date(''' ||
                     to_char(v_as_of_date,'dd-MON-yyyy') || ''',''dd-MON-yyyy'') as_of_date,''' ||
                     v_basis || ''' basis,' ||
                     p_load_run_id || ' load_run_id, ''' || 
                     p_file_id || ''' file_id, ''' || 
                     p_file_type || ''' file_type' || 
                     p_mapped_cols || 
                     ',substr(null' || p_unique_cols || ',2) key,'||
                     'substr(null'||p_unmapped_cols||',2,4000) unmapped_attributes,'||
                     'substr(null'||p_invalid_type_cols||',2,4000) invalid_type_attributes,'||
                     'row_number() OVER (PARTITION BY substr(null' ||
                     p_unique_cols || ',2) ORDER BY rownum) AS seq_id';
                   
    -- if this file is by accounting period)
    IF p_acc_period_field IS NOT NULL
    THEN
      v_select_cols := v_select_cols || ',pkg_loader.get_value('''||p_acc_period_field||''',ssa.staging_record) accounting_period';
      -- add accounting period criteria to where clause
      v_fromwhere_clause := v_fromwhere_clause ||
                            ' AND pkg_loader.get_value(''' ||
                            p_acc_period_field ||
                            ''',ssa.staging_record) = :1';
 
      -- top and tail values and insert clauses
      -- for an update add any additional invalid type attributes to clob column on target table
      v_values_cols := 's.source_id, s.as_of_date, s.basis, s.load_run_id, s.file_id, s.file_type' ||
                       p_values_cols ||
                       ', s.key, s.unmapped_attributes, decode(s.invalid_type_attributes,null,null,''Accounting Period:''||s.accounting_period||chr(9)||s.invalid_type_attributes||chr(10)), s.seq_id';
      v_update_cols :=  't.invalid_type_attributes = t.invalid_type_attributes||decode(s.invalid_type_attributes,null,null,''Accounting Period:''||s.accounting_period||chr(9)||s.invalid_type_attributes||chr(10))'||p_update_cols;
    
      -- format the merge statement
      v_load_sql := 'MERGE /*+ PARALLEL(t) */ INTO ' || p_table_name || ' t USING (SELECT /*+ PARALLEL(ssa) */ ';
    
      dbms_lob.append(v_load_sql, v_select_cols);
      dbms_lob.append(v_load_sql, v_fromwhere_clause);
      dbms_lob.append(v_load_sql,
                      ') s ON (t.as_of_date = '''||to_char(v_as_of_date,'dd-MON-yyyy')||''' AND t.source_id = '||v_source_id||' AND t.basis = '''||v_basis||''' AND t.key = s.key AND t.seq_id = s.seq_id) WHEN MATCHED THEN UPDATE /*+ PARALLEL('||p_table_name||') */ SET ');
      dbms_lob.append(v_load_sql, v_update_cols);
      dbms_lob.append(v_load_sql, ' WHEN NOT MATCHED THEN INSERT /*+ PARALLEL(t) */ (');
      dbms_lob.append(v_load_sql, v_insert_cols);
      dbms_lob.append(v_load_sql, ') VALUES (');
      dbms_lob.append(v_load_sql, v_values_cols);
      dbms_lob.append(v_load_sql, ')');
    ELSE
      -- no acc period stuff - just a straight insert 
      -- format insert statement
      v_load_sql := 'INSERT /*+ PARALLEL(t) */ INTO ';
    
      dbms_lob.append(v_load_sql, p_table_name || ' t (');
      dbms_lob.append(v_load_sql, v_insert_cols);
      dbms_lob.append(v_load_sql, ') SELECT /*+ PARALLEL(ssa) */ ');
      dbms_lob.append(v_load_sql, v_select_cols);
      dbms_lob.append(v_load_sql, v_fromwhere_clause);
    END IF;
  
    -- record sql against load run file
    pkg_source_load_run_mod.update_load_sql(p_load_run_id,
                                            p_file_id,
                                            p_file_type,
                                            v_load_sql);

    dbms_application_info.set_module(null,null);
    
    RETURN v_load_sql;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END get_load_sql;

  -- converts a CLOB to a table of varchar2(255) then executes SQL
  -- optionally a single varchar2 parameter can be bound to the sql
  FUNCTION execute_clob_sql(p_clob_sql IN CLOB,
                            p_param    VARCHAR2 DEFAULT NULL) RETURN INTEGER 
  AS
    t_sql dbms_sql.varchar2s;
  
    v_buffer VARCHAR2(255);
    v_offset INTEGER := 1;
    v_line   INTEGER := 1;
    v_size   INTEGER := 255;
  
    cur_sql INTEGER;
  
    v_no_of_rows INTEGER;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.execute_clob_sql',null);
    
    LOOP
      BEGIN
        dbms_lob.READ(p_clob_sql, v_size, v_offset, v_buffer);
      EXCEPTION
        WHEN no_data_found THEN
          EXIT;
      END;
    
      t_sql(v_line) := v_buffer;
    
      v_line   := v_line + 1;
      v_offset := v_offset + 255;
    
    END LOOP;
  
    cur_sql := dbms_sql.open_cursor;
  
    dbms_sql.parse(cur_sql,
                   t_sql,
                   t_sql.FIRST,
                   t_sql.LAST,
                   FALSE,
                   dbms_sql.native);
  
    IF p_param IS NOT NULL
    THEN
      dbms_sql.bind_variable(cur_sql, ':1', p_param);
    END IF;
  
    v_no_of_rows := dbms_sql.EXECUTE(cur_sql);
  
    dbms_sql.close_cursor(cur_sql);

    dbms_application_info.set_module(null,null);
    
    RETURN v_no_of_rows;
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
  END execute_clob_sql;

  -- loads records from staging area for a designated source and file into the defined target table
  PROCEDURE load_file(p_file_id     IN source_load_run_file.file_id%TYPE,
                      p_file_type   IN source_load_run_file.file_type%TYPE,
                      p_load_run_id IN source_load_run.load_run_id%TYPE) 
  AS
    v_insert_cols CLOB; -- for insert or merge statement
    v_update_cols CLOB; -- for merge
    v_values_cols CLOB; -- for merge
  
    v_mapped_cols       CLOB; -- for subquery of insert or merge
    v_unique_cols       CLOB; -- for subquery of insert or merge
    v_unmapped_cols     CLOB; -- for subquery of insert or merge
    v_invalid_type_cols CLOB; -- for subquery of insert or merge
  
    v_no_of_records INTEGER := NULL;
    v_ignore        INTEGER := NULL;
  
    v_table_name        file_type.table_name%TYPE;
    v_acc_period_field  file_type.accounting_period_field%TYPE;
    v_check_type        file_type.check_type%TYPE;
    v_preserve_unmapped file_type.preserve_unmapped%TYPE;
  
    v_load_sql CLOB;
     
    t_field_names utl.t_varchar2;
    
    -- variables to hold literals for where clause 
    v_as_of_date       DATE;
    v_basis            source_basis.basis%TYPE;
    v_source_id        source.source_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.load_file',null);
    -- determine whether the file has records by accounting period or not
    SELECT ft.accounting_period_field, ft.table_name, ft.check_type, ft.preserve_unmapped
    INTO   v_acc_period_field, v_table_name, v_check_type, v_preserve_unmapped
    FROM   file_type ft
    WHERE  ft.file_type = p_file_type;
  
    -- load nested table with field names from first record in staging area
    t_field_names := get_field_names(p_load_run_id, p_file_id, p_file_type);
  
    IF t_field_names IS NOT NULL -- if there is at least one record in the staging area
    THEN  
      -- retrieve all the fields in the staging record and all the mapped fields for this source
      -- joining them where possible and loop through all occurences
      FOR field_rec IN (SELECT sf.field_name,
                               mf.column_name,
                               mf.in_unique_key,
                               mf.acc_period,
                               mf.data_type,
                               mf.date_format
                        FROM   (SELECT VALUE(field) field_name
                                FROM   TABLE(CAST(t_field_names AS utl.t_varchar2)) field) sf
                                       FULL OUTER JOIN 
                                       (SELECT ftc.field_name,
                                               ftc.column_name,
                                               ftc.in_unique_key,
                                               ftc.accounting_period acc_period,
                                               atc.data_type,
                                               ft.date_format
                                       FROM   field_target_column  ftc,
                                              all_tab_columns      atc,
                                              file_type            ft
                                       WHERE  ftc.table_name         = ft.table_name
                                       AND    ft.file_type           = p_file_type
                                       AND    ftc.file_type          = ft.file_type
                                       AND    upper(ftc.table_name)  = atc.table_name
                                       AND    upper(ftc.column_name) = atc.column_name) mf 
                                       ON sf.field_name =  mf.field_name
                                ORDER  BY 1)
      LOOP
        -- format the lists of columns for the insert/merge
        get_target_col(v_insert_cols,
                       v_update_cols,
                       v_values_cols,
                       field_rec.column_name,
                       field_rec.acc_period,
                       v_acc_period_field);
      
        -- format the assignment to each mapped column for the insert or merge 
        -- and the assignment to the invalid type attributes column
        get_mapped_col(v_mapped_cols,
                       v_invalid_type_cols,
                       field_rec.column_name,
                       field_rec.field_name,
                       field_rec.acc_period,
                       v_acc_period_field,
                       field_rec.data_type,
                       field_rec.date_format,
                       v_check_type);
      
        -- format the assignment to the unique key field
        get_unique_col(v_unique_cols,
                       field_rec.column_name,
                       field_rec.field_name,
                       field_rec.in_unique_key);
      
        -- format the assignment to column containing unmapped fields
        -- if we are preserving unmapped fields for this file type
        IF v_preserve_unmapped = 'Y'
        THEN
          get_unmapped_col(v_unmapped_cols,
                           field_rec.column_name,
                           field_rec.field_name,
                           v_acc_period_field);
        END IF;
      END LOOP;
    
      -- format insert or merge statement
      v_load_sql := get_load_sql(p_file_id,
                                 p_file_type,
                                 p_load_run_id,
                                 v_acc_period_field,
                                 v_table_name,
                                 v_insert_cols,
                                 v_update_cols,
                                 v_values_cols,
                                 v_mapped_cols,
                                 v_unique_cols,
                                 v_unmapped_cols,
                                 v_invalid_type_cols);
    
      -- if file is by accounting period run the merge statement for each accounting period we have mappings defined for
      IF v_acc_period_field IS NOT NULL
      THEN
        FOR rec_acc_period IN (SELECT DISTINCT accounting_period
                               FROM   field_target_column  ftc,
                                      source_load_run_file slrf
                               WHERE  ftc.file_type    = slrf.file_type
                               AND    slrf.file_id     = p_file_id
                               AND    slrf.load_run_id = p_load_run_id
                               AND    slrf.file_type   = p_file_type
                               AND    ftc.table_name   = v_table_name
                               AND    ftc.accounting_period IS NOT NULL
                               ORDER BY ftc.accounting_period DESC)
        LOOP
          v_ignore := execute_clob_sql(v_load_sql,
                                       rec_acc_period.accounting_period);
          
          COMMIT;
          
          -- log number of records loaded
          utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Processed ' || nvl(v_ignore, 0) || ' ' ||
                       rec_acc_period.accounting_period ||' records for run ' ||
                       pkg_source_load_run.get_description(p_load_run_id) ||
                       ', file [' || p_file_id || '], type [' || p_file_type || ']',
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);  
        END LOOP;
      
        SELECT slr.as_of_date, slr.source_id, slr.basis
        INTO   v_as_of_date, v_source_id, v_basis
        FROM   source_load_run slr
        WHERE  slr.load_run_id = p_load_run_id;
        
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || v_table_name ||
                          ' t WHERE t.as_of_date = '''||to_char(v_as_of_date,'dd-MON-yyyy')||
                          ''' AND t.source_id = '||v_source_id||
                          ' AND t.file_id = '''||p_file_id||
                          ''' AND t.load_run_id = '||p_load_run_id
        INTO v_no_of_records;
      ELSE
        -- otherwise just run the insert statement
        v_no_of_records := execute_clob_sql(v_load_sql);
        
        COMMIT;
      END IF;
    ELSE
      -- staging area is empty for this file id
      v_no_of_records := 0;
      
      COMMIT; -- make sure transaction is ended
    END IF;
  
    -- log number of records loaded
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Loaded ' || nvl(v_no_of_records, 0) ||
                       ' records to ' || v_table_name || ' for run ' ||
                       pkg_source_load_run.get_description(p_load_run_id) ||
                       ', file [' || p_file_id || '], type [' || p_file_type || ']',
                       pkg_source_load_run.gc_log_message_parent_table,
                       p_load_run_id);
  
    -- record number of records loaded against load run file
    pkg_source_load_run_mod.update_no_of_records(p_load_run_id,
                                                 p_file_id,
                                                 p_file_type,
                                                 v_no_of_records);
                                                 
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      utl.pkg_errorhandler.handle;
    
      RAISE;
    
  END load_file;

  -- this procedure creates records in the defined target table for the source 
  -- by selecting from the source_staging_area table
  -- raises the exception e_source_in_progress if the source is already being loaded 

  PROCEDURE load(p_source_name IN source.source_name%TYPE,
                 p_basis       IN source_basis.basis%TYPE,
                 p_as_of_date  IN DATE) 
  AS
    v_load_run_id source_load_run.load_run_id%TYPE;
  BEGIN
    dbms_application_info.set_module('vcr.pkg_loader.load',null);
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
    
    pkg_source_load_run_mod.clear_info(v_load_run_id);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Started load from staging area for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
  
    -- if another load run for the same source is in progress then raise exception e_source_in_progress
    IF pkg_source_load_run.is_source_loading(v_load_run_id)
    THEN
      raise_application_error(utl.pkg_exceptions.gc_source_is_loading_err,
                              'Source ' || p_source_name ||
                              ' is in progress');
    END IF;
    
    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    EXECUTE IMMEDIATE 'ALTER SESSION FORCE PARALLEL QUERY';
    
    -- purge data to be replaced by this run
    pkg_purger.purge_target_table(v_load_run_id);

    -- for each file loaded in staging area
    FOR rec_file IN (SELECT file_id, file_type
                     FROM   source_load_run_file
                     WHERE  load_run_id = v_load_run_id)
    LOOP
      -- insert records to defined target table for the files type
      load_file(rec_file.file_id, rec_file.file_type, v_load_run_id);
    END LOOP;
    
    EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL DML';
    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL QUERY';
               
    -- discard any unwanted records in target table
    pkg_filter.filter_target_table(v_load_run_id);
    
    -- gather stats on the subpartition just populated at 10 percent sample rate
    pkg_housekeeping.gather_run_target_stats(v_load_run_id,10);
  
    -- run pre-validation checks on data 
    pkg_checker.check_target_table(v_load_run_id);
  
      -- purge the staging area now we are finished with it
    pkg_purger.purge_staging_area(p_source_name);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Purged staging area for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
  
    utl.pkg_logger.log(utl.pkg_logger.gc_log_message_event,
                       'Completed load from staging area for ' ||
                       pkg_source_load_run.get_description(v_load_run_id),
                       pkg_source_load_run.gc_log_message_parent_table,
                       v_load_run_id);
                       
    dbms_application_info.set_module(null,null);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;      
      
      utl.pkg_errorhandler.handle;
    
      pkg_source_load_run_mod.log_sqlerror(v_load_run_id);

      RAISE;
    
  END load;

END pkg_loader;
/
