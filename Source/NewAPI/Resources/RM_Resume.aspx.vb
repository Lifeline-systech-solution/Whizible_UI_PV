Public Class RM_Resume
    Inherits WebPages.Template.WhizTemplate
    Public m_PKToken_FromString As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023  
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 

        ValidateTokenForResume()
    End Sub

    Protected Sub ValidateTokenForResume()
        m_PKToken_FromString = Trim(Request.QueryString("PKToken") & "")
        Dim EmployeeID = Trim(Request.QueryString("EmployeeID") & "")
        Dim TagID = Trim(Request.QueryString("TagID") & "")

        If (((m_PKToken_FromString = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(TagID + EmployeeID + CType(Session("intUserID"), String), m_PKToken_FromString) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
    End Sub
End Class