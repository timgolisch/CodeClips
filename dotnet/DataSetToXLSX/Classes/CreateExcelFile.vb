'#define INCLUDE_WEB_FUNCTIONS
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Diagnostics
Imports System.Data
Imports System.Reflection
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Spreadsheet
Imports DocumentFormat.OpenXml
'Imports DocumentFormat.OpenXml.Drawing

Namespace ExportToExcel

    '----------------------------------------------------------------
    '  Credit: This code was adapted from another project
    '  http://www.codeproject.com/Articles/692092/A-free-Export-to-Excel-Csharp-class-using-OpenXML
    '  http://www.mikesknowledgebase.com
    '  For more info on formatting and other topics about OpenXml, download the free book "Open XML the markup explained"
    '  https://openxmldeveloper.org/cfs-file.ashx/__key/communityserver-components-postattachments/00-00-00-19-70/Open-XML-Explained.pdf
    '----------------------------------------------------------------

    Public Class ExcelFileGenerator(Of T) : Inherits ExcelFileGenerator 'Of T, declares T a generic type
        Public Overloads Function CreateExcelFile(ByVal list As List(Of T), ByVal xlsxFilePath As String) As Boolean
            Dim ds As DataSet = New DataSet
            ds.Tables.Add(ListToDataTable(list))
            Return MyBase.CreateExcelFile(ds, xlsxFilePath)
        End Function

#Region " Web Functions - optional"
#If INCLUDE_WEB_FUNCTIONS Then
        ''' <summary>
        ''' Create an Excel file, and write it out to a MemoryStream (rather than directly to a file)
        ''' </summary>
        ''' <param name="list">List of objects containing the data to be written to the Excel.</param>
        ''' <param name="filename">The filename (without a path) to call the new Excel file.</param>
        ''' <param name="Response">HttpResponse of the current page.</param>
        ''' <returns>True if it was created succesfully, otherwise false.</returns>
        Public Overloads Shared Function CreateExcelFile(ByVal list As List(Of T), ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
            Try
                Dim ds As DataSet = New DataSet
                ds.Tables.Add(ListToDataTable(list))
                MyBase.CreateExcelFileAsStream(ds, filename, Response)
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function
#End If '  End of "INCLUDE_WEB_FUNCTIONS" section
#End Region

#Region "HELPER FUNCTIONS"
        Public Shared Function ListToDataTable(ByVal list As List(Of T)) As DataTable
            Dim dt As DataTable = New DataTable
            For Each info As PropertyInfo In GetType(T).GetProperties
                dt.Columns.Add(New DataColumn(info.Name, GetNullableType(info.PropertyType)))
            Next
            For Each t As T In list
                Dim row As DataRow = dt.NewRow
                For Each info As PropertyInfo In GetType(T).GetProperties
                    If Not IsNullableType(info.PropertyType) Then
                        row(info.Name) = If(info.GetValue(t, Nothing), DBNull.Value)
                    End If
                Next
                dt.Rows.Add(row)
            Next
            Return dt
        End Function

        Private Shared Function GetNullableType(ByVal t As Type) As Type
            Dim returnType As Type = t
            If (t.IsGenericType AndAlso t.GetGenericTypeDefinition.Equals(GetType(Nullable))) Then
                returnType = Nullable.GetUnderlyingType(t)
            End If
            Return returnType
        End Function

        Private Shared Function IsNullableType(ByVal type As Type) As Boolean
            Return ((type = GetType(System.String)) _
                        OrElse (type.IsArray _
                        OrElse (type.IsGenericType AndAlso type.GetGenericTypeDefinition.Equals(GetType(Nullable)))))
        End Function
#End Region
    End Class

    Public Class ExcelFileGenerator
        Const cDEFAULT_NAMESPACE As String = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
        Private headerStyleIndexId As String = ""

#Region "Properties"
        Public Headers As New List(Of String)
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
        Public Overloads Function CreateExcelFile(ByVal dt As DataTable, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
            Try
                Dim ds As DataSet = New DataSet
                ds.Tables.Add(dt)
                CreateExcelDocumentAsStream(ds, filename, Response)
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
        Public Shared Function CreateExcelFileAsStream(ByVal ds As DataSet, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
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
        ''' <param name="xlsxFilePath">Name of file to be written.</param>
        ''' <returns>True if successful, false if something went wrong.</returns>
        Public Overloads Function CreateExcelFile(ByVal ds As DataSet, ByVal xlsxFilePath As String) As Boolean
            Try
                Using document As SpreadsheetDocument = SpreadsheetDocument.Create(xlsxFilePath, SpreadsheetDocumentType.Workbook)
                    WriteExcelFile(ds, document)
                End Using
                Trace.WriteLine(("Successfully created: " & xlsxFilePath))
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function

        Public Overloads Function CreateExcelFile(ByVal dt As DataTable, ByVal xlsxFilePath As String) As Boolean
            Dim ds As DataSet = New DataSet
            ds.Tables.Add(dt)
            Dim result As Boolean = CreateExcelFile(ds, xlsxFilePath)
            ds.Tables.Remove(dt)
            Return result
        End Function

#End Region

#Region "Private"
        Private Sub WriteExcelFile(ByVal ds As DataSet, ByVal spreadsheet As SpreadsheetDocument)
            Dim Sheets As DocumentFormat.OpenXml.Spreadsheet.Sheets = Nothing

            '  Create the Excel file contents.  This function is used when creating an Excel file either writing 
            '  to a file, or writing to a MemoryStream.
            spreadsheet.AddWorkbookPart()
            spreadsheet.WorkbookPart.Workbook = New DocumentFormat.OpenXml.Spreadsheet.Workbook

            '  The following line of code prevents crashes in Excel 2010
            spreadsheet.WorkbookPart.Workbook.Append(New BookViews(New WorkbookView))

            '  "WorkbookStylesPart" is required, in-case the user needs OLEDB to connect to this .xlsx file
            Dim workbookStylesPart As WorkbookStylesPart = spreadsheet.WorkbookPart.AddNewPart(Of WorkbookStylesPart)("rIdStyles")
            workbookStylesPart.Stylesheet = New Stylesheet()
            ' Defining the header style(s) can be pretty bulky. Better to do that in a separate function
            DefineHeaderStyle(workbookStylesPart.Stylesheet)
            spreadsheet.WorkbookPart.WorkbookStylesPart.Stylesheet.Save()

            '  Each DataTable in our DataSet will become an Excel Worksheet in the spreasheet.
            Dim worksheetNumber As UInteger = 1
            For Each dt As DataTable In ds.Tables
                '  Each worksheet needs a ReferenceID and a Name
                Dim workSheetID As String = ("rId" + worksheetNumber.ToString)
                Dim worksheetName As String = dt.TableName

                Dim newWorksheetPart As WorksheetPart = spreadsheet.WorkbookPart.AddNewPart(Of WorksheetPart)()
                newWorksheetPart.Worksheet = New DocumentFormat.OpenXml.Spreadsheet.Worksheet

                ' save worksheet
                WriteDataTableToExcelWorksheet(dt, newWorksheetPart)
                newWorksheetPart.Worksheet.Save()

                ' create the worksheet to workbook relation
                If (Sheets Is Nothing) Then
                    'add the List Of Sheets
                    spreadsheet.WorkbookPart.Workbook.AppendChild(New DocumentFormat.OpenXml.Spreadsheet.Sheets)
                    Sheets = spreadsheet.WorkbookPart.Workbook.GetFirstChild(Of DocumentFormat.OpenXml.Spreadsheet.Sheets)()
                End If
                'add the sheet to the list
                Dim newSheet As New DocumentFormat.OpenXml.Spreadsheet.Sheet _
                With {.Id = spreadsheet.WorkbookPart.GetIdOfPart(newWorksheetPart),
                    .SheetId = worksheetNumber,
                    .Name = dt.TableName
                }
                Sheets.AppendChild(newSheet)

                worksheetNumber = worksheetNumber + 1
            Next

            spreadsheet.WorkbookPart.Workbook.Save()
        End Sub

        Private Sub WriteDataTableToExcelWorksheet(ByVal dt As DataTable, ByVal worksheetPart As WorksheetPart)
            Dim worksheet = worksheetPart.Worksheet
            Dim sheetData As SheetData
            Dim columns As Columns
            Dim rowIndex As Integer = 1
            Dim colInx As Integer
            Dim cellValue As String = ""
            Dim boundaryUpperLeft As String

            '  Create a data Header row in the Excel file: for each Column of data in our DataTable.
            '
            '  Also create an array, showing which type each column of data is (Text or Numeric).
            '  So when the actual data is written, it will write Text values or Numeric cell values.
            Dim numberOfColumns As Integer = dt.Columns.Count
            Dim columnSizes() As Integer = New Integer(numberOfColumns - 1) {}
            Dim IsNumericColumn() As Boolean = New Boolean(numberOfColumns - 1) {}

            Dim excelColumnNames() As String = New String(numberOfColumns - 1) {}
            For n As Integer = 0 To numberOfColumns - 1
                excelColumnNames(n) = GetExcelColumnName(n)
            Next

            columns = worksheet.GetOrAddFirstChild(Of Columns)()
            ' Column widths
            For n As Integer = 0 To numberOfColumns - 1
                columnSizes(n) = Len(dt.Columns(n).ColumnName)
                Dim col As New Column
                col.Min = n + 1
                col.Max = n + 1
                col.Width = columnSizes(n) * 1.5
                col.CustomWidth = True
                columns.Append(col)
            Next

            ' create sheet data
            sheetData = worksheet.GetOrAddFirstChild(Of SheetData)()

            '
            'print-headers
            '
            For Each HeaderText As String In Me.Headers
                Dim pageHeaderRow = New Row() With {.RowIndex = rowIndex} ' add a row at the top of spreadsheet
                'pageHeaderRow
                sheetData.Append(pageHeaderRow)
                AppendTextCell((excelColumnNames(colInx) + CStr(rowIndex)), HeaderText, pageHeaderRow, HeaderType.Filters)
                rowIndex += 1
            Next

            '
            '  Header row 
            '
            boundaryUpperLeft = GetExcelColumnName(0) & CStr(rowIndex)
            Dim headerRow = New Row() With {.RowIndex = rowIndex} ' add a row at the top of spreadsheet
            sheetData.Append(headerRow)

            For colInx = 0 To numberOfColumns - 1
                Dim col As DataColumn = dt.Columns(colInx)
                AppendTextCell((excelColumnNames(colInx) + CStr(rowIndex)), col.ColumnName, headerRow, HeaderType.Title)
                IsNumericColumn(colInx) = ((col.DataType.FullName = "System.Decimal") _
                            OrElse (col.DataType.FullName = "System.Int32"))
            Next
            headerRow.StyleIndex = headerStyleIndexId

            '
            '  Now, step through each row of data in the DataTable...
            '
            Dim cellNumericValue As Double = 0
            For Each dr As DataRow In dt.Rows
                ' ...create a new row, and append a set of this row's data to it.
                rowIndex += 1
                Dim newExcelRow As New Row() With {.RowIndex = rowIndex} ' add a row at the top of spreadsheet
                sheetData.Append(newExcelRow)

                For colInx = 0 To numberOfColumns - 1
                    cellValue = dr.ItemArray(colInx).ToString

                    ' Create cell with data
                    If IsNumericColumn(colInx) Then
                        '  For numeric cells, make sure the input data IS a number, then write it out to the Excel file.
                        '  If this numeric value is NULL, then don't write anything to the Excel file.
                        cellNumericValue = 0
                        If Double.TryParse(cellValue, cellNumericValue) Then
                            cellValue = cellNumericValue.ToString
                            AppendNumericCell((excelColumnNames(colInx) + rowIndex.ToString), cellValue, newExcelRow)
                        End If
                    Else
                        '  For text cells, just write the input data straight out to the Excel file.
                        AppendTextCell((excelColumnNames(colInx) + rowIndex.ToString), cellValue, newExcelRow)
                    End If
                Next
            Next

            'Last step: put an AutoFilter around all of the data, so the user can easily filter/sort
            Dim filterArea As New DocumentFormat.OpenXml.Spreadsheet.AutoFilter()
            filterArea.Reference = boundaryUpperLeft & ":" & GetExcelColumnName(colInx - 1) & CStr(rowIndex)
            worksheet.AppendChild(filterArea)

            'Dim boundary As New DocumentFormat.OpenXml.Spreadsheet.Dimension
            'boundary.SetAttribute(New OpenXmlAttribute("ref", cDEFAULT_NAMESPACE, "A1:" & GetExcelColumnName(colInx - 1) & CStr(rowIndex)))
            'worksheet.AppendChild(boundary)

        End Sub
#End Region

#Region "Helper Functions"
        Enum HeaderType
            Title
            Filters
            Column
            None
        End Enum

        Private Sub AppendTextCell(ByVal cellReference As String, ByVal cellStringValue As String, ByVal excelRow As Row, Optional headerFormat As HeaderType = HeaderType.None)
            '  Add a new Excel Cell to the Row 
            Dim cell As New Cell With {.CellReference = cellReference, .DataType = CellValues.String}
            Dim cellValue As New CellValue
            Select Case headerFormat
                Case HeaderType.Title
                    cell.StyleIndex = headerStyleIndexId
                    cellValue.Text = cellStringValue
                'Case HeaderType.Filters
                '    cell.DataType = CellValues.InlineString
                '    cell.InlineString = New Spreadsheet.InlineString(cellStringValue)
                'Case HeaderType.Column
                '    cell.DataType = CellValues.InlineString
                '    cell.InlineString = New Spreadsheet.InlineString(cellStringValue)
                Case HeaderType.None
                    cellValue.Text = cellStringValue
                Case Else
                    cellValue.Text = cellStringValue
            End Select
            cell.Append(cellValue)
            excelRow.Append(cell)
        End Sub

        Private Sub AppendNumericCell(ByVal cellReference As String, ByVal cellStringValue As String, ByVal excelRow As Row)
            '  Add a new Excel Cell to the Row 
            Dim cell As New Cell With {.CellReference = cellReference}
            Dim cellValue As CellValue = New CellValue
            cellValue.Text = cellStringValue
            cell.Append(cellValue)
            excelRow.Append(cell)
        End Sub

        Private Function GetExcelColumnName(ByVal columnIndex As Integer) As String
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
#Region "Stylesheet"
        Private Sub DefineHeaderStyle(stylesheet As Stylesheet)
            'make sure the stylesheet already has the elements to hold these values that we will make
            If stylesheet.Fills Is Nothing Then stylesheet.Fills = New Fills(New Fill)
            If stylesheet.Borders Is Nothing Then stylesheet.Borders = New Borders(New Border)
            If stylesheet.Fonts Is Nothing Then stylesheet.Fonts = New Fonts(New Font)
            If stylesheet.CellFormats Is Nothing Then stylesheet.CellFormats = New CellFormats(New CellFormat)

            ' Step 1: A Fill holds a style
            Dim fill As New Fill(New PatternFill(New ForegroundColor, New BackgroundColor))
            'fill.PatternFill.ForegroundColor.Rgb = HexBinaryValue.FromString("FF1281F3")
            fill.PatternFill.BackgroundColor.Rgb = HexBinaryValue.FromString("FFDCF7FF")
            fill.PatternFill.PatternType = PatternValues.Solid
            stylesheet.Fills.Append(fill)

            'borders are created and stored separately
            Dim bottomBorder As New BottomBorder
            bottomBorder.Style = BorderStyleValues.Thin
            bottomBorder.Color = New Color()
            bottomBorder.Color.Rgb = HexBinaryValue.FromString("00000000")
            stylesheet.Borders.Append(New Border(bottomBorder))

            'same goes for fonts
            Dim font As New Font
            font.FontSize = New FontSize()
            font.FontSize.Val = 14
            font.FontName = New FontName
            font.FontName.Val = "Times New Roman"
            font.Color = New Color
            font.Color.Rgb = HexBinaryValue.FromString("00000000")
            stylesheet.Fonts.Append(font)

            ' Step 2 CellFormat is how you cross reference a fill/border to a cell
            stylesheet.Save()
            Dim fillId As UInteger = 1 '(stylesheet.Fills.Count.Value - 1)
            Dim borderId As UInteger = 1 'stylesheet.Borders.Count.Value - 1
            Dim fontId As UInteger = 1 'stylesheet.Fonts.Count.Value - 1

            Dim cellFormat As New CellFormat()
            cellFormat.BorderId = borderId
            cellFormat.FillId = fillId
            cellFormat.FontId = fontId
            cellFormat.ApplyFill = True
            stylesheet.CellFormats.AppendChild(cellFormat)

            ' store this id, so you don't have to look it up later
            headerStyleIndexId = 1 '(stylesheet.CellFormats.Count.Value - 1)

            'for more options, read pages 73-79 of "Open XML - the markup explained"
        End Sub

#End Region

    End Class
End Namespace

