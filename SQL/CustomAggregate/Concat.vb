'=====================================================================
'
'  File:    Concat.vb for User Defined Aggregate SQLCLR Example
'  Summary: Defines an aggregate for Concatenatenating string values into
'           a comma delimited string.
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

<Serializable(), Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Microsoft.SqlServer.Server.Format.UserDefined, IsInvariantToNulls:=True, IsInvariantToDuplicates:=False, IsInvariantToOrder:=False, MaxByteSize:=8000)> _
Public Class Concatenate
    'use clr serialization to serialize the intermediate result
    'optimizer property
    'optimizer property
    'optimizer property
    'maximum size in bytes of persisted value
    Implements Microsoft.SqlServer.Server.IBinarySerialize

    ''' <summary>
    ''' The variable that holds the intermediate result of the concatenation
    ''' </summary>
    Private intermediateResult As StringBuilder

    ''' <summary>
    ''' Initialize the internal data structures
    ''' </summary>
    Public Sub Init()
        intermediateResult = New StringBuilder()
    End Sub

    ''' <summary>
    ''' Accumulate the next value, nop if the value is null
    ''' </summary>
    ''' <param name="value"></param>
    Public Sub Accumulate(ByVal value As SqlString)
        If value.IsNull Then
            Return
        End If

        intermediateResult.Append(value.Value).Append(","c)
    End Sub

    ''' <summary>
    ''' Merge the partially computed aggregate with this aggregate.
    ''' </summary>
    ''' <param name="other"></param>
    Public Sub Merge(ByVal other As Concatenate)
        intermediateResult.Append(other.intermediateResult)
    End Sub

    ''' <summary>
    ''' Called at the end of aggregation, to return the results of the aggregation
    ''' </summary>
    ''' <returns></returns>
    Public Function Terminate() As SqlString
        Dim output As String = String.Empty

        'delete the trailing comma, if any
        If Not (intermediateResult Is Nothing) AndAlso intermediateResult.Length > 0 Then
            output = intermediateResult.ToString(0, intermediateResult.Length - 1)
        End If

        Return New SqlString(output)
    End Function

    Public Sub Read(ByVal r As BinaryReader) Implements Microsoft.SqlServer.Server.IBinarySerialize.Read
        If r Is Nothing Then
            Throw New ArgumentNullException("r")
        End If
        intermediateResult = New StringBuilder(r.ReadString())
    End Sub

    Public Sub Write(ByVal w As BinaryWriter) Implements Microsoft.SqlServer.Server.IBinarySerialize.Write
        If w Is Nothing Then
            Throw New ArgumentNullException("w")
        End If
        w.Write(intermediateResult.ToString())
    End Sub
End Class
