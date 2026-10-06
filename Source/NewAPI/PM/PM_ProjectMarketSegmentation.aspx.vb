Public Class PM_ProjectMarketSegmentation
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromMarketSegList As String = ""
    Protected m_PKToken_ToMarketSegList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnMarketSegAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnMarketSegEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnMarketSegDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnMarketSegViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ProjectMarketSegmentation As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreateGlobalObject()
        m_PKToken_ProjectMarketSegmentation = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectMarketSegmentation) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If

    End Sub
    Private Sub CreateGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2188

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnMarketSegAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnMarketSegDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnMarketSegEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnMarketSegViewAccess = objAccess.View 'If user has View Access

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromMarketSegList = CommonFunctions.Security.Token.GetToken("2188" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromMarketSegList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2188" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromMarketSegList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnMarketSegAddAccess = True Or m_blnMarketSegEditAccess = True Or m_blnMarketSegDeleteAccess = True) Then
            m_blnMarketSegViewAccess = True
        End If

    End Sub

End Class