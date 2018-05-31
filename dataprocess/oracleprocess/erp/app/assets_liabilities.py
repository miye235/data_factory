#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 资产负债
##################
SQL_NAME = "assets_liabilities"


class AssetsLiabilities(BASE):

    def __init__(self):
        super(AssetsLiabilities, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
