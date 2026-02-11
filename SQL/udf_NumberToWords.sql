DROP Function dbo.NumberToWords
GO

/********************************************************************
* Description: this function converts a number to an english 
*              description of the number.  It uses recursion to 
*              handle the repeating pattern of hundreds for every 
*              factor of 100 (Thousands, Millions, etc)
* Ex: dbo.NumberToWords(1024) returns 'One Thousand Twenty Four'
* Limitations: This function only handles positive integers below 
*              1 Trillion
********************************************************************/
CREATE FUNCTION dbo.NumberToWords 
	(@SomeNum As BigInt, 
	 @Suffix As VarChar(50)
	)
RETURNS VarChar(255)
AS
BEGIN

Declare @NumName As VarChar(255),
	@Out As VarChar(255)

If (@SomeNum >= 1000000000 AND @SomeNum <= 999999999999)
    --use recursion for the millions part
    Set @NumName = dbo.NumberToWords(@SomeNum / 1000000000, ' Billion ')  +  dbo.NumberToWords(@SomeNum % 1000000000, '')
Else If (@SomeNum >= 1000000 AND @SomeNum <= 999999999)
    --use recursion for the thousands part
    Set @NumName = dbo.NumberToWords(@SomeNum / 1000000, ' Million ')  +  dbo.NumberToWords(@SomeNum % 1000000, '')
Else If (@SomeNum >= 1000 AND @SomeNum <= 999999)
    --use recursion for the hundreds part
    Set @NumName = dbo.NumberToWords(@SomeNum / 1000, ' Thousand ')  +  dbo.NumberToWords(@SomeNum % 1000, '')
Else If (@SomeNum >= 100 AND @SomeNum <= 999)
    --use recursion for the tens part
    Set @NumName = dbo.NumberToWords(@SomeNum / 100, ' Hundred ')  +  dbo.NumberToWords(@SomeNum % 100, '')
Else If (@SomeNum >= 20 AND @SomeNum <= 99)
    --the number suffix for the tens part follows a slightly different pattern
    SELECT @NumName = CASE @SomeNum/10
 	WHEN 9 THEN 'Ninety '  +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 8 THEN 'Eighty '  +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 7 THEN 'Seventy ' +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 6 THEN 'Sixty '   +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 5 THEN 'Fifty '   +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 4 THEN 'Fourty '  +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 3 THEN 'Thirty '  +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 2 THEN 'Twenty '  +  dbo.NumberToWords(@SomeNum % 10, '')
	WHEN 1 THEN 'Ten '     +  dbo.NumberToWords(@SomeNum % 10, '') --this will never get hit.  its here for fun
	WHEN 0 THEN dbo.NumberToWords(@SomeNum % 10, '')
    END 
Else If @SomeNum < 20
    SELECT @NumName = CASE 
 	WHEN @SomeNum = 19 THEN 'Nineteen'
	WHEN @SomeNum = 18 THEN 'Eighteen'
	WHEN @SomeNum = 17 THEN 'Seventeen'
	WHEN @SomeNum = 16 THEN 'Sixteen'
	WHEN @SomeNum = 15 THEN 'Fifteen'
	WHEN @SomeNum = 14 THEN 'Fourteen'
	WHEN @SomeNum = 13 THEN 'Thirteen'
	WHEN @SomeNum = 12 THEN 'Twelve'
	WHEN @SomeNum = 11 THEN 'Eleven'
	WHEN @SomeNum = 10 THEN 'Ten'
 	WHEN @SomeNum =  9 THEN 'Nine'
	WHEN @SomeNum =  8 THEN 'Eight'
	WHEN @SomeNum =  7 THEN 'Seven'
	WHEN @SomeNum =  6 THEN 'Six'
	WHEN @SomeNum =  5 THEN 'Five'
	WHEN @SomeNum =  4 THEN 'Four'
	WHEN @SomeNum =  3 THEN 'Three'
	WHEN @SomeNum =  2 THEN 'Two'
	WHEN @SomeNum =  1 THEN 'One'
	WHEN @SomeNum =  0 THEN ''
    END 
Else
    -- this will only get hit for negative numbers or numbers above 1 trillion
    Set @NumName = Convert(VarChar, @SomeNum)


-- if there is a suffix, append it.  otherwise, just return the text
If LTrim(@Suffix) <> '' AND LTrim(@NumName) <> ''
	SELECT @Out = @NumName + ' ' + LTrim(@Suffix)
Else
	SELECT @Out = @NumName

-- done
Return @Out

END
GO

--allow anyone to use this harmless UDF
GRANT EXEC ON dbo.NumberToWords TO Public
GO

-------------------------
-- Testing...
-- SELECT dbo.NumberToWords(100266131252, '')
-------------------------
