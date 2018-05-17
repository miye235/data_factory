SELECT  o272412.VENDOR_NUM as VENDOR_NUM,o272412.VENDOR_NAME as 供应商名称,o272412.VENDOR_SITE_NAME as VENDOR_SITE_NAME,o272412.VAT_REGISTRATION_NUM as VAT_REGISTRATION_NUM,o272412.INVOICE_NUM as INVOICE_NUM,o272412.INVOICE_DATE as INVOICE_DATE,o272412.GL_DATE as GL_DATE,o272412.VOUCHER_NUMBER as VOUCHER_NUMBER,o272412.DUE_DATE as DUE_DATE,o272412.INVOICE_CURRENCY_CODE as INVOICE_CURRENCY_CODE,o272412.GROSS_AMOUNT as 总额,o272412.HOLD_FLAG as HOLD_FLAG,o272412.BANK_NAME as BANK_NAME,o272412.BANK_BRANCH_NAME as BANK_BRANCH_NAME,o272412.BANK_NUMBER as BANK_NUMBER,o272412.BRANCH_NUMBER as BRANCH_NUMBER,o272412.AMOUNT_REMAINING as AMOUNT_REMAINING,o272412.PAYMENT_METHOD_CODE as PAYMENT_METHOD_CODE,o272412.COMPANY_ACCT as COMPANY_ACCT,o272412.SCHEDULES_BANK_ACCOUNT_NAME as SCHEDULES_BANK_ACCOUNT_NAME,o272412.SCHEDULES_BANK_ACCOUNT_NUM as SCHEDULES_BANK_ACCOUNT_NUM,o272412.INVOICE_BANK_ACCOUNT_NAME as INVOICE_BANK_ACCOUNT_NAME,o272412.INVOICE_BANK_ACCOUNT_NUM as INVOICE_BANK_ACCOUNT_NUM,o272412.STATUS as STATUS
 FROM ( select pv.segment1 vendor_num
      ,pv.vendor_name
      ,pvs.vendor_site_code vendor_site_name
      ,nvl(pvs.attribute15,pv.attribute15) VAT_REGISTRATION_NUM
      ,ai.invoice_num
      ,ai.invoice_date
      ,ai.gl_date
      ,ai.doc_sequence_value  voucher_number
      ,aps.due_date
      ,ai.invoice_currency_code
      ,aps.gross_amount
      ,aps.hold_flag
      ,ai.payment_method_code
      ,cbb.bank_name
      ,cbb.bank_branch_name
      ,cbb.bank_number
      ,cbb.branch_number
      ,ieba.bank_account_name  schedules_bank_account_name
      ,ieba.bank_account_num   schedules_bank_account_num
      ,ieba1.bank_account_name  invoice_bank_account_name
      ,ieba1.bank_account_num   invoice_bank_account_num
      ,(case when nvl(ieba.bank_account_num,0)=nvl(ieba1.bank_account_num,0) then 'Y'  else 'N'  end)  status
      ,aps.amount_remaining
      ,gcc.segment1  company_acct
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
 ) o272412
