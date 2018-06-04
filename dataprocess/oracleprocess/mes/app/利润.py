from dataprocess.oracleprocess.mes.base import Base

import datetime,os

class LiRun(object):
    def __init__(self):
        super(LiRun, self).__init__()

    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp = b.conn('erp')
        self.ms=b.conn('offline')
        now = datetime.datetime.now()
        year=now.year
        month = (now.month - 1)%12
        if month==0:
            month=12
            year-=1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm=str(this_quarter_start)[:7]
        with open('sqls/利润表.sql','r') as f:
            sql1=f.read().replace('thismonth',str(lastm))
        res1 = self.erp.doget(sql1)
        res1.columns=['yingyesr','minu_yycb1','minu_yycb2','minu_yycb3','tax_add1','tax_add2','tax_add3','tax_add4','sale_fee1','sale_fee2','sale_fee3','sale_fee4','manage_fee1','manage_fee2','manage_fee3','manage_fee4','manage_fee5','manage_fee6','manage_fee7','manage_fee8','manage_fee9','manage_fee10','fin_fee1','fin_fee2','fin_fee3','fin_fee4','fin_fee5','minu_cost','bon_touzi','add_yywsr1','add_yywsr2','add_yywsr3','minu_yywzc1','minu_yywzc2','minu_yywzc3','minu_tax_fee']
        res1['upmonth']=lastm
        self.ms.dopost("delete from lirun where upmonth='"+lastm+"'")
        b.batchwri(res1,'lirun',self.ms)
        del res1,sql1
        self.erp.close()
        self.ms.close()