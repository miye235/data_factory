from dataprocess.oracleprocess.mes.base import Base

class ItemCost(object):
    def __init__(self):
        super(ItemCost, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        b=Base()
        self.ora =b.conn('mes')
        sql = open('../sqls/itemcost.sql', 'r').read()
        self.ms =b.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['ROW_ID','ITEM_NUMBER','ITEM_COST','LAST_UPDATE_DATE']
        self.ms.dopost('truncate table item_cost')
        b.batchwri(res, 'item_cost',self.ms)