select a.device, a.MATERIALNO from
(SELECT distinct device, MATERIALNO
FROM offline.sunhao
WHERE device IN (
		 SELECT DISTINCT 料號 FROM offline.loss_yuanfan_input
		 WHERE 業務日期 = 'yewudate')
	AND SUBSTR(materialno,1,5) IN ('M0102','M0103','M0104','M0107')
	GROUP BY device, MATERIALNO ) a
	inner join
(SELECT distinct device, MATERIALNO
FROM offline.sunhao
WHERE device IN (
		 SELECT DISTINCT 料號 FROM offline.loss_yuanfan_output
		 WHERE 業務日期 = 'yewudate')
	AND SUBSTR(materialno,1,5) IN ('M0102','M0103','M0104','M0107')
	GROUP BY device, MATERIALNO ) b
	on a.DEVICE = b.DEVICE
	and a.MATERIALNO = b.MATERIALNO