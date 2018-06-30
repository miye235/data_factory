import os

def rotate():
    if os.path.getsize('../log/mes.log')>1024*1024:
        for i in range(10):
            if not os.path.exists('../log/mes_'+str(i+1)+'.log'):
                fobj = open('../log/mes_'+str(i+1)+'.log', 'w')
                fobj.close()
        os.remove('../log/mes_10.log')
        for i in range(9):
            os.rename('../log/mes_'+str(i+1)+'.log','../log/mes_'+str(i+2)+'.log')
        os.rename('../log/mes.log','../log/mes_1.log')