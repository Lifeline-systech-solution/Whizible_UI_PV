Imports Whiz

Public Class RM_Qualification
    Inherits WebPages.Template.WhizTemplate

    Protected m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Protected m_ProjectId As Long 'ProjectId
    Private m_UserId As Long 'UserId
    Private m_UserName As String 'UserName
    Private m_CultureId As Long 'CultureId
    Public m_TagId As Long 'm_TagId'

    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean = False 'User has View Access ?
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 460
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel
        m_TagId = objGlobal.TagID
        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID
        m_TagId = objGlobal.TagID
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access
    End Sub

End Class