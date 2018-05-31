from dataprocess.oracleprocess.mes.base import Base
import os
class ChuHuo(object):
    def __init__(self):
        super(ChuHuo, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.ora = b.conn('erp')
        self.ms = b.conn('offline')
        sql = open('../sqls/出货统计.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['出货性质','Size','Shipment Date','销售面积','含税金额','Unit Selling Price','QTY','SUBINVENTORY','Item Number','Customer Name','F/R','单位面积','未税金额','含税单价']
        res['id']=0
        self.ms.dopost('truncate table chuhuotongji')
        b.batchwri(res, 'chuhuotongji',self.ms)