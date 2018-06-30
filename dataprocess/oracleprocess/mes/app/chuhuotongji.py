# -*- coding: UTF-8 -*-

from dataprocess.oracleprocess.mes.base import Base
import os,cx_Oracle
import pandas as pd
class ChuHuo(object):
    def __init__(self):
        super(ChuHuo, self).__init__()

    def Func(self,conn):
        cursor = self.conn.cursor()
        cursor.execute("begin apps.MO_GLOBAL.SET_POLICY_CONTEXT('S',81); end;")
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.conn = cx_Oracle.connect(
            str('BDATA') + '/' + str('BDATA') + '@' + str('10.232.1.101') + ':' + str('1521') + '/' + str('KSERP'))
        # self.ora =conns['erp']
        self.ms = conns['offline']
        cursor = self.conn.cursor()
        sql = open(b.path1+'sqls/出货统计.sql', 'r',encoding='utf8').read()
        try:
            self.Func(self.conn)
        except Exception:
            self.Func(self.conn)
            cursor.execute(sql)
            res =pd.DataFrame(cursor.fetchall())
            # with open('ap1.csv','r') as f:
            #     data=f.readlines()
            res.columns = ['出货性质','Size','Shipment_Date','销售面积','含税金额','Unit_Selling_Price','QTY','SUBINVENTORY','Item_Number','Item_Description','Customer_Name','F_R','单位面积','未税金额','含税单价']
            # res=pd.DataFrame([x.split('\t') for x in data],columns=columns)
            res['id']=0
            print(res)
            self.ms.dopost('truncate table CHTJ_AUTOLOAD')
            b.batchwri(res, 'CHTJ_AUTOLOAD',self.ms)
            cursor.close()
            self.conn.close()


# base = Base()
# # erp = base.conn('erp')
# offline = base.conn('offline')
# # wms = base.conn('wms')
# # mes = base.conn('mes')
# conns = {'offline': offline}
# zc=ChuHuo()
# zc(conns)
# offline.close()
# # erp.close()
# # wms.close()
# # mes.close()