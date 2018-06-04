from dataprocess.oracleprocess.mes.base import Base


class ShipmentsStatistics(object):

    def __init__(self):
        super(ShipmentsStatistics, self).__init__()
    def __call__(self):
        b=Base()
        self.ora =b.conn('erp')
        sql = open('sqls/直通率/Shipments_statistics.sql', 'r', encoding='utf-8').read()
        self.ms =b.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['ITEM_CODE', 'ONHAND_QUANTITY', 'UNIT_LENGTH', 'UNIT_WIDTH']
        self.ms.dopost('truncate table ShipmentsStatistics')
        b.batchwri(res, 'ShipmentsStatistics',self.ms)
        self.ora.close()
        self.ms.close()
