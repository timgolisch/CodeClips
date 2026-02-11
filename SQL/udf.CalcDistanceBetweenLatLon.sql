/****** Object:  UserDefinedFunction [dbo].[CalcGeoDistance]
        Script Date: 01/23/2009 12:23:39 
        Credit: http://www.codeproject.com/KB/webservices/GeoLocationByRadius.aspx
******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalcGeoDistance]
      (@LatitudeA      FLOAT = NULL,
       @LongitudeA     FLOAT = NULL,
       @LatitudeB      FLOAT = NULL,
       @LongitudeB     FLOAT = NULL,
       @InKilometers   BIT = 0
       )
RETURNS FLOAT
AS
BEGIN
      -- just set @InKilometers to 0 for miles or 1 for km
      -- ex:  SELECT dbo.CalcGeoDistance (30.123,27.1,28.14,32.23, 0)

      -- SELECT field1, field2, dbo.CalcGeoDistance(lat1, lon1, lat2, lon2, 0) as distance 
      -- FROM yourtable
      -- WHERE dbo.CalcGeoDistance(lat1, lon1, lat2, lon2, 0) <= 10 --within the ten miles range
      DECLARE @Distance FLOAT

      SET @Distance = (SIN(RADIANS(@LatitudeA)) *
              SIN(RADIANS(@LatitudeB)) +
              COS(RADIANS(@LatitudeA)) *
              COS(RADIANS(@LatitudeB)) *
              COS(RADIANS(@LongitudeA - @LongitudeB)))

      --Get distance in miles
        SET @Distance = (DEGREES(ACOS(@Distance))) * 69.09

      --If specified, convert to kilometers
      IF @InKilometers = 1
            SET @Distance = @Distance * 1.609344

      RETURN @Distance

END

GO

Grant EXEC on dbo.CalcGeoDistance TO Public
GO
