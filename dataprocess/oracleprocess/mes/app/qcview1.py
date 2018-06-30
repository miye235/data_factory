# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class QcVim1(object):
    def __init__(self):
        super(QcVim1, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        sql = "select * from MES.qcview1"
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table qcvim1')
        b.batchwri(res, 'qcvim1',self.ms)


# if __name__ == '__main__':
#     base = Base()
#     erp = base.conn('erp')
#     offline = base.conn('offline')
#     wms = base.conn('wms')
#     mes = base.conn('mes')
#     conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
#     zc=QcVim1()
#     zc(conns)
#     offline.close()
#     erp.close()
#     wms.close()
#     mes.close()
