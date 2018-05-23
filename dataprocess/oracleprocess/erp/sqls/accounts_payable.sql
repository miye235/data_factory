SELECT  o272412.VENDOR_NUM as 供应商编号,o272412.VENDOR_NAME as 供应商名称,o272412.INVOICE_DATE as 发票日期,o272412.INVOICE_NUM as 发票号码,to_char(o272412.DUE_DATE,'yyyy-mm-dd') as 到期日,o272412.GROSS_AMOUNT as 总金额,o272412.AMOUNT_REMAINING as 剩余金额,o272412.STATUS as 状态
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
where o272412.AMOUNT_REMAINING <> 0
and to_char(o272412.DUE_DATE,'yyyy-mm-dd') <= '2018-05-22'
order by to_char(o272412.DUE_DATE,'yyyy-mm-dd')
