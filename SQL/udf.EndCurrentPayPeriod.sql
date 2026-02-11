-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'EndCurrentPayPeriod')
	DROP FUNCTION dbo.EndCurrentPayPeriod
GO

CREATE FUNCTION dbo.EndCurrentPayPeriod (@datToday DateTime)
RETURNS DateTime
AS
BEGIN
	DECLARE @PayPeriodAnchor DateTime;  SET @PayPeriodAnchor = '1/3/2005'; -- a known pay period begin date
	--IF @datToday IS NULL SET @datToday = GetDate();

	------------------------------------------------------
	-- Description: this simply removes the days, Hrs, Min, Sec since the beginning of 
	--  the current pay period, then adds 6 days to get the end of this pay period
	-- Logic:
	--  Find the number of days since Jan 3, 2005 (a known pay period begin)
	--  Find the modulus (remainder) to tell us how far into the current week we are
	--  Subtract the modulus from the number of days since Jan 3, 2005
	--  Add 6 (to get the end of this pay period, not the beginning)
	--  This is how many days between Jan 3, 2005 and the end of the current pay period
	--   add it to 1/3/2005 and we have the end of the current pay period
	------------------------------------------------------
	RETURN DateAdd(d, 6 + DateDiff(d,@PayPeriodAnchor,@datToday) - (DateDiff(d,@PayPeriodAnchor,@datToday) % 7), @PayPeriodAnchor)
END
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.EndCurrentPayPeriod(GetDate())
SELECT dbo.EndCurrentPayPeriod('2/20/2005') 

GO