SELECT  case  when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) ='03' then 'PVA'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) ='04' then '保护膜'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) in('02','08') then '(上TAC)表面处理膜一般TAC'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2)  ='07' then '补偿膜(下TAC)'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) ='05' then '离型膜'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) ='01' then 'Leader Film'
   when SUBSTR(MATERIALNO,1,1) ='M'and SUBSTR(MATERIALNO,2,2) ='01' and SUBSTR(MATERIALNO,4,2) ='06' then '偏光膜'
   when SUBSTR(MATERIALNO,1,4) ='M011' then 'PET'
   END as ml,
      case
when UPDATETIME like '2018/03%' and FABCODE like '%25M%' then sum(MLOTCONSUMEQTY-OUTQTY/5.88)
when UPDATETIME like '2018/03%' and (FABCODE not like '%25M%' or FABCODE is null) then sum(MLOTCONSUMEQTY-OUTQTY/5.6)
when UPDATETIME not like '2018/03%' and FABCODE like '%16M%' then sum(MLOTCONSUMEQTY-OUTQTY/5.6)
when UPDATETIME not like '2018/03%' and (FABCODE not like '%16M%' or FABCODE is null) then sum(MLOTCONSUMEQTY-OUTQTY/5.88)
else  sum(MLOTCONSUMEQTY-OUTQTY)
end as rsh,
sum(OUTQTY) as rcc,sum(MLOTCONSUMEQTY) as rtr,
(case
when UPDATETIME like '2018/03%' and FABCODE like '%25M%' then sum(MLOTCONSUMEQTY-OUTQTY/5.88)
when UPDATETIME like '2018/03%' and (FABCODE not like '%25M%' or FABCODE is null) then sum(MLOTCONSUMEQTY-OUTQTY/5.6)
when UPDATETIME not like '2018/03%' and FABCODE like '%16M%' then sum(MLOTCONSUMEQTY-OUTQTY/5.6)
when UPDATETIME not like '2018/03%' and (FABCODE not like '%16M%' or FABCODE is null) then sum(MLOTCONSUMEQTY-OUTQTY/5.88)
else  sum(MLOTCONSUMEQTY-OUTQTY)
end)/sum(MLOTCONSUMEQTY) as rshbfb,DATE_FORMAT(str_to_date(UPDATETIME, '%Y/%m/%d'),'%Y/%m/%d') as rq
FROM
(select lot,device, MATERIALNO, MLOTCONSUMEQTY, WO,OPERATION,
case when EQUIPMENT is not null then OUTQTY else 0 end as OUTQTY, UPDATETIME,FABCODE
from offline.sunhao) sunhao
where
WO NOT LIKE 'KP1%'
AND OPERATION IN ('PSA','TAC-PVA','PVA','TAC')
GROUP BY rq,ml

order by rq