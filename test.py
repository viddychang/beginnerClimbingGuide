import pymysql

def main():
    author = 'changd'
    cnx = pymysql.connect(host='localhost', user='root', password='Northeastern',
        db='climbingFinalProject', charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)

    proc_cur = cnx.cursor()
    proc_cur.callproc("proc_modifyUserComment", (1,author,"25",))
    print(proc_cur[0])
    cnx.commit()

main()