-- Add your test scenario here --

declare @Lat float, @Lon float;
declare @Addr nvarchar(1000);
Set @Addr = '3400 Belle Chase Way, Lansing, MI 48911';

execute dbo.GetLatLon @Addr, @Lat output, @Lon output

select @Lat as Lat, @Lon as Lon
