SELECT
   vlm.lot AS 批號,
   vlm.device AS 料號,
   vlm.wo AS 工單,
   mwh.newquantity AS 产量,
   replace(mwh.transactiontime,'/','-') AS 日期,
   mwh.resourcename AS 機台別,
   mwh.OLDOPERATION
  FROM MES.view_lotlist_main vlm
  INNER JOIN MES.mes_wip_hist mwh
   ON mwh.lot = vlm.lot
   AND mwh.transaction = 'CheckOut'
   AND mwh.OLDOPERATION IN ('PVA','TAC-PVA')
  WHERE sequence = (SELECT MAX(sequence)FROM MES.mes_wip_hist
  WHERE lot = vlm.lot
   AND transaction = 'CheckOut'
   AND OLDOPERATION IN ('PVA','TAC-PVA')
      )
