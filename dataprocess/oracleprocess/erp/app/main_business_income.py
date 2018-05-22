#!/usr/bin/python
# -*- coding: UTF-8 -*-


import os

from ..base import BASE


################
#  主营业务收入
################
SQL_NAME = "main_business_income"


class MainBusinessIncome(BASE):

    def __init__(self):
        super(MainBusinessIncome, self).__init__(SQL_NAME)

    def __call__(self):
        os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
        data = self.get_remote_db_data()
        return data
