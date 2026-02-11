-- =============================================
-- Create scalar function (FN)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'StateName')
	DROP FUNCTION StateName
GO

CREATE FUNCTION dbo.StateName
	(@StateAbbr VarChar(2))
RETURNS VarChar(20)
AS
BEGIN
	DECLARE @Out VarChar(20)

	SELECT @Out = CASE @StateAbbr
		WHEN 'AL' THEN 'Alabama'
		WHEN 'AK' THEN 'Alaska'
		WHEN 'AZ' THEN 'Arizona'
		WHEN 'AR' THEN 'Arkansas'
		WHEN 'CA' THEN 'California'
		WHEN 'CO' THEN 'Colorado'
		WHEN 'CT' THEN 'Connecticut'
		WHEN 'DE' THEN 'Delaware'
		WHEN 'FL' THEN 'Florida'
		WHEN 'GA' THEN 'Georgia'
		WHEN 'HI' THEN 'Hawaii'
		WHEN 'ID' THEN 'Idaho'
		WHEN 'IL' THEN 'Illinois'
		WHEN 'IN' THEN 'Indiana'
		WHEN 'IA' THEN 'Iowa'
		WHEN 'KS' THEN 'Kansas'
		WHEN 'KY' THEN 'Kentucky'
		WHEN 'LA' THEN 'Louisiana'
		WHEN 'ME' THEN 'Maine'
		WHEN 'MD' THEN 'Maryland'
		WHEN 'MA' THEN 'Massachusetts'
		WHEN 'MI' THEN 'Michigan'
		WHEN 'MN' THEN 'Minnesota'
		WHEN 'MS' THEN 'Mississippi'
		WHEN 'MO' THEN 'Missouri'
		WHEN 'MT' THEN 'Montana'
		WHEN 'NE' THEN 'Nebraska'
		WHEN 'NV' THEN 'Nevada'
		WHEN 'NH' THEN 'New Hampshire'
		WHEN 'NJ' THEN 'New Jersey'
		WHEN 'NM' THEN 'New Mexico'
		WHEN 'NY' THEN 'New York'
		WHEN 'NC' THEN 'North Carolina'
		WHEN 'ND' THEN 'North Dakota'
		WHEN 'OH' THEN 'Ohio'
		WHEN 'OK' THEN 'Oklahoma'
		WHEN 'OR' THEN 'Oregon'
		WHEN 'PA' THEN 'Pennsylvania'
		WHEN 'RI' THEN 'Rhode Island'
		WHEN 'SC' THEN 'South Carolina'
		WHEN 'SD' THEN 'South Dakota'
		WHEN 'TN' THEN 'Tennessee'
		WHEN 'TX' THEN 'Texas'
		WHEN 'UT' THEN 'Utah'
		WHEN 'VT' THEN 'Vermont'
		WHEN 'VA' THEN 'Virginia'
		WHEN 'WA' THEN 'Washington'
		WHEN 'WV' THEN 'West Virginia'
		WHEN 'WI' THEN 'Wisconsin'
		WHEN 'WY' THEN 'Wyoming'

		WHEN 'AS' THEN 'American Samoa'
		WHEN 'DC' THEN 'District of Columbia'
		WHEN 'FM' THEN 'Federated States of Micronesia'
		WHEN 'GU' THEN 'Guam'
		WHEN 'MH' THEN 'Marshall Islands'
		WHEN 'MP' THEN 'Northern Mariana Islands'
		WHEN 'PW' THEN 'Palau'
		WHEN 'PR' THEN 'Puerto Rico'
		WHEN 'VI' THEN 'Virgin Islands'
	END	

	RETURN @Out
END
GO

GRANT EXEC on dbo.StateName TO Public
GO

-- =============================================
-- Example to execute function
-- =============================================
SELECT dbo.StateName('WI')
GO

