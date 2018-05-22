#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 期间费用-销售费用
##################
SQL_NAME = "period_cost_sales_cost"


class PeriodCostSalesCost(BASE):

    def __init__(self):
        super(PeriodCostSalesCost, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
