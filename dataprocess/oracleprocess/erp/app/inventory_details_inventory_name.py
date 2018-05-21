#!/usr/bin/python
# -*- coding: UTF-8 -*-


import os

from ..base import BASE


##################
# 存货明细-存货名称
##################
SQL_NAME = "inventory_details_inventory_name"


class InventoryDetailsInventoryName(BASE):

    def __init__(self):
        super(InventoryDetailsInventoryName, self).__init__(SQL_NAME)

    def _update_data(self, data):
        data.rename(columns={"ITEM_NUMBER": "物料编码",
                             "DESCRIPTION": "物料名称"},
                    inplace=True)

    def __call__(self):
        os.environ['NLS_LANG'] = ''
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
