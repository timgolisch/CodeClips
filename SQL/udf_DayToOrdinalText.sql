-- =============================================
-- Create inline function (IF)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'DayToOrdinalText')
	DROP FUNCTION DayToOrdinalText
GO

CREATE FUNCTION dbo.DayToOrdinalText
	(@Day int)
RETURNS VarChar(5)
AS
BEGIN
	DECLARE @Out VarChar(5)

	SELECT @Out = CASE 
		WHEN @Day = 1 or @Day = 21 or @Day = 31 THEN Convert(VarChar, @Day) + 'st'
		WHEN @Day = 2 or @Day = 22 THEN Convert(VarChar, @Day) + 'nd'
		WHEN @Day = 3 or @Day = 23 THEN Convert(VarChar, @Day) + 'rd'
		ELSE Convert(VarChar, @Day) + 'th'
	END

	RETURN @Out
END
GO

GRANT EXEC ON dbo.DayToOrdinalText TO Public
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.DayToOrdinalText(12), dbo.DayToOrdinalText(31), dbo.DayToOrdinalText(22), dbo.DayToOrdinalText(3)
GO

