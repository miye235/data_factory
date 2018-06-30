select * from
(
select 批號,料號,數量,工單,max(更新時間) AS 更新時間 from
(select distinct bb.批號,bb.料號,bb.數量,bb.工單,mwh.transactiontime AS 更新時間 from
(select 批號,料號,
case when count(批號) >= 2 then min(數量)
 when count(批號) < 2 then min(數量)
end as 數量,
工單
from
(SELECT distinct mwh.lot AS 批號, mwh.device AS 料號,
-- case when mwh.newquantity < mwh.oldquantity and mwh.transaction = 'Split' then 0
--  when mwh.oldquantity = 0 and mwh.transaction = 'Split' then mwh.newquantity
--  else mwh.newquantity
-- end AS a,
mwh.newquantity as 數量,vlm.wo AS 工單,mwh.transactiontime AS 更新時間
FROM mes.mes_wip_hist mwh
inner JOIN mes.view_lotlist_main vlm ON mwh.lot = vlm.lot
WHERE
(mwh.transaction = 'CheckIn' or mwh.transaction = 'Split')
and mwh.oldoperation = 'PSA'
-- and to_date(transactiontime,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('2018/05/02 07:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('2018/05/02 07:00:00','yyyy/mm/dd hh24:mi:ss') + 1
and mwh.LOT IN
(
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
     and to_date(transactiontime,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') + 1
) ) a group by 批號,料號,工單)bb
left join mes.mes_wip_hist mwh
on bb.批號 = mwh.lot
and bb.料號 = mwh.device
and bb.數量 = mwh.newquantity
where (mwh.transaction = 'CheckIn' or mwh.transaction = 'Split')
and mwh.oldoperation = 'PSA')
group by 批號,料號,數量,工單
union
SELECT SUBLOT AS 批號, 料號, MERGEQTY as 数量, 工單 , 更新時間 FROM MES.MES_WIP_MERGE mwm INNER JOIN
    (
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
        and to_date(transactiontime,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') + 1
    ) AA ON mwm.PARENTLOT = AA.批號
union
select a.批號,a.料號,a.数量,b.wo as 工單,a.更新時間  from
(select mwb.lot as 批號,mwh.device AS 料號,mwb.BONUSQTY as 数量 , mwh.transactiontime AS 更新時間
from mes.mes_wip_bonus mwb
inner join mes.mes_wip_hist mwh
on mwb.WIP_HIST_SID = mwh.WIP_HIST_SID
where 1=1
 and mwb.operation like 'PSA'
 and to_date(mwb.updatetime,'yyyy/MM/dd hh24:mi:ss') BETWEEN to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') AND to_date('thisdate 07:00:00','yyyy/mm/dd hh24:mi:ss') + 1
 )a
 inner join mes.view_lotlist_main b on a.批號 = b.lot
 )