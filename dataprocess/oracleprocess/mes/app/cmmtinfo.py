# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class CmmtInfo(object):
    def __init__(self):
        super(CmmtInfo, self).__init__()
    def __call__(self,conns):
        sql = '''SELECT 
 *
 FROM MES.CMMT_CCD_INFO'''
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table CMMT_CCD_INFO')
        b.batchwri(res, 'CMMT_CCD_INFO',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=CmmtInfo()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
