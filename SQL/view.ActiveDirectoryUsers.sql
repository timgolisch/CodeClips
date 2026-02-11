if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ActiveDirectoryUsers]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[ActiveDirectoryUsers]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Note: you will have to tweak the LDAP path before this will work  ******/
/******       Also, linking this to another table within a query may result in an error.  It may be better to pull it into a temp table then link to another table *****/

CREATE VIEW dbo.ActiveDirectoryUsers
AS
SELECT     CN, EmployeeNumber, EmployeeId, DisplayName, mail, GivenName, SN, Mobile, PhysicalDeliveryOfficeName, TelephoneNumber, Title, Department, 
                      FacsimileTelephoneNumber, SamAccountName, extensionattribute1, division, userPrincipalName, SUBSTRING( userPrincipalName , PATINDEX('%@%',userPrincipalName)
	     + 1 , PATINDEX('%.%',userPrincipalName) - PATINDEX('%@%', userPrincipalName) - 1) + '\' + SamAccountName AS DomainUserName
FROM         OPENQUERY(ADSI, 
                      'Select CN, EmployeeNumber, EmployeeId, DisplayName, mail, GivenName, SN, Mobile, PhysicalDeliveryOfficeName,
	       TelephoneNumber, Title, Department, FacsimileTelephoneNumber, SamAccountName, extensionattribute1, division, userPrincipalName
	       from  ''LDAP://LabLansing01/ou=Lab,DC=Lab,DC=Lansing'' 
	      WHERE objectClass = ''User'' AND objectClass <> ''Computer'' AND userAccountControl <> 514
                       ORDER BY SN')
                       ActiveDirectoryUsers





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

