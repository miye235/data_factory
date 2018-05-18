select DATA, PARAMETER, SAMPLESEQ,OPERATION,LOT
FROM (
    SELECT "DATA", "DEVICE", "DEVICE_DESCR", "LOT", "MATERIAL",
    "OPERATION", "PARAMETER", "RESOURCENAME", "SAMPLESEQ", "UPDATETIME", "USERID", "WO"
    FROM (
        SELECT AA.LOT, AA.WO, AA.MATERIAL, AA.DEVICE, AA.DEVICE_DESCR,
        AA.PARAMETER, AA.SAMPLESEQ, AA.DATA, AA.USERID, AA.UPDATETIME,
        AA.OPERATION, BB.RESOURCENAME
        FROM (
            SELECT vlm.LOT, mell.WO, vlm.MATERIAL, vlm.DEVICE, vlm.DEVICE_DESCR,
            meld.PARAMETER, meld.SAMPLESEQ, meld.DATA, meli.userid, meli.updatetime,
            to_char(meli.OPERATION) AS OPERATION
            FROM MES.view_lotlist_main vlm
            INNER JOIN MES.mes_edc_lotinfo meli ON meli.lot = vlm.lot
            INNER JOIN MES.mes_edc_lotdata meld ON meld.edc_lotinfo_sid = meli.edc_lotinfo_sid
            INNER JOIN MES.VIEW_LOTLIST_MAIN mell ON mell.lot = vlm.lot
            ) AA
        INNER JOIN (
            SELECT DISTINCT LOT, NEWOPERATION, RESOURCENAME
            FROM MES.MES_WIP_HIST
            where to_date(TRANSACTIONTIME,'yyyy-MM-dd hh24:mi:ss')>=to_date('begintime','yyyy-MM-dd hh24:mi:ss')
            and to_date(TRANSACTIONTIME,'yyyy-MM-dd hh24:mi:ss')<to_date('endtime','yyyy-MM-dd hh24:mi:ss')
            ) BB
        ON AA.LOT = BB.LOT AND AA.OPERATION = BB.NEWOPERATION
        WHERE BB.RESOURCENAME IS NOT NULL) A
    ) B
where B.PARAMETER LIKE '%curl%'
GROUP BY DATA, SAMPLESEQ, PARAMETER ,OPERATION,LOT
ORDER BY CASE WHEN B.PARAMETER LIKE '%DS' then 1
              WHEN B.PARAMETER LIKE '%DS_01' then 2
        WHEN B.PARAMETER LIKE '%M' then 3
              WHEN B.PARAMETER LIKE '%M_01' then 4
        WHEN B.PARAMETER LIKE '%OS' THEN 5
              WHEN B.PARAMETER LIKE '%OS_01' THEN 6
        ELSE 7
        END, SAMPLESEQ