------------------------------------------------------------------------------
-- $Header: vcr/tables/source_position_security_price.sql 1.8 2005/10/25 15:31:00BST apenney DEV  $
------------------------------------------------------------------------------
-- Table creation script for table VCR.SOURCE_POSITION_SECURITY_PRICE
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 23AUG2005 12:22:53
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @source_position_security_price.sql
------------------------------------------------------------------------------
set feedback off;
set serveroutput on size 1000000;
prompt Creating table VCR.SOURCE_POSITION_SECURITY_PRICE

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
     and object_name = upper('SOURCE_POSITION_SECURITY_PRICE');
  if(v_count>0)then
    dbms_output.put_line('Table VCR.SOURCE_POSITION_SECURITY_PRICE already exists. Dropping it');
    execute immediate 'drop table VCR.SOURCE_POSITION_SECURITY_PRICE';
  end if;
exception
  when others then
    if(v_count>0)then
      dbms_output.put_line('and dropping referential constraints to it');
      execute immediate 'drop table VCR.SOURCE_POSITION_SECURITY_PRICE cascade constraints';
    end if;
end;
/
------------------------------------------------------------------------------
-- Create table
------------------------------------------------------------------------------
create table VCR.SOURCE_POSITION_SECURITY_PRICE
(
  SOURCE_ID                       NUMBER    (22) not null
, AS_OF_DATE                      DATE       not null
, BASIS                           VARCHAR2  (30) not null
, KEY                             VARCHAR2  (4000) not null
, SEQ_ID                          NUMBER     default 1   not null
, REQUEST_ID                      NUMBER    (22) not null
, REQUEST_SEQ                     NUMBER    (22) not null
)
PARTITION BY RANGE (as_of_date)
SUBPARTITION BY LIST (source_id)
(
  PARTITION JUL_05_05 VALUES LESS THAN (TO_DATE('05-JUL-2005', 'DD-MON-YYYY'))
  (
    SUBPARTITION JUL_05_05_1 VALUES (1),
    SUBPARTITION JUL_05_05_2 VALUES (2),
    SUBPARTITION JUL_05_05_3 VALUES (3),
    SUBPARTITION JUL_05_05_4 VALUES (4),
    SUBPARTITION JUL_05_05_5 VALUES (5),
    SUBPARTITION JUL_05_05_6 VALUES (6),
    SUBPARTITION JUL_05_05_7 VALUES (7),
    SUBPARTITION JUL_05_05_8 VALUES (8),
    SUBPARTITION JUL_05_05_9 VALUES (9),
    SUBPARTITION JUL_05_05_10 VALUES (10)
  )
) TABLESPACE VCR_DATA_MED logging parallel
;



------------------------------------------------------------------------------
-- Create/Recreate primary key constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_POSITION_SECURITY_PRICE
  add constraint PK_SOURCE_POS_SECURITY_PRICE
  primary key (SOURCE_ID,AS_OF_DATE,BASIS,KEY,SEQ_ID)
  using index
  local
;

------------------------------------------------------------------------------
-- Create/Recreate foreign constraints
------------------------------------------------------------------------------
alter table VCR.SOURCE_POSITION_SECURITY_PRICE
  add constraint FK_SECURITY_PRICE
  foreign key (AS_OF_DATE,REQUEST_ID,REQUEST_SEQ)
  references VCR.SECURITY_PRICE(AS_OF_DATE,REQUEST_ID,REQUEST_SEQ)
;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

