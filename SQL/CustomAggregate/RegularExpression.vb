'=====================================================================
'
'  File:    RegularExpression.vb for String Utilities Example
'  Summary: Provides regular expression matching and replacing 
'           functionality for Transact-SQL callers.
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

''' <summary>
''' This class is provides regular expression operations for Transact-SQL callers
''' </summary>

Public NotInheritable Class RegularExpression

    Private Sub New()
    End Sub

    ''' <summary>
    ''' This method returns a table of matches, groups, and captures based on the input
    ''' string and pattern string provided.
    ''' </summary>
    ''' <param name="sqlInput">What to match against</param>
    ''' <param name="sqlPattern">What to look for</param>
    ''' <returns>An object which appears to be reading from SQL Server but which in fact is reading
    '''          from a memory based representation of the data.</returns>
    <SqlFunction(Name:="RegexMatches", FillRowMethodName:="FillMatchRow", _
        TableDefinition:="MatchID int, MatchIndex int, MatchValue nvarchar(4000), GroupID int, GroupIndex int, GroupValue nvarchar(4000), CaptureIndex int, CaptureValue nvarchar(4000)")> _
    Public Shared Function Matches(ByVal sqlInput As SqlString, ByVal sqlPattern As SqlString) As IEnumerable
        Dim input As String = String.Empty
        If Not sqlInput.IsNull Then
            input = sqlInput.Value
        End If

        Dim pattern As String = String.Empty
        If Not sqlPattern.IsNull Then
            pattern = sqlPattern.Value
        End If

        Return GetMatches(input, pattern)
    End Function

    ''' <summary>
    ''' Invoked by SQL Server when returning a row of the TVF.  Splits the MatchResult object into
    ''' the separate pieces of data which will form the columns of the row.
    ''' </summary>
    ''' <param name="row"></param>
    ''' <param name="matchID"></param>
    ''' <param name="matchIndex"></param>
    ''' <param name="matchValue"></param>
    ''' <param name="groupID"></param>
    ''' <param name="groupIndex"></param>
    ''' <param name="groupValue"></param>
    ''' <param name="captureIndex"></param>
    ''' <param name="captureValue"></param>
    ''' <remarks></remarks>
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1045:DoNotPassTypesByReference")> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1045:DoNotPassTypesByReference")> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1045:DoNotPassTypesByReference")> _
    Private Shared Sub FillMatchRow(ByVal row As Object, <Out()> ByRef matchId As Integer, _
        <Out()> ByRef matchIndex As Integer, <Out()> ByRef matchValue As String, <Out()> ByRef groupId As Integer, _
        <Out()> ByRef groupIndex As Integer, <Out()> ByRef groupValue As String, <Out()> ByRef captureIndex As Integer, _
        <Out()> ByRef captureValue As String)

        Dim result As MatchResult

        result = CType(row, MatchResult)

        matchId = result.MatchID
        matchIndex = result.MatchIndex
        matchValue = result.MatchValue
        groupId = result.GroupID
        groupIndex = result.GroupIndex
        groupValue = result.GroupValue
        captureIndex = result.CaptureIndex
        captureValue = result.CaptureValue
    End Sub

    ''' <summary>
    '''     Generates a list of Match/Group/Capture tuples represented using the
    '''     MatchResult struct based on the regular expression match of the input
    '''     string and pattern string provided.
    ''' </summary>
    ''' <param name="input">What to match</param>
    ''' <param name="pattern">What to look for</param>
    ''' <returns>A list of Match/Group/Capture tuples</returns>
    Private Shared Function GetMatches(ByVal input As String, ByVal pattern As String) As List(Of MatchResult)
        Dim result As List(Of MatchResult) = New List(Of MatchResult)()
        Dim matchID As Integer = 0
        Dim groupID As Integer = 0

        For Each m As Match In Regex.Matches(input, pattern)
            If m.Groups.Count < 1 Then
                result.Add(New MatchResult(matchID, m.Index, m.Value, -1, -1, _
                    String.Empty, -1, String.Empty))
            Else
                groupID = 0
                For Each g As Group In m.Groups
                    If g.Captures.Count < 1 Then
                        result.Add(New MatchResult(matchID, m.Index, m.Value, _
                            groupID, g.Index, g.Value, -1, String.Empty))
                    Else
                        For Each c As Capture In m.Groups
                            result.Add(New MatchResult(matchID, m.Index, _
                                m.Value, groupID, g.Index, g.Value, c.Index, _
                                c.Value))
                        Next
                    End If

                    groupID += 1
                Next
            End If

            matchID += 1
        Next

        Return result
    End Function

    ''' <summary>
    '''     This method performs a pattern based substitution based on the provided input string, pattern
    '''     string, and replacement string.
    ''' </summary>
    ''' <param name="sqlInput">The source material</param>
    ''' <param name="sqlPattern">How to parse the source material</param>
    ''' <param name="sqlReplacement">What the output should look like</param>
    ''' <returns></returns>
    <SqlFunction(Name:="RegexReplace", DataAccess:=DataAccessKind.None)> _
    Public Shared Function Replace(ByVal sqlInput As SqlString, ByVal sqlPattern As SqlString, ByVal sqlReplacement As SqlString) As String
        Dim input As String = String.Empty

        If Not sqlInput.IsNull Then
            input = sqlInput.Value
        End If

        Dim pattern As String = String.Empty

        If Not sqlPattern.IsNull Then
            pattern = sqlPattern.Value.ToString()
        End If

        Dim replacement As String = String.Empty

        If Not sqlReplacement.IsNull Then
            replacement = sqlReplacement.Value.ToString()
        End If

        Return Regex.Replace(input, pattern, replacement)
    End Function
End Class


''' <summary>
''' This struct is used to represent a Match/Group/Capture tuple.  Instances of 
''' this struct are created by the GetMatches method.
''' </summary>
Friend Structure MatchResult
    ''' <summary>
    ''' Which match this is
    ''' </summary>
    Private _matchID As Integer

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property MatchID() As Integer
        Get
            Return Me._matchID
        End Get
    End Property

    ''' <summary>
    ''' Where the match starts in the input string
    ''' </summary>
    Private _matchIndex As Integer

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property MatchIndex() As Integer
        Get
            Return Me._matchIndex
        End Get
    End Property

    ''' <summary>
    ''' What string matched the pattern
    ''' </summary>
    Private _matchValue As String

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property MatchValue() As String
        Get
            Return Me._matchValue
        End Get
    End Property

    ''' <summary>
    ''' Which matching group this is
    ''' </summary>
    Private _groupID As Integer

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property GroupID() As Integer
        Get
            Return Me._groupID
        End Get
    End Property

    ''' <summary>
    ''' Where this group starts in the input string
    ''' </summary>
    Private _groupIndex As Integer

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property GroupIndex() As Integer
        Get
            Return Me._groupIndex
        End Get
    End Property

    ''' <summary>
    ''' What the group matched in the input string
    ''' </summary>
    Private _groupValue As String

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property GroupValue() As String
        Get
            Return Me._groupValue
        End Get
    End Property

    ''' <summary>
    ''' Where this capture starts in the input string
    ''' </summary>
    Private _captureIndex As Integer

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property CaptureIndex() As Integer
        Get
            Return Me._captureIndex
        End Get
    End Property

    ''' <summary>
    ''' What the capture matched in the input string
    ''' </summary>
    Private _captureValue As String

    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")> _
    Friend ReadOnly Property CaptureValue() As String
        Get
            Return Me._captureValue
        End Get
    End Property

    ''' <summary>
    '''     A convenient constructor which fills in all the fields contained in this struct.
    ''' </summary>
    ''' <param name="matchID">Which match this is</param>
    ''' <param name="matchIndex">Where the match starts in the input string</param>
    ''' <param name="matchValue">What string matched the pattern</param>
    ''' <param name="groupID">Which matching group this is</param>
    ''' <param name="groupIndex">Where this group starts in the input string</param>
    ''' <param name="groupValue">What the group matched in the input string</param>
    ''' <param name="captureIndex">Where this capture starts in the input string</param>
    ''' <param name="captureValue">What the capture matched in the input string</param>
    Friend Sub New(ByVal matchID As Integer, ByVal matchIndex As Integer, ByVal matchValue As String, ByVal groupID As Integer, ByVal groupIndex As Integer, ByVal groupValue As String, ByVal captureIndex As Integer, ByVal captureValue As String)
        Me._matchID = matchID
        Me._matchIndex = matchIndex
        Me._matchValue = matchValue
        Me._groupID = groupID
        Me._groupIndex = groupIndex
        Me._groupValue = groupValue
        Me._captureIndex = captureIndex
        Me._captureValue = captureValue
    End Sub
End Structure
