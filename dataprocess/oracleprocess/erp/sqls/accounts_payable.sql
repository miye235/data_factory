SELECT  o272382.ACCT_NO as ACCT_NO,o272382.AP_GL_DATE as AP_GL_DATE,o272382.VENDOR_NAME as 供应商名称,o272382.VENDOR_SITE_CODE as VENDOR_SITE_CODE,o272382.VAT_REGISTRATION_NUM as VAT_REGISTRATION_NUM,o272382.VOUCHER_NUM as VOUCHER_NUM,o272382.INVOICE_NUM as INVOICE_NUM,o272382.INVOICE_DATE as INVOICE_DATE,o272382.DESCRIPTION as DESCRIPTION,o272382.INVOICE_CURRENCY_CODE as INVOICE_CURRENCY_CODE,o272382.TERMS_DATE as TERMS_DATE,o272382.TERM_NAME as TERM_NAME,o272382.EXCHANGE_RATE as EXCHANGE_RATE,o272382.SOURCE_TYPE as SOURCE_TYPE,o272382.ACCOUNTING_DATE as ACCOUNTING_DATE,o272382.ORG_ID as ORG_ID,o272382.CREATION_DATE as CREATION_DATE,SUM(o272382.ACCOUNTED_AMOUNT) as 本币总计,SUM(o272382.REMAINING_AMOUNT) as 原币总计
 FROM (
select gcc.segment3||'.'||gcc.segment4 acct_no
       ,ai.gl_date AP_GL_DATE
       ,pv.vendor_name
     ,pvs.vendor_site_code
       ,nvl(pvs.attribute15,pv.attribute15) VAT_REGISTRATION_NUM
       ,to_char(nvl(ai.doc_sequence_value,ai.voucher_num)) Voucher_Num
       ,ai.invoice_num
       ,ai.invoice_date
       ,ai.description
       ,ai.invoice_currency_code
       ,ai.terms_date
       ,at.name term_name
       ,(NVL(xtb.entered_unrounded_cr,0)-NVL(xtb.entered_unrounded_dr,0)) Remaining_Amount
       ,nvl(ai.exchange_rate,1) Exchange_Rate
      ,(NVL(xtb.acctd_rounded_cr,0)-NVL(xtb.acctd_rounded_dr,0)) ACCOUNTED_AMOUNT
       ,'A.AP' source_type
       ,xah.accounting_date
      ,ai.org_id
        ,ai.creation_date
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
 ) o272382
 GROUP BY o272382.ACCT_NO,o272382.AP_GL_DATE,o272382.VENDOR_NAME,o272382.VENDOR_SITE_CODE,o272382.VAT_REGISTRATION_NUM,o272382.VOUCHER_NUM,o272382.INVOICE_NUM,o272382.INVOICE_DATE,o272382.DESCRIPTION,o272382.INVOICE_CURRENCY_CODE,o272382.TERMS_DATE,o272382.TERM_NAME,o272382.EXCHANGE_RATE,o272382.SOURCE_TYPE,o272382.ACCOUNTING_DATE,o272382.ORG_ID,o272382.CREATION_DATE
 HAVING (SUM(o272382.REMAINING_AMOUNT) <> 0)
