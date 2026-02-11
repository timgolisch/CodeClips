Public Class Form1

    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub UsingOpenXml_Click(sender As System.Object, e As System.EventArgs) Handles Button1.Click
        Dim ds As DataSet = GetDummyData()
        Dim fileName As String

        fileName = "c:\Temp\DemoVB.xlsx"

        Dim ExcelGenerator As New ExportToExcel.ExcelFileGenerator
        ExcelGenerator.Headers.Add("<div align=""center""><font size=""14pt""><strong>Unable To Test Decision Count Report</strong></font></div>")
        ExcelGenerator.Headers.Add("<span><strong>Test Period:</strong> Spring 2013 ELPA</span>")

        ExcelGenerator.CreateExcelFile(ds, fileName)

        TextBox1.Text = fileName

    End Sub

    Private Sub UsingSerialization_Click(sender As System.Object, e As System.EventArgs) Handles Button2.Click
        Dim ds As DataSet = GetDummyData()

        Dim xlsx As String
        xlsx = DStoXLSX.XSLX.GetXSLX(ds)

        TextBox1.Text = xlsx
    End Sub

    Private Sub UsingExcelXml_Click(sender As System.Object, e As System.EventArgs) Handles Button3.Click
        Dim ds As DataSet = GetDummyData()
        Dim fileName As String

        fileName = "c:\Temp\DemoVB.xml"

        Dim ExcelXmlGenerator As New ExportToExcel.ExcelXmlFileGenerator
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("Unable To Test Decision Count Report", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Title))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>Test Period:</B> Spring 2013 ELPA", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>ISD:</B> Wayne RESA (82000)", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>District:</B> Detroit City School District (82010)", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>School:</B> All Schools", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))

        ExcelXmlGenerator.ColumnWidths.Add("462")
        ExcelXmlGenerator.ColumnWidths.Add("102")
        ExcelXmlGenerator.ColumnWidths.Add("162")

        ExcelXmlGenerator.CreateExcelXmlFile(ds, fileName)

        TextBox1.Text = fileName

    End Sub

    Private Function GetDummyData() As DataSet
        Dim ds As New DataSet
        Dim dr As DataRow
        Dim status() As String = {"Accepted", "Rejected", "Rejected", "Accepted"}

        ds.Tables.Add(New DataTable("Example1"))
        With ds.Tables(0)
            .Columns.Add("Test Period") ', Type.GetType("System.Int32"))
            .Columns.Add("Status")
            .Columns.Add("Decision Count", Type.GetType("System.Int32"))
            For x As Integer = 1 To 4
                dr = .NewRow
                dr("Test Period") = "Spring 2013 ELPA"
                dr("Status") = status(x Mod 4)
                dr("Decision Count") = 120 + (x * 4)
                .Rows.Add(dr)
            Next
        End With

        Return ds
    End Function
End Class
