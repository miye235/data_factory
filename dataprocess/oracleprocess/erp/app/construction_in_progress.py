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

    def _update_data(self, data):
        data['资本化时间']=[data['DESCRIPTION'][i][1:5] for i in range(len(data))]

    def __call__(self):
        data = self.get_remote_db_data()
        self._update_data(data)
        return data
