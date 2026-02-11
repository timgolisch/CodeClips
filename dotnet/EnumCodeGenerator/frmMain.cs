using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Settings = EnumCodeGenerator.Properties.Settings;

namespace EnumCodeGenerator
{
    public partial class frmMain : Form
    {
        DataTable _tblDatabases = null;
        DataTable _tblTables = null;

        #region Properties
        public string Server
        { 
            get
            {
                return lblServer.Text;
            }
        }
        public string Database
        {
            get
            {
                string strDatabase = "";
                try
                {
                    if (strDatabase == "")
                        if (lbxDatabase.SelectedIndex >= 0 && lbxDatabase.SelectedItem != null)
                        {
                            System.Data.DataRowView drv = (System.Data.DataRowView)lbxDatabase.SelectedItem;
                            if (drv.Row != null && drv.Row.ItemArray.Length > 0)
                                strDatabase = drv.Row[0].ToString();
                        };
                }
                catch { }
                return strDatabase;
            }
        }
        public string Table
        {
            get
            {
                string strTable = "";
                try
                {
                    if (strTable == "")
                        if (lbxTables.SelectedIndex >= 0 && lbxTables.SelectedItem != null)
                        {
                            System.Data.DataRowView drv = (System.Data.DataRowView)lbxTables.SelectedItem;
                            if (drv.Row != null && drv.Row.ItemArray.Length > 1)
                                strTable = drv.Row[1].ToString();
                        };
                }
                catch { }
                return strTable;
            }
        }
        #endregion


        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            txtSavePath.Text = Settings.SavePath;
            lblServer.Text = Settings.Server;
            LoadDbList();
        }

        private void btnServer_Click(object sender, EventArgs e)
        {
            lblServer.Text = InputBox.Show("Server Name", "Select DB Server", Server).ReturnString;
            LoadDbList();
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            foreach (DataRowView row in lbxTables.CheckedItems)
            {
                GenerateEnum(DBNotNull.DBNotNullStr(row.Row[1]), txtSavePath.Text);
            }
            //unselect all
            lbxTables.ClearSelected();
            for (int x = 0; x < lbxTables.Items.Count; x++ )
            {
                lbxTables.SetItemChecked(x, false);
            }
        }

        private void lbxDatabase_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strDatabase = Database;
            string strSQL;

            try
            {
                if (strDatabase != "")
                {
                    strSQL = "SELECT [object_id], [name] FROM [" + strDatabase + "].sys.tables WHERE type='U' ORDER BY Name";
                    _tblTables = DbHelper.ExecuteTable(strSQL, null, CommandType.Text);
                    lbxTables.DataSource = _tblTables;
                    lbxTables.DisplayMember = "Name";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void lbxTables_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strDatabase = Database;
            string strTable = Table;
            string strSQL;
            System.Data.DataTable tbl;

            try
            {
                if (strDatabase != "" && strTable != "")
                {
                    strSQL = "SELECT TOP 500 * FROM [" + strDatabase + "]..[" + strTable + "] ORDER BY ID";
                    tbl = DbHelper.ExecuteTable(strSQL, null, CommandType.Text);
                    grdPreview.DataSource = tbl;
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "Invalid column name 'ID'.")
                    MessageBox.Show("You cannot use this table because it does not have an [ID] column.");
                else
                    MessageBox.Show(ex.Message);
            };
        }

        
        
        private void LoadDbList()
        {
            try
            {
                _tblDatabases = DbHelper.ExecuteTable("SELECT name FROM sys.databases WHERE name NOT IN ('master','tempdb','model','msdb','ReportServer','ReportServerTempDB')", null, CommandType.Text);
                lbxDatabase.DataSource = _tblDatabases;
                lbxDatabase.DisplayMember = "Name";
            }
            catch  (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
        }

        private void GenerateEnum(string TableName, string Path)
        {
            string strDatabase = Database;
            string strSQL;
            System.Data.DataTable tbl;
            StringBuilder sbEnum = new StringBuilder();
            string strSuffix = "\n";
            string strFile;

            try
            {
                if (Database != "" && TableName != "")
                {
                    //header
                    sbEnum.Append("using System;\n\n");
                    //namespace
                    sbEnum.Append(Settings.Namespace + "\n{\n");
                    //enum declaration
                    sbEnum.Append("\tpublic enum " + TableName + "Enum\n\t{");

                    strSQL = "SELECT * FROM [" + strDatabase + "]..[" + TableName + "]";
                    tbl = DbHelper.ExecuteTable(strSQL, null, CommandType.Text);
                    foreach (DataRow row in tbl.Rows)
                    {
                        sbEnum.Append(strSuffix);
                        sbEnum.Append("\t\t" + row["Name"].ToString().Replace(" ", "") + " = " + row["ID"].ToString());
                        strSuffix = ",\n";
                    }
                    sbEnum.Append("\n");
                    sbEnum.Append("\t};\n");
                    sbEnum.Append("}\n");

                    //write the file
                    strFile = System.IO.Path.Combine(Path, TableName + ".enu.cs");
                    string strEnum = sbEnum.ToString();
                    System.IO.File.WriteAllLines(strFile, strEnum.Split(new string[]{"\n"}, StringSplitOptions.None));
                }
                else
                {
                    MessageBox.Show("Cannot generate enums for table \"" + TableName + "\"");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
            
        }
   }
}
