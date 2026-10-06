Public Class PM_Risks
    Inherits WebPage.Templates.WhizTemplate

    Protected m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Protected m_ProjectId As Long 'ProjectId
    Private m_UserId As Long 'UserId
    Private m_UserName As String 'UserName
    Private m_CultureId As Long 'CultureId
    Public m_TagId As Long 'Tagid
    Dim m_objAccess As WebPage.Templates.AccessRights
    Public m_PKToken_PMRisks As String

    Public ProjectID As String
    Public UserID As String

    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?

    Protected m_ViewApplied As String
    Protected strProjectId As String
    Protected selProjectId As Long



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim UserName As String = Session("strUserName").ToString()
        m_TagId = 1018
        strProjectId = Trim(Request.QueryString("ProjectID") & "")
        If ((strProjectId Is Nothing Or strProjectId = "")) Then
            selProjectId = 0
        Else
            selProjectId = CType(strProjectId, Long)
        End If

        If Not selProjectId = 0 Then
            m_ProjectId = selProjectId
        End If

        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Risks", "Whizible2Resources")
        m_PKToken_PMRisks = CommonFunctions.Security.Token.GetToken("1018" + CType(Session("RiskProject"), String) + CType(Session("intUserID"), String))

        m_ViewApplied = Trim(Request.QueryString("View") & "")
    End Sub

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1018
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel

        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID

        Dim blnPrjExists As Boolean = False

        m_PKToken_PMRisks = CommonFunctions.Security.Token.GetToken(objGlobal.TagID + CType(Session("RiskProject"), String) + CType(Session("intUserID"), String))

        If Not MyBase.GetFormValue("cboAccessibleProjects") Is Nothing Then
            If MyBase.GetFormValue("cboAccessibleProjects") <> "" Then
                m_ProjectId = CType(MyBase.GetFormValue("cboAccessibleProjects"), Integer)

            Else
                m_ProjectId = 0
            End If
            Session("RiskProject") = m_ProjectId
        ElseIf Not Session("RiskProject") Is Nothing And (HttpContext.Current.Request.QueryString("StartPage") Is Nothing Or Not HttpContext.Current.Request.QueryString("ApplyFilter") Is Nothing) Then
            m_ProjectId = CType(Session("RiskProject"), Long)
        Else
            If CType(Session("intRoleLevel"), Integer) = 3 Then
                blnPrjExists = True
                If blnPrjExists = True Then
                    m_ProjectId = objGlobal.ProjectID
                    Session("RiskProject") = m_ProjectId
                Else
                    m_ProjectId = 0
                End If
            Else
                m_ProjectId = objGlobal.ProjectID
                Session("RiskProject") = m_ProjectId
            End If
        End If

        Dim intCorporateRoleLevel As Integer
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_roleId " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)

        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
            m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
            If m_RoleId <> 0 Then
                objGlobal.RoleID = m_RoleId
                Session("RiskRole") = m_RoleId
            End If
            m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_tbl_PM_Role_level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)

            If m_RoleLevel <> 0 Then
                objGlobal.RoleLevel = m_RoleLevel
                Session("RiskRoleLevel") = m_RoleLevel
            End If
        End If
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        'CheckProjectIsClosed()
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
        m_PKToken_PMRisks = objGlobal.TagID + CType(Session("RiskProject"), String) + CType(Session("intUserID"), String)

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        Try
            HttpContext.Current.Session("RiskProject") = ProjectID

            Dim m_PKToken As String
            m_PKToken = CommonFunctions.Security.Token.GetToken("1018" + CType(HttpContext.Current.Session("RiskProject"), String) + CType(HttpContext.Current.Session("intUserID"), String))

            Return m_PKToken
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_Token(ByVal ProjectID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1018" + ProjectID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then

                'System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836", False)

                Return False
            Else
                Return True
            End If

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
    'Private Sub CheckProjectIsClosed()
    '    Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))

    '    If IsProjectClosed(intSessionProjectID) Then
    '        m_blnAddAccess = False
    '        m_blnEditAccess = False
    '        m_blnDeleteAccess = False
    '    End If
    'End Sub

    <System.Web.Services.WebMethod()>
    Private Function CheckProjectIsClosed(ByVal ProjectID As String) As Boolean
        Dim intProjectID As Integer


        If Not Integer.TryParse(ProjectID, intProjectID) Then
            Return False
        End If

        Dim blnIsProjectClosed As Boolean = IsProjectClosed(intProjectID)

        If blnIsProjectClosed Then
            m_blnAddAccess = False
            m_blnEditAccess = False
            m_blnDeleteAccess = False
        End If

        Return blnIsProjectClosed
    End Function

    Private Shared Function IsProjectClosed(ByVal ProjectID As Integer) As Boolean
        If ProjectID <= 0 Then
            Return False
        End If

        Dim strIsProjectClosed As String = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & ProjectID, True), "0"))
        Return strIsProjectClosed = "1" OrElse strIsProjectClosed.ToLower() = "true"
    End Function
    'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
End Class