DROP Function dbo.MoneyToWords
GO


/********************************************************************
* Description: this function converts a Monetary value to an english 
*              description of the number.  It calls the NumberToWords
               function.
* Ex: dbo.MoneyToWords(1011) returns 'One Thousand Eleven Dollars'
* Limitations: This function only handles positive integers below 
*              1 Trillion
********************************************************************/
CREATE FUNCTION dbo.MoneyToWords 
	(@SomeNum As Money, 
	 @ShowCents As Bit
	)
RETURNS VarChar(255)
AS
BEGIN

Declare @Dollars As BigInt,
	@Cents As Int,
	@NumName As VarChar(255),
	@Out As VarChar(255)

    --split off the dollars & cents
    Set @Dollars = Floor(@SomeNum)

    --dollars
    If @SomeNum < 1
	Set @NumName = 'No Dollars'
    Else
	Set @NumName = dbo.NumberToWords(@Dollars, '') + ' Dollars'

    If @ShowCents = 1
    Begin
    	--split off the dollars & cents
    	Set @Cents = Convert(Int, Floor(@SomeNum * 100)) % 100

    	--cents
    	If @Cents < 1
	    Set @Out = @NumName + ' and No Cents'
    	Else
	    Set @Out = @NumName + ' and ' + dbo.NumberToWords(@Cents, '') + ' Cents'
    End
    Else
	Set @Out = @NumName

Return @Out

END
GO

-- let anyone run this harmless UDF
GRANT Exec ON dbo.MoneyToWords TO Public
GO

SELECT dbo.MoneyToWords(1026.06, 1)
