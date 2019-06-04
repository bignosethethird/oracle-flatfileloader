------------------------------------------------------------------------------
-- $Header: vcr/tables/phase3_changes.sql 1.2 2005/10/28 14:47:13BST ghoekstra DEV  $
------------------------------------------------------------------------------

------------------------------------------------------------------------------
set feedback off;

Prompt adding some missing indices

prompt create index VCR.IX_SOURCE_POSITION_FUND
create index VCR.IX_SOURCE_POSITION_FUND on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,BASIS,FUND)
  tablespace VCR_IDX_MED local
;
prompt create index VCR.IX_SOURCE_POSITION_STRATEGY
create index VCR.IX_SOURCE_POSITION_STRATEGY on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,BASIS,FUND,STRATEGY)
  tablespace VCR_IDX_MED local
;
prompt create index VCR.IX_SOURCE_POSITION_FILE
create index VCR.IX_SOURCE_POSITION_FILE on VCR.SOURCE_POSITION(SOURCE_ID,AS_OF_DATE,LOAD_RUN_ID,FILE_ID)
  tablespace VCR_IDX_MED local
;

prompt alter table VCR.PRIME_BROKER
alter table VCR.PRIME_BROKER
  add constraint UK_PRIME_BROKER
  unique (DESCRIPTION)
  using index
  tablespace VCR_IDX_SMALL
;

prompt alter table vcr.ie_instrument_type
alter table vcr.ie_instrument_type add (stale_price_period NUMBER)
;


prompt Altering vcr.file_type
alter table vcr.file_type add change_reason varchar2(500);
comment on column vcr.file_type.change_reason
  is 'Reason for last change';
comment on column vcr.file_type.end_of_line
  is 'Record delimiting character. This can be one of the following values: LF (UNIX), CR (APPLE) or CRLF (Windows)';

prompt Altering vcr.file_type_field
alter table vcr.file_type_field add change_reason varchar2(500);
comment on column vcr.file_type_field.change_reason
  is 'Reason for last change';

prompt Altering vcr.field_target_column
alter table vcr.field_target_column add change_reason varchar2(500);
comment on column vcr.field_target_column.change_reason
  is 'Reason for last change';

prompt Altering vcr.ie_instrument_type
alter table vcr.ie_instrument_type add category varchar2(30) default 'OTHER' not null;

prompt Altering vcr.ie_platform
alter table vcr.ie_platform add change_reason varchar2(500);
comment on column vcr.ie_platform.change_reason
  is 'Reason for last change';

prompt Altering vcr.ie_target_column
alter table vcr.ie_target_column add change_reason varchar2(500);
comment on column vcr.ie_target_column.change_reason
  is 'Reason for last change';

prompt Altering vcr.investment_engine
alter table vcr.investment_engine add ignore_zero_positions char(1) default 'N' not null;
alter table vcr.investment_engine add ror_calc_denominator  varchar2(20) default 'NOTIONAL' not null;
alter table vcr.investment_engine add change_reason         varchar2(500);
comment on column vcr.investment_engine.change_reason
  is 'Reason for last change';

prompt Altering vcr.limit_exception
alter table vcr.limit_exception add current_bb_price number;
alter table vcr.limit_exception add prior_bb_price   number;
alter table vcr.limit_exception add to_be_resolved_ind char(1) default 'N' not null;

prompt Altering vcr.limit_header_parameter
alter table vcr.limit_header_parameter add parent_column_name varchar2(30);

prompt Altering vcr.ref_measure_value
comment on column vcr.REF_MEASURE_VALUE.VALUE_TYPE
  is 'whether the value is from the reference source (S) or calculated (C)';

prompt Altering vcr.source
alter table vcr.source drop column rollback_segment;
alter table vcr.source rename column tclean_delay to tplus1_offset;
alter table vcr.source add change_reason varchar2(500);
comment on column vcr.source.change_reason
  is 'Reason for last change';

prompt Altering vcr.source_file_type
alter table vcr.source_file_type add change_reason varchar2(500);
comment on column vcr.source_file_type.change_reason
  is 'Reason for last change';

prompt Altering vcr.source_position
alter table vcr.source_position add (pos_adjusted_delta number);
alter table vcr.source_position add (delta_value_k number);
alter table vcr.source_position add (exposure number);
alter table vcr.source_position add ( TOTAL_INCOME_MTD_LOCAL          NUMBER );
alter table vcr.source_position add ( YIELD_TO_MATURITY               NUMBER );
alter table vcr.source_position add ( MODIFIED_DURATION               NUMBER );
alter table vcr.source_position add ( YIELD_TO_WORST                  NUMBER );
alter table vcr.source_position add ( RULE_144A                       VARCHAR2  (2000));
alter table vcr.source_position add ( PRIVATE_PLACEMENT               VARCHAR2  (2000));
alter table vcr.source_position add ( RATING_FITCH                    VARCHAR2  (2000));
alter table vcr.source_position add ( CURRENT_YIELD                   NUMBER  );
alter table vcr.source_position add ( INTEREST_RATE                   NUMBER  );

prompt Altering vcr.target_table
alter table vcr.target_table add description varchar2(100);
alter table vcr.target_table add calculation_procedure varchar2(100);
comment on table vcr.target_table
  is 'Usually we have one table per data type';
comment on column vcr.target_table.purge_procedure
  is 'Name of PL/SQL procedure used to purge data';
comment on column vcr.target_table.check_procedure
  is 'Name of PL/SQL procedure used to check data after load';
comment on column vcr.target_table.months_retained
  is 'Number of months of data retained in target table e.g. 3 months';
comment on column vcr.target_table.description
  is 'Describes the type of data in this table';

set feedback on;

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

