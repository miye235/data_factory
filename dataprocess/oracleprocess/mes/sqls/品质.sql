SELECT DISTINCT LOT, OPERATION, VISUALRESULT,LOTQUANTITY AS S,
   dat
     FROM
     (SELECT "DEFECTTYPE", "DEVICE"
         , "LOT",  "LOTQUANTITY",  "OPERATION"
         , "PVACHECKOUTTIME", "PVARESNAME",  "QCRESULTCUST", "QCRESULTSYS"
         , "QUANTITY", "REMARK", "RESOURCENAME"
         , replace(UPDATETIME,'/','-')AS dat,  "VISUALRESULT", "WO"
     FROM MES.qcview
		 where to_date(UPDATETIME,'yyyy/mm/dd hh24:mi:ss')>to_date('someday','yyyy/mm/dd hh24:mi:ss')
     ) A
WHERE OPERATION IN ('TAC-PVA', 'PVA','PSA')
ORDER BY dat desc