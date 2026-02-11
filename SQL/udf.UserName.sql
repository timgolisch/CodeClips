-- =============================================
-- Create inline function (IF)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'UserName')
	DROP FUNCTION UserName
GO

CREATE FUNCTION dbo.UserName(@bolStripDomainPrefix AS bit = 1)
RETURNS varchar(255) 
AS
BEGIN
	DECLARE @UserName varchar(255)
	IF (@bolStripDomainPrefix = 1) AND (LEFT(SUSER_SNAME(),LEN(HOST_NAME()))=HOST_NAME())
		SET @UserName = SubString(SUSER_SNAME(),LEN(HOST_NAME())+2,255)
	ELSE
		SET @UserName = SUSER_SNAME()

	RETURN @UserName
END
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.UserName(0)
GO

