using System.Windows.Forms;
using System.Drawing;

public class InputBoxDialog
{
    private class InputBoxForm : Form
    {
        public Label label = new Label();
        public TextBox textBox = new TextBox();
        public Button buttonOk = new Button();
        public Button buttonCancel = new Button();
    }

    private static InputBoxForm SetupForm(string title, string promptText, string inputText)
    {
        InputBoxForm form = new InputBoxForm();
        form.Text = title;
        form.label.Text = promptText;
        form.textBox.Text = inputText;

        form.buttonOk.Text = "OK";
        form.buttonCancel.Text = "Cancel";
        form.buttonOk.DialogResult = DialogResult.OK;
        form.buttonCancel.DialogResult = DialogResult.Cancel;

        form.label.SetBounds(9, 20, 372, 13);
        form.textBox.SetBounds(12, 36, 372, 20);
        form.buttonOk.SetBounds(228, 72, 75, 23);
        form.buttonCancel.SetBounds(309, 72, 75, 23);

        form.label.AutoSize = true;
        form.textBox.Anchor = form.textBox.Anchor | AnchorStyles.Right;
        form.buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
        form.buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;

        form.ClientSize = new Size(396, 107);
        form.Controls.AddRange(new Control[] { form.label, form.textBox, form.buttonOk, form.buttonCancel });
        form.ClientSize = new Size(System.Math.Max(300, form.label.Right + 10), form.ClientSize.Height);
        form.FormBorderStyle = FormBorderStyle.FixedDialog;
        form.StartPosition = FormStartPosition.CenterScreen;
        form.MinimizeBox = false;
        form.MaximizeBox = false;
        form.AcceptButton = form.buttonOk;
        form.CancelButton = form.buttonCancel;

        return form;
    }

    public static DialogResult InputBox(string title, string promptText, ref string value)
    {
        InputBoxForm form = SetupForm(title, promptText, value);
        DialogResult dialogResult = form.ShowDialog();
        value = form.textBox.Text;
        return dialogResult;
    }

    public static string InputBox(string title, string promptText) { return InputBox(title, promptText, ""); }
    public static string InputBox(string title, string promptText, string value)
    {
        InputBoxForm form = SetupForm(title, promptText, value);
        DialogResult dialogResult = form.ShowDialog();
        value = form.textBox.Text;

        if (dialogResult == DialogResult.OK)
            return value;
        else
            return null;
    }

}