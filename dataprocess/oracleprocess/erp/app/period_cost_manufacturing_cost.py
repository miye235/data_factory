#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 期间费用-制造费用
##################
SQL_NAME = "period_cost_manufacturing_cost"


class PeriodCostManufacturingCost(BASE):

    def __init__(self):
        super(PeriodCostManufacturingCost, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
