from dataprocess.oracleprocess.mes.base_test import Base
class CostYuanfanWuliao(object):
    def __init__(self):
        super(CostYuanfanWuliao, self).__init__()
    def __call__(self, conns):
        base = Base()
        offline = conns['offline']
        erp = conns['erp']
        with open(base.path1+'sqls/原返组成物料信息.sql','r') as f:
            sql=f.read()
        res = erp.doget(sql)
        offline.dopost("truncate table cost_yuanfan_wuliao")
        base.batchwri(res, 'cost_yuanfan_wuliao', offline)


if __name__ == '__main__':
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = CostYuanfanWuliao()
    t3s(conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()
