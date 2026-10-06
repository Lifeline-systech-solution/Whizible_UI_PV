Public Class CreateNewIssue
    Inherits WebPage.Templates.WhizTemplate

    Public Sub New()

        MyBase.ApplySecurity(True)


        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")

    End Sub


    Public UserName As String
    Public m_PKToken_CopyIssue As String
    Public RoleId As String
    Protected IssueRoleId As String
    Public ProjectId As String
    Public parameter As String
    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public ViewApplied As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim m_objGlobal As WebPages.Template.IGlobal

        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights


        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 5, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access



        m_PKToken_CopyIssue = Trim(Request.QueryString("PKToken") & "")
        UserName = Trim(Request.QueryString("UserName") & "")
        RoleId = Trim(Request.QueryString("RoleId") & "")
        IssueRoleId = RoleId
        Session("IssueRole") = Trim(Request.QueryString("RoleId") & "")
        ProjectId = Trim(Request.QueryString("ProjectId") & "")
        ViewApplied = Trim(Request.QueryString("View") & "")
        parameter = UserName + RoleId + ProjectId
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(parameter, m_PKToken_CopyIssue) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
    End Sub

End Class