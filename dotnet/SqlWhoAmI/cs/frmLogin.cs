//using System.Configuration.ConfigurationSettings;
using System.Data;
using Microsoft.Data.SqlClient;

public class frmLogin : System.Windows.Forms.Form {

#region  Windows Form Designer generated code
    public frmLogin() {
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
    internal System.Windows.Forms.Label lblLogin;
    
    internal System.Windows.Forms.TextBox txtLogin;
    
    internal System.Windows.Forms.TextBox txtPassword;
    
    internal System.Windows.Forms.Label lblPassword;
    
    internal System.Windows.Forms.Button btnOk;
    
    internal System.Windows.Forms.Button btnCancel;
    
    internal System.Windows.Forms.CheckBox chkIntegratedSecurity;
    
    internal System.Windows.Forms.Label lblServer;
    
    internal System.Windows.Forms.TextBox txtServer;

    [System.Diagnostics.DebuggerStepThrough()]
    private void InitializeComponent()
    {
        lblLogin = new Label();
        txtLogin = new TextBox();
        txtPassword = new TextBox();
        lblPassword = new Label();
        btnOk = new Button();
        btnCancel = new Button();
        chkIntegratedSecurity = new CheckBox();
        lblServer = new Label();
        txtServer = new TextBox();
        SuspendLayout();
        // 
        // lblLogin
        // 
        lblLogin.Location = new Point(29, 20);
        lblLogin.Name = "lblLogin";
        lblLogin.Size = new Size(86, 28);
        lblLogin.TabIndex = 0;
        lblLogin.Text = "Login:";
        lblLogin.TextAlign = ContentAlignment.MiddleRight;
        // 
        // txtLogin
        // 
        txtLogin.Location = new Point(125, 20);
        txtLogin.MaxLength = 50;
        txtLogin.Name = "txtLogin";
        txtLogin.Size = new Size(153, 23);
        txtLogin.TabIndex = 1;
        // 
        // txtPassword
        // 
        txtPassword.Location = new Point(125, 49);
        txtPassword.MaxLength = 50;
        txtPassword.Name = "txtPassword";
        txtPassword.PasswordChar = '*';
        txtPassword.Size = new Size(153, 23);
        txtPassword.TabIndex = 2;
        // 
        // lblPassword
        // 
        lblPassword.Location = new Point(29, 49);
        lblPassword.Name = "lblPassword";
        lblPassword.Size = new Size(86, 29);
        lblPassword.TabIndex = 4;
        lblPassword.Text = "Password:";
        lblPassword.TextAlign = ContentAlignment.MiddleRight;
        // 
        // btnOk
        // 
        btnOk.Location = new Point(77, 138);
        btnOk.Name = "btnOk";
        btnOk.Size = new Size(90, 28);
        btnOk.TabIndex = 4;
        btnOk.Text = "OK";
        btnOk.Click += btnOk_Click;
        // 
        // btnCancel
        // 
        btnCancel.DialogResult = DialogResult.Cancel;
        btnCancel.Location = new Point(182, 138);
        btnCancel.Name = "btnCancel";
        btnCancel.Size = new Size(90, 28);
        btnCancel.TabIndex = 5;
        btnCancel.Text = "Cancel";
        btnCancel.Click += btnCancel_Click;
        // 
        // chkIntegratedSecurity
        // 
        chkIntegratedSecurity.Location = new Point(67, 79);
        chkIntegratedSecurity.Name = "chkIntegratedSecurity";
        chkIntegratedSecurity.Size = new Size(231, 19);
        chkIntegratedSecurity.TabIndex = 3;
        chkIntegratedSecurity.Text = "Use Integrated Network Security";
        chkIntegratedSecurity.CheckedChanged += chkIntegratedSecurity_CheckedChanged;
        // 
        // lblServer
        // 
        lblServer.Location = new Point(19, 98);
        lblServer.Name = "lblServer";
        lblServer.Size = new Size(96, 29);
        lblServer.TabIndex = 6;
        lblServer.Text = "Server:";
        lblServer.TextAlign = ContentAlignment.MiddleRight;
        // 
        // txtServer
        // 
        txtServer.Location = new Point(125, 98);
        txtServer.MaxLength = 50;
        txtServer.Name = "txtServer";
        txtServer.Size = new Size(153, 23);
        txtServer.TabIndex = 7;
        txtServer.Text = "(local)";
        // 
        // frmLogin
        // 
        AcceptButton = btnOk;
        AutoScaleBaseSize = new Size(6, 16);
        CancelButton = btnCancel;
        ClientSize = new Size(337, 174);
        ControlBox = false;
        Controls.Add(txtServer);
        Controls.Add(lblServer);
        Controls.Add(chkIntegratedSecurity);
        Controls.Add(btnCancel);
        Controls.Add(btnOk);
        Controls.Add(lblPassword);
        Controls.Add(txtPassword);
        Controls.Add(txtLogin);
        Controls.Add(lblLogin);
        FormBorderStyle = FormBorderStyle.FixedToolWindow;
        MaximizeBox = false;
        MinimizeBox = false;
        Name = "frmLogin";
        StartPosition = FormStartPosition.CenterScreen;
        Text = "Login";
        Load += frmLogin_Load;
        ResumeLayout(false);
        PerformLayout();
    }

    #endregion

    public event EventHandler SuccessfulLogin;
    
    private string _dsn;


    private void frmLogin_Load(object sender, System.EventArgs e) {
        if ((SqlWhoAmIcs.Properties.Settings.Default.IntegratedSecurity.ToLower() == "true")) {
            chkIntegratedSecurity.Checked = true;
        }        
    }
    
    private void frmLogin_Closing(object sender, System.ComponentModel.CancelEventArgs e) {
        if (chkIntegratedSecurity.Checked)
            SqlWhoAmIcs.Properties.Settings.Default.IntegratedSecurity = "true";
        else
            SqlWhoAmIcs.Properties.Settings.Default.IntegratedSecurity = "false";
        SqlWhoAmIcs.Properties.Settings.Default.Save();
    }
    
    private void chkIntegratedSecurity_CheckedChanged(object sender, System.EventArgs e) {
        if (chkIntegratedSecurity.Checked) {
            txtLogin.Enabled = false;
            txtPassword.Enabled = false;
        }
        else {
            txtLogin.Enabled = true;
            txtPassword.Enabled = true;
        }
        
    }
    
    private void btnOk_Click(object sender, System.EventArgs e) {
        SqlConnection cn;
        try {
            cn = new SqlConnection(this.DSN);
            cn.Open();
            cn.Close();
            cn.Dispose();
            cn = null;

            SuccessfulLogin?.Invoke(this, EventArgs.Empty);
            this.DialogResult = DialogResult.OK;
            this.Close();
        }
        catch (Exception ex) {
            MessageBox.Show(ex.Message);
        }
        
    }
    
    private void btnCancel_Click(object sender, System.EventArgs e) {
    }

    #region  Settings - Properties
    public string DSN {
        get {
            string strDSN;
            if (chkIntegratedSecurity.Checked) {
                strDSN = "Integrated Security=SSPI;Persist Security Info=False;Data Source=" + txtServer.Text
                    + ";TrustServerCertificate=True;";
            }
            else {
                // use the login/pw they provided
                strDSN = "Persist Security Info=False" 
                    + ";User ID=" + txtLogin.Text 
                    + ";Password=" + txtPassword.Text 
                    + ";Data Source=" + txtServer.Text
                    + ";TrustServerCertificate=True;";
            }
            
            return strDSN;
        }
    }
    #endregion
}