# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class YFCH(object):
    def __init__(self):
        super(YFCH, self).__init__()
    def getttype(self,df):
        if df['wo'][3] in ['T','M','P']:
            return '量产'
        elif df['wo'][3]=='D':
            return 'TD'
        else:
            res=self.ora.doget("SELECT value FROM MES.mes_attr_attr WHERE  ATTRIBUTENAME = 'WO_TYPE' AND OBJECT_SID='"+df['wo']+"'")
            v=res.values
            if len(v)==0:
                return 'null'
            elif v[0][0]=='MP':
                return '量产'
            else:
                return 'RD'
    def __call__(self,conns):
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        sql = open(b.path1+'sqls/原反产出.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['lot','device','wo','quantity','updatetime','type']
        res['type'] = res.apply(lambda r: self.getttype(r), axis=1)
        self.ms.dopost('truncate table yuanfanchanchu')
        b.batchwri(res, 'yuanfanchanchu',self.ms)
# base=Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=YFCH()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()