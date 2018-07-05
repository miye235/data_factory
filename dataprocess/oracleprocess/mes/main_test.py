# -*- coding: UTF-8 -*-

import sys,os,time
sys.path.append('/home/openstack/data_offline/data_factory/')
# sys.path.append('/Users/cloudin1/PycharmProjects/data_factory/')
from dataprocess.oracleprocess.mes.app.lvlizhuisu import LvLi
from dataprocess.oracleprocess.mes.app.qiaojiao_all import QiaoJiao
from dataprocess.oracleprocess.mes.app.fee import Fee
from dataprocess.oracleprocess.mes.app.yunfantouru import YunFan
from dataprocess.oracleprocess.mes.app.cost import Cost
from dataprocess.oracleprocess.mes.app.erp_hezhang import HeZhang
from dataprocess.oracleprocess.mes.app.vlm_mwh import Vlm
from dataprocess.oracleprocess.mes.app.lianglvtongji import LiangLv
from dataprocess.oracleprocess.mes.app.cunhuomingxi import CunHuo
from dataprocess.oracleprocess.mes.app.zichanfuzhai import FuZhai
from dataprocess.oracleprocess.mes.app.liangpin import LiangPin
from dataprocess.oracleprocess.mes.app.lirun import LiRun
from dataprocess.oracleprocess.mes.app.lianglvribao import LLRB
from dataprocess.oracleprocess.mes.app.mon_cost_rate import MonCostRate
from dataprocess.oracleprocess.mes.app.baozhuangchanneng import PkgCal
from dataprocess.oracleprocess.mes.app.chengbenjisuan import ChengBen
from dataprocess.oracleprocess.mes.app.LP_rate import LPrate
from dataprocess.oracleprocess.mes.app.Shipments_now import ShipmentsNow
from dataprocess.oracleprocess.mes.app.Shipments_statistics import ShipmentsStatistics
from dataprocess.oracleprocess.mes.app.item_cost import ItemCost
from dataprocess.oracleprocess.mes.base_test import Base
from dataprocess.oracleprocess.mes.app.chuhuotongji import ChuHuo
from dataprocess.oracleprocess.mes.app.penmo import PenMo
from dataprocess.oracleprocess.mes.app.quality import Qlt
from dataprocess.oracleprocess.mes.app.yuanfanchanchu import YFCH
from dataprocess.oracleprocess.mes.app.pva_channeng import PvaChan
from dataprocess.oracleprocess.mes.app.zhengtilianglvbiao import OverallGoodRatio
from dataprocess.oracleprocess.mes.app.should_pay_age import ShouldPayAge
from dataprocess.oracleprocess.mes.app.sold_area import SoldArea
from dataprocess.oracleprocess.mes.app.mainbuss_income import MainBussinessIncome
from dataprocess.oracleprocess.mes.app.gains_analysis import GainsAnalysis
from dataprocess.oracleprocess.mes.app.should_pay_atm import ShouldPayAtm
from dataprocess.oracleprocess.mes.app.should_get import ShouldGet
from dataprocess.oracleprocess.mes.app.qcview import QCview
# from dataprocess.oracleprocess.mes.app.wmhmes import WmhMes
from dataprocess.oracleprocess.mes.app.cmmtinfo import CmmtInfo
from dataprocess.oracleprocess.mes.app.main_business_cost import MainBusinessCost
from dataprocess.oracleprocess.mes.app.loss_yuanfan_output import LossYuanfanOutput
from dataprocess.oracleprocess.mes.app.loss_yuanfan_input import LossYuanfanInput
from dataprocess.oracleprocess.mes.app.materialprice import MaterialPrice
from dataprocess.oracleprocess.mes.app.top3_shortage import Top3Shortage
from dataprocess.oracleprocess.mes.app.dianque_sumrate import DianQueSum
from dataprocess.oracleprocess.mes.app.sum_goodratio import SumGoodRatio
from dataprocess.oracleprocess.mes.app.qcview1 import QcVim1
from dataprocess.oracleprocess.mes.app.should_pay import ShouldPay
from dataprocess.oracleprocess.mes.app.qty_delres import QtyDelRes
from dataprocess.oracleprocess.mes.app.assets_fixed import AssetsFixed
# from dataprocess.oracleprocess.mes.app.chuhuotongji_zhejiu import CHTJZJ
from dataprocess.oracleprocess.mes.app.cost_yuanfan_wuliao import CostYuanfanWuliao

import config_test as conf
from time import strftime,localtime

def minx(data):
    def lcm(x, y):
        #  获取最小公倍数
        if x > y:
            greater = x
        else:
            greater = y
        while (True):
            if ((greater % x == 0) and (greater % y == 0)):
                lcm = greater
                break
            greater += 1
        return lcm
    res=int(data[0])
    for d in data[1:]:
        res=lcm(res,int(d))
    return res

def k2func(name,btime,etime,conns):
     # 履历追溯
    if 'lvlizhuisu'==name:
        print('执行：' + name)
        ll= LvLi()
        ll(btime,etime,conns)
        del ll
    #翘角
    if 'qiaojiao'==name:
        print('执行：'+name)
        qj= QiaoJiao()
        qj(btime, etime,conns)
        del qj
    #期间费用
    if 'fee'==name:
        print('执行：' + name)
        fee= Fee()
        fee(conns)
        del fee
    #原反投入
    if 'yunfantouru'==name:
        print('执行：' + name)
        yf=YunFan()
        yf(conns)
        del yf
    #损耗
    if 'cost'==name:
        print('执行：' + name)
        c=Cost()
        c(conns)
        del c
    # erp核账
    if 'hezhang' == name:
        print('执行：' + name)
        hz = HeZhang()
        hz(conns)
        del hz
    # vlm_mwh
    if 'vlm' == name:
        print('执行：' + name)
        v = Vlm()
        v(conns)
        del v
    # 良率统计
    if 'lianglv' == name:
        print('执行：' + name)
        lianglv = LiangLv()
        lianglv(conns)
        del lianglv
    # 存货明细
    if 'cunhuo' == name:
        print('执行：' + name)
        cunhuo = CunHuo()
        cunhuo(conns)
        del cunhuo
    # 资产负债
    if 'fuzhai' == name:
        print('执行：' + name)
        fz = FuZhai()
        fz(conns)
        del fz
    # 良品率
    if 'liangpin' == name:
        print('执行：' + name)
        lp = LiangPin()
        lp(conns)
        del lp
    # 利润
    if 'lirun' == name:
        print('执行：' + name)
        lrun = LiRun()
        lrun(conns)
        del lrun
    # 良率日报
    if 'lianglvribao' == name:
        print('执行：' + name)
        llrb = LLRB()
        llrb(conns)
        del llrb
    # 月损耗
    if 'yuesunhao' == name:
        print('执行：' + name)
        mcr = MonCostRate()
        mcr(conns)
        del mcr
    # 包装产能计算
    if 'bzcn' == name:
        print('执行：' + name)
        pkg = PkgCal()
        pkg(conns)
        del pkg
    #成本计算计算
    if 'cbjs' == name:
        print('执行：' + name)
        chengben = ChengBen()
        chengben(conns)
        del chengben
    # LP-rate
    if 'lprate' == name:
        print('执行：' + name)
        lprate = LPrate()
        lprate(conns)
        del lprate
    # ShipmentsNow
    if 'ShipmentsNow' == name:
        print('执行：' + name)
        sn= ShipmentsNow()
        sn(conns)
        del sn
    # ShipmentsStatistics
    if 'ShipmentsStatistics' == name:
        print('执行：' + name)
        ss = ShipmentsStatistics()
        ss(conns)
        del ss
    # itemcost
    if 'itemcost' == name:
        print('执行：' + name)
        ic = ItemCost()
        ic(conns)
        del ic
    # 出货统计
    if 'chtj' == name:
        print('执行：' + name)
        chtj = ChuHuo()
        chtj(conns)
        del chtj
    # 喷墨率
    if 'penmo' == name:
        print('执行：' + name)
        pm = PenMo()
        pm(conns)
        del pm
    # 品质
    if 'qlt' == name:
        print('执行：' + name)
        qlt = Qlt()
        qlt(conns)
        del qlt
    #原反产出
    if 'yfch'==name:
        print('执行：' + name)
        yfch = YFCH()
        yfch(conns)
        del yfch
    #pva产能
    if 'pva_channeng'==name:
        print('执行：' + name)
        pcn = PvaChan()
        pcn(conns)
        del pcn
    # 整体良率
    #if 'ogr' == name:
     #   print('执行：' + name)
      #  ogr = OverallGoodRatio()
       # ogr(conns)
        #del ogr
    # should_pay_age
    if 'spa' == name:
        print('执行：' + name)
        spa = ShouldPayAge()
        spa(conns)
        del spa
    # 主要营业收入
    if 'mbi' == name:
        print('执行' + name)
        mbi = MainBussinessIncome()
        mbi(conns)
        del mbi
    # 损益分析
    if 'gan' == name:
        print('执行' + name)
        gan = GainsAnalysis()
        gan(conns)
        del gan
    # should_pay_atm
    if 'should_pay_atm' == name:
        print('执行：' + name)
        spa = ShouldPayAtm()
        spa(conns)
        del spa
    # should_get
    if 'should_get' == name:
        print('执行：' + name)
        shouldget = ShouldGet()
        shouldget(conns)
        del shouldget
    # qcview
    if 'qcview' == name:
        print('执行：' + name)
        qcview = QCview()
        qcview(conns)
        del qcview
    # # wmhmes
    # if 'wmhmes' == name:
    #     print('执行：' + name)
    #     wmhmes = WmhMes()
    #     wmhmes(conns)
    #     del wmhmes
    # cmmtinfo
    if 'cmmtinfo' == name:
        print('执行：' + name)
        cmmtinfo = CmmtInfo()
        cmmtinfo(conns)
        del cmmtinfo
    # 主营业务成本
    if 'mbc' == name:
        print('执行' + name)
        mbc = MainBusinessCost()
        mbc(conns)
        del mbc
    # 原返损耗产出
    if 'lyo' == name:
        print('执行' + name)
        lyo = LossYuanfanOutput()
        lyo(conns)
        del lyo
    # 原返损耗投入
    if 'lyi' == name:
        print('执行' + name)
        lyi = LossYuanfanInput()
        lyi(conns)
        del lyi
    # materialprice
    if 'materialprice' == name:
        print('执行：' + name)
        materialprice = MaterialPrice()
        materialprice(conns)
        del materialprice
    # 点缺top3
    if 't3s' == name:
        print('执行' + name)
        t3s = Top3Shortage()
        t3s(conns)
        del t3s
    # dianquesumrate
    if 'dianquesumrate' == name:
        print('执行：' + name)
        dianquesumrate = DianQueSum()
        dianquesumrate(conns)
        del dianquesumrate
    # 累计良率
    if 'sumgoodratio' == name:
        print('执行' + name)
        sumgoodratio = SumGoodRatio()
        sumgoodratio(conns)
        del sumgoodratio
    # qcview1
    if 'qcview1' == name:
        print('执行' + name)
        qcview1 = QcVim1()
        qcview1(conns)
        del qcview1
    # should_pay
    if 'should_pay' == name:
        print('执行：' + name)
        should_pay = ShouldPay()
        should_pay(conns)
        del should_pay
    # qtr_delres
    if 'qtr_delres' == name:
        print('执行：' + name)
        qtr_delres = QtyDelRes()
        qtr_delres(conns)
        del qtr_delres
    # # 出货统计含折旧
    # if 'chtjzj' == name:
    #     print('执行' + name)
    #     chtjzj = CHTJZJ()
    #     chtjzj(conns)
    #     del chtjzj
    # 原反损耗
    if 'cstyf' == name:
        print('执行' + name)
        cstyf = CostYuanfanWuliao()
        cstyf(conns)
        del cstyf
def main():
    print('------'+time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))+',运行测试程序'+'------')
    base=Base()
    erp = base.conn('erp')
    offline = base.conn('offline')
    wms = base.conn('wms')
    mes = base.conn('mes')
    conns = {'offline': offline, 'erp': erp, 'wms': wms, 'mes': mes}
    config = conf.configs
    lasttime=conf.total_T
    config_new = dict(config).copy()
    newpoint = strftime("%Y-%m-%d %H:%M:%S", localtime())
    if lasttime == minx([v['T'] for v in config.values()]):
        new_T = 1  # 周期循环
    else:
        new_T = lasttime + 1

    for k, v in config.items():
        if lasttime % int(v['T']) == 0:
            config[k]['checkpoint'] = newpoint  # 修改checkpoint
    with open(base.path1 + 'config_test.py', 'w') as f:
        f.write('configs=' + str(config) + '\n' + 'total_T=' + str(new_T))  # 写入配置文件
    for k, v in config_new.items():
        if lasttime % int(v['T']) == 0:
            k2func(k, v['checkpoint'], newpoint, conns)
    offline.close()
    erp.close()
    wms.close()
    mes.close()
    print('~~~~~~~'+time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))+',测试程序执行结束!'+'~~~~~~')
if __name__ == "__main__":
    main()
