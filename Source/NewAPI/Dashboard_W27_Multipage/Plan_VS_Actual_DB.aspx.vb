Public Class Plan_VS_Actual_DB
    Inherits WebPages.Template.WhizTemplate
    'Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strstring As String
        strstring = Session("intUserID").ToString
    End Sub
    'Added by Vishal Mane on 12/08/2026 For SQL Injection, Cross Scripting
    Public Sub New()
        MyBase.ApplySecurity(True)
    End Sub

End Class