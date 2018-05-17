#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 存货明细-存货名称
##################
SQL_NAME = "inventory_details_inventory_name"


class InventoryDetailsInventoryName(BASE):

    def __init__(self):
        super(InventoryDetailsInventoryName, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
