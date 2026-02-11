Namespace DStoXLSX
    Public Class XSLX
#Region "Factory Methods"
        Public Shared Function GetXSLX(ds As DataSet, Optional filename As String = "") As String
            Dim xslx As New Workbook(ds)
            Dim workbook As String
            Dim worksheets As New List(Of String)
            Dim file As New ZipFile

            workbook = xslx.Serialize
            For Each WorkSheet As WorkSheet In xslx.WorkSheets
                worksheets.Add(WorkSheet.Serialize)
            Next
            Return workbook & vbCrLf & "---------" & vbCrLf & worksheets(0)
        End Function
#End Region
#Region " Helper Methods"


        Public Shared Function GetExcelColumnName(ByVal columnIndex As Integer) As String
            '  Convert a zero-based column index into an Excel column reference  (A, B, C.. Y, Y, AA, AB, AC... AY, AZ, B1, B2..)
            '
            '  eg  GetExcelColumnName(0) should return "A"
            '      GetExcelColumnName(1) should return "B"
            '      GetExcelColumnName(25) should return "Z"
            '      GetExcelColumnName(26) should return "AA"
            '      GetExcelColumnName(27) should return "AB"
            '      ..etc..
            '
            If (columnIndex < 26) Then
                Return ChrW(65 + columnIndex)
            End If
            Dim firstChar As Char = ChrW(65 + (columnIndex / 26) - 1)
            Dim secondChar As Char = ChrW(65 + (columnIndex Mod 26))
            Return String.Format("{0}{1}", firstChar, secondChar)
        End Function


#End Region

    End Class
End Namespace
