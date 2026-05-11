# Enum Code Generator
This is a quick utility to read static data (eg MonthName, County, EmployeeType) from a DB and generate matching enums so you dont have to look up values like that.

# How does it know?
When I make a static data table (lookup) it almost always has a column named "ID" and "Name". This program will look for those colums. If a table doesn't hav those columns, it will output a debug message telling you that this table will be ignored.

# Before you start
Open the app.config file and change the values for:
* Server = the name of your database server. I'm using localhost (aka ".") 
* SavePath = a file folder where the code will be generated. If the path is broken, you will get an error message instead of code files
* NameSpace = This is the namespace that you are using in your outputted files
