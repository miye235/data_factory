SELECT  o289349.JE_SOURCE_NAME as JE_SOURCE_NAME,o289349.VENDOR_NAME as VENDOR_NAME,o289349.ITEM_NUMBER as 物料编码,o289349.ITEM_DESCRIPTION as 物料名称,o289349.ACCOUNTING_DATE as ACCOUNTING_DATE,o289349.CURRENCY_CODE as CURRENCY_CODE,o289349.CURRENCY_CONVERSION_RATE as CURRENCY_CONVERSION_RATE,o289349.ENTERED_AMOUNT as ENTERED_AMOUNT,o289349.ACCOUNTED_AMOUNT as ACCOUNTED_AMOUNT,o289349.QUANTITY as 库存,o289349.RECEIPT_NUM as RECEIPT_NUM,o289349.PO_NUMBER as PO_NUMBER
 FROM ( select rrsl.je_source_name
       ,pv.vendor_name
       ,msi.segment1 item_number
       ,msi.description item_description
       ,rrsl.accounting_date
       ,rrsl.currency_code
       ,rrsl.currency_conversion_rate
       ,(NVL(rrsl.entered_dr,0)-NVL(rrsl.entered_cr,0)) Entered_Amount
       ,(NVL(rrsl.accounted_dr,0)-NVL(rrsl.accounted_cr,0)) Accounted_Amount
       ,rrsl.source_doc_quantity quantity
       ,rsh.receipt_num
       ,rrsl.reference4 po_number
       ,rsl.shipment_line_id
       ,rt.transaction_id
  from apps.rcv_receiving_sub_ledger rrsl
       ,apps.rcv_transactions rt
       ,apps.mtl_system_items msi
       ,apps.rcv_shipment_lines rsl
       ,apps.rcv_shipment_headers rsh
       ,apps.po_vendors pv
 where rt.transaction_id=rrsl.rcv_transaction_id
       and rt.shipment_line_id=rsl.shipment_line_id
       and rt.shipment_header_id=rsh.shipment_header_id
       and rsl.to_organization_id=msi.organization_id
       and rsl.item_id=msi.inventory_item_id
       and accounting_line_type like 'Receiving Inspection'
       and rt.vendor_id=pv.vendor_id
       and rrsl.set_of_books_id= '2021'
union all
select 'MTL'
       ,pv.vendor_name
       ,msi.segment1 item_number
       ,msi.description item_desc
       ,mmt.transaction_date
       ,mta.CURRENCY_CODE
       ,mta.CURRENCY_CONVERSION_RATE
       ,NVL(mta.transaction_value,mta.base_transaction_value) transaction_value
       ,mta.base_transaction_value
       ,mmt.transaction_quantity*-1
       ,rsh.receipt_num
       ,ph.segment1 po_number
       ,rt.shipment_line_id
       ,rt.transaction_id
  from apps.MTL_TRANSACTION_ACCOUNTS mta
       ,apps.mtl_material_transactions mmt
       ,apps.rcv_transactions rt
       ,apps.rcv_shipment_headers rsh
       ,apps.po_headers_all ph
       ,apps.po_vendors pv
       ,apps.mtl_system_items msi
where mta.transaction_id=mmt.transaction_id
      and mmt.rcv_transaction_id=rt.transaction_id
      and mmt.transaction_source_id=ph.po_header_id
      and mmt.organization_id=msi.organization_id
      and mmt.inventory_item_id=msi.inventory_item_id
      and rt.shipment_header_id=rsh.shipment_header_id
      and rt.vendor_id=pv.vendor_id
      and mta.transaction_source_type_id=1
      and mta.accounting_line_type=5
      and ph.org_id='81'
 ) o289349
