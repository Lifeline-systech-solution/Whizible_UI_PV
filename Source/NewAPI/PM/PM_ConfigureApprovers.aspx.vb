Public Class PM_ConfigureApprovers
    Inherits WebPages.Template.WhizTemplate

    Public m_PM_ConfigureApproversAddAccess As Boolean = False
    Public m_PM_ConfigureApproversDeleteAccess As Boolean = False
    Public m_PM_ConfigureApproversEditAccess As Boolean = False
    Public m_PM_ConfigureApproversViewAccess As Boolean = False

    Public m_PM_ConfigureExpenseApproversAddAccess As Boolean = False
    Public m_PM_ConfigureExpenseApproversDeleteAccess As Boolean = False
    Public m_PM_ConfigureExpenseApproversEditAccess As Boolean = False
    Public m_PM_ConfigureExpenseApproversViewAccess As Boolean = False

    Public m_PKToken_ToConfigureApprovers As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32
    Protected m_PKToken_ConfigureApprovers As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023 
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_ProjectSettings", "Whizible2Resources")
        CreatePM_ConfigureApproversGlobalObject()
        CreatePM_ConfigureExpenseApproversGlobalObject()
        m_PKToken_ConfigureApprovers = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ConfigureApprovers) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'ProjectID = Convert.ToInt32(Session("intProjectID"))
        'm_PKToken_ToConfigureApprovers = CommonFunctions.Security.Token.GetToken("2250" + ProjectID + CType(Session("intUserID"), String))

        'If (((m_PKToken_ToConfigureApprovers = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2250" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToConfigureApprovers) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
    End Sub

    Public Sub CreatePM_ConfigureApproversGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2250

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ConfigureApproversAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ConfigureApproversDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ConfigureApproversEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ConfigureApproversViewAccess = objAccess.View 'If user has View Access
    End Sub

    Public Sub CreatePM_ConfigureExpenseApproversGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 3591

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_ConfigureExpenseApproversAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_ConfigureExpenseApproversDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_ConfigureExpenseApproversEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_ConfigureExpenseApproversViewAccess = objAccess.View 'If user has View Access
    End Sub

End Class