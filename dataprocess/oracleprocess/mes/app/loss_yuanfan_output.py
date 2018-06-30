from dataprocess.oracleprocess.mes.base import Base
import datetime
class LossYuanfanOutput(object):
    def __inint__(self):
        super(LossYuanfanOutput,self).__init__()
    def __call__(self,conns):
        base=Base()
        mes=conns['mes']
        offline=conns['offline']
        with open(base.path1+'sqls/原返损耗产出.sql','r') as f:
            sql=f.read()
        #offline.dopost("truncate table loss_yuanfan_output")
        #for d in range(1,27):
        yesterday = datetime.datetime.now() - datetime.timedelta(days=1)
        #yesterday=datetime.datetime(2018,6,d)
        date = datetime.datetime.strftime(yesterday,'%Y/%m/%d')
        res = mes.doget(sql.replace('thistime', date))
        res['業務日期']=date
        base.batchwri(res, 'loss_yuanfan_output', offline)
