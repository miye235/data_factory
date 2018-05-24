from common.DbCommon import mysql2pd,oracle2pd
import pandas as pd
from time import *
class HeZhang(object):
    def __init__(self):
        super(HeZhang, self).__init__()

    def getwms(self,type,t,s,p):
        with open('../sqls/erp核账/'+type+'.sql') as f:
            sql=f.read().replace("料号（ITEM_CODE）",t).replace("仓别（SUBINVENTORY_CODE）", s)
            if None==p:
                sql = sql.replace("like '%标签id（PALLET_NO）%'","is null")
            else:
                sql = sql.replace("标签id（PALLET_NO）", p)

        res=self.wms.doget(sql).drop_duplicates().dropna()
        if res.empty:
            return 'null'
        else:
            return res.values[0][0]
    def geterp(self,type,t,s,p):
        with open('../sqls/erp核账/'+type+'.sql') as f:
            sql=f.read().replace("料号（ITEM_CODE）",t).replace("仓别（SUBINVENTORY_CODE）",s).replace("标签id（PALLET_NO）",p)
        res = self.erp.doget(sql).drop_duplicates().dropna()
        if res.empty:
            return 'null'
        else:
            return res.values[0][0]

    def __call__(self):
        self.erp=oracle2pd('10.232.1.101','1521','KSERP','BDATA','BDATA')
        self.wms = oracle2pd('10.232.1.200', '1521', 'WMSDB', 'BDATA', 'BDATA')
        self.ms=mysql2pd('123.59.214.229','33333','offline','root','Rtsecret')
        with open('../sqls/erp核账/erp核账.sql','r') as f:
            sql=f.read()
        res = self.wms.doget(sql)
        result=[]
        for t,s in res[['ITEM_CODE','SUBINVENTORY_CODE']].drop_duplicates().dropna().values:
            if t!=None and s!=None:
                for p in res[res['ITEM_CODE'].str.contains(t)&res['SUBINVENTORY_CODE'].str.contains(s)]['PALLET_NO'].drop_duplicates().dropna().values:
                    listno=self.getwms('差异单据号',t,s,p)
                    user=self.getwms('操作人员',t,s,p)
                    erpqty = self.geterp('erp库存量', t, s, p)
                    kazhang = self.getwms('卡账', t, s, p)
                    wsp = self.getwms('未上抛', t, s, p)
                    if erpqty=='null':erpqty =0
                    if wsp=='null':wsp= 0
                    if kazhang=='null':kazhang=0
                    reason='null'
                    q = kazhang + wsp
                    chayi =float(q)- float(erpqty)
                    if wsp!=0:
                        if erpqty!=kazhang:
                            reason='卡账、未上抛'
                        else:
                            reason='未上抛'
                        result.append(
                            [s, t, p,q, erpqty, chayi, strftime("%Y-%m-%d %H:%M:%S", gmtime()), reason, listno,
                             user])
                        print('one')
                    else:
                        if erpqty!=kazhang:
                            reason='卡账'
                            result.append([s,t,p,q,erpqty,chayi,strftime("%Y-%m-%d %H:%M:%S", gmtime()),reason,listno,user])
                            print('one')
        result=pd.DataFrame(result,columns=['仓别','料号','标签ID','WMS库存量','ERP库存量','差异量','差异时间','差异原因','差异单据号','操作人员'])
        print(result)
        # self.ms.dopost("truncate table Hzgn_wms_erp")
        self.ms.write2mysql(result,'Hzgn_wms_erp')
m=HeZhang()
m()