------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_prm_broker_cash.sql 1.5 2005/08/22 17:46:43BST ghoekstra DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_PRM_BROKER_CASH
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:56
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_prm_broker_cash.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_PRM_BROKER_CASH

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_PRM_BROKER_CASH (
  INVESTMENT_ENGINE
, INVESTMENT_ENGINE_PLATFORM
, AS_OF_DATE
, BROKER
, SOURCE
, BASIS
, TOTAL_MKT_VALUE
, TOTAL_LONG_CASH
, TOTAL_SHORT_CASH
, TOTAL_CASH
, TOTAL_LONG_POSITIONS
, TOTAL_SHORT_POSITIONS
, TOTAL_POSITIONS
) as 
SELECT   sf.ie_id                     investment_engine 
        ,sf.ie_platform               investment_engine_platform 
        ,sp.as_of_date 
        ,pb.description broker 
        ,sp.fund||' ('||s.source_name||')' source 
        ,sp.basis 
        ,SUM(sp.instrument_value)         total_mkt_value 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'CASH'   , DECODE(SIGN(sp.instrument_value), 1,sp.instrument_value))) total_long_cash 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'CASH'   , DECODE(SIGN(sp.instrument_value),-1,sp.instrument_value))) total_short_cash 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'CASH'   , sp.instrument_value))                                      total_cash 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'NOTCASH', DECODE(SIGN(sp.instrument_value), 1,sp.instrument_value))) total_long_positions 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'NOTCASH', DECODE(SIGN(sp.instrument_value),-1,sp.instrument_value))) total_short_positions 
        ,SUM(DECODE(NVL(mc.cash,'NOTCASH'),'NOTCASH', sp.instrument_value))                                      total_positions 
FROM     source_position       sp 
        ,source_fund           sf 
        ,investment_engine     ie 
        ,source                s 
        ,(SELECT sit.instrument_type 
                ,sit.source_id 
                ,ieit.category          cash 
          FROM   source_instrument_type sit 
                ,source_ie_ins_type     siet 
                ,ie_instrument_type     ieit 
          WHERE  sit.source_instrument_type_id = siet.source_instrument_type_id 
          AND    siet.ie_instrument_type_id    = ieit.ie_instrument_type_id 
          AND    ieit.category                 = 'CASH' 
          ) mc 
         ,(SELECT DECODE(MIN(basis_rank),1,'TCLEAN',2,'TPLUS1') best_basis, slr.source_id, slr.as_of_date, sf.source_fund_id 
             FROM ( SELECT DISTINCT source_id,basis,DECODE(basis,'TCLEAN',1,'TPLUS1',2) basis_rank, as_of_date 
                    FROM   source_load_run 
                    WHERE  status = 'COM' ) slr 
                          ,source_fund sf 
             WHERE  slr.source_id = sf.source_id 
             GROUP BY slr.source_id ,slr.as_of_date,sf.source_fund_id) bb 
         , (SELECT pb.description, sb.source_id, sB.broker 
             FROM   source_broker sb 
                   ,prime_broker  pb 
             WHERE  sb.prime_broker_id = pb.prime_broker_id ) pb 
WHERE    sp.fund            =  sf.fund 
AND      sp.source_id       =  sf.source_id 
AND      sf.ie_id           =  ie.ie_id 
AND      sf.source_id       =  s.source_id 
AND      sp.broker          =  pb.broker           (+) 
AND      sp.source_id       =  pb.source_id        (+) 
AND      sp.instrument_type =  mc.instrument_type  (+) 
AND      sp.source_id       =  mc.source_id        (+) 
AND      sp.source_id       =  bb.source_id 
AND      sp.as_of_date      =  bb.as_of_date 
AND      sp.basis           =  bb.best_basis 
AND      sf.source_fund_id  =  bb.source_fund_id 
GROUP BY sf.ie_id 
        ,sf.ie_platform 
        ,sp.as_of_date 
        ,pb.description 
        ,sp.fund||' ('||s.source_name||')' 
        ,sp.basis ;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

