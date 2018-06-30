# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class Vlm(object):
    def __init__(self):
        super(Vlm, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['mes']
        self.ms =conns['offline']
        sql = open(b.path1+'sqls/vlm_mwh.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['lot','device','wo','newquantity','transactiontime','resourcename','oldoperation']
        self.ms.dopost('truncate table vlm_mwh')
        b.batchwri(res, 'vlm_mwh',self.ms)