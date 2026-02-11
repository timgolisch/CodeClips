'#define INCLUDE_WEB_FUNCTIONS
Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Diagnostics
Imports System.Data

Namespace ExportToExcel

    Public Class ExcelXmlFileGenerator
        Const cDEFAULT_NAMESPACE As String = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"

#Region "Properties"
        Public Headers As New List(Of Header)
        Public ColumnWidths As New List(Of String)
#End Region

#Region "Web Functions - optional"
#If INCLUDE_WEB_FUNCTIONS Then
        ''' <summary>
        ''' Create an Excel file, and write it out to a MemoryStream (rather than directly to a file)
        ''' </summary>
        ''' <param name="dt">DataTable containing the data to be written to the Excel.</param>
        ''' <param name="filename">The filename (without a path) to call the new Excel file.</param>
        ''' <param name="Response">HttpResponse of the current page.</param>
        ''' <returns>True if it was created succesfully, otherwise false.</returns>
        Public Overloads Function CreateExcelXmlFile(ByVal dt As DataTable, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
            Try
                Dim ds As DataSet = New DataSet
                ds.Tables.Add(dt)
                CreateExcelXmlAsStream(ds, filename, Response)
                ds.Tables.Remove(dt)
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function

        ''' <summary>
        ''' Create an Excel file, and write it out to a MemoryStream (rather than directly to a file)
        ''' </summary>
        ''' <param name="ds">DataSet containing the data to be written to the Excel.</param>
        ''' <param name="filename">The filename (without a path) to call the new Excel file.</param>
        ''' <param name="Response">HttpResponse of the current page.</param>
        ''' <returns>Either a MemoryStream, or NULL if something goes wrong.</returns>
        Public Shared Function CreateExcelXmlAsStream(ByVal ds As DataSet, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
            Try
                Dim stream As System.IO.MemoryStream = New System.IO.MemoryStream
                Dim document As SpreadsheetDocument = SpreadsheetDocument.Create(stream, SpreadsheetDocumentType.Workbook, True)
                WriteExcelFile(ds, document)
                stream.Flush()
                stream.Position = 0
                Response.ClearContent()
                Response.Clear()
                Response.Buffer = True
                Response.Charset = ""
                '  NOTE: If you get an "HttpCacheability does not exist" error on the following line, make sure you have
                '  manually added System.Web to this project's References.
                Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache)
                Response.AddHeader("content-disposition", ("attachment; filename=" + filename))
                Response.AddHeader("Content-Length", stream.Length.ToString())
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Dim data1() As Byte = New Byte((stream.Length) - 1) {}
                stream.Read(data1, 0, data1.Length)
                stream.Close()
                Response.BinaryWrite(data1)
                Response.Flush()
                Response.End()
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function

#End If '  End of "INCLUDE_WEB_FUNCTIONS" section
#End Region

#Region "Public"
        ''' <summary>
        ''' Create an Excel file, and write it to a file.
        ''' </summary>
        ''' <param name="ds">DataSet containing the data to be written to the Excel.</param>
        ''' <param name="xmlFilePath">Name of file to be written.</param>
        ''' <returns>True if successful, false if something went wrong.</returns>
        Public Overloads Function CreateExcelXmlFile(ByVal ds As DataSet, ByVal xmlFilePath As String) As Boolean
            Try
                Dim ExcelXmlFile As String
                ExcelXmlFile = GetExcelXmlFile(ds)
                System.IO.File.WriteAllText(xmlFilePath, ExcelXmlFile)

                Trace.WriteLine(("Successfully created: " & xmlFilePath))
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function

        Public Overloads Function CreateExcelXmlFile(ByVal dt As DataTable, ByVal xmlFilePath As String) As Boolean
            Dim ds As DataSet = New DataSet
            ds.Tables.Add(dt)
            Dim result As Boolean = CreateExcelXmlFile(ds, xmlFilePath)
            ds.Tables.Remove(dt)
            Return result
        End Function

#End Region

#Region "Private"
        Private Function GetExcelXmlFile(ByVal ds As DataSet) As String
            Dim file As New StringBuilder

            Dim header As String = cXMLHEADER
            'header = header.Replace("<Author></Author>", "<Author>" & UserName & "</Author>")
            'header = header.Replace("<LastAuthor></LastAuthor>", "<LastAuthor>" & UserName & "</LastAuthor>")
            header = header.Replace("<Created></Created>", "<Created>" & DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ssZ") & "</Created>")
            header = header.Replace("<LastSaved></LastSaved>", "<LastSaved>" & DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ssZ") & "</LastSaved>")
            file.Append(header)
            file.Append(cSTYLE)

            '  Each DataTable in our DataSet will become an Excel Worksheet in the spreasheet.
            Dim worksheetNumber As Integer = 1
            For Each dt As DataTable In ds.Tables
                Dim worksheetName As String = dt.TableName

                Dim range As String = "R" & CStr(Me.Headers.Count + 1) & "C1:R" & CStr(Me.Headers.Count + dt.Rows.Count + 1) & "C" & CStr(dt.Columns.Count)

                'Begin Worksheet 
                file.Append(" <Worksheet ss:Name=""" & worksheetName & """>" & vbCrLf & _
                            "  <Names>" & vbCrLf & _
                            "   <NamedRange ss:Name=""_FilterDatabase"" ss:RefersTo=""=" & worksheetName & "!" & range & """ ss:Hidden=""1""/>" & vbCrLf & _
                            "  </Names>" & vbCrLf)

                ' create sheet data
                file.Append(DataTableToExcelXmlWorksheet(dt))

                'Last step: put an AutoFilter around all of the data, so the user can easily filter/sort
                file.Append(cWORKSHEETEND.Replace("x:Range=""""", "x:Range=""" & range & """"))

                'End Worksheet
            Next
            'close the XML
            file.Append("</Workbook>")

            Return file.ToString
        End Function

        Private Function DataTableToExcelXmlWorksheet(ByVal dt As DataTable) As String
            Dim sheet As New StringBuilder

            Dim rowIndex As Integer = 1
            Dim colInx As Integer
            Dim rowStyle As String = ""
            Dim boundaryUpperLeft As String

            'evaluate the columns' types before rendering them
            Dim IsNumericColumn() As Boolean = New Boolean(dt.Columns.Count - 1) {}
            For colInx = 0 To dt.Columns.Count - 1
                Dim col As DataColumn = dt.Columns(colInx)
                IsNumericColumn(colInx) = ((col.DataType.FullName = "System.Decimal") OrElse (col.DataType.FullName = "System.Int32"))
            Next

            '  Create a table Header row in the Excel file
            sheet.Append("  <Table ss:ExpandedColumnCount=""" & CStr(dt.Columns.Count) & """ ss:ExpandedRowCount=""" & CStr(dt.Rows.Count + Headers.Count + 1) & """ x:FullColumns=""1"" x:FullRows=""1"" ss:StyleID=""s57"" ss:DefaultRowHeight=""15"">" & vbCrLf)

            '  For each Column of data in the DataTable
            '  create an column descriptor, showing the width of each.
            For n As Integer = 0 To dt.Columns.Count - 1
                If Me.ColumnWidths.Count < n Then
                    sheet.Append("   <Column ss:StyleID=""s57"" ss:AutoFitWidth=""1""/>" & vbCrLf)
                Else
                    sheet.Append("   <Column ss:StyleID=""s57"" ss:AutoFitWidth=""1"" ss:Width=""" & Me.ColumnWidths(n) & """/>" & vbCrLf)
                End If
            Next

            '
            '  Report Headers
            '
            For Each reportHeaderRow As Header In Me.Headers
                Select Case reportHeaderRow.Type
                    Case HeaderType.Title
                        sheet.Append("   <Row ss:Height=""15.75"">" & vbCrLf & _
                                    "    <Cell ss:StyleID=""s64""><Data ss:Type=""String"">" & reportHeaderRow.Text & "</Data></Cell>" & vbCrLf & _
                                    "   </Row>" & vbCrLf)
                    Case HeaderType.Filters
                        sheet.Append("   <Row>" & vbCrLf & _
                                    "    <Cell ss:StyleID=""s58""><ss:Data ss:Type=""String""" & vbCrLf & _
                                    "      xmlns=""http://www.w3.org/TR/REC-html40"">" & reportHeaderRow.Text & "</ss:Data></Cell>" & vbCrLf & _
                                    "   </Row>" & vbCrLf)
                    Case Else
                End Select
                rowIndex += 1
            Next

            '
            '  Table Header row 
            '
            boundaryUpperLeft = GetExcelColumnName(0) & CStr(rowIndex)

            sheet.Append("   <Row>" & vbCrLf)
            For colInx = 0 To dt.Columns.Count - 1
                sheet.Append("    <Cell ss:StyleID=""s59""><Data ss:Type=""String"">" & dt.Columns(colInx).ColumnName & "</Data><NamedCell ss:Name=""_FilterDatabase""/></Cell>" & vbCrLf)
            Next
            sheet.Append("   </Row>" & vbCrLf)

            '
            '  Now, step through each row of data in the DataTable...
            '
            Dim cellNumericValue As Double = 0
            For Each dr As DataRow In dt.Rows
                ' ...create a new row, and append a set of this row's data to it.
                rowIndex += 1
                sheet.Append("   <Row>" & vbCrLf)
                If rowStyle = "s60" Then rowStyle = "s62" Else rowStyle = "s60"
                For colInx = 0 To dt.Columns.Count - 1

                    ' Create cell with data
                    If IsNumericColumn(colInx) Then
                        sheet.Append("        <Cell ss:StyleID=""" & IIf(rowStyle = "s60", "s61", "s63") & """><Data ss:Type=""Number"">" & dr.Item(colInx) & "</Data><NamedCell ss:Name=""_FilterDatabase""/></Cell>" & vbCrLf)
                    Else
                        sheet.Append("        <Cell ss:StyleID=""" & rowStyle & """><Data ss:Type=""String"">" & dr.Item(colInx) & "</Data><NamedCell ss:Name=""_FilterDatabase""/></Cell>" & vbCrLf)
                    End If
                Next 'column
                sheet.Append("   </Row>" & vbCrLf)
            Next 'row
            sheet.Append("  </Table>" & vbCrLf)

            Return sheet.ToString
        End Function
#End Region

#Region "Helper Functions"
        Private Shared Function GetExcelColumnName(ByVal columnIndex As Integer) As String
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
            Dim firstChar As Char = ChrW(65 + (columnIndex \ 26) - 1)
            Dim secondChar As Char = ChrW(65 + (columnIndex Mod 26))
            Return String.Format("{0}{1}", firstChar, secondChar)
        End Function
#End Region

#Region "Raw Formatting Constants"
        Private Const cSTYLE As String = _
                " <Styles>" & vbCrLf & _
                "  <Style ss:ID=""Default"" ss:Name=""Normal"">" & vbCrLf & _
                "   <Alignment ss:Vertical=""Bottom""/>" & vbCrLf & _
                "   <Borders/>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""/>" & vbCrLf & _
                "   <Interior/>" & vbCrLf & _
                "   <NumberFormat/>" & vbCrLf & _
                "   <Protection/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s57"" ss:Name=""RegularCell"">" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s58"" ss:Name=""ReportSubHeader"">" & vbCrLf & _
                "   <Alignment ss:Horizontal=""Left"" ss:Vertical=""Bottom""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#606010"" ss:Bold=""1""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s59"" ss:Name=""GridHeader"">" & vbCrLf & _
                "   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Center"" ss:WrapText=""1""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000"" ss:Bold=""1""/>" & vbCrLf & _
                "   <Interior ss:Color=""#BDB6A6"" ss:Pattern=""Solid""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s60"" ss:Name=""GridRow"">" & vbCrLf & _
                "   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s61"" ss:Name=""GridRowNumeric"">" & vbCrLf & _
                "   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbCrLf & _
                "   <NumberFormat ss:Format=""0""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s62"" ss:Name=""GridRowAlt"">" & vbCrLf & _
                "   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbCrLf & _
                "   <Interior ss:Color=""#EDE8DF"" ss:Pattern=""Solid""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s63"" ss:Name=""GridRowAltNumeric"">" & vbCrLf & _
                "   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbCrLf & _
                "   <Interior ss:Color=""#EDE8DF"" ss:Pattern=""Solid""/>" & vbCrLf & _
                "   <NumberFormat ss:Format=""0""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                "  <Style ss:ID=""s64"" ss:Name=""ReportTitle"">" & vbCrLf & _
                "   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Bottom""/>" & vbCrLf & _
                "   <Borders>" & vbCrLf & _
                "    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbCrLf & _
                "   </Borders>" & vbCrLf & _
                "   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""12"" ss:Color=""#000000""" & vbCrLf & _
                "    ss:Bold=""1""/>" & vbCrLf & _
                "  </Style>" & vbCrLf & _
                " </Styles>" & vbCrLf

        Private Const cXMLHEADER As String = _
                "<?xml version=""1.0""?>" & vbCrLf & _
                "<?mso-application progid=""Excel.Sheet""?>" & vbCrLf & _
                "<Workbook xmlns=""urn:schemas-microsoft-com:office:spreadsheet""" & vbCrLf & _
                " xmlns:o=""urn:schemas-microsoft-com:office:office""" & vbCrLf & _
                " xmlns:x=""urn:schemas-microsoft-com:office:excel""" & vbCrLf & _
                " xmlns:ss=""urn:schemas-microsoft-com:office:spreadsheet""" & vbCrLf & _
                " xmlns:html=""http://www.w3.org/TR/REC-html40"">" & vbCrLf & _
                " <DocumentProperties xmlns=""urn:schemas-microsoft-com:office:office"">" & vbCrLf & _
                "  <Author></Author>" & vbCrLf & _
                "  <LastAuthor></LastAuthor>" & vbCrLf & _
                "  <Created></Created>" & vbCrLf & _
                "  <LastSaved></LastSaved>" & vbCrLf & _
                "  <Version>14.00</Version>" & vbCrLf & _
                " </DocumentProperties>" & vbCrLf & _
                " <OfficeDocumentSettings xmlns=""urn:schemas-microsoft-com:office:office"">" & vbCrLf & _
                "  <AllowPNG/>" & vbCrLf & _
                " </OfficeDocumentSettings>" & vbCrLf

        Private Const cWORKSHEETEND As String = _
                "  <WorksheetOptions xmlns=""urn:schemas-microsoft-com:office:excel"">" & vbCrLf & _
                "   <Selected/>" & vbCrLf & _
                "   <DoNotDisplayGridlines/>" & vbCrLf & _
                "   <ProtectObjects>False</ProtectObjects>" & vbCrLf & _
                "   <ProtectScenarios>False</ProtectScenarios>" & vbCrLf & _
                "  </WorksheetOptions>" & vbCrLf & _
                "  <AutoFilter x:Range=""""" & vbCrLf & _
                "   xmlns=""urn:schemas-microsoft-com:office:excel"">" & vbCrLf & _
                "  </AutoFilter>" & vbCrLf & _
                " </Worksheet>" & vbCrLf

#End Region

#Region " sub classes"
        Enum HeaderType
            Title
            Filters
            Column
            None
        End Enum

        Public Class Header
            Public Text As String
            Public Type As HeaderType

            Public Sub New()
                Type = HeaderType.None
            End Sub
            Public Sub New(newText As String, Optional newType As HeaderType = HeaderType.None)
                Text = newText
                Type = newType
            End Sub
        End Class
#End Region
    End Class
End Namespace

