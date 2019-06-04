------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_file_availibilty_by_fnd.sql 1.5 2005/10/20 13:46:02BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_FILE_AVAILIBILTY_BY_FND
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:48:17
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_file_availibilty_by_fnd.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_FILE_AVAILIBILTY_BY_FND

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

CREATE OR REPLACE VIEW VCR.VW_REP_FILE_AVAILIBILTY_BY_FND AS
SELECT c.calday,TO_CHAR(c.calday,'Dy') dow
      ,c.fund
      ,s.source_name
      ,j.as_of_date
      ,j.start_time
      ,nvl(j.feed_late,'N') feed_late
      ,j.load_run_id
      ,j.investment_engine
FROM   ( SELECT calday,source_id,fund
         FROM ( SELECT ( SELECT MIN(as_of_date) FROM source_load_run WHERE basis = 'TPLUS1') + r as calday
                      ,sf.source_id
                      ,sf.fund
                FROM   ( SELECT rownum r
                         FROM   all_objects
                         WHERE  ROWNUM <= ( SELECT SYSDATE - MIN(as_of_date) FROM source_load_run WHERE basis = 'TPLUS1')
                       )
                      ,source_fund sf -- note cartesian product of source_fund to give a calendar by source funds
              )
         WHERE TO_CHAR(calday,'Dy') NOT IN ('Sat','Sun') -- jobs dont run on weekends so we filter them
       ) c  --- this view generates the calendar that excludes Saturday and Sundays
      ,(SELECT slr.load_run_no
              ,slr.source_id
              ,slr.as_of_date
              ,slr.basis
              ,slr.start_time
              ,slr.load_run_id
              ,spsf.fund
              ,spsf.investment_engine
              ,CASE
               WHEN (utl.pkg_date.add_hours_shrink(utl.pkg_date.calc_weekday(slr.as_of_date,round(s.tplus1_offset/24)),mod(s.tplus1_offset,24))) < slr.start_time THEN 'Y'
               ELSE 'N'
               END feed_late  -- flag on time               
        FROM   source_load_run slr
              ,source          s
              ,(SELECT DISTINCT sp.load_run_id,sp.source_id
                      ,sp.as_of_date,sp.basis,sf.fund,ie.description investment_engine
                FROM   source_position   sp
                      ,source_fund       sf
                      ,investment_engine ie
                WHERE  sp.source_id = sf.source_id
                AND    sp.fund      = sf.fund
                AND    sf.ie_id     = ie.ie_id     (+)
                ) spsf
        WHERE  slr.basis       = 'TPLUS1'
        AND    slr.load_run_no = 1
        AND    slr.source_id   = s.source_id
        AND    slr.load_run_id = spsf.load_run_id
        AND    slr.source_id   = spsf.source_id
        AND    slr.as_of_date  = spsf.as_of_date
        AND    slr.basis       = spsf.basis
       ) j
      ,source   s
WHERE  c.source_id =  s.source_id --
AND    utl.pkg_date.add_hours_shrink(utl.pkg_date.calc_weekday(c.calday,round(s.tplus1_offset/24)),mod(s.tplus1_offset,24)) <= sysdate
AND    c.calday    = j.as_of_date (+)
AND    c.fund      = j.fund       (+);
/


------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

