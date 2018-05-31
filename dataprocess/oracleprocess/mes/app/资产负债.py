from dataprocess.oracleprocess.mes.base import Base
import os,datetime

class FuZhai(object):
    def __init__(self):
        super(FuZhai, self).__init__()


    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        b=Base()
        self.erp =b.conn('erp')
        self.ms=b.conn('offline')
        now = datetime.datetime.now()
        year=now.year
        month = (now.month - 1)%12
        if month==0:
            month=12
            year-=1
        this_quarter_start = datetime.datetime(year, month, 1)
        lastm=str(this_quarter_start)[:7]
        with open('../sqls/资产负债表.sql','r') as f:
            sql1=f.read().replace('thismonth',str(lastm))
        res1 = self.erp.doget(sql1)
        res1.columns=['monetary_funds','bill_sld_get','cash_sld_get','prepay1','prepay2','prepay3','prepay4','prepay5','sld_get_interest1','prepay2_1','prepay3_1','oth_sld_get1','oth_sld_get2','oth_sld_get3','oth_sld_get4','oth_sld_get5','oth_sld_get6','oth_sld_get7','stock','material1','material2','material3','material4','stock_good','stock_semi_good','other_flow_funds1','other_flow_funds2','other_flow_funds3','other_flow_funds4','other_flow_funds5','other_flow_funds6','other_flow_funds7','finan_assets4sale','Long_term_eq_inv','orival_fixed_asset1','orival_fixed_asset2','orival_fixed_asset3','orival_fixed_asset4','orival_fixed_asset5','orival_fixed_asset6','orival_fixed_asset7','orival_fixed_asset8','orival_fixed_asset9','orival_fixed_asset10','orival_fixed_asset11','minu_sum_zhejiu1','minu_sum_zhejiu2','minu_sum_zhejiu3','minu_sum_zhejiu4','minu_sum_zhejiu5','minu_sum_zhejiu6','minu_sum_zhejiu7','minu_sum_zhejiu8','minu_sum_zhejiu9','building_pro1','building_pro2','intangible_assets1','intangible_assets2','longterm_appor_cost1','longterm_appor_cost2','deferred_tax_assets1','deferred_tax_assets2','deferred_tax_assets3','shortterm_loan','sld_pay_bill1','sld_pay_bill2','sld_pay_money1','sld_pay_money2','sld_pay_money3','sld_pay_money4','pre_get_money','salary_sld_pay1','salary_sld_pay2','salary_sld_pay3','salary_sld_pay4','salary_sld_pay5','salary_sld_pay6','salary_sld_pay7','tax_sld_pay1','tax_sld_pay2','tax_sld_pay3','tax_sld_pay4','tax_sld_pay5','mid_tax_sld_pay1','mid_tax_sld_pay2','mid_tax_sld_pay3','mid_tax_sld_pay4','bonus_sld_pay1','bonus_sld_pay2','bonus_sld_pay3','bonus_sld_pay4','oth_sld_pay1','oth_sld_pay2','oth_sld_pay3','oth_sld_pay4','oth_sld_pay5','oth_sld_pay6','oth_sld_pay7','oth_sld_pay8','oth_sld_pay9','oth_sld_pay10','oth_sld_pay11','oth_sld_pay12','oth_sld_pay13','oth_sld_pay14','oth_sld_pay15','oth_sld_pay16','oth_sld_pay17','oth_sld_pay18','oth_flow_loan','longterm_loan','deferred_tax_liability1','deferred_tax_liability2','Capital_collection','Capital_stock','Special_reserve','surplus1','surplus2','statu_provident_fund','undistribute_profit1','undistribute_profit2','undistribute_profit3','undistribute_profit4']
        res1['upmonth']=lastm
        self.ms.dopost("delete from zichanfuzhai where upmonth='"+lastm+"'")
        b.batchwri(res1,'zichanfuzhai',self.ms)
        # del res1,sql1
    def __del__(self):
        self.erp.close()
        self.ms.close()