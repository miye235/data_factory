#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
# 应收账款
################
SQL_NAME = "accounts_receivable"


class AccountsReceivable(BASE):

    def __init__(self):
        super(AccountsReceivable, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
