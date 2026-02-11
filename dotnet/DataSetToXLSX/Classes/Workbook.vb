Imports System.Xml.Serialization

Namespace DStoXLSX
    <Serializable(), XmlRootAttribute("workbook", Namespace:="http://schemas.openxmlformats.org/spreadsheetml/2006/main", IsNullable:=False)> _
    Public Class Workbook
#Region "Public Properties"
#Region " Serializable"
        <XmlElement("workbookPr")> _
        Public DefaultTheme As Theme
        <XmlArrayAttribute("sheets")> _
        Public WorkbookSheetDefinitions As New List(Of sheet)
        <XmlArrayAttribute("definedNames")> _
        Public DefinedNames As New List(Of DefinedName)
#End Region
#Region " Not Serializable"
        <XmlIgnore()> _
        Public FileName As String
        <XmlIgnore()> _
        Public WorkSheets As New List(Of WorkSheet)
#End Region
#End Region

#Region "Constructors"
        Public Sub New()

        End Sub
        Public Sub New(ds As DataSet)
            Dim newSheet As WorkSheet
            For Each dt As DataTable In ds.Tables
                newSheet = New WorkSheet(dt)
                Me.WorkSheets.Add(newSheet)
                Me.WorkbookSheetDefinitions.Add(New sheet(dt.TableName, Me.WorkbookSheetDefinitions.Count + 1))
                'add a definedName for each sheet
                DefinedNames.Add(New DefinedName(newSheet, CStr(WorkSheets.Count - 1)))
            Next

        End Sub
#End Region

#Region "Public Instance Methods"
        Public Function Serialize() As String
            Dim xmlOut As String = ""
            Dim mem As New IO.MemoryStream
            Dim serializer As New XmlSerializer(GetType(Workbook))
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
#Region " Hidden sub-classes"
        Public Class sheet
            <XmlAttribute("name")> _
            Public Name As String
            <XmlAttribute("sheetId")> _
            Public SheetID As String
            <XmlAttribute("id", Namespace:="http://schemas.openxmlformats.org/officeDocument/2006/relationships")> _
            Public RelationID As String = "rId1"

            Public Sub New()

            End Sub
            Public Sub New(newName As String, newSheetID As String)
                Me.Name = newName
                Me.SheetID = newSheetID
            End Sub
        End Class

        <XmlType("definedName")> _
        Public Class DefinedName
            'Attributes
            <XmlAttribute()> _
            Public name As String
            <XmlAttribute()> _
            Public localSheetId As String
            <XmlAttribute()> _
            Public hidden As String
            'Element
            <XmlText()> _
            Public value As String
            Public Sub New()

            End Sub
            Public Sub New(newName As String, newSheetID As String, newHidden As String, newBoundary As String)
                name = newName
                localSheetId = newSheetID
                hidden = newHidden
                value = newBoundary
            End Sub
            Public Sub New(newSheet As WorkSheet, newSheetID As String, Optional newHidden As String = "1")
                name = "_xlnm._FilterDatabase"
                localSheetId = newSheetID
                hidden = newHidden
                value = newSheet.Name + "!" + "$A$1:" + "$" + XSLX.GetExcelColumnName(newSheet.Rows(0).Columns.Count - 1) + "$" + newSheet.Rows.Count.ToString
            End Sub
        End Class

        <XmlType("workbookPr")> _
        Public Class Theme
            'Attributes
            <XmlAttribute()> _
            Public defaultThemeVersion As String = "124226"
        End Class

#End Region
    End Class
End Namespace
