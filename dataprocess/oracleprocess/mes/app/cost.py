from common.DbCommon import mysql2pd,oracle2pd

class Cost(object):
    def __init__(self):
        super(Cost, self).__init__()

    def __call__(self):
        self.ora=oracle2pd('10.232.101.51','1521','MESDB','BDATA','BDATA')
        self.ms=mysql2pd('123.59.214.229','33333','offline','root','Rtsecret')
        with open('../sqls/损耗.sql','r') as f:
            sql=f.read()
        res = self.ora.doget(sql)
        self.ms.dopost('truncate table sunhao')
        print(res.shape)
        total=res.shape[0]
        nowrow=0
        while nowrow<total-1000:
            self.ms.write2mysql(res[nowrow:nowrow+1000], 'sunhao')
            nowrow+=1000
        self.ms.write2mysql(res[nowrow:], 'sunhao')
    def __del__(self):
        self.ora.close()
        self.ms.close()