Public Class RM_workprofile_help
    Inherits WebPages.Template.WhizTemplate

    Protected m_PKToken As String = ""
    Public m_IsLinkActiveAccess As String
    Public strSQL As String
    Public m_TagId As Long

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_TagId = Trim(Request.QueryString("TagID") & "")
        'Added by imran on 23-01-2022
        strSQL = "usp_Sel_tbl_Whizible2_IsLinkActiveAccess " + m_TagId.ToString
        m_IsLinkActiveAccess = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)
        'End Comment by imran on 23-01-2022
        m_PKToken = Trim(Request.QueryString("PKToken") & "")
        If ((m_PKToken = "") Or (CommonFunctions.Security.Token.ValidateToken(m_TagId.ToString() + CType(Session("intUserID"), String) + CType(HttpContext.Current.Session("LoginType"), String), m_PKToken) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
End Class