from dataprocess.oracleprocess.mes.base import Base
import os
class Fee(object):

    def __init__(self):
        super(Fee, self).__init__()
    def trandate(self,df):
        return df['日期'][:4]+'-'+df['日期'][4:6]+'-00'
    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        base=Base()
        tables={'manage_fee1': open('sqls/费用/管理费用.sql', 'r').read(), \
                'sale_fee1': open('sqls/费用/销售费用.sql', 'r').read(), \
                'made_fee1':open('sqls/费用/制造费用.sql','r').read(),\
                'finance_fee1':open('sqls/费用/财务费用.sql','r').read()}
        self.ms =base.conn('offline')
        self.ora=base.conn('erp')
        for k,v in tables.items():
            print('正在进行'+k)
            res = self.ora.doget(v)
            if k=='sale_fee1':
                res.columns=['日期','工资','福利','保险费_人事','住房公积金','工会经费','职工教育经费','股份支付','职工薪酬其他','文具用品','旅费','运费','邮电费','修缮费','广告费','动力费','交际费','折旧','各项摊提','权力费','职工福利','研究发展费','训练费','保全费','出口费用','加工费','包装费','间接材料','检测费','什项购置','书报杂志','劳务费','进口费用','会议费','租金支出','残保金','外包人力派遣','交通费','其他费用']
            if k=='manage_fee1':
                res.columns=['日期','工资','福利','保险费','住房公积金','工会经费','职工教育经费','股份支付','职工薪酬其他','文具用品','旅费','运费','邮电费','修缮费','广告费','动力费','交际费','折旧','各项摊提','权力费','职工福利','研究发展费','训练费','保全费','加工费','包装费','间接材料','检测费','保险费资产','什项购置','书报杂志','劳务费','进口费用','会议费','租金支出','残保金','外包人力派遣','交通费','其他费用']
            if k=='finance_fee1':
                res.columns=['日期','利息收入','集团内部利息收入','贷款利息支出','集团内部利息支出','金融机构手续费','汇兑损益','财务顾问费','担保费','贴现利息支出','融资租赁利支出','利息支出资本化']
            if k=='made_fee1':
                res.columns=['日期','薪资支出_直接','社会保险费_直接','伙食费_直接','外包人力派遣_直接','薪资支出','保险费_人事','文具用品','旅费','运费','邮电费','修缮费','广告费','动力费','交际费','折旧','各项摊提','权利金','伙食费','职工福利','研究发展费','训练费','保全费','出口费用','加工费','包装费','间接材料','检测费','保险费资产','什项购置','书报杂志','劳务费','进口费用','会议费','租金支出','残保金','外包人力派遣','交通费','其他费用']
            res['日期'] = res.apply(lambda r: self.trandate(r), axis=1)
            self.ms.dopost("truncate table "+k)
            base.batchwri(res,k,self.ms)
        self.ora.close()
        self.ms.close()