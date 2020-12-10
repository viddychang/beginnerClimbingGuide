import pymysql

def userCreate(dbConnection):
    ''' Function: create and then log into the database
        Parameters: dbConnection -- the current database connection
        return username from climbingUsers table
    '''
    user_list = set()
    proc_cur = dbConnection.cursor()
    proc_cur.callproc("proc_getUsers")
    rows = proc_cur.fetchall()

    for row in rows:
        user_list.add(row['user_username'])
    proc_cur.close()
    # print(user_list)
    valid = False
    
    userName = input("Please create a unique Username (case sensitive): ")

    while valid == False:
        if userName in user_list:
            userName = input("Username taken. Please create a different login or "
            + "enter '0' to continue as a guest: ")
            if userName == '0':
                return None
        else:
            valid = True
    
    password = input("Great! Now create a password: ")

    proc_cur = dbConnection.cursor()
    proc_cur.callproc("proc_createUser", (userName, password,))
    dbConnection.commit()
    proc_cur.close()

    print("User login successfully created! You are now logged in as:", userName)
    return userName

def userLogin(dbConnection):
    ''' Function: user log into the database with password
        Parameters: dbConnection -- the current database connection
        return username from climbingUsers table
    '''

    userName = input("Please enter your username: ")
    pw = input("Please enter your password: ")
    valid = False
    while valid != True:
        proc_cur = dbConnection.cursor()
        proc_cur.callproc("proc_userLoginCheck", (userName, pw,))
        returnValue = proc_cur.fetchone()
        for value in returnValue:
            loginValue = value

        if loginValue == "failed":
            print("\nUsername and/or password not found. Please try again or enter "
            + "'0' to return to main menu")
            userName = input("\nEnter your username: ")
            if userName == '0':
                return None
            pw = input("Enter your password: ")
        else:
            valid = True

    print("\nWelcome back " + userName + "!")
    return userName 
            
    

