using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlTypes;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using XpathQueryAnalyser.Properties;

namespace XpathQueryAnalyser
{
    public partial class frmXPath : Form
    {
        const string cAPPNAME = "XPathQueryAnalyser";

        const string cFILE = "lastxml.xml";

        private string _strFile = null;

        #region Form Events
        public frmXPath()
        {
            InitializeComponent();
        }

        private void Form_Load(object sender, System.EventArgs e)
        {
            try
            {
                _strFile = GetSetting("XmlFile", System.IO.Path.Combine(System.IO.Directory.GetCurrentDirectory(), cFILE));
                txtXML.Text = System.IO.File.ReadAllText(_strFile);

                // choose which formatting to use
                switch (GetSetting("Format", "None"))
                {
                    case "Formatted":
                        this.mnuFormatFormatted_Click(sender, e);
                        break;
                    case "Raw":
                        this.mnuFormatRaw_Click(sender, e);
                        break;
                    case "Html":
                        this.mnuFormatRaw_Click(sender, e);
                        break;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error while Loading settings");
            }

            txtXPath.Text = GetSetting("LastQuery", "");
            txtResult.Text = "";
            this.Height = GetSetting("Height", this.Height);
            this.Width = GetSetting("Width", this.Width);
            this.Left = GetSetting("Left", this.Left);
            this.Top = GetSetting("Top", this.Top);
        }

        private void frmXPath_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                string filename = System.IO.Path.Combine(System.IO.Directory.GetCurrentDirectory(), cFILE);
                System.IO.File.WriteAllText(filename, txtXML.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error while saving settings");
            }

            Properties.Settings.Default.XmlFile = _strFile;
            Properties.Settings.Default.LastQuery = txtXPath.Text;
            // if the window is not maximized or minimized, save its location & size
            if ((this.WindowState == FormWindowState.Normal))
            {
                Properties.Settings.Default.Height = this.Height;
                Properties.Settings.Default.Width = this.Width;
                Properties.Settings.Default.Left = this.Left;
                Properties.Settings.Default.Top = this.Top;
            }

            if (mnuFormatFormatted.Checked)
            {
                Properties.Settings.Default.Format = "Formatted";
            }
            else if (mnuFormatRaw.Checked)
            {
                Properties.Settings.Default.Format = "Raw";
            }
            else if (mnuFormatHtml.Checked)
            {
                Properties.Settings.Default.Format = "Html";
            }
            else
            {
                Properties.Settings.Default.Format = "None";
            }
            Properties.Settings.Default.Save();
        }

        private void btnRun_Click(object sender, System.EventArgs e)
        {
            System.Xml.XmlDocument objDocIn;
            System.Xml.XmlDocument objDocOut;
            System.Xml.XmlNodeList objNodes;
            int x;
            System.Xml.XPath.XPathDocument objXPath;
            System.IO.StringReader objTR;
            System.Xml.XmlTextReader objXR;
            System.Text.StringBuilder strOut = new System.Text.StringBuilder();
            object objTemp;
            System.Xml.XPath.XPathNodeIterator objIterator;
            try
            {
                objTR = new System.IO.StringReader(txtXML.Text);
                objXR = new System.Xml.XmlTextReader(objTR);
                objXPath = new System.Xml.XPath.XPathDocument(objXR);
                objXR = null;
                objTR = null;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error loading the XML");
                lblResultType.Text = "(no result)";
                return;
            }

            try
            {
                objTemp = objXPath.CreateNavigator().Evaluate(txtXPath.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error processing the XPath query");
                lblResultType.Text = "(no result)";
                return;
            }

            try
            {
                switch (objTemp.GetType().Name)
                {
                    case "XPathSelectionIterator":
                        objDocIn = new System.Xml.XmlDocument();
                        objDocIn.LoadXml(txtXML.Text);
                        objNodes = objDocIn.SelectNodes(txtXPath.Text);

                        objDocOut = new System.Xml.XmlDocument();
                        objDocOut.LoadXml(txtXML.Text);
                        objDocOut.RemoveAll();

                        lblResultType.Text = "(xml)";
                        for (x = 0; (x
                                    <= (objNodes.Count - 1)); x++)
                        {
                            strOut.Append((objNodes[x].OuterXml + "\r\n"));
                        }

                        break;
                    case "String":
                        lblResultType.Text = "(string)";
                        strOut.Append(objTemp);
                        break;
                    case "Number":
                    case "Double":
                    case "Boolean":
                        lblResultType.Text = "(Number)";
                        strOut.Append(objTemp.ToString);
                        break;
                    default:
                        lblResultType.Text = ("(" + objTemp.GetType().ToString() + ")");
                        MessageBox.Show(("No handler for result set of \""
                                        + (objTemp.GetType().ToString() + "\"")));
                        break;
                }
                txtResult.Text = strOut.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error displaying the XML");
                lblResultType.Text = "(no result)";
                return;
            }

        }
        #endregion

        private void txtXML_TextChanged(object sender, System.EventArgs e)
        {
        }

        private void txtXML_KeyUp(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            // ctrl-A highlights "all" (like in Notepad)
            if ((e.Control
                        && (!e.Shift
                        && (!e.Alt
                        && (e.KeyCode == Keys.A)))))
            {
                txtXML.SelectAll();
            }
            else if ((e.Control
                        && (e.KeyCode == Keys.V)))
            {
                // if they pressed ctrl-v, they just pasted, go ahead and format the content for them
                if (mnuFormatFormatted.Checked)
                {
                    this.mnuFormatRaw_Click(sender, e);
                    this.mnuFormatFormatted_Click(sender, e);
                }
                else if (mnuFormatRaw.Checked)
                {
                    this.mnuFormatRaw_Click(sender, e);
                }
            }
        }

        #region Menu 
        private void mnuFileSaveAs_Click(object sender, System.EventArgs e)
        {
            // disabled for now
        }

        private void mnuFileSave_Click(object sender, System.EventArgs e)
        {
            // disabled for now
        }

        private void mnuFileOpen_Click(object sender, System.EventArgs e)
        {
            string strFileName;
            strFileName = _strFile;
            ofdXml.Filter = "*.xml";
            ofdXml.FileName = strFileName;
            ofdXml.ShowDialog();
            strFileName = ofdXml.FileName;
            Properties.Settings.Default.XmlFile = strFileName;
            Properties.Settings.Default.Save();
            txtXML.Text = ReadXml(strFileName);
        }

        private void mnuFileExit_Click(object sender, System.EventArgs e)
        {
            this.Close();
        }

        private void mnuFormatRaw_Click(object sender, System.EventArgs e)
        {
            string strTemp;
            // remove line breaks, tabs and spaces (unless the text is part of an element or attribute
            strTemp = txtXML.Text.Replace("\r\n", "").Replace("\t", "");
            while ((strTemp.IndexOf("> ") > 0))
            {
                strTemp = strTemp.Replace("> ", ">");
            }

            txtXML.Text = strTemp;
            mnuFormatFormatted.Checked = false;
            mnuFormatHtml.Checked = false;
            mnuFormatRaw.Checked = true;
        }

        private void mnuFormatFormatted_Click(object sender, System.EventArgs e)
        {
            txtXML.Text = this.FormatXml(txtXML.Text);
            mnuFormatFormatted.Checked = true;
            mnuFormatHtml.Checked = false;
            mnuFormatRaw.Checked = false;
        }

        private void mnuFormatHtml_Click(object sender, System.EventArgs e)
        {
            mnuFormatFormatted.Checked = false;
            mnuFormatHtml.Checked = true;
            mnuFormatRaw.Checked = false;
        }

        private void mnuHelpOnlineHelp_Click(object sender, System.EventArgs e)
        {
            try
            {
                ProcessStartInfo startInfo = new ProcessStartInfo("http://www.w3.org/TR/xpath");
                Process.Start(startInfo);
            }
            catch //if launching the browser fails, just give a good URL for the user to try
            {
                MessageBox.Show("Open your browser to http://www.w3.org/TR/xpath");
            }

        }

        private void mnuHelpSuggestion_Click(object sender, System.EventArgs e)
        {
            bool bolIsNamespace = false;
            System.Xml.XmlDocument xmlContent;
            string strXpath;
            string[] arrTemp;
            // there are lots of suggestions to give 
            // start by analysing the xml and their current query
            try
            {
                xmlContent = new System.Xml.XmlDocument();
                xmlContent.LoadXml(txtXML.Text);
                strXpath = txtXPath.Text;
                if (xmlContent.FirstChild.Name == "xml" && xmlContent.ChildNodes.Count > 1)
                {
                    bolIsNamespace = (xmlContent.ChildNodes[1].NamespaceURI != "");
                }
                else if (xmlContent.FirstChild.NamespaceURI != "")
                {
                    bolIsNamespace = true;
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Invalid XML");
                return;
            }

            // start off simple
            // if their query is kinda deep, recommend that they start out shallow
            arrTemp = strXpath.Split("/");
            if ((((arrTemp.Length > 1)
                        && (arrTemp[0] != ""))
                        || (arrTemp.Length > 2)))
            {
                MessageBox.Show("You may be starting off with a rather complicated XPath query.  Try starting with something more " +
                    "simple and work up to something more complicated.");
            }

            // start with one of the following:  /  or // or //*
            if ((arrTemp.Length < 2))
            {
                MessageBox.Show("You may want to start your query with a \"/*\" or a \"//*\".  This tells it to start from the root of the" +
                    " XML");
            }
            else if (!(strXpath.StartsWith("/*") || strXpath.StartsWith("//*")))
            {
                MessageBox.Show("Your query may need to find multiple results.  Try starting your query with \"//*\" before you use the " +
                    "name of the node you want.");
            }
            else
            {
                MessageBox.Show("Your query may need to search deeper for the node you need.  " +
                    "Try starting your query with \"//*\" before you use the name of the node you want.");
            }

            // maybe consider doing the whole "/*[local-name()='###']"  thing
            if ((bolIsNamespace
                        && (((strXpath.IndexOf("local-name()") + 1) < 1)
                        || ((strXpath.IndexOf("local-name()") + 1) > 6))))
            {
                MessageBox.Show("Your XML seems to be using a namespace.  Normally, to find xml elements when there is a namespace, you" +
                    " need to use \"[local-name()=\'nodename\']\" (where nodename is the name of the node that you are trying" +
                    " to find)");
            }

        }
        private void mnuHelpExample_Click(object sender, System.EventArgs e)
        {
            bool bolIsNamespace = false;
            System.Xml.XmlDocument xmlContent;
            string strXpath;
            string[] arrTemp;
            // there are lots of examples to give 
            // start by analysing the xml and their current query
            try
            {
                xmlContent = new System.Xml.XmlDocument();
                xmlContent.LoadXml(txtXML.Text);
                strXpath = txtXPath.Text;
                if (xmlContent.FirstChild.Name == "xml" && xmlContent.ChildNodes.Count > 1)
                {
                    bolIsNamespace = (xmlContent.ChildNodes[1].NamespaceURI != "");
                }
                else if (xmlContent.FirstChild.NamespaceURI != "")
                {
                    bolIsNamespace = true;
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Invalid XML");
                return;
            }

            string nodename = InputBoxDialog.InputBox("Example: Node Name", "Input the name of a node that you would like to query");

            // maybe consider doing the whole "/*[local-name()='###']"  thing
            if ((bolIsNamespace
                        && (((strXpath.IndexOf("local-name()") + 1) < 1)
                        || ((strXpath.IndexOf("local-name()") + 1) > 6))))
                txtXPath.Text = $"//*[local-name()=\'{nodename}\']";
            else
                txtXPath.Text = $"//*/{nodename}";

        }
        #endregion

        #region Helper Functions
        private string FormatXml(string strIn)
        {
            string strOut;
            string[] strFile;
            int x;
            int intIndent = 0;
            List<int> intContentSize = new List<int>();

            // start off pretty simply
            strOut = strIn.Replace("><", (">" + ("\r\n" + "<")));
            // then look for lines to indent
            strFile = strOut.Split("\r\n");
            for (x = 0; x <= (strFile.Length - 1); x++)
            {
                if (strFile[x].StartsWith("<?"))
                {
                    // if it is the <?xml...?> tag then ignore it..don't increase indent
                    strFile[x] = (RepeatStr('\t', intIndent) + strFile[x].Trim());
                }
                else if (((strFile[x].IndexOf("/>") + 1) > 1))
                {
                    // if it is a <tag/> then it is singular..don't increase indent
                    strFile[x] = (RepeatStr('\t', intIndent) + strFile[x].Trim());
                    intContentSize[intIndent]++;
                    if ((intIndent > 0))
                    {
                        intContentSize[(intIndent - 1)]++;
                    }
                    else if (strFile[x].Trim().StartsWith("</"))
                    {
                        if ((intContentSize[intIndent] == 0))
                        {
                            // if the content count is 0, there is no content, so we should pull the end tag onto the same line as the opening tag
                            intIndent--;
                            strFile[x].Trim();
                            strFile[x] = "";
                        }
                        else
                        {
                            // this is a closing tag...unindent
                            intIndent--;
                            strFile[x] = (RepeatStr('\t', intIndent) + strFile[x].Trim());
                        }

                    }
                    else if (((strFile[x].IndexOf("</") + 1) > 0))
                    {
                        // this line contains its own closing tag...no changes to indent
                        strFile[x] = (RepeatStr('\t', intIndent) + strFile[x].Trim());
                        intContentSize[intIndent]++;
                    }
                    else
                    {
                        // just a begin tag
                        strFile[x] = (RepeatStr('\t', intIndent) + strFile[x].Trim());
                        intContentSize[intIndent]++;
                        // indent its contents
                        intIndent++;
                        if (intIndent > intContentSize.Count) intContentSize.Add(0);

                        // reset the content count at this indent level
                        intContentSize[intIndent] = 0;
                        if ((intIndent > 0))
                        {
                            intContentSize[(intIndent - 1)]++;
                        }

                        strOut = String.Join("\r\n", strFile);
                        // remove blank lines
                        while ((strOut.IndexOf(("\r\n\r\n")) > 0))
                        {
                            strOut = strOut.Replace(("\r\n\r\n"), "\r\n");
                        }
                    }
                }
            }
            return strOut;
        }

        private string RepeatStr(char str, int repeat)
        {
            return new string(str, repeat);
        }

        private string RepeatStr(string str, int repeat)
        {
            StringBuilder re = new StringBuilder();
            re.Insert(0, str, repeat);
            return re.ToString();
        }

        private string ReadXml(string strFile)
        {
            System.Xml.XmlDocument objXml = new System.Xml.XmlDocument();
            string re = string.Empty;
            try
            {
                objXml.Load(strFile);
                re = objXml.OuterXml;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error while reading xml file");
            }
            return re;
        }

        private void SaveXml(string strXml, string strFile)
        {
            System.IO.StreamWriter objFileOut;
            try
            {
                objFileOut = new System.IO.StreamWriter(strFile);
                objFileOut.Write(strXml);
                objFileOut.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error while saving settings");
            }
        }

        private string GetSetting(string settingName, string defaultValue)
        {
            if (Properties.Settings.Default.PropertyValues[settingName] != null)
                return Properties.Settings.Default.PropertyValues[settingName].ToString();
            else
                return defaultValue;
        }
        private int GetSetting(string settingName, int defaultValue)
        {
            if (Properties.Settings.Default.PropertyValues[settingName] != null)
                try
                {
                    return int.Parse(Properties.Settings.Default.PropertyValues[settingName].ToString());
                }
                catch (Exception e)
                {
                    MessageBox.Show($"Error Looking Up Setting [{settingName}],", e.Message);
                    return default;
                }

            else
                return defaultValue;
        }
        #endregion

    }
}
