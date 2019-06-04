------------------------------------------------------------------------------
-- $Header: vcr/tables/security_price_request.sql 1.2.1.1 2005/08/23 13:53:56BST ghoekstra DEV  $
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_exception.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.SECURITY_PRICE_REQUEST

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
     and object_name = upper('SECURITY_PRICE_REQUEST');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SECURITY_PRICE_REQUEST already exists. Dropping it');
    execute immediate 'drop table VCR.SECURITY_PRICE_REQUEST';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SECURITY_PRICE_REQUEST cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SECURITY_PRICE_REQUEST
(
  REQUEST_ID                      NUMBER    (22) not null
, LOAD_RUN_ID                     NUMBER    (22) not null
, REQUEST_FILE_NAME               VARCHAR2  (100) not null
, RESPONSE_FILE_NAME              VARCHAR2  (100) not null
, REQUEST_DATE_TIME               DATE      not null
, RESPONSE_TIME_STARTED           VARCHAR2(50)
, RESPONSE_TIME_FINISHED          VARCHAR2(50)
, STATUS                          VARCHAR2(10) not null
) TABLESPACE VCR_DATA_SMALL
;

------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------

comment on column VCR.SECURITY_PRICE_REQUEST.REQUEST_ID is
  'unique id of request';
comment on column VCR.SECURITY_PRICE_REQUEST.LOAD_RUN_ID is
  'currency of price';
comment on column VCR.SECURITY_PRICE_REQUEST.RESPONSE_TIME_STARTED is
  'time that response started processing';
comment on column VCR.SECURITY_PRICE_REQUEST.RESPONSE_TIME_FINISHED is
  'time that response finished processing';

------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SECURITY_PRICE_REQUEST
  add constraint PK_SECURITY_PRICE_REQUEST
  primary key (REQUEST_ID)
  using index tablespace VCR_IDX_SMALL
;
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SECURITY_PRICE_REQUEST
  add constraint FK_SECURITY_PRICE_REQ_RUN
  foreign key (LOAD_RUN_ID)
  references VCR.SOURCE_LOAD_RUN(LOAD_RUN_ID)
;

alter table VCR.SECURITY_PRICE_REQUEST
  add constraint FK_SECURITY_PRICE_REQ_STAT
  check (STATUS IN ('INITIAL','WAITING','COMPLETE','ERROR','CANCELLED'))
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

