Imports Whiz

Public Class PM_IssueSeverity

    Inherits WebPages.Template.WhizTemplate
    Protected m_SubProjectblnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_SubProjectblnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_SubProjectblnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_SubProjectblnViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_IssueSeverity As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        CreateSubProjectGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_IssueSeverity", "Whizible2Resources")
        m_PKToken_IssueSeverity = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_IssueSeverity) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreateSubProjectGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 536

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_SubProjectblnAddAccess = objAccess.Add 'If user has AddNew Access
        m_SubProjectblnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_SubProjectblnEditAccess = objAccess.Edit 'If user has Edit Access
        m_SubProjectblnViewAccess = objAccess.View 'If user has View Access
        If (m_SubProjectblnAddAccess = True Or m_SubProjectblnEditAccess = True Or m_SubProjectblnDeleteAccess = True) Then
            m_SubProjectblnViewAccess = True
        End If
    End Sub

End Class