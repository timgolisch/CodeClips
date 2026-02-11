-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'DateToString')
	DROP FUNCTION dbo.DateToString
GO

CREATE FUNCTION dbo.DateToString
	(@inDate DateTime)
RETURNS VarChar(15)
AS
BEGIN
	return Convert(VarChar,Month(@inDate)) + '/' + Convert(VarChar,Day(@inDate)) + '/' + Convert(VarChar,Year(@inDate))
END
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.DateToString(Convert(DateTime, '2/16/2005'))
GO

