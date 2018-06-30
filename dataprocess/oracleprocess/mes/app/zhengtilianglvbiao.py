from dataprocess.oracleprocess.mes.base import Base
import datetime
class OverallGoodRatio(object):
    def __init__(self):
        super(OverallGoodRatio, self).__init__()

    def trandate(self,df):
        this_time=df['CHECKOUTTIME']
        base_time = '2017/12/29 08:00:00'
        base_time = datetime.datetime(int(base_time[:4]), int(base_time[5:7]), int(base_time[8:10]),
                                      int(base_time[11:13]), int(base_time[14:16]), int(base_time[17:19]))
        this_time = datetime.datetime(int(this_time[:4]), int(this_time[5:7]), int(this_time[8:10]),
                                      int(this_time[11:13]), int(this_time[14:16]), int(this_time[17:19]))
        return '2018年第'+str((this_time - base_time).days // 7 + 1)+'周'
    def __call__(self, conns):
        base = Base()
        mes = conns['mes']
        offline =conns['offline']
        with open(base.path1+'sqls/良率/整体良率.sql','r') as f:
            sql=f.read()
        res = mes.doget(sql)
        res['week']=res.apply(lambda r:self.trandate(r),axis=1)
        offline.dopost("truncate table OverallGoodRatio")
        base.batchwri(res, 'OverallGoodRatio', offline)



