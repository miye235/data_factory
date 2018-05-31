from dataprocess.oracleprocess.mes.base import Base

class QiaoJiaoAll(object):
    def __init__(self):
        super(QiaoJiaoAll, self).__init__()
    def __del__(self):
        self.ms.close()
    def __call__(self):
        sql = '''
        select trace_production.psa_lot AS psa_lot,trace_production.pva_lot AS pva_lot,trace_production.psa_intime AS psa_intime,trace_production.psa_outtime AS psa_outtime,trace_production.pva_intime AS pva_intime,trace_production.pva_outtime AS pva_outtime,trace_production.rtx_intime AS rtx_intime,trace_production.rtx_outtime AS rtx_outtime,trace_production.slt_intime AS slt_intime,trace_production.slt_outtime AS slt_outtime,trace_production.slt_lot AS slt_lot,trace_production.rtx_lot AS hd_lot,qiaojiao_mess.DATA AS DATA,qiaojiao_mess.PARAMETER AS PARAMETER,qiaojiao_mess.SAMPLESEQ AS SAMPLESEQ,qiaojiao_mess.OPERATION AS OPERATION,check_mess.CHECKTIME AS checktime 
        FROM trace_production 
        inner join check_mess on trace_production.rtx_lot = check_mess.LOT
        inner join qiaojiao_mess on trace_production.psa_lot = qiaojiao_mess.LOT
        '''
        sql1="select distinct * from view_qiaojiao limit 1000"
        b=Base()
        self.ms =b.conn('offline')
        res = self.ms.doget(sql1)
        res.columns = ['psa_lot','pva_lot','psa_intime','psa_outtime','pva_intime','pva_outtime','rtx_intime','rtx_outtime','slt_intime','slt_outtime','slt_lot','hd_lot','DATA1','PARAMETER','SAMPLESEQ','OPERATION','checktime']
        self.ms.dopost('truncate table all_qiaojiao')
        b.batchwri(res, 'all_qiaojiao',self.ms)