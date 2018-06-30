# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
class QtyDelRes(object):
    def __init__(self):
        super(QtyDelRes, self).__init__()
    def __call__(self,conns):
        sql = '''select qty
from (SELECT 
  mwh.device,mwh.newquantity qty,substr(mwh.transactiontime,0,10) dat
  FROM MES.view_lotlist_main vlm
  INNER JOIN (select * from MES.mes_wip_hist where 
replace(transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
AND replace(transactiontime,'/','-') < 'today'||' 08:30:00') mwh 
     ON mwh.lot = vlm.lot
    AND mwh.oldoperation = 'Slitter_Inventory'
  WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM MES.mes_wip_hist WHERE lot = vlm.lot AND oldoperation = 'Slitter_Inventory')
   AND substr(vlm.wo,4,1) not in ('E','D') or (substr(vlm.wo,4,1) in ('E','D') and mwh.newquantity >'1000')
   group by mwh.device,mwh.newquantity,substr(mwh.transactiontime,0,10))
 ORDER BY qty'''
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        for day in [b.gettoday(),b.getYesterday()]:
            self.ms.dopost("delete from qty_delres where riqi='"+b.getYesterday(day)+"'")
            res =[x[0] for x in self.ora.doget(sql.replace('yesterday',b.getYesterday(day).replace('/','-')).replace('today',day.replace('/','-'))).values]
            i = 0
            while i < len(res)-1:
                if res[i+1]-res[i]<=5:
                    res.pop(i)
                    i -= 1
                i += 1
            b.batchwri(pd.DataFrame([[b.getYesterday(day),sum(res)]],columns=['riqi','qty']), 'qty_delres',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=QtyDelRes()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
