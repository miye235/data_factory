from dataprocess.oracleprocess.mes.base import Base
class SoldArea(object):
    def __init__(self):
        super(SoldArea,self).__init__()
    def __call__(self, conns):
        base=Base()
        erp=conns['erp']
        offline=conns['offline']
        with open(base.path1+'sqls/销售面积.sql','r') as f:
            sql=f.read()
        res=erp.doget(sql)
        offline.dopost("truncate table sold_area")
        base.batchwri(res,'sold_area',offline)

