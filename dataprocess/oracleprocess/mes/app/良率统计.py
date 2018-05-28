from common.DbCommon import mysql2pd,oracle2pd

class LiangLv(object):
    def __init__(self):
        super(LiangLv, self).__init__()

    def __call__(self):
        self.ora=oracle2pd('10.232.101.51','1521','MESDB','BDATA','BDATA')
        self.ms=mysql2pd('123.59.214.229','33333','offline','root','Rtsecret')
        with open('../sqls/良率/良率统计分析.sql','r') as f:
            sql=f.read()
        res = self.ora.doget(sql)
        res.columns=['pva_lot','psa_trantime','psa_sub','pva_trantime','slt_lot','hd_lot','sub_lot',\
                     'cust_lot','checkout_time','device','hd_wo',\
                     'qd_wo','arr_qty','Agui','reason','descr','quantity','bancheng_lot']
        self.ms.dopost('truncate table lianglv')
        print(res.shape)
        total=res.shape[0]
        nowrow=0
        while nowrow<total-1000:
            self.ms.write2mysql(res[nowrow:nowrow+1000], 'lianglv')
            nowrow+=1000
        self.ms.write2mysql(res[nowrow:], 'lianglv')
    def __del__(self):
        self.ora.close()
        self.ms.close()