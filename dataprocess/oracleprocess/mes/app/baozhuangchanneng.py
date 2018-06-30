# -*- coding: UTF-8 -*-

from dataprocess.oracleprocess.mes.base import Base

class PkgCal(object):
    def __init__(self):
        super(PkgCal, self).__init__()
    def __call__(self,conns):
        base=Base()
        self.ora =conns['mes']
        self.ms = conns['offline']
        # self.ms.dopost('truncate table pkg_cap_calcu')
        # for day in base.datelist('20180101','20180611'):
        day=base.getYesterday()
        today=base.gettoday()
        with open(base.path1+'sqls/包装产能计算.sql', 'r') as f:
            sql=f.read().replace('today',today).replace('yesterday',day)
        res = self.ora.doget(sql)
        res.columns = ['BAN','LEI','NUM']
        res['riqi']=today
        self.ms.dopost("delete from pkg_cap_calcu where riqi=str_to_date('"+today+"','%Y/%m/%d')")
        base.batchwri(res, 'pkg_cap_calcu',self.ms)