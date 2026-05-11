Imports Microsoft.VisualBasic.Logging

Public Class frmMain
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

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
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents btnDone As System.Windows.Forms.Button
    Friend WithEvents txtSUSER_NAME As System.Windows.Forms.TextBox
    Friend WithEvents txtSUSER_SNAME As System.Windows.Forms.TextBox
    Friend WithEvents txtUSER_NAME As System.Windows.Forms.TextBox
    Friend WithEvents txtUSER As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmMain))
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.txtSUSER_NAME = New System.Windows.Forms.TextBox
        Me.txtSUSER_SNAME = New System.Windows.Forms.TextBox
        Me.txtUSER_NAME = New System.Windows.Forms.TextBox
        Me.txtUSER = New System.Windows.Forms.TextBox
        Me.btnDone = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(16, 32)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "SUSER_NAME"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(16, 56)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "SUSER_SNAME"
        Me.Label2.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label3
        '
        Me.Label3.Location = New System.Drawing.Point(16, 80)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "USER_NAME"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label4
        '
        Me.Label4.Location = New System.Drawing.Point(16, 104)
        Me.Label4.Name = "Label4"
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "USER"
        Me.Label4.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'txtSUSER_NAME
        '
        Me.txtSUSER_NAME.Location = New System.Drawing.Point(128, 32)
        Me.txtSUSER_NAME.Name = "txtSUSER_NAME"
        Me.txtSUSER_NAME.ReadOnly = True
        Me.txtSUSER_NAME.Size = New System.Drawing.Size(200, 20)
        Me.txtSUSER_NAME.TabIndex = 5
        Me.txtSUSER_NAME.Text = ""
        '
        'txtSUSER_SNAME
        '
        Me.txtSUSER_SNAME.Location = New System.Drawing.Point(128, 56)
        Me.txtSUSER_SNAME.Name = "txtSUSER_SNAME"
        Me.txtSUSER_SNAME.ReadOnly = True
        Me.txtSUSER_SNAME.Size = New System.Drawing.Size(200, 20)
        Me.txtSUSER_SNAME.TabIndex = 6
        Me.txtSUSER_SNAME.Text = ""
        '
        'txtUSER_NAME
        '
        Me.txtUSER_NAME.Location = New System.Drawing.Point(128, 80)
        Me.txtUSER_NAME.Name = "txtUSER_NAME"
        Me.txtUSER_NAME.ReadOnly = True
        Me.txtUSER_NAME.Size = New System.Drawing.Size(200, 20)
        Me.txtUSER_NAME.TabIndex = 7
        Me.txtUSER_NAME.Text = ""
        '
        'txtUSER
        '
        Me.txtUSER.Location = New System.Drawing.Point(128, 104)
        Me.txtUSER.Name = "txtUSER"
        Me.txtUSER.ReadOnly = True
        Me.txtUSER.Size = New System.Drawing.Size(200, 20)
        Me.txtUSER.TabIndex = 8
        Me.txtUSER.Text = ""
        '
        'btnDone
        '
        Me.btnDone.Location = New System.Drawing.Point(136, 144)
        Me.btnDone.Name = "btnDone"
        Me.btnDone.TabIndex = 10
        Me.btnDone.Text = "Done"
        '
        'frmMain
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(360, 190)
        Me.Controls.Add(Me.btnDone)
        Me.Controls.Add(Me.txtUSER)
        Me.Controls.Add(Me.txtUSER_NAME)
        Me.Controls.Add(Me.txtSUSER_SNAME)
        Me.Controls.Add(Me.txtSUSER_NAME)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "frmMain"
        Me.Text = "SQL Who Am I"
        Me.ResumeLayout(False)

    End Sub

#End Region
    Private _strDSN As String

    Private Sub frmMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim cn As SqlClient.SqlConnection
        Dim cmd As SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim strSQL As String
        Dim sid() As Byte
        Dim byte2text As System.Text.Decoder

        Dim login As New frmLogin()
        Dim re As DialogResult = login.ShowDialog()

        If (re = DialogResult.OK) Then
            _strDSN = login.DSN

            Try
                strSQL = "SELECT SUSER_NAME() AS SUSERNAME, SUSER_SNAME() AS SUSERSNAME, USER_NAME() AS USERNAME, USER AS JustUser, SUSER_SID() AS SUSERSID"
                cn = New SqlClient.SqlConnection(_strDSN)
                cn.Open()

                cmd = cn.CreateCommand
                cmd.CommandText = strSQL

                dr = cmd.ExecuteReader
                If dr.Read Then
                    txtSUSER_NAME.Text = DBNotNull.DBNotNullStr(dr.Item("SUSERNAME"))
                    txtSUSER_SNAME.Text = DBNotNull.DBNotNullStr(dr.Item("SUSERSNAME"))
                    txtUSER_NAME.Text = DBNotNull.DBNotNullStr(dr.Item("USERNAME"))
                    txtUSER.Text = DBNotNull.DBNotNullStr(dr.Item("JustUser"))
                End If
            Catch ex As Exception
                MsgBox(ex.Message, , "Error")
            End Try
        End If

    End Sub

    Private Sub btnDone_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDone.Click
        End
    End Sub
End Class
