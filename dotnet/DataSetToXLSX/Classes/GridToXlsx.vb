Namespace ExportToExcel
    Public Class GridToXlsx

        Public Sub Example(Response As System.Net.HttpWebResponse)
            Dim gvExcelExport As New DataGridView

            ' set the column numbers to render HTML data instead of text        
            gvExcelExport.Attributes("columnNumbers") = columnNumbers

            ' Row bound event set for allowing HTML data to be rendered in export instead of text display        
            gvExcelExport.RowDataBound += New GridViewRowEventHandler(gvExcelExport_RowDataBound)
            gvExcelExport.HeaderStyle.BackColor = ColorTranslator.FromHtml("#210B61")
            gvExcelExport.HeaderStyle.Font.Bold = True
            gvExcelExport.HeaderStyle.ForeColor = Color.White

            ' Bind the gridview data     
            gvExcelExport.DataSource = dsExportData

            gvExcelExport.DataBind()

            '------------------------
            Dim sw As New StringWriter()
            Dim htw As New HtmlTextWriter(sw)
            gvExcelExport.RenderControl(htw)
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName)
            Response.Charset = ""
            Response.ContentType = "application/vnd.ms-excel"

            ' write the data      
            Response.Write(sw.ToString())
            Response.Flush()
            Response.Clear()


        End Sub
    End Class
End Namespace
