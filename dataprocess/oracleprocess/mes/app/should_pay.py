# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import cx_Oracle,os
import pandas as pd
class ShouldPay(object):
    def __init__(self):
        super(ShouldPay, self).__init__()
    def Func(self,conn):
        cursor = self.conn.cursor()
        cursor.execute("begin apps.MO_GLOBAL.SET_POLICY_CONTEXT('S',81); end;")
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b = Base()
        self.conn = cx_Oracle.connect(
            str('BDATA') + '/' + str('BDATA') + '@' + str('10.232.1.101') + ':' + str('1521') + '/' + str('KSERP'))
        self.ms = conns['offline']
        # self.ms.dopost("drop table should_pay_mon")
        cursor = self.conn.cursor()
        day=b.getYesterday(b.gettoday()[:8]+'01')
        sql = open(b.path1 + 'sqls/应付账款.sql', 'r', encoding='utf8').read().replace('thisday',day)
        try:
            self.Func(self.conn)
        except Exception:
            self.Func(self.conn)
            cursor.execute(sql)
            res = pd.DataFrame(cursor.fetchall())
            res.columns = ['公司名称', '币种', '逾期情况', '逾期款']
            res['riqi'] =b.gettoday()[:7]
            self.ms.dopost("delete from should_pay_mon where riqi='"+b.gettoday()[:7]+"'")
            b.batchwri(res, 'should_pay_mon', self.ms)
            cursor.close()
            self.conn.close()

# base = Base()
# # erp = base.conn('erp')
# offline = base.conn('offline')
# # wms = base.conn('wms')
# # mes = base.conn('mes')
# conns = {'offline': offline}
# zc = ShouldPay()
# zc(conns)
# offline.close()
# # erp.close()
# # wms.close()
# # mes.close()()