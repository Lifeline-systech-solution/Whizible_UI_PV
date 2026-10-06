Public Class PM_ResourceLoading
    Inherits WebPage.Templates.WhizTemplate

    Protected m_PKToken_ToResourcesList As String = ""
    Protected m_PKToken_FromResourcesList As String = ""
    Public BackLink As String
    Public ProjectEmployeeRoleID As String
    Public ProjectID As String
    Public EmployeeID As String
    Public UserID As String
    Public ProjectName As String
    Public m_PKToken_FromResourcesRequestList As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        MyBase.ApplySecurity(True)
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        MyBase.InitializeResources("Whizible2Resources.Source.PM.PM_Resources", "Whizible2Resources")


        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 1019

        m_PKToken_FromResourcesList = Trim(Request.QueryString("PKToken") & "")
        ProjectEmployeeRoleID = Trim(Request.QueryString("ProjectEmployeeRoleID") & "")
        ProjectID = Trim(Request.QueryString("ProjectID") & "")
        EmployeeID = Trim(Request.QueryString("EmployeeID") & "")
        ProjectName = Trim(Request.QueryString("ProjectName") & "")
        BackLink = Trim(Request.QueryString("Link") & "")

        If ProjectEmployeeRoleID <> "" Then
            m_PKToken_ToResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ProjectID + ProjectEmployeeRoleID + EmployeeID + CType(Session("intUserID"), String))

            If (((m_PKToken_FromResourcesList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1019" + ProjectID + ProjectEmployeeRoleID + EmployeeID + CType(Session("intUserID"), String), m_PKToken_FromResourcesList) = False)) Then

                System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

            End If
        Else

            ProjectEmployeeRoleID = 0

            m_PKToken_ToResourcesList = CommonFunctions.Security.Token.GetToken("1019" + ProjectID + EmployeeID + CType(Session("intUserID"), String))

            If (((m_PKToken_FromResourcesList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1019" + ProjectID + EmployeeID + CType(Session("intUserID"), String), m_PKToken_FromResourcesList) = False)) Then

                System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

            End If
            m_PKToken_FromResourcesRequestList = CommonFunctions.Security.Token.GetToken("1220" + ProjectID + CType(Session("intUserID"), String))
            If (((m_PKToken_FromResourcesRequestList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("1220" + ProjectID + CType(Session("intUserID"), String), m_PKToken_FromResourcesRequestList) = False)) Then

                System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

            End If
        End If



    End Sub

End Class