#!/usr/bin/python
# -*- coding: UTF-8 -*-


################
#  基本参数
################


SQL_FILE_PATH = {
    "main_business_cost": "./sqls/main_business_cost.sql",
}


class BASE_TOOLS(object):

    def __init__(self):
        super(BASE_TOOLS, self).__init__()

    def get_sql(self, sql_name):
        if SQL_FILE_PATH.has_key(sql_name):
            pass
        else:
            return None
