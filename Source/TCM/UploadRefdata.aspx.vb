Public Class UploadRefdata
    Inherits CLCP_Attachment

    Protected m_strExtensionList As String
  

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If HttpContext.Current.Request("FromWhere") = "PM" Then
            If HttpContext.Current.Request("ParentTagID") = "3654" Then
                MyBase.strFormPage = "Test_Session_CommonPage.aspx"
            Else
                MyBase.strFormPage = "ProjectTestSet_CommonPage.aspx"
            End If
        Else
                MyBase.strFormPage = "TestSet_CommonPage.aspx"
            End If

        MyBase.strAttachmentPage = "UploadRefdata.aspx"

        'Added by ArchanaN on 1-Oct-2010
        If HttpContext.Current.Request("FromWhere") = "PM" Then
            If HttpContext.Current.Request("ParentTagID") = "3654" Then
                ' MyBase.strFormPage = "Test_Session_CommonPage.aspx"
                m_strExtensionList = CommonFunction.General.GetFileExtnListForTag("3654")
            Else
                'MyBase.strFormPage = "ProjectTestSet_CommonPage.aspx"
                m_strExtensionList = CommonFunction.General.GetFileExtnListForTag("3664")
            End If
        Else
            m_strExtensionList = CommonFunction.General.GetFileExtnListForTag("3186")
            'MyBase.strFormPage = "TestSet_CommonPage.aspx"
        End If

        'End of Added by ArchanaN on 1-Oct-2010
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        If HttpContext.Current.Request("FromWhere") = "PM" Then
            If HttpContext.Current.Request("ParentTagID") = "3654" Then
                Return New cTest_SessionSubTagCLSQL(WhizGlobal)
            Else
                Return New cProjectTestSetSubTagCLSQL(WhizGlobal)
            End If


        Else
            Return New cTestSetSubTagCLSQL(WhizGlobal)
        End If

    End Function

    Public Overrides Sub Before_Description_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Args.MaxLength = 50
    End Sub

End Class
