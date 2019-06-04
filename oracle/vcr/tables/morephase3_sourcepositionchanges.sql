------------------------------------------------------------------------------
-- $Header: vcr/tables/morephase3_sourcepositionchanges.sql 1.5 2005/10/12 12:36:09BST ghoekstra DEV  $
------------------------------------------------------------------------------

Prompt converting option_multiplyer field
prompt Create temporary table vcr.spom
create table vcr.spom
as
select rowid sprowid,option_multiplyer
from   vcr.source_position
where  option_multiplyer is not null;


create unique index vcr.spom_uk on vcr.spom (sprowid);

prompt Gathering table stats for table vcr.spom
begin
  dbms_stats.gather_table_stats('vcr','spom',method_opt => 'for all indexed columns', cascade => true);
end;
/

prompt Updating multiplayer data into vcr.source_position
prompt (this can take a while)
update vcr.source_position sp set sp.option_multiplyer = null
where exists (select sprowid from vcr.spom om where om.sprowid = sp.rowid);

commit;

prompt alter table vcr.source_position modify (option_multiplyer number);
alter table vcr.source_position modify (option_multiplyer number);

prompt Updating more multiplayer data into vcr.source_position
prompt (this can take a while)
update vcr.source_position sp set sp.option_multiplyer = (select vcr.pkg_checker.to_number_or_null(spom.option_multiplyer)
from vcr.spom spom where spom.sprowid = sp.rowid)
where exists (select sprowid from vcr.spom om where om.sprowid = sp.rowid);

commit;


prompt Drop temporary table vcr.spom
drop table vcr.spom cascade constraints;

Prompt adding new globeop mtd and ytd fields


alter table vcr.source_position add (beg_book_acc_interest_mtd number)
;
alter table vcr.source_position add (book_coupon_mtd number)
;
alter table vcr.source_position add (book_unrealised_income_mtd number)
;
alter table vcr.source_position add (end_local_cost_mtd number)
;
alter table vcr.source_position add (beg_book_acc_interest_ytd number)
;
alter table vcr.source_position add (book_coupon_ytd number)
;
alter table vcr.source_position add (book_unrealised_income_ytd number)
;
alter table vcr.source_position add (end_local_cost_ytd number)
;

Prompt adding new High Yield fields

alter table vcr.source_position add (accrued_interest_local_hy number)
;
alter table vcr.source_position add (accrued_interest_hy number)
;
alter table vcr.source_position add (loan_identifier_hy varchar2(4000))
;
alter table vcr.source_position add (loan_effective_date_hy date)
;
alter table vcr.source_position add (instrument_price_change_hy number)
;
alter table vcr.source_position add (instrument_value_change_hy number)
;
alter table vcr.source_position add (paid_interest_hy number)
;
alter table vcr.source_position add (total_committed_amount_hy number)
;
alter table vcr.source_position add (total_funded_amount_hy number)
;
alter table vcr.source_position add (base_rate_hy number)
;
alter table vcr.source_position add (spread_rate_hy number)
;
alter table vcr.source_position add (paid_fees_hy number)
;
alter table vcr.source_position add (accrued_instrument_fees_hy number)
;
alter table vcr.source_position add (instrument_cost_value_hy number)
;


------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

