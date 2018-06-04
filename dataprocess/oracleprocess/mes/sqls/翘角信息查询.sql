select x.PVA站生产时间,x.PSA站生产时间,y.裁切生产时间,p.TRANSACTIONTIME,x.前段批号,x.分条批号,y.LOT as 后段批号
from
 (select g.PVA站生产时间 as PVA站生产时间,g.PSA站生产时间 as PSA站生产时间,
         g.LOT as 前段批号，h.LOT as 分条批号
 from
     (select e.LOT as LOT, e.PVA站生产时间 as PVA站生产时间, f.PSA站生产时间 as PSA站生产时间
  from
   (select a.LOT as LOT,b.TRANSACTIONTIME as PVA站生产时间
   from   MES.MES_WIP_LOT_NONACTIVE a , MES.MES_WIP_HIST b
   where  a.LOT=b.LOT
	 and to_date(b.TRANSACTIONTIME,'yyyy-mm-dd hh24:mi:ss')>=to_date('btime','yyyy-mm-dd hh24:mi:ss')
	 and to_date(b.TRANSACTIONTIME,'yyyy-mm-dd hh24:mi:ss')<to_date('etime','yyyy-mm-dd hh24:mi:ss')
   and    a.MATERIAL  is null
   and    b.OPERATIONNO='PVA'
   AND    b.TRANSACTION='CheckOut') e
   left join
   (select a.LOT as LOT,b.TRANSACTIONTIME as PSA站生产时间
   from   MES.MES_WIP_LOT_NONACTIVE a , MES.MES_WIP_HIST b
   where  a.LOT=b.LOT
   and    a.MATERIAL  is null
   and    b.OPERATIONNO='PSA'
   AND    b.TRANSACTION='CheckOut') f
  on e.LOT=f.LOT) g
  left join
  (select MATERIAL ,LOT
   from mes.MES_WIP_LOT_NONACTIVE
   where LOT LIKE 'KP1-S%') h
 on  g.LOT=h.MATERIAL) x
 left join
 (select a.LOT as LOT,a.MATERIAL as MATERIAL,b.TRANSACTIONTIME as 裁切生产时间
  from   MES.MES_WIP_LOT_NONACTIVE a , MES.MES_WIP_HIST b
  where  a.LOT=b.LOT
  and    a.lot not like '%-S-%'
  AND    b.TRANSACTION='CheckOut') y
on   (x.分条批号=y.MATERIAL
      or
      x.前段批号=y.MATERIAL)
left join MES.MES_WIP_HIST p
on (y.LOT=p.LOT
   and
   p.TRANSACTION='CheckOut')
 ORDER BY x.前段批号