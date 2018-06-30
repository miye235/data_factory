# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import os,datetime
import pandas as pd
class PvaChan(object):

    def __init__(self):
        super(PvaChan, self).__init__()
    def trandate(self,df):
        if int(df['日期'][11:13])>6:
            return df['日期'][:11]
        else:
            y=self.base.getYesterday(day=df['日期'][:11])
            return y[:4]+'-'+y[5:7]+'-'+y[8:10]
    def __call__(self,conns):
        self.base=Base()
        self.ms =conns['offline']
        self.ora=conns['mes']
        with open(self.base.path1+'sqls/pva产能.sql','r') as f:
            sql=f.read()
        res=self.ora.doget(sql)
        res['日期'] = res.apply(lambda r: self.trandate(r), axis=1)
        res.columns=['lot','device','wo','qty','riqi','jitai','OLDOPERATION']

        with open(self.base.path1 + 'sqls/psa产能.sql', 'r') as f:
            sql = f.read()
        res3 = self.ora.doget(sql)
        res3['日期'] = res3.apply(lambda r: self.trandate(r), axis=1)
        res3.columns = ['lot', 'device', 'wo', 'qty', 'riqi', 'jitai', 'OLDOPERATION']

        res2 = []
        for i in self.base.datelist('20180101', self.base.gettoday().replace('/','')):
            i = i.replace('/', '-')
            for t in ['PVA','TAC-PVA','PSA','換貼保護膜']:
                res2.append([i, 0,t])
        res2 = pd.DataFrame(res2, columns=['riqi', 'qty','OLDOPERATION'])
        self.ms.dopost("truncate table pvachanneng")
        self.base.batchwri(res2, 'pvachanneng', self.ms)
        self.base.batchwri(res,'pvachanneng',self.ms)
        self.base.batchwri(res3,'pvachanneng',self.ms)

# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=PvaChan()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()