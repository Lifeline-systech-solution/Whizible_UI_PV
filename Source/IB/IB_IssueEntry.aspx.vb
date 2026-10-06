Imports System.Text
Public Class IB_IssueEntry
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmIBIssueEntry As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Form level variables declareation "

    'Enum for display style of controls
    Private Enum IB_ControlDisplayStyle As Integer
        CONTROLS_IN_TABS = 1
        CONTROLS_IN_SECTIONS = 2
    End Enum
    Private RANGE As Double = CType(CommonFunction.Application.MaxItemsInIssueIDCombo, Integer) / 2

    Private m_DisplayStyle As IB_ControlDisplayStyle

    Private m_UseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_LoginId As Long 'Login Id
    'Added by MonikaI on 10th Oct 2006 IssueID : 6940
    Protected m_intDeliverableID As Integer
    'End of addition by MonikaI
    'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
    Protected m_LoginType As String 'Login type
    Protected m_IsIssueSLAApplicable As Boolean = False
    'End Modification
    Private m_RoleId As Long 'Role Id
    Private m_RoleLevel As Integer 'Role level
    Protected m_ProjectId As Long 'Project Id
    Private m_UserId As Long 'User Id
    Private m_UserName As String 'User Name
    Private m_CultureId As Long 'Culture Id
    Protected m_FromWhere As String 'From where ?

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?

    '(values set in )
    Protected m_intPageNumber As Integer  'Currently Selected page number
    Protected m_lngIssueId As Long = 0 'Currently Selected IssueId

    '(Values set in GetProjectIdAndRoleId)
    Private m_blnShareIBWithinProjectGroup As Boolean = False 'Share Issue in project group ?
    Protected m_blnAssignIssueToResponsiblePerson As Boolean = False 'Assign issue to responsible person ?
    Private m_blnIsProjectOver As Boolean = False 'Is Project Over ? 
    Private m_blnSendResponsiblePersonMail As Boolean = False 'Send mail to responsible person ?

    '(Values set in GetSortingDetails)
    Protected m_strSortField As String = "" 'Sort field
    Protected m_strSortOrder As String = "" 'SortOrder

    '(Values set in GetDisplayMode)
    Private m_blnShowDefaults As Boolean = False 'Show defaults ?
    Private m_blnShowFormContents As Boolean = False 'Show FOrm contents ? 
    Private m_blnShowRecordSetContents As Boolean = False 'Show recordset contents ?

    '(Values set in GetDisaplyMode)
    Protected m_strMode As String = "" 'Mode to open the issue entry page
    Protected m_strAction As String = "" 'Action to be performed
    'Added by SandipL to solve IssueID 2131
    Protected m_blnProjectChanged As Boolean = False
    'End addition by SandipL 
    '(Values set in GetTImeSheetDetailsForIssue)
    Private m_blnShowTimesheetDetails As Boolean = False

    '(Value set in GetTimeSheetDetailsForIssue)
    Protected m_blnIssueNavigation As Boolean = False

    '' ParagD 5-Sept-2006
    Protected m_strblnShowToCustomer As String
    '' END : ParagD On 5-Sept-2006

    '(value set in GetIssueDetails)
    Private drIssueDetails As IDataReader

    '(value set in GetCurrentType)
    Private m_strCurrentType As String = ""

    '(value assigned in GetIssueLayout)
    Private m_intLayoutID As Long
    Private m_intMaxRows As Integer
    Private m_intMaxCols As Integer
    Private m_blnShowIssueAssignmentLink As Boolean = False

    Private m_intDiscussionThread_Count As Integer

    Private ArrCtlAttr(20) As String

    Protected dblDefaultWork As Double = 0
    Private blnReportedByCustomer As Boolean = False 'Reported by Customer ?

    Protected strOnloadClientScript As String

    Private strFieldValue As String = ""

    'Added By GaneshG on 08 Nov 06 -- Flag setting for Issue
    Protected m_strIssueSummary As String = ""
    'End Addition By GaneshG 
    ''Commented by Nilesh G on 9/10/2015 for change six=ze of array
    ''Private arrValidationMessages(30) As String
    Private arrValidationMessages(50) As String
    ''end of Commented by Nilesh G on 9/10/2015 for change six=ze of array

    Protected strEnableControlsScript As String

    Private arrEventHandlers(30, 3) As String

    Private strEventHandlers As String

    Protected strDefaultScript As String

    Protected strClientSideScript As String

    Private m_IssuePresent As Boolean = False

    Private m_blnAssignToChanged As Boolean = False

    Private m_blnShowToCustomer As Boolean = False

    Protected declarevariables As String = ""

    Private WithEvents objAttachmentsGrid As New WebPage.Templates.GenericGrid

    'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
    'Purpose: Not allow to do any activity if Project is not baselined 
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0

    'Addtion ended

    'added by VivekP on 2 Apr 2005 for copy functionality
    Private m_lngCopyIssueId As Long
    'end of addition
    'Added by HarshK for sp4 issueid 539
    Private m_strEmployeeID As String
    'End Added by HarshK for sp4 issueid 539

    'Added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through issue and review (IssueID: 683)
    Private blnCalledFromReview As Boolean = False
    Protected intReviewStatisticsID As Integer = 0
    Protected intReviewActionID As Integer = 0
    Private strProjectPhase As String = ""
    Private strReviewer As String = ""
    Private strReviewee As String = ""
    Private intEmployeeID As Integer = 0
    Private strReviewDate As String = ""
    Private strReviewType As String = ""
    Private m_intModuleID As Integer = 0
    Private strModuleName As String = ""
    Private strCause As String = ""
    Private strReviewAction As String = ""
    Private strSeverity As String = ""
    Private strCauseId As String = ""
    Private intDeliverableID As Integer = 0

    'Added by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
    Private strIssueIDs As String = ""
    Private drEmployee As IDataReader
    Private intAssignTo As Integer
    Protected strIssueAddedFrom As String
    'End Addition
    'Integrated by SandipL SP8 to SP9

    'Integrated by PrashantD on 2 March 2007 for Product Execution Project
    ' Added By NitinVS on 25 May 2006 for Roamware Customization
    ' Implementing Product execution

    Protected m_EnableProductExecution As Boolean = False
    Protected m_ProductVersionID As String = "0"
    Protected m_CustomerId As String = "0"
    Protected m_ComponentId As String = "0"
    Protected m_CustomerAtDeliverable As Boolean = False
    Protected m_ProductExecutionPractice As Boolean = False

    ' End Addition By NitinVS on 25 May 2006 for Roamware Customization
    'End of Integration by PrashantD on 2 March 2007

    'End Integration by SandipL SP8 to SP9
    'Integrated by AmitJ on 16 Aug 2006 for whizible SP 7.2 IssueID 2002
    'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
    Protected intIsCustomerChecked As String = "0"
    'End Integration by SavitaS
    'End Integration by AmitJ

    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Protected m_strTokenFlagToFollow As String = ""
    Protected m_strToken As String = ""
    Protected m_strToken1 As String = ""
    Protected m_PKTokenIssueID As String = ""
    Protected m_strToken_AddNewMode As String = ""
    Protected m_strIssueID As String = ""
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    'Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
    Protected m_FromReview As String = "0"
    Protected m_strFromReview As String = "0"
    'Integrated by SandipL SP8 to SP9
    'Added by SrikanthY on 26 Dec 2006
    Protected m_PKQueryToken As String
    Protected m_Queryid As String
    Protected m_Count As Integer = 0
    'End of Addition by SrikanthY
    'Added by SrikanthY on 22 Jan 2007
    Protected m_QuerySortBy As String
    Protected m_QuerySortOrder As String
    'End Integration by SandipL SP8 to SP9
    'Added by GaneshD on 04 Jun 2009 for Issue base statusflow configuration
    Protected m_IsConfStatusFlow As Int16
    Protected m_StatusFlowCount As Integer
    Protected m_IsIssueTypechanged As Integer
    Protected m_strAllStatusInStatusFlow As String = ""
    ' End of addition by GaneshD
    Protected m_EnableProjectProductExecution As Boolean
    'Added by PrashantD on 13 July 2007 for Hiding Save link when clicked
    Dim WithEvents objMenu As WebPage.Templates.StaticMenu
    'End of additon by PrashantD on 13 July 2007 

    'Server Date Time Related Variables
    Dim h As Integer = 0
    Dim m As Integer = 0
    Dim strHour As String = ""
    Dim strMinute As String = ""
    Dim strGetServerTimeSQL1 As String = ""
    Dim strGetServerTime1 As String = ""
    Dim strGetServerDateSQL1 As String = ""
    Dim strGetServerDate1 As String = ""

    'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
    Private IssueListSearchType As Int16
    Private IssueListSearchValue As String = "0"
    'Ended by ShraddhaM

    'Added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)
    Protected m_intFlag As String = "0"
    'End of added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)
    ''Added By Nilesh g on 28/3/2016 for PKToken Generation
    Protected mStrProjectID As String
    '' end of Added By Nilesh g on 28/3/2016 for PKToken Generation

#End Region ' Form level variables declaration

#Region " Public Procedures "

    ''added by Nilesh g on 2/2/2016 for url issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(IssueID As String, intFixInDays As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(IssueID, String) + CType(intFixInDays, String) + "0" + "0")
        Return m_PKToken_Request_Multiple
    End Function

    ''ENDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAddDeliverableToken(IssueID As String, EmployeeID As String) As String
        Dim m_PKToken_AddDeliverable As String
        m_PKToken_AddDeliverable = CommonFunctions.Security.Token.GetToken(CType(IssueID, String) + CType(EmployeeID, String) + "0" + "0")
        Return m_PKToken_AddDeliverable
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateAddDeliverableToken1(IssueID As String, EmployeeID As String) As String
        Dim m_PKToken_AddDeliverable As String
        m_PKToken_AddDeliverable = CommonFunctions.Security.Token.GetToken(CType(IssueID, String) + CType(EmployeeID, String) + "0" + "0")
        Return m_PKToken_AddDeliverable
    End Function
    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : Nonefromwhere
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for page

    Public Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name         : PlotPageHeadTag()	
        ' Purpose               : To plot page head tag on client side script
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================
        Call CommonFunction.General.PlotPageHeadTag("Issues")
    End Sub 'Plot Page Head tag

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : Main procedure to build issue entry page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================


        'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
        Call ReadXML()
        'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197

        If CommonFunction.Application.ShowIBCustomFieldOnSameScreen Then
            m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS
        Else
            m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS
        End If

        Dim strMenu As String

        'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
        If Not Request.QueryString("IssueListSearchType") Is Nothing And Request.QueryString("IssueListSearchType") <> "" Then
            IssueListSearchType = CType(Request.QueryString("IssueListSearchType"), Int16)
        Else
            IssueListSearchType = CType(Request.Form("IssueListSearchType"), Int16)
        End If

        If Not Request.QueryString("IssueListSearchValue") Is Nothing And Request.QueryString("IssueListSearchValue") <> "" Then
            IssueListSearchValue = CType(Request.QueryString("IssueListSearchValue"), String)
        Else
            IssueListSearchValue = CType(Request.Form("IssueListSearchValue"), String)
        End If
        'Ended by ShraddhaM

        'Integrated by SandipL SP8 to SP9
        'Added by SrikanthY on 26 Dec 2006
        If Trim(Request.QueryString("QueryToken") & "") <> "" Then
            m_PKQueryToken = Request.QueryString("QueryToken")
        End If

        If Trim(Request.QueryString("Queryid") & "") <> "" Then
            m_Queryid = Request.QueryString("Queryid")
        End If
        'End of Addition by SrikanthY
        'Added by SrikanthY on 22 Jan 2007 for getting Helpdesk page,sorting details
        If Not Session("ParentQuerySortBY") Is Nothing Then
            m_QuerySortBy = CType(Session("ParentQuerySortBY"), String)
        End If

        If Not Session("ParentQuerySortOrder") Is Nothing Then
            m_QuerySortOrder = CType(Session("ParentQuerySortOrder"), String)
        End If
        ''Added By Nilesh g on 28/3/2016 for PKToken Generation
        If Trim(Request.QueryString("ProjectID") & "") <> "" Then
            mStrProjectID = Request.QueryString("ProjectID")
        End If
        ''end of Added By Nilesh g on 28/3/2016 for PKToken Generation
        'end of addition by SrikanthY on 22 Jan 2007
        'End Integration by SandipL SP8 to SP9
        Call CreateGlobalObject()

        'Get Currently selected page number
        m_intPageNumber = GetPageNumber()

        'Added by SavitaS on 19 Sept 2006 for Security Issue 6197 
        'Get current IssueId
        m_lngIssueId = GetIssueId()
        Call GetDisplayMode()
        'Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494
        If Not Request.QueryString("Fromwhere") Is Nothing Then
            m_FromWhere = Request.QueryString("Fromwhere")
        Else
            m_FromWhere = ""
        End If
        'Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
        If Not Request.QueryString("FromReview") Is Nothing Then
            ' m_strFromReview = Request.QueryString("FromReview")
            If CType(Request.QueryString("FromReview"), String) = "1" Then
                m_strFromReview = "1"
            End If
        Else
            m_strFromReview = "0"
        End If
        If m_strFromReview = "1" Then
            blnCalledFromReview = True
        End If
        'End of Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509

        'End of Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494

        'Addition by SavitaS on 19 Sept 2006 for Security Issue 6197 
        'Code commented by SavitaS on 25 Sept 2006
        'm_strToken_AddNewMode = CommonFunctions.Security.Token.GetToken(CType(Session("IssueProject"), String) + CType(Session("intUserID"), String) + "0" + "0")
        'End of Code commented by SavitaS on 25 Sept 2006

        Dim strFromwhere As String = ""
        m_strToken = ""
        If Request.QueryString("strFlag") Is Nothing Then
            strFromwhere = Request.QueryString("strFlag")
        End If
        'Modified by SavitaS on 04 Oct 2006 
        'Purpose: If Issue belong to the project for which logged in user has not access then m_lngIssueId returned as '-1'
        If CType(m_lngIssueId, String) <> "-1" Then
            'End of Modified by SavitaS on 04 Oct 2006 
            If strFromwhere = "Issueonchange" Then
                m_lngIssueId = GetIssueId()
                If Not Request.QueryString("PKToken") Is Nothing Then
                    m_strToken = Request.QueryString("PKToken").ToString
                End If
            Else

                If CType(m_lngIssueId, String) <> "0" Then
                    If Request.QueryString("PKToken") Is Nothing Then
                        ''commented and added by ShraddhaM on 4,Sep 2007
                        'crash on PM Dashboardh enhanced view --> By issue type graph
                        'm_strToken = Request.Form("txtPkToken").ToString
                        m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + "0" + "0")
                        ''End of comment and addition by ShraddhaM on 4,Sep 2007
                    Else

                        m_strToken = Request.QueryString("PKToken").ToString
                    End If
                End If
            End If
            m_strTokenFlagToFollow = CommonFunctions.Security.Token.GetToken(CType(m_ProjectId, String) + CType(Session("intUserID"), String) + "0" + "0" + CType(m_lngIssueId, String))
            m_strToken1 = CommonFunctions.Security.Token.GetToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + "0" + "0")
            ''Added by Yogesh J on 28-Jan to validate token for Project ID
            If Not Request.QueryString("ProjectID") Is Nothing Then
                If CType(m_lngIssueId, String) <> "0" And Request.QueryString("FromWhere") = "SR" Then
                    If ((m_strToken = "") And (m_lngIssueId.ToString <> "0")) Or _
             ((m_lngIssueId.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + CType(m_ProjectId, String) + CType(m_Queryid, String) + "0" + "0", m_strToken) = False)) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Entry", 0, 0, "Issue ID", CType(m_lngIssueId, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If

                End If

            Else
                ''End of Addition by Yogesh J on 28-Jan to validate token for Project ID
                If CType(m_lngIssueId, String) <> "0" Then
                    If ((m_strToken = "") And (m_lngIssueId.ToString <> "0")) Or _
             ((m_lngIssueId.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + "0" + "0", m_strToken) = False)) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Entry", 0, 0, "Issue ID", CType(m_lngIssueId, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
            End If
        End If
        'End Addition by SavitaS on 19 Sept 2006 for Security Issue 6197 

        'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
        'Purpose: Not allow to do any activity if Project is not baselined

        'commented by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
        'If Session("intProjectID") Is Nothing Then

        'added by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
        If CType(Session("IssueProject"), Long) > 0 Then
        Else
            If Session("IssueProject") IsNot Nothing Then 'Added By Vaijat K ON 10/12/2015 Issue ID-2723
                'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(Session("IssueProject").ToString, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

                Dim strQuery As String = ""
                Dim drProjectStatus As IDataReader

                'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("IssueProject").ToString

                drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                    If drProjectStatus.Read() Then
                        m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drProjectStatus)
            End If
        End If
        'Addtion ended
        'Added by HarshK for sp4 issueid 539
        m_strEmployeeID = CStr(Session("intUserID"))
        'End Added by HarshK for sp4 issueid 539

        '-------------------------------------------------------------------------
        'Added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through issue and review.(IssueID: 683)
        If Not Request.QueryString("ReviewStatisticsID") Is Nothing Then
            If Request.QueryString("ReviewStatisticsID") <> "" Then
                If CType(Request.QueryString("ReviewStatisticsID"), Integer) > 0 Then
                    blnCalledFromReview = True
                    Call GetReviewDetails()
                End If
            End If
        End If
        'end of addition by AniruddhaD on 16 Nov 2005

        If Not Request.QueryString("ReviewType") Is Nothing Then
            If Request.QueryString("ReviewType") <> "" Then
                strIssueAddedFrom = Request.QueryString("ReviewType")
            End If
        End If
        '-------------------------------------------------------------------------

        'Get current IssueId
        'Commented and Added above by SavitaS on 19 Sept 2006 for Security Issue 6197 
        ' m_lngIssueId = GetIssueId()
        'End of Commented and Added above by SavitaS on 19 Sept 2006 for Security Issue 6197 

        '' START : Modified BY ParagD On 5-Sept-2006
        '' Purpose : Whizible SP7 Issue : To persist ShowToCustomer flag for Issue
        If Not Request.QueryString("ShowToCustomer") Is Nothing Then
            m_strblnShowToCustomer = Request.QueryString("ShowToCustomer").ToString
        Else
            m_strblnShowToCustomer = "0"
        End If
        '' END : Modified BY ParagD On 5-Sept-2006


        'Added by MrugajaB on 8th Aug 2006 for Whiziblesem SP7 Issue ID.4262
        'Purpose:To check value of 'Project level Issue SLA' field

        Dim drIssueProject As IDataReader
        Dim lngIssueProject As Long

        If m_lngIssueId > 0 Then
            drIssueProject = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue " + CType(m_lngIssueId, String), MyBase.UseSQL)
            If drIssueProject.Read Then
                lngIssueProject = CType(CommonFunctions.Data.CheckIsDBNull(drIssueProject("ProjectID"), "0"), Long)
            End If
        Else
            If Session("IssueProject") Is Nothing Then
                If Session("intProjectID") Is Nothing Then
                    lngIssueProject = 0
                Else
                    lngIssueProject = CType(Session("intProjectID"), Integer)
                End If
            Else
                lngIssueProject = CType(Session("IssueProject"), Integer)
            End If
        End If

        If lngIssueProject > 0 Then
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'm_IsIssueSLAApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT IsIssueSLAApplicable FROM tbl_PM_Project WHERE ProjectID= " & lngIssueProject.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
            m_IsIssueSLAApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_IsIssueSLAApplicable " & lngIssueProject.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        End If

        'End Addition

        If m_lngIssueId = -1 And Request.QueryString("Goto") = "1" Then
            Exit Sub
        End If

        'Get sorting details
        Call GetSortingDetails()

        'Get Current ProjectId and ROleId
        Call GetProjectIdAndRoleId()
        'Integrated by SandipL SP8 to SP9
        'Integrated by PrashantD on 2 March 2007 for Product Execution Project		' Added By NitinVS on 23 May 2006 for Roamware Customization
        ' Implementing Product execution
        'Modified by ArchanaN on 7 Jun 2007 for Regression Testing - issueId 13328
        ' m_EnableProductExecution = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT IsNull( EnableProductExecution ,0) FROM Tbl_PM_CompanyInformation ", MyBase.UseSQL), "0"), Boolean)

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'm_EnableProductExecution = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT IsNull( EnableProductExecution ,0) FROM Tbl_PM_CompanyInformation ", MyBase.UseSQL), "0"), Boolean)
        m_EnableProductExecution = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_CompanyInformation_EnableProductExecution ", MyBase.UseSQL), "0"), Boolean)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If m_EnableProductExecution = True Then
            m_EnableProjectProductExecution = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC ups_sel_Product_workFlow " + m_ProjectId.ToString, MyBase.UseSQL), "0"), Boolean)
            m_EnableProductExecution = m_EnableProjectProductExecution
        End If
        'End by ArchanaN

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'm_CustomerAtDeliverable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT IsNull(DeliverableLevelCustomer,0) FROM tbl_PM_Project WHERE ProjectID =  " + m_ProjectId.ToString, MyBase.UseSQL), "0"), Boolean)
        m_CustomerAtDeliverable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_DeliverableLevelCustomer " + m_ProjectId.ToString, MyBase.UseSQL), "0"), Boolean)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        m_ProductExecutionPractice = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_get_ProductExecutionProject " + m_ProjectId.ToString, MyBase.UseSQL), "0"), Boolean)
        ' End Addition By NitinVS on 23 May 2006 for Roamware Customization
        'End of Integration by PrashantD on 2 March 2007


        'End Integration by SandipL SP8 to SP9
        'Commented and Added above by SavitaS on 25 Sept 2006
        'Get Display mode
        'Call GetDisplayMode()
        'End of Commented and Added above by SavitaS on 25 Sept 2006

        'Get TImesheet Details for the Issue
        Call GetTimeSheetDetailsForIssue()

        'Don't call these functions in save and ImportIssue mode, as they will be called after saving issue.
        'If m_strAction.ToUpper <> "SAVE" And m_strAction.ToUpper <> "IMPORTISSUE" Then
        'Get Issue details
        Call GetIssueDetails()

        'Get current type
        Call GetCurrentType()
        'End If

        'Get Layout to be applied
        Call GetIssueLayout()

        If m_strAction.ToUpper = "SAVE" Or m_strAction.ToUpper = "IMPORTISSUE" Then
            Call SaveIssue() 'Save Issue
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
            Call GetIssueDetails() 'Get details of newly saved / edited issue
            Call GetCurrentType() 'Get current type
        ElseIf m_strAction.ToUpper = "DELETEATTACHMENTS" Then
            'Added by SavitaS on 19 Sept 2006 for Security Issue 6197	  
            If ((m_strToken = "") And (CType(m_lngIssueId, String) <> "0")) Or _
            ((CType(m_lngIssueId, String) <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_strToken) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Delete Attachment", 0, 0, "Issue ID", CType(m_lngIssueId, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            'Added by SavitaS on 19 Sept 2006 for Security Issue 6197	  
            Call DeleteAttachments() 'Delete issue assignments
        End If

        'Show Attachment (show assignment when clicked on it.)
        If Not Request.QueryString("AttachmentID") Is Nothing Then

            If Request.QueryString("AttachmentID") <> "" Then
                Dim FileName As String
                'Added By AmitJ On 02-July-2010 
                'Purpose:Original File Name should not be passed  as system filename to view attachemt page.Encrypted file name should be passed thr querystring.
                ' FileName = CommonFunction.General.funcReturnOriginalFileName("BTS", CType(Request.QueryString("AttachmentID"), Long))
                Dim drFile As IDataReader
                Dim strOrigialFileName As String
                Dim strSystemFileName As String

                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'drFile = CommonFunction.Data.GetDataReader("Select OriginalFileName,FilePath from tbl_IB_Attachments where OriginalFileName IS NOT NULL AND IssueId=" + m_lngIssueId.ToString + "And AttachmentID=" + Request.QueryString("AttachmentID").ToString, MyBase.UseSQL)
                drFile = CommonFunction.Data.GetDataReader("usp_sel_tbl_IB_Attachments_OriginalFileName " + m_lngIssueId.ToString + "," + Request.QueryString("AttachmentID").ToString, MyBase.UseSQL)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                If drFile.Read Then
                    strOrigialFileName = CommonFunction.Data.CheckIsDBNull(drFile("OriginalFileName"), "").ToString
                    strSystemFileName = CommonFunction.Data.CheckIsDBNull(drFile("FilePath"), "").ToString
                End If
                CommonFunction.Data.DisposeDataReader(drFile)
                '  End Of Addition By Amitj


                'Integrated by PrashantSJ on 06 Nov 2006
                'Purpose: For Multi attachement Enhacements
                'Added by PrashantD for getting All attached files in zip

                'Dim drFile As IDataReader
                'Dim Ori_Files(0) As String
                'Dim Eny_Files(0) As String

                'drFile = CommonFunction.Data.GetDataReader("Select OriginalFileName,FilePath from tbl_IB_Attachments where OriginalFileName IS NOT NULL AND IssueId=" + m_lngIssueId.ToString, MyBase.UseSQL)
                'If drFile.Read Then
                '    Ori_Files(0) = drFile(0).ToString
                '    Eny_Files(0) = drFile(1).ToString
                'End If
                'While drFile.Read
                '    ReDim Preserve Ori_Files(Ori_Files.Length)
                '    ReDim Preserve Eny_Files(Eny_Files.Length)
                '    Ori_Files(Ori_Files.Length - 1) = drFile(0).ToString
                '    Eny_Files(Eny_Files.Length - 1) = drFile(1).ToString
                'End While

                'FileName = CommonFunction.ZipUtils.GetZipFile(Ori_Files, Eny_Files, "BTS")
                'End of addition by PrashantD
                'End of Integration by PrashantSJ on 06 Nov 2006
                If strSystemFileName <> "" Then
                    'Commented & Added By AmitJ On 02-July-2010 
                    'Purpose:Original File Name should not be passed  as system filename to view attachemt page.Encrypted file name should be passed thr querystring.
                    'strOnloadClientScript = strOnloadClientScript + "window.open(""../General/ViewAttachment.aspx?FileName=" + Server.UrlEncode(FileName) + "&FromWhere=BTS"");"
                    strOnloadClientScript = strOnloadClientScript + "window.open(""../General/ViewAttachment.aspx?FileName=" + Server.UrlEncode(strOrigialFileName) + "&SystemFileName=" + Server.UrlEncode(strSystemFileName) + "&FromWhere=BTS"");"
                    'End Of Modification By AmitJ
                End If
            End If
        End If

        'Generate menu
        strMenu = GenerateMenu() 'Generate menu for Issue entry page
        Response.Write(strMenu)

        Response.Write("<DIV id=DivMain style='overflow:auto;width:99.9%;height:485px'>")

        'Generate Page Legends
        Call GeneratePageLegends()

        'Generate IssueDetails section
        Call GenerateIssueDetailsSection()

        'Generate Keywords section
        Call GenerateKeywordsSection()


        'Generate Attachments section
        Call GenerateAttachmentsSection()

        'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
        Response.Write("<input type=hidden name='IssueListSearchType' id='IssueListSearchType' value='" + IssueListSearchType.ToString() + "' >")
        Response.Write("<input type=hidden name='IssueListSearchValue' id='IssueListSearchValue' value='" + IssueListSearchValue + "' >")
        'Ended by ShraddhaM


        Response.Write("</DIV>")

        Response.Write("<BR>" + strMenu)

        CommonFunction.Data.DisposeDataReader(drIssueDetails)

    End Sub 'Main procedure to build IssueEntry page

    Public Sub PopulateDefaultValues()
        Response.Write(vbCrLf + "PopulateDefaultValues();" + vbCrLf)
    End Sub
#End Region ' All public procedures used in code

#Region " Private Procedures "

    Private Sub GenerateIssueCode(ByVal IssueID As Long)
        Dim strSQL As String, strIsseCode As String
        strSQL = "EXEC usp_Sel_tbl_IB_Issue_GenerateIssueCode " + IssueID.ToString
        strIsseCode = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")

        If strIsseCode = "" Then Exit Sub

        strSQL = "update tbl_IB_Issue set IssueCode = '" + strIsseCode + "' WHERE IssueID = " + IssueID.ToString
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
    End Sub

    Private Sub DeleteAttachments()
        '=====================================================================
        ' Procedure Name        : DeleteAttachments()	
        ' Purpose               : To delete issue attachments
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 13, 2004
        ' Revisions             :  PramodA   on 18th November 2004
        '                           - Previously the flow for deletion of attachments
        '                             was first delete the record and then the file...
        '                             but in this flow there was bug that files were not getting 
        '                             deleted permanently...NCS Issue # 13996 (HotFix 4.0.72)
        '                           - Changes were made that first delete the file & then the records
        '                           Integration of solution in WhizibleSEM done by MrugajaB on 28th Feb,2005
        '                           For Issue ID.16459
        '=====================================================================

        Dim strSQLQuery As String, inti As Integer, drAttachments As IDataReader

        'Exit procedure if no issues to delete
        If MyBase.GetFormValue("ChkDelete") Is Nothing Or MyBase.GetFormValue("ChkDelete") = "" Then Exit Sub

        'Commented By MrugajaB on 28th Feb,2005 for Issue ID.16549
        'This code is placed at the end of this sub
        ' Build the query to delete the selected attachments in the database.
        'strSQLQuery = "Exec usp_Del_tbl_IB_Attachments NULL, '" + MyBase.GetFormValue("ChkDelete") + "'"

        'Actually delete form database
        'CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        'End Comment

        'Exit sub if Physical deletion of attachments is set to false.

        'If CommonFunction.Application.PhysicalDeletionOfDocuments = False Then Exit Sub

        'Code added by MrugajaB on 28th Feb,2005 for Issue ID.16549
        'If condition added to check whether corporate level flag for physical deletion of documents is checked
        If CommonFunction.Application.PhysicalDeletionOfDocuments = True Then
            'Delete attachments physically
            Dim AttachmentPath As String
            Dim Attachment As System.IO.File

            'Split Attachment Ids in an array
            Dim AttachmentIds() As String = Split(MyBase.GetFormValue("ChkDelete"), ",")

            'Loop through the array
            For inti = 0 To UBound(AttachmentIds)

                'Get attachment details
                drAttachments = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Attachments NULL," + AttachmentIds(inti).Trim, MyBase.UseSQL)
                While drAttachments.Read

                    ' Delete the original file.
                    If drAttachments("OriginalFileName").ToString <> "" Then
                        AttachmentPath = Server.MapPath("../../Attachments/BTS/") + "\" & drAttachments("OriginalFileName").ToString
                        If Attachment.Exists(AttachmentPath) Then
                            Attachment.Delete(AttachmentPath)
                        End If
                    End If

                    ' Delete the copy of  file.
                    If drAttachments("FilePath").ToString <> "" Then
                        AttachmentPath = Server.MapPath("../../Attachments/BTS/") + "\" & drAttachments("FilePath").ToString
                        If Attachment.Exists(AttachmentPath) Then
                            Attachment.Delete(AttachmentPath)
                        End If
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drAttachments)
            Next
        End If

        'Code added by MrugajaB on 28th Feb,2005 for Issue ID.16549
        'The SP for deletion of attachment records from database is called from here, instead of calling it before                  physical deletion code
        ' Build the query to delete the selected attachments in the database.
        strSQLQuery = "Exec usp_Del_tbl_IB_Attachments NULL, '" + MyBase.GetFormValue("ChkDelete") + "'"

        'Actually delete form database
        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        'End Addition
    End Sub 'Delete Issue Attachment(s)

    Private Sub SaveIssue()
        '=====================================================================
        ' Procedure Name        : SaveIssue()	
        ' Purpose               : To save / import issue
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strDatabaseQuery, strFieldList, strValueList As String
        Dim drIssueFields As IDataReader, IssueId As Long
        Dim intUpperBound As Integer

        m_blnAssignToChanged = False

        ' Retrieve the list of fields in the Issue Table for ganerating Hash Table

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT * FROM tbl_IB_Issue WHERE 1=2"
        strSQL = "usp_sel_tbl_IB_Issue_1"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'Generate Hash table.
        Dim ht As New System.Collections.Hashtable
        ht = CommonFunctions.Data.GetSchema(strSQL, MyBase.UseSQL)

        strDatabaseQuery = ""

        ' New Issue - Generate Insert Query 
        If m_lngIssueId = 0 Then

            m_blnShowToCustomer = False

            ' Generate the Insert Query.
            strDatabaseQuery = strDatabaseQuery & "INSERT INTO tbl_IB_Issue "

            'Modified by MrugajaB on 25th Feb 2006 for Isue ID.2395
            'When Issue is added through reviews using 'Add Issue' link then ReviewActionID was not getting added
            strFieldList = "ProjectID, CreatorOrModifier, LoginType,ReviewActionID"
            strValueList = m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_UserName) + "', '" + m_LoginType + "'"
            strValueList = strValueList & ",'" + Request.QueryString("ReviewActionID") & "'"
            'End Modification

            'No hash table to be created as no data present in sql for txtWorkInHours (Appended last in form conditionally)
            'Hence determine upper bound
            Dim inti As Integer
            If Not MyBase.GetFormValue("txtWorkInHours") Is Nothing Then
                intUpperBound = Request.Form.AllKeys.Length - 1
            Else
                intUpperBound = Request.Form.AllKeys.Length
            End If

            ' loop through each element in the form 
            'Omit first 5 controls on the form as they are static and no hash table can be created for them.

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
            'Added By PradipK on 13 March 2006 for SLA Management
            '  For inti = 8 To intUpperBound   'Value of inti changed from 6 to 8 by MrugajaB on 11th May 2005
            'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support
            Dim iCounter As Integer
            If InStr(CType(Request.ServerVariables("HTTP_USER_AGENT"), String), "Internet Explorer") > 0 Then
                iCounter = 14
            Else
                iCounter = 12
            End If
            'Modification Ends by SantoshK on June 6, 2006

            For inti = iCounter To intUpperBound

                'End Addition By PradipK on 13 March 2006 for SLA Management
                'Do nothing for "PriorityFixInDays", "txtOldAssignedTo" and "txtWorkInHours" as they are static and hidden 
                'Controls add in the form and no hash table to be crated for them as no data is available in SQL for these controls
                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672 
                'Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                'If Request.Form.GetKey(inti).ToUpper = "TXTOLDSTATUS" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDSTATUS" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'Exit loop if counter exceeds upperbound
                    If inti > intUpperBound Then Exit For
                End If

                'Added by ShraddhaM for Filter changes
                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHTYPE" Then
                    inti += 1

                    If inti > intUpperBound Then Exit For
                End If

                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHVALUE" Then
                    inti += 1

                    If inti > intUpperBound Then Exit For
                End If

                'Ended by ShraddhaM

                'Added by SavitaS on 26 Sept for SP7 IssueID 4887
                If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" And m_LoginType = "C" Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'Exit loop if counter exceeds upperbound
                    If inti > intUpperBound Then Exit For
                    'Added by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                    'If Show to Customer checkbox is checked and save the issue Page crashes
                    If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                        inti += 1
                        'exit loop if counter excceds upper bound
                        If inti > intUpperBound Then
                            Exit For
                        End If
                    End If
                    'End Addition by SavitaS on 27 Sept 2006
                End If
                'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                'Integrated/Added by GaneshD on 04 Jun 2009 for Issue Base Statusflow configuration
                If Request.Form.GetKey(inti).ToUpper = "TXTOLDSTATUS" Then
                    inti += 1
                    If inti > intUpperBound Then Exit For
                End If
                ' End of Addition by GaneshD

                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                'Modified and integrated by GaneshD for Issue Base StatuFlow configuration
                'objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)
                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHTYPE" OrElse Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHVALUE" OrElse Request.Form.GetKey(inti).ToUpper = "CMBSTATUS" Or Request.Form.GetKey(inti).ToUpper = "CMBPREVSTATUS" Then
                Else
                    objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)
                End If
                'End of integration by GaneshD on 04 Jun 2009

                'Check if Responsible person is changed
                If Request.Form.GetKey(inti) = "AssignTo" Then
                    m_blnAssignToChanged = True
                End If

                'omit IssueId from query, as it is identity key in the table. 
                If Request.Form.GetKey(inti) <> "IssueID" Then

                    ' If the "ShowToCustomer" check box is found in the form, set the flag to indicate the same.
                    If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                        m_blnShowToCustomer = True
                    End If

                    ' Check if the name of the form item, is a valid field in the Issue table. If yes, then proceed.
                    If IsValidField(drIssueFields, Request.Form.GetKey(inti)) Then
                        'Added by Harshada D on 04 June 2005 Jubilant Issue Id 19220
                        If CheckCustomFieldAccess(Request.Form.GetKey(inti)) Then
                            'end of Addition by Harshada D on 04 June 2005 Jubilant Issue Id 18796
                            ' Get the field name.
                            strFieldList = strFieldList + ", " + Request.Form.GetKey(inti)

                            ' Get the field value.
                            If MyBase.GetFormValue(Request.Form.GetKey(inti)) = "" Then
                                ' If the field value is blank, then insert NULL.
                                strValueList += ", NULL"

                                ' If the field is any of the following, then their corporate values must be stored as well.

                                'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                                'Code Added By PradipK for Complexity
                                If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                                    strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                                    strValueList = strValueList + ", '" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                                End If
                            Else
                                'Added/integrated by GaneshD on 04 Jun 2009 For Issue BAse StatusFlow configuration
                                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHTYPE" OrElse Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHVALUE" OrElse Request.Form.GetKey(inti).ToUpper = "CMBSTATUS" Or Request.Form.GetKey(inti).ToUpper = "CMBPREVSTATUS" Then
                                Else
                                    'End of addition by GaneshD on 04 Jun 2009 
                                    ' If the field data-type is either integer/boolean/double, then...
                                    If objSchema.DataType.Trim.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.DOUBLE" Then
                                        'Set value for ShowToCustomer
                                        'Code Commented By DipaliS 19 July 2004 to resolve issue 11990 and added the following
                                        'Added the check..if it is the check box for Show To Customer , then only append 1
                                        'else append the form value
                                        'If m_blnShowToCustomer Then
                                        If m_blnShowToCustomer And Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                                            'End Addition by DipaliS
                                            strValueList = strValueList + ", 1"
                                        Else
                                            'Added by PrachiK on 17 Mar  2005 for IssueID 16918
                                            'Purpose:Issue Entry Page crashes while assigning task to responsible person if EmployeeID  is greater than 1000
                                            'strValueList = strValueList + ", " + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                                            strValueList = strValueList + ", " + (MyBase.GetFormValue(Request.Form.GetKey(inti)))
                                            'Addtion ended
                                        End If
                                    Else 'For other data types
                                        If InStr(Request.Form.GetKey(inti).Trim, "CustomFieldCombo") <> 0 Then
                                            strValueList = strValueList + ", '" + Left(MyBase.GetFormValue(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                                        Else
                                            strValueList = strValueList + ", '" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                                        End If

                                        ' If the field is any of the following, then their corporate values must be stored as well.

                                        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                                        'Code Added By PradipK for Complexity
                                        If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                                            strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                                            strValueList = strValueList + ", '" & GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) & "'"
                                        End If
                                    End If
                                    'Added by GaneshD on 04 Jun 2009 For Issue Base Statusflow configuration
                                End If
                                'Addition End by GaneshD
                            End If
                        End If
                    End If
                End If
                objSchema = Nothing
            Next

            ' If the ShowToCustomer control was not displayed, then
            If m_blnShowToCustomer = False Then
                strFieldList = strFieldList + ", ShowToCustomer"
                ' If the customer has logged in, then by default this value must be set to True.
                If m_LoginType = "C" Then
                    strValueList = strValueList + ", 1"
                Else
                    strValueList = strValueList + ", 0"
                End If
            End If
            'Added by GaneshD on 04 Jun 2009 For Issue Base StatusFlow configuration
            strFieldList = strFieldList.Replace(", CmbStatus", "")
            strFieldList = strFieldList.Replace(", CmbPrevStatus", "")

            'Addition End by GaneshD
            'generate database query to be executed, from fields list and values list
            strDatabaseQuery = strDatabaseQuery + "( " + strFieldList + " ) VALUES ( " + strValueList + " )"

            'append for getting Issue Id of newly created Issue
            strDatabaseQuery += "; Select SCOPE_IDENTITY()"

            'Get newly added IssueId by executing the query.
            IssueId = CType(CommonFunction.Data.GetDataScalar(strDatabaseQuery, MyBase.UseSQL), Long)

            'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)
            m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If m_intFlag = "1" Then
                Dim dtScrumIssue As DataTable
                Dim strScrumIssue As String
                Dim strInsScrumIssue As New StringBuilder
                Dim counter As Integer = 0
                strScrumIssue = "SELECT ProjectID,IssueID,''''+Summary+'''',''''+Convert(nvarchar(500),Description)+'''',''''+Type+'''',''''+ISNULL(SubType,' ')+'''',''''+Status+'''',  "
                strScrumIssue += "''''+ISNULL(Priority,' ')+'''',''''+Convert(nvarchar(100),ReportedDate)+'''',ReleaseID,IterationID,"
                strScrumIssue += "UserStoryID,''''+'Map'+'''' FROM tbl_IB_Issue WITH(NOLOCK) WHERE IssueID = " + CType(IssueId, String)
                dtScrumIssue = CommonFunction.Data.GetDataTable(strScrumIssue, MyBase.UseSQL)
                strInsScrumIssue.Append("Exec usp_INS_tbl_PM_ScrumIssue ")
                Dim intLoopIndex As Integer
                For intLoopIndex = 0 To dtScrumIssue.Columns.Count - 1
                    ''Commented and Added by Dhanashri S on 24 Feb 2015 for Error occuring after adding issue for Agile Project
                    'strInsScrumIssue.Append(dtScrumIssue.Rows(0)(intLoopIndex).ToString())
                    If dtScrumIssue.Rows(0)(intLoopIndex).ToString() = "" Then
                        strInsScrumIssue.Append("NULL")
                    Else
                        strInsScrumIssue.Append(dtScrumIssue.Rows(0)(intLoopIndex).ToString())
                    End If
                    strInsScrumIssue.Append(",")
                    ''End of comment and Addition by Dhanashri S on 24 Feb 2015
                Next intLoopIndex
                CommonFunction.Data.InsertOrUpdateData(strInsScrumIssue.ToString.Substring(0, strInsScrumIssue.Length - 1), MyBase.UseSQL)
            End If
            'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)

            '------------------------------------------------------------------------------------
            'Added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through issue and review (IssueID: 683)
            'Update review actions table with new IssueID
            CommonFunction.Data.InsertOrUpdateData("usp_upd_tbl_PM_ReviewActions_IssueID " + intReviewActionID.ToString + "," + IssueId.ToString, MyBase.UseSQL)

            'Checking if this page is called from Add issue or Save as Issue Link.    
            If blnCalledFromReview = True Then
                If strIssueAddedFrom = "FTR" Then
                    'Refresh parent 
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=2191&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
                ElseIf strIssueAddedFrom = "Reviews" Then

                    'Refresh parent 
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=1026&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
                End If
            End If
            'end addition by AniruddhaD on 16 Nov 2005 for having common page for issue entru through issue and review
            '------------------------------------------------------------------------------------

            'Send mail - New Issue posted
            'Integrated by SandipL SP8 to SP9
            Call FreshParent()
            'End Integration by SandipL SP8 to SP9
            Call SendMail(8, IssueId)

            'Reset IssueID - To get details of new Issue and refresh the page after saving.
            m_lngIssueId = IssueId

            'Call GenerateIssueCode(m_lngIssueId)

        Else 'Update existing Issue

            Dim drProject, drDummy As IDataReader, strSQLQuery As String

            'Determine if History of the project is enabled.
            drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + m_ProjectId.ToString, MyBase.UseSQL)
            If drProject.Read Then
                If CType(drProject("IBHistoryOn"), Boolean) = True Then
                    ' If the Description field has changed, then log the changes in the History table.			

                    ' Modified By NitinVS on 18 Oct 2005 for WhizibleSEM SP4 IssueID 502 
                    ' Added Checkisnothing 
                    If StrComp(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtOldDescription"), "").Trim, CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("Description"), "")) <> 0 Then
                        ' End Modification By NitinVS on 18 Oct 2005 for WhizibleSEM SP4 IssueID 502 

                        strSQLQuery = "Exec usp_Ins_tbl_IB_History_InsertTextFields " + m_lngIssueId.ToString + ", 'Description', '" + CommonFunction.General.BuildQueryString(m_UserName) + "', '" + MyBase.GetFormValue("txtOldDescription") + "', '" + MyBase.GetFormValue("Description") + "'"
                        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                    End If
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drProject)

            ' Generate the Update Query.
            strDatabaseQuery = strDatabaseQuery & "UPDATE tbl_IB_Issue SET CreatorOrModifier = '" & CommonFunction.General.BuildQueryString(m_UserName) & "'"

            Dim drStatus, drEmailMessage As IDataReader
            Dim inti As Integer
            If Not MyBase.GetFormValue("txtWorkInHours") Is Nothing Then
                'No hash table to be created as no data present in sql for txtWorkInHours (Appended last in form conditionally)
                intUpperBound = Request.Form.AllKeys.Length - 1
            Else
                intUpperBound = Request.Form.AllKeys.Length
            End If

            'Omit first 6 controls on the form as they are static and no hash table can be created for them.

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
            'Code Added By PradipK on 17 Feb 2006
            'Value of initi is changed from 7 to 11 as CurrentDate & CurrentTime is plotted as hidden.
            'For inti = 7 To intUpperBound

            'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support
            Dim iCounter As Integer
            If InStr(CType(Request.ServerVariables("HTTP_USER_AGENT"), String), "MSIE") > 0 Then
                iCounter = 14
            Else
                iCounter = 12
            End If
            'Modification Ends by SantoshK on June 6, 2006

            For inti = iCounter To intUpperBound

                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672 
                'Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                'If Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'exit loop if counter excceds upper bound
                    If inti > intUpperBound Then Exit For
                End If

                'Added by ShraddhaM for Filter changes
                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHTYPE" Then
                    inti += 1

                    If inti > intUpperBound Then Exit For
                End If

                If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHVALUE" Then
                    inti += 1

                    If inti > intUpperBound Then Exit For
                End If

                'Ended by ShraddhaM

                'Added by SavitaS on 26 Sept for SP7 IssueID 4887
                If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" And m_LoginType = "C" Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'Exit loop if counter exceeds upperbound
                    If inti > intUpperBound Then
                        Exit For
                    End If
                    'Added by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                    'If Show to Customer checkbox is checked and save the issue Page crashes
                    If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                        'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                        inti += 1
                        'exit loop if counter excceds upper bound
                        If inti > intUpperBound Then
                            Exit For
                        End If
                    End If
                    'End Addition by SavitaS on 27 Sept 2006 
                End If
                'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887

                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)

                If Request.Form.GetKey(inti) = "AssignTo" Then
                    m_blnAssignToChanged = True
                End If

                'Check whether status of current Issue has been changed
                If Request.Form.GetKey(inti) = "Status" Then
                    If MyBase.GetFormValue("txtOldStatus") <> MyBase.GetFormValue(Request.Form.GetKey(inti)) Then
                        strSQLQuery = "SELECT * FROM tbl_IB_Project_Type_Status WHERE ProjectID = " + m_ProjectId.ToString + " AND Type = '" + MyBase.GetFormValue("Type") + "' "
                        'modified by SnehalV for For SP7 BFT Issues Integration on 3rd Oct 2006
                        'Commented And Modified By JyotiG
                        'SearchKey : JG_7198_26-Oct-2006
                        'Start
                        'strSQLQuery = strSQLQuery + "AND Status = '" + CommonFunctions.General.BuildQueryString(MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                        strSQLQuery = strSQLQuery + "AND Status = '" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                        'End Of Modication By JyotiG
                        'end of modification
                        drStatus = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                        If drStatus.Read Then
                            'Send mail if mail has to be changed and status has been changed
                            If CType(drStatus("SendMail"), Boolean) = True Then
                                'Integrated by SandipL SP8 to SP9
                                Call FreshParent()
                                'End Integration by SandipL SP8 to SP9
                                Call SendMail(34, m_lngIssueId) 'Issue status changed
                            End If
                        End If
                        CommonFunction.Data.DisposeDataReader(drStatus)
                    End If
                End If

                'omit IssueId from query, as it is identity key in the table. 
                If Request.Form.GetKey(inti) <> "IssueID" And Request.Form.GetKey(inti) <> "cboIssue" Then

                    If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                        m_blnShowToCustomer = True
                        inti += 1
                        'exit loop if counter excceds upper bound
                        If inti > intUpperBound Then
                            Exit For
                        Else
                            'Modified by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                            'If Show to Customer checkbox is checked and save the issue Page crash
                            If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                                'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                                inti += 1
                                'exit loop if counter excceds upper bound
                                If inti > intUpperBound Then
                                    Exit For
                                End If
                            End If
                            objSchema = Nothing
                            objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)
                        End If
                    End If

                    'End of Commented and Modified by SavitaS on 27 Sept 2006

                    ' Check if the name of the form item, is a valid field in the Issue table. If yes, then proceed.
                    If IsValidField(drIssueFields, Request.Form.GetKey(inti)) Then
                        'Added by Harshada D on 04 June 2005 Jubilant Issue Id 19220
                        If CheckCustomFieldAccess(Request.Form.GetKey(inti)) Then
                            'end of Addition by Harshada D on 04 June 2005 Jubilant Issue Id 18796
                            ' Get the field name.
                            If objSchema IsNot Nothing Then ' Added By Vaijat K On 04/11/2015
                                strDatabaseQuery = strDatabaseQuery + ", " + Request.Form.GetKey(inti) + " = "
                            End If
                            ' If the field value is blank, then insert NULL.
                            If Not MyBase.GetFormValue(Request.Form.GetKey(inti)) Is Nothing Then
                                If MyBase.GetFormValue(Request.Form.GetKey(inti)) = "" Then
                                    strDatabaseQuery = strDatabaseQuery & "NULL"
                                Else
                                    ' If the field data-type is either integer/boolean/double, then...
                                    'Added by GaneshD on 04 Jun For Issue Base Status Flow configuration
                                    If Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHTYPE" OrElse Request.Form.GetKey(inti).ToUpper = "ISSUELISTSEARCHVALUE" OrElse Request.Form.GetKey(inti).ToUpper = "CMBSTATUS" Or Request.Form.GetKey(inti).ToUpper = "CMBPREVSTATUS" Then
                                    Else
                                        'End of addition by GaneshD
                                        If objSchema IsNot Nothing Then 'Added By Vaijat K ON 04/11/2015
                                            If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                                                'Added by PrachiK on 17 Mar  2005 for IssueID 16918
                                                'Purpose:Issue Entry Page crashes while assigning task to responsible person if EmployeeID  is greater than 1000

                                                'strDatabaseQuery = strDatabaseQuery + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                                                strDatabaseQuery = strDatabaseQuery + MyBase.GetFormValue(Request.Form.GetKey(inti))
                                                'Addtion Ended
                                            Else

                                                'For other data types
                                                strDatabaseQuery = strDatabaseQuery + "'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                                            End If
                                        End If
                                        'Added by GaneshD on 04 Jun For Issue Base Status Flow configuration
                                    End If
                                    ' Addition end by GaneshD
                                End If
                            Else
                                strDatabaseQuery = strDatabaseQuery & "NULL"
                            End If

                            ' If the field is any of the following, then their corporate values must be stored as well.

                            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                            'Code Added By PradipK To Save Complexity
                            'Code Commented By PradipK
                            'If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                            'Code Added By PradipK on 15 Feb 2006
                            If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                                strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = '" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                            End If
                        End If
                    Else
                        ' If the field data-type is either integer/bit, then...
                        If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                            strDatabaseQuery = strDatabaseQuery + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                            ' Else, ...
                        Else
                            If InStr(Request.Form.GetKey(inti), "CustomFieldCombo") <> 0 Then
                                strDatabaseQuery = strDatabaseQuery + "'" + Left(MyBase.GetFormValue(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                            Else
                                strDatabaseQuery = strDatabaseQuery & "'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                            End If

                            ' If the field is any of the following, then their corporate values must be stored as well.

                            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                            'Code Added By PradipK To Save Complexity
                            ' If the field is any of the following, then their corporate values must be stored as well.
                            If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                                strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = '" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                            End If
                        End If
                    End If
                End If

                'Dispose the object schema
                objSchema = Nothing


            Next

            'Dispose hash table
            ht = Nothing



            ' If the ShowToCustomer control was not displayed, then...
            strDatabaseQuery = strDatabaseQuery + ", ShowToCustomer = "


            'Intigrated by HarshK on 02/09/2005 for sp4 isueid 155 If the ShowToCustomer Control is not in the layout
            '**************************************************************************
            'Addition by Harshada D for Navionics issue 18636 
            'For issue id 18301 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
            'Code Added by AmolG on 17th May 2005 

            Dim drLayout As IDataReader
            Dim intLayoutID As Integer
            ' Get the layout ID to be applied. since we want the Layout for the Type which is in the combobox selected.
            drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_GetIssueLayoutToBeApplied " + m_ProjectId.ToString + ", " + m_RoleId.ToString + ", '" + CommonFunction.General.BuildQueryString(Request.Form("Type")) + "'", MyBase.UseSQL)

            If drLayout.Read Then
                ' Get the layout ID.
                intLayoutID = CType(drLayout("LayoutID"), Integer)
            End If
            CommonFunction.Data.DisposeDataReader(drLayout)

            'Checking if ShowToCustomer is displayed in the layout or not

            strSQLQuery = "SELECT Count(*) as ShowToCustomerInLayout From tbl_IB_IssueEntry_Layout_Details where layoutid = " + intLayoutID.ToString + " AND UNIQUEID = 34 AND Active = 1"
            'Added by PrashantD on 12 April 2007 for IssueID 11365
            strSQLQuery += " AND ShowInEditMode = 1"
            'End of addition by PrashantD on 12 April 2007
            Dim intShowToCustomerInLayout As Integer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)), Integer)

            If m_blnShowToCustomer = False Then
                ' If the customer has logged in, then by default this value must be set to True.
                'if condition (m_LoginType.ToUpper = "C") added on 22 april
                If m_LoginType.ToUpper = "C" Then
                    strDatabaseQuery = strDatabaseQuery + "1"
                Else
                    'For Issue Id 20699 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
                    'Code Added by PradeepD on 19th Aug 2005 
                    If intShowToCustomerInLayout = 0 Then
                        Dim intShowToCustomer As Integer
                        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                        'strSQLQuery = "SELECT CAST( ShowToCustomer as integer) as ShowToCustomer FROM tbl_IB_Issue WHERE IssueID =  " + m_lngIssueId.ToString
                        strSQLQuery = "usp_sel_tbl_IB_Issue_ShowToCustomer_IssueID  " + m_lngIssueId.ToString
                        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                        intShowToCustomer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)), Integer)
                        strDatabaseQuery = strDatabaseQuery + intShowToCustomer.ToString
                    ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") Is Nothing Then

                        '' START : Added By ParagD On 5-Sept-2006    
                        If m_strblnShowToCustomer = "1" Then
                            strDatabaseQuery = strDatabaseQuery + "1"
                        Else
                            strDatabaseQuery = strDatabaseQuery + "0"
                        End If
                        '' END : ParagD On 5-Sept-2006
                    ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") = "1" Then
                        strDatabaseQuery = strDatabaseQuery + "1"
                    End If

                    '' START : Commented By ParagD On 5-Sept-2006
                    '' Purpose : Code is not in use.
                    'Integrated by AmitJ on 16 Aug 2006 for  whizible SP 7.2 IssueID 2002
                    'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
                    'Added by ShubhadaL on 23 Feb 2006 for FourSoft - 927
                    ' ShowToCustomer Checkbox goes blank when parent gets refreshed from DiscussionThread_Save click

                    ''intIsCustomerChecked = CommonFunction.General.CheckIsNothing(Request.QueryString("IsCustomerChecked"), "0")
                    ''If intIsCustomerChecked <> "0" Then
                    ''    strDatabaseQuery = strDatabaseQuery + "1"
                    ''Else
                    ''    strDatabaseQuery = strDatabaseQuery + "0"
                    ''End If
                    'End of addition by ShubhadaL on 23 Feb 2006 for FourSoft - 927
                    'End Integration by SavitaS
                    'End Integration by AmitJ

                    '' END : Commented By ParagD On 5-Sept-2006

                End If
            Else
                If m_LoginType.ToUpper = "C" Then
                    strDatabaseQuery = strDatabaseQuery + "1"
                Else
                    If intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") Is Nothing Then
                        '' START : ParagD On 5-Sept-2006    
                        If m_strblnShowToCustomer = "1" Then
                            strDatabaseQuery = strDatabaseQuery + "1"
                        Else
                            strDatabaseQuery = strDatabaseQuery + "0"
                        End If
                        '' END : ParagD On 5-Sept-2006

                    ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") = "0" Then
                        strDatabaseQuery = strDatabaseQuery + "1"
                    ElseIf Request.Form("ShowToCustomer") = "1" Then
                        strDatabaseQuery = strDatabaseQuery + "1"
                    End If
                End If
                'strDatabaseQuery = strDatabaseQuery + "1"
            End If
            'End Addition  For Issue Id  20699 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
            'END : Code Added by PradeepD on 19th Aug 2005 
            '**************************************************************************
            'END Intigration by HarshK on 02/09/2005 for sp4 isueid 155
            'Add IssueId in where condition (update selected issue)


            strDatabaseQuery = strDatabaseQuery + " WHERE IssueID = " + m_lngIssueId.ToString
            'Added/integrated by GaneshD on 04 Jun 2009 for Issue Base Status flow configuration
            strDatabaseQuery = strDatabaseQuery.Replace("CmbStatus = ,", "")
            strDatabaseQuery = strDatabaseQuery.Replace("CmbPrevStatus = ,", "")
            strDatabaseQuery = strDatabaseQuery.Replace("IsConfStatusFlow = ,", "")
            'Addition End by GaneshD


            ' Execute the update query.	
            CommonFunction.Data.InsertOrUpdateData(strDatabaseQuery, MyBase.UseSQL)

            'Generate Issue Code
            'Call GenerateIssueCode(m_lngIssueId)
        End If

        'Determine if responsible person is changed
        If m_blnAssignToChanged = True Then
            If MyBase.GetFormValue("txtOldAssignTo").Trim.ToUpper <> MyBase.GetFormValue("AssignTo").Trim.ToUpper Then
                If MyBase.GetFormValue("AssignTo") <> "" Then

                    'Assign Issue to responsible person, if project has this setting
                    If m_blnAssignIssueToResponsiblePerson = True Then
                        Call AssignIssueToEmployee(m_lngIssueId, MyBase.GetFormValue("txtOldAssignTo").ToString.Trim, MyBase.GetFormValue("AssignTo").ToString.Trim)
                    End If

                    'Send mail to responsible person, if project has this setting
                    If m_blnSendResponsiblePersonMail = True Then
                        'Integrated by SandipL SP8 to SP9
                        Call FreshParent()
                        'End Integration by SandipL SP8 to SP9
                        Call SendMail(41, m_lngIssueId) 'Assigned as responsible person
                    End If
                End If
            End If
        End If

        'Modified by SavitaS on 25 Sept 2006 for Whiziblesem SP7 Issue ID.6197
        If (m_strAction = "Save") And (m_strToken = "") And (m_lngIssueId > 0) Then
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String))
        End If
        'End Modification
        'Integrated by SandipL SP8 to SP9
        'Added by SrikanthY on 26 Dec 2006 To refresh parent Helpdeskpage on saving issue
        If m_FromWhere = "HDB" Then
            strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.close();"
            If m_Count = 0 Then
                Call FreshParent()
            End If
        End If
        'End of Addition by SrikanthY
        'End Integration by SandipL SP8 to SP9
    End Sub 'Save / Update / Import Issue

    Private Sub AssignIssueToEmployee(ByVal intIssueID As Long, ByVal strOldAssignTo As String, ByVal strNewAssignTo As String)
        '==================================================================================
        ' Procedure Name		:	AssignIssueToEmployee
        ' Parameters Passed		:	strOldAssignTo :- Old value of AssignTo.
        '							strNewAssignTo :- New Value of AssignTo.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	None.
        ' Purpose				:	If the Issue has been assigned to a resource, then a mail is sent to the concerned resource.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 17, 2004
        ' Revisions				:	
        '==================================================================================
        'Added by PrashantD on 17 March 2007 for IssueID 11616
        Dim blnIssueTaskCreated As Boolean = False
        'End of addition by PrashantD on 17 March 2007

        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim drEmailMessage As IDataReader

        Dim strSQLQuery As String = ""
        Dim drIssueDetails As IDataReader

        Dim dblWorkInHours As Double
        Dim dtmStartDate As String = ""
        Dim dtmEndDate As String = ""

        Dim blnIssueAssigned As Boolean = False

        If strNewAssignTo.Trim = "" Then
            strNewAssignTo = "NULL"
        End If

        ' Check if a task is already assigned to the resource. If yes, do not proceed with the assignment. 
        ' The previous assignment details should not be overwritten.
        ' Get the Start date, End Date and the Work (hrs) of the task assigned.
        strSQLQuery = "EXEC usp_Sel_tbl_PM_ProjectTasks_IssueTasks " & intIssueID & ", " & strNewAssignTo
        drIssueDetails = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drIssueDetails.Read Then
            blnIssueAssigned = True
        End If

        CommonFunction.Data.DisposeDataReader(drIssueDetails)

        'If Issue already assigned to employee, exit 
        If blnIssueAssigned = True Then
            Exit Sub
        End If

        ' If the Work had been taken from the user, then that value must be stored as Default Work (hrs).
        If MyBase.GetFormValue("txtWorkInHours") <> "" Then
            dblWorkInHours = CType(MyBase.GetFormValue("txtWorkInHours").ToString.Trim, Double)
        End If

        'Update worklHours value in tbl_IB_Project_Sub_Type table.
        If dblWorkInHours <> 0 Then
            strSQLQuery = "Exec usp_Upd_tbl_IB_Project_Sub_Type_UpdateDefaultWork " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(MyBase.GetFormValue("Type")) + "', " + FormatNumber(dblWorkInHours)
            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        End If

        strSQLQuery = ""
        ' Add a new Task in the Project Task table.
        drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + m_lngIssueId.ToString, MyBase.UseSQL)
        If drIssueDetails.Read Then
            strSQLQuery = strSQLQuery + "EXEC usp_Ins_IB_AssignIssueToEmployee " + m_lngIssueId.ToString + ", " + m_ProjectId.ToString + ", " + strNewAssignTo

            ' Store the Duration as the estimated Work.
            If dblWorkInHours = 0 Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", " + dblWorkInHours.ToString
            End If

            ' Store the Start Date.
            If dtmStartDate = "" Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", '" + CommonFunction.Dates.CGetDate(CType(dtmStartDate, Date)) + "'"
            End If

            ' Store the End Date.
            If dtmEndDate = "" Then
                strSQLQuery = strSQLQuery + ", NULL"
            Else
                strSQLQuery = strSQLQuery + ", '" + CommonFunction.Dates.CGetDate(CType(dtmEndDate, Date)) + "'"
            End If
            'Added and commented by PrashantD on 17 March 2007 for IssueID 11616
            ' Execute the insert query.
            'CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            Dim drIssueAssign As IDataReader
            drIssueAssign = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drIssueAssign.Read Then
                If CType(drIssueAssign(0), Boolean) = True Then
                    blnIssueTaskCreated = True
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drIssueAssign)
            'End of addition by PrashantD on 17 March 2007


        Else
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
            Exit Sub
        End If
        CommonFunction.Data.DisposeDataReader(drIssueDetails)

        ' If the Issue has not been assigned to anyone, then exit the subroutine. (No mail will be sent in this case.)
        If strNewAssignTo = "NULL" Then
            Exit Sub
        End If
        'Added and commented by PrashantD on 17 March 2007 for IssueID 11616
        If blnIssueTaskCreated = False Then
            Exit Sub
        End If
        'End of addition by PrashantD on 17 March 2007
        ' Retrieve the details of the message to be sent to the Resource.
        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 14", MyBase.UseSQL)
        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)

        ' Check if the mail has to be sent. (exit if no email is to be send)
        If blnSendEmail = False Then Exit Sub

        ' Check if a popup message has to be shown.
        If blnShowPopup = True Then
            'Integrated by SandipL SP8 to SP9
            Call FreshParent()
            'End Integration by SandipL SP8 to SP9
            strOnloadClientScript = strOnloadClientScript + "window.open(""../General/SendEmail.aspx?MessageID=14&IssueID=" + intIssueID.ToString + "&EmployeeIDList=," + strNewAssignTo + ","", """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
            ' Else, if the mail has to be sent silently, then...
        Else
            'Get email actual message by replacing placeholders
            Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intIssueID, "," & strNewAssignTo & ",")

            'Send mail
            Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
        End If
    End Sub

    Private Sub SendMail(ByVal MessageId As Integer, ByVal IssueId As Long)
        '=====================================================================
        ' Procedure Name        : SendMail()	
        ' Purpose               : To send mail for given messageId and IssueId
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 16, 2004
        ' Revisions             :
        '=====================================================================

        Dim drEmailMessage As IDataReader
        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        Select Case MessageId
            Case 8 'NEW ISSUE POSTED
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 8", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                'Destroy data reader
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                'Exit procedure if no mail is to be send
                If Not blnSendEmail Then Exit Sub

                'If popup window to be shown before sending mail
                If blnShowPopup Then
                    'parameters "EntityID" and "PKValue" added by Anirudha for jump to record for email functionality
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=8&EntityID=1&PKValue=" + IssueId.ToString + "&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                Else
                    'If mail is to be send silently
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_8(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If

            Case 34 'ISSUE STATUS CHANGED
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 34", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent (exit if not to send)
                If blnSendEmail = False Then Exit Sub

                ' Check if a popup message has to be shown.
                If blnShowPopup = True Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=34&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                    ' Else, if the mail has to be sent silently, then...
                Else
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If

            Case 41 'ASSIGNED AS RESPONSIBLE PERSON FOR ISSUE
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 41", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent.(exit if not to send  mail)
                If blnSendEmail = False Then Exit Sub

                ' Check if a popup message has to be shown.
                If blnShowPopup = True Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=41&IssueID=" + IssueId.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                    ' Else, if the mail has to be sent silently, then...
                Else
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_41(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, IssueId)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If

        End Select
    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Global object

        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            'Added by AniruddhaD on 21 Nov 2005 for providing projects combo on issue list page (IssueID:685)
            'm_ProjectId = .ProjectID

            'Added by AniruddhaD on 21 Nov 2005 for providing projects combo on issue list page (IssueID:685)

            If Not Request.QueryString("ProjectID") Is Nothing Then
                If Request.QueryString("ProjectID") <> "" Then
                    If CType(Request.QueryString("ProjectID"), Long) > 0 Then
                        m_ProjectId = CType(Request.QueryString("ProjectID"), Long)

                        'Added by MrugajaB on 02 Mar 2006 To Solve default query/view/filter problem (IssueID:685)
                        'Purpose:When we save issue and go back to issue list page the settings on the list page should be maintained

                        If CType(Session("IssueProject"), Long) <> m_ProjectId Then
                            m_blnProjectChanged = True
                            Session("IssueProject") = m_ProjectId
                            Session("intViewID") = ""
                            Session("intQueryID") = 0
                            Session("intFilterOnQuery") = ""
                            Session("Filters") = ""
                            Session("UnsavedQuery") = ""
                        End If
                        'End Addition

                    End If
                End If
            Else
                m_ProjectId = CType(Session("IssueProject"), Long)
            End If

            'end of addition

            m_UserId = .UserID
            m_UserName = .UserName
            m_CultureId = .LCID
            m_FromWhere = .FromWhere

            .TagID = 5
            'Code added by SandipL on 17 Feb 2006 --IssueID 2137 AND 2138 -- Whizsem_whiz2 sp6
            Dim intCorporateRoleLevel As Integer
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_RoleID " & CType(Session("intUserID"), String) & "", MyBase.UseSQL), Integer)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
                'Added by PrashantD on 10 April 2007 IssueId 11594
                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ApplyProjectLevelRole FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "0"), Boolean) = True Then
                If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_ApplyProjectLevelRole", MyBase.UseSQL), "0"), Boolean) = True Then
                    'End of addition by PrashantD on 10 April 2007
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    If Not m_RoleId > 0 Then
                        m_RoleId = CType(Session("intPostID"), Long)
                    End If
                    'Added by PrashantD on 10 April 2007 IssueId 11594
                Else
                    m_RoleId = CType(Session("intPostID"), Long)
                End If
                'End of addition by PrashantD on 10 April 2007
                If m_RoleId <> 0 Then
                    objGlobal.RoleID = m_RoleId
                End If
                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'm_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                If m_RoleLevel <> 0 Then
                    objGlobal.RoleLevel = m_RoleLevel
                End If
            End If
            'End addition by SandipL on 17 Feb 2006
        End With

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values

    Private Sub GeneratePageLegends()
        '=====================================================================
        ' Procedure Name        : GeneratePageLegends()	
        ' Purpose               : To generate page legends
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

    End Sub 'Generate Page Legends

    Protected Sub GenerateIssueDetailsSection()
        '=====================================================================
        ' Procedure Name        : GenerateIssueDetailsSection
        ' Purpose               : To generate Issue details section
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file for IssueList
        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle

        'Previous and Next links
        Dim strLinks As String() = {MyBase.GetResourceString("PREVIOUS"), MyBase.GetResourceString("NEXT")}

        'Previous and Next links - Client side functions
        Dim strLinkFunctions As String() = {"Previous_OnClick()", "Next_OnClick()"}

        'Previous and Next links - Tooltips
        Dim strLinkTooltips As String() = {MyBase.GetResourceString("PREVIOUS_TOOLTIP"), MyBase.GetResourceString("NEXT_TOOLTIP")}
        'Added by GaneshD on 09 Jun 2009 For Issue Base StatusFlow configuration
        ' Dim strOldStatus As String
        'Addition end by GaneshD
        With cObjSectionTitle
            Dim strIssueId As String

            'added by VivekP on 2 Apr 2005 for copy functionality
            Dim strInheritIssueData As String
            'end of addition by VivekP on 2 Apr 2005 for copy functionality

            'Added by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
            Dim strProjectName As String
            'Commeted by shraddhaM while integration of PTC to whiz 7 on 5,Sep 2007
            'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
            'End of comment by ShraddhaM
            'Integrated by ShraddhaM on 5,Sep 2007
            'Modified By GaneshG On 11-Jun-07 For Pointwest RequestID - 7366 
            If m_lngIssueId = 0 Then
                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
                strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectName_ID " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            Else
                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where ProjectID = " + m_ProjectId.ToString, True), String)
                strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectName_ID " + m_ProjectId.ToString, True), String)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            End If
            'End of integration by ShraddhaM
            Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, " Project: " + strProjectName, , , False))
            'End Addition by SandipL

            'Display IssueId - In AddNew mode show [Not Assigned] and in EditMode show IssueID 
            If m_lngIssueId = 0 Then

                'added by VivekP  On 2 Apr 2005 for copy functionality
                'Facility to copy issue data from previously created issues, for add new mode and add access only
                'Implemented using customization gates logic - Organization level
                'If Application("ACCN-ISSUECOPY") = True Then

                'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If m_blnAddAccess And blnCalledFromReview = False Then
                    strInheritIssueData = "Copy Data From " + GetUserFriendlyName("IssueID") + "&nbsp;&nbsp;" + PopulateComboForCopyIssueID("cboCopyIssue", 0, "onchange=cboCopyIssue_onchange()", False) + "&nbsp;&nbsp;"
                    'Modified by MrugajaB on 21st Dec 2005 for IssueID: 683
                    'Purpose:To plot hidden control for copy issue while adding issue through review as copy issue functionality is not required while adding issue thru' reviews
                ElseIf blnCalledFromReview = True Then
                    strInheritIssueData = PopulateComboForCopyIssueID("cboCopyIssue", 0, "onchange=cboCopyIssue_onchange()", True)
                End If
                'End Modification
                'End If
                'end of addition by VivekP On 2 Apr 2005 for copy functionality


                strIssueId = MyBase.GetResourceString("NOTASSIGNED")
            Else

                'added by VivekP on 2 Apr 2005 for copy functionality
                strInheritIssueData = ""
                'end of addition by VivekP on 2 Apr 2005 for copy functionality

                strIssueId = m_lngIssueId.ToString
            End If

            'combo with Issue IDs (If navigation is true (Edit Mode) and page not opended from DashBoard)
            'Modified by MrugajaB on 7th Feb 2006
            'Purpose:When page gets poped up from reviews and gets submitted when we open attachment, then to retain values on the page to the values when the page was initially called from reviews
            'Integrated by SandipL SP8 to SP9
            'If m_blnIssueNavigation And m_FromWhere <> "DB" And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Then
            If m_blnIssueNavigation And m_FromWhere <> "DB" And m_FromWhere <> "HDB" And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Then
                'End Integration by SandipL SP8 to SP9


                'End Modification
                Dim RightSectionTitle As String
                'Dim strSQL As String = GetDefaultQueryView(m_strSortField + " " + m_strSortOrder)
                RightSectionTitle = GetUserFriendlyName("IssueID") + " : " + PopulateComboForIssueID("cboIssue", 0, "onchange=cboIssue_onchange()") + "&nbsp;&nbsp;"
                .LinkNames = strLinks
                .LinkFunctions = strLinkFunctions
                .LinkTooltips = strLinkTooltips
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUEDETAILSLEFTSECTIONTITLE"), "DivIssueDetails", "ShowHideIssueDetails", , RightSectionTitle))
            Else

                'Just display current Issue ID

                'Added by AniruddhaD on 19 may 2004 for issuecode
                'get Issuecode, if any, for selected issue
                Dim strIssueCode As String
                If m_lngIssueId > 0 Then
                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'strIssueCode = CommonFunction.Data.GetDataScalar("Select IssueCode from tbl_IB_Issue where IssueID = " + m_lngIssueId.ToString, MyBase.UseSQL).ToString
                    strIssueCode = CommonFunction.Data.GetDataScalar("usp_sel_tbl_IB_Issue_IssueCode " + m_lngIssueId.ToString, MyBase.UseSQL).ToString
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                End If
                If strIssueCode <> "" Then
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUEDETAILSLEFTSECTIONTITLE"), "DivIssueDetails", "ShowHideIssueDetails", , GetUserFriendlyName("IssueID") + " : [" + strIssueId + " --> " + strIssueCode + "]"))
                Else
                    If strInheritIssueData <> "" Then

                        'Added By VivekP On 2 Apr 2005 for Copy Functionality
                        Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUEDETAILSLEFTSECTIONTITLE"), "DivIssueDetails", "ShowHideIssueDetails", , strInheritIssueData + "&nbsp;&nbsp;" + GetUserFriendlyName("IssueID") + " : [" + strIssueId + "]"))
                        'End Of addition By VivekP On 2 Apr 2005 for Copy Functionality

                    Else
                        Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUEDETAILSLEFTSECTIONTITLE"), "DivIssueDetails", "ShowHideIssueDetails", , GetUserFriendlyName("IssueID") + " : [" + strIssueId + "]"))
                    End If

                End If

            End If

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        'Div for section title
        Response.Write("<DIV Id='DivIssueDetails' Style='Overflow:Auto'>")

        'get all validation rules
        Call GetValidationRules()

        'Issue entry form controls
        Response.Write("<table width=99.9% cellSpacing=0 class=clsTable>")
        Response.Write("<tr class=clsTREven>")
        'Modified by PrashantD on 15 March 2007 for IssueID 11420
        'Response.Write("<td valign=top align=right>")
        Response.Write("<td width='10%' valign=top align=right>")
        'End of modification by PrashantD on 15 March 2007 

        'Draw hidden controls - all modes
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("IssueNavigation", "IssueNavigation", , , , m_blnIssueNavigation.ToString, IsHidden:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtSortField", "txtSortField", , , , m_strSortField, IsHidden:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtSortOrder", "txtSortOrder", , , , m_strSortOrder, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By PradipK on 16 Feb 2006
        'Dim strDate As String
        'Dim strSQL As String
        'Dim strCurrentHours As String
        'Dim strCurrentTime As String

        ' strSQL = "SELECT GetDate()"
        ' strDate = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Response.Write("<INPUT Type='Hidden' ID = 'CurrentDate' Name='CurrentDate' Value='" & CommonFunction.Dates.GetDate(Date.Now) & "'>")

        '        strSQL = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        '       strDate = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


        'Response.Write("<INPUT Type='Hidden' ID = 'CurrentTime' Name='CurrentTime' Value='" & strDate & "'>")
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunctions.Dates.GetDate(Date.Now), String), IsHidden:=True))
        'shraddha 3/08/2006
        'Dim h As Integer
        'Dim m As Integer
        'Dim strHour As String
        'Dim strMinute As String

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strGetServerTimeSQL1 = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        strGetServerTimeSQL1 = "usp_sel_GetDate"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        strGetServerTime1 = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strGetServerDateSQL1 = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        strGetServerDateSQL1 = "usp_sel_SMALLDATETIME"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        strGetServerDate1 = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        h = CType(Left(strGetServerTime1, 2), Integer)
        m = CType(Right(strGetServerTime1, 2), Integer)

        If h < 10 Then
            strHour = "0" + h.ToString
        Else
            strHour = h.ToString

        End If
        If m < 10 Then
            strMinute = "0" + m.ToString
        Else
            strMinute = m.ToString
        End If
        'Response.Write(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), DisplayNone:=True))
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, DisplayNone:=True))

        'strCurrentHours = Now.Hour.ToString
        'If CType(Now.Hour.ToString, Integer) < 10 Then
        '    strCurrentHours = "0" + Now.Hour.ToString
        'End If
        'strCurrentTime = Now.Minute.ToString
        'If CType(Now.Minute.ToString, Integer) < 10 Then
        '    strCurrentTime = "0" + Now.Minute.ToString
        'End If
        'Added By GaneshD on 04 Jun 2009 For Issue BAse StatusFlow configuration

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'm_IsConfStatusFlow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select Statusflow from tbl_pm_companyinformation ", MyBase.UseSQL), "1"), Int16)
        m_IsConfStatusFlow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_companyinformation_Statusflow", MyBase.UseSQL), "1"), Int16)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("IsConfStatusFlow", "IsConfStatusFlow", , , , IsConfStatusFlow.ToString, IsHidden:=True))
        m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_IB_GetStatusFlowCount " + CType(m_lngIssueId, String) + "," + m_ProjectId.ToString, MyBase.UseSQL), "0"), Integer)

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'End Addition by GaneshD
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If m_IssuePresent Then 'Edit Mode - Default values = values from recordset
            Dim strOldStatusChangeDate As String = ""
            Dim strOldStatusChangeTime As String = ""
            If CType(CommonFunctions.Data.CheckIsDBNull(drIssueDetails("StatusChangeDate"), ""), String) <> "" Then
                strOldStatusChangeDate = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Dates.GetDate(CType(drIssueDetails("StatusChangeDate"), Date)), "").ToString
            End If
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("OldStatusChangeDate", "OldStatusChangeDate", , , strOldStatusChangeDate, DisplayNone:=True))
            If CType(CommonFunctions.Data.CheckIsDBNull(drIssueDetails("StatusChangeTime"), ""), String) <> "" Then
                strOldStatusChangeTime = CommonFunction.Data.CheckIsDBNull(drIssueDetails("StatusChangeTime"), "").ToString
            End If
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("OldStatusChangeTime", "OldStatusChangeTime", , , , strOldStatusChangeTime, IsHidden:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("OldStatusChangeDate", "OldStatusChangeDate", DisplayNone:=True))
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("OldStatusChangeTime", "OldStatusChangeTime", IsHidden:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        'End Addition By PradipK 


        'Draw hidden controls for New / edit mode
        If m_IssuePresent Then 'Edit Mode - Default values = values from recordset
            Dim strassignto As String = CommonFunction.Data.CheckIsDBNull(drIssueDetails("AssignTo"), "").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldAssignTo", "txtOldAssignTo", , , , strassignto, IsHidden:=True, EnableHTMLEncode:=True))
            Dim strOldStatus As String = CommonFunction.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            'Added By GaneshD on 04 Jun 2009 for Issue Base StatusFlow configuration
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"), "") = "TypeChange" Then
                Dim drDefaultStatusValue As IDataReader
                m_IsIssueTypechanged = 1
                Dim strSQLQuery As String = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                drDefaultStatusValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultStatusValue.Read Then
                    strOldStatus = CType(drDefaultStatusValue("Status"), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultStatusValue)
            End If
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "2,'" + strOldStatus + "','" & m_ProjectId.ToString & "'", DisplayNone:=True)) '--, displaynone:=True
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "1", DisplayNone:=True)) ', displaynone:=True
            Dim dr_Allstatus As IDataReader
            Dim StrSql As String
            StrSql = "Exec usp_Sel_IB_CheckStatusExists '" + m_strCurrentType.Replace("'", "") + "','" & m_ProjectId.ToString & "'"
            dr_Allstatus = CommonFunctions.Data.GetDataReader(StrSql, MyBase.UseSQL)
            While dr_Allstatus.Read
                m_strAllStatusInStatusFlow = m_strAllStatusInStatusFlow + "," + CType(dr_Allstatus("AllStatus"), String)
            End While
            CommonFunction.Data.DisposeDataReader(dr_Allstatus)
            ' Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbCheckStatus", "Exec usp_Sel_IB_CheckStatusExists '" + m_strCurrentType.Replace("'", "") + "'", DisplayNone:=True)) ', displaynone:=True


            'Addition end by GaneshD

        Else ' Add New mode  = default values are blank.
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldAssignTo", "txtOldAssignTo", IsHidden:=True, EnableHTMLEncode:=True))
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", IsHidden:=True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            'Added By GaneshD on 04 Jun 2009 for Issue Base StatusFlow configuration
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType + "'," + "1", DisplayNone:=True))  '--, displaynone:=True
            'Addition end by GaneshD
        End If

        'Draw hidden dummy text box for - when enter pressed in txtIssueId - Functionality will not work without this text box.
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("IssueID", "IssueID", , , , m_lngIssueId.ToString, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Added by SavitaS on 20 Sept 2006  for Security Issue 6197 
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        HttpContext.Current.Session("OldToken") = m_strToken
        'End of Added by SavitaS on 20 Sept 2006  for Security Issue 6197 

        'Form contents to be shown ? (Preserve / persist form values ?)
        If m_blnShowFormContents = True Then
            'Code commented and added by PrashantD on 12 March 2007 for IssueID 11118 
            'Purpose: Mybase.GetFormValue replaces one single quote to two single quotes.
            'If Not MyBase.GetFormValue("Summary") Is Nothing Then
            '    strFieldValue = MyBase.GetFormValue("Summary")
            If Not Request.Form("Summary") Is Nothing Then
                strFieldValue = Request.Form("Summary")
                'End of addition by PrashantD on 12 March 2007
            Else
                strFieldValue = ""
            End If
        ElseIf m_blnShowRecordSetContents = True Then 'Show values from database (For Edit mode / refresh after add new - save) ? 
            If m_IssuePresent Then
                strFieldValue = drIssueDetails("Summary").ToString
                'Added By GaneshG on 08 Nov 06 -- Flag setting for Issue
                m_strIssueSummary = strFieldValue
                m_strIssueSummary = m_strIssueSummary.Replace("""", "&quot;")
                'Added by PrashantD on 21 Nov 2006
                m_strIssueSummary = m_strIssueSummary.Replace(Chr(10), "\n")
                m_strIssueSummary = m_strIssueSummary.Replace(Chr(13), "")
                'End of addition by PrashantD on 21 Nov 2006
                'End Addition By GaneshG
                'Added by VarunA on 26-Sep-2008
                'Purpose:-Security Issue
                m_strIssueSummary = m_strIssueSummary.Replace("<", "&#60")
                m_strIssueSummary = m_strIssueSummary.Replace(">", "&#62")
                'End by VarunA on 26-Sep-2008
            End If
        End If

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' Unused Code hence Commented

        '' Get the Layout details.
        'Dim drLayout As IDataReader
        'Dim strSQLQuery As String = "Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + m_intLayoutID.ToString
        'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        'If drLayout.Read Then
        '    Do
        '        If drLayout("TableFieldName").ToString = "Summary" Then Exit Do
        '    Loop While drLayout.Read
        'End If
        'CommonFunction.Data.DisposeDataReader(drLayout)

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Summary
        Call GetControlAttributes("Summary", strFieldValue, ArrCtlAttr) 'Get control attributes for summary field

        'caption for summary
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        Response.Write("</td>")

        'actual Control (text box)
        'Commented And Added By Vaijat K On 04/11/2015
        'Response.Write("<td valign=top>")
        Response.Write("<td style='vertical-align:top'>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)
        Response.Write("</td>")
        Response.Write("</tr>")
        'Summary field over

        'Description
        Response.Write("<tr class=clsTREven>")
        'Commented Added By Vaijat K On 04/11/2015
        'Response.Write("<td valign=top align=right>")
        Response.Write("<td valign=top align=right style='vertical-align:top'>")
        'Persist form value - form refresh after type changed
        If m_blnShowFormContents = True Then
            'Code commented and added by PrashantD on 12 March 2007 for IssueID 11118 
            'Purpose: Mybase.GetFormValue replaces one single quote to two single quotes.
            'If Not MyBase.GetFormValue("Description") Is Nothing Then
            'strFieldValue = MyBase.GetFormValue("Description")
            If Not Request.Form("Description") Is Nothing Then
                strFieldValue = Request.Form("Description")
                'End of addition by PrashantD on 12 March 2007
            Else
                'Blank value - if no value in the control
                strFieldValue = ""
            End If
            'Value frm database - Edit mode / refresh after add new - save
        ElseIf m_blnShowRecordSetContents = True Then
            strFieldValue = drIssueDetails("Description").ToString.Trim
        End If

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        '' Get the Layout details.
        'strSQLQuery = "Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + m_intLayoutID.ToString
        'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        'If drLayout.Read Then
        '    Do
        '        If drLayout("TableFieldName").ToString = "Description" Then Exit Do
        '    Loop While drLayout.Read
        'End If
        'CommonFunction.Data.DisposeDataReader(drLayout)

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 


        Call GetControlAttributes("Description", strFieldValue, ArrCtlAttr)
        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
        Response.Write("<br>")

        'If Description is set as disabled in layout, then disable insertion of time stamp  also
        If CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY), Boolean) Then
            Response.Write("<img SRC='../../images/time.gif' border='0' alt='Insert DateTimeStamp' WIDTH='17' HEIGHT='17'>")
        Else
            Response.Write("<a HREF='javascript:InsertTimeStamp()'>")
            Response.Write("<img SRC='../../images/time.gif' border='0' alt='Insert DateTimeStamp' WIDTH='17' HEIGHT='17'></a>")
        End If

        Response.Write("</td>")
        Response.Write("<td valign=top>")
        Call DrawControl(ArrCtlAttr)
        Call ClearAttributes(ArrCtlAttr)

        Response.Write("</td>")
        Response.Write("</tr>")
        'Description field over

        'Destroy the object
        cObjSectionTitle = Nothing

        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")

        'Integrated by SandipL SP8 to SP9
        'Integrated by PrashantD on 2 March 2007 for Product Execution Project
        ' Added By NitinVS on 25 May 2006 for Roamware Customization
        ' Add Section for Product if EnableProductExecution is True and Project is following the product execution practice.



        If m_EnableProductExecution = True And m_ProductExecutionPractice = True Then

            Dim cObjProductSectionTitle As New WebPage.Templates.SectionTitle

            Response.Write("<BR>")

            With cObjProductSectionTitle
                'Comment and modification done by SuchitraP on 12-July-2007
                'Response.Write(.GetSectionTitle("Product Details", "DivIssueProductDetails", "ShowHideProductDetails", , ))
                Response.Write(.GetSectionTitle("Product Fields", "DivIssueProductDetails", "ShowHideProductDetails", , ))
                'End of Comment and modification done by SuchitraP on 12-July-2007

                'Write ClientsideScript in order to show hide the section
                Response.Write("<SCRIPT Language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript)
                Response.Write("</SCRIPT>")

            End With

            cObjProductSectionTitle = Nothing



            'Div for section title
            Response.Write("<DIV Id='DivIssueProductDetails' Style='Overflow:Auto'>")
            'GAneshD-15 Sep 2009 - Change the table width from 100 to 99.9
            Response.Write("<table width=99.9% cellSpacing=0 class=clsTable>")
            Response.Write("<tr class=clsTREven>")
            'Response.Write("<td valign=top align=right> Product </TD>")
            Response.Write("<td valign=top align=right> ")

            ' Draw Customer Combo if Employee Login and Selected project is having CustomerForDeliverable True.
            If m_CustomerAtDeliverable = True Or m_LoginType = "C" Then
                'Persist form value - form refresh after type changed
                If m_blnShowFormContents = True Then
                    If Not MyBase.GetFormValue("CustomerID") Is Nothing Then
                        strFieldValue = MyBase.GetFormValue("CustomerID")
                    Else
                        'Blank value - if no value in the control
                        strFieldValue = ""
                    End If
                    'Value frm database - Edit mode / refresh after add new - save
                ElseIf m_blnShowRecordSetContents = True Then
                    strFieldValue = drIssueDetails("CustomerID").ToString.Trim
                End If

                m_CustomerId = strFieldValue

                Call GetControlAttributes("CustomerID", strFieldValue, ArrCtlAttr, MyBase.GetResourceString("CAP_CUSTOMER"))
                If m_LoginType <> "C" Then
                    Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
                    'Added by PrashantD on 5 March 2007 for Product Execution Project
                Else
                    If strFieldValue = "" Then
                        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                        'strFieldValue = CType(CommonFunction.Data.GetDataScalar("Select CustomerID from tbl_PM_Project WHERE ProjectId = " + m_ProjectId.ToString, MyBase.UseSQL), String)
                        strFieldValue = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_CustomerID " + m_ProjectId.ToString, MyBase.UseSQL), String)
                        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    End If
                    Response.Write("<INPUT type=hidden name=CustomerID id=CustomerID value=" + strFieldValue + ">")
                    'End of addition by PrashantD on 5 March 2007 for Product Execution Project
                End If

                If m_CustomerId = "" And m_LoginType = "C" Then
                    m_CustomerId = strFieldValue
                End If


                Response.Write("</td> ")
                Response.Write("<td valign=top align=left> ")
                If m_LoginType <> "C" Then
                    Call DrawControl(ArrCtlAttr)
                End If
                Call ClearAttributes(ArrCtlAttr)

                Response.Write("</td>")
                'Added by PrashantD on 5 March 2007 for Product Execution Project
            Else
                'Persist form value - form refresh after type changed
                If m_blnShowFormContents = True Then
                    If Not MyBase.GetFormValue("CustomerID") Is Nothing Then
                        strFieldValue = MyBase.GetFormValue("CustomerID")
                    Else
                        'Blank value - if no value in the control
                        strFieldValue = ""
                    End If
                    'Value frm database - Edit mode / refresh after add new - save
                ElseIf m_blnShowRecordSetContents = True Then
                    strFieldValue = drIssueDetails("CustomerID").ToString.Trim
                End If
                If strFieldValue = "" Then
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'strFieldValue = CType(CommonFunction.Data.GetDataScalar("Select CustomerID from tbl_PM_Project WHERE ProjectId = " + m_ProjectId.ToString, MyBase.UseSQL), String)
                    strFieldValue = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_CustomerID " + m_ProjectId.ToString, MyBase.UseSQL), String)
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                End If
                Response.Write("<INPUT type=hidden name=CustomerID id=CustomerID value=" + strFieldValue + ">")

                'End of addition by PrashantD on 5 March 2007
            End If

            ' ProductVersionID 
            Response.Write("<td valign=top align=right> ")

            'Persist form value - form refresh after type changed
            If m_blnShowFormContents = True Then
                If Not MyBase.GetFormValue("ProductVersionID") Is Nothing Then
                    strFieldValue = MyBase.GetFormValue("ProductVersionID")
                Else
                    'Blank value - if no value in the control
                    strFieldValue = ""
                End If
                'Value frm database - Edit mode / refresh after add new - save
            ElseIf m_blnShowRecordSetContents = True Then
                strFieldValue = drIssueDetails("ProductVersionID").ToString.Trim
            End If

            m_ProductVersionID = strFieldValue

            Call GetControlAttributes("ProductVersionID", strFieldValue, ArrCtlAttr, MyBase.GetResourceString("CAP_PRODUCT"))
            Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
            Response.Write(" </TD>")
            Response.Write("<td valign=top align=left> ")

            Call DrawControl(ArrCtlAttr)
            Call ClearAttributes(ArrCtlAttr)

            Response.Write("</td>")
            Response.Write("<td valign=top align=right> ")

            'Persist form value - form refresh after type changed
            If m_blnShowFormContents = True Then
                If Not MyBase.GetFormValue("ComponentID") Is Nothing Then
                    strFieldValue = MyBase.GetFormValue("ComponentID")
                Else
                    'Blank value - if no value in the control
                    strFieldValue = ""
                End If
                'Value frm database - Edit mode / refresh after add new - save
            ElseIf m_blnShowRecordSetContents = True Then
                strFieldValue = drIssueDetails("ComponentID").ToString.Trim
            End If

            Call GetControlAttributes("ComponentID", strFieldValue, ArrCtlAttr, MyBase.GetResourceString("CAP_COMPONENT"))
            Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
            Response.Write("</TD>")
            Response.Write("<td valign=top align=left> ")
            Call DrawControl(ArrCtlAttr)
            Call ClearAttributes(ArrCtlAttr)

            Response.Write("</TD>")
            Response.Write("</TR></Table> ")

            Response.Write("</DIV>")

        End If

        ' End Addition By  NitinVS on 25 May 2006 for Roamware Customization
        'End of Integration by PrashantD on 2 March 2007

        'End Integration by SandipL SP8 to SP9
        'If controls to be displayed in client side tabs
        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
            Call GenerateFieldTabs()
            'If controls to be displayed in sections
        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
            Call GenerateFieldSections()
        End If

        Response.Write("</DIV>")
    End Sub 'Generate Issue Details section

    Private Sub GenerateFieldSections()
        '==================================================================================
        ' Procedure Name		:	GenerateFieldSections
        ' Parameters Passed		:	To generate sections for Common and custom fields depending on setting.
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Mar 3, 2003
        ' Revisions				:	
        '==================================================================================		

        'Initialize Resource file for IssueList
        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        Response.Write("<BR>")

        'COMMON FIELDS
        Dim ObjCommonFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCommonFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("COMMONFIELDS"), "DivCommonFieldsSection", "HideShowCommonFieldsSection"))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        Response.Write("<DIV id=DivCommonFieldsSection style='overflow:auto'>")

        'Plot all common controls
        Call PlotCommonFields()

        Response.Write("</DIV>")

        Response.Write("<BR>")

        'CUSTOM FIELDS
        Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCustomFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        Response.Write("<DIV id=DivCustomFieldsSection style='overflow:auto'>")

        'plot all custom fields, if any
        Call PlotCustomFields()

        Response.Write("</DIV>")

        Response.Write("<BR>")

    End Sub

    Private Sub GetValidationRules()
        '==================================================================================
        ' Procedure Name		:	GetValidationRules
        ' Parameters Passed		:	To get all the validation messages in an array
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2003
        ' Revisions				:	
        '==================================================================================		

        Dim drValidationRules As IDataReader

        ' Retrieve all the validation messages.
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)'
        drValidationRules = CommonFunction.Data.GetDataReader("usp_sel_tbl_UI_Validation_ValidationID", MyBase.UseSQL)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        'Save all these validation messages in array
        Do While drValidationRules.Read
            arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
        Loop

        'Dispose data reader
        CommonFunction.Data.DisposeDataReader(drValidationRules)
    End Sub 'Get all validation rules and generate array

    Private Sub GenerateFieldTabs()
        '==================================================================================
        ' Procedure Name		:	GenerateFieldTabs
        ' Parameters Passed		:	To generate client side tabs for common and custom fields
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2003
        ' Revisions				:	
        '==================================================================================		
        Dim arrTabName() As String = {MyBase.GetResourceString("COMMONFIELDS"), MyBase.GetResourceString("CUSTOMFIELDS")}
        Dim arrTabToolTip() As String = {MyBase.GetResourceString("COMMONFIELDS_TOOLTIP"), MyBase.GetResourceString("CUSTOMFIELDS_TOOLTIP")}
        Dim arrDIVID() As String = {"DivCommonFields", "DivCustomFields"}
        Dim objTab As WebPage.Templates.ClientSideTabs

        'create Tab object
        objTab = New WebPage.Templates.ClientSideTabs
        With objTab
            .TabNameArray = arrTabName
            .TooltipArray = arrTabToolTip
            .TabOnclickFunctionName = "Tab_OnClick"
            .ReturnHTML = False
            .Align = "RIGHT"
            .FormName = "frmIBIssueEntry"
            .SelectedTab = MyBase.GetResourceString("COMMONFIELDS")
            .DIVIDArray = arrDIVID
            CommonFunctions.General.WriteHTML(.DrawTabs())
            ' write the generated client side script
            Response.Write(.ClientSideScript)
        End With
        objTab = Nothing

        With Response
            .Write("<TABLE class=clsTable width=99.9% style='border:#000080 3px solid'>")
            .Write("<TR class=clsTREven>")
            .Write("<TD>")

            'Define Common fields div
            .Write("<DIV id=DivCommonFields style='overflow:auto;height=235'>")
            Call PlotCommonFields()
            .Write("</DIV>")

            'Define custom fields div
            .Write("<DIV id=DivCustomFields style='overflow:auto;height=235;display:none'>")
            Call PlotCustomFields()
            .Write("</DIV>")

            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")
        End With

        Response.Write("<BR>")

    End Sub 'Generate client side tabs for Common and Custom fields of issue

    Private Sub PlotCustomFields()
        '==================================================================================
        ' Procedure Name		:	PlotCustomFields
        ' Parameters Passed		:	To plot custom fields for Issue
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2003
        ' Revisions				:	
        '==================================================================================

        Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer

        Dim drLayout As IDataReader

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added the code to check if security is set for given projectID and RoleID

        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer
        'modified by Harshk for sp4 issueid 539 on 10/10/2005
        'Integrated by AmitJ on 16 Aug 2006 for whizible SP 7.2 IssueID 23016
        '' Commented & Modified By ParagD On 4-July-2006
        '' Nucleus 23016 -- Customer login function is not working as per the acccess rights defined at the project level settings.
        '' strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID
        strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID + "," + m_LoginType.ToString
        '' END : Commented & Modified By ParagD On 4-July-2006
        'End of Integration
        'strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID
        'End modified by Harshk for sp4 issueid 539 on 10/10/2005
        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)

        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While

        CommonFunction.Data.DisposeDataReader(drCustomAccess)

        '*****End Addition*******

        ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_IB_CustomFields_Master WHERE ProjectID = " + m_ProjectId.ToString + " AND Active = 1"
        strSQLQuery = "usp_sel_tbl_IB_CustomFields_Master_RowNumber " + m_ProjectId.ToString
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drLayout.Read Then
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable>")


        'added by VivekP On 2 Apr 2005 for copy functionality (original code is in else part)
        Dim IssueType As String = ""
        If m_strAction.ToUpper = "COPYISSUE" Then
            Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
            IssueType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
            strSQLQuery = "usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ", NULL, 1"
            '' SnehalV 5-Oct-2006 
            '' If IssueType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + IssueType + "'"
            If IssueType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + CommonFunction.General.BuildQueryString(IssueType) + "'"
            drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        Else
            strSQLQuery = "usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ", NULL, 1"
            If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + CommonFunction.General.BuildQueryString(m_strCurrentType) + "'"
            drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        End If
        'end of addition on 2 Apr 2005 for copy functionality

        'strSQLQuery = "usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ", NULL, 1"
        'If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drLayout.Read Then
            For intRow = 1 To m_intMaxRows
                declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('frmIBIssueEntry','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                Response.Write("<TR class=clsTREven>")
                For intCol = 1 To m_intMaxCols
                    declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('frmIBIssueEntry','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                    intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
                    intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

                    If intCurrentCellNumber < intNextCellNumber Then
                        Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                    ElseIf intCurrentCellNumber >= intNextCellNumber Then
                        Response.Write("<td valign=top align=right style='width:10%'>")

                        'Added By VivekP On 2 Apr 2005 for Copy Functionality
                        If m_strAction.ToUpper = "COPYISSUE" Then
                            Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + drLayout("DatabaseFieldName").ToString.Trim + "'"
                            strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                        Else
                            'End Of Addition On 2 Apr 2005 for Copy Functionality

                            'get value form form
                            If m_blnShowFormContents = True Then
                                If Not Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
                                    strFieldValue = Request.Form(drLayout("DatabaseFieldName").ToString)
                                Else
                                    strFieldValue = ""
                                End If
                            ElseIf m_blnShowRecordSetContents = True Then
                                'If Not rsIssueDetails.EOF Then
                                strFieldValue = drIssueDetails(drLayout("DatabaseFieldName").ToString).ToString
                                'End If
                            Else
                                strFieldValue = ""
                            End If

                            'Added By VivekP On 2 Apr 2005 for Copy Functionality
                        End If
                        'End Of Addition On 2 Apr 2005 for Copy Functionality


                        ' Retrieve the attributes of the control to be displayed.
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
                        'Modified By VarunA on 27-Sep-2008
                        'Purpose : Security Issue
                        'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
                        'End By VarunA on 27-Sep-2008

                        '' 5-Oct
                        'Modified By VarunA on 24-Apr-2008 RequestID-12916
                        'Purpose : To have the value with single quotes
                        'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.General.BuildQueryString(strFieldValue)
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strFieldValue
                        'End By VarunA on 24-Apr-2008 RequestID-12916

                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
                        'Modified By ShraddhaM For Weserve Issue ID : 6283 on 3,Apr 2007
                        'Changed the Default Max Length 2000 instead of 0
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "2000").ToString
                        'End of Modification By ShraddhaM For Weserve Issue ID : 6283 on 3,Apr 2007
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
                        'arrCtlAttr(ATTR_READ_ONLY)			= False

                        ' Set the control type depending on the name of the custom field to be displayed.
                        ' For Text Area custom fields...
                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

                            ' Set the maxlengths of the textareas.
                            If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

                                'If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) Then
                                'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "3800"
                                'ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) > 3800 Then
                                '    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "3800"
                                'End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                                End If
                            End If

                            intDestinationIndex = 25 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                            '''''''''''dhn
                            ''ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
                            ''''''''dhn

                            ' For Text Box custom fields...
                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                            ' Set the maxlengths of the textboxes.
                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "100"
                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) > 100 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "100"
                            End If

                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                            End If

                            ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                            End If

                            intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                            ' For Combo Box custom fields...									
                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_ProjectId.ToString

                            ' Set the maxlengths of the combobox.
                            'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
                            'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "100"
                            'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
                            '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
                            'End If
                            If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                            End If

                            intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                            ' For Date Control custom fields...								
                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"

                            intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)
                        End If

                        ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "False"
                        If InStr("," + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                        End If

                        ' If the default value is to be retrieved from one of the common fields or custom fields, then...
                        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

                            ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
                            If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) Then

                                ' Get the index of the custom fields.
                                If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
                                    ' Text Area Range	: 26 - 28.
                                    intSourceIndex = 25 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
                                ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
                                    ' Text box Range	: 1 - 10.
                                    intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
                                    ' Combo box Range	: 11 - 20.
                                    intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
                                    ' Date control Range: 21 - 25.
                                    intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
                                End If

                                strEventHandlers = ""
                                strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('frmIBIssueEntry','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('frmIBIssueEntry','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

                                If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                    strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
                                Else
                                    strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                End If

                                strEventHandlers = strEventHandlers + "}" + vbCrLf

                                arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

                            End If

                            strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('frmIBIssueEntry','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                            strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('frmIBIssueEntry','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "');" + vbCrLf
                            strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
                            strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

                            'If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                            strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
                            'Else
                            '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                            'End If

                            strDefaultScript = strDefaultScript + "}" + vbCrLf
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = ""

                        End If

                        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))

                        Response.Write("</td>")
                        Response.Write("<td valign=top style='width:15%'>")

                        '****Code Added*******
                        'By     :   DipaliS
                        'Reason :   Apply Role Level Security to custom fields
                        'Date   :   6 July 2004
                        'Requirement No.:IB_PBN_ENT_05
                        'Addition   :  Added the code to check if security is set for given projectID and RoleID
                        Dim blnShowControl As Boolean = False
                        Dim intCounter As Integer

                        intCounter = 0
                        'If length of array is greater than 0 that means security is explicitly set
                        'In that case check if it is accessible ,if yes then show the control, 
                        'otherwise show it as not applicable
                        If intCount > 0 Then

                            While intCounter < intCount
                                'Check if the current Custom Field ID is in the array
                                If strCustomFieldIDs(intCounter).ToLower.Trim = _
                                            CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
                                    blnShowControl = True
                                End If

                                intCounter = intCounter + 1

                            End While

                        Else
                            'Commented By DipaliS To Ensure that the Custom Field will not be visible unless and untill access is set explicitly for it.
                            'blnShowControl = True
                        End If

                        '*****End Addition*******

                        'Code Commented By DipaliS 6 July 2004 and added the following
                        'If drLayout("IsCustomFieldAssigned").ToString = "1" Then

                        '****Code Added*******
                        'By     :   DipaliS
                        'Reason :   Apply Role Level Security to custom fields
                        'Date   :   6 July 2004
                        'Requirement No.:IB_PBN_ENT_05
                        'Addition   : Added one more condition to the IF to display the control
                        If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
                            '*****End Addition*****

                            Call DrawControl(ArrCtlAttr)
                            Call ClearAttributes(ArrCtlAttr)
                        Else

                            If m_blnShowDefaults = True Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
                            End If

                            'The Custom Field is not defied for the Current Type
                            Response.Write("( " + MyBase.GetResourceString("NOTAPPLICABLE") + " )")

                            'Do not save value if the Custom Field is not applicable
                            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                            CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
                            'ended by Yogesh J for HTML encoding Date:06/10/15
                            ' reset value of inactive custom fields before saving.
                            strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
                        End If
                        Response.Write("</TD>")
                        If Not drLayout.Read() Then
                            Dim i As Integer
                            For i = intCol To m_intMaxCols - 1
                                Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                            Next
                            Exit For
                        End If
                    Else
                        Response.Write("<td valign=top align=right colspan=2 style='width:25%'>&nbsp;</td>")
                        If Not drLayout.Read() Then
                            Dim i As Integer
                            For i = intCol To m_intMaxCols - 1
                                Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                            Next
                            Exit For
                        End If
                    End If
                Next
                Response.Write("</TR>")
            Next

            Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
            CommonFunction.Data.DisposeDataReader(drLayout)

            Dim intCtr As Integer
            ' Loop through the array to check if any event handlers need to be printed.
            For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

                ' If the control name is present and the event handler is present, then print it.
                ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
                ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
                ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
                If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
                    If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
                    Else
                        Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
                    End If
                    Response.Write(arrEventHandlers(intCtr, 2))
                    Response.Write("}" + vbCrLf)
                End If
            Next
            Response.Write("</SCRIPT>" + vbCrLf)
        Else
            Response.Write("<tr class=clsTREven>")
            Response.Write("<td align=center valign=center>")
            Response.Write("<b>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</b>")

            Response.Write("</td>")
            Response.Write("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        Response.Write("</TABLE>")

    End Sub 'Plot all custom fields for Issue

    Private Sub GenerateValidationScript(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
        '==================================================================================
        ' Procedure Name		:	GenerateValidationScript
        ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
        '							arrValidationMessages : The array containing the validation messages.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
        ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 17, 2004
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer

        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES).Trim, ",")

        If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
            Exit Sub
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
                'End If
            End If


            Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
            Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MIN_VALUE)
            Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_VALUE)

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														

                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",""" + arrValidations(1) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",'" + arrValidations(1) + "',false)){" + vbCrLf
                    'End If
                    'Modified By ShraddhaM on 29 Sep 2006
                    If strControlName = "StatusChangeDate" Then
                        If m_LoginType <> "C" And m_IsIssueSLAApplicable = True Then
                            strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf

                            If InStr(strControlName, "CustomField") <> 0 Then
                                strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                                'select tab if not selected
                                If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                    strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                                    'Expand section if collapsed
                                ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                    strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                                End If
                            Else
                                strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                                'select tab if not selected
                                If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                    strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                                    'Expand section if collapsed
                                ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                    strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                                End If
                            End If

                            If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                                strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                            End If
                            strValidation = strValidation + "return;" + vbCrLf
                            strValidation = strValidation + "}" + vbCrLf
                            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                        End If
                    Else
                        'Ended By ShraddhaM on 29 Sep 2006
                        strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf

                        If InStr(strControlName, "CustomField") <> 0 Then
                            strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                            'select tab if not selected
                            If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                                'Expand section if collapsed
                            ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                            End If
                        Else
                            strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                            'select tab if not selected
                            If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                                'Expand section if collapsed
                            ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                            End If
                        End If

                        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                            strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                        End If
                        strValidation = strValidation + "return;" + vbCrLf
                        strValidation = strValidation + "}" + vbCrLf
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                    End If


                Case "2" ' Valid Date.				

                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf

                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "3" ' Numeric Data.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",""" + arrValidations(3) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + arrValidations(3) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf

                    'strValidation = strValidation + "	alert( """ + arrValidations(3) + """);" + vbCrLf
                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "9" ' Only Alphabets.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",""" + arrValidations(9) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + arrValidations(9) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf

                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "12" ' Max Length
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                        If Trim(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
                            'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                            '    strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ",""" + Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) + """,false)){" + vbCrLf
                            'Else
                            '    strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ",'" + Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) + "',false)){" + vbCrLf
                            'End If

                            strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf

                            strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ");" + vbCrLf
                            If InStr(strControlName, "CustomField") <> 0 Then
                                strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                                'select tab if not selected
                                If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                    strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                                    'Expand section if collapsed
                                ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                    strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                                End If
                            Else
                                strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                                'select tab if not selected
                                If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                                    strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                                    'Expand section if collapsed
                                ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                                    strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                                End If
                            End If
                            If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                                strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                            End If
                            strValidation = strValidation + "return;" + vbCrLf
                            strValidation = strValidation + "}" + vbCrLf
                        End If
                    End If
                Case "13" ' Positive Numeric Data.				

                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if (disallowNegativeInteger(obj" + strControlName + ",""" + arrValidations(13) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if (disallowNegativeInteger(obj" + strControlName + ",'" + arrValidations(13) + "',false)){" + vbCrLf
                    'End If

                    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
                    ' Changed validation from disallowNegativeInteger to disallowNegativeNumeric

                    'strValidation = strValidation + "if (disallowNegativeInteger(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

                    'strValidation = strValidation + "	alert( """ + arrValidations(13) + """);" + vbCrLf
                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",""" + arrValidations(15) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + arrValidations(15) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf

                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "16" ' Minimum Value Check.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",""" + Replace(arrValidations(16), "<VALUE>", strMinValue) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + Replace(arrValidations(16), "<VALUE>", strMinValue) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf

                    If InStr(strControlName, "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "17" ' Maximum Value Check.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",""" + Replace(arrValidations(17), "<VALUE>", strMaxValue) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + Replace(arrValidations(17), "<VALUE>", strMaxValue) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf

                    If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "18" ' Value Range.
                    'If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION), "'") > 0 Then
                    '    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",""" + Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue) + """,false)){" + vbCrLf
                    'Else
                    '    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue) + "',false)){" + vbCrLf
                    'End If

                    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf

                    If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomField") <> 0 Then
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                        End If
                    Else
                        strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                        'select tab if not selected
                        If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            'Expand section if collapsed
                        ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                        End If
                    End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case Else
            End Select
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
            strClientSideScript = strClientSideScript + strValidation
            'Integrated by SandipL SP8 to SP9
            'Integrated by PrashantD on 2 March 2007 for Product Execution Project
            ' Modified By NitinVs on 28 May 2006 for Roamware Customization 
            ' Add case for Product 
        ElseIf UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "DESCRIPTION" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "PRODUCTVERSIONID" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "CUSTOMERID" Then
            strClientSideScript = strClientSideScript + strValidation
        End If
        ' End Modification By NitinVs on 28 May 2006 for Roamware Customization 
        'End of Integration by PrashantD on 2 March 2007


        'End Integration by SandipL SP8 to SP9

    End Sub
    Private Function CheckCustomFieldAccess(ByVal strFieldName As String) As Boolean
        '==================================================================================
        ' Procedure Name		:	CheckCustomFieldAccess
        ' Parameters Passed		:	To Check Access for Custom Fields
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Harshada D
        ' Created				:	04 June 2005
        ' Revisions				:	
        '==================================================================================

        Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer
        Dim drLayout As IDataReader
        Dim strSQLQueryField As String
        Dim drCustomFieldMaster As IDataReader
        Dim drCustomFieldAccess As IDataReader
        Dim strSQLForCustomAccess As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer

        'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
        'Integreted by SavitaS on 14 July 2006
        'Added by SavitaS on 10 July for Nucleus IssueID 22977
        'Issue : Issue status removes information from some fields
        Dim intUniqueID As String
        'End of Added by SavitaS on 10 July for Nucleus IssueID 22977
        'End of Integreted by SavitaS on 14 July 2006
        'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration

        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strSQLQueryField = "select * from tbl_IB_CustomFields_Master where ProjectID = " + m_ProjectId.ToString + "  AND   DatabaseFieldName = '" + CommonFunction.General.BuildQueryString(strFieldName) + "'"
        strSQLQueryField = "usp_sel_tbl_IB_CustomFields_Master_ProjectID " + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strFieldName) + "'"
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        drCustomFieldMaster = CommonFunction.Data.GetDataReader(strSQLQueryField, MyBase.UseSQL)
        While drCustomFieldMaster.Read
            If strFieldName = CType(CommonFunction.General.CheckIsNothing(drCustomFieldMaster("DatabaseFieldname")), String) Then

                'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
                'Integreted by SavitaS on 14 July 2006
                'Added by SavitaS on 10 July for Nucleus IssueID 22977
                'Issue : Issue status removes information from some fields
                intUniqueID = drCustomFieldMaster("UniqueID").ToString
                'End of Added by SavitaS on 10 July for Nucleus IssueID 22977
                'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration

                'modified by Harshk for sp4 issueid 539 on 10/10/2005

                'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
                'Commented and Modified by SavitaS on 10 July for Nucleus IssueID 22977
                'Issue : Issue status removes information from some fields
                'strSQLForCustomAccess = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID
                strSQLForCustomAccess = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID + ",'" + m_LoginType.ToString + "'," + intUniqueID.ToString
                'End of Commented and Modified by SavitaS on 10 July for Nucleus IssueID 22977
                'End of Integreted by SavitaS on 14 July 2006
                'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration

                'End modified by Harshk for sp4 issueid 539 on 10/10/2005
                drCustomFieldAccess = CommonFunction.Data.GetDataReader(strSQLForCustomAccess, MyBase.UseSQL)
                If drCustomFieldAccess.Read Then
                    Return True
                Else
                    Return False

                End If
                CommonFunction.Data.DisposeDataReader(drCustomFieldAccess)
            Else
                Return True
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drCustomFieldAccess)
        CommonFunction.Data.DisposeDataReader(drCustomFieldMaster)
        Return True
    End Function

    Private Sub PlotCommonFields()
        '==================================================================================
        ' Procedure Name		:	PlotCommonFields
        ' Parameters Passed		:	To plot common fields for Issue
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2003
        ' Revisions				:	
        '==================================================================================		

        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer

        Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable>")
        Response.Write("<TR class=clsTREven>")

        Dim drLayout As IDataReader
        drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + m_intLayoutID.ToString, MyBase.UseSQL)

        intCurrentCellRow = 1
        intCurrentCellCol = 1

        Dim tdwidth As Double = 1024 / (m_intMaxCols * 2)

        Do While drLayout.Read
            intRecordRow = CType(CommonFunction.Data.CheckIsDBNull(drLayout("RowNumber"), "0").ToString.Trim, Integer)
            intRecordCol = CType(CommonFunction.Data.CheckIsDBNull(drLayout("ColumnNumber"), "0").ToString.Trim, Integer)

            ' If the Field is InActive, then do not show the field.
            If CType(drLayout("Active"), Boolean) = False Then
                'Do nothing 

                ' If a new issue is being entered, and the ShowInAddMode flag is set to false, then do not show the field.
            ElseIf m_lngIssueId = 0 And CType(drLayout("ShowInAddMode"), Boolean) = False Then
                'Do nothing 

                ' If an old issue is being entered, and the ShowInEditMode flag is set to false, then do not show the field.
            ElseIf m_lngIssueId <> 0 And CType(drLayout("ShowInEditMode"), Boolean) = False Then
                'Do nothing 

                ' If the FieldName is "Summary", or "Description" or "Keywords", then do not show the field.
                ' These fields are already displayed on the top.
            ElseIf drLayout("TableFieldName").ToString.Trim.ToUpper = "SUMMARY" Or drLayout("TableFieldName").ToString.Trim.ToUpper = "DESCRIPTION" Or drLayout("TableFieldName").ToString.Trim.ToUpper = "KEYWORDS" Then
                'Do nothing 
            Else

                intRecordCellNumber = (((intRecordRow - 1) * m_intMaxCols) + intRecordCol)
                intCurrentCellNumber = (((intCurrentCellRow - 1) * m_intMaxCols) + intCurrentCellCol)

                If intCurrentCellNumber <= intRecordCellNumber Then
                    Response.Write("<td valign=top align=right width=" + tdwidth.ToString + ">")
                    If m_blnShowFormContents = True Then
                        If drLayout("TableFieldName").ToString.ToUpper = "SHOWTOCUSTOMER" Then
                            If MyBase.GetFormValue(drLayout("TableFieldName").ToString) <> "" Then
                                strFieldValue = "1"
                            Else
                                strFieldValue = "0"
                            End If
                        Else
                            strFieldValue = Request.Form(drLayout("TableFieldName").ToString)
                        End If

                    ElseIf m_blnShowRecordSetContents = True Then
                        strFieldValue = drIssueDetails(drLayout("TableFieldName").ToString).ToString
                    Else
                        strFieldValue = ""
                    End If

                    If Request.QueryString("Action") = "TypeChange" Then
                        If drLayout("TableFieldName").ToString.Trim.ToUpper = "STATUS" Or drLayout("TableFieldName").ToString.Trim.ToUpper = "SUBTYPE" Then
                            m_blnShowDefaults = True
                        End If
                    End If
                    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

                    Call GetControlAttributes(drLayout("TableFieldName").ToString, strFieldValue, ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)

                    ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

                    'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
                    'Purpose:When logintype is customer or project level issue SLA is not applicable then do not display status change fields
                    If ((m_LoginType = "C") Or (m_IsIssueSLAApplicable = False)) And ((drLayout("TableFieldName").ToString.Trim.ToUpper = "STATUSCHANGEDATE") Or (drLayout("TableFieldName").ToString.Trim.ToUpper = "STATUSCHANGETIME")) Then
                        Response.Write("<td valign=top  width=" + tdwidth.ToString + "style='display:none'>")
                    Else
                        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
                        Response.Write("</td>")
                        Response.Write("<td valign=top width=" + tdwidth.ToString + ">")
                    End If
                    'End Modification
                    Call DrawControl(ArrCtlAttr)
                    Call ClearAttributes(ArrCtlAttr)

                    If Request.QueryString("Action") = "TypeChange" Then
                        If drLayout("TableFieldName").ToString.Trim.ToUpper = "STATUS" Or drLayout("TableFieldName").ToString.Trim.ToUpper = "SUBTYPE" Then
                            m_blnShowDefaults = False
                        End If
                    End If

                    Response.Write("</td>")

                    intCurrentCellCol = intCurrentCellCol + 1
                    If intCurrentCellCol > m_intMaxCols Then
                        intCurrentCellCol = 1
                        intCurrentCellRow = intCurrentCellRow + 1

                        Response.Write("</tr>")
                        Response.Write("<tr class=clsTREven>")
                    End If
                ElseIf intCurrentCellNumber < intRecordCellNumber Then
                    Response.Write("<td valign=top align=right colspan=2 width=" + (tdwidth * 2).ToString + ">")
                    Response.Write("&nbsp;")
                    Response.Write("</td>")
                    intCurrentCellCol = intCurrentCellCol + 1
                    If intCurrentCellCol > m_intMaxCols Then
                        intCurrentCellCol = 1
                        intCurrentCellRow = intCurrentCellRow + 1
                        Response.Write("</tr>")
                        Response.Write("<tr class=clsTREven>")
                    End If
                End If
            End If
        Loop

        CommonFunction.Data.DisposeDataReader(drLayout)

        'Display the remaining blank cells.
        Dim intcol As Integer
        For intcol = intCurrentCellCol To m_intMaxCols
            Response.Write("<td valign=top align=right colspan=2 width=" + (tdwidth * 2).ToString + ">")
            Response.Write("&nbsp;")
            Response.Write("</td>")
        Next

        Response.Write("</TABLE>")

    End Sub 'Plot all common fields for Issue

    Private Sub ClearAttributes(ByRef arrCtlAttr As String())
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	arrCtlAttr : This array has to be re-initialised for each control
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets reinitialised.
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes

    Private Sub GenerateKeywordsSection()
        '=====================================================================
        ' Procedure Name        : GenerateKeywordsSection
        ' Purpose               : To generate keywords section
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file for IssueEntry
        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        'Get the layout information for the "Keywords" combobox.
        Dim drLayout, drIssueDetails As IDataReader
        Dim strKeyWords() As String

        'Determine, if keywords are to be displayed
        drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + m_intLayoutID.ToString + ", NULL, 'Keywords'", MyBase.UseSQL)
        drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + m_lngIssueId.ToString, MyBase.UseSQL)
        If Not drLayout.Read Then
            CommonFunction.Data.DisposeDataReader(drLayout)
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
            Exit Sub
        ElseIf Not ((m_lngIssueId = 0 And CType(drLayout("ShowInAddMode"), Boolean) = True) Or (m_lngIssueId <> 0 And CType(drLayout("ShowInEditMode"), Boolean) = True)) Then
            'Exit if in edit mode and keywords are not to be shown in edit mode 
            'or in Addnew mode and keywords are not to be shown in addnew mode 
            CommonFunction.Data.DisposeDataReader(drLayout)
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
            Exit Sub
        End If

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        With cObjSectionTitle
            'Integrated by MrugajaB on 28th Apr,2005 for WhizibleSEM SP3
            'Added by Priyanka, to fix Issue: 15577, 27th Jan 2005
            'Changing caption of Keywords in Field Caption, does not effect in Issues Module
            Response.Write(.GetSectionTitle(GetUserFriendlyName(MyBase.GetResourceString("KEYWORDSSECTIONTITLE")), "DivKeywords", "ShowHideKeywords"))
            'End Of Addition

            'Commented by Priyanka for the resolution of above issue
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("KEYWORDSSECTIONTITLE"), "DivKeywords", "ShowHideKeywords"))
            'End Comment
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        'Div for section title
        'Response.Write("<DIV Id='DivKeywords' Style='Overflow:Auto;HEIGHT:30px;'>")
        Response.Write("<DIV Id='DivKeywords' Style='Overflow:Auto;width=99.9%;HEIGHT:50px;'>")

        'Destroy the object
        cObjSectionTitle = Nothing

        If m_blnShowRecordSetContents = True Then 'Edit mode / refresh after addnew - save
            If m_IssuePresent Then
                If drIssueDetails.Read Then
                    If Not drIssueDetails("Keywords") Is Nothing Then
                        strKeyWords = Split(drIssueDetails("Keywords").ToString.Trim, ",")
                        ReDim Preserve strKeyWords(5)
                    Else
                        ReDim strKeyWords(5)
                    End If
                Else
                    ReDim strKeyWords(5)
                End If
            Else
                ReDim strKeyWords(5)
            End If
        ElseIf m_blnShowFormContents = True Then ' Refresh after type changed
            If Not Request.Form("KeyWords") Is Nothing Then
                strKeyWords = Split(Request.Form("KeyWords").Trim + "", ",")
                ReDim Preserve strKeyWords(5)
            Else
                ReDim strKeyWords(5)
            End If
        Else ' AddNew mdoe
            ReDim strKeyWords(5)
        End If

        'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
        'Purpose : Firefox Support, 100% changed to 99.9%
        'Response.Write("<table cellSpacing=0 class=clsTable width='100%'>")
        Response.Write("<table cellSpacing=0 class=clsTable width='99.9%'>")
        'Modification Ends by SantoshK on June 8, 2006
        Response.Write("<tr class=clsTREven>")

        'First combo of five
        Response.Write("<td width=20%>")
        Call GetControlAttributes("Keywords", Trim(strKeyWords(0) & ""), ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)
        Call DrawControl(ArrCtlAttr)
        Response.Write("</td>")

        'second combo of five
        Response.Write("<td width=20%>")
        Call GetControlAttributes("Keywords", Trim(strKeyWords(1) & ""), ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)
        Call DrawControl(ArrCtlAttr)
        Response.Write("</td>")

        'third combo of five
        Response.Write("<td width=20%>")
        Call GetControlAttributes("Keywords", Trim(strKeyWords(2) & ""), ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)
        Call DrawControl(ArrCtlAttr)
        Response.Write("</td>")

        'Fourth combo of five
        Response.Write("<td width=20%>")
        Call GetControlAttributes("Keywords", Trim(strKeyWords(3) & ""), ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)
        Call DrawControl(ArrCtlAttr)
        Response.Write("</td>")

        'Fifth combo of five
        Response.Write("<td width:20%>")
        Call GetControlAttributes("Keywords", Trim(strKeyWords(4) & ""), ArrCtlAttr, drLayout("UserFriendlyName").ToString, drLayout("Mandatory").ToString, drLayout("ReadOnlyInAddMode").ToString, drLayout("ReadOnlyInEditMode").ToString, drLayout("ControlWidth").ToString)
        Call DrawControl(ArrCtlAttr)
        Response.Write("</td>")

        Response.Write("</tr>")
        Response.Write("</table>")

        Response.Write("</DIV>")

        CommonFunction.Data.DisposeDataReader(drLayout)
        CommonFunction.Data.DisposeDataReader(drIssueDetails)
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
    End Sub 'Generate Issue Keywords Section

    Private Sub GenerateAttachmentsSection()
        '=====================================================================
        ' Procedure Name        : GenerateAttachmentsSection
        ' Purpose               : To generate Attachments section
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Do not show Attachments section if IssueId is 0
        If m_lngIssueId = 0 Then Exit Sub

        'Initialize Resource file for IssueList
        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        With cObjSectionTitle
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("ATTACHMENTSSECTIONTITLE"), "DivAttachments", "ShowHideAttachments"))
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With

        'Destroy the object
        cObjSectionTitle = Nothing

        'Generate Attachments grid
        Dim ArrActualColumnNames() As String = {"OriginalFileName", "AttachedBy", "Description", ""}
        Dim ArrUserFriendlyColumnNames() As String = {MyBase.GetResourceString("FILENAME"), MyBase.GetResourceString("ATTACHEDBY"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("DELETE")}
        Dim ArrRowLinks() As String = {"Attachment_OnClick(AttachmentId)"}
        Dim ArrDeleteCkechBox() As String = {"", "", "", "ChkDelete"}
        'Commented And Added By Usha Pandit On 31.03.2020 For wrapping long description
        'Dim ArrTDStyle() As String = {"", "", "", "Align=center"}
        Dim ArrTDStyle() As String = {"", "", "style ='word-break: break-all;width: 200px'", "Align=center"}
        'End Of Added By Usha Pandit On 31.03.2020 For wrapping long description

        With objAttachmentsGrid
            .ActualColumnArray = ArrActualColumnNames
            .UserFriendlyColumnArray = ArrUserFriendlyColumnNames
            .PrimaryKey = "AttachmentId"
            .CheckBoxIDArray = ArrDeleteCkechBox
            .TDStyleArray = ArrTDStyle
            .UseSQL = m_UseSQL
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = 3
            .DIVID = "DivAttachments"
            .DIVHeight = 100
            .DIVStyle = "Overflow:Auto"
            .RowLinkArray = ArrRowLinks
            .SQL = "usp_Sel_tbl_IB_Attachments " + m_lngIssueId.ToString
            .DrawGrid()
        End With

        objAttachmentsGrid = Nothing

    End Sub 'Generate Issue Attachments section

    Private Sub GetProjectIdAndRoleId()
        '=====================================================================
        ' Procedure Name        : SetProjectIdAndRoleId
        ' Purpose               : To set ProjectId and RoleId
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 1. In "Add" mode the ProjectID is set to the selected Project, 
        '                            and the role is set to the current Role
        '                         2. in "Edit" mode get the ProjectID and RoleID corresponding to the current IssueID  
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 9, 2004
        ' Revisions             :
        '=====================================================================
        Dim drProject As IDataReader

        If m_lngIssueId = 0 Then

            'commented by AniruddhaD on 18 Nov 2005 for providing project combo ob issue list page(IssueID:685)
            'm_ProjectId = CType(Session("intProjectID"), Long)

            'Added by AniruddhaD on 18 Nov 2005 for providing project combo ob issue list page(IssueID:685)
            m_ProjectId = CType(Session("IssueProject"), Long)
            'Code Commented by SandipL on 17 Feb 2006 since already initialized according to IssuProject
            ' m_RoleId = CType(Session("intPostID"), Long)
            'End Commenting by SandipL on 17 Feb 2006 
            ' Else, in "Edit" mode get the ProjectID and RoleID corresponding to the current IssueID.
        Else
            ' Check for the ProjectID in the QueryString collection.
            If Not Request.QueryString("ProjectId") Is Nothing Then
                If Request.QueryString("ProjectId").Trim <> "" Then
                    m_ProjectId = CType(Request.QueryString("ProjectId").Trim, Long)
                End If
                ' Else, get the ProjectID corresponding to the IssueID.
            ElseIf m_lngIssueId <> 0 Then
                Dim drIssueDetails As IDataReader
                drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " & m_lngIssueId.ToString, MyBase.UseSQL)
                If drIssueDetails.Read Then
                    m_ProjectId = CType(drIssueDetails("ProjectID"), Long)
                End If
                CommonFunction.Data.DisposeDataReader(drIssueDetails)
            End If

            If m_LoginType = "E" Then
                'Code commented and added by MrugajaB on 6th Oct 2006
                'Purpose:When logged in user is Higg or middle level resoource ,his corporate role should be considered
                'Project level role should be considered onlt for low level resources
                ' Get the role of the Employee in the current project.
                'drProject = CommonFunction.Data.GetDataReader("Exec usp_Sel_EmployeeProjectRole " + m_ProjectId.ToString + ", " + m_UserId.ToString, MyBase.UseSQL)
                'If drProject.Read Then
                '    m_RoleId = CType(drProject("Role"), Long)
                'Else
                '    m_RoleId = CType(Session("intPostID"), Long)
                'End If
                'CommonFunction.Data.DisposeDataReader(drProject)

                Dim intCorporateRoleLevel As Integer
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
                intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_RoleID " & CType(Session("intUserID"), String) & "", MyBase.UseSQL), Integer)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then

                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

                    drProject = CommonFunction.Data.GetDataReader("Exec usp_Sel_EmployeeProjectRole " + m_ProjectId.ToString + "," + m_UserId.ToString, MyBase.UseSQL)
                    If drProject.Read Then
                        m_RoleId = CType(drProject("Role"), Long)
                    Else
                        m_RoleId = CType(Session("intPostID"), Long)
                    End If
                    CommonFunction.Data.DisposeDataReader(drProject)

                End If

                'End Modification
            End If
        End If

        drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + m_ProjectId.ToString, MyBase.UseSQL)
        If drProject.Read Then
            'Share Issue within Project Group ?
            m_blnShareIBWithinProjectGroup = CType(drProject("ShareIBWithinProjectGroup"), Boolean)

            'Is Project Over ?
            m_blnIsProjectOver = CType(drProject("Over"), Boolean)

            'Send mail to responsible person ?
            m_blnSendResponsiblePersonMail = CType(drProject("SendResponsiblePersonMail"), Boolean)

            'Assign Issue To responsible person ?
            If CommonFunction.Application.AssignIssueToResponsiblePerson = True Then
                m_blnAssignIssueToResponsiblePerson = CType(drProject("AssignIssueToResponsiblePerson"), Boolean)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drProject)

    End Sub 'Get ProjectId and RoleId

    Private Sub GetSortingDetails()
        '=====================================================================
        ' Procedure Name        : GetSortingDetails()	
        ' Purpose               : to get sorting details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        ' if querystring has OrderBy
        If Not Request.QueryString("OrderBy") Is Nothing Then
            If Request.QueryString("OrderBy").Trim <> "" Then
                m_strSortField = Request.QueryString("OrderBy").Trim
            Else ' By default, sort on IssueId
                'Code Commented by DipaliS 30 Sep 2004 and added the following line
                'Purpose    :   To Remove the Default sorting on Issue ID
                'm_strSortField = "IssueID"
                m_strSortField = ""
            End If
        ElseIf Not MyBase.GetFormValue("txtSortField") Is Nothing Then
            If MyBase.GetFormValue("txtSortField").Trim <> "" Then
                m_strSortField = MyBase.GetFormValue("txtSortField").Trim
            End If
        Else
            'Code Commented by DipaliS 30 Sep 2004 and added the following line
            'Purpose    :   To Remove the Default sorting on Issue ID
            ' m_strSortField = "IssueID"
            m_strSortField = ""
        End If

        ' If querystring has sort order
        'Modified By Parag
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ASCDESC"), "") <> "" Then
            If Request.QueryString("ASCDESC").Trim <> "" Then
                m_strSortOrder = Request.QueryString("ASCDESC").Trim
            Else ' By default sort order is desc
                m_strSortOrder = "DESC"
            End If
            ' By default sort order is desc
        Else
            m_strSortOrder = Request.Form("txtSortOrder")
        End If
    End Sub 'Get Sorting details 

    Private Sub GetDisplayMode()
        '=====================================================================
        ' Procedure Name        : GetDisplayMode()	
        ' Purpose               : to get display mode, page will open in
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        'Added By VivekP On 2 Apr 2005 For Copy Functionality
        ' Get the action to be performed.
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If
        'End Of Addition By VivekP On 2 Apr 2005 For Copy Functionality

        ' Get the current mode.
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode").Trim
            Else
                If m_lngIssueId = 0 Then
                    m_strMode = "New"
                Else
                    m_strMode = "Edit"
                End If
            End If
        Else
            If m_lngIssueId = 0 Then
                'added by VivekP On 2 Apr 2005 for copy functionality
                If m_strAction = "CopyIssue" Then
                    m_strMode = "CopyIssue"
                Else
                    m_strMode = "New"
                End If
                'end of addition by VivekP On 2 Apr 2005 for copy functionality
            Else
                m_strMode = "Edit"
            End If
        End If

        ' Get the action to be performed.
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If

        ' If a new issue is being entered, and the user has accessed the page for the first time, then show the default values.
        If m_strMode = "New" Then 'And MyBase.GetFormValue("IssueID").Trim = "" Then
            If m_strAction = "TypeChange" Then
                m_blnShowFormContents = True
                m_blnShowDefaults = False
            ElseIf m_strAction = "Save" Then
                m_blnShowRecordSetContents = True
                'added by VivekP On 2 Apr 2005 for copy functionality
            ElseIf m_strAction.ToUpper = "COPYISSUE" Then
                m_blnShowDefaults = True
                'end of addition by VivekP On 2 Apr 2005 for copy functionality
            Else
                m_blnShowDefaults = True
            End If

        ElseIf m_strMode = "Edit" Then
            If m_strAction = "TypeChange" Then
                m_blnShowFormContents = True
                m_blnShowDefaults = False
            Else
                m_blnShowRecordSetContents = True
            End If
            ' If an existing issue has to be shown, and the user has accessed the page for the first time, then show the recordset contents.
            'added by VivekP On 2 Apr 2005 for copy functionality
        ElseIf m_strMode.ToUpper = "COPYISSUE" Then
            m_blnShowDefaults = False
            m_blnShowRecordSetContents = False
            m_blnShowFormContents = True
            'end of addition by VivekP On 2 Apr 2005 for copy functionality
        Else
            ' If the user has made changes, and the type has been changed, then the form is submitted. So the form contents must be displayed in that case.
            m_blnShowFormContents = True
        End If

    End Sub 'Get display mode

    Private Sub GetTimeSheetDetailsForIssue()
        '=====================================================================
        ' Procedure Name        : GetTimeSheetDetailsForIssue()	
        ' Purpose               : to get timesheet details of the issue
        ' Description           : If Issue has timesheet entries, type can't be changed in edit mode
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        If m_lngIssueId <> 0 Then
            Dim drTimeSheet As IDataReader
            drTimeSheet = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_DailyActivity_For_Issue " & m_lngIssueId.ToString, MyBase.UseSQL)
            If drTimeSheet.Read Then
                m_blnShowTimesheetDetails = True
            End If
            CommonFunction.Data.DisposeDataReader(drTimeSheet)
        End If

        If Not Request.QueryString("IssueNavigation") Is Nothing Then
            If Request.QueryString("IssueNavigation").Trim = "True" Or Request.QueryString("IssueNavigation").Trim = "1" Then
                m_blnIssueNavigation = True
            Else
                m_blnIssueNavigation = False
            End If
        Else
            If m_strMode = "Edit" Then
                If Not Request.QueryString("GoTo") Is Nothing Then
                    If Request.QueryString("GoTo") = "1" Then
                        m_blnIssueNavigation = False
                    End If

                    'Else
                    '    m_blnIssueNavigation = True
                End If
            End If
        End If
    End Sub 'Time details for the Issue

    Private Sub GetIssueDetails()
        '=====================================================================
        ' Procedure Name        : GetIssueDetails()	
        ' Purpose               : to get issue details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        ' Get the details of the current IssueID.
        ' NOTE : If the IssueID = 0, then a blank recordset will be returned.
        drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + m_lngIssueId.ToString, MyBase.UseSQL)
        If Not drIssueDetails.Read Then
            m_lngIssueId = 0
        Else
            m_IssuePresent = True
        End If
        'CommonFunction.Data.DisposeDataReader(drIssueDetails)
    End Sub 'Issue Details

    Private Sub GetCurrentType()
        '=====================================================================
        ' Procedure Name        : GetIssueDetails()	
        ' Purpose               : to get issue details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        ' If the default values have to shown, then retrieve the default type for the project.
        If m_blnShowDefaults = True Then
            Dim strSQLQuery As String = ""
            Dim drDefaultValue As IDataReader

            '------------------------------------------------------------------------------------------------
            'added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
            If blnCalledFromReview = True Then
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type_GetReviewType " + m_ProjectId.ToString

                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    m_strCurrentType = drDefaultValue("Type").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)
            End If
            'End of addition by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review
            '------------------------------------------------------------------------------------------------

            ' Get the default Type for the current Project.
            strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'T', " + m_ProjectId.ToString
            drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drDefaultValue.Read Then
                m_strCurrentType = drDefaultValue("Type").ToString.Trim
            End If
            CommonFunction.Data.DisposeDataReader(drDefaultValue)
        End If

        ' If the recordset contents have to be shown, then...
        If m_blnShowRecordSetContents = True Then
            If m_IssuePresent Then
                m_strCurrentType = drIssueDetails("Type").ToString.Trim
            Else
                m_strCurrentType = Request.Form("Type")
            End If
        End If

        ' If the form contents have to be shown, then...
        If m_blnShowFormContents = True Then
            If Not Request.Form("Type") Is Nothing Then
                m_strCurrentType = Request.Form("Type")
            Else
                m_strCurrentType = ""
            End If
        End If

    End Sub 'get default type for the project

    Private Sub GetIssueLayout()
        '=====================================================================
        ' Procedure Name        : GetIssueLayout()	
        ' Purpose               : to get issue layout to be applied
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim drLayout As IDataReader
        Dim strSQL As String
        Dim strIssueType As String

        ' Get the layout ID to be applied. 	
        'added by VivekP On 2 APr 2005 for copy functionality
        If m_strAction.ToUpper = "COPYISSUE" Then
            strSQL = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
            strIssueType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
            drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_GetIssueLayoutToBeApplied " + m_ProjectId.ToString + ", " + m_RoleId.ToString + ", '" + CommonFunction.General.BuildQueryString(strIssueType) + "'", MyBase.UseSQL)
        Else
            'End Of Addition On 2 APr 2005 for copy functionality
            drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_GetIssueLayoutToBeApplied " + m_ProjectId.ToString + ", " + m_RoleId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType) + "'", MyBase.UseSQL)
        End If

        If drLayout.Read Then

            ' Get the layout ID.
            m_intLayoutID = CType(drLayout("LayoutID"), Long)

            ' Get the maximum rows in the layout.
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)

            ' Get the maximum columns in the layout.
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)

            m_blnShowIssueAssignmentLink = CType(drLayout("ShowIssueAssignmentLink"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)
    End Sub 'Get Issue Layout attributes maxrows, maxcols etc.

    Private Sub GetControlAttributes(ByVal strFieldName As String, ByVal strFieldValue As String, ByRef arrCtlAttr() As String, Optional ByVal strUserFriendlyName As String = "", Optional ByVal strMandatory As String = "", Optional ByVal strReadOnlyInAddMode As String = "", Optional ByVal strReadOnlyInEditMode As String = "", Optional ByVal strControlWidth As String = "")
        '==================================================================================
        ' Procedure Name		:	GetControlAttributes
        ' Parameters Passed		:	strFieldName  :- The field name.
        '							strFieldValue :- The field value.
        '							arrCtlAttr	  :- The array gets modified.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr    : The control attributes are set in this array.
        ' Purpose				:	To set the attributes of the control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 10, 2004
        ' Revisions				:	
        ' Revisions				:	NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        '                           Added parameters for strUserFriendlyName , strMandatory, strReadOnlyInAddMode , strReadOnlyInEditMode , strControlWidth                    

        '==================================================================================		
        Dim drDefaultValue As IDataReader
        Dim strSQLQuery As String
        'Added by PrajaktaR for Nucleus IssueID 18970
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject

        'Modifed by NitinVS on 25 July 2007 for WhizibleSEM 7 
        'To reduce calls to the selected for server time miving the the code to
        'Modified by Shraddham on 7th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
        'Purpose : To Display Server Date And Time
        'Dim h As Integer
        'Dim m As Integer
        'Dim strHour As String
        'Dim strMinute As String

        'Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        'Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        'Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        h = CType(Left(strGetServerTime1, 2), Integer)
        m = CType(Right(strGetServerTime1, 2), Integer)

        If h < 10 Then
            strHour = "0" + h.ToString
        Else
            strHour = h.ToString

        End If
        If m < 10 Then
            strMinute = "0" + m.ToString
        Else
            strMinute = m.ToString
        End If
        'end of modification shraddhaM
        'End of Addition by PrajaktaR for Nucleus IssueID 18970

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = Trim(strFieldName)
        If Trim(strFieldName) = "Keywords" Then
            If InStr(declarevariables, "Keywords") = 0 Then
                declarevariables = declarevariables + "var obj" + strFieldName + "= GetObjectReference('frmIBIssueEntry','" + strFieldName + "',1);" + vbCrLf
            End If
        Else
            declarevariables = declarevariables + "var obj" + strFieldName + "= GetObjectReference('frmIBIssueEntry','" + strFieldName + "');" + vbCrLf
        End If

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "False"

        'Dim drLayout As IDataReader

        Select Case strFieldName.ToUpper
            Case "ASSIGNTO"
                strFieldName = "AssignToName"
            Case "CODEDBY"
                strFieldName = "CodedByName"
            Case "CHANGEREQUESTID"
                strFieldName = "ChangeRequestName"
        End Select

        ' Modified By NitinVS on 5 aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' used The Attributes send as parameter to the Procedure inplace of getting from database. 

        ' Get the layout ID to be applied. 	
        If strFieldName.ToUpper = "SUMMARY" Or strFieldName.ToUpper = "DESCRIPTION" Then
            Dim drLayout As IDataReader
            drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL," + m_intLayoutID.ToString + ", NULL, '" + strFieldName + "'", MyBase.UseSQL)

            If Not drLayout Is Nothing Then
                If drLayout.Read Then
                    ' Modified By NitinVS on 5 aug 2005 changed GetUserFriendlyName(strFieldName) to drLayout("UserFriendlyName").ToString
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = drLayout("UserFriendlyName").ToString  'GetUserFriendlyName(strFieldName)
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = drLayout("Mandatory").ToString
                    If m_lngIssueId = 0 Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = drLayout("ReadOnlyInAddMode").ToString
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = drLayout("ReadOnlyInEditMode").ToString
                    End If

                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = drLayout("ControlWidth").ToString


                End If
                CommonFunction.Data.DisposeDataReader(drLayout)
            End If

        Else
            'Added by SavitaS on 26 Sept for SP7 IssueID 4887
            If (m_LoginType = "C") And strFieldName.ToUpper = "SHOWTOCUSTOMER" Then
            Else
                'Commented and Added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)

                ''End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = strUserFriendlyName '---GetUserFriendlyName(strFieldName)
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = strMandatory
                'If m_lngIssueId = 0 Then
                '    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInAddMode
                'Else
                '    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInEditMode
                'End If

                '' Added By NitinVS on 10 Aug 2005 The Width is brought from a single 
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = strControlWidth
                '' Added by SavitaS on 26 Sept for SP7 IssueID 4887

                If strFieldName.ToUpper = "RELEASEID" Or strFieldName.ToUpper = "ITERATIONID" Or strFieldName.ToUpper = "USERSTORYID" Then
                    m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                    If m_intFlag = "1" Then
                        'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = strUserFriendlyName '---GetUserFriendlyName(strFieldName)
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = strMandatory
                        If m_lngIssueId = 0 Then
                            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInAddMode
                        Else
                            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInEditMode
                        End If

                        ' Added By NitinVS on 10 Aug 2005 The Width is brought from a single 
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = strControlWidth
                        ' Added by SavitaS on 26 Sept for SP7 IssueID 4887
                    End If
                Else
                    'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = strUserFriendlyName '---GetUserFriendlyName(strFieldName)
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = strMandatory
                    If m_lngIssueId = 0 Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInAddMode
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = strReadOnlyInEditMode
                    End If

                    ' Added By NitinVS on 10 Aug 2005 The Width is brought from a single 
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = strControlWidth
                    ' Added by SavitaS on 26 Sept for SP7 IssueID 4887
                End If
                'End of Commented and Added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)

            End If
            'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887

        End If

        ' Commented By NitinVS as Witdth Details is updated above.
        ''Code Commented By DipaliS 13 July 2004 and added the following
        ''arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "160"
        ''******Code Added ******
        ''By : DipaliS
        ''Date : 13 July 2004
        ''Purpose : To get the width of control from datadictionary.
        'Dim intWidth As Integer

        'intWidth = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_ib_datadictionary_GetWidth " + CommonFunctions.General.BuildQueryString(strFieldName), _
        'MyBase.UseSQL), "160"), Integer)

        'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = intWidth.ToString
        ''********End addition*********

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        If strFieldValue <> "" Then
            'Commented And Modified By JyotiG for Issue ID : 7198
            ' SerachKey: JG_7198_26-Oct-2006
            'Start
            'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.General.UnBuildQueryString(strFieldValue)
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strFieldValue
            'End of mOdification By JyotiG
        Else
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strFieldValue
        End If

        Select Case UCase(Trim(strFieldName))

            Case "ASSIGNTO", "ASSIGNTONAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "145"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " + m_ProjectId.ToString

                If strFieldValue <> "" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) & ", " & strFieldValue
                    '****Code Added*******
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   30 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :  Added the else part to add Null

                Else
                    '****Code Added*******
                    'By     :   DipaliS
                    'Reason :   Issue Responsible Person
                    'Date   :   4 July 2004
                    'Requirement No.:IB_PBN_ENT_02
                    'Addition   :  Added the Code to set the default responsible person
                    'Get the Responsible Person For Current Project

                    'Code Modified for IssueID - 15703
                    'If m_strCurrentType <> "" Then

                    'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                    'Added by SatyanarayanaA on 13-Jan-2006 
                    If blnCalledFromReview = True Then
                        'Test Start
                        'Added by SatyanarayanaA on 13-Jan-2006 for Displaying the Selected item As Default in the Combo
                        Dim ReviewActionID As String = Request.QueryString("ReviewActionID") + ""
                        If ReviewActionID = "" Then
                            ReviewActionID = "0"
                        End If
                        'ReviewActionID = CStr(CommonFunction.Data.GetDataScalar("select ISNULL(Reviewee,0) from tbl_PM_ReviewActions where ReviewActionId=" + ReviewActionID, MyBase.UseSQL)) & ""
                        If strIssueIDs = "" Then
                            drEmployee = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString + "," + ReviewActionID.ToString, MyBase.UseSQL)
                        Else
                            drEmployee = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString, MyBase.UseSQL)
                        End If

                        If drEmployee.Read Then
                            intAssignTo = CInt(CommonFunction.Data.CheckIsDBNull(drEmployee("EmployeeID"), "0"))
                        End If

                        drEmployee.Close()
                        CommonFunction.Data.DisposeDataReader(drEmployee)


                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intAssignTo.ToString  'intEmployeeID.ToString 'Reviewee
                        'Ended by SatyanarayanaA on 13-Jan-2006 for Displaying the Selected item As Default in the Combo

                        'Test End




                        'Commented By SatyanarayanaA on 13-Jan-2005
                        'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intEmployeeID.ToString 'Reviewee
                        'End Commented By SatyanarayanaA on 13-Jan-2005
                    Else
                        Dim intResponsiblePerson As Integer
                        Dim strSQL As String
                        strSQL = "usp_sel_tbl_ib_TypeResponsiblePerson " + m_ProjectId.ToString
                        intResponsiblePerson = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer)
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intResponsiblePerson.ToString

                        'Addition by SnehalV-18th Oct
                        If m_strAction.ToUpper = "COPYISSUE" Then
                            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = intResponsiblePerson.ToString
                        End If
                        'end of addition by SnehalV
                        'End If
                    End If
                    'Ended by SatyanarayanaA on 13-Jan-2006 

                    '*********End Addition*******

                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) & ",Null"
                    '*********End Addition*******
                End If

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   30 June 2004
                'Requirement No.:IB_PBN_ENT_01
                'Addition   :  Added one more parameter "Type" to the sp that fills the combo depending upon the type
                If m_strCurrentType <> "" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) & ",Null,Null,'" + CommonFunctions.General.BuildQueryString(m_strCurrentType) + "'"
                End If

                '*********End Addition*******

                If m_lngIssueId <> 0 And arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "145"
                End If

                'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                'Code Added By PradipK on 15 Feb 2006
                'To Add Complexity 
                ' Get the default Complexity for the project.
            Case "COMPLEXITY"
                If m_lngIssueId = 0 Then
                    strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Complexity " + m_ProjectId.ToString & ", 1"
                    drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    If drDefaultValue.Read Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Complexity").ToString.Trim
                    End If
                    CommonFunction.Data.DisposeDataReader(drDefaultValue)
                End If



                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Complexity " + m_ProjectId.ToString


                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If


            Case "STATUSCHANGEDATE"
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY ) =dr
                'Modified by Shraddham on 8th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                'Purpose : To Display Server Date
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                If m_lngIssueId = 0 Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strGetServerDate1     'CommonFunction.Dates.GetDate(Now())
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                If m_strAction.ToUpper = "COPYISSUE" Then
                    'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Dates.GetDate(Now())
                End If

            Case "STATUSCHANGETIME"


                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "50"
                If m_lngIssueId = 0 Then
                    'Modified by Shraddham on 7th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                    'Purpose : To Display Server Time
                    'If Now.Minute.ToString.Length < 2 Then
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = Now.Hour.ToString + ":0" + Now.Minute.ToString
                    'Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strHour + ":" + strMinute
                    'End If
                End If
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "5"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "onkeypress=""Time_OnKeyPress(event)"""
                '************End Addition*************

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    'Added and Commented By VijayD On 24 August 2009
                    If m < Now.Minute.ToString Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + "0" + Now.Minute.ToString
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                    End If
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                    'End Addition and Commnet By VijayD  On 24 August 2009
                End If

                'End Addition By PradipK on 15 Feb 2006

                'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
                'Purpose:When logintype is customer or Project level issue SLA is not applicable then do not display status change date field

                If (m_LoginType = "C") Or (m_IsIssueSLAApplicable = False) Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = " style='display:none'"
                End If
                'End Modification

            Case "CHANGEREQUESTID", "CHANGEREQUESTNAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_ChangeRequest_Master " + m_ProjectId.ToString

                'added by VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'ChangeRequestID'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                'end of addition on 2 Apr 2005 for Copy functionality

            Case "CODEDBY", "CODEDBYNAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
                'Commneted and Modified by SavitaS on 20 July 2006 for Nucleus IssueID 22977
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + m_ProjectId.ToString + ", NULL ,NULL, NULL, NULL , 'E','" & m_strMode & "'" & "," & m_lngIssueId
                'End of  Commneted and Modified by SavitaS on 20 July 2006 for Nucleus IssueID 22977
                'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration

                'added by VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'CodedBy'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                'end of addition on 2 Apr 2005 for Copy functionality
                'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If blnCalledFromReview = True Then
                    'Added by SatyanarayanaA on 13-Jan-2006 for Displaying the Selected item As Default in the Combo
                    Dim ReviewActionID As String = Request.QueryString("ReviewActionID") + ""
                    If ReviewActionID = "" Then
                        ReviewActionID = "0"
                    End If
                    'ReviewActionID = CStr(CommonFunction.Data.GetDataScalar("select IsNULL(Reviewee,0) from tbl_PM_ReviewActions where ReviewActionId=" + ReviewActionID, MyBase.UseSQL)) & ""
                    If strIssueIDs = "" Then
                        drEmployee = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString + "," + ReviewActionID.ToString, MyBase.UseSQL)
                    Else
                        drEmployee = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString, MyBase.UseSQL)
                    End If

                    If drEmployee.Read Then
                        intAssignTo = CInt(CommonFunction.Data.CheckIsDBNull(drEmployee("EmployeeID"), "0"))
                    End If

                    drEmployee.Close()
                    CommonFunction.Data.DisposeDataReader(drEmployee)


                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intAssignTo.ToString 'intEmployeeID.ToString 'Reviewee
                    'Ended by SatyanarayanaA on 13-Jan-2006 for Displaying the Selected item As Default in the Combo
                End If

            Case "CORRECTEDINVERSION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString

                'added by VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                'end of addition On 2 Apr 2005 for Copy functionality

            Case "CUSTOMERISSUEID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "30"

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Deliverable Feature
                'Date   :   19 Aug 2004
                'Addition   :   Added the case for Deliverable
            Case "DELIVERABLEID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString
                'added by VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'DeliverableID'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If

                '************End Addition*************

                '--------------------------------------------------------------------------------------------
                'added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = intDeliverableID.ToString
                End If
                'end of addition by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review
                '--------------------------------------------------------------------------------------------

            Case "DESCRIPTION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "895"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT) = "60"

                'added by AniruddhaD on 16 Nov 2005 for common page for issue entry for issue and review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strCause
                End If
                'end of addition

            Case "DUEDATE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "DURATION"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "4"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "70"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = "13,"

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


            Case "FIXEDINPHASE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "FOUNDINPHASE"
                ' Get the current phase of the project.

                'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strProjectPhase
                Else
                    strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Phases " + m_ProjectId.ToString + ", NULL, 1"
                    drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    If drDefaultValue.Read Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Phase").ToString.Trim + ""
                    End If
                    CommonFunction.Data.DisposeDataReader(drDefaultValue)
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                'End Integration by MrugajaB
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString
                'Added By GaneshD on 04 Jun 2009 for Issue Base statusflow configuration
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString + "," + CType(m_lngIssueId, String) + ",'" + m_LoginType + "'," + "1"
                ' Addition end by GaneshD

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


            Case "HARDWARE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_ProjectHardware " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


            Case "IMPORTID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "25"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = "13,"

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "KERNEL"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Kernels " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


            Case "KEYWORDS"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Keywords " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "180"

            Case "MODULENAME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                ' Added BY MahendraV On 12:33 PM 5/11/2007
                'Start_MV_5/11/2007
                If m_lngIssueId > 0 Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_Module_ProjectGroup " + m_ProjectId.ToString + "," + m_lngIssueId.ToString
                Else
                    'End_MV_5/11/2007
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_Module_ProjectGroup " + m_ProjectId.ToString + ",NULL"
                End If
                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

                'added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strModuleName
                End If
                'end of addition by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review

            Case "OS"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_OS " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality


            Case "PHASE"
                ' Get the current phase of the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Phases " + m_ProjectId.ToString & ", NULL, 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Phase").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "PRIORITY"

                ' Get the default priority for the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectId.ToString & ", 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Priority").ToString.Trim
                End If

                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Priorities " + m_ProjectId.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=Priority_OnChange()"
                Response.Write(CommonFunction.HTMLControls.DrawComboBox("PriorityFixInDays", "Exec usp_Sel_tbl_IB_Project_Priorities_FixInDays " + m_ProjectId.ToString, DisplayNone:=True))
                strOnloadClientScript = strOnloadClientScript & vbCrLf & "Priority_OnChange();" & vbCrLf

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

                'Integrated by SandipL SP8 to SP9
                'Integrated by PrashantD on 2 March 2007 for Product Execution Project
                ' Added By NitinVS on 26 May 06 for Roamware Customization

            Case "CUSTOMERID"

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "EXEC usp_Sel_tbl_PM_Customer_ProductExecution "
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "200"
                If m_LoginType = "C" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "style='visibility: hidden' OnChange=Customer_OnChange()"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = m_UserId.ToString
                Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=Customer_OnChange()"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False"
                End If

                If m_lngIssueId <> 0 And m_CustomerId <> "" And m_CustomerId <> "0" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) += " disabled "
                End If

                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    m_CustomerId = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)
                End If

            Case "PRODUCTVERSIONID"

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                If m_CustomerAtDeliverable = True And (m_CustomerId = "" Or m_CustomerId = "0") Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "IF (SELECT 1) = 0  SELECT '',''"
                Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + m_UserId.ToString + " , '" + m_LoginType + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null  " + CStr(IIf(m_CustomerId <> "" And m_CustomerId <> "0", " , " + m_CustomerId, " , Null ")) + " , " + CStr(IIf(m_ProjectId <> 0, m_ProjectId.ToString, " Null"))
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "200"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=ProductVersion_OnChange()"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False"

                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    m_ProductVersionID = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)
                End If

            Case "COMPONENTID"

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "EXEC USP_SEL_Tbl_PRD_ProductVersion_Component " + CStr(IIf(m_ProductVersionID.ToString <> "" And IsNothing(m_ProductVersionID) = False, m_ProductVersionID.ToString, " 0 ")) + " , " + CStr(IIf(m_CustomerId <> "", m_CustomerId, " Null ")) + " , " + CStr(IIf(m_ProjectId <> 0, m_ProjectId.ToString, " Null ")) + " , " + m_UserId.ToString + " , '" + m_LoginType + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 "))

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "200"

                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    m_ComponentId = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)
                End If

                ' End Addition By NitinVS on 26 May 06 for Roamware Customization
                'End of Integration by PrashantD on 2 March 2007

                'End Integration by SandipL SP8 to SP9
            Case "REPORTEDBY"

                'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strReviewer
                Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = m_UserName
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                ' arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + m_ProjectId.ToString + ", " + m_UserId.ToString + ", 1"
                'integrated by harshada d on 26092005 for WHIZ sP4 413  
                'Added by PrajaktaR for Nucleus IssueID 18970
                If objGlobal.LoginType = "C" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + m_ProjectId.ToString + ", " + m_UserId.ToString + ", 1 , NULL, NULL , 'C','" & m_strMode & "'" & "," & m_lngIssueId
                ElseIf objGlobal.LoginType = "E" Then
                    'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
                    'Commneted and Modified by SavitaS on 20 July 2006 for Nucleus IssueID 22977
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + m_ProjectId.ToString + ", " + m_UserId.ToString + ", 1"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + m_ProjectId.ToString + ", " + m_UserId.ToString + ", 1, NULL, NULL , 'E','" & m_strMode & "'" & "," & m_lngIssueId
                    'End of Commneted and Modified by SavitaS on 20 July 2006 for Nucleus IssueID 22977
                    'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
                End If

                objGlobal = Nothing
                'Added by PrajaktaR for Nucleus IssueID 18970
                'end of integration by harshada d on 26092005 for WHIZ sP4 413  
                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    'Modified by SandipL for IssueID 2183
                    'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).tostring
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Session("strUserName")).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

                'Added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)
            Case "RELEASEID"
                m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

                If m_intFlag = "1" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "SELECT ReleaseID,ReleaseName FROM tbl_PM_ScrumRelease WITH(NOLOCK) WHERE ProjectID = " + m_ProjectId.ToString
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "usp_sel_tbl_PM_ScrumRelease_ReleaseID " + m_ProjectId.ToString
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=GetIterations(this)"

                End If

            Case "ITERATIONID"
                m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

                If m_intFlag = "1" Then
                    Dim strSQL As String
                    strSQL = "SELECT tbl_PM_ScrumIteration.IterationID,tbl_PM_ScrumIteration.IterationName FROM tbl_PM_ScrumIteration WITH(NOLOCK) "
                    strSQL += "inner join tbl_IB_Issue WITH(NOLOCK) ON tbl_PM_ScrumIteration.IterationID = tbl_IB_Issue.IterationID WHERE IssueID = " + CType(m_lngIssueId, String)
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = strSQL
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=GetUserStories(this)"
                    'If m_strAction.ToUpper = "COPYISSUE" Then
                    '    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    '    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    'End If
                End If

            Case "USERSTORYID"
                m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

                If m_intFlag = "1" Then
                    Dim strSQL As String
                    strSQL = "SELECT tbl_PM_ScrumUserStory.UserStoryID,tbl_PM_ScrumUserStory.UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) "
                    strSQL += "inner join tbl_IB_Issue WITH(NOLOCK) ON tbl_PM_ScrumUserStory.UserStoryID = tbl_IB_Issue.UserStoryID WHERE IssueID = " + CType(m_lngIssueId, String)

                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = strSQL

                    'If m_strAction.ToUpper = "COPYISSUE" Then
                    '    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    '    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    'End If
                End If
                'End of added by NitinC on 07 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 56320)

            Case "REPORTEDDATE"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strGetServerDate1     ' CommonFunction.Dates.GetDate(Now())

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    'Modified by Shraddham on 7th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                    'Purpose : To Display Server Date
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strGetServerDate1     ' CommonFunction.Dates.GetDate(Now())
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "REPORTEDINVERSION"

                ' Get the current version number of the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString + ", NULL, 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Versions").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Version " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then

                    'Modified By VidyaJ - IssueID - 3330 - Whiz6.0
                    '' Modified By ParagD On 15-Feb-2006
                    '' Purpose : DSS 875 - When we say copy issue having minutes in Reported Time as 01 ,
                    ''           it truncates 0 from the minutes and take 1 only. 
                    If Now.Minute.ToString.Length < 2 Then
                        'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":0" + Now.Minute.ToString
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                    End If
                    '' Modified By ParagD On 15-Feb-2006

                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Reported Time Feature
                'Date   :   1 July 2004
                'Requirement No.:IB_PBN_ENT_04
                'Addition   :   Added the case for Reported Time
            Case "REPORTEDTIME"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "50"
                'Modified by Shraddham on 7th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                'Purpose : To Display Server Time
                'If Now.Minute.ToString.Length < 2 Then
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strHour + ":" + strMinute
                'Else
                ' arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strHour.ToString + ":" + Now.Minute.ToString
                'End If
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "5"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "onkeypress=""Time_OnKeyPress(event)"""
                '************End Addition*************

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    'Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    'Modified by SandipL on 16 Feb 2006 -- IssueID 1306 -- WhizSeM_Whiz2 sp6
                    '   arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                    ' If Now.Minute.ToString.Length < 2 Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strHour + ":" + strMinute
                    'Else
                    ' arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = Now.Hour.ToString + ":" + Now.Minute.ToString
                    'End If
                    'End Modification by SandipL on 16 Feb 2006
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Root Cause Feature
                'Date   :   5 July 2004
                'Requirement No.:IB_PBN_ENT_06
                'Addition   :   Added the case for Root Cause
            Case "ROOTCAUSEID"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_RootCause " + m_ProjectId.ToString
                '************End Addition*************
                'added by VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'RootCauseID'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                'end of addition on 2 Apr 2005 for Copy functionality

            Case "SEVERITY"

                ' Get the default severity for the project.
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectId.ToString & ", 1"
                drDefaultValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Severity").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Severity " + m_ProjectId.ToString

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "SHOWTOCUSTOMER"
                ' If the customer has logged in, then the default value for the ShowToCustomer bit must be set to 1.
                If m_LoginType = "C" Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = "1"
                Else
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = "0"
                End If

                ' If the Issue was reported by the customer, the checkbox must be checked and disabled.
                If blnReportedByCustomer = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "1"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True"
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_CHECK_BOX.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = ""

                'added VivekP On 2 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality

            Case "STATUS"
                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   24 June 2004
                'Requirement No.:IB_PBN_ENT_01
                'Addition   :   Added Code To Check Whether Security is applied for given Role and Project.

                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim strSQLForRole As String
                Dim blnDefaultAccessible As Boolean
                Dim blnRecordsExist As Boolean

                'Get the Types accessible for 
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)
                blnDefaultAccessible = False
                blnRecordsExist = False

                '*******End Of Addition********




                ' Get the default sub-type for the current type.
                strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                drDefaultValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then

                    '**********Code Commented By DipaliS 25 June 2004**********
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Status").ToString.Trim

                    '**********Code Added*******
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   25 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition : If default status is not accessible , then set it to Blank.

                    'If any record found that means security is explicitly set for the Role for that project
                    While drTypeAccess.Read
                        blnRecordsExist = True
                        'If the default type is not present then set the flag for same.
                        If drDefaultValue("Status").ToString.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("Status")), String) _
                         And CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim = m_strCurrentType.ToLower.Trim Then
                            blnDefaultAccessible = True
                            Exit While
                        End If
                    End While

                    'If Secuirity is set and access is not there then set the default value to blank.
                    If blnDefaultAccessible = False And blnRecordsExist = True Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = ""
                    Else
                        'Else set it as usual
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("Status").ToString.Trim
                    End If

                    '**********End Addition By DipaliS**********
                End If

                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                '**********Code Added By DipaliS 25 June 2004
                CommonFunction.Data.DisposeDataReader(drTypeAccess)
                '**********End Addition By DipaliS**********


                If m_lngIssueId <> 0 Then
                    'If Not drIssueDetails.EOF Then
                    If m_strCurrentType = drIssueDetails("Type").ToString.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drIssueDetails("Status").ToString
                    End If
                    'End If

                    '**********Code Added*******
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   25 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'If in edit mode the status is not accessible then disable the combo for status.
                    strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                    strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & drIssueDetails("ProjectID").ToString & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                    drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)
                    blnDefaultAccessible = False
                    blnRecordsExist = False

                    While drTypeAccess.Read
                        blnRecordsExist = True
                        'If the default type is not present or if the selected type is not current type then set the flag for same. 
                        If drIssueDetails("Status").ToString.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("Status")), String).ToLower.Trim _
                                And CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim = m_strCurrentType.ToLower.Trim Then
                            blnDefaultAccessible = True
                            Exit While
                        End If
                    End While

                    'If the status is not accessible , then disable the combo box
                    If blnDefaultAccessible = False And blnRecordsExist = True And m_strCurrentType.Trim <> "" And m_strCurrentType.ToLower.Trim = drIssueDetails("Type").ToString.ToLower.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True"
                    End If

                    CommonFunction.Data.DisposeDataReader(drTypeAccess)
                    '**********End Addition**********
                End If

                ' Whenever the default values are to be shown, set the current value to "". 
                ' This has to be done specifically for Status and sub-type, because these values must be set to the default everytime the type changes.
                If m_blnShowDefaults = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                If m_lngIssueId <> 0 Then
                    '**********Code commented By Dipalis 25 June 2004 and added the following line
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   25 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'Changed the SQL for Combo box.
                    If m_strCurrentType.ToLower.Trim = CType(CommonFunction.General.CheckIsNothing(drIssueDetails("Type")), String).ToLower.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'" + ",Null,Null," + _
                                                    m_RoleId.ToString + ",'" + CommonFunction.General.BuildQueryString(drIssueDetails("Status").ToString) + "'"
                    Else
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'" + ",Null,Null," + _
                                                                            m_RoleId.ToString
                    End If

                    '**********End Addition**********

                Else
                    '**********Code Commented By DipaliS 25 June 2004 and added the following line
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) & "'"
                    'By     :   DipaliS
                    'Reason :   Apply Role Level Security
                    'Date   :   25 June 2004
                    'Requirement No.:IB_PBN_ENT_01
                    'Addition   :   Added Code For the condition :
                    'Changed the SQL for Combo box.
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) & "'" + "," + m_RoleId.ToString
                    '**********End Addition**********
                End If

                'added VivekP On 2 Apr 2005 for Copy functionality 
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString

                    strSQL = "usp_sel_GetFieldValueForIssue " & m_lngCopyIssueId.ToString & ",'Type'"
                    Dim str1 As String = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " & m_ProjectId.ToString & ",'" & CommonFunction.General.BuildQueryString(str1) & "'"
                    drDefaultValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    If drDefaultValue.Read Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = drDefaultValue("Status").ToString.Trim
                    End If
                    CommonFunction.Data.DisposeDataReader(drDefaultValue)

                    strSQL = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
                    'Modified by PrashantD on 14 March 2007 for IssueID 11379
                    'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(str1) & "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + m_ProjectId.ToString + ", '" & CommonFunction.General.BuildQueryString(str1) & "'," + m_RoleId.ToString
                    'End of modification by PrashantD on 14 March 2007
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality
                'Added By PradipK on 20 March 2006 for SLA Management
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=Status_OnChange()"
                'End Addition By PradipK on 20 March 2006 for SLA Management

            Case "SUBTYPE"




                ' Get the default sub-type for the current type.
                strSQLQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S', " + m_ProjectId.ToString + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                drDefaultValue = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drDefaultValue.Read Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drDefaultValue("SubType").ToString.Trim
                End If
                CommonFunction.Data.DisposeDataReader(drDefaultValue)

                If m_lngIssueId <> 0 Then
                    'If Not drIssueDetails.EOF Then
                    If m_strCurrentType = drIssueDetails("Type").ToString.Trim Then
                        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = drIssueDetails("SubType").ToString.Trim
                    End If
                    'End If
                End If

                ' Whenever the default values are to be shown, set the current value to "". 
                ' This has to be done specifically for Status and sub-type, because these values must be set to the default everytime the type changes.				
                If m_blnShowDefaults = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'S', '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                'added VivekP On 2 Apr 2005 for Copy functionality 
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString

                    strSQL = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
                    '' 5-Oct-2006
                    Dim str2 As String = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                    '' arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'S', '" + CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).tostring + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'S', '" + CommonFunction.General.BuildQueryString(str2) + "'"
                End If
                ''end of addition On 2 Apr 2005 for Copy functionality
            Case "SUMMARY"
                '''Commented and Added by Dhanashri S on 26 Nov 2015
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "895"
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "512"

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "895"
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT) = "60"
                '''End of Comment and Addition by Dhanashri S on 26 Nov 2015

                'added by AniruddhaD on 16 Nov 2005 for common page for issue entry for issue and review (IssueID: 683)
                If blnCalledFromReview = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = strReviewAction
                End If
                'end of addition

            Case "TYPE"

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   24 June 2004
                'Requirement No:IB_PBN_ENT_01
                'Addition Made: Code added for the condition:
                'If current Role is not having access for default type, then show the default type as blank.

                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim drDefault As IDataReader
                Dim strSQLForRole As String
                Dim blnDefaultAccessible As Boolean
                Dim blnRecordsExist As Boolean

                'Get the Types accessible for 
                'strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                'strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                'drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)
                'Get the Types for current project
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_ProjectId & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                drDefault = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

                blnDefaultAccessible = False
                blnRecordsExist = False

                'If any record found that means security is explicitly set for the Role for that project
                'While drTypeAccess.Read
                '    blnRecordsExist = True
                '    'If the default type is not present then set the flag for the same.
                '    'If m_strCurrentType.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drTypeAccess("TypeName")), String).ToLower.Trim Then
                '    '    blnDefaultAccessible = True
                '    '    Exit While
                '    'End If
                'End While
                'Record exists then , secirity is set for project group
                While drDefault.Read
                    blnRecordsExist = True
                    If m_strCurrentType = "" Then
                        'Addition by SnehalV-18th Oct : Default Work Hours Incorrect Prompt issue
                        If m_strAction.ToUpper = "COPYISSUE" Then
                            Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
                            m_strCurrentType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                        End If
                        'End of addition by SnehalV 
                    End If
                    If m_strCurrentType.ToLower.Trim = CType(CommonFunctions.General.CheckIsNothing(drDefault("TypeName")), String).ToLower.Trim Then
                        blnDefaultAccessible = True
                        Exit While
                    End If
                End While

                'CommonFunctions.Data.DisposeDataReader(drTypeAccess)
                CommonFunctions.Data.DisposeDataReader(drDefault)

                If blnDefaultAccessible = False And blnRecordsExist = True Then
                    m_strCurrentType = ""
                End If

                '*******End Of Addition********

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = m_strCurrentType

                Dim drType As IDataReader
                strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " + m_ProjectId.ToString + ", 'T', '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'"
                drType = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drType.Read Then
                    dblDefaultWork = CType(CommonFunction.Data.CheckIsDBNull(drType("DefaultWork"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drType)

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString

                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO) = "OnChange=Type_OnChange()"

                '********Code Commented By DipaliS and added the following
                'arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'T'"

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   24 June 2004
                'Requirement No:IB_PBN_ENT_01
                arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + m_ProjectId.ToString + ", 'T'" + ",Null,Null,Null,Null,Null," + m_RoleId.ToString
                '*******End Addition**********

                If m_blnShowTimesheetDetails = True Then
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True"
                End If

                'added by VivekP On 3 Apr 2005 for Copy functionality
                If m_strAction.ToUpper = "COPYISSUE" Then
                    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'" + strFieldName + "'"
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                End If
                'End Of addition On 3 Apr 2005 for Copy functionality
            Case Else

        End Select

        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True" Then
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "1,"
        End If

        If Trim(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
            arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
        End If
    End Sub 'Get the control attributes

    Private Sub DrawControl(ByRef ArrCtlAttr() As String)
        '==================================================================================
        ' Procedure Name		:	DrawControl
        ' Parameters Passed		:	arrCtlAttr : This array contains the attributes of the control to be drawn.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets modified.
        ' Purpose				:	To actually draw the control as per the specifications in the array.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 10, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer

        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False

        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        If m_blnShowDefaults = True Then
            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)

            'Code Added By VidyaJ for IssueID - 15703
            'Set Default Value if default value is set for the control
            If strControlValue = "" Then
                If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) Is Nothing Then
                    strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
                    'Added By AmitJ For Cashtech IssueId 3324 : If Issue status contains special char like "'" e.g. 
                    'status = won't fix then page crashes in Add & Edit Mode
                    If strControlValue <> "" Then
                        strControlValue = Replace(strControlValue, "'", "''")
                    End If
                    'End Of Addition
                End If
            End If
            'End Of Addition
        Else
            strControlValue = ""
        End If

        'Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH)) <> "" Then
            intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH), Integer)
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
            intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH), Integer)
            'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If
        'Added By shraddhaM on 8,Mar 2007 for CashTech IssueID : 4637 IssueID - 11547
        'Purpose : Hide extra * on Page
        If strControlName.ToUpper() = "STATUSCHANGETIME" And ((m_LoginType = "C") Or (m_IsIssueSLAApplicable = False)) Then
            blnIsMandatory = False
        End If

        'End of Addition By shraddhaM on 8,Mar 2007 for CashTech IssueID : 4637 IssueID - 11547

        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.
                If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "DeliverableID" Then

                    Dim strDeliverableName As String
                    Dim drGetDeliverable As IDataReader
                    Dim strSQL As String


                    'end of addition on 2 Apr 2005 for Copy functionality

                    If strControlValue <> "" Then
                        'Added by MonikaI on 10th Oct 2006 IssueID : 6940
                        m_intDeliverableID = CType(strControlValue, Integer)
                        'End of addition by MonikaI
                        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                        'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strControlValue, String)
                        strSQL = "usp_sel_tbl_PM_OtherSchedules_Title_ScheduleID " + CType(strControlValue, String)
                        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                        If drGetDeliverable.Read Then
                            '' START : Modified BY ParagD On 5-Sept-2006
                            '' Purpose : Whizible SP7 Issue : Select Deliverable when contain quotes within it.
                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                            '' END : Modified BY ParagD On 5-Sept-2006
                        End If

                        CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                    End If
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", True, strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    '' START : Modified BY ParagD On 5-Sept-2006
                    '' Purpose : Whizible SP7 Issue : Select Deliverable when contain quotes within it.

                    '' Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:150px'  maxlength=100 value='" & strDeliverableName + "' disabled  readonly style='BACKGROUND-COLOR='>")
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "clsTextBoxReadOnly", , 100, strDeliverableName, "Left", , True, blnReadOnly, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    '' END : Modified BY ParagD On 5-Sept-2006

                    Response.Write("&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>")

                Else
                    ''Added By Vidya J ON 16 Aug 2016  
                    If ((strControlName = "StatusChangeTime") And (m_LoginType = "C")) Or ((strControlName = "StatusChangeTime") And (m_IsIssueSLAApplicable = False)) Then
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, , DisplayNone:=True, EnableHTMLEncode:=True))
                        ''Added By Vidya J ON 16 Aug 2016  
                    Else

                        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:06/10/15
                    End If
                End If


            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY)
                Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , blnIsMandatory))

                'Assign Issue button
                If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "AssignTo" And m_lngIssueId <> 0 And ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                    'Added following condition by PrashantD on 16 March 2007 for IssueID 11594
                    'Purpose:When user has edit access then only show Assign Task link
                    If m_blnEditAccess = True And m_lngIssueId > 0 Then
                        Response.Write("&nbsp;<a Href='javascript:AssignIssue_OnClick()'><image BORDER=0 src='..\..\images\dblclick.gif' alt='Click here to assign the issue...'></a>")
                    End If

                End If

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.
                'Modified By VarunA on 12-June-2008 RequestID-13081
                'Purpose : To have show popup when it is diasble also, while clicking on magnifier
                'Modified by Shraddham on 8th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                'Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIBIssueEntry", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, wrap:="Soft"))
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIBIssueEntry", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , blnReadOnly, blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft"))
                Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIBIssueEntry", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , blnReadOnly, blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft", EnableHTMLEncode:=True))
                'End By VarunA on 12-June-2008 RequestID-13081
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_CHECK_BOX.ToString  ' Draw the check box.

                If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "True" Or Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "1" Then
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "1"
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "0"
                End If
                strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)

                'If m_strAction.ToUpper = "TYPECHANGE" Then strControlValue = "1"

                'Added by SavitaS on 26 Sept for SP7 IssueID 4887
                If (m_LoginType = "C") And strControlName.ToUpper = "SHOWTOCUSTOMER" Then
                    'If logged in user is Customer then draw hidden control
                    Response.Write(CommonFunction.HTMLControls.DrawCheckBox(strControlName, strControlName, , CType(strControlValue, Boolean), , , strToBeInserted, , blnIsMandatory, , True, True))
                Else
                    Response.Write(CommonFunction.HTMLControls.DrawCheckBox(strControlName, strControlName, , CType(strControlValue, Boolean), , , strToBeInserted, , blnIsMandatory, , True))
                End If
                'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" Then

                    'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
                    'Purpose:When logintype is customer or Project level issue SLA is not applicable then do not display status change date field
                    If ((strControlName = "StatusChangeDate") And (m_LoginType = "C")) Or ((strControlName = "StatusChangeDate") And (m_IsIssueSLAApplicable = False)) Then
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmIBIssueEntry", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted, True))
                    Else
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmIBIssueEntry", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    End If
                Else
                    If ((strControlName = "StatusChangeDate") And (m_LoginType = "C")) Or ((strControlName = "StatusChangeDate") And (m_IsIssueSLAApplicable = False)) Then
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmIBIssueEntry", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted, True))
                    Else
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmIBIssueEntry", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    End If
                End If
                'End Modification
            Case Else
                Response.Write("&nbsp;")

        End Select
        ''Commented and added by nilesh g on 9/10/2015 for change size of array
        '' Dim arrtemp(30) As String
        Dim arrtemp(50) As String
        ''end of Commented and added by nilesh g on 9/10/2015 for change size of array
        arrValidationMessages.CopyTo(arrtemp, 0)

        'Generate the client side validation scripts for the control.		
        Call GenerateValidationScript(ArrCtlAttr, arrtemp)
        'Response.Write(ArrCtlAttr(ATTR_CONTROL_NAME) + ArrCtlAttr(ATTR_READ_ONLY))

        ' If the control is disabled, then enable it before submitting.
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" Then
            If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME).ToString.Trim, "Keywords") <> 0 Then
                strEnableControlsScript = "var obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "= GetObjectReference('frmIBIssueEntry','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "',1);" + vbCrLf
                For intCtr = 0 To 4
                    'Modified by SantoshK on Date June 7, 2006 for WhizibleSEM Issue ID.4168
                    'Purpose : Firefox Support, Changed () to []
                    strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "[" + intCtr.ToString + "].disabled = false;" + vbCrLf
                    'Modification Ends by SantoshK on June 7, 2006
                Next
            Else
                strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ".disabled = false;" + vbCrLf
            End If
        End If

    End Sub 'Draw the control 

    Private Sub GetReviewDetails()
        '==================================================================================
        ' Procedure Name		:	GetReviewDetails
        ' Parameters Passed		:	none
        ' Returns				:	No return Value.
        ' Parameters Affected	:	none
        ' Purpose				:	To get review details and default values for controls if page is called 
        '                           from(review)
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Nov 16, 2005
        ' Revisions				:	
        '==================================================================================	

        'Review statistics ID
        If Not Request.QueryString("ReviewStatisticsID") Is Nothing Then
            If Request.QueryString("ReviewStatisticsID") <> "" Then
                intReviewStatisticsID = CType(Request.QueryString("ReviewStatisticsID"), Integer)
            End If
        End If

        'Review Action ID
        If Not Request.QueryString("ReviewActionID") Is Nothing Then
            If Request.QueryString("ReviewActionID") <> "" Then
                intReviewActionID = CType(Request.QueryString("ReviewActionID"), Integer)
            End If
        End If

        Dim drReview As IDataReader

        drReview = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewStatistics " + intReviewStatisticsID.ToString, MyBase.UseSQL)
        If drReview.Read Then
            strProjectPhase = CommonFunction.Data.CheckIsDBNull(drReview("ProjectPhase"), "").ToString
            strReviewer = CommonFunction.Data.CheckIsDBNull(drReview("ReviewedBy"), "").ToString
            strReviewee = CommonFunction.Data.CheckIsDBNull(drReview("Reviewee"), "").ToString
            intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(drReview("EmployeeID"), "0"), Integer)
            strReviewDate = CommonFunction.Data.CheckIsDBNull(drReview("ReviewedDate"), "").ToString
            strReviewType = CommonFunction.Data.CheckIsDBNull(drReview("ReviewType"), "").ToString
            m_intModuleID = CType(CommonFunction.Data.CheckIsDBNull(drReview("ModuleID"), "0"), Integer)
            intDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(drReview("DeliverableID"), "0"), Integer)

            'Added by MrugajaB on 2nd Feb 2006 for Multiple Reviewees feature
            'Purpose:If review is FTR then 'FTR' value will be returned else boolean value will be returned
            strIssueIDs = CommonFunction.Data.CheckIsDBNull(drReview("IssueIDs"), "").ToString
            'End Addition
        End If
        CommonFunction.Data.DisposeDataReader(drReview)

        'Module name
        If m_intModuleID <> 0 Then
            Dim drModule As IDataReader
            drModule = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_Module NULL, " + m_intModuleID.ToString, MyBase.UseSQL)
            If drModule.Read Then
                strModuleName = CommonFunction.Data.CheckIsDBNull(drModule("ModuleName"), "").ToString.Trim
            End If
            CommonFunction.Data.DisposeDataReader(drModule)
        End If

        'Review cause and review action
        If intReviewActionID <> 0 Then
            Dim drAction As IDataReader
            drAction = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewActions " + intReviewActionID.ToString, MyBase.UseSQL)
            If drAction.Read Then
                strCauseId = CommonFunction.Data.CheckIsDBNull(drAction("PReviewCauseID"), "").ToString
                strCause = CommonFunction.Data.CheckIsDBNull(drAction("PReviewCause"), "").ToString
                strReviewAction = CommonFunction.Data.CheckIsDBNull(drAction("Action"), "").ToString
                'strSeverity = CommonFunction.Data.CheckIsDBNull(drAction("severity"), "").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drAction)
        End If

    End Sub

#End Region 'All private procedures used in code

#Region " Private Functions "

    Function PopulateComboForIssueID(ByVal strcboName As String, ByVal intComboWidth As Integer, ByVal strToBeInserted As String) As String
        '==================================================================================
        ' Procedure Name		:	PopulateCombo
        '
        ' Parameters Passed		:	Following are the List of Parameters passed
        '							and the explanation of each argument
        '
        '							1) strcboName		-	The Name of the combo which
        '													will be populated
        '							2) intComboWidth	-	The width of the combo box to be 
        '													populated in pixels

        ' Returns				:	HTML for combo

        ' Parameters Affected	:	
        ' Purpose				:	To COmboBox on Issue Entry Page

        ' Description			:	
        ' Assumptions			:	The SQL Query passed contains two Fields/Columns
        '							viz. 1st Column - ID representing the item value of the combo
        '								 2nd Column - Field which is displayed in the 
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	May 13, 2004
        ' Revisions				:	May 13, 2004
        '==================================================================================

        Dim strOutput, strFieldValue As String
        Dim rsList As IDataReader
        Dim blnExists As Boolean = False
        Dim i As Integer, Low As Integer, High As Integer

        Dim IssueIDs() As String = Split(Session("IssueIdsOnPage").ToString, ",")

        'Added by aniruddhad on 19 may 2004 for issuecode
        Dim IssueCodes() As String = Split(Session("IssueCodesOnPage").ToString, ",")
        'end of addition

        Dim Currentindex As Integer = IssueIDs.IndexOf(IssueIDs, m_lngIssueId.ToString)

        'Set Lower bound [Minimum value between (Currentindex - RANGE) and lbound of array]
        If Currentindex - RANGE < LBound(IssueIDs) Then
            Low = 0
        Else
            Low = Currentindex - CType(RANGE, Integer)
        End If

        'Set Upper Bound [Max value between (Currentindex + RANGE) and Ubound of array]
        If Currentindex + RANGE < UBound(IssueIDs) Then
            High = Currentindex + CType(RANGE, Integer)
        Else
            High = UBound(IssueIDs)
        End If


        strOutput = "<SELECT " + strToBeInserted + " id=" + strcboName + " name=" + strcboName
        'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
        'Purpose : Firefox Support
        'strOutput = strOutput + " class=clsComboBox style='height=70px; "
        strOutput = strOutput + " class=clsComboBox style='" 'style='height:70px;"
        'Modification Ends by SantoshK on June 6, 2006
        If intComboWidth <> 0 Then
            strOutput = strOutput + " width=" + intComboWidth.ToString + "px'><FONT size=1>"""
        Else
            strOutput += "'><FONT size=1>"""
        End If

        'Fill the Options (All elements in aray)
        For i = Low To High
            If IssueIDs(i) = Trim(m_lngIssueId.ToString) Then
                strOutput = strOutput & "<OPTION selected value =""" + IssueIDs(i).ToString + """>" + Trim(IssueIDs(i).ToString)
                'Added by AniruddhaD on 19 may 2004, for IssueCode
                If IssueCodes(i).Trim <> "" Then
                    strOutput = strOutput + "-->" + IssueCodes(i)
                End If
                strOutput += "</OPTION>"
                'End of addition
            Else
                strOutput = strOutput & "<OPTION value =""" + IssueIDs(i).ToString + """>" + Trim(IssueIDs(i).ToString)
                'Added by AniruddhaD on 19 may 2004, for issuecode
                If IssueCodes(i).Trim <> "" Then
                    strOutput = strOutput + "-->" + IssueCodes(i)
                End If
                strOutput += "</OPTION>"
                'end of addition
            End If
        Next

        strOutput = strOutput & "</FONT></SELECT>"
        Return strOutput

    End Function


    Private Function GetDiscussionCount(ByVal IssueId As Long) As Integer
        '=====================================================================
        ' Function Name         : GetDiscussionCount()	
        ' Purpose               : To get count of discussion threads - to show in menu
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             : By    PadmnabhA
        '                         On    05-05-2005
        '                           Added m_LoginType Parameter to udf_DiscussionThreadsForIssue functioncall
        '=====================================================================
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'm_intDiscussionThread_Count = CType(CommonFunction.Data.GetDataScalar("select dbo.udf_DiscussionThreadsForIssue(" + IssueId.ToString + ", '" + m_LoginType + "' )", MyBase.UseSQL), Integer)
        m_intDiscussionThread_Count = CType(CommonFunction.Data.GetDataScalar("usp_sel_udf_DiscussionThreadsForIssue " + IssueId.ToString + ", '" + m_LoginType + "'", MyBase.UseSQL), Integer)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        Return m_intDiscussionThread_Count

    End Function 'Count of discussion threads for Issue

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the Issue entry page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips


        If m_lngIssueId <> 0 Then ' Following are menu links for Edit Mode only 

            'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
            'Modified by MrugajaB on 7th Feb 2006
            'Purpose:When page gets poped up from reviews and gets submitted when we open attachment, then to retain values on the page to the values when the page was initially called from reviews
            'Integrated by AmitJ on 16 Aug 2006 for whizible SP 7.2 IssueID 2369
            'Commented and Modified by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Add Attachment Link in Issue module for customer login)
            'If m_FromWhere.ToUpper <> "DB" And blnCalledFromReview = False And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Then
            'Integrated by SandipL SP8 to SP9
            'If m_FromWhere.ToUpper <> "DB" And blnCalledFromReview = False And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Or m_LoginType = "C" Then
            If m_FromWhere.ToUpper <> "DB" And m_FromWhere.ToUpper <> "HDB" And blnCalledFromReview = False And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Or m_LoginType = "C" Then
                'End Integration by SandipL SP8 to SP9
                'If m_FromWhere.ToUpper <> "DB" And blnCalledFromReview = False And CType(CommonFunction.General.CheckIsNothing(Session("IssueIdsOnPage"), ""), String) <> "" Then
                'End Modification by SavitaS for Flexcel IssueID 2369
                'End of Integrtaion By AmitJ
                'End Modification by MrugajaB 
                If m_blnAddAccess Then
                    'Integrated By ChaitraliH For 'Extend Custom Field' on 26 May 10
                    ''RK
                    ArrMenuCaptionsList.Add("| Extended Custom Fields")
                    ArrMenuToolTipsList.Add("Extended Custom Fields")
                    ArrClientSideFunctionsList.Add("AddExtCustFields_OnClick()")
                    ''End RK
                    'End:Integrated By ChaitraliH For 'Extend Custom Field' on 26 May 10

                    'Add New
                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_ADDNEW"))
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"))
                    ArrClientSideFunctionsList.Add("AddNew_OnClick()")

                    'Add Attachment
                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_ADD_ATTACHMENT"))
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"))
                    ArrClientSideFunctionsList.Add("AddAttachment_OnClick()")

                    'Added By GaneshG on 08 Nov 06 -- Flag setting for Issue
                    'Flag Issue
                    ''Added by swapnil aswale on 28/12/2015 
                    If m_strMode.ToUpper <> "NEW" Then
                        If m_strAction.ToUpper <> "SAVE" Then
                            If m_LoginType <> "C" Then
                                ArrMenuCaptionsList.Add("| " + "Flag To Follow Up")
                                ArrMenuToolTipsList.Add("Flag To Follow Up")
                                ArrClientSideFunctionsList.Add("Flag_OnClick()")
                            End If
                        End If
                    End If
                    ''Ended

                    'If m_LoginType <> "C" Then
                    '    ArrMenuCaptionsList.Add("| " + "Flag To Follow Up")
                    '    ArrMenuToolTipsList.Add("Flag To Follow Up")
                    '    ArrClientSideFunctionsList.Add("Flag_OnClick()")
                    'End If
                    'End Addition By GaneshG 

                    '''Added By ManishK on 10th Jan to add link for AddDeliverable on Issue page
                    Dim drLayout As IDataReader

                    Dim strSQLQuery As String = "Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + m_intLayoutID.ToString
                    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                    'While drLayout.Read
                    'If drLayout("TableFieldName").ToString.ToUpper = "DELIVERABLEID" And drLayout("Active").ToString.ToUpper = "TRUE" Then
                    'Add Deliverable
                    '  ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADDDELIVERABLE"))
                    ' ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"))
                    ' ArrClientSideFunctionsList.Add("AddDeliverable_OnClick()")
                    'End If
                    ' End While
                    'Modified By Harshada on 18 Aug 2006
                    While drLayout.Read
                        If drLayout("TableFieldName").ToString.ToUpper = "DELIVERABLEID" And drLayout("Active").ToString.ToUpper = "TRUE" Then
                            'Add Deliverable
                            If m_LoginType <> "C" Then
                                'Added by PrashantD on 13 March 2007 for IssueID 11165
                                If CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Check_DeliverableNode_Access 2133," + Session("intPostID").ToString + "," + m_ProjectId.ToString + "," + Session("intUserID").ToString, MyBase.UseSQL), "False")) = True Then

                                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_ADDDELIVERABLE"))
                                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"))
                                    ArrClientSideFunctionsList.Add("AddDeliverable_OnClick()")
                                End If
                                'End of addition by PrashantD on 13 March 2007
                            End If
                        End If
                    End While

                    CommonFunction.Data.DisposeDataReader(drLayout)
                    '''End of Added By ManishK on 10th Jan to add link for AddDeliverable on Issue page

                End If

                If m_blnDeleteAccess Then
                    Dim drAttachments As IDataReader
                    drAttachments = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Attachments " + m_lngIssueId.ToString, MyBase.UseSQL)
                    If drAttachments.Read Then
                        'Delete Attachment
                        ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"))
                        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"))
                        ArrClientSideFunctionsList.Add("DeleteAttachment_OnClick()")
                    End If
                    CommonFunction.Data.DisposeDataReader(drAttachments)
                End If
            End If

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

            'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
            If m_blnShowIssueAssignmentLink = True And blnCalledFromReview = False Then
                'Added following condition by PrashantD on 16 March 2007 for IssueID 11594
                'Purpose:When user has edit access then only show Assign Task link
                If m_blnEditAccess = True And m_lngIssueId > 0 Then
                    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63  
                    Dim strModuleName As String = GetModuleName(10)

                    ''Assign Issue
                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("ASSIGN") + " " + GetModuleName(10))
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("ASSIGN_TOOLTIP") + " " + GetModuleName(10))
                    ArrClientSideFunctionsList.Add("AssignIssue_OnClick()")
                End If
            End If

            ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            'Show History
            'Integrated by SandipL SP8 to SP9
            'If m_FromWhere <> "DB" Then
            If m_FromWhere <> "DB" And m_FromWhere <> "HDB" Then
                'End Integration by SandipL SP8 to SP9
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_IB_SHOWHISTORY"))
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP"))
                ArrClientSideFunctionsList.Add("ShowHistory_OnClick()")
            End If

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

            'Show TimeSheet Details
            'integrated by harshada d for whiziblesem sp7 on 18 /july 2006
            ''INTEGRATED BY GANESHG ON 13 JULY 2006 -- CODE CHANGES BY SavitaS
            'Modified by SavitaS for Nucleus IssueID 23029(In issue module "Show Timesheet details " tab is visible to the customer)
            If m_LoginType <> "C" Then
                'End of Modified by SavitaS for Nucleus IssueID 23029(In issue module "Show Timesheet details " tab is visible to the customer)
                'end of integration by harshada d 
                'Integrated by SandipL SP8 to SP9
                'If m_blnShowTimesheetDetails = True And m_FromWhere <> "DB" Then
                If m_blnShowTimesheetDetails = True And m_FromWhere <> "DB" And m_FromWhere <> "HDB" Then
                    'End Integration by SandipL SP8 to SP9
                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_SHOWTIMESHEETDETAILS"))
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWTIMESHEETDETAILS_TOOLTIP"))
                    ArrClientSideFunctionsList.Add("ShowTimeSheet_OnClick()")
                End If
                'integrated by harshada d for whiziblesem sp7 on 18 /july 2006
                'Modified by SavitaS for Nucleus IssueID 23029(In issue module "Show Timesheet details " tab is visible to the customer)
            End If
            'End of Modified by SavitaS for Nucleus IssueID 23029(In issue module "Show Timesheet details " tab is visible to the customer)
            ''END INTEGRATION BY GANESHG 
            'end of integration by harshada d 
            'Import Issue to Current Project
            If m_blnIsProjectOver And m_blnShareIBWithinProjectGroup And m_ProjectId <> CType(Session("intProjectID"), Integer) And m_strAction.ToUpper <> "IMPORTISSUE" Then
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_IMPORTISSUE"))
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IMPORTISSUE_TOOLTIP"))
                ArrClientSideFunctionsList.Add("ImportIssue_OnClick()")
            End If

            'Discussion thread
            Call GetDiscussionCount(m_lngIssueId)
            If m_intDiscussionThread_Count > 0 Then
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_DISCUSSIONTHREAD") + "(" + m_intDiscussionThread_Count.ToString + ")")
            Else
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"))
            End If
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"))
            ArrClientSideFunctionsList.Add("DiscussionThread_OnClick()")
        End If

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'Save Issue
        'ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        'ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        'ArrClientSideFunctionsList.Add("Save_OnClick()")
        'Added by PrajaktaR on 13 June 2005 for Alliance IssueID 19345 
        'Added the If Condition for the Edit Access

        'Modified By VidyaJ - IssueID - 145
        If m_strMode = "Edit" Or (m_strMode = "New" And m_lngIssueId > 0) Or (m_strMode = "CopyIssue") Then
            If m_blnEditAccess = True Then
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_SAVE"))
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                ArrClientSideFunctionsList.Add("Save_OnClick()")
            End If
            If m_strMode = "CopyIssue" And m_lngIssueId = 0 And m_blnEditAccess = False Then
                If m_blnAddAccess = True Then
                    ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_SAVE"))
                    ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                    ArrClientSideFunctionsList.Add("Save_OnClick()")
                End If
            End If

        Else
            If m_lngIssueId = 0 Then
                ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_SAVE"))
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                ArrClientSideFunctionsList.Add("Save_OnClick()")
            End If
        End If
        'End of Addition by PrajaktaR on 13 June 2005 for Alliance IssueID 19345 


        'Back
        ' Modified By NitinVS on 10 May 2007 for WhizibleSEM 7.0 
        ' Not to show Back link when called from HDB
        'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
        If m_FromWhere.ToUpper <> "DB" And blnCalledFromReview = False And m_FromWhere <> "HDB" Then
            ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_BACK"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
            ArrClientSideFunctionsList.Add("Back_OnClick()")
        End If

        'Close
        'blnCalledFromReview condition added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through Issue and Review (IssueID: 683)
        'Integrated by SandipL SP8 to SP9
        'If m_FromWhere.ToUpper = "DB" Or blnCalledFromReview = True Then
        If m_FromWhere.ToUpper = "DB" Or m_FromWhere.ToUpper = "HDB" Or blnCalledFromReview = True Then
            'End Integration by SandipL SP8 to SP9
            ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_CLOSE"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            ArrClientSideFunctionsList.Add("Close_OnClick()")
        End If

        'Help 
        ArrMenuCaptionsList.Add("| " + MyBase.GetResourceString("MENU_HELP") + " |")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_ISSUE_DETAILS')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return
        'Code added and commented by PrashantD on 13 July 2007
        'Purpose: Obtaining events of Menu to hide Save link on click

        'Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        objMenu = New WebPage.Templates.StaticMenu
        Return objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        objMenu = Nothing
        'End of addition by PrashantD on 13 July 2007

    End Function 'Menu generation

    Private Function GetPageNumber() As Integer
        '=====================================================================
        ' Procedure Name        : GetPageNumber()	
        ' Purpose               : Get currently selected page number, from Issue List page
        ' Description           : Persist the page number, after going back to list page.
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'if pagenumber found in query string, assign that value
        If Not Request.QueryString("PageNumber") Is Nothing Then
            Return CType(Request.QueryString("PageNumber"), Integer)
        Else
            'set default value to 1
            Return 1
        End If

    End Function 'Get queryString parameter : Pagenumber

    Private Function GetIssueId() As Long
        '=====================================================================
        ' Procedure Name        : GetIssueId()	
        ' Purpose               : Get currently selected IssueId
        ' Description           : check if it is in project group 
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strScript As String, drIssueDetails As IDataReader

        'Check IssueId in forms collection
        If Not MyBase.GetFormValue("IssueID") Is Nothing Then
            'commented by AniruddhaD on 21 Nov 2005 for providing projects combo on issue list page(IssueID:685)
            'm_lngIssueId = CType(MyBase.GetFormValue("IssueID").Trim, Long)

            'added by AniruddhaD on 21 Nov 2005 for providing projects combo on issue list page(IssueID:685)
            If MyBase.GetFormValue("IssueID") <> "" Then
                m_lngIssueId = CType(MyBase.GetFormValue("IssueID").Trim, Long)
            Else
                If Not Request.QueryString("IssueID") Is Nothing Then
                    If Request.QueryString("IssueID") <> "" Then
                        m_lngIssueId = CType(Request.QueryString("IssueID"), Long)
                    Else
                        m_lngIssueId = 0
                    End If
                Else
                    m_lngIssueId = 0
                End If
            End If
            'end of addition

            ' If the issue has to be imported into the current project, then...		
            If m_lngIssueId <> 0 And Request.QueryString("Action") = "ImportIssue" Then
                strSQL = "Exec usp_Upd_tbl_IB_Issue_ImportIssueToProject " + m_lngIssueId.ToString + ", " + m_ProjectId.ToString
                Call CommonFunction.Data.InsertOrUpdateData(strSQL, m_UseSQL)
                ' Check in the QueryString collection.
            End If
        ElseIf Not Request.QueryString("IssueID") Is Nothing Then
            ' Get the IssueID that was passed in the QueryString.

            'added by VivekP On 2 Apr 2005 for copy functionality
            'don't set m_lngIssueId, if mode = CopyIssue
            If Not Request.QueryString("Action") Is Nothing Then
                If Request.QueryString("Action").ToUpper <> "COPYISSUE" Then
                    m_lngIssueId = CType(Request.QueryString("IssueID").Trim, Long)
                Else
                    m_lngIssueId = 0
                    m_lngCopyIssueId = CType(Request.QueryString("IssueID").Trim, Long)
                End If
            Else
                'added by AniruddhaD on 16 Nov 2005 for having common page issue entry through issue and review
                If Request.QueryString("IssueID") <> "" Then
                    m_lngIssueId = CType(Request.QueryString("IssueID").Trim, Long)
                Else
                    m_lngIssueId = 0
                End If
            End If

            'End of Addition by VivekP On 2 Apr 2005 for copy functionality
            'm_lngIssueId = CType(Request.QueryString("IssueID").Trim, Long)
            ' If the IssueID is not a proper numeric value, then...
            If Not IsNumeric(m_lngIssueId) Then
                ' Reset the IssueID to 0.
                m_lngIssueId = 0
            End If
            ' If the IssueID was specified by the user, then... 
            ' [On the Issue List screen a textbox is provided for the user to directly enter the Issue ID.]		
            If Request.QueryString("Goto") = "1" Then
                'Get sorting details
                Call GetSortingDetails()
                ' Check whether the IssueID passed is a valid IssueID, and the concerned person is authorized to view the Issue details.
                'Parameter added loginID by SandipL on 21 Feb 2006 -- IssueID whizsem_whiz2.0 sp6 2101
                'Parameter m_UserId added by AniruddhaD on 21 Nov 2005 for projects combo on issue list page (IssueID:685)
                strSQL = "Exec usp_Sel_tbl_IB_Issue_Project " + m_ProjectId.ToString + ", " + m_lngIssueId.ToString & ", '" + m_LoginType + "'," + m_UserId.ToString + "," + CType(Session("intLoginID"), String)
                drIssueDetails = CommonFunction.Data.GetDataReader(strSQL, m_UseSQL)
                'End Modification by SandipL on 21 Feb 2006
                ' If no record is found, then display the message, and redirect the person to the Issue List screen.
                If drIssueDetails.Read Then

                    'Added by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
                    Dim drTypeAccess As IDataReader
                    Dim blnIssueTypeAccessible As Boolean = False, blndrTypeAccessRead As Boolean = False
                    ' Modified by SandipL on 20 Feb 2006 --IssueID 2138
                    Dim intTempRoleID As Long

                    'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                    'intTempRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(drIssueDetails("ProjectID"), String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    intTempRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(drIssueDetails("ProjectID"), String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

                    If Not intTempRoleID > 0 Then
                        intTempRoleID = CType(Session("intPostID"), Long)
                    End If
                    'If type of issue is accessible to user
                    'MOdified by SandipL on 18 Feb 2006 -- Get types according to ShareIBwithinProjectGroup in Corporate settingg
                    'strSQL = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                    'strSQL = strSQL + "Exec usp_sel_tbl_ib_typerolesecurity_project " & drIssueDetails("ProjectID").ToString & "," & m_RoleId & ",0,@strTypeList OUTPUT" & vbCrLf
                    strSQL = "Exec usp_sel_tbl_ib_typerolesecurity_GetRecordSet " & drIssueDetails("ProjectID").ToString & "," & intTempRoleID
                    'End Modification by SandipL on 20 Feb 2006
                    drTypeAccess = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    Do While drTypeAccess.Read
                        blndrTypeAccessRead = True
                        'Trim function added MrugajaB on 17th Nov 2006 for Whiziblesem SP8
                        If Trim(drIssueDetails("Type").ToString) = Trim(drTypeAccess("TypeName").ToString) Then
                            'End Modification
                            blnIssueTypeAccessible = True
                            Exit Do
                        End If
                    Loop
                    CommonFunction.Data.DisposeDataReader(drTypeAccess)

                    If blndrTypeAccessRead = False Then
                        strScript = "<script LANGUAGE=javascript>" + vbCrLf
                        strScript += " alert('Issue does not belong to your accessible list');" + vbCrLf  '"alert(""This issue belongs to project: " + drIssueDetails("ProjectName").ToString + "\nYou do not have access for any of issue types defined for this project.\nPlease contact your WSEM Administrator to view this issue."");" + vbCrLf
                        If m_strSortField <> "" Then
                            strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&OrderBy=" & m_strSortField & "&ASCDESC=" & m_strSortOrder & "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                        Else
                            strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                        End If

                        strScript += "</script>"
                        Response.Write(strScript)
                    Else
                        If blnIssueTypeAccessible = False Then
                            strScript = "<script LANGUAGE=javascript>" + vbCrLf
                            'Modified by SandipL on 18 Feb 2006 -- IssueID 2139
                            'If CType(drIssueDetails("ProjectID"), Long) <> CType(Session("IssueProject"), Long) Then
                            '    strScript += "alert('This issue belongs to project: " + drIssueDetails("ProjectName").ToString + "\nYou do not have access for type of this issue (" + drTypeAccess("TypeName").ToString + "). Please contact your WSEM Administrator to view this issue.);" + vbCrLf
                            'Else
                            '    strScript += "alert('You do not have access for type of this issue (" + drTypeAccess("TypeName").ToString + "). Please contact your WSEM Administrator to view this issue.);" + vbCrLf
                            'End If
                            If CType(drIssueDetails("ProjectID"), Long) <> CType(Session("IssueProject"), Long) Then
                                strScript += " alert('Issue does not belong to your accessible list');" + vbCrLf  '"alert(""This issue belongs to project: " + drIssueDetails("ProjectName").ToString + "\nYou do not have access for type of this issue (" + drIssueDetails("Type").ToString + "). Please contact your WSEM Administrator to view this issue."");" + vbCrLf
                            Else
                                strScript += " alert('Issue does not belong to your accessible list');  " + vbCrLf  '"alert(""You do not have access for type of this issue (" + drIssueDetails("Type").ToString + "). Please contact your WSEM Administrator to view this issue."");" + vbCrLf
                            End If
                            'End mOdification by SandipL on 18 Feb 2006
                            If m_strSortField <> "" Then
                                strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&OrderBy=" & m_strSortField & "&ASCDESC=" & m_strSortOrder & "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                            Else
                                strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                            End If

                            strScript += "</script>"
                            Response.Write(strScript)
                        Else
                            If CType(drIssueDetails("ProjectID"), Long) <> CType(Session("IssueProject"), Long) Then
                                'Added by SavitaS on 22 Sept 2006 for whiziblesem Security IssueID 6197
                                m_PKTokenIssueID = CommonFunctions.Security.Token.GetToken(CType(drIssueDetails("IssueID").ToString, String) + CType(Session("intUserID"), String) + "0" + "0")
                                'End of Added by SavitaS on 22 Sept 2006 for whiziblesem Security IssueID 6197
                                strScript = "<script LANGUAGE=javascript>" + vbCrLf
                                strScript += "if (confirm(""This issue does not belong to currently selected project. \nThis issue belongs to Project : " + drIssueDetails("ProjectName").ToString + "\nWould you like to select this project?""))" + vbCrLf
                                strScript += "{" + vbNewLine
                                strScript += "objfrmIBIssueEntry = GetFormReference('frmIBIssueEntry');" + vbNewLine
                                'Modified by SavitaS on 22 Sept 2006 for whiziblesem Security IssueID 6197
                                'strScript += "objfrmIBIssueEntry.action = 'IB_IssueEntry.aspx?IssueID=" + drIssueDetails("IssueID").ToString + "&ProjectId=" + drIssueDetails("ProjectID").ToString + "';" + vbNewLine
                                strScript += "objfrmIBIssueEntry.action = 'IB_IssueEntry.aspx?IssueID=" + drIssueDetails("IssueID").ToString + "&PKToken=" + m_PKTokenIssueID + "&ProjectId=" + drIssueDetails("ProjectID").ToString + "';" + vbNewLine
                                'End of Modified by SavitaS on 22 Sept 2006 for whiziblesem Security IssueID 6197
                                strScript += "objfrmIBIssueEntry.submit();" + vbNewLine
                                strScript += "}"
                                strScript += "else" + vbNewLine
                                'strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "';" + vbNewLine
                                If m_strSortField <> "" Then
                                    strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&OrderBy=" & m_strSortField & "&ASCDESC=" & m_strSortOrder & "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                                Else
                                    strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                                End If
                                strScript += "</script>"
                                Response.Write(strScript)
                            End If
                        End If
                    End If
                    'end of addition
                Else
                    'Initialize standard menu resource file 
                    MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

                    m_lngIssueId = 0
                    strScript = "<script LANGUAGE=javascript>" + vbCrLf
                    strScript += "alert('This issue does not belong to any of the projects accessible to you!');" + vbCrLf
                    ' strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "';"
                    If m_strSortField <> "" Then
                        strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&OrderBy=" & m_strSortField & "&ASCDESC=" & m_strSortOrder & "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                    Else
                        strScript += "window.location.href = 'IBIssueList.aspx?PageNumber=" + m_intPageNumber.ToString + "&cboQuery=" & CType(Session("intQueryID"), String) & "&FromIssueEntry=1';" + vbNewLine
                    End If
                    strScript += "</script>"
                    Response.Write(strScript)
                    Return (-1)
                End If
                CommonFunction.Data.DisposeDataReader(drIssueDetails)
            End If
        Else
            m_lngIssueId = 0
        End If
        Return m_lngIssueId
    End Function 'Get Issue Id 

    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserFriendlyName()	
        ' Purpose               : To get user friendly field name for given field
        ' Description           : same as above
        ' Parameters Passed     : strFieldName - Actual Field name
        ' Returns               : user friendly field name (string)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        Dim strSQL As String

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_CultureId Then
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'"
        Else
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary_Culture '" + Trim(strFieldName) + "'," + m_CultureId.ToString
        End If

        Dim drUserFriendlyName As IDataReader

        drUserFriendlyName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drUserFriendlyName.Read Then
            'Return drUserFriendlyName("USerFriendlyName").ToString
            GetUserFriendlyName = drUserFriendlyName("USerFriendlyName").ToString
        Else
            'Return "Not Specified"
            GetUserFriendlyName = "Not Specified"
        End If
        CommonFunctions.Data.DisposeDataReader(drUserFriendlyName)

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
    End Function 'Get user friendly name for field

    Private Function GetDefaultQueryView(ByVal strUserOrderByClause As String) As String
        '=====================================================================
        'Procedure(Name)       :   GetDefaultQueryView()
        'Purpose				:	To return the query and view that needs to be applied.
        'Description			:	Same as above.
        'Parameters Passed		:	strUserOrderByClause :- The custom order by clause that needs to be applied.
        'Parameters Affected	:	None.
        'Returns				:	Builds the query and returns that query.
        'Assumptions			:	None.
        'Dependencies			:	None.
        'Author                :   AniruddhaD()
        'Created               : Feb 11, 2004
        'Revisions				:	
        '=====================================================================

        Dim drView As IDataReader     ' Recordset variable for View.				
        Dim drQuery As IDataReader     ' Recordset variable for Query.		
        Dim drCompanyInfo As IDataReader  ' Recordset variable to get the corporate view.				
        Dim drProjectList As IDataReader  ' Recordset variable to get the list of Projects accessible.
        Dim intViewID As Integer
        Dim intQueryID As Integer
        Dim strFieldList As String  ' Store the field list.
        Dim strSortBy As String   ' Store the sort by.					
        Dim strQuery As String   ' Store the query.		
        Dim strSQLQuery As String
        Dim strSQL As String
        Dim strTemp As String
        Dim intMaxItemsInIssueIDCombo As Integer ' Stores the maximum items that needs to be displayed in the Issue ID combo box.

        If Not Session("intViewID") Is Nothing Then
            If Session("intViewID").ToString <> "" Then
                intViewID = CType(Session("intViewID"), Integer)
            Else
                intViewID = 0
            End If
        Else
            intViewID = 0
        End If

        If Not Session("intQueryID") Is Nothing Then
            If Session("intQueryID").ToString <> "" Then
                intQueryID = CType(Session("intQueryID"), Integer)
            Else
                intQueryID = 0
            End If
        Else
            intQueryID = 0
        End If


        ' If View ID is specified, then retrieve details of the selected View.		
        If intViewID <> 0 Then
            ' Retrieve the details of the selected View.
            strSQLQuery = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," + intViewID.ToString
            drView = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drView.Read Then
                strFieldList = drView("Fields").ToString.Trim
                strSortBy = drView("SortBy").ToString.Trim
            End If
            CommonFunction.Data.DisposeDataReader(drView)
        Else
            ' If View ID is not specified, then retrieve details of the default View of the user in the selected project.

            ' Get the Default View details.
            strSQLQuery = "Exec usp_Sel_tbl_IB_DefaultView " + m_UserId.ToString + "," + m_ProjectId.ToString + ",'" + m_LoginType + "'"
            drView = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drView.Read Then
                intViewID = CType(drView("ProjectViewID"), Integer)
                strFieldList = drView("Fields").ToString.Trim
                strSortBy = CommonFunction.Data.CheckIsDBNull(drView("SortBy"), "").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drView)
        End If

        ' Get the corporate settings.
        strFieldList = CommonFunction.Application.IBDefaultView

        ' Append the sort by clause retrieved from the view to the custom order by clause supplied by the user.
        ' [Custom order by clause is generated when the user clicks the sorting images.]										
        If strUserOrderByClause.Trim <> "" Then
            strTemp = strUserOrderByClause.Trim
        End If

        'If strTemp <> "" Then
        If strSortBy = "" Then
            '    strTemp = strTemp + "," + strSortBy
            'Else
            strSortBy = "IssueID DESC"
        End If
        'Else
        'strTemp = strSortBy
        'End If
        strSortBy = strTemp

        ' If Query ID is specified, then retrieve details of the selected Query.		
        If intQueryID <> 0 Then

            ' Retrieve the details of the selected Query.
            strSQLQuery = "Exec usp_Sel_tbl_IB_Query " + intQueryID.ToString
            drQuery = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drQuery.Read Then
                strQuery = "(" + drQuery("QueryText").ToString.Trim + ")"
            End If
            CommonFunction.Data.DisposeDataReader(drQuery)

            ' If View ID is not specified, then retrieve details of the default View of the user in the selected project.
        Else
            If Not Session("UnsavedQuery") Is Nothing Then
                If Session("UnsavedQuery").ToString <> "" Then
                    strQuery = "(" + Session("UnsavedQuery").ToString + ")"
                Else
                    strQuery = ""
                End If
            Else
                ' Get the Default Query details.
                strSQLQuery = "Exec usp_Sel_tbl_IB_DefaultQuery " + m_UserId.ToString + "," + m_ProjectId.ToString + ",'" + m_LoginType + "'"
                drQuery = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drQuery.Read Then
                    intQueryID = CType(drQuery("QueryID"), Integer)
                    strQuery = "(" + drQuery("QueryText").ToString.Trim + ")"
                End If
                CommonFunction.Data.DisposeDataReader(drQuery)
            End If

        End If

        strSQLQuery = "SELECT IssueID"
        '"SELECT " + m_lngIssueId.ToString + "AS IssueID UNION added by AniruddhaD on 12 may 2004 for IssueID 11067 
        'strSQLQuery = "SELECT " + m_lngIssueId.ToString + " AS IssueID UNION SELECT IssueID"

        strSQLQuery += " FROM v_tbl_IB_Issue "

        'Attach the project id in where clause
        strSQLQuery += " WHERE  ( "

        strSQL = "DECLARE @strProjectList varchar(1000) " + vbCrLf
        strSQL = strSQL + " EXEC usp_Sel_tbl_IB_GetListOfSharedProjects " + m_ProjectId.ToString + ", @strProjectList OUTPUT" + vbCrLf
        strSQL = strSQL + " SELECT 'Projectlist' = @strProjectList "
        drProjectList = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drProjectList.Read Then
            strSQLQuery = strSQLQuery + " ProjectID IN ( " + drProjectList("Projectlist").ToString + ") "
        Else
            strSQLQuery = strSQLQuery + " ProjectID=" + m_ProjectId.ToString
        End If
        CommonFunction.Data.DisposeDataReader(drProjectList)

        'if loging type is customer then only show the selected bugs							
        If m_LoginType = "C" Then
            strSQLQuery = strSQLQuery + " AND ShowToCustomer=1 "
        End If

        'check for session filter
        If Not Session("Filters") Is Nothing Then
            If Session("Filters").ToString = "" Then
                If strQuery <> "" Then
                    strSQLQuery = strSQLQuery + " AND " + strQuery
                End If
            Else
                'apply filter on query
                If Not Session("intFilterOnQuery") Is Nothing Then
                    If Session("intFilterOnQuery").ToString = "1" Then
                        If strQuery <> "" Then
                            strSQLQuery = strSQLQuery + " AND " + strQuery + " And " + Session("Filters").ToString
                        Else
                            strSQLQuery = strSQLQuery + " AND " + Session("Filters").ToString
                        End If
                    Else 'if filter is not apply on query 
                        strSQLQuery = strSQLQuery + " AND " + Session("Filters").ToString
                    End If
                Else
                    strSQLQuery = strSQLQuery + " AND " + Session("Filters").ToString
                End If
            End If
        End If

        strSQLQuery = strSQLQuery + " ) "

        'Commented by aniruddhad on 13 may for IssueId - Combo Problem
        'If m_lngIssueId <> 0 Then
        '    If Session("IssueIdsOnPage").ToString <> "" Then
        '        Session("IssueIdsOnPage") = Session("IssueIdsOnPage").ToString + "," + m_lngIssueId.ToString
        '        strSQLQuery = strSQLQuery + " AND " + vbCrLf
        '        strSQLQuery = strSQLQuery + " IssueID in (" + Session("IssueIdsOnPage").ToString + ")" + vbCrLf
        '    End If
        'End If

        If m_lngIssueId <> 0 Then
            strSQLQuery = strSQLQuery & " OR " & vbCrLf
            strSQLQuery = strSQLQuery & " IssueID = " & m_lngIssueId.ToString & vbCrLf
        End If

        ' Set the order by clause.
        If strSortBy = "" Then
            strSQLQuery = strSQLQuery + " Order By IssueID Desc "
        Else
            strSQLQuery = strSQLQuery + " Order By  " + strSortBy
        End If

        GetDefaultQueryView = strSQLQuery

    End Function

    Private Function GetModuleName(ByVal intModuleID As Integer) As String

        '=====================================================================
        ' Procedure Name		:	GetModuleName
        ' Purpose				:	To get the current module name.
        ' Description			:	Same as above.
        ' Parameters Passed		:	intModuleID	
        ' Parameters Affected	:	None.
        ' Returns				:	The module name.
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	AniruddhaD
        ' Created				:	Feb 13, 2004
        ' Revisions				:	
        '=====================================================================
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        Dim drModule As IDataReader

        drModule = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_SystemModules " + intModuleID.ToString, MyBase.UseSQL)
        If drModule.Read Then
            'Return drModule("ModuleName").ToString.Trim
            GetModuleName = drModule("ModuleName").ToString.Trim
        Else
            'Return ""
            GetModuleName = ""
        End If
        CommonFunction.Data.DisposeDataReader(drModule)
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    End Function

    Private Function GetCorporateValue(ByVal strFieldName As String, ByVal strFieldValue As String) As String
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	strFieldName :- The field name.
        '							strFieldValue :- The field value.
        ' Returns				:	Returns the corporate mapped value.
        ' Parameters Affected	:	None
        ' Purpose				:	To get the corporate mapped value for the value passed.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 16, 2004
        ' Revisions				:	
        '==================================================================================	

        Dim strSQLQuery As String
        Dim drCorporateValue As IDataReader

        GetCorporateValue = ""

        ' Build the query to retrieve the corporate mapped value.
        strSQLQuery = "Exec usp_Sel_IB_GetCorporateValue '" & CommonFunction.General.BuildQueryString(strFieldName) + "', '" + CommonFunction.General.BuildQueryString(strFieldValue) + "', " + m_ProjectId.ToString
        If strFieldName = "SubType" Or strFieldName = "Status" Then
            strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(m_strCurrentType) & "'"
        End If

        ' Retrieve the corporate mapped value from the database, and return the value.
        drCorporateValue = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drCorporateValue.Read Then
            'Modified by SnehalV for SP7 BFT Issues Integration as on 3rd October 2006
            ' Added by GaneshD on 24 Sep 2009 to avoid DBNull page crash
            'GetCorporateValue = CommonFunction.General.BuildQueryString(CType(drCorporateValue("CorporateValue"), String))
            GetCorporateValue = CommonFunction.General.BuildQueryString(CommonFunction.Data.CheckIsDBNull(drCorporateValue("CorporateValue"), "").ToString)
            'End of modification by GaneshD
            'End of Modification
        End If
        CommonFunction.Data.DisposeDataReader(drCorporateValue)

    End Function

    Private Function IsValidField(ByVal rsFields As IDataReader, ByVal strFieldName As String) As Boolean
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	rsFields	 :- The recordset.
        '							strFieldName :- The field name.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	None
        ' Purpose				:	To check whether the field name specified, is a valid field in the recordset.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 16, 2004
        ' Revisions				:	
        '==================================================================================

        'Dim objRecordSetField

        'IsValidField = False

        '' For each field in the recordset, check if the field name matches with the field name that was passed.
        'For Each objRecordSetField In rsFields.Fields
        '    If objRecordSetField.Name = strFieldName Then
        '        IsValidField = True
        '        Exit For
        '    End If
        'Next
        Return True
    End Function

    Private Function PopulateComboForCopyIssueID(ByVal strcboName As String, ByVal intComboWidth As Integer, ByVal strToBeInserted As String, Optional ByVal blnIsHiddenControl As Boolean = False) As String
        '==================================================================================
        ' Procedure Name		:	PopulateCombo
        '
        ' Parameters Passed		:	Following are the List of Parameters passed
        '							and the explanation of each argument
        '
        '							1) strcboName		-	The Name of the combo which
        '													will be populated
        '							2) intComboWidth	-	The width of the combo box to be 
        '													populated in pixels

        ' Returns				:	HTML for combo

        ' Parameters Affected	:	
        ' Purpose				:	To COmboBox on Issue Entry Page

        ' Description			:	
        ' Assumptions			:	The SQL Query passed contains two Fields/Columns
        '							viz. 1st Column - ID representing the item value of the combo
        '								 2nd Column - Field which is displayed in the 
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	May 13, 2004
        ' Revisions				:	May 13, 2004
        '==================================================================================

        Dim strOutput, strFieldValue As String
        Dim rsList As IDataReader
        Dim blnExists As Boolean = False
        Dim i As Integer, Low As Integer, High As Integer


        If blnIsHiddenControl = False Then
            Dim IssueIDs() As String = Split(Session("IssueIdsOnPage").ToString, ",")
            'Dim Currentindex As Integer = Int((UBound(IssueIDs) - LBound(IssueIDs)) / 2)
            Dim Currentindex As Integer = IssueIDs.IndexOf(IssueIDs, m_lngIssueId.ToString)

            'Set Lower bound [Minimum value between (Currentindex - RANGE) and lbound of array]
            If Currentindex - RANGE < LBound(IssueIDs) Then
                Low = 0
            Else
                Low = Currentindex - CType(RANGE, Integer)
            End If

            'Set Upper Bound [Max value between (Currentindex + RANGE) and Ubound of array]
            If Currentindex + RANGE < UBound(IssueIDs) Then
                High = Currentindex + CType(RANGE, Integer)
            Else
                High = UBound(IssueIDs)
            End If


            strOutput = "<SELECT " + strToBeInserted + " id=" + strcboName + " name=" + strcboName
            'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support
            'strOutput = strOutput + " class=clsComboBox style='height=70px; "
            strOutput = strOutput + " class=clsComboBox style='" 'style='height:70px; "
            'Modification Ends by SantoshK on June 6, 2006
            If intComboWidth <> 0 Then
                strOutput = strOutput + " width=" + intComboWidth.ToString + "px'><FONT size=1>"""
            Else
                strOutput += "'><FONT size=1>"""
            End If

            strOutput += "<option value=''></option>"

            'Fill the Options (All elements in aray)
            For i = Low To High
                If IssueIDs(i) = Trim(m_lngCopyIssueId.ToString) Then
                    strOutput = strOutput & "<OPTION selected value =""" + IssueIDs(i).ToString + """>" + Trim(IssueIDs(i).ToString) + "</OPTION>"
                Else
                    strOutput = strOutput & "<OPTION value =""" + IssueIDs(i).ToString + """>" + Trim(IssueIDs(i).ToString) + "</OPTION>"
                End If
            Next

            strOutput = strOutput & "</FONT></SELECT>"

            'Modified by MrugajaB on 21st Dec 2005 for IssueID: 683
            'Purpose:To plot hidden control for copy issue while adding issue through review as copy issue functionality is not required while adding issue thru' reviews
        Else
            strOutput = "<INPUT Type=hidden id=" + strcboName + " name=" + strcboName + ">"
        End If
        'End Modification
        Return strOutput

    End Function

#End Region 'All Private Functions used in code

    Private Sub objAttachmentsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objAttachmentsGrid.ColumnHeaderTD_BeforePrint
        'Don't show delete column is no delete access 
        If Args.ColumnName.ToUpper = "DELETE" And Not m_blnDeleteAccess Then Cancel = True
    End Sub

    Private Sub objAttachmentsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objAttachmentsGrid.DataRowTD_BeforePrint
        'Don't show delete column is no delete access
        If Args.ColumnName.ToUpper = "DELETE" And Not m_blnDeleteAccess Then Cancel = True
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Public Sub ReadXML()
        If Request.QueryString("IsXMLHTTP") = "1" Then
            Response.Clear()
            Dim str As String = ""
            Dim strFromwhere As String = ""
            Dim m_IssueID As String = "0"
            Dim m_PKToken As String = ""
            Dim m_strTokenEntryPage As String = ""

            If Not Request.QueryString("IssueID") Is Nothing Then
                m_IssueID = CType(Request.QueryString("IssueID"), String)
            Else
                m_IssueID = ""
            End If

            If Not Request.QueryString("Fromwhere") Is Nothing Then
                strFromwhere = CType(Request.QueryString("Fromwhere"), String)
            Else
                strFromwhere = ""
            End If
            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_IssueID, String) + CType(Session("intUserID"), String) + "0" + "0")

            'Added by SavitaS on 22 Sept 2006 for Security Issue 6197
            'm_strTokenEntryPage = Session("OldToken").ToString

            'If (m_PKToken <> m_strTokenEntryPage) Then
            '    str = m_IssueID & "," & strFromwhere & "," & m_strTokenEntryPage
            'Else
            str = m_IssueID & "," & strFromwhere & "," & m_PKToken
            'End If
            'End of Added by SavitaS on 22 Sept 2006 for Security Issue 6197


            If m_IssueID <> "" Then
                Response.Write(str)
            Else
                Response.Write("0")
            End If
            Response.End()
        End If
    End Sub
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    'Integrated by SandipL SP8 to SP9
    'Added by SriaknthY on 21 Dec 2006 To Add code to Refresh parent Dashboard screen once the issue got saved
    Private Sub FreshParent()
        If m_FromWhere = "HDB" Then
            strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.opener.location.href = ""../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&PKToken=" + m_PKQueryToken + "&QueryID=" + m_Queryid + "&SortBy=" + m_QuerySortBy + "&SortOrder=" + m_QuerySortOrder + """"
            strOnloadClientScript = strOnloadClientScript + ";"
            m_Count = 1
        End If
        'Enf of Addition by SriaknthY
    End Sub
    'End Integration by SandipL SP8 to SP9

    Private Sub objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles objMenu.Initialize
        Args.LinkSeperator = ""
    End Sub

    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print
        If Args.FunctionName = "Save_OnClick()" Then
            'Modified By VarunA on 23-Sep-2008 IssueID-22512
            'Purpose : To have the name with the field as it is been used in FireFOX
            'Args.OtherProperties = "id='SAVEUP'"
            Args.OtherProperties = "id='SAVEUP' name='SAVEUP'"
            'End By VarunA on 23-Sep-2008 IssueID-22512
        Else
            Args.OtherProperties = ""
        End If

    End Sub
End Class
