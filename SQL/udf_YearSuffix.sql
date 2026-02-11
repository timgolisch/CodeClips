-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'YearSuffix')
	DROP FUNCTION YearSuffix
GO

CREATE FUNCTION dbo.YearSuffix
	(@Year int)
RETURNS VarChar(2)
AS
BEGIN
	
	RETURN SubString(Convert(VarChar, @Year), 3, 2)
END
GO

GRANT EXEC ON dbo.YearSuffix TO Public
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.YearSuffix(2005)
GO

