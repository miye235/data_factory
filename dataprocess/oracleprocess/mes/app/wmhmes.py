# -*- coding: UTF-8 -*-
import sys
sys.path.append('/home/openstack/data_offline/data_factory/')
from dataprocess.oracleprocess.mes.base import Base

class WmhMes(object):
    def __init__(self):
        super(WmhMes, self).__init__()
    def trandate(self,df):
        if int(df['transactiontime'][11:13])>6:
            return df['transactiontime'][:11]
        else:
            y=self.base.getYesterday(day=df['transactiontime'][:11])
            return y[:4]+'-'+y[5:7]+'-'+y[8:10]
    def __call__(self,conns):
        b=Base()
        sqldict={'PSA产量':'''
SELECT	NVL(SUM(CASE WHEN substr(vlm.wo,4,1) IN ('E','D') AND mwh.newquantity < 1000 THEN 0 ELSE mwh.newquantity END),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN	mes.mes_wip_hist mwh 
ON	mwh.lot = vlm.lot
	AND mwh.TRANSACTION = 'CheckOut'
	AND mwh.oldoperation = 'PSA'
WHERE	SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot AND TRANSACTION = 'CheckOut' AND oldoperation = 'PSA')
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 07:00:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 07:00:00'
''','PVA 1330M':'''
SELECT	NVL(SUM(CASE WHEN substr(vlm.wo,4,1) IN ('E','D') AND mwh.newquantity < 1000 THEN 0 ELSE mwh.newquantity END),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN	mes.mes_wip_hist mwh 
ON	mwh.lot = vlm.lot
	AND mwh. TRANSACTION = 'CheckOut'
	AND mwh.oldoperation IN ('PVA', 'TAC-PVA')
WHERE	SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot AND TRANSACTION = 'CheckOut' AND oldoperation IN ('PVA', 'TAC-PVA'))
	AND vlm.device LIKE '_000%'
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 07:00:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 07:00:00'
''','PVA 1490M':'''
SELECT	NVL(SUM(CASE WHEN substr(vlm.wo,4,1) IN ('E','D') AND mwh.newquantity < 1000 THEN 0 ELSE mwh.newquantity END),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN	mes.mes_wip_hist mwh 
ON	mwh.lot = vlm.lot
	AND mwh. TRANSACTION = 'CheckOut'
	AND mwh.oldoperation IN ('PVA', 'TAC-PVA')
WHERE	SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot AND TRANSACTION = 'CheckOut' AND oldoperation IN ('PVA', 'TAC-PVA'))
	AND vlm.device LIKE '_001%'
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 07:00:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 07:00:00'
''','RTC-KS':'''
SELECT
SUM(mwh.newquantity) 產出數量
FROM mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON  mwh.lot = vlm.lot
AND mwh.oldoperation = 'RTC-QC'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot  AND oldoperation = 'RTC-QC')
 and vlm.operationseq IN('002','003')
 AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
 AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
'''
,'RTP-XY':'''
SELECT 
NVL(SUM(mwh.newquantity),0)/2 產出數量
FROM mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON mwh.lot = vlm.lot
AND mwh.oldoperation = 'RTP'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot  AND oldoperation = 'RTP')
 and vlm.operationseq = '002'
 AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
 AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
''','RTS-CQ':'''
SELECT	NVL(SUM(mwh.newquantity),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON 	mwh.lot = vlm.lot
	AND mwh.oldoperation = 'RTS-QC'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot  AND oldoperation = 'RTS-QC')
	AND vlm.operationseq = '002'
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
''','RTS-KS':'''
SELECT	NVL(SUM(mwh.newquantity),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON 	mwh.lot = vlm.lot
	AND mwh.oldoperation = 'RTS-QC'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot  AND oldoperation = 'RTS-QC')
	AND vlm.operationseq = '003'
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
''','VIC':'''
SELECT  
NVL(SUM(mwh.newquantity),0) 產出數量
FROM mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON  mwh.lot = vlm.lot
  AND mwh.TRANSACTION = 'CheckOut'
  AND mwh.oldoperation LIKE '檢查%'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot AND TRANSACTION = 'CheckOut' AND oldoperation LIKE '檢查%')
 and vlm.wo like 'K%'
 and vlm.operation <> '凹凸靜置站' 
 AND vlm.operation <> 'D規內包裝'
 AND vlm.operation <> '翹曲靜置' 
 AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
 AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
''','WIP-psa':'''
SELECT 
NVL(SUM(CASE WHEN OPERATION = 'PSA' THEN QUANTITY END),0) PSA
from MES.mes_wip_lot where STATUS NOT IN ('Terminated','Finished')
''','WIP-vic':'''
SELECT
NVL(SUM(CASE WHEN OPERATION = '檢查_1' THEN QUANTITY END),0) VIC
from MES.mes_wip_lot where STATUS NOT IN ('Terminated','Finished')
''','WIP-内包':'''
SELECT
NVL(SUM(CASE WHEN OPERATION = '內包裝' THEN QUANTITY END),0) 内包
from MES.mes_wip_lot where STATUS NOT IN ('Terminated','Finished')
''','分条':'''
select NVL(sum(qty),0) 產出數量
from (SELECT 
  mwh.device,mwh.newquantity qty,substr(mwh.transactiontime,0,10) dat
  FROM MES.view_lotlist_main vlm
  INNER JOIN (select * from MES.mes_wip_hist where 
replace(transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
AND replace(transactiontime,'/','-') < 'today'||' 08:30:00') mwh 
     ON mwh.lot = vlm.lot
    AND mwh.oldoperation = 'Slitter_Inventory'
  WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM MES.mes_wip_hist WHERE lot = vlm.lot AND oldoperation = 'Slitter_Inventory')
   AND substr(vlm.wo,4,1) not in ('E','D') or (substr(vlm.wo,4,1) in ('E','D') and mwh.newquantity >'1000')
   group by mwh.device,mwh.newquantity,substr(mwh.transactiontime,0,10))
''','内包':'''
SELECT	
NVL(SUM(mwh.newquantity),0) 產出數量
FROM	mes.view_lotlist_main vlm
INNER JOIN mes.mes_wip_hist mwh 
ON 	mwh.lot = vlm.lot
		AND mwh.TRANSACTION = 'CheckOut'
		AND mwh.oldoperation LIKE '%內包裝'
WHERE SEQUENCE = (SELECT MAX(SEQUENCE) FROM mes.mes_wip_hist WHERE lot = vlm.lot AND TRANSACTION = 'CheckOut' AND mwh.oldoperation LIKE '%內包裝')
	and vlm.wo like 'K%'
	AND replace(mwh.transactiontime,'/','-') >= 'yesterday'||' 08:30:00'
	AND replace(mwh.transactiontime,'/','-') < 'today'||' 08:30:00'
'''}
        self.ora = conns['mes']
        self.ms = conns['offline']
        # self.ms.dopost("truncate table mwhvlm1")
        # for day in [b.getYesterday(),b.gettoday()]:
        for day in [b.getYesterday(),b.gettoday()]:
            self.ms.dopost("delete from mwhvlm1 where riqi='" + b.getYesterday(day).replace('/', '-') + "'")
            for k,v in sqldict.items():
                sqlthis=v.replace('yesterday',b.getYesterday(day).replace('/','-')).replace('today',day.replace('/','-'))
                res = self.ora.doget(sqlthis)
                res.columns=['qty']
                res['type']=k
                res['riqi']=b.getYesterday(day).replace('/','-')
                b.batchwri(res, 'mwhvlm1',self.ms)
                del res
base = Base()
offline = base.conn('offline')
mes=base.conn('mes')
offline1 = base.conn('offline_test')
wms = base.conn('wms')
conns = {'offline': offline,'wms': wms,'mes':mes}
conns1 = {'offline': offline1,'wms': wms,'mes':mes}
t3s = WmhMes()
t3s(conns)
t3s(conns1)
offline.close()
wms.close()
