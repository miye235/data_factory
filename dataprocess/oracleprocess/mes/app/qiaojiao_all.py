# -*- coding: UTF-8 -*-
from dataprocess.oracleprocess.mes.base import Base
import pandas as pd

class QiaoJiao(object):

    def __init__(self):
       super(QiaoJiao, self).__init__()

    def dolot(self,lot):
        sql3=self.sql2.replace('thislot',lot)
        data2=self.ora.doget(sql3)
        return data2
    def __call__(self,btime,etime,conns):
        b=Base()
        with open(b.path1+'sqls/翘角信息查询.sql','r') as f1:
            sql1 =f1.read().replace('btime',btime).replace('etime',etime)
        with open(b.path1+'sqls/翘角信息查询2.sql', 'r') as f2:
            self.sql2 = f2.read()
        self.ora=conns['mes']
        self.ms=conns['offline']
        data=self.ora.doget(sql1)
        print(data)
        res=[]
        for one in data.values:
            data2=self.dolot(list(one)[4])
            for v in data2.values:
                fin=list(one)+list(v)[:-1]
                res.append(fin)
        res_pd=pd.DataFrame(res,columns=["pva_outtime","psa_outtime","rtx_outtime","checktime","psa_lot",\
                                         "slt_lot","rtx_lot","data1","PARAMETER","SAMPLESEQ","OPERATION"])
        b.batchwri(res_pd,"all_qiaojiao",self.ms)
