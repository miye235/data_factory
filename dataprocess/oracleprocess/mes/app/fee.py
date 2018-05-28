from common.DbCommon import mysql2pd,oracle2pd
class Fee(object):

    def __init__(self):
        super(Fee, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def batchwri(self,res,table):
        print(res.shape)
        total = res.shape[0]
        nowrow = 0
        while nowrow < total - 1000:
            self.ms.write2mysql(res[nowrow:nowrow + 1000],table)
            nowrow += 1000
        self.ms.write2mysql(res[nowrow:],table)
    def trandate(self,df):
        return df['DATE_MONTH'][:4]+'-'+df['DATE_MONTH'][4:6]+'-00'
    def __call__(self):
        tables={'finance_fee':open('../sqls/费用/财务费用.sql','r').read(),'made_fee':open('../sqls/费用/制造费用.sql','r').read(),\
        'manage_fee':open('../sqls/费用/管理费用.sql','r').read(),'sale_fee':open('../sqls/费用/销售费用.sql','r').read()}
        self.ms = mysql2pd('123.59.214.229', '33333', 'offline', 'root', 'Rtsecret')
        self.ora=oracle2pd('10.232.1.101','1521','KSERP','BDATA','BDATA')
        for k,v in tables.items():
            print('正在进行'+k)
            res = self.ora.doget(v)
            res['DATE_MONTH'] = res.apply(lambda r: self.trandate(r), axis=1)
            self.ms.dopost("truncate table "+k)
            self.batchwri(res,k)

