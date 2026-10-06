Public Class PM_CreateProject
    Inherits WebPage.Templates.WhizTemplate

    Public m_PKToken As String
    Protected m_PKToken_FromCreateProject As String
    Public UserID As String
    Public ProjectID As String
    Public Parameter As String
    Protected strUserName As String
    Protected StrIsRoleAccess As Boolean = False
    Protected Mode As String = "Add"
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Protected FromWhereData As String
    Protected FromWhereProjectId As String = "0"
    Protected FromWhereTag As String
    Protected SelectedProject As String
    Public ProjectInformationTagID As String = 27
    Public ProjectCreateProjectTagID As String = 1263
    Protected FromWhichPage As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023

        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_CreateProject", "Whizible2Resources")

        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        'Commented And Added By Usha Pandit On 30.12.2020 For setting correct access for Create Project / Project information
        'Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 1263, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        Dim AccessTagId As String = ""
        If Not Request.QueryString("Mode") Is Nothing Then
            Mode = Request.QueryString("Mode").ToString
        Else
            Mode = "Add"
        End If

        If Mode = "Add" Then
            AccessTagId = ProjectCreateProjectTagID
        Else
            AccessTagId = ProjectInformationTagID
        End If
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, AccessTagId, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        'End Of Added By Usha Pandit On 30.12.2020 For setting correct access for Create Project / Project information
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = m_objAccess.View 'If user has View Access

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If

        UserID = CType(Session("intUserID"), Long)
        m_PKToken = CommonFunctions.Security.Token.GetToken("1263" + CType(Session("intProjectID"), String) + CType(Session("intUserID"), String))
        m_PKToken_FromCreateProject = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("FromWhereProjectId"), String) + CType(Session("intUserID"), String))
        FromWhichPage = Trim(Request.QueryString("update") & "")
        m_PKToken_FromCreateProject = Trim(Request.QueryString("PKToken") & "")
        If m_PKToken_FromCreateProject <> "" Then
            If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("FromWhereProjectId"), String) + CType(Session("intUserID"), String), m_PKToken_FromCreateProject) = False)) Then
                System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        ProjectID = CType(Session("intProjectID"), Long)
        strUserName = Session("strUserName")

        Parameter = UserID + ProjectID

        'For Check Which Mode from where action taken (list of project/ create Project)
        If Not Request.QueryString("Mode") Is Nothing Then
            Mode = Request.QueryString("Mode").ToString
        Else
            Mode = "Add"
        End If
        'End of For Check Which Mode 

        If Mode = "Add" Then
            FromWhereTag = ProjectCreateProjectTagID
            ' FromWhereTag = ProjectCreateProjectTagID
        Else
            FromWhereTag = ProjectInformationTagID
        End If

        'End of For Check Which Mode from where action taken (list of project/ create Project)

        'For Edit Mode when Action taken from Project List
        'Selected FromWhereData Comes From Where (C:Created,D:Draft,N:new Project)
        If FromWhereTag = ProjectInformationTagID Then
            If Not Request.QueryString("FromWhereData") Is Nothing Then
                FromWhereData = Request.QueryString("FromWhereData").ToString
                If Not Request.QueryString("FromWhereProjectId") Is Nothing Then
                    FromWhereProjectId = Request.QueryString("FromWhereProjectId")
                Else
                    FromWhereProjectId = "0"
                End If

            Else
                FromWhereData = "D" 'For Draft
            End If
        Else
            FromWhereData = "N" 'For New Project Create
        End If

        If FromWhereTag = ProjectInformationTagID Then
            'For Check Project 
            ''Commented And Added By Usha Pandit On 20.11.2019 For Project Wise Access Check 
            'If Not Request.QueryString("ProjectID") Is Nothing Then
            '    SelectedProject = Request.QueryString("ProjectID").ToString
            'Else
            '    SelectedProject = CType(Session("intProjectID"), Long)
            'End If
            If Not Request.QueryString("FromWhereProjectId") Is Nothing Then
                SelectedProject = Request.QueryString("FromWhereProjectId").ToString
                ProjectID = SelectedProject
            Else
                SelectedProject = CType(Session("intProjectID"), Long)
            End If
            ''End Of Added By Usha Pandit On 20.11.2019 For Project Wise Access Check 
            'End of Project
        Else
            SelectedProject = CType(Session("intProjectID"), Long)
        End If

        'End of For Edit Mode when Action taken from Project List

        Dim strSQL = "usp_Whizible2_tbl_PM_ProjectInfoRoleAccess " & ProjectID & "," & CType(Session("intPostID"), String) & ""
        StrIsRoleAccess = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    End Sub
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
    Public Shared Function ValidatePK_Token(ByVal ProjectID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(ProjectID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then

                'System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836", False)

                Return False
            Else
                Return True
            End If

        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SetSessionProject(ByVal ProjectID As String, ByVal ProjectName As String) As String
        Try
            HttpContext.Current.Session("intProjectID") = ProjectID
            HttpContext.Current.Session("strProjectName") = ProjectName
            Return ProjectID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
End Class