using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DatabaseSpellChecker
{
    public partial class frmMain : Form
    {
        private DataSet dsResult;
        private bool isLoading = true;

        public frmMain()
        {
            InitializeComponent();
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            txtDbConn.Text = Properties.Settings.Default.DbConn;
        }

        private void btnDbGo_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder xml = new StringBuilder();
            //look up the list of database tables
            string SQL = "SELECT tbl.name AS [Table], col.Name AS [Column] " +
                        " FROM sys.columns col INNER JOIN sys.tables tbl ON col.object_id = tbl.object_id " +
                        " WHERE col.user_type_id in (167,175,165,35,231,256,99) OR collation_name > '' " +
                        " ORDER BY [Table], col.column_id";
            string DSN = txtDbConn.Text;
            DataSet ds = new DataSet();

            try
            {
                System.Data.OleDb.OleDbDataAdapter da = new System.Data.OleDb.OleDbDataAdapter(SQL, DSN);

                da.Fill(ds);
                string curTable = "";
                TreeNode tnCurTable = null;

                //fill the tree
                foreach (System.Data.DataRow row in ds.Tables[0].Rows)
                {
                    if (curTable != row["Table"].ToString())
                    {
                        curTable = row["Table"].ToString();
                        tnCurTable = treeTablePicker.Nodes.Add(curTable);

                        //build the XML for the table picker
                        if (xml.Length > 5) xml.Append("</table>" + Environment.NewLine);
                        xml.Append(string.Format("<table name=\"{0}\">" + Environment.NewLine, row["Table"]));
                    }

                    if (tnCurTable != null) tnCurTable.Nodes.Add(row["Column"].ToString());

                    //build the XML for the table picker
                    xml.Append(string.Format("\t<column spellcheck=\"false\" name=\"{0}\" />" + Environment.NewLine, row["Column"]));
                }
                //close the last table node
                if (xml.Length > 5) xml.Append("</table>" + Environment.NewLine);

                //allow the user to edit the xml
                //txtTablePicker.Text = xml.ToString();
            }
            catch (Exception ex)
            {


            }

            btnSpellCheck.Enabled = true;
        }

        private void btnSpellCheck_Click(object sender, EventArgs e)
        {
            TreeNode tbl = null;
            string SQL = "";
            string DSN = txtDbConn.Text;
            System.Data.OleDb.OleDbDataAdapter da = new System.Data.OleDb.OleDbDataAdapter(SQL, DSN);
            NetSpell.SpellChecker.Spelling spell = new NetSpell.SpellChecker.Spelling();
            spell.ShowDialog = false; //don't attempt to correct spelling errors right now

            dsResult = new DataSet();
            isLoading = true;

            //if using the tree
            if (tabTablePicker.SelectedIndex == 0)
            {
                try
                {
                    //count the selected ones
                    List<TreeNode> selectedColumns = GetSelectedNodes();
                    pbTable.Maximum = selectedColumns.Count;
                    pnlSpellCheckProgress.Visible = true;

                    dsResult.Clear();
                    for (int x = 0; x < selectedColumns.Count; x++)
                    {
                        //prep
                        tbl = selectedColumns[x].Parent;
                        //if there were results from last run, clear them
                        if (selectedColumns[x].Text.Contains(" (")) selectedColumns[x].Text = selectedColumns[x].Text.Substring(0, selectedColumns[x].Text.IndexOf(" ("));
                        string nameOfTd = string.Format("{0}.{1}", tbl.Text, selectedColumns[x].Text);

                        //init the feedback
                        lblProgressTable.Text = nameOfTd;
                        pbTable.Value = x;
                        lblTableXofY.Text = string.Format("{0} of {1}", x + 1, pbTable.Maximum);
                        pbRow.Value = 0;
                        pbRow.Maximum = 1;
                        lblRowXofY.Text = "Querying...";
                        Application.DoEvents();

                        //look up the data for this chosen table.column
                        SQL = string.Format("SELECT {0} FROM {1}", selectedColumns[x].Text, tbl.Text);
                        da.SelectCommand.CommandText = SQL;
                        da.Fill(dsResult, nameOfTd);

                        DataTable dt = dsResult.Tables[nameOfTd];
                        pbRow.Maximum = dt.Rows.Count;

                        //spell check each row
                        for (int y = dt.Rows.Count - 1; y > 0; y--)
                        {
                            pbRow.Value = pbRow.Maximum - y;
                            lblRowXofY.Text = string.Format("{0} of {1}", pbRow.Value, pbRow.Maximum);
                            Application.DoEvents();

                            //remove all rows that pass the spell check (so the user can review the bad rows)
                            if (!spell.SpellCheck(dt.Rows[y][0].ToString()))
                                dt.Rows.RemoveAt(y);
                        }
                        //update the name to show the spell-check fail count
                        selectedColumns[x].Text += " (" + dt.Rows.Count.ToString() + " bad rows)";
                    }
                }
                catch (Exception ex)
                {


                }
            }
            else //if using the XML
            {

            }
            pnlSpellCheckProgress.Visible = false;
            MessageBox.Show("Done");
            isLoading = false;

        }

        private void treeTablePicker_AfterSelect(object sender, TreeViewEventArgs e)
        {
            TreeNode picked = treeTablePicker.SelectedNode;
            //reset the screen
            lbxSpellingFlaws.DataSource = null;
            lblSelected.Text = "Table.Column (none selected)";
            string nameOfTd = "";
            string columnName = "";

            isLoading = true;
            //only attempt to bind AFTER a spell-check search has been run
            if (dsResult != null && picked != null && picked.Parent != null)
            {
                //if there were results from last run, clear them
                if (picked.Text.Contains(" ("))
                    columnName = picked.Text.Substring(0, picked.Text.IndexOf(" ("));
                else
                    columnName = picked.Text;

                nameOfTd = string.Format("{0}.{1}", picked.Parent.Text, columnName);
                lblSelected.Text = nameOfTd;

                if (dsResult.Tables.Contains(nameOfTd))
                {
                    DataTable dt = dsResult.Tables[nameOfTd];
                    lbxSpellingFlaws.DataSource = dt;
                    lbxSpellingFlaws.DisplayMember = columnName;
                }
            }
            isLoading = false;
        }

        private List<TreeNode> GetSelectedNodes()
        {
            List<TreeNode> selectedNodes = new List<TreeNode>();
            TreeNode tbl = null;

            //for each table
            for (int x = 0; x < treeTablePicker.Nodes.Count; x++)
            {
                tbl = treeTablePicker.Nodes[x];
                //check each column to find the selected ones
                for (int y = 0; y < tbl.Nodes.Count; y++)
                {
                    if (tbl.Nodes[y].Checked)
                    {
                        selectedNodes.Add(tbl.Nodes[y]);
                    }
                }
            }

            return selectedNodes;
        }

        private void lbxSpellingFlaws_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbxSpellingFlaws.SelectedItem != null)
            {
                NetSpell.SpellChecker.Spelling spell = new NetSpell.SpellChecker.Spelling();
                spell.ShowDialog = !isLoading; //don't attempt to correct spelling errors while loading
                DataRowView drv = (DataRowView)lbxSpellingFlaws.SelectedItem;
                spell.Text = drv.Row[0].ToString();

                spell.SpellCheck();
            }
        }

    }
}
