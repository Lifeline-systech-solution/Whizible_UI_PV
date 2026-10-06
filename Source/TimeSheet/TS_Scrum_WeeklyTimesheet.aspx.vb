Public Partial Class TS_Scrum_WeeklyTimesheet
    Inherits WebPages.Template.WhizTemplate


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmScrumWeeklyTimesheet As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        MyBase.InitializeResources("AppResources.TS_WeeklyTimesheet", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Variables Declaration"
    '---   Private variables   ---
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Private m_strSelectedTaskType As String = ""
    Private m_strTaskFilter As String = ""
    Public m_strSessionUserID As String = ""
    Public m_strFromWhere As String
    Private m_strSessionPostID As String = ""
    Private m_strSessionProjectID As String = ""
    Private m_strDefaultProjectID As String = ""
    Private m_strProjectFilters As String = ""
    Private m_strWhere As String = ""
    Private m_strReqStartDate As String = ""
    Private m_strMode As String = ""
    Private m_blnTaskEditable As Boolean
    Private m_strTSAction As String = "" 'Timesheet action (GS for generate and save,RS for Regenerate and save,G for generate and R for Regenerate,S for send for approval)
    Private m_blnTimesheetEntryCombo As Boolean
    Private m_strTimesheetFrequency As String = ""
    '---   Protected Variables   ---
    Protected m_strWindowTitle As String
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights          'This variable is for access rights of page.
    '---   Constants   ---
    Private Const TASKS_FOR_THE_WEEK As Integer = 6
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"
    Private Const ALL_TASKS As Integer = 5
    Private Const GENERAL_TASKS As String = "D"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"
    Private Const ALL_TASK_TYPES As String = "A"
    Private Const DEFAULT_TIMESHEET_FREQUENCY As String = "W"
    '-----------------------------------------------------
    Private Const MODE_VIEW_TIMESHEET As String = "V"
    Private Const MODE_GENERATE_TIMESHEET As String = "G"
    Private Const MODE_REGENERATE_TIMESHEET As String = "R"
    Private Const MODE_GENERATE_SEND As String = "GS"
    Private Const MODE_REGENERATE_SEND As String = "RS"
    Private Const MODE_SEND_APPROVAL As String = "S"
    '-----------------------------------------------------
    Private Const STATUS_READY_FOR_VERIFICATION As String = "R"
    Private Const MAIL_READY_FOR_VERIFICATION As String = "434"
    '-----------------------------------------------------
    Protected Const CellColor As String = "#b0c4de"     '"#fffff0"      '"#e6e6fa"\
    Protected Const TD_WIDTH_1 As String = "96"
    'Modified BY VarunA on 27-Aug-2008 RequestID-15303
    'Purpose : To solve the alignment issue
    'Protected Const TD_WIDTH_2 As String = "40"
    'Protected Const TD_WIDTH_3 As String = "150"
    'Protected Const TD_WIDTH_4 As String = "45"
    Protected Const TD_WIDTH_2 As String = "50"
    Protected Const TD_WIDTH_3 As String = "96"
    Protected Const TD_WIDTH_4 As String = "50"
    'End By VarunA on 27-Aug-2008 RequestID-15303
    Protected Const TD_HEIGHT_1 As String = "66"
    Protected Const TD_HEIGHT_2 As String = "25"
    Protected Const TD_HEIGHT_3 As String = "0"
    Protected Const ERROR_COLOR As String = "#ff0000"
    Protected Const WARNING_COLOR As String = "#ffff00"
    Protected Const DISABLED_COLOR As String = "#d3d3d3"    '"#a9a9a9"   ' 
    Protected Const MOVE_PREVIOUS As String = "PREV"
    Protected Const MOVE_NEXT As String = "NEXT"
    Protected Const SAVE_MOVE_NEXT As String = "SAVE_NEXT"
    Protected Const SAVE_MOVE_PREVIOUS As String = "SAVE_PREV"
    Protected Const ERROR_IMAGE As String = "../../Images/red.gif"
    Protected Const WARNING_IMAGE As String = "../../Images/green.gif"

    '----Temp-----------------
    Protected m_whichGrid As String
    Protected m_strHtmlAfterForm As New System.Text.StringBuilder
    Protected m_intStartingDayOfWeek As Integer = 0
    Protected m_intCurrentDayOfWeek As Integer = 0
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date
    Protected m_strCurrentDate As String = ""
    Protected m_strProjectsOnHold As String = ""
    Protected m_strProjectsOnHoldMsg As String = ""
    Protected m_strBackdatingExpiry As String = ""
    Protected m_strFwddatingExpiry As String = ""
    Protected m_strHoursValidation As String = ""
    Protected m_TotalWeekHours As Double = 0
    Protected m_strJavaScript As String = ""
    Protected m_blnRestrict_MPPTasks As Boolean
    Protected m_blnRestrict_AssignedTasks As Boolean
    Protected m_strDAID As String 'DailyActivityEntryID
    Protected m_strShowDetails As String = ""
    Protected m_strDetail As String = ""
    Protected m_blnActualWorkHrs As Boolean = CommonFunction.Application.TimesheetEntryCombo
    Protected m_blnProjectBackdateEntry As Boolean
    Protected m_blnProjectFwddateEntry As Boolean
    Protected m_strDay As String = ""
    Protected m_strTimeSheetID As String = ""
    Protected m_strBrowserName As String
    Protected m_dblActualHrs As Double = 0
    Protected m_dblExpectedHrs As Double = 0
    Protected m_strDivHeight As String = ""

    Protected m_dblEntryDay1 As Double = 0
    Protected m_dblEntryDay2 As Double = 0
    Protected m_dblEntryDay3 As Double = 0
    Protected m_dblEntryDay4 As Double = 0
    Protected m_dblEntryDay5 As Double = 0
    Protected m_dblEntryDay6 As Double = 0
    Protected m_dblEntryDay7 As Double = 0

    Protected m_blnRedirectToDA As Boolean

    Protected m_strshowDetailTaskID As String
    Protected mstrStatus As String
    ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
    Private strSQL As New System.Text.StringBuilder("")
    Protected m_intFlag As Integer
    ''End of Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
#End Region

#Region " Init functions"
    Private Sub InitVariables()

        Dim strSDate As String, strEDate As String
        Dim drInit As IDataReader

        Dim intRoleLevel As Integer
        Dim strFilter As String
        'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
        'Check whether request came from Onsite Resource Timesheet
        If Request.QueryString("Fromwhere") = "Proxy" Then
            'If the Request Came from Proxy page then get the userid,level and post id as well as project list
            m_strFromWhere = "Proxy"
            m_strSessionUserID = Request.QueryString("EmployeeID")
            Dim drEmpDetails As IDataReader
            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            '  drEmpDetails = CommonFunction.Data.GetDataReader("SELECT PostID,[Level] FROM tbl_PM_Employee E LEFT JOIN tbl_PM_Role R ON E.PostID = R.RoleID WHERE E.EmployeeID = " + m_strSessionUserID, MyBase.UseSQL)
            drEmpDetails = CommonFunction.Data.GetDataReader("EXEC usp_sel_tbl_PM_Employee_PostID " + m_strSessionUserID, MyBase.UseSQL)
            '  End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            If drEmpDetails.Read() Then
                m_strSessionPostID = CType(CommonFunction.Data.CheckIsDBNull(drEmpDetails("PostID"), ""), String)
                intRoleLevel = CType(CommonFunction.Data.CheckIsDBNull(drEmpDetails("Level"), ""), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drEmpDetails)
            m_strProjectFilters = ""
            strFilter = CType(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_AccessibleProjects_ForEmployee_ProxyTimesheet " + m_strSessionUserID + ",0,0,1,0,'E',0,NULL,1,0", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If strFilter <> "" Then
                m_strProjectFilters = "(" + strFilter + ")"
            End If
            m_strProjectFilters = m_strProjectFilters.Trim

        Else
            m_strSessionUserID = CType(Session("intUserID"), String)
            m_strSessionPostID = CType(Session("intPostID"), String)

            '-----Project Filter---------

            intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
            If intRoleLevel = 2 Then
                m_strProjectFilters = ""
                strFilter = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If
                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
                m_strProjectFilters = m_strProjectFilters.Trim
            End If
            '----timesheet frequency-----
        End If
        'Addition End by SantoshK on 20th March 2006

        '----------------
        m_strSessionProjectID = CStr(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"))
        ' Commented and Added By MahendraV On 2:12 PM 5/29/2007 for Company Information Optimization
        ' Start_MV_5/29/2007
        'm_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        '


        m_intStartingDayOfWeek = CommonFunction.Application.StartingDayofweek
        ' End_MV_5/29/2007
        m_intStartingDayOfWeek += 1
        If m_intStartingDayOfWeek > 7 Then
            m_intStartingDayOfWeek = 1
        End If
        '-------------------
        m_intCurrentDayOfWeek = System.DateTime.Now.DayOfWeek

        m_strWhere = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Where"), ""))
        '-------From DA----------
        strSDate = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate"), ""))
        strEDate = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate"), ""))
        If strSDate.Trim = "" Or strEDate.Trim = "" Then
            strSDate = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnStartDate"), ""))
            strEDate = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnEndDate"), ""))
        End If
        '---------------------------
        m_strMode = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), ""))
        m_strShowDetails = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowDetails"), ""))
        m_strDetail = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Detail"), ""))
        m_strDAID = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("DAID"), "0"))
        If m_strDAID = "0" Then
            m_strDAID = CStr(CommonFunctions.General.CheckIsNothing(Split(Request("hdnDAID"), ",")(0), "0"))
        End If

        'Added By VidyaJ - SP8 performance
        m_strshowDetailTaskID = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskDAID"), "0"))
        If m_strshowDetailTaskID = "0" Then
            m_strshowDetailTaskID = CStr(CommonFunctions.General.CheckIsNothing(Split(Request("hdnTaskDAID"), ",")(0), "0"))

        End If



        If m_strWhere = MOVE_PREVIOUS Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, -7, CDate(strSDate))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        ElseIf m_strWhere = MOVE_NEXT Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, 7, CDate(strSDate))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        Else
            If strSDate = "" Then
                'Added by PrashantD on 7 March 2007 for IssueID 11104
                m_dtStartDateOfWeek = StartDateOfWeek(m_intCurrentDayOfWeek, m_intStartingDayOfWeek)
                m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
                'Modified By MahendraV On 4:40 PM 7/24/2007 For WhizibleSEM 7.0
                ' To display pending week for 'OnSite Resource TimeSheet'
                ' Start_MV_7/24/2007
                'Code Commented By VidyaJ - Sp8 performance
                'Removed RT part
                'Commented By VarunA on 6-Mar-2008 RequestID-11888
                'If Request.QueryString("Fromwhere") = "Proxy" Then
                '    Dim drSDED As IDataReader

                '    'Modified by NitinVS on 10 Aug 2007 for WhizibleSEM 7 
                '    ' Proxy user is stored in m_strSessionUserID replaced Session("intUserID").ToString  with m_strSessionUserID
                '    drSDED = CommonFunction.Data.GetDataReader("EXEC usp_tbl_PM_PendingResourceTimesheets " & m_strSessionUserID & ",1", MyBase.UseSQL)
                '    'End Modification by NitinVS on 10 Aug 2007 for WhizibleSEM 7 

                '    If drSDED.Read Then 'if Timesheet is pending for approval
                '        m_dtStartDateOfWeek = CDate(drSDED("FromDate"))
                '        m_dtEndDateOfWeek = CDate(drSDED("ToDate"))
                '    Else
                '        CommonFunction.Data.DisposeDataReader(drSDED)
                '        drSDED = CommonFunction.Data.GetDataReader("SELECT FromDate,ToDate FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" + Session("intUserID").ToString + " AND DATEDIFF(dd,FromDate,'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + "') <= 0 AND DATEDIFF(dd,ToDate,'" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "') >= 0", MyBase.UseSQL)
                '        If drSDED.Read Then 'TimeSheet is generated previously, take its dates
                '            m_dtStartDateOfWeek = CDate(drSDED("FromDate"))
                '            m_dtEndDateOfWeek = CDate(drSDED("ToDate"))
                '        End If
                '    End If
                'End If
                ' End_MV_7/24/2007
                'End By VarunA on 6-Mar-2008 RequestID-11888
            Else
                m_dtStartDateOfWeek = CDate(strSDate)
                m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
            End If
        End If

        If m_strShowDetails <> "1" Then
            ' Retrieve the task type.
            If Trim(MyBase.GetFormValue("optTasks")) <> "" Then
                m_strSelectedTaskType = Trim(FixString(MyBase.GetFormValue("optTasks"), 0, False, True))
            Else
                Dim drDailyActivity As IDataReader
                'Modified By VarunA on 4-Jan-2008
                'Purpose : Changes for Project Access to middle level Role
                'drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_GetDailyActivityParameters 1, " & m_strSessionUserID, MyBase.UseSQL)
                drDailyActivity = CommonFunctions.Data.GetDataReader("usp_Sel_GetDailyActivityParameters 1, " & m_strSessionUserID & ",Null,'" & m_strProjectFilters & "'", MyBase.UseSQL)
                'End By VarunA on 4-Jan-2008
                If drDailyActivity.Read Then
                    m_strSelectedTaskType = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "")), String)
                    m_strDefaultProjectID = CType((CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0")), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drDailyActivity)
                If m_strSelectedTaskType = "" Then
                    'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
                    'Modified by Anjali on 18 May 2006 for issue ID 3703
                    'm_strSelectedTaskType = PROJECT_SPECIFIC_TASKS

                    ''Commented and added by NitinC on 25 August 2011 For WhizibleSEM v10.0 (Agile Methodology)
                    'm_strSelectedTaskType = GENERAL_TASKS
                    m_strSelectedTaskType = ASSIGNED_TASKS
                    ''End 

                    ' End of modification by Anjali on 18 May 2006
                    'End Integration
                End If


            End If
        End If

        ' Retrieve the current Task filter value. 
        If Trim(MyBase.GetFormValue("optMainTaskFilter")) <> "" Then
            m_strTaskFilter = Trim(FixString(MyBase.GetFormValue("optMainTaskFilter"), 0, False, True))
        Else
            m_strTaskFilter = CStr(TASKS_FOR_THE_WEEK)
        End If

        '----Temp-------------
        m_whichGrid = CommonFunctions.General.CheckIsNothing(Request("WPage"), "2")
        '--------------------
        m_strCurrentDate = CStr(CommonFunctions.Data.GetDataScalar("select REPLACE(CONVERT(VARCHAR(12),getdate(),106),' ','-') ", MyBase.UseSQL))

        'Modified By VidyaJ - SP8 Performace
        'Execute this only in details mode
        If m_strSessionUserID <> "0" And m_strShowDetails = "1" Then

            drInit = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Project_For_DA_Active_InActive_Projects_OnHold " + m_strSessionUserID, MyBase.UseSQL)
            If drInit.Read() Then
                m_strProjectsOnHold = CType(CommonFunction.Data.CheckIsDBNull(drInit("ProjectsOnHold"), ""), String)
                If m_strProjectsOnHold = "" Then
                    m_strProjectsOnHoldMsg = ""
                Else
                    m_strProjectsOnHoldMsg = CType(CommonFunction.Data.CheckIsDBNull(drInit("ProjectsOnHoldMsg"), ""), String)
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drInit)
        Else
            m_strProjectsOnHold = ""
        End If

        '------------------------------
        ' Commented and Added By MahendraV On 2:12 PM 5/29/2007 for Company Information Optimization
        ' Start_MV_5/29/2007
        'drInit = CommonFunction.Data.GetDataReader("Select IsNull(WeekDays,0)*IsNull(HoursPerDay,0) weekhours, BackdatingNoDays,ForwardDatingNoDays,HoursValidation FROM tbl_PM_CompanyInformation", MyBase.UseSQL)
        'If drInit.Read() Then
        '    m_strBackdatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(drInit("BackdatingNoDays"), ""), String)
        '    m_strFwddatingExpiry = CType(CommonFunction.Data.CheckIsDBNull(drInit("ForwardDatingNoDays"), ""), String)
        '    m_strHoursValidation = CType(CommonFunction.Data.CheckIsDBNull(drInit("HoursValidation"), "C"), String)
        '    m_TotalWeekHours = CType(CommonFunction.Data.CheckIsDBNull(drInit("weekhours"), "0"), Double)

        'End If
        'CommonFunction.Data.DisposeDataReader(drInit)

        m_strBackdatingExpiry = CommonFunction.Application.BackdatingNoDays.ToString()
        m_strFwddatingExpiry = CommonFunction.Application.ForwardDatingNoDays.ToString()
        m_strHoursValidation = CommonFunction.Application.HoursValidation.ToString()

        '--- Commented by PurvaJ on 6 Nov 2008 for WhizibleSem8.0 
        '--- Total weekhours will be calculated based on the resource OU working days and working hours
        'm_TotalWeekHours = CommonFunction.Application.weekhours
        '--- End addition PurvaJ

        'End_MV_5/29/2007
        '--------------------------------
        m_blnRestrict_MPPTasks = CommonFunctions.Application.RestrictDurationChange_M
        m_blnRestrict_AssignedTasks = CommonFunctions.Application.RestrictDurationChange_O

        m_strDay = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Day"), ""))
        If m_strDay = "" Then
            m_strDay = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnDay"), ""))
        End If
        m_strTSAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("TSAction"), "")
        m_strTimeSheetID = CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheetID"), "")

        'Modified By NitinVS on 2 apr 2007 for WhizibleSEM SP 8 regression Issue 11104 
        ' to check wheter timesheet exists for the selected period if yes assign it

        If m_strTimeSheetID = "" Or m_strTimeSheetID = "0" Then
            ' m_strTimeSheetID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT TimesheetID  FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" + m_strSessionUserID + " AND DATEDIFF(dd,FromDate,'" + strSDate + "') <= 0 AND DATEDIFF(dd,ToDate,'" + strEDate + "') >= 0", MyBase.UseSQL), "0"), "")
            Dim drRt As IDataReader
            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'drRt = CommonFunction.Data.GetDataReader("SELECT Isnull( StatusCode , 'N' ) as StatusCode, TimesheetID  FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" + m_strSessionUserID + " AND DATEDIFF(dd,FromDate,'" + strSDate + "') <= 0 AND DATEDIFF(dd,ToDate,'" + strEDate + "') >= 0", MyBase.UseSQL)
            drRt = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_ResourceTimesheet_StatusCode " + m_strSessionUserID + ",'" + strSDate + "','" + strEDate + "'", MyBase.UseSQL)
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            If drRt.Read Then
                m_strTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drRt("TimesheetID"), "0"), String)
                mstrStatus = CType(CommonFunction.Data.CheckIsDBNull(drRt("StatusCode"), "0"), String)
            End If
            CommonFunction.Data.DisposeDataReader(drRt)

        End If

        ' End Modification By NitinVS on 2 apr 2007 for WhizibleSEM SP 8 regression Issue 11104 

        ' Commented and Added By MahendraV On 2:46 PM 5/29/2007 for Company Information Optimization
        ' Start_MV_5/29/2007
        'm_blnTimesheetEntryCombo = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select TimesheetEntryCombo from tbl_Pm_CompanyInformation", MyBase.UseSQL), "0"))
        ' m_strTimesheetFrequency = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ResourceTimeSheetFrequency FROM tbl_PM_CompanyInformation", MyBase.UseSQL), DEFAULT_TIMESHEET_FREQUENCY))

        m_blnTimesheetEntryCombo = CommonFunction.Application.TimesheetEntryCombo
        m_strTimesheetFrequency = CommonFunction.Application.ResourceTimeSheetFrequency
        ' End_MV_5/29/2007


        m_strDivHeight = CommonFunctions.General.CheckIsNothing(Request("hdnDivHeight"), "0")

        'Code Added by VidyaJ on 29th May 2007 - SP8 Performance
        ''Total entries need for validation
        'm_dblEntryDay1 = CDbl(getDurationOnDate(m_dtStartDateOfWeek.ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay2 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay3 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 2, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay4 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 3, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay5 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 4, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay6 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 5, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        'm_dblEntryDay7 = CDbl(getDurationOnDate(DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), m_strSessionUserID, ""))
        '----
        m_blnRedirectToDA = CBool(CommonFunctions.General.CheckIsNothing(Request("RedirectToDA"), "0"))
    End Sub

    Private Sub InitVariablesAfterSave()
        Dim drInit As IDataReader
        Dim strSDate As String

        'Modified By MahendraV On 4:40 PM 7/24/2007 For WhizibleSEM 7.0
        ' To calculate Actual and Expected Hrs for 'on Site Resource TimeSheet'
        ' Start_MV_7/24/2007
        'Commented By VidyaJ - SP8 Performance
        'Removed RT part
        If Request.QueryString("Fromwhere") = "Proxy" Then
            drInit = CommonFunctions.Data.GetDataReader("Exec usp_Sel_GetResourceTimesheetExpectedAndActualHours " + m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'", MyBase.UseSQL)
            If drInit.Read() Then
                m_dblActualHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drInit.Item("ActualAMH"), "0"))
                '-- m_dblExpectedHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drInit.Item("NormalAMH"), "0"))
            Else
                m_dblActualHrs = 0
                m_dblExpectedHrs = 0
            End If
            CommonFunctions.Data.DisposeDataReader(drInit)
        End If
        ''------------------
        ' End_MV_7/24/2007

        '--- commented and Added By purvaj on 6 Nov 2008 for WhizibleSEM 8.0
        '--- Total week hours will be calculated based on the resource OU working days and work hours
        m_dblExpectedHrs = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_ExpectedWorkHours " + m_strSessionUserID.ToString + ",'" + CommonFunction.Dates.GetDate(m_dtStartDateOfWeek).ToString + "','" + CommonFunction.Dates.GetDate(m_dtEndDateOfWeek).ToString + "'", True), "0")
        '--- End addition purvaJ


        strSDate = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate"), ""))
        If strSDate.Trim = "" Then
            strSDate = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnStartDate"), ""))
        End If
        '------------
        If m_strWhere = SAVE_MOVE_PREVIOUS Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, -7, CDate(strSDate))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        ElseIf m_strWhere = SAVE_MOVE_NEXT Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, 7, CDate(strSDate))
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        End If
    End Sub

    Private Function StartDateOfWeek(ByVal m_intCurrentDayOfWeek As Integer, ByVal m_intStartingDayOfWeek As Integer) As Date
        Dim tempDate As Date
        Dim intWD As Integer = Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday)

        Select Case m_intStartingDayOfWeek
            Case 1
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Sunday) - 1), System.DateTime.Now)
            Case 2
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Monday) - 1), System.DateTime.Now)
            Case 3
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday) - 1), System.DateTime.Now)
            Case 4
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday) - 1), System.DateTime.Now)
            Case 5
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Thursday) - 1), System.DateTime.Now)
            Case 6
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Friday) - 1), System.DateTime.Now)
            Case 7
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Saturday) - 1), System.DateTime.Now)
        End Select
        Return tempDate

    End Function

    Protected Sub InitPage()
        ''commented by Nilesh Gundecha on 15/10/2015 for show page in all browser
        '' m_strBrowserName = Request.Browser.Browser
        ''  If m_strBrowserName = "IE" Or m_strBrowserName = "Microsoft Internet Explorer" Then
        ''end of commented by Nilesh Gundecha on 15/10/2015 for show page in all browser
        GetGlobalObject()
        InitVariables()
        '--------------
        If m_strMode.ToUpper = "SAVE" And m_strShowDetails <> "1" Then
            ProcessSave()
            'RedirectToDA
            If m_blnRedirectToDA = True Then
                Server.Transfer("../PM/PM_DailyActivity.aspx", False)
            End If
        End If
        '--------------
        If m_strMode.ToUpper = "SAVE" And m_strShowDetails = "1" Then
            ProcessSave_ShowDetails()
        End If
        '--------------
        If m_strMode.ToUpper = "DELETE" And m_strShowDetails = "1" Then
            DeleteDA()
        End If
        '---------------------------------
        InitVariablesAfterSave()
        '----------------------------------
        If m_strTSAction <> "" And m_strShowDetails <> "1" Then 'timesheet action
            ProcessTSAction()
        End If
        '--------------
        If m_strShowDetails = "1" Then
            DrawShowDetailPage()
        Else
            DrawPage()
        End If
        ''commented by Nilesh Gundecha on 15/10/2015 for show page in all browser
        ''   Else
        ''   CommonFunctions.General.WriteHTML("<SCRIPT>alert(""" & MyBase.GetResourceString("MSG_BROWSER") & """)</SCRIPT>")
        '''  End If
        '--------------
        ''end of commented by Nilesh Gundecha on 15/10/2015 for show page in all browser
    End Sub

    Private Sub DrawPage()
        DrawMenu(True)
        DrawPageLegend()
        '----------------
        CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:480px'>")

        DrawPageCaption()
        '----------------
        CommonFunctions.General.WriteHTML("<BR>")
        DrawFilters()
        '----------------
        'CommonFunctions.General.WriteHTML("<BR>")
        'DrawControls()
        '----------------
        CommonFunctions.General.WriteHTML("<BR>")
        '---Temp---------
        If m_whichGrid = "1" Then
            'DrawTaskGrid()
        Else
            DrawTaskGrid2()
        End If

        'CommonFunctions.General.WriteHTML("</DIV>")
        '----------------
        CommonFunctions.General.WriteHTML("<BR>")
        '--- Added By Purvaj on 30 Sept 2008 for WhizibleSEM8.0 HOliday / leave changes
        DrawPageHeaderFooter()
        '--- End addition Purvaj
        DrawMenu(False)
        '----------------
        DrawHiddens()
    End Sub

#End Region

#Region "Show Detail Page"

    Private Sub DrawShowDetailPage()
        '=====================================================================
        ' Procedure Name        : DrawShowDetailPage
        ' Purpose               : To Draw PopUp page
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        DrawMenu(True)
        DrawPageLegend()
        '----------------
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<div id='divMain' style='overflow:auto;width:100%;Height:450px'>")

        DrawTaskDetail()
        '----------------
        CommonFunctions.General.WriteHTML("</div >")
        '-------------------
        '---------Note------------------
        CommonFunctions.General.WriteHTML("<table width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td >")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_VOID"))
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")
        '----------------------------
        DrawMenu(False)
        '----------------
        DrawHiddens()
    End Sub

    Private Sub DrawTaskDetail()
        '=====================================================================
        ' Procedure Name        : DrawTaskDetail
        ' Purpose               : To Draw details of PopUp page
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strSql As New System.text.StringBuilder
        Dim drPage As IDataReader
        Dim strTaskName As String = ""
        Dim strDuration As String = ""
        Dim strDesc As String = ""
        Dim strTaskID As String
        Dim strMaxEntry As String
        Dim strProjectID As String
        Dim strDAID As String = ""
        Dim strEntryDate As String = ""
        Dim strEntryDateNew As String = ""
        Dim strIsDurationChange As String = ""
        Dim strActualWork As String = "", strAllocatedWork As String = ""
        Dim strTotalEntryOn As String = ""
        Dim strWhichTask As String
        Dim strStartDate As String = ""
        Dim strEndDate As String = ""
        Dim strResourceTimesheetID As String = ""
        Dim strRemarks As String
        Dim strOldProjectID As String = "", strProjectName As String = ""
        ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
        Dim strStoryPoint As String = ""
        ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
        If m_strDetail = "0" Then
            'Modifid By VidyaJ - SP8 Performance
            'strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail " & m_strDAID & "," & m_strSessionUserID & ",NULL,NULL,0,'" & m_strProjectFilters & "'")
            strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail " & m_strshowDetailTaskID & "," & m_strSessionUserID & ",'" & m_strDay & "',NULL,0,'" & m_strProjectFilters & "'")

        ElseIf m_strDetail = "1" Then
            strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail " & m_strshowDetailTaskID & "," & m_strSessionUserID & ",NULL,NULL,1,'" & m_strProjectFilters & "'")
            'strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail " & m_strshowDetailTaskID & "," & m_strSessionUserID & ",NULL,NULL,1,'" & m_strProjectFilters & "'")
        ElseIf m_strDetail = "2" Then
            strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail " & m_strshowDetailTaskID & "," & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "',2,'" & m_strProjectFilters & "'")
        ElseIf m_strDetail = "3" Then
            strSql.Append("usp_Sel_tbl_PM_DailyActivity_ShowDetail Null," & m_strSessionUserID & ",'" & DateAdd(DateInterval.Day, CInt(m_strDay) - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") & "','" & DateAdd(DateInterval.Day, CInt(m_strDay) - 1, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") & "',3,'" & m_strProjectFilters & "'")
        End If

        drPage = CommonFunctions.Data.GetDataReader(strSql.ToString, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto;'>")
        CommonFunctions.General.WriteHTML("<table id='tblList' CELLSPACING='0' class='clsTable' width='99.9%' >")
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<td>" + MyBase.GetResourceString("COL_TASKNAME") + "</td>")
        CommonFunctions.General.WriteHTML("<td style='width:70' align='center'>" + MyBase.GetResourceString("COL_ACTUAL") + "</td>")
        ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
        If m_strDetail = "0" Then
            CommonFunctions.General.WriteHTML("<td style='width:70' align='center'>Story Point</td>")
        End If
        ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
        CommonFunctions.General.WriteHTML("<td style='width:50%'>" + MyBase.GetResourceString("COL_DESCRIPTION") + "</td>")

        'Modified by MrugajaB on 31st July 2006 for WhizibleSEM SP 7.2 Issue ID.3734
        'Purpose:if 'Delete' access is not present then do not show Delete checkbox in edit mode
        If (m_strShowDetails = "1" And m_objAccessRights.Delete) Then
            CommonFunctions.General.WriteHTML("<td>" + MyBase.GetResourceString("COL_DELETE") + "</td>")
        End If
        'End Modification
        CommonFunctions.General.WriteHTML("</tr>")

        While drPage.Read
            Dim blnOver As Boolean
            Dim strTimeSheet As String
            Dim blnIsComplete As Boolean
            Dim blnIsTaskCompleteFromTask As Boolean
            Dim strResTmSheetStatus As String
            Dim blnIsActive As Boolean
            Dim blnVerified As Boolean
            Dim blnTaskOnHold As Boolean
            Dim blnDisableDelete As Boolean
            Dim blnVoid As Boolean
            Dim strTRstyle As String = ""
            'Added By VarunA on 2-Sep-2008
            'Purpose : To have details of a project in a diasble mode when the project is 'On Hold' in 'All Project View'.
            Dim MapToProjectOnHold As Boolean
            'End By VarunA on 2-Sep-2008
            strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("TaskName"), ""))
            strDuration = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("Duration"), "0"))
            strDesc = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("Description"), "0"))
            strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("TaskID"), "0"))
            strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("ProjectID"), "0"))
            strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("ProjectName"), "0"))
            strDAID = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("DailyActivityEntryID"), "0"))
            strEntryDate = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("EntryDate"), ""))
            strIsDurationChange = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("IsDurationChange"), "0"))
            strWhichTask = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("WhichTask"), ""))
            'Start_AJ_24Sep2006,Format was not as dd-MMM-yyyy which is necessary for comparision in txtDuration_ObBlur, commented and added below
            'strStartDate = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("StartDate"), ""))
            'strEndDate = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("EndDate"), ""))
            'Added By VarunA on 2-Sep-2008
            'Purpose : To have details of a project in a diasble mode when the project is 'On Hold' in 'All Project View'.
            MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drPage("MapToProjectOnHold"), "0"), Boolean)
            'End By VarunA on 2-Sep-2008
            If CStr(CommonFunctions.Data.CheckIsDBNull(drPage("StartDate"), "")) = "" Then
                strStartDate = ""
            Else
                strStartDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(drPage("StartDate"), "").ToString))
            End If

            If CStr(CommonFunctions.Data.CheckIsDBNull(drPage("EndDate"), "")) = "" Then
                strEndDate = ""
            Else
                strEndDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(drPage("EndDate"), "").ToString))
            End If
            strEntryDateNew = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(drPage("EntryDate"), "").ToString))
            'End_AJ_24Sep2006,Format was not as dd-MMM-yyyy
            strRemarks = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("Remarks"), ""))

            strMaxEntry = getMaxEntry(strProjectID)
            strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("ActualWork"), "0")) ' getActualWork(strTaskID)
            strAllocatedWork = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("Work"), "0")) 'getAllocatedWork(strTaskID)
            strTotalEntryOn = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("DurationOndate"), "0")) 'getDurationOnDate(strEntryDate, m_strSessionUserID, strTaskID)

            m_blnTaskEditable = True

            blnOver = CType(CommonFunctions.Data.CheckIsDBNull(drPage("Over"), "0"), Boolean)
            blnIsActive = CType(CommonFunctions.Data.CheckIsDBNull(drPage("IsActive"), "0"), Boolean)
            blnVerified = CType(CommonFunction.Data.CheckIsDBNull(drPage("Verified"), "0"), Boolean)
            blnTaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(drPage("TaskOnHold"), "0"), Boolean)
            blnVoid = CType(CommonFunction.Data.CheckIsDBNull(drPage("void"), "0"), Boolean)
            strTimeSheet = CType(CommonFunctions.Data.CheckIsDBNull(drPage("TimeSheetID"), ""), String)
            strResourceTimesheetID = CType(CommonFunctions.Data.CheckIsDBNull(drPage("ResourceTimesheetID"), ""), String)
            blnIsComplete = CType((CommonFunctions.Data.CheckIsDBNull(drPage("IsTaskComplete"), "0")), Boolean)
            blnIsTaskCompleteFromTask = CType((CommonFunctions.Data.CheckIsDBNull(drPage("IsTaskCompleteFromTask"), "0")), Boolean)
            If blnOver = True Then
                m_blnTaskEditable = False
            End If
            If Trim(strTimeSheet) <> "" Then
                m_blnTaskEditable = False
            End If
            If blnIsComplete = True Then
                m_blnTaskEditable = False
            End If
            If blnIsTaskCompleteFromTask = True Then
                m_blnTaskEditable = False
            End If

            If blnIsActive = False Or blnTaskOnHold Then 'voided task in red color
                strTRstyle = "COLOR: red"
            End If


            strResTmSheetStatus = CType(CommonFunction.Data.CheckIsDBNull(drPage("Status"), ""), String)

            ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            strStoryPoint = CStr(CommonFunctions.Data.CheckIsDBNull(drPage("StoryPoint"), "0"))
            ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            'If Not (strResTmSheetStatus = "N" Or (CType(CommonFunction.Data.CheckIsDBNull(drPage("Verified"), "0"), Boolean) = False And strResTmSheetStatus <> "R")) Then 'strResTmSheetStatus = "J" Then
            '    m_blnTaskEditable = False
            'End If
            '-------------------
            blnDisableDelete = DisableDelete(strProjectID, strEntryDate, blnOver, strTimeSheet, blnIsActive, strResourceTimesheetID, strResTmSheetStatus, strRemarks, blnVerified, blnTaskOnHold)
            '------------
            '-----Project Grouping------
            If strOldProjectID <> strProjectID Then
                CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")
                CommonFunctions.General.WriteHTML("<TD colspan=4><i>" & strProjectName & "</i></TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            '---------------------------
            CommonFunctions.General.WriteHTML("<tr class='clsTREven' style='" & strTRstyle & "'>")
            '-------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td>")
            If m_strDetail <> "0" Then
                CommonFunctions.General.WriteHTML("<b>" + CDate(strEntryDate).ToString("dd-MMM-yyyy") + "</b><br>")
            End If
            CommonFunctions.General.WriteHTML(strTaskName)
            CommonFunctions.General.WriteHTML("</td>")
            '-------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td style='width:70' align='center'>")
            'If m_blnTaskEditable = True Then
            If blnDisableDelete = False Then
                If m_blnTaskEditable = True Then
                    ' The value in objEntryDate control is sent in "dd/mm/yyyy" format. This value
                    ' is used while checking the backward and forward blocking date. The same format
                    ' is used while comparing the date with start date and end date which is in 
                    ' "dd-mmm-yyyy" which makes it incompatible with objEntryDate date format and 
                    ' thereby resulting in -2 as the return value always. For this purpose, a parameter
                    ' is added to the function that will also pass the Entry Date in "dd-mmm-yyyy" format.
                    ' A different variable will be used to let objEntryDate variable to continue with its
                    ' current functionality. 
                    If m_blnTimesheetEntryCombo = True Then
                        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("txtDuration_" + strDAID, "usp_sel_GetHoursForDA " & CStr(CommonFunction.Application.MinHoursForDAEntry), , FormatNumber(strDuration, 2, , , TriState.False), _
                        "  OnChange='javascript:txtDuration_OnBlur(this," & strMaxEntry & "," & FormatNumber(strDuration, 2, , , TriState.False) & "," & FormatNumber(strAllocatedWork, 2, , , TriState.False) & "," & FormatNumber(strActualWork, 2, , , TriState.False) & "," & strTotalEntryOn & ",""" & strWhichTask & """,""" & strStartDate & """,""" & strEndDate & """,""" & strEntryDateNew & """)' ", , , , True))
                    Else
                        'Modified By VarunA on 2-Sep-2008
                        'Purpose : To have details of a project in a diasble mode when the project is 'On Hold' in 'All Project View'.
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDuration_" + strDAID, "txtDuration_" + strDAID, , 45, 7, FormatNumber(strDuration, 2, , , TriState.False), "Right", , , , , , _
                        '"  OnBlur='javascript:txtDuration_OnBlur(this," & strMaxEntry & "," & FormatNumber(strDuration, 2, , , TriState.False) & "," & FormatNumber(strAllocatedWork, 2, , , TriState.False) & "," & FormatNumber(strActualWork, 2, , , TriState.False) & "," & strTotalEntryOn & ",""" & strWhichTask & """,""" & strStartDate & """,""" & strEndDate & """,""" & strEntryDateNew & """)' ", , True)
                        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                        CommonFunctions.HTMLControls.DrawTextBox("txtDuration_" + strDAID, "txtDuration_" + strDAID, , 45, 7, FormatNumber(strDuration, 2, , , TriState.False), "Right", , MapToProjectOnHold, , , , _
                        "  OnBlur='javascript:txtDuration_OnBlur(this," & strMaxEntry & "," & FormatNumber(strDuration, 2, , , TriState.False) & "," & FormatNumber(strAllocatedWork, 2, , , TriState.False) & "," & FormatNumber(strActualWork, 2, , , TriState.False) & "," & strTotalEntryOn & ",""" & strWhichTask & """,""" & strStartDate & """,""" & strEndDate & """,""" & strEntryDateNew & """)' ", , True, EnableHTMLEncode:=True)
                        'ended by Shamkant s  for HTML encoding Date:07/10/15
                        'End By VarunA on 2-Sep-2008
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='txtDuration_" + strDAID + "' name='txtDuration_" + strDAID + "' value='" + strDuration + "'>")
                    CommonFunctions.General.WriteHTML(FormatNumber(strDuration, 2))
                End If
            Else
                CommonFunctions.General.WriteHTML("<input type='hidden' id='txtDuration_" + strDAID + "' name='txtDuration_" + strDAID + "' value='" + strDuration + "'>")
                CommonFunctions.General.WriteHTML(FormatNumber(strDuration, 2))
            End If

            ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            If m_strDetail = "0" Then
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("<td style='width:70' align='center'>")
                If blnDisableDelete = False Then
                    If m_blnTaskEditable = True Then

                        CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint_" + m_strshowDetailTaskID, "txtStoryPoint_" + m_strshowDetailTaskID, , 45, 7, strStoryPoint, "Right", , MapToProjectOnHold, , , , _
                        "OnBlur='javascript:ValidateEditStoryPoint(this)'", , False, EnableHTMLEncode:=True)

                    Else
                        CommonFunctions.General.WriteHTML("<input type='hidden' id='txtStoryPoint_" + m_strshowDetailTaskID + "' name='txtStoryPoint_" + m_strshowDetailTaskID + "' value='" + strStoryPoint + "'>")
                        CommonFunctions.General.WriteHTML(strStoryPoint)
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<input type='hidden' id='txtStoryPoint_" + m_strshowDetailTaskID + "' name='txtStoryPoint_" + m_strshowDetailTaskID + "' value='" + strStoryPoint + "'>")
                    CommonFunctions.General.WriteHTML(strStoryPoint)
                End If
            End If
            ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum

            'Added by vidyaJ - SP8 Performance
            'Commented and added by Shamkant s for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("hdnTaskDAID", "hdnTaskDAID", , 45, 7, m_strshowDetailTaskID, , , , , , True, EnableHTMLEncode:=True)

            CommonFunctions.HTMLControls.DrawTextBox("hdnDAID", "hdnDAID", , 45, 7, strDAID, , , , , , True, EnableHTMLEncode:=True)
            'CommonFunctions.HTMLControls.DrawTextBox("hdnDAID", "hdnDAID", , 45, 7, strTaskID, , , , , , True)
            CommonFunctions.HTMLControls.DrawTextBox("hdnEntryDate_" + strDAID, "hdnEntryDate_" + strDAID, , 45, 7, strEntryDate, , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("hdnDuCh_" + strDAID, "hdnDuCh_" + strDAID, , 45, 7, strIsDurationChange, , , , , , True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML("</td>")
            '-------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td style='width:50%'>")
            If blnDisableDelete = True Then
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + strDAID, "txtDescription_" + strDAID, "Description", , , "frmScrumWeeklyTimesheet", , , , , 4000, strDesc, , "width:90%;height:75", True, , , , " disabled ", True, False))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + strDAID, "txtDescription_" + strDAID, "Description", , , "frmScrumWeeklyTimesheet", , , , , 4000, strDesc, , "width:90%;height:75", True, , , , " disabled ", True, False, , , , , , , , True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Else
                'Modified By VarunA on 2-Sep-2008
                'Purpose : To have details of a project in a diasble mode when the project is 'On Hold' in 'All Project View'.
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + strDAID, "txtDescription_" + strDAID, "Description", , , "frmScrumWeeklyTimesheet", , , , , 4000, strDesc, , "width:90%;height:75", , , , , , True, False))
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + strDAID, "txtDescription_" + strDAID, "Description", , , "frmScrumWeeklyTimesheet", , , , , 4000, strDesc, , "width:90%;height:75", MapToProjectOnHold, , , , , True, False))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription_" + strDAID, "txtDescription_" + strDAID, "Description", , , "frmScrumWeeklyTimesheet", , , , , 4000, strDesc, , "width:90%;height:75", MapToProjectOnHold, , , , , True, False, , , , , , , , True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'End By VarunA on 2-Sep-2008
            End If
            CommonFunctions.General.WriteHTML("</td>")
            '-------------------------------------------------------------
            CommonFunctions.General.WriteHTML("<td>")
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strDAID, Not m_blnTaskEditable))

            'Modified by MrugajaB on 31st July 2006 for WhizibleSEM SP 7.2 Issue ID.3734
            'Purpose:if 'Delete' access is not present then do not show Delete checkbox in edit mode
            If (m_strShowDetails = "1" And m_objAccessRights.Delete) Then
                'Modified By VarunA on 2-Sep-2008
                'Purpose : To have details of a project in a diasble mode when the project is 'On Hold' in 'All Project View'.
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strDAID, blnDisableDelete))
                If MapToProjectOnHold = True Then
                    blnDisableDelete = MapToProjectOnHold
                End If
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strDAID, blnDisableDelete))
                'End By VarunA on 2-Sep-2008
            End If
            'End Modification
            CommonFunctions.General.WriteHTML("</td>")
            '-------------------------------------------------------------
            CommonFunctions.General.WriteHTML("</tr>")

            strOldProjectID = strProjectID
            'Commented and added by Shamkant s for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("hdnTaskID_" & strDAID, "hdnTaskID_" & strDAID, , 45, 7, strTaskID, , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("hdnProjectID_" & strDAID, "hdnProjectID_" & strDAID, , 45, 7, strProjectID, , , , , , True, EnableHTMLEncode:=True)
        End While
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.HTMLControls.DrawTextBox("hdnTaskID", "hdnTaskID", , 45, 7, strTaskID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnProjectID", "hdnProjectID", , 45, 7, strProjectID, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnDay", "hdnDay", , 45, 7, m_strDay, , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        'Integrated by ShraddhaM on 20,Nov 2007 for Timesheet
        'Uncommented by ChristinaT on 18-Oct-2007 for Weekly Timesheet - Backdate Issue
        'Commented By VidyaJ - SP8 Performance
        If isBackDate(strProjectID) = "true" Then
            m_blnProjectBackdateEntry = True
        Else
            m_blnProjectBackdateEntry = False
        End If
        If isForwardDate(strProjectID) = "true" Then
            m_blnProjectFwddateEntry = True
        Else
            m_blnProjectFwddateEntry = False
        End If
        'End by christinat

        CommonFunctions.Data.DisposeDataReader(drPage)
        strSql = Nothing
    End Sub

    Private Function getActualWork(ByVal strTaskID As String) As String
        '=====================================================================
        ' Function Name        : getActualWork
        ' Purpose               : To get actual work
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strAct As String = ""

        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strAct = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ActualWork from tbl_PM_ProjectTasks where TaskID = " & strTaskID, MyBase.UseSQL), "0"))
        strAct = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_ActualWork " & strTaskID, MyBase.UseSQL), "0"))
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        Return strAct
    End Function

    Private Function getAllocatedWork(ByVal strTaskID As String) As String
        Dim strAct As String = ""
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        ' strAct = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select Work from tbl_PM_ProjectTasks where TaskID = " & strTaskID, MyBase.UseSQL), "0"))
        strAct = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_Work " & strTaskID, MyBase.UseSQL), "0"))
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        Return strAct
    End Function

    Private Function getDurationOnDate(ByVal strEntryDate As String, ByVal m_strSessionUserID As String, ByVal strTaskID As String) As String
        Dim strDU As String = ""

        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'Dim strQry As String = "select sum(Duration) from tbl_PM_DailyActivity where Employeeid = " & m_strSessionUserID & " AND DateDiff(dd,EntryDate,'" & strEntryDate & "')=0"
        Dim strQry As String = "usp_sel_tbl_PM_DailyActivity_EmployeeID '" & m_strSessionUserID & "','" & strEntryDate & "'"
        strDU = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQry, MyBase.UseSQL), "0"))
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

        Return strDU
    End Function

    Private Function DisableDelete(ByVal strProjectID As String, ByVal strEntryDate As String, ByVal blnOver As Boolean, ByVal strTimeSheet As String, ByVal blnIsActive As Boolean, ByVal strResourceTimesheetID As String, ByVal strStatus As String, ByVal strRemarks As String, ByVal blnVerified As Boolean, ByVal blnTaskOnHold As Boolean) As Boolean
        '----------------------------
        Dim blnExpired As Boolean
        Dim blnDAEntryEditable As Boolean = True
        '----------------------------

        If DateDiff(DateInterval.Day, CDate(strEntryDate), Today()) > 0 Then
            If m_strBackdatingExpiry <> "" Then
                If isBackDate(strProjectID) = "true" Then
                    blnExpired = False
                Else
                    If DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, CInt(m_strBackdatingExpiry), CDate(strEntryDate)), Today()) > 0 Then
                        blnExpired = True
                    Else
                        blnExpired = False
                    End If
                End If
            Else
                blnExpired = False
            End If
        End If

        If DateDiff(DateInterval.Day, CDate(strEntryDate), Today()) < 0 Then
            If m_strFwddatingExpiry <> "" Then
                If isForwardDate(strProjectID) = "true" Then
                    blnExpired = False
                Else
                    If DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, -CInt(m_strFwddatingExpiry), CDate(strEntryDate)), Today()) < 0 Then
                        blnExpired = True
                    Else
                        blnExpired = False
                    End If
                End If
            Else
                blnExpired = False
            End If
        End If

        '*************
        If blnOver = True Then
            blnDAEntryEditable = False
        End If
        If strTimeSheet <> "" Then
            blnDAEntryEditable = False
        End If
        If blnIsActive = False Then
            blnDAEntryEditable = False
        End If

        If strResourceTimesheetID <> "" Then
            If strRemarks <> "" Or strStatus.ToUpper = "J" Then
            Else
                blnDAEntryEditable = False
            End If
        End If

        If strResourceTimesheetID <> "" Then
            If (strStatus = "N" Or (blnVerified = False And strStatus <> "R")) Then
                If blnIsActive = False Then
                    blnDAEntryEditable = False
                End If
            Else
                blnDAEntryEditable = False
            End If
        End If

        If blnTaskOnHold = True Then
            blnDAEntryEditable = False
        End If

        '----------------------
        Return (Not blnDAEntryEditable) Or blnExpired
        '-----------------
    End Function
#End Region

#Region "DataBase Function"
    Private Sub ProcessSave()
        '=====================================================================
        ' Procedure Name        : ProcessSave
        ' Purpose               : To Process save action
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '====================================================================
        Dim strQueryString As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnQueryString")))
        Dim arrQueryString() As String = strQueryString.Split(CChar(";")) 'Edited cells
        '------------------------
        Dim strHdnTP As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnTP")))
        Dim arrHdnTP() As String = strHdnTP.Split(CChar(";")) 'edited text box of percent complete
        '------------------------
        Dim strHdnChk As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnChk")))
        Dim arrHdnChk() As String = strHdnChk.Split(CChar(";")) 'edited check box
        '------------------------
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim strSQL2 As String = ""
        Dim strUpdatedTasks As String = ","
        Dim strCompletedTasks As String = ","
        Dim i As Integer

        For i = 0 To arrQueryString.Length - 1
            Dim arrValues() As String = arrQueryString(i).Split(CChar(":"))
            ''Commented and Modified By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            'If arrValues.Length = 5 Then
            If arrValues.Length = 6 Then
                ''End of Commented and Modified By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                Dim strCellvalue As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), ""))
                Dim strCellIndex As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))
                Dim strCellTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(2), "0"))
                Dim strCellProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(3), "0"))
                Dim strIsDurationChange As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(4), "0"))
                ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                Dim strStoryPoint As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(5), ""))
                ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                Dim strPercentComplete As String = CStr(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtPercentComplete_" + strCellTaskID), ""))
                Dim dtEntryDate As Date = DateAdd(DateInterval.Day, CDbl(strCellIndex) - 3, m_dtStartDateOfWeek)
                Dim blnResourceLevelTaskCompletion As Boolean

                If strCellvalue <> "" And strCellvalue.ToUpper <> "NULL" Then
                    'strSQL2 = "SELECT ResourceLevelTaskCompletion FROM tbl_PM_Project WHERE ProjectID =  " & strCellProjectID
                    strSQL2 = "usp_sel_tbl_PM_Project_ResourceLevelTaskCompletion " & strCellProjectID
                    blnResourceLevelTaskCompletion = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "0"))

                    strUpdatedTasks += strCellTaskID + ","
                    strSQLQuery.Append("Exec usp_Ins_tbl_PM_DailyActivity  NULL," & strCellTaskID & "," & strCellProjectID & "," & m_strSessionUserID & "," & m_strSessionPostID & ",'" & dtEntryDate.ToString("dd-MMM-yyyy") & "'," & strCellvalue & ", NULL,NULL,NULL")
                    'Booleon flag indicating whether this entry has caused the duration of the task to change
                    If strIsDurationChange = "1" Then
                        strSQLQuery.Append(",1")
                    Else
                        strSQLQuery.Append(",0")
                    End If
                    '-------------------------
                    If MyBase.GetFormValue("chkTaskCompleted_" & strCellTaskID) <> "" Then
                        strSQLQuery.Append(",1")
                    Else
                        strSQLQuery.Append(",0")
                    End If
                    If MyBase.GetFormValue("txtPercentComplete_" + strCellTaskID) <> "" Then
                        If blnResourceLevelTaskCompletion Then
                            strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strCellTaskID), 0, False, True), , , , TriState.False) & ",1")
                            ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
                            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strCellProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
                            If m_intFlag = 1 Then
                                strSQL.Append("EXEC Usp_Upd_UserStoryStatus '" & strCellTaskID & "'," & strCellProjectID & ",8")
                                strSQL.Append(vbCrLf)
                            End If
                            ''End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology Issue Fix : 57807)
                        Else
                            strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strCellTaskID), 0, False, True), , , , TriState.False) & ",0")
                        End If
                    End If
                    ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                    strSQLQuery.Append(",NULL,NULL," & strStoryPoint)
                    ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                    strSQLQuery.Append(vbCrLf)
                End If
            End If
        Next
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If
        '------------------------------------
        ''Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)
        If strSQL.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
        End If
        strSQL.Remove(0, strSQL.ToString.Length)
        strSQL.Append("")
        ''End of Added by Nitinc on 02 Jan 2011 for WhizibleSEM v11.0 (Agile Methodology Issue Fix : 57807)

        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        For i = 0 To arrHdnTP.Length - 1
            Dim arrValues() As String = arrHdnTP(i).Split(CChar(":"))
            If arrValues.Length = 2 Then
                Dim strTPTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), "0"))
                Dim strTPProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))
                Dim blnResourceLevelTaskCompletion As Boolean
                Dim blntaskCompleted As Boolean = False
                If MyBase.GetFormValue("txtPercentComplete_" + strTPTaskID) <> "" And strUpdatedTasks.IndexOf("," + strTPTaskID + ",") = -1 Then
                    If CType(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), Integer) <> 0 Then
                        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                        'strSQL2 = "SELECT ResourceLevelTaskCompletion FROM tbl_PM_Project WHERE ProjectID =  " & strTPProjectID
                        strSQL2 = "usp_sel_tbl_PM_Project_ResourceLevelTaskCompletion  " & strTPProjectID
                        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

                        blnResourceLevelTaskCompletion = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "0"))
                        If blnResourceLevelTaskCompletion Then
                            If CType(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), Integer) <> 100 Then
                                '--- Modified by purvaj on 19 Nov 2008 for Whiziblesem 8.0 
                                '--- Logic modified. DO not consider Resource allowed to mark task as complete.
                                '--- in any condition update both the fields ActualPercentComplete and ResourcePercentComplete
                                '--- ResourcePercentComplete = FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) added here
                                'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                                'CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & ", ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTPTaskID, MyBase.UseSQL)
                                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ProjectTasks_ActualPerc " & strTPTaskID & "," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & "," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False), MyBase.UseSQL)
                                'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                            Else
                                strCompletedTasks += strTPTaskID + ","
                                blntaskCompleted = True
                            End If
                        Else
                            '--- Modified by purvaj on 19 Nov 2008 for Whiziblesem 8.0 
                            '--- Logic modified. DO not consider Resource allowed to mark task as complete.
                            '--- in any condition update both the fields ActualPercentComplete and ResourcePercentComplete
                            '--- ActualPercentComplete = FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete" & strTaskID), 0, False, True), , , , TriState.False) added here
                            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                            'CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & ", ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTPTaskID, MyBase.UseSQL)
                            CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_ProjectTasks_ActualPerc " & strTPTaskID & "," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & "," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False), MyBase.UseSQL)
                            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

                        End If

                        If (MyBase.GetFormValue("chkTaskCompleted_" & strTPTaskID) <> "" And strUpdatedTasks.IndexOf("," + strTPTaskID + ",") = -1) Or blntaskCompleted = True Then
                            strSQLQuery.Append("Exec usp_Upd_ProjectTaskComplete " & strTPTaskID & ", 1 " + vbCrLf)
                        End If
                    End If

                    '--- added By purvaj on 19 Nov 2008 for Whiziblesem 8.0 for Task status management actual % complete
                    '--- Parent task's Actual % complete recalculated depending on the  % entered for child task
                    CommonFunction.Data.InsertOrUpdateData("usp_UPD_ActualPercentComplete_forParentTask '" + strTPTaskID.ToString + ",',0", True)
                    '--- End addition purvaj

                End If
            End If
        Next
        '---------------------------------
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If
        '---------------------------------

        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        For i = 0 To arrHdnChk.Length - 1
            Dim arrValues() As String = arrHdnChk(i).Split(CChar(":"))
            If arrValues.Length = 2 Then
                Dim strCKTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), "0"))
                Dim strCKProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))

                If MyBase.GetFormValue("chkTaskCompleted_" & strCKTaskID) <> "" And strUpdatedTasks.IndexOf("," + strCKTaskID + ",") = -1 And strCompletedTasks.IndexOf("," + strCKTaskID + ",") = -1 Then
                    strSQLQuery.Append("Exec usp_Upd_ProjectTaskComplete " & strCKTaskID & ", 1 " + vbCrLf)
                End If
            End If
        Next
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If

        strSQLQuery = Nothing
    End Sub

    Private Sub ProcessSave_ShowDetails()
        '=====================================================================
        ' Procedure Name        : ProcessSave_ShowDetails
        ' Purpose               : To Process save action of pop up page
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strDAIDs As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnDAID")))
        Dim arrDAIDs() As String = strDAIDs.Split(CChar(","))
        Dim strSQLQuery As New System.Text.StringBuilder

        Dim i As Integer

        For i = 0 To arrDAIDs.Length - 1
            Dim strDAID As String = arrDAIDs(i)

            Dim strTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnTaskID_" + strDAID)))
            Dim strProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnProjectID_" + strDAID)))
            Dim strEntryDate As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnEntryDate_" + strDAID)))
            Dim strIsDurationChange As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnDuCh_" + strDAID), "0"))
            Dim strDuration As String = CStr(CommonFunctions.General.CheckIsNothing(Request("txtDuration_" + strDAID), ""))
            Dim strDescription As String = CStr(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDescription_" + strDAID), ""))
            ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            Dim strStoryPoint As String = CStr(CommonFunctions.General.CheckIsNothing(Request("txtStoryPoint_" + strTaskID), ""))
            ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
            If strDAID <> "" And strDuration <> "" Then
                strSQLQuery.Append("Exec usp_Ins_tbl_PM_DailyActivity  ")
                strSQLQuery.Append(strDAID)
                strSQLQuery.Append("," & strTaskID)
                strSQLQuery.Append("," & strProjectID)
                strSQLQuery.Append("," & m_strSessionUserID)
                strSQLQuery.Append("," & m_strSessionPostID)
                strSQLQuery.Append(",'" & strEntryDate & "'")
                strSQLQuery.Append("," & FixString(strDuration, 0, False, False))
                strSQLQuery.Append(",'" & Left(FixString(strDescription, 2000, False, False), 2000) & "'")
                strSQLQuery.Append(", NULL,NULL")

                If Trim(strIsDurationChange) <> "1" Then
                    strSQLQuery.Append(", NULL")
                Else
                    strSQLQuery.Append(", 1")
                End If
                ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                If strStoryPoint <> "" Then
                    strSQLQuery.Append(", NULL,NULL,NULL,NULL,NULL," & strStoryPoint)
                Else
                    strSQLQuery.Append(", NULL,NULL,NULL,NULL,NULL")
                End If

                ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
                strSQLQuery.Append(" " & vbCrLf)
            End If
        Next

        ' Execute the update query.
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If

        strSQLQuery = Nothing

        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
        CommonFunctions.General.WriteHTML("try")
        CommonFunctions.General.WriteHTML("{")
        'CommonFunctions.General.WriteHTML("window.opener.location.reload();")
        'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
        'Check whether request came from Onsite Resource Timesheet
        If Request.QueryString("Fromwhere") = "Proxy" Then
            CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?Fromwhere=Proxy&EmployeeID=" + m_strSessionUserID + "&MasterTagID=9015';" + vbCrLf)
        Else
            CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?MasterTagID=9015';" + vbCrLf)
        End If
        'Addition End by SantoshK on 20th March 2006
        'CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?MasterTagID=9015';" + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.submit();" + vbCrLf)
        CommonFunctions.General.WriteHTML("}")
        CommonFunctions.General.WriteHTML("catch(e)")
        CommonFunctions.General.WriteHTML("{")
        CommonFunctions.General.WriteHTML("// This condition will come if the parentpage has been closed, of changed.")
        CommonFunctions.General.WriteHTML("// Do nothing.						")
        CommonFunctions.General.WriteHTML("}")
        CommonFunctions.General.WriteHTML("</script>")


        ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

        HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmAdvancedTimesheet'", "'Advanced_Timesheet.aspx'", "'../AdvancedTimesheet/Advanced_Timesheet.aspx?Filter=1&FromWhere=DA'", True))

        ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

    End Sub

    Private Sub ProcessTSAction()
        '=====================================================================
        ' Procedure Name        : ProcessTSAction
        ' Purpose               : To Process action related to timesheet generation
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Select Case m_strTSAction

            Case MODE_GENERATE_TIMESHEET
                GenerateTimesheet()
            Case MODE_GENERATE_SEND
                GenerateTimesheet()
                SendForApproval()
            Case MODE_REGENERATE_TIMESHEET
                RegenerateTimesheet()
            Case MODE_REGENERATE_SEND
                Generate_N_Send()
            Case MODE_SEND_APPROVAL
                Generate_N_Send()
        End Select
    End Sub

    Private Sub GenerateTimesheet()
        '=====================================================================
        ' Function Name         : GenerateTimesheet
        ' Purpose               : Generates the Resource Timesheet
        ' Author                : HarshK
        ' Created               : 2 Dec 2005
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As New System.Text.StringBuilder
        Dim drTimesheet As IDataReader

        strSQLQuery.Append("EXEC usp_GenerateResourceTimeSheet ")
        strSQLQuery.Append(m_strSessionUserID)
        strSQLQuery.Append(",'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy"))
        strSQLQuery.Append("','" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "'")
        drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        If drTimesheet.Read Then
            m_strTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), String)
        End If
        CommonFunction.Data.DisposeDataReader(drTimesheet)
        strSQLQuery = Nothing
    End Sub

    Private Sub RegenerateTimesheet()
        '=====================================================================
        ' Function Name         : RegenerateTimesheet
        ' Purpose               : Regenerates the Resource Timesheet
        ' Author                : HarshK
        ' Created               : 2 Dec 2005
        ' Revisions             : 
        '=====================================================================
        'No Daily Activities Present in the Timesheet,Feature Dates

        Dim strSQLQuery As New System.Text.StringBuilder
        Dim drTimesheet As IDataReader

        strSQLQuery.Append("EXEC usp_GenerateResourceTimeSheet ")
        strSQLQuery.Append(m_strSessionUserID)
        strSQLQuery.Append(",'" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy"))
        strSQLQuery.Append("','" + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + "'")
        If m_strTimeSheetID <> "" And m_strTimeSheetID <> "0" Then
            strSQLQuery.Append("," + m_strTimeSheetID)
        End If
        drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        If drTimesheet.Read Then
            m_strTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), String)
        End If
        CommonFunction.Data.DisposeDataReader(drTimesheet)
        strSQLQuery = Nothing
    End Sub

    Private Sub SendForApproval()
        '=====================================================================
        ' Procedure Name         : SendForApproval
        ' Purpose               : Updates the status of the Resource Timesheet(send for approval)
        ' Author                : HarshK
        ' Created               : 2 Dec 2005
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim drTimesheet As IDataReader, drEmailMessage As IDataReader
        Dim blnSendEmail As Boolean, blnShowPopup As Boolean
        Dim strProjectList As String = ""
        Dim strMsg As String = ""
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        If m_strTimeSheetID <> "0" Then
            strSQLQuery = " Exec usp_sel_GetRTApprovers " & m_strTimeSheetID & "," & m_strSessionUserID
            strProjectList = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "").ToString
        End If
        If strProjectList = "" Then
            strSQLQuery = "EXEC usp_Upd_ResouceTimesheetStatus " + m_strTimeSheetID + ",'" + STATUS_READY_FOR_VERIFICATION + "'"
            drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drTimesheet.Read Then
                m_strTimeSheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), String)
            End If
            CommonFunction.Data.DisposeDataReader(drTimesheet)

            strSQLQuery = "usp_Sel_tbl_PM_EmailMessages " + MAIL_READY_FOR_VERIFICATION
            drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drEmailMessage.Read Then
                blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(drEmailMessage)

            ' Check if the mail has to be sent.
            If blnSendEmail = True Then
                ' Check if a popup message has to be shown.
                If blnShowPopup = True Then
                    CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                    CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=" _
                    + MAIL_READY_FOR_VERIFICATION + "&TimesheetID=" + m_strTimeSheetID + "&EmailMode=Generate', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                    CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                Else
                    CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_434(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CInt(m_strTimeSheetID))
                    CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
        Else
            strMsg = MyBase.GetResourceString("MSG_APPROVERNOTSET")
            strMsg = Replace(strMsg, "<PROJECTLIST>", strProjectList)
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("alert(""" & strMsg & """)")
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        End If

    End Sub

    Private Sub Generate_N_Send()

        Dim drDAsPresentInTimeSheet As IDataReader
        Dim strSQLQuery As String
        Dim dblDATimeSheetHrs As Double
        Dim blnDAsPresent As Boolean = False
        Dim blnIsAllowed As Boolean = True
        Dim strMsg As String = ""
        'If da not present then do not allow to genetare timesheet
        '---------------------------------------------------------
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT DATimeSheetHrs = ISNULL(SUM(Duration),0) "
        'strSQLQuery += " FROM tbl_PM_DailyActivity "
        'strSQLQuery += " WHERE EmployeeID = " & m_strSessionUserID
        'strSQLQuery += " And EntryDate BETWEEN '" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "' AND '" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"
        strSQLQuery = "usp_sel_tbl_PM_DailyActivity_TimeSheetHrs " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

        drDAsPresentInTimeSheet = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drDAsPresentInTimeSheet.Read() Then
            dblDATimeSheetHrs = CType(drDAsPresentInTimeSheet("DATimeSheetHrs"), Double)
            If dblDATimeSheetHrs > 0 Then
                blnDAsPresent = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drDAsPresentInTimeSheet)
        '-----------------------------------------------------------
        'Timesheet for feature date cnanot be generated
        'If DateDiff(DateInterval.Day, System.DateTime.Now, m_dtStartDateOfWeek) > 0 Then
        '    blnIsAllowed = False
        'End If
        '---------------------------------------------------------
        If blnIsAllowed = False Then
            strMsg = MyBase.GetResourceString("MSG_FEATURE_DATE")
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("alert(""" & strMsg & """)")
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            Return
        ElseIf blnDAsPresent <> True Then
            strMsg = MyBase.GetResourceString("MSG_NO_DA")
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("alert(""" & strMsg & """)")
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            Return
        End If
        RegenerateTimesheet()
        SendForApproval()

    End Sub

    Private Sub DeleteDA()
        Dim strChkDel As String = CommonFunctions.General.CheckIsNothing(Request("chkDelete"), "")
        Dim arrChkDel() As String = strChkDel.Split(CChar(","))
        Dim i As Integer = 0
        Dim drDAEntry As IDataReader
        Dim strSQL As String

        For i = 0 To arrChkDel.Length - 1
            If arrChkDel(i) = m_strDAID Then
                m_strDAID = arrChkDel(i)
            End If
            If arrChkDel(i) <> "" Then
                strSQL = "usp_Del_tbl_PM_DailyActivity " & arrChkDel(i)
                drDAEntry = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drDAEntry.Read Then
                    If CType(CommonFunction.Data.CheckIsDBNull(drDAEntry(1), "0"), Boolean) = False Then
                        CommonFunction.General.WriteHTML("<script language=Javascript>")
                        CommonFunction.General.WriteHTML("alert('Cannot delete the Task " + CType(CommonFunction.Data.CheckIsDBNull(drDAEntry(0), "0"), String) + "');")
                        CommonFunction.General.WriteHTML("</script>")
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drDAEntry)
            End If
        Next

        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
        CommonFunctions.General.WriteHTML("try")
        CommonFunctions.General.WriteHTML("{")
        'CommonFunctions.General.WriteHTML("window.opener.location.reload();")
        'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
        'Check whether request came from Onsite Resource Timesheet
        If Request.QueryString("Fromwhere") = "Proxy" Then
            CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?Fromwhere=Proxy&EmployeeID=" + m_strSessionUserID + "&MasterTagID=9015';" + vbCrLf)
        Else
            CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.action = '../TimeSheet/TS_Scrum_WeeklyTimesheet.aspx?MasterTagID=9015';" + vbCrLf)
        End If
        'Addition End by SantoshK on 20th March 2006
        CommonFunctions.General.WriteHTML("window.opener.frmScrumWeeklyTimesheet.submit();" + vbCrLf)
        CommonFunctions.General.WriteHTML("}")
        CommonFunctions.General.WriteHTML("catch(e)")
        CommonFunctions.General.WriteHTML("{")
        CommonFunctions.General.WriteHTML("// This condition will come if the parentpage has been closed, of changed.")
        CommonFunctions.General.WriteHTML("// Do nothing.						")
        CommonFunctions.General.WriteHTML("}")
        CommonFunctions.General.WriteHTML("</script>")

        ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

        HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmAdvancedTimesheet'", "'Advanced_Timesheet.aspx'", "'../AdvancedTimesheet/Advanced_Timesheet.aspx?Filter=1&FromWhere=DA'", True))

        ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

    End Sub

#End Region

#Region "Grid Functions 2"
    Private Sub DrawTaskGrid2()
        '=====================================================================
        ' Procedure Name        : DrawTaskGrid2
        ' Purpose               : To draw Grid
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strSql As New System.Text.StringBuilder
        Dim blnRecordPresent As Boolean = False
        Dim drGrid As IDataReader
        Dim strOldProjectName As String = "", strProjectName As String = "", strOldProjectID As String = ""
        Dim strOldTaskType As String = "", strTaskType As String = ""
        Dim strProjectID As String = "", strTaskName As String = "", strTaskID As String = ""
        Dim strActualPercentComplete As String = ""
        Dim strWhichTask As String
        Dim strTaskStartDate As String
        Dim strTaskEndDate As String
        Dim strTaskActualStartDate As String
        Dim strActualEndDate As String
        Dim strMaxEntryDate As String
        Dim strConstraintType As String
        Dim strConstraintDate As String
        Dim blnTaskComplete As Boolean
        Dim dblAllocatedWork As Double
        Dim dblActualWork As Double
        Dim dblWorkDone As Double
        Dim dblActualTotal As Double = 0
        Dim dblActualTotalAll As Double = 0
        Dim blnResourceLevelTaskCompletion As Boolean
        Dim i As Integer
        Dim lngRowNo As Long = -1, lngTaskRowNo As Long = 0
        Dim arrTaskTotal() As Double = {0, 0, 0, 0, 0, 0, 0}
        Dim arrProjectTotal() As Double = {0, 0, 0, 0, 0, 0, 0}
        Dim arrDA_ID() As Double = {0, 0, 0, 0, 0, 0, 0} 'array for dailyActivityEntryID
        Dim blnTimeBookedAgainstTask As Boolean
        'Commented and added by Yogesh J 02-Dec-2015
        ' strSql.Append("usp_Sel_tbl_PM_ProjectTasks_Scrum_WeeklyView " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString & "','" & m_dtEndDateOfWeek.ToString & "'")
        strSql.Append("usp_Sel_tbl_PM_ProjectTasks_Scrum_WeeklyView " & m_strSessionUserID & ",'" & Format(CType(FormatDateTime(m_dtStartDateOfWeek.ToString, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtEndDateOfWeek.ToString, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "'")
        'End of Comment and added by Yogesh J
        If m_strSelectedTaskType = ALL_TASK_TYPES Then
            strSql.Append(",NULL")
        Else
            strSql.Append(",'" & m_strSelectedTaskType & "'")
        End If
        strSql.Append("," & m_strTaskFilter & ",'" & m_strProjectFilters & "'")

        drGrid = CommonFunctions.Data.GetDataReader(strSql.ToString, MyBase.UseSQL)

        'DrawTaskHeader_1()
        'Commented and added by Yogesh J on 03-Dec-2015
        'CommonFunctions.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;Height:300px'>")
        CommonFunctions.General.WriteHTML("<div id='divList' style='Overflow:auto;width:100%;'>")
        'End of comment by Yogesh J on 03-Dec-2015
        CommonFunctions.General.WriteHTML("<Table id='tblList'  cellSpacing=1 cellPadding=1 border=0 class='clsTable' width='99.9%'>")
        '--------------
        lngRowNo += 1
        DrawTaskHeader_2(True)



        ''Modified By NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 regression Issue 
        '' Status code of timesheet is not changeing per project hence getting the timesheet status and passing it as parameter 
        ''Added By JyotiG
        ''Issue ID : 6850
        ''Start
        'Dim strSQL2 As String = "SELECT Isnull( StatusCode , 'N' ) FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" & m_strSessionUserID & " AND DATEDIFF(dd,FromDate,'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "') <= 0 AND DATEDIFF(dd,ToDate,'" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "') >= 0"
        'Dim strTStatus As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "N"), String)
        Dim strTStatus As String
        strTStatus = mstrStatus

        If IsNothing(strTStatus) = True Or strTStatus = "" Then
            strTStatus = "N"
        End If

        ''End of modification by JyotiG
        ' End Modification By NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue 


        While drGrid.Read
            blnRecordPresent = True
            '-----Reading from data reader------------------------------
            Dim arrDA(7) As String

            strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("ProjectName"), ""))
            strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("ProjectID"), "0"))
            strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("TaskName"), ""))
            strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("TaskID"), "0"))
            strTaskType = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("WhichTask"), "0"))
            blnResourceLevelTaskCompletion = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ResourceLevelTaskCompletion"), "0"), Boolean)
            strMaxEntryDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("MaxEntryDate"), "0"), String)
            '---------------------------------------------------------------------
            strTaskStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("StartDate"), ""), String)
            strTaskEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("EndDate"), ""), String)
            strTaskActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ActualStartDate"), ""), String)
            strActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ActualEndDate"), ""), String)
            blnTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("IsTaskComplete"), "0"), Boolean)
            dblAllocatedWork = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("Work"), "0"), Double)
            dblActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ActualWork"), "0"), Double)
            dblWorkDone = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("WorkDone"), "0"), Double)
            strConstraintType = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ConstraintType"), ""), String)
            strConstraintDate = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ConstraintDate"), ""), String)
            '-------
            Dim strSecName As String = "hdnSection_" & strProjectID
            Dim strSecValue As String = CommonFunctions.General.CheckIsNothing(Request(strSecName), "0")
            If m_strDefaultProjectID = "" Then
                m_strDefaultProjectID = strProjectID
            End If
            '-------Draw Task Total----------------------------------------------------------------
            If strOldProjectID <> strProjectID Then
                If strOldProjectID <> "" Then
                    lngRowNo += 1
                    DrawTaskTotal_2(strProjectID, arrTaskTotal, dblActualTotal, strOldProjectName)
                    ResetToZero(arrTaskTotal)  ' reset task total array
                    dblActualTotal = 0
                End If
            End If
            '-----------------------------------------------------------------------
            For i = 0 To 6
                arrDA(i) = CStr(CommonFunctions.Data.CheckIsDBNull(drGrid((i + 1).ToString), ""))
                dblActualTotal += CDbl(IIf(arrDA(i) = "", 0, arrDA(i))) 'project wise total
                dblActualTotalAll += CDbl(IIf(arrDA(i) = "", 0, arrDA(i))) 'Total for all projects
                'Modified By VidyaJ - SP8 Performance
                arrDA_ID(i) = 0 'CDbl(CommonFunctions.Data.CheckIsDBNull(drGrid("DA" + (i + 1).ToString), "0")) 'DailyActivityEntryID

                arrTaskTotal(i) += CDbl(CommonFunctions.Data.CheckIsDBNull(drGrid((i + 1).ToString), "0")) 'project wise total
                arrProjectTotal(i) += CDbl(CommonFunctions.Data.CheckIsDBNull(drGrid((i + 1).ToString), "0")) 'Total for all projects
            Next
            '-----------------------------------------------------------------------
            If blnResourceLevelTaskCompletion Then
                strActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ActualPercentComplete"), "0"), String)
            Else
                strActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drGrid("ResourcePercentComplete"), "0"), String)
            End If
            '-------------------------------
            If strTaskActualStartDate <> "" Then
                blnTimeBookedAgainstTask = True
            Else
                blnTimeBookedAgainstTask = False
            End If
            '------Project Grouping--------------------------------------
            If strOldProjectID <> strProjectID Then
                lngRowNo += 1
                'If m_strSessionProjectID = strProjectID Or strSecValue = "1" Then
                If m_strDefaultProjectID = strProjectID Or strSecValue = "1" Then
                    DrawProjectGroup_2(strProjectName, strProjectID, lngRowNo, True)
                Else
                    DrawProjectGroup_2(strProjectName, strProjectID, lngRowNo, False)
                End If
                strOldTaskType = "" ' reset task group
            End If
            '------Task Grouping----------------------------------------
            If strOldTaskType <> strTaskType Then
                lngRowNo += 1
                'If m_strSessionProjectID = strProjectID Or strSecValue = "1" Then
                If m_strDefaultProjectID = strProjectID Or strSecValue = "1" Then
                    DrawTaskGroup(strProjectID, strTaskType, True)
                Else
                    DrawTaskGroup(strProjectID, strTaskType, False)
                End If
            End If
            '-----------------------------------------------------------
            'lngRowNo += 2
            'lngTaskRowNo += 2  'DrawTaskDetail_2 plot 2 rows
            'If m_strSessionProjectID = strProjectID Or strSecValue = "1" Then

            If m_strDefaultProjectID = strProjectID Or strSecValue = "1" Then
                DrawTaskDetail_2(strProjectID, strTaskName, strTaskID, strActualPercentComplete, lngRowNo, arrDA, dblAllocatedWork, dblActualWork, dblWorkDone, blnTaskComplete, strTaskStartDate, strTaskEndDate, strTaskType _
                , strMaxEntryDate, blnResourceLevelTaskCompletion, strTaskActualStartDate, strActualEndDate _
                , strConstraintType, strConstraintDate, True, arrDA_ID, strProjectName, strTStatus)
            Else
                DrawTaskDetail_2(strProjectID, strTaskName, strTaskID, strActualPercentComplete, lngRowNo, arrDA, dblAllocatedWork, dblActualWork, dblWorkDone, blnTaskComplete, strTaskStartDate, strTaskEndDate, strTaskType _
                , strMaxEntryDate, blnResourceLevelTaskCompletion, strTaskActualStartDate, strActualEndDate _
                , strConstraintType, strConstraintDate, False, arrDA_ID, strProjectName, strTStatus)
            End If
            '-----------------------------------------

            strOldProjectID = strProjectID
            strOldProjectName = strProjectName
            strOldTaskType = strTaskType

            'Added By VidyaJ - SP8 Performance
            Dim strBackDating As String
            Dim strForwardating As String
            If CType(CommonFunctions.Data.CheckIsDBNull(drGrid("IsBackDating"), "0"), Boolean) = False Then
                strBackDating = "false"
            Else
                strBackDating = "true"
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drGrid("IsForwardDating"), "0"), Boolean) = False Then
                strForwardating = "false"
            Else
                strForwardating = "true"
            End If


            m_strJavaScript += " arrProjectTasks.push(new ProjectTasks(" & strProjectID & "," _
                                & strTaskID & "," _
                                & getMaxEntry(strProjectID) & "," _
                                & strBackDating & "," _
                                & strForwardating & "," _
                                & "'" & CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("ConstraintType"), "")) & "'," _
                                & "'" & CStr(CommonFunctions.Data.CheckIsDBNull(drGrid("ConstraintDate"), "")) & "'," _
                                & "'" & strTaskType & "'," _
                                & CStr(IIf(CBool(CommonFunctions.Data.CheckIsDBNull(drGrid("EnforceConstraints"), "0")) = True, "true", "false")) & "," _
                                & CStr(IIf(blnTimeBookedAgainstTask = True, "true", "false")) _
                                & "));" & vbCrLf
        End While
        If blnRecordPresent = True Then
            DrawTaskTotal_2(strProjectID, arrTaskTotal, dblActualTotal, strProjectName)
            'DrawTotalAll_2(strProjectID, arrProjectTotal, dblActualTotalAll)
        Else
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD align=center colspan=13>")
            CommonFunctions.General.WriteHTML(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MSG_NORECORD"), "There are no items to show in this view."))
            CommonFunctions.General.WriteHTML("</TD></TR>")
        End If
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("</div>")
        '---------Total----------------
        CommonFunctions.General.WriteHTML("<BR>")
        DrawTotalAll_2(strProjectID, arrProjectTotal, dblActualTotalAll)
        CommonFunctions.Data.DisposeDataReader(drGrid)
        strSql = Nothing
    End Sub

    Private Sub DrawTaskGroup(ByVal strProjectID As String, ByVal strTaskType As String, ByVal openSection As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawTaskGroup
        ' Purpose               : To draw Task Type row
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strRowStyle As String

        If (openSection = True) Then
            strRowStyle = ""
        Else
            strRowStyle = "style='display:none'"
        End If
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' " & strRowStyle & ">")
        CommonFunctions.General.WriteHTML("<TD colspan=13 align=left>")

        Select Case strTaskType
            Case "D"
                CommonFunctions.General.WriteHTML("<i>" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_GENERAL_TASK"), "General Tasks") & "</i>")
            Case "O"
                CommonFunctions.General.WriteHTML("<i>" & MyBase.GetResourceString("CAP_ASSIGNED_TASK") & "</i>")
            Case "M"
                CommonFunctions.General.WriteHTML("<i>" & MyBase.GetResourceString("CAP_MPP_TASK") & "</i>")
            Case "B"
                CommonFunctions.General.WriteHTML("<i>" & MyBase.GetResourceString("CAP_ISSUE_TASK") & "</i>")
            Case Else
                CommonFunctions.General.WriteHTML("<i>" & MyBase.GetResourceString("CAP_OTHER_TASK") & "</i>")
        End Select

        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
    End Sub

    Private Sub DrawTotalAll_2(ByVal strProjectID As String, ByVal arrProjectTotal() As Double, ByVal dblActualTotalAll As Double)
        '=====================================================================
        ' Procedure Name        : DrawTotalAll_2
        ' Purpose               : To draw Total of all projects
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        CommonFunctions.General.WriteHTML("<Table bgcolor='#8b0000' id='tblTotal' CellSpacing='1' CellPadding='1' class='clsTable' Style=""table-layout:fixed;"">")
        CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")

        CommonFunctions.General.WriteHTML("<TD colspan=3 >")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("CAP_PROJECT_TOTAL_ALL") & "</b>")
        CommonFunctions.General.WriteHTML("</TD>")

        For i = 0 To 6
            CommonFunctions.General.WriteHTML("<TD align=right id=TDA" & (i + 3).ToString & " >")
            If arrProjectTotal(i) = 0 Then
                CommonFunction.General.WriteHTML("<b>" + FormatNumber(arrProjectTotal(i), 2) + "</b>")
            Else
                CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(0,3,'" & (i + 1).ToString & "')""><b>" + FormatNumber(arrProjectTotal(i), 2) + "</b></a>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")
        Next

        CommonFunctions.General.WriteHTML("<TD colspan=2 align=center >")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD  align=right >")
        CommonFunctions.General.WriteHTML(FormatNumber(dblActualTotalAll, 2))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("</Table>")
    End Sub

    Private Sub DrawTaskDetail_2(ByVal strProjectID As String, ByVal strTaskName As String, ByVal strTaskID As String, ByVal strActualPercentCompleteas As String, ByRef lngRowNo As Long, ByVal arrDA() As String, ByVal dblAllocatedWork As Double, ByVal dblActualWork As Double, ByVal dblWorkDone As Double, ByVal blnTaskComplete As Boolean, ByVal strTaskStartDate As String, ByVal strTaskEndDate As String, ByVal strTaskType As String, ByVal strMaxEntryDate As String, ByVal blnResourceLevelTaskCompletion As Boolean, ByVal strTaskActualStartDate As String, ByVal strActualEndDate As String, ByVal strConstraintType As String, ByVal strConstraintDate As String, ByVal openSection As Boolean, ByVal arrDA_ID() As Double, ByVal strProjectName As String, ByVal strTStatus As String)
        '=====================================================================
        ' Procedure Name        : DrawTaskDetail_2
        ' Purpose               : To draw actual grid
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strRowStyle As String
        Dim i As Integer
        Dim dblWeekTotal As Double = 0
        Dim intColIndex As Integer = 0
        Dim strTitle As New System.Text.StringBuilder
        Dim strTooltipConstraintType As String
        'commented By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue 
        ' Moved at the begining of the procedure call 
        ''Added By JyotiG
        ''Issue ID : 6850
        ''Start
        'Dim strSQL2 As String = "SELECT TimesheetID,StatusCode FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" & m_strSessionUserID & " AND DATEDIFF(dd,FromDate,'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "') <= 0 AND DATEDIFF(dd,ToDate,'" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "') >= 0"
        'Dim drTStatus As IDataReader
        'Dim strTStatus As String = ""
        'drTStatus = CommonFunctions.Data.GetDataReader(strSQL2, MyBase.UseSQL)
        'If drTStatus.Read Then
        '    strTStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drTStatus("StatusCode"), "N"))
        'End If
        'CommonFunction.Data.DisposeDataReader(drTStatus)
        ''End of modification by JyotiG
        ' End commenting by NitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue 

        If openSection = True Then
            strRowStyle = ""
        Else
            strRowStyle = "style='display:none'"
        End If


        If strConstraintType <> "" Then
            Select Case strConstraintType
                Case "0" 'as soon as possible
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_ASAP")
                Case "1" 'as late as possible
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_ALAP")
                Case "2" 'Must Start on 
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_MSO")
                Case "3" 'Must Finish on
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_MFO")
                Case "4" 'start no earlier than 
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_NET")
                Case "5" 'Start no later than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_SNLT")
                Case "6" 'Finish no eariler than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_FNET")
                Case "7" 'finish no later than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_FNLT")
            End Select
        Else
            strTooltipConstraintType = MyBase.GetResourceString("CAP_NOCONSTRAINT")
        End If

        'Modified By VidyaJ - issueid - 11819
        strTitle.Append("[Project : " + strProjectName.Replace("\'", "/'/g") + "]")
        strTitle.Append(vbCrLf & "[Task : " + strTaskName.Replace("\'", "/'/g") + "]")
        If strTaskType <> GENERAL_TASKS Then
            strTitle.Append(vbCrLf & "Status" & vbTab & vbTab & vbTab & " = ")
            If blnTaskComplete Then
                strTitle.Append("Complete")
            Else
                strTitle.Append("InProgress")
            End If
            If strTaskStartDate <> "" Then strTitle.Append(vbCrLf & "Start Date" & vbTab & vbTab & " = " & CDate(strTaskStartDate).ToString("dd-MMM-yyyy"))
            If strTaskEndDate <> "" Then strTitle.Append(vbCrLf & "End Date" & vbTab & vbTab & " = " & CDate(strTaskEndDate).ToString("dd-MMM-yyyy"))
            If strTaskActualStartDate <> "" Then strTitle.Append(vbCrLf & "Actual Start Date" & vbTab & " = " & CDate(strTaskActualStartDate).ToString("dd-MMM-yyyy"))
            If strActualEndDate <> "" Then strTitle.Append(vbCrLf & "Actual End Date" & vbTab & vbTab & " = " & CDate(strActualEndDate).ToString("dd-MMM-yyyy"))

            If strTaskType = PROJECT_SPECIFIC_TASKS Then
                strTitle.Append(vbCrLf & vbCrLf & "Constraint : " & strTooltipConstraintType)
                If strConstraintType <> "" Then
                    If CInt(strConstraintType) > 1 Then
                        strTitle.Append(CommonFunction.General.FormatString(" '" & strConstraintDate & "'"))
                    End If
                End If
            End If
        End If
        ''////////////////////////////////////
        '------------Task detail like start date
        If strTaskType <> GENERAL_TASKS Then
            intColIndex = 2
            lngRowNo += 1
            CommonFunctions.General.WriteHTML("<TR id=TRS_" + strTaskID + " class='clsTREven' " & strRowStyle & ">")
            '---Task name column-------------------------------
            CommonFunctions.General.WriteHTML("<TD title ='" & CommonFunction.General.FormatString(Server.HtmlEncode(strTitle.ToString)) & "' id = TDS0_" + strTaskID + "  rowSpan=2 width='" + TD_WIDTH_3 + "' >")
            'Status Comparison code added by JyotiG
            'Issue ID : 6850
            If blnTaskComplete = False And strTStatus <> "V" Then
                ''Added And Commented By Vidya J ON 29-01-2016
                CommonFunction.General.WriteHTML("<a href=""javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                ' Dim m_PKToken = CommonFunctions.Security.Token.GetToken(CType(strTaskID, String) + CType(strProjectID, String) + "0" + "0")
                'CommonFunction.General.WriteHTML("<a href=""javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "','" & m_PKToken & "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                ''End Of Added And Commented By Vidya J ON 29-01-2016
                'shraddha
                'CommonFunction.General.WriteHTML("<a href=javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')>" + CommonFunction.General.FormatString(strTaskName) + "</a>")
            Else
                CommonFunction.General.WriteHTML(CommonFunction.General.FormatString(strTaskName))
            End If
            CommonFunctions.General.WriteHTML("</TD>")
            '---Start date column------------------------------

            'Modified by MrugajaB on 3rd Aug 2006
            'Purpose: The start and end date of task was getting appended with bold tags which was creating problem in date checks
            'Modified BY VarunA on 27-Aug-2008 RequestID-15303
            'Purpose : To solve the alignment issue
            'CommonFunctions.General.WriteHTML("<TD id = TDS1_" + strTaskID + "  colspan=3 width=200>")
            CommonFunctions.General.WriteHTML("<TD id = TDS1_" + strTaskID + "  colspan=3 >")
            'End By VarunA on 27-Aug-2008 RequestID-15303
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_START_DATE") + " = <b>" & strTaskStartDate)
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_START_DATE") + " = " & strTaskStartDate)
            'CommonFunctions.General.WriteHTML("</b></TD>")
            CommonFunctions.General.WriteHTML("</TD>")
            '---End date column--------------------------------
            CommonFunctions.General.WriteHTML("<TD id = TDS2_" + strTaskID + "  colspan=4 >")
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_END_DATE") + " = <b>" & strTaskEndDate)
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_END_DATE") + " = " & strTaskEndDate)
            'CommonFunctions.General.WriteHTML("</b></TD>")
            CommonFunctions.General.WriteHTML("</TD>")
            'End Modification
            'Mpp Hours
            CommonFunctions.General.WriteHTML("<TD id = TDS2_" + strTaskID + "  colspan=5 >")
            If dblWorkDone <> 0 Then CommonFunctions.General.WriteHTML("<font color=blue><b>(" + FormatNumber(dblWorkDone, 2) + " hrs uploaded from the MPP.)</b>")
            CommonFunctions.General.WriteHTML("</b></TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        '--**************************************
        lngRowNo += 1
        CommonFunctions.General.WriteHTML("<TR id=TRD_" + strProjectID + "_" + strTaskID + " name = TRD_" + strProjectID + "_" + strTaskID + " class='clsTREven'  " & strRowStyle & ">")
        If strTaskType = GENERAL_TASKS Then
            '---Task name column-------------------------------
            intColIndex = 3
            CommonFunctions.General.WriteHTML("<TD title ='" & strTitle.ToString & "' id = TDS0_" + strTaskID + "  width='" + TD_WIDTH_3 + "' >")
            'Status Comparison code added by JyotiG
            'Issue ID : 6850
            If blnTaskComplete = False And strTStatus <> "V" Then
                CommonFunction.General.WriteHTML("<a href=""javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                'shraddha
                'CommonFunction.General.WriteHTML("<A href=javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')>" + CommonFunction.General.FormatString(strTaskName) + "</A>")
            Else
                CommonFunction.General.WriteHTML(CommonFunction.General.FormatString(strTaskName))
            End If
            CommonFunctions.General.WriteHTML("</TD>")
        End If
        '---Allocated hours column-------------------------
        CommonFunctions.General.WriteHTML("<TD id=TDA_" + strTaskID + "  width='" + TD_WIDTH_4 + "' align=right>")
        If strTaskType = GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("N/A")
        Else
            CommonFunctions.General.WriteHTML(FormatNumber(dblAllocatedWork, 2))
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        '---Actual hours column----------------------------
        CommonFunctions.General.WriteHTML("<TD id=TDB_" + strTaskID + "  width='" + TD_WIDTH_4 + "' align=right>")

        'Commented and Modified By JyotiG
        'Issue Id : 6801
        'Date : 09-Oct-2006
        'Start
        If strTaskType = GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("N/A")
        Else
            If dblActualWork = 0 Then
                CommonFunction.General.WriteHTML("<b>" + CStr(dblActualWork) + "</b>")
            Else
                CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",1)""><b>" + FormatNumber(dblActualWork, 2) + "</b></a>")
            End If
            If dblWorkDone <> 0 Then
                CommonFunction.General.WriteHTML("<a HREF='javascript:ShowWorkDone(" + FormatNumber(dblWorkDone, 1) + ")'><font color='blue'><b>" + FormatNumber(dblWorkDone, 2) + "</b></font></a>")
            End If
        End If
        'If dblActualWork = 0 Then
        '    CommonFunction.General.WriteHTML("<b>" + CStr(dblActualWork) + "</b>")
        'Else
        '    CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",1)""><b>" + FormatNumber(dblActualWork, 2) + "</b></a>")
        'End If
        'If dblWorkDone <> 0 Then
        '    CommonFunction.General.WriteHTML("<a HREF='javascript:ShowWorkDone(" + FormatNumber(dblWorkDone, 1) + ")'><font color='blue'><b>" + FormatNumber(dblWorkDone, 2) + "</b></font></a>")
        'End If
        'End of Modification By JyotiG

        CommonFunctions.General.WriteHTML("</TD>")
        Dim strDate As String
        '---7 Days column----------------------------------
        For i = 0 To 6 'style='border-Top-Style:solid;Border-Top-Width:thin;BORDER-TOP-COLOR:' DISABLED_COLOR
            If arrDA(i) <> "" Then
                dblWeekTotal += CDbl(arrDA(i))
                CommonFunctions.General.WriteHTML("<TD align=right style='BORDER-TOP:" & DISABLED_COLOR & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + DISABLED_COLOR + "' align=center onclick=""PlotControls(this,'" + strProjectID + "','" + (i + 3).ToString & "_" + strTaskID + "' )""   >")
                'Modified By VidyaJ - SP8 Performance
                'CommonFunctions.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(" & arrDA_ID(i).ToString & ",0)"">")
                strDate = CType(DateAdd(DateInterval.Day, i, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), String)
                CommonFunctions.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(" & strTaskID & ",0,'" & strDate & "' )"">")

                CommonFunctions.General.WriteHTML(FormatNumber(CDbl(arrDA(i)), 2))
                CommonFunctions.General.WriteHTML("</a>")
            Else
                If blnTaskComplete = True And strTaskType <> GENERAL_TASKS Then 'completed tasks are disabled
                    'CommonFunctions.General.WriteHTML("<TD style='BORDER-TOP:" & DISABLED_COLOR & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + DISABLED_COLOR + "' align=center onclick=""PlotControls(this,'" + strProjectID + "','" + (i + 3).ToString & "_" + strTaskID + "' )"" >")
                    CommonFunctions.General.WriteHTML("<TD style='BORDER-TOP:" & DISABLED_COLOR & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + DISABLED_COLOR + "' align=center  >")
                ElseIf blnTaskComplete = False And m_objAccessRights.Add = False Then
                    CommonFunctions.General.WriteHTML("<TD style='BORDER-TOP:" & CellColor & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + CellColor + "' align=center  >")
                Else
                    CommonFunctions.General.WriteHTML("<TD id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + CellColor + "' align=center onclick=""PlotControls(this,'" + strProjectID + "','" + (i + 3).ToString & "_" + strTaskID + "' )""  >")
                End If
            End If
            'CommonFunctions.General.WriteHTML("<IMG style='visibility:hidden' id='TDM" & (i + 3).ToString & "-" & strTaskID & "' src='../../Images/red.gif'>")
            CommonFunctions.General.WriteHTML("</TD>")
        Next
        '---actual percent complete column ----------------
        CommonFunctions.General.WriteHTML("<TD  align=center width='" + TD_WIDTH_4 + "' id=TDS4_" + strTaskID + " align=center title='" & MyBase.GetResourceString("COL_ACTUAL_PERCENT") & "'>")
        If strTaskType = GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("N/A")
        Else
            If blnTaskComplete = True Then
                CommonFunctions.General.WriteHTML(FormatNumber(strActualPercentCompleteas, 2, , , TriState.False))
            Else
                'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txtPercentComplete_" + strTaskID, "txtPercentComplete_" + strTaskID, , 45, 7, FormatNumber(strActualPercentCompleteas, 2, , , TriState.False), "Right", , , , , , "align=right  onblur='javascript:txtPercentComplete_OnBlur(this)' OnChange='javascript:txtPercentComplete_OnChange(this)'", , True, EnableHTMLEncode:=True)
                'ended by Shamkant s  for HTML encoding Date:07/10/15
            End If
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        '---Task complete checkbox column------------------
        CommonFunctions.General.WriteHTML("<TD  align=center width='" + TD_WIDTH_4 + "'  id=TDS5_" + strTaskID + " align=center title='" & MyBase.GetResourceString("COL_TASK_COMPLETE") & "'>")
        If strTaskType = GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("N/A")
        Else
            If blnResourceLevelTaskCompletion Then
                If strMaxEntryDate <> "0" Then
                    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted_" + strTaskID, "chkTaskCompleted_" + strTaskID, , blnTaskComplete, strTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this,'" + Date.Parse(strMaxEntryDate).ToString("MM/dd/yyyy") + "') ", True))
                Else
                    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted_" + strTaskID, "chkTaskCompleted_" + strTaskID, , blnTaskComplete, strTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this) ", True))
                End If
            Else
                CommonFunctions.General.WriteHTML("N/A")
            End If
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        '---work hours this week column---------------------
        'Modified By VarunA on 7-Oct-2008 IssueID-23398
        'Purpose : Alignment Problem of Work Hrs
        'CommonFunctions.General.WriteHTML("<TD  align=center id=TDS6_" + strTaskID + "  width='" + TD_WIDTH_4 + "' >")
        CommonFunctions.General.WriteHTML("<TD  align=right id=TDS6_" + strTaskID + "  width='" + TD_WIDTH_4 + "' >")
        'End By VarunA on 7-Oct-2008 IssueID-23398
        If dblWeekTotal = 0 Then
            Response.Write("<B>" + CStr(dblWeekTotal) + "</B>")
        Else
            CommonFunction.General.WriteHTML("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",2)"">")
            CommonFunction.General.WriteHTML("<b>" + FormatNumber(dblWeekTotal, 2) + "</b>")
            CommonFunction.General.WriteHTML("</a>")
        End If
        CommonFunctions.General.WriteHTML("</TD>")


        CommonFunctions.General.WriteHTML("</TR>")
        strTitle = Nothing

    End Sub

    Private Sub DrawProjectGroup_2(ByVal strProjectName As String, ByVal strProjectID As String, ByVal lngRowNo As Long, ByVal openSection As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawProjectGroup_2
        ' Purpose               : To draw Project Name row
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader' >")
        CommonFunctions.General.WriteHTML("<TD align='left' colspan='13'>")

        CommonFunctions.General.WriteHTML("<A href=""Javascript:ShowHideRows('" + strProjectID + "'," & lngRowNo.ToString & ")"">")
        Dim strSecName As String = "hdnSection_" & strProjectID
        If openSection = True Then
            'Commented and added by Shamkant s for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML("<Img Border=0 id=img" + strProjectID + " Src='../../Images/minus.gif' Title='' /></A>")
            CommonFunctions.HTMLControls.DrawTextBox(strSecName, strSecName, , , , "1", , , , , , True, EnableHTMLEncode:=True)
        Else
            CommonFunctions.General.WriteHTML("<Img Border=0 id=img" + strProjectID + " Src='../../Images/plus.gif' Title='' /></A>")
            CommonFunctions.HTMLControls.DrawTextBox(strSecName, strSecName, , , , "0", , , , , , True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:07/10/15

        End If
        CommonFunctions.General.WriteHTML("<b>" + strProjectName)
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        '------Row for task deatil------------------------
        'CommonFunctions.General.WriteHTML("<TR >")
        'CommonFunctions.General.WriteHTML("<TD align='left' colspan='13'>")
        'If openSection = True Then
        '    CommonFunctions.General.WriteHTML("<TABLE id='tbl_" + strProjectID + "' cellSpacing=1 cellPadding=1 border=0 bgColor=dodgerblue class='clsTable' width='100%' Style=""table-layout:fixed;"">")
        'Else
        '    CommonFunctions.General.WriteHTML("<TABLE id='tbl_" + strProjectID + "' cellSpacing=1 cellPadding=1 border=0 bgColor=dodgerblue class='clsTable' width='100%' style=""table-layout:fixed;display:none"">")
        'End If


    End Sub

    Private Sub DrawTaskTotal_2(ByVal strProjectID As String, ByVal arrTaskTotal() As Double, ByVal dblActualTotal As Double, ByVal strProjectName As String)
        '=====================================================================
        ' Procedure Name        : DrawTaskTotal_2
        ' Purpose               : To draw Total project wise for each day
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim i As Integer = 0
        CommonFunctions.General.WriteHTML("<TR id=TRP_" + strProjectID + "  class='clsTROdd'>")
        CommonFunctions.General.WriteHTML("<TD colspan=3>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("CAP_PROJECT_TOTAL") & "-" & strProjectName & "</b>")
        CommonFunctions.General.WriteHTML("</TD>")
        For i = 0 To 6
            CommonFunctions.General.WriteHTML("<TD width=" & TD_WIDTH_2 & " align=right id=TDP3_" + strProjectID + " align=right>")
            CommonFunctions.General.WriteHTML(FormatNumber(arrTaskTotal(i), 2))
            CommonFunctions.General.WriteHTML("</TD>")
        Next
        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=right ></TD>")
        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=right ></TD>")
        CommonFunctions.General.WriteHTML("<TD  width='" + TD_WIDTH_2 + "' align=right >")
        CommonFunctions.General.WriteHTML(FormatNumber(dblActualTotal, 2))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
    End Sub

    Private Sub DrawTaskHeader_2(ByVal openSection As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawTaskHeader_2
        ' Purpose               : To draw Task Header
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strColumnValue As String
        Dim strWeekDay As String
        Dim strRowStyle As String

        If (openSection = True) Then
            strRowStyle = ""
        Else
            strRowStyle = "style='display:none'"
        End If

        ' CommonFunctions.General.WriteHTML("<Table id ='tblTaskHead' cellSpacing=1 cellPadding=1 class='clsTable' width='98%' Style=""table-layout:fixed;"">")
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' " & strRowStyle & ">")

        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_1 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_TASKNAME"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_ALLOCATED"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_ACTUAL"))
        CommonFunctions.General.WriteHTML("</TD>")

        'm_dtStartDateOfWeek
        'strColumnValue()

        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
        Dim DrHolidayLeave As IDataReader
        Dim IsHolidayOrLeave As Boolean
        Dim intWorkingDays As Integer
        'Commented and added by Yogesh J 02-Dec-2015
        ' DrHolidayLeave = CommonFunction.Data.GetDataReader("usp_sel_WeeklyView_HolidayORLeaveStatus " + m_strSessionUserID.ToString + ",'" + m_dtStartDateOfWeek.ToString + "'", True)
        DrHolidayLeave = CommonFunction.Data.GetDataReader("usp_sel_WeeklyView_HolidayORLeaveStatus " + m_strSessionUserID.ToString + ",'" + Format(CType(FormatDateTime(m_dtStartDateOfWeek.ToString, DateFormat.ShortDate), Date), "MM/dd/yyyy") + "'", True)
        'End of Comment by Yogesh J
        DrHolidayLeave.Read()
        intWorkingDays = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrHolidayLeave("WorkingDays"), "5"), "5")
        '--- End addition Purvaj

        Dim i As Integer
        For i = 0 To 6
            '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
            IsHolidayOrLeave = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(DrHolidayLeave("Day" + (i + 1).ToString), "0"), "0"))
            '--- End addition Purvaj

            strWeekDay = WeekdayName(i + 1, True, CType(m_intStartingDayOfWeek, Microsoft.VisualBasic.FirstDayOfWeek))
            strColumnValue = strWeekDay + "<br>[" + GetShortDate(DateAdd(DateInterval.Day, i, m_dtStartDateOfWeek)) + "]"
            CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
            '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
            If IsHolidayOrLeave = True Or (i + 1) > intWorkingDays Then
                CommonFunction.General.WriteHTML("<FONT color='red'>")
            End If
            '--- End addition Purvaj

            CommonFunctions.General.WriteHTML(strColumnValue)
            '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
            If IsHolidayOrLeave = True Or (i + 1) > intWorkingDays Then
                CommonFunction.General.WriteHTML("</FONT>")
            End If
            '--- End addition Purvaj
            CommonFunctions.General.WriteHTML("</TD>")
        Next

        '--- Added By PurvaJ on 30 Sept 2008 for Whiziblesem8.0 to show holiday or leave in red color
        CommonFunction.Data.DisposeDataReader(DrHolidayLeave)
        '--- End addition Purvaj

        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_ACTUAL_PERCENT"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_TASK_COMPLETE"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD  width='" + TD_WIDTH_2 + "' align=center height='" & TD_HEIGHT_1 & "'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("COL_ACTUAL_THISWEEK"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")

        'CommonFunctions.General.WriteHTML("</Table>")
    End Sub

    Protected Sub DrawAfterForm()
        '=====================================================================
        ' Procedure Name        : DrawAfterForm
        ' Purpose               : To draw controls after form tag
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        m_strHtmlAfterForm.Append("<div  id='com3_' style='visibility: hidden;position: absolute;top:-10000;left:-10000;width: 66%;background: infobackground;z-index: 100;'")
        m_strHtmlAfterForm.Append("onmouseover=""msoCommentPersist('com3_')"" onmouseout=""msoCommentReset('com3_')"" >")
        m_strHtmlAfterForm.Append("</div> " & vbCrLf)
        CommonFunctions.General.WriteHTML(m_strHtmlAfterForm.ToString)
        CommonFunctions.General.WriteHTML(" <script> " & m_strJavaScript & " </script> ")
        m_strHtmlAfterForm = Nothing
    End Sub

    Private Function getMaxEntry(ByVal strProjectID As String) As String
        '=====================================================================
        ' Function Name         : getMaxEntry()	
        ' Purpose               : returns maximum entry per day
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        'Dim drTotalHours As IDataReader
        'Dim dblTotalWorkHours As Double
        'drTotalHours = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Daily_WorkingHours_Office " & strProjectID & ", '" & m_strHoursValidation & "'", MyBase.UseSQL)
        'If drTotalHours.Read() Then
        '    dblTotalWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drTotalHours("WorkingHours"), "0"), Double)
        'End If
        'CommonFunction.Data.DisposeDataReader(drTotalHours)
        'Return dblTotalWorkHours.ToString
        Return "24"
    End Function
    Private Function isBackDate(ByVal strProjectID As String) As String
        '=====================================================================
        ' Function Name         : isBackDate()	
        ' Purpose               : returns check the flag IsBackDating and return true or false
        ' Returns               : None
        ' Author                : HarshK
        ' Revisions             :
        '=====================================================================
        Dim m_blnProjectBackdateEntry As Boolean
        If m_strBackdatingExpiry <> "" Then
            If strProjectID <> "" Then
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & strProjectID, MyBase.UseSQL)


                If drBackDatedConf.Read() Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsBackDating"), "0"), Boolean) = False Then
                        m_blnProjectBackdateEntry = False
                    Else
                        m_blnProjectBackdateEntry = True
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectBackdateEntry = False
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            End If
        Else
            m_blnProjectBackdateEntry = True
        End If

        If m_blnProjectBackdateEntry = True Then
            Return "true"
        Else
            Return "false"
        End If
    End Function

    Private Function isForwardDate(ByVal strProjectID As String) As String
        '=====================================================================
        ' Function Name         : isForwardDate()	
        ' Purpose               : returns check the flag IsForwardDating and return true or false
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim m_blnProjectFwddateEntry As Boolean
        If m_strFwddatingExpiry <> "" Then
            If strProjectID <> "" Then
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & strProjectID, MyBase.UseSQL)
                If drBackDatedConf.Read() Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(CommonFunction.Data.CheckIsDBNull(drBackDatedConf("IsForwardDating"), "0"), Boolean) = False Then
                        m_blnProjectFwddateEntry = False
                    Else
                        m_blnProjectFwddateEntry = True
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectFwddateEntry = False
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            End If
        Else
            m_blnProjectFwddateEntry = True
        End If

        If m_blnProjectFwddateEntry = True Then
            Return "true"
        Else
            Return "false"
        End If
    End Function

    Private Function GetShortDate(ByVal dTDate As Date) As String
        '=====================================================================
        ' Function Name         : GetShortDate()	
        ' Purpose               : returns Short date eg Wed [Nov 30]
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True)

        Return (strMonth + " " + CStr(intDate))
    End Function

    Private Sub ResetToZero(ByRef arr() As Double)
        '=====================================================================
        ' Procedure Name        : ResetToZero()	
        ' Purpose               : set all elements of array to zero
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        For i = 0 To arr.Length - 1
            arr(i) = 0
        Next
    End Sub
#End Region



#Region " Menu, Caption, Filters"
    'modified by VidyaJ - IssueID - 11763
    Private Sub DrawMenu(ByVal blnTop As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : To draw MENU
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML MyBase.GetResourceString("PAGE_TITLE")
        Dim strTID As String = ""
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'Dim strSQL2 As String = "SELECT TimesheetID,StatusCode FROM tbl_PM_ResourceTimesheet WHERE EmployeeID=" & m_strSessionUserID & " AND DATEDIFF(dd,FromDate,'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "') <= 0 AND DATEDIFF(dd,ToDate,'" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "') >= 0"
        Dim strSQL2 As String = "usp_sel_tbl_PM_ResourceTimesheet_StatusCodeN " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        Dim drTStatus As IDataReader
        Dim strTStatus As String = ""

        'Modified By MahendraV On 4:40 PM 7/24/2007 For WhizibleSEM 7.0
        ' To show 'Send For Approver' link for 'OnSite Resource TimeSheet'
        ' Start_MV_7/24/2007
        'Commented By VidyaJ - SP8 Performance
        'Removed RT part
        If Request.QueryString("Fromwhere") = "Proxy" Then


            drTStatus = CommonFunctions.Data.GetDataReader(strSQL2, MyBase.UseSQL)
            If drTStatus.Read Then
                strTStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drTStatus("StatusCode"), ""))
                strTID = CStr(CommonFunctions.Data.CheckIsDBNull(drTStatus("TimesheetID"), ""))
            End If
            CommonFunction.Data.DisposeDataReader(drTStatus)
            '-----------------------------------------------------------
            If m_strShowDetails <> "1" And strTID <> "" Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_HISTORY"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_HISTORY_TOOLTIP"))
                arrClientSideFunctionList.Add("ShowHistory_OnClick('" & strTID & "')")
            End If
            '--------------------
            If m_strShowDetails <> "1" Then
                Dim strSql As String = "usp_sel_tbl_PM_ResourceTimesheet_GetDetail " & m_strSessionUserID _
                            & ",'" & DateAdd(DateInterval.Day, -7, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy") & "'" _
                            & ",'" & DateAdd(DateInterval.Day, -7, m_dtEndDateOfWeek).ToString("dd-MMM-yyyy") & "'"
                Dim drPreTimeSheet As IDataReader
                Dim drTimeSheet As IDataReader
                Dim strStatusCode As String = ""
                Dim strTimeSheetID As String = ""
                'if previous timesheet is  generated then only show generate timesheet link
                If m_strTimesheetFrequency.ToUpper = "W" And (m_objAccessRights.Add) Then  'this link is only for weekly frequency
                    drPreTimeSheet = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                    If drPreTimeSheet.Read Then
                        If strTID <> "" Then
                            If strTStatus.ToUpper = "N" Then
                                arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_SEND_APPROVE"))
                                arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_SEND_APPROVE_TOOLTIP"))
                                arrClientSideFunctionList.Add("SendApproval_OnClick()")
                            ElseIf strTStatus.ToUpper <> "V" Then
                                arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_RESEND_APPROVE"))
                                arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_RESEND_APPROVE_TOOLTIP"))
                                arrClientSideFunctionList.Add("SendApproval_OnClick()")
                            End If
                        Else
                            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_SEND_APPROVE"))
                            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_SEND_APPROVE_TOOLTIP"))
                            arrClientSideFunctionList.Add("SendApproval_OnClick()")
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(drPreTimeSheet)
                End If

                '-----------------------------------------------------------
            End If
        End If
        '-----------------------------------------------------------
        ' End_MV_7/24/2007
        If m_strShowDetails <> "1" And m_objAccessRights.Add Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_SAVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_SAVE_TOOLTIP"))
            arrClientSideFunctionList.Add("Save_OnClick()")
        ElseIf m_strShowDetails = "1" And m_objAccessRights.Edit Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_SAVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_SAVE_TOOLTIP"))
            arrClientSideFunctionList.Add("Save2_OnClick()")
        End If
        '-----------------------------------------------------------
        If m_strShowDetails = "1" Then
            If m_objAccessRights.Delete Then
                arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_DELETE"))
                arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_DELETE_TOOLTIP"))
                arrClientSideFunctionList.Add("Delete_OnClick()")
            End If
            '----------------------------------
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_CLOSE_TOOLTIP"))
            arrClientSideFunctionList.Add("Close_OnClick()")
        Else
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_PREVIOUE_WEEK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_PREVIOUE_WEEK_TOOLTIP"))
            arrClientSideFunctionList.Add("PreviousWeek_OnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_NEXT_WEEK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_NEXT_WEEK_TOOLTIP"))
            arrClientSideFunctionList.Add("NextWeek_OnClick()")
        End If
        '-----------------------------------------------------------
        If m_strShowDetails <> "1" Then
            'If strTID <> "" And strTID <> "0" Then
            '    arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_HISTORY"))
            '    arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_HISTORY_TOOLTIP"))
            '    arrClientSideFunctionList.Add("ShowHistory_OnClick('" & strTID & "')")
            'End If

        End If

        'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
        'Check whether request came from Onsite Resource Timesheet
        If Request.QueryString("Fromwhere") = "Proxy" And Request.QueryString("Detail") = "" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_BACK_TOOLTIP"))
            arrClientSideFunctionList.Add("Back_OnClick()")
        End If
        'Addition End by SantoshK on 20th March 2006

        '-----------------------------------------------------------
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MNU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MNU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('DA_WEEKLY_VIEW_ALLPROJECT')")
        '-----------------------------------------------------------
        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'modified by VidyaJ - IssueID - 11763
        If (blnTop = True) Then
            strMenu = "<TABLE class=clsTable name=tblMenuTop id=tblMenuTop cellSpacing=0 cellPadding=0 width='99.9%'> <TR><td>" & strMenu & "</TD></TR></table>"
        Else
            strMenu = "<TABLE class=clsTable name=tblMenuBottom id=tblMenuBottom cellSpacing=0 cellPadding=0 width='99.9%'> <TR><TD>" & strMenu & "</TD></TR></table>"
        End If

        CommonFunctions.General.WriteHTML(strMenu)
        m_objMenu = Nothing
    End Sub

    Private Sub DrawPageCaption()
        '=====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Purpose               : To draw Page caption
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim dblTotal As Double
        Dim strSql As String

        'Modified By VidyaJ - SP8 Performance
        Dim drWeekTotal As IDataReader
        Dim intCounter As Integer
        strSql = "usp_sel_tbl_PM_DailyActivity_WeeklyTotal " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"

        ' dblTotal = CDbl(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), "0"))

        drWeekTotal = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)
        intCounter = 0
        Dim strDate As Date
        Dim strDateComp As Date

        While drWeekTotal.Read()

            strDate = DateAdd(DateInterval.Day, 0, CType(drWeekTotal("EntryDate"), DateTime))
            'strDateComp = m_dtStartDateOfWeek

            Dim intDayCount As Long
            intDayCount = DateDiff(DateInterval.Day, m_dtStartDateOfWeek.Date, strDate)

            'If strDate = strDateComp Then

            Select Case intDayCount
                Case 0
                    m_dblEntryDay1 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
                Case 1
                    m_dblEntryDay2 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 2
                    m_dblEntryDay3 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 3
                    m_dblEntryDay4 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 4
                    m_dblEntryDay5 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
                Case 5
                    m_dblEntryDay6 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 6
                    m_dblEntryDay7 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

            End Select
            ' End If

            intCounter = intCounter + 1

        End While
        CommonFunction.Data.DisposeDataReader(drWeekTotal)
        dblTotal = m_dblEntryDay1 + m_dblEntryDay2 + m_dblEntryDay3 + m_dblEntryDay4 + m_dblEntryDay5 + m_dblEntryDay6 + m_dblEntryDay7
        m_dblActualHrs = dblTotal

        CommonFunctions.General.WriteHTML("<Table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<Tr class='clsTRSectionHeader'>")

        CommonFunctions.General.WriteHTML("<Td align='left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))

        '' START : Modified By ParagD On 29-Aug-2006
        '' Purpose : The date format is not dsiplayed as per the format set at the 
        ''           "Company Information -> Date Format"

        '' CommonFunctions.General.WriteHTML(" (" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + " - " + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + ")")
        CommonFunctions.General.WriteHTML(" (" + CommonFunctions.Dates.CGetDate(Date.Parse(m_dtStartDateOfWeek.ToString)) + " - " + CommonFunctions.Dates.CGetDate(Date.Parse(m_dtEndDateOfWeek.ToString)) + ")")
        '' END : Modified By ParagD On 29-Aug-2006 

        CommonFunctions.General.WriteHTML("</Td>")

        '--- Added By purvaj on 6 Nov 2008 for WhizibleSEM 8.0
        '--- Total week hours will be calculated based on the resource OU working days and work hours
        m_TotalWeekHours = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_ExpectedWorkHours " + m_strSessionUserID.ToString + ",'" + CommonFunctions.Dates.GetDate(m_dtStartDateOfWeek).ToString + "','" + CommonFunctions.Dates.GetDate(m_dtEndDateOfWeek).ToString + "'", True), "0")
        m_dblExpectedHrs = m_TotalWeekHours
        '--- End addition purvaJ


        CommonFunctions.General.WriteHTML("<TD align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION_TOTAL"))
        CommonFunctions.General.WriteHTML(FormatNumber(dblTotal, 2))
        CommonFunctions.General.WriteHTML(" / " + FormatNumber(m_TotalWeekHours, 2) + " " + MyBase.GetResourceString("HRS"))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</Tr>")
        CommonFunctions.General.WriteHTML("</Table>")
    End Sub

    Private Sub DrawFilters()
        '=====================================================================
        ' Procedure Name        : DrawFilters
        ' Purpose               : To draw Filters
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strSql As String
        'TODO: Procedure for 'Select Hours' combo. hours must be in multiple of CommonFunction.Application.MinHoursForDAEntry

        strSql = "usp_sel_GetHoursForDA " & CStr(CommonFunction.Application.MinHoursForDAEntry)

        CommonFunctions.General.WriteHTML("<Table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")

        CommonFunctions.General.WriteHTML("<TD style='width:20%'>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , m_strTaskFilter = CStr(ALL_TASKS), CStr(ALL_TASKS), , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_ALL"))
        CommonFunctions.General.WriteHTML("</TD>")


        CommonFunctions.General.WriteHTML("<TD style='width:50%' >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , m_strTaskFilter = CStr(TASKS_FOR_THE_WEEK), CStr(TASKS_FOR_THE_WEEK), , " language=JavaScript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_SELECTED_WEEK"))
        CommonFunctions.General.WriteHTML("</TD><TD style='width:15%'></TD><TD style='width:15%'></TD>")
        '--------------------
        'Start_AJ_24Sep2006,Commenting Start
        '''CommonFunctions.General.WriteHTML("<TD style='width:30%' colspan=2 align=right title='" & MyBase.GetResourceString("CAP_SELECT_HOURS") & "'>")
        '''CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SELECT_HOURS"))
        '''If m_blnTimesheetEntryCombo = True Then
        '''    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("Cbohours", strSql))
        '''Else
        '''    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 45, , , "Right"))
        '''End If
        ''''CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=btnHours type=button value='" & MyBase.GetResourceString("CAP_POST_HOURS") & "' onclick=""PostHours_OnClick()"">")
        ''''CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=btnClr type=button value='" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_CLR_HOURS"), "Clear Hours") & "' onclick=""ClearHours_OnClick()"">")
        '''CommonFunctions.General.WriteHTML("</TD>")
        '''CommonFunctions.General.WriteHTML("<TD >")
        '''Dim arrMenuCap() As String = {MyBase.GetResourceString("CAP_POST_HOURS"), CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_CLR_HOURS"), "Clear Hours")}
        '''Dim arrMenuFun() As String = {"PostHours_OnClick()", "ClearHours_OnClick()"}
        '''Dim arrMenuToolTip() As String = {"Post Hours", "Clear Hours"}
        '''m_objMenu = New WebPages.Template.StaticMenu
        '''Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenuCap, arrMenuFun, arrMenuToolTip, True)
        '''CommonFunctions.General.WriteHTML(strMenu)
        ''''m_objMenu = Nothing
        '''CommonFunctions.General.WriteHTML("</TD>")
        'End_AJ_24Sep2006,Commenting End
        '--------------------Style=""table-layout:fixed;""
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")

        CommonFunctions.General.WriteHTML("<TD colspan=5>")
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optGeneralTasks", , m_strSelectedTaskType = GENERAL_TASKS, GENERAL_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_GENERAL"))

        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optMPPTasks", , m_strSelectedTaskType = PROJECT_SPECIFIC_TASKS, PROJECT_SPECIFIC_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_MPP"))

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optAssignedTasks", , m_strSelectedTaskType = ASSIGNED_TASKS, ASSIGNED_TASKS, , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_ASSIGNED"))

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , m_strSelectedTaskType = DEFECTS_ASSIGNED, DEFECTS_ASSIGNED, , " Language=javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_ISSUE"))

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optDefectTasks", , m_strSelectedTaskType = ALL_TASK_TYPES, CStr(ALL_TASK_TYPES), , " language=Javascript OnClick=optTasks_OnClick() ", True))
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SHOW_ALL_TYPES"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")
    End Sub

    Private Sub DrawControls()
        '=====================================================================
        ' Procedure Name        : DrawControls
        ' Purpose               : To draw controls
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strSql As String
        'TODO: Procedure for 'Select Hours' combo. hours must be in multiple of CommonFunction.Application.MinHoursForDAEntry
        ' Commented and Added By MahendraV On 2:12 PM 5/29/2007 for Company Information Optimization
        ' Start_MV_5/29/2007
        ' Dim blnTimesheetEntryCombo As Boolean = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select TimesheetEntryCombo from tbl_Pm_CompanyInformation", MyBase.UseSQL), "0"))
        Dim blnTimesheetEntryCombo As Boolean = CommonFunction.Application.TimesheetEntryCombo
        ' End_MV_5/29/2007

        strSql = "usp_sel_GetHoursForDA " & CStr(CommonFunction.Application.MinHoursForDAEntry)
        CommonFunctions.General.WriteHTML("<Table CellSpacing='0' width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")

        CommonFunctions.General.WriteHTML("<TD align=right width=120>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_SELECT_HOURS"))
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD aligh=left width=120>")
        If blnTimesheetEntryCombo = True Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("Cbohours", strSql))
        Else
            'Commented and added by Shamkant s for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 45, , , "Right", EnableHTMLEncode:=True))
            'ended by Shamkant s  for HTML encoding Date:07/10/15

        End If

        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD aligh=left>")
        CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=btnHours type=button value='" & MyBase.GetResourceString("CAP_POST_HOURS") & "' onclick=""PostHours_OnClick()"">")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD aligh=left>")
        CommonFunctions.General.WriteHTML("<input class=ButtonStyle id=btnClr type=button value='" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_CLR_HOURS"), "Clear Hours") & "' onclick=""ClearHours_OnClick()"">")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")
    End Sub

    Private Sub DrawPageLegend()
        '=====================================================================
        ' Procedure Name        : DrawPageLegend()	
        ' Purpose               : Plots the Page Legend.
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 
        ' Revisions             : WARNING_IMAGE
        '=====================================================================




        Dim arrLegend As New ArrayList
        Dim arrLegendImage As New ArrayList

        arrLegend.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MANDATORY"), "Mandatory"))
        arrLegendImage.Add("<img src='../../images/star.gif'>")

        'If m_strShowDetails <> "1" Then
        '    arrLegend.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("ERROR"), "Error"))
        '    arrLegendImage.Add("<img src='" & ERROR_IMAGE & "'>")

        '    arrLegend.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("WARNING"), "Warning"))
        '    arrLegendImage.Add("<img src='" & WARNING_IMAGE & "'>")
        'End If

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, GetArray(arrLegendImage), GetArray(arrLegend)) + vbCrLf)
    End Sub

    Private Sub DrawHiddens()
        '=====================================================================
        ' Procedure Name        : DrawHiddens
        ' Purpose               : To draw hidden controls
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        'Added by TruptiK 
        'Purpose:-To add validation for joining date of employee.
        Dim strquery As String
        Dim strJoiningdate As String
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strquery = "select joiningdate from tbl_pm_employee where employeeid=" + m_strSessionUserID.ToString
        strquery = "usp_sel_tbl_pm_employee_joiningdate " + m_strSessionUserID.ToString
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'End of addition by TrutpiK
        strJoiningdate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strquery, True), ""), String)
        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("hdnStartDate", "hdnStartDate", , , , m_dtStartDateOfWeek.ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnEndDate", "hdnEndDate", , , , m_dtEndDateOfWeek.ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnQueryString", "hdnQueryString", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnTP", "hdnTP", , , , , , , , , , True, EnableHTMLEncode:=True) 'for txtPercentComplete
        CommonFunctions.HTMLControls.DrawTextBox("hdnChk", "hdnChk", , , , , , , , , , True, EnableHTMLEncode:=True) 'for check box values
        CommonFunctions.HTMLControls.DrawTextBox("hdnDivHeight", "hdnDivHeight", , , , m_strDivHeight, , , , , , True, EnableHTMLEncode:=True)  'for check box values
        'Added by TruptiK 
        CommonFunctions.HTMLControls.DrawTextBox("hdnJoiningdate", "hdnJoiningdate", , , , CDate(strJoiningdate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        'End of addition by TrutpiK

    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub
    ''Added And Commented By Vidya J On 28 Jan 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowDetails_OnClick(TaskDAID_Details As String, Details As String, StartDate As String, Days As String) As String
        Try
            Dim m_PKToken_ShowDetails_Multiple As String
            m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskDAID_Details, String) + CType(Details, String) + CType(StartDate, String) + CType(Days, String) + "0" + "0")

            Return m_PKToken_ShowDetails_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowDetails_OnClick_ForDay(TaskDAID_Details As String, Details As String, StartDate As String) As String
        Try
            Dim m_PKToken_ShowDetails As String
            m_PKToken_ShowDetails = CommonFunctions.Security.Token.GetToken(CType(TaskDAID_Details, String) + CType(Details, String) + CType(StartDate, String) + "0" + "0")

            Return m_PKToken_ShowDetails
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_TaskLink_OnClick(ProjectID As String, TaskDAID As String) As String
        Dim m_PKToken_TaskLink_OnClick As String
        m_PKToken_TaskLink_OnClick = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(TaskDAID, String) + "0" + "0")

        Return m_PKToken_TaskLink_OnClick

    End Function
    ''End Of Added And Commented By Vidya J On 28 Jan 2016
    ''Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateStoryPoint(ByVal TaskID As String, ByVal StoryPoint As String)
        Try
            Dim strsql As String = ""
            Dim strResult As String = ""

            strsql = "EXEC usp_NG2_chk_ValidateStoryPoint " & TaskID & "," & StoryPoint

            strResult = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strsql, True), "")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Added By Aniruddh Gujar on 16-Apr-2018 Purpose::To enter the story points for scrum
#Region " Generic Functions "

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Function Name        : GetArray
        ' Purpose               : Return array
        ' Returns               : Array
        ' Created               : 11 nov 2005
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

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
        ' Author                : Purvaj
        ' Created               : 30 Sept 2008
        ' Revisions             :
        '=====================================================================

        Dim strHTML As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER
        objHeaderFooter.HeaderFooter = MyBase.GetResourceString("FOOTERNOTE").ToString
        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML(strHTML + "<BR>")
        End If

    End Sub

End Class