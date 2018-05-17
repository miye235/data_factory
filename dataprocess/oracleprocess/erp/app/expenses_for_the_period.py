#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
# 期间费用
################
SQL_NAME = "expenses_for_the_period"


class ExpensesForThePeriod(BASE):

    def __init__(self):
        super(ExpensesForThePeriod, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
