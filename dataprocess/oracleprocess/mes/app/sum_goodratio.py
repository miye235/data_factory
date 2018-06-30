from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
import datetime
class SumGoodRatio(object):
    def __init__(self):
        super(SumGoodRatio, self).__init__()


    def __call__(self,conns):
        base=Base()
        ms =conns['offline']
        with open(base.path1+'sqls/良率30日累计/综合.sql','r') as f:
            sql1=f.read()
        with open(base.path1+'sqls/良率30日累计/量产TD.sql','r') as f:
            sql2=f.read()
        with open(base.path1+'sqls/良率30日累计/量产重庆.sql','r') as f:
            sql3=f.read()

        sqldict = {'综合':sql1, '量产＋TD': sql2, '量产＋重庆':sql3}
        devicedict = {'R':['R', 'D'], 'F':['F', 'U']}
        sizelst = [55,50,31.5,38.5,23.6]

        # for day in base.datelist('20180101', '20180628')[::-1]:
        #     day = day.replace('/', '-')
        #     day30 = base.getYesterday(day, 30).replace('/','-')
        #     for rangename, sql in sqldict.items():
        #         res = []
        #         thissql = sql.replace('starttime', "'" + day30 + "'").replace('endtime', "'" + day + "'")
        #         for device in devicedict.values():
        #             for size in sizelst:
        #                 thissql = thissql.replace('thisdevice1', device[0]).replace('thisdevice2', device[1]).replace('thissize', str(size))
        #                 sqlres = ms.doget(thissql)
        #                 sum_input = sum(sqlres['sum(投入)'])
        #                 if sum_input >= 1:
        #                     ljlv30 = sum(sqlres['sum(A规)'])/sum_input
        #                     res.append([day, ljlv30, size, device[0], rangename])
        #         if not res == []:
        #             res = pd.DataFrame(res, columns=['rq', 'ljlv30', 'chicun', 'type', 'range'] )
        #             base.batchwri(res, 'sum_goodratio', ms)

        today = datetime.datetime.now()
        tomorrow = today + datetime.timedelta(1)
        #ms.dopost("truncate table sum_goodratio")
        #for day in base.datelist('20180101', '20180627')[::-1]:
        for day in [today.strftime('%Y/%m/%d'), tomorrow.strftime('%Y/%m/%d')]:
            day = day.replace('/', '-')
            day30 = base.getYesterday(day, 30).replace('/', '-')
            ms.dopost("delete from sum_goodratio where rq="+"'"+day+"'")
            for rangename, sql in sqldict.items():
                res = []
                thissql = sql.replace('starttime', "'" + day30 + "'").replace('endtime', "'" + day + "'")
                thissql2=sql.replace('starttime', "'" + day[:8] + "01'").replace('endtime', "'" + day + "'")
                for device in devicedict.values():
                    for size in sizelst:
                        thissql = thissql.replace('thisdevice1', device[0]).replace('thisdevice2', device[1]).replace('thissize', str(size))
                        thissql2 = thissql2.replace('thisdevice1', device[0]).replace('thisdevice2', device[1]).replace('thissize', str(size))
                        sqlres = ms.doget(thissql)
                        sqlres2 = ms.doget(thissql2)
                        sum_input = sum(sqlres['sum(投入)'])
                        sum_input2 = sum(sqlres2['sum(投入)'])
                        if sum_input >= 1:
                            ljlv30 = sum(sqlres['sum(A规)'])/sum_input
                        else:
                            ljlv30 =-1
                        if sum_input2>= 1:
                            ljlv_mon = sum(sqlres2['sum(A规)'])/sum_input2
                        else:
                            ljlv_mon =-1
                        res.append([day, ljlv30, ljlv_mon, size, device[0], rangename])
                if not res == []:
                    res = pd.DataFrame(res, columns=['rq', 'ljlv30','ljlv_mon', 'chicun', 'type', 'range'] )
                    base.batchwri(res, 'sum_goodratio', ms)


if __name__ == "__main__":
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = SumGoodRatio()
    t3s(conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()
