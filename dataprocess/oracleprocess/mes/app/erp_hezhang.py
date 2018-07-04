# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
import datetime

class HeZhang(object):
    def __init__(self):
        super(HeZhang, self).__init__()

    def getwms(self,type,t,s,p):
        with open(self.base.path1+'sqls/erp核账/'+type+'.sql') as f:
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
        with open(self.base.path1+'sqls/erp核账/'+type+'.sql') as f:
            sql=f.read().replace("料号（ITEM_CODE）",t).replace("仓别（SUBINVENTORY_CODE）",s).replace("标签id（PALLET_NO）",p)
        res = self.erp.doget(sql).drop_duplicates().dropna()
        if res.empty:
            return 'null'
        else:
            return res.values[0][0]

    def __call__(self,conns):
        self.base=Base()
        self.erp=conns['erp']
        self.wms =conns['wms']
        self.ms=conns['offline']
        with open(self.base.path1+'sqls/erp核账/erp核账.sql','r') as f:
            sql=f.read()
        res = self.wms.doget(sql)
        result=[]
        for t,s in res[['ITEM_CODE','SUBINVENTORY_CODE']].drop_duplicates().dropna().values:
            if t!=None and s!=None:
                p=res[res['ITEM_CODE'].str.contains(t)&res['SUBINVENTORY_CODE'].str.contains(s)]['PALLET_NO'].drop_duplicates().dropna().values[0]
                erpqty = self.geterp('erp库存量', t, s, p)
                yishangpao = self.getwms('卡账', t, s, p)
                wsp = self.getwms('未上抛', t, s, p)
                if erpqty=='null':erpqty =0
                if wsp=='null':wsp= 0
                if yishangpao=='null':yishangpao=0
                reason='null'
                q = yishangpao + wsp
                chayi =float(q)- float(erpqty)
                if chayi!=0:
                    listno = self.geterp('差异单据号', t, s, p)
                    user = self.getwms('操作人员', t, s, p)
                    if self.geterp('差异时间',t,s,p)=='null' or self.geterp('差异时间',t,s,p)==None:
                        tim=None
                    else:
                        tim=pd.to_datetime(str(self.geterp('差异时间',t,s,p)),format="%Y-%m-%dT%H:%M:%S")
                        if wsp!=0:
                            if erpqty!=yishangpao:
                                reason='卡账、未上抛'
                            else:
                                reason='未上抛'
                            result.append(
                                [s, t, p,q, erpqty, chayi, tim, reason, listno,
                                 user])
                        elif erpqty<yishangpao:
                            reason='卡账'
                            result.append([s,t,p,q,erpqty,chayi,tim,reason,listno,user])
                        else:
                            reason = '其他'
                            result.append(
                                [s, t, p, q, erpqty, chayi, tim, reason, listno,
                                 user])
        result=pd.DataFrame(result,columns=['仓别','料号','标签ID','WMS库存量','ERP库存量','差异量','差异时间','差异原因','差异单据号','操作人员'])
        self.ms.dopost("truncate table Hzgn_wms_erp")
        self.base.batchwri(result,'Hzgn_wms_erp',self.ms)
