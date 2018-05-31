from dataprocess.oracleprocess.mes.base import Base

class Cost(object):
    def __init__(self):
        super(Cost, self).__init__()

    def __call__(self):
        base=Base()
        self.ora=base.conn('mes')
        self.ms=base.conn('offline')
        with open('../sqls/损耗.sql','r') as f:
            sql=f.read()
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table sunhao')
        base.batchwri(res,'sunhao',self.ms)
    def __del__(self):
        self.ora.close()
        self.ms.close()
c=Cost()
c()