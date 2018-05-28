--总体
SELECT 前段工单,后段工单,料号,批号,生产状态,日期,厂区,分类,类型,sum(投入数) as 投入数 ,sum(良品数) as 良品数 ,点缺数,点缺项,sort
FROM (
SELECT 前段工单,后段工单,料号,批号,生产状态,日期,厂区,分类,类型,投入数,良品数,点缺数,点缺项,
row_number()over(partition by 前段工单,后段工单,料号,批号,生产状态,日期,厂区,分类,投入数,良品数 order by 点缺数 DESC)sort
FROM (
SELECT T8.WO as 前段工单,
       T2.WO as 后段工单,
       T2.DEVICE AS 料号,
       T2.LOT 批号,
       CASE WHEN SUBSTR(T8.WO,4,1)='E' OR SUBSTR(T2.WO,4,1)='E' THEN 'E工单'
               WHEN SUBSTR(T8.WO,4,1)IN('T','M','P') AND SUBSTR(T2.WO,4,1)IN('T','M','P') then 'P工单'
               WHEN SUBSTR(T8.WO,4,1)IN('D') OR SUBSTR(T2.WO,4,1)IN('D') THEN 'D工单'
               WHEN SUBSTR(T2.WO,5,1)IN('R')THEN 'R工单'
               ELSE '' END AS 生产状态,
       substr(T7.TRANSACTIONTIME,1,10) as 日期,
        CASE WHEN substr(T2.WO,1,1)='K' THEN '昆山'
      WHEN substr(T2.WO,1,1)='Q' THEN '重庆'
      ELSE '咸阳' END 厂区,
       CASE WHEN SUBSTR(t2.DEVICE,2,2)='CE' THEN 'CEC-'
     WHEN SUBSTR(t2.DEVICE,2,2)='HK' THEN 'HK-'
	   WHEN SUBSTR(t2.DEVICE,2,2)='CH' THEN 'CH-'
     WHEN SUBSTR(t2.DEVICE,2,2)='SP' THEN 'SP-'
     WHEN SUBSTR(t2.DEVICE,2,2)='CS' THEN 'CS-'
		 end ||
CASE WHEN SUBSTR(T2.DEVICE,5,3)='001' THEN '55"'
     WHEN SUBSTR(T2.DEVICE,5,3)='002' THEN '31.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='003' THEN '39.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='004' THEN '38.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='005' THEN '64.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='006' THEN '50"'
     WHEN SUBSTR(T2.DEVICE,5,3)='008' THEN '49"'
     WHEN SUBSTR(T2.DEVICE,5,3)='009' THEN '23.6"'
     else '' end ||
      CASE WHEN substr(t2.WO,1,1)='K' THEN '昆山检查'
           WHEN substr(t2.WO,1,1)='Q' THEN '重庆检查'
 end   ||
case when t2.MATERIAL is not null then '自制品'  else '台湾卷料' end ||
case WHEN SUBSTR(t2.wo,4,1)='D' THEN 'TD试机"' end
 as 分类
,
--SUBSTR(T2.DEVICE,2,2) AS 客户,
    SUM(T9.ARRANGE_QUANTITY) AS 投入数,
    SUM(T10.QUANTITY) AS 良品数,
    SUM(T11.QUANTITY)AS 点缺数,
    T11.DESCR 点缺项
    ,
     case WHEN SUBSTR(t2.DEVICE,4,1) in('F','U') THEN '上片'
     WHEN SUBSTR(t2.DEVICE,4,1) in('R','D') THEN '下片'
     ELSE '' END  as 类型

FROM (
select MATERIAL,LOT from MES.MES_WIP_LOT_NONACTIVE TT WHERE
 MATERIAL NOT LIKE 'KP1-S%'
UNION ALL
SELECT * FROM
(select DISTINCT TT.MATERIAL,B.LOT from MES.MES_WIP_LOT_NONACTIVE TT RIGHT JOIN
(select MATERIAL,LOT from MES.MES_WIP_LOT_NONACTIVE where
 material like 'KP1-S%') b  ON B.MATERIAL=TT.LOT
 )T) T1 LEFT JOIN
 MES.MES_WIP_LOT_NONACTIVE T2 ON T1.LOT=T2.LOT
 /*PVA站合并批*/
 LEFT JOIN (select b.sublot,PARENTLOT from  MES.MES_WIP_MERGE b
where b.operation='PSA')T3 ON T2.MATERIAL=T3.PARENTLOT
/*PVA站生产时间*/
LEFT JOIN (select TRANSACTIONTIME,lot from MES.MES_WIP_HIST where  OPERATIONNO='PVA' AND TRANSACTION='CheckOut'

)T4
on T1.MATERIAL=T4.LOT
/*分条批号*/
LEFT JOIN (select MATERIAL AS SPILIT_LOT,lot  from mes.MES_WIP_LOT_NONACTIVE where MATERIAL LIKE 'KP1-S%')T5 ON
T1.LOT=T5.LOT
/*检查合并批*/
LEFT JOIN (select b.sublot,PARENTLOT from  MES.MES_WIP_MERGE b
where b.OPERATION = '檢查_1')T6 ON T1.MATERIAL=T6.PARENTLOT
/*检查站CheckOutDate*/
LEFT JOIN (select TRANSACTIONTIME,WIP_HIST_SID,LOT from mes.MES_WIP_HIST where TRANSACTION='Terminated')T7 ON T1.LOT=T7.LOT
/*前段工单*/
LEFT JOIN(select WO,LOT from MES.MES_WIP_LOT_NONACTIVE)T8 ON T1.MATERIAL=T8.LOT
/*成品批量*/
LEFT JOIN(select  ARRANGE_QUANTITY,lot from mes.CMMT_BACK_INSPECT a
					left join (select CMMT_BACKEND_INSPECT_SID,SUM(NVL(QUANTITY,0))QUANTITY FROM mes.CMMT_BACK_INSPECT_BIN
					WHERE BIN IN ('R1','R2','R3','R4','R19')
					GROUP BY CMMT_BACKEND_INSPECT_SID)
					b on a.CMMT_BACKEND_INSPECT_SID=b.CMMT_BACKEND_INSPECT_SID
					)T9 ON T1.LOT =T9.LOT
/*A规*/
LEFT JOIN (select SUM(NVL(b.QUANTITY,0)) AS QUANTITY,a.CMMT_BACKEND_INSPECT_SID,a.lot
		 from mes.CMMT_BACK_INSPECT a left join mes.CMMT_BACK_INSPECT_BIN b
		 on a.CMMT_BACKEND_INSPECT_SID=b.CMMT_BACKEND_INSPECT_SID
		 where BIN IN ('A','A1','A2','A3','A4','A5','A6','Q1','R9','R10','R11','R12','R13','R14','R15','R16','R17','R18')
		 GROUP BY a.CMMT_BACKEND_INSPECT_SID,a.lot
		 ) T10
ON T1.LOT=T10.LOT
  /*点缺明细*/
 LEFT JOIN (select REASON, DESCR, QUANTITY,CMMT_BACKEND_INSPECT_SID from mes.CMMT_BACK_INSPECT_DEFECT)T11
 ON T10.CMMT_BACKEND_INSPECT_SID=T11.CMMT_BACKEND_INSPECT_SID

 GROUP BY T8.WO ,
          T2.WO ,
          T2.DEVICE,
          T2.LOT ,
          T11.DESCR,
          CASE WHEN SUBSTR(T8.WO,4,1)='E' OR SUBSTR(T2.WO,4,1)='E' THEN 'E工单'
               WHEN SUBSTR(T8.WO,4,1)IN('T','M','P') AND SUBSTR(T2.WO,4,1)IN('T','M','P') then 'P工单'
               WHEN SUBSTR(T8.WO,4,1)IN('D') OR SUBSTR(T2.WO,4,1)IN('D') THEN 'D工单'
               WHEN SUBSTR(T2.WO,5,1)IN('R')THEN 'R工单'
               ELSE '' END ,
        substr(T7.TRANSACTIONTIME,1,10),
        CASE WHEN substr(T2.WO,1,1)='K' THEN '昆山'
      WHEN substr(T2.WO,1,1)='Q' THEN '重庆'
      ELSE '咸阳' END ,
       CASE WHEN SUBSTR(t2.DEVICE,2,2)='CE' THEN 'CEC-'
     WHEN SUBSTR(t2.DEVICE,2,2)='HK' THEN 'HK-'
	   WHEN SUBSTR(t2.DEVICE,2,2)='CH' THEN 'CH-'
     WHEN SUBSTR(t2.DEVICE,2,2)='SP' THEN 'SP-'
     WHEN SUBSTR(t2.DEVICE,2,2)='CS' THEN 'CS-'
		 end ||
CASE WHEN SUBSTR(T2.DEVICE,5,3)='001' THEN '55"'
     WHEN SUBSTR(T2.DEVICE,5,3)='002' THEN '31.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='003' THEN '39.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='004' THEN '38.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='005' THEN '64.5"'
     WHEN SUBSTR(T2.DEVICE,5,3)='006' THEN '50"'
     WHEN SUBSTR(T2.DEVICE,5,3)='008' THEN '49"'
     WHEN SUBSTR(T2.DEVICE,5,3)='009' THEN '23.6"'
     else '' end ||
      CASE WHEN substr(t2.WO,1,1)='K' THEN '昆山检查'
      WHEN substr(t2.WO,1,1)='Q' THEN '重庆检查'
end ||
case when t2.MATERIAL is not null then '自制品'  else '台湾卷料' end ||
case WHEN SUBSTR(t2.wo,4,1)='D' THEN 'TD试机"' end

     order by substr(T7.TRANSACTIONTIME,1,10) asc )TT
      WHERE 投入数 IS NOT NULL
      AND (点缺项 IS NOT NULL OR 点缺项<>'')
      ${if(len(LotType) == 0,"","AND 生产状态='" + LotType + "'")}
      ORDER BY 日期 asc,点缺数 desc
      )
WHERE SORT<4
group by 前段工单,后段工单,料号,批号,生产状态,日期,厂区,分类,类型,点缺数,点缺项,sort
