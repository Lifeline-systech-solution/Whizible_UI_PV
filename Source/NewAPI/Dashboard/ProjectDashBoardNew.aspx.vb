Public Class ProjectDashBoardNew
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetAcess()
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.ProjectDashBoardNew.PM_ProjectDashboardNew", "Whizible2Resources")
    End Sub

    Private Sub GetAcess()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
    End Sub

End Class