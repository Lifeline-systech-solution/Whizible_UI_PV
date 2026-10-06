Public Class PM_TaskTypeTimesheet
    Inherits WebPages.Template.WhizTemplate

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
    End Sub

#End Region

#Region " Protected Variable Declaration. "
    Protected m_strWindowTitle As String
    Protected m_blnActualWorkHrs As Boolean = CommonFunction.Application.TimesheetEntryCombo
    'This variable decide what to show on the form 
    'to fill the Actual Hours worked. i.e. ComboBox Or TextBox

    'Added on 26th May 2004
    Protected EXPIRY_OF_TASK As Integer
    Protected EXPIRY_OF_TASK_FORWARD As Integer
    'End addition
    Protected m_blnProjectBackdateEntry As Boolean
    Protected m_blnProjectFwddateEntry As Boolean

    Private Const INVALID_ENTRY As String = "-9999"
    ' Added By NitinVS on 20 Apr 2005 PBNITE SP3
    ' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also
    Protected m_HaveSubTaskTypes As Boolean
    'Added By Santosh Pawar on 21 Oct 2004 
    Protected m_blnResourceLevelTaskCompletion As Boolean
    'End of Addition 
    ' End Addition By NitinVS on 20 Apr 2005 PBNITE SP3
    'Added by PrashantD on 28 March 2007 for IssueID 11767
    Protected m_strProjectsOnHoldMsg As String
    Protected m_strProjectsOnHold As String
    Protected m_strFirstNotOnHoldProject As String
    Private m_strProjectFilters As String
    'End of addition by PrashantD on 28 March 2007
    '''<Summary>
    '' Added By: PrashantSJ
    '' date: 27th May 2008
    ''Purpose: DA blocked for particular project from project workflow.
    '''</Summary>

    Protected m_strProjectsDABlocked As String = ""
    Protected m_strProjectsDABlockedMsg As String = ""
    Protected arrTSBlockedProjects As String() = {"", ""}
    '''End of addition by PrashantSJ on 27th May 2008
#End Region

#Region " Private Variable Declaration. "

    Protected blnPersistValues As Boolean
    Protected dblEnteredHoursForTheDay As Double = 0
    Protected dblTotalHoursForTheDay As Double = 0
    Protected strMessage As String = ""

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private Const GENERAL_TASKS As String = "D"
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"

    Private m_blnTaskTypesApplicable As Boolean
    Protected blnIncludeCompletedTasks As Boolean
    Private strTaskTypeID As String
    'Private m_strTaskTypeName As String
    Private m_strTaskInfo As String = ""
    Private strTaskType As String
    'Private m_strProjectID As String = ""
    Private m_strTREven As String = "clsTREven"
    Private m_strSessionUserID As String        'For storing the User ID from Session
    Private m_strSessionPostID As String        'For storing the Post ID from Session
    Private m_strSessionClientDate As String    'For storing the Client Date from Session
    Private cObjSectionTitle As New WebPage.Templates.SectionTitle
    Private m_strFromWhere As String
    Protected m_strAction As String
    Protected dtmEntryDate As String
    Private intProjectID As String = ""
    Protected strWhichTask As String
    Private intTaskTypeID As String
    Private strTaskInfo As String
    Private strTempArray As String()
    Protected intTaskID As String
    'Private blnIncludeCompletedTasks As Boolean
    Protected blnRestrictDurationChange_MPPTasks As Boolean
    Protected blnRestrictDurationChange_AssignedTasks As Boolean
    Private blnUseClientDateForDA As Boolean
    Protected blnTaskTypeMandatoryInDA As Boolean
    Private intPrevProjectID As String
    Private strPrevWhichTask As String
    Private strLockAttributes As String = ""
    Protected m_dblWorkingHours As Double

    'Added By NitinVS on 22 Apr 2005 for whizibleSEM SP3 
    '##### Adding Variable For Resource Timesheet Flow
    'Added By AmitD on 28 JUL 2004
    Private m_blnTimesheetWorkFlow As Boolean
    Private m_blnAllowTaskProgress As Boolean
    'End Addition
    '##### End Addition
    'End Addition By NitinVS on 22 Apr 2005 for whizibleSEM SP3 

#End Region

#Region " Constructor and Page Initialization Part. "
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_TaskTypeTimesheet", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub

    Public Sub PageInit()
        Dim intTagID As Integer = 10
        Dim intHelpID As String = "TASK_TYPE_TIMESHEET"
        Dim strQSParameters As String = ""
        Dim drCompanyInformation As IDataReader
        Dim drTask As IDataReader
        Dim strSQLQuery As String
        Dim drDailyActivity As IDataReader
        Dim drTaskType As IDataReader
        Dim intCtr As Integer
        Dim intSubTaskTypeID As String
        Dim objDr As IDataReader

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strSessionPostID = CType(Session("intPostID"), String)
        m_strSessionClientDate = CType(Session("ClientDate"), String)
        strTaskInfo = ""

        ' INITIALIZATIONS.
        '-----------------				
        ' Get the FromWhere attribute (DeveloperDB/PMDashboard).
        If Trim(Request.QueryString("FromWhere")) <> "" Then
            m_strFromWhere = Trim(Request.QueryString("FromWhere"))
            strQSParameters = "&FromWhere=" + m_strFromWhere
        End If

        ' Added By NitinVS on 22 Apr 2005 for WhizibleSEM SP3

        '##### Added For Resource Timesheet Work Flow
        'Added By AmitD on 10 Aug 2004
        m_blnTimesheetWorkFlow = CommonFunction.Application.TimesheetWorkFlow
        m_blnAllowTaskProgress = CommonFunction.Application.AllowTaskProgress
        'End Addition

        '##### End Addition By NitinVS on 22 Apr 2005 for WhizibleSEM SP3

        ' End Addition  

        ' Get the action to be performed (VIEW/SAVE).
        If Trim(Request.QueryString("Action")) <> "" Then
            m_strAction = Trim(Request.QueryString("Action"))
        Else
            m_strAction = "View"
        End If

        'Get the corporate settings.
        drCompanyInformation = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_PM_CompanyInformation", MyBase.UseSQL)
        If drCompanyInformation.Read Then
            blnRestrictDurationChange_MPPTasks = CommonFunction.Application.RestrictDurationChange_M
            blnRestrictDurationChange_AssignedTasks = CommonFunction.Application.RestrictDurationChange_O
            blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA
            blnTaskTypeMandatoryInDA = True
        End If
        CommonFunctions.Data.DisposeDataReader(drCompanyInformation)

        'Added By PrasannaP on 15th May 2004
        'drCompanyInformation = CommonFunction.Data.GetDataReader("SELECT AcceptETC , BackdatingNoDays, ForwardDatingNoDays FROM tbl_PM_CompanyInformation", MyBase.UseSQL)
        drCompanyInformation = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation_AcceptETC_BackdatingNoDays_ForwardDatingNoDays ", MyBase.UseSQL)

        If drCompanyInformation.Read() Then
            EXPIRY_OF_TASK = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("BackdatingNoDays"), INVALID_ENTRY), Integer)
            EXPIRY_OF_TASK_FORWARD = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ForwardDatingNoDays"), INVALID_ENTRY), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drCompanyInformation)
        'End Addition

        'Added by PrasannaP on 26th May 2004
        If Trim(MyBase.GetFormValue("cboProject")) <> "" Then
            Dim strProjectIDForBackDating As String
            strProjectIDForBackDating = Trim(MyBase.GetFormValue("cboProject"))
            Trim(MyBase.GetFormValue("cboProject"))
            If CStr(EXPIRY_OF_TASK) <> INVALID_ENTRY Then
                '*****code to put project backdate entry
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," + strProjectIDForBackDating, MyBase.UseSQL)

                If drBackDatedConf.Read Then
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
            Else
                m_blnProjectBackdateEntry = True
            End If


            If CStr(EXPIRY_OF_TASK_FORWARD) <> INVALID_ENTRY Then
                '*****code to put project backdate entry
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," + strProjectIDForBackDating, MyBase.UseSQL)

                If drBackDatedConf.Read Then
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
            Else
                m_blnProjectFwddateEntry = True
            End If
        End If
        'Addition Ends

        ' If the FORM contents have to be used, then...
        If MyBase.GetFormValue("txtUseFormValues") <> "" Then

            ' Get the Entry Date.
            dtmEntryDate = Trim(MyBase.GetFormValue("txtEntryDate"))

            ' Get the ProjectID.
            intProjectID = Trim(MyBase.GetFormValue("cboProject"))
            If intProjectID = "" Then intProjectID = "0"

            ' Get the Task Category to be selected.	
            strWhichTask = Trim(MyBase.GetFormValue("optWhichTask"))

            ' Get the TaskTypeID.
            intTaskTypeID = Trim(MyBase.GetFormValue("cboTaskTypeID"))
            If intTaskTypeID = "" Then intTaskTypeID = "0"

            ' Get the TaskID.
            strTaskInfo = Trim(MyBase.GetFormValue("cboTaskID"))
            If strTaskInfo <> "" Then
                'Modified By VidyaJ on 31st May 2005 - For IssueID - 18707
                If MyBase.GetFormValue("txtChangeElement") = "optProjectTasks" Or MyBase.GetFormValue("txtChangeElement") = "optDefectTasks" Or MyBase.GetFormValue("txtChangeElement") = "optGeneralTasks" Or MyBase.GetFormValue("txtChangeElement") = "optAssignedTasks" Then
                    intTaskID = "0"
                Else
                    strTempArray = Split(strTaskInfo, "|")
                    intTaskID = strTempArray(1)
                End If
                'End Of Modifications
            Else
                intTaskID = "0"
            End If

            ' Get the flag indicating whether the Tasks that are marked as complete should be included in the Task list.

            blnIncludeCompletedTasks = CBool((MyBase.GetFormValue("txtIncludeCompletedTasks") = "1"))

            Select Case MyBase.GetFormValue("txtChangeElement")
                Case "cboTaskID"
                    ' If the Task has been changed, then get the new Task details.	
                    Call GetTaskDetails(intTaskID, strTaskInfo, intProjectID, strWhichTask, intTaskTypeID)
                    'Added by MrugajaB on 3rd June 2005
                    'Purpose:When task does not have a task type, message will be displayed before all felds clear out
                    If intTaskTypeID = "0" Then
                        'Commented and Added by Chakshuta H on 8th-Aug-2016 
                        'strSQLQuery = "SELECT TaskName FROM tbl_PM_ProjectTasks Where TaskID = " & intTaskID
                        strSQLQuery = "usp_sel_tbl_PM_ProjectTasks_TaskID " & intTaskID
                        'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
                        drTask = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                        If (drTask.Read) Then
                            CommonFunction.General.WriteHTML("<Script 'language=javascript'> ")
                            CommonFunction.General.WriteHTML("alert('Task " & """" & CType(drTask("TaskName"), String) & """" & " is not mapped to any tasktype')")
                            CommonFunction.General.WriteHTML("</Script> ")
                        End If
                        CommonFunctions.Data.DisposeDataReader(drTask)
                    End If
                    'Added By VidyaJ for IssueID - 346
                    'Disable project and task combo for DeveloperDB/PMDashboar task
                    If m_strFromWhere = "PMDashboard" Or m_strFromWhere = "DeveloperDB" Then
                        strLockAttributes = " disabled "
                    End If
                    'End Addition
                Case "cboTaskTypeID"
                    ' If the Task Type has been changed, then reset the Task details [but if no Task Type is selected currently, then do not reset the task details].		
                    If intTaskTypeID <> "0" Then
                        intTaskID = "0"
                        strTaskInfo = ""
                    End If
                Case "cboProject"
                    ' If the Project has been changed, then reset the Task Type, and the Task details.		
                    intTaskTypeID = "0"
                    intTaskID = "0"
                    strTaskInfo = ""
                Case "txtIncludeCompletedTasks"
                    ' If the Project has been changed, then reset the Task Type, and the Task details.		
                    If intTaskID <> "0" Then
                        If blnIncludeCompletedTasks = False Then
                            drTask = CommonFunction.Data.GetDataReader("Exec usp_Sel_GetTaskDetails " & intTaskID, MyBase.UseSQL)
                            If drTask.Read Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(drTask("IsTaskComplete"), "0"), Boolean) = True Then
                                    intTaskID = "0"
                                    strTaskInfo = ""
                                End If
                            End If
                            CommonFunctions.Data.DisposeDataReader(drTask)
                        End If
                    End If
                Case Else
                    ' do nothing.
            End Select

            ' If the initial parameters have to be retrieved from the QUERYSTRING collection, then...
            ' NOTE: This case will arise only when the page is accessed the first time.	
        Else

            ' Get the Entry Date.
            If Trim(Request.QueryString("EntryDate")) <> "" Then
                dtmEntryDate = Trim(Request.QueryString("EntryDate"))
            Else

                If blnUseClientDateForDA = True Then
                    'Added by PrashantD on 28 March 2007 for IssueID 12053
                    'dtmEntryDate = CommonFunction.Dates.CGetDate(Date.Parse(m_strSessionClientDate))
                    dtmEntryDate = Date.Parse(m_strSessionClientDate).ToString("dd-MMM-yyyy")
                    'End of addition by PrashantD on 28 March 2007
                Else
                    'Added by PrashantD on 28 March 2007 for IssueID 12053
                    'dtmEntryDate = CommonFunction.Dates.CGetDate(Now())
                    dtmEntryDate = Now().ToString("dd-MMM-yyyy")
                    'End of addition by PrashantD on 28 March 2007
                End If

            End If



            ' Get the project and task category for which an activity was filled last. 
            'Modified by SiddharthS on 23 Feb 2005 .
            'Purpose : To fix the problem of page crash on clicking task type timesheet link.
            strSQLQuery = "EXEC usp_Sel_GetDailyActivityParameters_TaskTypeTimesheet 1," & m_strSessionUserID & ",'" & dtmEntryDate & "'" '& CommonFunction.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "'"
            'End Modification.
            drDailyActivity = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            ' If Entry found, then select that particular Project, and that particular Task Type.
            If drDailyActivity.Read Then
                intPrevProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("ProjectID"), "0"), String)
                strPrevWhichTask = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("WhichTask"), "0"), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            ' Get the ProjectID.
            If Trim(Request.QueryString("ProjectID")) <> "" Then
                intProjectID = Trim(Request.QueryString("ProjectID"))
            ElseIf intPrevProjectID <> "" Then
                intProjectID = intPrevProjectID
            Else
                intProjectID = "0"
            End If

            ' If the task category was not specified...
            If strPrevWhichTask <> "" Then
                strWhichTask = strPrevWhichTask
            Else
                strWhichTask = PROJECT_SPECIFIC_TASKS
            End If

            ' Get the TaskTypeID.
            If Trim(Request.QueryString("TaskTypeID")) <> "" Then
                intTaskTypeID = Trim(Request.QueryString("TaskTypeID"))
            Else

                ' Get the default task type for the project.
                drTaskType = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Project_TaskTypes " & intProjectID & ", 1", MyBase.UseSQL)
                If drTaskType.Read Then
                    intTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskTypeID"), "0"), String)
                    If intTaskTypeID = "" Then intTaskTypeID = "0"
                Else
                    intTaskTypeID = "0"
                End If
                CommonFunctions.Data.DisposeDataReader(drTaskType)

            End If

            ' Get the TaskID.
            If Trim(Request.QueryString("TaskID")) <> "" Then
                intTaskID = Trim(Request.QueryString("TaskID"))
                Call GetTaskDetails(intTaskID, strTaskInfo, intProjectID, strWhichTask, intTaskTypeID)
                strLockAttributes = " disabled "
            Else
                intTaskID = "0"
            End If

            ' Set the flag indicating that the Tasks that are marked as complete should NOT be included in the Task list.
            blnIncludeCompletedTasks = False

        End If

        ' If the Project is not selected, then Task Type ID is invalid.
        If intProjectID = "0" Then
            intTaskTypeID = "0"
        End If

        ' If the Task Type is not selected, then Task ID is invalid.
        If intTaskTypeID = "0" Then
            intTaskID = "0"
            strTaskInfo = ""
        End If

        blnPersistValues = False
        'Code Added By VidyaJ on 20th April 2004
        'User can enter max DA for 24 hours
        m_dblWorkingHours = 24 'CommonFunction.General.GetWorkingHoursPerDay(intProjectID)

        ' Added by NitinVS on 25 Apr 2005 for WhizibleSEM SP3 
        ' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also
        If intProjectID <> "" Then
            'strSQLQuery = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID = " + intProjectID
            strSQLQuery = "usp_sel_tbl_PM_Project_HaveSubTaskTypes " + intProjectID
            m_HaveSubTaskTypes = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), Boolean)
        End If


        If intProjectID <> "" Then
            strSQLQuery = "usp_Get_ProjectFlag_ResourceLevelTaskCompletion " & intProjectID
            objDr = CommonFunction.Data.GetDataReader(strSQLQuery, True)
            strSQLQuery = ""
            If objDr.Read Then
                m_blnResourceLevelTaskCompletion = CType(IIf(IsDBNull(objDr("ResourceLevelTaskCompletion")), False, objDr("ResourceLevelTaskCompletion")), Boolean)
            Else
                m_blnResourceLevelTaskCompletion = True
            End If
            CommonFunctions.Data.DisposeDataReader(objDr)
        End If
        ' End Addition by NitinVS on 25 Apr 2005 for WhizibleSEM SP3 


        '=====================================================================
        '	INSERT RECORD(S) OF THE TIMESHEET ENTRY.
        '=====================================================================
        If m_strAction = "Save" Then

            strSQLQuery = ""
            dblEnteredHoursForTheDay = 0
            dblTotalHoursForTheDay = 0

            ' Get the total hour of Timesheet entry that was already made on the selected date.
            'Commented & Modified By AMitJ For Yash 'issueid = 5730 =>Error while updating timesheet using " Task Type Timesheet "
            'drDailyActivity = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & CommonFunctions.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "','" & CommonFunctions.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "',NULL, 1, 1", MyBase.UseSQL)
            drDailyActivity = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_DailyActivity_ForSimpleDA " & m_strSessionUserID & ",NULL,NULL,NULL,'" & CommonFunctions.Dates.GetDate(Date.Parse(dtmEntryDate)) & "','" & CommonFunctions.Dates.GetDate(Date.Parse(dtmEntryDate)) & "',NULL, 1, 1", MyBase.UseSQL)
            'End of Modifications by AmitJ
            'drDailyActivity = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ProjectTasks_ForTaskTypeTimesheet " & m_strSessionUserID & ",NULL,NULL,NULL,'" & CommonFunctions.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "','" & CommonFunctions.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "',NULL, 1, 1", MyBase.UseSQL)

            If drDailyActivity.Read Then
                dblEnteredHoursForTheDay = CType(CommonFunctions.Data.CheckIsDBNull(drDailyActivity("TotalHours"), "0"), Double)
                dblTotalHoursForTheDay = dblTotalHoursForTheDay + dblEnteredHoursForTheDay
                'TODO: Convert to MyBase
                strMessage = Replace(Replace(MyBase.GetResourceString("MAX_BOOKING1"), "<&>", CStr(m_dblWorkingHours)), "<=>", CStr(dblEnteredHoursForTheDay))

            End If
            CommonFunctions.Data.DisposeDataReader(drDailyActivity)

            'Added by MrugajaB on 3rd June 2005 for WhizibleSEM SP3 issue ID.18709
            'Purpose : This condition is shifted to line No. where actal DA is inserted in table
            For intCtr = 1 To Split(FixString(MyBase.GetFormValue("txtSubTaskTypeID"), 0, False, False), ",").Length
                If FixString(Split(MyBase.GetFormValue("txtHours"), ",")(intCtr - 1), 0, False, False) <> "" Then
                    dblTotalHoursForTheDay = dblTotalHoursForTheDay + CType(FormatNumber(FixString(Split(MyBase.GetFormValue("txtHours"), ",")(intCtr - 1), 0, True, True) + "", , , , TriState.False), Double)
                End If
            Next

            'Commented by MrugajaB on 8th June 2005
            'If dblTotalHoursForTheDay >= m_dblWorkingHours Then
            'Removed '=' check so that exact 24 hrs can also be entered
            If dblTotalHoursForTheDay > m_dblWorkingHours Then
                'End Modification
                blnPersistValues = True
                strMessage = strMessage & MyBase.GetResourceString("MAX_BOOKING2") & (dblTotalHoursForTheDay - dblEnteredHoursForTheDay) & Replace(MyBase.GetResourceString("MAX_BOOKING3"), "<=>", CStr(m_dblWorkingHours))

            Else
                'End Addition

                ' Build the query to insert the Timesheet entries.
                For intCtr = 1 To Split(FixString(MyBase.GetFormValue("txtSubTaskTypeID"), 0, False, False), ",").Length

                    ' Get the Sub Task Type ID.
                    intSubTaskTypeID = Split(FixString(MyBase.GetFormValue("txtSubTaskTypeID"), 0, False, False), ",")(intCtr - 1)

                    ' If the hours column has been filled, then make the Timesheet Entry.
                    If FixString(Split(MyBase.GetFormValue("txtHours"), ",")(intCtr - 1), 0, False, False) <> "" Then

                        ' Build the Query to make the Timesheet entry.
                        'Commented & Modified By AMitJ For Yash 'issueid = 5730 =>Error while updating timesheet using " Task Type Timesheet "
                        'strSQLQuery = strSQLQuery & "Exec usp_Ins_tbl_PM_DailyActivity NULL, " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1) & ", " & intProjectID & ", " & m_strSessionUserID & ", " & m_strSessionPostID & ", '" & CommonFunctions.Dates.CGetDate(Date.Parse(dtmEntryDate)) & "' "
                        strSQLQuery = strSQLQuery & "Exec usp_Ins_tbl_PM_DailyActivity NULL, " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1) & ", " & intProjectID & ", " & m_strSessionUserID & ", " & m_strSessionPostID & ", '" & CommonFunctions.Dates.GetDate(Date.Parse(dtmEntryDate)) & "' "
                        'End of Modfifications By AmitJ
                        ' Get the Work (hrs).
                        strSQLQuery = strSQLQuery & "," & FormatNumber(FixString(Split(MyBase.GetFormValue("txtHours"), ",")(intCtr - 1), 0, True, True), , , , TriState.False)
                        ' Add to the total hours for the selected day.

                        'Commented By MrugajaB 
                        'dblTotalHoursForTheDay = dblTotalHoursForTheDay + CType(FormatNumber(FixString(Split(MyBase.GetFormValue("txtHours"), ",")(intCtr - 1), 0, True, True) + "", , , , TriState.False), Double)

                        ' The Description of the Task.
                        If Trim(Split(MyBase.GetFormValue("txtDescription"), ",")(intCtr - 1)) <> "" Then
                            strSQLQuery = strSQLQuery & ",'" & FixString(Split(MyBase.GetFormValue("txtDescription"), ",")(intCtr - 1), 2000, False, True) & "'"
                        Else
                            strSQLQuery = strSQLQuery & ", NULL"
                        End If

                        ' The Task Type of the Task.
                        If Trim(MyBase.GetFormValue("cboTaskTypeID")) <> "" Then
                            strSQLQuery = strSQLQuery & ", " & MyBase.GetFormValue("cboTaskTypeID")
                        Else
                            strSQLQuery = strSQLQuery & ", NULL"
                        End If

                        ' The Sub Task Type of the Task.			
                        strSQLQuery = strSQLQuery & ", " & intSubTaskTypeID

                        ' The Flag indicating that the Duration has changed.
                        If MyBase.GetFormValue("txtIsDurationChange") <> "1" Then
                            strSQLQuery = strSQLQuery & ", NULL"
                        Else
                            strSQLQuery = strSQLQuery & ", 1"
                        End If

                        ' Modified by NitinVS on 25 Apr 2005 

                        ' Added by RajaniR on Tuesday, November 26, 2002 11:11.
                        'If MyBase.GetFormValue("chkIsTaskComplete") <> "" Then

                        If MyBase.GetFormValue("chkIsTaskComplete" & intSubTaskTypeID) <> "" Then
                            Dim strsql As String
                            strSQLQuery = strSQLQuery & ", 1"
                            '' If the task is marked as completed, then update the task status in the database.
                            'strsql = "Exec usp_Upd_ProjectTaskComplete " + Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1) + " ,1 "
                            'CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)
                            'Added by PrashantD on 26 March 2007 for IssueID 11794
                        ElseIf Request.Form("hidIsChkIsTaskCompletePlotted" + intSubTaskTypeID) = "1" Then
                            If CType(Request.Form("txtActualPercentComplete" + intSubTaskTypeID), Double) >= 100 Then
                                strSQLQuery = strSQLQuery & ", 1"
                            Else
                                strSQLQuery = strSQLQuery & ", 0"
                            End If
                            'End of addition by PrashantD on 26 March 2007
                        Else
                            'Added by PrashantD on 26 March 2007 for IssueID 11794
                            'Purpose: For Case 1 And 2 projects, checkbox "IsTaskComplete" id  does not have subtasktypeid.
                            If MyBase.GetFormValue("chkIsTaskComplete") <> "" Then
                                strSQLQuery = strSQLQuery & ", 1"
                            Else
                                If Request.Form("hidIsChkIsTaskCompletePlotted") = "1" And CType(Request.Form("txtActualPercentComplete"), Double) >= 100 Then
                                    strSQLQuery = strSQLQuery & ", 1"
                                Else
                                    strSQLQuery = strSQLQuery & ", 0"
                                End If
                            End If
                            'strSQLQuery = strSQLQuery & ", 0"
                            'End of addition by PrashantD on 26 March 2007

                        End If
                        ' End Addition.


                        strSQLQuery = strSQLQuery & vbCrLf

                        Call CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                    End If



                    strSQLQuery = ""

                    If MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) <> "" Then
                        'Added By AmitD - For Corporate level TimesheetWorkFlow and TaskProgress settings
                        If m_blnTimesheetWorkFlow = False And m_blnAllowTaskProgress = False Then

                            'Added By Santosh Pawar on 21 Oct 2004
                            'Purpose : New Flag introduced at project Level which will allow or diallow 
                            '			task completion by resource
                            If m_blnResourceLevelTaskCompletion = True Then
                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + ", ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)
                            Else

                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)

                            End If
                            'Addition Complete
                        ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = False Then

                            If m_blnResourceLevelTaskCompletion = True Then
                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + ", ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)
                            Else
                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)
                                ' strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID, 0, False, False), , , , TriState.False) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)

                            End If

                            'strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                        ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = True Then

                            If m_blnResourceLevelTaskCompletion = True Then

                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + ", ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)

                            Else

                                strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + MyBase.GetFormValue("txtActualPercentComplete" & intSubTaskTypeID) + " WHERE TaskID = " & Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1)

                            End If


                        End If

                        'strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                        'End Addition
                        '##### Commented By AmitD on 10 Aug 2004 For handling conditions of Resource Timesheet Flow
                        'strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                        '##### End Comment
                        'DEADLOCK ISSUE - VidyaJ

                        'Code Added By VidyaJ for IssueID - 16218
                        If Split(MyBase.GetFormValue("txtTaskID"), ",")(intCtr - 1) = "" Then
                            strSQLQuery = strSQLQuery & intTaskID
                        End If
                        'End Of Addition

                        Call CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                        strSQLQuery = ""


                    End If
                Next

                ' If the total hours for the day is less than or equal to 24 hours, then proceeed with the entries.


                If dblTotalHoursForTheDay <= m_dblWorkingHours Then
                    Dim drDummy As IDataReader

                    ' INSERT THE TIMESHEET ENTRIES.
                    '==============================								
                    If strSQLQuery <> "" Then

                        drDummy = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                        CommonFunction.Data.DisposeDataReader(drDummy)
                    End If

                    ' INSERT THE ETC INTO THE ETC TABLE.
                    '===================================
                    If Trim(MyBase.GetFormValue("txtETC")) <> "" Then

                        drDummy = CommonFunctions.Data.GetDataReader("EXEC usp_Ins_tbl_PM_ProjectTaskETC " & intProjectID & "," & m_strSessionUserID & "," & intTaskID & "," & FormatNumber(Trim(MyBase.GetFormValue("txtETC")), , , , TriState.False) & ",'" & strWhichTask & "'", MyBase.UseSQL)
                        CommonFunction.Data.DisposeDataReader(drDummy)
                    End If

                    ' MARK THE TASK AS "COMPLETE" IF REQUIRED.
                    '=========================================
                    If Trim(MyBase.GetFormValue("chkIsTaskComplete")) <> "" Then
                        'Commented by PrasannP on 24 May 2004
                        'drDummy = CommonFunctions.Data.GetDataReader("EXEC usp_Upd_ProjectTaskComplete " & intTaskID & ",1", MyBase.UseSQL)
                        'CommonFunction.Data.DisposeDataReader(drDummy)
                    End If

                    ' UPDATE THE VALUE OF 'ACTUAL % COMPLETE'.
                    '=========================================

                    ' Added By NitinVS on 20 APr 2005 for WhizibleSEM SP3 

                    If m_HaveSubTaskTypes = False Then

                        If Trim(MyBase.GetFormValue("txtActualPercentComplete")) <> "" Then

                            'Added By AmitD - For Corporate level TimesheetWorkFlow and TaskProgress settings
                            If m_blnTimesheetWorkFlow = False And m_blnAllowTaskProgress = False Then
                                'Added By Santosh Pawar on 21 Oct 2004
                                'Purpose : New Flag introduced at project Level which will allow or diallow 
                                '			task completion by resource
                                If m_blnResourceLevelTaskCompletion = True Then
                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                                Else

                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID

                                End If
                                'Addition Complete
                            ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = False Then

                                If m_blnResourceLevelTaskCompletion = True Then
                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                                Else

                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID

                                End If

                                'strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                            ElseIf m_blnTimesheetWorkFlow = True And m_blnAllowTaskProgress = True Then

                                If m_blnResourceLevelTaskCompletion = True Then

                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + ", ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                                Else

                                    strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID

                                End If

                                'strSQLQuery = "UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & intTaskID
                            End If


                            'End Addition
                            '##### Commented By AmitD on 10 Aug 2004 For handling conditions of Resource Timesheet Flow
                            'strSQL = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " + FormatNumber(FixString(MyBase.GetFormValue("txtActualPercentComplete"), 0, False, True), , , , TriState.False) + " WHERE TaskID = " & m_strParamTaskID
                            '##### End Comment
                            'DEADLOCK ISSUE - VidyaJ
                            Call CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)



                        End If

                    End If

                    'End Addition By NitinVS on 20 APr 2005 for WhizibleSEM SP3 

                    ' If the page has been called from the dasbboards, then 
                    ' Set the active list to "To do list" or "Issues" depending on from where it has been called.

                    If m_strFromWhere = "DeveloperDB" Or m_strFromWhere = "PMDashboard" Then
                        If MyBase.GetFormValue("optTasks") = PROJECT_SPECIFIC_TASKS Or MyBase.GetFormValue("optTasks") = ASSIGNED_TASKS Then
                            Session("DB_ListNumber") = 1
                        ElseIf MyBase.GetFormValue("optTasks") = DEFECTS_ASSIGNED Then
                            Session("DB_ListNumber") = 2
                        End If
                    End If

                    ' Refresh the parent page, and close the current window if required.
                    CommonFunctions.General.WriteHTML("<script LANGUAGE='javascript'>")
                    CommonFunctions.General.WriteHTML("var strParentPage;")
                    CommonFunctions.General.WriteHTML("try")
                    CommonFunctions.General.WriteHTML("{	")
                    CommonFunctions.General.WriteHTML("strParentPage = new String();")
                    CommonFunctions.General.WriteHTML("strParentPage = opener.location.href;")
                    CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the DailyActivity.asp, then refresh the calling page and close the current window.")
                    CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('PM_DAILYACTIVITY.ASPX') != -1)")
                    CommonFunctions.General.WriteHTML("{")
                    CommonFunctions.General.WriteHTML("opener.location.href = '../PM/PM_DailyActivity.aspx?Mode=List&txtDate=" + dtmEntryDate + "';")
                    CommonFunctions.General.WriteHTML("//window.close();")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the DailyactivityMatrix.asp, then refresh the calling page and close the current window.")
                    CommonFunctions.General.WriteHTML("else if (strParentPage.toUpperCase().indexOf('PM_DAILYACTIVITYMATRIX.ASPX') != -1)")
                    CommonFunctions.General.WriteHTML("{")
                    CommonFunctions.General.WriteHTML("window.opener.DA.action = opener.location.href;")
                    CommonFunctions.General.WriteHTML("window.opener.DA.submit();")
                    CommonFunctions.General.WriteHTML("window.close();")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the PMDashboard.asp, then refresh the calling page and close the current window.")
                    CommonFunctions.General.WriteHTML("else if (strParentPage.toUpperCase().indexOf('PMDASHBOARD.ASPX') != -1)")
                    CommonFunctions.General.WriteHTML("{")
                    CommonFunctions.General.WriteHTML("opener.location.href = '../DB/PMDashboard.aspx';")
                    CommonFunctions.General.WriteHTML("window.close();")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the DeveloperDB.asp, then refresh the calling page and close the current window.")
                    CommonFunctions.General.WriteHTML("else if (strParentPage.toUpperCase().indexOf('DEVELOPERDB.ASPX') != -1)")
                    CommonFunctions.General.WriteHTML("{")
                    CommonFunctions.General.WriteHTML("opener.location.href = '../DB/DeveloperDB.aspx';")
                    CommonFunctions.General.WriteHTML("window.close();")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("catch(e)")
                    CommonFunctions.General.WriteHTML("{")
                    CommonFunctions.General.WriteHTML("// This condition will come if the parentpage has been closed, of changed.")
                    CommonFunctions.General.WriteHTML("window.close();")
                    CommonFunctions.General.WriteHTML("}")
                    CommonFunctions.General.WriteHTML("</script>")

                    'Code Added By VidyaJ on 20th April 2005
                    ' If the Task has been changed, then get the new Task details.	
                    Call GetTaskDetails(intTaskID, strTaskInfo, intProjectID, strWhichTask, intTaskTypeID)

                    'Commented by MrugajaB
                    'Else
                    '   blnPersistValues = True
                    '  strMessage = strMessage & MyBase.GetResourceString("MAX_BOOKING2") & (dblTotalHoursForTheDay - dblEnteredHoursForTheDay) & Replace(MyBase.GetResourceString("MAX_BOOKING3"), "<=>", CStr(m_dblWorkingHours))

                End If
                'MrugajaB
            End If

        End If
        DrawPage()


        'Added by PrashantD on 28 March 2007 for IssueID 11767
        'Purpose: Select onhold project List in to one protected variable which is used in aspx
        Dim drProjectsOnHold As IDataReader
        If m_strSessionUserID <> "0" Then
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
        strSQLQuery = "EXEC usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,'" & dtmEntryDate & "'" & ",'" & m_strProjectFilters & "'"
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
        'End of addition by PrashantD on 28 March 2007
    End Sub

#End Region

#Region " Page Plotting. "

    Private Sub DrawPage()
        DrawMenu()
        DrawPageLegend()
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:100%'>")
        Response.Write("<input type=hidden name=txtUseFormValues id=txtUseFormValues value='1'>")
        Response.Write("<input type=hidden name=txtChangeElement id=txtChangeElement value=''>")
        Response.Write("<input type=hidden name=txtIncludeCompletedTasks id=txtIncludeCompletedTasks value='")
        If blnIncludeCompletedTasks = False Then Response.Write("-1") Else Response.Write("1")
        Response.Write("'>")
        PlotSections()
        PlotGrid()
        CommonFunctions.General.WriteHTML("</DIV><br>")
        DrawMenu()
    End Sub

    Private Sub DrawPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub
#End Region

#Region " Menu Plotting. "
    Private Sub DrawMenu()
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
        ' Created               : March 8, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu


        '-------------------------------------------------------------
        'This block prints the Menus on the TTTemplate page.
        '-------------------------------------------------------------
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrClientSideFunctionList.Add("Save_OnClick()")

        If blnIncludeCompletedTasks = False Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_ALL_TASKS"))
            arrClientSideFunctionList.Add("IncludeCompletedTasks()")
        Else
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASKS"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOW_INCOMPLETE_TASKS"))
            arrClientSideFunctionList.Add("IncludeInCompletedTasks()")
        End If

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('TASK_TYPE_TIMESHEET')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        '-------------------------------------------------------------

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
#End Region

#Region " Generic Functions. "
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
#End Region

#Region " Details plotting. "
    Public Sub PlotSections()
        Dim strSQL As String = ""
        Dim strHTML As String = ""      'This is used to store the HTML contents.
        Dim drTaskType As IDataReader

        strHTML = ""
        If Request.QueryString("EntryDate") <> "" Then
            strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtEntryDate", "txtEntryDate", , , Request.QueryString("EntryDate"), , "TTTimesheet", , , , , True, , True)
        Else
            If MyBase.GetFormValue("txtEntryDate") <> "" Then
                strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtEntryDate", "txtEntryDate", , , MyBase.GetFormValue("txtEntryDate"), , "TTTimesheet", , , , , True, , True)
            Else
                strHTML = strHTML + CommonFunction.HTMLControls.DrawDateControl("txtEntryDate", "txtEntryDate", , , Date.Now().ToString("dd-MMM-yyyy"), , "TTTimesheet", , , , , True, , True)
            End If
        End If

        With cObjSectionTitle
            strHTML = .GetSectionTitle(MyBase.GetResourceString("SECTION_TITLE") + " " + strHTML, "", "", , , , , , , , , , False, False)
        End With
        CommonFunctions.General.WriteHTML(strHTML)

        strHTML = "<br><Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=" + m_strTREven + ">"
        strHTML = strHTML + "<TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>"
        strHTML = strHTML + "<TD align=left>"
        strHTML = strHTML + CommonFunctions.HTMLControls.DrawComboBox("cboProject", "EXEC usp_Sel_tbl_PM_Project_TaskTypeTimesheet " & m_strSessionUserID, , intProjectID, strLockAttributes + " language=javascript onChange=FilterTaskList('cboProject') ", True, True, , True)
        strHTML = strHTML + "</TD></TR>"

        CommonFunctions.General.WriteHTML(strHTML)

        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD></TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optWhichTask", "optGeneralTasks", , False, GENERAL_TASKS, False, " " + strLockAttributes + " onClick=FilterTaskList('optGeneralTasks') ", True) & MyBase.GetResourceString("GENERAL_TASK") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optWhichTask", "optProjectTasks", , False, PROJECT_SPECIFIC_TASKS, False, " " + strLockAttributes + " onClick=FilterTaskList('optProjectTasks') ", True) & MyBase.GetResourceString("MPP_TASKS") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optWhichTask", "optAssignedTasks", , False, ASSIGNED_TASKS, False, " " + strLockAttributes + " onClick=FilterTaskList('optAssignedTasks') ", True) & MyBase.GetResourceString("ASSIGNED_TASKS") & "&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optWhichTask", "optDefectTasks", , False, DEFECTS_ASSIGNED, False, " " + strLockAttributes + " onClick=FilterTaskList('optDefectTasks') ", True) & MyBase.GetResourceString("ISSUES_ASSIGNED"))
        CommonFunctions.General.WriteHTML("</TD></TR>")

        'strSQL = "usp_Sel_tbl_PM_ProjectTasks_ForSimpleDA " & intProjectID & "," & m_strSessionUserID
        strSQL = "usp_Sel_tbl_PM_ProjectTasks_ForTaskTypeTimesheet " & intProjectID & "," & m_strSessionUserID
        CommonFunctions.General.WriteHTML("<SCRIPT Language=JavaScript>" & vbCrLf)
        Select Case strWhichTask
            Case DEFECTS_ASSIGNED
                strSQL = strSQL & ",1,NULL,NULL,NULL"
                CommonFunctions.General.WriteHTML("objoptDefectTasks = GetObjectReference('TTTimesheet', 'optDefectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptDefectTasks.checked = true;" & vbCrLf)
            Case GENERAL_TASKS
                strSQL = strSQL & ",NULL,1,NULL,NULL"
                CommonFunctions.General.WriteHTML("objoptGeneralTasks = GetObjectReference('TTTimesheet', 'optGeneralTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptGeneralTasks.checked = true;" & vbCrLf)
            Case PROJECT_SPECIFIC_TASKS
                strSQL = strSQL & ",NULL,NULL,1,NULL"
                CommonFunctions.General.WriteHTML("objoptProjectTasks = GetObjectReference('TTTimesheet', 'optProjectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptProjectTasks.checked = true;" & vbCrLf)
            Case ASSIGNED_TASKS
                strSQL = strSQL & ",NULL,NULL,NULL,1"
                CommonFunctions.General.WriteHTML("objoptAssignedTasks = GetObjectReference('TTTimesheet', 'optAssignedTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptAssignedTasks.checked = true;" & vbCrLf)
            Case Else
                strSQL = strSQL & ",NULL,NULL,1,NULL"
                CommonFunctions.General.WriteHTML("objoptProjectTasks = GetObjectReference('TTTimesheet', 'optProjectTasks');" & vbCrLf)
                CommonFunctions.General.WriteHTML("objoptProjectTasks.checked = true;" & vbCrLf)
        End Select
        CommonFunctions.General.WriteHTML("</SCRIPT>")
        strSQL = strSQL & ",NULL,NULL,NULL,1"

        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("TASK_TYPE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD colspan=2 align=Left>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTaskTypeID", "usp_Sel_tbl_PM_Project_TaskTypes " & intProjectID, 300, intTaskTypeID, strLockAttributes + " Language=JavaScript onChange=FilterTaskList('cboTaskTypeID') ", True, True, , True))
        Response.Write("<input type=hidden name='txtPrevTaskTypeID' id='txtPrevTaskTypeID' value='" + intTaskTypeID + "'>")
        CommonFunctions.General.WriteHTML("</TD></TR>")



        ' Retrieve the corresponding task type name.
        drTaskType = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_TaskTypes " & intTaskTypeID, MyBase.UseSQL)
        If drTaskType.Read Then
            strTaskType = CType(CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskType"), ""), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drTaskType)

        CommonFunctions.General.WriteHTML("<TR class=" & m_strTREven & "><TD align=right>" & MyBase.GetResourceString("SELECT_TASK") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left colspan=2>")

        strSQL = strSQL & ", NULL, '"
        If Not blnIncludeCompletedTasks Then
            If strWhichTask = ASSIGNED_TASKS And m_HaveSubTaskTypes = True Then
                'Commented By VarunA on 3-Oct-2008 IssueID-22550
                'Purpose : To Have HelpDesk Assign Task also
                'strSQL = strSQL & "AND B.IsTaskComplete = 0 "
                'Else
                'End By VarunA on 3-Oct-2008 IssueID-22550
                strSQL = strSQL & "AND A.IsTaskComplete = 0 "
            End If
        End If
        ' Code Added By NitinVS on 21 Apr 2005 for WhizibleSEM SP3 
        ' Changed the Task Type Name Matching to TaskTypeID Matching 
        If intTaskTypeID <> "0" Then
            'strSQL = strSQL & "AND B.ModuleName = """ & Replace(strTaskType, """", """""") & """ "

            'Modified by MrugajaB on 13th June 2005
            'Purpose: For general tasks TaskTypeID is not present .In such cases, Modulename will be considered
            If strWhichTask = "D" Then
                strSQL = strSQL & "AND A.ModuleName = (SELECT TaskType FROM tbl_PM_TaskTypes WHERE TaskTypeID= " + intTaskTypeID + ")"
            Else
                strSQL = strSQL & "AND A.TaskTypeID = " + intTaskTypeID
            End If
            'End Modification
            ' End Code Addition By NitinVS on 21 Apr 2005 for WhizibleSEM SP3 
        End If
        'Modified By VarunA on 3-Oct-2008 IssueID-22550
        'strSQL = strSQL & "ORDER BY A.TaskName'"
        strSQL = strSQL & " ORDER BY A.TaskName'"
        'End By VarunA on 3-Oct-2008 IssueID-22550
        'Code commented and added by PrashantD on 26 March 2007 for IssueID 11796
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTaskID", strSQL, 300, strTaskInfo, "Language=JavaScript OnChange='TaskClick()'", True, True, , True))

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboTaskID", strSQL, 300, Request.Form("cboTaskID") & "", "Language=JavaScript OnChange='TaskClick()'", True, True, , True))
        'End of addition by PrashantD on 26 March 2007
        'Added by MrugajaB on 31st May 2005 for WhizibleSEM SP3 Issue ID.18703
        'Purpose:Displays all tasks for assigned to the resource in one page
        'Added by PrashantD on 27 March 2007 IssueId 12503
        'Purpose : If strTaskType has single quote, javascript error occurs
        'CommonFunctions.General.WriteHTML("<a Href='javascript:SelectTask(""" & strTaskType & """)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" & MyBase.GetResourceString("TOOLTIP_CLICK_HERE") & "'></a>")
        If Not strTaskType Is Nothing Then
            CommonFunctions.General.WriteHTML("<a Href='javascript:SelectTask(""" & strTaskType.Replace("'", "&#39;") & """)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" & MyBase.GetResourceString("TOOLTIP_CLICK_HERE") & "'></a>")
        Else
            CommonFunctions.General.WriteHTML("<a Href='javascript:SelectTask(""" & strTaskType & """)'><image BORDER='0' src='..\..\images\dblclick.gif' alt='" & MyBase.GetResourceString("TOOLTIP_CLICK_HERE") & "'></a>")
        End If
        'End of addition by PrashantD on 27 March 2007
        'End Modification
        CommonFunctions.General.WriteHTML("</TD></TR>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD>")
        Response.Write("<input type=hidden name='txtPrevTaskID' id='txtPrevTaskID' value=" + intTaskID + ">")
        Response.Write("<input type=hidden id='txtIsDurationChange' name='txtIsDurationChange' value='0'>")
        Response.Write("<LABEL id=lblTaskName name=lblTaskName> </LABEL></TD></TR>")

        If strWhichTask <> GENERAL_TASKS Then
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td></td>")
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("<DIV id=divCode style='text-align:justify'>")
            CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE><BR>")
        'Response.Write("<script language=javascript>DisplayTaskAttributes();</script>")
    End Sub
#End Region

#Region " Grid Plotting "
    Sub PlotGrid()
        Dim drSubTaskTypes As IDataReader
        Dim strSQLQuery As String = ""
        Dim blnReadFlag As Boolean
        Dim strTxtID As String
        Dim strName As String = ""
        Dim intControlCounter As Integer = 0   'Counter for the controls on the page to retreive the values.


        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%'>")
        CommonFunction.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing=0>")


        ' If a Task is selected, then...
        If intTaskID <> "" And intTaskID <> "0" Then
            CommonFunction.General.WriteHTML("<tr class='clsTRColumnHeader'>")
            CommonFunction.General.WriteHTML("<td align='left' width=25%>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ACTIVITY"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td align='center' width=80>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("ACTUAL_WORK"))
            CommonFunction.General.WriteHTML("</td>")

            'Modified By VidyaJ - IssueID - 335 - SP4
            If m_HaveSubTaskTypes = True And strWhichTask <> "D" Then
                CommonFunction.General.WriteHTML("<td align='center' width=100>")
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("ACTUAL_PERCENT_COMPLETE"))
                CommonFunction.General.WriteHTML("</td>")
                If m_blnResourceLevelTaskCompletion = True Then
                    CommonFunction.General.WriteHTML("<td align='center' width=100>")
                    CommonFunction.General.WriteHTML(MyBase.GetResourceString("IS_COMPLETE"))
                    CommonFunction.General.WriteHTML("</td>")
                End If
            End If

            CommonFunction.General.WriteHTML("<td align='center' width=75%>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("DESCRIPTION"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
            ' Get the sub task types associated with the selected project and task type.
            'strSQLQuery = "Exec usp_Sel_tbl_PM_Project_SubTaskTypes " & intProjectID & ", " & intTaskTypeID

            'Modified by SiddharthS on 23 Feb 2005 for IssueID 15670
            strSQLQuery = "Exec usp_Sel_GetSubTasks_For_TTTimesheet " & intTaskID & "," & CType(HttpContext.Current.Session("intUserID"), String)
            'End Modification.
            drSubTaskTypes = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            While drSubTaskTypes.Read
                blnReadFlag = True
                Dim strWork As String       'Working hours for a task.
                Dim strActualWork As String 'Hours worked on a task.
                ' Display the list of reviews planned.

                strActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("ActualWork"), "0"), String)
                strWork = CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("work"), "0"), String)

                CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
                CommonFunction.General.WriteHTML("<td valign='top' width='30%'>")
                Response.Write(CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskType"), ""), String))
                Response.Write("<br><br>Work (hrs): <B>" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("work"), "0"), String) + "</B> Actual Work: <b>" + strActualWork + "</b>")
                CommonFunction.General.WriteHTML("<input type=hidden id='txtSubTaskTypeID' name='txtSubTaskTypeID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String) + "'>")
                CommonFunction.General.WriteHTML("<input type=hidden id='txtHoursValidation' name='txtHoursValidation' value='" + strWork + "'>")
                CommonFunction.General.WriteHTML("<input type=hidden id='txtTaskID' name='txtTaskID' value='" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("TaskID"), "0"), String) + "'>")
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("<td valign='top' align=center>")
                strName = "txtHours" & CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), ""), String)

                If blnPersistValues = False Then
                    'Added By Prasanna 26th March 2004
                    'To be compatible with netscape
                    If m_blnActualWorkHrs = True Then
                        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("txtHours", "usp_Sel_GetActualHrs " + CStr(CommonFunctions.Application.MinHoursForDAEntry), 0, , " id=" + strName + " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                        'Response.Write(CommonFunctions.HTMLControls.DrawComboBox(strName, "usp_Sel_GetActualHrs " + CStr(CommonFunctions.Application.MinHoursForDAEntry), 0, , " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                    Else
                        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtHours", strName, , 45, 5, , "Right", , , , , , " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True, EnableHTMLEncode:=True))
                        '''End of Modification by Dhanashri S on 7 Oct 2015

                        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox(strName, strName, , 45, 5, , "Right", , , , , , " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                    End If
                Else
                    If m_blnActualWorkHrs = True Then
                        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("txtHours", "usp_Sel_GetActualHrs " + CStr(CommonFunctions.Application.MinHoursForDAEntry), 0, Split(MyBase.GetFormValue("txtHours"), ",")(intControlCounter), " id=" + strName + " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                        'Response.Write(CommonFunctions.HTMLControls.DrawComboBox(strName, "usp_Sel_GetActualHrs " + CStr(CommonFunctions.Application.MinHoursForDAEntry), 0, Split(MyBase.GetFormValue("txtHours"), ",")(intControlCounter), " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                    Else
                        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtHours", strName, , 45, 5, Split(MyBase.GetFormValue("txtHours"), ",")(intControlCounter), "Right", , , , , , " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True, EnableHTMLEncode:=True))
                        '''End of Modification by Dhanashri S on 7 Oct 2015

                        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox(strName, strName, , 45, 5, Split(MyBase.GetFormValue("txtHours"), ",")(intControlCounter), "Right", , , , , , " onblur='javascript:txtHours_OnBlur(this," + strActualWork + "," + strWork + ")' onfocus='javascript:txtHours_OnFocus(this)' ", True))
                    End If
                    'Addition Ends
                End If

                CommonFunction.General.WriteHTML("</td>")

                'Added By NitinVS on 25 Apr 2005 for WhizibleSEM SP3 
                ' To Show the Percentage Complete And Is Task Complete Check box for each sub task in case 3 of Task Creation
                If m_HaveSubTaskTypes = True Then

                    'Modified By VidyaJ - IssueID - 335 - SP4
                    If strWhichTask <> "D" Then
                        ' Percent Complete
                        CommonFunction.General.WriteHTML("<td valign='top'>")
                        'Modified By SandeepA on 7 Dec,2005 for IssueID-672 : For Integrating Whiz 2.0. 
                        'Modified Text Box width. (Earlier 10%)

                        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtActualPercentComplete" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String), "txtActualPercentComplete" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String), , 45, 6, CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTaskTypes("ActualPercentComplete"), "0"), "0.00"), "Right", "width=70%", returnHTML:=True, EnableHTMLEncode:=True))
                        '''End of Modification by Dhanashri S on 7 Oct 2015 

                        'End of Modification by SandeepA on 7 Dec,2005 for IssueID-672 : For Integrating Whiz 2.0.
                        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtActualPercentComplete", "txtActualPercentComplete", , 45, 6, CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drSubTaskTypes("ActualPercentComplete"), "0"), "0.00"), "Right", "width=10%", ReturnHtml:=True))
                        CommonFunction.General.WriteHTML("</td>")
                    End If
                    'Modified By VidyaJ - IssueID - 335 - SP4
                    ' Is Task Complete
                    If m_blnResourceLevelTaskCompletion = True And strWhichTask <> "D" Then

                        CommonFunction.General.WriteHTML("<td valign= 'top' align='center'>")
                        Response.Write(CommonFunction.HTMLControls.DrawCheckBox("chkIsTaskComplete" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String), "chkIsTaskComplete" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String), , , CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String), , "align=center", True, ))
                        'Added by PrashantD on 13 April 2007 for IssueID 11794
                        Response.Write("<input type=hidden name=hidIsChkIsTaskCompletePlotted" + CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskTypes("SubTaskTypeID"), "0"), String) + " value=1 >")
                        'End of addition by PrashantD on 13 April 2007
                        CommonFunction.General.WriteHTML("</td>")

                    End If

                    CommonFunction.General.WriteHTML("<td valign ='top'>")

                    If blnPersistValues = False Then
                        'Modified by MrugajaB on 31st May 2005 for calling 'opentextdialog function
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, , , "width:96%", , , , , , True))
                        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, , , "width:96%", , , , , , True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    Else
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, Split(MyBase.GetFormValue("txtDescription"), ",")(intControlCounter), , "width:96%", , , , , , True))
                        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, Split(MyBase.GetFormValue("txtDescription"), ",")(intControlCounter), , "width:96%", , , , , , True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    End If

                    CommonFunction.General.WriteHTML("</td>")

                Else

                    CommonFunction.General.WriteHTML("<td valign='top'>")

                    If blnPersistValues = False Then
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, , , "width:96%", , , , , , True))
                        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, , , "width:96%", , , , , , True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    Else
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, Split(MyBase.GetFormValue("txtDescription"), ",")(intControlCounter), , "width:96%", , , , , , True))
                        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "TTTimesheet", , , , 50, 2000, Split(MyBase.GetFormValue("txtDescription"), ",")(intControlCounter), , "width:96%", , , , , , True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'End Modification by MrugajaB on 31st May 2005
                    End If

                    CommonFunction.General.WriteHTML("</td>")

                End If

                ' End addition By NitinVS on 25 Apr 2005 for WhizibleSEM SP3 

                CommonFunction.General.WriteHTML("</tr>")
                intControlCounter += 1
            End While
            CommonFunctions.Data.DisposeDataReader(drSubTaskTypes)
            If blnReadFlag = False Then
                CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
                CommonFunction.General.WriteHTML("<td align='center' colspan='10'>")
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("VIEW_EMPTY"))
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("</tr>")
                'CommonFunctions.Data.DisposeDataReader(drSubTaskTypes)
            End If
            ' Else, if no task is selected, then...
        Else
            CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<td align='center' colspan='10'>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("TASK_EMPTY"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        End If
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("<br>")
    End Sub
#End Region

    Sub GetTaskDetails(ByVal intTaskID As String, ByRef strTaskInfo As String, ByRef intProjectID As String, ByRef strWhichTask As String, ByRef intTaskTypeID As String)
        '=====================================================================
        ' Procedure Name		:	GetTaskDetails
        ' Purpose				:	To get the details of the Task.
        ' Description			:	Same as above.
        ' Parameters Passed		:	intTaskID		: The Task ID of the task whose details have to be retrieved.
        '							strTaskInfo		: The Task Information.
        '							intProjectID	: The Project ID.
        '							strWhichTask	: The Task Category.
        '							intTaskTypeID	: The Task Type ID.
        ' Parameters Affected	:	strTaskInfo, intProjectID, strWhichTask, intTaskTypeID
        ' Returns				:	No return values.
        ' Assumptions			:	None.
        ' Dependencies			:	
        ' Author				:	PrasannaP
        ' Created				:	March 08, 2004
        ' Revisions				:
        '=====================================================================

        Dim strSQLQuery As String
        Dim drTask As IDataReader

        'Added by MrugajaB on 13th June 2005
        Dim strTaskType As String
        Dim drTaskType As IDataReader
        'End Addition

        ' Get the details of the Task.
        strSQLQuery = "Exec usp_Sel_GetTaskDetails " & intTaskID
        drTask = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drTask.Read Then
            strTaskInfo = CType(CommonFunctions.Data.CheckIsDBNull(drTask("TaskInfo"), ""), String)
            intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), ""), String)
            strWhichTask = CType(CommonFunctions.Data.CheckIsDBNull(drTask("WhichTask"), ""), String)

            'Modified by MrugajaB on 13th June 2005
            'Purpose:When task is General Task, TaskTypeID is NULL so Modulename should be used
            If strWhichTask = "D" Then
                'Commented and Added by Chakshuta H on 8th-Aug-2016 
                'strSQLQuery = "SELECT TaskTypeID FROM tbl_PM_TaskTypes WHERE TaskType='" & CommonFunction.General.BuildQueryString(CType(CommonFunctions.Data.CheckIsDBNull(drTask("ModuleName"), ""), String)) & "'"
                strSQLQuery = "usp_sel_TaskTypeID_tbl_PM_TaskTypes '" & CommonFunction.General.BuildQueryString(CType(CommonFunctions.Data.CheckIsDBNull(drTask("ModuleName"), ""), String)) & "'"
                'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
                drTaskType = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If drTaskType.Read Then
                    intTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskType("TaskTypeID"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drTaskType)

            Else
                intTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTask("TaskTypeID"), ""), String)
            End If
            'End Modification
            If intTaskTypeID = "" Then intTaskTypeID = "0"
        End If
        CommonFunctions.Data.DisposeDataReader(drTask)
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName = MyBase.GetResourceString("MENU_SHOW_ALL_TASKS") Then
            Cancel = True
        End If
    End Sub
End Class
