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

    def _update_data(self, data):
        data.rename(columns={"TRX_DATE_CN": "年月",
                             "CUSTOMER_NAME_CN": "客商名称",
                             "EXTENDED_AMOUNT_CN": "金额",
                             "UOM_CODE_CN": "计量单位",
                             "DESCRIPTION_CN": "商品名称",
                             "QUANTITY_INVOICED_CN": "出货数量",
                             "QUANTITY_CREDITED_CN": "面积"},
                    inplace=True)

    def __call__(self):
        os.environ['NLS_LANG'] = ''
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
