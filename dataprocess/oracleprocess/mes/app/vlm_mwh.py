from common.DbCommon import oracle2pd,mysql2pd
class Vlm(object):
    def __init__(self):
        super(Vlm, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        self.ora = oracle2pd('10.232.101.51', '1521', 'MESDB', 'BDATA', 'BDATA')
        sql = open('../sqls/vlm_mwh.sql', 'r').read()
        self.ms = mysql2pd('123.59.214.229', '33333', 'offline', 'root', 'Rtsecret')
        res = self.ora.doget(sql)
        res.columns = ['lot','device','wo','newquantity','transactiontime','resourcename','oldoperation']
        self.ms.dopost('truncate table vlm_mwh')
        total = res.shape[0]
        print(str(total))
        nowrow = 0
        while nowrow < total - 1000:
            print(str(nowrow)+':'+str(self.ms.write2mysql(res[nowrow:nowrow + 1000], 'vlm_mwh')))
            nowrow += 1000
        self.ms.write2mysql(res[nowrow:], 'vlm_mwh')