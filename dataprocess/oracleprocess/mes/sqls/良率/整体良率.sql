SELECT DISTINCT MMT.*
,MELT.TRANSACTIONTIME RTC出站时间
FROM
(select MMO.*
,MELO.UPDATETIME PSA出站时间
from
(select MM.*
,MEL.UPDATETIME PVA出站时间
FROM (select cbi.LOT,vlm.WO,dd.REASON,dd.DESCR,dd.QUANTITY AS dianque,tt.bin,tt.QUANTITY as agui,oo.TRANSACTIONTIME as checkouttime,oo.TRANSACTION,

case when substr(vlm.WO,4,1) in ('M','T','P')  then '量产'
     when substr(vlm.WO,4,1) = 'E' then 'RD试样'
     when substr(vlm.WO,4,1) = 'D' then 'TD试机'
     else ''
     end as WOTYPE_BACKEND,

decode(substr(vlm.DEVICE,2,2), 'BO', '京东方', 'CE', '熊猫(CEC)','HK', '惠科', 'CS', '华星', 'SP', '盛波光电', 'CH', '彩虹光电', 'SS', '三星', 'CP', '成都熊猫','IN','群创') as kehu,

decode(substr(vlm.DEVICE,5,3), '001', '55"', '002', '31.5"', '003', '39.5"', '004', '38.5"', '005', '64.5"', '006', '50"', '008', '49"', '009', '23.6"', '010', '58"')
 as chicun,

decode(substr(vlm.DEVICE,4,1), 'F', '自制上片', 'R', '自制下片', 'U', '外购上片', 'D', '外购下片', '1', '购销上片', '2','购销上片') as shangxiapian,

decode(substr(vlm.WO,1,1), 'Q', '重庆', 'K', '昆山','Y', '咸阳') as changqu,

vlm.LOTTYPE, vlm.DEVICE ,
(select case when sum(QUANTITY) is null then 0  else sum(QUANTITY) end from mes.CMMT_BACK_INSPECT_BIN where LOT=cbi.LOT and BIN in ('A','B','C','D','R6','R7','R8','R9','R10','R11','R12','R13','R14','R15','R16','R17','A1','A2','A3','A4','Q1','R18','A5','A6','A7')) AS QUANTITY,
(select case when sum(QUANTITY) is null then 0  else sum(QUANTITY) end from mes.CMMT_BACK_INSPECT_BIN where LOT=cbi.LOT and BIN in ('A','R9','R10','R11','R12','R13','R14','R15','R16','R17','A1','A2','A3','A4','Q1','R18','A5','A6','A7')) AS GOODPERCENT,
(select case when sum(QUANTITY) is null then 0 else sum(QUANTITY) end from mes.CMMT_BACK_INSPECT_BIN where LOT=cbi.LOT and BIN in ('A','A1')) AS AGRADEPERCENT ,
 vlm.MATERIAL, vlm.LOTNO,
-- '' AS RTCCheckOutDate,'' AS CheckInDate, '' AS PSACheckOutDate,'' AS CheckOutDate, '已结批' AS STATUS, '' AS FinishedDate,
(case when vl1.MATERIAL is null then (select cc.wo  from MES.view_lotlist_main cc where cc.lot=vlm.MATERIAL)else  AA.WO  end )AS 前段工单,
case when substr((case when vl1.MATERIAL is null then (select cc.wo  from mes.view_lotlist_main cc where cc.lot=vlm.MATERIAL)else  AA.WO  end ),4,1) in ('M','T','P') then '量产'
                                     when substr((case when vl1.MATERIAL is null then (select cc.wo  from mes.view_lotlist_main cc where cc.lot=vlm.MATERIAL)else  AA.WO  end ),4,1) = 'E' then 'RD试样'
                                     when substr((case when vl1.MATERIAL is null then (select cc.wo  from mes.view_lotlist_main cc where cc.lot=vlm.MATERIAL)else  AA.WO  end ),4,1) = 'D' then 'TD试机'
                                     else ''
                                     end as WOTYPE_FRONTEND,
 vl1.MATERIAL AS MLOT,
(case when vlm.MATERIAL like '1K1%'  then  vl1.DEVICE  when vl1.MATERIAL like '1K1%'  then vmm.MATERIALNO else null end) AS  物料,  vmm.CUSTLOT,
(case when vl1.MATERIAL like '1%' and AA.FABCODE like '%25M%' then '25M' when vl1.MATERIAL like '1%' and AA.FABCODE like '%16M%' then '16M'
when vlm.MATERIAL like '1%' and vl1.FABCODE like '%25M%' then '25M' when vlm.MATERIAL like '1%' and vl1.FABCODE like '%16M%' then '16M' else null end)AS 机速
from mes.CMMT_BACK_INSPECT cbi
inner join mes.view_lotlist_main vlm on vlm.LOT=cbi.LOT
left join mes.view_lotlist_main vl1 on vl1.LOT=vlm.MATERIAL
left join mes.view_mmslotlist_main vmm on vmm.MLOT=vl1.MATERIAL
left join mes.view_lotlist_main AA on AA.LOT=vl1.MATERIAL
left join mes.CMMT_BACK_INSPECT_DEFECT dd on DD.LOT=cbi.LOT
left join mes.CMMT_BACK_INSPECT_BIN tt on tt.LOT=cbi.LOT
left join mes.MES_WIP_HIST oo on oo.LOT=cbi.LOT
where cbi.LOT in (SELECT DISTINCT INSP.LOT FROM mes.VIEW_LOTLIST_MAIN LOT , MES.CMMT_BACK_INSPECT INSP
WHERE LOT.LOT = INSP.LOT )
--and cbi.LOT IN ('QP1-B-1805-0095')
and oo.TRANSACTION='Terminated'
group by cbi.LOT ,vlm.DEVICE,AA.WO, vlm.MATERIAL, vlm.LOTNO,vl1.MATERIAL,vmm.MATERIALNO,vmm.CUSTLOT,vl1.DEVICE,vlm.WO,vlm.LOTTYPE,AA.FABCODE,vl1.FABCODE,dd.REASON,dd.DESCR,dd.QUANTITY,tt.bin,tt.QUANTITY,oo.TRANSACTIONTIME,oo.TRANSACTION) MM
LEFT JOIN MES.mes_edc_lotinfo MEL
ON NVL(CUSTLOT,NVL(MM.MLOT,MM.MATERIAL)) = MEL.LOT AND MEL.OPERATION IN ('TAC-PVA','PVA')) MMO
LEFT JOIN  MES.mes_edc_lotinfo MELO
ON NVL(MMO.CUSTLOT,NVL(MMO.MLOT,MMO.MATERIAL)) = MELO.LOT AND MELO.OPERATION = 'PSA') MMT
LEFT JOIN MES.MES_WIP_HIST MELT
ON MMT.LOT = MELT.LOT  AND  MELT.ACTIVITY ='BackEndRTCCheckOut'
-- WHERE MMF.LOT = 'KP1-B-1711-0160.01'


-- AND MEL.OPERATION IN ('TAC-PVA','PVA')
-- LEFT JOIN MES.mes_edc_lotinfo MELO
-- ON NVL(CUSTLOT,NVL(MM.MLOT,MM.MATERIAL)) = MELO.LOT AND MELO.OPERATION = 'PSA'

-- order by tt.bin