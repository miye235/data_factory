#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 利润表
##################
SQL_NAME = "profit_statement"


class ProfitStatement(BASE):

    def __init__(self):
        super(ProfitStatement, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
