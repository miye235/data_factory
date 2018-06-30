# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base


class ShipmentsNow(object):

    def __init__(self):
        super(ShipmentsNow, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['wms']
        sql = open(b.path1+'sqls/直通率/Shipments_now.sql', 'r').read()
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        res.columns = ['amt', 'num', 'time']
        self.ms.dopost('truncate table ShipmentsNow')
        b.batchwri(res, 'ShipmentsNow',self.ms)
