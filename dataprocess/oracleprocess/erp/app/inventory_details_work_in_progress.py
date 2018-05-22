#!/usr/bin/python
# -*- coding: UTF-8 -*-


import os

from ..base import BASE


######################
# 存货明细-在制品进耗存
######################
SQL_NAME = "inventory_details_work_in_progress"


class InventoryDetailsWorkInProgress(BASE):

    def __init__(self):
        super(InventoryDetailsWorkInProgress, self).__init__(SQL_NAME)

    def _update_data(self, data):
        data.rename(columns={"ITEM_CODE": "物料编码",
                             "TOTALSUMMARY": "综合总计",
                             "WIPQTY": "在制品数量总计"},
                    inplace=True)

    def __call__(self):
        os.environ['NLS_LANG'] = ''
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
