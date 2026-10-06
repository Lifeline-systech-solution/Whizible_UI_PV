Public Class PM_Resource_Utilization
    Inherits WebPage.Templates.WhizTemplate

    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Public m_PKToken_FromResourcesList As String = ""

    Protected m_ProjectId As Long 'ProjectId
    Protected ResourceProjectID As String
    Protected strProjectId As String
    Protected selProjectId As String
    Protected m_PKToken_ToResourcesList As String = ""
    Public ProjectID As String
    Public UserID As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by RehanC on 10th April 2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        ''End Of comment by RehanC on 10th April 2023
        MyBase.ApplySecurity(True)
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
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ResourceUtilization", "Whizible2Resources")
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

        m_PKToken_FromResourcesList = Trim(Request.QueryString("PKToken") & "")
        ProjectID = Trim(Request.QueryString("ProjectID"))
        UserID = Trim(Request.QueryString("UserID"))

        If ((m_PKToken_FromResourcesList = "") Or (CommonFunctions.Security.Token.ValidateToken(ProjectID + "3752" + UserID, m_PKToken_FromResourcesList) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If

    End Sub

End Class