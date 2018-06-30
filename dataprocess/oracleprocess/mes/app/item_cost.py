# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base


class ItemCost(object):
    def __init__(self):
        super(ItemCost, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self,conns):
        b=Base()
        yday=b.getYesterday()
        self.ora =conns['erp']
        sql = open(b.path1+'sqls/itemcost.sql', 'r').read().replace('yesterday',yday)
        self.ms =b.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['ROW_ID','ITEM_NUMBER','ITEM_COST','LAST_UPDATE_DATE']
        self.ms.dopost("delete from item_cost where LAST_UPDATE_DATE>'"+yday+' 00:00:00'+"'")
        b.batchwri(res, 'item_cost',self.ms)
