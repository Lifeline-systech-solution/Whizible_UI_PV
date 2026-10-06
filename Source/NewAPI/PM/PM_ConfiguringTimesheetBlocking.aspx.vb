Public Class PM_ConfiguringTimesheetBlocking
    Inherits WebPages.Template.WhizTemplate
    Protected m_PKToken_FromCTBList As String = ""
    Protected m_PKToken_ToCTBList As String = ""

    Public UserID As String
    Public ProjectID As String = False 'For Session Project ID
    Protected m_blnCTBAddAccess As Boolean = False 'Add access for the logged in user
    Protected m_blnCTBEditAccess As Boolean = False 'Edit access for the logged in user
    Protected m_blnCTBDeleteAccess As Boolean = False 'Delete access for the logged in user
    Protected m_blnCTBViewAccess As Boolean = False 'View access for the logged in user
    Protected m_PKToken_ConfiguringTimesheetBlocking As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreateCTBGlobalObject()
        m_PKToken_ConfiguringTimesheetBlocking = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ConfiguringTimesheetBlocking) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Private Sub CreateCTBGlobalObject()
        'Global object

        Dim blnPrjExists As Boolean = False

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1273

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnCTBAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnCTBDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnCTBEditAccess = objAccess.Edit 'If user has Edit Access
        m_blnCTBViewAccess = objAccess.View 'If user has View Access

        If (m_blnCTBAddAccess = True And m_blnCTBEditAccess = True) Then
            If (m_blnCTBViewAccess = False) Then
                m_blnCTBViewAccess = True
            Else
                m_blnCTBViewAccess = True
            End If

        Else
            If (m_blnCTBViewAccess = False) Then
                m_blnCTBViewAccess = False
            Else
                m_blnCTBViewAccess = True
            End If
        End If

        'ProjectID = CommonFunctions.General.CheckIsNothing(CType(Session("intProjectID"), String), "0")
        'm_PKToken_FromCTBList = CommonFunctions.Security.Token.GetToken("1273" + ProjectID + CType(Session("intUserID"), String))



        'If (((m_PKToken_FromCTBList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1273" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromCTBList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        If (m_blnCTBAddAccess = True Or m_blnCTBEditAccess = True Or m_blnCTBDeleteAccess = True) Then
            m_blnCTBViewAccess = True
        End If
    End Sub
End Class