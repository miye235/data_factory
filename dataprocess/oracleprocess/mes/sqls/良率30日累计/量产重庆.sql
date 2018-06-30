select sum(投入),sum(A规),rq from (
SELECT distinct LOT,
 WO,
 WOTYPE_BACKEND,
  CHICUN AS 尺寸,
 DEVICE,
 QUANTITY AS 投入,
 GOODPERCENT AS A规,
 CHECKOUTTIME,
 前段工单,
 WOTYPE_FRONTEND
 ,IFNULL(机速,(CASE WHEN SUBSTR(前段工单,6,2) ='17' THEN '16M' ELSE (CASE WHEN SUBSTR(前段工单,6,2) ='18' THEN '25M' ELSE '-' END) END)) as 机速速,
 DATE_FORMAT(
  date_sub(CHECKOUTTIME, INTERVAL 8 HOUR),
  '%Y-%m-%d'
 ) AS rq
FROM
 OverallGoodRatio
WHERE  DATE_FORMAT(CHECKOUTTIME, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT(starttime, '%Y-%m-%d 08:00:00') and DATE_FORMAT(endtime,'%Y-%m-%d 08:00:00')
AND WOTYPE_BACKEND='量产'
AND WOTYPE_FRONTEND='量产'
and IFNULL(机速,(CASE WHEN SUBSTR(前段工单,6,2) ='17' THEN '16M' ELSE (CASE WHEN SUBSTR(前段工单,6,2) ='18' THEN '25M' ELSE '-' END) END)) like '16M'
AND (DEVICE LIKE '___thisdevice1%' or DEVICE LIKE '___thisdevice2%')
and WO not like '____R%'
AND CHICUN  LIKE 'thissize%'
AND (前段工单 not like  '____L%' OR WO not like  '____L%')
)b group by rq

ORDER BY RQ