# beginnerClimbingGuide
The objective of this project is to create an application that beginner climbers can use to search for climbing routes that fit their level and supply them with the information needed to be safe. This was submitted as a final class project for Northeastern CS5200.

The application starts with a welcome menu will include an option to CREATE a user login account, log in to an existing account or continue as a guest. The decision made by the user at this step will affect the user’s access to certain CRUD features.

Users can then CREATE a new route to add to the database or search for a route based on filter criteria, then READ data from the routes database and display results on the webpage. In this first iteration, a user can search routes by State or Climbing Style. The user then has the option to go into a single route and see more details of the route (i.e. links to skill resources, equipment required, etc. In addition, the user can CREATE a comment on the route’s page or DELETE and/or UPDATE. Non-registered users can search and see route details, but cannot UPDATE the route data. 

### Installation ###
1. Open command line interface (i.e. termainal).
1. $ git clone https://github.com/viddychang/beginnerClimbingGuide.git
1. cd /beginnerClimbingGuide
1. Make sure your machine has python 3.8.6 or later: https://www.python.org/downloads/
1. Connect to your local MySQL database (i.e. via MySQL workbench) and import the DDL/DML (Dump20201210.sql)
1. In `main.py` line 17, update the database connection credentials (*user*, *password*) to your local MySQL credentials
1. To run, `python main.py`
