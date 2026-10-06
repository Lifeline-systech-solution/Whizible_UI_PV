Public Class HTMLEditor
    Inherits System.Web.UI.Page
    Protected WithEvents lnkBtnSet As System.Web.UI.WebControls.LinkButton
    Protected WithEvents Literal1 As System.Web.UI.WebControls.Literal
    Protected WithEvents txtHTML As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents FreeTextBox As FreeTextBoxControls.FreeTextBox
    Protected WithEvents txtHidden As System.Web.UI.HtmlControls.HtmlTextArea

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        If IsPostBack = True Then
            Dim strHTML As String = txtHTML.Value
            If strHTML.Trim <> "" Then
                If FreeTextBox.Text.Trim = "" Then FreeTextBox.Text = strHTML
            End If
        End If
    End Sub
    Private Sub lnkBtnSet_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lnkBtnSet.Click
        txtHidden.Value = FreeTextBox.Text
        Dim strjScript As String = "<script language=""javascript"">"
        'strjScript &= "document.getElementById('txtHidden').innerText='" & FormatString(FreeTextBox.Text) & "';"
        strjScript &= "window.opener.document.forms['" & _
        HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value =document.getElementById('txtHidden').value;"
        strjScript = strjScript & "window.close();"
        'FormatString(Replace(FreeTextBox.Text, vbCrLf, "")) & "';window.close();"
        strjScript = strjScript & "</script" & ">" 'Don't Ask, Tool Bug
        Literal1.Text = strjScript
    End Sub
    Public Sub PageLoad()

        If Request.Form.Get("txtHTML") = "" And Request.QueryString("Fire") & "" = "" Then
            Response.Write(vbCrLf & "<Script Language=JavaScript>")
            Response.Write(vbCrLf & "function window_onload()")
            Response.Write(vbCrLf & "{")
            Response.Write(vbCrLf & "document.getElementById('txtHTML').value=")
            Response.Write("window.opener.document.forms['" & _
            HttpContext.Current.Request.QueryString("formname") & "'].elements['" & HttpContext.Current.Request.QueryString("datefield") & "'].value;")
            Response.Write(vbCrLf & "frmHTMLEditor.action=" & Chr(34) & "HTMLEditor.aspx?Fire=Y&" & CommonFunction.General.GetQuerySrtingValues() & Chr(34) & ";")
            Response.Write(vbCrLf & "frmHTMLEditor.submit();")
            Response.Write(vbCrLf & "}")
            Response.Write(vbCrLf & "</SCRIPT>")
        Else
            Response.Write(vbCrLf & "<Script Language=JavaScript>")
            Response.Write(vbCrLf & "function window_onload()")
            Response.Write(vbCrLf & "{")
            Response.Write(vbCrLf & "}")
            Response.Write(vbCrLf & "</SCRIPT>")
        End If
    End Sub
End Class
