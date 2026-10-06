Public Class PM_DocumentCategory
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromDocList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnDocAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnDocEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnDocDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnDocViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_DocumentCategory As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_DocumentCategory", "Whizible2Resources")
        CreateDocGlobalObject()
        m_PKToken_DocumentCategory = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_DocumentCategory) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Private Sub CreateDocGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3003

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnDocAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDocDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnDocEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnDocViewAccess = objAccess.View 'If user has View Access

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromDocList = CommonFunctions.Security.Token.GetToken("3003" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromDocList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3003" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromDocList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnDocAddAccess = True Or m_blnDocEditAccess = True Or m_blnDocDeleteAccess = True) Then
            m_blnDocViewAccess = True
        End If
    End Sub
End Class