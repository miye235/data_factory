# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class LiangLv(object):
    def __init__(self):
        super(LiangLv, self).__init__()

    def __call__(self,conns):
        b=Base()
        self.ora=conns['mes']
        self.ms=conns['offline']
        with open(b.path1+'sqls/良率/良率统计分析.sql','r') as f:
            sql=f.read()
        res = self.ora.doget(sql)
        res.columns=['pva_lot','psa_trantime','psa_sub','pva_trantime','slt_lot','hd_lot','sub_lot',\
                     'cust_lot','checkout_time','device','hd_wo',\
                     'qd_wo','arr_qty','Agui','reason','descr','quantity','bancheng_lot']
        self.ms.dopost('truncate table lianglv')
        b.batchwri(res, 'lianglv',self.ms)