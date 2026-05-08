# SQL Who Am I
This is a quick utility to connect to a SQL Server and ask it for the name that it recognizes you as. 

This util looks up 4 possible ways to retrieve your identity
* SUSER_NAME
* SUSER_SNAME
* USER_NAME
* USER

For example, when I connect to the SQL Server on my local dev box, it has the following answers:
* SUSER_NAME = DevBox\Timster
* SUSER_SNAME = DevBox\Timster
* USER_NAME = dbo
* USER = dbo
