from dataprocess.oracleprocess.mes.base import Base
import pandas as pd

class QiaoJiao(object):

    def __init__(self):
        super(QiaoJiao, self).__init__()
    def __del__(self):
        self.ora.close()
        self.ms.close()
    def createtables(self,sql):
        self.ms.dopost(sql)
    def mess1(self,sql):
        res = self.ora.doget(sql)
        res.columns = ['DATA', 'PARAMETER', 'SAMPLESEQ', 'OPERATION', 'LOT']
        self.ms.write2mysql(res, 'qiaojiao_mess')
    def mess2(self,btime,etime):
        LOTLIST = self.ms.getdata('trace_production', pars=['rtx_lot'],tjs=["to_date(rtx_outtime,'yyyy-mm-dd hh24:mi:ss')>=to_date('"+btime+"','yyyy-mm-dd hh24:mi:ss')","to_date(rtx_outtime,'yyyy-mm-dd hh24:mi:ss')<to_date('"+etime+"','yyyy-mm-dd hh24:mi:ss')"]).drop_duplicates().dropna()
        LOTLIST.columns = ['LOT']
        trans = self.ora.getdata('MES.MES_WIP_HIST', pars=['LOT', 'TRANSACTIONTIME'],
                            tjs=["TRANSACTION='CheckOut'", "LOT like '%-B-%'"])
        res2 = pd.merge(LOTLIST, trans, how='left', on='LOT')
        res2.columns = ['LOT', 'CHECKTIME']
        self.ms.dopost('truncate table check_mess')
        self.ms.write2mysql(res2, 'check_mess')
    def checktable(self,table):
        ret=self.ms.getdata(table)
        print(ret)

    def __call__(self,btime,etime):
        sql1 =open('../sqls/翘角信息查询.sql','r').read()
        b=Base()
        self.ora=b.conn('mes')
        self.ms=b.conn('offline')
        self.mess2('2018-06-01 00:00:00','2018-06-04 00:00:00')
        # print('创建输出表...')
        # createtables(sqlc1)
        # createtables(sqlc2)
        print('取表1...')
        # for lot in ms.getdata('check_mess')['LOT'].drop_duplicates().dropna().values:
        #     sql1=sql1.replace('thislot',lot)
        #     mess1(sql1)
        # print('取表2...')
        # for i in range(1,5):
        #     print('正在查询第'+str(i)+'月的信息...')
        #     if i<9:
        #         bd='0'+str(i)+'-01'
        #         ed='0'+str(i+1)+'-01'
        #     elif i==9:
        #         bd='09'+'-01'
        #         ed='10'+'-01'
        #     elif i==12:
        #         bd='12-01'
        #         ed='12-31'
        #     else:
        #         bd=str(i)+'-01'
        #         ed=str(i+1)+'-01'
        sql1=sql1.replace('begintime','2018-06-01').replace('endtime','2018-06-04')
        self.mess1(sql1)