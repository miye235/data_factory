import re
import os
import cx_Oracle


def func(name):
    with open(name, "r", encoding="utf-8") as f:
        o = []
        # 公式
        r = []
        # 字段
        n = []
        # 别名和字段对照字典
        m = {}
        f = f.read()
        g = re.split("select|SELECT", f)
        # from层级区分list
        t = []
        flag = 0

        for j in g[flag:]:
            if j.count("from") > 1:
                t.append(g.index(j))
            elif j.count("FROM") > 1:
                t.append(g.index(j))
        # 查找全部公式
        for i in g:
            # 寻找全部sql的公式
            for k in i.split(" "):
                if k.find("(") != 1 and k.find(")") != 1 and k.count("(") == k.count(")") and k.count("(") > 0:

                    if k.split("(")[0].strip(",").find(".") == -1:
                        if k.split("(")[0].strip(",").find(",") != -1:
                            r.append(k.split("(")[0].strip(",").split(",")[-1])
                        elif k.split("(")[0].strip(","):
                            r.append(k.split("(")[0].strip(","))
                    else:
                        if k.find("(+)") == -1:

                            if k.startswith(","):
                                r.append(k.split(",")[1].split("(")[0])
                            else:
                                for i in k.split("="):
                                    if i.find("(") != -1:
                                        r.append(i.split("(")[0])
        # 查找所有表名
        for i in g:
            # 寻找最外层from的位置，获得最外层from的别名填入字典
            if len(re.split("FROM \(|from \(", i)) == 2 and len(i) != 0:
                # print(i)
                l = g[-flag].split(" ")
                p = l[l.index(")") + 1].strip().strip(";")
                m.update({p.strip(): re.split(p, re.split("FROM \(|from \(", f)[1])[0].strip()})

            # 内层select
            else:
                # print(i)
                d = re.split("from |FROM ", i.strip().strip("\n"))[-1]
                # print(d)
                if d.find("where") == -1 and d.find("WHERE") == -1 and len(d) > 0:
                    pass
                else:
                    for i in re.split("where|WHERE", d):
                        # print(i)
                        if len(i) == 0:
                            pass
                        else:
                            # print(i.strip().strip(",").strip("\n"))
                            o.append(i.strip().strip(",").strip("\n"))
                            break
            flag += 1
        o = list(set(o))
    for i in o:
        if len(i.split(" ")) <= 3 and i.find(",") == -1:
            # print(i)
            n.append(i.split(" ")[0])
        else:

            for j in i.split(","):
                j = j.strip()
                if len(j.split(" "))<=3:

                    n.append(j.split(" ")[0])
                else:
                    if j.find("join") != 1:
                        for k in re.split("LEFT JOIN | RIGHT JOIN |right join| left join | on | ON ", j)[:2]:
                            n.append(k.split(" ")[0])

    r = list(set(r))
    for i in r:
        if i.find(")") != -1:
            r.remove(i)
    for i in range(len(r)):
        r[i] = r[i].upper()
    fx = list(set(r))
    n = list(set(n))
    n.append(fx)
    return n


if __name__ == "__main__":

    conn = cx_Oracle.connect('BDATA/BDATA@10.232.1.101:1521/KSERP')
    c = conn.cursor()
    z = []
    path = os.getcwd() + "/result"
    if os.path.exists(path):
        pass
    else:
        os.makedirs(path)
    log = open(path + "/result.txt", "w", encoding="utf-8")
    error = open(path + "/error.txt", "w", encoding="utf-8")
    fx = open(path + "/function.txt", "w", encoding="utf-8")
    for i in os.listdir():
        if i.endswith(".txt"):
            print("*" * 30, i, "*" * 30, file=log)
            print("*" * 30, i, "*" * 30, file=error)
            print("正在检测", i,)
            print("\n", file=log)
            l = func(i)
            ff = l.pop()
            print("*" * 30, i, "*" * 30, file=fx)
            for k in ff:
                print("函数"+k, file=fx)
            for j in l:
                if len(j) != 0:
                    sql = "select * from " + j
                    try:
                        print(j+"检测完成", file=log)
                        c.execute(sql)
                    except Exception as e:
                        print("=" * 25 + "出错" + "=" * 25, file=log)
                        print(j, file=log)
                        print(e, file=log)
                        print("=" * 54, file=log)
                        print("表名", j, "错误原因", e, file=error)
                        print("\n", file=error)
