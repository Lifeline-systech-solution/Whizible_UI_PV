Imports Whiz
Public Class HR_Grade_Master_Help
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        Dim m_PKToken_FromGradeList As String

    End Sub

End Class