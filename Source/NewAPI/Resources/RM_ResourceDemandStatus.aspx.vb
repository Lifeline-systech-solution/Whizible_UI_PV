Public Class RM_ResourceDemandStatus
    Inherits WebPages.Template.WhizTemplate
    Protected m_AddAccess As Boolean = False 'Add access for the logged in user
    Protected m_EditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_DeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_ViewAccess As Boolean = False 'View access for the logged in user

    Protected m_PKToken As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.InitializeResources("Whizible2Resources.Source.Resource.RM_ResourceDemandStatus", "Whizible2Resources")
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        CreateGlobalObject()


        m_PKToken = CommonFunctions.Security.Token.GetToken("3862" + CType(Session("intUserID"), String))

        If (((m_PKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3862" + CType(Session("intUserID"), String), m_PKToken) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If
    End Sub

    Private Sub CreateGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3862

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_AddAccess = objAccess.Add 'If user has AddNew Access
        m_DeleteAccess = objAccess.Delete 'If User has Delete Access
        m_EditAccess = objAccess.Edit 'If user has Edit Access
        m_ViewAccess = objAccess.View 'If user has View Access

        If (m_AddAccess = True Or m_EditAccess = True Or m_DeleteAccess = True) Then
            m_ViewAccess = True
        End If
    End Sub

End Class