# -*- coding: UTF-8 -*-
import sys
sys.path.append('/home/openstack/data_offline/data_factory/')
from dataprocess.oracleprocess.mes.base import Base

class SWG(object):
    def __init__(self):
        super(SWG, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['wms']
        self.ms =conns['offline']
        sql ='''
        select  
SUM(QTY)/1000 QTY,ITEM_CODE 
FROM WMS.A_PALLET_ITEM 
WHERE  SUBINVENTORY_CODE IN ('F1FGA','F1RDA','F1CAA') AND QC_STATUS NOT IN ('B','D')
GROUP BY ITEM_CODE'''
        res = self.ora.doget(sql)
        day=base.gettoday()
        res['日期']=day
        self.ms.dopost("delete from swgkc where 日期='"+day+"'")
        b.batchwri(res, 'swgkc',self.ms)

base = Base()
offline = base.conn('offline')
offline1 = base.conn('offline_test')
wms = base.conn('wms')
conns = {'offline': offline,'wms': wms}
conns1 = {'offline': offline1,'wms': wms}
t3s = SWG()
t3s(conns)
t3s(conns1)
offline.close()
wms.close()
