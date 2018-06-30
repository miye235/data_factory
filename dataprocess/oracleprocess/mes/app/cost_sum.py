# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
import datetime

class CostSum(object):
    def __init__(self):
        super(CostSum,self).__init__()
    def __call__(self, conns):
        base = Base()
        offline = conns['offline']
        # offline.dopost("drop table CostSum")
        for dir in ['综合','量产','量产TD']:
            sqldcit={'PVA':open(base.path1+'sqls/损耗分析晨会/'+dir+'/pva.sql','r').read(),'PET':open(base.path1+'sqls/损耗分析晨会/'+dir+'/pet.sql','r').read(),\
                     '保护膜':open(base.path1+'sqls/损耗分析晨会/'+dir+'/protectshell.sql','r').read(),'上TAC':open(base.path1+'sqls/损耗分析晨会/'+dir+'/tac_on.sql','r').read(),\
                    '下TAC':open(base.path1+'sqls/损耗分析晨会/'+dir+'/tac_under.sql','r').read()}
            for day in base.datelist('20180601','20180628')[::-1]:
                fin = []
                offline.dopost("delete from CostSum where rq='"+day+"' and item='"+dir+"'")
                for k,v in sqldcit.items():
                    oneday=offline.doget("select * from ("+v+") s where rq='"+day.replace('/','-')+"'")
                    if oneday.empty:
                        sunhao_money,touru_money=0,0
                    else:
                        sunhao_money=oneday['moneysh'][0]
                        touru_money=oneday['moneytr'][0]
                        if sunhao_money==None or sunhao_money=='null':
                            sunhao_money=0
                        if touru_money==None or touru_money=='null':
                            touru_money=0
                    mon=offline.doget("select sum(moneysh) sh,sum(moneytr) tr from ("+v+") s where rq>='"+day[:8].replace('/','-')+"01"+"' and rq<='"+day.replace('/','-')+"'")
                    sh_sum=mon['sh'][0]
                    tr_sum=mon['tr'][0]
                    fin.append([day,sunhao_money,touru_money,sh_sum,tr_sum,k])
                res=pd.DataFrame(fin,columns=['rq','moneysh','moneytr', 'moneysh_mon', 'moneytr_mon','type'])
                res['item']=dir
                # offline.dopost("truncate table CostSum")
                # print(res)
                base.batchwri(res, 'CostSum', offline)

base = Base()
erp = base.conn('erp')
offline = base.conn('offline')
wms = base.conn('wms')
mes = base.conn('mes')
conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
hz=CostSum()
hz(conns)
offline.close()
erp.close()
wms.close()
mes.close()