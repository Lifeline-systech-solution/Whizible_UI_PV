Public Class PM_GraphAndOtherInformation
    Inherits WebPages.Template.WhizTemplate

    Protected m_PKToken_FromPSDList As String = ""
    Protected m_blnAddAccess As Boolean = False 'user has Add Access ?
    Protected m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Protected m_blnEditAccess As Boolean = False 'User has Edit Access ?
    public m_blnViewAccess As Boolean = False 'User has View Access ?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_GraphAndOtherInformation", "Whizible2Resources")

        ' Added by imran on 16-12-2021 to check View access
        Dim m_objGlobal As WebPages.Template.IGlobal
        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights

        Dim AccessTagId As String = "3969"
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, AccessTagId, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())

        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = m_objAccess.View 'If user has View Access

        If m_blnAddAccess = True Or m_blnEditAccess = True Or m_blnDeleteAccess = True Then
            m_blnViewAccess = True
        End If

        m_PKToken_FromPSDList = CommonFunctions.Security.Token.GetToken("3969" + CType(Session("intUserID"), String))
        If (((m_PKToken_FromPSDList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3969" + CType(Session("intUserID"), String), m_PKToken_FromPSDList) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=3969")
        End If
        'End comment by imran on 16-12-2021

    End Sub

End Class