from dataprocess.oracleprocess.mes.base import Base

class LiangPin(object):
    def __init__(self):
        super(LiangPin, self).__init__()
    def __call__(self):
        base=Base()
        self.ora =base.conn('mes')
        sql = open('sqls/良品.sql', 'r').read()
        self.ms =base.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['liangpin_qty','touru_qty','class','WEEK']
        self.ms.dopost('truncate table liangpin')
        base.batchwri(res, 'liangpin',self.ms)
        self.ora.close()
        self.ms.close()