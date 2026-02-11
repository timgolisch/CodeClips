SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  FUNCTION dbo.DateTimeToIso8601 
	(@InDate DateTime)
RETURNS varchar(26)
AS
BEGIN
	Declare @Out VarChar(26)

	If @InDate IS NULL
		Set @Out = '';
	Else
		Set @Out = Convert(VarChar,DatePart(yyyy, @InDate)) + '-' 
			+ Right('0' + Convert(VarChar,DatePart(mm, @InDate)),2) + '-' 
			+ Right('0' + Convert(VarChar,DatePart(dd, @InDate)),2) + 'T' 
			+ Right('0' + DatePart(hh, @InDate),2) + ':' 
			+ Right('0' + DatePart(n, @InDate),2) + ':' 
			+ Right('0' + DatePart(ss, @InDate),2);

	Return @Out
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT EXEC ON dbo.DateTimeToIso8601 TO PUBLIC
GO
