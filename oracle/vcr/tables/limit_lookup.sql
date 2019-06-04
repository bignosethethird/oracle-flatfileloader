------------------------------------------------------------------------------
-- $Header: vcr/tables/limit_lookup.sql 1.1 2005/10/28 14:00:17BST apenney DEV  $
------------------------------------------------------------------------------

set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.LIMIT_LOOKUP

-- Drop table if it already exists
-- Note that the contents of the table will also be deleted
--  and that referential constraints will also be dropped.
-- You will be warned when this happens.
declare 
  v_count integer:=0;
begin
  select count(*)
    into v_count
    from sys.all_objects
   where object_type = 'TABLE'
     and owner = upper('VCR')
     and object_name = upper('LIMIT_LOOKUP');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.LIMIT_LOOKUP already exists. Dropping it');
    execute immediate 'drop table VCR.LIMIT_LOOKUP';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.LIMIT_LOOKUP cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create global temporary table VCR.LIMIT_LOOKUP
(
  LIMIT_ID                        NUMBER     not null
, LIMIT_VERSION					  NUMBER	 not null
, HEADER_VALUE_1				  VARCHAR2(100)
, HEADER_VALUE_2				  VARCHAR2(100)
, HEADER_VALUE_3				  VARCHAR2(100)
, HEADER_VALUE_4				  VARCHAR2(100)
, HEADER_VALUE_5				  VARCHAR2(100)
, PARAM_VALUE_1					  NUMBER
, PARAM_VALUE_2					  NUMBER
, PARAM_VALUE_3					  NUMBER
, PARAM_VALUE_4					  NUMBER
, BREAK_MESSAGE					  VARCHAR2(200)
)
;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

