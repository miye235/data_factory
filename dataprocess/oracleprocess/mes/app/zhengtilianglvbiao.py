from dataprocess.oracleprocess.mes.base import Base
import datetime
class OverallGoodRatio(object):
    def __init__(self):
        super(OverallGoodRatio, self).__init__()


    def trandate(self, df):
        this_time = df['CHECKOUTTIME']
        base_time = '2017/12/29 08:00:00'
        base_time = datetime.datetime(int(base_time[:4]), int(base_time[5:7]), int(base_time[8:10]),
                                      int(base_time[11:13]), int(base_time[14:16]), int(base_time[17:19]))
        this_time = datetime.datetime(int(this_time[:4]), int(this_time[5:7]), int(this_time[8:10]),
                                      int(this_time[11:13]), int(this_time[14:16]), int(this_time[17:19]))
        if (this_time - base_time).days // 7 + 1 < 10:
            return '2018年第0' + str((this_time - base_time).days // 7 + 1) + '周'
        else:
            return '2018年第' + str((this_time - base_time).days // 7 + 1) + '周'



    def findmu(self, lot):
        idx = lot.find('.')
        if idx == -1:
            return lot
        else:
            return lot[:idx]

    def __call__(self, conns):
        base = Base()
        mes = conns['mes']
        offline =conns['offline']
        with open(base.path1+'sqls/良率/整体良率.sql','r') as f:
            sql=f.read()
        # offline.dopost("delete from OverallGoodRatio00 where date_format(CHECKOUTTIME,'%Y-%m-%d %H:%i:%s')>date_format('" + "2018-03-03 08:00:00" + "','%Y-%m-%d %H:%i:%s') ")
        # for day in base.datelist('20180101', '20180704')[::-1]:
        #     todaybeg = day + ' 08:00:00'
        #     todayend = datetime.datetime.strptime(todaybeg, '%Y/%m/%d %H:%M:%S') + datetime.timedelta(1)
        #     todayend = todayend.strftime('%Y/%m/%d %H:%M:%S')
        #     thissql = sql.replace('thisbegtime', todaybeg).replace('thisendtime', todayend)
        #     res = mes.doget(thissql)
        #     if not res.empty:
        #         lotmu = res['LOT'].apply(self.findmu)
        #         lotmures = []
        #         for idx in lotmu.index:
        #             if lotmu[idx] in lotmu.values[:idx] or lotmu[idx] in lotmu.values[idx+1:]:
        #                 lotmures.append(lotmu[idx])
        #             else:
        #                 lotmures.append(res.loc[idx, 'LOT'])
        #         res['LOT_MU'] = lotmures
        #         res['week'] = res.apply(lambda r: self.trandate(r), axis=1)
        #         base.batchwri(res, 'OverallGoodRatio00', offline)

        todaybeg = datetime.datetime.now().strftime('%Y/%m/%d') + ' 08:00:00'
        todayend = datetime.datetime.strptime(todaybeg, '%Y/%m/%d %H:%M:%S') + datetime.timedelta(1)
        todayend = todayend.strftime('%Y/%m/%d %H:%M:%S')
        thissql = sql.replace('thisbegtime', todaybeg).replace('thisendtime', todayend)
        res = mes.doget(thissql)
        if not res.empty:
            lotmu = res['LOT'].apply(self.findmu)
            offline.dopost("delete from OverallGoodRatio00 where date_format(CHECKOUTTIME,'%Y-%m-%d %H:%i:%s')>date_format('"+todaybeg+"','%Y-%m-%d %H:%i:%s') ")
            lotmures = []
            for idx in lotmu.index:
                if lotmu[idx] in lotmu.values[:idx] or lotmu[idx] in lotmu.values[idx + 1:]:
                    lotmures.append(lotmu[idx])
                else:
                    lotmures.append(res.loc[idx, 'LOT'])
            res['LOT_MU'] = lotmures
            res['week'] = res.apply(lambda r: self.trandate(r), axis=1)
            base.batchwri(res, 'OverallGoodRatio00', offline)


if __name__ == "__main__":
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = OverallGoodRatio()
    t3s(conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()




