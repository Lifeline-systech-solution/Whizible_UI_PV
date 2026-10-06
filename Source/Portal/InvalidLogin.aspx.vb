Public Partial Class InvalidLogin
    Inherits System.Web.UI.Page

    Protected strApplicationName As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        strApplicationName = Request.QueryString("ProductName")
    End Sub
End Class