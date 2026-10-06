Imports System.Data
Public Class HR_SkillRequestApprovals
    'Inherits System.Web.UI.Page

    Inherits WebPages.Template.WhizTemplate
    ' Access rights flags
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Protected m_IsEnabledSkillFileUpload As Boolean = False



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

            ' Initialize resources (if available)
            Try
                MyBase.InitializeResources("Whizible2Resources.Source.HR.HR_SkillRequestApprovals", "Whizible2Resources")
            Catch ex As Exception
                ' Continue if resource initialization fails
            End Try

            Dim dtSkillWF As DataTable = Nothing
            Try
                dtSkillWF = CommonFunctions.Data.GetDataTable("Exec Usp_Whizible2_Sel_tbl_Whizible2_PM_ProjectSettings_SkillWFEnabled", True)
                If dtSkillWF IsNot Nothing AndAlso dtSkillWF.Rows.Count > 0 Then
                    m_IsEnabledSkillFileUpload = Convert.ToBoolean(dtSkillWF.Rows(0)("IsEnabledSkillFileUpload"))
                Else
                    m_IsEnabledSkillFileUpload = False
                End If
            Catch
                m_IsEnabledSkillFileUpload = False
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
            objGlobal.TagID = 86144 ' Using MyTeam tag ID as reference - update with actual MyProfile tag ID

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


        Catch ex As Exception
            'Keep Page resilient if access initialization fails - deny access
            m_blnAddAccess = False
            m_blnDeleteAccess = False
            m_blnEditAccess = False
            m_blnViewAccess = False
        End Try
    End Sub



End Class