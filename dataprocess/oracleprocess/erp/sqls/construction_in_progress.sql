SELECT  o279072.ASSET_NUMBER as 资产编号,o279072.ASSET_TYPE as ASSET_TYPE,o279072.VENDOR_NUMBER as VENDOR_NUMBER,o279072.VENDOR_NAME as VENDOR_NAME,o279072.PAYABLES_BATCH_NAME as PAYABLES_BATCH_NAME,o279072.PO_NUMBER as PO_NUMBER,o279072.INVOICE_NUMBER as INVOICE_NUMBER,o279072.INVOICE_LINE_NUMBER as INVOICE_LINE_NUMBER,o279072.DESCRIPTION as DESCRIPTION,o279072.DELETED_FLAG as DELETED_FLAG,o279072.FIXED_ASSETS_COST as FIXED_ASSETS_COST,o278338.FA_CATEGORY as FA_CATEGORY
 FROM ( select fb.book_type_code
       ,fab.asset_number
       ,fat.description
       ,fab.current_units
       ,fab.asset_type
       ,fab.tag_number
	   ,fab.SERIAL_NUMBER
	   ,fab.IN_USE_FLAG
	   ,fab.inventorial
       ,fab.model_number
       ,substr(fab.attribute_category_code,1,instr(fab.attribute_category_code,'.',1)-1) fa_main_category
       ,substr(fab.attribute_category_code,instr(fab.attribute_category_code,'.',1)+1) fa_sub_category
       ,fab.attribute_category_code fa_category
       ,fb.date_placed_in_service
       ,fb.deprn_method_code
       ,fb.life_in_months
       ,fb.cost
       ,fb.adjusted_cost
       ,fb.original_cost
       ,fb.salvage_value
       ,fb.prorate_date
       ,fb.CAPITALIZE_FLAG
       ,fb.depreciate_flag
       ,fab.attribute1 "tax credit allowance num"
       ,fab.manufacturer_name
       ,pfa.asset_number parent_asset_number
       ,fb.asset_id
  from apps.fa_additions_b fab
       ,apps.fa_additions_tl fat
       ,apps.fa_books   fb
       ,apps.fa_book_controls fbc
       ,apps.fa_additions_b pfa
 where fbc.book_type_code=fb.book_type_code
       and fb.asset_id=fab.asset_id
       and fab.asset_id=fat.asset_id
       and fb.date_ineffective is null
       and fab.parent_asset_id=pfa.asset_id(+)
       and set_of_books_id='2021'
 order by fab.asset_number
 ) o278338,
      ( select b.asset_number, asset_type
           ,vendor_number
           ,vendor_name
           ,payables_batch_name
           ,po_number
           ,invoice_number
           ,invoice_line_number
           ,description
           ,deleted_flag
           ,fixed_assets_cost
           ,inv.asset_id
 from apps.FA_INVOICE_DETAILS_V inv
          ,apps.fa_additions_b b
where inv.asset_id = b.asset_id
 ) o279072
 WHERE ( (o278338.ASSET_ID = o279072.ASSET_ID))
   AND (o279072.ASSET_TYPE = 'CIP')
