#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 存货明细-暂收存货
##################
SQL_NAME = "inventory_details_interim_inventory"


class InventoryDetailsInterimInventory(BASE):

    def __init__(self):
        super(InventoryDetailsInterimInventory, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
