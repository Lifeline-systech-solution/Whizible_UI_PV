Public Class TimesheetApproval_Mobile
    Inherits WebPages.Template.WhizTemplate
    Protected Timesheetstatus As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim UserName As String = Session("strUserName").ToString()
        Timesheetstatus = Request.QueryString("TimesheetStatus")
    End Sub

End Class