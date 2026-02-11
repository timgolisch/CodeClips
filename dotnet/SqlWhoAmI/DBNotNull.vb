Public Class DBNotNull
    '===========================================================
    '              DB Return value (not null) handlers
    '===========================================================
    Public Shared Function DBNotNullStr(ByVal vntIn As Object, Optional ByVal strDefault As String = "") As String
        If IsDBNull(vntIn) Then
            DBNotNullStr = strDefault
        ElseIf IsDate(vntIn) Then
            DBNotNullStr = Format(vntIn, "M/d/yyyy")
        Else
            DBNotNullStr = vntIn
        End If
    End Function

    Public Shared Function DBNotNullBool(ByVal vntIn As Object, Optional ByVal bolDefault As Boolean = False) As Boolean
        If IsDBNull(vntIn) Then
            DBNotNullBool = bolDefault
        Else
            DBNotNullBool = vntIn
        End If
    End Function

    Public Shared Function DBNotNullInt(ByVal vntIn As Object, Optional ByVal lngDefault As Integer = 0) As Integer
        If IsDBNull(vntIn) Then
            DBNotNullInt = lngDefault
        Else
            DBNotNullInt = vntIn
        End If
    End Function

    Public Shared Function DBNotNullLng(ByVal vntIn As Object, Optional ByVal lngDefault As Long = 0) As Long
        If IsDBNull(vntIn) Then
            DBNotNullLng = lngDefault
        Else
            DBNotNullLng = vntIn
        End If
    End Function

    Public Shared Function DBNotNullSingle(ByVal vntIn As Object, Optional ByVal sngDefault As Single = 0) As Single
        If IsDBNull(vntIn) Then
            DBNotNullSingle = sngDefault
        Else
            Try
                DBNotNullSingle = Convert.ToSingle(vntIn)
            Catch
                DBNotNullSingle = sngDefault
            End Try
        End If
    End Function

    Public Shared Function DBNotNullDouble(ByVal vntIn As Object, Optional ByVal dblDefault As Double = 0) As Double
        If IsDBNull(vntIn) Then
            DBNotNullDouble = dblDefault
        Else
            Try
                DBNotNullDouble = Convert.ToDouble(vntIn)
            Catch
                DBNotNullDouble = dblDefault
            End Try
        End If
    End Function

    Public Shared Function DBNotNullDec(ByVal vntIn As Object, Optional ByVal decDefault As Decimal = 0) As Decimal
        If IsDBNull(vntIn) Then
            DBNotNullDec = decDefault
        Else
            Try
                DBNotNullDec = Convert.ToDecimal(vntIn)
            Catch
                DBNotNullDec = decDefault
            End Try
        End If
    End Function

    Public Shared Function DBNotNullDate(ByVal vntIn As Object, ByVal datDefault As Date) As Date
        If IsDBNull(vntIn) Then
            DBNotNullDate = datDefault
        Else
            Try
                DBNotNullDate = Convert.ToDateTime(vntIn)
            Catch
                DBNotNullDate = datDefault
            End Try
        End If
    End Function
    Public Shared Function DBNotNullDate(ByVal vntIn As Object, Optional ByVal strFormat As String = "d", Optional ByVal strDefault As String = "") As String
        If IsDBNull(vntIn) Then
            DBNotNullDate = strDefault
        Else
            Try
                DBNotNullDate = Convert.ToDateTime(vntIn).ToString(strFormat)
            Catch
                DBNotNullDate = strDefault
            End Try
        End If
    End Function
    Public Shared Function DBNotNullDateTime(ByVal vntIn As Object, ByVal datDefault As Date) As DateTime
        If IsDBNull(vntIn) Then
            Return datDefault
        Else
            Try
                Return Convert.ToDateTime(vntIn)
            Catch
                Return datDefault
            End Try
        End If
    End Function
End Class
