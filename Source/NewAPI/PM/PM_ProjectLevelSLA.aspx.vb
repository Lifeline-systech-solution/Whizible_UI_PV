Public Class PM_ProjectLevelSLA
    Inherits WebPages.Template.WhizTemplate
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnprojSLAAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnprojSLAEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnprojSLADeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnprojSLAViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_FromPLSList As String
    Protected m_PKToken_ProjectLevelSLA As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreateProjLevelSLAGlobalObject()
        m_PKToken_ProjectLevelSLA = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectLevelSLA) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreateProjLevelSLAGlobalObject()
        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3574

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnprojSLAAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnprojSLADeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnprojSLAEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnprojSLAViewAccess = objAccess.View 'If user has View Access

        If (m_blnprojSLAAddAccess = True And m_blnprojSLAEditAccess = True) Then
            If (m_blnprojSLAViewAccess = False) Then
                m_blnprojSLAViewAccess = True
            Else
                m_blnprojSLAViewAccess = True
            End If

        Else
            If (m_blnprojSLAViewAccess = False) Then
                m_blnprojSLAViewAccess = False
            Else
                m_blnprojSLAViewAccess = True
            End If
        End If

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")

        'm_PKToken_FromPLSList = CommonFunctions.Security.Token.GetToken("3227" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromPLSList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3227" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromPLSList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnprojSLAAddAccess = True Or m_blnprojSLAEditAccess = True Or m_blnprojSLADeleteAccess = True) Then
            m_blnprojSLAViewAccess = True
        End If
    End Sub
End Class