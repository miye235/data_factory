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

    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        data = self.get_remote_db_data()
        return data
