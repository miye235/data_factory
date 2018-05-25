#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


##################
# 固定资产
##################
SQL_NAME = "permanent_assets"


class PermanentAssets(BASE):

    def __init__(self):
        super(PermanentAssets, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
