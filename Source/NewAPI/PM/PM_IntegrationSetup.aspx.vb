Public Class PM_IntegrationSetup
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromISList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnISAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnISEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnISDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnISViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_IntegrationSetup As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_IntegrationSetup", "Whizible2Resources")
        CreateCTBGlobalObject()
        m_PKToken_IntegrationSetup = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_IntegrationSetup) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Private Sub CreateCTBGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 8056

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnISAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnISDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnISEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnISViewAccess = objAccess.View 'If user has View Access

        If (m_blnISAddAccess = True And m_blnISEditAccess = True) Then
            If (m_blnISViewAccess = False) Then
                m_blnISViewAccess = True
            Else
                m_blnISViewAccess = True
            End If

        Else
            If (m_blnISViewAccess = False) Then
                m_blnISViewAccess = False
            Else
                m_blnISViewAccess = True
            End If
        End If

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromISList = CommonFunctions.Security.Token.GetToken("8056" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromISList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("8056" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromISList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnISAddAccess = True Or m_blnISEditAccess = True Or m_blnISDeleteAccess = True) Then
            m_blnISViewAccess = True
        End If
    End Sub
End Class