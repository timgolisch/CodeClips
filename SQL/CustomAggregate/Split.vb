'=====================================================================
'
'  File:    Split.vb for Streaming TVF SQLCLR Example
'  Summary: Defines a streaming table valued function to split a string into a one-column table
'  Date:    April 06, 2005
'
'---------------------------------------------------------------------
'  This file is part of the Microsoft SQL Server Code Samples.
'  Copyright (C) Microsoft Corporation.  All rights reserved.
'
'  This source code is intended only as a supplement to Microsoft
'  Development Tools and/or on-line documentation.  See these other
'  materials for detailed information regarding Microsoft code samples.
'
'  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
'  KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
'  IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
'  PARTICULAR PURPOSE.
'======================================================= 

Public NotInheritable Class StringSplitter

    ''' <summary>
    ''' The streaming table-valued function used to split the string into a relation
    ''' </summary>
    ''' <param name="argument"></param>
    ''' <returns></returns>
    <SqlFunction(Name:="Split", DataAccess:=DataAccessKind.None, FillRowMethodName:="FillSplitRow", _
        TableDefinition:="StringElement nvarchar(128) COLLATE Latin1_General_CI_AS")> _
    Public Shared Function Split(ByVal argument As SqlString) As IEnumerable
        Dim value As String

        If argument.IsNull Then
            value = String.Empty
        Else
            value = argument.Value
        End If

        Return value.Split(","c)
    End Function

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1045:DoNotPassTypesByReference")> _
    Private Shared Sub FillSplitRow(ByVal row As Object, ByRef stringElement As String)
        stringElement = CType(row, String)
    End Sub

    ''' <summary>
    ''' Don't allow callers to create instances of this class
    ''' </summary>
    Private Sub New()
    End Sub
End Class