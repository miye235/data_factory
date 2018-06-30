# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class YunFan(object):
    def __init__(self):
        super(YunFan, self).__init__()
    def getttype(self,df):
        if df['formno'][3] in ['T','M','P']:
            return '量产'
        elif df['formno'][3]=='D':
            return 'TD'
        else:
            res=self.ora.doget("SELECT value FROM MES.mes_attr_attr WHERE  ATTRIBUTENAME = 'WO_TYPE' AND OBJECT_SID='"+df['formno']+"'")
            v=res.values
            if len(v)==0:
                return 'null'
            elif v[0][0]=='MP':
                return '量产'
            else:
                return 'RD'
    def __call__(self,conns):
        b=Base()
        self.ora = conns['mes']
        self.ms = conns['offline']
        sql = open(b.path1+'sqls/原反投入.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['matno', 'lot', 'num', 'uptime', 'formno']
        res['wotype']=res.apply(lambda r: self.getttype(r), axis=1)
        self.ms.dopost('truncate table yuanfantouru')
        b.batchwri(res, 'yuanfantouru',self.ms)
# base=Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=YunFan()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()