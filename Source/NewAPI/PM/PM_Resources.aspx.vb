Public Class PM_Resources
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Public m_PKToken_FromResourcesList As String = ""

    Protected m_ProjectId As Long 'ProjectId
    Protected ResourceProjectID As String
    Protected strProjectId As String
    Protected selProjectId As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        ''Added by RehanC on 10th April 2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        ''End Of comment by RehanC on 10th April 2023
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
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Resources", "Whizible2Resources")
    End Sub

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        Dim blnPrjExists As Boolean = False
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1019

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        If Not MyBase.GetFormValue("cboProjects") Is Nothing Then
            If MyBase.GetFormValue("cboProjects") <> "" Then
                m_ProjectId = CType(MyBase.GetFormValue("cboProjects"), Integer)

            Else
                m_ProjectId = 0
            End If
            ResourceProjectID = m_ProjectId
        ElseIf Not ResourceProjectID Is Nothing And (HttpContext.Current.Request.QueryString("StartPage") Is Nothing Or Not HttpContext.Current.Request.QueryString("ApplyFilter") Is Nothing) Then
            m_ProjectId = CType(ResourceProjectID, Long)
        Else
            If CType(Session("intRoleLevel"), Integer) = 3 Then
                blnPrjExists = True
                If blnPrjExists = True Then
                    m_ProjectId = objGlobal.ProjectID
                    ResourceProjectID = m_ProjectId
                Else
                    m_ProjectId = 0
                End If
            Else
                m_ProjectId = objGlobal.ProjectID
                ResourceProjectID = m_ProjectId
            End If
        End If

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        'Added by Aditya J. on 19-08-2026 for restricting changes to closed projects
        Dim intSessionProjectID As Integer = Convert.ToInt32(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"))
        Dim strIsSessionProjectClosed As String = "0"

        If intSessionProjectID > 0 Then
            strIsSessionProjectClosed = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_CheckSessionProjectClosed @SessionProjectID = " & intSessionProjectID, True), "0"))

            If strIsSessionProjectClosed = "1" OrElse strIsSessionProjectClosed.ToLower() = "true" Then
                m_blnAddAccess = False
                m_blnEditAccess = False
                m_blnDeleteAccess = False
            End If
        End If
        'End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

        If (m_blnAddAccess = True And m_blnEditAccess = True) Then
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = True
            Else
                m_blnViewAccess = True
            End If

        Else
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = False
            Else
                m_blnViewAccess = True
            End If
        End If

        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ResourceProjectID + CType(Session("intUserID"), String))
        If (((m_PKToken_FromResourcesList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1019" + ResourceProjectID + CType(Session("intUserID"), String), m_PKToken_FromResourcesList) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_TokenUtilization(ByVal ProjectID As String, ByVal ProjectEmployeeRoleID As String, ByVal EmployeeID As String) As String
        Try
            Dim ResourceProjectID As String
            ResourceProjectID = ProjectID

            Dim m_PKToken_FromResourcesList As String
            m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ResourceProjectID + ProjectEmployeeRoleID + EmployeeID + CType(HttpContext.Current.Session("intUserID"), String))

            Return m_PKToken_FromResourcesList
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    'Resource Utilization Added by imran 17-08-2021
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_TokenResourceUtilization(ByVal ProjectID As String, ByVal TagID As String, ByVal UserID As String) As String
        Try
            Dim ResourceProjectID As String
            Dim ResourceTagID As String
            Dim ResourceUserID As String

            ResourceProjectID = ProjectID
            ResourceTagID = TagID
            ResourceUserID = UserID

            Dim m_PKToken_FromResourcesList As String
            m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken(ResourceProjectID + ResourceTagID + ResourceUserID)

            Return m_PKToken_FromResourcesList
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_TokenUtilization(ByVal ProjectID As String, ByVal TagID As String, ByVal PKToken As String, ByVal UserID As String) As Boolean
        Try
            If (PKToken = "") And (CommonFunctions.Security.Token.ValidateToken(ProjectID + TagID + UserID, PKToken) = False) Then

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
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        Try
            Dim ResourceProjectID As String
            ResourceProjectID = ProjectID

        Dim m_PKToken_FromResourcesList As String
        m_PKToken_FromResourcesList = CommonFunctions.Security.Token.GetToken("1220" + ResourceProjectID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken_FromResourcesList
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidatePK_Token(ByVal ProjectID As String, ByVal PKToken As String) As Boolean
        Try
            If (((PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1220" + ProjectID + CType(HttpContext.Current.Session("intUserID"), String), PKToken) = False)) Then
                'System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836", False)
                Return False
            Else
                Return True
            End If
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

End Class