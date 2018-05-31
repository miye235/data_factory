#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 出货统计
##################
SQL_NAME = "shipment_statistics"


class ShipmentStatistics(BASE):

    def __init__(self):
        super(ShipmentStatistics, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
