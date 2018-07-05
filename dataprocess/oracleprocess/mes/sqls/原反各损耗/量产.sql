select sum(日投入成本) touru,sum(日损耗金额) sunhao from(SELECT sum(aaa.touru) as 日投入, sum(bbb.chanchu) as 日产出,sum(touru-chanchu) as 日损耗米数, sum(dj*touru) as 日投入成本,sum((touru-chanchu)*dj) as 日损耗金额,bbb.業務日期 FROM
( SELECT bb.料號, aa.dj, bb.touru,rq FROM
( SELECT DEVICE, SUM(COMPONENT_QUANTITY * ITEM_COST) AS dj FROM
( SELECT a.DEVICE, a.MATERIALNO, a.COMPONENT_QUANTITY, b.ITEM_COST FROM
( SELECT DEVICE, MATERIALNO, COMPONENT_QUANTITY FROM offline.cost_yuanfan_wuliao
WHERE DEVICE IN (
SELECT DISTINCT 料號 FROM offline.loss_yuanfan_input where 業務日期 BETWEEN 'starttime' and 'endtime'
)
AND DISABLE_DATE IS NULL
AND SUBSTR(materialno,1,5) IN ('M0102','M0103','M0104','M0107','M0108','M0112','M0111')
) a
INNER JOIN offline.materialprice b
ON a.MATERIALNO = b.ITEM_NUMBER
	AND b.COST_TYPE= 'Frozen'
	AND b.ITEM_COST != 0
	) c
	GROUP BY DEVICE ) aa
	INNER JOIN
	(SELECT 料號,SUM(數量) AS touru,業務日期 AS rq  FROM offline.loss_yuanfan_input WHERE 業務日期  BETWEEN 'starttime' and 'endtime' and (工單 LIKE '___M%' OR 工單 LIKE '___P%' OR 工單 LIKE '___T%')
	GROUP BY 料號,業務日期
	) bb
	ON aa.device = bb.料號 ) aaa
	INNER JOIN
	(SELECT 料號,SUM(數量) AS chanchu,業務日期  FROM offline.loss_yuanfan_output WHERE 業務日期 BETWEEN 'starttime' and 'endtime' and (工單 LIKE '___M%' OR 工單 LIKE '___P%' OR 工單 LIKE '___T%')
	GROUP BY 料號,業務日期
	) bbb
	 ON aaa.料號 = bbb.料號 AND aaa.rq = bbb.業務日期
GROUP BY 業務日期) s