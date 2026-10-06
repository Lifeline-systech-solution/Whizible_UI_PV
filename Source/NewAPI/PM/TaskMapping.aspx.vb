Public Class TaskMapping
    Inherits WebPages.Template.WhizTemplate
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_TaskDetails", "AppResources")
    End Sub

End Class