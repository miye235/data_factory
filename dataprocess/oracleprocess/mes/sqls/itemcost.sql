
SELECT 良品数,投入数,分类,week from (

select sum(良品数) as  良品数 , sum(投入数) -sum(差额)  as  投入数   ,分类,week from (

SELECT AA.QUANTITY as  投入数, AA.r 差额 ,AA.DATA as  week ,A1.DEVICE as 料号,AGUI as 良品数,


CASE WHEN SUBSTR(A1.DEVICE,5,3)='001' THEN '55"'
     WHEN SUBSTR(A1.DEVICE,5,3)='002' THEN '31.5"'
     WHEN SUBSTR(A1.DEVICE,5,3)='003' THEN '39.5"'
     WHEN SUBSTR(A1.DEVICE,5,3)='004' THEN '38.5"'
     WHEN SUBSTR(A1.DEVICE,5,3)='005' THEN '64.5"'
     WHEN SUBSTR(A1.DEVICE,5,3)='006' THEN '50"'
     WHEN SUBSTR(A1.DEVICE,5,3)='008' THEN '49"'
     WHEN SUBSTR(A1.DEVICE,5,3)='009' THEN '23.6"'
     else '' end
||CASE WHEN SUBSTR(A1.DEVICE,4,1)='F' THEN '自制上片'
      WHEN SUBSTR(A1.DEVICE,4,1)='R' THEN '自制下片'
      WHEN SUBSTR(A1.DEVICE,4,1)='U' THEN '外购上片'
      WHEN SUBSTR(A1.DEVICE,4,1)='D' THEN '外购下片'
      else ''end||'\n' ||
      CASE WHEN substr(WO,1,1)='K' THEN '昆山检查'
      WHEN substr(WO,1,1)='Q' THEN '重庆检查'
end || A1.DEVICE  as 分类


  FROM
(SELECT DISTINCT TT.lot,TT.QUANTITY,R,AGUI, to_char(TO_DATE(t1.TRANSACTIONTIME,'yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd') DATA FROM
(SELECT  BIN,QUANTITY,lot,
CASE WHEN BIN = 'R1' OR BIN = 'R2' OR BIN = 'R3' OR BIN = 'R4' OR BIN = 'R19' THEN QUANTITY
END AS R,
CASE WHEN BIN = 'A' OR BIN = 'A1' OR BIN = 'A2' OR BIN = 'A3' OR BIN = 'A4' OR BIN = 'A5' OR BIN = 'A6' OR BIN = 'Q1' OR BIN = 'R9' OR BIN = 'R10' OR BIN = 'R11' OR BIN = 'R12' OR BIN = 'R13' OR BIN = 'R14' OR BIN = 'R15' OR BIN = 'R16' OR BIN = 'R17' OR BIN = 'R18' THEN QUANTITY
END AS AGUI
FROM
MES.CMMT_BACK_INSPECT_BIN
WHERE LOT IN
(select distinct LOT from MES.MES_WIP_HIST where lot IN
(select distinct  lot from MES.MES_WIP_LOT_NONACTIVE  )
AND TRANSACTION='Terminated')) TT
LEFT JOIN
MES.MES_WIP_HIST T1
ON TT.LOT = T1.LOT) AA
LEFT JOIN
MES.MES_WIP_LOT_NONACTIVE A1
ON AA.LOT = A1.LOT
)
GROUP BY 分类,week
ORDER BY  week asc
)
where  良品数 is not  null
and  投入数 is not  null