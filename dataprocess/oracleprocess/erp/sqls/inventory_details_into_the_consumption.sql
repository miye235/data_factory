SELECT  o287073.ITEM_NUMBER as 物料编码,o287073.ITEM_DESCRIPTION as 物料名称,substr(to_char(o287073.TRANSACTION_DATE_FM,'yyyy-mm-dd'),0,7) as 日期,o287073.END_STK as 库存,o287073.END_AMT as 金额
 FROM ( select msi.segment1 item_number
       ,msi.description item_description
       ,transaction_date_fm
       ,transaction_date_to
       ,mcb.segment1 category_name
       ,beg_stk,       beg_amt
       ,po_stk_in,     po_in_amt
       ,wip_stk_in,    wip_in_amt
       ,wip_stk_out,   wip_out_amt
       ,so_stk_out,    so_out_amt
       ,dept_stk_out,  dept_out_amt
       ,other_stk_out, other_out_amt
       ,end_stk,       end_amt
       ,decode(end_stk,0,0,round(end_amt/end_stk,4)) end_up
       ,NVL(standard_cost,0) standard_cost
       ,mp.organization_code
       ,msi.organization_id
       ,msi.inventory_item_id
  from apps.ycst_mtl_io_dtls_tmp mio
       ,apps.mtl_system_items msi
       ,apps.mtl_item_categories mic
       ,apps.mtl_categories_b mcb
       ,apps.mtl_category_sets_tl mcs
       ,apps.mtl_parameters mp, APPS.FND_USER FU, APPS.FND_RESPONSIBILITY_VL FRV
 where mio.organization_id=msi.organization_id
       and mio.inventory_item_id=msi.inventory_item_id
       and msi.organization_id=mic.organization_id
       and msi.inventory_item_id=mic.inventory_item_id
       and mic.category_id=mcb.category_id
       and mic.category_set_id=mcs.category_set_id
       and mcs.category_set_name like 'Inventory%'
       and mio.organization_id=mp.organization_id
       and mp.organization_id in (select organization_id from apps.org_access where responsibility_id = FRV.RESPONSIBILITY_ID
          )and mio.created_by=FU.USER_ID
 ) o287073
 group by o287073.ITEM_NUMBER,o287073.ITEM_DESCRIPTION,substr(to_char(o287073.TRANSACTION_DATE_FM,'yyyy-mm-dd'),0,7),o287073.TRANSACTION_DATE_TO,o287073.END_STK,o287073.END_AMT
 order by o287073.ITEM_NUMBER
 