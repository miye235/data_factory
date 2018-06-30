from dataprocess.oracleprocess.mes.base import Base
class Top3Shortage(object):
    def __init__(self):
        super(Top3Shortage,self).__init__()
    def __call__(self,conns):
        base=Base()
        mes=conns['mes']
        offline=conns['offline']
        with open(base.path1+'sqls/缺点top3.sql','r') as f:
            sql0=f.read()
        for day in base.datelist(base.getYesterday(base.gettoday()),base.gettoday()):
            date=day.replace('/','-')
            sql1=sql0.replace('${dateEditor1}',date)
            res=mes.doget(sql1)
            res['日期']=date
            offline.dopost("delete from top3_shortage where 日期='" + date + "'")
            base.batchwri(res,'top3_shortage_test',offline)

