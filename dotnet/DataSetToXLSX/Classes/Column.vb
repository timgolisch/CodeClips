Imports System.Xml.Serialization

Namespace DStoXLSX
    <XmlType("col")> _
    Public Class ColumnDefinition
        Public Const cDEFAULTWIDTH As String = "12"
        Public Const cDEFAULTSTYLE As String = "1"
#Region "Public Properties"
        <XmlAttribute()> _
        Public min As String
        <XmlAttribute()> _
        Public max As String
        <XmlAttribute()> _
        Public width As String
        <XmlAttribute()> _
        Public style As String
        <XmlAttribute()> _
        Public customWidth As String
#End Region

#Region "Constructors"
        Public Sub New()

        End Sub
        Public Sub New(ord As Integer)
            Me.min = ord.ToString
            Me.max = ord.ToString
            Me.width = cDEFAULTWIDTH
            Me.style = cDEFAULTSTYLE
        End Sub
        Public Sub New(col As DataColumn, ord As Integer)
            Try
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
        End Sub
#End Region

#Region "Factory Methods"
        Public Shared Function GetColumns(dt As DataTable) As ColumnDefinition()
            Dim re() As ColumnDefinition
            Try
                ReDim re(dt.Columns.Count - 1)
                For x As Integer = 0 To dt.Columns.Count - 1
                    re(x) = New ColumnDefinition(x + 1)
                Next
            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
            Return re
        End Function
#End Region

    End Class
End Namespace
