from dataprocess.oracleprocess.mes.base_test import Base
class AssetsFixed(object):
    def __init__(self):
        super(AssetsFixed,self).__init__()
    def __call__(self,conns):
        base=Base()
        erp=conns['erp']
        offline=conns['offline']
        with open(base.path1+'sqls/固定资产.sql','r') as f:
            sql=f.read()
        now=base.gettoday().replace('/','-')[:7]
        res=erp.doget(sql)
        res['日期']=now
        offline.dopost("delete from assets_fixed where 日期='"+now+"'")
        base.batchwri(res,'assets_fixed',offline)
#
# base = Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# af=AssetsFixed()
# af(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()
