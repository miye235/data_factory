select * from
(SELECT MAN AS NUM,BAN,
CASE WHEN MAN >= 0 THEN '人检'
END AS LEI
FROM
((SELECT MAN,MACHINE,
CASE WHEN MACHINE >= 0 THEN '夜班'
END AS BAN
FROM
(SELECT
sum(CASE WHEN (LOT LIKE '%.22' OR LOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MAN,
sum(CASE WHEN (LOT NOT LIKE '%.22' OR LOT NOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MACHINE
FROM MES.CMMT_BACK_INSPECT_BIN WHERE SUBSTR(LOT,0,15) IN
(
SELECT
DISTINCT SUBSTR("批號",0,15)
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
) A
WHERE
"工單" LIKE 'K%'
-- AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday 8:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday 16:00:00','yyyy/mm/dd hh24:mi:ss')
--白班
AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday'||' 20:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday'||' 8:00:00','yyyy/mm/dd hh24:mi:ss') +1
--夜班
）))
union all
(SELECT MAN,MACHINE,
CASE WHEN MACHINE >= 0 THEN '白班'
END AS BAN
FROM
(SELECT
sum(CASE WHEN (LOT LIKE '%.22' OR LOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MAN,
sum(CASE WHEN (LOT NOT LIKE '%.22' OR LOT NOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MACHINE
FROM MES.CMMT_BACK_INSPECT_BIN WHERE SUBSTR(LOT,0,15) IN
(
SELECT
DISTINCT SUBSTR("批號",0,15)
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
) A
WHERE
"工單" LIKE 'K%'
 AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday'||' 8:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday'||' 20:00:00','yyyy/mm/dd hh24:mi:ss')
）)))
UNION ALL
(SELECT MACHINE AS NUM,BAN,
CASE WHEN MAN >= 0 THEN '机检'
END AS LEI
FROM
((SELECT MAN,MACHINE,
CASE WHEN MACHINE >= 0 THEN '夜班'
END AS BAN
FROM
(SELECT
sum(CASE WHEN (LOT LIKE '%.22' OR LOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MAN,
sum(CASE WHEN (LOT NOT LIKE '%.22' OR LOT NOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MACHINE
FROM MES.CMMT_BACK_INSPECT_BIN WHERE SUBSTR(LOT,0,15) IN
(
SELECT
DISTINCT SUBSTR("批號",0,15)
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
) A
WHERE
"工單" LIKE 'K%'
-- AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday 8:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday 16:00:00','yyyy/mm/dd hh24:mi:ss')
--白班
AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday'||' 20:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday'||' 8:00:00','yyyy/mm/dd hh24:mi:ss') +1
--夜班
）))
union all
(SELECT MAN,MACHINE,
CASE WHEN MACHINE >= 0 THEN '白班'
END AS BAN
FROM
(SELECT
sum(CASE WHEN (LOT LIKE '%.22' OR LOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MAN,
sum(CASE WHEN (LOT NOT LIKE '%.22' OR LOT NOT LIKE '%.1') THEN QUANTITY ELSE 0 END) AS MACHINE
FROM MES.CMMT_BACK_INSPECT_BIN WHERE SUBSTR(LOT,0,15) IN
(
SELECT
DISTINCT SUBSTR("批號",0,15)
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
) A
WHERE
"工單" LIKE 'K%'
 AND to_date("更新時間",'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('someday'||' 8:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('someday'||' 20:00:00','yyyy/mm/dd hh24:mi:ss')
）)))))
where BAN = '白班' or  BAN = '夜班'