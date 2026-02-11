-- =============================================
-- Create table function (TF)
-- =============================================

CREATE FUNCTION Split 
	(@strSplitMe VarChar(8000))
RETURNS @Split TABLE 
	(ID VarChar(255))
AS
BEGIN
	Declare @strSubString VarChar(255)
	
	WHILE DataLength(@strSplitMe) > 0
	BEGIN 
		SELECT @strSubString = NULL
		IF CHARINDEX(',',@strSplitMe) > 0
		BEGIN 	-- get the first string up to the comma
			SELECT @strSubString = substring(@strSplitMe,1,CHARINDEX(',',@strSplitMe)-1)
			-- remove everything up to, and including the comma
			SELECT @strSplitMe = substring(@strSplitMe,CHARINDEX(',',@strSplitMe) + 1,DataLength(@strSplitMe)) 
		
		END
		ELSE -- last or only string
		BEGIN 
			SELECT @strSubString = @strSplitMe
			SELECT @strSplitMe = NULL
		END

		IF @strSubString IS NOT NULL
		BEGIN
			INSERT INTO @Split
			VALUES (@strSubString)
		END
	END --WHILE

	RETURN 
END
GO

-- =============================================
-- Example to execute function
-- =============================================
-- SELECT * FROM Split('test1,test2,test3')
GO

