SELECT  SUBSTRB(o289371.ITEM_DESCRIPTION,INSTR(o289371.ITEM_DESCRIPTION,';',1,2)+1,INSTR(o289371.ITEM_DESCRIPTION,';',2,3)-INSTR(o289371.ITEM_DESCRIPTION,';',1,2)-1) as 类别,NVL(( ( o289371.UNIT_LENGTH*o289371.UNIT_WIDTH )/1000000 )*o289371.TRANSACTION_QUANTITY,0) as AREA,o289371.CUSTOMER_NAME as CUSTOMER_NAME,o289371.TRANSACTION_NUMBER as TRANSACTION_NUMBER,o289371.TRANSACTION_QUANTITY as 数量,o289371.REVENUE_AMOUNT as REVENUE_AMOUNT,o289371.COGS_MATERIAL as COGS_MATERIAL,o289371.COGS_RESOURCE as COGS_RESOURCE,o289371.COGS_OVERHEAD as COGS_OVERHEAD,o289371.DEFERRED as DEFERRED,o289371.COGS_ACCT as COGS_ACCT,o289371."Inventory Category" as INVENTORY_CATEGORY,o289371.ITEM_NUMBER as 商品名称,o289371.ITEM_DESCRIPTION as ITEM_DESCRIPTION,o289371.PRIMARY_UOM_CODE as 计量单位,o289371.COGS as COGS,o289371.PROFIT as PROFIT
 FROM ( select tmp.txn_type
       ,tmp.customer_name
       ,tmp.transaction_number
       ,tmp.txn_id
       ,mcb.segment1||'.'||mcb.segment2  "Inventory Category"
       ,msi.segment1 item_number
       ,msi.description item_description
       ,msi.primary_uom_code
       ,msi.unit_length
       ,msi.unit_width
       ,msi.unit_weight
       ,tmp.transaction_quantity
       ,tmp.revenue_amount
       ,cogs_material
       ,cogs_resource
       ,cogs_overhead
       ,(cogs_material+cogs_resource+cogs_overhead) cogs
       ,(tmp.revenue_amount - (cogs_material+cogs_resource+cogs_overhead)) profit
       ,cogs_acct
       ,tmp.deferred,mcs.category_set_name
  from  apps.YCST_COGS_TMP tmp
       ,apps.mtl_system_items msi
       ,apps.mtl_item_categories mic
       ,apps.mtl_categories_b mcb
       ,apps.mtl_category_sets_tl mcs ,APPS.FND_USER FU
 where tmp.organization_id=msi.organization_id
       and tmp.inventory_item_id=msi.inventory_item_id
       and msi.organization_id=mic.organization_id
       and msi.inventory_item_id=mic.inventory_item_id
       and mic.category_id=mcb.category_id
       and mic.category_set_id=mcs.category_set_id
       and mcs.category_set_name like 'Inventory%'
       and tmp.created_by = FU.USER_ID
 ) o289371
 ORDER BY o289371.COGS_ACCT ASC ;
