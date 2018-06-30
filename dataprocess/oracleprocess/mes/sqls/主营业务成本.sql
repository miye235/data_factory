select  商品名称,尺寸,类别,计量单位,sum(数量) 数量,case when sum(成本金额)=0 then 0 else round(sum(成本金额)/sum(数量),2) end 单价,sum(成本金额) 成本金额
    from(SELECT  o289371.ITEM_NUMBER as 商品名称,regexp_substr(o289371.ITEM_DESCRIPTION,'\d+?\.?\d+?["|m]+',1) as 尺寸,o289371."Inventory Category" as 类别,o289371.PRIMARY_UOM_CODE as 计量单位,TRANSACTION_QUANTITY as 数量,o289371.COGS as 成本金额
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
           ,(case when (select count(*) from apps.OE_ORDER_LINES_all oola,apps.OE_TRANSACTION_TYPES_TL lt
                where  oola.line_id = tmp.txn_id and oola.line_type_id=lt.TRANSACTION_TYPE_ID
                  and LT.language = 'US' and (DESCRIPTION like '%折讓%'OR DESCRIPTION like '%樣品%'))>0 then 0
                 else tmp.transaction_quantity end) transaction_quantity
           ,tmp.revenue_amount
           ,(CASE WHEN (select COUNT(*) from apps.OE_ORDER_LINES_all oola ,apps.OE_TRANSACTION_TYPES_TL LT  where  oola.line_id = tmp.txn_id and oola.line_type_id=lt.TRANSACTION_TYPE_ID and LT.language = 'US' and DESCRIPTION like '%樣品%')>0 THEN 0 ELSE cogs_material END)
           +(CASE WHEN (select COUNT(*) from apps.OE_ORDER_LINES_all oola ,apps.OE_TRANSACTION_TYPES_TL LT  where  oola.line_id = tmp.txn_id and oola.line_type_id=lt.TRANSACTION_TYPE_ID and LT.language = 'US' and DESCRIPTION like '%樣品%')>0 THEN 0 ELSE cogs_resource END)
           +(CASE WHEN (select COUNT(*) from apps.OE_ORDER_LINES_all oola ,apps.OE_TRANSACTION_TYPES_TL LT  where  oola.line_id = tmp.txn_id and oola.line_type_id=lt.TRANSACTION_TYPE_ID and LT.language = 'US' and DESCRIPTION like '%樣品%')>0 THEN 0 ELSE cogs_overhead END) cogs
          -- ,(cogs_material+cogs_resource+cogs_overhead) cogs
           ,(tmp.revenue_amount - (cogs_material+cogs_resource+cogs_overhead)) profit
           ,cogs_acct
           ,tmp.deferred,mcs.category_set_name
      from  apps.YCST_COGS_TMP tmp
           ,apps.mtl_system_items msi
           ,apps.mtl_item_categories mic
           ,apps.mtl_categories_b mcb
           ,apps.mtl_category_sets_tl mcs
           ,APPS.FND_USER FU
     where tmp.organization_id=msi.organization_id
           and tmp.inventory_item_id=msi.inventory_item_id
           and msi.organization_id=mic.organization_id
           and msi.inventory_item_id=mic.inventory_item_id
           and mic.category_id=mcb.category_id
           and mic.category_set_id=mcs.category_set_id
           and mcs.category_set_name like 'Inventory%'
           and tmp.created_by = FU.USER_ID
           and FU.USER_ID = 'userid'
      and tmp.ORGANIZATION_ID = '102'
           AND TO_CHAR(tmp.CREATION_DATE,'YYYY-MM-dd') = 'date'
    --        AND tmp.TRANSACTION_NUMBER NOT LIKE '12%'
    --      and msi.segment1 = 'FHKR00200901A'

     ) o289371
    )
    group by 商品名称,尺寸,类别,计量单位
    order by 类别

