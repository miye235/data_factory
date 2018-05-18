SELECT "料號", "批號", "數量", "更新時間", "工單" FROM
(
SELECT LOT,transactiontime FROM mes.mes_wip_hist WHERE transaction = 'CheckIn' and oldoperation = 'PSA' and LOT IN
(
    SELECT SUBLOT FROM MES.MES_WIP_MERGE mwm INNER JOIN
    (
            SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 數量, mwh.transactiontime AS 更新時間
                , mwh.resourcename AS 機台別
            FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh
                ON mwh.lot = vlm.lot
                    AND mwh.transaction = 'CheckOut'
                    AND mwh.oldoperation = 'PSA'
            WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                    AND transaction = 'CheckOut'
                    AND oldoperation = 'PSA'
        )
    ) AA ON mwm.PARENTLOT = AA.批號

     UNION

     SELECT  vlm.lot AS 批號
            FROM mes.view_lotlist_main vlm
                INNER JOIN mes.mes_wip_hist mwh
                ON mwh.lot = vlm.lot
                    AND mwh.transaction = 'CheckOut'
                    AND mwh.oldoperation = 'PSA'

            WHERE sequence = (
                SELECT MAX(sequence)
                FROM mes.mes_wip_hist
                WHERE lot = vlm.lot
                    AND transaction = 'CheckOut'
                    AND oldoperation = 'PSA'

        )

    )
)BBB

INNER JOIN

(SELECT "料號", "批號", "數量", "更新時間", "工單"
FROM (
    SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.newquantity AS 數量, mwh.transactiontime AS 更新時間
        , mwh.resourcename AS 機台別
    FROM mes.view_lotlist_main vlm
        INNER JOIN mes.mes_wip_hist mwh
        ON mwh.lot = vlm.lot
            AND mwh.transaction = 'CheckIn'
            AND mwh.oldoperation = 'PSA'

    WHERE sequence = (
        SELECT MAX(sequence)
        FROM mes.mes_wip_hist
        WHERE lot = vlm.lot
            AND transaction = 'CheckIn'
            AND oldoperation = 'PSA'
    )
) )A

ON A.批號 = BBB.LOT