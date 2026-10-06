Public Class PM_ProjectKeywords
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectKeyword", "Whizible2Resources")

        m_PKToken_ProjectKeywords = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectKeywords) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Protected m_LoginType As String 'Login Type
    Protected m_RoleId As Long 'RoleId
    Protected m_RoleLevel As Integer 'Role Level
    Protected m_UserId As Long 'UserId
    Protected m_UserName As String 'UserName
    Protected m_LoginID As String
    Protected m_CultureId As Long 'CultureId
    Protected m_ProjectId As Long   'ProjectId
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ProjectKeywords As String

    Private Sub CreateGlobalObject()

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 531
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel
        m_LoginID = objGlobal.LoginID
        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        If (m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True) Then
            m_blnViewAccess = True
        End If
        m_ProjectId = Session("intProjectID")
    End Sub
End Class