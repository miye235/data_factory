# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class LiangPin(object):
    def __init__(self):
        super(LiangPin, self).__init__()
    def __call__(self,conns):
        base=Base()
        self.ora =conns['mes']
        sql = open(base.path1+'sqls/良品.sql', 'r').read()
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        res.columns = ['liangpin_qty','touru_qty','class','WEEK']
        self.ms.dopost('truncate table liangpin')
        base.batchwri(res, 'liangpin',self.ms)