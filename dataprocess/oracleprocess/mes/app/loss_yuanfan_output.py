from dataprocess.oracleprocess.mes.base import Base
class LossYuanfanOutput(object):
    def __inint__(self):
        super(LossYuanfanOutput,self).__init__()
    def __call__(self,conns):
        base=Base()
        mes=conns['mes']
        offline=conns['offline']
        with open(base.path1+'sqls/原返损耗产出.sql','r') as f:
            sql=f.read()
        offline.dopost("truncate table loss_yuanfan_output")
        for date in [base.gettoday(),base.getYesterday()]:
            res = mes.doget(sql.replace('thistime', date))
            res['業務日期']=date
            offline.dopost("delete from loss_yuanfan_output where 業務日期='"+date+"'")
            base.batchwri(res, 'loss_yuanfan_output', offline)
