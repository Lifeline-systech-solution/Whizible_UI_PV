Public Class PM_ProjecKernel
    Inherits WebPages.Template.WhizTemplate
    Public m_PM_ProjectKernelAddAccess As Boolean = False
    Public m_PM_ProjectKernelDeleteAccess As Boolean = False
    Public m_PM_ProjectKernelEditAccess As Boolean = False
    Public m_PM_ProjectKernelViewAccess As Boolean = False
    Public m_PKToken_ToProjectOS As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32
    Protected m_PKToken_ProjecKernel As String
    Public Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePM_ProjectClosureGlobalObject()
        m_PKToken_ProjecKernel = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjecKernel) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'ProjectID = Convert.ToInt32(Session("intProjectID"))
        'm_PKToken_ToProjectOS = CommonFunctions.Security.Token.GetToken("534" + ProjectID + CType(Session("intUserID"), String))

        'If (((m_PKToken_ToProjectOS = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("534" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToProjectOS) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
    End Sub
    Public Sub CreatePM_ProjectClosureGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 534

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectKernelAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectKernelDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectKernelEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectKernelViewAccess = objAccess.View 'If user has View Access


        If (m_PM_ProjectKernelAddAccess = True Or m_PM_ProjectKernelEditAccess = True Or m_PM_ProjectKernelDeleteAccess = True) Then
            m_PM_ProjectKernelViewAccess = True
        End If
    End Sub


End Class