# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
import datetime


class MonCostRate(object):
    def __init__(self):
        super(MonCostRate, self).__init__()
    def __call__(self,conns):
        b=Base()
        sql = open(b.path1+'sqls/月损耗金额百分比.sql', 'r').read()
        self.ms =conns['offline']
        # day='2018/05/20'
        day = str(b.getYesterday())
        data = self.ms.doget(sql)
        data_up_day=data[(data['rq'].str.contains(day[:7]))&(data['rq']<=day)]
        pva=['(上TAC)表面处理膜一般TAC','补偿膜(下TAC)','保护膜','PVA']
        psa=['离型膜']
        sunhao=65*sum([float(x) for x in data_up_day[data_up_day['ml'].isin(pva)]['rsh'].dropna().values])+\
            2.6*sum([float(x) for x in data_up_day[data_up_day['ml'].isin(psa)]['rsh'].dropna().values])
        all=65*sum([float(x) for x in data_up_day[data_up_day['ml'].isin(pva)]['rtr'].dropna().values])+\
            2.6*sum([float(x) for x in data_up_day[data_up_day['ml'].isin(psa)]['rtr'].dropna().values])
        if all==0:
            rate=0
        else:
            rate=sunhao/all
        res=pd.DataFrame([[day,rate]],columns=['thisdate','rate'])
        self.ms.dopost("delete from month_cost_rate where str_to_date(thisdate,'%Y/%m/%d')=str_to_date('"+day+"','%Y/%m/%d')")
        b.batchwri(res, 'month_cost_rate',self.ms)
