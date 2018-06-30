-- begin apps.MO_GLOBAL.SET_POLICY_CONTEXT('S',81); end;
SELECT 公司名称
			,ZZ.币种 币种
			,逾期情况
			,(CASE WHEN ZZ.币种 = 'CNY' THEN 1 ELSE YY.汇率 END)*逾期款 逾期款
FROM(SELECT
		A.VENDOR_NAME 公司名称
		,A.INVOICE_CURRENCY_CODE 币种
		,decode(sign(ROUND(TRUNC(TO_DATE('thisday','yyyy-mm-dd')) - to_date(to_char(B.due_date,'yyyy-mm-dd'),'yyyy-mm-dd'))),-1,'逾期1年以内',0,'逾期1年以内',1,
		decode(ceil(ROUND(TRUNC(TO_DATE('thisday','yyyy-mm-dd')) - to_date(to_char(B.due_date,'yyyy-mm-dd'),'yyyy-mm-dd'))/360),0,'逾期1年以内',1,'逾期1年以内',2,'逾期1-2年',3,'逾期2-3年',4,'逾期3年以上',5,'逾期3年以上',6,'逾期3年以上',7,'逾期3年以上')
		) 逾期情况
		,sum(A.REMAINING_AMOUNT_SUM) 逾期款
		FROM
		(SELECT  o272382.VENDOR_NAME as VENDOR_NAME,o272382.INVOICE_NUM as INVOICE_NUM,o272382.INVOICE_CURRENCY_CODE as INVOICE_CURRENCY_CODE,SUM(o272382.REMAINING_AMOUNT) as REMAINING_AMOUNT_SUM
		 FROM (
		select pv.vendor_name
					 ,ai.invoice_num
					 ,ai.invoice_currency_code
					 ,(NVL(xtb.entered_unrounded_cr,0)-NVL(xtb.entered_unrounded_dr,0)) Remaining_Amount
			from apps.xla_trial_balances xtb
					 ,apps.gl_code_combinations gcc
					 ,apps.XLA_TRANSACTION_ENTITIES xte
					 ,apps.ap_invoices_all ai
					 ,apps.ap_terms_tl at
					 ,apps.xla_ae_headers xah
					 ,apps.po_vendors pv
					 ,apps.po_vendor_sites_all pvs
		where 1=1
		and NVL(xtb.applied_to_entity_id,xtb.source_entity_id) = xte.entity_id
		and xte.source_id_int_1=ai.invoice_id
		and ai.terms_id=at.term_id
		and xtb.ae_header_id = xah.ae_header_id
		and ai.vendor_id=pv.vendor_id
		and ai.vendor_site_id = pvs.vendor_site_id
		and xtb.code_combination_id = gcc.code_combination_id(+)
		and ai.org_id= '81'
		AND gcc.segment3 IN ('2131','2132')
AND TO_CHAR(xah.accounting_date,'YYYY-MM') < '2018-05'
-- 		AND pv.vendor_name = '伟迪捷（上海）标识技术有限公司'
		 ) o272382

		GROUP BY o272382.VENDOR_NAME,o272382.INVOICE_NUM,o272382.INVOICE_CURRENCY_CODE,o272382.REMAINING_AMOUNT
		HAVING (SUM(o272382.REMAINING_AMOUNT) <> 0)) A
		,(SELECT o272412.INVOICE_NUM as INVOICE_NUM,o272412.DUE_DATE as DUE_DATE
		 FROM ( select ai.invoice_num
									,MAX(aps.due_date) due_date
					 from apps.ap_invoices_all ai
							 ,apps.ap_payment_schedules_all aps
							 ,apps.po_vendors pv
							 ,apps.po_vendor_sites_all pvs
							 ,apps.iby_ext_bank_accounts ieba
							 ,apps.iby_ext_bank_accounts ieba1
							 ,apps.ce_bank_branches_v cbb
							 ,apps.gl_code_combinations  gcc
					where ai.invoice_id=aps.invoice_id(+)
								and ai.vendor_id=pv.vendor_id
								and ai.vendor_site_id=pvs.vendor_site_id
								and aps.external_bank_account_id = ieba.ext_bank_account_id(+)
								and ai.external_bank_account_id=ieba1.ext_bank_account_id(+)
								and ieba.branch_id = cbb.branch_party_id(+)
								and ai.ACCTS_PAY_CODE_COMBINATION_ID = gcc.code_combination_id
-- 								AND ai.invoice_num = '02036456/02036593'
					GROUP BY ai.invoice_num
		 ) o272412) B
		WHERE A.INVOICE_NUM = B.INVOICE_NUM
		GROUP BY A.VENDOR_NAME, A.INVOICE_CURRENCY_CODE,decode(sign(ROUND(TRUNC(TO_DATE('thisday','yyyy-mm-dd')) - to_date(to_char(B.due_date,'yyyy-mm-dd'),'yyyy-mm-dd'))),-1,'逾期1年以内',0,'逾期1年以内',1,
		decode(ceil(ROUND(TRUNC(TO_DATE('thisday','yyyy-mm-dd')) - to_date(to_char(B.due_date,'yyyy-mm-dd'),'yyyy-mm-dd'))/360),0,'逾期1年以内',1,'逾期1年以内',2,'逾期1-2年',3,'逾期2-3年',4,'逾期3年以上',5,'逾期3年以上',6,'逾期3年以上',7,'逾期3年以上'))
		ORDER BY A.VENDOR_NAME
		)ZZ
LEFT JOIN (SELECT FROM_CURRENCY 币种,SHOW_CONVERSION_RATE 汇率,USER_CONVERSION_TYPE FROM APPS.GL_DAILY_RATES_V WHERE USER_CONVERSION_TYPE = '評價匯率-CN' AND TO_CURRENCY = 'CNY' AND to_char(CONVERSION_DATE,'yyyy-mm-dd') = 'thisday') YY
ON YY.币种 = ZZ.币种
WHERE ZZ.逾期款<>0
ORDER BY 公司名称