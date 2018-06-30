from dataprocess.oracleprocess.mes.base import Base
import datetime

class MainBussinessIncome(object):

    def __init__(self):
        super(MainBussinessIncome, self).__init__()


    def __call__(self,conns):
        self.base=Base()
        self.ms =conns['offline']
        self.ora=conns['erp']
        # for month in range(7):
        #     now = datetime.datetime.now()
        #     year = now.year
        #     if month == 0:
        #         month = 12
        #         year -= 1
        #     this_quarter_start = datetime.datetime(year, month, 1)
        #     lastm = str(this_quarter_start)[:7]
        #     with open(self.base.path1 + 'sqls/主营业务收入.sql', 'r') as f:
        #         sql = f.read().replace('thismonth', lastm)
        #     res = self.ora.doget(sql)
        #     res['日期'] = lastm
        #     self.base.batchwri(res, 'main_bussiness_income1', self.ms)
        now = datetime.datetime.now()
        year = now.year
        month = (now.month - 1)%12
        if month == 0:
            month = 12
            year -= 1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm = str(this_quarter_start)[:7]

        with open(self.base.path1+'sqls/主营业务收入.sql','r') as f:
            sql=f.read().replace('thismonth', lastm)
        res = self.ora.doget(sql)
        res['日期'] = lastm
        self.ms.dopost("delete from main_bussiness_income1 where 日期='" + lastm + "'")
        self.base.batchwri(res, 'main_bussiness_income1', self.ms)

