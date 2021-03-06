# beginnerClimbingGuide v1.0
The objective of this project was to create database application from start to finish. The program built for this project is an application for beginner climbers to search for climbing routes that fit their level and supply them with the information needed to be safe. This was submitted as a final class project for Northeastern CS5200.

The application uses a MySQL database and a python backend. The frontend/UI of this application is the command line interface (CLI).

When run, users start at a welcome menu will include an option to CREATE a user login account, log in to an existing account or continue as a guest. The decision made by the user at this step will affect the user’s access to certain CRUD features.

Users can then CREATE a new route to add to the database or search for a route based on filter criteria, then READ data from the routes database and display results on the webpage. In this first iteration, a user can search routes by State or Climbing Style. The user then has the option to go into a single route and see more details of the route (i.e. links to skill resources, equipment required, etc. In addition, the user can CREATE a comment on the route’s page or DELETE and/or UPDATE. Non-registered users can search and see route details, but cannot UPDATE the route data. 

### Installation and how to run ###
1. Open command line interface (i.e. termainal).
1. `git clone https://github.com/viddychang/beginnerClimbingGuide.git`
1. `cd /beginnerClimbingGuide`
1. Make sure your machine has python 3.8.6 or later: https://www.python.org/downloads/
1. `pip install PyMySQL`
1. Connect to your local MySQL database (i.e. via MySQL workbench) and import the DDL/DML (`chang_final_project.sql`)
1. In `main.py` line 17, update the database connection credentials (*user*, *password*) to your local MySQL credentials
1. To run, `python main.py`
