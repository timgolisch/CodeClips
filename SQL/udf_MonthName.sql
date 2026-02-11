-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'MonthName')
	DROP FUNCTION MonthName
GO

CREATE FUNCTION dbo.MonthName 
	(@MonthNumber int) --, @Length int = 15)
RETURNS VarChar(15)
AS
BEGIN
	Declare @MonthName VarChar(15)

	IF @MonthNumber = 1
		SET @MonthName = 'January'
	ELSE IF @MonthNumber = 2
		SET @MonthName = 'February'
	ELSE IF @MonthNumber = 3
		SET @MonthName = 'March'
	ELSE IF @MonthNumber = 4
		SET @MonthName = 'April'
	ELSE IF @MonthNumber = 5
		SET @MonthName = 'May'
	ELSE IF @MonthNumber = 6
		SET @MonthName = 'June'
	ELSE IF @MonthNumber = 7
		SET @MonthName = 'July'
	ELSE IF @MonthNumber = 8
		SET @MonthName = 'August'
	ELSE IF @MonthNumber = 9
		SET @MonthName = 'September'
	ELSE IF @MonthNumber = 10
		SET @MonthName = 'October'
	ELSE IF @MonthNumber = 11
		SET @MonthName = 'November'
	ELSE IF @MonthNumber = 12
		SET @MonthName = 'December'


	--RETURN SubString(@MonthName, 0, @Length)
	RETURN @MonthName
END
GO

GRANT EXEC ON dbo.MonthName TO Public
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.MonthName(2) AS LongMonth --, dbo.MonthName(5,3) AS ShortMonth
GO

