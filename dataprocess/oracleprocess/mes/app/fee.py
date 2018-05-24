from common.DbCommon import mysql2pd,oracle2pd
class Fee(object):

    def __init__(self):
        super(Fee, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def trandate(self,df):
        return df['DATE_MONTH'][:4]+'-'+df['DATE_MONTH'][4:6]+'-00'
    def __call__(self):
        tables={'finance_fee':open('../sqls/财务费用.sql','r').read(),'made_fee':open('../sqls/制造费用.sql','r').read(),\
        'manage_fee':open('../sqls/管理费用.sql','r').read(),'sale_fee':open('../sqls/销售费用.sql','r').read()}
        ms = mysql2pd('123.59.214.229', '33333', 'offline', 'root', 'Rtsecret')
        ora=oracle2pd('10.232.1.101','1521','KSERP','BDATA','BDATA')
        for k,v in tables.items():
            print('正在进行'+k)
            res = ora.doget(v)
            res['DATE_MONTH'] = res.apply(lambda r: self.trandate(r), axis=1)
            print(res)
            ms.dopost("truncate table "+k)
            ms.write2mysql(res,k)
