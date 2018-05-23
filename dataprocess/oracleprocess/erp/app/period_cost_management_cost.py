#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 期间费用-管理费用
##################
SQL_NAME = "period_cost_management_cost"


class PeriodCostManagementCost(BASE):

    def __init__(self):
        super(PeriodCostManagementCost, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
