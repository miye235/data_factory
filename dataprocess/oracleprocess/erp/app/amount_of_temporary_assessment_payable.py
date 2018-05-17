#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
# 应付暂估款
################
SQL_NAME = "amount_of_temporary_assessment_payable"


class AmountOfTemporaryAssessmentPayable(BASE):

    def __init__(self):
        super(AmountOfTemporaryAssessmentPayable, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
