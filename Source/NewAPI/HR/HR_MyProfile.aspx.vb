Imports System.Data
Imports System.Data.SqlClient
Public Class HR_MyProfile
    'Inherits System.Web.UI.Page

    Inherits WebPages.Template.WhizTemplate
    Protected m_IsSkillWFEnabled As Boolean = False

    Protected m_IsEnabledSkillFileUpload As Boolean = False
    ' Access rights flags
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user

    'Added by Vishal Mane on 20/01/2026 to apply tab specific role access
    ' ===================== Certification  =====================
    Protected m_blnAddAccess_Certification As Boolean = False 'Add access for the logged in user
    Protected m_blnDeleteAccess_Certification As Boolean = False 'Delete access for the logged in user
    Protected m_blnEditAccess_Certification As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess_Certification As Boolean = False 'View access for the logged in user

    ' ===================== Qualifications  =====================
    Protected m_blnAddAccess_Qualifications As Boolean = False 'Add access for the logged in user
    Protected m_blnDeleteAccess_Qualifications As Boolean = False 'Delete access for the logged in user
    Protected m_blnEditAccess_Qualifications As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess_Qualifications As Boolean = False 'View access for the logged in user

    ' ===================== Previous Work Experience =====================
    Protected m_blnAddAccess_PrevWorkExp As Boolean = False   ' Add access
    Protected m_blnDeleteAccess_PrevWorkExp As Boolean = False ' Delete access
    Protected m_blnEditAccess_PrevWorkExp As Boolean = False  ' Edit access
    Protected m_blnViewAccess_PrevWorkExp As Boolean = False  ' View access

    ' ========================= Assignments ===============================
    Protected m_blnAddAccess_Assignments As Boolean = False
    Protected m_blnDeleteAccess_Assignments As Boolean = False
    Protected m_blnEditAccess_Assignments As Boolean = False
    Protected m_blnViewAccess_Assignments As Boolean = False

    ' ============================ Skills =================================
    Protected m_blnAddAccess_Skills As Boolean = False
    Protected m_blnDeleteAccess_Skills As Boolean = False
    Protected m_blnEditAccess_Skills As Boolean = False
    Protected m_blnViewAccess_Skills As Boolean = False
    'End of Added by Vishal Mane on 20/01/2026 to apply tab specific role access

    ' Page variables
    Protected m_UserId As Long 'UserId
    Protected m_UserName As String 'UserName
    Protected m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Private m_ProjectId As Long 'ProjectId
    Private m_CultureId As Long 'CultureId
    Public m_TagId As Long 'TagId



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            ' Apply security - authentication and authorization
            MyBase.ApplySecurity(True)

            ' Get user ID for logging/tracking
            Dim strUserId As String
            strUserId = Session("intUserID").ToString

            ' Initialize access rights and global object
            CreateGlobalObject()
            'Added by Vishal Mane on 20/01/2026 to apply tab specific role access
            LoadAllRoleAccess()
            LoadSkillWorkflowConfiguration()
            'End of Added by Vishal Mane on 20/01/2026 to apply tab specific role access
            ' Initialize resources (if available)
            Try
                MyBase.InitializeResources("Whizible2Resources.Source.HR.MyProfile", "Whizible2Resources")
            Catch ex As Exception
                ' Continue if resource initialization fails
            End Try

        Catch ex As Exception
            ' Log error and redirect to error page
            Response.Redirect("../../General/ErrorPage.aspx?Mode=PageLoad&Error=" + Server.UrlEncode(ex.Message))
        End Try
    End Sub

    Public Sub CreateGlobalObject()
        Try
            'Global Object
            Dim objGlobal As WebPages.Template.IGlobal
            Dim blnPrjExists As Boolean = False

            'Fill Global object
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
            objGlobal = MyBase.GlobalObject

            'Tag ID for My Profile - using a standard profile tag ID
            'Note: This should be set to the actual tag ID for My Profile in your system
            objGlobal.TagID = 1085 ' Using MyTeam tag ID as reference - update with actual MyProfile tag ID

            Dim objAccess As New WebPages.Template.AccessRights
            objAccess.GetAccess(objGlobal)

            'Get project ID from session Or query string
            m_ProjectId = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")

            'Set user information
            m_UserId = objGlobal.UserID
            m_UserName = objGlobal.UserName
            m_LoginType = objGlobal.LoginType
            m_RoleId = objGlobal.RoleID
            m_RoleLevel = objGlobal.RoleLevel
            m_CultureId = objGlobal.LCID
            m_TagId = objGlobal.TagID

            'Set access rights
            m_blnAddAccess = objAccess.Add 'If user has AddNew Access
            m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
            m_blnEditAccess = objAccess.Edit 'If user has Edit Access
            m_blnViewAccess = objAccess.View 'If user has View Access

            'If User Then has any access level (Add/Edit/Delete), they should have View access too
            If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
                m_blnViewAccess = True
            End If

            ' For My Profile, users should always have view access to their own profile
            ' Edit access is typically granted to the user for their own profile
            If m_blnViewAccess = False Then
                ' Default to view access for own profile
                m_blnViewAccess = True
            End If

        Catch ex As Exception
            'Keep Page resilient if access initialization fails - default to view-only
            m_blnAddAccess = False
            m_blnDeleteAccess = False
            m_blnEditAccess = False
            m_blnViewAccess = True ' Default to view access for own profile
        End Try
    End Sub

    'Added by Vishal Mane On 20/01/2026 To apply tab specific role access
    Public Sub LoadAllRoleAccess()
        ' Tag IDs
        Const TAG_Certifications As Long = 3180
        Const TAG_Qualifications As Long = 3181
        Const TAG_PrevWorkExp As Long = 3179
        Const TAG_Assignments As Long = 3178
        Const TAG_Skills As Long = 3177

        ' Certifications
        Dim accCert = GetAccessByTagId(TAG_Certifications)
        m_blnAddAccess_Certification = accCert.Add
        m_blnEditAccess_Certification = accCert.Edit
        m_blnDeleteAccess_Certification = accCert.Delete
        m_blnViewAccess_Certification = accCert.View Or accCert.Add Or accCert.Edit Or accCert.Delete

        ' Qualifications
        Dim accProfile = GetAccessByTagId(TAG_Qualifications)
        m_blnAddAccess_Qualifications = accProfile.Add
        m_blnEditAccess_Qualifications = accProfile.Edit
        m_blnDeleteAccess_Qualifications = accProfile.Delete
        m_blnViewAccess_Qualifications = accProfile.View Or accProfile.Add Or accProfile.Edit Or accProfile.Delete

        ' PrevWorkExp
        Dim PrevWorkExp = GetAccessByTagId(TAG_PrevWorkExp)
        m_blnAddAccess_PrevWorkExp = PrevWorkExp.Add
        m_blnEditAccess_PrevWorkExp = PrevWorkExp.Edit
        m_blnDeleteAccess_PrevWorkExp = PrevWorkExp.Delete
        m_blnViewAccess_PrevWorkExp = PrevWorkExp.View Or PrevWorkExp.Add Or PrevWorkExp.Edit Or PrevWorkExp.Delete

        ' Assignments
        Dim Assignments = GetAccessByTagId(TAG_Assignments)
        m_blnAddAccess_Assignments = Assignments.Add
        m_blnEditAccess_Assignments = Assignments.Edit
        m_blnDeleteAccess_Assignments = Assignments.Delete
        m_blnViewAccess_Assignments = Assignments.View Or Assignments.Add Or Assignments.Edit Or Assignments.Delete

        ' Skills
        Dim Skills = GetAccessByTagId(TAG_Skills)
        m_blnAddAccess_Skills = Skills.Add
        m_blnEditAccess_Skills = Skills.Edit
        m_blnDeleteAccess_Skills = Skills.Delete
        m_blnViewAccess_Skills = Skills.View Or Skills.Add Or Skills.Edit Or Skills.Delete

    End Sub

    'Public Function GetAccessByTagId(tagId As Long) As WebPages.Template.AccessRights
    '    Dim dtDataTable As DataTable
    '    Dim strSQL = "usp_Sel_RoleAccess " & CType(Session("intPostID"), String) & "," & 1085 & "," & tagId & ""
    '    dtDataTable = CommonFunctions.Data.GetDataTable(strSQL, True)
    '    Return dtDataTable
    'End Function

    Public Function GetAccessByTagId(tagId As Long) As WebPages.Template.AccessRights
        Dim objAccess As New WebPages.Template.AccessRights
        Dim dt As DataTable
        ' usp_Sel_RoleAccess <PostID>, <ParentTagID>, <ChildTagID>
        Dim strSQL As String = "usp_Sel_RoleAccess " & CType(Session("intPostID"), String) & ",1085," & tagId
        dt = CommonFunctions.Data.GetDataTable(strSQL, True)
        ' Safe fallback – no rows means no access
        If dt Is Nothing OrElse dt.Rows.Count = 0 Then
            objAccess.Add = False
            objAccess.Delete = False
            objAccess.Edit = False
            objAccess.View = False
            Return objAccess
        End If
        Dim dr As DataRow = dt.Rows(0)
        ' ===== Map SP columns to AccessRights =====
        objAccess.Add = Convert.ToBoolean(dr("A"))
        objAccess.Delete = Convert.ToBoolean(dr("D"))
        objAccess.Edit = Convert.ToBoolean(dr("E"))
        objAccess.View = Convert.ToBoolean(dr("V"))

        Return objAccess
    End Function


    Private Sub LoadSkillWorkflowConfiguration()
        Try
            Dim dataTable As DataTable = CommonFunctions.Data.GetDataTable("Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSettings_SkillWFEnabled", True)

            If dataTable IsNot Nothing AndAlso dataTable.Rows.Count > 0 Then
                m_IsSkillWFEnabled = Convert.ToBoolean(dataTable.Rows(0)("IsSkillWFEnabled"))
                m_IsEnabledSkillFileUpload = Convert.ToBoolean(dataTable.Rows(0)("IsEnabledSkillFileUpload"))
            Else
                m_IsSkillWFEnabled = False
                m_IsEnabledSkillFileUpload = False
            End If

        Catch ex As Exception
            m_IsSkillWFEnabled = False
            m_IsEnabledSkillFileUpload = False
        End Try
    End Sub

    'End Of Added by Vishal Mane On 20/01/2026 To apply tab specific role access

    'End Sub

End Class