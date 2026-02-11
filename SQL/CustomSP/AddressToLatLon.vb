Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.SqlTypes
Imports Microsoft.SqlServer.Server

'http://code.google.com/apis/maps/signup.html
'http://www.codeproject.com/KB/webservices/GeoLocationByRadius.aspx


Partial Public Class StoredProcedures
    Private Const cGoogleAPIKey As String = "ABQIAAAAUcd8DZ7-DFI3zJ5eFtRCZBRiSjztwzgoMe57QLOZxn5aZWRE9hR2sq-NlTf7d1NgRAg7x--Lz4fDxg"

    <Microsoft.SqlServer.Server.SqlProcedure()> _
    Public Shared Sub GetLatLon(ByVal address As String, ByRef latitude As Single, ByRef longitude As Single)
        ' use the Google Map API to lookup the lat/lon for this address
        Dim gmapRequest As String = "http://maps.google.com/maps/geo?key=" & _
            cGoogleAPIKey & _
            "&q=" & address & "&sensor=false&output=xml" 'output as XML instead of csv or kml
        'example: http://maps.google.com/maps/geo?key=ABQIAAAAUcd8DZ7-DFI3zJ5eFtRCZBRiSjztwzgoMe57QLOZxn5aZWRE9hR2sq-NlTf7d1NgRAg7x--Lz4fDxg&q=34000 Belle Chase Way, Lansing, MI, 48911&sensor=false&output=xml

        Try
            Dim xmlGeo As New System.Xml.XmlDocument
            Dim coordinatesNodeList As System.Xml.XmlNodeList

            'get the response from Google Map 
            xmlGeo.Load(gmapRequest)

            'find the "coordinates" element
            coordinatesNodeList = xmlGeo.GetElementsByTagName("coordinates")
            Dim strCoord As String = coordinatesNodeList.Item(0).InnerText
            Dim strLatLon() As String = Split(strCoord, ",")

            latitude = CSng(strLatLon(0))
            longitude = CSng(strLatLon(1))
        Catch ex As Exception
            'jeez, if it fails, just punt
            Debug.Print(ex.Message)
        End Try
    End Sub
End Class
