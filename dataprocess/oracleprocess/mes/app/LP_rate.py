# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import datetime
def getYesterday():
    today=datetime.date.today()
    oneday=datetime.timedelta(days=1)
    yesterday=today-oneday
    return yesterday

class LPrate(object):

    def __init__(self):
        super(LPrate, self).__init__()

    def __call__(self,conns):
        b=Base()
        today = datetime.date.today()
        flag = 1
        oneday = str(today - datetime.timedelta(days=flag))
        self.ora =conns['mes']
        sqlz = open(b.path1+'sqls/直通率/LP_rate.sql', 'r', encoding='utf-8').read()
        sql = sqlz+"and week <= '" +oneday + "' and week like '%" + oneday[:7] + "%' group by substr(week,0,7),typ order by substr(week,0,7)"
        self.ms =conns['offline']
        res = self.ora.doget(sql)
        res['dat'] = oneday
        # print(res)
        res.columns = ['AMT_RATE', 'TYPE', 'dat']
        self.ms.dopost("delete from LPrate where dat='"+oneday+"'")
        self.ms.write2mysql(res, 'LPrate')