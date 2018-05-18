from common.DbCommon import oracle2pd,mysql2pd

ora=oracle2pd('10.232.101.51','1521','MESDB','BDATA','BDATA')
sql=open('dataprocess/oracleprocess/mes/sqls/原反投入.sql','r').read()
sqlc='''CREATE TABLE `yuanfantouru` (
`tid` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
`uptime` datetime(6) COMMENT '更新时间',
`matno` varchar(20) COMMENT '料号',
`lot` varchar(20) COMMENT '批号 ',`num` int(6) COMMENT '数量',
`formno` varchar(20) COMMENT '工单 ',
PRIMARY KEY (`tid`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARSET = utf8;
'''
# sqld='drop table yuanfantouru'
sqlindex='''
create index timeindex on yuanfantouru(uptime)
'''
ms=mysql2pd('123.59.26.236','33333','mysql','root','Rtsecret')
# ms.dopost(sqld)
# ms.dopost(sqlc)
res=ora.doget(sql)
res.columns=['matno','lot','num','uptime','formno']
ms.write2mysql(res,'yuanfantouru')
# print(ms.dopost(sqlindex))
# ms.getdata('trace_production').to_csv('res.csv')
