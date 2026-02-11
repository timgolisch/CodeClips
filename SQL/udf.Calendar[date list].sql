
/****** Object:  UserDefinedFunction [dbo].[udfCalendar]    Script Date: 07/02/2012 11:01:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		TG
-- Create date: 10/20/2011
-- Description:	Generate a simple calendar table with every date within the period specified (by param)
-- =============================================
-- To Test:
-- SELECT * FROM dbo.udfCalendar(GetDate(), DateAdd(d, 20, GetDate()));
-- ...should return 20 days starting from today.
-- =============================================
-- DROP FUNCTION dbo.udfCalendar 

CREATE FUNCTION [dbo].[udfCalendar] 
(	
	@StartDate Date,
	@EndDate Date
)
RETURNS @Calendar TABLE (ID int, DateValue DateTime, DayValue int, MonthValue int, YearValue int)
AS

BEGIN
	WHILE @StartDate < @EndDate
	BEGIN
		INSERT @Calendar
		SELECT
			YEAR (@StartDate) * 10000 + MONTH (@StartDate) * 100 + Day (@StartDate) AS ID,
			@StartDate AS DateValue,
			DATEPART (dd, @StartDate) AS DayValue,
			DATEPART (mm, @StartDate) AS MonthValue,
			DATEPART (yy, @StartDate) AS YearValue;
		
		SET @StartDate = DateAdd(d, 1, @StartDate);
	END
	
	RETURN;
END


GO


