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

    def findmother(self, lotid, alllotid):
        res = []
        for k, x in lotid.iteritems():
            idx = x.rfind('.')
            if idx == -1:
                res.append(x)
            else:
                if x[:idx] in lotid or x[:idx] in alllotid:
                    res.append(x[:idx])
                else:
                    res.append(x)
        return res

    def __call__(self, begtime, endtime, conns):
        base = Base()
        mes = conns['mes']
        offline =conns['offline']
        with open(base.path1+'sqls/良率/整体良率.sql','r') as f:
            sql=f.read().replace('thisbegtime', begtime)
        res = mes.doget(sql)
        alllotid = offline.doget("select LOT from OverallGoodRatio")
        res['LOT_MU'] = self.findmother(res['LOT'], alllotid)
        res['week'] = res.apply(lambda r: self.trandate(r), axis=1)
        # offline.dopost("truncate table OverallGoodRatio")
        base.batchwri(res, 'OverallGoodRatio00', offline)

if __name__ == "__main__":
    base = Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    t3s = OverallGoodRatio()
    t3s('2018-07-02 12:09:05','2018-07-02 17:09:05', conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()




