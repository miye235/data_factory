from common.DbCommon import mysql2pd,oracle2pd
import pandas as pd

def createtables(sql):
    ms.dopost(sql)
def mess1(sql):
    res = ora.doget(sql)
    res.columns = ['DATA', 'PARAMETER', 'SAMPLESEQ', 'OPERATION', 'LOT']
    ms.write2mysql(res, 'qiaojiao_mess')
def mess2():
    LOTLIST = ms.getdata('trace_production', pars=['rtx_lot']).drop_duplicates().dropna()
    LOTLIST.columns = ['LOT']
    trans = ora.getdata('MES.MES_WIP_HIST', pars=['LOT', 'TRANSACTIONTIME'],
                        tjs=["TRANSACTION='CheckOut'", "LOT like '%-B-%'"])
    res2 = pd.merge(LOTLIST, trans, how='left', on='LOT')
    res2.columns = ['LOT', 'CHECKTIME']
    ms.write2mysql(res2, 'check_mess')
def checktable(table):
    ret=ms.getdata(table)
    print(ret)

if __name__ == "__main__":
    sql1 =open('dataprocess/oracleprocess/mes/sqls/翘角信息查询.sql','r').read()
    ora=oracle2pd('10.232.101.51','1521','MESDB','BDATA','BDATA')
    ms=mysql2pd('123.59.26.236','33333','mysql','root','Rtsecret')
    # print('创建输出表...')
    # createtables(sqlc1)
    # createtables(sqlc2)
    print('取表1...')
    # for lot in ms.getdata('check_mess')['LOT'].drop_duplicates().dropna().values:
    #     sql1=sql1.replace('thislot',lot)
    #     mess1(sql1)
    # print('取表2...')
    for i in range(1,5):
        print('正在查询第'+str(i)+'月的信息...')
        if i<9:
            bd='0'+str(i)+'-01'
            ed='0'+str(i+1)+'-01'
        elif i==9:
            bd='09'+'-01'
            ed='10'+'-01'
        elif i==12:
            bd='12-01'
            ed='12-31'
        else:
            bd=str(i)+'-01'
            ed=str(i+1)+'-01'
        sql1=sql1.replace('begintime','2018-'+bd+' 00:00:00').replace('endtime','2018-'+ed+' 00:00:00')
        mess1(sql1)
    # print('检查表中数据...')
    # checktable('check_mess')
    # checktable('qiaojiao_mess')