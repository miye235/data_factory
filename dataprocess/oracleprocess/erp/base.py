#!/usr/bin/python
# -*- coding: UTF-8 -*-


from common.DbCommon import oracle2pd


################
#  基本功能
################


ORACLE_HOST = "10.232.1.101"
ORACLE_PORT = "1521"
ORACLE_DB = "KSERP"
ORACLE_USER = "BDATA"
ORACLE_PWD = "BDATA"

SQL_FILE_ROOT = "dataprocess/oracleprocess/erp/sqls/"
SQL_FILE_NAME = [
    "accounts_payable_aging",
    "accounts_receivable",
    "amount_of_temporary_assessment_payable",
    "construction_in_progress",
    "expenses_for_the_period",
    "inventory_details_interim_inventory",
    "inventory_details_into_the_consumption",
    "inventory_details_inventory_name",
    "inventory_details_work_in_progress",
    "main_business_cost",
    "main_business_income",
]


class BASE(object):

    def __init__(self, sql_name):
        super(BASE, self).__init__()
        self.sql_name = sql_name

    def _get_sql(self):
        if self.sql_name in SQL_FILE_NAME:
            path = SQL_FILE_ROOT + self.sql_name + ".sql"
            with open(path, "r") as fr:
                sql = fr.read()
                return sql
        else:
            return None

    def get_remote_db_data(self):
        sql = self._get_sql()
        odb = oracle2pd(ORACLE_HOST, ORACLE_PORT, ORACLE_DB,
                        ORACLE_USER, ORACLE_PWD)
        data = odb.doget(sql)
        return data
