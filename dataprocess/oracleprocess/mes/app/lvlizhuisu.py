from common.DbCommon import mysql2pd,oracle2pd
import pandas as pd

def sltmer(lotid,ope=None):
    '''
    获取分批并批信息
    :param lotid: 子批lot
    :param ope: 操作筛选
    :return: dataframe形式父批lot
    '''
    slt=ora.getdata('MES.MES_WIP_SPLIT',['SUBLOT','PARENTLOT','OPERATION'],tjs=["SUBLOT="+"'"+lotid+"'"])
    merge=ora.getdata('MES.MES_WIP_MERGE',['SUBLOT','PARENTLOT','OPERATION'],tjs=["SUBLOT="+"'"+lotid+"'"])
    if ope!=None:
        slt=slt[slt['OPERATION'].str.contains(ope)]
        merge = merge[merge['OPERATION'].str.contains(ope)]
    if slt.empty and merge.empty:
        res = pd.DataFrame([[lotid,lotid,None]],columns=['SUBLOT','PARENTLOT','OPERATION'])
    elif not slt.empty:
        res = slt.drop_duplicates().dropna()
    else:
        res = merge.drop_duplicates().dropna()

    return  res
def nondata(lotid):
    '''
    获取表MES.MES_WIP_LOT_NONACTIVE中的数据
    :param lotid: 限制lot号
    :return: dataframe形式的查询结果
    '''
    return ora.getdata('MES.MES_WIP_LOT_NONACTIVE',['LOT','MATERIAL','PALLET','QUANTITY','CUSTLOT','DEVICE'],tjs=["LOT="+"'"+lotid+"'"])


#处理数据
def gethist(lot,ope=None):
    '''
    根据lot和operation取MES.MES_WIP_HIST表中的数据
    :param lot: lot号限制
    :param ope: 操作限制
    :return: dataframe形式的查询结果
    '''
    df=ora.getdata('MES.MES_WIP_HIST',pars=['LOT','OLDRESOURCE','OPERATIONNO','OLDOPERATION','TRANSACTIONTIME', 'NEWQUANTITY','TRANSACTION','ACTIVITY'],tjs=["LOT='"+lot+"'"])
    if ope!= None:df=df[df['OLDOPERATION'].str.contains(ope)]
    # print(df)
    df1=df[df['TRANSACTION'].str.contains('CheckIn')]
    if df1['TRANSACTIONTIME'].empty:
        intime='null'
    else:
        intime=df1['TRANSACTIONTIME'].values[0]
    inqty =sum([float(a) for a in df1['NEWQUANTITY'].values])
    df2=df[df['TRANSACTION'].str.contains('CheckOut')]
    if df2['TRANSACTIONTIME'].empty:
        outtime='null'
    else:outtime=df2['TRANSACTIONTIME'].values[0]
    outqty =sum([float(a) for a in df2['NEWQUANTITY'].values])
    return df,intime,outtime,inqty,outqty
def mmsdata(lot):
    '''
    根据批号取MES.MES_MMS_HIST表中的原物料信息
    :param lot:
    :return:
    '''
    df = ora.getdata('MES.MES_MMS_HIST',pars=['LOT', 'MLOT','MATERIALNO','LOTQTY' ,'TRANSACTIONTIME','ACTIVITY'], tjs=["LOT='" + lot + "'"])
    return df.drop_duplicates().dropna()


def doit(c):
    '''
    按c开始追溯
    :param c:
    :return:
    '''
    fin=[]
    df1=nonact[nonact['PALLET']==c]
    sltlot=df1['MATERIAL'].drop_duplicates().dropna()#找出对应分条号
    for sid in sltlot.values:

        slt_df, slt_intime, slt_outtime, slt_inqty, slt_outqty = gethist(sid)
        df2=nonact[nonact['MATERIAL']==sid].drop_duplicates().dropna()
        cqlot=df2[df2['LOT'].str.contains('-B-')]
        pkg2b=cqlot[cqlot['MATERIAL'].str.match('\d*')]#包装换厂裁切
        sl=df1[[x.isdigit() for x in df1['LOT'].values]]
        flag=[not f for f in sl['LOT'].isin(cqlot['MATERIAL'].values)]
        baozlot=sl[flag]['LOT'].drop_duplicates().dropna().values#裁切后包装，包装号，分条号，客户号
        for bzno in baozlot:
            pkg_df=nondata(bzno).drop_duplicates().dropna()
            pkg_custlot,pkg_qty=pkg_df['CUSTLOT'].values[0],pkg_df['QUANTITY'].values[0]
            sltdf=sltmer(bzno)
            # print(sltdf)
            # xx=sltdf[sltdf['OPERATION'].str.contains('包')]
            for cqno in sltdf['PARENTLOT'].drop_duplicates().dropna().values:
                poutlot,pout_custlot, pout_qty='null','null','null'
                if cqno in pkg2b['LOT'].values:
                    pout=pkg2b[pkg2b['LOT']==cqno]['MATERIAL'].drop_duplicates().dropna().values
                    #换厂包装信息，不需要，暂时注释掉
                    # for p in pout:
                    #     poutlot=p
                    #     pout_df = nondata(p).drop_duplicates().dropna()
                    #     pout_custlot, pout_qty = pout_df['CUSTLOT'].values[0], pout_df['QUANTITY'].values[0]
                cq_df,cq_intime,cq_outtime,cq_inqty,cq_outqty = gethist(cqno)
                cq_sta=cq_df['OLDRESOURCE'].drop_duplicates().dropna().values[0]
                # print(sid)
                for s in sltmer(sid)['PARENTLOT'].drop_duplicates().dropna().values:
                    for qdlot in nondata(s)['MATERIAL'].drop_duplicates().dropna().values:
                        # print(qdlot)
                        if qdlot.find('RT')!=-1:
                            resfin = [0,'null','null','null','null','null', \
                                      'null','null','null','null','null', \
                                      'null','null','null','null','null', \
                                      'null','null','null','null',\
                                                s, slt_inqty, slt_outqty,slt_intime, slt_outtime, \
                                                cqno,cq_sta,cq_inqty,cq_outqty,cq_intime,cq_outtime,\
                                                bzno,pkg_custlot,pkg_qty,c]
                            fin.append(resfin)
                        else:
                            for psalot in sltmer(qdlot,'PSA')['PARENTLOT'].drop_duplicates().dropna().values:
                            # psalot=qdlot
                                print(psalot)
                                sc_df,sc_intime,sc_outtime,sc_inqty,sc_outqty=gethist(psalot,'AGING')
                                psa_df,psa_intime,psa_outtime,psa_inqty, psa_outqty =gethist(psalot,'PSA')
                                for pva in sltmer(psalot,'PVA')['PARENTLOT'].drop_duplicates().dropna().values:
                                    pva_df, pva_intime, pva_outtime, pva_inqty, pva_outqty = gethist(pva,'PVA')
                                    mlot_df=mmsdata(pva)
                                    for mlot in mlot_df['MLOT'].drop_duplicates().dropna().values:
                                        pva_inqty=sum(mlot_df[mlot_df['ACTIVITY']== 'EQPUnloadMaterial']['LOTQTY'].values)
                                        front_device=nondata(pva)['DEVICE'].drop_duplicates().dropna().values[0]
                                        pva_intime = mlot_df['TRANSACTIONTIME'].drop_duplicates().dropna().values[0]
                                        materialno=mlot_df['MATERIALNO'].drop_duplicates().dropna().values[0]
                                        mat_df=ora.getdata('MES.MES_MMS_MLOT',pars=['CUSTOMER'],tjs=["MLOT='"+mlot+"'"]).drop_duplicates().dropna()
                                        if mat_df.empty:mat_cuslot='null'
                                        else:mat_cuslot=mat_df.values[0]
                                        mat_type=ora.getdata('MES.VIEW_MMSLOTLIST_MAIN',pars=['MLOTTYPE'],tjs=["MLOT='"+mlot+"'"]).drop_duplicates().dropna().values[0]
                                        resfin=[0,front_device,mat_cuslot,mat_type[0],materialno,mlot,\
                                                pva_inqty,pva_intime,pva,pva_outtime,pva_outqty,\
                                                psalot,psa_inqty,psa_outqty,psa_intime,psa_outtime,\
                                                sc_inqty,sc_outqty,sc_intime,sc_outtime,\
                                                s, slt_inqty, slt_outqty,slt_intime, slt_outtime, \
                                                cqno,cq_sta,cq_inqty,cq_outqty,cq_intime,cq_outtime,\
                                                bzno,pkg_custlot,pkg_qty,c]
                                        for i in range(0,len(resfin)):
                                            if resfin[i]==None:resfin[i]='null'
                                        fin.append(resfin)
    return  fin

if __name__=="__main__":
    # 取数据
    print('Data Loading...')
    ora = oracle2pd('10.232.101.51', '1521', 'MESDB', 'BDATA', 'BDATA')
    # hist=ora.getdata('MES.MES_WIP_HIST',pars=['LOT','OLDOPERATION','TRANSACTIONTIME', 'NEWQUANTITY','TRANSACTION','ACTIVITY'],elimit=100000)
    nonact = ora.getdata('MES.MES_WIP_LOT_NONACTIVE', ['LOT', 'MATERIAL', 'PALLET', 'QUANTITY', 'CUSTLOT'], blimit=10010,
                         elimit=11000)
    # slt = ora.getdata('MES.MES_WIP_SPLIT', ['SUBLOT', 'PARENTLOT', 'OPERATION'], elimit=10)
    # merge=ora.getdata('MES.MES_WIP_MERGE',['SUBLOT','PARENTLOT'],elimit=10)
    # mms=ora.getdata('MES.VIEW_MMSLOTLIST_MAIN',elimit=10)
    print('Data Loading finish!')
    print('Data processing...')
    # ms=mysql2pd()
    custlot = 'KA180200879'
    nonflag = nonact['MATERIAL'].fillna('null')
    custlot = nonact[nonflag.str.contains('-S-')]['PALLET'].drop_duplicates().dropna()
    ms = mysql2pd('123.59.26.236', '33333', 'mysql', 'root', 'Rtsecret')
    # ms.dopost('truncate table trace_production')
    for c in custlot.values:
        print('开始：' + str(c))
        res = doit(c)
        res = pd.DataFrame([x for x in res if len(x) > 2],
                           columns=['trace_id', 'front_device', 'mat_cuslot', 'mat_type', 'mat_device', 'mat_lot', \
                                    'pva_inqty', 'pva_intime', 'pva_lot', 'pva_outtime', 'pva_outqty', 'psa_lot',
                                    'psa_inqty', 'psa_outqty', 'psa_intime', 'psa_outtime', \
                                    'aging_inqty', 'aging_outqty', 'aging_intime', 'aging_outtime', 'slt_lot',
                                    'slt_inqty', 'slt_outqty', 'slt_intime', 'slt_outtime', 'rtx_lot', 'rtx_enqu',
                                    'rtx_inqty',
                                    'rtx_outqty', 'rtx_intime', 'rtx_outtime', 'pkg_pallet', 'pkg_custlot', 'pkg_qty',
                                    'pkg_outlot'
                                    ]).drop_duplicates()
        # print(res['pva_lot']+'|'+res['psa_lot']+'|'+res['slt_lot']+'|'+res['rtx_lot'])
        ms.write2mysql(res, 'trace_production')
