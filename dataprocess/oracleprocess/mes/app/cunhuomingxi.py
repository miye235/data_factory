# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

import datetime,os
class CunHuo(object):
    def __init__(self):
        super(CunHuo, self).__init__()

    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =conns['erp']
        self.ms=conns['offline']
        #暂收存货
        with open(b.path1+'sqls/存货明细/存货明细-暂收存货SQL_new.sql','r') as f:
            sql1=f.read().replace('yestoday',str(b.getYesterday()))
        res1 = self.erp.doget(sql1)
        res1.columns=['JE_SOURCE_NAME','VENDOR_NAME','ITEM_NUMBER','ITEM_DESCRIPTION',\
                     'ACCOUNTING_DATE','CURRENCY_CODE','CURRENCY_CONVERSION_RATE',\
                     'ENTERED_AMOUNT','ACCOUNTED_AMOUNT','QUANTITY','RECEIPT_NUM','PO_NUMBER']

        self.ms.dopost("delete from zanshoucunhuo where str_to_date(date_format(ACCOUNTING_DATE,'%Y-%m-%d'),'%Y-%m-%d')=str_to_date(date_format(SUBDATE(SYSDATE(),interval 1 day),'%Y-%m-%d'),'%Y-%m-%d')")
        b.batchwri(res1,'zanshoucunhuo',self.ms)
        del res1,sql1

        #在制品
        with open(b.path1+'sqls/存货明细/存货明细-在制品进耗存SQL_NEW.sql','r') as f:
            sql2=f.read()
        res2 = self.erp.doget(sql2)
        res2.columns=['WIP_ENTITY_NAME','ITEM_CODE','STATUS_TYPE','DATE_CLOSED',\
'TOTALSUMMARY_SUM','OVERHEADSUMMARY_SUM','RESROUCESUMMARY_SUM','MATERIALSUMMARY_SUM',\
'COSTUPDATESUMMARY_SUM','COSTUPDATEOVERHEAD_SUM','COSTUPDATERESROUCE_SUM','COSTUPDATEMATERIAL_SUM',
'CURSCRAPSUMMARY_SUM','CURSCRAPOVERHEAD_SUM','CURSCRAPRESROUCE_SUM','CURSCRAPMATERIAL_SUM',\
'CURCOMPLETESUMMARY_SUM','CURCOMPLETEOVERHEAD_SUM','CURCOMPLETERESROUCE_SUM',\
'CURCOMPLETEMATERIAL_SUM','CURISSUESUMMARY_SUM','CURISSUEOVERHEAD_SUM','CURISSUERESROUCE_SUM',\
'CURISSUEMATERIAL_SUM','BEFSUMMARY_SUM','BEFOVERHEAD_SUM','BEFRESOURCE_SUM','BEFMATERIAL_SUM','WIPQTY_SUM']
        thism=str(datetime.date.today())[:-3]
        res2['upmonth']=thism
        self.ms.dopost("delete from zaizhipin where upmonth='"+thism+"'")
        b.batchwri(res2,'zaizhipin',self.ms)
        del res2,sql2

        # 进耗存
        with open(b.path1+'sqls/存货明细/存货明细-进耗存SQL_NEW.sql', 'r') as f:
            sql3 = f.read()
        res3 = self.erp.doget(sql3.replace('thismonth',thism))
        res3.columns = ['ITEM_NUMBER','ITEM_DESCRIPTION','TRANSACTION_DATE_FM','TRANSACTION_DATE_TO',\
'CATEGORY_NAME','BEG_STK','BEG_AMT','PO_STK_IN','PO_IN_AMT','WIP_STK_IN','WIP_IN_AMT','WIP_STK_OUT',\
'WIP_OUT_AMT','SO_STK_OUT','SO_OUT_AMT','DEPT_STK_OUT',\
'DEPT_OUT_AMT','OTHER_STK_OUT','OTHER_OUT_AMT','END_STK','END_AMT','END_UP','STANDARD_COST']
        self.ms.dopost("delete from jinhaocun where str_to_date(date_format(TRANSACTION_DATE_FM,'%Y-%m'),'%Y-%m')=str_to_date('"+thism+"','%Y-%m')")
        b.batchwri(res3, 'jinhaocun',self.ms)
        del sql3,res3