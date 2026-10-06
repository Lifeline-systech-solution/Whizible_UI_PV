'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	PbNIT
' Module Name      :	PM_DailyActivityMatrix.aspx
' Purpose          :	To bulk add the Daily Activities
' Description      :	To bulk add the Daily Activities
' Assumptions      :	None.
' Dependencies     :	
' Author           :	PrasannaP
' Reviewed         :	
' Tested           :	
' Created          :	26th Feb 2004
' Revisions        :			
'**********************************************************************************

Public Class PM_DailyActivityMatrix
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration"
    Protected m_strWindowTitle As String

    Private m_objMenu As WebPages.Template.StaticMenu
    Private m_strSessionUserID As String        'For storing the User ID from Session
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_strSessionClientDate As String    'For storing the Client Date from Session
    'Private m_drDailyActivity As IDataReader

    Protected m_blnStatus_MPPTasks As Boolean
    Protected m_blnStatus_AssignedTasks As Boolean
    Protected dtmToDate As String = ""
    Protected dtmFromDate As String = ""
    Protected m_blnActualWorkHrs As Boolean = CommonFunction.Application.TimesheetEntryCombo
    'This variable decide what to show on the form 
    'to fill the Actual Hours worked. i.e. ComboBox Or TextBox

    Private m_blnIncludeGeneralTasks As Boolean
    Protected m_blnDisableWVForTaskTypeProjects As Boolean
    Protected m_blnIsTaskTypeProject As Boolean
    Protected m_blnEnforceConstraints As Boolean
    Private m_blnUseClientDateForDA As Boolean
    Private m_strSelectedTaskType As String
    Private m_intTaskFilter As Integer
    'Private strSQLQuery As String
    Private strSQLQuery As New System.Text.StringBuilder("")
    Private m_intProjectID As String = "0"
    Private dblArray_DayWiseTotalHrs As Double() = {0, 0, 0, 0, 0, 0, 0}
    Private dblArray_TaskWiseTotalHrs As Double()
    Private m_blnTaskEditable As Boolean
    'Private strClientSideScript As String = ""
    Private strClientSideScript As New System.Text.StringBuilder("")
    Private dtmPreviousDate As String
    Private m_strTooltip As String() = {"", "", "", "", "", "", "", ""}

    Private Const TASKS_FOR_THE_WEEK As Integer = 6
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"
    Private Const ALL_TASKS As Integer = 5
    Private Const GENERAL_TASKS As String = "D"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"
    Private Const ALL_TASK_TYPES As String = "A"

    'Added By PrasannaP on May 19th 2004
    'This flag determines whether to execute a Matrix according to Enterprise version or not
    Private Const ENTERPRISE_CHANGES As Boolean = True
    Protected m_strBackdatingExpiry As String
    Protected m_strFwddatingExpiry As String
    Protected m_strHoursValidation As String
    Protected m_dblTotalWorkHours As Double
    Protected m_blnProjectBackdateEntry As Boolean
    Protected m_blnProjectFwddateEntry As Boolean
    'End Addition

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
    'Added By Santosh Pawar on 21 oct 2004
    'Following flag will restrict the display of taskcomplete checkbox 
    Protected m_blnResourceLevelTaskCompletion As Boolean = False

    'Added by DipaliS 5 Nov 2004
    'Purpose    :    IssueID 13754
    Private m_strProjectFilters As String = ""
    'End addition by DipaliS
    'End of Addition

    '' START : ParagD On 24-Aug-2006
    Protected m_TotalHoursForAllProjects As Double
    '' END : ParagD On 24-Aug-2006

    'Modified By VidyaJ for IssueID - 89 (SP4 DA Performance) 
    Protected m_TotalHours As Double
    Protected m_TotalMPPHours As Double
    Protected m_TotalGeneralHours As Double
    Protected m_TotalAssignedHours As Double
    Protected m_TotalIssuesHours As Double
    Protected m_TotalWeekHours As Double
    Protected m_strProjectName As String
    'End Of Addition

    '' START : Modified By ParagD On 25-Aug-2006
    Protected m_TotalMPPHours_ForProject As Double
    Protected m_TotalGeneralHours_ForProject As Double
    Protected m_TotalAssignedHours_ForProject As Double
    Protected m_TotalIssuesHours_ForProject As Double
    '' END : Modified By ParagD On 25-Aug-2006

    'Modified By VidyaJ for IssueID - 364 (SP4 ) 
    Private strResTmSheetStatus As String

    ''Code added by VidtaJ on 28th May 2007 for SP8 - Performance
    Dim m_intStartingDayofWeek As Integer
    ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
    Private strSQL As New System.Text.StringBuilder("")
    Protected m_intFlag As Integer
    ''End of Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)

    ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
    Protected m_PKToken_TaskDetails As String
    Protected m_PKToken_ProjectID As String
    Protected m_PKToken_TaskType As String
    Protected m_PKToken_TaskID As String
    Protected m_PKToken_FromDate As String
    Protected m_PKToken_ToDate As String
    Protected m_PKToken_ShowDetails As String
    Protected m_PKToken_EmployeeID As String
    Protected m_PKToken_TagID As String
    Protected m_PKToken_mid As String
    Protected m_PKToken_Mode As String
    ''End of Addition by Dhanashri S on 28 Jan 2016


    Private Enum TASK_DETAILS
        COL_TASKID = 0
        COL_STARTDATE
        COL_ENDDATE
        COL_WORK
        COL_TOTALHOURS
        COL_ENTRYDATE
        COL_DAYTOTALS
    End Enum

    ''End of addition by VidyaJ 

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

        ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
        If Not Request.QueryString("PkToken") Is Nothing Then
            m_PKToken_TaskDetails = Request.QueryString("PkToken").ToString
        End If
        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_PKToken_ProjectID = Request.QueryString("ProjectID").ToString
        End If
        If Not Request.QueryString("TaskType") Is Nothing Then
            m_PKToken_TaskType = Request.QueryString("TaskType").ToString
        End If
        If Not Request.QueryString("TaskID") Is Nothing Then
            m_PKToken_TaskID = Request.QueryString("TaskID").ToString
        Else
            m_PKToken_TaskID = 0
        End If
        If Not Request.QueryString("FromDate") Is Nothing Then
            m_PKToken_FromDate = Request.QueryString("FromDate").ToString
        End If
        If Not Request.QueryString("ToDate") Is Nothing Then
            m_PKToken_ToDate = Request.QueryString("ToDate").ToString
        End If
        ''Added by Dhanashri S on 10 Aug 2016 purpose:validate PK token
        If Not Request.QueryString("ShowDetails") Is Nothing Then
            m_PKToken_ShowDetails = Request.QueryString("ShowDetails").ToString
        Else
            m_PKToken_ShowDetails = "2"
        End If

        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_PKToken_EmployeeID = Request.QueryString("EmployeeID").ToString
        End If

        If Not Request.QueryString("TagID") Is Nothing Then
            m_PKToken_TagID = Request.QueryString("TagID").ToString
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_PKToken_Mode = Request.QueryString("Mode").ToString
        End If

 


        ''End of Addition by Dhanashri S on 1 Aug 2016

        If m_PKToken_TagID = "10" Then
            ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
            ''If m_PKToken_TaskDetails = "" Or (CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Session("intUserID").ToString + HttpContext.Current.Session("intProjectID").ToString + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False) Then
            If m_PKToken_TaskDetails = "" Or (CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Session("intUserID").ToString + CType(m_PKToken_ProjectID, String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False) Then
                ''End of Addition by Dhanashri S on 11 Aug 2016
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            If (m_PKToken_ShowDetails = "1" And m_PKToken_Mode <> "Save") Then
                If m_PKToken_TaskDetails = "" Or (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_ProjectID, String) + CType(m_PKToken_EmployeeID, String) + CType(m_PKToken_TaskID, String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False) Then
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            Else
                'If m_PKToken_ShowDetails = "2" Then
                If m_PKToken_ShowDetails = "2" And Request.QueryString("TaskNotes") <> "1" Then
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If

        End If





        'If (m_PKToken_ShowDetails <> "") Then
        '    'If m_PKToken_TaskDetails <> "" Then
        '    '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_ProjectID, String) + CType(m_PKToken_TaskType, String) + CType(m_PKToken_TaskID, String) + CType(m_PKToken_FromDate, String) + CType(m_PKToken_ToDate, String) + CType(Request.QueryString("EmployeeID"), String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False) Then
        '    '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_PKToken_ProjectID, String))
        '    '        'Token is Invalid now redirect to the Invalid Access Page
        '    '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    '    End If
        '    'End If

        '    If ((m_PKToken_TaskDetails = "") And (Request.QueryString("TaskID"))) Or ((Request.QueryString("TaskID")) And (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_ProjectID, String) + CType(m_PKToken_TaskType, String) + CType(m_PKToken_TaskID, String) + CType(m_PKToken_FromDate, String) + CType(m_PKToken_ToDate, String) + CType(Request.QueryString("EmployeeID"), String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False)) Then

        '        

        '    End If

        'End If
        'If m_PKToken_TagID = "10" Then
        '    If m_PKToken_TaskDetails <> "" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_ProjectID, String) + CType(m_PKToken_EmployeeID, String) + CType(m_PKToken_TagID, String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False) Then

        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'Else
        '    If (m_PKToken_ShowDetails <> "") Then
        '        If ((m_PKToken_TaskDetails = "") And (Request.QueryString("TaskID"))) Or ((Request.QueryString("TaskID")) And (CommonFunctions.Security.Token.ValidateToken(CType(m_PKToken_mid, String) + CType(m_PKToken_TaskID, String) + CType(0, String) + CType(0, String), m_PKToken_TaskDetails) = False)) Then
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'End If





        ''End of Addition by Dhanashri S on 28 Jan 2016

        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub
    ''Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowDetails_OnClick(ProjectID As String, EmployeeID As String, TaskID As String) As String
        Try
            Dim m_PKToken_ShowDetails_Multiple As String
            ''m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(TaskType, String) + CType(TaskID, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")
            m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(EmployeeID, String) + CType(TaskID, String) + "0" + "0")

            Return m_PKToken_ShowDetails_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function

    'Public Shared Function GenrateURLToken_TaskLink_OnClick(ProjectID As String, TaskID As String) As String
    '    Dim m_PKToken_TaskLink_Multiple As String
    '    m_PKToken_TaskLink_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(TaskID, String) + "0" + "0")

    '    Return m_PKToken_TaskLink_Multiple

    'End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_TaskLink_OnClick(TaskID As String, EmployeeID As String, ProjectID As String, ShowClose As String) As String
        Try
            Dim m_PKToken_TaskLink_Multiple As String
            m_PKToken_TaskLink_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskID, String) + CType(EmployeeID, String) + "0" + "0" + CType(ProjectID, String) + CType(ShowClose, String))

            Return m_PKToken_TaskLink_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 28 Jan 2016

    Public Sub PageInit()
        'Added by DipaliS 5 Nov 2004
        'Purpose    :    IssueID 13754
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

        Dim arrDailyActivityEntryIDs() As String
        Dim drCompanyInformation As IDataReader
        Dim drProjectsOnHold As IDataReader
        Dim drResourceLevelTaskCompletion As IDataReader
        Dim strSQL As String

        'Store UserID in Local Variable
        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_strSessionClientDate = CType(Session("ClientDate"), String)

        m_blnStatus_MPPTasks = CommonFunctions.Application.RestrictDurationChange_M
        m_blnStatus_AssignedTasks = CommonFunctions.Application.RestrictDurationChange_O
        m_blnIncludeGeneralTasks = CommonFunctions.Application.IncludeGeneralTasks
        m_blnDisableWVForTaskTypeProjects = CommonFunctions.Application.DisableWVForTaskTypeProjects
        m_blnUseClientDateForDA = CommonFunctions.Application.UseClientDateForDA

        If m_blnStatus_MPPTasks = Nothing Then
            m_blnStatus_MPPTasks = False
        End If

        If m_blnStatus_AssignedTasks = Nothing Then
            m_blnStatus_AssignedTasks = False
        End If

        If m_blnIncludeGeneralTasks = Nothing Then
            m_blnIncludeGeneralTasks = False
        End If



        'Code Added by PrasannaP on 19 May 2004  => BackdatingNoDays field added to list
        If ENTERPRISE_CHANGES Then
            Dim drTotalHours As IDataReader
            'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4)

            ' Commented and Added By MahendraV On 12:38 PM 5/29/2007 for CompanyInformation Optimization
            ' Start_MV_5/29/2007
            'Dim drCompanyInfoSettings As IDataReader
            'drCompanyInfoSettings = CommonFunction.Data.GetDataReader("Select IsNull(WeekDays,0)*IsNull(HoursPerDay,0) weekhours, BackdatingNoDays,ForwardDatingNoDays,HoursValidation FROM tbl_PM_CompanyInformation", MyBase.UseSQL)
            'If drCompanyInfoSettings.Read() Then
            '    m_strBackdatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfoSettings("BackdatingNoDays"), ""), String)
            '    m_strFwddatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfoSettings("ForwardDatingNoDays"), ""), String)
            '    m_strHoursValidation = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfoSettings("HoursValidation"), "C"), String)
            '    m_TotalWeekHours = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfoSettings("weekhours"), "0"), Double)

            'End If
            ' CommonFunction.Data.DisposeDataReader(drCompanyInfoSettings)
            m_strBackdatingExpiry = CommonFunction.Application.BackdatingNoDays.ToString()
            m_strFwddatingExpiry = CommonFunction.Application.ForwardDatingNoDays.ToString()
            m_strHoursValidation = CommonFunction.Application.HoursValidation.ToString()
            '--- Commented by PurvaJ on 6 Nov 2008 for WhizibleSem8.0 
            '--- Total weekhours will be calculated based on the resource OU working days and working hours
            'm_TotalWeekHours = CommonFunction.Application.weekhours
            '--- End comment PurvaJ
            m_intStartingDayofWeek = CommonFunction.Application.StartingDayofweek

            ' End_MV_5/29/2007




            'm_strBackdatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT BackdatingNoDays FROM tbl_PM_CompanyInformation", MyBase.UseSQL), ""), String)
            'm_strFwddatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ForwardDatingNoDays FROM tbl_PM_CompanyInformation", MyBase.UseSQL), ""), String)

            ''Get the Total Hours that the user can enter while filling the Daily Activity
            'm_strHoursValidation = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT HoursValidation FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "C"), String)
            'End Of Modifications
    'Trupti
            Dim strquery As String
            Dim strJoiningdate As String
            strquery = "select joiningdate from tbl_pm_employee where employeeid=" + m_strSessionUserID.ToString
            strJoiningdate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strquery, True), ""), String)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("hdnJoiningdate", "hdnJoiningdate", , , , CDate(strJoiningdate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End

            If MyBase.GetFormValue("cboProject") = "" Or MyBase.GetFormValue("cboProject") Is Nothing Then
                If Request.QueryString("ShowDetails") = "1" Then
                    m_intProjectID = CType(IIf(Request.QueryString("ProjectID") = "", "0", Request.QueryString("ProjectID")), String)
                End If
            Else
                m_intProjectID = CType(IIf(MyBase.GetFormValue("cboProject") = "", "0", MyBase.GetFormValue("cboProject")), String)
            End If

            ''Commented by PrashantSJ on 17th Sep 2009 : Purpose: for performance reason we have comment this code (las DA filled DA)
            'If m_intProjectID = "" Or m_intProjectID Is Nothing Then
            '    Dim drSelectProject As IDataReader

            '    'Code Commented by DipaliS 5 NOV 2004
            '    'Purpose :  IssueID 13754
            '    'drSelectProject = CommonFunction.Data.GetDataReader("usp_Sel_Project_For_DA " & m_strSessionUserID, MyBase.UseSQL)
            '    'Code Added by DipaliS 5 Nov 2004
            '    'Modified By VarunA on 8-Oct-2008 IssueID-20112
            '    'Purpose : To have the last filled DA ProjectID for Task Complete Check box
            '    'drSelectProject = CommonFunction.Data.GetDataReader("usp_Sel_Project_For_DA " & m_strSessionUserID & ",NULL,'" & m_strProjectFilters & "'", MyBase.UseSQL)
            '    drSelectProject = CommonFunction.Data.GetDataReader("usp_Sel_GetDailyActivityParameters 1," & m_strSessionUserID & ",NULL,'" & m_strProjectFilters & "'", MyBase.UseSQL)
            '    'End By VarunA on 8-Oct-2008 IssueID-20112
            '    'End addition by DipaliS

            '    If drSelectProject.Read() Then
            '        'Modified By VarunA on 8-Oct-2008 IssueID-20112
            '        'Purpose : To have the last filled DA ProjectID for Task Complete Check box
            '        'm_intProjectID = CType(CommonFunction.Data.CheckIsDBNull(drSelectProject.Item(0), "0"), String)
            '        m_intProjectID = CType(CommonFunction.Data.CheckIsDBNull(drSelectProject("ProjectID"), "0"), String)
            '        'End By VarunA on 8-Oct-2008 IssueID-20112
            '    Else
            '        m_intProjectID = "0"
            '    End If
            '    CommonFunction.Data.DisposeDataReader(drSelectProject)
            'End If
            '''End of addition by PrashantSJ on 17th Sep2009

            ' Commented By MahendraV On 12:18 PM 5/29/2007 For allowing IsBackdateing and IsForwardDating
            ' Start_MV_5/29/2007
            'If Request.QueryString("TaskNotes") <> "1" Then
            '    drTotalHours = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Daily_WorkingHours_Office " & m_intProjectID & ", '" & m_strHoursValidation & "'", MyBase.UseSQL)
            '    If drTotalHours.Read() Then
            '        m_dblTotalWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drTotalHours("WorkingHours"), "0"), Double)
            '    End If
            '    CommonFunction.Data.DisposeDataReader(drTotalHours)
            '    CommonFunction.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (" & m_dblTotalWorkHours & " - 0); </Script>")

            '    If m_strBackdatingExpiry <> "" Then
            '        Dim drBackDatedConf As IDataReader
            '        drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_intProjectID, MyBase.UseSQL)


            '        If drBackDatedConf.Read() Then
            '            'Entry exists for the current project and current user in configuration table
            '            If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsBackDating"), "0"), Boolean) = False Then
            '                m_blnProjectBackdateEntry = False
            '            Else
            '                m_blnProjectBackdateEntry = True
            '            End If
            '        Else
            '            'Entry Doesnot exist for the current project and current user in configuration table
            '            m_blnProjectBackdateEntry = False
            '        End If
            '        CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            '    Else
            '        m_blnProjectBackdateEntry = True
            '    End If

            '    If m_strFwddatingExpiry <> "" Then
            '        Dim drBackDatedConf As IDataReader
            '        drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_intProjectID, MyBase.UseSQL)


            '        If drBackDatedConf.Read() Then
            '            'Entry exists for the current project and current user in configuration table
            '            If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsForwardDating"), "0"), Boolean) = False Then
            '                m_blnProjectFwddateEntry = False
            '            Else
            '                m_blnProjectFwddateEntry = True
            '            End If
            '        Else
            '            'Entry Doesnot exist for the current project and current user in configuration table
            '            m_blnProjectFwddateEntry = False
            '        End If
            '        CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            '    Else
            '        m_blnProjectFwddateEntry = True
            '    End If

            'End If


            ' End_MV_5/29/2007
        End If
        ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
        m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
        ''End of Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)

        'End Of Addition

        '##### Added for alerting users if the selected project is on hold
        'Added By PriyankaN on 9th Sep 2004
        If m_strSessionUserID <> "0" Then
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

        'Code Commented by DipaliS 5 Nov 2004
        'Purpose : IssueID 13754
        'strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,NULL" '& m_strParamDate & "'"
        'Code Added by DipaliS 5 Nov 2004
        'Purspoe : IssueID 13754
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        strSQLQuery.Append("EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,NULL,'" & m_strProjectFilters & "'")
        'End Addition by DipaliS
        drProjectsOnHold = CommonFunction.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)

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

        ' Added by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 

        'Sets the first project which is not on hold.
        If InStr(1, m_strProjectsOnHold, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
            m_intProjectID = m_strFirstNotOnHoldProject
        End If
        '''<Summary>
        '' Added By: PrashantSJ
        '' date: 27th May 2008
        ''Purpose: DA blocked for particular project from project workflow.
        '''</Summary>
        'Sets the first project which is not on hold.
        If InStr(1, m_strProjectsDABlocked, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
            m_intProjectID = m_strFirstNotOnHoldProject
        End If
        ''End of addition by PrashantSJ on 27th May 2008
        ' End Addition by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 

        'End Addition
        '##### End Addition
        '//Modified By VidyaJ - IssueID  - 11764
        DrawMenu(Request.QueryString("TaskNotes"), True)
        DrawPageLegend()
        PlotNote()
        'Commented By VarunA on 24-Sep-2008 IssueID-22543
        'Purpose : Extra data was displayed in Mozilla
        'DrawPageHeaderFooter()
        'End By VarunA on 24-Sep-2008 IssueID-22543
        ''Added and commented by PrashantSJ on 17th Sep 2009
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:450px'>")
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;'>")
        ''End of addition by PrashantSJ on 17th Sep 2009
        ''Commented By VidyaJ for IssueID - 89 (DA Performance - SP4) 
        '    'Added By Santosh Pawar on 21 Oct 2004 
        '    If m_intProjectID <> "" Then
        '        strSQL = "usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & m_intProjectID
        '        drResourceLevelTaskCompletion = CommonFunction.Data.GetDataReader(strSQL, True)
        '        strSQL = ""
        '        If drResourceLevelTaskCompletion.Read Then
        '            m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), False, drResourceLevelTaskCompletion("ResourceLevelTaskCompletion")), Boolean)
        '        Else
        'm_blnResourceLevelTaskCompletion = True
        '        End If
        '    End If
        '    'Addition Complete

        If Request.QueryString("TaskNotes") = "1" Then
            '=====================================================================
            ' TASK NOTES PAGE IS REQUESTED.
            '=====================================================================
            DisplayTaskNotes()
        ElseIf CDbl(Request.QueryString("ShowDetails")) = 1 Then
            '=====================================================================
            ' DETAILS OF DAILY ACTIVITY IS REQUESTED.
            '=====================================================================
            DisplaySavedDailyActivityMatrix()
        Else
            '=====================================================================
            ' WEEKLY VIEW DAILY ACTIVITY IS REQUESTED.
            '=====================================================================
            DisplayWeeklyActivityGrid()

        End If

        CommonFunctions.General.WriteHTML("</DIV>")

        '--- Added BY purvaj on 30 Sept 2008 for Whiziblesem8.0 Holiday/ leave changes
        DrawPageHeaderFooter()
        '--- End addition Purvaj

        '//Modified By VidyaJ - IssueID  - 11764
        DrawMenu(Request.QueryString("TaskNotes"), False)

        strSQLQuery = Nothing
        strClientSideScript = Nothing

    End Sub

    Private Sub DrawPageHeaderFooter()
        '=====================================================================
        ' Procedure Name        : DrawPageHeaderFooter()	
        ' Purpose               : Plots the Page Header.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================

        '--Commented by Purvaj on 30 Sept 2008 for WhizibleSEM 8.0 
        'If Not CommonFunctions.General.IsClientBrowserIE Then
        '--- End commened by Purvaj
        Dim strHTML As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        'Modifeid by Purvaj UI_HEADER  channged to UI_FOOTER
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER

        '--Commented and Added by Purvaj on 30 Sept 2008 for WhizibleSEM 8.0
        'objHeaderFooter.HeaderFooter = MyBase.GetResourceString("NOTE")
        objHeaderFooter.HeaderFooter = MyBase.GetResourceString("FOOTERNOTE").ToString
        '--- End commened by Purvaj
        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML(strHTML + "<BR>")
        End If
        '--Commented by Purvaj on 30 Sept 2008 for WhizibleSEM 8.0
        ' End If
        '--- End commened by Purvaj
    End Sub

    Private Sub DrawPageLegend()
        '=====================================================================
        ' Procedure Name        : DrawPageLegend()	
        ' Purpose               : Plots the Page Legend.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================

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
    Private Sub DisplayWeeklyActivityGrid()
        '=====================================================================
        ' Procedure Name        : DisplayWeeklyActivityGrid()	
        ' Purpose               : Plots the Grid of Matrix.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================


        Dim strSaveAgainstProjectID As String
        Dim strTaskID As String
        Dim strHoursEntered As String
        Dim dtmSelectedDate As String

        Dim drDailyActivity As IDataReader

        '' START : ParagD On 24-Aug-2006
        Dim drDailyActivityForAllProjects As IDataReader
        '' END : ParagD On 24-Aug-2006

        Dim drProject As IDataReader
        ' Dim drCompanyWeekHours As IDataReader

        '----------------
        ' INITIALIZATION.
        '----------------
        ' Retrieve the ProjectID.	


        'Added By MahendraV On 12:18 PM 5/29/2007 For allowing IsBackdateing and IsForwardDating
        'Start_MV_5/29/2007 
        Dim drTotalHours As IDataReader
        Dim strSQLTaskCaseStructure As String
        'End_MV_5/29/2007 

        ' Added By MahendraV On 2:14 PM 5/31/2007 for SP8 - Performance
        ' Start_MV_5/31/2007
        strSQLTaskCaseStructure = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_intProjectID
        ' End_MV_5/31/2007

        If Trim(MyBase.GetFormValue("cboProject")) <> "" Then
            m_intProjectID = FixString(MyBase.GetFormValue("cboProject"), 0, False, True)
        Else
            m_intProjectID = "0"
        End If


        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
        'This variable is initialized while getting the data from project setting above 
        'm_blnEnforceConstraints = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select dbo.udf_EnforceConstraints(" & m_intProjectID & ")", MyBase.UseSQL), "0"), Boolean)

        'Modified By VidyaJ for IssueID -  89 (DA Performance - SP4) 
        If m_intProjectID <> "" Then
            Dim drProjectSettings As IDataReader
            Dim strSQL As String
            ''Code added by VidtaJ on 28th May 2007 for SP8 - Performance

            ' Commented and Added By MahendraV On 2:14 PM 5/31/2007 for SP8 - Performance
            ' Start_MV_5/31/2007
            'strSQL = "SELECT ProjectName,ResourceLevelTaskCompletion,CAST(EnforceConstraints AS BIT) EnforceConstraints FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID =  " & m_intProjectID
            strSQL = strSQLTaskCaseStructure
            ' End_MV_5/31/2007
             drProjectSettings = CommonFunction.Data.GetDataReader(strSQL, True)
            strSQL = ""
            If drProjectSettings.Read Then
                m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drProjectSettings("ResourceLevelTaskCompletion")), False, drProjectSettings("ResourceLevelTaskCompletion")), Boolean)
                m_blnEnforceConstraints = CType(CommonFunction.Data.CheckIsDBNull(drProjectSettings("EnforceConstraints"), "0"), Boolean)
                m_strProjectName = Trim(CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings("ProjectName"), "0"), String))
            Else
                m_blnResourceLevelTaskCompletion = False
            End If
            CommonFunction.Data.DisposeDataReader(drProjectSettings)
        End If
        'End Of Modifications

        If Trim(Request.QueryString("PrevProjectID")) <> "" Then
            strSaveAgainstProjectID = Trim(Request.QueryString("PrevProjectID"))
        Else
            strSaveAgainstProjectID = m_intProjectID
        End If

        ' Retrieve the task type.
        If Trim(MyBase.GetFormValue("optTasks")) <> "" Then
            m_strSelectedTaskType = Trim(FixString(MyBase.GetFormValue("optTasks"), 0, False, True))
        Else
            m_strSelectedTaskType = "0"
        End If

        ' Retrieve the current Task filter value.
        If Trim(MyBase.GetFormValue("optMainTaskFilter")) <> "" Then
            m_intTaskFilter = CType(FixString(MyBase.GetFormValue("optMainTaskFilter"), 0, True, True), Integer)
        Else
            m_intTaskFilter = TASKS_FOR_THE_WEEK
        End If

        ' IF THE DAILY ACTIVITY ENTRIES HAVE TO BE SAVED, THEN...
        '--------------------------------------------------------
        If Request.QueryString("Mode") = "Save" Then
            Dim intRow As Integer
            Dim intCol As Integer
            Dim strArrTaskIDs As String()
            Dim strArrDates As String() = Split(MyBase.GetFormValue("txtEntryDate"), ",")

            'Added By VidyaJ for IssueID - 20315 (DA Performance) 
            Dim blnUpdated As Boolean
            Dim blnTaskComplete As Boolean

            blnUpdated = False
            'End Of Modifications

            strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
            strSQLQuery.Append("")

            ' Generate the SQL query required to insert the records.
            For intRow = 1 To Split(MyBase.GetFormValue("txtTaskID"), ",").Length
                strArrTaskIDs = Split(FixString(MyBase.GetFormValue("txtTaskID"), 0, False, False), ",")
                strTaskID = Trim(strArrTaskIDs(intRow - 1))
                For intCol = 1 To 7
                    strHoursEntered = MyBase.GetFormValue("txtRow" + CStr(intRow) + "Col" + CStr(intCol))
                    If strHoursEntered <> "" And strHoursEntered <> "0" Then
                        'strSQLQuery = strSQLQuery & "Exec usp_Ins_tbl_PM_DailyActivity NULL," & strTaskID & "," & intProjectID & "," & Session("intUserID") & "," & Session("intPostID") & ",'" & Request.Form("txtEntryDate")(intCol) & "'," & strHoursEntered & ", NULL"
                        'strSQLQuery = strSQLQuery & "Exec usp_Ins_tbl_PM_DailyActivity_WeeklyView NULL," & strTaskID & "," & intProjectID & "," & Session("intUserID") & "," & Session("intPostID") & ",'" & Request.Form("txtEntryDate")(intCol) & "'," & strHoursEntered & ", NULL"

                        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                        '  strSQLQuery = strSQLQuery & "Exec usp_Ins_tbl_PM_DailyActivity_WeeklyView NULL," & strTaskID & "," & strSaveAgainstProjectID & "," & m_strSessionUserID & "," & m_strSessionPostID & ",'" & Trim(strArrDates(intCol - 1)) & "'," & strHoursEntered & ", NULL"
                        strSQLQuery.Append("Exec usp_Ins_tbl_PM_DailyActivity  NULL," & strTaskID & "," & strSaveAgainstProjectID & "," & m_strSessionUserID & "," & m_strSessionPostID & ",'" & Trim(strArrDates(intCol - 1)) & "'," & strHoursEntered & ", NULL,NULL,NULL")

                        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                        If Trim(MyBase.GetFormValue("txtDuChRow" & intRow & "Col" & intCol)) = "1" Then
                            strSQLQuery.Append(",1")
                        Else
                            strSQLQuery.Append(",0")
                        End If
                        'End Of Modifications

                        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                        If MyBase.GetFormValue("chkTaskCompleted" & strTaskID) <> "" Then
                            strSQLQuery.Append(",1")
                        Else
                            strSQLQuery.Append(",0")
                        End If
                        If MyBase.GetFormValue("txtPercentComplete" + strTaskID) <> "" Then
                            If m_blnResourceLevelTaskCompletion Then
                                strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & ",1")
                            Else
                                strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & ",0")
                            End If
                        End If


                        strSQLQuery.Append(vbCrLf)
                        blnUpdated = True
                        'End Of Modifications

                        ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
                        If m_intFlag = 1 Then
                            strSQL.Append("EXEC Usp_Upd_UserStoryStatus '" & strTaskID & "'," & m_intProjectID & ",8")
                            strSQL.Append(vbCrLf)
                        End If
                        ''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology Issue Fix : 57807)

                    End If
                Next

                'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                'Added Additional blnUpdated condition
                ' Update the Task complete status for each Task.
                blnTaskComplete = False
                If MyBase.GetFormValue("txtPercentComplete" + strTaskID) <> "" And blnUpdated = False Then
                    If CType(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), Integer) <> 0 Then
                        If m_blnResourceLevelTaskCompletion Then
                            'Used the InsertOrUpdateData function in place of GetDataReder - Modified By PadmnabhA
                            'CommonFunctions.Data.GetDataReader("UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTaskID, MyBase.UseSQL)
                            '--- Modified by purvaj on 19 Nov 2008 for Whiziblesem 8.0 
                            '--- Logic modified. DO not consider Resource allowed to mark task as complete.
                            '--- in any condition update both the fields ActualPercentComplete and ResourcePercentComplete
                            '--- ResourcePercentComplete = FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) added here
                            If CType(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), Integer) <> 100 Then
                                CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & ", ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTaskID, MyBase.UseSQL)
                            Else
                                blnTaskComplete = True
                            End If

                        Else
                            'Used the InsertOrUpdateData function in place of GetDataReder - Modified By PadmnabhA
                            'CommonFunctions.Data.GetDataReader("UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTaskID, MyBase.UseSQL)
                            '--- Modified by purvaj on 19 Nov 2008 for Whiziblesem 8.0 
                            '--- Logic modified. DO not consider Resource allowed to mark task as complete.
                            '--- in any condition update both the fields ActualPercentComplete and ResourcePercentComplete
                            '--- ActualPercentComplete = FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) added here
                            CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & ", ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTaskID, MyBase.UseSQL)
                        End If
                    End If
                    '--- added By purvaj on 19 Nov 2008 for Whiziblesem 8.0 for Task status management actual % complete
                    '--- Parent task's Actual % complete recalculated depending on the  % entered for child task
                    CommonFunction.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + strTaskID + ",',0", True)
                    '--- End addition purvaj
                End If

                'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                'Added Additional blnUpdated condition
                ' If the task is marked as completed, then update the task status in the database.
                If (MyBase.GetFormValue("chkTaskCompleted" & strTaskID) <> "" And blnUpdated = False) Or blnTaskComplete = True Then
                    strSQLQuery.Append(" Exec usp_Upd_ProjectTaskComplete " & strTaskID & ", 1 " + vbCrLf)
                    '22 April 2004. Updated in the above SP.
                    'If the Task is marked complete, then set ActualPercentComplete = 100%
                    'CommonFunctions.Data.GetDataReader("UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = 100 WHERE TaskID = " + strTaskID, MyBase.UseSQL)

                End If
            Next

            'Execute the query.
            If strSQLQuery.ToString <> "" Then
                'DEADLOCK ISSUE - VidyaJ
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
            End If
            strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
            strSQLQuery.Append("")

            ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
            If m_intFlag = 1 Then
                If strSQL.ToString <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
                End If
                strSQL.Remove(0, strSQL.ToString.Length)
                strSQL.Append("")
            End If
            ''End of Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)

            ' If the Back link was clicked, then the user must be redirected to DA page.
            If Request.QueryString("ReturnToDA") = "1" Then
                Response.Redirect("PM_DailyActivity.aspx")
            End If
        End If

        '-----------------------------------------------------
        ' IF PREVIOUS INITIALIZATIONS WERE INCOMPLETE, THEN...
        '-----------------------------------------------------
        ' Get the project and task type of the task for which an DA entry was last filled.
        ' 'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
        'Added Below if condition
        ''Commented by PrashantSJ on 17th Sep 2009 : Purpose: for performance reason we have comment this code (las DA filled DA)
        'If m_intProjectID = "0" Or m_strSelectedTaskType = "0" Then
        '    'Modified By VarunA on 4-Jan-2008
        '    'Purpose : Changes for Project Access to middle level Role
        '    'drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_GetDailyActivityParameters 1, " & m_strSessionUserID, MyBase.UseSQL)
        '    drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_GetDailyActivityParameters 1, " & m_strSessionUserID & ",Null,'" & m_strProjectFilters & "'", MyBase.UseSQL)
        '    'End By VarunA on 4-Jan-2008
        '    If drDailyActivity.Read Then
        '        If m_intProjectID = "0" Then m_intProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)

        '        ' Added by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 

        '        'Sets the first project which is not on hold.
        '        If InStr(1, m_strProjectsOnHold, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
        '            m_intProjectID = m_strFirstNotOnHoldProject
        '        End If

        '        ' End Addition by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 
        '        '''<Summary>
        '        '' Added By: PrashantSJ
        '        '' date: 27th May 2008
        '        ''Purpose: DA blocked for particular project from project workflow.
        '        '''</Summary>
        '        'Sets the first project which is not on hold.
        '        If InStr(1, m_strProjectsDABlocked, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
        '            m_intProjectID = m_strFirstNotOnHoldProject
        '        End If
        '        ''End of addition by PrashantSJ on 27th May 2008
        '        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
        '        If m_intProjectID <> "" Then
        '            Dim drProjectSettings As IDataReader
        '            Dim strSQL As String
        '            ''Code added by VidtaJ on 28th May 2007 for SP8 - Performance

        '            ' Commented and Added By MahendraV On 2:14 PM 5/31/2007 for SP8 - Performance
        '            ' Start_MV_5/31/2007
        '            'strSQL = "SELECT ProjectName,ResourceLevelTaskCompletion,CAST(EnforceConstraints AS BIT) EnforceConstraints FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID =  " & m_intProjectID
        '            strSQL = strSQLTaskCaseStructure
        '            drProjectSettings = CommonFunction.Data.GetDataReader(strSQL, True)
        '            ' End_MV_5/31/2007 drProjectSettings = CommonFunction.Data.GetDataReader(strSQL, True)
        '            strSQL = ""
        '            If drProjectSettings.Read Then
        '                m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drProjectSettings("ResourceLevelTaskCompletion")), False, drProjectSettings("ResourceLevelTaskCompletion")), Boolean)
        '                m_blnEnforceConstraints = CType(CommonFunction.Data.CheckIsDBNull(drProjectSettings("EnforceConstraints"), "0"), Boolean)
        '                m_strProjectName = Trim(CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings("ProjectName"), "0"), String))
        '            Else
        '                m_blnResourceLevelTaskCompletion = False
        '            End If
        '            CommonFunction.Data.DisposeDataReader(drProjectSettings)
        '        End If
        '        'End Of Modifications
        '        If m_strSelectedTaskType = "0" Then m_strSelectedTaskType = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "0")), String)
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(drDailyActivity)
        'End If
        '''End of addition by PrashantSJ on 17th Sep2009

        ' If still no project is selected, then select the first project by default.
        If m_intProjectID = "0" Then
            'Code Commented by DipaliS 5 Nov 2004
            'Purpose : issuid 13754
            'drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " & m_strSessionUserID, MyBase.UseSQL)
            'Code Added by DipaliS 5 Nov 2004
            'Purpose : issuid 13754
            drProject = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA " & m_strSessionUserID & ",NULL,'" & m_strProjectFilters & "'", MyBase.UseSQL)
            'End addition by DipaliS
            If drProject.Read Then
                m_intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drProject)

            ' Added by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 

            'Sets the first project which is not on hold.
            If InStr(1, m_strProjectsOnHold, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
                m_intProjectID = m_strFirstNotOnHoldProject
            End If

            ' End Addition by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11766 
            '''<Summary>
            '' Added By: PrashantSJ
            '' date: 27th May 2008
            ''Purpose: DA blocked for particular project from project workflow.
            '''</Summary>
            'Sets the first project which is not on hold.
            If InStr(1, m_strProjectsDABlocked, "," + m_intProjectID + ",", CompareMethod.Text) <> 0 Then
                m_intProjectID = m_strFirstNotOnHoldProject
            End If
            ''End of addition by PrashantSJ on 27th May 2008
            'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
            If m_intProjectID <> "" Then
                Dim drProjectSettings As IDataReader
                Dim strSQL As String
                'Code modified by vidyaj - 28th may - SP8 Performance

                ' Commented and Added By MahendraV On 2:14 PM 5/31/2007 for SP8 - Performance
                ' Start_MV_5/31/2007
                'strSQL = "SELECT ProjectName,ResourceLevelTaskCompletion,CAST(EnforceConstraints AS BIT) EnforceConstraints FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID =  " & m_intProjectID
                strSQL = strSQLTaskCaseStructure
                drProjectSettings = CommonFunction.Data.GetDataReader(strSQL, True)
                ' End_MV_5/31/2007 drProjectSettings = CommonFunction.Data.GetDataReader(strSQL, True)
                strSQL = ""
                If drProjectSettings.Read Then
                    m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(drProjectSettings("ResourceLevelTaskCompletion")), False, drProjectSettings("ResourceLevelTaskCompletion")), Boolean)
                    m_blnEnforceConstraints = CType(CommonFunction.Data.CheckIsDBNull(drProjectSettings("EnforceConstraints"), "0"), Boolean)
                    m_strProjectName = Trim(CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings("ProjectName"), "0"), String))
                Else
                    m_blnResourceLevelTaskCompletion = False
                End If
                CommonFunction.Data.DisposeDataReader(drProjectSettings)
            End If
            'End Of Modifications

        End If


        'Added By MahendraV On 12:18 PM 5/29/2007 For allowing IsBackdateing and IsForwardDating
        'Start_MV_5/29/2007 

        drTotalHours = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Daily_WorkingHours_Office " & m_intProjectID & ", '" & m_strHoursValidation & "'", MyBase.UseSQL)
        If drTotalHours.Read() Then
            m_dblTotalWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drTotalHours("WorkingHours"), "0"), Double)
        End If
        CommonFunction.Data.DisposeDataReader(drTotalHours)
        CommonFunction.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (" & m_dblTotalWorkHours & " - 0); </Script>")

        If m_strBackdatingExpiry <> "" Or m_strFwddatingExpiry <> "" Then
            Dim drBackDatedConf As IDataReader
            drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_intProjectID, MyBase.UseSQL)


            If drBackDatedConf.Read() Then
                'Entry exists for the current project and current user in configuration table
                If m_strBackdatingExpiry <> "" Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsBackDating"), "0"), Boolean) = False Then
                        m_blnProjectBackdateEntry = False
                    Else
                        m_blnProjectBackdateEntry = True
                    End If
                Else
                    m_blnProjectBackdateEntry = True
                End If
                'Entry exists for the current project and current user in configuration table
                If m_strFwddatingExpiry <> "" Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsForwardDating"), "0"), Boolean) = False Then
                        m_blnProjectFwddateEntry = False
                    Else
                        m_blnProjectFwddateEntry = True

                    End If
                Else
                    m_blnProjectFwddateEntry = True
                End If

            Else
                'Entry Doesnot exist for the current project and current user in configuration table
                m_blnProjectBackdateEntry = False
                m_blnProjectFwddateEntry = False
            End If
            CommonFunction.Data.DisposeDataReader(drBackDatedConf)
        Else
            m_blnProjectBackdateEntry = True
            m_blnProjectFwddateEntry = True
        End If
        'End_MV_5/29/2007 


        ' If still not task type selected, then select MPP Tasks by default.
        If m_strSelectedTaskType = "0" Then
            m_strSelectedTaskType = PROJECT_SPECIFIC_TASKS
        End If

        ' Select the selected date. (The user may specify a specific date, and tasks for that week must be shown.)
        If MyBase.GetFormValue("txtSelectedDate") <> "" Then
            dtmSelectedDate = FixString(MyBase.GetFormValue("txtSelectedDate"), 0, False, True)
        Else
            If m_blnUseClientDateForDA = True Then
                dtmSelectedDate = CommonFunctions.Dates.GetDate(Date.Parse(m_strSessionClientDate))
                dtmSelectedDate = CommonFunctions.Dates.GetDate(Date.Parse(m_strSessionClientDate))
            Else
                dtmSelectedDate = CommonFunctions.Dates.GetDate(Date.Now)
            End If
        End If

        ' Get the date range for this week.
        ' If the date range is not specified, then retrieve the current week's date range from the database.
        If Request.QueryString("FromDate") = "" And Request.QueryString("ToDate") = "" Then
            CommonFunction.Dates.GetFromAndToDates("1", dtmFromDate, dtmToDate, dtmSelectedDate)
            dtmToDate = DateAdd("d", 6, dtmFromDate).ToString("dd-MMM-yyyy")
        Else
            dtmFromDate = Request.QueryString("FromDate")
            dtmToDate = Request.QueryString("ToDate")
        End If


        CommonFunctions.General.WriteHTML("<input type='hidden' name='txtFromDate' value='" + dtmFromDate + "'>")
        CommonFunctions.General.WriteHTML("<input type='hidden' name='txtToDate' value='" + dtmToDate + "'>")

        CommonFunctions.General.WriteHTML("<table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td align='left'>")

        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TIMESHEET") + " (" + CommonFunctions.Dates.CGetDate(Date.Parse(dtmFromDate)) + " - " + CommonFunctions.Dates.CGetDate(Date.Parse(dtmToDate)) + ")")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TOTAL_HRS") + MyBase.GetResourceString("ALL_PROJECTS"))

        'Get the Total hours of daily activity enters for this week.
        ' 'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
        'Added additional parameters to SP to get total hours task type wise

        '' START : Integrated by ParagD for whizible SP 7.2
        '' Commented & Modified By ParagD On 30-June-2006
        '' Purpose : DSS 1985 - Weekly view of timesheet wrong total for the project selected.

        '' Added ProjectID parameter in the following SP to show Actual Work Hours for the selected Week 
        '' with Selected Project only.
        '' drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL, 1, 1,0,1,0", MyBase.UseSQL)
        If m_intProjectID <> "" Then
            drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & "," & m_intProjectID & ",NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL, 1, 1,0,1,0", MyBase.UseSQL)
        Else
            drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL, 1, 1,0,1,0", MyBase.UseSQL)
        End If
        '' END : Commented & Modified By ParagD On 30-June-2006
        '' END : Integrated by ParagD for whizible SP 7.2

        ' If drDailyActivity.Read Then
        While drDailyActivity.Read
            If CType(drDailyActivity("WhichTask"), String) = "D" Then
                m_TotalGeneralHours_ForProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Double)
            End If
            If CType(drDailyActivity("WhichTask"), String) = "O" Then
                m_TotalAssignedHours_ForProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Double)
            End If
            If CType(drDailyActivity("WhichTask"), String) = "M" Then
                m_TotalMPPHours_ForProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Double)
            End If
            If CType(drDailyActivity("WhichTask"), String) = "B" Then
                m_TotalIssuesHours_ForProject = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Double)
            End If
        End While
        ''m_TotalHours = m_TotalGeneralHours + m_TotalAssignedHours + m_TotalMPPHours + m_TotalIssuesHours
        m_TotalHours = m_TotalGeneralHours_ForProject + m_TotalAssignedHours_ForProject + m_TotalMPPHours_ForProject + m_TotalIssuesHours_ForProject
        'CommonFunctions.General.WriteHTML(FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Integer), 2))
        CommonFunctions.Data.DisposeDataReader(drDailyActivity)
        'End of modifications

        ''START : ParagD 24-Aug-2006

        'Commented By VidyaJ - Sp8 Performance
        'drDailyActivityForAllProjects = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL, 1, 1,0,1,0", MyBase.UseSQL)
        'While drDailyActivityForAllProjects.Read
        '    If CType(drDailyActivityForAllProjects("WhichTask"), String) = "D" Then
        '        m_TotalGeneralHours = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivityForAllProjects("TotalHours"), "0"), Double)
        '    End If
        '    If CType(drDailyActivityForAllProjects("WhichTask"), String) = "O" Then
        '        m_TotalAssignedHours = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivityForAllProjects("TotalHours"), "0"), Double)
        '    End If
        '    If CType(drDailyActivityForAllProjects("WhichTask"), String) = "M" Then
        '        m_TotalMPPHours = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivityForAllProjects("TotalHours"), "0"), Double)
        '    End If
        '    If CType(drDailyActivityForAllProjects("WhichTask"), String) = "B" Then
        '        m_TotalIssuesHours = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivityForAllProjects("TotalHours"), "0"), Double)
        '    End If
        'End While
        'm_TotalHoursForAllProjects = m_TotalGeneralHours + m_TotalAssignedHours + m_TotalMPPHours + m_TotalIssuesHours
        m_TotalHoursForAllProjects = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_GetDailyActivityTotalHours " & m_strSessionUserID & ",'" & dtmFromDate & "','" & dtmToDate & "'", MyBase.UseSQL), "0"), Double)

        CommonFunctions.General.WriteHTML(FormatNumber(m_TotalHoursForAllProjects, 2))
        'CommonFunctions.Data.DisposeDataReader(drDailyActivityForAllProjects)
        ''START : ParagD 24-Aug-2006
        ' End If



        'Get the total hours work that is expected of the person, for the week.
        ' 'Modified By VidyaJ for IssueID - 20315 (DA Performance) 
        ' drCompanyWeekHours = CommonFunctions.Data.GetDataReader("usp_Get_CompanyWeekHours", MyBase.UseSQL)
        ' If drCompanyWeekHours.Read Then

        '--- Added By purvaj on 6 Nov 2008 for WhizibleSEM 8.0
        '--- Total week hours will be calculated based on the resource OU working days and work hours
        m_TotalWeekHours = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_ExpectedWorkHours " + Session("intUserID").ToString + ",'" + dtmFromDate.ToString + "','" + dtmToDate.ToString + "'", True), "0")
        '--- End addition purvaJ

        CommonFunctions.General.WriteHTML(" / " + FormatNumber(m_TotalWeekHours, 2) + " " + MyBase.GetResourceString("HRS"))
        ' End If
        ' CommonFunctions.Data.DisposeDataReader(drCompanyWeekHours)
        'End Of Modifications

        '###########################################################################
        '
        ' Plots the Radio Buttons on the top of the page which are actually filters
        ' to show the Weekly View.
        '
        '###########################################################################

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellSpacing='0' width='99.9%'>")

        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td align='left' colspan='5'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_PROJECT"))

        'Code commented by DipaliS 4 Nov 2004
        'Purpose : For Issue 13754
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA " & m_strSessionUserID, 0, m_intProjectID, " language=Javascript OnFocus=cboProject_OnFocus() OnChange=cboProject_OnChange() "))
        'Code Added by dipaliS 4 Nov 2004
        'Purpose : For Issue 13754
        'Modified by sandipL on 1 Feb 2006 --IssueID 1821
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA " & m_strSessionUserID & ",NULL,'" & m_strProjectFilters & "'", 0, m_intProjectID, " language=Javascript OnFocus=cboProject_OnFocus() OnChange=cboProject_OnChange() "))
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_strSessionUserID & ",1", 0, m_intProjectID, " language=Javascript OnFocus=cboProject_OnFocus() OnChange=cboProject_OnChange() "))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_strSessionUserID & ",1,1", 0, m_intProjectID, " language=Javascript OnFocus=cboProject_OnFocus() OnChange=cboProject_OnChange() "))
        CommonFunctions.General.WriteHTML("<a Href='javascript:SelectProject(this)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='Click here to select project...'></a>")
        'Added By VarunA on 27-Dec-2007
        'Purpose : To have the correct Project Name when there is first hit on Weekly View same as dropdown of Project Name

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_strProjectName = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ProjectName FROM tbl_PM_Project WITH (NOLOCK) WHERE ProjectID =  " & m_intProjectID, MyBase.UseSQL), ""), String)
        m_strProjectName = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_tbl_PM_Project_ProjectName  " & m_intProjectID, MyBase.UseSQL), ""), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


        'End By VarunA on 27-Dec-2007
        'End Modification by SandipL on 1 Feb 20
        'End addition by DipaliS

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , m_intTaskFilter = ALL_TASKS, CStr(ALL_TASKS), , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_ALL_TASKS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:20%' colspan='4'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , m_intTaskFilter = TASKS_FOR_THE_WEEK, CStr(TASKS_FOR_THE_WEEK), , " language=JavaScript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOW_SELECTED_WEEK_TASK"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optGeneralTasks", , m_strSelectedTaskType = GENERAL_TASKS, GENERAL_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GENERAL_TASKS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optMPPTasks", , m_strSelectedTaskType = PROJECT_SPECIFIC_TASKS, PROJECT_SPECIFIC_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MPP_TASKS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optAssignedTasks", , m_strSelectedTaskType = ASSIGNED_TASKS, ASSIGNED_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ASSIGNED_TASKS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , m_strSelectedTaskType = DEFECTS_ASSIGNED, DEFECTS_ASSIGNED, , " Language=javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ISSUES_ASSIGNED"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , m_strSelectedTaskType = ALL_TASK_TYPES, CStr(ALL_TASK_TYPES), , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ALL_TASKS_TO_ME"))
        CommonFunctions.General.WriteHTML("</td>																						")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>	")
        CommonFunctions.General.WriteHTML("<br>")

        '###########################################################################
        PlotList()

    End Sub

    Private Sub PlotList()
        '=====================================================================
        ' Procedure Name        : PlotList()	
        ' Purpose               : Plots the List of Daily Activity Matrix.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================

        ''Code Commented and added by VidyaJ on 29th May - SP8 Performance
        'Use Dataset instead of data reader
        'Dim drProject As IDataReader
        'Dim drTasks As IDataReader
        'Dim drDailyActivity As IDataReader

        Dim intRecordCount As Integer
        Dim intRowStartIndex As Integer
        Dim intRowEndIndex As Integer
        Dim intRow As Integer
        Dim intCol As Integer
        Dim dtmEntryDate As String
        Dim strWeekDay As String
        Dim strPrevTaskType As String
        Dim strMaxEntryDate As String
        ''Code added by VidyaJ on 29h May 2007 - SP8 Performance
        Dim dsTasks As DataSet = New DataSet
        Dim dsDailyActivity As DataSet = New DataSet
        Dim drTasks As DataRow
        Dim drDailyActivity As DataRow
        ''End of addition 

        'Integrated by MrugajaB on 25th April,2005 for WhizibleSEM SP3
        ' Code Added by RajkumarM on 6th March 05 ONSITE
        Dim intStartingDayofWeek As Integer
        ' Commented and Added By MahendraV On 2:12 PM 5/29/2007 for Company Information Optimization
        ' Start_MV_5/29/2007

        'drProject = CommonFunction.Data.GetDataReader("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL)
        'If drProject.Read Then
        '    intStartingDayofWeek = CType(CommonFunctions.Data.CheckIsDBNull(drProject("StartingDayofweek"), "0"), Integer) + 1

        'End If
        'CommonFunctions.Data.DisposeDataReader(drProject)
        intStartingDayofWeek = CommonFunction.Application.StartingDayofweek + 1
        ' End_MV_5/29/2007

        If intStartingDayofWeek = 8 Then intStartingDayofWeek = 1
        ' End of Addition ONSITE
        'End Integration
        'Modified By VidyaJ for IssueID - 20315 (DA Performance)  - remove outer DIV
        'Modified Div Height from 350 to 340
        ''PrashantSJ on 17th Sep 2009
        'CommonFunction.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;Height:340px'>")
        CommonFunction.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;'>")
        ''End of addition by PrashantSJ on 17th Sep 2009
        CommonFunction.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%'>")
        ' If the project has been selected, then proceed.
        If m_intProjectID <> "0" Then
            If m_blnDisableWVForTaskTypeProjects = True Then
                m_blnIsTaskTypeProject = False
                'Code Commented by VidyaJ - For ISSUEID - 16703
                'drProject = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_intProjectID, MyBase.UseSQL)
                'If drProject.Read Then
                '    m_blnIsTaskTypeProject = CType(CommonFunctions.Data.CheckIsDBNull(drProject("HaveSubTaskTypes"), "0"), Boolean)
                'End If
                'CommonFunctions.Data.DisposeDataReader(drProject)

                'End

            End If

            If Not (m_blnDisableWVForTaskTypeProjects = True And m_blnIsTaskTypeProject = True) Then
                ' BUILD THE QUERY ACCORDING TO THE OPTION SELECTED.
                '--------------------------------------------------
                strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
                strSQLQuery.Append("usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " + m_intProjectID + "," + m_strSessionUserID)

                Select Case m_strSelectedTaskType

                    Case DEFECTS_ASSIGNED
                        strSQLQuery.Append(", 1,    NULL, NULL, NULL")
                    Case GENERAL_TASKS
                        strSQLQuery.Append(", NULL, 1,    NULL, NULL")
                    Case PROJECT_SPECIFIC_TASKS
                        strSQLQuery.Append(", NULL, NULL, 1,    NULL")
                    Case ASSIGNED_TASKS
                        strSQLQuery.Append(", NULL, NULL, NULL, 1   ")
                    Case ALL_TASK_TYPES
                        If m_blnIncludeGeneralTasks Then
                            strSQLQuery.Append(", 1,	 1,	   1,	 1   ")
                        Else
                            strSQLQuery.Append(", 1,	 NULL, 1,	 1   ")
                        End If
                    Case Else
                        strSQLQuery.Append(", NULL, 1,    NULL, NULL")
                        m_strSelectedTaskType = PROJECT_SPECIFIC_TASKS
                End Select

                ' All Tasks or Weekly Tasks.		
                If m_intTaskFilter = TASKS_FOR_THE_WEEK Then
                    strSQLQuery.Append(", 1")
                Else
                    strSQLQuery.Append(", NULL")
                End If

                strSQLQuery.Append(",'" & dtmFromDate & "'")
                strSQLQuery.Append(",'" & dtmToDate & "'")

                'Added By JayavantK on 06 Oct 2004
                'To Add the Role level access to the General Tasks.
                'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                If m_strSelectedTaskType = GENERAL_TASKS Or m_strSelectedTaskType = ALL_TASK_TYPES Then
                    Dim lngProjectRoleID As Long = 0
                    Dim strQuery As New System.Text.StringBuilder("")

                    strQuery.Append("SELECT Role FROM tbl_PM_ProjectEmployeeRole WITH (NOLOCK) WHERE ProjectID=" & m_intProjectID.ToString())
                    strQuery.Append(" AND EmployeeID=" & m_strSessionUserID.ToString())
                    lngProjectRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery.ToString, MyBase.UseSQL), "0"), Long)
                    strQuery = Nothing

                    'Added by DipaliS 6 Nov 2004
                    ' IssueID 13831
                    If lngProjectRoleID = 0 Then
                        lngProjectRoleID = CType(m_strSessionPostID, Integer)
                    End If
                    'End addition by Dipalis

                    strSQLQuery.Append(",null,null,null,null, " & lngProjectRoleID.ToString())
                End If
                'Addition Ends

                'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                ' Retrieve the values in the recordset.
                ' drTasks = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                ' INITIALIZATIONS.
                '-----------------
                ' These values are the start and end indexes of the row boundaries of the entire skill matrix.

                intRowStartIndex = 0
                intRecordCount = 0

                'While drTasks.Read
                '    intRecordCount = intRecordCount + 1
                'End While

                '''Code Commented by VidyaJ on 29th May 2007 - SP8 Performance
                'If m_strSelectedTaskType = GENERAL_TASKS Or m_strSelectedTaskType = ALL_TASK_TYPES Then
                '    intRecordCount = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString & ",1", True), Integer)
                'Else
                '    intRecordCount = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString & ",null,null,null,null,null,1", True), Integer)
                'End If
                'End Of Modifications

                ' Retrieve the values in the recordset.
                '''Code Modified by VidyaJ on 29th May 2007 - SP8 Performance
                'drTasks = CommonFunctions.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
                dsTasks = CommonFunctions.Data.GetDataSet(strSQLQuery.ToString, "Tasks", , , MyBase.UseSQL)
                intRecordCount = dsTasks.Tables(0).Rows.Count

                strSQLQuery.Remove(0, strSQLQuery.ToString.Length)


                If intRecordCount = 0 Then
                    intRowEndIndex = 1
                Else
                    intRowEndIndex = intRecordCount
                End If

                CommonFunctions.General.WriteHTML("<script language=javascript>")
                CommonFunctions.General.WriteHTML("initArray()")
                CommonFunctions.General.WriteHTML("</script>")

                ReDim dblArray_TaskWiseTotalHrs(intRecordCount)

                ' Initialise the total hours per task.
                For intRow = 0 To intRecordCount - 1
                    dblArray_TaskWiseTotalHrs(intRow) = 0
                Next

                ' Initialise the total hours per day.
                For intCol = 0 To 6
                    dblArray_DayWiseTotalHrs(intCol) = 0
                Next

                ' If the at least one record is found, then proceed.
                Dim i As Integer
                If intRecordCount <> 0 Then
                    CommonFunctions.General.WriteHTML("<script language=""Javascript"">")
                    CommonFunctions.General.WriteHTML("var dblTaskDetails = new Array(" + CStr(intRecordCount + 1) + ");")
                    CommonFunctions.General.WriteHTML("var dblHours = new Array(" + CStr(intRecordCount + 1) + ");")

                    For i = 0 To intRecordCount + 1
                        CommonFunctions.General.WriteHTML("dblHours[" & i & "] = new Array(7);")
                    Next

                    CommonFunctions.General.WriteHTML("var intRow; var intCol;")
                    CommonFunctions.General.WriteHTML("for(intRow = 0; intRow <= " + CStr(intRecordCount) + "; intRow++) {")
                    ' To insert line feed in the DLL.
                    CommonFunctions.General.WriteHTML("for(intCol = 0; intCol<=7; intCol++) {")
                    CommonFunctions.General.WriteHTML("dblHours[intRow][intCol] = -1;")
                    CommonFunctions.General.WriteHTML("}}")
                    CommonFunctions.General.WriteHTML("</script>")
                    '=====================================================================
                    ' DISPLAY THE COLUMN HEADERS.
                    '=====================================================================
                    CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
                    CommonFunction.General.WriteHTML("<td>" + MyBase.GetResourceString("TASK_NAME") + "</td>")
                    If m_strSelectedTaskType <> GENERAL_TASKS Then
                        CommonFunction.General.WriteHTML("<td align='center' TITLE='" + MyBase.GetResourceString("TOOLTIP_ALLOCATED_HRS") + "' width='60'>" + MyBase.GetResourceString("ALLOCATED_HRS") + "</td>")
                        CommonFunction.General.WriteHTML("<td align='center' TITLE='" + MyBase.GetResourceString("TOOLTIP_ACTUAL_WORK") + "' width='60'>" + MyBase.GetResourceString("ACTUAL_WORK") + "</td>")
                    End If
                    '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
                    Dim DrHolidayLeave As IDataReader
                    Dim IsHolidayOrLeave As Boolean
                    Dim intWorkingDays As Integer
                    DrHolidayLeave = CommonFunction.Data.GetDataReader("usp_sel_WeeklyView_HolidayORLeaveStatus " + m_strSessionUserID.ToString + ",'" + dtmFromDate.ToString + "'", True)
                    DrHolidayLeave.Read()
                    intWorkingDays = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrHolidayLeave("WorkingDays"), "5"), "5")
                    '--- End addition Purvaj

                    For intCol = 1 To 7
                        ' GET THE NUMBER OF HOURS OF DAILY ACTIVITY ENTERED FOR THE DAY.
                        '---------------------------------------------------------------
                        dtmEntryDate = CommonFunctions.Dates.GetDate(DateAdd("d", intCol - 1, CDate(dtmFromDate)))
                        'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                        ' drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmEntryDate & "','" & dtmEntryDate & "',NULL,1,1", MyBase.UseSQL)
                        'If drDailyActivity.Read Then
                        strClientSideScript.Append("dblHours[0][" & intCol & "] =0; ") '& CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String) & ";" & vbCrLf
                        ' End If
                        ' CommonFunctions.Data.DisposeDataReader(drDailyActivity)
                        'End Of Modifications

                        'Code commented by MrugajaB on 25th April,2005
                        'strWeekDay = WeekdayName(intCol, True, vbMonday)

                        'Code integrated by MrugajaB on 25th April,2005 for WhizibleSEM SP3 
                        ' Code Modified by RajkumarM on 6th March 05 ONSITE
                        strWeekDay = WeekdayName(intCol, True, CType(intStartingDayofWeek, Microsoft.VisualBasic.FirstDayOfWeek))
                        ' End of Modification
                        'End Integration

                        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
                        IsHolidayOrLeave = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrHolidayLeave("Day" + intCol.ToString), "0"), "0"))
                        '--- End addition Purvaj

                        CommonFunction.General.WriteHTML("<td align='center' width='60' TITLE='" + CommonFunction.Dates.CGetDate(Date.Parse(dtmEntryDate)) + "'>")
                        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
                        If IsHolidayOrLeave = True Or intCol > intWorkingDays Then
                            CommonFunction.General.WriteHTML("<FONT color='red'>")
                        End If
                        '--- End addition Purvaj

                        CommonFunction.General.WriteHTML(strWeekDay + "<br>[" + GetShortDate(Date.Parse(dtmEntryDate)) + "]")
                        m_strTooltip(intCol) = strWeekDay + vbCrLf + "[" + GetShortDate(Date.Parse(dtmEntryDate)) + "]"
                        CommonFunction.General.WriteHTML("<input type='hidden' name='txtEntryDate' value='" + CommonFunction.Dates.GetDate(Date.Parse(dtmEntryDate)) + "'>")

                        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
                        If IsHolidayOrLeave = True Or intCol > intWorkingDays Then
                            CommonFunction.General.WriteHTML("</FONT>")
                        End If
                        '--- End addition Purvaj

                        CommonFunction.General.WriteHTML("</td>")
                    Next
                    '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
                    CommonFunction.Data.DisposeDataReader(DrHolidayLeave)
                    '--- End addition Purvaj

                    'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                    'Call the SP only once and store the data instead of firing it 7 times
                    'Call the SP only once and store the data instead of firing it 7 times
                    '''Code Modified by VidyaJ on 29th May 2007 - SP8 Performance
                    'drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1,1,0,0,1", MyBase.UseSQL)
                    dsDailyActivity = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1,1,0,0,1", "DailyActivity", , , MyBase.UseSQL)
                    intCol = 1
                    'If drDailyActivity.IsClosed = False Then
                    '    While drDailyActivity.Read
                    If dsDailyActivity.Tables(0).Rows.Count > 0 Then
                        For Each drDailyActivity In dsDailyActivity.Tables(0).Rows

                            'Commented By PrashantD on 12 jan 2006
                            'dtmEntryDate = CommonFunctions.Dates.GetDate(DateAdd("d", intCol - 1, CDate(dtmFromDate)))
                            'intCol = CType(DateDiff(DateInterval.Day, CType(dtmEntryDate, DateTime), CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("FromDate"), ""), DateTime)), Integer)
                            intCol = CType(DateDiff(DateInterval.Day, CType(dtmFromDate, DateTime), CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("FromDate"), ""), DateTime)), Integer)
                            'EndOf Addition and comment by PrashantD
                            ' if ctype(dtmEntryDate,DateTime)= CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("FromDate"), ""), datetime then
                            strClientSideScript.Append("dblHours[0][" & intCol + 1 & "] = " & CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String) & ";" & vbCrLf)
                            ' End If

                            'End While
                        Next
                    End If
                    'CommonFunctions.Data.DisposeDataReader(drDailyActivity)
                    'End Of Modifications


                    If m_strSelectedTaskType <> GENERAL_TASKS Then
                        CommonFunction.General.WriteHTML("<td align='center'>" + MyBase.GetResourceString("ACTUAL_PERCENT_COMPLETE") + "</td>")

                        'Modified by PrasannaP on 19th May 2004
                        ' If Not ENTERPRISE_CHANGES Then
                        CommonFunction.General.WriteHTML("<td align='center' TITLE='" + MyBase.GetResourceString("ACTUAL_PERCENT_COMPLETE") + "'>" + MyBase.GetResourceString("TASK_COMPLETE") + "</td>")
                        'End If
                        'End Modification.

                    End If
                    CommonFunction.General.WriteHTML("<td align='center' TITLE='" + MyBase.GetResourceString("TOOLTIP_ACTUAL_WORK_WEEK") + "' width='60'>" + MyBase.GetResourceString("ACTUAL_WORK_WEEK") + "</td>")
                    CommonFunction.General.WriteHTML("</tr>")

                    strPrevTaskType = ""
                    '=====================================================================
                    ' DISPLAY THE VALUES.
                    '=====================================================================
                    Dim intTaskID As String
                    Dim strTaskName As String
                    Dim strWhichTask As String
                    Dim dtmStartDate As String
                    Dim dtmEndDate As String
                    Dim dtmActualStartDate As String
                    Dim dtmActualEndDate As String
                    Dim blnTaskComplete As Boolean
                    Dim dblAllocatedWork As String
                    Dim dblActualWork As Double
                    Dim dblWorkDone As Double
                    Dim dblActualPercentComplete As String
                    Dim strConstraintDate As String
                    Dim strConstraintType As String
                    Dim blnTimeBookedAgainstTask As Boolean
                    Dim strTooltipConstraintType As String
                    Dim strClsTR() As String = {"'clsTROdd'", "'clsTREven'"}

                    'Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
                    Dim blnIsUserTask As Boolean
                    'End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

                    '''Code Modified by VidyaJ on 29th May 2007 - SP8 Performance
                    'For intRow = intRowStartIndex + 1 To intRowEndIndex
                    intRow = intRowStartIndex + 1
                    For Each drTasks In dsTasks.Tables(0).Rows
                        'drTasks.Read()
                        ' Retrieve the Task Details.
                        intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("TaskID"), "0"), String)
                        strTaskName = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("TaskName"), "0"), String)
                        strWhichTask = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("WhichTask"), "0"), String)
                        dtmStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("StartDate"), ""), String)
                        dtmEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("EndDate"), ""), String)
                        dtmActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ActualStartDate"), ""), String)
                        dtmActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ActualEndDate"), ""), String)
                        blnTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("IsTaskComplete"), "0"), Boolean)
                        dblAllocatedWork = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("Work"), "0"), String)
                        dblActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ActualWork"), "0"), Double)
                        dblWorkDone = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("WorkDone"), "0"), Double)

                        'Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
                        blnIsUserTask = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("IsUserStoryTask"), "0"), Boolean)
                        'End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

                        If m_blnResourceLevelTaskCompletion Then
                            dblActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ActualPercentComplete"), "0"), String)
                        Else
                            dblActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ResourcePercentComplete"), "0"), String)
                        End If
                        strConstraintType = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ConstraintType"), ""), String)

                        If dtmStartDate <> "" Then
                            dtmStartDate = CommonFunctions.Dates.GetDate(Date.Parse(dtmStartDate))
                        End If
                        If dtmEndDate <> "" Then
                            dtmEndDate = CommonFunctions.Dates.GetDate(Date.Parse(dtmEndDate))
                        End If
                        If dtmActualEndDate <> "" Then
                            dtmActualEndDate = CommonFunctions.Dates.GetDate(Date.Parse(dtmActualEndDate))
                        End If
                        If dtmActualStartDate <> "" Then
                            dtmActualStartDate = CommonFunctions.Dates.GetDate(Date.Parse(dtmActualStartDate))
                        End If

                        If strConstraintType <> "" Then

                            strConstraintDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("ConstraintDate"), ""), String)

                            Select Case strConstraintType
                                Case "0" 'as soon as possible
                                    strTooltipConstraintType = MyBase.GetResourceString("AS_SOON_AS_POSSIBLE")
                                Case "1" 'as late as possible
                                    strTooltipConstraintType = MyBase.GetResourceString("AS_LATE_AS_POSSIBLE")
                                Case "2" 'Must Start on 
                                    strTooltipConstraintType = MyBase.GetResourceString("MUST_START_ON")
                                Case "3" 'Must Finish on
                                    strTooltipConstraintType = MyBase.GetResourceString("MUST_FINISH_ON")
                                Case "4" 'start no earlier than 
                                    strTooltipConstraintType = MyBase.GetResourceString("START_NO_EARLIER")
                                Case "5" 'Start no later than
                                    strTooltipConstraintType = MyBase.GetResourceString("START_NO_LATER")
                                Case "6" 'Finish no eariler than
                                    strTooltipConstraintType = MyBase.GetResourceString("FINISH_NO_EARLIER")
                                Case "7" 'finish no later than
                                    strTooltipConstraintType = MyBase.GetResourceString("FINISH_NO_LATER")
                            End Select
                        Else
                            strTooltipConstraintType = MyBase.GetResourceString("NO_CONSTRAINTS")
                        End If
                        If strConstraintDate <> "" Then
                            If Date.Parse(strConstraintDate).ToString("yyyy") <> "1800" Then
                                strConstraintDate = CommonFunction.Dates.GetDate(Date.Parse(strConstraintDate))
                            Else
                                strConstraintDate = "None"
                            End If
                        End If

                        'Modified By VidyaJ for IssueID - 20315 (DA Performance) 
                        'Daily activity present against the task
                        ' strSQLQuery = "select dbo.udf_TimeBookedAgainstTask(" & intTaskID & ")"
                        ' blnTimeBookedAgainstTask = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), Boolean)
                        If dtmActualStartDate <> "" Then
                            blnTimeBookedAgainstTask = True
                        Else
                            blnTimeBookedAgainstTask = False
                        End If
                        'End Of Modification

                        If m_strSelectedTaskType <> GENERAL_TASKS Then
                            If blnTaskComplete = False Then
                                ' Get the number of hours of daily activity entered for the task.
                                strClientSideScript.Append("dblHours[" + CStr(intRow) + "][0] = " + CStr((CDbl(dblActualWork) + CDbl(dblWorkDone))) + ";" + vbCrLf)
                            End If
                        End If

                        'Get the other Task details.
                        'Added the ActualPercentComplete in the Array
                        If dtmStartDate = "" Then
                            strClientSideScript.Append("dblTaskDetails[" + CStr(intRow) + "] = new Array("""", """", " + dblAllocatedWork + ", """ + strWhichTask + """, " + dblActualPercentComplete + ", """ + strConstraintType + """, """ + strConstraintDate + """,""" & blnTimeBookedAgainstTask & """);" + vbCrLf)
                        Else
                            'Commented by Siddharths 24 Mar 2005 for issue id 17012
                            'Purpose : To remove the problem of page crash after clicking on the weekly view link on timesheet page.

                            ' strClientSideScript = strClientSideScript + "dblTaskDetails[" + CStr(intRow) + "] = new Array(""" + CDate(CommonFunction.Dates.GetDate(CType(dtmStartDate, Date))).ToString("dd-MMM-yyyy") + """, """ + CDate(CommonFunction.Dates.GetDate(CType(dtmEndDate, Date))).ToString("dd-MMM-yyyy") + """, " + dblAllocatedWork + ", """ + strWhichTask + """, " + dblActualPercentComplete & _
                            ' ", """ + strConstraintType + """, """ + strConstraintDate + """,""" & blnTimeBookedAgainstTask & """);" + vbCrLf
                            'End comment.

                            'Modified by Siddharths 24 Mar 2005 for issue id 17012
                            strClientSideScript.Append("dblTaskDetails[" + CStr(intRow) + "] = new Array(""" + dtmStartDate + """, """ + dtmEndDate + """, " + dblAllocatedWork + ", """ + strWhichTask + """, " + dblActualPercentComplete & _
                            ", """ + strConstraintType + """, """ + strConstraintDate + """,""" & blnTimeBookedAgainstTask & """);" + vbCrLf)
                            'End modification.
                        End If


                        'If All Task Types are shown, then they must be grouped according to the Task Types.
                        If m_strSelectedTaskType = ALL_TASK_TYPES Then
                            If strPrevTaskType <> strWhichTask Then
                                CommonFunction.General.WriteHTML("<tr class='clsTRSectionHeader'>")
                                CommonFunction.General.WriteHTML("<td align='left' colspan='14'>")
                                CommonFunction.General.WriteHTML("<p align='left'><b><i>")
                                Select Case strWhichTask
                                    Case PROJECT_SPECIFIC_TASKS
                                        Response.Write("MPP Tasks")
                                    Case ASSIGNED_TASKS
                                        Response.Write("Assigned Tasks")
                                    Case GENERAL_TASKS
                                        Response.Write("General Tasks")
                                    Case DEFECTS_ASSIGNED
                                        Response.Write("Issues Assigned")
                                End Select
                                CommonFunction.General.WriteHTML("</i></b>")
                                CommonFunction.General.WriteHTML("</p>")
                                CommonFunction.General.WriteHTML("</td>")
                                CommonFunction.General.WriteHTML("</tr>")

                                strPrevTaskType = strWhichTask
                            End If
                        End If

                        CommonFunction.General.WriteHTML("<tr class=" + strClsTR(1) + ">")
                        Response.Write("<td width='250' TITLE='")
                        Response.Write("[Task : " + CommonFunction.General.FormatString(Replace(strTaskName, """", "'")) & "]")
                        If strWhichTask <> GENERAL_TASKS Then
                            Response.Write(vbCrLf & MyBase.GetResourceString("STATUS") & vbTab & vbTab & vbTab & " = ")
                            If blnTaskComplete Then
                                Response.Write(MyBase.GetResourceString("COMPLETE"))
                            Else
                                Response.Write(MyBase.GetResourceString("IN_PROGRESS"))
                            End If
                            If dtmStartDate <> "" Then Response.Write(vbCrLf & MyBase.GetResourceString("START_DATE") & vbTab & vbTab & " = " & CommonFunction.Dates.CGetDateTime(Date.Parse(dtmStartDate)))
                            If dtmEndDate <> "" Then Response.Write(vbCrLf & MyBase.GetResourceString("END_DATE") & vbTab & vbTab & " = " & CommonFunction.Dates.CGetDateTime(Date.Parse(dtmEndDate)))
                            If dtmActualStartDate <> "" Then Response.Write(vbCrLf & MyBase.GetResourceString("ACTUAL_START_DATE") & vbTab & " = " & CommonFunction.Dates.CGetDateTime(Date.Parse(dtmActualStartDate)))
                            If dtmActualEndDate <> "" Then Response.Write(vbCrLf & MyBase.GetResourceString("ACTUAL_END_DATE") & vbTab & " = " & CommonFunction.Dates.CGetDateTime(Date.Parse(dtmActualEndDate)))

                            If strWhichTask = PROJECT_SPECIFIC_TASKS Then
                                Response.Write(vbCrLf & vbCrLf & "Constraint : " & strTooltipConstraintType)
                                If strConstraintType <> "" Then
                                    If CInt(strConstraintType) > 1 Then
                                        Response.Write(CommonFunction.General.FormatString(" '" & strConstraintDate & "'"))
                                    End If
                                End If
                            End If

                            Response.Write("' rowspan='2")
                        End If

                        Response.Write("'>")
                        'Added by VidyaJ on 3rd Nov 2004
                        ' Do not allow to add DA for completed tasks
                        If blnTaskComplete = False Then
                            If blnIsUserTask = True Then
                                CommonFunction.General.WriteHTML("<IMG src=""../../Images/Scrum/UserStory.gif""> <a href=""javascript:TaskLinkClick('" + CStr(intTaskID) + "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                            Else
                                CommonFunction.General.WriteHTML("<a href=""javascript:TaskLinkClick('" + CStr(intTaskID) + "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                            End If
                        Else
                            If blnIsUserTask = True Then
                                CommonFunction.General.WriteHTML("<IMG src=""../../Images/Scrum/UserStory.gif"">" + CommonFunction.General.FormatString(strTaskName))
                            Else
                                CommonFunction.General.WriteHTML(CommonFunction.General.FormatString(strTaskName))
                            End If

                        End If
                        CommonFunction.General.WriteHTML("<input type='hidden' id='txtTaskID' name='txtTaskID' value='" + intTaskID + "'>")
                        CommonFunction.General.WriteHTML("</td>")
                        If m_strSelectedTaskType <> GENERAL_TASKS Then
                            If strWhichTask <> GENERAL_TASKS Then
                                'Modified By PrasannaP on May 19th 2004
                                'If  ENTERPRISE_CHANGES Then
                                If m_blnResourceLevelTaskCompletion = False Then
                                    CommonFunction.General.WriteHTML("<td colspan='12' valign='top'>")
                                Else
                                    CommonFunction.General.WriteHTML("<td colspan='12' valign='top'>")
                                End If
                                'End Modification

                                If dtmStartDate <> "" Then Response.Write(MyBase.GetResourceString("START_DATE") + "= <b>" + CommonFunction.Dates.CGetDate(Date.Parse(dtmStartDate)) + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                                If dtmEndDate <> "" Then Response.Write(MyBase.GetResourceString("END_DATE") + "= <b>" + CommonFunction.Dates.CGetDate(Date.Parse(dtmEndDate)) + "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                                If dblWorkDone <> 0 Then Response.Write("<font color=blue><b>(" + FormatNumber(dblWorkDone, 2) + " hrs uploaded from the MPP.)</b>")
                                CommonFunction.General.WriteHTML("</td>")
                                CommonFunction.General.WriteHTML("</tr>")
                                CommonFunction.General.WriteHTML("<tr id=TR" + CStr(intTaskID) + " name=TR" + CStr(intRow) + " class=" + strClsTR(1) + ">")
                                CommonFunction.General.WriteHTML("<td width='65' valign='top' align='center' Title='Allocated Work (hrs)'>" + FormatNumber(dblAllocatedWork, 2) + "</td>")
                                CommonFunction.General.WriteHTML("<td width='60' valign='top' align='center' Title='Actual Work (hrs)' noWrap >")
                                If dblActualWork = 0 Then
                                    CommonFunction.General.WriteHTML("<b>" + CStr(dblActualWork) + "</b>")
                                Else
                                    CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails(" + m_intProjectID + ",''," + intTaskID + ",'','')""><b>" + FormatNumber(dblActualWork, 2) + "</b></a>")
                                End If
                                If dblWorkDone <> 0 Then
                                    CommonFunction.General.WriteHTML("<a HREF='javascript:ShowWorkDone(" + FormatNumber(dblWorkDone, 1) + ")'><font color='blue'><b>" + FormatNumber(dblWorkDone, 2) + "</b></font></a>")
                                End If
                                CommonFunction.General.WriteHTML("</td>")
                            Else
                                CommonFunction.General.WriteHTML("<td align='center'>N/A</td><td align='center'>N/A</td>")
                            End If
                        End If

                        For intCol = 1 To 7
                            dtmEntryDate = CommonFunction.Dates.GetDate(DateAdd("d", intCol - 1, CDate(dtmFromDate)))
                            strWeekDay = WeekdayName(intCol, True, vbMonday)
                            CommonFunction.General.WriteHTML("<td width='60' valign='top' align='center' title='" + m_strTooltip(intCol) + "'>")
                            ' NOTE: For general tasks, the textbox will be displayed irrespective of the TaskComplete Status.
                            Dim strDay As String = CType(CommonFunctions.Data.CheckIsDBNull(drTasks(strWeekDay), ""), String)

                            If Trim(strDay) = "" And (blnTaskComplete = False Or strWhichTask = GENERAL_TASKS) Then
                                If m_blnActualWorkHrs = True Then
                                    'Commented By MrugajaB on 30th April,2005
                                    '                                    CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("txtRow" & intRow & "Col" & intCol, "usp_Sel_GetActualHrs " + CStr(CommonFunction.Application.MinHoursForDAEntry), 0, , " Title='" + m_strTooltip(intCol) + "' Langugage=JavaScript OnChange=Hours_OnChange(this," & intRow & "," & intCol & ") ", True, True))
                                    'Integrated by MrugajaB on 30th April for integrating PBNV4 sp6 in WhizibleSEM sp3
                                    'Modified By MrugajaB on 3rd jan,2005 for Esstech Issue ID.13654 Hotfix ID.4.0.93-BF
                                    'Purpose:intTaskID was not getting passed as parameter when control to be plotted is ComboBox.Due to this javascript error was generated when call to 'Hours_Onchange()' function was given
                                    CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("txtRow" & intRow & "Col" & intCol, "usp_Sel_GetActualHrs " + CStr(CommonFunction.Application.MinHoursForDAEntry), 0, , " Title='" + m_strTooltip(intCol) + "' Langugage=JavaScript OnChange=Hours_OnChange(this," & intRow & "," & intCol & ",'" & intTaskID & "') ", True, True))

                                Else
                                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                                    CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtRow" & intRow & "Col" & intCol, "txtRow" & intRow & "Col" & intCol, , 45, 5, , "Right", , , , , , " Title='" + m_strTooltip(intCol) + "' Language=JavaScript OnBlur=Hours_OnChange(this," & intRow & "," & intCol & ",'" & intTaskID & "') onfocus=SaveValues(this,'dummy'," + CStr(intRow) + "," + CStr(intCol) + ") ", True, EnableHTMLEncode:=True))
                                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                                End If

                                If strWhichTask = PROJECT_SPECIFIC_TASKS Or strWhichTask = ASSIGNED_TASKS Or strWhichTask = DEFECTS_ASSIGNED Then
                                    CommonFunctions.General.WriteHTML("<input type='hidden' id='txtDuChRow" + CStr(intRow) + "Col" + CStr(intCol) + "' name='txtDuChRow" + CStr(intRow) + "Col" + CStr(intCol) + "' value='0'>")
                                End If
                            Else
                                If Trim(CType(CommonFunctions.Data.CheckIsDBNull(drTasks(strWeekDay), ""), String)) <> "" Then
                                    Response.Write("<a HREF=""javascript:ShowDetails(" + m_intProjectID + ",''," + intTaskID + ",'" + dtmEntryDate + "','" + dtmEntryDate + "')"">")
                                    Response.Write(FormatNumber(CType(CommonFunctions.Data.CheckIsDBNull(drTasks(strWeekDay), ""), String), 2))
                                    Response.Write("</a>")
                                    dblArray_TaskWiseTotalHrs(intRow - 1) = dblArray_TaskWiseTotalHrs(intRow - 1) + CType(CommonFunctions.Data.CheckIsDBNull(drTasks(strWeekDay), "0"), Double)
                                    dblArray_DayWiseTotalHrs(intCol - 1) = dblArray_DayWiseTotalHrs(intCol - 1) + CType(CommonFunctions.Data.CheckIsDBNull(drTasks(strWeekDay), "0"), Double)
                                End If
                            End If
                            CommonFunction.General.WriteHTML("</td>")
                        Next

                        If m_strSelectedTaskType <> GENERAL_TASKS Then
                            If strWhichTask <> GENERAL_TASKS Then
                                CommonFunction.General.WriteHTML("<td width='60' valign='top' align='center' Title='Actual % Complete'>")
                                If Not blnTaskComplete Then
                                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                                    CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtPercentComplete" + intTaskID, "txtPercentComplete" + intTaskID, , 45, 7, FormatNumber(dblActualPercentComplete, 2, , , TriState.False), "Right", , , , , , " onblur='javascript:txtActualPercentComplete_onblur(this, " + CStr(intRow) + ")' onfocus=SaveValues(this,'ActualComplete') ", True, True, EnableHTMLEncode:=True))
                                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                                Else
                                    CommonFunction.General.WriteHTML(FormatNumber(dblActualPercentComplete, 2, , , TriState.False))
                                End If
                                CommonFunction.General.WriteHTML("</td>")

                                'Modified by PrasannaP on May 19th 2004
                                'If Not ENTERPRISE_CHANGES Then

                                CommonFunction.General.WriteHTML("<td width='75' valign='top' align='center' Title='Task Complete?'>")
                                'Modified By VidyaJ - DA Performance Issue - 89 ( SP4)
                                'strMaxEntryDate = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_tbl_PM_DailyActivity_Max_EntryDate " + CStr(intTaskID), MyBase.UseSQL), "0"), String)
                                strMaxEntryDate = CType(CommonFunctions.Data.CheckIsDBNull(drTasks("MaxEntryDate"), "0"), String)

                                'Condition Added by Santosh Pawar on 21 Oct 2004
                                If m_blnResourceLevelTaskCompletion Then
                                    If strMaxEntryDate <> "0" Then
                                        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted" + intTaskID, "chkTaskCompleted" + intTaskID, , blnTaskComplete, intTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this,'" + Date.Parse(strMaxEntryDate).ToString("MM/dd/yyyy") + "') ", True))
                                    Else
                                        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted" + intTaskID, "chkTaskCompleted" + intTaskID, , blnTaskComplete, intTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this) ", True))
                                    End If
                                    CommonFunction.General.WriteHTML("</td>")
                                Else
                                    CommonFunction.General.WriteHTML("N/A</td>")
                                End If
                                ' End If
                                'End Modification

                            Else
                                CommonFunction.General.WriteHTML("<td align='center'>N/A</td><td align='center'>N/A</td>")
                            End If
                        End If

                        CommonFunction.General.WriteHTML("<td width='60' valign='top' align='center' Title='Actual Work (hrs) this week'>")
                        If dblArray_TaskWiseTotalHrs(intRow - 1) = 0 Then
                            Response.Write("<B>" + CStr(dblArray_TaskWiseTotalHrs(intRow - 1)) + "</B>")
                        Else
                            CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails(" + m_intProjectID + ",''," + intTaskID + ",'" + dtmFromDate + "','" + dtmToDate + "')"">")
                            CommonFunction.General.WriteHTML("<b>" + FormatNumber(dblArray_TaskWiseTotalHrs(intRow - 1), 2) + "</b>")
                            CommonFunction.General.WriteHTML("</a>")
                        End If
                        CommonFunction.General.WriteHTML("</td>")
                        CommonFunction.General.WriteHTML("</tr>")
                        '''Code Modified by VidyaJ on 29th May 2007 - SP8 Performance
                        intRow = intRow + 1

                        ' Check if the client is still connected. If not, exit the loop
                        If Not Response.IsClientConnected() Then
                            Exit For
                        End If
                    Next
                    '''Code Modified by VidyaJ on 29th May 2007 - SP8 Performance
                    'CommonFunctions.Data.DisposeDataReader(drTasks)
                    If Not (dsTasks Is Nothing) Then
                        dsTasks.Dispose()
                    End If

                    If Not (dsDailyActivity Is Nothing) Then
                        dsDailyActivity.Dispose()
                    End If
                    ''End of addition

                    '=====================================================================
                    '	DISPLAY THE COLUMN TOTALS.
                    '=====================================================================
                    CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
                    CommonFunction.General.WriteHTML("<td align='left'>Actual Work (hrs) per Day</td>									")
                    If m_strSelectedTaskType <> GENERAL_TASKS Then
                        CommonFunction.General.WriteHTML("<td align='center'>&nbsp;</td>")
                        CommonFunction.General.WriteHTML("<td align='center'>&nbsp;</td>")
                    End If

                    For intCol = 1 To 7
                        dtmEntryDate = CommonFunctions.Dates.GetDate(DateAdd("d", intCol - 1, CDate(dtmFromDate)))
                        CommonFunction.General.WriteHTML("<td align='center'>")
                        CommonFunction.General.WriteHTML("<label ID='lblTotalHoursPerDay" + CStr(intCol) + "'>")
                        If dblArray_DayWiseTotalHrs(intCol - 1) = 0 Then
                            Response.Write("<B>" & dblArray_DayWiseTotalHrs(intCol - 1) & "</B>")
                        Else
                            Response.Write("<a HREF=""javascript:ShowDetails(" + m_intProjectID + ",'")
                            If m_strSelectedTaskType = ALL_TASK_TYPES Then
                                Response.Write(ALL_TASK_TYPES)
                            Else
                                Response.Write(strWhichTask)
                            End If
                            Response.Write("',0,'" + dtmEntryDate + "','" + dtmEntryDate + "')""><b>" + FormatNumber(dblArray_DayWiseTotalHrs(intCol - 1), 2) + "</b></a>")
                            CommonFunction.General.WriteHTML("</label>")
                            CommonFunction.General.WriteHTML("</td>")
                        End If
                    Next
                    CommonFunctions.General.WriteHTML("<script LANGUAGE=""Javascript"">")
                    CommonFunctions.General.WriteHTML(strClientSideScript.ToString)
                    CommonFunctions.General.WriteHTML("</script>")

                    If m_strSelectedTaskType <> GENERAL_TASKS Then
                        CommonFunction.General.WriteHTML("<td align='center'>&nbsp;</td>")

                        'Modified by PrasannaP on 19th May 2004
                        'If Not ENTERPRISE_CHANGES Then
                        CommonFunction.General.WriteHTML("<td align='center'>&nbsp;</td>")
                        'End If
                        'End Modification

                    End If
                    CommonFunction.General.WriteHTML("<td align='center'>&nbsp;</td>")
                    CommonFunction.General.WriteHTML("</tr>")
                Else
                    CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
                    CommonFunction.General.WriteHTML("<td align='middle'>")
                    CommonFunction.General.WriteHTML(MyBase.GetResourceString("NO_ITEMS"))
                    CommonFunction.General.WriteHTML("</td>")
                    CommonFunction.General.WriteHTML("</tr>")
                End If
            Else
                CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
                CommonFunction.General.WriteHTML("<td align='middle'>")
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("WEEKLY_VIEW_NA"))
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("</tr>")
            End If
        Else
            CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<td align='middle'>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("VALIDATE_SELECT_PROJECT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        End If
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div><br>")

        If m_intProjectID <> "0" Then

            CommonFunction.General.WriteHTML("<table id='tblHeader' CellSpacing='0' width='99.9%' class='clsTable'>")
            CommonFunction.General.WriteHTML("<tr class='clsTRSectionHeader'>")
            CommonFunction.General.WriteHTML("<td>")
            Response.Write("<b>" + MyBase.GetResourceString("TOTAL_WORK_HRS") + "'")

            'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
            '  drProject = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_intProjectID, MyBase.UseSQL)
            ' If drProject.Read Then
            Response.Write(m_strProjectName)
            ' End If
            'CommonFunctions.Data.DisposeDataReader(drProject)
            'End Of Modifications

            '25-Aug - ParagD
            Response.Write("' " + MyBase.GetResourceString("THIS_WEEK"))

            'Modified By VidyaJ for IssueID - 20315 (DA Performance) 
            ' drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " + m_strSessionUserID + "," + m_intProjectID + ",NULL,NULL,'" + dtmFromDate + "','" + dtmToDate + "',NULL,1, 1", MyBase.UseSQL)
            ' If drDailyActivity.Read Then
            'Dim strTotalHrs As String
            'Response.Write(FormatNumber(drDailyActivity("TotalHours"), 2) + " " + MyBase.GetResourceString("HRS") + " ")
            Response.Write(FormatNumber(m_TotalHours, 2) + " " + MyBase.GetResourceString("HRS") + " ")
            'If CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String) <> "0" Then

            'Modified by NitinVS on 20 Aug 2007 for WhizbileSEM 7 
            If m_TotalHours > 0 Or m_TotalGeneralHours_ForProject > 0 Or m_TotalAssignedHours_ForProject > 0 Then

                Response.Write(" [ ")
            End If



            If m_TotalHours > 0 Then
                'Response.Write("[ ")
                'End Modification by NitinVS on 20 Aug 2007 for WhizbileSEM 7 

                ' Display the number of hours spent on project tasks.
                'drDailyActivity.Close()
                'drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & "," & m_intProjectID & ",'M',NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1, 1", MyBase.UseSQL)
                'If drDailyActivity.Read Then
                'strTotalHrs = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String)
                'If strTotalHrs <> "0" Then
                'Response.Write("Project Tasks : " & FormatNumber(strTotalHrs, 2) & " hrs ")
                If m_TotalMPPHours > 0 Then
                    Response.Write("Project Tasks : " & FormatNumber(m_TotalMPPHours_ForProject, 2) & " hrs ")
                End If
            End If


            ' Display the number of hours spent on general tasks.
            'CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            ' drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & "," & m_intProjectID & ",'D',NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1, 1", MyBase.UseSQL)
            ' If drDailyActivity.Read Then
            'strTotalHrs = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String)
            If m_TotalGeneralHours_ForProject > 0 Then
                Response.Write(MyBase.GetResourceString("GENERAL_TASKS") + " : " + FormatNumber(m_TotalGeneralHours_ForProject, 2) + " " + MyBase.GetResourceString("HRS") + " ")
            End If
            'End If

            ' Display the number of hours spent on assigned tasks.
            'CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            ' drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & "," & m_intProjectID & ",'O',NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1, 1", MyBase.UseSQL)
            ' If drDailyActivity.Read Then
            'StrTotalHrs = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String)
            If m_TotalAssignedHours_ForProject > 0 Then
                '' 25-Aug-2006
                '' Response.Write(MyBase.GetResourceString("ASSIGNED_TASKS") + " : " + FormatNumber(m_TotalAssignedHours, 2) + " " + MyBase.GetResourceString("HRS") + " ")
                Response.Write(MyBase.GetResourceString("ASSIGNED_TASKS") + " : " + FormatNumber(m_TotalAssignedHours_ForProject, 2) + " " + MyBase.GetResourceString("HRS") + " ")
            End If
            ' End If

            ' Display the number of hours spent on resolving the defects in the project.
            'CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            'drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & "," & m_intProjectID & ",'B',NULL,'" & dtmFromDate & "','" & dtmToDate & "',NULL,1, 1", MyBase.UseSQL)
            ' If drDailyActivity.Read Then
            ' strTotalHrs = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), String)
            If m_TotalIssuesHours_ForProject > 0 Then
                Response.Write("Issues Assigned : " & FormatNumber(m_TotalIssuesHours_ForProject, 2) & " hrs ")
            End If
            'End If
            'Modified by NitinVS on 20 Aug 2007 for WhizbileSEM 7 
            'Response.Write("]")
            If m_TotalHours > 0 Or m_TotalGeneralHours_ForProject > 0 Or m_TotalAssignedHours_ForProject > 0 Then

                Response.Write("] ")
            End If

            'End Modification by NitinVS on 20 Aug 2007 for WhizbileSEM 7 


            ' End If
            ' End If


            ' CommonFunctions.Data.DisposeDataReader(drDailyActivity)
            'End Of Modifications



            CommonFunctions.General.WriteHTML("</b>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("</table>")
            CommonFunction.General.WriteHTML("<br>")
        End If

    End Sub

    Private Sub DisplaySavedDailyActivityMatrix()
        '=====================================================================
        ' Procedure Name        : DisplaySavedDailyActivityMatrix()	
        ' Purpose               : Plots the Daily Activity Matrix.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrDailyActivityEntryIDs As String()
        Dim strDailyActivityIDsToDelete As String
        Dim drDailyActivity As IDataReader
        Dim drTotalHours As IDataReader
        Dim intCtr As Integer = 1
        Dim intDescriptionCounter As Integer = 1

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        ' added by sujatak for IssueID. 3718
        Dim strStringtoBeInsertednew As String
        'end by sujatak
        'End Integration

        'Added By MahendraV On 12:12 PM 5/29/2007 For allowing IsBackdateing and IsForwardDating
        ' Start_MV_5/29/2007
        drTotalHours = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Daily_WorkingHours_Office " & m_intProjectID & ", '" & m_strHoursValidation & "'", MyBase.UseSQL)
        If drTotalHours.Read() Then
            m_dblTotalWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drTotalHours("WorkingHours"), "0"), Double)
        End If
        CommonFunction.Data.DisposeDataReader(drTotalHours)
        CommonFunction.General.WriteHTML("<Script Language=Javascript> intMaxEntry = (" & m_dblTotalWorkHours & " - 0); </Script>")

        If m_strBackdatingExpiry <> "" Or m_strFwddatingExpiry <> "" Then
            Dim drBackDatedConf As IDataReader
            drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_intProjectID, MyBase.UseSQL)


            If drBackDatedConf.Read() Then
                'Entry exists for the current project and current user in configuration table
                If m_strBackdatingExpiry <> "" Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsBackDating"), "0"), Boolean) = False Then
                        m_blnProjectBackdateEntry = False
                    Else
                        m_blnProjectBackdateEntry = True
                    End If
                Else
                    m_blnProjectBackdateEntry = True
                End If
                'Entry exists for the current project and current user in configuration table
                If m_strFwddatingExpiry <> "" Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsForwardDating"), "0"), Boolean) = False Then
                        m_blnProjectFwddateEntry = False
                    Else
                        m_blnProjectFwddateEntry = True

                    End If
                Else
                    m_blnProjectFwddateEntry = True
                End If

            Else
                'Entry Doesnot exist for the current project and current user in configuration table
                m_blnProjectBackdateEntry = False
                m_blnProjectFwddateEntry = False
            End If
            CommonFunction.Data.DisposeDataReader(drBackDatedConf)
        Else
            m_blnProjectBackdateEntry = True
            m_blnProjectFwddateEntry = True
        End If
        ' End_MV_5/29/2007


        If Request.QueryString("Mode") = "Save" Then

            strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
            strSQLQuery.Append("")

            If Request("DailyActivityEntryID") <> "" Then
                arrDailyActivityEntryIDs = Split(Request("DailyActivityEntryID"), ",")
                For Each strDailyActivityIDsToDelete In arrDailyActivityEntryIDs
                    'Modified By VidyaJ - IssueID - 89 (DA Performance Issue - SP4)
                    'strSQLQuery = strSQLQuery + "Exec usp_Ins_tbl_PM_DailyActivity_WeeklyView "
                    strSQLQuery.Append("Exec usp_Ins_tbl_PM_DailyActivity ")

                    ' If the DailyActivityEntryID is sent in the query string, then...
                    If Trim(Request.QueryString("DailyActivityEntryID")) <> "" Then
                        strSQLQuery.Append(Request.QueryString("DailyActivityEntryID"))
                        ' Else, if the DailyActivityEntryID is sent in the form, then...
                    Else
                        strSQLQuery.Append(strDailyActivityIDsToDelete)
                    End If

                    ' If the TaskID is sent in the query string, then...
                    If Trim(Request.QueryString("TaskID")) <> "" Then
                        strSQLQuery.Append("," & Request.QueryString("TaskID"))
                        ' Else, if the taskID is sent in the form, then...
                    Else
                        strSQLQuery.Append("," & Split(MyBase.GetFormValue("TaskID"), ",")(intCtr - 1))
                    End If

                    ' If the ProjectID is sent in the query string, then...
                    If Trim(Request.QueryString("ProjectID")) <> "" Then
                        strSQLQuery.Append("," & Request.QueryString("ProjectID"))
                        ' Else, if the ProjectID is sent in the form, then...
                    Else
                        strSQLQuery.Append("," + Split(MyBase.GetFormValue("ProjectID"), ",")(intCtr - 1))
                    End If

                    ' The Employee ID.
                    strSQLQuery.Append(", " & m_strSessionUserID)

                    ' The Role ID.
                    strSQLQuery.Append(", " & m_strSessionPostID)

                    ' The Entry Date.
                    strSQLQuery.Append(", '" & MyBase.GetFormValue("txtEntryDate" & intDescriptionCounter) & "' ")

                    ' The Duration.
                    strSQLQuery.Append("," & FixString(MyBase.GetFormValue("txtDuration" & intDescriptionCounter), 0, False, False))

                    ' The Description of the Task.
                    If Trim(MyBase.GetFormValue("txtDescription" + CStr(intCtr))) <> "" Then
                        strSQLQuery.Append(",'" & Left(FixString(MyBase.GetFormValue("txtDescription" + CStr(intDescriptionCounter)), 2000, False, False), 2000) & "'")
                    Else
                        strSQLQuery.Append(", NULL")
                    End If

                    'Modified By VidyaJ for IssueID - 89 (DA Performance - SP4) 
                    strSQLQuery.Append(", NULL,NULL")

                    ' If the DailyActivityEntryID is sent in the query string, then...
                    If Trim(MyBase.GetFormValue("txtIsDurationChange" & intCtr)) <> "1" Then
                        strSQLQuery.Append(", NULL")
                    Else
                        strSQLQuery.Append(", 1")
                    End If

                    intDescriptionCounter = intDescriptionCounter + 1
                    intCtr = intCtr + 1
                    strSQLQuery.Append(" " & vbCrLf)
                Next
            End If

            ' Execute the update query.
            If Trim(strSQLQuery.ToString) <> "" Then
                'DEADLOCK ISSUE - VidyaJ
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
            End If
            strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
            strSQLQuery.Append("")

            CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
            CommonFunctions.General.WriteHTML("var strParentPage;")
            CommonFunctions.General.WriteHTML("try")
            CommonFunctions.General.WriteHTML("{")
            CommonFunctions.General.WriteHTML("strParentPage = new String();")
            CommonFunctions.General.WriteHTML("strParentPage = opener.location.href;")
            CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the EmployeeCertifications.asp, then refresh the page.")
            CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf(""PM_DAILYACTIVITYMATRIX.ASPX"") != -1)")
            CommonFunctions.General.WriteHTML("{")
            'CommonFunctions.General.WriteHTML("window.opener.frmDailyActivityMatrix.action = opener.location.href;")
            'CommonFunctions.General.WriteHTML("window.opener.frmDailyActivityMatrix.submit();")
            CommonFunctions.General.WriteHTML("window.opener.document.forms['frmDailyActivityMatrix'].action = opener.location.href;")
            CommonFunctions.General.WriteHTML("window.opener.document.forms['frmDailyActivityMatrix'].submit();")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("catch(e)")
            CommonFunctions.General.WriteHTML("{")
            CommonFunctions.General.WriteHTML("// This condition will come if the parentpage has been closed, of changed.")
            CommonFunctions.General.WriteHTML("// Do nothing.						")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("</script>")
        End If

        ' Build the querystring.
        strSQLQuery.Append("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID)

        ' The selected projectID.
        If Trim(Request.QueryString("ProjectID")) <> "" Then
            strSQLQuery.Append("," & Request.QueryString("ProjectID"))
        Else
            strSQLQuery.Append(",NULL")
        End If

        ' The selected TaskType	
        If Trim(Request.QueryString("TaskType")) <> "" Then
            strSQLQuery.Append(",'" & Request.QueryString("TaskType") & "'")
        Else
            strSQLQuery.Append(",NULL")
        End If

        ' The selected TaskID
        If Trim(Request.QueryString("TaskID")) <> "" Then
            strSQLQuery.Append("," & Request.QueryString("TaskID"))
        Else
            strSQLQuery.Append(",NULL")
        End If

        ' The start date of the date range.
        If Trim(Request.QueryString("FromDate")) <> "" Then
            strSQLQuery.Append(",'" & Request.QueryString("FromDate") & "'")
        Else
            strSQLQuery.Append(",NULL")
        End If

        ' The end date of the date range.
        If Trim(Request.QueryString("ToDate")) <> "" Then
            strSQLQuery.Append(",'" & Request.QueryString("ToDate") & "'")
        Else
            strSQLQuery.Append(",NULL")
        End If

        'Response.Write strSQLQuery
        drDailyActivity = CommonFunctions.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)

        'PRASANNA - Wrote Javascript on client side page with out condition.
        'Now plotting the actual Matrix.

        CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto'>")
        CommonFunctions.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<td>" + MyBase.GetResourceString("TASK_NAME") + "</td>")
        CommonFunctions.General.WriteHTML("<td style='width:70' align='center'>" + MyBase.GetResourceString("ACTUAL_WORK") + "</td>")
        CommonFunctions.General.WriteHTML("<td style='width:50%'>" + MyBase.GetResourceString("DESCRIPTION") + "</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        Dim intNumberOfDates As Integer = 0
        Dim intNumberOfTasks As Integer = 0
        Dim intPreviousTaskID As Integer = 0
        Dim intJavaScriptCounter As Integer = 0     'This counter is used to declare dblTaskWiseHours

        intCtr = 1

        If drDailyActivity.IsClosed = False Then
            While drDailyActivity.Read
                Dim blnOver As Boolean
                Dim strTimeSheet As String
                Dim blnIsComplete As Boolean
                Dim intTaskID As Integer
                Dim strEntryDate As String
                Dim intProjectID As Integer
                Dim intDailyActivityEntryID As Integer
                Dim strTaskName As String
                Dim strDuration As String
                Dim strWhichTask As String
                Dim strDescription As String
                Dim blnIsTaskCompleteFromTask As Boolean
                'added by harshk on 31 Jan 2006
                Dim blnIsActive As Boolean
                Dim blnVerified As Boolean
                Dim strResourceTimesheetID As String = ""
                Dim strRemarks As String = ""

                'Added By VidyaJ - 11773
                Dim blnOnHold As Boolean
                blnOnHold = False

                'End added by harshk on 31 Jan 2006
                m_blnTaskEditable = True

                blnOver = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Over"), "0"), Boolean)
                strTimeSheet = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TimeSheetID"), ""), String)
                'Modified By UmeshJ on 05 Aug 2004 
                'Changed the column reference by index (20) by name (IsTaskComplete)
                blnIsComplete = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsTaskComplete"), "0")), Boolean)
                'Modification Ends

                'Added By VidyaJ on 3rd Nov 2004
                ' Do not allow to edit task hours if a task is complete
                blnIsTaskCompleteFromTask = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsTaskCompleteFromTask"), "0")), Boolean)


                intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskID"), "0"), Integer)
                strEntryDate = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("EntryDate"), "0")), String)
                intProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), Integer)
                intDailyActivityEntryID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("DailyActivityEntryID"), "0")), Integer)
                strTaskName = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskName"), "")), String)
                strDuration = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Duration"), "0")), String)
                strWhichTask = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "0")), String)
                strDescription = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Description"), "")), String)
                'added by harshk on 31 Jan 2006
                blnIsActive = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("IsActive"), "0"), Boolean)
                blnVerified = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Verified"), "0"), Boolean)
                strResourceTimesheetID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ResourceTimesheetID"), "")), String)
                strRemarks = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("Remarks"), "")), String)

                'Added By VidyaJ - 11773
                blnOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskOnHold"), "0"), Boolean)
                If blnOnHold = True Then
                    m_blnTaskEditable = False
                End If

                If blnIsActive = False Then
                    m_blnTaskEditable = False
                End If

                'End added by harshk on 31 Jan 2006
                'Modified by PRASANNA: on 4th March 2004
                If blnOver = True Then
                    m_blnTaskEditable = False
                End If
                If Trim(strTimeSheet) <> "" Then
                    m_blnTaskEditable = False
                End If
                If blnIsComplete = True Then
                    m_blnTaskEditable = False
                End If

                'Added By VidyaJ on 3rd Nov 2004
                ' Do not allow to edit task hours if a task is complete
                If blnIsTaskCompleteFromTask = True Then
                    m_blnTaskEditable = False
                End If

                'Modified and added by harshk on 31 Jan 2006
                'Modified By VidyaJ - DA Performance Issue - IssueID -364
                'Do not allow to edit DA which are already approved 
                strResTmSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(drDailyActivity("Status"), ""), String)


                'If Not (strResTmSheetStatus = "N" Or (CType(CommonFunction.Data.CheckIsDBNull(drDailyActivity("Verified"), "0"), Boolean) = False And strResTmSheetStatus <> "R")) Then 'strResTmSheetStatus = "J" Then
                '    m_blnTaskEditable = False
                'End If
                'End Of Modifications
                '****************
                If strResourceTimesheetID <> "" Then
                    If strRemarks <> "" Or strResTmSheetStatus.ToUpper = "J" Then
                    Else
                        m_blnTaskEditable = False
                    End If
                End If

                If strResourceTimesheetID <> "" Then
                    If (strResTmSheetStatus = "N" Or (blnVerified = False And strResTmSheetStatus <> "R")) Then
                        If blnIsActive = False Then
                            m_blnTaskEditable = False
                        End If
                    Else
                        m_blnTaskEditable = False
                    End If
                End If
                '***************
                'End Modified and added by harshk on 31 Jan 2006
                If intPreviousTaskID <> intTaskID Then

                    intNumberOfTasks = intNumberOfTasks + 1
                    strClientSideScript.Append("dblTaskWiseHours[" + CStr(intNumberOfTasks - 1) + "][0] = " & CStr(intTaskID) & vbCrLf)
                    ' Code to store the value of the "number of hours of daily activity entered for the Task".
                    drTotalHours = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL," & intTaskID & ",NULL,NULL,NULL,1,1", MyBase.UseSQL)
                    If drTotalHours.Read Then
                        Dim intTotalHours As Double
                        intTotalHours = CType((CommonFunctions.Data.CheckIsDBNull(drTotalHours("TotalHours"), "0")), Double)
                        strClientSideScript.Append("dblTaskWiseHours[" & intNumberOfTasks - 1 & "][1] = " & intTotalHours & vbCrLf)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drTotalHours)

                    ' Code to store the value of the "Allocated hours for the Task".						
                    drTotalHours = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Projecttasks NULL, " & intTaskID, MyBase.UseSQL)
                    If drTotalHours.Read Then
                        Dim strTotalWork As String
                        Dim strStartDate As String
                        Dim strEndDate As String

                        strStartDate = CType((CommonFunctions.Data.CheckIsDBNull(drTotalHours("StartDate"), "0")), String)
                        strEndDate = CType((CommonFunctions.Data.CheckIsDBNull(drTotalHours("EndDate"), "0")), String)
                        strTotalWork = CType((CommonFunctions.Data.CheckIsDBNull(drTotalHours("Work"), "0")), String)

                        If Trim(strTotalWork) <> "" Then
                            strClientSideScript.Append("dblTaskWiseHours[" & (intNumberOfTasks - 1) & "][2] = " & strTotalWork & vbCrLf)
                        Else
                            strClientSideScript.Append("dblTaskWiseHours[" & (intNumberOfTasks - 1) & "][2] = 0" & vbCrLf)
                        End If
                        strClientSideScript.Append("dblTaskWiseHours[" & CStr(intNumberOfTasks - 1) & "][3] = """ & CDate(CommonFunctions.Dates.GetDate(Date.Parse(Trim(strStartDate)))).ToString("dd-MMM-yyyy") & """" & vbCrLf)
                        strClientSideScript.Append("dblTaskWiseHours[" & (intNumberOfTasks - 1) & "][4] = """ & CDate(CommonFunctions.Dates.GetDate(Date.Parse(Trim(strEndDate)))).ToString("dd-MMM-yyyy") & """" & vbCrLf)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drTotalHours)

                    intPreviousTaskID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TaskID"), "0")), Integer)

                End If

                If dtmPreviousDate <> CommonFunctions.Dates.GetDate(Date.Parse(strEntryDate)) Then
                    If (Request.QueryString("FromDate") <> Request.QueryString("ToDate")) Or Trim(Request.QueryString("FromDate")) = "" Or Trim(Request.QueryString("ToDate")) = "" Then
                        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
                        CommonFunctions.General.WriteHTML("<td colspan='3' valign='top' align='left'><b>" + CommonFunctions.Dates.CGetDate(Date.Parse(strEntryDate)) + "</b></td>")
                        CommonFunctions.General.WriteHTML("</tr>")
                    End If

                    intNumberOfDates = intNumberOfDates + 1
                    ' Code to store the value of the "number of hours of daily activity entered for the day".
                    drTotalHours = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" + CommonFunctions.Dates.GetDate(Date.Parse(strEntryDate)) + "','" & CommonFunctions.Dates.GetDate(Date.Parse(strEntryDate)) & "',NULL,1,1", MyBase.UseSQL)
                    If drTotalHours.Read Then
                        strClientSideScript.Append("dblDateWiseHours[" & intNumberOfDates & "] = " & CType((CommonFunctions.Data.CheckIsDBNull(drTotalHours("TotalHours"), "0")), String) & ";" & vbCrLf)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drTotalHours)

                    dtmPreviousDate = CommonFunctions.Dates.GetDate(Date.Parse(strEntryDate))

                End If
                CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
                If Trim(Request.QueryString("ProjectID")) = "" Then
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='ProjectID' name='ProjectID' value='" + CStr(intProjectID) + "'>")
                End If
                If Trim(Request.QueryString("TaskID")) = "" Then
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='TaskID' name='TaskID' value='" + CStr(intTaskID) + "'>")
                End If

                If Trim(Request.QueryString("DailyActivityEntryID")) = "" Then
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='DailyActivityEntryID' name='DailyActivityEntryID' value='" & intDailyActivityEntryID & "'>")
                End If
                'Added By VidyaJ - 11773
                If blnOnHold = True Then
                    CommonFunctions.General.WriteHTML("<td valign='top'  style='color:red; text-align:left' >" & strTaskName & "</td>")
                    CommonFunctions.General.WriteHTML("<td valign='top'  style='color:red; ' align='center'>")
                Else
                    CommonFunctions.General.WriteHTML("<td valign='top'>" & strTaskName & "</td>")
                    CommonFunctions.General.WriteHTML("<td valign='top' align='center'>")
                End If

                If m_blnTaskEditable = True Then
                    Dim strStringtoBeInserted As String

                    If m_blnActualWorkHrs = True Then
                        strStringtoBeInserted = " language=Javascript OnChange=txtDuration_OnChange(this," + CStr(intCtr).ToString + ",""" + strWhichTask + """," + CStr(intNumberOfDates).ToString + "," + CStr(intNumberOfTasks).ToString + ") OnFocus=txtDuration_OnFocus(this)"
                        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("txtDuration" & CStr(intCtr), "usp_Sel_GetActualHrs " + CStr(CommonFunctions.Application.MinHoursForDAEntry), 0, FormatNumber(CStr((CDbl(strDuration) / CommonFunctions.Application.MinHoursForDAEntry) * CommonFunctions.Application.MinHoursForDAEntry), 2), strStringtoBeInserted, True, True, , True))
                    Else
                        strStringtoBeInserted = " language=Javascript OnBlur=txtDuration_OnChange(this," + CStr(intCtr).ToString + ",""" + strWhichTask + """," + CStr(intNumberOfDates).ToString + "," + CStr(intNumberOfTasks).ToString + ") OnFocus=txtDuration_OnFocus(this)"
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtDuration" & CStr(intCtr), "txtDuration" & CStr(intCtr), , 45, 5, FormatNumber(CStr((CDbl(strDuration) / CommonFunctions.Application.MinHoursForDAEntry) * CommonFunctions.Application.MinHoursForDAEntry), 2), "Right", , , , , , strStringtoBeInserted, True, True, EnableHTMLEncode:=True))
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    End If

                Else
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='txtDuration" + CStr(intCtr) + "' name='txtDuration" + CStr(intCtr) + "' value='" + strDuration + "'>")
                    CommonFunctions.General.WriteHTML(FormatNumber(strDuration, 2))
                End If
                CommonFunctions.General.WriteHTML("<input type='hidden' id='txtIsDurationChange" + CStr(intCtr) + "' name='txtIsDurationChange" + CStr(intCtr) + "' value='0'>")
                CommonFunctions.General.WriteHTML("<input type='hidden' id='txtEntryDate" + CStr(intCtr) + "' name='txtEntryDate" + CStr(intCtr) + "' value='" + CDate(CommonFunctions.Dates.GetDate(Date.Parse(strEntryDate))).ToString("dd-MMM-yyyy") + "'>")
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("<td valign='top'>")
                CommonFunctions.General.WriteHTML("<input type='hidden' id='txtTaskComplete' name='txtTaskComplete' value='" + CStr(blnIsComplete) + "'>")

                'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
                'Modified by SandipL on 18 May 2006 for WhizEnggSP6 IssueID 3718
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription" + CStr(intCtr), "txtDescription" + CStr(intCtr), MyBase.GetResourceString("DESCRIPTION"), , , "frmDailyActivityMatrix", , , , , 4000, strDescription, , "width:90%;height:75", , , , , , True, False))
                ' Added by sujatak on 23 May 2006
                strStringtoBeInsertednew = " language=Javascript OnBlur=txtDescription_OnChange(this," + CStr(intCtr).ToString + ") OnFocus=txtDescription_OnFocus(this)"
                ' end of addition by sujatak
                'End Integration
                'Modified By ShraddhaM on 27 July 2006
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription" + CStr(intCtr), "txtDescription" + CStr(intCtr), MyBase.GetResourceString("DESCRIPTION"), , , "frmDailyActivityMatrix", , , , , 4000, strDescription, , "width:90%;height:75", Not m_blnTaskEditable, Not m_blnTaskEditable, , , strStringtoBeInsertednew, True, False, , , , , , "Soft", ))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription" + CStr(intCtr), "txtDescription" + CStr(intCtr), MyBase.GetResourceString("DESCRIPTION"), , , "frmDailyActivityMatrix", , , , , 4000, strDescription, , "width:90%;height:75", Not m_blnTaskEditable, Not m_blnTaskEditable, , , strStringtoBeInsertednew, True, False, , , , , , "Soft", , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'End modification by SandipL on 18 May 2006

                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("</tr>")
                intCtr = intCtr + 1
            End While
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtDescriptionCounter", "txtDescriptionCounter", , , , CStr(intCtr - 1), , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align=center colspan='3'>" + MyBase.GetResourceString("NO_ITEMS") + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
        End If
        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
        'If intNumberOfDates > 0 Then
        CommonFunctions.General.WriteHTML("var dblDateWiseHours = new Array(" + CStr(intNumberOfDates) + ");")
        CommonFunctions.General.WriteHTML("var dblTaskWiseHours = new Array(" + CStr(intNumberOfTasks) + ");")
        'Else
        '    CommonFunctions.General.WriteHTML("var dblDateWiseHours = new Array(" + CStr(intNumberOfDates) + ");")
        '    CommonFunctions.General.WriteHTML("var dblTaskWiseHours = new Array(" + CStr(intNumberOfTasks) + ");")
        'End If

        For intJavaScriptCounter = 0 To intNumberOfTasks - 1
            CommonFunctions.General.WriteHTML("dblTaskWiseHours[" + CStr(intJavaScriptCounter) + "] = new Array(5);")
        Next

        CommonFunctions.General.WriteHTML(strClientSideScript.ToString)
        CommonFunctions.General.WriteHTML("var dblInitialHours;")
        CommonFunctions.General.WriteHTML("dblInitialHours = dblDateWiseHours;")
        CommonFunctions.General.WriteHTML("</script>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div><br>") '

        strSQLQuery.Append("")
        CommonFunction.Data.DisposeDataReader(drDailyActivity)

    End Sub

    Private Sub DisplayTaskNotes()
        '=====================================================================
        ' Procedure Name        : DisplayTaskNotes()	
        ' Purpose               : Plots the task notes when we click on the link.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================
        Dim strTaskID As String
        Dim drTasks As IDataReader
        Dim strTaskName As String
        Dim strTaskNotes As String
        Dim strSQL As String

        strTaskID = Request.QueryString("TaskID")

        ' Save the Task Notes details.
        If Request.QueryString("Mode") = "Save" Then
            If Trim(MyBase.GetFormValue("txtTaskNotes")) = "" Then
                strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
                strSQLQuery.Append("UPDATE tbl_PM_ProjectTasks SET TaskNotes = NULL WHERE TaskID = " & strTaskID)

                'Added by PrasannaP, 19th May 2004
                If ENTERPRISE_CHANGES Then
                    strSQL = "UPDATE tbl_PM_ProjectTasks SET TaskNotes = NULL WHERE TaskID IN (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE  TaskId = " & strTaskID & ")"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    strSQL = "UPDATE tbl_PM_ProjectTasks SET TaskNotes = NULL WHERE ParentTask_UID IN (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE  TaskId = " & strTaskID & ")"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
                'End Of Addition

            Else
                strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
                strSQLQuery.Append("UPDATE tbl_PM_ProjectTasks SET TaskNotes = '" & Left(Trim(MyBase.GetFormValue("txtTaskNotes")), 2000) & "' WHERE TaskID = " & strTaskID)

                'Added by PrasannaP, 19th May 2004
                If ENTERPRISE_CHANGES Then
                    strSQL = "UPDATE tbl_PM_ProjectTasks SET TaskNotes = '" & Left(CommonFunction.General.BuildQueryString(Trim(Request.Form("txtTaskNotes"))), 2000) & "' WHERE TaskID IN (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE  TaskId = " & strTaskID & ")"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    strSQL = "UPDATE tbl_PM_ProjectTasks SET TaskNotes = '" & Left(CommonFunction.General.BuildQueryString(Trim(Request.Form("txtTaskNotes"))), 2000) & "' WHERE ParentTask_UID IN (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE  TaskId = " & strTaskID & ")"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
                'End Of Addition
            End If

            'Execute the update query.
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
            strSQLQuery.Remove(0, strSQLQuery.ToString.Length)

            CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("</script>")
        End If

        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
        CommonFunctions.General.WriteHTML("document.title = 'Task Notes'")
        CommonFunctions.General.WriteHTML("function Close_OnClick() {")
        CommonFunctions.General.WriteHTML("window.close();")
        CommonFunctions.General.WriteHTML("}")

        CommonFunctions.General.WriteHTML("function SaveClick() {")
        CommonFunctions.General.WriteHTML("objfrmDailyActivity = GetFormReference('frmDailyActivityMatrix');")
        CommonFunctions.General.WriteHTML("objfrmDailyActivity.action = 'PM_DailyActivityMatrix.aspx?TaskNotes=1&Mode=Save&TaskID=" + strTaskID + "';")
        CommonFunctions.General.WriteHTML("objfrmDailyActivity.submit(); }")
        CommonFunctions.General.WriteHTML("</script>")

        ' Retrieve the details of the Task.
        drTasks = CommonFunction.Data.GetDataReader("usp_GetTaskStatus " + strTaskID, MyBase.UseSQL)
        If drTasks.Read Then
            strTaskName = CType((CommonFunctions.Data.CheckIsDBNull(drTasks("TaskName"), "")), String)
            strTaskNotes = CType((CommonFunctions.Data.CheckIsDBNull(drTasks("TaskNotes"), "")), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drTasks)

        CommonFunctions.General.WriteHTML("<DIV id='divList' style='Overflow:auto;width:100%;Height:150px'>")
        CommonFunction.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%' height='100%'>		")
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td  width='30%' align='right' valign='top'>" + MyBase.GetResourceString("TASK_NOTES_NAME") + "</td>			")
        CommonFunction.General.WriteHTML("<td  width='70%' valign='top'><b>" + Server.HtmlEncode(Trim(strTaskName + "")) + "</b></td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td width=30% align='right' valign='top'>" + MyBase.GetResourceString("TASK_NOTES") + "</td>")
        'Modified By ShraddhaM on 27 July 2006
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.General.WriteHTML("<td width=70% valign='top'>" + CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", MyBase.GetResourceString("TASK_NOTES"), , , , , , , 120, 2000, strTaskNotes + "", , "width:100%", , , , , , True, , , , , , , "Soft", ) + "</td>")
        CommonFunction.General.WriteHTML("<td width=70% valign='top'>" + CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", MyBase.GetResourceString("TASK_NOTES"), , , , , , , 120, 2000, strTaskNotes + "", , "width:100%", , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True) + "</td>")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div><br>")

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_DailyActivityMatrix", "AppResources")
    End Sub

    'modified by VidyaJ - IssueID - 11763
    Private Sub DrawMenu(ByVal strWhatToShow As String, ByVal blnTop As Boolean)
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
        ' Created               : Feb 26, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu

        '-------------------------------------------------------------
        'This block prints the Menus on the Page of Weekly View.
        '-------------------------------------------------------------
        'Modified By VidyaJ - issueID - 11448
        If Request.QueryString("TaskNotes") <> "1" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrClientSideFunctionList.Add("SaveClick()")
        End If


        If Request.QueryString("ShowDetails") <> "1" And strWhatToShow <> "1" Then

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
            arrClientSideFunctionList.Add("PreviousWeek()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))
            arrClientSideFunctionList.Add("NextWeek()")

            If Request.QueryString("ShowClose") <> "1" Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK"))
                arrClientSideFunctionList.Add("Back_OnClick()")
            End If

        End If

        If Request.QueryString("ShowClose") = "1" Or Request.QueryString("ShowDetails") = "1" Or strWhatToShow = "1" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrClientSideFunctionList.Add("Close_OnClick()")
        End If

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('Task_Notes')")
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        '-------------------------------------------------------------


        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        'modified by VidyaJ - IssueID - 11763
        If (blnTop = True) Then
            strMenu = "<TABLE class=clsTable name=tblMenuTop id=tblMenuTop cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD>" & strMenu & "</TD></TR></table>"
        Else
            strMenu = "<TABLE class=clsTable name=tblMenuBottom id=tblMenuBottom cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD>" & strMenu & "</TD></TR></table>"
        End If

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

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

    Function GetShortDate(ByVal dTDate As Date) As String

        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True)

        Return (strMonth + " " + CStr(intDate))
    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

