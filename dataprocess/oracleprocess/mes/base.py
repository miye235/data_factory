from common.DbCommon import oracle2pd,mysql2pd
import datetime
import pandas as pd
class Base():
    def __init__(self):
        self.dbconfig={
            'erp':('10.232.1.101', '1521', 'KSERP', 'BDATA', 'BDATA'),
            'offline':('123.59.214.229', '33333', 'offline', 'root', 'Rtsecret'),
            # 'offline':('10.232.70.203', '33333', 'offline', 'root', 'Rtsecret'),
            'mes':('10.232.101.51', '1521', 'MESDB', 'BDATA', 'BDATA'),
            'wms':('10.232.1.200', '1521', 'WMSDB', 'BDATA', 'BDATA')
        }
    def conn(self,db):
        if db=='offline':
            return mysql2pd(*self.dbconfig['offline'])
        else:
            return oracle2pd(*self.dbconfig[db])
    def datelist(self,beginDate, endDate):
        # beginDate, endDate是形如‘20160601’的字符串或datetime格式
        date_l = [datetime.datetime.strftime(x, '%Y/%m/%d') for x in list(pd.date_range(start=beginDate, end=endDate))]
        return date_l

    def getYesterday(self):
        today = datetime.date.today()
        oneday = datetime.timedelta(days=1)
        yesterday = today - oneday
        yesterday = datetime.datetime.strftime(yesterday, '%Y/%m/%d')
        return yesterday

    def batchwri(self, res, table,conn):
        print(res.shape)
        total = res.shape[0]
        nowrow = 0
        while nowrow < total - 1000:
            conn.write2mysql(res[nowrow:nowrow + 1000], table)
            nowrow += 1000
        conn.write2mysql(res[nowrow:], table)