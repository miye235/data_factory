select distinct ROW_ID,ITEM_NUMBER,ITEM_COST,LAST_UPDATE_DATE from APPS.CST_ITEM_COST_TYPE_V
where  ITEM_COST != 0
and LAST_UPDATE_DATE>=to_date('yesterday 00:00:00','yyyy/mm/dd hh24:mi:ss')
ORDER BY LAST_UPDATE_DATE desc