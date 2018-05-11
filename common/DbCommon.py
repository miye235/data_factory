import cx_Oracle,pymysql
import pandas as pd
class oracle2pd:
    def __init__(self,host,port,db,user,pwd):
        '''
        :param host: 主机ip
        :param port: 端口号
        :param db: 数据库
        :param user: 用户名
        :param pwd: 密码
        '''
        self.conn=cx_Oracle.connect(str(user)+'/'+str(pwd)+'@'+str(host)+':'+str(port)+'/'+str(db))
        self.cursor=self.conn.cursor()
    def showtables(self,keyword=None,showpars=False):
        '''
        显示数据库中的表
        :param keyword: 表名关键词
        :param showpars: 是否显示表的所有信息，若为否则只显示表名
        :return: 查询结果
        '''
        if not showpars:obj='table_name'
        else:obj='*'
        sql="select "+obj+" from all_tables"
        if keyword:
            sql+=" where table_name like '%"+keyword+"%'"
        self.cursor.execute(sql)
        return pd.DataFrame(self.cursor.fetchall())
    def dosql(self,sql):
        self.cursor.execute(sql)
        return pd.DataFrame(self.cursor.fetchall())
    def getdata(self,table,pars=None,blimit=None,elimit=None):
        '''
        从数据库中取出数据放到dataframe中
        :param table: 数据源表
        :param pars: list类型，列出想要提取的字段名，若为空则查询所有字段
        :param blimit: 数据行数最小值限制
        :param elimit: 数据行数最大值限制
        :return: dataframe类型查询结果
        '''
        if pars==None:
            items='*'
            sql2 = "select column_name from all_tab_cols where table_name ='" +table.split('.')[1]+ "'"
            clos = self.cursor.execute(sql2).fetchall()[20:]  # 列名
        else:
            items=','.join(pars)
            clos=pars
        sql1='select '+items+' from '+table
        if blimit!=None or elimit!=None:
            sql1+=' where rownum'
            if blimit!=None and elimit!=None:sql1+='<='+str(elimit)+' minus '+'select '+items+' from '+table+' where rownum<='+str(blimit)
            elif elimit!=None:sql1+='<='+str(elimit)
            else:sql1='select '+items+' from '+table+' minus '+'select '+items+' from '+table+' where rownum<='+str(blimit)
        print(sql1)
        self.cursor.execute(sql1)
        data=self.cursor.fetchall()#数据
        res=pd.DataFrame(data,columns=clos)
        return res

class mysql2pd:
    def __init__(self,host,port,db,user,pwd):
        '''
        :param host: 主机ip
        :param port: 端口号
        :param db: 数据库
        :param user: 用户名
        :param pwd: 密码
        '''
        self.conn=pymysql.connect(host=host,user=user,password=pwd,db=db,port=port)
        self.cursor=self.conn.cursor()
    def showtables(self,keyword=None,showpars=False):
        '''
         显示数据库中的表
         :param keyword: 表名关键词
         :param showpars: 是否显示表的所有信息，若为否则只显示表名
         :return: 查询结果
         '''
        if not showpars:obj='table_name'
        else:obj='*'
        sql="select "+obj+" from information_schema.tables"
        if keyword:
            sql+=" where table_name like '%"+keyword+"%'"
        self.cursor.execute(sql)
        return pd.DataFrame(self.cursor.fetchall())
    def getdata(self,table,pars=None,blimit=None,elimit=None):
        '''
        从数据库中取出数据放到dataframe中
        :param table: 数据源表
        :param pars: list类型，列出想要提取的字段名，若为空则查询所有字段
        :param blimit: 数据行数最小值限制
        :param elimit: 数据行数最大值限制
        :return: dataframe类型查询结果
        '''
        if pars==None:
            items='*'
            sql2 = "select column_name from information_schema.columns where table_name ='"+table.split('.')[1]+"'"
            clos = self.cursor.execute(sql2).fetchall()[20:]  # 列名
        else:
            items=','.join(pars)
            clos=pars
        sql1='select '+items+' from '+table
        if blimit!=None or elimit!=None:
            sql1+=' where rownum'
            if blimit!=None and elimit!=None:sql1+=' between '+str(blimit)+' and '+str(elimit)
            elif elimit!=None:sql1+='<='+str(elimit)
            else:sql1+='>='+str(blimit)
        print(sql1)
        self.cursor.execute(sql1)
        data=self.cursor.fetchall()#数据
        res=pd.DataFrame(data,columns=clos)
        return res