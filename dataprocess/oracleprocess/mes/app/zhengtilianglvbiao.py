from dataprocess.oracleprocess.mes.base import Base

class OverallGoodRatio(object):
    def __init__(self):
        super(OverallGoodRatio, self).__init__()

    def __call__(self, conns):
        base = Base()
        mes = conns['mes']
        offline =conns['offline']
        with open(base.path1+'sqls/良率/整体良率.sql','r') as f:
            sql=f.read()
        res = mes.doget(sql)
        offline.dopost("truncate table OverallGoodRatio")
        base.batchwri(res, 'OverallGoodRatio', offline)



