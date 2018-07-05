from dataprocess.oracleprocess.mes.base import Base
import datetime

class LossYuanfanInput(object):

    def __init__(self):
        super(LossYuanfanInput, self).__init__()


    def __call__(self,conns):
        self.base=Base()
        self.ms =conns['offline']
        self.ora=conns['mes']

        with open(self.base.path1+'sqls/原返损耗投入.sql','r') as f:
            sql=f.read()
        # self.ms.dopost('truncate table loss_yuanfan_input')
        # for day in range(1,3):
        #     today = datetime.datetime(2018,7,day)
        #     todaystr = datetime.datetime.strftime(today, '%Y/%m/%d')
        #     sql0 = sql.replace('thisdate', todaystr)
        #     res = self.ora.doget(sql0)
        #     res['業務日期'] = todaystr
        #     self.ms.dopost("delete from loss_yuanfan_input where 業務日期='"+todaystr+"'")
        #     self.base.batchwri(res, 'loss_yuanfan_input', self.ms)

        yesterday = datetime.datetime.now() - datetime.timedelta(days=1)

        #yesterday=datetime.datetime(2018,6,5)
        yesterdaystr = datetime.datetime.strftime(yesterday, '%Y/%m/%d')
        sql0 = sql.replace('thisdate', yesterdaystr)
        res = self.ora.doget(sql0)
        res['業務日期']=yesterdaystr
        self.ms.dopost("delete from loss_yuanfan_input where 業務日期='" + yesterdaystr + "'")
        self.base.batchwri(res, 'loss_yuanfan_input', self.ms)

if __name__ == "__main__":
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = LossYuanfanInput()
    t3s(conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()
