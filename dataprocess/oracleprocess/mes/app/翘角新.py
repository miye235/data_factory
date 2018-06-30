from dataprocess.oracleprocess.mes.base import Base
import pandas as pd
import datetime
class QiaoJiaoAll(object):
    def __init__(self):
        super(QiaoJiaoAll, self).__init__()

    def timestamp2string(self,timeStamp):
        try:
            d = datetime.datetime.fromtimestamp(timeStamp)
            str1 = d.strftime("%Y-%m-%d %H:%M:%S")
            # 2015-08-28 16:43:37'
            return str1
        except Exception as e:
            print
            e
            return ''
    def __call__(self):
        sql1="select distinct * from view_qiaojiao"
        b=Base()
        self.ms =b.conn('offline')
        che=self.ms.getdata('check_mess')
        res=[]
        for hdlot,checktime in che[['LOT','CHECKTIME']].dropna().drop_duplicates().values:
            hddata=self.ms.getdata('trace_production',tjs=["rtx_lot='"+hdlot+"'"]).drop_duplicates()
            hdfin=hddata[['psa_lot','pva_lot','psa_intime','psa_outtime','pva_intime','pva_outtime','rtx_intime','rtx_outtime','slt_intime','slt_outtime','slt_lot','rtx_lot']].values[0]
            for qdlot in hddata['psa_lot'].drop_duplicates().dropna().values:
                if qdlot=='null':
                    res.append(list(hdfin)+['']*5)
                else:
                    qddata=self.ms.getdata('qiaojiao_mess',tjs=["LOT='"+str(qdlot)+"'"]).drop_duplicates()
                    for one in qddata.values:
                        all=list(hdfin)+list(one)[1:-1]+[str(checktime)]
                        for i in range(2,10):
                            all[i]=str(all[i])
                        res.append(all)
        column=['psa_lot','pva_lot','psa_intime','psa_outtime','pva_intime','pva_outtime','rtx_intime','rtx_outtime','slt_intime','slt_outtime','slt_lot','hd_lot','DATA1','PARAMETER','SAMPLESEQ','OPERATION','checktime']
        res =pd.DataFrame(res,columns=column)
        self.ms.dopost('truncate table all_qiaojiao')
        b.batchwri(res, 'all_qiaojiao',self.ms)
        self.ms.close()