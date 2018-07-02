select ITEM_COST from offline.materialprice
where COST_TYPE= 'Frozen'
  and ITEM_COST != 0
  and ITEM_NUMBER = 'thisno'