# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class DianQueSum(object):
    def __init__(self):
        super(DianQueSum, self).__init__()
    def calrate(self,df):
        self.sumnow+=float(df['qty'])
        return self.sumnow/self.total
    def __call__(self,conns):
        sql = '''select DESCR,sum(a.dianque) qty from (
SELECT DISTINCT DESCR,dianque,CHECKOUTTIME FROM OverallGoodRatio
WHERE STR_TO_DATE(REPLACE(CHECKOUTTIME ,'/','-'),'%Y-%m-%d %H:%i:%s')
BETWEEN STR_TO_DATE(CURDATE(),'%Y-%m-%d 07:00:00')
AND STR_TO_DATE(date_add(CURDATE(), interval 1 day),'%Y-%m-%d 07:00:00')
) a
GROUP BY DESCR'''
        b=Base()
        self.ms =conns['offline']
        res = self.ms.doget(sql).dropna()
        self.sumnow=0.0
        self.total=sum([float(x[1]) for x in res.values])
        self.ms.dopost('truncate table dianque_sumrate')
        if self.total!=0:
            res['rate']=res.apply(lambda r:self.calrate(r),axis=1)
            #print(res)
            b.batchwri(res, 'dianque_sumrate',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=DianQueSum()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()

