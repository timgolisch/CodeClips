-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'FormatSSN')
	DROP FUNCTION dbo.FormatSSN
GO

CREATE FUNCTION dbo.FormatSSN(@SSN VarChar(11))
RETURNS varchar(11)
AS
BEGIN
	Declare @Out varchar(11)

	IF CharIndex('-', @SSN) > 0
		SET @Out = @SSN
	ELSE
		SET @Out = SubString(@SSN, 1, 3) + '-' + SubString(@SSN,4,2) + '-' + SubString(@SSN, 6, 4)

	Return @Out
END
GO

GRANT EXEC ON dbo.FormatSSN TO Public
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.FormatSSN('123456789')
GO

