Public Class SM_AdvancedSettings
    Inherits WebPages.Template.WhizTemplate
    Protected m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnViewAccess As Boolean = False 'View access for the logged in user
    Public m_PKToken_List As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CreateGlobalObject()
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.SM.SM_AdvanceSettings", "Whizible2Resources")
    End Sub

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        Dim blnPrjExists As Boolean = False

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3914

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)



        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnViewAccess = objAccess.View 'If user has View Access

        If (m_blnAddAccess = True And m_blnEditAccess = True) Then
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = True
            Else
                m_blnViewAccess = True
            End If

        Else
            If (m_blnViewAccess = False) Then
                m_blnViewAccess = False
            Else
                m_blnViewAccess = True
            End If
        End If

        m_PKToken_List = CommonFunctions.Security.Token.GetToken("3914" + CType(Session("intUserID"), String))
        If (((m_PKToken_List = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3914" + CType(Session("intUserID"), String), m_PKToken_List) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If

    End Sub

End Class