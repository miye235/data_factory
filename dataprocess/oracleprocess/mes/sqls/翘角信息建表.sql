CREATE TABLE qiaojiao_mess (
`tid` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
`DATA` varchar(100),
`PARAMETER` varchar(100),
`SAMPLESEQ` varchar(100),
`OPERATION` varchar(100),
`LOT` varchar(100),
PRIMARY KEY (`tid`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARSET = utf8;