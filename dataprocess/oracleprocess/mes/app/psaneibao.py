import sys,os
sys.path.append('/home/openstack/data_offline/data_factory/')
from dataprocess.oracleprocess.mes.base import Base
base=Base()
sql='''
SELECT 
NVL(SUM(CASE WHEN OPERATION = 'PSA' THEN QUANTITY END),0) PSA
,NVL(SUM(CASE WHEN OPERATION = '檢查_1' THEN QUANTITY END),0) VIC
,NVL(SUM(CASE WHEN OPERATION = '內包裝' THEN QUANTITY END),0) 内包
from MES.mes_wip_lot where STATUS NOT IN ('Terminated','Finished')'''
ora=base.conn('mes')
ms=base.conn('offline')
ms_test=base.conn('offline_test')
res=ora.doget(sql)
res['日期']=base.gettoday()
# ms.dopost('truncate table PsaInnerPkg')
base.batchwri(res,'PsaInnerPkg',ms)
base.batchwri(res,'PsaInnerPkg',ms_test)
ora.close()
ms.close()
ms_test.close()
