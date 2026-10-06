Public Class PM_ProjectList
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected m_LoginType As String 'Login Type
    Protected m_RoleId As Long 'RoleId
    Protected m_RoleLevel As Integer 'Role Level
    Protected m_UserId As Long 'UserId
    Protected m_UserName As String 'UserName
    Protected m_LoginID As String
    Protected m_CultureId As Long 'CultureId

    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectList", "Whizible2Resources")
    End Sub

    Private Sub CreateGlobalObject()

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 32
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
        m_blnDeleteAccess = objAccess.Delete 'If user has Delete Access
        m_blnViewAccess = objAccess.View 'If User has View Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        If (m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True) Then
            m_blnViewAccess = True
        End If
    End Sub
    ''Added By Usha Pandit For Validate Token 
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        Try
            Dim m_PKToken As String
            m_PKToken = CommonFunctions.Security.Token.GetToken(ProjectID + CType(HttpContext.Current.Session("intUserID"), String))

            Return m_PKToken
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SetSessionProject(ByVal ProjectID As String, ByVal ProjectName As String) As String
        '''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        'ProjectID = Utilities.Security.SecurityBuilder.CheckUserInput(ProjectID, 2, True, False, False)
        'ProjectName = Utilities.Security.SecurityBuilder.CheckUserInput(ProjectName, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        '''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            HttpContext.Current.Session("intProjectID") = ProjectID
            HttpContext.Current.Session("strProjectName") = ProjectName
            Return ProjectID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End Of Added By Usha Pandit For Validate Token 
End Class