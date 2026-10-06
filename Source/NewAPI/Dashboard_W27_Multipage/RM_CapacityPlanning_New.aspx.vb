Imports Whiz

Public Class RM_CapacityPlanning_New

    Inherits WebPages.Template.WhizTemplate

    Protected m_LoginType As String
    Private m_RoleId As Long
    Private m_UserId As Long
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public m_blnViewAccess As Boolean
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        MyBase.ApplySecurity(True)
        'CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.Resource.RM_CapacityPlanning_New", "Whizible2Resources")
        Dim strstring As String
        strstring = Session("intUserID").ToString
    End Sub
    ' start commented by vikas T On 09-09-2026 Not In use For dashboard
    'Public Sub CreateGlobalObject()
    '    Dim m_objGlobal As WebPages.Template.IGlobal
    '    Dim m_objAccess As New WebPage.Templates.AccessRights
    '    m_objAccess = New WebPage.Templates.AccessRights

    '    Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 86153, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
    '    m_objAccess.GetAccess(objGlobal)
    '    m_objGlobal = objGlobal

    '    m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
    '    m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
    '    m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
    '    m_blnViewAccess = m_objAccess.View 'If user has View Access

    '    If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
    '        m_blnViewAccess = True
    '    End If
    'End Sub
    'end commented by vikas T On 09-09-2026 Not In use For dashboard
End Class