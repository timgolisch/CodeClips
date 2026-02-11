-- Add your test scenario here --

declare @Lat float, @Lon float

exec dbo.AddressToLatLon('3400 Belle Chase Way, Lansing, MI 48911', @Lat, @Lon)

select @Lat as Lat, @Lon as Lon
