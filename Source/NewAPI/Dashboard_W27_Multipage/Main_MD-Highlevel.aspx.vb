Public Class Main_MD_Highlevel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strstring As String
        strstring = Session("intUserID").ToString
    End Sub

End Class