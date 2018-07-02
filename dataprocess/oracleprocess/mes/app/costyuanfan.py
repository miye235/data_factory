from dataprocess.oracleprocess.mes.base import Base
class CostYuanfan(object):
    def __init__(self):
        super(CostYuanfan,self).__init__()
    def transth(self,df):
        result=self.erp.doget(self.sql2.replace('thisno',df['MATERIALNO']))['COMPONENT_QUANTITY'].dropna()
        if result.empty:
            return None
        else:
            return float(result[0])
    def transth2(self,df):
        result = self.offline.doget(self.sql3.replace('thisno',df['MATERIALNO']))['ITEM_COST'].dropna()
        if result.empty:
            return None
        else:
            return float(result[0])
    def __call__(self,conns):
        base=Base()
        self.offline=conns['offline']
        self.erp=conns['erp']
        res=[]
        # res.columns[]
        # self.offline.dopost("truncate table cost_yuanfan_test")
        with open(base.path1+'sqls/原反损耗/sql1.sql','r') as f:
            sql1=f.read()
        with open(base.path1+'sqls/原反损耗/sql2.sql','r') as f:
            self.sql2=f.read()
        with open(base.path1+'sqls/原反损耗/sql3.sql','r') as f:
            self.sql3=f.read()
        for date in [base.getYesterday(),base.gettoday()]:
            res=self.offline.doget(sql1.replace('yewudate',date))
            self.offline.dopost("delete from cost_yuanfan_test where 業務日期='"+date+"'")
            if not res.empty:
                res['用量']=res.apply(lambda r: self.transth(r), axis=1)
                res['单价']=res.apply(lambda r: self.transth2(r),axis=1)
                res['業務日期']=date
                base.batchwri(res, 'cost_yuanfan_test', self.offline)
            del res