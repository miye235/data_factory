SELECT
 日期,
 B.DATA05 DATA05,
 B.LOT LOT
FROM MES.CMMT_CCD_INFO B RIGHT JOIN
  (SELECT
   "料號",
   "批號",
   "產出數量",
   REPLACE(更新時間,'/','-') as 日期,
   "工單",
   OLDOPERATION
  FROM (
    SELECT
     vlm.lot AS 批號,
     vlm.device AS 料號,
     vlm.wo AS 工單,
     mwh.newquantity AS 產出數量,
     mwh. transactiontime AS 更新時間,
     mwh.resourcename AS 機台別,
     mwh.OLDOPERATION
    FROM MES.view_lotlist_main vlm
    INNER JOIN MES.mes_wip_hist mwh
     ON mwh.lot = vlm.lot
     AND mwh.transaction = 'CheckOut'
     AND mwh.OLDOPERATION IN '換貼保護膜'
    WHERE to_date(mwh.transactiontime,'yyyy-mm-dd hh24:mi:ss')>to_date('someday','yyyy-mm-dd hh24:mi:ss')
    AND sequence = (SELECT MAX(sequence)FROM MES.mes_wip_hist
    WHERE lot = vlm.lot
                    AND transaction = 'CheckOut'
                    AND OLDOPERATION ='換貼保護膜'
                )
   ) A
  ) C
 ON B.LOT = C.批號
WHERE B.DATA05 != '非数字'
group by 日期, B.DATA05, B.LOT
ORDER BY 日期 desc