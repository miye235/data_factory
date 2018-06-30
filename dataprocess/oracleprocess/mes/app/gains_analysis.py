from dataprocess.oracleprocess.mes.base import Base
import datetime,os
class GainsAnalysis(object):
    def __init__(self):
        super(GainsAnalysis,self).__init__()
    def trandate(self,df):
        return df['日期'][:4]+'-'+df['日期'][4:6]+'-00'
    def __call__(self,conns):
        self.base = Base()
        self.ms = conns['offline']
        self.ora = conns['erp']
        # for month in range(7):
        now = datetime.datetime.now()
        year = now.year
        month = (now.month-1)%12
        if month == 0:
            month = 12
            year -= 1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm = str(this_quarter_start)[:7]
        with open(self.base.path1 + 'sqls/损益分析.sql', 'r') as f:
            sql = f.read().replace('thismonth', lastm)
        res = self.ora.doget(sql)
        res['日期'] = lastm
        self.ms.dopost("delete from " + 'gains_analysis' + " where 日期='" + lastm + "'")
        self.base.batchwri(res, 'gains_analysis', self.ms)


