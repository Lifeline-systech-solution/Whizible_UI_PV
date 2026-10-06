Public Class IB_Dashboard
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_ToIssueList As String
    Protected m_PKToken_FromIssueList As String
    Public ViewApplied As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueDashboard", "Whizible2Resources")
        ''Added By Dipali V On 13th Aug 2019 For PK Token
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 5
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PKToken_FromIssueList = CommonFunctions.Security.Token.GetToken(objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String))
        m_PKToken_ToIssueList = objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String)
        If (((m_PKToken_FromIssueList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(m_PKToken_ToIssueList, m_PKToken_FromIssueList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
        ''End of Added By Dipali V On 13th Aug 2019 For PK Token
        ViewApplied = Trim(Request.QueryString("View") & "")
    End Sub

End Class