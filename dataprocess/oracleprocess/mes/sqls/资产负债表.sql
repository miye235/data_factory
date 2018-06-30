select
货币资金
,应收票据
,应收账款
,预付款项1+预付款项2+预付款项3+预付款项4+预付款项5 预付款项
,应收利息1+应收利息2+应收利息3 应收利息
,其他应收账款1+其他应收账款2+其他应收账款3+其他应收账款4+其他应收账款5+其他应收账款6+其他应收账款7 其他应收账款
,存货
,原材料1+原材料2+原材料3+原材料4 原材料
,库存商品_产成品
,库存商品_半成品
,其他流动资产1+其他流动资产2+其他流动资产3+其他流动资产4+其他流动资产5+其他流动资产6+其他流动资产7 其他流动资产
,可供出售金融资产
,长期股权投资
,固定资产原值1+固定资产原值2+固定资产原值3+固定资产原值4+固定资产原值5+固定资产原值6+固定资产原值7+固定资产原值8+固定资产原值9+固定资产原值10+固定资产原值11 固定资产原值
,减_累计折旧1+减_累计折旧2+减_累计折旧3+减_累计折旧4+减_累计折旧5+减_累计折旧6+减_累计折旧7+减_累计折旧8+减_累计折旧9 减_累计折旧
,在建工程1+在建工程2 在建工程
,无形资产1+无形资产2 无形资产
,长期待摊费用1+长期待摊费用2 长期待摊费用
,递延所得税资产1+递延所得税资产2+递延所得税资产3 递延所得税资产
,短期借款
,应付票据1+应付票据2 应付票据
,应付账款1+应付账款2+应付账款3+应付账款4 应付账款
,预收账款
,应付职工薪酬1+应付职工薪酬2+应付职工薪酬3+应付职工薪酬4+应付职工薪酬5+应付职工薪酬6+应付职工薪酬7 应付职工薪酬
,应交税费1+应交税费2+应交税费3+应交税费4+应交税费5 应交税费
,其中_应交税金1+其中_应交税金2+其中_应交税金3+其中_应交税金4+其中_应交税金5 其中_应交税金
,应付利息1+应付利息2+应付利息3+应付利息4 应付利息
,其他应付款1+其他应付款2+其他应付款3+其他应付款4+其他应付款5+其他应付款6+其他应付款7+其他应付款8+其他应付款9+其他应付款10+其他应付款11+其他应付款13+其他应付款14+其他应付款15+其他应付款16+其他应付款17+其他应付款18 其他应付款
,其他流动负债
,长期借款
,递延所得税负债1+递延所得税负债2 递延所得税负债
,实收资本
,资本公积
,专项储备
,盈余公积1+盈余公积2 盈余公积
,其中_法定公积金
,未分配利润1+未分配利润2+未分配利润3+未分配利润4 未分配利润
from 	(select SUM(CASE WHEN A.segment4 between '1101' and '1118' AND A.segment4 <> '1115' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1101' and '1118' AND A.segment4 <> '1115' THEN B.accounted_cr ELSE 0 END) 货币资金

					,SUM(CASE WHEN A.segment4 between '1131' and '1133' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1131' and '1133' THEN B.accounted_cr ELSE 0 END) 应收票据
					,SUM(CASE WHEN A.segment4 between '1151' and '1152' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1151' and '1152' THEN B.accounted_cr ELSE 0 END) 应收账款

					,SUM(CASE WHEN A.segment4 = '1241' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1241' THEN B.accounted_cr ELSE 0 END) 预付款项1
					,SUM(CASE WHEN A.segment4 between '1261' and '1262' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1261' and '1262' THEN B.accounted_cr ELSE 0 END) 预付款项2
					,SUM(CASE WHEN A.segment4 = '1269' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1269' THEN B.accounted_cr ELSE 0 END) 预付款项3
					,SUM(CASE WHEN A.segment4 = '1281' and A.segment6 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1281' and A.segment6 = '190' THEN B.accounted_cr ELSE 0 END) 预付款项4
					,SUM(CASE WHEN A.segment4 between '1641' and '1651' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1641' and '1651' THEN B.accounted_cr ELSE 0 END) 预付款项5

					,SUM(CASE WHEN A.segment4 = '1153' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1153' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END) 应收利息1
					,SUM(CASE WHEN A.segment4 = '1155' and A.segment6 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1155' and A.segment6 = '000' THEN B.accounted_cr ELSE 0 END) 应收利息2
					,SUM(CASE WHEN A.segment4 = '1155' and A.segment6 = '100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1155' and A.segment6 = '100' THEN B.accounted_cr ELSE 0 END) 应收利息3

					,SUM(CASE WHEN A.segment4 = '1153' and A.segment6 between '000' and '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1153' and A.segment6 between '000' and '130' THEN B.accounted_cr ELSE 0 END) 其他应收账款1
					,SUM(CASE WHEN A.segment4 = '1153' and A.segment6 = '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1153' and A.segment6 = '150' THEN B.accounted_cr ELSE 0 END) 其他应收账款2
					,SUM(CASE WHEN A.segment4 = '1154' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1154' THEN B.accounted_cr ELSE 0 END) 其他应收账款3
					,SUM(CASE WHEN A.segment4 = '1263' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1263' THEN B.accounted_cr ELSE 0 END) 其他应收账款4
					,SUM(CASE WHEN A.segment4 = '1281' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1281' THEN B.accounted_cr ELSE 0 END) 其他应收账款5
					,0 - (SUM(CASE WHEN A.segment4 = '1281' and A.segment6 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1281' and A.segment6 = '190' THEN B.accounted_cr ELSE 0 END)) 其他应收账款6
					,SUM(CASE WHEN A.segment4 = '1920' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1920' THEN B.accounted_cr ELSE 0 END) 其他应收账款7

					,SUM(CASE WHEN A.segment4 between '1210' and '1222' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1210' and '1222' THEN B.accounted_cr ELSE 0 END) 存货

					,SUM(CASE WHEN A.segment4 = '1211' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1211' THEN B.accounted_cr ELSE 0 END) 原材料1
					,SUM(CASE WHEN A.segment4 = '1216' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1216' THEN B.accounted_cr ELSE 0 END) 原材料2
					,SUM(CASE WHEN A.segment4 = '1217' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1217' THEN B.accounted_cr ELSE 0 END) 原材料3
					,SUM(CASE WHEN A.segment4 = '1220' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1220' THEN B.accounted_cr ELSE 0 END) 原材料4

					,SUM(CASE WHEN A.segment4 = '1214' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1214' THEN B.accounted_cr ELSE 0 END) 库存商品_产成品

					,SUM(CASE WHEN A.segment4 = '1213' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1213' THEN B.accounted_cr ELSE 0 END) 库存商品_半成品

					,SUM(CASE WHEN A.segment4 = '1251' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1251' THEN B.accounted_cr ELSE 0 END) 其他流动资产1
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '110' and '113' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '110' and '113' THEN B.accounted_cr ELSE 0 END) 其他流动资产2
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '120' THEN B.accounted_cr ELSE 0 END) 其他流动资产3
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '130' THEN B.accounted_cr ELSE 0 END) 其他流动资产4
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END) 其他流动资产5
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '160' THEN B.accounted_cr ELSE 0 END) 其他流动资产6
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '200' THEN B.accounted_cr ELSE 0 END) 其他流动资产7

					,SUM(CASE WHEN A.segment4 = '1123' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1123' THEN B.accounted_cr ELSE 0 END) 可供出售金融资产

					,SUM(CASE WHEN A.segment4 = '1420' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1420' THEN B.accounted_cr ELSE 0 END) 长期股权投资

					,SUM(CASE WHEN A.segment4 = '1511' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1511' THEN B.accounted_cr ELSE 0 END) 固定资产原值1
					,SUM(CASE WHEN A.segment4 = '1515' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1515' THEN B.accounted_cr ELSE 0 END) 固定资产原值2
					,SUM(CASE WHEN A.segment4 = '1519' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1519' THEN B.accounted_cr ELSE 0 END) 固定资产原值3
					,SUM(CASE WHEN A.segment4 = '1523' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1523' THEN B.accounted_cr ELSE 0 END) 固定资产原值4
					,SUM(CASE WHEN A.segment4 = '1527' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1527' THEN B.accounted_cr ELSE 0 END) 固定资产原值5
					,SUM(CASE WHEN A.segment4 = '1531' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1531' THEN B.accounted_cr ELSE 0 END) 固定资产原值6
					,SUM(CASE WHEN A.segment4 = '1535' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1535' THEN B.accounted_cr ELSE 0 END) 固定资产原值7
					,SUM(CASE WHEN A.segment4 = '1539' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1539' THEN B.accounted_cr ELSE 0 END) 固定资产原值8
					,SUM(CASE WHEN A.segment4 = '1543' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1543' THEN B.accounted_cr ELSE 0 END) 固定资产原值9
					,SUM(CASE WHEN A.segment4 = '1547' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1547' THEN B.accounted_cr ELSE 0 END) 固定资产原值10
					,SUM(CASE WHEN A.segment4 = '1559' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1559' THEN B.accounted_cr ELSE 0 END) 固定资产原值11

					,SUM(CASE WHEN A.segment4 = '1513' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1513' THEN B.accounted_cr ELSE 0 END) 减_累计折旧1
					,SUM(CASE WHEN A.segment4 = '1517' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1517' THEN B.accounted_cr ELSE 0 END) 减_累计折旧2
					,SUM(CASE WHEN A.segment4 = '1521' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1521' THEN B.accounted_cr ELSE 0 END) 减_累计折旧3
					,SUM(CASE WHEN A.segment4 = '1525' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1525' THEN B.accounted_cr ELSE 0 END) 减_累计折旧4
					,SUM(CASE WHEN A.segment4 = '1529' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1529' THEN B.accounted_cr ELSE 0 END) 减_累计折旧5
					,SUM(CASE WHEN A.segment4 = '1533' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1533' THEN B.accounted_cr ELSE 0 END) 减_累计折旧6
					,SUM(CASE WHEN A.segment4 = '1537' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1537' THEN B.accounted_cr ELSE 0 END) 减_累计折旧7
					,SUM(CASE WHEN A.segment4 = '1541' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1541' THEN B.accounted_cr ELSE 0 END) 减_累计折旧8
					,SUM(CASE WHEN A.segment4 = '1549' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1549' THEN B.accounted_cr ELSE 0 END) 减_累计折旧9

					,SUM(CASE WHEN A.segment4 between '1661' and '1663' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1661' and '1663' THEN B.accounted_cr ELSE 0 END) 在建工程1
					,SUM(CASE WHEN A.segment4 = '1671' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1671' THEN B.accounted_cr ELSE 0 END) 在建工程2

					,SUM(CASE WHEN A.segment4 between '1700' and '1701' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1700' and '1701' THEN B.accounted_cr ELSE 0 END) 无形资产1
					,SUM(CASE WHEN A.segment4 = '1790' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1790' THEN B.accounted_cr ELSE 0 END) 无形资产2

					,SUM(CASE WHEN A.segment4 between '1930' and '1940' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '1930' and '1940' THEN B.accounted_cr ELSE 0 END) 长期待摊费用1
					,SUM(CASE WHEN A.segment4 = '1980' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1980' THEN B.accounted_cr ELSE 0 END) 长期待摊费用2

					,SUM(CASE WHEN A.segment4 = '1282' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1282' THEN B.accounted_cr ELSE 0 END) 递延所得税资产1
					,SUM(CASE WHEN A.segment4 = '1970' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1970' THEN B.accounted_cr ELSE 0 END) 递延所得税资产2
					,SUM(CASE WHEN A.segment4 = '1990' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '1990' THEN B.accounted_cr ELSE 0 END) 递延所得税资产3

					,SUM(CASE WHEN A.segment4 = '2101' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2101' THEN B.accounted_cr ELSE 0 END) 短期借款

					,SUM(CASE WHEN A.segment4 = '2121' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2121' THEN B.accounted_cr ELSE 0 END) 应付票据1
					,SUM(CASE WHEN A.segment4 = '2123' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2123' THEN B.accounted_cr ELSE 0 END) 应付票据2

					,SUM(CASE WHEN A.segment4 = '2131' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2131' THEN B.accounted_cr ELSE 0 END) 应付账款1
					,SUM(CASE WHEN A.segment4 = '2132' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2132' THEN B.accounted_cr ELSE 0 END) 应付账款2
					,SUM(CASE WHEN A.segment4 = '2151' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2151' THEN B.accounted_cr ELSE 0 END) 应付账款3
					,SUM(CASE WHEN A.segment4 = '2152' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2152' THEN B.accounted_cr ELSE 0 END) 应付账款4

					,SUM(CASE WHEN A.segment4 = '2245' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2245' THEN B.accounted_cr ELSE 0 END) 预收账款

					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 between '110' and '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 between '110' and '130' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬1
					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '180' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '180' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬2
					,SUM(CASE WHEN A.segment4 = '2182' and A.segment6 between '110' and '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2182' and A.segment6 between '110' and '140' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬3
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '110' and '111' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '110' and '111' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬4
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '180' and '185' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '180' and '185' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬5
					,SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '110' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '110' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬6
					,SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END) 应付职工薪酬7

					,SUM(CASE WHEN A.segment4 between '2171' and '2172' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '2171' and '2172' THEN B.accounted_cr ELSE 0 END) 应交税费1
					,0 - (SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '110' and '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '110' and '120' THEN B.accounted_cr ELSE 0 END)) 应交税费2
					,0 - (SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '130' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '130' THEN B.accounted_cr ELSE 0 END)) 应交税费3
					,0 - (SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '140' and '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 between '140' and '160' THEN B.accounted_cr ELSE 0 END)) 应交税费4
					,0 - (SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '200' THEN B.accounted_cr ELSE 0 END)) 应交税费5

					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '160' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '160' THEN B.accounted_cr ELSE 0 END) 其中_应交税金1
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '170' THEN B.accounted_cr ELSE 0 END) 其中_应交税金2
					,SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2171' and A.segment6 = '190' THEN B.accounted_cr ELSE 0 END) 其中_应交税金3
					,SUM(CASE WHEN A.segment4 = '2172' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2172' THEN B.accounted_cr ELSE 0 END) 其中_应交税金4
					,SUM(CASE WHEN A.segment4 = '2172' and A.segment6 = 'A10' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2172' and A.segment6 = 'A10' THEN B.accounted_cr ELSE 0 END) 其中_应交税金5

					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '150' THEN B.accounted_cr ELSE 0 END) 应付利息1
					,SUM(CASE WHEN A.segment4 = '2183' and A.segment6 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2183' and A.segment6 = '000' THEN B.accounted_cr ELSE 0 END) 应付利息2
					,SUM(CASE WHEN A.segment4 = '2183' and A.segment6 = '100' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2183' and A.segment6 = '100' THEN B.accounted_cr ELSE 0 END) 应付利息3
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '120' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '120' THEN B.accounted_cr ELSE 0 END) 应付利息4

					,SUM(CASE WHEN A.segment4 = '2141' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2141' THEN B.accounted_cr ELSE 0 END) 其他应付款1
					,SUM(CASE WHEN A.segment4 = '2142' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2142' THEN B.accounted_cr ELSE 0 END) 其他应付款2
					,SUM(CASE WHEN A.segment4 = '2143' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2143' THEN B.accounted_cr ELSE 0 END) 其他应付款3
					,SUM(CASE WHEN A.segment4 = '2161' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2161' THEN B.accounted_cr ELSE 0 END) 其他应付款4
					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '000' THEN B.accounted_cr ELSE 0 END) 其他应付款5
					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 between '140' and '170' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 between '140' and '170' THEN B.accounted_cr ELSE 0 END) 其他应付款6
					,SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2181' and A.segment6 = '190' THEN B.accounted_cr ELSE 0 END) 其他应付款7
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '000' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '000' THEN B.accounted_cr ELSE 0 END) 其他应付款8
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '130' and '170' THEN B.accounted_dr END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 between '130' and '170' THEN B.accounted_cr END) 其他应付款9
					,SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '190' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2191' and A.segment6 = '190' THEN B.accounted_cr ELSE 0 END) 其他应付款10
					,SUM(CASE WHEN A.segment4 between '2235' and '2243' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '2235' and '2243' THEN B.accounted_cr ELSE 0 END) 其他应付款11
					,SUM(CASE WHEN A.segment4 = '2251' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2251' THEN B.accounted_cr ELSE 0 END) 其他应付款13
					,SUM(CASE WHEN A.segment4 = '2253' and A.segment6 between '000' and '150' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2253' and A.segment6 between '000' and '150' THEN B.accounted_cr ELSE 0 END) 其他应付款14
					,SUM(CASE WHEN A.segment4 = '2255' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2255' THEN B.accounted_cr ELSE 0 END) 其他应付款15
					,0 - (SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '110' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '110' THEN B.accounted_cr ELSE 0 END)) 其他应付款16
					,0 - (SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '140' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2255' and A.segment6 = '140' THEN B.accounted_cr ELSE 0 END)) 其他应付款17
					,SUM(CASE WHEN A.segment4 = '2821' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2821' THEN B.accounted_cr ELSE 0 END) 其他应付款18

					,SUM(CASE WHEN A.segment4 = '2252' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2252' THEN B.accounted_cr ELSE 0 END) 其他流动负债

					,SUM(CASE WHEN A.segment4 = '2401' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2401' THEN B.accounted_cr ELSE 0 END) 长期借款

					,SUM(CASE WHEN A.segment4 = '2281' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2281' THEN B.accounted_cr ELSE 0 END) 递延所得税负债1
					,SUM(CASE WHEN A.segment4 = '2851' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '2851' THEN B.accounted_cr ELSE 0 END) 递延所得税负债2

					,SUM(CASE WHEN A.segment4 = '3111' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3111' THEN B.accounted_cr ELSE 0 END) 实收资本

					,SUM(CASE WHEN A.segment4 = '3200' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3200' THEN B.accounted_cr ELSE 0 END) 资本公积

					,SUM(CASE WHEN A.segment4 = '3320' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3320' THEN B.accounted_cr ELSE 0 END) 专项储备

					,SUM(CASE WHEN A.segment4 = '3300' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3300' THEN B.accounted_cr ELSE 0 END) 盈余公积1
					,SUM(CASE WHEN A.segment4 = '3310' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3310' THEN B.accounted_cr ELSE 0 END) 盈余公积2

					,SUM(CASE WHEN A.segment4 = '3310' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3310' THEN B.accounted_cr ELSE 0 END) 其中_法定公积金

					,SUM(CASE WHEN A.segment4 = '3351' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3351' THEN B.accounted_cr ELSE 0 END) 未分配利润1
					,SUM(CASE WHEN A.segment4 = '3352' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3352' THEN B.accounted_cr ELSE 0 END) 未分配利润2
					,SUM(CASE WHEN A.segment4 = '3353' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 = '3353' THEN B.accounted_cr ELSE 0 END) 未分配利润3
					,SUM(CASE WHEN A.segment4 between '5110' and '8112' THEN B.accounted_dr ELSE 0 END)-SUM(CASE WHEN A.segment4 between '5110' and '8112' THEN B.accounted_cr ELSE 0 END) 未分配利润4
			from apps.gl_code_combinations A
					,apps.gl_je_lines B
			where A.CODE_COMBINATION_id = B.CODE_COMBINATION_id
			and B.LEDGER_ID = '2066'
				AND to_char(B.EFFECTIVE_DATE,'YYYY-MM') <= 'thismonth')