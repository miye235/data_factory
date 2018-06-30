# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import os,datetime

class FuZhai(object):
    def __init__(self):
        super(FuZhai, self).__init__()


    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =conns['erp']
        self.ms=conns['offline']
        now = datetime.datetime.now()
        # for month in range(6):
        year=now.year
        month = (now.month - 1)%12
        if month==0:
            month=12
            year-=1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm=str(this_quarter_start)[:7]
        with open(b.path1+'sqls/资产负债表.sql','r') as f:
            sql1=f.read().replace('thismonth',str(lastm))
        res1 = self.erp.doget(sql1)
        res1.columns=['货币资金','应收票据','应收账款','预付款项','应收利息','其他应收账款','存货','原材料','库存商品_产成品','库存商品_半成品','其他流动资产','可供出售金融资产','长期股权投资','固定资产原值','减_累计折旧','在建工程','无形资产','长期待摊费用','递延所得税资产','短期借款','应付票据','应付账款','预收账款','应付职工薪酬','应交税费','其中_应交税金','应付利息','其他应付款','其他流动负债','长期借款','递延所得税负债','实收资本','资本公积','专项储备','盈余公积','其中_法定公积金','未分配利润']
        res1['upmonth']=lastm
        self.ms.dopost("delete from zichanfz where upmonth='"+lastm+"'")
        b.batchwri(res1,'zichanfz',self.ms)
        del res1,sql1