import pymysql
import datetime

def showCommentsInRoute(routeId, dbCnx):
    ''' function: show the comments for a given route
        paramaeters: routeId -- the route to check
        return an array of comments associated with the route
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_routeComments", (routeId,))
    rows = proc_cur.fetchall()
    comments = []
    for row in rows:
        comments.append(row['commentText'] 
        + "\n\nBy " + row['authorUserName'] + " on " + str(row['commentDate']))
    
    return comments

def showCommentsByUser(routeId, author, dbCnx):
    ''' function: show the user the comments they authored for a route
        parameters: routeId -- the route we check
                    author -- the username of the current user
                    dbCnx -- the db connection
        return array of comments from most recent to oldest (convention in
            web apps like Facebook to show comments this way)
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_userRouteComment", (routeId, author,))
    rows = proc_cur.fetchall()
    comments = []
    commentIds = []
    for row in rows:
        comments.append(str(row['commentId']) + " -- " + row['commentText'])
        commentIds.append(str(row['commentId']))

    return comments, commentIds

def overwriteComment(routeId, commentId, author, newText, dbCnx):
    ''' function: update the comment based on user input
        parameters: routeId -- route the comment is part of
                    commentId -- the comment being updated
                    author -- the username of the author
                    newT    ext -- the new text
                    dbCnx -- the db connection
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_userRouteComment", (routeId, author,))
    rows = proc_cur.fetchall()
    comments = []
    for row in rows:
        comments.append(row['commentId'])
    # check that the commentId is valid
    if commentId in comments:
        proc_cur.callproc("proc_modifyUserComment", (commentId,author,newText,))
        dbCnx.commit()
        print("\nComment was overwritten!")
    else:
        print("Inputted commentId was invalid.")


def addComment(routeId, author, text, dbCnx):
    ''' function: update the comment based on user input
        parameters: routeId -- route the comment is part of
                    author -- the username of the author
                    text -- the new text
                    dbCnx -- the db connection
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_insertComment", (routeId, author,text))
    dbCnx.commit()


def deleteComment(routeId, commentId, author, dbCnx):
    ''' function: delete a comment
        parameters: routeId -- the route the comment is associated with
                    commentId -- route the comment is part of
                    author -- the username of the author
                    dbCnx -- the db connection
    '''
    proc_cur = dbCnx.cursor()
    proc_cur.callproc("proc_userRouteComment", (routeId, author,))
    rows = proc_cur.fetchall()
    comments = []
    for row in rows:
        comments.append(row['commentId'])
    # check that the commentId is valid
    if commentId in comments:
        proc_cur.callproc("proc_deleteUserComment", (commentId,author,))
        dbCnx.commit()
        print("\nComment %d has been deleted!" % commentId)
    else:
        print("Inputted commentId was invalid.")
