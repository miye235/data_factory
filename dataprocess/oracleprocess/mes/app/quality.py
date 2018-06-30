# -*- coding: UTF-8 -*-

from dataprocess.oracleprocess.mes.base import Base
import os
class Qlt(object):
    def __init__(self):
        super(Qlt, self).__init__()
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        self.base=Base()
        self.ora =conns['mes']
        self.ms = conns['offline']
        day = self.base.getYesterday()
        day = day+' 00:00:00'
        # today = base.gettoday()
        # day='2018/01/01 00:00:00'
        with open(self.base.path1 + 'sqls/品质.sql', 'r') as f:
            sql = f.read().replace('someday',day)
        res = self.ora.doget(sql)
        res.columns = ['LOT', 'OPERATION', 'VISUALRESULT','S','dat']
        # res['dat']=res.apply(lambda r:self.trandate(r),axis=1)
        self.ms.dopost("delete from quality where dat>str_to_date('" + day.replace('/','-') + "','%Y-%m-%d %H:%i:%s')")
        self.base.batchwri(res, 'quality', self.ms)
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# hz=Qlt()
# hz(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()