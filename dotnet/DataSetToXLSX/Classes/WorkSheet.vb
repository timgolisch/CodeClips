Imports System.Xml.Serialization

Namespace DStoXLSX
    <Serializable(), XmlRootAttribute("worksheet", Namespace:="http://schemas.openxmlformats.org/spreadsheetml/2006/main", IsNullable:=False)> _
    Public Class WorkSheet
#Region "Public Properties"
#Region " Serializable"
        <XmlElement("autoFilter")> _
        Public Boundaries As Boundary
        <XmlArrayAttribute("sheetData")> _
        Public Rows() As Row
#End Region
#Region " Not Serializable"
        <XmlIgnore()> _
        Public Name As String
#End Region
#End Region

#Region "Constructors"
        Public Sub New()

        End Sub
        Public Sub New(dt As DataTable)
            Dim row As DataRow

            'first resize the row array
            ReDim Rows(dt.Rows.Count - 1)

            'then add the title row
            Rows(0) = New row

            ReDim Rows(0).Columns(dt.Columns.Count - 1)
            For x As Integer = 0 To dt.Columns.Count - 1 ' Each col As DataColumn In dt.Columns
                Rows(0).Columns(x) = New Row.ColumnData(dt.Columns(x).ColumnName, x, 0)
            Next

            'then add each row
            For x As Integer = 0 To dt.Rows.Count - 1
                row = dt.Rows(x)
                Me.Rows(x) = New row(row, x + 1)
            Next

            'copy table attributes
            Name = dt.TableName
            Boundaries = New Boundary(Me)
        End Sub
#End Region

#Region "Public Instance Methods"
        Public Function Serialize() As String
            Dim xmlOut As String = ""
            Dim mem As New IO.MemoryStream
            Dim serializer As New XmlSerializer(GetType(WorkSheet))
            Dim ns As New XmlSerializerNamespaces
            ns.Add("", "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
            ns.Add("r", "http://schemas.openxmlformats.org/officeDocument/2006/relationships")

            Try
                Dim writer As New IO.StreamWriter(mem, System.Text.Encoding.UTF8)
                serializer.Serialize(writer, Me, ns)
                xmlOut = System.Text.Encoding.UTF8.GetString(mem.ToArray)
            Catch ex As Exception
                Debug.Write(ex.Message)
            End Try
            Return xmlOut
        End Function
#End Region
#Region "Factory Methods"

#End Region

#Region " Hidden sub-Classes"
        <XmlType("autoFilter")> _
        Public Class Boundary
            <XmlAttribute("ref")> _
            Public UpperLeftLowerRightMost As String
            Public Sub New()

            End Sub
            Public Sub New(sheet As WorkSheet)
                Me.UpperLeftLowerRightMost = "A1:" + XSLX.GetExcelColumnName(sheet.Rows(0).Columns.Length - 1) + sheet.Rows.Count.ToString
            End Sub
        End Class
#End Region
    End Class
End Namespace
