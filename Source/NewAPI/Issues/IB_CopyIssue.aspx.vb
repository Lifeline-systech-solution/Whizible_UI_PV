Public Class IB_CopyIssue
    Inherits WebPage.Templates.WhizTemplate
#Region " Constants Used in the Class "

    Protected m_PKToken_CopyIssue As String
    Protected m_ProjectID As String
    Protected m_TagID As String
    Protected m_PKToken_ToIssueList As String
    Protected m_PKToken_FromIssueList As String
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected ViewApplied As String


#End Region

    Public Sub New()
        ' Initialize caption resource file 
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")
        'CreateGlobalObject()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim UserName As String = Session("strUserName").ToString()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 5
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)
        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access



        'm_PKToken_CopyIssue = Trim(Request.QueryString("PKToken") & "")
        'm_ProjectID = Trim(Request.QueryString("ProjectID") & "")
        Session("IssueRole") = Trim(Request.QueryString("RoleId") & "")

        'If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_ProjectID, String) + CType(m_TagID, String) + HttpContext.Current.Session("intUserID").ToString, m_PKToken_CopyIssue) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        m_PKToken_FromIssueList = CommonFunctions.Security.Token.GetToken(objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String))
        m_PKToken_ToIssueList = objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String)
        If (((m_PKToken_FromIssueList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(m_PKToken_ToIssueList, m_PKToken_FromIssueList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
        ViewApplied = Trim(Request.QueryString("View") & "")
    End Sub

End Class


