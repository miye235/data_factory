SELECT
   *
FROM
 (
  SELECT
   vlm.lot AS 批號,
   vlm.device AS 料號,
   vlm.wo AS 工單,
   mwh.newquantity AS 數量,
   mwh.transactiontime AS 更新時間,
   mwh.resourcename AS 機台別
  FROM
   mes.view_lotlist_main vlm
  INNER JOIN mes.mes_wip_hist mwh ON mwh.lot = vlm.lot
  AND mwh. TRANSACTION = 'CheckOut'
  AND mwh.oldoperation = 'PSA'
  WHERE
   SEQUENCE = (
    SELECT
     MAX (SEQUENCE)
    FROM
     mes.mes_wip_hist
    WHERE
     lot = vlm.lot
    AND TRANSACTION = 'CheckOut'
    AND oldoperation = 'PSA'
   )
 )