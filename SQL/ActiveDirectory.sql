USE [ActiveDirectory]
GO

/****** Object:  View [dbo].[Users]    Script Date: 09/08/2011 11:00:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--EXEC sp_addlinkedserver 'ADSI', 'Active Directory Services 2.5', 'ADSDSOObject', 'adsdatasource'
ALTER VIEW [dbo].[Users]
AS
SELECT     cn AS FullName, distinguishedName, mail AS Email, displayName, sAMAccountName AS LoginName, title, company, physicalDeliveryOfficeName AS Location, 
                      department, streetAddress AS Address, l AS City, st AS State, postalCode, co AS Country, c AS CountryCode, telephoneNumber AS Phone, 
                      CASE WHEN isnull(userAccountControl & 2, 0) > 0 THEN 'Disabled' ELSE 'Enabled' END AS AccountStatus
FROM         (SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                                              displayName, mail, distinguishedName, cn
                       FROM          OPENQUERY(ADSI, 
                                              'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=Home Office,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
		')
                                               AS AD_HO) AS HO

UNION

SELECT     cn AS FullName, distinguishedName, mail AS Email, displayName, sAMAccountName AS LoginName, title, company, physicalDeliveryOfficeName AS Location, 
                      department, streetAddress AS Address, l AS City, st AS State, postalCode, co AS Country, c AS CountryCode, telephoneNumber AS Phone, 
                      CASE WHEN isnull(userAccountControl & 2, 0) > 0 THEN 'Disabled' ELSE 'Enabled' END AS AccountStatus
FROM    (SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                    displayName, mail, distinguishedName, cn
         FROM          OPENQUERY(ADSI, 
           'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=US,ou=Franchises,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
			  AND (sAMAccountName=''A*'' OR sAMAccountName=''B*'' OR sAMAccountName=''C*'' OR sAMAccountName=''D*'' OR sAMAccountName=''E*'')
		   ') AS AD_US1
		 UNION
	     SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                    displayName, mail, distinguishedName, cn
         FROM          OPENQUERY(ADSI, 
           'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=US,ou=Franchises,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
			  AND (sAMAccountName=''F*'' OR sAMAccountName=''G*'' OR sAMAccountName=''H*'' OR sAMAccountName=''I*'' OR sAMAccountName=''J*'')
		   ') AS AD_US2
		 UNION
	     SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                    displayName, mail, distinguishedName, cn
         FROM          OPENQUERY(ADSI, 
           'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=US,ou=Franchises,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
			  AND (sAMAccountName=''K*'' OR sAMAccountName=''L*'' OR sAMAccountName=''M*'' OR sAMAccountName=''N*'' OR sAMAccountName=''O*'')
		   ') AS AD_US3
		 UNION
	     SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                    displayName, mail, distinguishedName, cn
         FROM          OPENQUERY(ADSI, 
           'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=US,ou=Franchises,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
			  AND (sAMAccountName=''P*'' OR sAMAccountName=''Q*'' OR sAMAccountName=''R*'' OR sAMAccountName=''S*'' OR sAMAccountName=''T*'')
		   ') AS AD_US4
		 UNION
	     SELECT     userAccountControl, telephoneNumber, c, co, postalCode, st, l, streetAddress, department, physicalDeliveryOfficeName, company, title, sAMAccountName, 
                    displayName, mail, distinguishedName, cn
         FROM          OPENQUERY(ADSI, 
           'SELECT cn, distinguishedName, mail, displayName, sAMAccountName, title, 
				company, physicalDeliveryOfficeName, department, streetAddress, l,
				st, postalCode, co, c, telephoneNumber, userAccountControl 
			FROM ''LDAP://svr-tmt-dc1.twomen.com/ou=US,ou=Franchises,dc=twomen,dc=com'' 
			WHERE objectClass=''User''
			  AND objectCategory = ''Person''
			  AND (sAMAccountName=''U*'' OR sAMAccountName=''V*'' OR sAMAccountName=''W*'' OR sAMAccountName=''X*'' OR sAMAccountName=''Y*'' OR sAMAccountName=''Z*'')
		   ') AS AD_US5
                                               ) AS US

