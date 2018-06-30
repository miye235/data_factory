# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class ShouldGet(object):
    def __init__(self):
        super(ShouldGet, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['erp']
        self.ms =conns['offline']
        sql = open(b.path1+'sqls/应收账款.sql', 'r').read()
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table should_get_mon')
        b.batchwri(res, 'should_get_mon',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=ShouldGet()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()