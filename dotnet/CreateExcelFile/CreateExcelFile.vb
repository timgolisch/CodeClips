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

Namespace ExportToExcel

    '----------------------------------------------------------------
    '  Credit: This code was adapted from another project
    '  http://www.codeproject.com/Articles/692092/A-free-Export-to-Excel-Csharp-class-using-OpenXML
    '  http://www.mikesknowledgebase.com
    '
    '----------------------------------------------------------------

    Public Class CreateExcelFile(Of T) 'Of T, declares T a generic type
        Public Overloads Shared Function CreateExcelDocument(ByVal list As List(Of T), ByVal xlsxFilePath As String) As Boolean
            Dim ds As DataSet = New DataSet
            ds.Tables.Add(ListToDataTable(list))
            Return CreateExcelFile.CreateExcelDocument(ds, xlsxFilePath)
        End Function

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

    Public Class CreateExcelFile
#Region "HELPER FUNCTIONS"

        Public Overloads Shared Function CreateExcelDocument(ByVal dt As DataTable, ByVal xlsxFilePath As String) As Boolean
            Dim ds As DataSet = New DataSet
            ds.Tables.Add(dt)
            Dim result As Boolean = CreateExcelDocument(ds, xlsxFilePath)
            ds.Tables.Remove(dt)
            Return result
        End Function
#End Region


#If INCLUDE_WEB_FUNCTIONS Then
        ''' <summary>
        ''' Create an Excel file, and write it out to a MemoryStream (rather than directly to a file)
        ''' </summary>
        ''' <param name="dt">DataTable containing the data to be written to the Excel.</param>
        ''' <param name="filename">The filename (without a path) to call the new Excel file.</param>
        ''' <param name="Response">HttpResponse of the current page.</param>
        ''' <returns>True if it was created succesfully, otherwise false.</returns>
        Public Overloads Shared Function CreateExcelDocument(ByVal dt As DataTable, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
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

        Public Overloads Shared Function CreateExcelDocument(ByVal list As List(Of T), ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
            Try
                Dim ds As DataSet = New DataSet
                ds.Tables.Add(ListToDataTable(list))
                CreateExcelDocumentAsStream(ds, filename, Response)
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
        Public Shared Function CreateExcelDocumentAsStream(ByVal ds As DataSet, ByVal filename As String, ByVal Response As System.Web.HttpResponse) As Boolean
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

        ''' <summary>
        ''' Create an Excel file, and write it to a file.
        ''' </summary>
        ''' <param name="ds">DataSet containing the data to be written to the Excel.</param>
        ''' <param name="excelFilename">Name of file to be written.</param>
        ''' <returns>True if successful, false if something went wrong.</returns>
        Public Overloads Shared Function CreateExcelDocument(ByVal ds As DataSet, ByVal excelFilename As String) As Boolean
            Try
                Using document As SpreadsheetDocument = SpreadsheetDocument.Create(excelFilename, SpreadsheetDocumentType.Workbook)
                    WriteExcelFile(ds, document)
                End Using
                Trace.WriteLine(("Successfully created: " + excelFilename))
                Return True
            Catch ex As Exception
                Trace.WriteLine(("Failed, exception thrown: " + ex.Message))
                Return False
            End Try
        End Function

        Private Shared Sub WriteExcelFile(ByVal ds As DataSet, ByVal spreadsheet As SpreadsheetDocument)
            Dim Sheets As DocumentFormat.OpenXml.Spreadsheet.Sheets = Nothing

            '  Create the Excel file contents.  This function is used when creating an Excel file either writing 
            '  to a file, or writing to a MemoryStream.
            spreadsheet.AddWorkbookPart()
            spreadsheet.WorkbookPart.Workbook = New DocumentFormat.OpenXml.Spreadsheet.Workbook

            '  My thanks to James Miera for the following line of code (which prevents crashes in Excel 2010)
            spreadsheet.WorkbookPart.Workbook.Append(New BookViews(New WorkbookView))

            '  If we don't add a "WorkbookStylesPart", OLEDB will refuse to connect to this .xlsx file !
            Dim workbookStylesPart As WorkbookStylesPart = spreadsheet.WorkbookPart.AddNewPart(Of WorkbookStylesPart)("rIdStyles")
            Dim stylesheet As Stylesheet = New Stylesheet
            workbookStylesPart.Stylesheet = stylesheet

            '  Loop through each of the DataTables in our DataSet, and create a new Excel Worksheet for each.
            Dim worksheetNumber As UInteger = 1
            For Each dt As DataTable In ds.Tables
                '  For each worksheet you want to create
                Dim workSheetID As String = ("rId" + worksheetNumber.ToString)
                Dim worksheetName As String = dt.TableName

                Dim newWorksheetPart As WorksheetPart = spreadsheet.WorkbookPart.AddNewPart(Of WorksheetPart)()
                newWorksheetPart.Worksheet = New DocumentFormat.OpenXml.Spreadsheet.Worksheet

                ' create sheet data
                newWorksheetPart.Worksheet.AppendChild(New DocumentFormat.OpenXml.Spreadsheet.SheetData)

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

        Private Shared Sub WriteDataTableToExcelWorksheet(ByVal dt As DataTable, ByVal worksheetPart As WorksheetPart)
            Dim worksheet = worksheetPart.Worksheet
            Dim sheetData As SheetData = worksheet.GetFirstChild(Of SheetData)()

            Dim cellValue As String = ""
            '  Create a Header Row in our Excel file, containing one header for each Column of data in our DataTable.
            '
            '  We'll also create an array, showing which type each column of data is (Text or Numeric), so when we come to write the actual
            '  cells of data, we'll know if to write Text values or Numeric cell values.
            Dim numberOfColumns As Integer = dt.Columns.Count
            Dim IsNumericColumn() As Boolean = New Boolean((numberOfColumns) - 1) {}

            Dim excelColumnNames() As String = New String((numberOfColumns) - 1) {}
            For n As Integer = 0 To numberOfColumns - 1
                excelColumnNames(n) = GetExcelColumnName(n)
            Next

            '
            '  Create the Header row in our Excel Worksheet
            '
            Dim rowIndex As Integer = 1

            Dim headerRow = New Row() With {.RowIndex = rowIndex} ' add a row at the top of spreadsheet
            sheetData.Append(headerRow)

            For colInx As Integer = 0 To numberOfColumns - 1
                Dim col As DataColumn = dt.Columns(colInx)
                AppendTextCell((excelColumnNames(colInx) + "1"), col.ColumnName, headerRow)
                IsNumericColumn(colInx) = ((col.DataType.FullName = "System.Decimal") _
                            OrElse (col.DataType.FullName = "System.Int32"))
            Next

            '
            '  Now, step through each row of data in our DataTable...
            '
            Dim cellNumericValue As Double = 0
            For Each dr As DataRow In dt.Rows
                ' ...create a new row, and append a set of this row's data to it.
                rowIndex = (rowIndex + 1)
                Dim newExcelRow As New Row() With {.RowIndex = rowIndex} ' add a row at the top of spreadsheet
                sheetData.Append(newExcelRow)

                For colInx = 0 To numberOfColumns - 1
                    cellValue = dr.ItemArray(colInx).ToString

                    ' Create cell with data
                    If IsNumericColumn(colInx) Then
                        '  For numeric cells, make sure our input data IS a number, then write it out to the Excel file.
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
        End Sub

        Private Shared Sub AppendTextCell(ByVal cellReference As String, ByVal cellStringValue As String, ByVal excelRow As Row)
            '  Add a new Excel Cell to our Row 
            Dim cell As New Cell With {.CellReference = cellReference, .DataType = CellValues.String}
            Dim cellValue As New CellValue
            cellValue.Text = cellStringValue
            cell.Append(cellValue)
            excelRow.Append(cell)
        End Sub

        Private Shared Sub AppendNumericCell(ByVal cellReference As String, ByVal cellStringValue As String, ByVal excelRow As Row)
            '  Add a new Excel Cell to our Row 
            Dim cell As New Cell With {.CellReference = cellReference}
            Dim cellValue As CellValue = New CellValue
            cellValue.Text = cellStringValue
            cell.Append(cellValue)
            excelRow.Append(cell)
        End Sub

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
    End Class
End Namespace

