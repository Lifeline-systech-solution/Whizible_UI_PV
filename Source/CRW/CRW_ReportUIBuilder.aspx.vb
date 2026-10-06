Public Class CRW_ReportUIBuilder
    Inherits System.Web.UI.Page
    Private m_blnValidate As Boolean = True
    Protected m_strPKToken As String
    Protected m_ReportID As String

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
        InitializeComponent()

        
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

        'm_strPKToken = Request.QueryString("PkToken").ToString
        'm_ReportID = Request.QueryString("ReportID").ToString

        'If (m_strPKToken = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        '    m_blnValidate = False
        'ElseIf (m_ReportID <> 0) Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_ReportID, String) + CType(Session("intUserID"), String) + "0" + "0", m_strPKToken) = False) Then
        '        m_blnValidate = False
        '    End If
        'End If
        'If (m_blnValidate = False) Then
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If


        'Put user code to initialize the page here

        ''Added  By Shamkant s 31/12/2015 For Security
        If Request.Browser.Browser <> "IE" And Request.Browser.Browser <> "InternetExplorer" Then
            If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
                Response.Write(vbCrLf + "<script>")
                Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
                If strRedirectToPage.Trim = "" Then
                    Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
                Else
                    Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
                End If
                Response.Write(vbCrLf + "</script>")
            End If
            'Ended By Shamkant s 31/12/2015
        End If
    End Sub

End Class
