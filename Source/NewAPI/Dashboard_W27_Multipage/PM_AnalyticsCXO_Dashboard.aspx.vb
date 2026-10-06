Public Class PM_AnalyticsCXO_Dashboard
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strstring As String
        strstring = Session("intUserID").ToString
    End Sub

    Public Sub New()
        MyBase.ApplySecurity(True)
    End Sub

End Class
