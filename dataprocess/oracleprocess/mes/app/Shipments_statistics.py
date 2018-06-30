# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base


class ShipmentsStatistics(object):

    def __init__(self):
        super(ShipmentsStatistics, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['erp']
        sql = open(b.path1+'sqls/直通率/Shipments_statistics.sql', 'r', encoding='utf-8').read()
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        res.columns = ['ITEM_CODE', 'ONHAND_QUANTITY', 'UNIT_LENGTH', 'UNIT_WIDTH']
        self.ms.dopost('truncate table ShipmentsStatistics')
        b.batchwri(res, 'ShipmentsStatistics',self.ms)
