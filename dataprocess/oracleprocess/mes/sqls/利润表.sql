select SUM(CASE WHEN A.segment3 between '5110' and '5230' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5110' and '5230' THEN B.accounted_cr ELSE 0 END) 营业收入

			,SUM(CASE WHEN A.segment3 between '5301' and '5340' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5301' and '5340' THEN B.accounted_cr ELSE 0 END) 减_营业成本1
			,0 - SUM(CASE WHEN A.segment3 = '5301' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5301' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 减_营业成本2
			,SUM(CASE WHEN A.segment3 between '5810' and '5820' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5810' and '5820' THEN B.accounted_cr ELSE 0 END) 减_营业成本3
			
			,SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_cr ELSE 0 END) 税金及附加1
			,SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_cr ELSE 0 END) 税金及附加2
			,SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_cr ELSE 0 END) 税金及附加3
			,SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '300' and '400' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '300' and '400' THEN B.accounted_cr ELSE 0 END) 税金及附加4
			
			,SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END) 销售费用1
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 销售费用2
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_cr ELSE 0 END) 销售费用3
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_cr ELSE 0 END) 销售费用4
			
			,SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END) 管理费用1
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_cr ELSE 0 END) 管理费用2
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_cr ELSE 0 END) 管理费用3
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '200' and '400' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '200' and '400' THEN B.accounted_cr ELSE 0 END) 管理费用4
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 管理费用5
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '200' and '400' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '200' and '400' THEN B.accounted_cr ELSE 0 END) 管理费用6
			,SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END) 管理费用7
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 between '120' and '140' THEN B.accounted_cr ELSE 0 END) 管理费用8
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '170' THEN B.accounted_cr ELSE 0 END) 管理费用9
			,0 - SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5521' and A.segment4 = '200' THEN B.accounted_cr ELSE 0 END) 管理费用10
			
			,SUM(CASE WHEN A.segment3 = '7110' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7110' THEN B.accounted_cr ELSE 0 END) 财务费用1
			,SUM(CASE WHEN A.segment3 = '7161' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7161' THEN B.accounted_cr ELSE 0 END) 财务费用2
			,SUM(CASE WHEN A.segment3 = '7510' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7510' THEN B.accounted_cr ELSE 0 END) 财务费用3
			,SUM(CASE WHEN A.segment3 = '7560' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7560' THEN B.accounted_cr ELSE 0 END) 财务费用4
			,SUM(CASE WHEN A.segment3 = '7580' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7580' THEN B.accounted_cr ELSE 0 END) 财务费用5
			
			,SUM(CASE WHEN A.segment3 = '5301' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '5301' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 资产减值损失
			
			,SUM(CASE WHEN A.segment3 = '7121' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7121' THEN B.accounted_cr ELSE 0 END) 投资收益
			
			,SUM(CASE WHEN A.segment3 = '7100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7100' THEN B.accounted_cr ELSE 0 END) 加_营业外收入1
			,SUM(CASE WHEN A.segment3 between '7131' and '7241' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '7131' and '7241' THEN B.accounted_cr ELSE 0 END) 加_营业外收入2
			,0 - SUM(CASE WHEN A.segment3 = '7161' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7161' THEN B.accounted_cr ELSE 0 END) 加_营业外收入3
			
			,SUM(CASE WHEN A.segment3 between '7520' and '7550' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '7520' and '7550' THEN B.accounted_cr ELSE 0 END) 减_营业外支出1
			,SUM(CASE WHEN A.segment3 between '7600' and '7610' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '7600' and '7610' THEN B.accounted_cr ELSE 0 END) 减_营业外支出2
			,SUM(CASE WHEN A.segment3 = '7690' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '7690' THEN B.accounted_cr ELSE 0 END) 减_营业外支出3
			
			,SUM(CASE WHEN A.segment3 between '8111' and '8112' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '8111' and '8112' THEN B.accounted_cr ELSE 0 END) 减_所得税费用
			
from apps.gl_code_combinations A
		,apps.gl_je_lines B
where A.CODE_COMBINATION_id = B.CODE_COMBINATION_id
	AND substr(to_char(B.creation_date,'yyyy-mm-dd'),0,7) = 'thismonth'
	
