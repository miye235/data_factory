from dataprocess.oracleprocess.mes.base import Base
import datetime
class MainBusinessCost(object):
    def __init__(self):
        super(MainBusinessCost,self).__init__()
    def __call__(self, conns):
        now=datetime.datetime.now()
        day1=now.day
        oneday = datetime.timedelta(days=1)
        tomorrow = now + oneday
        day2=tomorrow.day
        if day1==1 or day2==1:
            base=Base()
            erp=conns['erp']
            offline=conns['offline']

            remove_res = erp.doget('select * from apps.YCST_COGS_TMP').drop_duplicates(['CREATED_BY','CREATION_DATE','TXN_DATE_FM','TXN_DATE_TO'])
            #print(res)
            with open(base.path1+'sqls/主营业务成本.sql','r') as f:
                sql=f.read()
            offline.dopost("truncate table main_bussiness_cost1")
            for index in remove_res.index:
                date=remove_res.loc[index]['CREATION_DATE'].strftime("%Y-%m-%d")
                res = erp.doget(sql.replace('userid',str(remove_res.loc[index]['CREATED_BY'])).replace('date',date))
                searchdate=remove_res.loc[index]['TXN_DATE_FM'].strftime("%Y-%m-%d")[:7]
                res['日期'] = searchdate
                base.batchwri(res, 'main_bussiness_cost1', offline)


# base=Base()
# erp = base.conn('erp')
# offline = base.conn('offline')
# wms = base.conn('wms')
# mes = base.conn('mes')
# conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
# mbs=MainBusinessCost()
# mbs(conns)
# offline.close()
# erp.close()
# wms.close()
# mes.close()