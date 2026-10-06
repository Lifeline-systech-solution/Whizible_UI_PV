Public Class PM_ProjectServiceSegmentation
    Inherits WebPages.Template.WhizTemplate

    Public m_PM_ProjectServiceSegmentationAddAccess As Boolean = False
    Public m_PM_ProjectServiceSegmentationDeleteAccess As Boolean = False
    Public m_PM_ProjectServiceSegmentationEditAccess As Boolean = False
    Public m_PM_ProjectServiceSegmentationViewAccess As Boolean = False
    Public m_PKToken_ToProjectServiceSegmentation As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32
    Protected m_PKToken_ProjectServiceSegmentation As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePM_ProjectServiceSegmentationGlobalObject()
        m_PKToken_ProjectServiceSegmentation = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectServiceSegmentation) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'ProjectID = Convert.ToInt32(Session("intProjectID"))
        'm_PKToken_ToProjectServiceSegmentation = CommonFunctions.Security.Token.GetToken("2118" + ProjectID + CType(Session("intUserID"), String))

        'If (((m_PKToken_ToProjectServiceSegmentation = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2118" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToProjectServiceSegmentation) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
    End Sub
    Public Sub CreatePM_ProjectServiceSegmentationGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2118

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectServiceSegmentationAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectServiceSegmentationDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectServiceSegmentationEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectServiceSegmentationViewAccess = objAccess.View 'If user has Edit Access
        If (m_PM_ProjectServiceSegmentationAddAccess = True Or m_PM_ProjectServiceSegmentationEditAccess = True Or m_PM_ProjectServiceSegmentationDeleteAccess = True) Then
            m_PM_ProjectServiceSegmentationViewAccess = True
        End If
    End Sub
End Class