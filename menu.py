import pymysql
from routes import *
from comments import *

def startMenu():
    ''' Function: start menu for when a user opens the app
        parameters: none
        return the choice
    '''
    welcome_page_choices = ["0", "1", "2", "3"]
    print("\nWelcome to Beginner's Climbing World!\nSelect one of the following to get started:\n")
    print("0 -- Log in to your user account")
    print("1 -- Create a user account")
    print("2 -- Continue as a guest")
    print("3 -- Close program\n")
    welcome_user = input("Choice: ")
    while welcome_user not in welcome_page_choices:
        welcome_user = input("Invalid choice, please try again: ")
    return welcome_user


def topSearchMenu():
    ''' function: top search menu for when a user searches for a route
        parameters: none
        return choice
    '''
    topSearchMenu_choices = ["1", "2", "3", "4"]
    print("\nWhat would you like to do?")
    print("1 -- By state (Currently MA, NH, and ME are supported)")
    print("2 -- By climbing style (Currently Trad, Sport, Boulder, and Top Rope are supported)")
    print("3 -- Add a route to the database")
    print("4 -- Log out and/or return to welcome menu")

    topSearchMenu_input = input("\nEnter choice: ")
    while topSearchMenu_input not in topSearchMenu_choices:
        topSearchMenu_input = input("Invalid choice, please try again: ")
    return topSearchMenu_input


def stateSearchMenu(dbCnx):
    ''' function: search menu for when a user searches for a route
        parameters: dbCnx -- db connection
        return choice
    '''
    
    print("Which state would you like to search for routes?\n" 
    + "(Currently MA, NH, and ME are supported)")
    states, stateIds = getStates(dbCnx)
    for state in states:
        print(state)
    
    for i in range(len(stateIds)):
        stateIds[i] = str(stateIds[i])

    userState = input("\nEnter choice or '0' to go back: ")

    while userState not in stateIds:
        if userState == '0':
            return 0
        userState = input("Invalid input, please try again: ")
    return userState


def styleSearchMenu(dbCnx):
    ''' function: search menu for when a user searches for a route based on style
        parameters: dbCnx -- db connection
        return choice
    '''
    
    print("What state would you like to search for?\n" 
    + "(Currently Trad, Sport, Boulder, and Top Rope are supported)")
    styles, styleIds = getClimbStyles(dbCnx)
    for style in styles:
        print(style)
    
    for i in range(len(styleIds)):
        styleIds[i] = str(styleIds[i])

    style_choice = input("\nEnter choice or '0' to go back: ")

    while style_choice not in styleIds:
        if style_choice == '0':
            return 0
        style_choice = input("Invalid input, please try again: ")
    return style_choice

def selectRouteMenu(searchType, searchId, dbCnx):
    ''' function: route selection search menu
        parameters: searchType -- the type of search (by state or climbing style)
                    dbCnx -- db connection
        return chosen routeId
    '''
    print("\nWhich route would you like to explore?")
    routes, routeIds = getRouteIds(searchType, searchId, dbCnx)
    for route in routes:
        print(route)
    
    for i in range(len(routeIds)):
        routeIds[i] = str(routeIds[i])

    selectedRoute = input("\nEnter choice or '0' to go back: ")

    while selectedRoute not in routeIds:
        if selectedRoute == '0':
            return 0
        selectedRoute = input("Invalid input, please try again: ")
    
    return selectedRoute

def insideRouteMenu():
    ''' function: options for when a user is inside a route
        parameters: none
        return choice
    '''
    valid_choices = ["1", "2", "3", "4", "5"]
    print("\nWhat would you like to do next?")
    print("1 -- Add a comment")
    print("2 -- Modify one of my comments on this route")
    print("3 -- Delete one of my comments on this route")
    print("4 -- Search for another route")
    print("5 -- Return to the welcome page")
    print("6 -- Close the program")

    choice = input("\nEnter choice: ")

    while choice not in valid_choices:
        choice = input("Invalid input, please try again: ")
    
    return choice


def routeAddDriver(author, dbCnx):
    ''' function: driver code when adding a route to the database
        parameters: dbCnx -- database connection
        return 1 if route added or 0 if cancelled
    '''
    routeName = input("Enter the name of the route or 'quit' to cancel: ")
    if routeName == 'quit':
        return 0
    lc = input("Enter the GPS coordinates of the route or 'quit' to cancel: ")
    if lc == 'quit':
        return 0
    parkInfo = input("Enter the parking information or 'quit' to cancel: ")
    if parkInfo == 'quit':
        return 0        
    
    routeDesc = input("Enter a description of the route or 'quit' to cancel: ")
    if routeDesc == 'quit':
        return 0  

    states, stateIds = getStates(dbCnx)
    print("Which state is this route? Choose a state from the following list: ")
    for state in states:
        print(state)
    
    for i in range(len(stateIds)):
        stateIds[i] = str(stateIds[i])

    state_choice = input("Enter state choice: ")
    while state_choice not in stateIds:
        state_choice = input("Invalid choice, try again: ")
    
    rId = addRoute(routeName, lc, parkInfo, routeDesc, state_choice, author, dbCnx)
    
    addStyle = ""
    while addStyle != "next":
        print("What climb style is this route (choose one at a time)?")
        styles, styleIds = getClimbStyles(dbCnx)
        for s in styles:
            print(s)
        for i in range(len(styleIds)):
            styleIds[i] = str(styleIds[i])
        styleIds.append('next')
        
        addStyle = input("Enter climb style choice or 'next' to move on: ")
        if addStyle not in styleIds:
            print("Invalid choice, please try again.")
        elif addStyle == "next":
            break
        else:
            addClimbStyleToRoute(rId, int(addStyle), dbCnx)


    addGear = ""
    while addGear != "next":
        print("What kind of gear would you like to add?")
        gear, gearIds = getGear(dbCnx)
        for g in gear:
            print(g)
        
        for i in range(len(gearIds)):
            gearIds[i] = str(gearIds[i])
        gearIds.append('next')
        
        addGear = input("Enter gear choice or 'next' to move on: ")
        if addGear not in gearIds:
            print("Invalid choice, please try again.")
        elif addGear == 'next':
            break
        else:
            n = 0
            while n == 0:
                n_temp = input("How many units of this gear is needed? Enter number (int): ")
                if n_temp.isdigit():
                    n = int(n_temp)
                    addGearToRoute(rId, int(addGear), n, dbCnx)
                else:
                    print("Please enter an integer")
    
    addResource = ""
    while addResource != "next":
        print("What kind of resources would you like to add from our library?")
        resource, resIds = getResources(dbCnx)
        for r in resource:
            print(r)
        for i in range(len(resIds)):
            resIds[i] = str(resIds[i])
        resIds.append('next')
        
        addResource = input("Enter resource choice or 'next' to move on: ")
        if addResource not in resIds:
            print("Invalid choice, please try again.")
        elif addResource == "next":
            break
        else:
            addResourceToRoute(rId, int(addResource), dbCnx)
    
    return 1

        



    
