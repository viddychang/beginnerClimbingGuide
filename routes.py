import pymysql
import datetime

def getStates(dbCnx):
    ''' function: get the states supported by the db
        parameters: dbCnx -- the db connection
        return array of states with Ids and an array of ids
    '''
    stmt_cur = dbCnx.cursor()
    stmt_cur.execute("SELECT * FROM state")
    rows = stmt_cur.fetchall()
    states = []
    stateIds = []

    for row in rows:
        states.append(str(row['stateId']) + " -- " + row['stateAbbName'])
        stateIds.append(row['stateId'])
        
    stmt_cur.close()
    return states, stateIds


def getClimbStyles(dbCnx):
    ''' function: get the climbing styles supported by the db
        parameters: dbCnx -- the db connection
        return array of styles with Ids and an array of ids
    '''
    stmt_cur = dbCnx.cursor()
    stmt_cur.execute("SELECT * FROM climbStyle")
    rows = stmt_cur.fetchall()
    styles = []
    styleIds = []

    for row in rows:
        styles.append(str(row['climbStyleId']) + " -- " + row['styleName'])
        styleIds.append(row['climbStyleId'])

        
    stmt_cur.close()
    return styles, styleIds


def getRouteIds(searchType, searchTypeId, dbCnx):
    ''' function: get a list of routes by searchType
        parameters: searchType -- type of search
                    searchTypeId -- the id of the searchType
                    dbCnx -- the current db connection
        return an array of routeId with their name and an array with just routeIds
    '''
    validSearchTypes = ["state", "style"]
    if searchType not in validSearchTypes:
        print("searchType is invalid.")
        return []

    proc_cur = dbCnx.cursor()
    if searchType == "state":
        proc_cur.callproc("proc_getRoutesInState", (searchTypeId,))
    elif searchType == "style":
        proc_cur.callproc("proc_getRoutesInStyle", (searchTypeId,))
    rows = proc_cur.fetchall()

    routeIds = []
    for row in rows:
        routeIds.append(row['routeId'])
    proc_cur.close()

    routes = []
    for routeId in routeIds:
        stmt_cur = dbCnx.cursor()
        stmt_cur.execute("SELECT routeId, routeName FROM route WHERE routeId = %s", routeId)
        row = stmt_cur.fetchall()
        routes.append(str(row[0]['routeId']) + " -- " + row[0]['routeName'])
        stmt_cur.close()
    
    return routes, routeIds


def getRouteInformation(routeId, dbCnx):
    ''' function: get the full route information which includes resources, gear
        parameters: routeId -- the route being fetched
                    dbCnx -- the db connection
        return an array to print the route info
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_routeWithState", (routeId,))
    routeInfo = []

    # should only be a single row
    routeRow = proc_cur.fetchall()

    routeInfo.append(routeRow[0]['routeName']
                    + "\nAdded by: " + str(routeRow[0]['author'])
                    + "\nAdded on " + str(routeRow[0]['dateCreated'])
                    + "\nLast modified on " + str(routeRow[0]['dateModified'])
                    + "\n\nGPS Location: " + str(routeRow[0]['locationCoordinates'])
                    + "\n\nDescription: " + str(routeRow[0]['routeDescription'])
                    + "\n\nParking information: " + str(routeRow[0]['parkingInformation'])
                    )
    

    # get the gear
    proc_cur.callproc("proc_getGearForRoute", (routeId,))
    rows = proc_cur.fetchall()
    routeInfo.append("\nSuggested Gear:")
    
    if len(rows) > 0:
        for row in rows:
            routeInfo.append(str(row['numberOfGear']) + " " + row['gearName'])
    else:
        routeInfo.append("N/A")
    
    # get the skill resources
    proc_cur.callproc("proc_getSkillResourceForRoute", (routeId,))
    rows = proc_cur.fetchall()
    routeInfo.append("\nThese skills resources might help:")
    if len(rows) > 0:
        for row in rows:
            routeInfo.append(row['resourceName'] + ": " + row['resourceLink'])
    else:
        routeInfo.append("N/a")    
    proc_cur.close()

    return routeInfo


def addRoute(routeName, locationCoordinates, parkingInformation, routeDescription, 
                stateId, author, dbCnx):
    ''' function: create a new route to the db
        parameters: routeName -- name of route
                    locationCoordinates -- the gps location of the route
                    parkingInformation -- information about parking
                    routeDescription -- description of the route
                    stateId - the stateId of wehre the route is
                    dbCnx -- the db connection
        return the routeId
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_insertRoute", (routeName, locationCoordinates, parkingInformation, routeDescription, 
                stateId, author,))
    dbCnx.commit()
    print(routeName + " successfully added to the database!")
    proc_cur.close()

    # to get the routeId
    stmt_cur = dbCnx.cursor()
    # not a perfect way to get the routeId, but shoudl be okay in most cases
    # case not handled is if there is a duplicate
    stmt_cur.execute("SELECT routeId FROM route WHERE routeName = %s", routeName)
    routeIdRow = stmt_cur.fetchall()
    routeId = routeIdRow[0]['routeId']
    stmt_cur.close()

    return routeId

def getGear(dbCnx):
    ''' function: get the gear supported by the db
        parameters: dbCnx -- the db connection
        return array of gear with Ids and an array of ids
    '''
    stmt_cur = dbCnx.cursor()
    stmt_cur.execute("SELECT * FROM gear")
    rows = stmt_cur.fetchall()
    gear = []
    gearIds = []

    for row in rows:
        gear.append(str(row['gearId']) + " -- " + row['gearName'])
        gearIds.append(row['gearId'])
        
    stmt_cur.close()
    return gear, gearIds


def addGearToRoute(rId, gId, n, dbCnx):
    ''' function: add gear to a route
        paramaters: rId -- the routeId where gear is being added
                    gId -- the gearId that's being added
                    n -- the number of gear
        return none
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_addGearToRoute", (rId, gId, n,))
    dbCnx.commit()
    proc_cur.close()


def getResources(dbCnx):
    ''' function: get the resources supported by the db
        parameters: dbCnx -- the db connection
        return array of gear with Ids and an array of ids
    '''
    stmt_cur = dbCnx.cursor()
    stmt_cur.execute("SELECT * FROM skillResources")
    rows = stmt_cur.fetchall()
    resources = []
    resourceIds = []

    for row in rows:
        resources.append(str(row['resourceId']) + " -- " + row['resourceName'])
        resourceIds.append(row['resourceId'])
        
    stmt_cur.close()
    return resources, resourceIds

def addResourceToRoute(rId, resId, dbCnx):
    ''' function: add a resource to a route
        parameters: rId -- the id of the route
                    resId -- the id of the resource
                    dbCnx -- the dbConnection
        return none
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_addSkillResourceToRoute", (rId, resId,))
    dbCnx.commit()
    proc_cur.close()


def addClimbStyleToRoute(rId, styleId, dbCnx):
    ''' function: add a style to the route
        parameters: rId -- the id of the route
                    styleId -- the id of the style
                    dbCnx -- the dbConnection
        return none
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_addStyleToRoute", (rId, styleId,))
    dbCnx.commit()
    proc_cur.close()