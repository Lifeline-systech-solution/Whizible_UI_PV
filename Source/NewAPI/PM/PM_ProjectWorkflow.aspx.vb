Public Class PM_ProjectWorkflow
    Inherits WebPages.Template.WhizTemplate
    Protected m_PM_ProjectWorkFlowblnAddAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowblnDeleteAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowblnEditAccess As Boolean = False
    Protected m_PM_ProjectWorkFlowblnViewAccess As Boolean = False
    Protected m_ProjectID As String = ""
    Protected m_PKToken_ProjectWorkflow As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        CreatePM_ProjectWorkFlowGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectWorkflow", "Whizible2Resources")
        m_ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        m_PKToken_ProjectWorkflow = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectWorkflow) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreatePM_ProjectWorkFlowGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3934

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectWorkFlowblnAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectWorkFlowblnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectWorkFlowblnEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectWorkFlowblnViewAccess = objAccess.View 'If user has View Access

        If (m_PM_ProjectWorkFlowblnAddAccess = True And m_PM_ProjectWorkFlowblnEditAccess = True) Then
            If (m_PM_ProjectWorkFlowblnViewAccess = False) Then
                m_PM_ProjectWorkFlowblnViewAccess = True
            Else
                m_PM_ProjectWorkFlowblnViewAccess = True
            End If

        Else
            If (m_PM_ProjectWorkFlowblnViewAccess = False) Then
                m_PM_ProjectWorkFlowblnViewAccess = False
            Else
                m_PM_ProjectWorkFlowblnViewAccess = True
            End If
        End If
        If (m_PM_ProjectWorkFlowblnAddAccess = True Or m_PM_ProjectWorkFlowblnEditAccess = True Or m_PM_ProjectWorkFlowblnDeleteAccess = True) Then
            m_PM_ProjectWorkFlowblnViewAccess = True
        End If
    End Sub
End Class