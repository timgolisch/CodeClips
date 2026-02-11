Imports System.Xml.Serialization

Namespace DStoXLSX
    <XmlType("row")> _
    Public Class Row
#Region "Public Properties"
#Region " Serializable"
        <XmlAttribute("r")> _
        Public RowNumber As String
        '<XmlAttribute("spans")> _
        'Public ColSpan As String
        <XmlElement("c")> _
        Public Columns() As ColumnData
#End Region
#Region " Not Serializable"

#End Region
#End Region

#Region "Constructors"
        Public Sub New()

        End Sub
        Public Sub New(dr As DataRow, rownum As String)
            Try
                RowNumber = rownum
                'ColSpan = "1:" & dr.ItemArray.Length.ToString
                'copy the column data into the columns for this row
                ReDim Columns(dr.ItemArray.Length - 1)
                For x As Integer = 0 To dr.ItemArray.Length - 1 ' Each col As Object In dr.ItemArray
                    Me.Columns(x) = New ColumnData(dr.ItemArray(x), x, RowNumber)
                Next
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
        End Sub
#End Region

#Region "Public Instance Methods"

#End Region
#Region "Factory Methods"

#End Region
#Region "Hidden sub-classes"
        <XmlType("c")> _
        Public Class ColumnData
            <XmlAttribute("r")> _
            Public CellName As String
            '<XmlAttribute("s")> _
            'Public Format As String
            <XmlAttribute("t")> _
            Public Type As String
            <XmlElement("v")> _
            Public Value As String
            Public Sub New()

            End Sub
            Public Sub New(col As Object, ord As Integer, rownumber As String)
                Me.CellName = XSLX.GetExcelColumnName(ord) + rownumber
                'Me.Format = "1" '1=number, 2=date
                If Not IsDBNull(col) Then
                    If Not IsNumeric(col) Then
                        Me.Type = "str" 's=shared strings, b=bit
                    End If
                    Me.Value = col.ToString
                End If
            End Sub
        End Class
#End Region
    End Class
End Namespace
