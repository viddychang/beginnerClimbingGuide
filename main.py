#!/usr/bin/env python
# -*- coding: utf-8 -*-

# %% Simple selector (MySQL database)
# import pymysql for a simple interface to a MySQL DB

import pymysql
from userUtilFunctions import *
from menu import *
from comments import *
from routes import *


def main():
    try:
        # first connect to db
        cnx = pymysql.connect(host='localhost', user='root', password='Northeastern',
            db='climbingFinalProject', charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor)

        # print("\n -- Connection to 'climbingUsers' was successful -- \n")
    except pymysql.err.OperationalError:
        print("Error: %d: %s" % (e.args[0], e.args[1]))
    

    # get users logged in
    welcome_user = 2
    userName = None
    program_run = True
    welcome = True
    search = True

    while program_run == True:
        route = True
        addRoute = False
        # try block for user auth
        try:
            if welcome == True:
                welcome_user = startMenu()
                # close program
                if welcome_user == "3":
                    program_run = False
                    search = False
                    route = False
                elif welcome_user == "1":
                    userName = userCreate(cnx)
                
                elif welcome_user == "0":
                    userName = userLogin(cnx)
                welcome = False

            # print("out of welcome")
        except ValueError as err:
            print(err)
        
        # try block for searching for a route
        routeId = 0
        try:
            routeInfo = []
            routeComments = []
            if search == True:
                topSearchInput = topSearchMenu()
                if topSearchInput == "4":
                    welcome = True
                    route = False
                elif topSearchInput == "1":
                    print("")
                    stateIdSearch = int(stateSearchMenu(cnx))
                    if stateIdSearch != 0:
                        routeId = int(selectRouteMenu("state", stateIdSearch, cnx))
                elif topSearchInput == "2":
                    print("")
                    styleIdSearch = int(styleSearchMenu(cnx))
                    if styleIdSearch != 0:
                        routeId = int(selectRouteMenu("style", styleIdSearch, cnx))
                elif topSearchInput == "3":
                    if userName == None:
                        print("\nOnly users logged in can add routes to the database.")
                        print("Returning back to welcome menu.\n")
                        welcome = True
                        route = False
                    else:
                        addRoute = True
                        route = False
                
        except ValueError as err:
            print(err)

        # inside a route
        if routeId == 0 or routeId == '0':
            route = False
        

        try:
            if route == True:
                print("")
                routeInfo = getRouteInformation(routeId, cnx)
                routeComments = showCommentsInRoute(routeId, cnx)
                for info in routeInfo:
                    print(info)
                print("\nComments:")
                if len(routeComments) > 0:
                    for comment in routeComments:
                        print("------------\n" + comment)
                else:
                    print("\nNo comments")
                
                inRoute = True
                while inRoute == True:
                    route_menu_choice = insideRouteMenu()
                    if route_menu_choice == "6":
                        program_run = False
                        inRoute = False
                    elif route_menu_choice == "4":
                        welcome = False
                        inRoute = False
                    elif route_menu_choice == "5":
                        welcome = True
                        inRoute = False
                    else:
                        if userName == None:
                            print("Only users logged in can add comments to the database.")
                            print("Returning back to welcome menu.")
                            welcome = True
                            inRoute = False
                        elif route_menu_choice == "1":
                            commentText = input("Enter text: ")
                            addComment(routeId, userName, commentText, cnx)
                            print("\nComment has been added!\n")
                        elif route_menu_choice == "2":
                            commentsByUser, commentIds = showCommentsByUser(routeId, userName, cnx)
                            if len(commentsByUser) > 0:
                                print("Which comment would you like to overwrite?\n")
                                for comment in commentsByUser:
                                    print(comment)
                                print("")
                                select_comment = input("Enter choice or '0' to cancel: ")
                                if select_comment == '0':
                                    continue
                                else:
                                    newText = input("Enter text: ")
                                    overwriteComment(routeId, int(select_comment), userName, newText, cnx)
                            else:
                                print("\nYou have not written any comments for this route.\n")

                        elif route_menu_choice == "3":
                            commentsByUser, commentIds = showCommentsByUser(routeId, userName, cnx)
                            if len(commentsByUser) > 0:
                                print("Which comment would you like to delete?\n")
                                for comment in commentsByUser:
                                    print(comment)
                                print("")
                                select_comment = input("Enter choice or '0' to cancel: ")
                                if select_comment == '0':
                                    break
                                else:
                                    deleteComment(routeId, int(select_comment), userName, cnx)
                            else:
                                print("\nYou have not written any comments for this route.\n")
        
        except ValueError as err:
            print(err)

        try:
        # adding a route to the database
            if addRoute == True:

                value = routeAddDriver(userName, cnx)
                if value == 1:
                    print("All set! Returning to the main menu.")
                else:
                    print("\nOperation cancelled.")
                welcome = False
                search = True

        except ValueError as err:
            print(err)    
    
    
    
    print("\nWe hope to see you again!\n")
    cnx.close()

main()