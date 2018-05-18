CREATE TABLE check_mess (
        `tid` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
        `LOT` varchar(100),
        `CHECKTIME` datetime(6),
        PRIMARY KEY (`tid`)
        ) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARSET = utf8;