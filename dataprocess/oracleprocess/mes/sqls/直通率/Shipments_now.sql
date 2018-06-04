SELECT DISTINCT
   D .TRANSACTION_QTY AS "出货数量",
   D .ITEM_CODE AS "成品料号",
   to_date(D.REMOVE_TIME,'yyyy/mm/dd hh24:mi:ss') "出库时间"
  FROM
   (
    SELECT
     *
    FROM
     (
      SELECT
       B.TRANSACTION_QTY,
       A .ITEM_CODE,
       B.SUBINVENTORY,
       B.REMOVE_TIME
      FROM
       WMS.A_INVENTORY_HIST A
      JOIN WMS.A_ERP_DELIVERY_DTL_HIST B ON B.INVENTORY_ITEM_ID = A .ITEM_ID
     ) C
    WHERE
 C.SUBINVENTORY IN ('F1FGA', 'F1FGB', 'F1CAA')
   ) D
order by to_date(D.REMOVE_TIME,'yyyy/mm/dd hh24:mi:ss') desc