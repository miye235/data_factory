#!/usr/bin/python
# -*- coding: UTF-8 -*-


import os

from ..base import BASE


################
# 存货明细-进耗存
################
SQL_NAME = "inventory_details_into_the_consumption"


class InventoryDetailsIntoTheConsumption(BASE):

    def __init__(self):
        super(InventoryDetailsIntoTheConsumption, self).__init__(SQL_NAME)

    def _update_data(self, data):
        data.rename(columns={"ITEM_NUMBER": "物料编码",
                             "ITEM_DESCRIPTION": "物料名称",
                             "END_STK": "结束时股数",
                             "END_AMT": "结束时金额"},
                    inplace=True)

    def __call__(self):
        os.environ['NLS_LANG'] = ''
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
