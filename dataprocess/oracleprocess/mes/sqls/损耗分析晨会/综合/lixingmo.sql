select a.rq,rtr,rcc,ITEM_COST,rtr-rcc as sh,(rtr-rcc)*ITEM_COST as moneysh,(rtr*ITEM_COST) as moneytr  from (
select sum(MLOTCONSUMEQTY) as rtr,b.ITEM_COST,rq,机速,IFNULL(机速,(CASE WHEN SUBSTR(wo,6,2) ='17' THEN '16M' ELSE (CASE WHEN SUBSTR(wo,6,2) ='18' THEN '25M' ELSE '-' END) END)) as 机速速 from
(select *,DATE_FORMAT(date_sub(UPDATETIME,interval 7 hour),'%Y-%m-%d') as rq,
(case when FABCODE like '%25M%' then '25M' when  FABCODE like '%16M%' then '16M' else null end)AS 机速 from offline.sunhao

/*DATE_FORMAT(UPDATETIME, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT('2018/05/26', '%Y-%m-%d 07：00：00') and DATE_FORMAT('2018/05/30','%Y-%m-%d 07：00：00')
AND*/
where OPERATION IN ('PSA','TAC-PVA','PVA','TAC','AGING')
AND MATERIALNO LIKE '_0105%'

 )sa INNER JOIN materialprice b on sa.materialno=b.ITEM_NUMBER
WHERE b.ITEM_COST != 0 and b.COST_TYPE= 'Frozen'
GROUP BY rq)a

left join

(select sum(outqty) as rcc,rq from

(select *,DATE_FORMAT(date_sub(UPDATETIME,interval 7 hour),'%Y-%m-%d') as rq from offline.sunhao
/*DATE_FORMAT(UPDATETIME, '%Y-%m-%d %H:%i:%s') between DATE_FORMAT('2018/05/26', '%Y-%m-%d 07：00：00') and DATE_FORMAT('2018/05/30','%Y-%m-%d 07：00：00')
AND */
where WO NOT LIKE 'KP1%'
AND OPERATION IN ('PSA','TAC-PVA','PVA','TAC','AGING')
 AND MATERIALNO LIKE '_0105%'
AND EQUIPMENT IS NOT NULL

  ) sb

GROUP BY rq)b

on a.rq=b.rq
