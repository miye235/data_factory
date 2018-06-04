from dataprocess.oracleprocess.mes.base import Base

class YunFan(object):
    def __init__(self):
        super(YunFan, self).__init__()
    def __call__(self):
        b=Base()
        self.ora = b.conn('mes')
        self.ms = b.conn('offline')
        sql = open('sqls/原反投入.sql', 'r').read()
        res = self.ora.doget(sql)
        res.columns = ['matno', 'lot', 'num', 'uptime', 'formno']
        self.ms.dopost('truncate table yuanfantouru')
        b.batchwri(res, 'yuanfantouru',self.ms)
        self.ora.close()
        self.ms.close()