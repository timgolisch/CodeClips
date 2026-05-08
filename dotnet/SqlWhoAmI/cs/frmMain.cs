using Microsoft.Data.SqlClient;

public class frmMain : System.Windows.Forms.Form {
    private string DSN;

    #region  Windows Form Designer generated code

    public frmMain() {
        // This call is required by the Windows Form Designer.
        this.InitializeComponent();
        // Add any initialization after the InitializeComponent() call
    }
    
    // Form overrides dispose to clean up the component list.
    protected override void Dispose(bool disposing) {
        if (disposing) {
            if (!(components == null)) {
                components.Dispose();
            }
        }
        
        base.Dispose(disposing);
    }
    
    // Required by the Windows Form Designer
    private System.ComponentModel.IContainer components;
    
    // NOTE: The following procedure is required by the Windows Form Designer
    // It can be modified using the Windows Form Designer.  
    // Do not modify it using the code editor.
    internal System.Windows.Forms.Label Label1;
    
    internal System.Windows.Forms.Label Label2;
    
    internal System.Windows.Forms.Label Label3;
    
    internal System.Windows.Forms.Label Label4;
    
    internal System.Windows.Forms.Button btnDone;
    
    internal System.Windows.Forms.TextBox txtSUSER_NAME;
    
    internal System.Windows.Forms.TextBox txtSUSER_SNAME;
    
    internal System.Windows.Forms.TextBox txtUSER_NAME;
    
    internal System.Windows.Forms.TextBox txtUSER;

    [System.Diagnostics.DebuggerStepThrough()]
    private void InitializeComponent()
    {
        Label1 = new Label();
        Label2 = new Label();
        Label3 = new Label();
        Label4 = new Label();
        txtSUSER_NAME = new TextBox();
        txtSUSER_SNAME = new TextBox();
        txtUSER_NAME = new TextBox();
        txtUSER = new TextBox();
        btnDone = new Button();
        SuspendLayout();
        // 
        // Label1
        // 
        Label1.Location = new Point(19, 39);
        Label1.Name = "Label1";
        Label1.Size = new Size(120, 29);
        Label1.TabIndex = 0;
        Label1.Text = "SUSER_NAME";
        Label1.TextAlign = ContentAlignment.TopRight;
        // 
        // Label2
        // 
        Label2.Location = new Point(19, 69);
        Label2.Name = "Label2";
        Label2.Size = new Size(120, 28);
        Label2.TabIndex = 1;
        Label2.Text = "SUSER_SNAME";
        Label2.TextAlign = ContentAlignment.TopRight;
        // 
        // Label3
        // 
        Label3.Location = new Point(19, 98);
        Label3.Name = "Label3";
        Label3.Size = new Size(120, 29);
        Label3.TabIndex = 2;
        Label3.Text = "USER_NAME";
        Label3.TextAlign = ContentAlignment.TopRight;
        // 
        // Label4
        // 
        Label4.Location = new Point(19, 128);
        Label4.Name = "Label4";
        Label4.Size = new Size(120, 28);
        Label4.TabIndex = 3;
        Label4.Text = "USER";
        Label4.TextAlign = ContentAlignment.TopRight;
        // 
        // txtSUSER_NAME
        // 
        txtSUSER_NAME.Location = new Point(154, 39);
        txtSUSER_NAME.Name = "txtSUSER_NAME";
        txtSUSER_NAME.ReadOnly = true;
        txtSUSER_NAME.Size = new Size(240, 23);
        txtSUSER_NAME.TabIndex = 5;
        // 
        // txtSUSER_SNAME
        // 
        txtSUSER_SNAME.Location = new Point(154, 69);
        txtSUSER_SNAME.Name = "txtSUSER_SNAME";
        txtSUSER_SNAME.ReadOnly = true;
        txtSUSER_SNAME.Size = new Size(240, 23);
        txtSUSER_SNAME.TabIndex = 6;
        // 
        // txtUSER_NAME
        // 
        txtUSER_NAME.Location = new Point(154, 98);
        txtUSER_NAME.Name = "txtUSER_NAME";
        txtUSER_NAME.ReadOnly = true;
        txtUSER_NAME.Size = new Size(240, 23);
        txtUSER_NAME.TabIndex = 7;
        // 
        // txtUSER
        // 
        txtUSER.Location = new Point(154, 128);
        txtUSER.Name = "txtUSER";
        txtUSER.ReadOnly = true;
        txtUSER.Size = new Size(240, 23);
        txtUSER.TabIndex = 8;
        // 
        // btnDone
        // 
        btnDone.Location = new Point(163, 177);
        btnDone.Name = "btnDone";
        btnDone.Size = new Size(90, 29);
        btnDone.TabIndex = 10;
        btnDone.Text = "Done";
        btnDone.Click += btnDone_Click;
        // 
        // frmMain
        // 
        AutoScaleBaseSize = new Size(6, 16);
        ClientSize = new Size(426, 217);
        Controls.Add(btnDone);
        Controls.Add(txtUSER);
        Controls.Add(txtUSER_NAME);
        Controls.Add(txtSUSER_SNAME);
        Controls.Add(txtSUSER_NAME);
        Controls.Add(Label4);
        Controls.Add(Label3);
        Controls.Add(Label2);
        Controls.Add(Label1);
        Name = "frmMain";
        Text = "SQL Who Am I";
        Load += frmMain_Load;
        ResumeLayout(false);
        PerformLayout();
    }

    private string _strDSN;

    #endregion

    private void frmMain_Load(object sender, System.EventArgs e) {
        frmLogin login = new frmLogin();
        DialogResult re = login.ShowDialog();

        if (re == DialogResult.OK)
        {
            _strDSN = login.DSN;

            SqlConnection cn;
            SqlCommand cmd;
            SqlDataReader dr;
            string strSQL;
            byte[] sid;
            System.Text.Decoder byte2text;
            try
            {
                strSQL = "SELECT SUSER_NAME() AS SUSERNAME, SUSER_SNAME() AS SUSERSNAME, USER_NAME() AS USERNAME, " +
                "USER AS JustUser, SUSER_SID() AS SUSERSID";
                cn = new SqlConnection(_strDSN);
                cn.Open();
                cmd = cn.CreateCommand();
                cmd.CommandText = strSQL;
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtSUSER_NAME.Text = DBNotNull.DBNotNullStr(dr["SUSERNAME"]);
                    txtSUSER_SNAME.Text = DBNotNull.DBNotNullStr(dr["SUSERSNAME"]);
                    txtUSER_NAME.Text = DBNotNull.DBNotNullStr(dr["USERNAME"]);
                    txtUSER.Text = DBNotNull.DBNotNullStr(dr["JustUser"]);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error");
            }
        }        
    }
    
    private void btnDone_Click(object sender, System.EventArgs e) {
        this.Close();
    }
}