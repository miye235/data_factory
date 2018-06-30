# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
class PastCost(object):
    def __init__(self):
        super(PastCost, self).__init__()
    def __call__(self,conns):
        sql_chanchu = '''
select sum(outqty) as rcc from 

(select *,DATE_FORMAT(date_sub(UPDATETIME,interval 7 hour),'%Y-%m-%d') as rq from offline.sunhao where 
DATE_FORMAT(UPDATETIME, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT('${startime}', '%Y-%m-%d 07：00：00') and DATE_FORMAT('${endtime}','%Y-%m-%d 07：00：00') 
  and   MATERIALNO LIKE '_thiscode%'
  AND WO NOT LIKE 'KP1%'
AND OPERATION IN ('PSA','TAC-PVA','PVA','TAC','AGING')
  AND EQUIPMENT IS NOT NULL
   AND WOTYPE='量产'
  AND (WO like '___M%' OR WO like '___P%' OR WO like '___T%' OR WO like '___E%')
  ) s'''
        sql_touru='''select sum(MLOTCONSUMEQTY) as rtr from 

(select *,DATE_FORMAT(date_sub(UPDATETIME,interval 7 hour),'%Y-%m-%d') as rq from offline.sunhao where 
DATE_FORMAT(UPDATETIME, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT('${startime}', '%Y-%m-%d 07：00：00') and DATE_FORMAT('${endtime}','%Y-%m-%d 07：00：00') 
AND OPERATION IN ('PSA','TAC-PVA','PVA','TAC','AGING')
 AND MATERIALNO LIKE '_thiscode%'
AND WOTYPE='量产'
 AND (WO like '___M%' OR WO like '___P%' OR WO like '___T%' or WO like '___E%')
 ) s'''
        sql_yuanfan_chanchu='''select SUM(數量) as qty from loss_yuanfan_output 
where  DATE_FORMAT(更新時間, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT('${startime}', '%Y-%m-%d 07:00:00') and DATE_FORMAT('${endtime}','%Y-%m-%d 07:00:00') 
 AND (工單 like '___M%' OR 工單 like '___P%' OR 工單 like '___T%')'''
        sql_yuanfan_touru='''
        select SUM(數量) as qty from loss_yuanfan_input
where  DATE_FORMAT(查询日期, '%Y-%m-%d') between DATE_FORMAT('${startime}', '%Y-%m-%d') and DATE_FORMAT('${endtime}','%Y-%m-%d') 
AND (工單 like '___M%' OR 工單 like '___P%' OR 工單 like '___T%')'''
        code_dict={'PVA':'0103','保护膜':'0104','上T':'0102','PET':'011','下T':'0107','离型膜':'0105'}
        b=Base()
        self.ms =conns['offline']
        for day in b.datelist('20180611','20180625'):
            print(day)
            for k,v in code_dict.items():
                chanchu15=self.ms.doget(sql_chanchu.replace('thiscode',v).replace('${endtime}',day).replace('${startime}',b.getYesterday(day,15)))['rcc'][0]
                touru15=self.ms.doget(sql_touru.replace('thiscode',v).replace('${endtime}',day).replace('${startime}',b.getYesterday(day,15)))['rtr'][0]
                chanchu30 = self.ms.doget(
                    sql_chanchu.replace('thiscode', v).replace('${endtime}', day).replace('${startime}',
                                                                                          b.getYesterday(day, 30)))[
                    'rcc'][0]
                touru30 = self.ms.doget(
                    sql_touru.replace('thiscode', v).replace('${endtime}', day).replace('${startime}',
                                                                                        b.getYesterday(day, 30)))[
                    'rtr'][0]

                if touru15==None or touru15=='null' or touru30==None or touru30=='null':
                    res=pd.DataFrame([[b.getYesterday(day),0,0,k]],columns=['riqi','costrate15','costrate30','type'])
                else:
                    if chanchu15 == None or chanchu15 == 'null':
                        chanchu15 = 0
                    if chanchu30 == None or chanchu30 == 'null':
                        chanchu30 = 0
                    res=pd.DataFrame([[b.getYesterday(day),1-float(chanchu15)/float(touru15),1-float(chanchu30)/float(touru30),k]],columns=['riqi','costrate15','costrate30','type'])

                b.batchwri(res, 'pastcost', self.ms)
            chanchu_yuanfan15=self.ms.doget(sql_yuanfan_chanchu.replace('${endtime}',day).replace('${startime}',b.getYesterday(day,15)))['qty'][0]
            touru_yuanfan15=self.ms.doget(sql_yuanfan_touru.replace('${endtime}',day).replace('${startime}',b.getYesterday(day,15)))['qty'][0]
            chanchu_yuanfan30=self.ms.doget(sql_yuanfan_chanchu.replace('${endtime}',day).replace('${startime}',b.getYesterday(day,30)))['qty'][0]
            touru_yuanfan30=self.ms.doget(sql_yuanfan_touru.replace('${endtime}',day).replace('${startime}',b.getYesterday(day,30)))['qty'][0]

            if touru_yuanfan15==None or touru_yuanfan15=='null' or touru_yuanfan30 == None or touru_yuanfan30 == 'null':
                res = pd.DataFrame([[b.getYesterday(day),0,0, '原反']],
                                   columns=['riqi', 'costrate15', 'costrate30', 'type'])
            else:
                if chanchu_yuanfan30==None or chanchu_yuanfan30=='null':
                    chanchu_yuanfan30=0
                if chanchu_yuanfan15 == None or chanchu_yuanfan15 == 'null':
                    chanchu_yuanfan15 = 0
                res = pd.DataFrame([[b.getYesterday(day), 1 - float(chanchu_yuanfan15) / float(touru_yuanfan15), 1 - float(chanchu_yuanfan30) / float(touru_yuanfan30),'原反']],
                   columns=['riqi', 'costrate15', 'costrate30', 'type'])
            b.batchwri(res, 'pastcost', self.ms)
base = Base()
erp = base.conn('erp')
offline = base.conn('offline')
wms = base.conn('wms')
mes = base.conn('mes')
conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
zc=PastCost()
zc(conns)
offline.close()
erp.close()
wms.close()
mes.close()
