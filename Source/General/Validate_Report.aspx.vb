Public Class Validate_Report
    Inherits WebPages.Template.WhizTemplate

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




    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        Dim m_strReportID As String
        Dim m_strUniqueID As String
        Dim m_strUserID As String
        Dim m_strTagID As String
        Dim m_strParentTagID As String
        Dim m_strTokenID As String

        ' Getting all the values fromt the query string
        m_strReportID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReportID"), "0"), String)
        m_strUniqueID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "0"), String)
        m_strUserID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserID"), "0"), String)
        m_strTagID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"), "0"), String)
        m_strParentTagID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentTagID"), "0"), String)
        m_strTokenID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PKToken"), "0"), String)

        validateReportToken(m_strUniqueID, m_strUserID, m_strParentTagID, m_strTagID, m_strTokenID, m_strReportID)


    End Sub

    '-------------------------------------------------------------------
    '   Function Name       :   validateReportToken
    '   Purpose             :   To validate the token id and redirecting the URL 
    '                           depending upon the token validation
    '                           1. If token is valid then redirecting to the report page
    '                           2. Else redirecting to the invalid access page
    '   Author              :   SwapnilR
    '   Created Date        :   25th Sept 2006
    '   Input parameters    :   PrimaryKey
    '                           UserID
    '                           ParentTagID
    '                           TagID
    '                           TokenID
    '                           ReportID
    '   Output parameter    :   None.
    '------------------------------------------------------------------
    Public Sub validateReportToken(ByVal m_strUniqueID As String, ByVal m_strUserID As String, _
                        ByVal m_strParentTagID As String, ByVal m_strTagID As String, ByVal m_strTokenID As String, _
                        ByVal m_strReportID As String)

        ' If UserID is not coming through query string
        ' Then UserID in the session will be taken for the processing
        If m_strUserID = "0" Then
            m_strUserID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0"), String)
        End If

        If CommonFunctions.Security.Token.ValidateToken(m_strUniqueID + m_strUserID + m_strParentTagID + m_strTagID, m_strTokenID) = False Then
            ' If token is not validated then displaying the invalid access page
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Review Report", CType(m_strTagID, Long), CType(m_strParentTagID, Long), "PrimaryKey", m_strUniqueID)
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        Else
            ' Else displaying normal report page
            System.Web.HttpContext.Current.Response.Redirect("../CRW/CRW_ReportUIBuilder.aspx?ReportID=" + m_strReportID + "&UniqueID=" + m_strUniqueID + "&MasterTagID=" + m_strTagID)
        End If

    End Sub


End Class
