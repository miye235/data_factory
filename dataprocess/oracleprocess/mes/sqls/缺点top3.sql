SELECT EE.LEI,E1.DESCR,E1.NUM,EE.LL FROM
	(SELECT LEI,ROUND(A/ARRANGE,4) AS LL FROM
	(SELECT CC.LEI,C1.A,CC.ARRANGE FROM
		(SELECT LEI,SUM(ARRANGE_QUANTITY) AS ARRANGE
		FROM
			(SELECT BB.LOT,BB.LEI,B1.ARRANGE_QUANTITY FROM
				(SELECT LOT,SIZEE||CLASS AS LEI FROM
					(SELECT LOT,DEVICE,
					CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
					     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
					     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
					     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
					     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
					     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
					     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
					     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
					END AS SIZEE,
					CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
					     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
					END AS CLASS
					FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
						(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
				WHERE SIZEE > 0) BB
			LEFT JOIN
			MES.CMMT_BACK_INSPECT B1
			ON BB.LOT = B1.LOT)
		group by LEI) CC
	LEFT JOIN
	(SELECT LEI,SUM(AGUI) AS A FROM
		(SELECT DISTINCT LOT,LEI,
		CASE WHEN BIN = 'A' OR BIN = 'A1' OR BIN = 'A2' OR BIN = 'A3' OR BIN = 'A4' OR BIN = 'A5' OR BIN = 'A6' OR BIN = 'Q1' OR BIN = 'R9' OR BIN = 'R10' OR BIN = 'R11' OR BIN = 'R12' OR BIN = 'R13' OR BIN = 'R14' OR BIN = 'R15' OR BIN = 'R16' OR BIN = 'R17' OR BIN = 'R18' THEN QUANTITY
		END AS AGUI
		FROM
			(SELECT AA.LOT,AA.LEI,A1.BIN,A1.QUANTITY
			FROM
				(SELECT LOT,SIZEE||CLASS AS LEI FROM
					(SELECT LOT,DEVICE,
					CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
					     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
					     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
					     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
					     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
					     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
					     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
					     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
					END AS SIZEE,
					CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
					     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
					END AS CLASS
					FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
						(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
				WHERE SIZEE > 0) AA
			LEFT JOIN
			MES.CMMT_BACK_INSPECT_BIN A1
			ON A1.LOT = AA.LOT))
	group by LEI) C1
	ON CC.LEI = C1.LEI)
	WHERE ROUND(A/ARRANGE,4) > 0) EE
LEFT JOIN
((SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '23.6上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '23.6下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '55上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '55下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '31.5上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '31.5下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '39.5上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '39.5下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '38.5上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '38.5下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '64.5上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '64.5下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '50上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '50下' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '49上' AND ROWNUM < 4)
UNION ALL
(SELECT * FROM
	(SELECT LEI,DESCR,NUM FROM
		(SELECT LEI,DESCR,SUM(QUANTITY) AS NUM FROM
			(SELECT LEI,DESCR,QUANTITY FROM
				(SELECT DD.LOT,DD.LEI,D1.DESCR,D1.QUANTITY FROM
					(SELECT LOT,SIZEE||CLASS AS LEI FROM
						(SELECT LOT,DEVICE,
						CASE WHEN SUBSTR(DEVICE,5,3) = '001' THEN '55'
						     WHEN SUBSTR(DEVICE,5,3) = '002' THEN '31.5'
						     WHEN SUBSTR(DEVICE,5,3) = '003' THEN '39.5'
						     WHEN SUBSTR(DEVICE,5,3) = '004' THEN '38.5'
						     WHEN SUBSTR(DEVICE,5,3) = '005' THEN '64.5'
						     WHEN SUBSTR(DEVICE,5,3) = '006' THEN '50'
						     WHEN SUBSTR(DEVICE,5,3) = '008' THEN '49'
						     WHEN SUBSTR(DEVICE,5,3) = '009' THEN '23.6'
						END AS SIZEE,
						CASE WHEN SUBSTR(DEVICE,4,1) = 'F' OR SUBSTR(DEVICE,4,1) = 'U' THEN '上'
						     WHEN SUBSTR(DEVICE,4,1) = 'R' OR SUBSTR(DEVICE,4,1) = 'D' THEN '下'
						END AS CLASS
						FROM MES.MES_WIP_LOT_NONACTIVE WHERE LOT IN
							(select DISTINCT LOT from MES.MES_WIP_HIST where SUBSTR(REPLACE(TRANSACTIONTIME,'/','-'),0,10) = '${dateEditor1}' and TRANSACTION='Terminated'))
					WHERE SIZEE > 0) DD
				LEFT JOIN
				mes.CMMT_BACK_INSPECT_DEFECT D1
				ON D1.LOT = DD.LOT)
			WHERE QUANTITY > 0)
		GROUP BY LEI,DESCR)
	ORDER BY NUM DESC)
WHERE LEI = '49下' AND ROWNUM < 4)) E1
ON EE.LEI = E1.LEI
