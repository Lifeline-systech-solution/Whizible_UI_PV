Public Class PM_ProjectHealthSheet_Help
    Inherits WebPages.Template.WhizTemplate

    Protected m_PKToken As String = ""
    Protected TagID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        'Added by imran on 10-02-2022
        m_PKToken = Trim(Request.QueryString("PKToken") & "")
        TagID = Trim(Request.QueryString("TagID") & "")
        If ((m_PKToken = "") Or (CommonFunctions.Security.Token.ValidateToken(TagID.ToString() + CType(Session("intUserID"), String) + CType(HttpContext.Current.Session("LoginType"), String), m_PKToken) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End Comment by imran on 10-02-2022
    End Sub

End Class