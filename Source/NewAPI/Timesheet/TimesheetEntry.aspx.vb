Public Class TimesheetEntry
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim UserName As String = Session("strUserName").ToString()
    End Sub

End Class