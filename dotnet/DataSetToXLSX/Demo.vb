Public Class Demo

    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        txtOutputPath.Text = "c:\temp\"
        txtFilename.Text = "DemoVB"

    End Sub

    Private Sub UsingOpenXml_Click(sender As System.Object, e As System.EventArgs) Handles Button1.Click
        Dim ds As DataSet = GetDummyData()
        Dim fileName As String

        txtRaw.Text = "processing ..."
        Application.DoEvents()
        System.Threading.Thread.Sleep(1000) 'allow the user one second to read the processing message

        fileName = System.IO.Path.Combine(txtOutputPath.Text, txtFilename.Text + ".xlsx")

        Dim ExcelGenerator As New ExportToExcel.ExcelFileGenerator

        ExcelGenerator.CreateExcelFile(ds, fileName)
        txtRaw.Text = "File generated to " + fileName + vbCrLf + "can be opened with excel"

    End Sub

    Private Sub UsingSerialization_Click(sender As System.Object, e As System.EventArgs) Handles Button2.Click
        Dim ds As DataSet = GetDummyData()

        txtRaw.Text = "processing ..."
        Application.DoEvents()
        System.Threading.Thread.Sleep(1000) 'allow the user one second to read the processing message

        Dim xlsx As String
        xlsx = DStoXLSX.XSLX.GetXSLX(ds)

        txtRaw.Text = xlsx
    End Sub

    Private Sub UsingExcelXml_Click(sender As System.Object, e As System.EventArgs) Handles Button3.Click
        Dim ds As DataSet = GetDummyData()
        Dim fileName As String

        txtRaw.Text = "processing ..."
        Application.DoEvents()
        System.Threading.Thread.Sleep(1000) 'allow the user one second to read the processing message

        fileName = System.IO.Path.Combine(txtOutputPath.Text, txtFilename.Text + ".xml")

        Dim ExcelXmlGenerator As New ExportToExcel.ExcelXmlFileGenerator
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("District Count Report", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Title))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>Test Period:</B> Spring 2013", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))
        ExcelXmlGenerator.Headers.Add(New ExportToExcel.ExcelXmlFileGenerator.Header("<B>District:</B> Detroit MI", ExportToExcel.ExcelXmlFileGenerator.HeaderType.Filters))

        ExcelXmlGenerator.ColumnWidths.Add("462")
        ExcelXmlGenerator.ColumnWidths.Add("102")
        ExcelXmlGenerator.ColumnWidths.Add("162")

        ExcelXmlGenerator.CreateExcelXmlFile(ds, fileName)

        txtRaw.Text = "File generated to " + fileName + vbCrLf + "can be opened with excel"

    End Sub

    Private Function GetDummyData() As DataSet
        Dim ds As New DataSet
        Dim dr As DataRow
        Dim status() As String = {"Accepted", "Rejected", "Rejected", "Accepted"}

        ds.Tables.Add(New DataTable("Data By Period"))
        With ds.Tables(0)
            .Columns.Add("Test Period") ', Type.GetType("System.Int32"))
            .Columns.Add("Status")
            .Columns.Add("Decision Count", Type.GetType("System.Int32"))
            For x As Integer = 1 To 4
                dr = .NewRow
                dr("Test Period") = "Spring 2013"
                dr("Status") = status(x Mod 4)
                dr("Decision Count") = 120 + (x * 4)
                .Rows.Add(dr)
            Next
        End With

        ds.Tables.Add(New DataTable("Data By Region"))
        With ds.Tables(1)
            .Columns.Add("Geographic Region") ', Type.GetType("System.Int32"))
            .Columns.Add("Sample period")
            .Columns.Add("Participant Count", Type.GetType("System.Int32"))
            For x As Integer = 1 To 14
                For y As Integer = 1 To 4
                    dr = .NewRow
                    dr("Geographic Region") = $"Region {x}"
                    dr("Sample Period") = y
                    dr("Participant Count") = CInt(Int(120 * Rnd()) * y)
                    .Rows.Add(dr)
                Next
            Next
        End With

        Return ds
    End Function
End Class
