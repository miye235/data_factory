from dataprocess.oracleprocess.mes.base_test import Base
import pandas as pd
import datetime
class MoCost(object):
    def __init__(self):
        super(MoCost, self).__init__()
    def caltouru(self,df):
        return float(df['ITEM_COST'])*float(df['rtr'])
    def calchanchu(self,df):
        return float(df['ITEM_COST'])*float(df['rcc'])
    def __call__(self,conns):
        base = Base()
        ms = conns['offline']
        ms.dopost("truncate table mocost")
        for day in base.datelist('20180528', '20180531')[::-1]:
            res=[]
            day=day.replace('/','-')
            day30 = base.getYesterday(day, 30).replace('/', '-')
            day15 = base.getYesterday(day, 15).replace('/', '-')
            for item in ['PET损耗','PVA损耗','上T损耗','下T损耗','保护膜','离型膜损耗']:
                for type in ['量产','TD','RD']:
                    print(item+'-'+type+':')
                    with open('../sqls/各大膜损耗/'+item+'-'+type+'-'+'产出.sql','r') as f:
                        sql_chanchu=f.read()
                    with open('../sqls/各大膜损耗/'+item+'-'+type+'-'+'投入.sql','r') as f:
                        sql_touru=f.read()
                    sql_chanchu_mon=sql_chanchu.replace('${startime}',day[:8] +'01').replace('${endtime}', day)
                    sql_touru_mon=sql_touru.replace('${startime}',day[:8] +'01').replace('${endtime}', day)
                    sql_chanchu15 = sql_chanchu.replace('${startime}', day15).replace('${endtime}', day)
                    sql_touru15 = sql_touru.replace('${startime}', day15).replace('${endtime}', day)
                    sql_chanchu30 = sql_chanchu.replace('${startime}', day30).replace('${endtime}', day)
                    sql_touru30 = sql_touru.replace('${startime}', day30).replace('${endtime}', day)
                    touru_mon=ms.doget(sql_touru_mon)
                    chanchu_mon=ms.doget(sql_chanchu_mon)
                    touru15 = ms.doget(sql_touru15)
                    chanchu15 = ms.doget(sql_chanchu15)
                    touru30 = ms.doget(sql_touru30)
                    chanchu30 = ms.doget(sql_chanchu30)
                    mon=pd.merge(touru_mon,chanchu_mon,how='inner',on='rq')
                    m15=pd.merge(touru15,chanchu15,how='inner',on='rq')
                    m30=pd.merge(touru30,chanchu30,how='inner',on='rq')
                    if mon.empty or m15.empty or m30.empty:
                        pass
                    else:
                        print(mon)
                        tourucost_mon=sum(list(touru_mon.apply(lambda r:self.caltouru(r),axis=1)))
                        chanchusum_mon=sum(list(chanchu_mon.apply(lambda r:self.calchanchu(r),axis=1)))
                        sunhao_mon=tourucost_mon-chanchusum_mon
                        if item=='PVA损耗':
                            mishu_mon=1-sum(chanchu_mon['rcc'])/(5.88*sum(touru_mon['rtr']))
                        else:
                            mishu_mon=1-sum(chanchu_mon['rcc'])/sum(touru_mon['rtr'])
                        sun_money15=1-sum(chanchu15.apply(lambda r:self.calchanchu(r),axis=1))/sum(touru15.apply(lambda r:self.caltouru(r),axis=1))
                        sun_money30=1-sum(chanchu30.apply(lambda r:self.calchanchu(r),axis=1))/sum(touru30.apply(lambda r:self.caltouru(r),axis=1))
                        res.append([day,item,type,sunhao_mon,tourucost_mon,mishu_mon,sun_money15,sun_money30])
            res=pd.DataFrame(res,columns=['day','item','type','sunhao_mon','tourucost_mon','mishu_mon','sun_money15','sun_money30'])
            print(res)
            base.batchwri(res,'mocost',ms)

base = Base()
erp = base.conn('erp')
offline = base.conn('offline')
wms = base.conn('wms')
mes = base.conn('mes')
conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
t3s = MoCost()
t3s(conns)
offline.close()
erp.close()
wms.close()
mes.close()
