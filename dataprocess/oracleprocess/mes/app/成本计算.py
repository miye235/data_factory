from dataprocess.oracleprocess.mes.base import Base
import os

class ChengBen(object):
    def __init__(self):
        super(ChengBen, self).__init__()

    def batchwri(self,res,table):
        print(res.shape)
        total = res.shape[0]
        nowrow = 0
        while nowrow < total - 500:
            print(str(nowrow))
            self.ms.write2mysql(res[nowrow:nowrow + 500],table)
            nowrow += 500
        self.ms.write2mysql(res[nowrow:],table)
    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =b.conn('erp')
        self.ms=b.conn('offline')
        with open('../sqls/成本计算.sql','r') as f:
            sql1=f.read()
        res1 = self.erp.doget(sql1)
        res1.columns=['cpdm','wlbm','UOM','bibie','MSIZE','FROZEN_COST','CURRENT_COST','COMPONENT_QUANTITY']
        self.ms.dopost("truncate table chengbenjisuan")
        b.batchwri(res1,'chengbenjisuan',self.ms)
        del res1,sql1
    def __del__(self):
        self.erp.close()
        self.ms.close()