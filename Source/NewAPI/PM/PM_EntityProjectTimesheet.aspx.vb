Imports Whiz
Public Class PM_EntityProjectTimesheet
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'View access for the logged in user

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strstring As String
        strstring = Session("intUserID").ToString
        CreateGlobalObject()
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_EntityApproval", "Whizible2Resources")
    End Sub
    Private Sub CreateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3936

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has View Access
        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
    End Sub
End Class
