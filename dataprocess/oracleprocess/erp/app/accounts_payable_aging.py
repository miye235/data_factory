#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
# 应付账款账龄
################
SQL_NAME = "accounts_payable_aging"


class AccountsPayableAging(BASE):

    def __init__(self):
        super(AccountsPayableAging, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
