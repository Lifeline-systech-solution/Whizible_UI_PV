Public Class PM_ReviewTypes
    Inherits WebPages.Template.WhizTemplate
    Protected m_roleLevel As String
    Protected m_AddAccess As String
    Protected m_EditAccess As String
    Protected m_DeleteAccess As String
    Protected m_ViewAccess As String
    Protected m_PKToken_ReviewType As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.Reviewtype", "Whizible2Resources")
        m_PKToken_ReviewType = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ReviewType) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1033
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)
        m_roleLevel = objGlobal.RoleLevel
        m_AddAccess = objAccess.Add
        m_EditAccess = objAccess.Edit
        m_DeleteAccess = objAccess.Delete
        m_ViewAccess = objAccess.View

        'If (m_AddAccess = True And m_EditAccess = True) Then
        '    If (m_ViewAccess = False) Then
        '        m_ViewAccess = True
        '    Else
        '        m_ViewAccess = True
        '    End If

        'Else
        '    If (m_ViewAccess = False) Then
        '        m_ViewAccess = False
        '    Else
        '        m_ViewAccess = True
        '    End If
        'End If

        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
        'If (objAccess.Add = False And objAccess.Edit = False And objAccess.Delete = False And objAccess.View = False) Then
        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        'End If
    End Sub

End Class