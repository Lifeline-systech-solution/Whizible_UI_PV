Public Class PM_IR_Related_Settings
    Inherits WebPages.Template.WhizTemplate

    Public m_PM_IRRelatedSettingsAddAccess As Boolean = False
    Public m_PM_IRRelatedSettingsDeleteAccess As Boolean = False
    Public m_PM_IRRelatedSettingsEditAccess As Boolean = False
    Public m_PM_IRRelatedSettingsViewAccess As Boolean = False

    Public m_PKToken_ToIRRelatedSettings As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePM_ConfigureApproversGlobalObject()
        ''Added by RehanC on 10th April 2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        ''End Of comment by RehanC on 10th April 2023
        'ProjectID = Convert.ToInt32(Session("intProjectID"))
        ProjectID = Request.QueryString("ProjectID")
        'm_PKToken_ToIRRelatedSettings = CommonFunctions.Security.Token.GetToken("3091" + ProjectID + CType(Session("intUserID"), String))

        m_PKToken_ToIRRelatedSettings = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ToIRRelatedSettings) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'If (((m_PKToken_ToIRRelatedSettings = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1263" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToIRRelatedSettings) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
    End Sub
    Public Sub CreatePM_ConfigureApproversGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3091

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_IRRelatedSettingsAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_IRRelatedSettingsDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_IRRelatedSettingsEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_IRRelatedSettingsViewAccess = objAccess.View 'If user has view Access

        If (m_PM_IRRelatedSettingsAddAccess = True Or m_PM_IRRelatedSettingsEditAccess = True Or m_PM_IRRelatedSettingsDeleteAccess = True) Then
            m_PM_IRRelatedSettingsViewAccess = True
        End If
    End Sub
End Class