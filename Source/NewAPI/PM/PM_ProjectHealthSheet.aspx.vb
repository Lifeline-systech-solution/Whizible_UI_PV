Public Class PM_ProjectHealthSheet
    Inherits WebPages.Template.WhizTemplate

    'Added By Imran Mujawar on 08-07-2022 
    Public m_PKToken As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectHealthSheet", "Whizible2Resources")

        'Added By Imran Mujawar On 10-02-2022 
        m_PKToken = CommonFunctions.Security.Token.GetToken("3068" + CType(HttpContext.Current.Session("intUserID"), String) + CType(HttpContext.Current.Session("LoginType"), String))
        If (((m_PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3068" + CType(Session("intUserID"), String) + CType(HttpContext.Current.Session("LoginType"), String), m_PKToken) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of Added By On 10-02-2022 
    End Sub

End Class