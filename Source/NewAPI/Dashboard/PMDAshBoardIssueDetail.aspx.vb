Public Class PMDAshBoardIssueDetail
    Inherits WebPage.Templates.WhizTemplate

    Public m_PKToken_CopyIssue As String
    Public IssueID As Integer
    Public ProjectID As Integer
    Public Parameter As String
    Public IssueIDList As String
    Public ViewApplied As String
    Protected ProjectName As String
    Protected IssueRoleID As String
    Public m_blnAddAccess As Boolean = False 'user has Add Access ?
    Public m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Public m_blnEditAccess As Boolean = False 'User has Edit Access ?
    Public qid As String
    Public stext As String
    Public qtext As String
    Public flist As String
    Public forder As String
    Public qType As String
    Public qname As String
    Public globalclose As String
    Public SelectedEmployeeID As String
    Public Sub New()
        '    =====================================================================
        '     Procedure Name        :   New()	
        '     Purpose: Constructor for the page
        '     Description: same as above
        '     Parameters Passed     : Nonefromwhere
        '        Parameters Affected   
        'Assumptions:
        'Dependencies:
        'Author: omkarP
        'Created: 14/5/2019
        '     Revisions:
        '    =====================================================================

        '    Apply Security
        'Commented and Added by Nilesh g on 14/5/2019 Purpose:For sso and sql injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of 

        ' Initialize caption resource file 
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")
        'CreateGlobalObject()

        ''added by imran on 06-02-2023 
        'Dim strstring As String
        'strstring = Session("intUserID")
        ''End of comment by imran on 06-02-2023
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim m_objGlobal As WebPages.Template.IGlobal
        'MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")
        MyBase.InitializeResources("Whizible2Resources.Source.Issue.IssueEntry", "Whizible2Resources")
        ''MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'objGlobal = MyBase.GlobalObject
        'With objGlobal

        'End With

        'objAccess.GetAccess(objGlobal)

        'm_blnAddAccess = objAccess.Add 'If user has AddNew Access
        'm_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        'm_blnEditAccess = objAccess.Edit 'If user has Edit Access


        Dim m_objAccess As New WebPage.Templates.AccessRights
        m_objAccess = New WebPage.Templates.AccessRights


        ' Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)


        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 5, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString())
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        m_blnAddAccess = m_objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = m_objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = m_objAccess.Edit 'If user has Edit Access


        m_PKToken_CopyIssue = Trim(Request.QueryString("PKToken") & "")
        IssueID = Trim(Request.QueryString("IssueID") & "")
        ProjectID = Trim(Request.QueryString("ProjectID") & "")
        IssueIDList = Trim(Request.QueryString("IssueIDList") & "")
        ViewApplied = Trim(Request.QueryString("View") & "")
        ProjectName = Trim(Request.QueryString("ProjectName") & "")
        IssueRoleID = Trim(Request.QueryString("RoleID") & "")

        IssueID = Convert.ToInt32(IssueID)
        ProjectID = Convert.ToInt32(ProjectID)
        Session("IssueProject") = ProjectID

        'Added By Dipali V On 27th March 2023 
        'added by imran on 06-02-2023 
        Dim strstring As String
        strstring = Session("intUserID").ToString
        'End of comment by imran on 06-02-2023
        'End of Added By Dipali V On 27th March 2023 
        'Added by  Dipali V On 25th Oct 2021 For Filter Persist
        If Not Trim(Request.QueryString("ProjectID") & "") Is Nothing Then
            If Trim(Request.QueryString("ProjectID") & "") <> "" Then
                Session("SelectedProjectID") = Trim(Request.QueryString("ProjectID") & "")

            Else
                Session("SelectedProjectID") = ""
            End If
        End If


        If Not Trim(Request.QueryString("secondfilter") & "") Is Nothing Then
            If Trim(Request.QueryString("secondfilter") & "") <> "" Then
                Session("SFilter") = Trim(Request.QueryString("secondfilter") & "")

            Else
                Session("SFilter") = ""
            End If
        End If

        If Not Trim(Request.QueryString("FirstFilter") & "") Is Nothing Then
            If Trim(Request.QueryString("FirstFilter") & "") <> "" Then
                Session("FFilter") = Trim(Request.QueryString("FirstFilter") & "")

            Else
                Session("FFilter") = ""
            End If
        End If


        If Not Trim(Request.QueryString("SavedQueryName") & "") Is Nothing Then
            If Trim(Request.QueryString("SavedQueryName") & "") <> "" Then
                Session("SavedQueryName") = Trim(Request.QueryString("SavedQueryName") & "")

            Else
                Session("SavedQueryName") = ""
            End If
        End If


        If Not Trim(Request.QueryString("EmployeeID") & "") Is Nothing Then
            If Trim(Request.QueryString("EmployeeID") & "") <> "" Then
                Session("EmployeeID") = Trim(Request.QueryString("EmployeeID") & "")

            Else
                Session("EmployeeID") = ""
            End If
        End If


        If Not Trim(Request.QueryString("QueryID") & "") Is Nothing Then
            If Trim(Request.QueryString("QueryID") & "") <> "" Then
                Session("QueryID") = Trim(Request.QueryString("QueryID") & "")

            Else
                Session("QueryID") = ""
            End If
        End If

        If Not Trim(Request.QueryString("QueryType") & "") Is Nothing Then
            If Trim(Request.QueryString("QueryType") & "") <> "" Then
                Session("QueryType") = Trim(Request.QueryString("QueryType") & "")

            Else
                Session("QueryType") = ""
            End If
        End If

        If Not Trim(Request.QueryString("ViewType") & "") Is Nothing Then
            If Trim(Request.QueryString("ViewType") & "") <> "" Then
                Session("ViewTypeFilter") = Trim(Request.QueryString("ViewType") & "")

            Else
                Session("ViewTypeFilter") = ""
            End If
        End If

        'End of Added by  Dipali V On 25th Oct 2021 For Filter Persist
        Session("IssueRole") = Trim(Request.QueryString("RoleId") & "")
        Parameter = IssueID + ProjectID
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(Parameter, m_PKToken_CopyIssue) = False)) Then

            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        End If


    End Sub

End Class