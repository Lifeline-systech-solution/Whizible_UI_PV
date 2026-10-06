Public Class Uploaddata
    Inherits CLCP_Attachment

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If HttpContext.Current.Request("FromWhere") = "PM" Then
            MyBase.strFormPage = "Project_UploadData_CommonPage.aspx"
        Else
            MyBase.strFormPage = "Config_UploadData_CommonPage.aspx"
        End If

        MyBase.strAttachmentPage = "Uploaddata.aspx"
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        If HttpContext.Current.Request("FromWhere") = "PM" Then
            Return New cProject_UploadData_CommonPageSubTagCLSQL(WhizGlobal)
        Else
            Return New cConfig_UploadData_CommonPageSubTagCLSQL(WhizGlobal)
        End If

    End Function
End Class
