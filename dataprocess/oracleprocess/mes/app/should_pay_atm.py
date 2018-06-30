# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import os,datetime
class ShouldPayAtm(object):

    def __init__(self):
        super(ShouldPayAtm, self).__init__()
    def trandate(self,df):
        return df['日期'][:4]+'-'+df['日期'][4:6]+'-00'
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        base=Base()

        self.ms =conns['offline']
        self.ora=conns['erp']
        now = datetime.datetime.now()
        # for month in range(7):
        year = now.year
        month = (now.month - 1)%12
        if month == 0:
            month = 12
            year -= 1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm = str(this_quarter_start)[:7]
        with open(base.path1+'sqls/应付暂估款.sql','r') as f:
            sql=f.read().replace('thismonth',lastm)
        res=self.ora.doget(sql)
        res['日期']=lastm
        self.ms.dopost("delete from ShouldPayAtm where 日期='"+lastm+"'")
        print(res)
        base.batchwri(res,'ShouldPayAtm',self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# zc=ShouldPayAtm()
# zc(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()