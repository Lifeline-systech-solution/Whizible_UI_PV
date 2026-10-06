Public Class PM_ProjectComplexity
    Inherits WebPages.Template.WhizTemplate
    Public ProjectID As String = False 'For Session Project ID
    Protected m_PKToken_FromComplexityList As String = ""

    Public UserID As String

    Protected m_blnComplexityAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnComplexityEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnComplexityDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnComplexityViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ProjectComplexity As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreateProjectComplexityGlobalObject()
        m_PKToken_ProjectComplexity = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ProjectComplexity) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub

    Private Sub CreateProjectComplexityGlobalObject()
        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3577

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnComplexityAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnComplexityDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnComplexityEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnComplexityViewAccess = objAccess.View 'If user has View Access

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromComplexityList = CommonFunctions.Security.Token.GetToken("3577" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromComplexityList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("3577" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromComplexityList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnComplexityAddAccess = True Or m_blnComplexityEditAccess = True Or m_blnComplexityDeleteAccess = True) Then
            m_blnComplexityViewAccess = True
        End If
    End Sub
End Class