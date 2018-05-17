SELECT  o287518.VENDOR_NAME as 供应商名称,o287518.CURRENCY_CODE as CURRENCY_CODE,o287518.AMOUNT as 原币,o287518.ACCOUNTED_AMOUNT as 本币,o287518.SOURCE_DOC_QUANTITY as SOURCE_DOC_QUANTITY,o287518.RECEIPT_NUM as RECEIPT_NUM,o287518.ITEM_NUMBER as ITEM_NUMBER,o287518.PO_NUMBER as PO_NUMBER
 FROM ( select 'A.'||rrsl.je_source_name Source
       ,rrsl.accounting_date
       ,pv.vendor_name
       ,rrsl.JE_HEADER_NAME
       ,rrsl.currency_code
       ,NVL(rrsl.ENTERED_cr,0)-nvl(rrsl.entered_dr,0) Amount
       ,rrsl.CURRENCY_CONVERSION_RATE EX_RATE
       ,NVL(rrsl.accounted_cr,0)-NVL(rrsl.accounted_dr,0) Accounted_Amount
,decode(rt.transaction_type,'RECEIVE',rrsl.SOURCE_DOC_QUANTITY,-rrsl.source_doc_quantity) source_doc_quantity
       ,rsh.receipt_num
       ,msi.segment1 item_number
       ,rsl.item_description description
       ,YI.CATEGORY_SEG1
       ,YI.CATEGORY_SEG2
       ,rrsl.reference4 po_number
       ,rrsl.rcv_transaction_id
       ,trunc(rsh.creation_date) receipt_date
       ,gcc.segment3 main_acct
  from apps.rcv_receiving_sub_ledger rrsl
       ,apps.gl_code_combinations gcc
       ,apps.rcv_transactions rt
       ,apps.rcv_shipment_headers rsh
       ,apps.rcv_shipment_lines rsl
       ,apps.mtl_system_items msi
       ,apps.po_vendors pv
       ,apps.ywms_item yi
 where gcc.code_combination_id=rrsl.code_combination_id
       and rrsl.rcv_transaction_id=rt.transaction_id
       and rt.shipment_header_id=rsh.shipment_header_id
       and rt.shipment_line_id=rsl.shipment_line_id
       and rsl.to_organization_id=msi.organization_id(+)
       and rsl.item_id=msi.inventory_item_id(+)
       and rsl.to_organization_id= yi.organization_id(+)
       and rsl.item_id=yi.inventory_item_id(+)
       and rt.vendor_id=pv.vendor_id
       and rrsl.accounting_line_type like 'Accrual'
       and rrsl.set_of_books_id='2021'
union all
select 'B.'||'AP Invoice' Source
       ,ai.gl_date
       ,pv.vendor_name
       ,to_char(ai.doc_sequence_value) voucher_num
       ,aal.CURRENCY_CODE
       ,nvl(xdl.unrounded_ENTERED_cr,0)-nvl(xdl.unrounded_entered_dr,0) Amount
       ,NVL(aal.currency_conversion_rate,1) currency_conversion_rate
       ,NVL(xdl.unrounded_accounted_cr,0)-nvl(xdl.unrounded_accounted_dr,0) Accounted_Amount
       ,quantity_invoiced * -1
       ,rsh.receipt_num
       ,msi.segment1 item_number
       ,rsl.item_description description
       ,YI.CATEGORY_SEG1
       ,YI.CATEGORY_SEG2
       ,ph.segment1 po_number
       ,rt.transaction_id
       ,trunc(rsh.creation_date) receipt_date
      ,gcc.segment3
  from apps.xla_ae_lines aal
       ,apps.xla_distribution_links xdl
       ,apps.ap_invoices_all ai
       ,apps.ap_invoice_distributions_all aida
       ,apps.rcv_transactions rt
       ,apps.rcv_shipment_headers rsh
       ,apps.rcv_shipment_lines rsl
       ,apps.mtl_system_Items msi
       ,apps.gl_code_combinations gcc
       ,apps.po_headers_all ph
       ,apps.po_vendors pv
       ,apps.ywms_item yi
 where ai.invoice_id=aida.invoice_id
       and aal.application_id=xdl.application_id
       and aal.ae_header_id=xdl.ae_header_id
       and aal.ae_line_num = xdl.ae_line_num
       and xdl.source_distribution_id_num_1 = aida.invoice_distribution_id(+)
       and aal.CODE_COMBINATION_ID=gcc.code_combination_id
       and aal.application_id = 200
       and aida.rcv_transaction_id=rt.transaction_id
       and rt.shipment_header_id=rsh.shipment_header_id
       and rt.shipment_line_id=rsl.shipment_line_id
       and rsl.to_organization_id= msi.organization_id(+)
       and rsl.to_organization_id= yi.organization_id(+)
       and rsl.item_id=yi.inventory_item_id(+)
       and rsl.item_id=msi.inventory_item_id(+)
       and rt.po_header_id=ph.po_header_id
       and aal.accounting_class_code in ('ACCRUAL','NRTAX')
       and ph.vendor_id=pv.vendor_id
       and ai.set_of_books_id='2021'
 ) o287518
 WHERE (o287518.MAIN_ACCT = '2151');
