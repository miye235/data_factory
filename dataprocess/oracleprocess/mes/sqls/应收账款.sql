SELECT o289440.CUSTOMER_NUMBER as 客户编号,o289440.CUSTOMER_NAME as 客户名称,o289440.CURRENCY as 货币类型 ,sum(o289440.AMOUNT_DUE) as 原币金额,sum(o289440.FUNCTIONAL_AMOUNT_DUE) as 人民币金额,o289440.到期状况 as 到期状况
	FROM ( SELECT cust.customer_number,
	cust.customer_name,
	hcsu.location,
	rt.name payment_term,
	rct.interface_header_attribute1,
	rct.trx_number,
	rct.ct_reference sales_order,
	rct.purchase_order,
	rct.trx_date,
	arps.due_date,
	rct.invoice_currency_code currency,
	arps.amount_due_remaining amount_due,
	arps.amount_due_remaining * NVL(arps.exchange_rate,1) functional_amount_due,
	jr.name salesrep,
	arps.customer_id,
	rct.bill_to_site_use_id,
	rct.customer_trx_id,
	ROUND(TRUNC(SYSDATE) - arps.due_date) days_past_due,
	rct.attribute1 invoice_num,
	decode(sign(ROUND(TRUNC(SYSDATE) - arps.due_date)),-1,'未逾期',0,'未逾期',1,
	decode(ceil(ROUND(TRUNC(SYSDATE) - arps.due_date)/360),0,'逾期1年以内',1,'逾期1年以内',2,'逾期1-2年',3,'逾期2-3年',4,'逾期3年以上')
	) "到期状况",
	rct.comments
	FROM ar.ar_payment_schedules_all arps,
	ar.ra_customer_trx_all rct,
	apps.ar_customers cust,
	apps.HZ_CUST_PROFILE_AMTS acpa,
	ar.hz_cust_site_uses_all HCSU,
	ar.ra_terms_tl rt,
	jtf.jtf_rs_salesreps JR
	WHERE arps.org_id = '81'
	AND arps.customer_trx_id = rct.customer_trx_id
	AND rct.set_of_books_id = '2021'
	AND arps.customer_id = cust.customer_id
	AND rct.term_id = rt.term_id(+)
	and rct.org_id= jr.org_id(+)
	AND rct.primary_salesrep_id = jr.salesrep_id(+)
	AND arps.amount_due_remaining <> 0
	AND rct.bill_to_site_use_id = hcsu.site_use_id
	AND rct.bill_to_site_use_id = acpa.site_use_id(+)
	AND rct.invoice_currency_code = acpa.currency_code(+)
	AND (acpa.cust_acct_profile_amt_id =
	(SELECT MAX(acpa1.cust_acct_profile_amt_id)
	FROM apps.HZ_CUST_PROFILE_AMTS acpa1
	WHERE rct.bill_to_site_use_id = acpa1.site_use_id(+)
	AND rct.invoice_currency_code = acpa1.currency_code(+)) OR
	acpa.cust_acct_profile_amt_id IS NULL )
	) o289440
	group by o289440.CUSTOMER_NUMBER,o289440.CUSTOMER_NAME,o289440.CURRENCY,o289440.到期状况
	order by o289440.CUSTOMER_NUMBER