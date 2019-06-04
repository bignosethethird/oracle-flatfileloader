------------------------------------------------------------------------------
-- $Header: vcr/data/phase3source_basis_measure_rule.sql 1.2 2005/09/27 14:02:30BST apenney DEV  $
------------------------------------------------------------------------------
-- Data population script for table vcr.source_basis_measure_rule.
-- WARNING: *** This script overwrites the entire table! ***
--          *** Save important content before running.   ***
-- To run this script from the command line:
--   $ sqlplus "vcr/[password]@[instance]" @source_basis_measure_rule.sql
-- This file was generated from database instance VCRD1.
--   Database Time    : 26APR2005 09:43:46
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
------------------------------------------------------------------------------
set feedback off;
prompt Populating records into table vcr.source_basis_measure_rule.

------------------------------------------------------------------------------
-- Populating the table:
------------------------------------------------------------------------------

insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(8,3,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(9,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(10,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(11,2,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(12,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(13,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(14,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(15,1,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(20,2,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(21,2,
      'TCLEAN'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(22,1,
      'TCLEAN'
      );      
      
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(8,3,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(9,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(10,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(11,2,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(12,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(13,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(14,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(15,1,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(20,2,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(21,2,
      'TPLUS1'
      );
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(22,1,
      'TPLUS1'
      );    
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(23,3,
      'TPLUS1'
      );   
insert into vcr.source_basis_measure_rule
      (MEASURE_ID,RULE_ID,BASIS)
values(23,3,
      'TCLEAN'
      );         
commit;
set feedback on;
------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

