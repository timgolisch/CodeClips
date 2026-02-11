SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

DROP FUNCTION dbo.DateToShortDate
GO

CREATE   FUNCTION dbo.DateToShortDate 
	(@InDate DateTime)
RETURNS varchar(26)
AS
BEGIN
	Declare @Out VarChar(26)

	If @InDate IS NULL
		Set @Out = '';
	Else
		Set @Out = Convert(VarChar,DatePart(mm, @InDate)) + '/' + 
			Convert(VarChar,DatePart(dd, @InDate)) + '/' +
			Convert(VarChar,DatePart(yyyy, @InDate));

	Return @Out
END
Go

GRANT EXEC ON dbo.DateToShortDate TO Public
GO

--test
SELECT dbo.DateToShortDate(GetDate())


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

