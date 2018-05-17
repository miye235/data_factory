SELECT  o283859.ORGANIZATION_CODE as ORGANIZATION_CODE,o283859.ITEM_NUMBER as 物料编码,o283859.DESCRIPTION as 物料名称,o283859.FACTORY_APPROVED as FACTORY_APPROVED,o283859.KNIFEID as KNIFEID,o283859.UNIT_LENGTH as UNIT_LENGTH,o283859.UNIT_WIDTH as UNIT_WIDTH,o283859.UNIT_WEIGHT as UNIT_WEIGHT,o283859.SHELF_LIFE_DAYS as SHELF_LIFE_DAYS,o283859.STATUS as STATUS,o283859.PRIMARY_UNIT_OF_MEASURE as PRIMARY_UNIT_OF_MEASURE,o283859.CREATION_DATE as CREATION_DATE,o283859.INVENTORY_MAIN_CATEGORY as INVENTORY_MAIN_CATEGORY,o283859.INVENTORY_SUB_CATEGORY as INVENTORY_SUB_CATEGORY,o283859.PURCHASING_MAIN_CATEGORY as PURCHASING_MAIN_CATEGORY,o283859.PURCHASING_SUB_CATEGORY as PURCHASING_SUB_CATEGORY
 FROM ( SELECT MP.ORGANIZATION_CODE,
       MSI.ORGANIZATION_ID,
       MSI.INVENTORY_ITEM_ID,
       MSI.SEGMENT1 ITEM_NUMBER,
       MSI.DESCRIPTION,
       msi.PRIMARY_UNIT_OF_MEASURE,
       MSI.ATTRIBUTE1 FACTORY_APPROVED,
       MSI.ATTRIBUTE2 KNIFEID,
       msi.unit_length,
       msi.unit_width,
       msi.unit_weight,
       msi.SHELF_LIFE_DAYS
       ,msi.INVENTORY_ITEM_STATUS_CODE status
       ,(select mcbk.SEGMENT1 from apps.MTL_CATEGORIES_b_kfv mcbk,apps.MTL_ITEM_CATEGORIES mic
          where mic.INVENTORY_ITEM_ID = msi.inventory_item_id
                and mic.organization_id=msi.organization_id
                and mic.category_id=mcbk.category_id
                and mic.category_set_id = '1') INVENTORY_MAIN_CATEGORY
       ,(select mcbk.SEGMENT2 from apps.MTL_CATEGORIES_b_kfv mcbk,apps.MTL_ITEM_CATEGORIES mic
          where mic.INVENTORY_ITEM_ID = msi.inventory_item_id
                and mic.organization_id=msi.organization_id
                and mic.category_id=mcbk.category_id
                and mic.category_set_id = '1') INVENTORY_SUB_CATEGORY
       ,(select mcbk.SEGMENT1 from apps.MTL_CATEGORIES_b_kfv mcbk,apps.MTL_ITEM_CATEGORIES mic
          where mic.INVENTORY_ITEM_ID = msi.inventory_item_id
                and mic.organization_id=msi.organization_id
                and mic.category_id=mcbk.category_id
                and mic.category_set_id = '1100000041') PURCHASING_MAIN_CATEGORY
       ,(select mcbk.SEGMENT2 from apps.MTL_CATEGORIES_b_kfv mcbk,apps.MTL_ITEM_CATEGORIES mic
          where mic.INVENTORY_ITEM_ID = msi.inventory_item_id
                and mic.organization_id=msi.organization_id
                and mic.category_id=mcbk.category_id
                and mic.category_set_id = '1100000041') PURCHASING_SUB_CATEGORY
       ,msi.CREATION_DATE
  FROM apps.MTL_SYSTEM_ITEMS MSI, apps.MTL_PARAMETERS MP, apps.fnd_responsibility_vl frv
 WHERE MSI.ORGANIZATION_ID = MP.ORGANIZATION_ID
  AND MP.ORGANIZATION_ID IN
    (SELECT ORGANIZATION_ID
        FROM apps.ORG_ACCESS
       WHERE RESPONSIBILITY_ID = frv.responsibility_id
 )) o283859;
