import sys,os
sys.path.append('/home/openstack/data_offline/data_factory/')
from dataprocess.oracleprocess.mes.base import Base
class Wms_Erp(object):
    def __init__(self):
        super(Wms_Erp, self).__init__()
    def trandata(self,df):
        if str(df['ORG名称'])=='102':
            return '昆山奇材廠'
        elif df['ORG名称']=='昆山奇材廠':
            return '昆山'
        else:
            return df['ORG名称']
    def __call__(self, conns):
        erp = conns['erp']
        offline = conns['offline']
        wms = conns['wms']
        base = Base()
        sql1 = '''
        select DISTINCT
B.SEGMENT1 料号 
,B.DESCRIPTION 品名
,A.TRANSACTION_UOM 单位
,A.TRANSACTION_QUANTITY 数量
,A.organization_id 厂区
,A.subinventory_code 仓别
,TO_CHAR(A.TRANSACTION_DATE,'yyyy-mm-dd') 日期
from apps.MTL_MATERIAL_TRANSACTIONS A 
,apps.MTL_SYSTEM_ITEMS B
where 
B.INVENTORY_ITEM_ID = A.INVENTORY_ITEM_ID
and a.organization_id=b.organization_id
AND A.subinventory_code in('F1SCA', 'S1SCA', 'S1SCB', 'F1SCB')
        '''
        sql2 = '''
        SELECT * FROM 
        (SELECT 
         (case 
           when  A.TO_ERP='1' then
            'V'
            else
           NULL
           end) as ERP,
            A.ITEM_CODE AS 料号,
            A.ITEM_DESCRIPTION AS 品名,
            A.PRIMARY_UOM_CODE AS 单位,
            A.CARTON_NO AS 收料标签IDor箱号,
            A.PALLET_NO AS 标签id,
            A.CARRIER_TYPE AS 栈板大小,
            A.STAGE_SIZE AS 载台尺寸,
            A.LOT_NO as 批号,
            A.ERP_LOT_NUMBER as ERP批号,
            A.QTY as 数量,
            A.AREA_NAME as 库存区域名称,
            A.SUBINVENTORY_NAME as 仓别名称,
            A.SUBINVENTORY_CODE as SUBINVENTORY,
                  (case 
              when  (A.SUBINVENTORY_CODE='FQFGA' or  A.SUBINVENTORY_CODE='FQSCA' or 
                    A.SUBINVENTORY_CODE='SQSGA' or  A.SUBINVENTORY_CODE='FQFBA')
              then '重庆'
              when  (A.SUBINVENTORY_CODE='FXFGA' or  A.SUBINVENTORY_CODE='SXSGA' or 
                    A.SUBINVENTORY_CODE='FXSCA' or  A.SUBINVENTORY_CODE='FXFBA')
              then '咸阳'
                    when A.SUBINVENTORY_CODE is null then null
            else
             '昆山'
           end) as 地区,
            A.LOCATION_NAME  as  库位,
            A.RECEIPT_DATE as 收料日,
            A.EXPIRED_DATE as 到期日,
            A.BND as 保税,
            A.QC_STATUS as STATUS,
            A.FACTORY as 厂区,
            A.ORG_NAME as ORG名称,
            A.MODIFY_LIST_NO as 最后异动单号,
            (SELECT USER_NAME FROM WMS.A_USER WHERE USER_NO = A.MODIFY_USER_NO) as 最后作业人员,
            A.UPDATE_TIME as 最后作业时间,
             (case 
           when  A.LOCKED='1' then
            'V'
            else
           NULL
           end) as 是否被锁定,
            A.EXPIRED_LOCKED as 效期上锁,
                (case 
           when   A.MANUAL_LOCKED='1' then
            'V'
            else
           NULL
           end) as QC手动上锁,
            (SELECT USER_NAME FROM WMS.A_USER WHERE USER_NO = A.LOCKED_USER) AS 锁定者 ,
            A.LOCKED_REASON as 锁定原因,
             (case 
           when   A.LOCKED_TYPE='Expired' then '已过期'
           when   A.LOCKED_TYPE='Manual' then '人员锁定'
            else
           NULL
           end) as 锁定类型,

            A.INBOUND_LIST_NO as 入库单号,
            A.INBOUND_CLIENT_NO as 入库作业站,
            A.TO_ERP_TIME as 上抛ERP时间,
            A.CATEGORY_SEG1 as 库存种类,
            A.RESERVED as 是否已被预约,
            A.RESERVED_LIST_NO as 预约单据号码,
            A.QC_TIME as QC判定时间,
            A.QC_USER as QC判定人员,
            A.TEMPORART_STORAGE as 暂存品,
            A.TEMPORART_GROUP as 暂存品群组名称,

                (SELECT LIST_TYPE_NAME FROM WMS.A_LIST_SETTING WHERE LIST_TYPE = A.INBOUND_LIST_TYPE) as 单号种类
            FROM WMS.V_INVENTORY A ) B
        where  标签id not like '%MP%' AND 标签id not like '%EMPU%'
        '''
        res1 = erp.doget(sql1)
        res1.columns = ['料号','品名','单位','数量','ORG名称','SUBINVENTORY', '收料日']
        res1['ORG名称']=res1.apply(lambda r:self.trandata(r),axis=1)
        res1['地区']=res1.apply(lambda r:self.trandata(r),axis=1)
        res2 = wms.doget(sql2)
        offline.dopost("truncate table warehouse_report")
        base.batchwri(res1, 'warehouse_report', offline)
        base.batchwri(res2, 'warehouse_report', offline)
base = Base()
erp = base.conn('erp')
offline = base.conn('offline')
wms = base.conn('wms')
mes = base.conn('mes')
conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
hz=Wms_Erp()
hz(conns)
offline=base.conn('offline_test')
conns['offline']=offline
hz(conns)
offline.close()
erp.close()
wms.close()
mes.close()
