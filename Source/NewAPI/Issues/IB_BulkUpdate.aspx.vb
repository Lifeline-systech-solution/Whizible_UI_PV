Public Class BulkUpdate
    Inherits WebPage.Templates.WhizTemplate

    Protected m_PKToken_BulkUpdate As String
    Protected m_ProjectID As String
    Protected m_TagID As String
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Private m_blnUpdateLinkAccess As Boolean = True
    Protected m_PKToken_FromIssueList As String
    Protected m_PKToken_ToIssueList As String
    Protected ViewApplied As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim m_lngRoleID = CType(Session("intPostID"), Long)
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_UI_NodeAccess 5," + m_lngRoleID.ToString, MyBase.UseSQL)
        If dr.Read Then
            If CBool(dr("E")) = True Then
                m_blnUpdateLinkAccess = True
            Else
                m_blnUpdateLinkAccess = False
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        m_blnEditAccess = m_blnUpdateLinkAccess 'If user has Edit Access
        'm_blnEditAccess = False

        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 5
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")

        'm_PKToken_BulkUpdate = Trim(Request.QueryString("PKToken") & "")
        'm_ProjectID = Trim(Request.QueryString("ProjectID") & "")
        Session("IssueRole") = Request.QueryString("RoleId")

        'If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_ProjectID, String) + CType(m_TagID, String) + HttpContext.Current.Session("intUserID").ToString, m_PKToken_BulkUpdate) = False)) Then

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