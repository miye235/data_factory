# -*- coding: UTF-8 -*-

from dataprocess.oracleprocess.mes.base import Base
import os
class PenMo(object):
    def __init__(self):
        super(PenMo, self).__init__()
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        base=Base()
        self.ora =conns['mes']
        self.ms = conns['offline']
        day = base.getYesterday()
        day=day.replace('/','-')+' 00:00:00'
        # today = base.gettoday()
        with open(base.path1 + 'sqls/PSA喷墨率.sql', 'r') as f:
            sql = f.read().replace('someday', day)
        res = self.ora.doget(sql)
        res.columns = ['日期','DATA05','LOT']
        self.ms.dopost("delete from psa_penmo where 日期>str_to_date('" + day + "','%Y-%m-%d %H:%i:%s')")
        base.batchwri(res, 'psa_penmo', self.ms)


        with open(base.path1 + 'sqls/检反喷墨率.sql', 'r') as f:
            sql = f.read().replace('someday', day)
        res = self.ora.doget(sql)
        res.columns = ['日期','DATA05','LOT']
        self.ms.dopost("delete from jianfan_penmo where 日期>str_to_date('" + day + "','%Y-%m-%d %H:%i:%s')")
        base.batchwri(res, 'jianfan_penmo', self.ms)