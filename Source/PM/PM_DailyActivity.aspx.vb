'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	Chanakya Enhancements
' Module Name      :	PM_DailyActivity.aspx
' Purpose          :	To fill the details of Daily Activities.
' Description      :	To fill the details of Daily Activities.
' Assumptions      :	None.
' Dependencies     :	
' Author           :	PrasannaP
' Reviewed         :	
' Tested           :	
' Created          :	18th Feb 2004
' Revisions        :	26th August 2004. Modification by PrasannaP.
'                       Checkout the differences by using VSS diff.
'**********************************************************************************


Imports CommonFunctions
Imports System.Globalization

Public Class PM_DailyActivity
    Inherits WebPages.Template.WhizTemplate

#Region " Private Variable Declaration. "
    Private Const GENERAL_TASKS As String = "D"
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"
    Private Const INVALID_ENTRY As String = "-9999"
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_strParamMasterTagID As String
    Protected m_strParamDate As String
    Private m_strParamAction As String
    Private m_strParamTaskID As String
    Private m_strProjectID As String
    Private m_strParamTaskTypeID As String
    Private m_strParamIncludeCompletedTasks As String
    Protected m_strWindowTitle As String
    Private m_blnUseClientDateForDA As Boolean
    Private m_dblTotalDuration As Double
    Private m_blnShowWeeklyView As Boolean
    Private m_blnShowTaskTypeTimesheet As Boolean
    Protected m_blnTaskTypesApplicable As Boolean 'Check whether Task Types are applicable for the current project.

    'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
    'Purpose:Changed from Private to Protected
    Protected m_strSessionUserID As String        'For storing the User ID from Session
    'End Addition
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_strSessionClientDate As String    'For storing the Client Date from Session
    Private m_strTaskTypeID As String = ""
    'Private strSQL As String                    'Tos Store the SQL statements
    Private strSQL As New System.Text.StringBuilder       'Tos Store the SQL statements
    Protected m_strSubTaskTypeID As String = ""
    Private m_blnExceeded24Hours As Boolean
    Protected m_blnTaskComplete As Boolean
    Private m_strDescription As String
    Private m_strTREven As String = "clsTREven"
    Private m_strTaskTypeName As String
    Private m_objDTFI As New DateTimeFormatInfo       'Requires to parse the date.

    Private m_blnProjectEditable As Boolean
    Private m_blnTaskEditable As Boolean
    Private m_strTaskType As String
    Private m_strTaskInfo As String = ""
    Private m_strTaskArray() As String
    Private m_blnIsDurationChange As Boolean
    Private m_strStartDate As String = ""
    Private m_strEndDate As String = ""
    Private m_blnGetDeveloperDBDate As Boolean

    'Added on 15 May 2004
    Private blnDisplayETC As Boolean
    Protected EXPIRY_OF_TASK As String
    Protected EXPIRY_OF_TASK_FORWARD As String

    Private m_dblOvertime As Double
    Private m_dblTotalOvertimeHours As Double
    Private m_intOvertime As Double
    Protected m_dblTotalWorkHours As Double
    Private m_blnProjectFound As Boolean
    Private m_intFirstProject As Integer
    Private m_blnGlobalProject As Boolean
    Protected m_blnProjectBackdateEntry As Boolean
    Protected m_blnProjectFwddateEntry As Boolean
    Private m_blnProjectBackdateEntryList As Boolean
    Private m_blnProjectFwddateEntryList As Boolean
    Private m_blnTaskEditExpired As Boolean
    Private m_blnTaskEditExpiredForward As Boolean
    'End Addition

    'Variables required in the ManipulateRecords function
    '-----------------------------------------------------------------
    Private m_fltETC As String            'To store the ETC from the submitted page
    Private m_strDuration As String = ""
    Private m_dblPrevTotalHours As Double
    Private m_dblTotalHours As Double
    Private m_intTaskComplete As Integer
    Private m_strRefreshDetailsWindow As String
    '-----------------------------------------------------------------


    '##### Adding Variable For Resource Timesheet Flow
    'Added By AmitD on 28 JUL 2004
    Private m_blnTimesheetWorkFlow As Boolean
    Private m_blnAllowTaskProgress As Boolean
    'End Addition
    '##### End Addition

    '##### Adding Variable For Projects On Hold
    'Added By Priyanka on 9th Sep 2004
    Protected m_strProjectsOnHold As String
    Protected m_strProjectsOnHoldMsg As String
    Protected m_strFirstNotOnHoldProject As String
    'End Addition
    '##### End Addition
    '''<Summary>
    '' Added By: PrashantSJ
    '' date: 27th May 2008
    ''Purpose: DA blocked for particular project from project workflow.
    '''</Summary>

    Protected m_strProjectsDABlocked As String = ""
    Protected m_strProjectsDABlockedMsg As String = ""
    Protected arrTSBlockedProjects As String() = {"", ""}
    '''End of addition by PrashantSJ on 27th May 2008

    'Added By JayavantK  on 08-Oct-2004
    Private m_blnHideTaskTypeTimesheetMenuLink As Boolean = True
    Private m_blnHideTaskReportMenuLink As Boolean = True
    'End Addition

    'Added By Santosh Pawar on 21 Oct 2004 
    Protected m_blnResourceLevelTaskCompletion As Boolean
    'End of Addition 

    'Added by DipaliS 5 Nov 2004
    Private m_strProjectFilters As String = ""
    'End addition by DipaliS

    ' Added By NitinVS on 15 Apr 2005 for Customization 
    ' To Display Sub Task Types for CASE 1 and CASE 2 
    Protected m_blnHaveSubTaskTypes As Boolean
    ' End Addition By NitinVS on 15 Apr 2005 for Customization 

    'Modified By VidyaJ - For IssueID - 294 
    'Sub Task Type/Activity combo from DA page is displayed depending upon the configuration set
    Protected blnAllowActivityLevelDAEntry As Boolean
    'Start-AUJ-22Jan2007
    Dim m_strDAType As String = "N"
    Dim blnAcceptDATYpe As Boolean = False
    'End-AUJ-22Jan2007
#End Region

#Region " Public Variables Declaration. "
    'Public Variables
    Public m_blnIncludeCompletedTasks As Boolean
    Public m_strParamDailyActivityID As String
    Public m_strParamFromWhere As String
    Protected m_strParamMode As String
    'Protected m_strConstraintDate As String = ""
    'Protected m_strConstraintType As String = ""
    'Protected m_blnTimeBookedAgainstTask As Boolean
    Protected m_blnEnforceConstraints As Boolean
    Public m_strParamShowCloseLink As String
    Public m_blnStatus_AssignedTasks As Boolean
    Public m_blnTaskTypeMandatoryInDA As Boolean
    Public m_dblMinHoursForDAEntry As Double
    Public m_blnStatus_MPPTasks As Boolean
    Protected m_blnActualWorkHrs As Boolean = CommonFunction.Application.TimesheetEntryCombo 'This variable decide what to show on the form 
    'to fill the Actual Hours worked. i.e. ComboBox Or TextBox
    Private m_strStringToBeInserted As String = ""
    Private m_blnDAEntryEditable As Boolean

    'Added by MrugajaB on 19th Sept 2006 for Whiziblesem SP7 Issue ID.6197
    Protected m_strToken As String
    Protected m_strPkToken As String
    'End Addition

    ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
    Protected m_PKToken_TaskLinkClick As String
    Protected m_strFromWhere As String
    ''End of Addition by Dhanashri S on 28 Jan 2016
    ''Added by Vidya J on 28 Jan 2016 for PkToken Validation
    Protected m_AllProject_GeneralTaskLink As String
    Protected m_AllProject_AssignedTaskLink As String
    ''End of Addition by Vidya J on 28 Jan 2016 for PkToken Validation

    ''Added by Dhanashri S on 11 Aug 2016
    Protected m_blnValidate As Boolean = "True"
    Protected m_strEmployeeID As String
    Protected m_strShowClose As String
    Protected m_strFlagMove As String

    ''End of Addition by Dhanashri S on 11 Aug 2016

#End Region

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        'If Not HttpContext.Current.Session("intProjectID") Is Nothing Then
        ''End of Addition by Dhanashri S on 11 Aug 2016

        m_strPkToken = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Session("intUserID").ToString + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), String).ToString + "0" + "0")
        ''End If

    End Sub

#End Region
    'Addde By vivekP On 6 jun 2005
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As New WebPage.Templates.AccessRights
    Private m_blnProjectActive As Boolean = False
    Protected m_lngTagID As Long
    Protected GlobalProject As String
    Protected m_strBackdatingExpiry As String
    Protected m_strFwddatingExpiry As String
    'Added by SandipL on 20 April 2007 IssueID 12534
    'Private m_blnTaskaccessible As Boolean = True
    'End addition by SandipL

    'End Of addition On 6 Jun 2005 By VivekP

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''Added by swapnil A for session timeout expire on 18-1-2016
        'If Context.Session IsNot Nothing Then
        '    If Session.IsNewSession Then
        '        Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED")
        '    End If
        'End If
        ''Ended

        ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString

            'If m_strFromWhere.ToString = "ATS" Then
            '    ''m_PKToken_TaskLinkClick = Request.QueryString("ATS_PkToken").ToString
            '    m_PKToken_TaskLinkClick = Request.QueryString("PkToken").ToString
            'End If
        End If

        If Not Request.QueryString("PkToken") Is Nothing Then
            m_PKToken_TaskLinkClick = Request.QueryString("PkToken").ToString
        End If
        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_strProjectID = Request.QueryString("ProjectID").ToString
        End If
        If Not Request.QueryString("TaskID") Is Nothing Then
            m_strParamTaskID = Request.QueryString("TaskID").ToString
        End If
        If Not Request.QueryString("PkToken") Is Nothing Then
            m_AllProject_GeneralTaskLink = Request.QueryString("PkToken").ToString
        End If

        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_strEmployeeID = Request.QueryString("EmployeeID").ToString
        End If

        If Not Request.QueryString("ShowClose") Is Nothing Then
            m_strShowClose = Request.QueryString("ShowClose").ToString
        End If
        '' Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If Not Request.QueryString("FlagMove") Is Nothing Then
            m_strFlagMove = Request.QueryString("FlagMove").ToString
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        If (m_strFlagMove <> "PrevNext" And m_strFlagMove <> "save") Then
            If Not Request.QueryString("FromWhere") Is Nothing Then
                If m_strFromWhere.ToString = "ATS" Or m_strFromWhere.ToString = "SimpleDA" Then
                    '    'If m_PKToken_TaskLinkClick <> "" Then
                    '    If (m_PKToken_TaskLinkClick = "") Or (CommonFunctions.Security.Token.ValidateToken(CType(m_strProjectID, String) + CType(m_strParamTaskID, String) + CType(0, String) + CType(0, String), m_PKToken_TaskLinkClick) = False) Then
                    '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strProjectID, String))
                    '        'Token is Invalid now redirect to the Invalid Access Page
                    '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    '    End If
                    '    'End If
                    If (((m_PKToken_TaskLinkClick = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_strParamTaskID, String) + CType(m_strEmployeeID, String) + CType(0, String) + CType(0, String) + CType(m_strProjectID, String) + CType(m_strShowClose, String), m_PKToken_TaskLinkClick) = False)) Then
                        ''System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        m_blnValidate = "False"
                    End If
                ElseIf m_strFromWhere.ToString = "WTimeSheet" Then
                    'Added By Vidya J ON 28-01-2016 For PkToken Validation 
                    If (((m_AllProject_GeneralTaskLink = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_strParamTaskID, String) + CType(m_strEmployeeID, String) + CType(0, String) + CType(0, String) + CType(m_strProjectID, String) + CType(m_strShowClose, String), m_AllProject_GeneralTaskLink) = False)) Then
                        m_blnValidate = "False"
                    End If
                    'End Of Addition By Vidya J ON 28-01-2016 For PkToken Validation
                End If
                ''Added by Dhanashri S on 11 Aug 2016
            Else
                m_blnValidate = "False"
                ''End of Addition by Dhanashri S on 11 Aug 2016
            End If
        End If


        If Not Request.QueryString("PKTokenValue") Is Nothing Then
            m_AllProject_AssignedTaskLink = Request.QueryString("PKTokenValue").ToString
        End If

        If m_AllProject_AssignedTaskLink <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_strProjectID, String) + CType(m_strParamTaskID, String) + CType(0, String) + CType(0, String), m_AllProject_AssignedTaskLink) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strProjectID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        ''End of Addition by Dhanashri S on 28 Jan 2016



        ''Added by Dhanashri S on 11 Aug 2016
        If m_blnValidate = "False" Then
            ''System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        ''Added by swapnil A for session timeout expire on 18-1-2016
        'If Context.Session IsNot Nothing Then
        '    If Session.IsNewSession Then

        '        Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED")

        '    End If
        'End If
        ''Ended
        ' ***********************************************************************************
        ' Added  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
        ' ***********************************************************************************
        Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
        If Value2 IsNot Nothing Then
            For i As Integer = 0 To Value2.Count - 1
                If Value2.Item(i) <> Session("SessionID") Then
                    CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID"))
                    Session("intUserID") = Nothing
                    Session.Abandon()
                    Response.Redirect("../../Default.aspx?Message=SESSIONEXPIRED")
                End If
            Next
        End If
        ' ***********************************************************************************
        ' Ended  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
        ' ***********************************************************************************
        m_strWindowTitle = MyBase.GetResourceString("TIMESHEET")
        'Added by VivekP On 6 jun 2005
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        ' m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_lngTagID = 1038
        If m_lngTagID = 0 Then
            m_lngTagID = m_objGlobal.TagID
        Else
            m_objGlobal.TagID = m_lngTagID
        End If
        m_objAccessRights.GetAccess(m_objGlobal)
        'ENd Of addition on 6 Jun 2005 By VivekP
        EXPIRY_OF_TASK = CommonFunction.Application.BackdatingNoDays.ToString()
        EXPIRY_OF_TASK_FORWARD = CommonFunction.Application.ForwardDatingNoDays.ToString()
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_DailyActivity", "AppResources")
    End Sub


    ''added by Nilesh g on 2/2/2016 for url issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(strTaskType As String, projectid As String, TaskTypeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(strTaskType, String) + CType(projectid, String) + CType(TaskTypeID, String) + "0" + "0")
            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''ENDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE


    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : This function is get called after form load.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================

        'Modified By VidyaJ - DA Performance Issue - IssueID -89
        ''Added by DipaliS 4 Nov 2004
        ''Purpose : For Issue 13754
        'Dim intRoleLevel As Integer
        'intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        ''If middle level then apply filter for Projects
        'If intRoleLevel = 2 Then
        '    'Apply Role Access Filter for Project List
        '    m_strProjectFilters = ""
        '    Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
        '    If strFilter <> "" Then
        '        m_strProjectFilters += strFilter
        '    End If
        '    'Code Commented By DipaliS 15 July and added the following
        '    Dim strRemove As String = "ProjectID IN"
        '    m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
        '    'End Addition
        '    m_strProjectFilters = m_strProjectFilters.Replace("'", "")
        'End If
        ''End addition by DipaliS
        'End Of Modifications
        '--- added By purvaj on 30 Sept 2008 for Whiziblesem8.0 , to display whether selected date is holiday

        Dim strFromXML As String
        strFromXML = CommonFunction.General.CheckIsNothing(Request("FromXML"), "")
        If strFromXML = "1" Then
            GetHolidayOrLeave()
        Else
            '--- End addition Purvaj

            Dim drTaskDetails As IDataReader
            Dim drProjectsOnHold As IDataReader
            Dim strSQLQuery As String
            Dim drProject As IDataReader


            m_blnStatus_MPPTasks = CommonFunction.Application.RestrictDurationChange_M
            m_blnStatus_AssignedTasks = CommonFunction.Application.RestrictDurationChange_O
            m_blnShowWeeklyView = CommonFunction.Application.ShowWeeklyView
            m_blnTaskTypeMandatoryInDA = CommonFunction.Application.TaskTypeMandatoryInDA
            m_blnShowTaskTypeTimesheet = CommonFunction.Application.ShowTaskTypeTimesheet
            m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()
            m_dblMinHoursForDAEntry = CommonFunction.Application.MinHoursForDAEntry()

            '##### Added For Resource Timesheet Work Flow
            'Added By AmitD on 10 Aug 2004
            m_blnTimesheetWorkFlow = CommonFunction.Application.TimesheetWorkFlow
            m_blnAllowTaskProgress = CommonFunction.Application.AllowTaskProgress
            'End Addition
            '##### End Addition

            'Store UserID in Local Variable

            'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
            'Check whether request came from Onsite Resource Timesheet
            If CType(Trim(Request.QueryString("From")), String) = "Proxy" Then
                If CType(Request.QueryString("EmployeeID"), String) <> "" Then
                    m_strSessionUserID = CType(Request.QueryString("EmployeeID"), String)
                End If
            Else
                m_strSessionUserID = CType(Session("intUserID"), String)
            End If
            'Addition End by SantoshK on 20th March 2006

            m_strSessionPostID = CType(Session("intPostID"), String)
            m_strSessionClientDate = CType(Session("ClientDate"), String)

            '-----------------------------------------------------
            m_blnDAEntryEditable = True
            m_blnProjectEditable = True
            m_blnTaskEditable = True


            ' Store the location from where the page has been called.
            m_strParamFromWhere = Trim(Request.QueryString("FromWhere"))

            ' Flag indicating that the CloseLink must be shown or not.	
            ' The Falg will be set only if the page has been called from the Dashboards, or the Weekly View.
            m_strParamShowCloseLink = CType(Trim(Request.QueryString("ShowClose")), String)
            If m_strParamShowCloseLink = "" Then
                m_strParamShowCloseLink = "0"
            End If

            ' Retrieve the DailyActivityEntryID if a particular entry has to be edited.
            m_strParamDailyActivityID = Trim(Request.QueryString("DailyActivityID"))
            If m_strParamDailyActivityID = "" Then
                m_strParamDailyActivityID = "0"
            Else
                m_blnProjectEditable = False
                m_blnTaskEditable = False
            End If

            If InStr(1, Request("IncludeCompletedTasks"), "1") <> 0 Then
                m_blnIncludeCompletedTasks = True
            Else
                m_blnIncludeCompletedTasks = False
            End If

            ' Retrieve the Entry date. If no date is specified, then the Current Date will be set as the Default Date.	
            If Trim(MyBase.GetFormValue("txtDate")) <> "" Then
                m_strParamDate = Trim(FixString(MyBase.GetFormValue("txtDate"), 0, False, False))
            ElseIf Trim(Request.QueryString("txtDate")) <> "" Then
                m_strParamDate = Request.QueryString("txtDate")
            Else
                'Get the client side as default date for daily activity
                'To keep the flag at corporate level to whether to use the client for DA or Not
                If m_blnUseClientDateForDA = True Then
                    m_strParamDate = CType(Session("ClientDate"), String)
                Else
                    m_strParamDate = Date.Today.ToString("dd-MMM-yyyy")
                End If
            End If

            ' Retrieve the Mode.
            m_strParamMode = Trim(Request.QueryString("Mode"))
            If m_strParamMode = "" Then
                If m_strParamFromWhere = "DA" Or m_strParamFromWhere = "" Then
                    m_strParamMode = "List"
                Else
                    m_strParamMode = "New"
                End If
            ElseIf m_strParamMode = "Edit" Then
                m_blnProjectEditable = False
                m_blnTaskEditable = False
            End If

            'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
            m_strToken = ""

            If CType(m_strParamDailyActivityID, String) <> "0" Then
                If Request.QueryString("PkToken") Is Nothing Then
                    m_strToken = Request.Form("txtHidToken").ToString
                Else
                    m_strToken = Request.QueryString("PkToken").ToString
                End If
            End If

            If ((m_strToken = "") And (m_strParamDailyActivityID <> "0")) Or _
    ((m_strParamDailyActivityID <> "0") And (CommonFunctions.Security.Token.ValidateToken(m_strParamDailyActivityID + CType(Session("intUserID"), String) + CType(0, String) + CType(m_lngTagID, String), m_strToken) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet", m_lngTagID, 0, "DailyActivity ID", CType(m_strParamDailyActivityID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            'End Addition

            'Modified By VidyaJ - DA Performance Issue - IssueID -89
            'Get Project Filter Info only in Details page and not in list page
            'If m_strParamMode <> "List" Then

            'Added by DipaliS 4 Nov 2004
            'Purpose : For Issue 13754
            Dim intRoleLevel As Integer
            intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
            'If middle level then apply filter for Projects
            If intRoleLevel = 2 Then
                'Apply Role Access Filter for Project List
                m_strProjectFilters = ""
                Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If
                'Code Commented By DipaliS 15 July and added the following
                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
                'End Addition
                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            End If
            'End addition by DipaliS

            'End If
            'End Of Modifications

            ' Retrieve the Action to be performed.
            m_strParamAction = Trim(Request.QueryString("Action"))
            If m_strParamAction = "" Then
                m_strParamAction = "Show"
            End If

            '##### Added for alerting users if the selected project is on hold
            'Added By PriyankaN on 9th Sep 2004

            'Modified By VidyaJ - DA Performance Issue - IssueID -89
            'Check this condition only in details page , so added m_strParamMode <> "List" condition

            If m_strSessionUserID <> "0" And m_strParamMode <> "List" Then
                'End Of Modification
                drProjectsOnHold = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Project_For_DA_Active_InActive_Projects_OnHold " + m_strSessionUserID, MyBase.UseSQL)
                If drProjectsOnHold.Read() Then
                    m_strProjectsOnHold = CType(CommonFunction.Data.CheckIsDBNull(drProjectsOnHold("ProjectsOnHold"), ""), String)
                    If m_strProjectsOnHold = "" Then
                        m_strProjectsOnHoldMsg = ""
                    Else
                        m_strProjectsOnHoldMsg = CType(CommonFunction.Data.CheckIsDBNull(drProjectsOnHold("ProjectsOnHoldMsg"), ""), String)
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drProjectsOnHold)
                '''<Summary>
                '' Added By: PrashantSJ
                '' date: 27th May 2008
                ''Purpose: DA blocked for particular project from project workflow.
                '''</Summary>
                arrTSBlockedProjects = CommonFunction.WhizibleWorkflow.GetTimesheetBlockedProjectList(m_strSessionUserID)

                m_strProjectsDABlocked = arrTSBlockedProjects(0)
                m_strProjectsDABlockedMsg = arrTSBlockedProjects(1)

                '''End of addition by PrashantSJ on 27th May 2008
            Else
                m_strProjectsOnHold = ""
                m_strProjectsDABlocked = ""
            End If

            'Sets the first project which is not on hold.
            'Code Commented by DipaliS 5 Nov 2004
            'Purpose :IssueID 13754
            'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'"
            'Code Added by DipaliS 5 Nov 2004
            'Purpose : IssueID 13754

            'Modified By VidyaJ - DA Performance Issue - IssueID -89
            'Check this condition only in details page , so added m_strParamMode <> "List" condition

            If m_strParamMode <> "List" Then

                strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'" & ",'" & m_strProjectFilters & "'"
                'End addition by DipaliS
                drProjectsOnHold = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                m_strFirstNotOnHoldProject = "0"
                While drProjectsOnHold.Read
                    m_strFirstNotOnHoldProject = CType(CommonFunction.Data.CheckIsDBNull(drProjectsOnHold("ProjectID"), "0"), String)
                    If InStr(1, m_strProjectsOnHold, "," + m_strFirstNotOnHoldProject + ",", CompareMethod.Text) = 0 Then
                        '''<Summary>
                        '' Added By: PrashantSJ
                        '' date: 27th May 2008
                        ''Purpose: DA blocked for particular project from project workflow.
                        '''</Summary>
                        ''Exit While
                        If InStr(1, m_strProjectsDABlocked, "," + m_strFirstNotOnHoldProject + ",", CompareMethod.Text) = 0 Then

                            Exit While
                        End If
                        '''End of addition by PrashantSJ on 27th May 2008
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drProjectsOnHold)

            End If
            'End Of Modifications

            'End Addition
            '##### End Addition

            If m_strParamMode <> "List" Then

                ' Get the project to be selected.
                ' If the project is selected in the combo box, then...
                If Trim(MyBase.GetFormValue("cboProject")) <> "" Then
                    m_strProjectID = FixString(MyBase.GetFormValue("cboProject"), 0, False, True)

                Else
                    'Modified by SandipL on 20 April 2007 IssueID 12620 -- Selected project does not persists
                    'm_strProjectID = "0"
                    If Not Request.QueryString("ProjectID") Is Nothing Then
                        m_strProjectID = Request.QueryString("ProjectID")
                    Else
                        m_strProjectID = "0"
                    End If
                    'End modification by SandipL on 20 April 2007


                    'Commented by Priyanka, 9th Sep 2004, for setting the first not ONHOLD Project, instead of the first project
                    'Added by PrasannaP on 18th May 2004.
                    'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'"
                    'drProject = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    'If drProject.Read() Then
                    '    m_strProjectID = CType(CommonFunction.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String)
                    'Else
                    '    m_strProjectID = "0"
                    'End If
                    'CommonFunction.Data.DisposeDataReader(drProject)
                    'End Addition
                    'End Of Commenting

                    'Added by Priyanka, 9th Sep 2004
                    'm_strProjectID = m_strFirstNotOnHoldProject
                    'End Of Addition

                End If
                'Added By VivekP On 6 Jun 2005
                m_blnProjectActive = IsProjectActive(CType(m_strProjectID, Long))

                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''GlobalProject = CType(CommonFunctions.Data.GetDataScalar("SELECT GlobalProject FROM tbl_PM_Project WHERE ProjectID=" + CType(m_strProjectID, String), MyBase.UseSQL), String)
                GlobalProject = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_GlobalProject " + CType(m_strProjectID, String), MyBase.UseSQL), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                'End Of addition On 6 jun 2005 By Vivekp

                ' Get the Task Type to be selected.	
                If Trim(MyBase.GetFormValue("optTasks")) <> "" Then
                    m_strTaskType = FixString(MyBase.GetFormValue("optTasks"), 0, False, True)
                Else
                    m_strTaskType = "0"
                End If

                ' Get the TaskID of the task to be selected.	
                If Trim(MyBase.GetFormValue("cboTask")) <> "" Then
                    m_strTaskInfo = FixString(MyBase.GetFormValue("cboTask"), 0, False, True)
                    m_strTaskArray = Split(m_strTaskInfo, "|")
                    m_strParamTaskID = m_strTaskArray(1)
                ElseIf Trim(Request.QueryString("TaskID")) <> "" Then
                    m_strParamTaskID = Request.QueryString("TaskID")

                    ' Get the details for that TaskID.
                    drTaskDetails = CommonFunction.Data.GetDataReader("usp_Sel_GetTaskDetails " + m_strParamTaskID, MyBase.UseSQL)

                    ' If the details are found, then...
                    If drTaskDetails.Read Then

                        m_strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("ProjectID"), "0"), String)
                        m_strTaskInfo = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("TaskInfo"), "0"), String)
                        m_strTaskType = Left(m_strTaskInfo, 1)
                        m_strTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("TaskTypeID"), "0"), String)
                        m_strTaskTypeName = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("ModuleName"), ""), String)
                        '---------------------------------
                        'Added by Prasanna
                        'This is to set the date of DailyActivityPage with the assigned issue date.
                        Try
                            m_strStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("StartDate"), ""), Date).ToString("dd-MMM-yyyy")
                            'Added on 7th June 2004
                            m_strEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDetails("EndDate"), ""), Date).ToString("dd-MMM-yyyy")
                            'End Addition
                            If m_strParamFromWhere = "DeveloperDB" Or m_strParamFromWhere = "PMDashboard" Then
                                m_blnGetDeveloperDBDate = True
                            End If
                        Catch e As Exception
                            m_blnGetDeveloperDBDate = False
                        End Try

                        '----------------------------------
                        If m_strTaskTypeID = "" Then
                            m_strTaskTypeID = "0"
                        End If

                    End If
                    CommonFunctions.Data.DisposeDataReader(drTaskDetails)
                    m_blnProjectEditable = False
                    m_blnTaskEditable = False
                Else
                    m_strParamTaskID = "0"
                End If
            End If
            '-----------------------------------------------------

            If m_strParamDate = "" Then
                If m_blnUseClientDateForDA = True Then
                    m_strParamDate = Session("ClientDate").ToString
                Else
                    m_strParamDate = Date.Today.ToString("dd-MMM-yyyy")
                End If
            Else
                Try
                    m_strParamDate = Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI).ToString("dd-MMM-yyyy")
                Catch e As FormatException
                    If m_blnUseClientDateForDA = True Then
                        m_strParamDate = Date.ParseExact(m_strSessionClientDate, "d-MMM-yyyy", m_objDTFI).ToString("dd-MMM-yyyy")
                    Else
                        m_strParamDate = Date.Today.ToString("dd-MMM-yyyy")
                    End If
                End Try
            End If

            If m_strProjectID <> Nothing Or m_strProjectID <> "" Then
                'Get the Total Hours that the user can enter while filling the Daily Activity
                'Commented By VidyaJ - DA Performance Issue - IssueID -89
                'Always validate for max 24 hours per day
                'm_dblTotalWorkHours = CommonFunction.General.GetWorkingHoursPerDay(m_strProjectID)
                m_dblTotalWorkHours = 24
            End If
            'Decides what to do according to the Mode of action

            DrawPage()
            strSQL = Nothing
        End If '---- FromXML If end
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : This procedure holds the logic of plotting the 
        '                         which page and when.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 19, 2004
        ' Revisions             :
        '=====================================================================
        Dim strFromDate As String = ""
        Dim strToDate As String = ""


        'Modified By VidyaJ - DA Performance Issue - IssueID -89
        'Check this condition only on list page

        If m_strParamMode = "List" Then
            CommonFunction.Dates.GetFromAndToDates("1", strFromDate, strToDate, m_strParamDate)
            strToDate = DateAdd("d", 6, strFromDate).ToString("dd, MMM yyyy")
            strFromDate = DateAdd("d", -6, strToDate).ToString("dd, MMM yyyy")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("hdntxtToDate", "hdntxtToDate", , , , strToDate, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("hdntxtFromDate", "hdntxtFromDate", , , , strFromDate, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'PlotNote()
        End If
        'End Of Modifications

        ManipulateRecords()

        'Added By PrasannaP on 15th May 2004
        'Dim drCompanyInformation As IDataReader
        blnDisplayETC = False

        ' Commented and Added By MahendraV On 3:05 PM 5/29/2007 for Company Information optimization
        ' Start_MV_5/29/2007
        'drCompanyInformation = CommonFunction.Data.GetDataReader("SELECT AcceptETC , BackdatingNoDays, ForwardDatingNoDays, isnull(AcceptDAType, 0) AS AcceptDAType FROM tbl_PM_CompanyInformation", MyBase.UseSQL)

        'If drCompanyInformation.Read() Then
        '    blnDisplayETC = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AcceptETC"), "0"), Boolean)
        '    EXPIRY_OF_TASK = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("BackdatingNoDays"), INVALID_ENTRY), Integer)
        '    EXPIRY_OF_TASK_FORWARD = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ForwardDatingNoDays"), INVALID_ENTRY), Integer)
        '    'Start-AUJ-22Jan2007
        '    blnAcceptDATYpe = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AcceptDAType"), "0"), Boolean)
        '    'End-AUJ-22Jan2007
        'End If
        'CommonFunction.Data.DisposeDataReader(drCompanyInformation)

        blnDisplayETC = CommonFunction.Application.AcceptETC
        EXPIRY_OF_TASK = CommonFunction.Application.BackdatingNoDays.ToString()
        If EXPIRY_OF_TASK = "" Then EXPIRY_OF_TASK = INVALID_ENTRY

        EXPIRY_OF_TASK_FORWARD = CommonFunction.Application.ForwardDatingNoDays.ToString()

        If EXPIRY_OF_TASK_FORWARD = "" Then EXPIRY_OF_TASK_FORWARD = INVALID_ENTRY

        blnAcceptDATYpe = CommonFunction.Application.AcceptDAType
        ' End_MV_5/29/2007
        'End Addition

        If m_strParamMode = "List" Then
            '---------------------------------------------------
            'For list page of Dialy Activity
            '---------------------------------------------------
            DrawMenu("ListTop")
            'Main Div
            If CommonFunction.General.IsClientBrowserIE Then
                CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='width:100%; Height:450px; overflow: auto;'>")
                CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='width: 100%; Height: 425px; overflow: auto; '>")
            Else
                CommonFunctions.General.WriteHTML("<DIV id=""DivMain"" style=""height:500px; overflow: auto;"">")
                CommonFunctions.General.WriteHTML("<br><DIV id=DivTaksList style='margin-left: 1px; height: 400px; overflow: auto; '>")
            End If
            'PlotNote()
            DrawGrid()
            'Display Total Duration (Actual Hours) and closes Div 
            CommonFunctions.General.WriteHTML("</div>" & _
                                              "</br></br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD>" & MyBase.GetResourceString("MARKED_RED") & "</TD><td widht=50%></td>" & _
                                              "<td align=right><B>" & MyBase.GetResourceString("TOTAL_ACTUAL_WORK") & " " & CStr(m_dblTotalDuration) & "</B></TD></TR></Table><BR>")
            CommonFunctions.General.WriteHTML("</Div>")
            If Not CommonFunction.General.IsClientBrowserIE Then
                CommonFunctions.General.WriteHTML("</td></tr></table>")
            End If
            DrawMenu("ListBottom")
            '---------------------------------------------------
        Else
            '---------------------------------------------------
            'For Filling or editing the Daily Activity.
            '---------------------------------------------------
            'Added by SandipL on 24 April 2007 SEMSP8 regression testing issues IssueID 13048
            ' ProjectID need to be initialized before plotting menu code from DrawEntryFormForDailyActivity transfered in this function
            InitializeEntryFormProject()
            'End addition by SandipL

            DrawMenu("EditTop")
            DrawPageLegend()
            PlotNote()
            DrawEntryFormForDailyActivity()
            'SetMPPConstraintFlag()
            CommonFunctions.General.WriteHTML("</DIV>")
            DrawMenu("EditBottom")

            'Commented By VidyaJ - DA Performance Issue - IssueID -89
            'Variable can be initialized in DrawEntryFormForDailyActivity function itself
            'No need of firing the query again
            'GetEnforceConstraint()
            '---------------------------------------------------
        End If

    End Sub

    Private Sub GetEnforceConstraint()
        'Added by PrasannaP on 03 April 2004 for task constraint checking
        'Purpose : Check and force task level constraints while saving daily activity
        'Assumptions : 1. Task not started = no daily activity is present against the task
        '			   2. Project is integrated with MSP and not with Project Server
        '			   3. The flag 'Enforce Constraints' is set to 1 for project

        ''Enforce Constraints
        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("select dbo.udf_EnforceConstraints(" & m_strProjectID & ")")
        m_blnEnforceConstraints = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL.ToString, MyBase.UseSQL), "0"), Boolean)
        strSQL.Remove(0, strSQL.ToString.Length)
    End Sub

    Private Sub DrawPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub
    Protected Function PlotNote() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b style='font-weight: bold;'>Note : </b> Future date as the task completion date may impact all the reports in the whizible.</TD></TR></TABLE>"
        'Return CStr(strPlot)
        Response.Write(strPlot)
    End Function
    Private Sub ManipulateRecords()

        Dim strDailyActivityIDsToDelete As String

        Dim drTotalHours, drDAEntry As IDataReader
        Dim drResourceLevelTaskCompletion As IDataReader

        Select Case m_strParamAction
            Case "Delete"
                Dim arrChkDelete() As String
                'Construct the query to delete the selected records from tbl_PM_DailyActivity table.
                If CType(MyBase.GetFormValue("chkDelete"), String) <> "" Then

                    arrChkDelete = Split(CType(FixString(MyBase.GetFormValue("chkDelete"), 0, False, True), String), ",")
                    For Each strDailyActivityIDsToDelete In arrChkDelete
                        'strSQL = "usp_Del_tbl_PM_DailyActivity " & strDailyActivityIDsToDelete
                        strSQL.Remove(0, strSQL.ToString.Length)
                        strSQL.Append("usp_Del_tbl_PM_DailyActivity " & strDailyActivityIDsToDelete)
                        drDAEntry = CommonFunction.Data.GetDataReader(strSQL.ToString, MyBase.UseSQL)
                        If drDAEntry.Read Then
                            If CType(CommonFunction.Data.CheckIsDBNull(drDAEntry(1), "0"), Boolean) = False Then
                                CommonFunction.General.WriteHTML("<script language=Javascript>")
                                CommonFunction.General.WriteHTML("alert('Cannot delete the Task " + CType(CommonFunction.Data.CheckIsDBNull(drDAEntry(0), "0"), String) + "');")
                                CommonFunction.General.WriteHTML("</script>")
                            End If
                        End If
                        CommonFunction.Data.DisposeDataReader(drDAEntry)
                    Next
                    strSQL.Remove(0, strSQL.ToString.Length)
                End If
            Case "Save"
                'modified by HarshK for sp4 issueid 672 on 7 Dec 2005 (CommonFunctions.General.CheckIsNothing is used)
                m_fltETC = Trim(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtETC")), 0, False, False))
                m_strTaskInfo = Trim(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboTask")), 0, False, False))

                m_strDuration = Trim(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtHours"), "0"), 0, False, False))

                'Modified By Prasanna on 17th May 2004
                'm_strDescription = Trim(FixString(MyBase.GetFormValue("txtDescription"), 2000, False, True))
                m_strDescription = Trim(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDescription")), 2000, False, False))
                'End Modification
                'End modified by HarshK for sp4 issueid 672 on 7 Dec 2005 (CommonFunctions.General.CheckIsNothing is used)
                If m_strDescription <> "" Then
                    m_strDescription = Left(m_strDescription, 2000)
                End If

                'Commented By PrasannP on 15th May 2004

                '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

                '' START : Modified By ParagD On 25-July-2006
                '' Purpose : Infopro 2949 - Page crash in Update Task screen.

                ''Check for task completion Check Box
                ''If CType(MyBase.GetFormValue("chkCompleteTask"), String) <> "" Then
                If CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkCompleteTask"), ""), String) <> "" Then
                    '' END : Modified By ParagD On 25-July-2006
                    '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

                    m_blnTaskComplete = True
                    m_intTaskComplete = 1
                Else
                    m_blnTaskComplete = False
                    m_intTaskComplete = 0
                End If

                '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

                '' START : Modified By ParagD On 25-July-2006
                '' Purpose : Infopro 2949 - Page crash in Update Task screen.

                'Added by Priyanka, 12th Feb 2003
                ''If Len(Trim(Request.Form("txtOvertime"))) > 0 Then
                If Len(Trim(CommonFunctions.General.CheckIsNothing(Request.Form("txtOvertime"), "0"))) > 0 Then
                    '' END : Modified By ParagD On 25-July-2006
                    'Commented and Modified by SavitaS on 26 July 2006 for Infopro 2949 (Page crash Issue)
                    'm_intOvertime = CType(Trim(Request.Form("txtOvertime")), Double)
                    m_intOvertime = CType(Trim(CommonFunctions.General.CheckIsNothing(Request.Form("txtOvertime"), "0")), Double)
                    'End of Commented and Modified by SavitaS on 26 July 2006 for Infopro 2949 (Page crash Issue)
                    '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2
                Else
                    m_intOvertime = 0
                End If
                m_dblTotalOvertimeHours = 0
                'End Of Addition

                '' START : Modified By ParagD On 25-July-2006
                '' Purpose : Infopro 2949 - Page crash in Update Task screen.

                ''Check for IsDurationChange flag.
                ''If Trim(MyBase.GetFormValue("txtIsDurationChange")) = "1" Then -- Commented
                If Trim(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtIsDurationChange"), "0")) = "1" Then
                    '' END : Modified By ParagD On 25-July-2006
                    m_blnIsDurationChange = True
                Else
                    m_blnIsDurationChange = False
                End If

                '--------------------------------------------------------------------
                'End Of Addition
                '--------------------------------------------------------------------


                ''--------------------------------------------------------------------
                ''CHECK IF THE TOTAL HOURS ENTERED FOR THE DAY IS EXCEEDING 24 HOURS.
                ''--------------------------------------------------------------------			

                ''Get the total hours spent on the particular date.
                drTotalHours = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & m_strParamDate & "','" & m_strParamDate & "',NULL, 1, 1", MyBase.UseSQL)
                If drTotalHours.Read Then
                    m_dblPrevTotalHours = CType(CommonFunctions.Data.CheckIsDBNull(drTotalHours("TotalHours"), "0"), Double)
                    m_dblTotalHours = CType(CommonFunctions.Data.CheckIsDBNull(drTotalHours("TotalHours"), "0"), Double)
                End If
                CommonFunctions.Data.DisposeDataReader(drTotalHours)

                If Trim(m_strParamDailyActivityID) = "0" Then
                    m_dblTotalHours = m_dblTotalHours + CDbl(m_strDuration)
                Else
                    'Modified By VidyaJ - DA Performance Issue - IssueID -89
                    'No need of firing this complex query to get DA details. Instead file a simple select query
                    'drDAEntry = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity " & m_strParamDailyActivityID, MyBase.UseSQL)

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''drDAEntry = CommonFunctions.Data.GetDataReader("Select Duration From tbl_PM_Dailyactivity Where DailyActivityEntryID= " & m_strParamDailyActivityID, MyBase.UseSQL)
                    drDAEntry = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Dailyactivity_Duration " & m_strParamDailyActivityID, MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


                    'End Of Modification

                    If drDAEntry.Read Then
                        m_dblTotalHours = m_dblTotalHours - CType(CommonFunctions.Data.CheckIsDBNull(drDAEntry("Duration"), "0"), Double) + CDbl(m_strDuration)
                    End If
                    CommonFunction.Data.DisposeDataReader(drDAEntry)
                End If

                m_blnExceeded24Hours = False

                'If m_dblTotalHours > 24 Then

                '    m_blnExceeded24Hours = True

                '    'Recalculate the Duration value, and adjust it such that the sum does not exceed 24 hours.
                '    'The Result is first divided by 0.5 and then multiplied by 0.5 to get the final result as an multiple of 0.5.
                '    Dim dblExcess As Double
                '    dblExcess = CDbl(FixString(MyBase.GetFormValue("txtHours"), 0, True, False)) - (m_dblTotalHours - 24)
                '    m_strDuration = CStr((CInt(dblExcess / CommonFunction.Application.MinHoursForDAEntry)) * CommonFunctions.Application.MinHoursForDAEntry)

                '    CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" & vbCrLf)

                '    CommonFunctions.General.WriteHTML("alert('" + MyBase.GetResourceString("VALIDATE_HOURS_BOOKED1") + FormatNumber(m_dblPrevTotalHours, 2) + MyBase.GetResourceString("VALIDATE_HOURS_BOOKED2") + "');")
                '    If FixString(MyBase.GetFormValue("txtETC"), 0, True, False) = "" Then
                '        CommonFunctions.General.WriteHTML("strETCValue = '';")
                '    Else
                '        CommonFunctions.General.WriteHTML("strETCValue = " + FixString(MyBase.GetFormValue("txtETC"), 0, True, True) + ";")
                '    End If
                '    CommonFunctions.General.WriteHTML("</script>")

                'Commented by Priyanka, 12th Feb 2003
                'If dblTotalHours > 24 Then

                'Added by Priyanka, 18th Nov 2003
                'Get the total overtime hrs entered for the entry date

                'Modified By VidyaJ - DA Performance Issue - IssueID -89
                'Commented Code as Overtime is not accepted in WSEM

                'Dim drOvertime As IDataReader

                'drOvertime = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_DailyActivity_Overtime " & m_strSessionUserID & ",'" & m_strParamDate & "',NULL", MyBase.UseSQL)
                'If drOvertime.Read Then
                '    m_dblTotalOvertimeHours = CType(CommonFunction.Data.CheckIsDBNull(drOvertime("Overtime"), "0"), Double)
                'Else
                '    m_dblOvertime = 0
                'End If
                'CommonFunction.Data.DisposeDataReader(drOvertime)

                'If Trim(m_strParamDailyActivityID) <> "0" Then
                '    drOvertime = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_DailyActivity_Overtime " & m_strSessionUserID & ",'" & m_strParamDate & "'," & m_strParamDailyActivityID, MyBase.UseSQL)
                '    If drOvertime.Read Then
                '        If CType(CommonFunction.Data.CheckIsDBNull(drOvertime("Overtime"), ""), String) <> "" Then
                '            m_dblTotalOvertimeHours = CDbl(m_dblTotalOvertimeHours) - CDbl(drOvertime("Overtime")) + CDbl(m_intOvertime)
                '        Else
                '            m_dblTotalOvertimeHours = 0
                '        End If
                '    End If
                '    CommonFunction.Data.DisposeDataReader(drOvertime)
                'Else
                '    m_dblTotalOvertimeHours = CDbl(m_dblTotalOvertimeHours) + CDbl(m_intOvertime)
                'End If
                ''End Addition

                m_dblTotalOvertimeHours = 0
                'End Of Modification 

                If m_dblTotalHours > m_dblTotalWorkHours Then
                    m_blnExceeded24Hours = True
                    ' Recalculate the Duration value, and adjust it such that the sum does not exceed 24 hours.
                    ' The Result is first divided by 0.25 and then multiplied by 0.25 to get the final result as an multiple of 0.25.
                    m_strDuration = CType(CDbl(Request.Form("txtHours")) - (m_dblTotalHours - m_dblTotalWorkHours), String)
                    '--------------------------------------------------------------------
                    ' End Addition		
                    '--------------------------------------------------------------------


                    CommonFunction.General.WriteHTML("<script LANGUAGE='Javascript'>")
                    CommonFunction.General.WriteHTML("alert('" + Replace(MyBase.GetResourceString("VALIDATE_HOURS_BOOKED1"), "<=>", CStr(m_dblTotalWorkHours)) + CStr(m_dblTotalHours - CDbl(Request.Form("txtHours"))) + MyBase.GetResourceString("VALIDATE_HOURS_BOOKED2") + "');")
                    CommonFunction.General.WriteHTML("var strETCValue;")
                    CommonFunction.General.WriteHTML("strETCValue = '" + MyBase.GetFormValue("txtETC") + "';")
                    CommonFunction.General.WriteHTML("</script>")

                ElseIf ((m_dblTotalOvertimeHours + m_dblTotalHours) > m_dblTotalWorkHours) Then
                    m_blnExceeded24Hours = True
                    m_intOvertime = CDbl(m_intOvertime) - ((m_dblTotalOvertimeHours + m_dblTotalHours) - m_dblTotalWorkHours)
                    CommonFunction.General.WriteHTML("<script LANGUAGE='Javascript'>")
                    CommonFunction.General.WriteHTML("alert('You can book a total of only " & m_dblTotalWorkHours & " hours in a day.')")
                    CommonFunction.General.WriteHTML("</script>")
                Else
                    ''-----------------------------------------------------------
                    ''BUILD THE QUERY TO INSERT/UPDATE THE DAILY ACTIVITY ENTRY.
                    ''-----------------------------------------------------------
                    'Modified By VidyaJ - IssueID - 294 - SP4
                    Dim StrActvityLevelDAEntryQuery As String
                    StrActvityLevelDAEntryQuery = " EXEC usp_Sel_AllowActivityLevelDAEntry " & m_strProjectID

                    Dim iDAReader As IDataReader
                    iDAReader = CommonFunction.Data.GetDataReader(StrActvityLevelDAEntryQuery, MyBase.UseSQL)
                    While iDAReader.Read
                        blnAllowActivityLevelDAEntry = CType(CommonFunction.Data.CheckIsDBNull(iDAReader("AllowActivityLevelDA"), "0"), Boolean)
                        m_blnHaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(iDAReader("HaveSubTaskTypes"), "0"), Boolean)
                    End While

                    CommonFunction.Data.DisposeDataReader(iDAReader)

                    ' strSQL = strSQL & "Exec usp_Ins_tbl_PM_DailyActivity "
                    strSQL.Append("Exec usp_Ins_tbl_PM_DailyActivity ")

                    'If the mode is edit, then...
                    If Trim(m_strParamDailyActivityID) <> "0" And Trim(m_strParamDailyActivityID) <> "" Then
                        strSQL.Append(m_strParamDailyActivityID)
                    Else
                        strSQL.Append(" NULL")
                    End If

                    strSQL.Append(", " & m_strParamTaskID & ", " & m_strProjectID & ", " & m_strSessionUserID & ", " & m_strSessionPostID & ", '" & m_strParamDate & "' " & "," & m_strDuration)

                    ''The Description of the Task.
                    If Trim(m_strDescription) <> "" Then
                        strSQL.Append(",'" & Left(m_strDescription, 2000) & "'")
                    Else
                        strSQL.Append(", NULL")
                    End If



                    'The Task Type of the Task.
                    If Trim(MyBase.GetFormValue("cboTaskType")) <> "" Then
                        strSQL.Append(", " & FixString(MyBase.GetFormValue("cboTaskType"), 0, False, True))
                    Else
                        strSQL.Append(", NULL")
                    End If


                    ''The Sub Task Type of the Task.
                    If Trim(MyBase.GetFormValue("cboSubTaskType")) <> "" Then
                        'Modified By VidyaJ - For IssueID - 294 
                        If blnAllowActivityLevelDAEntry = True Then
                            strSQL.Append(", " & FixString(MyBase.GetFormValue("cboSubTaskType"), 0, False, True))
                        Else
                            strSQL.Append(", NULL")
                        End If

                    Else
                        strSQL.Append(", NULL")
                    End If

                    '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2
                    '' START : Modified By ParagD On 25-July-2006
                    '' Purpose : Infopro 2949 - Page crash in Update Task screen.

                    ''The Flag indicating that the Duration has changed.
                    ''If Trim(FixString(MyBase.GetFormValue("txtIsDurationChange"), 0, False, False)) <> "1" Then
                    If Trim(FixString(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtIsDurationChange"), "0"), 0, False, False)) <> "1" Then
                        '' END : Modified By ParagD On 25-July-2006 
                        '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2

                        strSQL.Append(", NULL")
                    Else
                        strSQL.Append(", 1")
                    End If

                    If m_intTaskComplete = 1 Then
                        strSQL.Append(", 1")
                    Else
                        strSQL.Append(", 0")
                    End If

                    ''Insert the ETC into the ETC Table.
                    If m_fltETC <> "" Then
                        'DEADLOCK ISSUE - VidyaJ
                        CommonFunctions.Data.InsertOrUpdateData("usp_Ins_tbl_PM_ProjectTaskETC " & m_strProjectID & "," & m_strSessionUserID & "," & m_strParamTaskID & "," & FormatNumber(m_fltETC, , , , TriState.False) & ",'" & m_strTaskType & "'", MyBase.UseSQL)
                    End If

                    'Modified By VidyaJ - DA Performance Issue - 89 (SP4)
                    If m_strProjectID <> "" Then
                        'strSQL = "usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_strProjectID
                        drResourceLevelTaskCompletion = CommonFunction.Data.GetDataReader("usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_strProjectID, True)

                        If drResourceLevelTaskCompletion.Read Then
                            m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), False, drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), Boolean)
                        Else
                            m_blnResourceLevelTaskCompletion = True
                        End If
                        CommonFunctions.Data.DisposeDataReader(drResourceLevelTaskCompletion)
                    End If
                    'Addition Complete
                    If Trim(MyBase.GetFormValue("txtActualPercentComplete")) <> "" Then
                        If m_blnResourceLevelTaskCompletion Then
                            strSQL.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) & ",1")
                        Else
                            strSQL.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) & ",0")
                        End If
                        'Start-AUJ-22Jan2007
                    Else
                        strSQL.Append(",null,null")
                        'End-AUJ-22Jan2007
                    End If
                    'Start-AUJ-22Jan2007
                    If Trim(MyBase.GetFormValue("optDAType")) <> "" Then
                        strSQL.Append(",null,'" & FixString(MyBase.GetFormValue("optDAType"), 0, False, True) & "'")
                    End If
                    'End-AUJ-22Jan2007

                    'Added By VarunA on 9-Dec-2008 RequestID-15591
                    'Purpose : To have the positive duration if he make changes in the file and removes the Javascript validation.
                    Dim IsNegativeValue As String = ""
                    IsNegativeValue = CommonFunctions.Data.GetDataScalar(strSQL.ToString, MyBase.UseSQL)
                    If IsNegativeValue = "0" Then
                        CommonFunction.General.WriteHTML("<Script>alert('Timesheet entry cannot be negative.');</script>")
                    End If
                    'End By VarunA on 9-Dec-2008 RequestID-15591

                    ''                 Execute the insert/update query.		
                    'DEADLOCK ISSUE - VidyaJ
                    'Commented By VarunA on 9-Dec-2008 RequestID-15591
                    'Purpose : To have the positive duration if he make changes in the file and removes the Javascript validation.
                    'CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
                    'End By VarunA on 9-Dec-2008 RequestID-15591

                    strSQL.Remove(0, strSQL.ToString.Length)
                    '''                 Mark the Task as "Complete" or "Not Complete".
                    'If m_intTaskComplete = 1 Then
                    '    'DEADLOCK ISSUE - VidyaJ
                    '    CommonFunctions.Data.InsertOrUpdateData("usp_Upd_ProjectTaskComplete " & m_strParamTaskID & ",1", MyBase.UseSQL)

                    '    'CommonFunctions.Data.GetDataReader("usp_Ins_tbl_ProjectTaskETC_AutomaticETCRequest " & m_strTaskID, MyBase.UseSQL)
                    '    ''Removed the facility to mark the Task as incomplete once it is marked complete. (As suggested By AshishR)				
                    '    'Else
                    '    'CommonFunctions.Data.GetDataReader("usp_Upd_ProjectTaskComplete " & m_strTaskID & ",0", MyBase.UseSQL)
                    'End If

                    ''' Update the value of 'Actual % Complete'.
                    'If Trim(MyBase.GetFormValue("txtActualPercentComplete")) <> "" Then

                    '    'Added By Santosh Pawar on 21 Oct 2004 
                    '    If m_strProjectID <> "" Then
                    '        strSQL = "usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_strProjectID
                    '        drResourceLevelTaskCompletion = CommonFunction.Data.GetDataReader(strSQL, True)
                    '        strSQL = ""
                    '        If drResourceLevelTaskCompletion.Read Then
                    '            m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), False, drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), Boolean)
                    '        Else
                    '            m_blnResourceLevelTaskCompletion = True
                    '        End If
                    '        CommonFunctions.Data.DisposeDataReader(drResourceLevelTaskCompletion)
                    '    End If
                    '    'Addition Complete

                    '    'Added By AmitD - For Corporate level TimesheetWorkFlow and TaskProgress settings
                    '    If m_blnTimesheetWorkFlow = False And m_blnAllowTaskProgress = False Then
                    '        'Added By Santosh Pawar on 21 Oct 2004
                    '        'Purpose : New Flag introduced at project Level which will allow or diallow 
                    '        '			task completion by resource
                    '        If m_blnResourceLevelTaskCompletion = True Then
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        Else

                    '            ' Modified by NitinVS on 22 Apr 2005 for WhizibleSEM SP3 
                    '            ' To update the ResourcePercentComplete field only once. 

                    '            'strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID



                    '        End If
                    '        'Addition Complete
                    '    ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = False Then

                    '        'strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        If m_blnResourceLevelTaskCompletion = True Then
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        Else
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        End If

                    '    ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = True Then
                    '        'strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        If m_blnResourceLevelTaskCompletion = True Then
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        Else
                    '            strSQL = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '        End If

                    '    End If

                    '    ' End Modification by NitinVS on 22 Apr 2005 for WhizibleSEM SP3 

                    '    'End Addition
                    '    '##### Commented By AmitD on 10 Aug 2004 For handling conditions of Resource Timesheet Flow
                    '    'strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                    '    '##### End Comment
                    '    'DEADLOCK ISSUE - VidyaJ
                    '    Call CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                    'End If

                    If m_strParamFromWhere = "DeveloperDB" Or m_strParamFromWhere = "PMDashboard" Then
                        If FixString(MyBase.GetFormValue("optTasks"), 0, False, False) = PROJECT_SPECIFIC_TASKS Or FixString(MyBase.GetFormValue("optTasks"), 0, False, False) = ASSIGNED_TASKS Then
                            Session("DB_ListNumber") = 1
                        ElseIf FixString(MyBase.GetFormValue("optTasks"), 0, False, False) = DEFECTS_ASSIGNED Then
                            Session("DB_ListNumber") = 2
                        End If
                    End If

                    ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
                    If m_intTaskComplete = 1 Then
                        Dim m_intFlag As Integer
                        m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
                        If m_intFlag = 1 Then
                            Dim SQL As String
                            SQL = "EXEC Usp_Upd_UserStoryStatus '" & m_strParamTaskID & "'," & m_strProjectID & ",8"
                            CommonFunctions.Data.InsertOrUpdateData(SQL, True)
                        End If
                    End If
                    ''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology Issue Fix : 57807)



                    ''                 Reset the DailyActivityEntryID and set the Mode to "New".
                    '---------------------------
                    'Commented by Prasanna on 23rd Feb and added new line
                    'm_intDailyActivityID = 0
                    m_strParamDailyActivityID = "0"
                    '----------------------------------------
                    m_strParamTaskID = "0"
                    m_strTaskInfo = ""
                    m_strParamMode = "New"
                    m_blnIsDurationChange = False
                    m_blnTaskComplete = False
                    m_blnProjectEditable = True
                    m_blnTaskEditable = True

                    ''                 Retrieve the flag indicating how to refresh the parent window.
                    m_strRefreshDetailsWindow = Request("RefreshDetailsWindow")


                    ''                 If the page was not called from the Normal DA page, then refresh the appropriate parent page.
                    'modified by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)to refresh parent page
                    If m_strParamFromWhere = "SimpleDA" Or m_strParamFromWhere = "DeveloperDB" Or m_strParamFromWhere = "PMDashboard" Or m_strParamFromWhere = "WTimeSheet" Or m_strParamFromWhere = "WScrumTimeSheet" Then
                        'End modified by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)to refresh parent page
                        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
                        CommonFunctions.General.WriteHTML("var strParentPage;")
                        CommonFunctions.General.WriteHTML("try" + vbCrLf)
                        CommonFunctions.General.WriteHTML("{" + vbCrLf)
                        CommonFunctions.General.WriteHTML("strParentPage = new String();" + vbCrLf)
                        CommonFunctions.General.WriteHTML("strParentPage = opener.location.href;" + vbCrLf)
                        CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the PM_DailyActivityMatrix.aspx, then refresh the page." + vbCrLf)

                        If m_strParamFromWhere = "SimpleDA" Then
                            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('PM_DAILYACTIVITYMATRIX.ASPX', 0) != -1)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("window.opener.frmDailyActivityMatrix.action = opener.location.href;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("window.opener.frmDailyActivityMatrix.submit();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            'Added by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)to refresh parent page
                        ElseIf m_strParamFromWhere = "WTimeSheet" Then
                            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('TS_WEEKLYTIMESHEET.ASPX', 0) != -1)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("window.opener.frmWeeklyTimesheet.action = '../TimeSheet/TS_WeeklyTimesheet.aspx?Fromwhere=Proxy&EmployeeID=' + m_strSessionUserID + ' + vbCrLf)
                            'CommonFunctions.General.WriteHTML("window.opener.frmWeeklyTimesheet.action = '../TimeSheet/TS_WeeklyTimesheet.aspx';" + vbCrLf)
                            'Modified By VidyaJ - IssueID - 11822
                            If m_strSessionUserID <> CType(Session("intUserID"), String) Then
                                CommonFunctions.General.WriteHTML("window.opener.frmWeeklyTimesheet.action = '../TimeSheet/TS_WeeklyTimesheet.aspx?Fromwhere=Proxy&MasterTagId=3583&EmployeeID=" + m_strSessionUserID + "';" + vbCrLf)
                            Else
                                CommonFunctions.General.WriteHTML("window.opener.frmWeeklyTimesheet.action = '../TimeSheet/TS_WeeklyTimesheet.aspx?FromWhere=DT&MasterTagId=3583';" + vbCrLf)
                            End If

                            CommonFunctions.General.WriteHTML("window.opener.frmWeeklyTimesheet.submit();" + vbCrLf)

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            'End Added by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)

                            'Added by NitinC on 30 Nov 2011 for WhizibleSEM 10.0 Issue Fix 56400 (To refresh scrum activity page in timesheet module)
                        ElseIf m_strParamFromWhere = "WScrumTimeSheet" Then
                            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('TS_SCRUM_WEEKLYTIMESHEET.ASPX', 0) != -1)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            If m_strSessionUserID <> CType(Session("intUserID"), String) Then
                                CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?Fromwhere=Proxy&MasterTagId=9015&EmployeeID=" + m_strSessionUserID + "';" + vbCrLf)
                            Else
                                CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?FromWhere=DT&MasterTagId=9015';" + vbCrLf)
                            End If
                            CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.submit();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)

                            'End of Added by NitinC on 30 Nov 2011 for WhizibleSEM 10.0 Issue Fix 56400 (To refresh scrum activity page in timesheet module)

                        ElseIf m_strParamFromWhere = "DeveloperDB" Then
                            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('DEVELOPERDB.ASPX', 0) != -1)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.location.href = '../DB/DeveloperDB.aspx'" + vbCrLf)
                            CommonFunctions.General.WriteHTML("opener.location.href = opener.location.href " + vbCrLf)
                            CommonFunctions.General.WriteHTML("}")
                        ElseIf m_strParamFromWhere = "PMDashboard" Then
                            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('PMDASHBOARD.ASPX', 0) != -1)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.location.href = '../DB/PMDashboard.aspx'" + vbCrLf)
                            CommonFunctions.General.WriteHTML("opener.location.href = opener.location.href " + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                        End If
                        CommonFunctions.General.WriteHTML("}")
                        CommonFunctions.General.WriteHTML("catch(e)")
                        CommonFunctions.General.WriteHTML("{")
                        CommonFunctions.General.WriteHTML("// This condition will come if the parentpage has been closed, of changed." + vbCrLf)
                        CommonFunctions.General.WriteHTML("// Do nothing." + vbCrLf)
                        CommonFunctions.General.WriteHTML("}" + vbCrLf)
                        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                    End If
                    ''                 1 - Save & Refresh Task List :- Refresh Task List, Close
                    ''                 2 - Save & Close :- Close
                    ''                 3 - Save & Add More :- Refresh Task List				
                    If m_strRefreshDetailsWindow = "1" Or m_strRefreshDetailsWindow = "3" Then
                        ''                     Refresh the Task List
                        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
                        CommonFunctions.General.WriteHTML("var strParentPage;")
                        CommonFunctions.General.WriteHTML("try")
                        CommonFunctions.General.WriteHTML("{	")
                        CommonFunctions.General.WriteHTML("strParentPage = new String();")
                        CommonFunctions.General.WriteHTML("strParentPage = opener.location.href;")
                        CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the DailyactivityMatrix.asp, then refresh the page.")
                        CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('PM_DAILYACTIVITY.ASPX', 0) != -1)")
                        CommonFunctions.General.WriteHTML("{")
                        ''Commented and Added by Dhanashri S on 23 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
                        ''CommonFunctions.General.WriteHTML("window.opener.location.href =" & Chr(34) & "PM_DailyActivity.aspx?Mode=List&txtDate=" + m_strParamDate + Chr(34) + ";")
                        CommonFunctions.General.WriteHTML("window.opener.location.href =" & Chr(34) & "PM_DailyActivity.aspx?Mode=List&FromWhere=DA&txtDate=" + m_strParamDate + Chr(34) + ";")
                        ''End of comment and addition by Dhanashri S on 23 Aug 2016
                        CommonFunctions.General.WriteHTML("}")
                        CommonFunctions.General.WriteHTML("}")
                        CommonFunctions.General.WriteHTML("catch(e)")
                        CommonFunctions.General.WriteHTML("{")
                        CommonFunctions.General.WriteHTML("// This condition will come if the parent page has been closed, of changed.")
                        CommonFunctions.General.WriteHTML("// Do nothing.")
                        CommonFunctions.General.WriteHTML("}")
                        CommonFunctions.General.WriteHTML("</script>")
                    End If

                    If m_strRefreshDetailsWindow = "1" Or m_strRefreshDetailsWindow = "2" Then
                        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
                        CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                    End If

                    If m_strRefreshDetailsWindow = "3" Then
                        '---------------------------
                        'Commented by Prasanna on 23rd Feb and added new line
                        'm_intDailyActivityID = 0
                        'Modified by VivekP On 16 Jun 2005 For WhizibleSem SP3
                        m_strParamDailyActivityID = "0"
                        'm_strParamDailyActivityID = "0&FromTimesheet=CreateTask"
                        'End Of Modification by VivekP On 16 Jun 2005
                        '----------------------------------------
                    End If
                End If
                ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

                HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmAdvancedTimesheet'", "'Advanced_Timesheet.aspx'", "'../AdvancedTimesheet/Advanced_Timesheet.aspx?Filter=1&FromWhere=DA'", True))

                ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                'End If
        End Select
    End Sub

    Private Sub DrawEntryFormForDailyActivity()
        '=====================================================================
        ' Procedure Name        : DrawEntryFormForDailyActivity()	
        ' Purpose               : To plot the entry form for daily activity.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 19, 2004
        ' Revisions             :
        '=====================================================================

        Dim drCheckSubTaskType, drTaskType, drDailyActivity, drProject As IDataReader
        Dim strSQLQuery As String = ""

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        Dim strHTML As String

        Dim drResourceLevelTaskCompletion As IDataReader

        '------------------------------------------------------------------------------------------------
        'Added PRASANNA 21-Feb-2004
        ' If the Total hours have been exceeded, then display the previously entered details.

        'Commented by SandipL on 24 April 2007 for SEM SP8 regression testing IssueID 13048
        'Code transfered to sun initializeEntryFormProject()

        'If m_blnExceeded24Hours = True Then

        'ElseIf m_strParamMode = "Edit" Then
        '    ' Else if strMode is "Edit", then display the selected daily acitivity record's details.

        '    ' Query to select the selected daily activity.
        '    drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity " & m_strParamDailyActivityID, MyBase.UseSQL)

        '    If drDailyActivity.Read Then


        '        ' Assign the values to the variables.
        '        m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)
        '        m_strTaskInfo = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskInfo"), "0")), String)
        '        m_strTaskType = Left(Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskInfo"), "0")), String)), 1)
        '        m_strDuration = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Duration"), "0")), String))
        '        m_strDuration = FormatNumber(m_strDuration, 2)
        '        m_strDescription = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Description"), "0")), String))
        '        m_blnTaskComplete = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsTaskCompleteForTasks"), "0")), Boolean)
        '        m_blnIsDurationChange = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsDurationChange"), "0")), Boolean)
        '        m_strTaskTypeID = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskTypeID"), "0")), String))
        '        m_strSubTaskTypeID = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("SubTaskTypeID"), "0")), String))
        '        If m_strTaskTypeID = "" Then
        '            m_strTaskTypeID = "0"
        '        End If
        '        If m_strSubTaskTypeID = "" Then
        '            m_strSubTaskTypeID = "0"
        '        End If
        '        'Start-AUJ-22Jan2007
        '        m_strDAType = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("DAType"), "N")), String))
        '        'End-AUJ-22Jan2007
        '        'Modified By VidyaJ - DA Performance Issue - IssueID -89
        '        'Get Following info for select project from usp_Sel_tbl_PM_DailyActivity sp itself instead of firing seperate queries
        '        m_blnEnforceConstraints = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("EnforceConstraints"), "0")), Boolean)
        '        m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drDailyActivity("ResourceLevelTaskCompletion")), False, drDailyActivity("ResourceLevelTaskCompletion")), Boolean)
        '        m_blnGlobalProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("GlobalProject"), "0"), Boolean)
        '        'End Of Modifications


        '        ' Get the Task Type name.				
        '        drTaskType = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_TaskTypes " + m_strTaskTypeID, MyBase.UseSQL)
        '        If drTaskType.Read Then
        '            m_strTaskTypeName = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), "0")), String)
        '        End If
        '        CommonFunction.Data.DisposeDataReader(drTaskType)



        '        ' Initialize the Previous Hours value to the current value in the Duration field.
        '        CommonFunctions.General.WriteHTML("<script LANGUAGE='JavaScript'>" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("dblPreviousHours = " + Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Duration"), "0")), String)) + ";" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("if(dblPreviousHours == """") { " + vbCrLf)
        '        CommonFunctions.General.WriteHTML("dblPreviousHours = 0;" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("}" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("else {" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("dblPreviousHours = dblPreviousHours - 0" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("}" + vbCrLf)
        '        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(drDailyActivity)

        '    ' Initialize all the values.
        'Else

        '    m_strDuration = ""
        '    m_strDescription = ""
        '    m_blnTaskComplete = False
        '    m_blnIsDurationChange = False

        '    'Added By PrasannaP on 18th May 2004 
        '    m_blnProjectBackdateEntry = False
        '    m_intOvertime = 0
        '    'End Addition


        '    ' If no project is selected, then...
        '    If m_strProjectID = "0" Then

        '        ' Get the project for which an activity was filled last. Select the project.			
        '        strSQL.Remove(0, strSQL.ToString.Length)
        '        'strSQL = "EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'"
        '        strSQL.Append("EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'")

        '        drDailyActivity = CommonFunctions.Data.GetDataReader(strSQL.ToString, MyBase.UseSQL)

        '        ' If Entry found, then select that particular Project, and that particular Task Type.
        '        If drDailyActivity.Read Then
        '            m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)
        '            m_strTaskType = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "0")), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drDailyActivity)
        '    End If

        '    '##### Added By AmitD on 27 Oct 2004
        '    'Sets the first project which is not on hold.
        '    If InStr(1, m_strProjectsOnHold, "," + m_strProjectID + ",", CompareMethod.Text) <> 0 Then
        '        m_strProjectID = m_strFirstNotOnHoldProject
        '    End If
        '    '##### End Addition


        '    ' If still no project is selected, then...
        '    If m_strProjectID = "0" Then
        '        ' Get the list of projects assigned to the user.		
        '        'Code Commented by DipaliS 5 Nov 2004
        '        'Purpose : IssueID 13754
        '        'drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " + m_strSessionUserID, MyBase.UseSQL)
        '        'Code Added by DipaliS 5 Nov 2004
        '        'Purpose : IssueID 13754
        '        drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " + m_strSessionUserID + ",NULL,'" & m_strProjectFilters & "'", MyBase.UseSQL)
        '        'End addition by DipaliS
        '        ' Select the first project by default.				
        '        If drProject.Read Then
        '            m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0")), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drProject)
        '    End If
        '    ' End Modification.	

        'End If

        'End commenting by SandipL on 24 April 2007
        'Added By Santosh Pawar on 21 Oct 2004 
        If m_strProjectID <> "" Then
            strSQL.Remove(0, strSQL.ToString.Length)
            'strSQL = "usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_strProjectID
            strSQL.Append("usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_strProjectID)
            drResourceLevelTaskCompletion = CommonFunction.Data.GetDataReader(strSQL.ToString, True)

            strSQL.Remove(0, strSQL.ToString.Length)
            strSQL.Append("")
            If drResourceLevelTaskCompletion.Read Then
                m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), False, drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), Boolean)
            Else
                m_blnResourceLevelTaskCompletion = True
            End If
            CommonFunctions.Data.DisposeDataReader(drResourceLevelTaskCompletion)
            Dim StrActvityLevelDAEntryQuery As String
            StrActvityLevelDAEntryQuery = " EXEC usp_Sel_AllowActivityLevelDAEntry " & m_strProjectID
            Dim iDAReader As IDataReader
            iDAReader = CommonFunction.Data.GetDataReader(StrActvityLevelDAEntryQuery, MyBase.UseSQL)
            While iDAReader.Read
                blnAllowActivityLevelDAEntry = CType(CommonFunction.Data.CheckIsDBNull(iDAReader("AllowActivityLevelDA"), "0"), Boolean)
                m_blnHaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(iDAReader("HaveSubTaskTypes"), "0"), Boolean)
            End While
            CommonFunction.Data.DisposeDataReader(iDAReader)
        End If
        'Addition Complete


        ' Generate the query to retrieve the available task types for the particular project, and the options selected by the user.
        If m_strProjectID <> "0" And m_strTaskType = "0" Then

            ' Build the query according to the option selected.
            strSQL.Remove(0, strSQL.ToString.Length)
            strSQL.Append("usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " + m_strProjectID + "," + m_strSessionUserID)
            strSQL.Append(",1,1,1,1, NULL, NULL, NULL, NULL,1")
            drTaskType = CommonFunctions.Data.GetDataReader(strSQL.ToString, MyBase.UseSQL)

            ' Find out what type of tasks are avaliable for that project.
            If drTaskType.Read Then
                m_strTaskType = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("WhichTask"), "0")), String)
                ' If no tasks are assigned to the project, then show all the tasks.
            Else
                m_strTaskType = PROJECT_SPECIFIC_TASKS
            End If
            CommonFunctions.Data.DisposeDataReader(drTaskType)
        End If
        '---------------------------------------------------------------------------------

        strHTML = ""
        If m_blnGetDeveloperDBDate = True And m_strStartDate <> "" And m_strEndDate <> "" Then
            'Modified by PrasannaP on 7th June 2004
            If Not (DateDiff(DateInterval.Day, Date.Parse(m_strParamDate), Date.Parse(m_strEndDate)) >= 0 And DateDiff(DateInterval.Day, Date.Parse(m_strParamDate), Date.Parse(m_strStartDate)) <= 0) Then
                strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , m_strStartDate, , "DA", , , , , True, , True)
            Else
                strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "DA", , , , , True, , True)
            End If
            m_blnGetDeveloperDBDate = False
            'End Modification.
        Else
            'If m_strParamMode <> "Edit" Then
            strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "DA", , , , , True, , True)
            'Else
            'strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "DA", , , , True, True, , True)
            'End If
        End If

        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
        Dim IsHolidayOrLeave As Boolean
        IsHolidayOrLeave = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + m_strSessionUserID.ToString + ",'" + m_strParamDate.ToString + "'", True), "0"), "0"))
        strHTML = strHTML + "<TD id='tdHolidayComment' name='tdHolidayComment'>"
        If IsHolidayOrLeave = True Then
            strHTML = strHTML + CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("NOTE"), "").ToString
        End If
        strHTML = strHTML + "</TD>"
        '--- End addition Purvaj

        With cObjSectionTitle
            strHTML = .GetSectionTitle(MyBase.GetResourceString("SECTION_TITLE") + " " + strHTML, "", "", , , , , , , , , , False, False)
        End With
        CommonFunctions.General.WriteHTML(strHTML)
        'Main Div
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:430px'>")

        strHTML = ""
        strHTML = "<DIV id=DivTaksList style='Overflow:auto;width=100%;Height:300'>"
        strHTML = "<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=" + m_strTREven + ">"

        strHTML = strHTML + "<TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>"
        strHTML = strHTML + "<TD align=left colspan=2>"

        If m_blnProjectEditable = False Then m_strStringToBeInserted = " disabled "


        ' To disable the Project combo box in case of Editing a Completed task.		
        If m_strParamMode = "Edit" Then
            'Added By VidyaJ - For IssueID 426 - SP4  
            'Modified by SandipL on 23 April 2007 for SP8 IssueID
            '            strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_New " & m_strSessionUserID & ",null," & m_strProjectID, , m_strProjectID, " disabled ", , True, , True)
            strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_New " & m_strSessionUserID & ",null," & m_strProjectID, , m_strProjectID, " disabled ", , True, , True)
            ' End modification by SandipL
            'Code commented by DipaliS 4 Nov 2004
            'Purpose : For Issue 13754
            'strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'", , m_strProjectID, " disabled ", , True, , True)
            'Code Added by dipaliS 4 Nov 2004
            'Purpose : For Issue 13754
            'Commented By VidyaJ - For IssueID - 426 - SP4
            ' strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'" & ",'" & m_strProjectFilters & "'", , m_strProjectID, " disabled ", , True, , True)
            'End addition by DipaliS
        Else
            'strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA " & m_strSessionUserID, , m_strProjectID, m_strStringToBeInserted + " Langugage=JavaScript OnChange=ProjectComboSubmit('" & m_strParamMode & "')", , True, , True)
            'Code commented by DipaliS 4 Nov 2004
            'Purpose : For Issue 13754
            'strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'", , m_strProjectID, m_strStringToBeInserted + " Langugage=JavaScript OnChange=ProjectComboSubmit('" & m_strParamMode & "')", , True, , True)
            'Code Added by dipaliS 4 Nov 2004
            'Purpose : For Issue 13754
            '///////////////////////////////////////////////////////

            '///////////////////////////////////////////////////////
            strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'" & ",'" & m_strProjectFilters & "',0", , m_strProjectID, m_strStringToBeInserted + " Langugage=JavaScript OnChange=ProjectComboSubmit('" & m_strParamMode & "')", , True, , True)
            If m_strStringToBeInserted.Trim = "" Then
                strHTML = strHTML + "<a Href='javascript:SelectProject(this)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='Click here to select project...'></a>"
            End If
            'End addition by DipaliS
        End If
        strHTML = strHTML + "</TD>"
        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue 
        ' TD is not required for hidden fields 
        'Added by MrugajaB on 19th Sept 2006 for whiziblesem SP7 issue ID.6197
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
        'strHTML = strHTML + "<TD align='left'>"

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML = strHTML + CommonFunctions.HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'strHTML = strHTML + "</TD></TR>"
        strHTML = strHTML + "</TR>"

        'End Addition
        'End Modification By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue

        'Added by PrasannaP, 18th May 2004
        If m_strParamMode <> "Edit" Then
            'Code Commented by DipaliS 5 Nov 2004
            'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'"
            'Code Added by DipaliS 5 Nov 2004
            'Purpose : IssueID 13754
            strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & m_strParamDate & "'" & ",'" & m_strProjectFilters & "'"
            'End addition by DipaliS
            drProject = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            strSQLQuery = ""
            m_blnProjectFound = False
            If drProject.Read Then
                m_intFirstProject = CType(CommonFunction.Data.CheckIsDBNull(drProject("ProjectID"), "0"), Integer)

                Do
                    If CInt(drProject("ProjectID")) = CInt(m_strProjectID) Then
                        m_blnProjectFound = True
                        Exit Do
                    End If
                Loop While drProject.Read

                If m_blnProjectFound = False Then
                    m_strProjectID = m_intFirstProject.ToString()
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drProject)
        End If
        'End Of Addition

        ' Check whether Task Types are applicable for the current project.
        ' Modified By NitinVS on 15 Apr 2005 for WhizibleSEM SP3 
        m_blnTaskTypesApplicable = True



        'Modified By VidyaJ - DA Performance Issue - IssueID -89
        'No Need of firing this query as GlobalProject can be initialized above 

        'drCheckSubTaskType = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Project " & m_strProjectID, MyBase.UseSQL)
        'If drCheckSubTaskType.Read Then
        '    '==============================================================
        '    'Modified By        :   HiteshS on 28th Jan.2005
        '    'IssueID            :   15658
        '    'Description        :   Code commented to Hide the Task Type combo.
        '    '==============================================================
        '    'm_blnTaskTypesApplicable = CType(CommonFunctions.Data.CheckIsDBNull(drCheckSubTaskType("HaveSubTaskTypes"), "0"), Boolean)
        '    '==============================================================
        '    'Midification Ends  :   HiteshS on 28th Jan.2005
        '    '==============================================================

        '    m_blnHaveSubTaskTypes = CType(CommonFunctions.Data.CheckIsDBNull(drCheckSubTaskType("HaveSubTaskTypes"), "0"), Boolean)

        '    ' End Modification By NitinVS on 15 Apr 2005 for  WhizibleSEM SP3 

        '    m_blnGlobalProject = CType(CommonFunctions.Data.CheckIsDBNull(drCheckSubTaskType("GlobalProject"), "0"), Boolean)

        If CStr(EXPIRY_OF_TASK) <> INVALID_ENTRY Then
            Dim drBackDatedConf As IDataReader
            drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_strProjectID, MyBase.UseSQL)

            If drBackDatedConf.Read() Then
                'Entry exists for the current project and current user in configuration table
                If CType(drBackDatedConf("IsBackDating"), Boolean) = False Then
                    m_blnProjectBackdateEntry = False
                Else
                    m_blnProjectBackdateEntry = True
                End If
            Else
                'Entry Doesnot exist for the current project and current user in configuration table
                m_blnProjectBackdateEntry = False
            End If
            CommonFunction.Data.DisposeDataReader(drBackDatedConf)
        Else
            m_blnProjectBackdateEntry = True
        End If

        If CStr(EXPIRY_OF_TASK_FORWARD) <> INVALID_ENTRY Then
            Dim drBackDatedConf As IDataReader
            drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_strProjectID, MyBase.UseSQL)

            If drBackDatedConf.Read() Then
                'Entry exists for the current project and current user in configuration table
                If CType(drBackDatedConf("IsForwardDating"), Boolean) = False Then
                    m_blnProjectFwddateEntry = False
                Else
                    m_blnProjectFwddateEntry = True
                End If
            Else
                'Entry Doesnot exist for the current project and current user in configuration table
                m_blnProjectFwddateEntry = False
            End If
            CommonFunction.Data.DisposeDataReader(drBackDatedConf)
        Else
            m_blnProjectFwddateEntry = True
        End If

        ' End If
        'End Of Modifications- DA Performance Issue - IssueID -89

        CommonFunctions.Data.DisposeDataReader(drCheckSubTaskType)

        'Added by Prasanna on 19th Feb 2004
        If m_strTaskTypeID Is Nothing Or m_strTaskTypeID = "" Then
            m_strTaskTypeID = ""
        End If

        If m_blnTaskTypesApplicable Then
            ' If TakTypeID is not mentioned, then... (In Edit mode this value will be set above.)
            If m_strTaskTypeID = "" Then

                ' If the page is refreshed on account of change in TaskType, or project or any other reason, 
                ' retrieve the task type from the form contents posted.
                If MyBase.GetFormValue("cboProject") <> "" Then

                    ' If some task type had been selected, then... 
                    If MyBase.GetFormValue("cboTaskType") <> "" Then

                        ' Retrieve the Task Type ID.
                        m_strTaskTypeID = FixString(MyBase.GetFormValue("cboTaskType"), 0, False, True)


                        ' Retrieve the corresponding task type name.
                        drTaskType = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_TaskTypes " & m_strTaskTypeID, MyBase.UseSQL)
                        If drTaskType.Read Then
                            m_strTaskTypeName = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), "0")), String)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drTaskType)
                    Else
                        m_strTaskTypeID = "0"
                    End If

                Else ' On entering the page for the first time...

                    ' Get the default task type for the project.
                    drTaskType = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project_TaskTypes " & m_strProjectID & ", 1", MyBase.UseSQL)
                    If drTaskType.Read Then
                        m_strTaskTypeID = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskTypeID"), "0")), String)
                        m_strTaskTypeName = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), "0")), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drTaskType)

                    ' If no default Task Type is found then select the first Task Type in the list.
                    If m_strTaskTypeID = "" Then

                        drTaskType = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Project_TaskTypes " & m_strProjectID, MyBase.UseSQL)
                        If drTaskType.Read Then
                            m_strTaskTypeID = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskTypeID"), "0")), String)
                            m_strTaskTypeName = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), "0")), String)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drTaskType)

                        ' If still no Task Type is found then set it to 0.
                        If m_strTaskTypeID = "" Then
                            m_strTaskTypeID = "0"
                        End If
                    End If
                End If
            End If
        End If

        CommonFunctions.General.WriteHTML(strHTML)

        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD></TD>")
        CommonFunctions.General.WriteHTML("<TD colspan=2>")
        'trupti
        Dim strquery1 As String
        Dim strJoiningdate As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strquery1 = "select joiningdate from tbl_pm_employee where employeeid=" + m_strSessionUserID.ToString
        strquery1 = "usp_sel_tbl_pm_employee_joiningdate " + m_strSessionUserID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        strJoiningdate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strquery1, True), ""), String)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("hdnJoiningdate", "hdnJoiningdate", , , , CDate(strJoiningdate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'end
        'Added By PrasannaP on 18th May 2004
        If m_blnProjectBackdateEntry = True Then
            CommonFunctions.General.WriteHTML("<INPUT type=Hidden VALUE='Yes' name=ProjectBackdateEntry id=ProjectBackdateEntry>")
        Else
            CommonFunctions.General.WriteHTML("<INPUT type=Hidden VALUE='No' name=ProjectBackdateEntry id=ProjectBackdateEntry>")
        End If

        If m_blnProjectFwddateEntry = True Then
            CommonFunctions.General.WriteHTML("<INPUT type=Hidden VALUE='Yes' name=ProjectFwddateEntry id=ProjectFwddateEntry>")
        Else
            CommonFunctions.General.WriteHTML("<INPUT type=Hidden VALUE='No' name=ProjectFwddateEntry id=ProjectFwddateEntry>")
        End If

        'End If

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optGeneralTasks", , False, GENERAL_TASKS, False, m_strStringToBeInserted + " onClick='Task_OnClick()' ", True) & MyBase.GetResourceString("GENERAL_TASK") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optProjectTasks", , False, PROJECT_SPECIFIC_TASKS, False, m_strStringToBeInserted + " onClick='Task_OnClick()' ", True) & MyBase.GetResourceString("MPP_TASKS") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optAssignedTasks", , False, ASSIGNED_TASKS, False, m_strStringToBeInserted + " onClick='Task_OnClick()' ", True) & MyBase.GetResourceString("ASSIGNED_TASKS") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , False, DEFECTS_ASSIGNED, False, m_strStringToBeInserted + " onClick='Task_OnClick()' ", True) & MyBase.GetResourceString("ISSUES_ASSIGNED"))
        CommonFunctions.General.WriteHTML("</TD></TR>")

        'strSQL = "usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " & m_strProjectID & "," & m_strSessionUserID
        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("usp_Sel_tbl_PM_ProjectTasks_ForDA " & m_strProjectID & "," & m_strSessionUserID)
        CommonFunctions.General.WriteHTML("<SCRIPT Language=JavaScript>" & vbCrLf)

        Select Case m_strTaskType
            Case DEFECTS_ASSIGNED
                strSQL.Append(",1,NULL,NULL,NULL")
                CommonFunctions.General.WriteHTML("objoptDefectTasks = GetObjectReference('DA', 'optDefectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptDefectTasks.checked = true;" & vbCrLf)
            Case GENERAL_TASKS
                strSQL.Append(",NULL,1,NULL,NULL")
                CommonFunctions.General.WriteHTML("objoptGeneralTasks = GetObjectReference('DA', 'optGeneralTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptGeneralTasks.checked = true;" & vbCrLf)
            Case PROJECT_SPECIFIC_TASKS
                strSQL.Append(",NULL,NULL,1,NULL")
                strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_ForMPPTasks " + m_strProjectID + ", " + m_strSessionUserID + ", '" + Date.Parse(m_strParamDate).ToString("MM/dd/yyyy") + "', NULL,1,1,"
                m_blnEnforceConstraints = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select dbo.udf_EnforceConstraints(" & m_strProjectID & ")", MyBase.UseSQL), "0"), Boolean)
                CommonFunctions.General.WriteHTML("objoptProjectTasks = GetObjectReference('DA', 'optProjectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptProjectTasks.checked = true;" & vbCrLf)
            Case ASSIGNED_TASKS
                strSQL.Append(",NULL,NULL,NULL,1")
                CommonFunctions.General.WriteHTML("objoptAssignedTasks = GetObjectReference('DA', 'optAssignedTasks'); " & vbCrLf)
                CommonFunctions.General.WriteHTML(" if (objoptAssignedTasks != null ) objoptAssignedTasks.checked = true;" & vbCrLf)
            Case Else
                strSQL.Append(",NULL,NULL,1,NULL")
                CommonFunctions.General.WriteHTML("objoptProjectTasks = GetObjectReference('DA', 'optProjectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptProjectTasks.checked = true;" & vbCrLf)
        End Select

        CommonFunctions.General.WriteHTML("</SCRIPT>" & vbCrLf)
        strSQL.Append(",NULL,NULL,NULL,1")

        ' Modified By NitinVS on 25 Apr 2005 for WhizibleSEM SP3 
        ' The Task Type is not to be shown on DA Entry Page. Made It Hidden 

        ' If Task Types are applicable for the current project, then...
        If m_blnTaskTypesApplicable Then
            '    If m_blnGlobalProject Then
            'CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("TASK_TYPE") & "</TD>")
            'CommonFunctions.General.WriteHTML("<TD colspan=2 align=Left>")

            If m_blnProjectEditable = False Then
                Dim strTaskType As String

                Dim iReader As IDataReader
                iReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Project_TaskTypes " & m_strProjectID, MyBase.UseSQL)
                While iReader.Read
                    strTaskType = CType(CommonFunction.Data.CheckIsDBNull(iReader("TaskTypeID"), ""), String)
                    If strTaskType = m_strTaskTypeID Then
                        strTaskType = CType(CommonFunction.Data.CheckIsDBNull(iReader("TaskType"), ""), String)
                        Exit While
                    End If
                End While

                CommonFunction.Data.DisposeDataReader(iReader)
                If m_strTaskTypeID = "0" Then
                    strTaskType = ""
                End If
                'Commented by MrugajaB on 28th June 2005
                'strTasktype was getting passed as text parameter to sp usp_Ins_tbl_pm_dailyactivity
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("cboTaskType", "cboTaskType", , 300, , strTaskType, , , True, True, IsHidden:=True))
                'Modified by MrugajaB on 28th June 2005 
                'Modified By VidyaJ - DA Performance Issue - 89 (SP4)
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("cboTaskType", "cboTaskType", , 300, , m_strTaskTypeID, , , True, True, IsHidden:=True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'End Addition


                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes " & m_strProjectID, 300, m_strTaskTypeID, m_strStringToBeInserted + " style='display:none' Language=JavaScript OnChange='TaskType_OnChange()'", True, True))

            Else

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes " & m_strProjectID, 300, m_strTaskTypeID, " style='display:none' ", True, True, ))

            End If
            CommonFunctions.General.WriteHTML("</TD></TR>")

            'Added By PrasannaP on 14th May 2004
            'Create Client Side array to filter Sub Task Types

            Dim drSubTaskTypes As IDataReader
            Dim iRowLoop As Integer = 0
            Dim intTotalCount As Integer
            Dim strSubCat As String = ""

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''drSubTaskTypes = CommonFunction.Data.GetDataReader("SELECT SubTaskTypeID, SubTaskTYpe FROM tbl_PM_SubTaskTypes", MyBase.UseSQL)
            drSubTaskTypes = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_SubTaskTypes_SubTaskTypeID_SubTaskTYpe", MyBase.UseSQL)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Response.Write(" <SCRIPT LANGUAGE=Javascript>	" & vbCrLf)

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''intTotalCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select Count(*) as Cnt FROM tbl_PM_SubTaskTypes", MyBase.UseSQL), "0"), Integer)
            intTotalCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_SubTaskTypes_Count", MyBase.UseSQL), "0"), Integer)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Response.Write(" var arrSubTaskTypes = new Array(" & intTotalCount & ");" & vbCrLf)
            While drSubTaskTypes.Read()
                strSubCat = ":" & CType(CommonFunction.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), ""), String) & "," & CType(CommonFunction.Data.CheckIsDBNull(drSubTaskTypes("SubTaskType"), ""), String)
                Response.Write("arrSubTaskTypes[" & iRowLoop & "]=" & Chr(34) & strSubCat & Chr(34) & ";" & vbCrLf)
                iRowLoop += 1
            End While

            Response.Write("</SCRIPT>")

            ' drSubTaskTypes.Close()
            CommonFunction.Data.DisposeDataReader(drSubTaskTypes)
            'End Addition

        End If

        'End Comment By NitinVS on 25 Apr 2005 for WhizibleSEM SP3 

        ' Modified By NitinVS on 21 Apr 2005 for WhizibleSEM SP3 
        ' To select the sub task on task change.     
        If m_strProjectID <> "" Then
            Dim strSubTaskType As String
            Dim DrSubTaskType As IDataReader
            Dim strSubTask As String
            Dim strTaskTypeID As String
            Dim strSubTaskTypeID As String
            Dim strsubtaskTypeName As String

            strSubTaskType = "usp_sel_ProjectTaskType_SubTaskType_For_DA " + m_strProjectID
            DrSubTaskType = CommonFunction.Data.GetDataReader(strSubTaskType, MyBase.UseSQL)
            strSubTask = " <SCRIPT> " + vbCrLf
            strSubTask += "var arrsubtask = new Array();" + vbCrLf

            While DrSubTaskType.Read

                strTaskTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrSubTaskType("TaskTypeID"), ""), "")
                strSubTaskTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrSubTaskType("SubTaskTypeID"), ""), "")
                strsubtaskTypeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrSubTaskType("SubTaskType"), ""), "")
                strSubTask += " arrsubtask.push( new Array( " + """" + strTaskTypeID + """," + """" + strSubTaskTypeID + """," + """" + strsubtaskTypeName + """) )" + vbCrLf

            End While
            strSubTask += " </SCRIPT> " + vbCrLf
            CommonFunction.General.WriteHTML(strSubTask)
            'Modified By VidyaJ - DA Performance Issue - IssueID - 89 (SP4)
            CommonFunction.Data.DisposeDataReader(DrSubTaskType)
        End If



        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("SELECT_TASK") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left colspan=2>")

        strSQL.Append(", NULL, '")
        If strSQLQuery <> "" Then
            strSQLQuery = strSQLQuery + " '"
        End If
        If Not m_blnIncludeCompletedTasks Then
            strSQL.Append("AND IsTaskComplete = 0 ")
            If strSQLQuery <> "" Then
                strSQLQuery = strSQLQuery + "AND IsTaskComplete = 0 "
            End If
        End If

        'Commented By PrasannaP
        'If m_blnTaskTypesApplicable Then
        '    If m_strTaskTypeID <> "0" Then
        '        strSQL = strSQL & "AND ModuleName = """ & Replace(m_strTaskTypeName, """", """""") & """ "
        '        If strSQLQuery <> "" Then
        '            strSQLQuery = strSQLQuery & "AND ModuleName = """ & Replace(m_strTaskTypeName, """", """""") & """ "
        '        End If
        '    End If
        'End If

        'Commented By NitinVS on 25 Apr 2005 for WhizibleSEM SP3

        'Task Type Is Not to be shown in DA Entry Page.

        ''Added By PrasannaP on 14th May 2004
        'If m_strTaskTypeID <> "0" Then
        '    If m_strTaskType = ASSIGNED_TASKS And m_strTaskTypeID <> "" Then
        '        strSQL = strSQL & "AND TaskTypeID = " & m_strTaskTypeID & " "
        '    End If
        'End If
        ''Addition Ends

        'End comment By NitinVS on 25 Apr 2005 for WhizibleSEM SP3 

        strSQL.Append("ORDER BY A.TaskName'")
        If strSQLQuery <> "" Then
            strSQLQuery = strSQLQuery & "ORDER BY A.TaskName'"
        End If

        'Added By PrasannaP on 14 May 2004
        strSQL.Append(", NULL, '" & m_strParamDate & "'")
        'Addition Ends

        'Added By JayavantK on 06 Oct 2004
        'To Add the Role level access to the General Tasks.
        If m_strTaskType = GENERAL_TASKS Then
            'Added by DipaliS 6 Nov 2004
            'Purpose : Issue 13831
            Dim lngProjectRoleID As Long = 0
            Dim strQuery As String = ""

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strQuery = "SELECT Role FROM tbl_PM_ProjectEmployeeRole WHERE ProjectID=" & m_strProjectID.ToString()
            'strQuery = strQuery & " AND EmployeeID=" & m_strSessionUserID.ToString()

            strQuery = "usp_sel_tbl_PM_ProjectEmployeeRole_Role " & m_strProjectID.ToString() & "," & m_strSessionUserID.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            lngProjectRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)

            If lngProjectRoleID = 0 Then
                lngProjectRoleID = CType(m_strSessionPostID, Integer)
            End If
            'End Addition by DipaliS

            'Code Commented by DipaliS 6 Nov 2004
            'strSQL = strSQL & ", " & m_strSessionPostID
            'Code Added by DipaliS 6 Nov 2004
            'Purpose : Issue 13831
            strSQL.Append(", " & lngProjectRoleID.ToString)
            'Added by SandipL for SP8 Regression Testing
            If m_strParamMode = "Edit" Then
                strSQL.Append(",NULL, " & m_strParamDailyActivityID)
            End If
            'End addition by SandipL
            'End addition by DipaliS

            ' Task Type is Not To Be Shown in DA Entry Page.
            ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request

            'If m_strTaskTypeID = "0" Then
            '    strSQL = strSQL & ", " & "0"
            'End If
        Else
            'If m_strTaskTypeID = "0" Then
            '    strSQL = strSQL & ", Null , " & "0"
            'Else
            '    strSQL = strSQL & ", Null ,  " + m_strTaskTypeID
            'End If
            ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
        End If
        'Addition Ends


        ' Modified By NitinVS on 15 Apr 2005 for Da Wincey Customization Request
        'Task Type is Not To Be Shown in DA Entry Page.

        'If m_strTaskTypeID <> "" Then
        'Modified Function By PrasannaP TaskClick() 14 May 2004
        If m_blnProjectEditable Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTask", strSQL.ToString, 300, m_strTaskInfo, m_strStringToBeInserted + "Language=JavaScript OnChange=""TaskClick('" & m_blnTaskTypesApplicable & "','" & m_strSubTaskTypeID & "')""", True, True))
            CommonFunctions.General.WriteHTML("<a Href='javascript:SelectTask(""" & m_strTaskType & """)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" & MyBase.GetResourceString("TOOLTIP_CLICK_HERE") & "'></a>")
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTask", strSQL.ToString, 300, m_strTaskInfo, m_strStringToBeInserted + "Language=JavaScript OnChange=""TaskClick('" & m_blnTaskTypesApplicable & "','" & m_strSubTaskTypeID & "')""", False, True))
        End If
        strSQL.Remove(0, strSQL.ToString.Length)
        'End Modification
        If strSQLQuery <> "" Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboMPPTaskConstraints", strSQLQuery, 300, m_strTaskInfo, " style='display:none' ", True, True))
        End If

        Response.Write("<input type='hidden' id='txtIsDurationChange' name='txtIsDurationChange' value=""")
        If m_blnIsDurationChange = True Then Response.Write("1") Else Response.Write("0")
        Response.Write(""">")
        Response.Write(" <img Border=0 src='../../images/star.gif'></TD></TR>")
        Response.Write("<TR class=" & m_strTREven & "><TD>&nbsp;</TD><TD colspan=2><LABEL ID='lblTaskName'> </LABEL></TD></TR>")

        ' Modified By NitinVS on 15 Apr 2005 for WhizibleSEM SP3 
        ' Sub Task Selection shoud be given for all cases of task creation

        'If m_blnHaveSubTaskTypes = False Then
        'Modified by PrasannaP on 21st May 2004

        ' Changed the Lable from Sub Task to Select Activity
        'CommonFunctions.General.WriteHTML("<TR Class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("SUB_TASK_TYPE") & "</TD>")


        If blnAllowActivityLevelDAEntry = True Then
            CommonFunctions.General.WriteHTML("<TR Class=" & m_strTREven & "  ><TD align=right>" & MyBase.GetResourceString("ACTIVITY") & "</TD>")
        Else
            CommonFunctions.General.WriteHTML("<TR Class=" & m_strTREven & "  style='display:none'><TD align=right>" & MyBase.GetResourceString("ACTIVITY") & "</TD>")
        End If

        'CommonFunctions.General.WriteHTML("<TD align=Left colspan=2 id=tdSubTaskType name=tdSubTaskType>")
        CommonFunctions.General.WriteHTML("<TD align=Left colspan=2 >")

        'Changed the Source to usp_sel_ProjectTaskType_SubTaskType_For_DA

        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboSubTaskType", "usp_Sel_tbl_PM_Project_SubTaskTypes " & m_strProjectID & ", " & m_strTaskTypeID, 300, m_strSubTaskTypeID, , , True, , , , ))
        'Modified By VidyaJ - For IssueID - 294 
        'Remove Sub Task Type/Activity combo from DA page
        If blnAllowActivityLevelDAEntry = True Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboSubTaskType", "usp_sel_ProjectTaskType_SubTaskType_For_DA " & m_strProjectID & ", 1 ", 300, m_strSubTaskTypeID, , , True, , , , False))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboSubTaskType", "usp_sel_ProjectTaskType_SubTaskType_For_DA " & m_strProjectID & ", 1 ", 300, m_strSubTaskTypeID, , , True, , , , True))
        End If

        'If m_blnTaskTypeMandatoryInDA = True Then
        '    CommonFunctions.General.WriteHTML("<img Border=0 src='../../images/star.gif' WIDTH=5 HEIGHT=5>")
        'End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'End Modification
        'End If
        'End If
        'Start-AUJ-22Jan2007
        If blnAcceptDATYpe = True Then
            CommonFunctions.General.WriteHTML("<tr class=" & m_strTREven & "><td></td><td colspan=2>")
            If m_strParamMode = "Edit" And m_blnTaskComplete = True Then
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeNormal", , True, "N", True, "", True) & "Normal" & "&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeOT", , False, "T", True, "", True) & "Over Time" & "&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeOS", , False, "S", True, "", True) & "Over Stay" & "&nbsp;&nbsp;&nbsp;")
            Else
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeNormal", , True, "N", False, "", True) & "Normal" & "&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeOT", , False, "T", False, "", True) & "Over Time" & "&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDAType", "optDATypeOS", , False, "S", False, "", True) & "Over Stay" & "&nbsp;&nbsp;&nbsp;")
            End If

            CommonFunctions.General.WriteHTML("</td></tr>")
            CommonFunctions.General.WriteHTML("<SCRIPT Language=JavaScript>" & vbCrLf)
            Select Case m_strDAType
                Case "N"
                    CommonFunctions.General.WriteHTML("obj = GetObjectReference('DA', 'optDATypeNormal');" & vbCrLf)
                    CommonFunctions.General.WriteHTML("obj.checked = true;" & vbCrLf)
                Case "T"
                    CommonFunctions.General.WriteHTML("obj = GetObjectReference('DA', 'optDATypeOT');" & vbCrLf)
                    CommonFunctions.General.WriteHTML("obj.checked = true;" & vbCrLf)
                Case "S"
                    CommonFunctions.General.WriteHTML("obj = GetObjectReference('DA', 'optDATypeOS');" & vbCrLf)
                    CommonFunctions.General.WriteHTML("obj.checked = true;" & vbCrLf)
            End Select
            CommonFunctions.General.WriteHTML("</SCRIPT>" & vbCrLf)
        End If
        'End-AUJ-22Jan2007
        CommonFunction.General.WriteHTML("<SCRIPT>")
        CommonFunction.General.WriteHTML("var objcboSubTaskType =  GetObjectReference('DA', 'cboSubTaskType'); " + vbCrLf)
        CommonFunction.General.WriteHTML("if (objcboSubTaskType != null) objcboSubTaskType.length =0 ;")
        CommonFunction.General.WriteHTML("</SCRIPT>")
        ' End Modification By NitinVS on 15 Apr 2005 for Empower Customization Request

        ' Changed caption "Work (hrs)" -> "Actual Work (hrs)".
        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("ACTUAL_WORK") & "</TD><TD colspan=2 align=left>")
        ' End Modification.
        If m_strParamMode = "Edit" And m_blnTaskComplete = True Then
            If m_blnActualWorkHrs = True Then
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("txtHours", "usp_Sel_GetActualHrs " + CStr(m_dblMinHoursForDAEntry), 0, m_strDuration, " disabled ", True, True, , True))
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 45, 5, m_strDuration, "Right", , , , , , " disabled ", True, True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
        Else
            If m_blnActualWorkHrs = True Then
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("txtHours", "usp_Sel_GetActualHrs " + CStr(m_dblMinHoursForDAEntry), 0, m_strDuration, , True, True, , True, ))
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 45, 5, m_strDuration, "Right", , , , , , " Language=Javascript OnBlur=durationBlur() OnFocus=durationFocused() ", True, True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
        End If


        If m_strTaskType <> GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & MyBase.GetResourceString("ACTUAL_COMPLETE"))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtActualPercentComplete", "txtActualPercentComplete", , 45, 7, , "Right", , , , , , , True, True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'Commented By PrasannaP on May 15 2004.
            'Condition Added By Santosh Pawar on 21 Oct 2004 
            If m_blnResourceLevelTaskCompletion = True Then
                CommonFunctions.General.WriteHTML("    &nbsp;&nbsp;&nbsp;" & MyBase.GetResourceString("IS_TASK_COMPLETE") & " <Input Type=CheckBox Name=chkCompleteTask id=chkCompleteTask>")
            End If
            'End of Addition
            'End Addition.
        End If

        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD></TD><TD colspan=2><DIV ID=DivCode></DIV></TD></TR>")
        CommonFunctions.General.WriteHTML("</TD></TR>")
        ''Commented And Added By Vaijat K ON 18/11/2015
        ''CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD valign=top align=right>" & MyBase.GetResourceString("DESCRIPTION") & "</td>")
        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD valign=top align=right style='vertical-align:top;padding-top:10px'>" & MyBase.GetResourceString("DESCRIPTION") & "</td>")
        CommonFunctions.General.WriteHTML("<TD colspan=2 valign=top align=left>")
        '"<TEXTAREA class=clsTextArea id=txtDescription name=txtDescription rows=3 style='width:545'>" & Server.HtmlEncode(Trim(m_strDescription)) & "</TEXTAREA> <img Border=0 src='../../images/star.gif' WIDTH=5 HEIGHT=5>")
        'Modified By ShraddhaM on 27 July 2006
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("DESCRIPTION"), , , "DA", , , 545, 80, , Server.HtmlEncode(Trim(m_strDescription)), , , , , , , , True, , , , , , , "Soft", ))

        'Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("DESCRIPTION"), , , "DA", , , 545, 80, , Server.HtmlEncode(Trim(m_strDescription)), , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", MyBase.GetResourceString("DESCRIPTION"), , , "DA", , , 545, 80, , Trim(m_strDescription), , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
        'End Of Commented By Chakshuta H on 13th-June-2017 Purpose::To remove HTML Encoding

        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<SCRIPT LANGUAGE=Javascript>" & vbCrLf)
        ''Modified by PrasannaP 14 May 2004
        'CommonFunctions.General.WriteHTML("TaskClick('" & m_blnTaskTypesApplicable & "','" & m_strSubTaskTypeID & "');" & vbCrLf)
        ''End Modification

        'Commented by PrasannaP on 15th May 2004

        If m_blnExceeded24Hours = True And m_strTaskType <> GENERAL_TASKS And m_blnResourceLevelTaskCompletion Then
            CommonFunctions.General.WriteHTML(" objchkCompleteTask = GetObjectReference('DA', 'chkCompleteTask'); " & vbCrLf)
            If m_blnTaskComplete = True Then
                CommonFunctions.General.WriteHTML("	objchkCompleteTask.checked = true;" & vbCrLf)
            Else
                CommonFunctions.General.WriteHTML("	objchkCompleteTask.checked = false;" & vbCrLf)
            End If
        End If

        'End Addition

        CommonFunctions.General.WriteHTML("</SCRIPT>" & vbCrLf)

        cObjSectionTitle = Nothing

    End Sub
    Private Sub InitializeEntryFormProject()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To Initialize Project related Data for DA entry page in Edit mode or add new mode
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandipL
        ' Created               : 24 April 2007
        ' Revisions             :
        '=====================================================================
        Dim drCheckSubTaskType, drTaskType, drDailyActivity, drProject As IDataReader
        If m_blnExceeded24Hours = True Then
        ElseIf m_strParamMode = "Edit" Then
            ' Else if strMode is "Edit", then display the selected daily acitivity record's details.

            ' Query to select the selected daily activity.
            drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity " & m_strParamDailyActivityID, MyBase.UseSQL)

            If drDailyActivity.Read Then


                ' Assign the values to the variables.
                m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)
                m_strTaskInfo = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskInfo"), "0")), String)
                m_strTaskType = Left(Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskInfo"), "0")), String)), 1)
                m_strDuration = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Duration"), "0")), String))
                m_strDuration = FormatNumber(m_strDuration, 2)
                m_strDescription = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Description"), "0")), String))
                m_blnTaskComplete = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsTaskCompleteForTasks"), "0")), Boolean)
                m_blnIsDurationChange = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsDurationChange"), "0")), Boolean)
                m_strTaskTypeID = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskTypeID"), "0")), String))
                m_strSubTaskTypeID = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("SubTaskTypeID"), "0")), String))
                If m_strTaskTypeID = "" Then
                    m_strTaskTypeID = "0"
                End If
                If m_strSubTaskTypeID = "" Then
                    m_strSubTaskTypeID = "0"
                End If
                'Start-AUJ-22Jan2007
                m_strDAType = Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("DAType"), "N")), String))
                'End-AUJ-22Jan2007
                'Modified By VidyaJ - DA Performance Issue - IssueID -89
                'Get Following info for select project from usp_Sel_tbl_PM_DailyActivity sp itself instead of firing seperate queries
                m_blnEnforceConstraints = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("EnforceConstraints"), "0")), Boolean)
                m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drDailyActivity("ResourceLevelTaskCompletion")), False, drDailyActivity("ResourceLevelTaskCompletion")), Boolean)
                m_blnGlobalProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("GlobalProject"), "0"), Boolean)
                'End Of Modifications


                ' Get the Task Type name.				
                drTaskType = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_TaskTypes " + m_strTaskTypeID, MyBase.UseSQL)
                If drTaskType.Read Then
                    m_strTaskTypeName = CType((CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), "0")), String)
                End If
                CommonFunction.Data.DisposeDataReader(drTaskType)



                ' Initialize the Previous Hours value to the current value in the Duration field.
                CommonFunctions.General.WriteHTML("<script LANGUAGE='JavaScript'>" + vbCrLf)
                CommonFunctions.General.WriteHTML("dblPreviousHours = " + Trim(CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Duration"), "0")), String)) + ";" + vbCrLf)
                CommonFunctions.General.WriteHTML("if(dblPreviousHours == """") { " + vbCrLf)
                CommonFunctions.General.WriteHTML("dblPreviousHours = 0;" + vbCrLf)
                CommonFunctions.General.WriteHTML("}" + vbCrLf)
                CommonFunctions.General.WriteHTML("else {" + vbCrLf)
                CommonFunctions.General.WriteHTML("dblPreviousHours = dblPreviousHours - 0" + vbCrLf)
                CommonFunctions.General.WriteHTML("}" + vbCrLf)
                CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            End If
            CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            ' Initialize all the values.
        Else

            m_strDuration = ""
            m_strDescription = ""
            m_blnTaskComplete = False
            m_blnIsDurationChange = False

            'Added By PrasannaP on 18th May 2004 
            m_blnProjectBackdateEntry = False
            m_intOvertime = 0
            'End Addition

            ' If no project is selected, then...
            ''Commented by PrashantSJ on 17th Sep 2009 : Purpose: for performance reason we have comment this code (las DA filled DA)
            'If m_strProjectID = "0" Then

            '    ' Get the project for which an activity was filled last. Select the project.			
            '    strSQL.Remove(0, strSQL.ToString.Length)
            '    'strSQL = "EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'"
            '    'Modified By VarunA on 4-Dec-2007 
            '    'Purpose : Changes for Project Access to middle level Role
            '    'strSQL.Append("EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'")
            '    strSQL.Append("EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "','" & m_strProjectFilters & "'")
            '    'End By VarunA on 4-Jan-2008

            '    drDailyActivity = CommonFunctions.Data.GetDataReader(strSQL.ToString, MyBase.UseSQL)

            '    ' If Entry found, then select that particular Project, and that particular Task Type.
            '    If drDailyActivity.Read Then
            '        m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)
            '        m_strTaskType = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "0")), String)
            '    End If
            '    CommonFunctions.Data.DisposeDataReader(drDailyActivity)
            'End If
            '''End of addition by PrashantSJ on 17th Sep2009

            '##### Added By AmitD on 27 Oct 2004


            ' If still no project is selected, then...
            If m_strProjectID = "0" Then
                ' Get the list of projects assigned to the user.		
                'Code Commented by DipaliS 5 Nov 2004
                'Purpose : IssueID 13754
                'drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " + m_strSessionUserID, MyBase.UseSQL)
                'Code Added by DipaliS 5 Nov 2004
                'Purpose : IssueID 13754
                drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " + m_strSessionUserID + ",NULL,'" & m_strProjectFilters & "'", MyBase.UseSQL)
                'End addition by DipaliS
                ' Select the first project by default.				
                If drProject.Read Then
                    m_strProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0")), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drProject)
            End If
            'Sets the first project which is not on hold.
            If InStr(1, m_strProjectsOnHold, "," + m_strProjectID + ",", CompareMethod.Text) <> 0 Then
                m_strProjectID = m_strFirstNotOnHoldProject
            End If
            '##### End Addition
            '''<Summary>
            '' Added By: PrashantSJ
            '' date: 27th May 2008
            ''Purpose: DA blocked for particular project from project workflow.
            '''</Summary>
            'Sets the first project which is not on hold.
            If InStr(1, m_strProjectsDABlocked, "," + m_strProjectID + ",", CompareMethod.Text) <> 0 Then
                m_strProjectID = m_strFirstNotOnHoldProject
            End If
            ''End of addition by PrashantSJ on 27th May 2008

            ' End Modification.	
            If m_strProjectID <> "" Or m_strProjectID <> "0" Then
                m_blnGlobalProject = CType((CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select GlobalProject from tbl_PM_Project where ProjectID =  " & m_strProjectID, MyBase.UseSQL), "0")), Boolean)
            End If

        End If
        If m_strProjectID <> "" Or m_strProjectID <> "0" Then
            m_blnProjectActive = IsProjectActive(CType(m_strProjectID, Long))
        End If

    End Sub
    Private Sub DrawMenu(ByVal strLocation As String)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu


        If strLocation = "ListTop" Or strLocation = "ListBottom" Then
            '-------------------------------------------------------------
            'This block prints the Menus on the List page of DailyActivity
            '-------------------------------------------------------------
            Dim objGate As CommonEngines.HashTables.Gates
            objGate = CommonEngines.HashTables.Gates.GetGetsHashTableObject(CommonFunction.Constants.GATE_EXPENSES)

            If Not objGate Is Nothing Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("EXPENSES"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("EXPENSES"))
                arrClientSideFunctionList.Add("Expenses_OnClick()")
            End If

            objGate = Nothing


            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATE_TASK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATE_TASK"))
            arrClientSideFunctionList.Add("UpdateTask_OnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE"))
            arrClientSideFunctionList.Add("Delete_OnClick()")

            'Modified By PrachiK on 15 Feb 2005 for Issue ID=15669. 
            'Purpose: To show or hide Weekly View  TimeSheet .

            If m_blnShowWeeklyView = True Then

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WEEKLY_VIEW"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WEEKLY_VIEW"))
                arrClientSideFunctionList.Add("WeeklyView_OnClick()")

            End If

            'End Addition

            'Added by SavitaS on 11 Jan 2006 to add "Weekly Timesheet" Link 
            'arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_WEEKLY_TIMESHEET"))
            'arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_WEEKLY_TIMESHEET"))
            'arrClientSideFunctionList.Add("WeeklyTimesheet_OnClick()")
            'End addition by SavitaS 
            'Removed by PrashantSJ on 14th Aug 2009 for SEM 9.0 onwards this feature no longer visible
            'If m_blnShowTaskTypeTimesheet = True Then
            '    arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_TASK_TYPE"))
            '    arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_TASK_TYPE"))
            '    arrClientSideFunctionList.Add("taskTypeTimesheet_OnClick()")
            'End If
            'Removed by PrashantSJ on 14th Aug 2009 for SEM 9.0 onwards this feature no longer visible

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_TASK_REPORT"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_TASK_REPORT"))
            arrClientSideFunctionList.Add("TaskReports_OnClick()")

            arrMenuCaptionsList.Add("?")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrClientSideFunctionList.Add("Help_OnClick('DA')")
            If strLocation = "ListTop" Then
                strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, PrepareDayNavigation())
            ElseIf strLocation = "ListBottom" Then
                strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, "")
            End If

            '-------------------------------------------------------------

        Else
            '-------------------------------------------------------------
            'This block prints the Menus on the Activity Entry page of DailyActivity
            '-------------------------------------------------------------
            'Added By VivekP On 2 jun 2005

            'Commented and Modified By JyotiG
            'Date : 25-Oct-2006
            'Issue ID : 7113 & 7219
            'Start

            'arrMenuCaptionsList.Add("Create Task")
            'arrMenuToolTipsList.Add("Create Task")
            'arrClientSideFunctionList.Add("CreateTask_OnClick()")

            'Commented by SandipL on 24 April 2007 Project Initialized before menu plot in initializeEntryFromProject()

            ''End Of Addition On 2 jun 2005
            'Dim drGlobalProject As IDataReader
            'Dim drDailyAct As IDataReader
            'Dim strGlobalPrj As Boolean
            'Dim strprjId As String = "0"

            'If m_strProjectID = "0" Then
            '    ' Get the project for which an activity was filled last. Select the project.			
            '    strSQL.Remove(0, strSQL.ToString.Length)
            '    'strSQL = "EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'"
            '    strSQL.Append("EXEC usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ", '" & m_strParamDate & "'")

            '    drDailyAct = CommonFunctions.Data.GetDataReader(strSQL.ToString, MyBase.UseSQL)

            '    ' If Entry found, then select that particular Project, and that particular Task Type.
            '    If drDailyAct.Read Then
            '        strprjId = CType((CommonFunctions.Data.CheckIsDBNull(drDailyAct("ProjectID"), "0")), String)
            '    End If
            '    CommonFunctions.Data.DisposeDataReader(drDailyAct)
            '    drGlobalProject = CommonFunctions.Data.GetDataReader("Select GlobalProject from tbl_PM_Project where ProjectID =  " & strprjId, MyBase.UseSQL)
            'Else
            '    drGlobalProject = CommonFunctions.Data.GetDataReader("Select GlobalProject from tbl_PM_Project where ProjectID =  " & m_strProjectID, MyBase.UseSQL)
            'End If
            'If drGlobalProject.Read Then
            '    strGlobalPrj = CType((CommonFunctions.Data.CheckIsDBNull(drGlobalProject("GlobalProject"), "0")), Boolean)
            'End If

            'End commenting by SandipL
            'Modified by SandipL on 24 April 2007 SEM SP8 regression testing IssueID 13048
            ' If strGlobalPrj = False Then
            If m_blnGlobalProject = False Then
                'End modifications by SandipL
                arrMenuCaptionsList.Add("Create Task")
                arrMenuToolTipsList.Add("Create Task")
                arrClientSideFunctionList.Add("CreateTask_OnClick()")
                'End Of Addition On 2 jun 2005
            End If
            '            CommonFunction.Data.DisposeDataReader(drGlobalProject)
            'End of Modification By JyotiG for Issue ID : 7113  & 7219

            If m_strParamShowCloseLink <> "1" Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_ADD_MORE"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_ADD_MORE"))
                arrClientSideFunctionList.Add("Save_OnClick(3)")

                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_REFRESH"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_REFRESH"))
                arrClientSideFunctionList.Add("Save_OnClick(1)")
            End If

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_AND_CLOSE"))
            arrClientSideFunctionList.Add("Save_OnClick(2)")

            If m_blnProjectEditable Then
                If m_strTaskType <> GENERAL_TASKS Then
                    'CommonFunctions.General.WriteHTML("<a STYLE=TEXT-DECORATION:NONE href='JavaScript:IncludeCompletedTasks(")
                    'If m_blnIncludeCompletedTasks Then CommonFunctions.General.WriteHTML "0" Else CommonFunctions.General.WriteHTML "1"
                    'CommonFunctions.General.WriteHTML(")'>" & HREF_FONT_SETTING & "<B>&nbsp;|&nbsp;")
                    If m_blnIncludeCompletedTasks Then
                        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASK"))
                        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASK"))
                        arrClientSideFunctionList.Add("IncludeCompletedTasks(0)")
                    Else
                        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
                        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
                        arrClientSideFunctionList.Add("IncludeCompletedTasks(1)")
                    End If
                End If
                Response.Write("<INPUT id='IncludeCompletedTasks' name='IncludeCompletedTasks' type='hidden' value='")
                If m_blnIncludeCompletedTasks Then
                    Response.Write("1")
                Else
                    Response.Write("0")
                End If
                Response.Write("'>")

            Else
                m_blnIncludeCompletedTasks = True
            End If
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrClientSideFunctionList.Add("Close_OnClick()")

            arrMenuCaptionsList.Add("?")
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
            arrClientSideFunctionList.Add("Help_OnClick('DA')")

            If strLocation = "EditTop" Then
                strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
            ElseIf strLocation = "EditBottom" Then
                strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
            End If
        End If
        '-------------------------------------------------------------

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Function PrepareDayNavigation() As String
        '=====================================================================
        ' Procedure Name        : PrepareDayNavigation()	
        ' Purpose               : This function is used to Prepare the left hand side 
        '                         of the Menu.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : String as HTML
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================

        Dim strTaskList As String                       'Stores the Title on the Left HandSide from resources
        'Dim strHTML As String                           'Stores the whole HTML on the Left Hand Side.
        Dim strHTML As New System.Text.StringBuilder                           'Stores the whole HTML on the Left Hand Side.
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strPrevDay As String = ""
        Dim strNextDay As String = ""
        strTaskList = MyBase.GetResourceString("TASK_LIST")
        strHTML.Append(strTaskList)

        strPrevDay = DateAdd("d", -1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        strNextDay = DateAdd("d", 1, Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        '***** Code Modified by SandipL on 2 Dec 2005 --To solve page refresh problem due to editable Date Control 
        strHTML.Append(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI).ToString("dddd") + " " + CommonFunction.HTMLControls.DrawDateControl("txtDate", "txtDate", , , CommonFunction.Dates.GetDate(Date.ParseExact(m_strParamDate, "d-MMM-yyyy", m_objDTFI)), , "DA", , , , , True, , True, , , "onkeypress= change_date(event)"))
        '***** End modification by SandipL on 2 Dec 2005
        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        strHTML.Append("<A class='Menu' style='' " & _
                            "HREF='PM_DailyActivity.aspx?FlagMove=PrevNext&txtDate=" + strPrevDay + "' Title=""" & _
                            MyBase.GetResourceString("PREVIOUS_DAY") & """ >" & _
                            MyBase.GetResourceString("PREVIOUS_DAY") & _
                            "</A> | <A class='Menu' style='' HREF='PM_DailyActivity.aspx?FlagMove=PrevNext&txtDate=" & _
                            strNextDay + "' Title=""" & MyBase.GetResourceString("NEXT_DAY") & """ >" & _
                            MyBase.GetResourceString("NEXT_DAY") & "</A> |")

        Return strHTML.ToString
        strHTML = Nothing
    End Function

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : This procedure actually plots the grid on the Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim drDailyActivity As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Start-AUJ-22Jan2007, commented and added below.
        'Dim arrCheckBox() As String = {"", "", "", "", "chkDelete"}
        'Dim arrGrouping() As String = {"1"}
        'Dim arrWidthArray() As String = {"", "style='width:40%'", "style='width:10%' align=right", "style='width:40%'", "style='width:10%' align=center"}
        'Dim arrColRowLinks() As String = {"", "Edit_OnClick(DailyActivityEntryID)", "", ""}
        Dim arrCheckBox() As String = {"", "", "", "", "", "chkDelete"}
        Dim arrGrouping() As String = {"1"}
        Dim arrWidthArray() As String = {"", "style='width:30%'", "style='width:10%' align=right", "style='width:40%'", "style='width:10%'", "style='width:10%' align=center"}
        Dim arrColRowLinks() As String = {"", "Edit_OnClick(DailyActivityEntryID)", "", "", ""}
        'End-AUJ-22Jan2007
        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("Exec usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ", NULL, NULL, NULL, '" & m_strParamDate & "','" & m_strParamDate & "', NULL, NULL, 1")

        'Plots the Table for Daily Activity .
        '-------------------------------------------------------------------

        arrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_WORK"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DESCRIPTION"))
        'Start-AUJ-22Jan2007
        arrColumnHeadingList.Add("DA Type")
        'End-AUJ-22Jan2007
        arrColumnHeadingList.Add(MyBase.GetResourceString("DELETE"))

        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("TaskName")
        arrActualColumnNames.Add("Duration")
        arrActualColumnNames.Add("Description")
        'Start-AUJ-22Jan2007
        arrActualColumnNames.Add("DATypeList")
        'End-AUJ-22Jan2007
        arrActualColumnNames.Add("Delete")

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .GroupOnColumn = arrGrouping
            .NoOfDataColumns = 5 'Start-AUJ-22Jan2007, Previous value = 4, changed to 5
            .TDStyleArray = arrWidthArray
            .CheckBoxIDArray = arrCheckBox
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .RowLinkArray = arrColRowLinks
            .SQL = strSQL.ToString
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .PrimaryKey = "DailyActivityEntryID"
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With
        m_objGrid = Nothing
        strSQL.Remove(0, strSQL.ToString.Length)
        '-------------------------------------------------------------------

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
        'Start-AUJ-22Jan2007
        If Args.DataField.ToUpper = "DATYPELIST" Then
            'If CType(CommonFunction.Data.GetDataScalar("select isnull(AcceptDAType, 0) from tbl_PM_CompanyInformation with (nolock)", MyBase.UseSQL), Boolean) = False Then
            If blnAcceptDATYpe = False Then
                Cancel = True
            End If
        End If
        'End-AUJ-22Jan2007
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        'If Args.DataReader.GetName(6) = "Duration" Then
        '    m_dblTotalDuration = m_dblTotalDuration + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.GetValue(6), "0"), Double)
        'End If

        'Modified By NileshD On 10 August 2004
        'Preveous code used index of column insted of name of column. it cuases problem for replication
        'so change from index to name of column (Duration).
        m_dblTotalDuration = m_dblTotalDuration + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Duration"), "0"), Double)
        'End of Modification

        'Dim strSQLAccess As String
        'Dim intRoleLevel As Integer
        'intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        'm_blnTaskaccessible = True
        'If intRoleLevel = 2 Then
        '    If ("," & m_strProjectFilters & ",").IndexOf("," & Args.DataReader("ProjectID").ToString & ",") = -1 Then
        '        m_blnTaskaccessible = False
        '    End If
        'End If
        'If Args.DataReader("WhichTask").ToString = "D" And m_blnTaskaccessible = True Then
        '    strSQLAccess = " Select Count(1) From tbl_PM_OtherTasks task with (nolock) ,tbl_PM_Employee Emp  with (nolock) "
        '    strSQLAccess = strSQLAccess & " left join tbl_PM_ProjectEmployeeRole prjEmp with (nolock)  ON PrjEmp.EmployeeID = " & m_strSessionUserID & " and PrjEmp.ProjectID = " & Args.DataReader("ProjectID").ToString
        '    strSQLAccess = strSQLAccess & " where(Emp.EmployeeID = " & m_strSessionUserID & " And Task.TaskID = " & Args.DataReader("otherTaskID").ToString & ")"
        '    strSQLAccess = strSQLAccess & " and CharIndex( cast(Isnull(prjEmp.Role,Emp.PostID) as varchar),',' + Ltrim(Rtrim(task.EditableRoleList)) + ',')>0  "
        '    m_blnTaskaccessible = CBool(CommonFunctions.Data.GetDataScalar(strSQLAccess, True))
        'End If

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        'Modified by MrugajaB on 19th Sept 2006 for Whiziblesem SP7 Issue ID.6197
        Dim m_strToken As String
        'End Modification

        m_blnDAEntryEditable = True
        m_blnProjectBackdateEntryList = False


        If CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Over"), "0")), Boolean) = True Then
            m_blnDAEntryEditable = False
        End If
        If CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetID"), "")), String) <> "" Then
            m_blnDAEntryEditable = False
        End If
        If CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsActive"), "0")), Boolean) = False Then
            m_blnDAEntryEditable = False
        End If

        'If m_blnTaskaccessible = False Then
        '    m_blnDAEntryEditable = False
        'End If


        '##### Added For handling Resource Timesheet Flow on 10 AUG 2004
        'Added on 4 Aug 2004 - For ResourceTimsheetID check
        If CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ResourceTimesheetID"), "")), String) <> "" Then
            If CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Remarks"), "")), String) <> "" Or CType((CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), "")), String).ToUpper = "J" Then
                'Commented code for issueID - 526 - sp4
                'm_blnDAEntryEditable = True
            Else
                m_blnDAEntryEditable = False
            End If
        End If
        'End Addition
        '##### End Addition



        If Args.ColumnName = "Description" Then
            Args.ApplyHTMLEncode = False
            ''Commented by Yogesh J on 22-Jan-2016 to remove <pre> tag
            ' Args.DataFieldValue = "<Pre><FONT face='Verdana, Arial'>" & Server.HtmlEncode(Args.DataFieldValue.ToString) & "</FONT></Pre>"
            Args.DataFieldValue = "<P><FONT face='Verdana, Arial'>" & Server.HtmlEncode(Args.DataFieldValue.ToString) & "</FONT></P>"
            ''End of addition by Yogesh J on 22-Jan-2016 to remove <pre> tag
        End If

        '############################################################3
        'Added by PrasannaP, 18th May 2004
        Dim drResTmSheet As IDataReader
        Dim strResTmSheetStatus As String
        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ResourceTimesheetID"), ""), String) <> "" Then

            'Modified By VidyaJ - DA Performance Issue - IssueID -89
            'Commented below code as StatusCode can be fetched from Grid SQL itself

            'strSQL = "SELECT StatusCode FROM tbl_PM_Resourcetimesheet WHERE TimeSheetID = " & CType(Args.DataReader("ResourceTimesheetID"), String)
            'drResTmSheet = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            'If drResTmSheet.Read Then
            '    strResTmSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(drResTmSheet("StatusCode"), ""), String)
            'End If

            strResTmSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)
            'End Of Modifications

            'Response.Write strResTmSheetStatus
            'Response.End 

            'Modified By VidyaJ - DA Performance Issue - IssueID -89
            'Do not allow to edit DA which are already approved 
            If (strResTmSheetStatus = "N" Or (CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Verified"), ""), Boolean) = False And strResTmSheetStatus <> "R")) Then  'strResTmSheetStatus = "J" Then

                'Commented code for issueID - 526 - sp4
                'm_blnDAEntryEditable = True

                '==============================================================
                'Added By       :   HiteshS on 28th Jan.2005
                'IssueID        :   15214
                'Description    :   To Set the DA entry Non-editable if that Task is marked as Void
                '                   from Task Management page.
                '==============================================================

                'Modified By VidyaJ - DA Performance Issue - IssueID -89
                'Commented below code as StatusCode can be fetched from Grid SQL itself
                ' Dim drDAEntryVoid As IDataReader
                Dim intDAEntryVoidStatus As Integer

                'strSQL = "Select IsActive From tbl_PM_ProjectTasks Where TaskID = " & CType(Args.DataReader("TaskID"), String)
                'drDAEntryVoid = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                'If drDAEntryVoid.Read Then
                '    intDAEntryVoidStatus = CType(CommonFunction.Data.CheckIsDBNull(drDAEntryVoid("IsActive"), "1"), Integer)
                'End If

                intDAEntryVoidStatus = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsActive"), "1"), Integer)

                'End Of Modifications

                If intDAEntryVoidStatus = 0 Then
                    m_blnDAEntryEditable = False
                End If
                '==============================================================
                'Addition Ends  :   HiteshS on 28th Jan.2005
                '==============================================================
            Else
                m_blnDAEntryEditable = False
            End If
        End If

        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold"), "0"), Boolean) = True Then
            m_blnDAEntryEditable = False
        End If

        'Checking whether project for the current activity is allowing back dated entries or not
        '			Set rsProject = GetRecordSet("Exec usp_Sel_tbl_PM_Project " & rsDailyActivity("ProjectId"))			
        '			If Not rsProject.EOF Then
        If DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime), Today()) > 0 Then
            If CStr(EXPIRY_OF_TASK) <> INVALID_ENTRY Then
                '*****code to put project backdate entry
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & CType(Args.DataReader("ProjectId"), String), MyBase.UseSQL)

                If drBackDatedConf.Read Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsBackDating"), "0"), Boolean) = False Then
                        m_blnProjectBackdateEntryList = False
                    Else
                        m_blnProjectBackdateEntryList = True
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectBackdateEntryList = False
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            Else
                m_blnProjectBackdateEntryList = True
            End If

            If m_blnProjectBackdateEntryList = False Then
                If DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, CType(EXPIRY_OF_TASK, Integer), CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime)), Today()) > 0 Then
                    'If (CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime) + EXPIRY_OF_TASK) < Date Then
                    m_blnTaskEditExpired = True
                Else
                    m_blnTaskEditExpired = False
                End If
            Else
                m_blnTaskEditExpired = False
            End If
        End If
        '---------------------------------------------------------------1
        'Added on 25 May 2004
        If DateDiff(DateInterval.Day, CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime), Today()) < 0 Then
            If CStr(EXPIRY_OF_TASK_FORWARD) <> INVALID_ENTRY Then
                '*****code to put project backdate entry
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & CType(Args.DataReader("ProjectId"), String), MyBase.UseSQL)

                If drBackDatedConf.Read Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsForwardDating"), "0"), Boolean) = False Then
                        m_blnProjectBackdateEntryList = False
                    Else
                        m_blnProjectBackdateEntryList = True
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectBackdateEntryList = False
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            Else
                m_blnProjectBackdateEntryList = True
            End If

            If m_blnProjectBackdateEntryList = False Then
                If DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, -CType(EXPIRY_OF_TASK_FORWARD, Integer), CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime)), Today()) < 0 Then
                    'If (CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), DateTime) + EXPIRY_OF_TASK) < Date Then
                    m_blnTaskEditExpired = True
                Else
                    m_blnTaskEditExpired = False
                End If
            Else
                m_blnTaskEditExpired = False
            End If
        End If
        '---------------------------------------------------------------1
        '############################################################3

        If m_blnDAEntryEditable = False Then
            If Args.ColumnName = "Task Name" Then
                Args.EnableLink = False
            End If
            If Args.ColumnName = "Delete" Then
                Args.IsCheckBoxDisabled = True
            End If
        Else
            If Args.ColumnName = "Task Name" Then
                'Args.ReplacementValue = ""
                Cancel = True

                'Modified by MrugajaB on 19th Sept 2006 for Whiziblesem SP7 Issue ID.6197
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("DailyActivityEntryID"), String) + CType(Session("intUserID"), String) + "0" + CType(1038, String))


                Args.StringToBeInserted = "<TD  vAlign=top style='width:40%' title='Task Name'>" & _
                                          "<A href=JavaScript:Edit_OnClick('" + CType(Args.DataReader("DailyActivityEntryID"), String) + "','" & m_blnTaskEditExpired & "','" & m_blnProjectBackdateEntryList & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')>" + Server.HtmlEncode(CType(Args.DataReader("TaskName"), String)) + "</A></td>"
            End If
        End If

        If m_blnTaskEditExpired Then
            Args.IsCheckBoxDisabled = True
        End If

        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold"), "0"), Boolean) = True Or CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsActive"), "1"), Boolean) = False Then
            If Args.ColumnName <> MyBase.GetResourceString("PROJECT_NAME") And Args.ColumnName <> MyBase.GetResourceString("ACTUAL_WORK") Then
                Args.TDStyle = " style='color:red' "
            End If
            If Args.ColumnName = MyBase.GetResourceString("ACTUAL_WORK") Then
                Args.TDStyle = " style='color:red; text-align:Right' "
            End If

        End If

        'Start-AUJ-22Jan2007
        If Args.DataField.ToUpper = "DATYPELIST" Then
            'If CType(CommonFunction.Data.GetDataScalar("select isnull(AcceptDAType, 0) from tbl_PM_CompanyInformation with (nolock)", MyBase.UseSQL), Boolean) = False Then
            If blnAcceptDATYpe = False Then
                Cancel = True
            End If
        End If
        'End-AUJ-22Jan2007
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName = MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASK") Or Args.LinkName = MyBase.GetResourceString("MENU_SHOW_ALL_TASKS") Then
            Cancel = True
        End If
        'Added By JayavantK on 08-Oct-2004
        'Hide the Top Menu links of 'Task Type Timesheet' and 'Task Reports'
        If Args.LinkName = MyBase.GetResourceString("MENU_TASK_TYPE") Then
            If m_blnHideTaskTypeTimesheetMenuLink = True Then
                m_blnHideTaskTypeTimesheetMenuLink = False
                Cancel = True
            End If
        ElseIf Args.LinkName = MyBase.GetResourceString("MENU_TASK_REPORT") Then
            If m_blnHideTaskReportMenuLink = True Then
                m_blnHideTaskReportMenuLink = False
                Cancel = True
            End If
        End If
        'End Addition

        'Added By VivekP On 6 Jun 2005
        If Args.LinkName = "Create Task" Then
            If Not (m_objAccessRights.Add = True And m_blnProjectActive = True) Then Cancel = True
            If GlobalProject = "True" Then
                Cancel = True
            End If
            'Added By VivekP On 16 jun 2005
            If Request.QueryString("FromTimesheet") <> "CreateTask" Then
                Cancel = True
            End If
            'End Of addition on 16 jun 2005

            ' Added By nitinVS on 16 Apr 2007 for whizibleSEM SP 8 Regression Issue Fixes 
            If IsNothing(m_strProjectID) = True Or m_strProjectID = "" Or m_strProjectID = "0" Then
                Cancel = True
            End If
            'End Addition By nitinVS on 16 Apr 2007 for whizibleSEM SP 8 Regression Issue Fixes 

        End If

        'End of addition By VivekP On 6 jun 2005 

    End Sub
    'Added By VivekP On 6 Jun 2005
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub
    Public Shared Function IsProjectActive(ByVal lngProjectID As Long) As Boolean
        '====================================================================
        ' Function Name        : IsProjectActive
        ' Parameters Passed    : Id of the Project.
        ' Returns              : Boolean value true or false depending upon the project is over or not.
        ' Parameters Affected  : None
        ' Purpose              : This procedure check the over flag from the db against the Project and returns 
        '                        true if it is true else false.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim blnReturn As Boolean = False
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "Select [Over] IsOver from tbl_PM_Project where ProjectID=" & lngProjectID.ToString()
        strQuery = "usp_sel_tbl_PM_Project_IsOver " & lngProjectID.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        blnReturn = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), Boolean)
        Return (Not blnReturn)
    End Function

    'End Of addition On 6 Jun 2005 By VivekP

    '--- Added By Purvaj on 30 Sept 2008 for Whiziblesem8.0 for displaying whether selected date is holiday
    Public Sub GetHolidayOrLeave()
        Dim IsHolidayOrLeave As Boolean
        Dim strDate As String
        strDate = CommonFunction.General.CheckIsNothing(Request("txtDate"), "").ToString
        IsHolidayOrLeave = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + CommonFunction.General.CheckIsNothing(Session("intUserID"), "0").ToString + ",'" + strDate.ToString + "'", True), "0"), "0"))
        Response.Clear()
        Response.Write(IsHolidayOrLeave)
        Response.End()
    End Sub
    '---End addition Purvaj

    ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
    '' CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(EmployeeID, String) + CType(TagID, String) + "0" + "0")



End Class

