Public Class PM_ProjecOS
    Inherits WebPages.Template.WhizTemplate
    Public m_PM_ProjectOSAddAccess As Boolean = False
    Public m_PM_ProjectOSDeleteAccess As Boolean = False
    Public m_PM_ProjectOSEditAccess As Boolean = False
    Public m_PM_ProjectOSViewAccess As Boolean = False
    Public m_PKToken_ToProjectOS As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32
    Protected m_PKToken_ProjecOS As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePM_ProjectOSGlobalObject()
        m_PKToken_ProjecOS = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjecOS) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'ProjectID = Convert.ToInt32(Session("intProjectID"))
        'm_PKToken_ToProjectOS = CommonFunctions.Security.Token.GetToken("535" + ProjectID + CType(Session("intUserID"), String))

        'If (((m_PKToken_ToProjectOS = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("535" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToProjectOS) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
    End Sub
    Public Sub CreatePM_ProjectOSGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 535

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ProjectOSAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ProjectOSDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ProjectOSEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ProjectOSViewAccess = objAccess.View 'If user has View Access

        If (m_PM_ProjectOSAddAccess = True Or m_PM_ProjectOSEditAccess = True Or m_PM_ProjectOSDeleteAccess = True) Then
            m_PM_ProjectOSViewAccess = True
        End If

    End Sub

End Class