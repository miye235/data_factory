select SUM(CASE WHEN A.segment3 between '1101' and '1118' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1101' and '1118' THEN B.accounted_cr ELSE 0 END) 货币资金

		,SUM(CASE WHEN A.segment3 between '1131' and '1133' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1131' and '1133' THEN B.accounted_cr ELSE 0 END) 应收票据
		,SUM(CASE WHEN A.segment3 between '1151' and '1152' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1151' and '1152' THEN B.accounted_cr ELSE 0 END) 应收账款

		,SUM(CASE WHEN A.segment3 = '1241' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1241' THEN B.accounted_cr ELSE 0 END) 预付款项1
		,SUM(CASE WHEN A.segment3 between '1261' and '1262' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1261' and '1262' THEN B.accounted_cr ELSE 0 END) 预付款项2
		,SUM(CASE WHEN A.segment3 = '1269' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1269' THEN B.accounted_cr ELSE 0 END) 预付款项3
		,SUM(CASE WHEN A.segment3 = '1281' and A.segment4 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1281' and A.segment4 = '190' THEN B.accounted_cr ELSE 0 END) 预付款项4
		,SUM(CASE WHEN A.segment3 between '1641' and '1651' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1641' and '1651' THEN B.accounted_cr ELSE 0 END) 预付款项5

		,SUM(CASE WHEN A.segment3 = '1153' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1153' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 应收利息1
		,SUM(CASE WHEN A.segment3 = '1155' and A.segment4 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1155' and A.segment4 = '000' THEN B.accounted_cr ELSE 0 END) 预付款项2
		,SUM(CASE WHEN A.segment3 = '1155' and A.segment4 = '100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1155' and A.segment4 = '100' THEN B.accounted_cr ELSE 0 END) 预付款项3

		,SUM(CASE WHEN A.segment3 = '1153' and A.segment4 between '000' and '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1153' and A.segment4 between '000' and '130' THEN B.accounted_cr ELSE 0 END) 其他应收账款1
		,SUM(CASE WHEN A.segment3 = '1153' and A.segment4 = '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1153' and A.segment4 = '150' THEN B.accounted_cr ELSE 0 END) 其他应收账款2
		,SUM(CASE WHEN A.segment3 = '1154' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1154' THEN B.accounted_cr ELSE 0 END) 其他应收账款3
		,SUM(CASE WHEN A.segment3 = '1263' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1263' THEN B.accounted_cr ELSE 0 END) 其他应收账款4
		,SUM(CASE WHEN A.segment3 = '1281' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1281' THEN B.accounted_cr ELSE 0 END) 其他应收账款5
		,0 - SUM(CASE WHEN A.segment3 = '1281' and A.segment4 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1281' and A.segment4 = '190' THEN B.accounted_cr ELSE 0 END) 其他应收账款6
		,SUM(CASE WHEN A.segment3 = '1920' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1920' THEN B.accounted_cr ELSE 0 END) 其他应收账款7

		,SUM(CASE WHEN A.segment3 between '1210' and '1222' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1210' and '1222' THEN B.accounted_cr ELSE 0 END) 存货

		,SUM(CASE WHEN A.segment3 = '1211' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1211' THEN B.accounted_cr ELSE 0 END) 原材料1
		,SUM(CASE WHEN A.segment3 = '1216' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1216' THEN B.accounted_cr ELSE 0 END) 原材料2
		,SUM(CASE WHEN A.segment3 = '1217' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1217' THEN B.accounted_cr ELSE 0 END) 原材料3
		,SUM(CASE WHEN A.segment3 = '1220' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1220' THEN B.accounted_cr ELSE 0 END) 原材料4

		,SUM(CASE WHEN A.segment3 = '1214' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1214' THEN B.accounted_cr ELSE 0 END) 库存商品_产成品

		,SUM(CASE WHEN A.segment3 = '1213' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1213' THEN B.accounted_cr ELSE 0 END) 库存商品_半成品

		,SUM(CASE WHEN A.segment3 = '1251' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1251' THEN B.accounted_cr ELSE 0 END) 其他流动资产1
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '110' and '113' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '110' and '113' THEN B.accounted_cr ELSE 0 END) 其他流动资产2
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '120' THEN B.accounted_cr ELSE 0 END) 其他流动资产3
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '130' THEN B.accounted_cr ELSE 0 END) 其他流动资产4
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 其他流动资产5
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '160' THEN B.accounted_cr ELSE 0 END) 其他流动资产6
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '200' THEN B.accounted_cr ELSE 0 END) 其他流动资产7

		,SUM(CASE WHEN A.segment3 = '1123' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1123' THEN B.accounted_cr ELSE 0 END) 可供出售金融资产

		,SUM(CASE WHEN A.segment3 = '1420' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1420' THEN B.accounted_cr ELSE 0 END) 长期股权投资

		,SUM(CASE WHEN A.segment3 = '1511' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1511' THEN B.accounted_cr ELSE 0 END) 固定资产原值1
		,SUM(CASE WHEN A.segment3 = '1515' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1515' THEN B.accounted_cr ELSE 0 END) 固定资产原值2
		,SUM(CASE WHEN A.segment3 = '1519' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1519' THEN B.accounted_cr ELSE 0 END) 固定资产原值3
		,SUM(CASE WHEN A.segment3 = '1523' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1523' THEN B.accounted_cr ELSE 0 END) 固定资产原值4
		,SUM(CASE WHEN A.segment3 = '1527' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1527' THEN B.accounted_cr ELSE 0 END) 固定资产原值5
		,SUM(CASE WHEN A.segment3 = '1531' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1531' THEN B.accounted_cr ELSE 0 END) 固定资产原值6
		,SUM(CASE WHEN A.segment3 = '1535' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1535' THEN B.accounted_cr ELSE 0 END) 固定资产原值7
		,SUM(CASE WHEN A.segment3 = '1539' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1539' THEN B.accounted_cr ELSE 0 END) 固定资产原值8
		,SUM(CASE WHEN A.segment3 = '1543' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1543' THEN B.accounted_cr ELSE 0 END) 固定资产原值9
		,SUM(CASE WHEN A.segment3 = '1547' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1547' THEN B.accounted_cr ELSE 0 END) 固定资产原值10
		,SUM(CASE WHEN A.segment3 = '1559' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1559' THEN B.accounted_cr ELSE 0 END) 固定资产原值11

		,SUM(CASE WHEN A.segment3 = '1513' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1513' THEN B.accounted_cr ELSE 0 END) 减_累计折旧1
		,SUM(CASE WHEN A.segment3 = '1517' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1517' THEN B.accounted_cr ELSE 0 END) 减_累计折旧2
		,SUM(CASE WHEN A.segment3 = '1521' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1521' THEN B.accounted_cr ELSE 0 END) 减_累计折旧3
		,SUM(CASE WHEN A.segment3 = '1525' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1525' THEN B.accounted_cr ELSE 0 END) 减_累计折旧4
		,SUM(CASE WHEN A.segment3 = '1529' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1529' THEN B.accounted_cr ELSE 0 END) 减_累计折旧5
		,SUM(CASE WHEN A.segment3 = '1533' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1533' THEN B.accounted_cr ELSE 0 END) 减_累计折旧6
		,SUM(CASE WHEN A.segment3 = '1537' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1537' THEN B.accounted_cr ELSE 0 END) 减_累计折旧7
		,SUM(CASE WHEN A.segment3 = '1541' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1541' THEN B.accounted_cr ELSE 0 END) 减_累计折旧8
		,SUM(CASE WHEN A.segment3 = '1549' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1549' THEN B.accounted_cr ELSE 0 END) 减_累计折旧9

		,SUM(CASE WHEN A.segment3 between '1661' and '1663' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1661' and '1663' THEN B.accounted_cr ELSE 0 END) 在建工程1
		,SUM(CASE WHEN A.segment3 = '1671' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1671' THEN B.accounted_cr ELSE 0 END) 在建工程2

		,SUM(CASE WHEN A.segment3 between '1700' and '1701' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1700' and '1701' THEN B.accounted_cr ELSE 0 END) 无形资产1
		,SUM(CASE WHEN A.segment3 = '1790' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1790' THEN B.accounted_cr ELSE 0 END) 无形资产2

		,SUM(CASE WHEN A.segment3 between '1930' and '1940' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '1930' and '1940' THEN B.accounted_cr ELSE 0 END) 长期待摊费用1
		,SUM(CASE WHEN A.segment3 = '1980' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1980' THEN B.accounted_cr ELSE 0 END) 长期待摊费用2

		,SUM(CASE WHEN A.segment3 = '1282' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1282' THEN B.accounted_cr ELSE 0 END) 递延所得税资产1
		,SUM(CASE WHEN A.segment3 = '1970' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1970' THEN B.accounted_cr ELSE 0 END) 递延所得税资产2
		,SUM(CASE WHEN A.segment3 = '1990' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '1990' THEN B.accounted_cr ELSE 0 END) 递延所得税资产3

		,SUM(CASE WHEN A.segment3 = '2101' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2101' THEN B.accounted_cr ELSE 0 END) 短期借款

		,SUM(CASE WHEN A.segment3 = '2121' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2121' THEN B.accounted_cr ELSE 0 END) 应付票据1
		,SUM(CASE WHEN A.segment3 = '2123' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2123' THEN B.accounted_cr ELSE 0 END) 应付票据2

		,SUM(CASE WHEN A.segment3 = '2131' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2131' THEN B.accounted_cr ELSE 0 END) 应付账款1
		,SUM(CASE WHEN A.segment3 = '2132' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2132' THEN B.accounted_cr ELSE 0 END) 应付账款2
		,SUM(CASE WHEN A.segment3 = '2151' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2151' THEN B.accounted_cr ELSE 0 END) 应付账款3
		,SUM(CASE WHEN A.segment3 = '2152' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2152' THEN B.accounted_cr ELSE 0 END) 应付账款4

		,SUM(CASE WHEN A.segment3 = '2245' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2245' THEN B.accounted_cr ELSE 0 END) 预收账款

		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 between '110' and '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 between '110' and '130' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬1
		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '180' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '180' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬2
		,SUM(CASE WHEN A.segment3 = '2182' and A.segment4 between '110' and '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2182' and A.segment4 between '110' and '140' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬3
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 between '110' and '111' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2191' and A.segment4 between '110' and '111' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬4
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 between '180' and '185' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2191' and A.segment4 between '180' and '185' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬5
		,SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '110' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '110' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬6
		,SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬7

		,SUM(CASE WHEN A.segment3 between '2171' and '2172' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '2171' and '2172' THEN B.accounted_cr ELSE 0 END) 应交税费1
		,0 - SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '110' and '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '110' and '120' THEN B.accounted_cr ELSE 0 END) 应交税费2
		,0 - SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '130' THEN B.accounted_cr ELSE 0 END) 应交税费3
		,0 - SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '140' and '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 between '140' and '160' THEN B.accounted_cr ELSE 0 END) 应交税费4
		,0 - SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '200' THEN B.accounted_cr ELSE 0 END) 应交税费5

		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '160' THEN B.accounted_cr ELSE 0 END) 其中_应交税金1
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '170' THEN B.accounted_cr ELSE 0 END) 其中_应交税金2
		,SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2171' and A.segment4 = '190' THEN B.accounted_cr ELSE 0 END) 其中_应交税金3
		,SUM(CASE WHEN A.segment3 = '2172' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2172' THEN B.accounted_cr ELSE 0 END) 其中_应交税金4

		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '150' THEN B.accounted_cr ELSE 0 END) 应付利息1
		,SUM(CASE WHEN A.segment3 = '2183' and A.segment4 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2183' and A.segment4 = '000' THEN B.accounted_cr ELSE 0 END) 应付利息2
		,SUM(CASE WHEN A.segment3 = '2183' and A.segment4 = '100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2183' and A.segment4 = '100' THEN B.accounted_cr ELSE 0 END) 应付利息3
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '120' THEN B.accounted_cr ELSE 0 END) 应付利息4

		,SUM(CASE WHEN A.segment3 = '2141' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2141' THEN B.accounted_cr ELSE 0 END) 其他应付款1
		,SUM(CASE WHEN A.segment3 = '2142' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2142' THEN B.accounted_cr ELSE 0 END) 其他应付款2
		,SUM(CASE WHEN A.segment3 = '2143' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2143' THEN B.accounted_cr ELSE 0 END) 其他应付款3
		,SUM(CASE WHEN A.segment3 = '2161' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2161' THEN B.accounted_cr ELSE 0 END) 其他应付款4
		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '000' THEN B.accounted_cr ELSE 0 END) 其他应付款5
		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 between '140' and '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 between '140' and '170' THEN B.accounted_cr ELSE 0 END) 其他应付款6
		,SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 = '190' THEN B.accounted_cr ELSE 0 END) 其他应付款7
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '000' THEN B.accounted_cr ELSE 0 END) 其他应付款8
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 between '130' and '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2181' and A.segment4 between '130' and '170' THEN B.accounted_cr ELSE 0 END) 其他应付款9
		,SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2191' and A.segment4 = '190' THEN B.accounted_cr ELSE 0 END) 其他应付款10
		,SUM(CASE WHEN A.segment3 between '2235' and '2243' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '2235' and '2243' THEN B.accounted_cr ELSE 0 END) 其他应付款11
		,SUM(CASE WHEN A.segment3 = '2241' and A.segment4 = '100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2241' and A.segment4 = '100' THEN B.accounted_cr ELSE 0 END) 其他应付款12
		,SUM(CASE WHEN A.segment3 = '2251' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2251' THEN B.accounted_cr ELSE 0 END) 其他应付款13
		,SUM(CASE WHEN A.segment3 = '2253' and A.segment4 between '000' and '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2253' and A.segment4 between '000' and '150' THEN B.accounted_cr ELSE 0 END) 其他应付款14
		,SUM(CASE WHEN A.segment3 = '2255' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2255' THEN B.accounted_cr ELSE 0 END) 其他应付款15
		,0 - SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '110' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '110' THEN B.accounted_cr ELSE 0 END) 其他应付款16
		,0 - SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2255' and A.segment4 = '140' THEN B.accounted_cr ELSE 0 END) 其他应付款17
		,SUM(CASE WHEN A.segment3 = '2821' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2821' THEN B.accounted_cr ELSE 0 END) 其他应付款18

		,SUM(CASE WHEN A.segment3 = '2252' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2252' THEN B.accounted_cr ELSE 0 END) 其他流动负债

		,SUM(CASE WHEN A.segment3 = '2401' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2401' THEN B.accounted_cr ELSE 0 END) 长期借款

		,SUM(CASE WHEN A.segment3 = '2281' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2281' THEN B.accounted_cr ELSE 0 END) 递延所得税负债1
		,SUM(CASE WHEN A.segment3 = '2851' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '2851' THEN B.accounted_cr ELSE 0 END) 递延所得税负债2

		,SUM(CASE WHEN A.segment3 = '3111' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3111' THEN B.accounted_cr ELSE 0 END) 实收资本

		,SUM(CASE WHEN A.segment3 = '3200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3200' THEN B.accounted_cr ELSE 0 END) 资本公积

		,SUM(CASE WHEN A.segment3 = '3320' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3320' THEN B.accounted_cr ELSE 0 END) 专项储备

		,SUM(CASE WHEN A.segment3 = '3300' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3300' THEN B.accounted_cr ELSE 0 END) 盈余公积1
		,SUM(CASE WHEN A.segment3 = '3310' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3310' THEN B.accounted_cr ELSE 0 END) 盈余公积2

		,SUM(CASE WHEN A.segment3 = '3310' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3310' THEN B.accounted_cr ELSE 0 END) 其中_法定公积金

		,SUM(CASE WHEN A.segment3 = '3351' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3351' THEN B.accounted_cr ELSE 0 END) 未分配利润1
		,SUM(CASE WHEN A.segment3 = '3352' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3352' THEN B.accounted_cr ELSE 0 END) 未分配利润2
		,SUM(CASE WHEN A.segment3 = '3353' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 = '3353' THEN B.accounted_cr ELSE 0 END) 未分配利润3
		,SUM(CASE WHEN A.segment3 between '5110' and '8112' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment3 between '5110' and '8112' THEN B.accounted_cr ELSE 0 END) 未分配利润4
from apps.gl_code_combinations A
		,apps.gl_je_lines B
where A.CODE_COMBINATION_id = B.CODE_COMBINATION_id
	AND substr(to_char(B.creation_date,'yyyy-mm-dd'),0,7) <= '2018-03'
