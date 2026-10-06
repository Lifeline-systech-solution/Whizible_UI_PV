Public Class SM_TeamsAlertSettings
    Inherits WebPage.Templates.WhizTemplate

    Protected m_blnAddAccess As Boolean = False
    Protected m_blnDeleteAccess As Boolean = False
    Protected m_blnEditAccess As Boolean = False
    Public m_blnViewAccess As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        CreateGlobalObject()

        ' TODO: Add resource file and uncomment when resource keys are created
        ' MyBase.InitializeResources("Whizible2Resources.Source.SM.SM_TeamsAlertSettings", "Whizible2Resources")
    End Sub

    Public Sub CreateGlobalObject()
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        ' TODO: Update TagID when page is registered in menu master
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 86160, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
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
