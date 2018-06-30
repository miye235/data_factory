# -*- coding: UTF-8 -*-

from dataprocess.oracleprocess.mes.base import Base
import os

class ChengBen(object):
    def __init__(self):
        super(ChengBen, self).__init__()

    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =conns['erp']
        self.ms=conns['offline']
        with open(b.path1+'sqls/成本计算.sql','r') as f:
            sql1=f.read()
        res1 = self.erp.doget(sql1)
        res1.columns=['cpdm','wlbm','UOM','bibie','MSIZE','FROZEN_COST','CURRENT_COST','COMPONENT_QUANTITY']
        self.ms.dopost("truncate table chengbenjisuan")
        b.batchwri(res1,'chengbenjisuan',self.ms)
        del res1,sql1