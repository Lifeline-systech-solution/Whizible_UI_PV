Imports System

Public Class PM_ProjectSites
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False
    Protected m_blnDeleteAccess As Boolean = False
    Protected m_blnEditAccess As Boolean = False
    Public m_blnViewAccess As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()
        Try
            ' Safely initialize resources if available; keep page resilient if not present
            MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSites", "Whizible2Resources")
        Catch
        End Try

        Dim UserName As String = Session("strUserName").ToString()
    End Sub

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        ' Page ID for Project Sites - 80023
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 2251, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add
        m_blnDeleteAccess = m_objAccess.Delete
        m_blnEditAccess = m_objAccess.Edit
        m_blnViewAccess = m_objAccess.View

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If
    End Sub

End Class

