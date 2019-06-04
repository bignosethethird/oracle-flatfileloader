------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_num_trades_per_instrmnt.sql 1.7 2005/10/25 15:43:13BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_NUM_TRADES_PER_INSTRMNT
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:56
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_num_trades_per_instrmnt.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_NUM_TRADES_PER_INSTRMNT

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_NUM_TRADES_PER_INSTRMNT (
  INVESTMENT_ENGINE
, INVESTMENT_ENGINE_PLATFORM
, FUND
, INSTRUMENT_TYPE
, CURRENT_AS_OF_DATE
, TOTAL_POSITIONS
, PREVIOUS_AS_OF_DATE
, PREVIOUS_TOTAL_POSITIONS
, POSITION_DIFF
) as 
SELECT (SELECT ie_id FROM source_fund WHERE source_id = counts.source_id AND fund = counts.fund) investment_engine,
       (SELECT ie_platform FROM source_fund WHERE source_id = counts.source_id AND fund = counts.fund) investment_engine_platform,       
       counts.fund||' ('||counts.source_name||')' fund,
       counts.instrument_type,
       counts.as_of_date current_as_of_date,
       counts.total_positions,
       counts.previous_as_of_date,
       counts.previous_total_positions,
       counts.total_positions-counts.previous_total_positions position_diff
FROM
(
SELECT this_sp.source_id,
       this_sp.fund,
  		 this_sp.instrument_type,
		   this_sp.as_of_date, 
		   count(*)           total_positions, 
		   this_sp.last_as_of_date                previous_as_of_date, 
		   SUM(nvl2(last_sp.key,1,0))           previous_total_positions,
       s.source_name	     
FROM   
       (
         SELECT sp.as_of_date,
                sp.source_id,
                sp.basis,
                sp.fund,
                sp.instrument_type,
                sp.key,
                sp.seq_id,
                sp.instrument_holding,
                lastrun.as_of_date last_as_of_date,
                lastrun.basis      last_basis
        FROM  
        (
          SELECT  source_id, as_of_date, basis, rownum r
          FROM
          (
            SELECT   DECODE(MIN(basis_rank),1,'TCLEAN',2,'TPLUS1') basis,
                     slr.source_id, 
                     slr.as_of_date
            FROM    ( SELECT DISTINCT source_id,
                                      basis,
                                      DECODE(basis,'TCLEAN',1,'TPLUS1',2) basis_rank, 
                                      as_of_date 
                      FROM   source_load_run 
                      WHERE  status = 'COM') slr
            GROUP BY slr.source_id ,slr.as_of_date
            ORDER BY slr.source_id, slr.as_of_date
          )
        ) thisrun,
        (
          SELECT  source_id, as_of_date, basis, rownum+1 r
          FROM
          (
            SELECT   DECODE(MIN(basis_rank),1,'TCLEAN',2,'TPLUS1') basis,
                     slr.source_id, 
                     slr.as_of_date
            FROM    ( SELECT DISTINCT source_id,
                                      basis,
                                      DECODE(basis,'TCLEAN',1,'TPLUS1',2) basis_rank, 
                                      as_of_date 
                      FROM   source_load_run 
                      WHERE  status = 'COM') slr
            GROUP BY slr.source_id ,slr.as_of_date
            ORDER BY slr.source_id, slr.as_of_date
          )
        ) lastrun,
        source_position sp
        WHERE  thisrun.source_id     = lastrun.source_id
        AND    thisrun.r             = lastrun.r
        AND    thisrun.source_id     = sp.source_id
        AND    thisrun.as_of_date    = sp.as_of_date
        AND    thisrun.basis         = sp.basis
        ) this_sp,
        source_position last_sp,
        source s
WHERE   this_sp.source_id       = last_sp.source_id (+)
AND     this_sp.last_basis      = last_sp.basis (+)
AND     this_sp.last_as_of_date = last_sp.as_of_date (+)
AND     this_sp.key             = last_sp.key (+)
AND     this_sp.seq_id          = last_sp.seq_id (+)
AND     this_sp.instrument_holding = last_sp.instrument_holding (+)
AND     this_sp.source_id       = s.source_id
GROUP BY this_sp.as_of_date,this_sp.fund,this_sp.instrument_type,this_sp.last_as_of_date,s.source_name,this_sp.source_id
ORDER BY this_sp.fund,this_sp.instrument_type
) counts;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

