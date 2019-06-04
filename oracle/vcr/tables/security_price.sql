------------------------------------------------------------------------------
-- $Header: vcr/tables/security_price.sql 1.2.1.1 2005/08/23 13:36:18BST ghoekstra DEV  $
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @limit_exception.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating table VCR.SECURITY_PRICE

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
     and object_name = upper('SECURITY_PRICE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SECURITY_PRICE already exists. Dropping it');
    execute immediate 'drop table VCR.SECURITY_PRICE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SECURITY_PRICE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SECURITY_PRICE
(
  AS_OF_DATE                      DATE       not null
, REQUEST_ID                      NUMBER    (22)  not null
, REQUEST_SEQ                     NUMBER    (22)  not null
, SECURITY_CODE                   VARCHAR2  (100) not null
, SECURITY_CODE_TYPE              VARCHAR2  (100) not null
, CURRENCY                        VARCHAR2  (100)
, UNIQUE_SECURITY_ID              VARCHAR2  (100)
, RETURN_CODE                     VARCHAR2  (3)
, PRICE                           NUMBER
)
PARTITION BY RANGE (as_of_date)
(
  PARTITION JUL_05_05 VALUES LESS THAN (TO_DATE('05-JUL-2005', 'DD-MON-YYYY'))
) TABLESPACE VCR_DATA_MED
;

------------------------------------------------------------------------------
-- Column comments:
------------------------------------------------------------------------------

comment on column VCR.SECURITY_PRICE.AS_OF_DATE is
  'as of date price is for';
comment on column VCR.SECURITY_PRICE.SECURITY_CODE is
  'isin, cusip, sedol, Bloomberg Ticker';
comment on column VCR.SECURITY_PRICE.SECURITY_CODE_TYPE is
  'isin, cusip, sedol, Bloomberg Ticker';
comment on column VCR.SECURITY_PRICE.REQUEST_ID is
  'parent request';
comment on column VCR.SECURITY_PRICE.REQUEST_SEQ is
  'sequence in which security is listed in request and reply files';
comment on column VCR.SECURITY_PRICE.CURRENCY is
  'currency of price';
comment on column VCR.SECURITY_PRICE.UNIQUE_SECURITY_ID is
  'Unique id used by provider of price';
comment on column VCR.SECURITY_PRICE.RETURN_CODE is
  '0 = success; 10 = unrecognised security';

------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SECURITY_PRICE
  add constraint PK_SECURITY_PRICE
  primary key (AS_OF_DATE,REQUEST_ID,REQUEST_SEQ)
  using index tablespace VCR_IDX_MED
  local
;
------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SECURITY_PRICE
  add constraint FK_SECURITY_PRICE_REQUEST
  foreign key (REQUEST_ID)
  references VCR.SECURITY_PRICE_REQUEST(REQUEST_ID)
;

------------------------------------------------------------------------------
-- Create/Recreate indexes
------------------------------------------------------------------------------
create index VCR.IX_SECURITY_PRICE_CODE on VCR.SECURITY_PRICE(AS_OF_DATE,SECURITY_CODE,SECURITY_CODE_TYPE)
  tablespace VCR_IDX_MED local
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

