# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class MaterialPrice(object):
    def __init__(self):
        super(MaterialPrice, self).__init__()
    def __call__(self,conns):
        sql ="select * from APPS.CST_ITEM_COST_TYPE_V"
        b=Base()
        self.ora =conns['erp']
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table materialprice')
        b.batchwri(res, 'materialprice',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=MaterialPrice()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
