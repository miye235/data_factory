# -*- coding: UTF-8 -*-
import sys
sys.path.append('/home/openstack/data_offline/data_factory/')
from dataprocess.oracleprocess.mes.base import Base
import os,cx_Oracle
import pandas as pd
class CHTJZJ(object):
    def __init__(self):
        super(CHTJZJ, self).__init__()
    def Func(self,conn):
        cursor = self.conn.cursor()
        cursor.execute("begin apps.MO_GLOBAL.SET_POLICY_CONTEXT('S',81); end;")
    def caltype(self,df):
        type_sql="select DISTINCT QC_STATUS FROM WMS.A_TRANSACTION_HIST where ITEM_CODE='thiscode' and LIST_NO ='thisno' and TRANSACTION_TYPE = 'ERP'"
        code = df['ORDEREDITEM']
        if df['SALETYPE']=='出货':
            thisno=df['DELIVERYNO']
        elif ('折让' in df['SALETYPE'] or '销退' in df['SALETYPE']) and str(df['SOURCEID'])!='nan':
            self.cursor.execute("SELECT DELIVERY_NO FROM apps.YOM_SHIPPING_NOTICE_V WHERE ORDER_LINE_ID ='"+str(df['SOURCEID'])+"'")
            thisno = pd.DataFrame(self.cursor.fetchall())[0][0]
        else:
            return 'null'
        type_res=self.wms.doget(type_sql.replace('thiscode',code).replace('thisno',thisno)).drop_duplicates().dropna()
        if type_res.empty:
            return 'null'
        else:
            return type_res['QC_STATUS'][0]
    def __call__(self,conns):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.wms = conns['wms']
        self.ms = conns['offline']
        self.conn = cx_Oracle.connect(
            str('BDATA') + '/' + str('BDATA') + '@' + str('10.232.1.101') + ':' + str('1521') + '/' + str('KSERP'))
        # self.ora =conns['erp']

        try:
            self.Func(self.conn)
        except Exception:
            print('erp连接成功！')
        finally:
            self.Func(self.conn)
            # for day in b.datelist('20180629','20180705'):
            for day in [b.getYesterday(),b.gettoday()]:
                day = day.replace('/', '-')
                print(day)
                self.cursor = self.conn.cursor()
                # self.ms.dopost("truncate table CHTJZJ")
                # day=b.getYesterday().replace('/','-')
                with open(b.path1+'sqls/出货统计含折让.sql', 'r') as f:
                    sql = f.read().replace('thisday',day)
                self.cursor.execute(sql)
                res = pd.DataFrame(self.cursor.fetchall())
                self.ms.dopost("delete from CHTJZJ where SHIPMENTDATE='"+day+"'")
                if not res.empty:
                    res.columns=['SALETYPE','Size','SHIPMENTDATE','TRIPNO','SOURCEID','LINEID','SHIPQUANTITY','DELIVERYNO','SHIPAERA','ORDEREDITEM','NONTAXAMOUNT','TAXAMOUNT','LINE_TYPE','ORDER_NUMBER','UNITSELLPRICE','SUBINVENTORY','DESCRIPTION','CUSTOMERNAME','FRUD','UNITAERA','TAXPRICE']
                    res['class']=res.apply(lambda r:self.caltype(r),axis=1)
                    b.batchwri(res, 'CHTJZJ',self.ms)
                self.cursor.close()
            self.conn.close()
if __name__ == "__main__":
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    offline1 = base.conn('offline_test')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    conns1 = {'offline': offline1, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = CHTJZJ()
    t3s(conns)
    t3s(conns1)
    offline.close()
    erp.close()
    wms.close()
    mes.close()