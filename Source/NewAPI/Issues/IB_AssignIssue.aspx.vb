Public Class IB_AssignIssue
    Inherits WebPages.Template.WhizTemplate
    Public m_PKToken_FromString As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").toString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IB_AssignIssue", "Whizible2Resources")

        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IB_AssignIssue", "Whizible2Resources")
        m_PKToken_FromString = Trim(Request.QueryString("PKToken") & "")
        Dim QueryID = Trim(Request.QueryString("QueryID") & "")


        If (((m_PKToken_FromString = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(QueryID + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromString) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")



        End If
    End Sub

End Class