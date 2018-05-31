from dataprocess.oracleprocess.mes.app.lvlizhuisu import LvLi
from dataprocess.oracleprocess.mes.app.qiaojiao import QiaoJiao
from dataprocess.oracleprocess.mes.app.fee import Fee
from dataprocess.oracleprocess.mes.app.yunfantouru import YunFan
from dataprocess.oracleprocess.mes.app.cost import Cost
from dataprocess.oracleprocess.mes.app.erp核账 import HeZhang
from dataprocess.oracleprocess.mes.app.vlm_mwh import Vlm
from dataprocess.oracleprocess.mes.app.良率统计 import LiangLv
from dataprocess.oracleprocess.mes.app.存货明细 import CunHuo
from dataprocess.oracleprocess.mes.app.资产负债 import FuZhai
from dataprocess.oracleprocess.mes.app.良品 import LiangPin
from dataprocess.oracleprocess.mes.app.利润 import LiRun
from dataprocess.oracleprocess.mes.app.良率日报 import LLRB
from dataprocess.oracleprocess.mes.app.月损耗百分比 import MonCostRate
import config as conf
from time import strftime,gmtime

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

def k2func(name,btime,etime):
    #履历追溯
    if 'lvlizhuisu'==name:
        print('执行：' + name)
        ll= LvLi(btime,etime)
        ll(btime, etime)
        del ll
    #翘角
    if 'qiaojiao'==name:
        print('执行：'+name)
        qj= QiaoJiao()
        qj(btime, etime)
        del qj
    #期间费用
    if 'fee'==name:
        print('执行：' + name)
        fee= Fee()
        fee()
        del fee
    #原反投入
    if 'yunfantouru'==name:
        print('执行：' + name)
        yf=YunFan()
        yf()
        del yf
    #损耗
    if 'cost'==name:
        print('执行：' + name)
        c=Cost()
        c()
        del c
    # erp核账
    if 'erp核账' == name:
        print('执行：' + name)
        hz = HeZhang()
        hz()
        del hz
    # vlm_mwh
    if 'vlm' == name:
        print('执行：' + name)
        v = Vlm()
        v()
        del v
    # 良率统计
    if 'lianglv' == name:
        print('执行：' + name)
        lianglv = LiangLv()
        lianglv()
        del lianglv
    # 存货明细
    if 'cunhuo' == name:
        print('执行：' + name)
        cunhuo = CunHuo()
        cunhuo()
        del cunhuo
    # 资产负债
    if 'fuzhai' == name:
        print('执行：' + name)
        fz = FuZhai()
        fz()
        del fz
    # 良品率
    if 'liangpin' == name:
        print('执行：' + name)
        lp = LiangPin()
        lp()
        del lp
    # 利润
    if 'lirun' == name:
        print('执行：' + name)
        lrun = LiRun()
        lrun()
        del lrun
    # 良率日报
    if 'lianglvribao' == name:
        print('执行：' + name)
        llrb = LLRB()
        llrb()
        del llrb
    # 月损耗
    if '月损耗' == name:
        print('执行：' + name)
        mcr = MonCostRate()
        mcr()
        del mcr

def main():
    config = conf.configs
    lasttime=conf.total_T
    newpoint = strftime("%Y-%m-%d %H:%M:%S", gmtime())
    for k,v in config.items():
        if lasttime%int(v['T'])==0:
            k2func(k,v['checkpoint'],newpoint)
            config[k]['checkpoint']=newpoint#修改checkpoint
    if lasttime == minx([v['T'] for v in config.values()]):
        new_T = 1  # 周期循环
    else:
        new_T = lasttime + 1
    with open ('config.py','w') as f:
        f.write('configs='+str(config)+'\n'+'total_T='+str(new_T))#写入配置文件
if __name__ == "__main__":
    main()
