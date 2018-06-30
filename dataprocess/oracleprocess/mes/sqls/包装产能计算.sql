SELECT 
'夜班' 夜班,
'人检' 人检,
sum(CASE WHEN (B.LOT LIKE '%.22' OR B.LOT LIKE '%.1') and to_date(A.更新時間,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('yesterday 20:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('today 08:00:00','yyyy/mm/dd hh24:mi:ss') THEN B.QUANTITY ELSE 0 END) AS 夜班人检
FROM MES.CMMT_BACK_INSPECT_BIN B,
(
SELECT 
DISTINCT SUBSTR("批號",0,15) 批號,更新時間,工單
FROM (
        SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 產出數量, mwh.transactiontime AS 更新時間
                , mwh.resourcename AS 機台別 , mwh.OLDOPERATION, mwh.NEWOPERATION
        FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh ON mwh.lot = vlm.lot
        AND mwh.transaction = 'CheckOut'
        AND mwh.oldoperation like '檢查%' 
        WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                        AND transaction = 'CheckOut'
                        AND oldoperation like '檢查%'
        )
) C

WHERE  C.工單 LIKE 'K%'
) A
WHERE SUBSTR(B.LOT,0,15) = A.批號
UNION
SELECT 
'夜班' 夜班,
'机检' 机检,
sum(CASE WHEN (B.LOT NOT LIKE '%.22' OR B.LOT NOT LIKE '%.1') and to_date(A.更新時間,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('yesterday 20:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('today 08:00:00','yyyy/mm/dd hh24:mi:ss') THEN B.QUANTITY ELSE 0 END) AS 夜班机检
FROM MES.CMMT_BACK_INSPECT_BIN B,
(
SELECT 
DISTINCT SUBSTR("批號",0,15) 批號,更新時間,工單
FROM (
        SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 產出數量, mwh.transactiontime AS 更新時間
                , mwh.resourcename AS 機台別 , mwh.OLDOPERATION, mwh.NEWOPERATION
        FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh ON mwh.lot = vlm.lot
        AND mwh.transaction = 'CheckOut'
        AND mwh.oldoperation like '檢查%' 
        WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                        AND transaction = 'CheckOut'
                        AND oldoperation like '檢查%'
        )
) C

WHERE  C.工單 LIKE 'K%'
) A
WHERE SUBSTR(B.LOT,0,15) = A.批號
UNION
SELECT 
'白班' 白班,
'人检' 人检,
sum(CASE WHEN (B.LOT LIKE '%.22' OR B.LOT LIKE '%.1') and to_date(A.更新時間,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('today 08:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('today 20:00:00','yyyy/mm/dd hh24:mi:ss')  THEN B.QUANTITY ELSE 0 END) AS 白班人检
FROM MES.CMMT_BACK_INSPECT_BIN B,
(
SELECT 
DISTINCT SUBSTR("批號",0,15) 批號,更新時間,工單
FROM (
        SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 產出數量, mwh.transactiontime AS 更新時間
                , mwh.resourcename AS 機台別 , mwh.OLDOPERATION, mwh.NEWOPERATION
        FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh ON mwh.lot = vlm.lot
        AND mwh.transaction = 'CheckOut'
        AND mwh.oldoperation like '檢查%' 
        WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                        AND transaction = 'CheckOut'
                        AND oldoperation like '檢查%'
        )
) C

WHERE  C.工單 LIKE 'K%'
) A
WHERE SUBSTR(B.LOT,0,15) = A.批號
UNION
SELECT 
'白班' 白班,
'机检' 机检,
sum(CASE WHEN (B.LOT LIKE '%.22' OR B.LOT not LIKE '%.1') and to_date(A.更新時間,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('today 08:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('today 20:00:00','yyyy/mm/dd hh24:mi:ss')  THEN B.QUANTITY ELSE 0 END) AS 白班人检
FROM MES.CMMT_BACK_INSPECT_BIN B,
(
SELECT 
DISTINCT SUBSTR("批號",0,15) 批號,更新時間,工單
FROM (
        SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 產出數量, mwh.transactiontime AS 更新時間
                , mwh.resourcename AS 機台別 , mwh.OLDOPERATION, mwh.NEWOPERATION
        FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh ON mwh.lot = vlm.lot
        AND mwh.transaction = 'CheckOut'
        AND mwh.oldoperation like '檢查%' 
        WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                        AND transaction = 'CheckOut'
                        AND oldoperation like '檢查%'
        )
) C

WHERE  C.工單 LIKE 'K%'
) A
WHERE SUBSTR(B.LOT,0,15) = A.批號