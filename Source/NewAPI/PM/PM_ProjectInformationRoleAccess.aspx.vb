Public Class PM_ProjectInformationRoleAccess
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromPIRAList As String = ""
    Protected m_PKToken_ToPIRAList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnPIRAAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnPIRAEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnPIRADeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnPIRAViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ProjectInformationRoleAccess As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePIRAGlobalObject()
        m_PKToken_ProjectInformationRoleAccess = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectInformationRoleAccess) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Private Sub CreatePIRAGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3083

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnPIRAAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnPIRADeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnPIRAEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnPIRAViewAccess = objAccess.View 'If user has View Access

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromPIRAList = CommonFunctions.Security.Token.GetToken("3083" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromPIRAList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3083" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromPIRAList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnPIRAAddAccess = True Or m_blnPIRAEditAccess = True Or m_blnPIRADeleteAccess = True) Then
            m_blnPIRAViewAccess = True
        End If
    End Sub
End Class