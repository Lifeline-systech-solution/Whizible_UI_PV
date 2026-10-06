Public Class PM_TaskType
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'Delete access for the logged in user
    Protected m_PKToken_TaskType As String
    Protected m_PKToken_TaskTypeToken As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        CreateSubProjectGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_TaskType", "Whizible2Resources")
        m_PKToken_TaskTypeToken = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String))

        m_PKToken_TaskType = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_TaskType) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreateSubProjectGlobalObject()
        'Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 1027, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'objGlobal = MyBase.GlobalObject
        'objGlobal.TagID = 1027

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has View Access
        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
    End Sub

End Class