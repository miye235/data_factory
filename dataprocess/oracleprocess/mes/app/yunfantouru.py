from common.DbCommon import oracle2pd,mysql2pd
class YunFan(object):
    def __init__(self):
        super(YunFan, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        self.ora = oracle2pd('10.232.101.51', '1521', 'MESDB', 'BDATA', 'BDATA')
        sql = open('../sqls/原反投入.sql', 'r').read()
        self.ms = mysql2pd('123.59.214.229', '33333', 'offline', 'root', 'Rtsecret')
        res = self.ora.doget(sql)
        res.columns = ['matno', 'lot', 'num', 'uptime', 'formno']
        self.ms.dopost('truncate table yuanfantouru')
        self.ms.write2mysql(res, 'yuanfantouru')