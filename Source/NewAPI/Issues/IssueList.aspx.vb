Public Class IssueList
    'Inherits System.Web.UI.Page
    Inherits WebPage.Templates.WhizTemplate
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        CreateGlobalObject()
        'MyBase.InitializeResources("AppResources.RT_TimesheetApproval", "AppResources")
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")
        m_PKToken_FromIssueList = CommonFunctions.Security.Token.GetToken("5" + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String))
        If (((m_PKToken_FromIssueList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("5" + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String), m_PKToken_FromIssueList) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'Session("SFilter") = ""
        m_ViewApplied = Trim(Request.QueryString("View") & "")
    End Sub
    Protected m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Protected m_ProjectId As Long 'ProjectId
    Private m_UserId As Long 'UserId
    Private m_UserName As String 'UserName
    Private m_CultureId As Long 'CultureId
    Public m_PKToken_FromIssueList As String
    Protected m_PKToken_ToIssueList As String
    Protected m_IssueRoleId As String
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewApplied As String
    'Added By Dipali V On 25th Oct 2021 For Filter Persist
    Protected qid As String
    Protected stext As String
    Protected qtext As String
    Protected flist As String
    Protected forder As String
    Protected qname As String
    Protected qType As String
    Public globalclose As String
    Public SelectedEmployeeID As String
    'End of Added By Dipali V On 25th Oct 2021 For Filter Persist
    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 5
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel
        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID
        Dim strSQL As String
        Dim drProjectAccess As IDataReader
        Dim blnPrjExists As Boolean = False
        m_PKToken_FromIssueList = CommonFunctions.Security.Token.GetToken(objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String))
        If Not MyBase.GetFormValue("cboIssueProjects") Is Nothing Then
            If MyBase.GetFormValue("cboIssueProjects") <> "" Then
                m_ProjectId = CType(MyBase.GetFormValue("cboIssueProjects"), Integer)
            Else
                m_ProjectId = 0
            End If
            Session("IssueProject") = m_ProjectId
        ElseIf Not Session("IssueProject") Is Nothing And (HttpContext.Current.Request.QueryString("StartPage") Is Nothing Or Not HttpContext.Current.Request.QueryString("ApplyFilter") Is Nothing) Then
            m_ProjectId = CType(Session("IssueProject"), Long)
        Else
            If CType(Session("intRoleLevel"), Integer) = 3 Then
                'If CommonFunctions.Application.ShowEvenReleaseFromProject Then
                '    strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1"
                'Else
                '    strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1"
                'End If
                'drProjectAccess = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                'If CommonFunctions.General.CheckIsNothing(drProjectAccess) <> "" Then
                '    While (drProjectAccess.Read)
                '        If CType(drProjectAccess("ProjectID"), Long) = CType(Session("intProjectID"), Long) Then
                '            blnPrjExists = True
                '        End If
                '    End While
                'End If
                'CommonFunction.Data.DisposeDataReader(drProjectAccess)
                blnPrjExists = True
                If blnPrjExists = True Then
                    m_ProjectId = objGlobal.ProjectID
                    Session("IssueProject") = m_ProjectId
                Else
                    m_ProjectId = 0
                End If
            Else
                m_ProjectId = objGlobal.ProjectID
                Session("IssueProject") = m_ProjectId
            End If
        End If
        Dim intCorporateRoleLevel As Integer
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_roleId " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
            m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
            If m_RoleId <> 0 Then
                objGlobal.RoleID = m_RoleId
                Session("IssueRole") = m_RoleId
            End If
            m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            If m_RoleLevel <> 0 Then
                objGlobal.RoleLevel = m_RoleLevel
                Session("IssueRoleLevel") = m_RoleLevel
            End If
        End If
        m_IssueRoleId = m_RoleId
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)
        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        ''destroy global and AccessRights objects
        'objGlobal = Nothing
        'objAccess = Nothing
        m_PKToken_ToIssueList = objGlobal.TagID + CType(Session("IssueProject"), String) + CType(Session("intUserID"), String)
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function AssigntoSession(ByVal strSQL As String, ByVal DisplayMode As String, ByVal ViewID As String, ByVal ProjectID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strSQL = Utilities.Security.SecurityBuilder.CheckUserInput(strSQL, 2, True, False, False)
        DisplayMode = Utilities.Security.SecurityBuilder.CheckUserInput(DisplayMode, 2, True, False, False)
        ViewID = Utilities.Security.SecurityBuilder.CheckUserInput(ViewID, 2, True, False, False)
        ProjectID = Utilities.Security.SecurityBuilder.CheckUserInput(ProjectID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            HttpContext.Current.Session("IssueSQL") = strSQL
            HttpContext.Current.Session("MyIssueMode") = DisplayMode
            HttpContext.Current.Session("intViewID") = ViewID
            HttpContext.Current.Session("IssueProject") = ProjectID
            HttpContext.Current.Session("IssueSQLForExel2") = strSQL
            ''HttpContext.Current.Session("IssueRole") = m_RoleId
            Return ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Dipali V On 28th Oct 2021
    <System.Web.Services.WebMethod()>
    Public Shared Function clearsession(ByVal WhichFilter As String) As String
        '''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        'WhichFilter = Utilities.Security.SecurityBuilder.CheckUserInput(WhichFilter, 2, True, False, False)
        'Dim request = HttpContext.Current.Request
        'Dim response = HttpContext.Current.Response
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        '''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim Flag As String = "0"
            If WhichFilter = "SecondFilter" Then
                Flag = "1"
                HttpContext.Current.Session("SFilter") = ""
            ElseIf WhichFilter = "Load" Then
                HttpContext.Current.Session("QueryType") = ""
                HttpContext.Current.Session("QueryID") = ""
                HttpContext.Current.Session("EmployeeID") = ""
                HttpContext.Current.Session("SavedQueryName") = ""
                HttpContext.Current.Session("FFilter") = ""
                HttpContext.Current.Session("ViewTypeFilter") = ""
                HttpContext.Current.Session("SFilter") = ""
                'Added By Dipali V On 10th Nov 2021 For Clear Session Project 
                HttpContext.Current.Session("SelectedProjectID") = ""
                'End of Added By Dipali V On 10th Nov 2021 For Clear Session Project 
            Else
                Flag = "1"
                HttpContext.Current.Session("QueryType") = ""
                HttpContext.Current.Session("QueryID") = ""
                HttpContext.Current.Session("EmployeeID") = ""
                HttpContext.Current.Session("SavedQueryName") = ""
                HttpContext.Current.Session("FFilter") = ""
                'Added By Dipali V On 10th Nov 2021 For Clear Session Project 
                HttpContext.Current.Session("SelectedProjectID") = ""
                'End of Added By Dipali V On 10th Nov 2021 For Clear Session Project 
            End If
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        Try
            HttpContext.Current.Session("IssueProject") = ProjectID
            Dim m_PKToken As String
            m_PKToken = CommonFunctions.Security.Token.GetToken("5" + CType(HttpContext.Current.Session("IssueProject"), String) + CType(HttpContext.Current.Session("intUserID"), String))
            Return m_PKToken
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetProjectRole(ByVal ProjectID As String) As String
    '    HttpContext.Current.Session("IssueProject") = ProjectID
    '    Dim Result As String
    '    Dim strSQL As String
    '    strSQL = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_role " & CType(ProjectID, String), True), "0"), Long)
    '    Return Result
    'End Function
End Class