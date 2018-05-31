from dataprocess.oracleprocess.mes.base import Base

class PkgCal(object):
    def __init__(self):
        super(PkgCal, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        base=Base()
        self.ora =base.conn('mes')
        self.ms = base.conn('offline')
        day=base.getYesterday()
        with open('../sqls/包装产能计算.sql', 'r') as f:
            sql=f.read().replace('someday',day)
        res = self.ora.doget(sql)
        res.columns = ['NUM','BAN','LEI']
        res['riqi']=day
        # self.ms.dopost('truncate table pkg_cap_calcu')
        self.ms.dopost("delete from pkg_cap_calcu where riqi=str_to_date('"+day+"','%Y/%m/%d')")
        base.batchwri(res, 'pkg_cap_calcu',self.ms)