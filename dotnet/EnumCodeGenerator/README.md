# Enum Code Generator
This is a quick utility to read static data (eg MonthName, County, EmployeeType) from a DB and generate matching enums so you dont have to look up values like that.

# How does it know?
When I make a static data table (lookup) it almost always has a column named "ID" and "Name". This program will look for those colums. If a table doesn't hav those columns, it will output a debug message telling you that this table will be ignored.

# Before you start
Open the app.config file and change the values for:
* Server = the name of your database server. I'm using localhost (aka ".") 
* SavePath = a file folder where the code will be generated. If the path is broken, you will get an error message instead of code files
* NameSpace = This is the namespace that you are using in your outputted files

# Using the app
If your DB connection is good, it will find the names of databases on your server and fill a dropdown list (upper left). If your connection is wrong, you can use the [...] button to pick a different server.

Once you pick a database, the list below will populate with names of tables who have columns ID/Name. 

I set up the list to use (keyboard) down arrow and spacebar to select tables from the list. I thought that worked faster than clicking with a mouse. Consequently, the mouseclick doesn't work right. You sort-of have to click each item twice (but not double-click).

When you select a table from the list, it will display the columns and properties of that table (marginally useful, I suppose).

# Example Output
```
using System;

Model.DataLayer.Enums
{
   public enum StateEnum
   {
      Alabama=1,
      Alaska=2,
      Arizona=3,
      Arkansas=4,
      California=5,
      Colorado=6,
      Connecticut=7,
      Delaware=8,
      Florida=9,
      // you get the idea
   };
}
```