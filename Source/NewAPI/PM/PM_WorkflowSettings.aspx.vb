Public Class PM_WorkflowSettings
    Inherits WebPages.Template.WhizTemplate
    Protected m_PM_ProjectWorkFlowSettingblnAddAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowSettingblnDeleteAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowSettingblnEditAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowSettingblnViewAccess As Boolean = False
    Protected m_ProjectID As String = ""
    Protected m_PKToken_WorkflowSettings As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        CreatePM_ProjectWorkFlowSettingGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_WorkflowSettings", "Whizible2Resources")
        m_ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        m_PKToken_WorkflowSettings = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_WorkflowSettings) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreatePM_ProjectWorkFlowSettingGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3933

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectWorkFlowSettingblnAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectWorkFlowSettingblnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectWorkFlowSettingblnEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectWorkFlowSettingblnViewAccess = objAccess.View 'If user has View Access

        If (m_PM_ProjectWorkFlowSettingblnAddAccess = True And m_PM_ProjectWorkFlowSettingblnEditAccess = True) Then
            If (m_PM_ProjectWorkFlowSettingblnViewAccess = False) Then
                m_PM_ProjectWorkFlowSettingblnViewAccess = True
            Else
                m_PM_ProjectWorkFlowSettingblnViewAccess = True
            End If

        Else
            If (m_PM_ProjectWorkFlowSettingblnViewAccess = False) Then
                m_PM_ProjectWorkFlowSettingblnViewAccess = False
            Else
                m_PM_ProjectWorkFlowSettingblnViewAccess = True
            End If
        End If
        If (m_PM_ProjectWorkFlowSettingblnAddAccess = True Or m_PM_ProjectWorkFlowSettingblnEditAccess = True Or m_PM_ProjectWorkFlowSettingblnDeleteAccess = True) Then
            m_PM_ProjectWorkFlowSettingblnViewAccess = True
        End If
    End Sub
End Class