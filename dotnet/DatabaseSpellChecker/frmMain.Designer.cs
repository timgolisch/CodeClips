namespace DatabaseSpellChecker
{
    partial class frmMain
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtDbConn = new System.Windows.Forms.TextBox();
            this.tabTablePicker = new System.Windows.Forms.TabControl();
            this.tabTreeView = new System.Windows.Forms.TabPage();
            this.treeTablePicker = new System.Windows.Forms.TreeView();
            this.btnDbGo = new System.Windows.Forms.Button();
            this.btnSpellCheck = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lbxSpellingFlaws = new System.Windows.Forms.ListBox();
            this.lblSelected = new System.Windows.Forms.Label();
            this.pnlSpellCheckProgress = new System.Windows.Forms.Panel();
            this.lblSpellCheckProgress = new System.Windows.Forms.Label();
            this.lblProgressTable = new System.Windows.Forms.Label();
            this.lblTableXofY = new System.Windows.Forms.Label();
            this.lblRowXofY = new System.Windows.Forms.Label();
            this.pbTable = new System.Windows.Forms.ProgressBar();
            this.pbRow = new System.Windows.Forms.ProgressBar();
            this.tabTablePicker.SuspendLayout();
            this.tabTreeView.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.pnlSpellCheckProgress.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(50, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "DB Conn";
            // 
            // txtDbConn
            // 
            this.txtDbConn.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtDbConn.Location = new System.Drawing.Point(56, 6);
            this.txtDbConn.Name = "txtDbConn";
            this.txtDbConn.Size = new System.Drawing.Size(478, 20);
            this.txtDbConn.TabIndex = 1;
            // 
            // tabTablePicker
            // 
            this.tabTablePicker.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.tabTablePicker.Controls.Add(this.tabTreeView);
            this.tabTablePicker.Location = new System.Drawing.Point(1, 32);
            this.tabTablePicker.Name = "tabTablePicker";
            this.tabTablePicker.SelectedIndex = 0;
            this.tabTablePicker.Size = new System.Drawing.Size(280, 544);
            this.tabTablePicker.TabIndex = 2;
            // 
            // tabTreeView
            // 
            this.tabTreeView.Controls.Add(this.treeTablePicker);
            this.tabTreeView.Location = new System.Drawing.Point(4, 22);
            this.tabTreeView.Name = "tabTreeView";
            this.tabTreeView.Padding = new System.Windows.Forms.Padding(3);
            this.tabTreeView.Size = new System.Drawing.Size(272, 518);
            this.tabTreeView.TabIndex = 0;
            this.tabTreeView.Text = "Tree View";
            this.tabTreeView.UseVisualStyleBackColor = true;
            // 
            // treeTablePicker
            // 
            this.treeTablePicker.CheckBoxes = true;
            this.treeTablePicker.Dock = System.Windows.Forms.DockStyle.Fill;
            this.treeTablePicker.Location = new System.Drawing.Point(3, 3);
            this.treeTablePicker.Name = "treeTablePicker";
            this.treeTablePicker.Size = new System.Drawing.Size(266, 512);
            this.treeTablePicker.TabIndex = 0;
            this.treeTablePicker.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.treeTablePicker_AfterSelect);
            // 
            // btnDbGo
            // 
            this.btnDbGo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDbGo.Location = new System.Drawing.Point(540, 4);
            this.btnDbGo.Name = "btnDbGo";
            this.btnDbGo.Size = new System.Drawing.Size(35, 23);
            this.btnDbGo.TabIndex = 3;
            this.btnDbGo.Text = "GO";
            this.btnDbGo.UseVisualStyleBackColor = true;
            this.btnDbGo.Click += new System.EventHandler(this.btnDbGo_Click);
            // 
            // btnSpellCheck
            // 
            this.btnSpellCheck.Enabled = false;
            this.btnSpellCheck.Location = new System.Drawing.Point(162, 32);
            this.btnSpellCheck.Name = "btnSpellCheck";
            this.btnSpellCheck.Size = new System.Drawing.Size(111, 23);
            this.btnSpellCheck.TabIndex = 4;
            this.btnSpellCheck.Text = "Do Spell Check ->";
            this.btnSpellCheck.UseVisualStyleBackColor = true;
            this.btnSpellCheck.Click += new System.EventHandler(this.btnSpellCheck_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.lbxSpellingFlaws);
            this.groupBox1.Controls.Add(this.lblSelected);
            this.groupBox1.Location = new System.Drawing.Point(298, 33);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(268, 536);
            this.groupBox1.TabIndex = 5;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Spelling Flaws";
            // 
            // lbxSpellingFlaws
            // 
            this.lbxSpellingFlaws.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lbxSpellingFlaws.FormattingEnabled = true;
            this.lbxSpellingFlaws.Location = new System.Drawing.Point(10, 43);
            this.lbxSpellingFlaws.Name = "lbxSpellingFlaws";
            this.lbxSpellingFlaws.Size = new System.Drawing.Size(252, 485);
            this.lbxSpellingFlaws.TabIndex = 1;
            this.lbxSpellingFlaws.SelectedIndexChanged += new System.EventHandler(this.lbxSpellingFlaws_SelectedIndexChanged);
            // 
            // lblSelected
            // 
            this.lblSelected.AutoSize = true;
            this.lblSelected.Location = new System.Drawing.Point(9, 24);
            this.lblSelected.Name = "lblSelected";
            this.lblSelected.Size = new System.Drawing.Size(148, 13);
            this.lblSelected.TabIndex = 0;
            this.lblSelected.Text = "Table.Column (none selected)";
            // 
            // pnlSpellCheckProgress
            // 
            this.pnlSpellCheckProgress.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.pnlSpellCheckProgress.BackColor = System.Drawing.Color.Bisque;
            this.pnlSpellCheckProgress.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pnlSpellCheckProgress.Controls.Add(this.pbRow);
            this.pnlSpellCheckProgress.Controls.Add(this.pbTable);
            this.pnlSpellCheckProgress.Controls.Add(this.lblRowXofY);
            this.pnlSpellCheckProgress.Controls.Add(this.lblTableXofY);
            this.pnlSpellCheckProgress.Controls.Add(this.lblProgressTable);
            this.pnlSpellCheckProgress.Controls.Add(this.lblSpellCheckProgress);
            this.pnlSpellCheckProgress.Location = new System.Drawing.Point(116, 169);
            this.pnlSpellCheckProgress.Name = "pnlSpellCheckProgress";
            this.pnlSpellCheckProgress.Size = new System.Drawing.Size(339, 180);
            this.pnlSpellCheckProgress.TabIndex = 1;
            this.pnlSpellCheckProgress.Visible = false;
            // 
            // lblSpellCheckProgress
            // 
            this.lblSpellCheckProgress.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.lblSpellCheckProgress.AutoSize = true;
            this.lblSpellCheckProgress.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSpellCheckProgress.Location = new System.Drawing.Point(100, 12);
            this.lblSpellCheckProgress.Name = "lblSpellCheckProgress";
            this.lblSpellCheckProgress.Size = new System.Drawing.Size(143, 17);
            this.lblSpellCheckProgress.TabIndex = 0;
            this.lblSpellCheckProgress.Text = "Spell Check Progress";
            this.lblSpellCheckProgress.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblProgressTable
            // 
            this.lblProgressTable.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblProgressTable.Location = new System.Drawing.Point(3, 37);
            this.lblProgressTable.Name = "lblProgressTable";
            this.lblProgressTable.Size = new System.Drawing.Size(331, 23);
            this.lblProgressTable.TabIndex = 1;
            this.lblProgressTable.Text = "Table: --waiting--";
            this.lblProgressTable.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblTableXofY
            // 
            this.lblTableXofY.Location = new System.Drawing.Point(121, 89);
            this.lblTableXofY.Name = "lblTableXofY";
            this.lblTableXofY.Size = new System.Drawing.Size(100, 23);
            this.lblTableXofY.TabIndex = 2;
            this.lblTableXofY.Text = "Table 0 of 0";
            this.lblTableXofY.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // lblRowXofY
            // 
            this.lblRowXofY.Location = new System.Drawing.Point(121, 151);
            this.lblRowXofY.Name = "lblRowXofY";
            this.lblRowXofY.Size = new System.Drawing.Size(100, 23);
            this.lblRowXofY.TabIndex = 3;
            this.lblRowXofY.Text = "Row 0 of 0";
            this.lblRowXofY.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // pbTable
            // 
            this.pbTable.Location = new System.Drawing.Point(32, 63);
            this.pbTable.Name = "pbTable";
            this.pbTable.Size = new System.Drawing.Size(278, 23);
            this.pbTable.TabIndex = 4;
            // 
            // pbRow
            // 
            this.pbRow.Location = new System.Drawing.Point(32, 125);
            this.pbRow.Name = "pbRow";
            this.pbRow.Size = new System.Drawing.Size(278, 23);
            this.pbRow.TabIndex = 5;
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(578, 576);
            this.Controls.Add(this.pnlSpellCheckProgress);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.btnSpellCheck);
            this.Controls.Add(this.btnDbGo);
            this.Controls.Add(this.tabTablePicker);
            this.Controls.Add(this.txtDbConn);
            this.Controls.Add(this.label1);
            this.Name = "frmMain";
            this.Text = "DB Spell Checker";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.tabTablePicker.ResumeLayout(false);
            this.tabTreeView.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.pnlSpellCheckProgress.ResumeLayout(false);
            this.pnlSpellCheckProgress.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtDbConn;
        private System.Windows.Forms.TabControl tabTablePicker;
        private System.Windows.Forms.TabPage tabTreeView;
        private System.Windows.Forms.TreeView treeTablePicker;
        private System.Windows.Forms.Button btnDbGo;
        private System.Windows.Forms.Button btnSpellCheck;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ListBox lbxSpellingFlaws;
        private System.Windows.Forms.Label lblSelected;
        private System.Windows.Forms.Panel pnlSpellCheckProgress;
        private System.Windows.Forms.ProgressBar pbRow;
        private System.Windows.Forms.ProgressBar pbTable;
        private System.Windows.Forms.Label lblRowXofY;
        private System.Windows.Forms.Label lblTableXofY;
        private System.Windows.Forms.Label lblProgressTable;
        private System.Windows.Forms.Label lblSpellCheckProgress;
    }
}

