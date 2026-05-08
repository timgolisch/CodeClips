Imports System.Configuration.ConfigurationSettings

Public Class frmLogin
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents lblLogin As System.Windows.Forms.Label
    Friend WithEvents txtLogin As System.Windows.Forms.TextBox
    Friend WithEvents txtPassword As System.Windows.Forms.TextBox
    Friend WithEvents lblPassword As System.Windows.Forms.Label
    Friend WithEvents btnOk As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents chkIntegratedSecurity As System.Windows.Forms.CheckBox
    Friend WithEvents lblServer As System.Windows.Forms.Label
    Friend WithEvents txtServer As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmLogin))
        Me.lblLogin = New System.Windows.Forms.Label
        Me.txtLogin = New System.Windows.Forms.TextBox
        Me.txtPassword = New System.Windows.Forms.TextBox
        Me.lblPassword = New System.Windows.Forms.Label
        Me.btnOk = New System.Windows.Forms.Button
        Me.btnCancel = New System.Windows.Forms.Button
        Me.chkIntegratedSecurity = New System.Windows.Forms.CheckBox
        Me.lblServer = New System.Windows.Forms.Label
        Me.txtServer = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'lblLogin
        '
        Me.lblLogin.Location = New System.Drawing.Point(24, 16)
        Me.lblLogin.Name = "lblLogin"
        Me.lblLogin.Size = New System.Drawing.Size(72, 23)
        Me.lblLogin.TabIndex = 0
        Me.lblLogin.Text = "Login:"
        Me.lblLogin.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'txtLogin
        '
        Me.txtLogin.Location = New System.Drawing.Point(104, 16)
        Me.txtLogin.MaxLength = 50
        Me.txtLogin.Name = "txtLogin"
        Me.txtLogin.Size = New System.Drawing.Size(128, 20)
        Me.txtLogin.TabIndex = 1
        Me.txtLogin.Text = ""
        '
        'txtPassword
        '
        Me.txtPassword.Location = New System.Drawing.Point(104, 40)
        Me.txtPassword.MaxLength = 50
        Me.txtPassword.Name = "txtPassword"
        Me.txtPassword.PasswordChar = Microsoft.VisualBasic.ChrW(42)
        Me.txtPassword.Size = New System.Drawing.Size(128, 20)
        Me.txtPassword.TabIndex = 2
        Me.txtPassword.Text = ""
        '
        'lblPassword
        '
        Me.lblPassword.Location = New System.Drawing.Point(24, 40)
        Me.lblPassword.Name = "lblPassword"
        Me.lblPassword.Size = New System.Drawing.Size(72, 23)
        Me.lblPassword.TabIndex = 4
        Me.lblPassword.Text = "Password:"
        Me.lblPassword.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'btnOk
        '
        Me.btnOk.Location = New System.Drawing.Point(64, 112)
        Me.btnOk.Name = "btnOk"
        Me.btnOk.TabIndex = 4
        Me.btnOk.Text = "OK"
        '
        'btnCancel
        '
        Me.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnCancel.Location = New System.Drawing.Point(152, 112)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.TabIndex = 5
        Me.btnCancel.Text = "Cancel"
        '
        'chkIntegratedSecurity
        '
        Me.chkIntegratedSecurity.Location = New System.Drawing.Point(56, 64)
        Me.chkIntegratedSecurity.Name = "chkIntegratedSecurity"
        Me.chkIntegratedSecurity.Size = New System.Drawing.Size(192, 16)
        Me.chkIntegratedSecurity.TabIndex = 3
        Me.chkIntegratedSecurity.Text = "Use Integrated Network Security"
        '
        'lblServer
        '
        Me.lblServer.Location = New System.Drawing.Point(16, 80)
        Me.lblServer.Name = "lblServer"
        Me.lblServer.Size = New System.Drawing.Size(80, 23)
        Me.lblServer.TabIndex = 6
        Me.lblServer.Text = "Server:"
        Me.lblServer.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'txtServer
        '
        Me.txtServer.Location = New System.Drawing.Point(104, 80)
        Me.txtServer.MaxLength = 50
        Me.txtServer.Name = "txtServer"
        Me.txtServer.Size = New System.Drawing.Size(128, 20)
        Me.txtServer.TabIndex = 7
        Me.txtServer.Text = "(local)"
        '
        'frmLogin
        '
        Me.AcceptButton = Me.btnOk
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.CancelButton = Me.btnCancel
        Me.ClientSize = New System.Drawing.Size(292, 144)
        Me.ControlBox = False
        Me.Controls.Add(Me.txtServer)
        Me.Controls.Add(Me.lblServer)
        Me.Controls.Add(Me.chkIntegratedSecurity)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnOk)
        Me.Controls.Add(Me.lblPassword)
        Me.Controls.Add(Me.txtPassword)
        Me.Controls.Add(Me.txtLogin)
        Me.Controls.Add(Me.lblLogin)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmLogin"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Login"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Const _cAPPNAME As String = "SQLWhoAmI"

    Public Event SuccessfulLogin(ByVal DSN As String)

#Region " Settings - Properties "
    Private ReadOnly Property DSN() As String
        Get
            Dim strDSN As String
            If chkIntegratedSecurity.Checked Then
                strDSN = "Integrated Security=SSPI;Persist Security Info=False" & _
                    ";Data Source=" & txtServer.Text
            Else 'use the login/pw they provided
                strDSN = "Persist Security Info=False" & _
                    ";User ID=" & txtLogin.Text & _
                    ";Password=" & txtPassword.Text & _
                    ";Data Source=" & txtServer.Text
            End If
            Return strDSN
        End Get
    End Property
#End Region

    Private Sub frmLogin_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If GetSetting(_cAPPNAME, Me.Name, "IntegratedSecurity", "false") = "true" Then
            chkIntegratedSecurity.Checked = True
        End If
    End Sub

    Private Sub frmLogin_Closing(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles MyBase.Closing
        If chkIntegratedSecurity.Checked Then
            SaveSetting(_cAPPNAME, Me.Name, "IntegratedSecurity", "true")
        Else
            SaveSetting(_cAPPNAME, Me.Name, "IntegratedSecurity", "false")
        End If
    End Sub

    Private Sub chkIntegratedSecurity_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkIntegratedSecurity.CheckedChanged
        If chkIntegratedSecurity.Checked Then
            txtLogin.Enabled = False
            txtPassword.Enabled = False
        Else
            txtLogin.Enabled = True
            txtPassword.Enabled = True
        End If
    End Sub

    Private Sub btnOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOk.Click
        Dim cn As SqlClient.SqlConnection

        Try
            cn = New SqlClient.SqlConnection(Me.DSN)
            cn.Open()
            cn.Close()
            cn.Dispose()
            cn = Nothing

            RaiseEvent SuccessfulLogin(Me.DSN)

            Me.Close()
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        End
    End Sub
End Class
