Public Class TaskDetail
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Public Shared m_strEntityListToShow As String = ""
    Public index As Integer = 0
    Public intCtr As Integer = 0

    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"
    Protected m_strProjectSetting As String = ""
    Protected m_ApplyEffortDistribution As Boolean
    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""
    Private m_lngProjectLocationID As Long = 0
    Protected m_HaveSubTaskTypes As Boolean
    Protected m_bitResourceValidation As Int16 = 1
    Private m_blnProjectActive As Boolean = False
    Private m_blnBillable As Boolean = False
    Protected blnIsNewTask As Boolean
    Protected m_strUserName As String = ""
    'Task Details
    Protected m_strTaskIDList As String = ""
    Protected m_lngTaskId As Long = 0
    Private m_lngProjectId As Long = 0
    Protected m_strEntity As String = ""
    Protected m_strPrimaryKey As String = ""

    Private m_strPhase As String = ""
    Private m_strModule As String = ""
    Private m_strSubProject As String = ""
    Private m_strMilestone As String = ""
    Protected m_strEmployeeId As String = ""
    Protected m_strHolidays As String = ""
    Protected m_ChkDeliverable As Integer = 0
    'For Custom Filed
    Protected m_blnShowDefaults As Boolean = True
    Private m_strCurrentType As String = ""
    Private m_strTaskType As String = ""
    Protected declarevariables As String = ""
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    Protected strClientSideScript As String 'Validation script for custom fields
    Protected m_strCustomFieldList As String = ""
    Dim intColumnNumber As Integer
    Dim objSectionTitle As WebPages.Template.SectionTitle
    Private m_strFormName As String        'FormName on which CustomFields are to be plotted
    Public m_lngRoleId As Long
    Public m_lngUserId As Long
    Private m_strTypeInaccessibleCustomFieldList As String
    Private m_strEntityName As String = "Task" 'can be Delivarble,Review etc
    Private m_intMaxRows As Integer
    Private m_intMaxCols As Integer
    Private ArrCtlAttr(20) As String            'array to store Properties of Custom Fields such as name,caption,ht etc
    Private arrEventHandlers(30, 3) As String
    Private strFieldValue As String = ""
    Private strDummyFieldValue As String = ""
    Private m_strPrimaryTable As String         'Table From which Custom field Values  to be retrived
    Private m_strPrimaryKeyID As Long
    Private strEventHandlers As String
    Public IsAddNewMode As Boolean
    Public QueryStringForTypeChange As String 'Query string Passed to URL for Type change e.g "TaskTypeID"
    'Commented and Added By Bharat T on 9th-Oct-2015
    'Private arrValidationMessages(30) As String
    Private arrValidationMessages(50) As String
    'End of Commented and Added By Bharat T on 9th-Oct-2015
#End Region
    Public Function PlotAssignTaskFields(ByVal TaskID As String, ByVal strProjectID As String, ByVal strPrimaryKey As String, ByVal strEntity As String, ByVal USID As String) As String
        m_lngProjectId = strProjectID
        m_strEntity = strEntity
        m_strPrimaryKey = strPrimaryKey
        MyBase.ApplySecurity(True)

        Dim sbTasksHTML As New StringBuilder("")
        Dim sbTasksDynamicHTML As New StringBuilder("")
        Dim sbTasksCustomFiledsHTML As New StringBuilder("")

        Dim StrQueryTask As String = ""
        Dim TaskOnHold As String = ""
        Dim StrTaskName As String = ""
        Dim TaskNotes As String = ""
        Dim Priority As String = ""
        Dim NextGen_IterationID As String = ""
        Dim NextGen_ReleaseID As String = ""
        Dim StoryPoint As String = ""
        Dim EmployeeID As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim TaskType As String = ""
        Dim TaskTypeID As String = ""
        Dim PhaseID As String = ""
        Dim MilestoneID As String = ""
        Dim ModuleID As String = ""
        Dim SubProjectID As String = ""
        Dim ChangeRequestID As String = ""
        Dim DeliverableID As String = ""
        Dim workHrs As String = ""
        Dim UserStoryID As String = ""
        Dim drUS As IDataReader
        StrQueryTask = "usp_Sel_Ng2_Tbl_Pm_GetProjectTasks " & TaskID & "," & strProjectID & ""
        drUS = CommonFunctions.Data.GetDataReader(StrQueryTask, True)
        While drUS.Read
            StrTaskName = CommonFunctions.Data.CheckIsDBNull(drUS("TaskName"), "")
            TaskNotes = CommonFunctions.Data.CheckIsDBNull(drUS("TaskNotes"), "")
            Priority = CommonFunctions.Data.CheckIsDBNull(drUS("Priority"), "")
            NextGen_ReleaseID = CommonFunctions.Data.CheckIsDBNull(drUS("NextGen_ReleaseID"), "")
            EmployeeID = CommonFunctions.Data.CheckIsDBNull(drUS("EmployeeID"), "")
            NextGen_IterationID = CommonFunctions.Data.CheckIsDBNull(drUS("NextGen_IterationID"), "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(drUS("StartDate"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drUS("EndDate"), "")
            TaskTypeID = CommonFunctions.Data.CheckIsDBNull(drUS("TaskTypeID"), "")
            PhaseID = CommonFunctions.Data.CheckIsDBNull(drUS("PhaseID"), "")
            ModuleID = CommonFunctions.Data.CheckIsDBNull(drUS("ModuleID"), "")
            SubProjectID = CommonFunctions.Data.CheckIsDBNull(drUS("SubProjectID"), "")
            MilestoneID = CommonFunctions.Data.CheckIsDBNull(drUS("MilestoneID"), "")
            UserStoryID = CommonFunctions.Data.CheckIsDBNull(drUS("UserStoryID"), "")
            StoryPoint = CommonFunctions.Data.CheckIsDBNull(drUS("StoryPoint"), "")
            workHrs = CommonFunctions.Data.CheckIsDBNull(drUS("Work"), "")
            TaskOnHold = CommonFunctions.Data.CheckIsDBNull(drUS("TaskOnHold"), "")
            ChangeRequestID = CommonFunctions.Data.CheckIsDBNull(drUS("ChangeRequestID"), "")
            DeliverableID = CommonFunctions.Data.CheckIsDBNull(drUS("DeliverableID"), "")
        End While

        Dim strProjectName As String = ""
        Dim strAttributeName As String = ""

        sbTasksDynamicHTML.Append(PlotDynamicFields(strProjectID, strPrimaryKey, "PageLoad", USID, ModuleID, PhaseID, SubProjectID, MilestoneID, ChangeRequestID, DeliverableID))
        strProjectName = GetprojectName(strProjectID)

        If strEntity = "AssignedTask" Then
            strAttributeName = "Assigned Task"
        Else
            strAttributeName = GetAttributeDetails(strPrimaryKey, strProjectID, strEntity)
        End If

        sbTasksHTML.Append("<Div class='clsControlSection'>")
        sbTasksHTML.Append("<div class='col-md-12'>")
        sbTasksHTML.Append("<div class='form-group'>")

        sbTasksHTML.Append("<label class='control-label  col-sm-2'>")
        sbTasksHTML.Append("Task Name")
        sbTasksHTML.Append("</label>")

        sbTasksHTML.Append("<div class='col-sm-10'>")
        If StrTaskName = "" Then
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AssigntxtTaskName", "AssigntxtTaskName", "task-form  ", , 255, StrTaskName, , , , , , , "onkeyup='javascript:limitText(this,countTaskName,255)' onKeyUp='javascript:limitText(this,countTaskName,255)'", True, EnableHTMLEncode:=True))
            sbTasksHTML.Append("<small name='countTaskName' Id='countTaskName'>255</small>")
        Else
            Dim len As Integer = 255
            Dim len1 As Integer
            If StrTaskName.Length <> -1 Then
                len1 = StrTaskName.Length
                len = 255 - len1
            End If
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AssigntxtTaskName", "AssigntxtTaskName", "task-form  ", , 255, StrTaskName, , , , , , , "onkeyup='javascript:limitText(this,countTaskName,255)' onKeyUp='javascript:limitText(this,countTaskName,255)'", True, EnableHTMLEncode:=True))
            sbTasksHTML.Append("<small name='countTaskName' Id='countTaskName'>" & len & "</small>")
        End If

        sbTasksHTML.Append("<input type=hidden id='hdnTaskID' name='hdnTaskID' value='" & TaskID & "' />")
        sbTasksHTML.Append("<input type=hidden id='hdnTaskID' name='hdnTaskID' value='" & TaskID & "' />")
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("</div>") 'End of First TR
        sbTasksHTML.Append("<TR>")
        sbTasksHTML.Append("<TD>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("<TD colspan=3>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spntxtTaskName'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>")

        sbTasksHTML.Append("<div class='form-group'>")  '2nd TR

        sbTasksHTML.Append("<label class='control-label  col-sm-2'>")
        sbTasksHTML.Append("Task Notes")
        sbTasksHTML.Append("</label>")

        sbTasksHTML.Append("<div class='col-sm-10'>")
        'Commented & Added By Dipali V On 24th May 2017 For Give Char Lenght validation For Text Area Control
        If TaskNotes = "" Then
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , "task-form", , , , , , , 2000, TaskNotes, , "", , , , , "onkeyup='javascript:limitText(this,countTaskNote,2000)' onKeyUp='javascript:limitText(this,countTaskNote,2000)'onchange=ClearSpan('txtTaskNotes','spntxtTaskNotes') data-autoresize", True, EnableHTMLEncode:=True))
            sbTasksHTML.Append("<small name='countTaskNote' Id='countTaskNote'  style='border-style:None;float:Right;margin-top:-4%'>2000</small>")
        Else
            Dim len As Integer = 2000
            Dim len1 As Integer
            If TaskNotes.Length <> -1 Then
                len1 = TaskNotes.Length
                len = 2000 - len1
            End If
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , "task-form", , , , , , , 2000, TaskNotes, , "", , , , , "onkeyup='javascript:limitText(this,countTaskNote,2000)' onKeyUp='javascript:limitText(this,countTaskNote,2000)'onchange=ClearSpan('txtTaskNotes','spntxtTaskNotes') data-autoresize", True, EnableHTMLEncode:=True))
            sbTasksHTML.Append("<small name='countTaskNote' Id='countTaskNote'  style='border-style:None;float:Right;margin-top:-4%'>" & len & "</small>")

        End If

        'End of Commented & Added By Dipali V On 24th May 2017 For Give Char Lenght validation For Text Area Control
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("</div>") 'End of 2nd TR

        sbTasksHTML.Append("<TR>")
        sbTasksHTML.Append("<TD>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("<TD colspan=3>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spntxtTaskNotes'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>")


        sbTasksHTML.Append("<div class='form-group'>")   '3rd TR

        sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        sbTasksHTML.Append("Resource(s) *")
        sbTasksHTML.Append("</label>")
        sbTasksHTML.Append("<div class='col-sm-10'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAssignResources", "usp_Ng2_Sel_CurrentTeamMembers " & Session("IntProjectID"), , EmployeeID, "onchange=ClearSpan('cboResources','spncboResources') disabled", True, True, "task-form", , , , ))
        sbTasksHTML.Append("<input type=hidden class='clsHidden' id='hdnEmployeeID' name='hdnEmployeeID' value=''>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spncboResources'></span>")
        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")


        sbTasksHTML.Append("<div class='form-group'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        sbTasksHTML.Append("Work(hrs) *")
        sbTasksHTML.Append("</label>")
        sbTasksHTML.Append("<div class='col-sm-4'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AssigntxtWorkHrs", "AssigntxtWorkHrs", "task-form ", , 6, workHrs, , , , , , , "onkeyup=ClearSpan('txtWorkHrs','spntxtWorkHrs')", True, EnableHTMLEncode:=True))
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spntxtWorkHrs'></span>")
        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>") 'End of 3rd TR


        sbTasksHTML.Append("<div class='form-group'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-2' >") 'style='text-align:center'
        sbTasksHTML.Append("Story Points")
        sbTasksHTML.Append("</label>")


        sbTasksHTML.Append("<div class='col-sm-4'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AssigntxtStoryPoints", "AssigntxtStoryPoints", "task-form ", , , StoryPoint, , , , , , , " style='' ", True, , , , , , True))
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spndtEndDate'></span>")

        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")






        sbTasksHTML.Append("<TR>") '4th TR
        sbTasksHTML.Append("<TD colspan=2>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spnResources_Work'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>") 'End of 4th TR

        sbTasksHTML.Append("<div class='form-group'>")  '5th TR
        'Added By Dipali V On 30th May 2018 For Alignment Issues
        sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        sbTasksHTML.Append("Start Date *")
        sbTasksHTML.Append("</label>")

        sbTasksHTML.Append("<div class='col-sm-4'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtStartDateAssigntask", "dtStartDateAssigntask", "task-form", , 100, StartDate, , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        sbTasksHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float:right;  margin-top: -35px;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#dtStartDateAssigntask').datepicker();$('#dtStartDateAssigntask').datepicker('show');""></i>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spndtStartDate'></span>")

        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("<div class='form-group'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-2' >") 'style='text-align:center'
        sbTasksHTML.Append("End Date *")
        sbTasksHTML.Append("</label>")


        sbTasksHTML.Append("<div class='col-sm-4'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtEndDateAssigntask", "dtEndDateAssigntask", "task-form ", , 100, EndDate, , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        sbTasksHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float:right;  margin-top: -35px;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#dtEndDateAssigntask').datepicker();$('#dtEndDateAssigntask').datepicker('show');""></i>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spndtEndDate'></span>")

        sbTasksHTML.Append("</div>")
        'End of Added By Dipali V On 30th May 2018 For Alignment Issues
        sbTasksHTML.Append("</div>") 'End of 5th TR

        sbTasksHTML.Append("<TR>") '6th TR
        sbTasksHTML.Append("<TD colspan=2>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spnDates'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>") 'End of 6th TR

        sbTasksHTML.Append("<TR>")  '7th TR

        sbTasksHTML.Append("<div class='form-group'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        sbTasksHTML.Append("Priority * ")
        sbTasksHTML.Append("</label>")

        sbTasksHTML.Append("<div class='col-sm-4'>")
        sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboPriorities", "usp_Sel_tbl_IB_Priorities ", , Priority, "onchange=ClearSpan('cboPriorities','spncboPriorities')", True, True, "task-form", , , , ))
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spncboPriorities'></span>")
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("<div class='form-group'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-2'  >") 'style='text-align:center'
        sbTasksHTML.Append("Task Type *")
        sbTasksHTML.Append("</label>")

        sbTasksHTML.Append("<div class='col-sm-4'>")
        'Dim strSQLQuery As String = "usp_Ng2_Sel_Typetypefrom_tasktypeid '" & TaskTypeID & "'"
        'm_strCurrentType = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)
        If TaskTypeID <> "" Then
            StrQueryTask = "usp_Ng2_Sel_Typetypefrom_tasktypeid " & TaskTypeID & ""
            drUS = CommonFunctions.Data.GetDataReader(StrQueryTask, True)
            While drUS.Read
                TaskType = CommonFunctions.Data.CheckIsDBNull(drUS("TaskType"), "")
            End While
            ' sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , TaskType, "onchange=Customfiled(this)", True, True, "task-form", , , , ))
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , TaskType, "", True, True, "task-form", , , , ))
        Else
            'sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , , "onchange=Customfiled(this)", True, True, "task-form", , , , ))
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , , "", True, True, "task-form", , , , ))
        End If

        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spncboTaskType'></span>")
        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")

        'sbTasksHTML.Append("<div class='form-group'>")
        'sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        'sbTasksHTML.Append("Task Type *")
        'sbTasksHTML.Append("</label>")

        'sbTasksHTML.Append("<div class='col-sm-10'>")
        ''Dim strSQLQuery As String = "usp_Ng2_Sel_Typetypefrom_tasktypeid '" & TaskTypeID & "'"
        ''m_strCurrentType = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)
        'If TaskTypeID <> "" Then
        '    StrQueryTask = "usp_Ng2_Sel_Typetypefrom_tasktypeid " & TaskTypeID & ""
        '    drUS = CommonFunctions.Data.GetDataReader(StrQueryTask, True)
        '    While drUS.Read
        '        TaskType = CommonFunctions.Data.CheckIsDBNull(drUS("TaskType"), "")
        '    End While
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , TaskType, "onchange=Customfiled(this)", True, True, "task-form", , , , ))
        'Else
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskType", "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("IntProjectID"), , , "onchange=Customfiled(this)", True, True, "task-form", , , , ))
        'End If

        'sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spncboTaskType'></span>")
        'sbTasksHTML.Append("</div>")
        'sbTasksHTML.Append("</div>") 'End of 7th TR

        sbTasksHTML.Append("<TR>") '8th TR
        sbTasksHTML.Append("<TD colspan=2>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spnPriority_TaskType'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>") 'End of 8th TR

        sbTasksHTML.Append("<div class='form-group' style='margin-top:15px;'>")  '9th TR
        sbTasksHTML.Append("<div class='col-sm-6' style='margin-top:15px;'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-4 col-xs-4' style='margin-left: -4%;'>On Hold</label>")
        sbTasksHTML.Append("<div class='col-sm-8 clsShowInEdit'>")
        If TaskOnHold = "True" Then
            sbTasksHTML.Append("<input type=checkbox id=chkHold name=chkHold checked=true value=1/>")
        Else
            sbTasksHTML.Append("<input type=checkbox id=chkHold name=chkHold value='' />")
        End If

        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("<div class='col-sm-6' style='margin-top:15px;    margin-bottom: 15px;'>")
        sbTasksHTML.Append("<label class='control-label  required col-sm-4 col-xs-4' style='margin-left:-3%'>Billable</label>")
        sbTasksHTML.Append("<div class='col-sm-8'>")
        sbTasksHTML.Append("<input type=checkbox id=chkBillable name=chkBillable checked=true value=1 />")
        sbTasksHTML.Append("</div>")
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("</div>")  'End of 9th TR




        'sbTasksHTML.Append("<div class='form-group'>")
        'sbTasksHTML.Append("<label class='control-label  required col-sm-2'>")
        'sbTasksHTML.Append("Story Points")
        'sbTasksHTML.Append("</label>")

        'sbTasksHTML.Append("<div class='col-sm-10'>")
        'sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AssigntxtStoryPoints", "AssigntxtStoryPoints", "task-form ", , , StoryPoint, , , , , , , " style='' ", True, , , , , , True))
        ''sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("AssigntxtStoryPoints", "AssigntxtStoryPoints", , "task-form", , , , , , , , , , "", , , , , "onkeyup='javascript:limitTextTask(this,countdown,2000)' onKeyUp='javascript:limitTextTask(this,countdown,2000)'onchange=ClearSpan('txtTaskNotes','spntxtTaskNotes')", True, EnableHTMLEncode:=True))
        'sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spncboTaskType'></span>")
        'sbTasksHTML.Append("</div>")
        'sbTasksHTML.Append("</div>")



        sbTasksHTML.Append("<TR>")
        sbTasksHTML.Append("<TD>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("<TD colspan=3>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spntxtTaskNotes'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>")




        sbTasksHTML.Append("</div>") 'End of Main Table of assigned Tasks

        'Starts 2nd section of the page entity fields dynamic section
        sbTasksHTML.Append("<div class='col-md-12 col-sm-12 col-xs-12'>")

        'Dynamic Fields Plotting
        sbTasksHTML.Append("<div id='divDynamicFields'>")
        sbTasksHTML.Append("<div class='task-attribute'>Task Attributes</div>")

        'sbTasksHTML.Append(PlotDynamicFields(strProjectID, "PageLoad"))
        sbTasksHTML.Append(sbTasksDynamicHTML.ToString)
        sbTasksHTML.Append("</div>")

        sbTasksHTML.Append("</Div>") 'End of clsControlSection'
        sbTasksHTML.Append("</div>")


        sbTasksHTML.Append("</div>") 'End of modal-body

        sbTasksHTML.Append("<div class='modal-footer'>")
        sbTasksHTML.Append("<span id='divSuccess1' style='float:left;width:60%;height:34px;display:none;background-color:#00B050!important' class='alert alert-info' >")
        sbTasksHTML.Append("<button style='display:none;' type='button' class='close' data-bs-dismiss='alert' aria-hidden='true'>&times;</button>")
        sbTasksHTML.Append("<h5 id='alertID1' style='float:left;'><i class='icon fa fa-check'></i>Task Created Successfully!</h5>")
        sbTasksHTML.Append("</span>")


        sbTasksHTML.Append(GetProjectSettingsDetails(strProjectID, "Hidden"))

        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))
        'Dim strPlannedWork As String
        'strPlannedWork = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_PlannedWorkHours_ChildTasks " + m_lngTaskId.ToString, True), "0"), "0")
        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtPlannedWork", "hid_txtPlannedWork", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))

        'TaskEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskEndDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")
        'TaskStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskStartDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")

        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate", "hid_txtTaskEndDate", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))
        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate", "hid_txtTaskStartDate", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))

        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))
        sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , , , , , , , True, , True, EnableHTMLEncode:=True))

        'End of Hidden Control Section 

        'sbTasksHTML.Append("</Div>")  'End Main Assigned Tasks Div

        PlotAssignTaskFields = sbTasksHTML.ToString

    End Function

    Public Function PlotDynamicFields(ByVal strProjectID As String, ByVal strPrimaryKey As String, Optional ByVal strStatus As String = "", Optional ByVal USID As String = "", Optional ByVal ModuleID As String = "", Optional ByVal PhaseID As String = "", Optional ByVal SubProjectID As String = "", Optional ByVal MilestoneID As String = "", Optional ChangeRequestID As String = "", Optional DeliverableID As String = "") As String
        Dim sbTasksHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim dtDataTable As DataTable
        Dim tdCounter As Integer = 0
        Dim strDropdownSQL As String = ""
        Dim strEntityName As String = ""

        Dim strProjectTypeID As String = "NULL"
        Dim strEntitySQL As String = ""
        strProjectID = Session("IntProjectID")
        Dim StrProjectType As String = "NULL"
        Dim strIsAgileProject As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_IsAgileProject " & Session("IntProjectID"), True), "1")

        'strEntitySQL = "Usp_Ng2_Ins_tbl_PM_AssignTaskAttributeView " & Session("intUserID") & "," & strProjectID & ",'" & strStatus & "',null"
        ' CommonFunctions.Data.InsertOrUpdateData(strEntitySQL, True)

        'strSQL = "usp_App_Sel_Get_Task_Attributes " & strProjectID
        strSQL = "Usp_Ng2_Sel_tbl_PM_AssignTaskAttributeView " & Session("intUserID") & "," & strProjectID & ",null"
        dtDataTable = CommonFunctions.Data.GetDataTable(strSQL, True)

        sbTasksHTML.Append("<div id='tblEntityFields' class='clsfullWidth clsTRSpacing'>")

        Dim strPrimaryKey1 As String = ""
        For index = 0 To dtDataTable.Rows.Count - 1

            If tdCounter = 0 Then
                sbTasksHTML.Append("<div class='form-group'>")
            End If

            If dtDataTable.Rows(index)("Attributes") = "Phase" Then
                strDropdownSQL = "usp_NG2_PRS_GetProjectPhasesForSQA " & strProjectID
                strPrimaryKey1 = PhaseID
                'If CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_sel_Is_AgileProject " & strProjectID & "," & HttpContext.Current.Session("ProjectTypeID"), True), "") = "1" Then
                '    Continue For
                'End If


            ElseIf dtDataTable.Rows(index)("Attributes") = "Module" Then
                strDropdownSQL = "usp_Ng2_Sel_tbl_PM_Module " & strProjectID & ",NULL,'A',NULL "
                strPrimaryKey1 = ModuleID
            ElseIf dtDataTable.Rows(index)("Attributes") = "Sub Project" Or dtDataTable.Rows(index)("Attributes") = "SubProject" Then


                ''strDropdownSQL = "usp_App_Sel_tbl_PM_SubProject " & strProjectID & ",NULL,'T',NULL "
                strDropdownSQL = "usp_Ng2_Sel_tbl_PM_SubProject " & strProjectID & ",NULL,'T',NULL,NULL"
                strPrimaryKey1 = SubProjectID
            ElseIf dtDataTable.Rows(index)("Attributes") = "Milestone" Then

                strPrimaryKey1 = MilestoneID
                ''strDropdownSQL = "usp_App_Sel_tbl_PM_Milestones " & strProjectID & ",'T',NULL "
                strDropdownSQL = "usp_Ng2_Sel_tbl_PM_Milestones " & strProjectID & ",'T',NULL,NULL"
                ''End of Commented And Added By Vaijat K ON 15/02/2017 For Passing Practice ID
            ElseIf dtDataTable.Rows(index)("Attributes") = "Change Request" Or dtDataTable.Rows(index)("Attributes") = "ChangeRequest" Then
                strPrimaryKey1 = ChangeRequestID
                strDropdownSQL = "usp_Ng2_Sel_tbl_PM_ChangeRequest_Master " & strProjectID & ",Null,'','','',Null,'','',NULL"
            ElseIf dtDataTable.Rows(index)("Attributes") = "Deliverable" Then
                strPrimaryKey1 = DeliverableID
                strDropdownSQL = "usp_Ng2_sel_tbl_PM_OtherSchedulesForList " & strProjectID & ",NULL"
                m_ChkDeliverable = 1
                'strPrimaryKey1 = 
            Else
                strDropdownSQL = ""
            End If

            'If dtDataTable.Rows(index)("Mandatory") = "1" Then
            sbTasksHTML.Append("<label class='control-label  col-sm-2'>")

            If dtDataTable.Rows(index)("Attributes") = "ChangeRequest" Then
                sbTasksHTML.Append("Change Request")
            ElseIf dtDataTable.Rows(index)("Attributes") = "SubProject" Then
                sbTasksHTML.Append("Sub Project")
            Else
                sbTasksHTML.Append("" & dtDataTable.Rows(index)("Attributes") & "")
            End If
            If dtDataTable.Rows(index)("Mandatory") = "1" Then
                sbTasksHTML.Append("<span class='required'>*</span></label>")
            Else
                sbTasksHTML.Append("</label>")
            End If
            '



            sbTasksHTML.Append("<div class='col-sm-10'>")


            strEntityName = CType(dtDataTable.Rows(index)("Attributes"), String).Replace(" ", "")

            If m_strPrimaryKey = dtDataTable.Rows(index)("Attributes") Then
                sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cbo" & strEntityName & "", strDropdownSQL, , strPrimaryKey, "onchange=ClearSpan('cbo" & strEntityName & "','spn" & strEntityName & "'); Mandatory=" & dtDataTable.Rows(index)("Mandatory") & "", True, True, "task-form", , , , ))
                sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spn" & strEntityName & "'></span>")
            Else
                sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cbo" & strEntityName & "", strDropdownSQL, , strPrimaryKey1, "onchange=ClearSpan('cbo" & strEntityName & "','spn" & strEntityName & "'); Mandatory=" & dtDataTable.Rows(index)("Mandatory") & "", True, True, "task-form", , , , ))
                sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spn" & strEntityName & "'></span>")
            End If
            sbTasksHTML.Append("<input type=hidden id='hdn" & strEntityName & "' class='hdnControls'  value='' '>")
            sbTasksHTML.Append("</div>")

            tdCounter += 1
            'End If

            If tdCounter = 2 Then
                sbTasksHTML.Append("</div>")
                tdCounter = 0
            End If

        Next


        If tdCounter = 1 Then
            sbTasksHTML.Append("</div>")
        End If

        If strIsAgileProject <> "0" Then
            ''Commented By Vidya Jadhav
            sbTasksHTML.Append("<div class='form-group'>")

            sbTasksHTML.Append("<label class='control-label  col-sm-2'>")

            sbTasksHTML.Append("User Stories")
            sbTasksHTML.Append("</label>")

            Dim strQuery As String = "usp_sel_tbl_PM_ScrumUserStory " & strProjectID
            'Dim strProjectTypeID As String = Session("ProjectTypeID")
            sbTasksHTML.Append("<div class='col-sm-10'>")


            If m_strEntity = "UserStory" Then
                sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "usp_NG2_GetUserStoriesForTask " & strProjectID & "", , USID, "onChange=UserStoryID_OnChange(value) disabled", True, True, "task-form", , , , ))
            Else
                sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "usp_NG2_GetUserStoriesForTask " & strProjectID & "", , USID, "onChange=UserStoryID_OnChange(value) disabled", True, True, "task-form", , , , ))
            End If


            sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spnUserStory'></span>")
            sbTasksHTML.Append("<input type=hidden id='hdnUserStory' class='hdnControls'  value='' '>")
            sbTasksHTML.Append("</div>")

            sbTasksHTML.Append("</div>")

        End If
        sbTasksHTML.Append("<TR>")
        sbTasksHTML.Append("<TD colspan=3>")
        sbTasksHTML.Append("<span class='clsSpan' style='color: #dd1037; font-size: 12px;' id='spnEntity'></span>")
        sbTasksHTML.Append("</TD>")
        sbTasksHTML.Append("</TR>")

        If strIsAgileProject <> "0" Then

            Dim strIteration As String
            Dim strRelease As String
            Dim strIsStoryComplete As String

            If strPrimaryKey <> "" Then
                Dim strResult As String = GetUserStoryDetails(strPrimaryKey, USID)
                Dim arrResult() As String = Split(strResult, "#$$#")

                If arrResult.Length = 1 Then
                    strRelease = ""
                    strIteration = ""
                    strIsStoryComplete = "0"
                Else
                    strRelease = arrResult(0)
                    strIteration = arrResult(1)
                    strIsStoryComplete = arrResult(2)
                End If

            End If

            sbTasksHTML.Append("<div class='form-group'>")



            sbTasksHTML.Append("<label class='control-label  col-sm-2'>")
            sbTasksHTML.Append("Release")
            sbTasksHTML.Append("</label><div class='col-sm-10'>")

            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelease", "txtRelease", "task-form clsTextBoxReadOnly", , , strRelease, "left", , True, True, , , "", returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True))

            sbTasksHTML.Append("</div>")

            sbTasksHTML.Append("<label class='control-label  col-sm-2'>")
            'sbTasksHTML.Append("Iteration")
            sbTasksHTML.Append("Sprint ")
            sbTasksHTML.Append("</label><div class='col-sm-10'>")

            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtIteration", "txtIteration", "task-form clsTextBoxReadOnly", , , strIteration, "left", , True, True, , , "", returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True))
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHdnIsStoryComplete", "txtHdnIsStoryComplete", strIsStoryComplete, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))

            sbTasksHTML.Append("</div>")

            sbTasksHTML.Append("</div>")
            'End Of Commented By Vidya Jadhav
        End If

        sbTasksHTML.Append("</div>")
        PlotDynamicFields = sbTasksHTML.ToString
    End Function

    'Public Function PlotMainCustomFields(ByVal strProjectID As String, ByVal strPrimaryKey As String, Optional ByVal strStatus As String = "", Optional ByVal USID As String = "") As String
    '    Dim sbTasksHTML As New StringBuilder("")
    '    Dim strSQL As String = ""
    '    If m_strTaskType = "" Then
    '        m_strTaskType = ""
    '        m_strCurrentType = ""
    '    End If
    '    'Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
    '    'With ObjCustomFieldsSection
    '    '    'Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
    '    '    'Response.Write("<SCRIPT Language=javascript>")
    '    '    'Response.Write(.ClientsideScript)
    '    '    'Response.Write("</SCRIPT>")
    '    '    sbTasksHTML.Append(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
    '    '    sbTasksHTML.Append("<SCRIPT Language=javascript>")
    '    '    sbTasksHTML.Append(.ClientsideScript)
    '    '    sbTasksHTML.Append("</SCRIPT>")
    '    'End With
    '    sbTasksHTML.Append("<DIV id=DivCustomFieldsSection width='100%' style='overflow:auto'>")
    '    'Response.Write("<DIV id=DivCustomFieldsSection width='100%' style='overflow:auto'>")
    '    Dim strTaskID As String
    '    Dim strDummyTask As String
    '    Dim blnDummyDefaultValue As Boolean
    '    strTaskID = ""
    '    If strTaskID <> "" Then
    '        strDummyTask = strTaskID
    '        blnDummyDefaultValue = False
    '    Else
    '        strDummyTask = m_lngTaskId.ToString()
    '        blnDummyDefaultValue = m_blnShowDefaults
    '    End If
    '    Dim objCustomFields As New AssignTask
    '    With objCustomFields
    '        .EntityName = "Task"
    '        .FormName = "form1"
    '        .PrimaryKey = "TaskID"
    '        .PrimaryTable = "tbl_PM_ProjectTasks"
    '        .TypeID = m_strCurrentType
    '        .IsAddNewMode = blnDummyDefaultValue
    '        .PrimaryKeyValue = CType(strDummyTask, Long)

    '        .QueryStringForTypeChange = "TaskTypeID"
    '        .m_lngProjectId = m_lngProjectId
    '        '.PlotCustomFields()
    '        .PlotCustomFields()
    '        'declarevariables = .VariableDeclarationScript
    '        'strClientSideScript = .ValidationScript
    '        'strDefaultScript = .DefaultValueScript
    '        'm_strCustomFieldList = .AccesibleCustomFields
    '    End With
    '    sbTasksHTML.Append("</DIV>")
    '    ' Response.Write("</DIV>")
    '    '  End If
    '    'End addition by SandipL

    '    'If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
    '    '    'To Display the Resources List
    '    '    If m_lngTaskId > 0 Then
    '    '        objSectionTitle = New WebPages.Template.SectionTitle
    '    '        'CommonFunctions.General.WriteHTML("<BR>")
    '    '        sbTasksHTML.Append("</BR>")
    '    '        objSectionTitle.GetSectionTitle(MyBase.GetResourceString("RESOURCES"), "", "")
    '    '        objSectionTitle = Nothing

    '    '        ' Call DisplayResourcesList()

    '    '        ' Added By NitinVS on 10 March 2005 for PBNITE SP2
    '    '        ' To show the details of Documents uploaded 
    '    '        objSectionTitle = New WebPages.Template.SectionTitle
    '    '        ' CommonFunctions.General.WriteHTML("<BR>")
    '    '        sbTasksHTML.Append("</BR>")
    '    '        objSectionTitle.GetSectionTitle("Document(s)", "", "")
    '    '        objSectionTitle = Nothing
    '    '        ' Call DisplayDocumentList()
    '    '        ' End Addition By NitinVS on 10 MArch 2005 for PBNITE SP2

    '    '    End If
    '    '    'Added By NitinVS on 12 Apr 2005 for PBNITE SP2 To Show Documents Grid for CASE 3 
    '    'Else
    '    '    If m_lngTaskId > 0 Then
    '    '        objSectionTitle = New WebPages.Template.SectionTitle
    '    '        sbTasksHTML.Append("</BR>")
    '    '        objSectionTitle.GetSectionTitle("Document(s)", "", "")
    '    '        objSectionTitle = Nothing
    '    '        ' Call DisplayDocumentList()
    '    '    End If
    '    '    ' End Addition By NitinVS on 10 MArch 2005 for PBNITE SP2
    '    'End If


    '    'sbTasksHTML.Append("</DIV>")
    '    Return sbTasksHTML.ToString
    '    ' CommonFunctions.General.WriteHTML("</DIV>")
    '    ''--- added By PurvaJ on 7 Nov 2008 for Whiziblesem 8.0
    '    ''--- validation : Current Work hours should not be less than actual work hours.

    '    ' '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    '    'CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , m_strActualWork.ToString, , , , , , True, EnableHTMLEncode:=True)
    '    'Dim strPlannedWork As String
    '    'strPlannedWork = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_PlannedWorkHours_ChildTasks " + m_lngTaskId.ToString, True), "0"), "0")
    '    'CommonFunction.HTMLControls.DrawTextBox("hid_txtPlannedWork", "hid_txtPlannedWork", , 200, , strPlannedWork.ToString, , , , , , True, EnableHTMLEncode:=True)
    '    ' '''End of Modification by Dhanashri S on 7 Oct 2015 

    '    ''--- end addition purvaj
    '    ''Added by TruptiK on 24-Mar-09
    '    ''--- validation : Current Date should not be less than actual date.
    '    ''CommonFunction.HTMLControls.DrawTextBox("hid_txtActualWork", "hid_txtActualWork", , 200, , m_strActualWork.ToString, , , , , , True)
    '    'Dim TaskEndDate As String
    '    'Dim TaskStartDate As String
    '    ''Added by TruptiK on 13-Apr-09
    '    'Dim ModeCopy As String
    '    ''End of addition by TruptiK on 13-Apr-09 
    '    'TaskEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskEndDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")
    '    'TaskStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TaskStartDate_ChildTasks " + m_lngTaskId.ToString, True), ""), "")
    '    'If TaskEndDate <> "" Then

    '    '    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate", "hid_txtTaskEndDate", , 200, , CDate(TaskEndDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
    '    'Else
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskEndDate", "hid_txtTaskEndDate", , 200, , TaskEndDate, , , , , , True, EnableHTMLEncode:=True)
    '    'End If
    '    'If TaskStartDate <> "" Then
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate", "hid_txtTaskStartDate", , 200, , CDate(TaskStartDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
    '    'Else
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtTaskStartDate", "hid_txtTaskStartDate", , 200, , TaskStartDate, , , , , , True, EnableHTMLEncode:=True)
    '    'End If
    '    ''Added by TruptiK on 13-Apr-09
    '    'ModeCopy = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"))
    '    'If ModeCopy = "" Then
    '    '    If m_strActualStartDate <> "" Then
    '    '        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , CDate(m_strActualStartDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
    '    '    Else
    '    '        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , m_strActualStartDate, , , , , , True, EnableHTMLEncode:=True)
    '    '    End If
    '    '    'Added by GokulP on 08 Oct 2009 for IssueID : 32455
    '    '    If m_strTaskMaxEntryDate <> "" Then
    '    '        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , CDate(m_strTaskMaxEntryDate).ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
    '    '    Else
    '    '        CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , m_strTaskMaxEntryDate, , , , , , True, EnableHTMLEncode:=True)
    '    '    End If
    '    '    'End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455
    '    'Else
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtActualStartDate", "hid_txtActualStartDate", , 200, , "0", , , , , , True, EnableHTMLEncode:=True)
    '    '    'Added by GokulP on 08 Oct 2009 for IssueID : 32455
    '    '    CommonFunction.HTMLControls.DrawTextBox("hid_txtActualEndDate", "hid_txtActualEndDate", , 200, , "0", , , , , , True, EnableHTMLEncode:=True)
    '    '    '''End of Modification by Dhanashri S on 7 Oct 2015 

    '    '    'End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455
    '    'End If

    'End Function
    ''Public Function PlotCustomFields(Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "")
    ''    '==================================================================================
    ''    ' Procedure Name		:	PlotCustomFields
    ''    ' Parameters Passed		:	To plot custom fields for Tasks
    ''    ' Returns				:	none
    ''    ' Parameters Affected	:	none
    ''    ' Purpose				:	
    ''    ' Description			:	Same as above.
    ''    ' Assumptions			:	
    ''    ' Dependencies			:	None
    ''    ' Author				:	SandipL
    ''    ' Created				:	20 Jan 2006
    ''    ' Revisions				:	
    ''    '==================================================================================
    ''    Dim sbTasksHTML As New StringBuilder("")
    ''    Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
    ''    Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
    ''    Dim intDestinationIndex, intSourceIndex As Integer
    ''    Dim drLayout As IDataReader
    ''    Dim drCustomAccess As IDataReader
    ''    Dim strSQLForCustom As String
    ''    Dim strCustomFieldIDs() As String
    ''    Dim intCount As Integer
    ''    Dim intCorporateRoleLevel As Integer
    ''    'Declare variables needed for security
    ''    m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)

    ''    If Not m_lngProjectId > 0 Then
    ''        m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
    ''    Else
    ''        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    ''        ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
    ''        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
    ''        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    ''        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
    ''            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    ''            'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
    ''            m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
    ''            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    ''        End If
    ''    End If
    ''    If Not m_lngRoleId > 0 Then
    ''        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
    ''    End If


    ''    m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)

    ''    If UserID = 0 Then
    ''        UserID = CType(HttpContext.Current.Session("intUserID"), Integer)
    ''    End If
    ''    If LoginType = "" Then
    ''        LoginType = Session("LoginType").ToString()
    ''    End If

    ''    'Added By Amol Changle On: 22 Jul 2009
    ''    'Purpose: For Entity "Help-Desk" ProjectID is considered to be 0.
    ''    'Modified By Syamantak Chavan on 21 Sept 2011 For Custom Field addition in whizible 10.0
    ''    If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
    ''        m_lngProjectId = 0
    ''    End If
    ''    'End Addition

    ''    m_strCustomFieldList = ""
    ''    m_strTypeInaccessibleCustomFieldList = ""

    ''    'MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    ''    'Get Accesible CustomFieldIDs List
    ''    strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + UserID.ToString
    ''    If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    ''        strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
    ''    End If

    ''    'Added By Amol Changle On: 19 Aug 2009
    ''    'Purpose: To handle Login Type specific issues
    ''    strSQLForCustom += ",'" + LoginType + "'"
    ''    'End Addition

    ''    drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
    ''    While drCustomAccess.Read
    ''        ReDim Preserve strCustomFieldIDs(intCount)
    ''        strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
    ''        intCount += 1
    ''    End While
    ''    CommonFunction.Data.DisposeDataReader(drCustomAccess)


    ''    ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
    ''    'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

    ''    If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
    ''        m_strCurrentType = "NULL"
    ''    End If

    ''    strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + m_strCurrentType

    ''    If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    ''        'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
    ''        strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
    ''    Else
    ''        'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
    ''        strSQLQuery = strSQLQuery + ",'Task'"
    ''    End If
    ''    strSQLQuery = strSQLQuery + ",1," + UserID.ToString()


    ''    'Added By Amol Changle On: 19 Aug 2009
    ''    'Purpose: To handle Login Type specific issues
    ''    strSQLQuery += ",'" + LoginType + "'"
    ''    'End Addition

    ''    'usp_Sel_tbl_PM_CustomFields_Master_MaxRows

    ''    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
    ''    If drLayout.Read Then
    ''        m_intMaxRows = CType(drLayout("MaxRows"), Integer)
    ''        m_intMaxCols = CType(drLayout("MaxCols"), Integer)
    ''    End If
    ''    CommonFunction.Data.DisposeDataReader(drLayout)

    ''    'Start Plotting of Custom Fields
    ''    'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
    ''    sbTasksHTML.Append("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
    ''    ' HttpContext.Current.Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
    ''    strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


    ''    If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

    ''    If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
    ''    If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"

    ''    'Added by ShraddhaM
    ''    strSQLQuery = strSQLQuery + "," + UserID.ToString()
    ''    'Ended by ShraddhaM

    ''    'Added By Amol Changle On: 19 Aug 2009
    ''    'Purpose: To handle Login Type specific issues
    ''    strSQLQuery += ",'" + LoginType + "'"
    ''    'End Addition


    ''    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
    ''    ' Call GetValidationRules()

    ''    If drLayout.Read Then
    ''        For intRow = 1 To m_intMaxRows
    ''            'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf

    ''            'Added By Amol Changle On: 22 Jul 2009
    ''            'Purpose: Not to render blank rows
    ''            If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
    ''                'End Addition
    ''                sbTasksHTML.Append("<TR class=clsTREven >")
    ''                ' HttpContext.Current.Response.Write("")
    ''                For intCol = 1 To m_intMaxCols
    ''                    intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
    ''                    intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

    ''                    If intCurrentCellNumber < intNextCellNumber Then
    ''                        sbTasksHTML.Append("<td valign=top align=right colspan=2 >&nbsp;</td>")
    ''                        'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
    ''                    ElseIf intCurrentCellNumber >= intNextCellNumber Then
    ''                        declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
    ''                        'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
    ''                        'HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")
    ''                        sbTasksHTML.Append("<td valign=top align=right width='5%'>")
    ''                        'get value form form
    ''                        'If m_blnShowFormContents = True Then


    ''                        If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
    ''                            strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

    ''                            'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
    ''                            ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
    ''                            'Save Database value also

    ''                            If m_strPrimaryKeyID > 0 Then
    ''                                'If Not rsIssueDetails.EOF Then
    ''                                Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    ''                                strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    ''                                'End If
    ''                            Else
    ''                                strDummyFieldValue = ""
    ''                            End If

    ''                        Else
    ''                            If m_strPrimaryKeyID > 0 Then
    ''                                'If Not rsIssueDetails.EOF Then
    ''                                Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    ''                                strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    ''                                'End If
    ''                            Else
    ''                                strFieldValue = ""
    ''                            End If
    ''                            strDummyFieldValue = strFieldValue
    ''                        End If

    ''                        'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

    ''                        ' Retrieve the attributes of the control to be displayed.
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
    ''                        'Modified By VarunA on 27-Sep-2008
    ''                        'Purpose : Security Issue
    ''                        'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
    ''                        'End By VarunA on 27-Sep-2008
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
    ''                        If (drLayout("DataType").ToString = "1") Then
    ''                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
    ''                            End If
    ''                        End If

    ''                        ' Set the control type depending on the name of the custom field to be displayed.
    ''                        ' For Text Area custom fields...

    ''                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

    ''                            ' Set the maxlengths of the textareas.
    ''                            'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

    ''                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    ''                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    ''                            End If

    ''                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    ''                            End If
    ''                            'End If

    ''                            intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
    ''                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    ''                            ' For Text Box custom fields...
    ''                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    ''                            ' Set the maxlengths of the textboxes.
    ''                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    ''                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    ''                            End If

    ''                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    ''                            End If

    ''                            ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
    ''                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
    ''                            End If

    ''                            intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    ''                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    ''                            ' For Combo Box custom fields...									
    ''                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
    ''                            ''Added By Amol Changle On: 21 Jul 2009
    ''                            ''Purpose: To select field details Entity Specific
    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
    ''                            ''End Addition

    ''                            ' Set the maxlengths of the combobox.
    ''                            'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
    ''                            'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    ''                            'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
    ''                            '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
    ''                            'End If
    ''                            'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    ''                            '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    ''                            'End If

    ''                            intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
    ''                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    ''                            ' For Date Control custom fields...								
    ''                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

    ''                            intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
    ''                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



    ''                        End If

    ''                        ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
    ''                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
    ''                        If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
    ''                        End If

    ''                        ' If the default value is to be retrieved from one of the common fields or custom fields, then...
    ''                        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

    ''                            ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
    ''                            If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

    ''                                ' Get the index of the custom fields.
    ''                                If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
    ''                                    ' Text Area Range	: 26 - 28.
    ''                                    intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
    ''                                ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
    ''                                    ' Text box Range	: 1 - 10.
    ''                                    intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
    ''                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
    ''                                    ' Combo box Range	: 11 - 20.
    ''                                    intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
    ''                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
    ''                                    ' Date control Range: 21 - 25.
    ''                                    intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
    ''                                End If

    ''                                strEventHandlers = ""
    ''                                strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    ''                                strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    ''                                strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

    ''                                If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    ''                                    strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
    ''                                Else
    ''                                    strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    ''                                End If

    ''                                strEventHandlers = strEventHandlers + "}" + vbCrLf

    ''                                arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

    ''                            End If

    ''                            strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    ''                            strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    ''                            strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
    ''                            strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

    ''                            'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    ''                            strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
    ''                            'Else
    ''                            '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    ''                            'End If

    ''                            strDefaultScript = strDefaultScript + "}" + vbCrLf
    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

    ''                            ' For Numweric custom fields...
    ''                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then

    ''                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    ''                            ' Set the maxlengths of the textboxes.
    ''                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    ''                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    ''                            End If

    ''                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    ''                            End If


    ''                            'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    ''                            intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
    ''                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


    ''                        End If
    ''                        sbTasksHTML.Append(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))
    ''                        'HttpContext.Current.Response.Write(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))
    ''                        sbTasksHTML.Append("</td>")
    ''                        ' HttpContext.Current.Response.Write("</td>")
    ''                        ' HttpContext.Current.Response.Write("<td valign=top style='width:15%'>")
    ''                        sbTasksHTML.Append("<td valign=top style='width:15%'>")

    ''                        'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
    ''                        Dim blnShowControl As Boolean = False
    ''                        Dim intCounter As Integer

    ''                        intCounter = 0
    ''                        'If length of array is greater than 0 that means security is explicitly set
    ''                        'In that case check if it is accessible ,if yes then show the control, 
    ''                        'otherwise show it as not applicable
    ''                        If intCount > 0 Then

    ''                            While intCounter < intCount
    ''                                'Check if the current Custom Field ID is in the array
    ''                                If strCustomFieldIDs(intCounter).ToLower.Trim = _
    ''                                            CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
    ''                                    blnShowControl = True
    ''                                    Exit While
    ''                                End If

    ''                                intCounter = intCounter + 1

    ''                            End While

    ''                        Else
    ''                        End If

    ''                        If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
    ''                            m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
    ''                            ' Call DrawControl(ArrCtlAttr)
    ''                            'Call ClearAttributes(ArrCtlAttr)
    ''                        Else

    ''                            If IsAddNewMode = True Then
    ''                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
    ''                            End If

    ''                            'The Custom Field is not defied for the Current Type
    ''                            'HttpContext.Current.Response.Write("( " + MyBase.GetResourceString("NbyA") + " )")
    ''                            sbTasksHTML.Append("( " + MyBase.GetResourceString("NbyA") + " )")
    ''                            'Do not save value if the Custom Field is not applicable
    ''                            If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
    ''                                m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","

    ''                                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    ''                                sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, IsHidden:=True, EnableHTMLEncode:=True))
    ''                            Else
    ''                                sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , IsHidden:=True, EnableHTMLEncode:=True))
    ''                            End If
    ''                            sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True))
    ''                            '''End of Modification by Dhanashri S on 7 Oct 2015 

    ''                            ' reset value of inactive custom fields before saving.
    ''                            strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
    ''                        End If
    ''                        ' HttpContext.Current.Response.Write("</TD>")
    ''                        sbTasksHTML.Append("</TD>")
    ''                        If Not drLayout.Read() Then
    ''                            Dim i As Integer
    ''                            For i = intCol To m_intMaxCols - 1
    ''                                sbTasksHTML.Append("<td valign=top align=right colspan=2>&nbsp;</td>")

    ''                                'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
    ''                            Next
    ''                            Exit For
    ''                        End If
    ''                    Else
    ''                        sbTasksHTML.Append("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
    ''                        'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
    ''                        'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
    ''                        If Not drLayout.Read() Then
    ''                            Dim i As Integer
    ''                            For i = intCol To m_intMaxCols - 1
    ''                                'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
    ''                                sbTasksHTML.Append("<td valign=top align=right colspan=2>&nbsp;</td>")
    ''                            Next
    ''                            Exit For
    ''                        End If
    ''                    End If
    ''                Next
    ''                'HttpContext.Current.Response.Write("</TR>")
    ''                sbTasksHTML.Append("</TR>")
    ''            End If
    ''        Next
    ''        If m_strCustomFieldList <> "" Then
    ''            m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
    ''        End If
    ''        If m_strTypeInaccessibleCustomFieldList <> "" Then
    ''            m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
    ''        End If
    ''        sbTasksHTML.Append("<SCRIPT language=javaScript>")
    ''        ' HttpContext.Current.Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
    ''        CommonFunction.Data.DisposeDataReader(drLayout)

    ''        Dim intCtr As Integer
    ''        ' Loop through the array to check if any event handlers need to be printed.
    ''        For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

    ''            ' If the control name is present and the event handler is present, then print it.
    ''            ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
    ''            ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
    ''            ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
    ''            If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
    ''                If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    ''                    ' HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
    ''                    sbTasksHTML.Append("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
    ''                Else
    ''                    ' HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
    ''                    sbTasksHTML.Append("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
    ''                End If
    ''                ' HttpContext.Current.Response.Write(arrEventHandlers(intCtr, 2))
    ''                sbTasksHTML.Append(arrEventHandlers(intCtr, 2))
    ''                'HttpContext.Current.Response.Write("}" + vbCrLf)
    ''                sbTasksHTML.Append("}" + vbCrLf)
    ''            End If
    ''        Next
    ''        sbTasksHTML.Append("</SCRIPT>" + vbCrLf)
    ''        ' HttpContext.Current.Response.Write("</SCRIPT>" + vbCrLf)
    ''    Else
    ''        sbTasksHTML.Append("<tr class=clsTREven>")
    ''        ' HttpContext.Current.Response.Write("<tr class=clsTREven>")
    ''        ' HttpContext.Current.Response.Write("<td align=center valign=center>")
    ''        'HttpContext.Current.Response.Write("<b>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</b>")
    ''        sbTasksHTML.Append("<td align=center valign=center>")
    ''        sbTasksHTML.Append("<b>No Custom Filds</b>")
    ''        sbTasksHTML.Append("</td>")
    ''        sbTasksHTML.Append("</tr>")

    ''    End If
    ''    CommonFunction.Data.DisposeDataReader(drLayout)
    ''    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    ''    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True))
    ''    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True))
    ''    '''End of Modification by Dhanashri S on 7 Oct 2015 
    ''    'HttpContext.Current.Response.Write("</TABLE>")
    ''    sbTasksHTML.Append("</TABLE>")
    ''    ' Return sbTasksHTML.ToString

    ''    'PlotCustomFields = sbTasksHTML.ToString
    ''End Function 'Plot all custom fields for Issue
    ''Private Sub DrawControl(ByRef ArrCtlAttr() As String)
    ''    '==================================================================================
    ''    ' Procedure Name		:	DrawControl
    ''    ' Parameters Passed		:	arrCtlAttr : This array contains the attributes of the control to be drawn.
    ''    ' Returns				:	No return Value.
    ''    ' Parameters Affected	:	arrCtlAttr :- The array gets modified.
    ''    ' Purpose				:	To actually draw the control as per the specifications in the array.
    ''    ' Description			:	Same as above.
    ''    ' Assumptions			:	
    ''    ' Dependencies			:	None
    ''    ' Author				:	SandipL
    ''    ' Created				:	20 Jan 2006
    ''    ' Revisions				:	
    ''    '==================================================================================		

    ''    Dim strToBeInserted As String = ""
    ''    Dim strProperty As String
    ''    Dim intCtr As Integer
    ''    Dim strControlCaption As String
    ''    Dim strControlName As String
    ''    Dim strControlValue As String = ""
    ''    Dim SQLQuey As String
    ''    Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
    ''    Dim blnReadOnly As Boolean = False
    ''    Dim blnIsMandatory As Boolean = False
    ''    Dim blnIsDisabled As Boolean = False
    ''    strControlCaption = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
    ''    ' If the default values have to be shown, then... (When the page is loaded for the first time.)
    ''    '        If (IsAddNewMode = True And HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing) Then
    ''    If (IsAddNewMode = True) Then
    ''        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
    ''    End If

    ''    If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
    ''        strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE)

    ''        'If strControlValue = "" And Not HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing Then
    ''        '    If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) Is Nothing Then
    ''        '        strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
    ''        '    End If
    ''        'End If

    ''    Else
    ''        strControlValue = ""
    ''    End If

    ''    'Control Name
    ''    strControlName = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)

    ''    ' control width 
    ''    If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH)) <> "" Then
    ''        intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH), Integer)
    ''    End If

    ''    'Cotrol Height
    ''    If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT)) <> "" Then
    ''        intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT), Integer)
    ''    End If

    ''    ' Read Only
    ''    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
    ''        blnReadOnly = True
    ''        strToBeInserted = strToBeInserted & " disabled "
    ''        blnIsDisabled = True
    ''    Else
    ''        blnReadOnly = False
    ''        blnIsDisabled = False
    ''    End If

    ''    ' additional information.
    ''    If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) <> "" Then
    ''        strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) + " "
    ''    End If

    ''    ' maxlength 
    ''    If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" Then
    ''        intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH), Integer)
    ''        'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) + " "
    ''    End If

    ''    ' mandatory 
    ''    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
    ''        blnIsMandatory = True
    ''    Else
    ''        blnIsMandatory = False
    ''    End If


    ''    ' Depending on the control type, draw the control.
    ''    Select Case ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    ''        Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.

    ''            HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory))

    ''        Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
    ''            SQLQuey = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY)
    ''            HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , blnIsMandatory))

    ''        Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.

    ''            'Modified By ShraddhaM on 27 July 2006
    ''            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
    ''            'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft"))
    ''            HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft", EnableHTMLEncode:=True))
    ''            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
    ''        Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
    ''            If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
    ''                If Not IsDate(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE).Trim) Then
    ''                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
    ''                End If
    ''            Else
    ''                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
    ''            End If

    ''            If strControlValue <> "" And strControlValue <> "0" Then
    ''                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , m_strFormName, , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
    ''            Else
    ''                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , m_strFormName, , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
    ''            End If

    ''        Case Else
    ''            HttpContext.Current.Response.Write("&nbsp;")

    ''    End Select
    ''    'Commented and added by Bharat T on 13th-Oct-2015
    ''    'Dim arrtemp(30) As String
    ''    Dim arrtemp(50) As String
    ''    'End of Commented and added by Bharat T on 13th-Oct-2015
    ''    arrValidationMessages.CopyTo(arrtemp, 0)

    ''    'Generate the client side validation scripts for the control.		
    ''    Call GenerateValidationScript(ArrCtlAttr, arrtemp)


    ''End Sub 'Draw the control 
    ''Private Sub GenerateValidationScript(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
    ''    '==================================================================================
    ''    ' Procedure Name		:	GenerateValidationScript
    ''    ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
    ''    '							arrValidationMessages : The array containing the validation messages.
    ''    ' Returns				:	No Return Value
    ''    ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
    ''    ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
    ''    ' Description			:	Same as above.
    ''    ' Assumptions			:	
    ''    ' Dependencies			:	None
    ''    ' Author				:	SandipL
    ''    ' Created				:	20 Jan 2006
    ''    ' Revisions				:	
    ''    '==================================================================================

    ''    Dim strValidation As String = ""
    ''    Dim intCtr As Integer = 0
    ''    Dim arrRules As String()
    ''    Dim intValidationID As Integer
    ''    Dim strCaption As String
    ''    ' Get the validation rule IDs in an array.
    ''    strValidation = ""

    ''    arrRules = Split(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).Trim, ",")
    ''    strCaption = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
    ''    If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
    ''        Exit Sub
    ''    End If

    ''    ' For each validation rule to be applied, generate the client side validation script.
    ''    For intCtr = LBound(arrRules) To UBound(arrRules)
    ''        If arrRules(intCtr) <> "" Then
    ''            intValidationID = CType(arrRules(intCtr), Integer)
    ''            'If IsNumeric(intValidationID) Then
    ''            intValidationID = CInt(intValidationID)
    ''            arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
    ''            'End If
    ''        End If

    ''        Dim blnLoopcheck As Boolean = False
    ''        Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    ''        Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE)
    ''        Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE)

    ''        Select Case intValidationID.ToString

    ''            Case "1" ' Not Blank.														

    ''                strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
    ''                arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
    ''                blnLoopcheck = True
    ''            Case "2" ' Valid Date.				

    ''                If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION), "'") > 0 Then
    ''                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
    ''                Else
    ''                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
    ''                End If

    ''                strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
    ''                If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    ''                    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
    ''                End If
    ''                strValidation = strValidation + "return;" + vbCrLf
    ''                strValidation = strValidation + "}}}" + vbCrLf

    ''            Case "3" ' Numeric Data.
    ''                strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True
    ''            Case "9" ' Only Alphabets.
    ''                strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True
    ''            Case "12" ' Max Length
    ''                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
    ''                If Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" And Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "0" Then
    ''                    strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf
    ''                    strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ");" + vbCrLf
    ''                    blnLoopcheck = True
    ''                End If

    ''                'End If

    ''            Case "13" ' Positive Numeric Data.				
    ''                strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True
    ''            Case "14" ' Check Duplication.
    ''                ' Not Processed !!

    ''            Case "15" ' Restrict Special characters.
    ''                strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True

    ''            Case "16" ' Minimum Value Check.
    ''                strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True

    ''            Case "17" ' Maximum Value Check.
    ''                strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True
    ''            Case "18" ' Value Range.

    ''                strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
    ''                blnLoopcheck = True

    ''            Case Else
    ''        End Select
    ''        If blnLoopcheck = True Then

    ''            If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    ''                strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
    ''            End If
    ''            strValidation = strValidation + "return false;" + vbCrLf
    ''            strValidation = strValidation + "}" + vbCrLf
    ''        End If
    ''    Next

    ''    ' if the control is editable, only then apply the validation rules.
    ''    If Right(strValidation, 2) = ";;" Then
    ''        strValidation = Left(strValidation, Len(strValidation) - 1)
    ''    End If
    ''    If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
    ''        strClientSideScript = strClientSideScript + strValidation
    ''    ElseIf UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "DESCRIPTION" Then
    ''        strClientSideScript = strClientSideScript + strValidation
    ''    End If

    ''End Sub
    ''Private Sub GetValidationRules()
    ''    '==================================================================================
    ''    ' Procedure Name		:	GetValidationRules
    ''    ' Parameters Passed		:	To get all the validation messages in an array
    ''    ' Returns				:	none
    ''    ' Parameters Affected	:	none
    ''    ' Purpose				:	
    ''    ' Description			:	Same as above.
    ''    ' Assumptions			:	
    ''    ' Dependencies			:	None
    ''    ' Author				:	SandipL
    ''    ' Created				:	20 Jan 2006
    ''    ' Revisions				:	
    ''    '==================================================================================		

    ''    Dim drValidationRules As IDataReader

    ''    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    ''    ' Retrieve all the validation messages.
    ''    '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
    ''    drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

    ''    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    ''    'Save all these validation messages in array
    ''    Do While drValidationRules.Read
    ''        arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
    ''    Loop

    ''    'Dispose data reader
    ''    CommonFunction.Data.DisposeDataReader(drValidationRules)
    ''End Sub 'Get all validation rules and generate array
    ''Private Sub ClearAttributes(ByRef arrCtlAttr As String())
    ''    '==================================================================================
    ''    ' Procedure Name		:	IsValidField
    ''    ' Parameters Passed		:	arrCtlAttr : This array has to be re-initialised for each control
    ''    ' Returns				:	No return Value.
    ''    ' Parameters Affected	:	arrCtlAttr :- The array gets reinitialised.
    ''    ' Purpose				:	
    ''    ' Description			:	Same as above.
    ''    ' Assumptions			:	
    ''    ' Dependencies			:	None
    ''    ' Author				:	SandipL
    ''    ' Created				:	19 Jan 2006
    ''    ' Revisions				:	
    ''    '==================================================================================		

    ''    Dim intCtr As Integer

    ''    For intCtr = 0 To 14
    ''        arrCtlAttr(intCtr) = ""
    ''    Next

    ''    arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"

    ''End Sub 'Clear control Atributes
    Public Function GetprojectName(ByVal Projectid As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetprojectName
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To get project Name from projectID
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Bharat T.
        ' Created				:   12th-Dec-2016
        '=====================================================================
        Dim strResult As New StringBuilder("")
        Dim strsql As String
        'Dim objPM_Risk As New PM_Risk()
        Dim strReturnHtml As New StringBuilder("")
        Dim strResult1 As String = ""

        strsql = "usp_Ng2_Sel_Projectname " & Projectid & ""
        strResult1 = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strsql, True), "")


        Return strResult1

    End Function
    Public Function GetAttributeDetails(ByVal strPrimaryKey As String, ByVal strProjectID As String, ByVal strEntity As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetAttributeDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To get details of passed attribute id
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Bharat T.
        ' Created				:   14th-Dec-2016
        '=====================================================================
        Dim strResult As New StringBuilder("")
        Dim strsql As String
        'Dim objPM_Risk As New PM_Risk()
        Dim strReturnHtml As New StringBuilder("")
        Dim strResult1 As String = ""

        strsql = "Usp_Ng2_Get_AttributeDetails " & strPrimaryKey & "," & strProjectID & ",'" & strEntity & "'"
        strResult1 = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strsql, True), "")


        Return strResult1

    End Function
    'Public Function SaveTask(ByVal TaskID As String, ByVal TaskName As String, ByVal EmployeeID As String, ByVal WorkHrs As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Priority As String, _
    '                        ByVal TaskType As String, ByVal Billable As String, ByVal Hold As String, ByVal PhaseVal As String, ByVal ModuleVal As String, ByVal SubProjectVal As String, _
    '                        ByVal MilestoneVal As String, ByVal ChangeRequestVal As String, ByVal DeliverableVal As String, ByVal strProjectID As String, ByVal PracticeID As String) As String
    Public Function SaveTask(ByVal AssignTaskData As Object) As String
        Dim strProjectID As String = HttpContext.Current.Session("ProjectID").ToString

        Call GetProjectSettingsDetails(strProjectID, "")
        Dim EmployeeID As String = AssignTaskData(0)("EmployeeID")

        Dim TaskID As String
        Dim TaskName As String
        Dim WorkHrs As String
        Dim StartDate As String
        Dim EndDate As String
        Dim Priority As String
        Dim TaskType As String
        Dim Billable As String
        Dim Hold As String
        Dim PhaseVal As String
        Dim ModuleVal As String
        Dim SubProjectVal As String
        Dim MilestoneVal As String
        Dim ChangeRequestVal As String
        Dim DeliverableVal As String
        Dim PracticeID As String
        Dim UserStoryID As String
        Dim strEntity As String

        TaskID = AssignTaskData(0)("TaskID")
        TaskName = AssignTaskData(0)("TaskName")
        WorkHrs = AssignTaskData(0)("WorkHrs")
        StartDate = AssignTaskData(0)("StartDate")
        EndDate = AssignTaskData(0)("EndDate")
        Priority = AssignTaskData(0)("Priority")
        TaskType = AssignTaskData(0)("TaskType")
        Billable = AssignTaskData(0)("Billable")
        Hold = AssignTaskData(0)("Hold")
        PhaseVal = AssignTaskData(0)("PhaseVal")
        ModuleVal = AssignTaskData(0)("ModuleVal")
        SubProjectVal = AssignTaskData(0)("SubProjectVal")
        MilestoneVal = AssignTaskData(0)("MilestoneVal")
        ChangeRequestVal = AssignTaskData(0)("ChangeRequestVal")
        DeliverableVal = AssignTaskData(0)("DeliverableVal")
        ''Added By Vidya Jadhav ON 30 Jan 2017
        'For index = 1 To AssignTaskData.

        'Next

        'For Each kvp As KeyValuePair(Of Integer, String) In AssignTaskData(0)
        '    Dim v1 As Integer = kvp.Key
        '    Dim v2 As String = kvp.Value

        'Next

        'For index = 0 To AssignTaskData(0).count - 1
        '    Dim v1 As Integer = AssignTaskData(0)("UserStoryID")
        'Next

        Dim temp As Integer = 0
        Try
            UserStoryID = AssignTaskData(0)("UserStoryID")
        Catch ex As Exception
            temp = 1
        End Try

        'strEntity = AssignTaskData(0)("strEntity")
        'If strEntity <> "Phase" Then
        '    UserStoryID = AssignTaskData(0)("UserStoryID")
        'End If
        ''Added By Vidya Jadhav ON 30 Jan 2017
        PracticeID = HttpContext.Current.Session("ProjectTypeID")

        If EmployeeID <> "" Then
            Dim strQuery As String = ""
            Dim strQuery_1 As String = ""
            Dim strQuery_2 As String = ""
            Dim strTempQuery As String = ""
            Dim arrEmpId() As String
            Dim intNumberOfEmployees As Integer = 0
            Dim strEmployeeNames As String = ""
            Dim strTempName As String = ""
            Dim strSQL As String = ""

            If TaskID > 0 Then
                If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                    '   strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & EmployeeID & "," & TaskID.ToString()
                    strQuery_1 = "Exec usp_App_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & EmployeeID & "," & TaskID.ToString()
                Else
                    ''     strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                    strQuery_1 = "Exec usp_App_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                End If
                blnIsNewTask = False
            Else
                '  strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks NULL"
                strQuery_1 = "Exec usp_App_Ins_tbl_PM_ProjectAssignedTasks NULL"
                blnIsNewTask = True
            End If
            strQuery_2 &= ", " & strProjectID.ToString()
            '----------------------
            ' SQL QUERY : PART 2
            '----------------------
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskName) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(StartDate) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(EndDate) & "'"


            If WorkHrs = "" Then
                strQuery_2 &= ",null"
            Else
                strQuery_2 &= ",'" + WorkHrs + "'"
            End If
            '----------'
            strQuery_2 &= ",'O'"
            '---------'
            If Billable = "1" Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If

            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskName) & "'"
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(TaskType) & "'"

            If StartDate <> "" Then
                strQuery_2 &= ", '" & StartDate.ToString() & "'"
            Else
                strQuery_2 &= ", NULL"
            End If
            If EndDate <> "" Then
                strQuery_2 &= ", '" & EndDate.ToString() & "'"
            Else
                strQuery_2 &= ", NULL"
            End If
            If WorkHrs <> "" Then
                strQuery_2 &= ", " & FormatNumber(WorkHrs, , , , TriState.False)
            Else
                strQuery_2 &= ", NULL"
            End If


            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(Priority) & "'"

            strSQL = "EXEC Usp_App_Sel_WBSNames " & PhaseVal & "," & ModuleVal & "," & SubProjectVal & "," & MilestoneVal
            Dim drNames As IDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

            If drNames.Read Then
                m_strPhase = CommonFunction.Data.CheckIsDBNull(drNames("Phase"), "")
                m_strModule = CommonFunction.Data.CheckIsDBNull(drNames("Module"), "")
                m_strSubProject = CommonFunction.Data.CheckIsDBNull(drNames("Subproject"), "")
                m_strMilestone = CommonFunction.Data.CheckIsDBNull(drNames("Milestone"), "")
            End If

            If PhaseVal > 0 Then
                strQuery_2 &= ", " & PhaseVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strPhase) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If ModuleVal > 0 Then
                strQuery_2 &= ", " & ModuleVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strModule) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If SubProjectVal > 0 Then
                strQuery_2 &= ", " & SubProjectVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strSubProject) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If
            If MilestoneVal > 0 Then
                strQuery_2 &= ", " & MilestoneVal.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strMilestone) & "'"
            Else
                strQuery_2 &= ", NULL, NULL"
            End If

            'ReviewActionId
            '------------------'
            strQuery_2 &= ",null"
            '------------------'

            If ChangeRequestVal > 0 Then
                strQuery_2 &= ", " & ChangeRequestVal.ToString()
            Else
                strQuery_2 &= ", NULL"
            End If


            '-----------Project Feature & Estimation-------'
            strQuery_2 &= ",null"
            strQuery_2 &= ",null"
            '------------------'

            'Deliverable ID
            If DeliverableVal > 0 Then
                strQuery_2 &= ", " & DeliverableVal.ToString()
            Else
                strQuery_2 &= ", NULL"
            End If

            strQuery_2 &= ",null,null,0,1"

            '---Hold----
            If Hold = "1" Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If
            'strQuery_2 &= ",0"
            '---Hold----
            m_strUserName = HttpContext.Current.Session("strUserName")
            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"


            'If CommonFunction.General.CheckIsNothing(Request.QueryString("WhichTask"), "") = "S" Or CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Or m_strUserStory <> "" Then
            '    strQuery_2 &= ", 1"
            'Else
            '    strQuery_2 &= ", 0"
            'End If

            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If

            'Commented By Vidya
            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", " & UserStoryID
            Else
                strQuery_2 &= ", NULL"
            End If

            'End of Commented By Vidya



            'If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "") <> "" Then
            '    strQuery_2 &= ", " & Request.QueryString("UserStoryID")
            'ElseIf m_strUserStory <> "" Then
            '    strQuery_2 &= ", " & m_strUserStory
            'Else
            '    strQuery_2 &= ", NULL"
            'End If


            '---------------------------------------------------------------------------------           
            'If CommonFunction.General.CheckIsNothing(Request.QueryString("PageType"), "") = "Deliverable" Then
            '    If m_strRequestStageID <> "" Then
            '        strQuery_2 &= ", '" & m_strRequestStageID.ToString & "'"
            '    Else
            '        strQuery_2 &= ", NULL"
            '    End If
            'End If
            strQuery_2 &= ",NULL"
            ''Added By Vidya Jadhav ON 13 Jan 2017
            strQuery_2 &= ", " & PracticeID.ToString()
            '---------------------------------------------------------------------------------
            strTempQuery = strQuery_2
            strQuery = strQuery_1 & strTempQuery

            If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                m_strTaskIDList = m_lngTaskId.ToString() & ", "
                'Insert the SubTasks for each Resource when new Task is created
            ElseIf m_strProjectSetting = PROJECT_SETTING_NORMAL Then
                If blnIsNewTask = True Then
                    arrEmpId = EmployeeID.Split(CType(",", Char))
                    intNumberOfEmployees = arrEmpId.Length()
                    strQuery_2 = strTempQuery
                    strTempQuery = strQuery
                    strEmployeeNames = ""
                    For intCtr = 0 To intNumberOfEmployees - 1

                        m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

                        'Insert the Child Tasks for each employee
                        'strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 = "Exec usp_App_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 &= ", " & arrEmpId(intCtr)
                        strQuery_1 &= ", NULL"
                        strQuery = strQuery_1 & strQuery_2
                        m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                    Next
                Else
                    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                End If
            End If
        End If

        Return ""
    End Function

#Region " Database Related Functions Or Procedures "

    Private Function GetProjectSettingsDetails(ByVal strProjectID As String, ByVal strFlag As String) As String
        '====================================================================
        ' Procedure Name       : GetProjectSettingsDetails
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure gets the Project settings information from the database.
        ' Description          : The UseActivities and ApplyEffortDistribution flags are used while assigning the
        '                        Tasks to the resources and while distributing the work hours between them.
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Bharat T.
        ' Created              : 14th-Dec-2016        
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectSettings As IDataReader
        Dim blnUseActivities As Boolean = False
        Dim blnApplyEffortDistribution As Boolean = False
        Dim sbTasksHTML As New StringBuilder("")
        Dim strQuery2 As String = ""
        Dim drWork As IDataReader
        Dim strTemp As String = ""
        ' Changed select to SP 
        strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & strProjectID.ToString()

        drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drProjectSettings.Read() Then
            blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_lngProjectLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("LocationID"), "0"), Long)
            m_strProjectStartDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedStartDate"), "").ToString()
            m_strProjectEndDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedEndDate"), "").ToString()
            If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
            If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
            m_HaveSubTaskTypes = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            m_ApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_bitResourceValidation = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ResourceValidation"), "False"), Short)
            ' True is treated as -1 
            If m_bitResourceValidation = -1 Then
                m_bitResourceValidation = 1
            End If
            m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Billable"), "False"), Boolean)
            m_blnProjectActive = Not (CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Over"), "False"), Boolean))
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectSettings)

        'Depending upon the Project Level Settings and the Page Called from set the value
        If blnApplyEffortDistribution = False And blnUseActivities = False Then
            m_strProjectSetting = PROJECT_SETTING_NORMAL
        ElseIf blnUseActivities = True Then
            m_strProjectSetting = PROJECT_SETTING_ACTIVITY
        ElseIf blnApplyEffortDistribution = True Then
            m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION
        End If

        m_strHolidays = ""
        strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                strTemp = drWork.Item("HolidayDate").ToString()
                If strTemp <> "" Then
                    m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        If strFlag = "Hidden" Then
            sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectStartDate", "hdnProjectStartDate", , , , CDate(m_strProjectStartDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
            sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectEndDate", "hdnProjectEndDate", , , , CDate(m_strProjectEndDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
            sbTasksHTML.Append("<input type=hidden id='hdnResourceValidation' name='hdnResourceValidation' value='" & m_bitResourceValidation & "' />")
            strQuery2 = "EXEC usp_Ng2_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",0"
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, , , , True, True, , , , True))
            strQuery2 = "EXEC usp_Ng2_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",1"
            sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, , , , True, True, , , , True))


            sbTasksHTML.Append("<input type=hidden id='hdnHolidays' name='hdnHolidays' value='" & m_strHolidays & "' />")
            sbTasksHTML.Append("<input type=hidden id='hdnApplyEffortDistribution' name='hdnApplyEffortDistribution' value='" & m_ApplyEffortDistribution & "' />")
            sbTasksHTML.Append("<input type=hidden id='hdnHaveSubTaskTypes' name='hdnHaveSubTaskTypes' value='" & m_HaveSubTaskTypes & "' />")
            GetProjectSettingsDetails = sbTasksHTML.ToString
        End If

    End Function

    Public Function ValidateLeaves(ByVal lngTaskId As String, ByVal strCurrentStartDate As String, ByVal strCurrentEndDate As String, ByVal strEmployeeId As String) As String
        '====================================================================
        ' Procedure Name        : ValidateLeaves
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Validate Leaves for selected resource and dates 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Bharat T. 
        ' Created               : 19th-Dec-2016
        ' Revisions             :
        '=====================================================================
        Dim blnIsNewTask As Boolean
        Dim arrEmpId() As String
        Dim intCtr As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim dblTempWork As Double = 0
        Dim strEmployeeNames As String
        Dim strTempName As String
        'Dim strEmployeeId As String
        'Dim strCurrentStartDate As String
        'Dim strCurrentEndDate As String
        Dim strLeaveMessage As String
        'Dim lngTaskId As Long
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate
        Dim ProjectSettings As String = ""

        WebForm.InitializeResources("AppResources.PM_AssignTasks", "AppResources")
        'lngTaskId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("TaskId"), "0"), Long)

        If lngTaskId > 0 Then
            blnIsNewTask = False
        Else
            blnIsNewTask = True
        End If

        'strCurrentStartDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("FromDate"), "")
        'strCurrentEndDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ToDate"), "")
        'strEmployeeId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeIDs"), "")

        If blnIsNewTask = True Then
            arrEmpId = strEmployeeId.Split(CType(",", Char))
            intNumberOfEmployees = arrEmpId.Length()
            strEmployeeNames = ""
            For intCtr = 0 To intNumberOfEmployees - 1
                If arrEmpId(intCtr) <> "" Then
                    'Check if there is any leave(s) between the start date and end date
                    strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), strCurrentStartDate, strCurrentEndDate)
                    If strTempName <> "" Then strEmployeeNames &= strTempName + "<==>"
                End If
            Next
            strLeaveMessage = strEmployeeNames
        Else
            'Check if there is any leave(s) between the start date and end date
            strTempName = CheckLeaves(CType(strEmployeeId, Long), strCurrentStartDate, strCurrentEndDate)
            strLeaveMessage = strTempName
        End If

        Return strLeaveMessage

    End Function
    Public Function CheckLeaves(ByVal lngEmployeeID As Long, ByVal strStartDate As String, _
          ByVal strEndDate As String) As String
        '====================================================================
        ' Procedure Name       : CheckLeaves
        ' Parameters Passed    : EmployeeId - The Resources unique id
        '                       strStartDate - The Tasks Start date
        '                       strEndDate - The Tasks End date
        ' Returns              : The Name of the Employee if there is leave in between the start date and end date
        ' Parameters Affected  : None
        ' Purpose              : This function checks whether there is any leave in between the task start date 
        '                        and end date of the resource.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : Bharat T.
        ' Created              : 19th-nov-2016
        ' Revisions            : 
        '=====================================================================

        Dim strReturn As String = ""
        Dim strQuery As String = ""
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        Dim drLeave As IDataReader
        Dim strTemp As String = ""
        Dim strWFHDays As String = ""
        Dim strLeaveMessage As String = ""
        Dim strWFHMessage As String = ""
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate
        Dim strEmployeeName As String
        Dim strLeaveDays As String

        strQuery = "Exec usp_Sel_tbl_PM_EmployeeLeaveDetails_ForGivenDates " & lngEmployeeID.ToString()
        strQuery &= ", '" & strStartDate & "'"
        strQuery &= ", '" & strEndDate & "'"

        drLeave = CommonFunctions.Data.GetDataReader(strQuery, WebForm.UseSQL)
        While drLeave.Read
            strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName"), ""), "")
            If strEmployeeName <> "" Then
                strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveDays"), ""), "")
                strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("WFHDays"), ""), "")
                If strLeaveDays <> "" Then
                    strLeaveMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_LEAVES") + " " + strLeaveDays.Remove(0, 1) + " "
                End If
                If strWFHDays <> "" Then
                    strWFHMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_WFH") + " " + strWFHDays.Remove(0, 1)
                End If
                strTemp = strLeaveMessage + " <==> " + strWFHMessage
            End If
        End While
        CommonFunctions.Data.DisposeDataReader(drLeave)
        strReturn = strTemp
        'strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), "")
        Return strReturn

    End Function

    Public Function GetUserStoryDetails(ByVal UserStoryID As String, ByVal UserStoryID1 As String) As String
        Dim UserStoryResponseText As New StringBuilder
        UserStoryResponseText.Remove(0, UserStoryResponseText.Length) ''EMPTY STRING
        Dim strQuery As String
        Dim strProjectTypeID As String = "NULL"
        If UserStoryID = "" Then
            UserStoryID = "NULL"
        End If
        strQuery = "Exec Usp_Ng2_Sel_Scrum_UserStories 'UserStoryDetails'," + Session("IntProjectID").ToString + "," + UserStoryID + "," + strProjectTypeID + ""
        Dim drUSDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
        If (drUSDetails.HasRows) Then
            While (drUSDetails.Read())
                UserStoryResponseText.Append(drUSDetails(0).ToString())
                UserStoryResponseText.Append("#$$#")
                UserStoryResponseText.Append(drUSDetails(1).ToString())
                UserStoryResponseText.Append("#$$#")
                UserStoryResponseText.Append(drUSDetails(2).ToString())
                'Added By Bharat T on 7th-july-2017 for sprint cancellation changes
                UserStoryResponseText.Append("#$$#")
                UserStoryResponseText.Append(drUSDetails(3).ToString())
                'End of Added By Bharat T on 7th-july-2017 for sprint cancellation changes
            End While
        End If

        Return UserStoryResponseText.ToString

    End Function
#End Region


    Public Property EntityName() As String
        Get
            Return m_strEntityName
        End Get
        Set(ByVal Value As String)
            m_strEntityName = Value
        End Set
    End Property
    Public Property PrimaryKey() As String
        Get
            Return m_strPrimaryKey
        End Get
        Set(ByVal Value As String)
            m_strPrimaryKey = Value
        End Set
    End Property
    Public Property PrimaryKeyValue() As Long
        Get
            Return m_strPrimaryKeyID
        End Get
        Set(ByVal Value As Long)
            m_strPrimaryKeyID = Value
        End Set
    End Property
    Public Property TypeID() As String
        Get
            Return m_strCurrentType
        End Get
        Set(ByVal Value As String)
            m_strCurrentType = Value
        End Set
    End Property
    Public Property PrimaryTable() As String
        Get
            Return m_strPrimaryTable
        End Get
        Set(ByVal Value As String)
            m_strPrimaryTable = Value
        End Set
    End Property
    Public ReadOnly Property VariableDeclarationScript() As String
        Get
            Return declarevariables
        End Get
    End Property
    Public ReadOnly Property ValidationScript() As String
        Get
            Return strClientSideScript
        End Get
    End Property
    Public ReadOnly Property AccesibleCustomFields() As String
        Get
            Return m_strCustomFieldList
        End Get
    End Property
    Public ReadOnly Property DefaultValueScript() As String
        Get
            Return strDefaultScript
        End Get
    End Property
    Public Property FormName() As String
        Get
            Return m_strFormName
        End Get
        Set(ByVal Value As String)
            m_strFormName = Value
        End Set
    End Property
End Class
