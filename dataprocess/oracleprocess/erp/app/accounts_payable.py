#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
# 应付账款
################
SQL_NAME = "accounts_payable"


class AccountsPayable(BASE):

    def __init__(self):
        super(AccountsPayable, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
