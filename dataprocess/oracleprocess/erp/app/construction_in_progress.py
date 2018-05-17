#!/usr/bin/python
# -*- coding: UTF-8 -*-


from ..base import BASE


################
#  在建工程
################
SQL_NAME = "construction_in_progress"


class ConstructionInProgress(BASE):

    def __init__(self):
        super(ConstructionInProgress, self).__init__(SQL_NAME)

    def __call__(self):
        data = self.get_remote_db_data()
        return data
