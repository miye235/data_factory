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

    def _update_data(self, data):
        data['评价后金额'] = data['本币总计']
        data['评价汇率'] = data['本币总计'].div(data['原币总计'], fill_value=0)
        data['account'] = [1151 for i in range(len(data))]
        data['DIFF'] = [None for i in range(len(data))]

    def __call__(self):
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
