Public Class PM_Project_Information
    Inherits WebPages.Template.WhizTemplate

    Public ProjectID As String
    Public WhichAction As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        ProjectID = CType(Session("intProjectID"), Long)
        WhichAction = "C"
        'System.Web.HttpContext.Current.Response.Redirect("PM_CreateProject.aspx?FromWhereProjectId='" + ProjectID + "'&FromWhereData='" + WhichAction + "'&Mode=Edit'")
    End Sub

End Class