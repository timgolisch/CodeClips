namespace XpathQueryAnalyser
{
    partial class frmXPath
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            MainMenu = new MenuStrip();
            mnuFile = new ToolStripMenuItem();
            mnuFileSave = new ToolStripMenuItem();
            mnuFileSaveAs = new ToolStripMenuItem();
            mnuFileOpen = new ToolStripMenuItem();
            mnuItem9 = new ToolStripMenuItem();
            mnuFileExit = new ToolStripMenuItem();
            mnuFormat = new ToolStripMenuItem();
            mnuFormatRaw = new ToolStripMenuItem();
            mnuFormatFormatted = new ToolStripMenuItem();
            mnuFormatHtml = new ToolStripMenuItem();
            mnuHelp = new ToolStripMenuItem();
            mnuHelpOnline = new ToolStripMenuItem();
            mnuHelpSuggestion = new ToolStripMenuItem();
            mnuHelpExample = new ToolStripMenuItem();
            lblXML = new Label();
            txtXML = new TextBox();
            lblResult = new Label();
            txtResult = new TextBox();
            txtXPath = new TextBox();
            btnRun = new Button();
            lblXpath = new Label();
            lblResultType = new Label();
            ofdXml = new OpenFileDialog();
            MainMenu.SuspendLayout();
            SuspendLayout();
            // 
            // MainMenu
            // 
            MainMenu.Items.AddRange(new ToolStripItem[] { mnuFile, mnuFormat, mnuHelp });
            MainMenu.Location = new Point(0, 0);
            MainMenu.Name = "MainMenu";
            MainMenu.Size = new Size(800, 24);
            MainMenu.TabIndex = 0;
            MainMenu.Text = "MainMenu";
            // 
            // mnuFile
            // 
            mnuFile.DropDownItems.AddRange(new ToolStripItem[] { mnuFileSave, mnuFileSaveAs, mnuFileOpen, mnuItem9, mnuFileExit });
            mnuFile.Name = "mnuFile";
            mnuFile.Size = new Size(37, 20);
            mnuFile.Text = "File";
            // 
            // mnuFileSave
            // 
            mnuFileSave.Name = "mnuFileSave";
            mnuFileSave.Size = new Size(114, 22);
            mnuFileSave.Text = "Save";
            mnuFileSave.Visible = false;
            mnuFileSave.Click += mnuFileSave_Click;
            // 
            // mnuFileSaveAs
            // 
            mnuFileSaveAs.Name = "mnuFileSaveAs";
            mnuFileSaveAs.Size = new Size(114, 22);
            mnuFileSaveAs.Text = "Save As";
            mnuFileSaveAs.Visible = false;
            mnuFileSaveAs.Click += mnuFileSaveAs_Click;
            // 
            // mnuFileOpen
            // 
            mnuFileOpen.Name = "mnuFileOpen";
            mnuFileOpen.Size = new Size(114, 22);
            mnuFileOpen.Text = "Open";
            mnuFileOpen.Click += mnuFileOpen_Click;
            // 
            // mnuItem9
            // 
            mnuItem9.Name = "mnuItem9";
            mnuItem9.Size = new Size(114, 22);
            mnuItem9.Text = "---";
            // 
            // mnuFileExit
            // 
            mnuFileExit.Name = "mnuFileExit";
            mnuFileExit.Size = new Size(114, 22);
            mnuFileExit.Text = "Exit";
            // 
            // mnuFormat
            // 
            mnuFormat.DropDownItems.AddRange(new ToolStripItem[] { mnuFormatRaw, mnuFormatFormatted, mnuFormatHtml });
            mnuFormat.Name = "mnuFormat";
            mnuFormat.Size = new Size(57, 20);
            mnuFormat.Text = "Format";
            // 
            // mnuFormatRaw
            // 
            mnuFormatRaw.Name = "mnuFormatRaw";
            mnuFormatRaw.Size = new Size(129, 22);
            mnuFormatRaw.Text = "Raw";
            mnuFormatRaw.Click += mnuFormatRaw_Click;
            // 
            // mnuFormatFormatted
            // 
            mnuFormatFormatted.Name = "mnuFormatFormatted";
            mnuFormatFormatted.Size = new Size(129, 22);
            mnuFormatFormatted.Text = "Formatted";
            mnuFormatFormatted.Click += mnuFormatFormatted_Click;
            // 
            // mnuFormatHtml
            // 
            mnuFormatHtml.Name = "mnuFormatHtml";
            mnuFormatHtml.Size = new Size(129, 22);
            mnuFormatHtml.Text = "HTML";
            mnuFormatHtml.Click += mnuFormatHtml_Click;
            // 
            // mnuHelp
            // 
            mnuHelp.DropDownItems.AddRange(new ToolStripItem[] { mnuHelpOnline, mnuHelpSuggestion, mnuHelpExample });
            mnuHelp.Name = "mnuHelp";
            mnuHelp.Size = new Size(44, 20);
            mnuHelp.Text = "Help";
            // 
            // mnuHelpOnline
            // 
            mnuHelpOnline.Name = "mnuHelpOnline";
            mnuHelpOnline.Size = new Size(137, 22);
            mnuHelpOnline.Text = "Online Help";
            mnuHelpOnline.Click += mnuHelpOnlineHelp_Click;
            // 
            // mnuHelpSuggestion
            // 
            mnuHelpSuggestion.Name = "mnuHelpSuggestion";
            mnuHelpSuggestion.Size = new Size(137, 22);
            mnuHelpSuggestion.Text = "Suggestion";
            mnuHelpSuggestion.Click += mnuHelpSuggestion_Click;
            // 
            // mnuHelpExample
            // 
            mnuHelpExample.Name = "mnuHelpExample";
            mnuHelpExample.Size = new Size(137, 22);
            mnuHelpExample.Text = "Example";
            mnuHelpExample.Click += mnuHelpExample_Click;
            // 
            // lblXML
            // 
            lblXML.Location = new Point(0, 0);
            lblXML.Name = "lblXML";
            lblXML.Size = new Size(40, 16);
            lblXML.TabIndex = 0;
            lblXML.Text = "XML";
            // 
            // txtXML
            // 
            txtXML.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtXML.Location = new Point(0, 27);
            txtXML.MaxLength = 2000000;
            txtXML.Multiline = true;
            txtXML.Name = "txtXML";
            txtXML.ScrollBars = ScrollBars.Both;
            txtXML.Size = new Size(800, 189);
            txtXML.TabIndex = 3;
            txtXML.Text = "Paste Xml Here";
            txtXML.WordWrap = false;
            txtXML.KeyUp += txtXML_KeyUp;
            // 
            // lblResult
            // 
            lblResult.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblResult.Location = new Point(8, 248);
            lblResult.Name = "lblResult";
            lblResult.Size = new Size(56, 16);
            lblResult.TabIndex = 6;
            lblResult.Text = "Result";
            // 
            // txtResult
            // 
            txtResult.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtResult.Location = new Point(0, 264);
            txtResult.MaxLength = 2100000;
            txtResult.Multiline = true;
            txtResult.Name = "txtResult";
            txtResult.ScrollBars = ScrollBars.Both;
            txtResult.Size = new Size(800, 189);
            txtResult.TabIndex = 5;
            txtResult.Text = "TextBox3";
            txtResult.WordWrap = false;
            // 
            // txtXPath
            // 
            txtXPath.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtXPath.Location = new Point(64, 224);
            txtXPath.Name = "txtXPath";
            txtXPath.Size = new Size(682, 23);
            txtXPath.TabIndex = 4;
            txtXPath.Text = "TextBox2";
            // 
            // btnRun
            // 
            btnRun.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            btnRun.Location = new Point(752, 224);
            btnRun.Name = "btnRun";
            btnRun.Size = new Size(48, 23);
            btnRun.TabIndex = 2;
            btnRun.Text = "Run";
            btnRun.Click += btnRun_Click;
            // 
            // lblXpath
            // 
            lblXpath.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblXpath.Location = new Point(0, 224);
            lblXpath.Name = "lblXpath";
            lblXpath.Size = new Size(72, 16);
            lblXpath.TabIndex = 1;
            lblXpath.Text = "XPath Query";
            // 
            // lblResultType
            // 
            lblResultType.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblResultType.Location = new Point(64, 248);
            lblResultType.Name = "lblResultType";
            lblResultType.Size = new Size(184, 16);
            lblResultType.TabIndex = 7;
            lblResultType.Text = "no result yet";
            // 
            // ofdXml
            // 
            ofdXml.FileName = "ofdXml";
            // 
            // frmXPath
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(MainMenu);
            Controls.Add(lblResultType);
            Controls.Add(lblResult);
            Controls.Add(txtResult);
            Controls.Add(txtXPath);
            Controls.Add(txtXML);
            Controls.Add(btnRun);
            Controls.Add(lblXpath);
            Controls.Add(lblXML);
            MainMenuStrip = MainMenu;
            Name = "frmXPath";
            Text = "XPath Query Analyzer";
            FormClosing += frmXPath_FormClosing;
            Load += Form_Load;
            MainMenu.ResumeLayout(false);
            MainMenu.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        private void BtnRun_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        #endregion

        private MenuStrip MainMenu;
        private ToolStripMenuItem mnuFormat;
        private ToolStripMenuItem mnuFormatRaw;
        private ToolStripMenuItem mnuFormatFormatted;
        private ToolStripMenuItem mnuFormatHtml;
        private ToolStripMenuItem mnuFile;
        private ToolStripMenuItem mnuFileSave;
        private ToolStripMenuItem mnuFileSaveAs;
        private ToolStripMenuItem mnuFileOpen;
        private ToolStripMenuItem mnuItem9;
        private ToolStripMenuItem mnuFileExit;
        private ToolStripMenuItem mnuHelp;
        private ToolStripMenuItem mnuHelpOnline;
        private ToolStripMenuItem mnuHelpSuggestion;
        private ToolStripMenuItem mnuHelpExample;
        private Label lblXML;
        private TextBox txtXML;
        private Label lblResult;
        private TextBox txtResult;
        private TextBox txtXPath;
        private Button btnRun;
        private Label lblXpath;
        private Label lblResultType;
        private OpenFileDialog ofdXml;
    }
}