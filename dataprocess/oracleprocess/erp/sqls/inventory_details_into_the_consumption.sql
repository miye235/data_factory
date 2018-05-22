SELECT  o287073.ITEM_NUMBER,o287073.ITEM_DESCRIPTION,o287073.TRANSACTION_DATE_FM as TRANSACTION_DATE_FM,o287073.TRANSACTION_DATE_TO as TRANSACTION_DATE_TO,o287073.CATEGORY_NAME as CATEGORY_NAME,o287073.BEG_STK as BEG_STK,o287073.BEG_AMT as BEG_AMT,o287073.PO_STK_IN as PO_STK_IN,o287073.PO_IN_AMT as PO_IN_AMT,o287073.WIP_STK_IN as WIP_STK_IN,o287073.WIP_IN_AMT as WIP_IN_AMT,o287073.WIP_STK_OUT as WIP_STK_OUT,o287073.WIP_OUT_AMT as WIP_OUT_AMT,o287073.SO_STK_OUT as SO_STK_OUT,o287073.SO_OUT_AMT as SO_OUT_AMT,o287073.DEPT_STK_OUT as DEPT_STK_OUT,o287073.DEPT_OUT_AMT as DEPT_OUT_AMT,o287073.OTHER_STK_OUT as OTHER_STK_OUT,o287073.OTHER_OUT_AMT as OTHER_OUT_AMT,o287073.END_STK,o287073.END_AMT,o287073.END_UP as END_UP,o287073.STANDARD_COST as STANDARD_COST
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
