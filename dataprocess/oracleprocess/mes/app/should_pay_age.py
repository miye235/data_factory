from dataprocess.oracleprocess.mes.base import Base
class ShouldPayAge(object):
    def __init__(self):
        super(ShouldPayAge,self).__init__()
    def __call__(self, conns):
        base=Base()
        erp=conns['erp']
        offline=conns['offline']
        with open(base.path1+'sqls/应付账款账龄.sql','r') as f:
            sql=f.read()
        res=erp.doget(sql)
        offline.dopost("truncate table should_pay_age")
        base.batchwri(res,'should_pay_age',offline)
