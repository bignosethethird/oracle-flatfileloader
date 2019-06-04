------------------------------------------------------------------------------
-- $Header: vcr/views/vw_rep_fund_ror_tol.sql 1.9 2005/10/19 14:28:41BST apenney DEV  $
------------------------------------------------------------------------------
-- Creation script for view VCR.VW_REP_FUND_ROR_TOL
--
-- This file was generated from database instance VCRD1.
--   Database Time    : 22AUG2005 17:00:56
--   IP address       : 10.44.0.228
--   Database Language: AMERICAN_AMERICA.WE8ISO8859P1
--   Client Machine   : misqux42
--   O/S user         : vcrdev
-- To run this script from the command line:
-- sqlplus VCR/[password]@[instance] @vw_rep_fund_ror_tol.sql
------------------------------------------------------------------------------
set feedback off;
prompt Creating view VCR.VW_REP_FUND_ROR_TOL

------------------------------------------------------------------------------
-- Create view
------------------------------------------------------------------------------

create or replace view VCR.VW_REP_FUND_ROR_TOL (
  CAL_ME_FUND
, CAL_SOURCE
, CAL_ME_FUND_ID
, CAL_FUND
, CAL_AS_OF_DATE
, CAL_PRIOR_AS_OF_DATE
, TP1_MEASURE
, TP1_FUND
, TP1_AS_OF_DATE
, TP1_MTD_ROR_VALUE
, TP1_ME_FUND_ID
, TC_MEASURE
, TC_FUND
, TC_AS_OF_DATE
, TC_MTD_ROR_VALUE
, TC_ME_FUND_ID
, MGR_MEASURE
, MGR_FUND
, MGR_AS_OF_DATE
, MGR_MTD_ROR_VALUE
, MGR_ME_FUND_ID
, PTP1_MEASURE
, PTP1_FUND
, PTP1_AS_OF_DATE
, PTP1_ORIG_MTD_ROR_VALUE
, PTP1_ME_FUND_ID
, PTP1_OFFSET
, PTP1_UPPER
, PTP1_LOWER
) as 
SELECT  cf.* 
       ,tp1f.* 
       ,tcf.* 
       ,mgr.* 
       ,ptp1f.* 
FROM (  SELECT   'TPLUS1 VSP FUND'      tp1_measure 
                ,sf.fund                tp1_fund 
                ,cmr.as_of_date         tp1_as_of_date 
                ,cmr.value * 100        tp1_mtd_ror_value 
                ,sf.me_fund_id          tp1_me_fund_id 
        FROM     source_fund            sf 
                ,calculated_mtd_ror cmr 
        WHERE    cmr.source_object_type = 'FUND' 
        AND      cmr.source_object_id   = sf.source_fund_id 
        AND      cmr.source_id          = sf.source_id 
        AND      cmr.basis              = 'TPLUS1' 
     ) tp1f 
    ,(  SELECT   'TCLEAN VSP FUND'      tc_measure 
                ,sf.fund                tc_fund 
                ,cmr.as_of_date         tc_as_of_date 
                ,cmr.value * 100        tc_mtd_ror_value 
                ,sf.me_fund_id          tc_me_fund_id 
        FROM     source_fund            sf 
                ,calculated_mtd_ror     cmr 
        WHERE    cmr.source_object_type = 'FUND' 
        AND      cmr.source_object_id   = sf.source_fund_id 
        AND      cmr.source_id          = sf.source_id 
        AND      cmr.basis              = 'TCLEAN' 
     ) tcf 
    ,( SELECT    'MANAGER FUND'         mgr_measure 
                ,sf.fund                mgr_fund 
                ,rmv.as_of_date         mgr_as_of_date 
                ,rmv.value * 100        mgr_mtd_ror_value 
                ,sf.me_fund_id          mgr_me_fund_id 
       FROM      source_fund            sf 
                ,ref_measure_value      rmv 
       WHERE     sf.me_fund_id          = rmv.ref_object_id 
       AND       rmv.measure            = 'MTDROR' 
       AND       rmv.as_of_date         = rmv.actual_as_of_date 
     ) mgr 
    ,( SELECT   'PRIOR TPLUS1 VSP FUND ' ptp1_measure 
                ,sf.fund                                  ptp1_fund 
                ,cmr.as_of_date                           ptp1_as_of_date 
                ,cmr.value * 100                          ptp1_orig_mtd_ror_value 
                ,sf.me_fund_id                            ptp1_me_fund_id 
                ,vcr.pkg_limit.get_version_values(l.limit_id, lv.limit_version) ptp1_offset 
                ,cmr.value * 100 + vcr.pkg_limit.get_version_value(l.limit_id, lv.limit_version,1) ptp1_upper 
                ,cmr.value * 100 + vcr.pkg_limit.get_version_value(l.limit_id, lv.limit_version,2) ptp1_lower 
       FROM     limit                  l 
               ,limit_version          lv 
               ,limit_header_value     lhv 
               ,limit_header_parameter lhp 
               ,source_fund            sf 
               ,calculated_mtd_ror     cmr 
       WHERE    l.measure_id            = utl.pkg_config.get_variable_int('exception.tol_level.measure_id') 
       AND      l.rule_id               = utl.pkg_config.get_variable_int('exception.tol_level.rule_id') 
       AND      l.limit_id              = lv.limit_id 
       AND      (    (cmr.as_of_date >= lv.start_date AND cmr.as_of_date <= lv.end_date) 
                  OR (cmr.as_of_date >= lv.start_date AND lv.end_date is null        ) 
                ) 
       AND      lhv.limit_id            = l.limit_id 
       AND      lhp.header_parameter_id = lhv.header_parameter_id 
       AND      (     (lhp.column_name  = 'source_fund_id' AND lhv.value = sf.source_fund_id ) 
                  OR  (lhp.column_name  = 'ie_id'          AND lhv.value = sf.ie_id          ) 
                ) 
       AND      cmr.basis               = 'TPLUS1' 
       AND      cmr.source_object_type  = 'FUND' 
       AND      sf.me_fund_id           IS NOT NULL 
       AND      sf.source_fund_id       = cmr.source_object_id 
       AND      sf.source_id            = cmr.source_id 
     ) ptp1f 
    ,( SELECT   ro.ref_object_code    cal_me_fund 
               ,s.source_name         cal_source 
               ,sf.me_fund_id         cal_me_fund_id 
               ,sf.fund               cal_fund 
               ,cf.as_of_date         cal_as_of_date 
               ,cf.prior_as_of_date   cal_prior_as_of_date 
       FROM ( SELECT source_object_id
                    ,as_of_Date 
                    ,LAG(as_of_date,1) OVER (PARTITION BY source_object_id ORDER BY as_of_date) as prior_as_of_date 
              FROM  (SELECT DISTINCT as_of_date, source_object_id 
                     FROM   calculated_mtd_ror     cmr 
                     WHERE  cmr.source_object_type = 'FUND' ) 
            ) cf 
             ,source_fund sf 
             ,ref_object  ro 
             ,source      s 
       WHERE sf.source_id        = s.source_id 
       AND   sf.me_fund_id       = ro.ref_object_id           (+) 
       AND   cf.source_object_id = sf.source_fund_id
    ) cf 
WHERE  cf.cal_as_of_date         = tp1f.tp1_as_of_date        (+) 
AND    cf.cal_fund               = tp1f.tp1_fund              (+) 
AND    cf.cal_as_of_date         = tcf.tc_as_of_date          (+) 
AND    cf.cal_fund               = tcf.tc_fund                (+) 
AND    cf.cal_as_of_date         = mgr.mgr_as_of_date         (+) 
AND    cf.cal_fund               = mgr.mgr_fund               (+) 
AND    cf.cal_prior_as_of_date   = ptp1f.ptp1_as_of_date      (+) 
AND    cf.cal_fund               = ptp1f.ptp1_fund            (+) ;
/

------------------------------------------------------------------------------
-- end of file
------------------------------------------------------------------------------

