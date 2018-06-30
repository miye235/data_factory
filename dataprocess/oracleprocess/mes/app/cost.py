# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class Cost(object):
    def __init__(self):
        super(Cost, self).__init__()
    def getttype(self,df):
        if df['WO'][3] in ['T','M','P']:
            return '量产'
        elif df['WO'][3]=='D':
            return 'TD'
        else:
            res=self.ora.doget("SELECT value FROM MES.mes_attr_attr WHERE  ATTRIBUTENAME = 'WO_TYPE' AND OBJECT_SID='"+df['WO']+"'")
            v=res.values
            if len(v)==0:
                return 'null'
            elif v[0][0]=='MP':
                return '量产'
            else:
                return 'RD'
    def __call__(self,conns):
        base=Base()
        self.ora=conns['mes']
        self.ms=conns['offline']
        with open(base.path1+'sqls/损耗.sql','r') as f:
            sql=f.read()
        res = self.ora.doget(sql)
        res['wotype']=res.apply(lambda r: self.getttype(r), axis=1)
        self.ms.dopost('truncate table sunhao')
        base.batchwri(res,'sunhao',self.ms)
# base=Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=Cost()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
