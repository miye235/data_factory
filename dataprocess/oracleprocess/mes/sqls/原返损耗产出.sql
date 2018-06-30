SELECT vlm.lot AS 批號, vlm.device AS 料號, vlm.wo AS 工單, mwh.oldquantity AS 數量, mwh.transactiontime AS 更新時間
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
        and to_date(transactiontime,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('thistime 07:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('thistime 07:00:00','yyyy/mm/dd hh24:mi:ss') + 1