------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_file_availibilty_by_src.sql 1.4 2005/10/20 13:46:02BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_FILE_AVAILIBILTY_BY_SRC
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:48:37
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_file_availibilty_by_src.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_FILE_AVAILIBILTY_BY_SRC

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

CREATE OR REPLACE VIEW VCR.VW_REP_FILE_AVAILIBILTY_BY_SRC AS
SELECT c.calday,TO_CHAR(c.calday,'Dy') dow
      ,c.source_id
      ,c.source_name
      ,j.load_run_no
      ,j.as_of_date
      ,j.basis
      ,j.start_time
      ,j.as_st_diff
      ,j.feed_late
FROM   ( SELECT calday,source_id,source_name
         FROM ( SELECT ( SELECT MIN(as_of_date) FROM source_load_run WHERE basis = 'TPLUS1') + r as calday
                      ,s.source_id
                      ,s.source_name
                FROM   ( SELECT rownum r
                         FROM   all_objects
                         WHERE  ROWNUM <= ( SELECT SYSDATE - MIN(as_of_date) FROM source_load_run WHERE basis = 'TPLUS1')
                       )
                      ,source s -- note cartesian product of source to give a calendar by source
              )
         WHERE TO_CHAR(calday,'Dy') NOT IN ('Sat','Sun') -- jobs dont run on weekends so we filter them
       ) c
      ,(SELECT slr.load_run_no
              ,slr.source_id
              ,slr.as_of_date
              ,slr.basis
              ,slr.start_time
              ,(start_time - as_of_date) * 24 as_st_diff
              ,CASE
               WHEN (utl.pkg_date.add_hours_shrink(utl.pkg_date.calc_weekday(slr.as_of_date,round(s.tplus1_offset/24)),mod(s.tplus1_offset,24))) < slr.start_time THEN 'Y'
               ELSE 'N'
               END feed_late  -- flag on time                  
        FROM   source_load_run slr
              ,source          s
        WHERE  slr.basis       = 'TPLUS1'
        AND    slr.load_run_no = 1
        AND    slr.source_id = s.source_id
       ) j
      ,source   s
WHERE  c.source_id =  s.source_id
AND    utl.pkg_date.add_hours_shrink(utl.pkg_date.calc_weekday(c.calday,round(s.tplus1_offset/24)),mod(s.tplus1_offset,24)) <= sysdate
AND    c.calday    =  j.as_of_date (+)
AND    c.source_id =  j.source_id  (+)
AND    TO_CHAR(c.calday,'Dy') not in ('Sat','Sun');
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

