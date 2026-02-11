Module modMain

    'Prior to login, a connection test is done to determine if the user is 
    'connected to the internet

    'shared variables
    Private WithEvents objFrmlogin As frmLogin
    Private mstrDSN As String
    Friend mobjFrmMain As frmMain

    Friend Sub Main()

        'show the splash screen first
        objFrmlogin = New frmLogin
        objFrmlogin.ShowDialog()

        'if they have successfully logged in, show the main screen
        mobjFrmMain = New frmMain(mstrDSN)
        mobjFrmMain.ShowDialog()

    End Sub

    Private Sub objFrmlogin_SuccessfulLogin(ByVal DSN As String) Handles objFrmlogin.SuccessfulLogin
        mstrDSN = DSN
    End Sub
End Module
