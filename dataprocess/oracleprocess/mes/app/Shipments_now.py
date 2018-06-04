from dataprocess.oracleprocess.mes.base import Base


class ShipmentsNow(object):

    def __init__(self):
        super(ShipmentsNow, self).__init__()
    def __call__(self):
        b=Base()
        self.ora = b.conn('wms')
        sql = open('sqls/直通率/Shipments_now.sql', 'r').read()
        self.ms = b.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['amt', 'num', 'time']
        self.ms.dopost('truncate table ShipmentsNow')
        b.batchwri(res, 'ShipmentsNow',self.ms)
        self.ora.close()
        self.ms.close()
