from dataprocess.oracleprocess.mes.base import Base

class LLRB(object):
    def __init__(self):
        super(LLRB, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def __call__(self):
        b=Base()
        self.ora =b.conn('mes')
        sql = open('../sqls/良率/良率日报.sql', 'r').read()
        self.ms =b.conn('offline')
        res = self.ora.doget(sql)
        res.columns = ['qd_wo','hd_wo','materialno','lot','pro_state','thisdate','facno','class','thistype','touru_qty','liangpin_qty','dianque_qty','dianque_item','sort']
        self.ms.dopost('truncate table lianglvribao')
        b.batchwri(res, 'lianglvribao',self.ms)