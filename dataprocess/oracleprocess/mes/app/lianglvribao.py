# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base

class LLRB(object):
    def __init__(self):
        super(LLRB, self).__init__()
    def __call__(self,conns):
        b=Base()
        self.ora =conns['mes']
        sql = open(b.path1+'sqls/良率/良率日报.sql', 'r').read()
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        res.columns = ['qd_wo','hd_wo','materialno','qd_lot','hd_lot','pro_state','thisdate','facno','class','thistype','touru_qty','liangpin_qty','dianque_qty','dianque_item','sort','speed']
        self.ms.dopost('truncate table lianglvribao')
        b.batchwri(res, 'lianglvribao',self.ms)
