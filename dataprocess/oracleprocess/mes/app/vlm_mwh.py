from dataprocess.oracleprocess.mes.base import Base

class Vlm(object):
    def __init__(self):
        super(Vlm, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        b=Base()
        self.ora = b.conn('mes')
        self.ms = b.conn('offline')
        sql = open('../sqls/vlm_mwh.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['lot','device','wo','newquantity','transactiontime','resourcename','oldoperation']
        self.ms.dopost('truncate table vlm_mwh')
        b.write2mysql(res, 'vlm_mwh',self.ms)