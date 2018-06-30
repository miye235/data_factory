select 营业收入
   ,减_营业成本1+减_营业成本2+减_营业成本3 减_营业成本
   ,税金及附加1+税金及附加2+税金及附加3+税金及附加4+税金及附加5 税金及附加
   ,销售费用1+销售费用2+销售费用3+销售费用4 销售费用
   ,管理费用1+管理费用2+管理费用3+管理费用4+管理费用5+管理费用6+管理费用7+管理费用8+管理费用9+管理费用10+管理费用11 管理费用
   ,财务费用1+财务费用2+财务费用3+财务费用4+财务费用5 财务费用
   ,资产减值损失
   ,投资收益
   ,加_营业外收入1+加_营业外收入2+加_营业外收入3 加_营业外收入
   ,减_营业外支出1+减_营业外支出2+减_营业外支出3 减_营业外支出
   ,减_所得税费用
FROM
  (select SUM(CASE WHEN A.segment4 between '5110' and '5230' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '5110' and '5230' THEN B.accounted_dr ELSE 0 END) 营业收入

     ,SUM(CASE WHEN A.segment4 between '5301' and '5340' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '5301' and '5340' THEN B.accounted_dr ELSE 0 END) 减_营业成本1
     ,0 - (SUM(CASE WHEN A.segment4 = '5301' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5301' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)) 减_营业成本2
     ,SUM(CASE WHEN A.segment4 between '5810' and '5820' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '5810' and '5820' THEN B.accounted_dr ELSE 0 END) 减_营业成本3

     ,SUM(CASE WHEN A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_dr ELSE 0 END) 税金及附加1
     ,SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_dr ELSE 0 END) 税金及附加2
     ,SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_dr ELSE 0 END) 税金及附加3
     ,SUM(CASE WHEN A.segment4 = '5521' and A.segment6 between '300' and '400' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 between '300' and '400' THEN B.accounted_dr ELSE 0 END) 税金及附加4
     ,SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '500' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '500' THEN B.accounted_dr ELSE 0 END) 税金及附加5

     ,SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'SD' AND  A.segment4 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END) 销售费用1
     ,0 - (SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)) 销售费用2
     ,0 - (SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_dr ELSE 0 END)) 销售费用3
     ,0 - (SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'SD' AND A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_dr ELSE 0 END)) 销售费用4

     ,SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END) 管理费用1
     ,0 - (SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_dr ELSE 0 END)) 管理费用2
     ,0 - (SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_dr ELSE 0 END)) 管理费用3
     ,0 - (SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 between '200' and '400' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'MG' AND A.segment4 = '5521' and A.segment6 between '200' and '400' THEN B.accounted_dr ELSE 0 END)) 管理费用4
     ,0 - (SUM(CASE WHEN A.segment3 = 'PD' AND A.segment4 = '5521' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'PD' AND A.segment4 = '5521' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)) 管理费用5
     ,0 - (SUM(CASE WHEN A.segment3 = 'PD' AND A.segment4 = '5521' and A.segment6 between '200' and '400' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'PD' AND A.segment4 = '5521' and A.segment6 between '200' and '400' THEN B.accounted_dr ELSE 0 END)) 管理费用6
     ,SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 between '5410' and '5579' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 between '5410' and '5579' THEN B.accounted_dr ELSE 0 END) 管理费用7
     ,0 - (SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 between '120' and '140' THEN B.accounted_dr ELSE 0 END)) 管理费用8
     ,0 - (SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 = '170' THEN B.accounted_dr ELSE 0 END)) 管理费用9
     ,0 - (SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment3 = 'RD' AND A.segment4 = '5521' and A.segment6 = '200' THEN B.accounted_dr ELSE 0 END)) 管理费用10
     ,0 - (SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '500' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5521' and A.segment6 = '500' THEN B.accounted_dr ELSE 0 END)) 管理费用11


     ,SUM(CASE WHEN A.segment4 = '7110' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7110' THEN B.accounted_dr ELSE 0 END) 财务费用1
     ,SUM(CASE WHEN A.segment4 = '7161' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7161' THEN B.accounted_dr ELSE 0 END) 财务费用2
     ,SUM(CASE WHEN A.segment4 = '7510' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7510' THEN B.accounted_dr ELSE 0 END) 财务费用3
     ,SUM(CASE WHEN A.segment4 = '7560' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7560' THEN B.accounted_dr ELSE 0 END) 财务费用4
     ,SUM(CASE WHEN A.segment4 = '7580' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7580' THEN B.accounted_dr ELSE 0 END) 财务费用5

     ,SUM(CASE WHEN A.segment4 = '5301' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '5301' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END) 资产减值损失

     ,SUM(CASE WHEN A.segment4 = '7121' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7121' THEN B.accounted_dr ELSE 0 END) 投资收益

     ,SUM(CASE WHEN A.segment4 = '7100' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7100' THEN B.accounted_dr ELSE 0 END) 加_营业外收入1
     ,SUM(CASE WHEN A.segment4 between '7131' and '7241' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '7131' and '7241' THEN B.accounted_dr ELSE 0 END) 加_营业外收入2
     ,0 - (SUM(CASE WHEN A.segment4 = '7161' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7161' THEN B.accounted_dr ELSE 0 END)) 加_营业外收入3

     ,SUM(CASE WHEN A.segment4 between '7520' and '7550' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '7520' and '7550' THEN B.accounted_dr ELSE 0 END) 减_营业外支出1
     ,SUM(CASE WHEN A.segment4 between '7600' and '7610' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '7600' and '7610' THEN B.accounted_dr ELSE 0 END) 减_营业外支出2
     ,SUM(CASE WHEN A.segment4 = '7690' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '7690' THEN B.accounted_dr ELSE 0 END) 减_营业外支出3

     ,SUM(CASE WHEN A.segment4 between '8111' and '8112' THEN B.accounted_cr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '8111' and '8112' THEN B.accounted_dr ELSE 0 END) 减_所得税费用

  from apps.gl_code_combinations A
    ,apps.gl_je_lines B
  where A.CODE_COMBINATION_id = B.CODE_COMBINATION_id
   and B.LEDGER_ID ='2066'
   AND to_char(B.EFFECTIVE_DATE,'YYYY-MM') = 'thismonth')