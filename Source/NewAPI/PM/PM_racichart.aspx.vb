Public Class racichart
    Inherits WebPages.Template.WhizTemplate
    Protected m_roleLevel As String
    Protected m_AddAccess As String
    Protected m_EditAccess As String
    Protected m_DeleteAccess As String
    Protected m_ViewAccess As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.Stakeholders.Racichart", "Whizible2Resources")
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2104
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)
        m_roleLevel = objGlobal.RoleLevel
        m_AddAccess = objAccess.Add
        m_EditAccess = objAccess.Edit
        m_DeleteAccess = objAccess.Delete
        m_ViewAccess = objAccess.View
    End Sub

End Class