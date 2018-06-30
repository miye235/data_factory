# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class QCview(object):
    def __init__(self):
        super(QCview, self).__init__()
    def __call__(self,conns):
        sql = '''
        SELECT "DEFECTTYPE", "DEVICE"
            , "LOT",  "LOTQUANTITY",  "OPERATION"
            , "PVACHECKOUTTIME", "PVARESNAME",  "QCRESULTCUST", "QCRESULTSYS"
            , "QUANTITY", "REMARK", "RESOURCENAME"
            , replace("UPDATETIME",'/','-') AS dat,  "VISUALRESULT", "WO"
        FROM MES.qcview'''
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table qcview')
        b.batchwri(res, 'qcview',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=QCview()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
