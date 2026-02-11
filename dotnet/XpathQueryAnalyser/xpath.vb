Public Class frmXpath
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
    Friend WithEvents lblXML As System.Windows.Forms.Label
    Friend WithEvents txtXML As System.Windows.Forms.TextBox
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents lblResult As System.Windows.Forms.Label
    Friend WithEvents txtResult As System.Windows.Forms.TextBox
    Friend WithEvents txtXPath As System.Windows.Forms.TextBox
    Friend WithEvents btnRun As System.Windows.Forms.Button
    Friend WithEvents lblXpath As System.Windows.Forms.Label
    Friend WithEvents lblResultType As System.Windows.Forms.Label
    Friend WithEvents mnuFormat As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFormatRaw As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFormatFormatted As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFormatHtml As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFile As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFileSave As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFileSaveAs As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFileOpen As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem9 As System.Windows.Forms.MenuItem
    Friend WithEvents mnuFileExit As System.Windows.Forms.MenuItem
    Friend WithEvents mnuHelp As System.Windows.Forms.MenuItem
    Friend WithEvents mnuHelpOnlineHelp As System.Windows.Forms.MenuItem
    Friend WithEvents mnuHelpSuggestion As System.Windows.Forms.MenuItem
    Friend WithEvents ofdXml As System.Windows.Forms.OpenFileDialog
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.lblXML = New System.Windows.Forms.Label
        Me.txtXML = New System.Windows.Forms.TextBox
        Me.MainMenu1 = New System.Windows.Forms.MainMenu
        Me.mnuFile = New System.Windows.Forms.MenuItem
        Me.mnuFileSave = New System.Windows.Forms.MenuItem
        Me.mnuFileSaveAs = New System.Windows.Forms.MenuItem
        Me.mnuFileOpen = New System.Windows.Forms.MenuItem
        Me.MenuItem9 = New System.Windows.Forms.MenuItem
        Me.mnuFileExit = New System.Windows.Forms.MenuItem
        Me.mnuFormat = New System.Windows.Forms.MenuItem
        Me.mnuFormatRaw = New System.Windows.Forms.MenuItem
        Me.mnuFormatFormatted = New System.Windows.Forms.MenuItem
        Me.mnuFormatHtml = New System.Windows.Forms.MenuItem
        Me.mnuHelp = New System.Windows.Forms.MenuItem
        Me.mnuHelpOnlineHelp = New System.Windows.Forms.MenuItem
        Me.mnuHelpSuggestion = New System.Windows.Forms.MenuItem
        Me.lblResult = New System.Windows.Forms.Label
        Me.txtResult = New System.Windows.Forms.TextBox
        Me.txtXPath = New System.Windows.Forms.TextBox
        Me.btnRun = New System.Windows.Forms.Button
        Me.lblXpath = New System.Windows.Forms.Label
        Me.lblResultType = New System.Windows.Forms.Label
        Me.ofdXml = New System.Windows.Forms.OpenFileDialog
        Me.SuspendLayout()
        '
        'lblXML
        '
        Me.lblXML.Location = New System.Drawing.Point(0, 0)
        Me.lblXML.Name = "lblXML"
        Me.lblXML.Size = New System.Drawing.Size(40, 16)
        Me.lblXML.TabIndex = 0
        Me.lblXML.Text = "XML"
        '
        'txtXML
        '
        Me.txtXML.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtXML.Location = New System.Drawing.Point(0, 16)
        Me.txtXML.MaxLength = 2000000
        Me.txtXML.Multiline = True
        Me.txtXML.Name = "txtXML"
        Me.txtXML.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.txtXML.Size = New System.Drawing.Size(480, 200)
        Me.txtXML.TabIndex = 3
        Me.txtXML.Text = "TextBox1"
        Me.txtXML.WordWrap = False
        '
        'MainMenu1
        '
        Me.MainMenu1.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.mnuFile, Me.mnuFormat, Me.mnuHelp})
        '
        'mnuFile
        '
        Me.mnuFile.Index = 0
        Me.mnuFile.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.mnuFileSave, Me.mnuFileSaveAs, Me.mnuFileOpen, Me.MenuItem9, Me.mnuFileExit})
        Me.mnuFile.Text = "File"
        '
        'mnuFileSave
        '
        Me.mnuFileSave.Index = 0
        Me.mnuFileSave.Text = "Save"
        Me.mnuFileSave.Visible = False
        '
        'mnuFileSaveAs
        '
        Me.mnuFileSaveAs.Index = 1
        Me.mnuFileSaveAs.Text = "Save As"
        Me.mnuFileSaveAs.Visible = False
        '
        'mnuFileOpen
        '
        Me.mnuFileOpen.Index = 2
        Me.mnuFileOpen.Text = "Open"
        '
        'MenuItem9
        '
        Me.MenuItem9.Index = 3
        Me.MenuItem9.Text = "-"
        '
        'mnuFileExit
        '
        Me.mnuFileExit.Index = 4
        Me.mnuFileExit.Text = "Exit"
        '
        'mnuFormat
        '
        Me.mnuFormat.Index = 1
        Me.mnuFormat.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.mnuFormatRaw, Me.mnuFormatFormatted, Me.mnuFormatHtml})
        Me.mnuFormat.Text = "Format"
        '
        'mnuFormatRaw
        '
        Me.mnuFormatRaw.Index = 0
        Me.mnuFormatRaw.Text = "Raw"
        '
        'mnuFormatFormatted
        '
        Me.mnuFormatFormatted.Index = 1
        Me.mnuFormatFormatted.Text = "Formatted"
        '
        'mnuFormatHtml
        '
        Me.mnuFormatHtml.Index = 2
        Me.mnuFormatHtml.Text = "HTML"
        Me.mnuFormatHtml.Visible = False
        '
        'mnuHelp
        '
        Me.mnuHelp.Index = 2
        Me.mnuHelp.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.mnuHelpOnlineHelp, Me.mnuHelpSuggestion})
        Me.mnuHelp.Text = "Help"
        '
        'mnuHelpOnlineHelp
        '
        Me.mnuHelpOnlineHelp.Index = 0
        Me.mnuHelpOnlineHelp.Text = "Online Help"
        '
        'mnuHelpSuggestion
        '
        Me.mnuHelpSuggestion.Index = 1
        Me.mnuHelpSuggestion.Text = "Suggestion"
        '
        'lblResult
        '
        Me.lblResult.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblResult.Location = New System.Drawing.Point(8, 248)
        Me.lblResult.Name = "lblResult"
        Me.lblResult.Size = New System.Drawing.Size(56, 16)
        Me.lblResult.TabIndex = 6
        Me.lblResult.Text = "Result"
        '
        'txtResult
        '
        Me.txtResult.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtResult.Location = New System.Drawing.Point(0, 264)
        Me.txtResult.MaxLength = 2100000
        Me.txtResult.Multiline = True
        Me.txtResult.Name = "txtResult"
        Me.txtResult.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.txtResult.Size = New System.Drawing.Size(484, 216)
        Me.txtResult.TabIndex = 5
        Me.txtResult.Text = "TextBox3"
        Me.txtResult.WordWrap = False
        '
        'txtXPath
        '
        Me.txtXPath.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtXPath.Location = New System.Drawing.Point(64, 224)
        Me.txtXPath.Name = "txtXPath"
        Me.txtXPath.Size = New System.Drawing.Size(368, 20)
        Me.txtXPath.TabIndex = 4
        Me.txtXPath.Text = "TextBox2"
        '
        'btnRun
        '
        Me.btnRun.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRun.Location = New System.Drawing.Point(432, 224)
        Me.btnRun.Name = "btnRun"
        Me.btnRun.Size = New System.Drawing.Size(48, 23)
        Me.btnRun.TabIndex = 2
        Me.btnRun.Text = "Run"
        '
        'lblXpath
        '
        Me.lblXpath.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblXpath.Location = New System.Drawing.Point(0, 224)
        Me.lblXpath.Name = "lblXpath"
        Me.lblXpath.Size = New System.Drawing.Size(72, 16)
        Me.lblXpath.TabIndex = 1
        Me.lblXpath.Text = "XPath Query"
        '
        'lblResultType
        '
        Me.lblResultType.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblResultType.Location = New System.Drawing.Point(64, 248)
        Me.lblResultType.Name = "lblResultType"
        Me.lblResultType.Size = New System.Drawing.Size(184, 16)
        Me.lblResultType.TabIndex = 7
        Me.lblResultType.Text = "(no result yet)"
        '
        'frmXpath
        '
        Me.AcceptButton = Me.btnRun
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(480, 477)
        Me.Controls.Add(Me.lblResultType)
        Me.Controls.Add(Me.lblResult)
        Me.Controls.Add(Me.txtResult)
        Me.Controls.Add(Me.txtXPath)
        Me.Controls.Add(Me.txtXML)
        Me.Controls.Add(Me.btnRun)
        Me.Controls.Add(Me.lblXpath)
        Me.Controls.Add(Me.lblXML)
        Me.Menu = Me.MainMenu1
        Me.Name = "frmXpath"
        Me.Text = "XPath Query Analyser"
        Me.ResumeLayout(False)

    End Sub

#End Region

#Region " Private Variables "
    Const cAPPNAME As String = "XPathQueryAnalyser"
    Const cFILE As String = "lastxml.xml"
    Private _strFile As String
#End Region

#Region " Form Events "
    Private Sub Form_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim objFileIn As System.IO.StreamReader
        'Dim objDocIn As New Xml.XmlDocument

        Try
            _strFile = GetSetting(cAPPNAME, Me.Name, "XmlFile", System.IO.Path.Combine(CurDir(), cFILE))
            objFileIn = New System.IO.StreamReader(_strFile)
            txtXML.Text = objFileIn.ReadToEnd
            objFileIn.Close()

            'choose which formatting to use
            Select Case GetSetting(cAPPNAME, Me.Name, "Format", "None")
                Case "Formatted"
                    mnuFormatFormatted_Click(sender, e)
                Case "Raw"
                    mnuFormatRaw_Click(sender, e)
            End Select

        Catch ex As Exception
            MsgBox(ex.Message, , "Error while Loading settings")
        End Try

        txtXPath.Text = GetSetting(cAPPNAME, Me.Name, "LastQuery")
        txtResult.Text = ""
        'restore the window size & location
        Me.Height = GetSetting(cAPPNAME, Me.Name, "Height", Me.Height)
        Me.Width = GetSetting(cAPPNAME, Me.Name, "Width", Me.Width)
        Me.Left = GetSetting(cAPPNAME, Me.Name, "Left", Me.Left)
        Me.Top = GetSetting(cAPPNAME, Me.Name, "Top", Me.Top)

    End Sub

    Private Sub Form_Closing(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles MyBase.Closing
        Dim objFileOut As System.IO.StreamWriter

        Try
            objFileOut = New System.IO.StreamWriter(CurDir() & cFILE)
            objFileOut.Write(txtXML.Text)
            objFileOut.Close()

        Catch ex As Exception
            MsgBox(ex.Message, , "Error while saving settings")
        End Try

        SaveSetting(cAPPNAME, Me.Name, "XmlFile", _strFile)
        SaveSetting(cAPPNAME, Me.Name, "LastQuery", txtXPath.Text)
        'if the window is not maximized or minimized, save its location & size
        If Me.WindowState = FormWindowState.Normal Then
            SaveSetting(cAPPNAME, Me.Name, "Height", Me.Height)
            SaveSetting(cAPPNAME, Me.Name, "Width", Me.Width)
            SaveSetting(cAPPNAME, Me.Name, "Left", Me.Left)
            SaveSetting(cAPPNAME, Me.Name, "Top", Me.Top)
        End If
        If mnuFormatFormatted.Checked Then
            SaveSetting(cAPPNAME, Me.Name, "Format", "Formatted")
        ElseIf mnuFormatRaw.Checked Then
            SaveSetting(cAPPNAME, Me.Name, "Format", "Raw")
        Else
            SaveSetting(cAPPNAME, Me.Name, "Format", "None")
        End If

    End Sub
#End Region

    Private Sub btnRun_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRun.Click
        Dim objDocIn, objDocOut As Xml.XmlDocument
        Dim objNodes As Xml.XmlNodeList
        Dim x As Integer

        Dim objXPath As Xml.XPath.XPathDocument
        Dim objTR As IO.StringReader
        Dim objXR As Xml.XmlTextReader

        Dim strOut As New System.Text.StringBuilder
        Dim objTemp As Object
        Dim objIterator As Xml.XPath.XPathNodeIterator

        Try
            objTR = New IO.StringReader(txtXML.Text)
            objXR = New Xml.XmlTextReader(objTR)
            objXPath = New Xml.XPath.XPathDocument(objXR)
            objXR = Nothing
            objTR = Nothing
        Catch ex As Exception
            MsgBox(ex.Message, , "Error load the XML")
            lblResultType.Text = "(no result)"
            Exit Sub
        End Try

        Try
            objTemp = objXPath.CreateNavigator().Evaluate(txtXPath.Text)
        Catch ex As Exception
            MsgBox(ex.Message, , "Error processing the XPath query")
            lblResultType.Text = "(no result)"
            Exit Sub
        End Try

        Try
            Select Case TypeName(objTemp)
                Case "XPathSelectionIterator"
                    objDocIn = New Xml.XmlDocument
                    objDocOut = objDocIn.Clone

                    objDocIn.LoadXml(txtXML.Text)

                    objNodes = objDocIn.SelectNodes(txtXPath.Text) 'as xml.xmldocument
                    objDocOut.RemoveAll()

                    lblResultType.Text = "(xml)"
                    For x = 0 To objNodes.Count - 1
                        strOut.Append(objNodes(x).OuterXml & vbCrLf)
                    Next
                Case "String"
                    lblResultType.Text = "(string)"
                    strOut.Append(objTemp)
                Case "Number", "Double", "Boolean"
                    lblResultType.Text = "(Number)"
                    strOut.Append(objTemp.ToString)
                Case Else
                    lblResultType.Text = "(" & TypeName(objTemp) & ")"
                    MsgBox("No handler for result set of """ & TypeName(objTemp) & """")
            End Select
            txtResult.Text = strOut.ToString
        Catch ex As Exception
            MsgBox(ex.Message, , "Error displaying the XML")
            lblResultType.Text = "(no result)"
            Exit Sub
        End Try

    End Sub

    Private Sub txtXML_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtXML.TextChanged

    End Sub
    Private Sub txtXML_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtXML.KeyUp
        'ctrl-A highlights "all" (like in Notepad)
        If (e.Control And (Not e.Shift) And (Not e.Alt) And e.KeyCode = Keys.A) Then
            txtXML.SelectAll()
        ElseIf e.Control And (e.KeyCode = Keys.V) Then
            'if they pressed ctrl-v, they just pasted, go ahead and format the content for them
            If mnuFormatFormatted.Checked Then
                mnuFormatRaw_Click(sender, e)
                mnuFormatFormatted_Click(sender, e)
            ElseIf mnuFormatRaw.Checked Then
                mnuFormatRaw_Click(sender, e)
            End If
        End If
    End Sub

#Region " Menu "
#Region "   File "

    Private Sub mnuFileSaveAs_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFileSaveAs.Click
        'disabled for now
    End Sub

    Private Sub mnuFileSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFileSave.Click
        'disabled for now
    End Sub

    Private Sub mnuFileOpen_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFileOpen.Click
        Dim strFileName As String

        strFileName = _strFile
        ofdXml.Filter = "*.xml"

        ofdXml.FileName = strFileName
        ofdXml.ShowDialog()
        strFileName = ofdXml.FileName

        SaveSetting(cAPPNAME, Me.Name, "XmlFile", strFileName)
        txtXML.Text = ReadXml(strFileName)
    End Sub

    Private Sub mnuFileExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFileExit.Click
        Me.Close()
    End Sub
#End Region

#Region "   Format "
    Private Sub mnuFormatRaw_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFormatRaw.Click
        Dim strTemp As String

        'remove line breaks, tabs and spaces (unless the text is part of an element or attribute
        strTemp = txtXML.Text.Replace(vbCrLf, "").Replace(vbTab, "")
        While strTemp.IndexOf("> ") > 0
            strTemp = strTemp.Replace("> ", ">")
        End While
        txtXML.Text = strTemp

        mnuFormatFormatted.Checked = False
        mnuFormatHtml.Checked = False
        mnuFormatRaw.Checked = True
    End Sub

    Private Sub mnuFormatFormatted_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFormatFormatted.Click
        txtXML.Text = FormatXml(txtXML.Text)
        mnuFormatFormatted.Checked = True
        mnuFormatHtml.Checked = False
        mnuFormatRaw.Checked = False
    End Sub

    Private Sub mnuFormatHtml_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuFormatHtml.Click
        mnuFormatFormatted.Checked = False
        mnuFormatHtml.Checked = True
        mnuFormatRaw.Checked = False
    End Sub

#End Region

#Region "   Help "
    Private Sub mnuHelpOnlineHelp_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuHelpOnlineHelp.Click
        Dim objReg As Microsoft.Win32.RegistryKey
        Dim strIExplore As String

        'find out which browser to use to browse the web page
        objReg = Microsoft.Win32.Registry.LocalMachine.OpenSubKey("SOFTWARE\Classes\Applications\iexplore.exe\shell\open\command", False)
        If objReg Is Nothing Then
            MsgBox("Open your browser to http://www.w3.org/TR/xpath")
        Else
            strIExplore = objReg.GetValue("")
            Shell(strIExplore.Replace("%1", "http://www.w3.org/TR/xpath"), AppWinStyle.NormalFocus)
        End If

    End Sub

    Private Sub mnuHelpSuggestion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mnuHelpSuggestion.Click
        Dim bolIsNamespace As Boolean
        Dim xmlContent As Xml.XmlDocument
        Dim strXpath As String
        Dim arrTemp() As String

        'there are lots of suggestions to give 
        'start by analysing the xml and their current query
        Try
            xmlContent = New Xml.XmlDocument
            xmlContent.LoadXml(txtXML.Text)
            strXpath = txtXPath.Text

            If xmlContent.FirstChild.NamespaceURI <> "" Then bolIsNamespace = True
        Catch ex As Exception
            MsgBox(ex.Message, , "Invalid XML")
            Exit Sub
        End Try

        'start off simple
        'if their query is kinda deep, recommend that they start out shallow
        arrTemp = Split(strXpath, "/")
        If (arrTemp.Length > 1 AndAlso arrTemp(0) <> "") OrElse (arrTemp.Length > 2) Then
            MsgBox("You may be starting off with a rather complicated XPath query.  Try starting with something more simple and work up to something more complicated.")
        End If

        'start with one of the following:  /  or // or //*
        If arrTemp.Length < 2 Then
            MsgBox("You may want to start your query with a ""/*"" or a ""//*"".  This tells it to start from the root of the XML")
        ElseIf Not (strXpath.StartsWith("/*") Or strXpath.StartsWith("//*")) Then
            MsgBox("Your query may need to find multiple results.  Try starting your query with ""//*"" before you use the name of the node you want.")
        Else
            MsgBox("Your query may need to search deeper for the node you need.  Try starting your query with ""//*"" before you use the name of the node you want.")
        End If
        'maybe consider doing the whole "/*[local-name()='###']"  thing
        If bolIsNamespace And (InStr(strXpath, "local-name()") < 1 Or InStr(strXpath, "local-name()") > 6) Then
            MsgBox("Your XML seems to be using a namespace.  Normally, to find xml elements when there is a namespace, you need to use ""[local-name()='nodename']"" (where nodename is the name of the node that you are trying to find)")
        End If
    End Sub

#End Region
#End Region

#Region " Helper Functions "
    Private Function FormatXml(ByVal strIn As String) As String
        Dim strOut As String
        Dim strFile() As String
        Dim x As Int32
        Dim intIndent As Int32 = 0
        Dim bolArrContentCount(1000) As Integer

        'start off pretty simply
        strOut = strIn.Replace("><", ">" & vbCrLf & "<")

        'then look for lines to indent
        strFile = Split(strOut, vbCrLf)
        For x = 0 To strFile.Length - 1
            If strFile(x).StartsWith("<?") Then
                'if it is the <?xml...?> tag then ignore it..don't increase indent
                strFile(x) = RepeatStr(vbTab, intIndent) & strFile(x).Trim
            ElseIf InStr(strFile(x), "/>") > 1 Then
                'if it is a <tag/> then it is singular..don't increase indent
                strFile(x) = RepeatStr(vbTab, intIndent) & strFile(x).Trim
                bolArrContentCount(intIndent) += 1
                If intIndent > 0 Then bolArrContentCount(intIndent - 1) += 1
            ElseIf strFile(x).Trim.StartsWith("</") Then
                If bolArrContentCount(intIndent) = 0 Then
                    'if the content count is 0, there is no content, so we should pull the end tag onto the same line as the opening tag
                    intIndent -= 1
                    strFile(x - 1) &= strFile(x).Trim
                    strFile(x) = ""
                Else
                    'this is a closing tag...unindent
                    intIndent -= 1
                    strFile(x) = RepeatStr(vbTab, intIndent) & strFile(x).Trim
                End If
            ElseIf InStr(strFile(x), "</") > 0 Then
                'this line contains its own closing tag...no changes to indent
                strFile(x) = RepeatStr(vbTab, intIndent) & strFile(x).Trim
                bolArrContentCount(intIndent) += 1
            Else
                'just a begin tag
                strFile(x) = RepeatStr(vbTab, intIndent) & strFile(x).Trim
                bolArrContentCount(intIndent) += 1
                'indent its contents
                intIndent += 1
                'reset the content count at this intent level
                bolArrContentCount(intIndent) = 0
                If intIndent > 0 Then bolArrContentCount(intIndent - 1) += 1
            End If
        Next

        strOut = Join(strFile, vbCrLf)
        'remove blank lines
        While InStr(strOut, vbCrLf & vbCrLf)
            strOut = strOut.Replace(vbCrLf & vbCrLf, vbCrLf)
        End While

        Return strOut
    End Function

    Private Function RepeatStr(ByVal strIn As String, ByVal intCount As Int32) As String
        Dim x As Integer
        Dim strOut As String = ""

        For x = 0 To intCount - 1
            strOut &= strIn
        Next

        Return strOut
    End Function

    Private Function ReadXml(ByVal strFile As String) As String
        Dim objXml As New Xml.XmlDocument

        Try
            objXml.Load(strFile)
            Return objXml.OuterXml
        Catch ex As Exception
            MsgBox(ex.Message, , "Error while reading xml file")
        End Try
    End Function

    Private Sub SaveXml(ByVal strXml As String, ByVal strFile As String)
        Dim objFileOut As System.IO.StreamWriter

        Try
            objFileOut = New System.IO.StreamWriter(strFile)
            objFileOut.Write(strXml)
            objFileOut.Close()
        Catch ex As Exception
            MsgBox(ex.Message, , "Error while saving settings")
        End Try
    End Sub
#End Region
End Class
