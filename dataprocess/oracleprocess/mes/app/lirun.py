# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

import datetime,os

class LiRun(object):
    def __init__(self):
        super(LiRun, self).__init__()

    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =conns['erp']
        self.ms=conns['offline']
        now = datetime.datetime.now()
        month = (now.month - 1)%12
        # for month in range(7):
        year = now.year
        if month==0:
            month=12
            year-=1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm=str(this_quarter_start)[:7]
        with open(b.path1+'sqls/利润表.sql','r') as f:
            sql1=f.read().replace('thismonth',str(lastm))
        res1 = self.erp.doget(sql1)
        res1.columns=['营业收入','减_营业成本','税金及附加','销售费用','管理费用','财务费用','资产减值损失','投资收益','加_营业外收入','减_营业外支出','减_所得税费用']
        res1['upmonth']=lastm
        self.ms.dopost("delete from lirun_new where upmonth='"+lastm+"'")
        b.batchwri(res1,'lirun_new',self.ms)
        del res1,sql1