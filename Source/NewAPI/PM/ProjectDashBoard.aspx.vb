Public Class ProjectDashBoard
    Inherits WebPages.Template.WhizTemplate
    'Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    'Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    'Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    'Protected m_ViewAccess As Boolean = False 'View access for the logged in user
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetAcess()
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectDashboard", "Whizible2Resources")
    End Sub


    Private Sub GetAcess()
        'Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'objGlobal = MyBase.GlobalObject
        'objGlobal.TagID = 22603


        'Dim objAccess As New WebPages.Template.AccessRights
        'objAccess.GetAccess(objGlobal)

        'm_AddAccess = True
        'm_EditAccess = True 'If User has Delete Access
        'm_DeleteAccess = True 'If user has Edit Access
        'm_ViewAccess = True 'If user has Edit Access
    End Sub
End Class