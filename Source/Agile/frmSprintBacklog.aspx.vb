Public Class frmSprintBacklog
    Inherits WebPages.Template.WhizTemplate
    Public CurrentIterationID As String = ""
    Public projectID As String = ""
    Public globalPercentage As String = ""
    Protected m_strHolidays As String = ""
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
    Protected strIsPrductOwner As Integer
    Protected strAcceptanceCriteria As String = ""
    Protected strFixedVersion As String = ""
    Protected strFixedVersionColor As String = "#DDD"
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"
    Public SelectedReleaselistReleaseID As String = ""
    Protected m_strTaskIDList As String = ""
    Protected m_lngTaskId As Long = 0
    Private m_lngProjectId As Integer = 0
    Protected m_strEntity As String = ""
    Protected m_strPrimaryKey As String = ""
    Protected m_strUserName As String = ""
    Private m_strPhase As String = ""
    Private m_strModule As String = ""
    Private m_strSubProject As String = ""
    Private m_strMilestone As String = ""
    Protected m_strEmployeeId As String = ""
    'Protected m_strHolidays As String = ""
    Protected m_ChkDeliverable As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        projectID = Session("intProjectID")
        CurrentIterationID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select dbo.fn_NG2_Sel_CurrentIterationOrRelease (" & projectID & ",'ITERATION')", True), "0")
    End Sub
    Public Function PlotMainSection()
        '*******************************************************************************'
        ' Function Name	        :	PlotMainSection                                            '
        ' Purpose				:   Plotting  Header of Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'
        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row HeaderFreeze'>")
        strHTML.Append("<div class='col-md-4 clsDivHeader' style='color: #888888b8; font-weight: 500; font-size: 15px;margin-left: 34px;    margin-top: 3px;'>Sprint Backlog(Task Wise)  <p style='margin-top: 15px;'>Sprint Name : <span class='sprintname'></span></p></div>")
        strHTML.Append("<div class='col-md-8' style='float:right;margin-left:auto;margin-top:-8.5%'>")
        strHTML.Append("<div class='btn-group dropdown' id='div1' style='float: right; margin-right: 20px;margin-top:10px'>")

        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div data-bs-toggle='dropdown' style='cursor: pointer;' aria-expanded='false'><i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Filter' style='font-size: 16px!important' class='fa fa-ellipsis-v'></i></div>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle

        strHTML.Append("<div class='dropdown-menu' id='filter-dropdown' role='menu'>")
        'Filter Section
        strHTML.Append("<div id='tblAdvHeader'>")
        strHTML.Append("<div class='row' style='display:flow-root'>")
        strHTML.Append("<div class='col-sm-10'>")
        strHTML.Append("<p class='grey-text' style='float: left; margin-left: 2%!important'>Filters</p>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-2'>")
        strHTML.Append("<i class='fas fa-times' style='font-size: 14px!important; color: grey!important;margin-right:12px;float:right;' data-bs-toggle='tooltip' title='Close'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='dropdown-content'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-8'>")
        strHTML.Append("<p class='grey-text'>Task Assigned to Me")
        strHTML.Append("</p>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='switch'>")
        strHTML.Append("<input type='checkbox'  id='TaskAssigntome'>")
        strHTML.Append("<span class='slider round' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Assigned to Me'></span>")
        strHTML.Append("</label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<hr id='hr_line'>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<label for='defaultFormRegisterNameEx' class='grey-text'>By Sprint</label>")
        strHTML.Append("<div class='input-group'>")
        strHTML.Append("<span class='input-group-addon' style='background-color: #275482; border: 1px solid #275482; color: white;'><i class='fa fa-list' aria-hidden='true'></i></span>")
        Dim SQL As String = ""
        SQL = "usp_NG2_Sel_Product_FilterSprintRelease " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",Iteration"
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SprintBacklogSprint", SQL, , CurrentIterationID, "class='form-control' style='margin-left: 0px;' ", False, True))
        strHTML.Append("<input type='hidden' value='" & CurrentIterationID & "' id='hdnCurrentIterationID' />")
        strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("<br />")

        'Filter by Resource Section
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='col-md-12'>")
        'strHTML.Append("<label for='defaultFormRegisterNameEx' class='grey-text'>By Resource</label>")
        'strHTML.Append("<div class='input-group'>")
        'strHTML.Append("<span class='input-group-addon' style='background-color: #275482; border: 1px solid #275482; color: white;'><i class='fa fa-user' aria-hidden='true'></i></span>")

        'strHTML.Append("<div class='input-group open'>")
        'strHTML.Append("<input type='Textbox' name='txtAssignedTo' id='txtAssignedTo' class='form-control' style='text-align: Left; width: 255px;' value='' onkeyup='myFunction()' data-bs-toggle='dropdown'><ul id='emplistUL' class='dropdown-menu' role='menu' style='width: 250px;'>")
        'strHTML.Append("<li class='clsAssignedListItem dropdown-item' name='Aniruddh Gujar'><a href='#' id='504' name='Aniruddh Gujar' onclick='AssignToListClick(this)'>")
        'strHTML.Append("<img id='imgUser504' data-bs-toggle='tooltip' data-bs-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='image_kashish/profile.jpg' style='height: 30px; width: 30px;' src='../../Images/Photo/3783361b.jpg'>&nbsp;Aniruddh Gujar</a>")
        ' strHTML.Append("<li class='clsAssignedListItem dropdown-item' name='Aniruddh Gujar'><a href='#' id='504' name='Aniruddh Gujar' onclick='AssignToListClick(this)'>")
        'strHTML.Append("<img id='imgUser504' data-bs-toggle='tooltip' data-bs-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='image_kashish/profile.jpg' style='height: 30px; width: 30px;' src='../../Images/Photo/3783361b.jpg'>&nbsp;Aniruddh Gujar</a>")
        'strHTML.Append("</li>")
        'strHTML.Append("<li class='clsAssignedListItem dropdown-item' name='Aniruddh Gujar'><a href='#' id='504' name='Aniruddh Gujar' onclick='AssignToListClick(this)'>")
        'strHTML.Append("<img id='imgUser504' data-bs-toggle='tooltip' data-bs-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='image_kashish/profile.jpg' style='height: 30px; width: 30px;' src='../../Images/Photo/3783361b.jpg'>&nbsp;Aniruddh Gujar</a>")
        'strHTML.Append("</li>")
        'strHTML.Append(" </ul>")
        'strHTML.Append("<input type='hidden' id='hdnAssignToId' value=''>")
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("<br />")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-8'>")
        strHTML.Append("<button type='button' id='btnApply' class='btn btn-block btn-default' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Apply' onclick=Filter_onclickSprint(this)>Apply</button>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-md-4'>")
        strHTML.Append("<button type='button' id='btnClear' class='btn btn-block btn-default' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Clear' onclick=Clear_onclick(this)>Clear</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ' 'End of Filter Section

        'Legends section
        strHTML.Append("  <div class='btn-group dropdown'  id='divHeaderLeftSection'  style=' float:right;margin-right: 28px;' >")
        strHTML.Append("<div class='row' >")
        strHTML.Append("  <div class='col-sm-4' style='display:flex;'>")
        strHTML.Append("  <p class='col-sm-2'  style=' font-size: 13px; color: GREY;white-space: nowrap;width: 60.666667%!important;' ><label class='green_bar'  style=' width: 2px;height: 18px;background-color: #c73c14;margin-bottom: -4px!important;margin-left: -12px;border-radius: 9px;' ></label>&nbsp;Delayed </p>")
        strHTML.Append("    <p class='col-sm-2'  style=' font-size: 13px; color: grey;white-space: nowrap; width: 43.333333%!important;' ><label class=' green_bar'  style='    width:  2px;  height:  18px; background-color: orange;margin-bottom:  -4px!important; margin-left: -15px;  border-radius: 9px;' ></label>&nbsp;Issue </p>")
        strHTML.Append("<p class='col-sm-2'  style=' font-size: 13px; color: grey;white-space: nowrap;width:62.33%!important' ><label class=' green_bar'  style='    width:  2px;  height:  17px; background-color:#14c751;margin-bottom:  -4px!important; margin-left: -21px;  border-radius: 9px;' ></label>&nbsp;Completed </p>")
        strHTML.Append("  <p class='col-sm-2'  style=' font-size: 13px; color: grey;white-space: nowrap;width:52%!important;' ><label class=' green_bar'  style='    width:  2px;  height: 17px; background-color: blue;margin-bottom:  -4px!important; margin-left: -12px;  border-radius: 9px;' ></label>&nbsp;In Progress </p>")
        strHTML.Append("  <p class='col-sm-2'  style=' font-size: 13px; color: grey;white-space: nowrap;    width: 24%;!important' ><label class=' green_bar'  style='    width:  2px;  height: 17px; background-color: gray;margin-bottom:  -4px!important; margin-left: 8px;  border-radius: 9px;' ></label>&nbsp;Cancelled </p>")

        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        'End of Legends section
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        'Card Section
        strHTML.Append("<div id='Allcardsdata'>")
        strHTML.Append(CardSectionPlotting(CurrentIterationID, ""))
        strHTML.Append("</div>")

        Response.Write(strHTML.ToString())
    End Function

    Public Function CardSectionPlotting(Optional CurrentIterationID As String = "", Optional USID As String = "", Optional AssignFilterChecked As String = "", Optional SelectedDiv As String = "")
        '*******************************************************************************'
        ' Function Name	        :	CardSectionPlotting                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        If USID = "" Then
            USID = "null"
        Else
            USID = USID
        End If
        strHTML.Append("<div class='row'>")
        strHTML.Append("<section class='main'>")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12' style='display:flex;'>")
        strHTML.Append("<div class='col-lg-3 col-md-3 col-sm-12'>")
        strHTML.Append(CardUS(CurrentIterationID, USID, SelectedDiv))
        strHTML.Append("</div>")

        '<!--To Do List start-->
        strHTML.Append(Cardtodolist(CurrentIterationID, USID, AssignFilterChecked))
        '<!--To Do List Ends Here-->

        '<!--Progress List Here-->
        strHTML.Append(CardProgress(CurrentIterationID, USID, AssignFilterChecked))
        '<!--Completed List Start-->
        strHTML.Append(CardCompeleted(CurrentIterationID, USID, AssignFilterChecked))
        '<!--Completed List End Start-->
        '<!--Progress List Ends Here-->



        strHTML.Append("</div>")
        strHTML.Append("</section>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function


    Public Function CardUS(ByVal CurrentIterationID As String, ByVal UserStoryNewID As String, ByVal SelectedDiv As String)
        '*******************************************************************************'
        ' Function Name	        :	CardUS                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim StrQueryUS As String = ""
        Dim drUS As IDataReader
        StrQueryUS = "usp_NG2_sel_tbl_PM_ScrumIterationUserStories " & CurrentIterationID & ""
        drUS = CommonFunctions.Data.GetDataReader(StrQueryUS, True)
        Dim UserStoryID As String = ""
        Dim UserStoryName As String = ""
        Dim TaskID As String = ""
        Dim AssignedTo As String = ""
        Dim CurrentStage As String = ""
        Dim EndDate As String = ""
        Dim StoryPoints As String = ""
        Dim SystemFileName As String = ""
        Dim PlannedEffort As String = ""
        Dim ActualEffort As String = ""
        Dim IsCancelledStory As String = ""
        Dim IscheckData As String = "0"
        Dim Color As String = ""
        strHTML.Append("<div class='scrum-grid'>")

        strHTML.Append("<div class='scrum-title  collapse fade in' id='DivUS'>")
        strHTML.Append("<i class='fa fa-th icon' aria-hidden='true' style='color: #b92e2e;'></i>")
        strHTML.Append("<div>")
        strHTML.Append("<p class='drag-text'><i class='fa fa-mouse-pointer' aria-hidden='true'></i>&nbsp;Click to get the task list</p>")
        strHTML.Append("<form>")
        strHTML.Append("<input type='search' name='search' placeholder='search...' id='userstories'/>")
        strHTML.Append(" </form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='scrum-content'>")
        strHTML.Append("<div class='scrum-header' style='background-color:#b92e2e!important; width: 100px; cursor: pointer;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='click to hide' id='UStooltip'>")
        strHTML.Append("<center><p style='white-space:nowrap;'  data-bs-toggle='collapse' data-bs-target='.collapse' onclick=""ExpandCollapse('DivUS','UStooltip')"" >User Stories</p></center>")
        strHTML.Append("</div>")
        strHTML.Append("<h5></h5>")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='scrum-stories scroller'>")
        '<!--To Do list Drag Drop Card strat-->
        While drUS.Read
            IscheckData = "1"
            UserStoryID = CommonFunctions.Data.CheckIsDBNull(drUS("UserStoryID"), "")
            UserStoryName = CommonFunctions.Data.CheckIsDBNull(drUS("UserStoryName"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drUS("EndDate"), "")
            PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drUS("PlannedEffort"), "")
            StoryPoints = CommonFunctions.Data.CheckIsDBNull(drUS("StoryPoint"), "")
            ActualEffort = CommonFunctions.Data.CheckIsDBNull(drUS("ActualEffort"), "")
            Color = CommonFunctions.Data.CheckIsDBNull(drUS("Color"), "")
            If PlannedEffort = "" Then
                PlannedEffort = "0"
            End If
            If ActualEffort = "" Then
                ActualEffort = "0"
            End If
            If StoryPoints = "" Then
                StoryPoints = "0"
            End If

            If UserStoryName = "" Then
                UserStoryName = "Not Specified"
            End If
            If EndDate = "" Then
                EndDate = "Not Specified"
            End If

            If SelectedDiv = "SelectUS" & UserStoryID & "" Then
                strHTML.Append("<div class='scrum-stories User-Story'  id='clsdivus'>")
            Else
                strHTML.Append("<div class='scrum-stories User-Story'  style='border-left:2px solid " & Color & "!important' id='clsdivus'>")
            End If
            'strHTML.Append("<div id='todolist' class='divDraggable'>")
            If SelectedDiv = "SelectUS" & UserStoryID & "" Then
                strHTML.Append("<div class='scrum-stories-list' onclick='filterTask_US(this," & UserStoryID & ")' id='SelectUS" & UserStoryID & "' style='box-shadow:0 2px 4px 0 #575757, 0 0px 6px 0 " & Color & "!important;transform:translateY(-3px)'>")
            Else
                strHTML.Append("<div class='scrum-stories-list' onclick='filterTask_US(this," & UserStoryID & ")' id='SelectUS" & UserStoryID & ">")
            End If
            strHTML.Append("<p style='word-wrap:break-word'><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='User Story Name' style='word-wrap:break-word'>" & UserStoryName & "</span></p>") '<i class='fa fa-filter'  aria-hidden='true' ></i>
            strHTML.Append("<p>")
            strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned End Date'>" & EndDate & "</span> &nbsp")
            strHTML.Append("<span class='' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned Hrs Vs  Actual Hrs '>" & PlannedEffort & "/" & ActualEffort & "</span>")
            'Commented & added By Dipali v On 26th jun 2020 for Issue Id 25273
            'strHTML.Append("<label class='float-end label label-success' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Story Point'>" & StoryPoints & "</label>") '
            strHTML.Append("<label class='float-end label label-success' data-bs-toggle='tooltip' data-bs-placement='bottom' title='User Story Story Point'>" & StoryPoints & "</label>") '
            'End of Commented & added By Dipali v On 26th jun 2020 for Issue Id 25273
            strHTML.Append("</p>")
            strHTML.Append("<input type='hidden' value='" & UserStoryID & "' id='hdnUserStoryID' />")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


        End While
        'strHTML.Append("</div>")
        If IscheckData <> "1" Then
            'strHTML.Append("<div class='scrum-stories'>")
            strHTML.Append("<div class='scrum-stories-list User-Story'>")
            strHTML.Append("<p class='nodrop'>")
            strHTML.Append("There are no items to show in this view ")
            strHTML.Append("  </p>")
            strHTML.Append("</div>")
            'strHTML.Append("</div>")
        End If
        strHTML.Append("<input type='hidden' value='" & IscheckData & "' id='hdncheckData' />")
        strHTML.Append("</div>")
        ' strHTML.Append("</div>")
        '<!--To Do list drag Dop Ends Here-->
        'strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Public Function Cardtodolist(ByVal CurrentIterationID As String, ByVal UserStoryID As String, ByVal UserID As String)
        '*******************************************************************************'
        ' Function Name	        :	Cardtodolist                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim drTask As IDataReader
        Dim ToDolistdrPercentage As IDataReader

        Dim strQuery As String = ""
        Dim TaskID As String = ""
        Dim IscheckData As String = "0"
        Dim ScrumTaskName As String = ""
        Dim ScrumTaskDescription As String = ""

        Dim AssignedTo As String = ""
        Dim CurrentStage As String = ""
        Dim EndDate As String = ""
        Dim StoryPoints As String = ""
        Dim SystemFileName As String = ""
        Dim Effort As String = ""
        Dim Actual As String = ""
        Dim IsCancelledStory As String = ""
        Dim Percentage As String = ""
        Dim Flags As Integer = 0
        Dim color As String = ""
        Dim EmployeeName As String = ""
        Dim IsSprintCompleted As String = ""
        If UserStoryID = "" Then
            UserStoryID = "Null"
        End If
        Dim UserStoryIDnew As String = ""
        If UserID = "1" Then
            UserID = Session("IntUserID")
        Else
            UserID = "Null"

        End If
        strQuery = "usp_NG2_sel_tbl_PM_ScrumIterationTasks " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'DoList'"
        drTask = CommonFunctions.Data.GetDataReader(strQuery, True)
        'While drTask.Read
        '    Percentage = CommonFunctions.Data.CheckIsDBNull(drTask("Percentage"), "")
        'End While
        strHTML.Append("<div class='col-lg-3 col-md-3 col-sm-12'>")
        strHTML.Append("<div class='scrum-grid' id='sidebarnew'>")
        strHTML.Append("<div class='scrum-title  collapse fade in' id='DivTodolist'>")
        'strHTML.Append("<i class='fa fa-sign-in' style='line-height: 18px; font-size: 2.5em;' aria-hidden='true' id='toggle'></i>")
        strHTML.Append("<i class='fa fa-list-ol icon' aria-hidden='true'></i>")
        strHTML.Append("<div>")
        strHTML.Append("<p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag task between list</p>")
        strHTML.Append(" <form>")
        strHTML.Append("<input type='search' name='search' placeholder='search...'  id='Tasktodolist'/>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='scrum-content'>")
        strHTML.Append("<div class='scrum-header' style='background-color:#00C6D7!important; width: 100px; cursor: pointer;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='click to hide'  id='TODOtooltip'>")
        strHTML.Append("<center><p  data-bs-toggle='collapse' data-bs-target='.collapse' style='color:white!important' onclick=""ExpandCollapse('DivTodolist','TODOtooltip')"">To-Do List</p></center>")
        strHTML.Append(" </div>")
        'If Percentage = "" Then
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        'Else
        'Dim ToDolistPercentage As String = CommonFunctions.Data.GetDataScalar("usp_NG2_GetPercentageForTaskStages " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'DoList'", True)
        'If ToDolistPercentage = "" Then
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        'Else
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>" & ToDolistPercentage & "%</h5>")
        'End If

        Dim ToDolistPercentage As String = ""
        ToDolistdrPercentage = CommonFunctions.Data.GetDataReader("usp_NG2_GetPercentageForTaskStages " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'DoList'", True)
        While ToDolistdrPercentage.Read
            ToDolistPercentage = CommonFunctions.Data.CheckIsDBNull(ToDolistdrPercentage("Percentage"), "")
        End While

        If ToDolistPercentage = "" Then
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        Else
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>" & ToDolistPercentage & "%</h5>")
        End If

        'End If
        strHTML.Append("</div>")
        strHTML.Append("<div id='todolist' class='divDraggable scroller'>")
        While drTask.Read

            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(drTask("ScrumTaskName"), "")
            ScrumTaskDescription = CommonFunctions.Data.CheckIsDBNull(drTask("ScrumTaskDescription"), "")
            TaskID = CommonFunctions.Data.CheckIsDBNull(drTask("TaskID"), "")
            AssignedTo = CommonFunctions.Data.CheckIsDBNull(drTask("AssignedTo"), "")
            CurrentStage = CommonFunctions.Data.CheckIsDBNull(drTask("CurrentStage"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drTask("EndDate"), "")
            StoryPoints = CommonFunctions.Data.CheckIsDBNull(drTask("StoryPoints"), "")
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drTask("SystemFileName"), "")
            Effort = CommonFunctions.Data.CheckIsDBNull(drTask("Effort"), "")
            Actual = CommonFunctions.Data.CheckIsDBNull(drTask("Actual"), "")
            IsCancelledStory = CommonFunctions.Data.CheckIsDBNull(drTask("IsCancelledStory"), "")
            color = CommonFunctions.Data.CheckIsDBNull(drTask("Color"), "")
            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drTask("EmployeeName"), "")
            UserStoryIDnew = CommonFunctions.Data.CheckIsDBNull(drTask("UserStoryID"), "")
            IsSprintCompleted = CommonFunctions.Data.CheckIsDBNull(drTask("IsSprintCompleted"), "")
            If ScrumTaskName = "" Then
                IscheckData = "0"
            Else

                IscheckData = "1"
                If Actual = "" Then
                    Actual = "0.00"
                End If
                If Effort = "" Then
                    Effort = "0.00"
                End If
                If StoryPoints = "" Then
                    StoryPoints = "0"
                End If
                If SystemFileName = "" Then
                    SystemFileName = "no-photo.png"
                End If
                '<!--To Do list Drag Drop Card strat-->

                If IsSprintCompleted = "1" Then
                    strHTML.Append("<div class='scrum-stories todolist'  id='clsdivtodolist' draggable='false' id='sortable_" & TaskID & "'>")
                Else
                    strHTML.Append("<div class='scrum-stories todolist'  id='clsdivtodolist' draggable='true' id='sortable_" & TaskID & "'>")
                End If

                strHTML.Append("<div class='scrum-stories-list todolistheight' style='border-left:2px solid " & color & "'>") 'to-do-list
                If ScrumTaskName = "" Then
                    strHTML.Append("<p data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Name'>Not Specified</p>")
                Else
                    strHTML.Append("<p style='word-wrap:break-word;width: 95%;'><span class='taskname'  title='Task Name' onclick=""taskpopup('" & TaskID & "'," & UserStoryIDnew & ",'TODOLIST')"" data-bs-toggle='modal' >" & ScrumTaskName & "</span></p>")
                End If
                strHTML.Append(" <p>")
                strHTML.Append("<i class='fas fa-arrows-alt drag-drop-popup 'aria-hidden='true' onclick=Open_DragPopUp('" & TaskID & "','ToDOList')  title='Drag & Drop' data-bs-toggle='tooltip' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-placement='bottom'  style=''></i>")
                If EndDate = "" Then
                    strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned End Date'>Not Specified</span>&nbsp;")
                Else
                    strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned End Date'>" & EndDate & " </span>&nbsp;")
                End If
                strHTML.Append("&nbsp;<span class='' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned Hrs  Vs Actual Hrs'>&nbsp;" & Effort & "/" & Actual & " &nbsp;</span>")
                strHTML.Append("<span style='color: #2196F3;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Story Point'>" & StoryPoints & "</span>")
                strHTML.Append("<span class='task-high' style='float: right;'>")
                ' strHTML.Append("<img src='../../Images/Photo/" & SystemFileName & "' style='width: 20px;' class='img-circle avatar' alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name'></span>")
                ' strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name' />")
                If EmployeeName = "" Then
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Not Assigned' />")
                Else
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & EmployeeName & "' />")

                End If

                strHTML.Append(" </p>")
                strHTML.Append("</div>")
                strHTML.Append("<input type='hidden' value='" & TaskID & "' id='todolisthdnTaskID' />")
                strHTML.Append("</div>")
                'strHTML.Append("</div>")
            End If


        End While

        If IscheckData <> "1" Then
            strHTML.Append("<div class='clsremovedrag todolist' >")
            strHTML.Append("<div class='to-do-list' style='height:80px'>")
            strHTML.Append("  <p class='nodrop'>")
            strHTML.Append("There are no items to show in this view ")
            strHTML.Append("  </p>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        '<!--To Do list drag Dop Ends Here-->
        strHTML.Append("<input type='hidden' value='" & IscheckData & "' id='hdncheckDataTodolist' />")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function
    'Public Function CardProgress()
    '    '*******************************************************************************'
    '    ' Function Name	        :	CardProgress                                            '
    '    ' Purpose				:   Plotting Page                            '
    '    ' Parameters Passed     :   None                                                '
    '    ' Returns               :                                                       '
    '    ' Author                :   Dipali Vekhande    
    '    'Date                   :   14nd April 2018
    '    '*******************************************************************************'
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div class='col-lg-3 col-md-3 col-sm-12'>")
    '    strHTML.Append("<div class='scrum-grid' id='sidebarnew'>")
    '    strHTML.Append("<div class='scrum-title collapse fade in'>")
    '    strHTML.Append("<i class='fa fa-sign-in' style='line-height: 18px; font-size: 2.5em;' aria-hidden='true' id='toggle'></i>")
    '    strHTML.Append("<i class='fa fa-spinner icon' aria-hidden='true'></i>")
    '    strHTML.Append("<div>")
    '    strHTML.Append("<p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag task between list</p>")
    '    strHTML.Append("<form>")
    '    strHTML.Append("<input type='search' name='search' placeholder='search...' />")
    '    strHTML.Append(" </form>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='scrum-content'>")
    '    strHTML.Append("<div class='scrum-header task-progress' style='cursor: pointer;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='click to collapse'>")
    '    strHTML.Append("<center><p data-bs-toggle='collapse' data-bs-target='.collapse'>Progress</p></center>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>30%</h5>")
    '    strHTML.Append("</div>")
    '    '<!--Progress list Drag Drop Card strat-->
    '    strHTML.Append("<div id='progresslist' class='divDraggable'>")
    '    strHTML.Append(" <div class='scrum-stories'>")
    '    strHTML.Append("<div class='scrum-stories-list progress-list'>")
    '    strHTML.Append("<p data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Name'>App doesn't work on IE10</p>")
    '    strHTML.Append(" <p>")
    '    strHTML.Append(" <i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='End Date'>15/01/2018 </span>")
    '    strHTML.Append("<span class='task-high' style='float: right;'>")
    '    strHTML.Append(" <img src='http://bootdey.com/img/Content/user_1.jpg' style='width: 20px;' class='img-circle avatar' alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name'></span>")
    '    strHTML.Append("</p>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")

    '      strHTML.Append(" <div class='scrum-stories'>")
    '    strHTML.Append("<div class='scrum-stories-list progress-list'>")
    '    strHTML.Append("<p data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Name'>App doesn't work on IE10</p>")
    '    strHTML.Append(" <p>")
    '    strHTML.Append(" <i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='End Date'>15/01/2018 </span>")
    '    strHTML.Append("<span class='task-high' style='float: right;'>")
    '    strHTML.Append(" <img src='http://bootdey.com/img/Content/user_1.jpg' style='width: 20px;' class='img-circle avatar' alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name'></span>")
    '    strHTML.Append("</p>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append("<div id='drop'></div>")
    '       strHTML.Append(" <div class='scrum-stories'>")
    '    strHTML.Append("<div class='scrum-stories-list progress-list'>")
    '    strHTML.Append("<p data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Name'>App doesn't work on IE10</p>")
    '    strHTML.Append(" <p>")
    '    strHTML.Append(" <i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='End Date'>15/01/2018 </span>")
    '    strHTML.Append("<span class='task-high' style='float: right;'>")
    '    strHTML.Append(" <img src='http://bootdey.com/img/Content/user_1.jpg' style='width: 20px;' class='img-circle avatar' alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name'></span>")
    '    strHTML.Append("</p>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    Return strHTML.ToString
    'End Function
    Public Function CardProgress(ByVal CurrentIterationID As String, ByVal UserStoryID As String, ByVal UserID As String)
        '*******************************************************************************'
        ' Function Name	        :	CardProgress                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim ScrumTaskName As String = ""
        Dim ScrumTaskDescription As String = ""
        Dim TaskID As String = ""
        Dim AssignedTo As String = ""
        Dim CurrentStage As String = ""
        Dim EndDate As String = ""
        Dim StoryPoints As String = ""
        Dim SystemFileName As String = ""
        Dim Effort As String = ""
        Dim Actual As String = ""
        Dim IsCancelledStory As String = ""
        Dim Percentage As String = ""
        Dim Flags As Integer = 0
        Dim EmployeeName As String = ""
        Dim IsSprintCompleted As String = ""
        Dim color As String = ""
        If UserStoryID = "" Then
            UserStoryID = "Null"
        End If
        If UserID = "1" Then
            UserID = Session("IntUserID")
        Else
            UserID = "Null"

        End If
        Dim IscheckData As String = "0"
        Dim drTaskinporgress As IDataReader
        Dim drPercentage As IDataReader
        Dim strQuery As String = ""
        strQuery = "usp_NG2_sel_tbl_PM_ScrumIterationTasks " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'InProgress'"
        drTaskinporgress = CommonFunctions.Data.GetDataReader(strQuery, True)
        'While drTaskinporgress.Read
        '    Percentage = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("Percentage"), "")
        'End While
        strHTML.Append("<div class='col-lg-3 col-md-3 col-sm-12'>")
        strHTML.Append("<div class='scrum-grid' id='sidebarnew'>")

        strHTML.Append("<div class='scrum-title collapse fade in' id='DivInprogress'>")
        ' strHTML.Append("<i class='fa fa-sign-in' style='line-height: 18px; font-size: 2.5em;' aria-hidden='true' id='toggle'></i>")
        strHTML.Append("<i class='fa fa-spinner icon' aria-hidden='true'></i>")
        strHTML.Append("<div>")
        strHTML.Append("<p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag task between list</p>")
        strHTML.Append("<form>")
        strHTML.Append("<input type='search' name='search' placeholder='search...' id='mytaskprogress'/>")
        strHTML.Append(" </form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='scrum-content'>")
        strHTML.Append("<div class='scrum-header task-progress' style='cursor: pointer;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='click to hide' id='Inprogresstooltip'>")
        strHTML.Append("<center><p data-bs-toggle='collapse' data-bs-target='.collapse'  onclick=""ExpandCollapse('DivInprogress','Inprogresstooltip')"">In Progress</p></center>")
        strHTML.Append("</div>")
        'If Percentage = "" Then
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        'Else
        Dim InProgressPercentage As String = ""
        drPercentage = CommonFunctions.Data.GetDataReader("usp_NG2_GetPercentageForTaskStages " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'InProgress'", True)
        While drPercentage.Read
            InProgressPercentage = CommonFunctions.Data.CheckIsDBNull(drPercentage("Percentage"), "")
        End While

        If InProgressPercentage = "" Then
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        Else
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>" & InProgressPercentage & "%</h5>")
        End If

        ' End If
        Dim UserStoryIDInprogressnew As String = ""
        strHTML.Append("</div>")
        '<!--Progress list Drag Drop Card strat-->
        strHTML.Append("<div id='progresslist' class='divDraggable scroller'>")
        While drTaskinporgress.Read
            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("ScrumTaskName"), "")
            ScrumTaskDescription = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("ScrumTaskDescription"), "")
            TaskID = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("TaskID"), "")
            AssignedTo = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("AssignedTo"), "")
            CurrentStage = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("CurrentStage"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("EndDate"), "")
            StoryPoints = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("StoryPoints"), "")
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("SystemFileName"), "")
            Effort = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("Effort"), "")
            Actual = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("Actual"), "")
            IsCancelledStory = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("IsCancelledStory"), "")
            color = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("Color"), "")
            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("EmployeeName"), "")
            UserStoryIDInprogressnew = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("UserStoryID"), "")
            IsSprintCompleted = CommonFunctions.Data.CheckIsDBNull(drTaskinporgress("IsSprintCompleted"), "")

            If ScrumTaskName = "" Then
                IscheckData = "0"
            Else
                IscheckData = "1"
                If Actual = "" Then
                    Actual = "0.00"
                End If
                If Effort = "" Then
                    Effort = "0.00"
                End If
                If StoryPoints = "" Then
                    StoryPoints = "0"
                End If
                If SystemFileName = "" Then
                    SystemFileName = "no-photo.png"
                End If

                strHTML.Append("<input type='hidden' value='" & TaskID & "' id='hdnTaskID' />")

                If IsSprintCompleted = "1" Then
                    strHTML.Append(" <div class='scrum-stories progresslist ' id='clsdivprogresslist' draggable='false' id='sortable_" & TaskID & "'>")
                Else
                    strHTML.Append(" <div class='scrum-stories progresslist ' id='clsdivprogresslist' draggable='true' id='sortable_" & TaskID & "'>")
                End If

                strHTML.Append("<div class='scrum-stories-list progresslistheight' style='border-left:2px solid " & color & "' >") 'progress-list
                strHTML.Append("<p  style='word-wrap:break-word;width: 95%;'><span class='taskname'  title='Task Name'onclick=""taskpopup('" & TaskID & "'," & UserStoryIDInprogressnew & ",'Inprogress')"" data-bs-toggle='modal'>" & ScrumTaskName & "</span></p>")
                strHTML.Append(" <p>")
                strHTML.Append("<i class='fas fa-arrows-alt drag-drop-popup 'aria-hidden='true' onclick=Open_DragPopUp('" & TaskID & "','InProgress')  title='Drag & Drop' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-toggle='tooltip' data-bs-placement='bottom' style=''></i>")

                strHTML.Append(" <i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned End Date'>" & EndDate & "</span>&nbsp;&nbsp;")
                strHTML.Append("&nbsp;<span class='' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned Hrs  Vs Actual Hrs'>&nbsp;" & Effort & "/" & Actual & " &nbsp;</span>")
                strHTML.Append("<span style='color: #2196F3;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Story Point'>" & StoryPoints & "</span>")
                strHTML.Append("<span class='task-high' style='float: right;'>")
                'strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Name' />")
                If EmployeeName = "" Then
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Not Assigned' />")
                Else
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & EmployeeName & "' />")

                End If
                strHTML.Append("</p>")
                strHTML.Append("<input type='hidden' value='" & TaskID & "' id='todolisthdnTaskID' />")
                strHTML.Append(" </div>")
                strHTML.Append(" </div>")

            End If
        End While

        If IscheckData <> "1" Then
            strHTML.Append("<div class='progresslist  clsremovedrag'  style='height:80px'>")
            strHTML.Append("<div class=' progress-list'>")
            strHTML.Append("  <p class='nodrop'>")
            strHTML.Append("There are no items to show in this view ")
            strHTML.Append("  </p>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        strHTML.Append("<input type='hidden' value='" & IscheckData & "' id='hdncheckDataInprogress' />")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        'strHTML.Append(" </div>")
        Return strHTML.ToString

    End Function
    Public Function CardCompeleted(ByVal CurrentIterationID As String, ByVal UserStoryID As String, ByVal UserID As String)
        '*******************************************************************************'
        ' Function Name	        :	CardProgress                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   14nd April 2018
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim ScrumTaskName As String = ""
        Dim ScrumTaskDescription As String = ""
        Dim TaskID As String = ""
        Dim AssignedTo As String = ""
        Dim CurrentStage As String = ""
        Dim EndDate As String = ""
        Dim StoryPoints As String = ""
        Dim SystemFileName As String = ""
        Dim Effort As String = ""
        Dim Actual As String = ""
        Dim IsCancelledStory As String = ""
        Dim Percentage As String = ""
        Dim Flags As Integer = 0
        Dim TaskID1 As String = ""
        Dim color As String = ""
        Dim EmployeeName As String = ""
        Dim IsSprintCompleted As String = ""
        If UserStoryID = "" Then
            UserStoryID = "Null"
        End If
        If UserID = "1" Then
            UserID = Session("IntUserID")
        Else
            UserID = "Null"

        End If

        Dim drTaskCompleted As IDataReader
        Dim drCompltetedPercentage As IDataReader

        Dim strQuery As String = ""
        Dim IscheckData As String = "0"
        Dim UserStoryIDComp As String = ""

        strQuery = "usp_NG2_sel_tbl_PM_ScrumIterationTasks " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'Complete'"
        drTaskCompleted = CommonFunctions.Data.GetDataReader(strQuery, True)
        'While drTaskCompleted.Read
        '    Percentage = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Percentage"), "")
        'End While

        strHTML.Append("<div class='col-lg-3 col-md-3 col-sm-12'>")
        strHTML.Append("<div class='scrum-grid'>")
        strHTML.Append("<div class='scrum-title collapse fade in' id='DivCompleted'>")
        ' strHTML.Append("<i class='fa fa-sign-in' style='line-height: 18px; font-size: 2.5em;' aria-hidden='true' id='toggle'></i>")
        strHTML.Append("<i class='far fa-check-square icon' aria-hidden='true'></i>")
        strHTML.Append("<div>")
        strHTML.Append(" <p class='drag-text'><i class='far fa-hand-point-up drag-handler' aria-hidden='true'></i>Drag task between list</p>")
        strHTML.Append(" <form>")
        strHTML.Append(" <input type='search' name='search' placeholder='search...' id='completedtask' />")
        strHTML.Append(" </form>")
        strHTML.Append("</div>")
        strHTML.Append("  </div>")
        strHTML.Append("<div class='scrum-content'>")
        strHTML.Append(" <div class='scrum-header task-completed' style='cursor: pointer;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='click to hide' id='Completedtooltip'>")
        strHTML.Append("<center><p data-bs-toggle='collapse' data-bs-target='.collapse' onclick=""ExpandCollapse('DivCompleted','Completedtooltip')"">Completed</p></center>")
        strHTML.Append("   </div>")
        'If CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Percentage"), "") = "" Then
        'Dim CompeltedPercentage As String = CommonFunctions.Data.GetDataScalar("usp_NG2_GetPercentageForTaskStages " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'InProgress'", True)
        'If CompeltedPercentage = "" Then
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        'Else
        '    strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>" & CompeltedPercentage & "%</h5>")
        'End If
        Dim CompeltedPercentage As String = ""
        drCompltetedPercentage = CommonFunctions.Data.GetDataReader("usp_NG2_GetPercentageForTaskStages " & CurrentIterationID & "," & UserID & "," & UserStoryID & ",'Complete'", True)
        While drCompltetedPercentage.Read
            CompeltedPercentage = CommonFunctions.Data.CheckIsDBNull(drCompltetedPercentage("Percentage"), "")
        End While

        If CompeltedPercentage = "" Then
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>0%</h5>")
        Else
            strHTML.Append("<h5 data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task completion percentage'>" & CompeltedPercentage & "%</h5>")
        End If
        strHTML.Append(" </div>")
        '<!--Progress list Drag Drop Card strat-->

        strHTML.Append("<div id='completedlist' class='divDraggable'>")
        While drTaskCompleted.Read
            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("ScrumTaskName"), "")
            ScrumTaskDescription = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("ScrumTaskDescription"), "")
            TaskID1 = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("TaskID"), "")
            AssignedTo = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("AssignedTo"), "")
            CurrentStage = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("CurrentStage"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("EndDate"), "")
            StoryPoints = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("StoryPoints"), "")
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("SystemFileName"), "")
            Effort = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Effort"), "")
            Actual = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Actual"), "")
            IsCancelledStory = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("IsCancelledStory"), "")
            color = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Color"), "")
            Percentage = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("Percentage"), "")
            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("EmployeeName"), "")
            UserStoryIDComp = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("UserStoryID"), "")
            IsSprintCompleted = CommonFunctions.Data.CheckIsDBNull(drTaskCompleted("IsSprintCompleted"), "")
            If Actual = "" Then
                Actual = "0.00"
            End If
            If Effort = "" Then
                Effort = "0.00"
            End If
            If StoryPoints = "" Then
                StoryPoints = "0"
            End If
            If SystemFileName = "" Then
                SystemFileName = "no-photo.png"
            End If

            If ScrumTaskName = "" Then
                IscheckData = "0"
            Else
                IscheckData = "1"

                If IsSprintCompleted = "1" Then
                    strHTML.Append("<div class='scrum-stories ' id='clsdivcompletedlist' draggable='false' id='sortable_" & TaskID1 & "'>")
                Else
                    strHTML.Append("<div class='scrum-stories ' id='clsdivcompletedlist' draggable='true' id='sortable_" & TaskID1 & "'>")
                End If

                strHTML.Append("<div class='completed-list' style='border-left:2px solid " & color & "'>")
                strHTML.Append("<p class='taskname'  title='Task Name'onclick=""taskpopup('" & TaskID1 & "'," & UserStoryIDComp & ",'Completed')"" data-bs-toggle='modal'  style='word-wrap:break-word;width: 95%;'>" & ScrumTaskName & "</p>")
                strHTML.Append("  <p>")
                strHTML.Append("<i class='fas fa-arrows-alt drag-drop-popup 'aria-hidden='true' onclick=Open_DragPopUp('" & TaskID1 & "','Completed')  title='Drag & Drop' data-bs-toggle='tooltip' data-bs-placement='bottom' style=''></i>")
                strHTML.Append("<i class='far fa-clock drag-handler' aria-hidden='true'></i><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned End Date'>" & EndDate & "</span>&nbsp;&nbsp;")
                strHTML.Append("&nbsp;<span class='' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Planned Hrs  Vs Actual Hrs'>&nbsp;" & Effort & "/" & Actual & " &nbsp;</span>")
                strHTML.Append("<span style='color: #2196F3;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Task Story Point'>" & StoryPoints & "</span>")
                strHTML.Append(" <span class='task-high' style='float: right;'>")
                If EmployeeName = "" Then
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Resource Not Assigned' />")
                Else
                    strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & SystemFileName & "'  alt='user profile image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & EmployeeName & "' />")

                End If
                strHTML.Append("  </p>")
                strHTML.Append("</div>")
                strHTML.Append("<input type='hidden' value='" & TaskID1 & "' id='todolisthdnTaskID' />")
                strHTML.Append("</div>")

            End If

        End While

        If IscheckData <> "1" Then
            strHTML.Append("<div class='clsremovedrag'  style='height:80px'>")
            strHTML.Append("<div class='completed-list' style='border-left:1px solid white!important'>")
            strHTML.Append("<p class='nodrop'>")
            strHTML.Append("There are no items to show in this view ")
            strHTML.Append("  </p>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("<input type='hidden' value='" & IscheckData & "' id='hdncheckCompleted' />")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function TaskPopup(ByVal TaskID As String, ByVal UserStoryID As String) As String
        '*******************************************************************************'
        ' Function Name	        :	Cardtodolist                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   16nd April 2018
        '*******************************************************************************'
        Try

            Dim strHTML As New StringBuilder("")
            strHTML.Append("<Div class='' id='divtaskForm' >")
            strHTML.Append(" <div class=''>")
            Dim ObjAssignTask As New TaskDetail()
            strHTML.Append(ObjAssignTask.PlotAssignTaskFields(TaskID, HttpContext.Current.Session("IntProjectID"), UserStoryID, "AssignedTask", UserStoryID))
            strHTML.Append("</Div>")
            strHTML.Append("</div>")

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilterPage(ByVal SprintID As String, ByVal AssignFilterChecked As String) As String
        '*******************************************************************************'
        ' Function Name	        :	Cardtodolist                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   16nd April 2018
        '*******************************************************************************'
        Dim objfrmSprintBacklog As New frmSprintBacklog
        If AssignFilterChecked = "1" Then

        Else
            AssignFilterChecked = "0"
        End If
        Return objfrmSprintBacklog.CardSectionPlotting(SprintID, "", AssignFilterChecked)
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function FilterDataPerUS(ByVal SprintValue As String, ByVal UserStoryID As String, ByVal AssignFilterChecked As String, ByVal SelectedDiv As String) As String
        '*******************************************************************************'
        ' Function Name	        :	FilterDataPerUS                                            '
        ' Purpose				:   Plotting Page                            '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande    
        'Date                   :   16nd April 2018
        '*******************************************************************************'
        Dim objfrmSprintBacklog As New frmSprintBacklog
        If AssignFilterChecked = "1" Then

        Else
            AssignFilterChecked = "0"
        End If
        Return objfrmSprintBacklog.CardSectionPlotting(SprintValue, UserStoryID, AssignFilterChecked, SelectedDiv)
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateLogPersonAcessTask(ByVal StrTaskID As String) As String
        '=====================================================================
        ' Procedure  Name		:	ValidateLogPersonAccessUserStory
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   16-April-2018
        '=====================================================================
        Try

            Dim strQuery As String = ""

            Dim drGetValidation As IDataReader
            Dim strResult As String = ""

            strQuery = "usp_NG2_Sel_CheckTaskAssignedToEmployee '" & HttpContext.Current.Session("intUserID") & "'," & StrTaskID


            drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetValidation.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
            End While
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DropValidation(ByVal StrTaskID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DropValidation
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   16-April-2018
        '=====================================================================
        Try

            Dim strQuery As String = ""
            Dim strMessage As String = ""
            Dim drGetValidation As IDataReader
            Dim strResult As String = ""

            strQuery = "usp_NG2_chk_AllowScrumTaskToComplete " & StrTaskID


            drGetValidation = CommonFunctions.Data.GetDataReader(strQuery, True)
            If drGetValidation.Read Then
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetValidation("Result").ToString, "")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotDragDrop(ByVal TaskID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	PlotDragDrop
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	To plot drag drop page
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   27-MAR-2018
        '=====================================================================
        Try

            Dim strFlag As String
            Dim strHTML As New StringBuilder("")
            strHTML.Append("<form>")
            strHTML.Append("<div class='input-group stage-divide' data-bs-toggle='tooltip' title='Select stage to drop'>")
            strHTML.Append("<span class='input-group-addon stage-info'>")
            strHTML.Append("<i class='fa fa-list'></i>")
            strHTML.Append("</span>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Stages", "usp_NG2_Sel_TaskStages " & Flag, , , "class='form-control' ", True, True))
            strHTML.Append("</div>")
            'strHTML.Append("<div class='input-group stage-divide'>")
            ''strHTML.Append("<span class='input-group-addon  stage-info'>")
            ''strHTML.Append(" <i class='fa fa-dot-circle-o'></i>")
            ''strHTML.Append("</span>")
            ''strHTML.Append("<select class='form-control' name='storyPosition'>")
            ''strHTML.Append("<option>1</option>")
            ''strHTML.Append(" <option>2</option>")
            ''strHTML.Append("</select>")
            'strHTML.Append("</div>")
            strHTML.Append(" <div class='input-group col-md-12 col-sm-12 align-center'>")
            strHTML.Append(" <input type='button' id='submitbutton' class='btn btn-default submit-btn' name='setPosition' Onclick=""DragDrop_Onclick(" & TaskID & ",'" & Flag & "')"" value='Submit' title='Submit' data-bs-toggle='tooltip' data-bs-placement='bottom'>")
            strHTML.Append("</div>")
            strHTML.Append("</form>")

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateTaskDetails(ByVal StrTaskID As String, ByVal StageID As String, ByVal SprintID As String, ByVal AssignFilterChecked As String) As String
        '=====================================================================
        ' Procedure  Name		:	DropValidation
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    16-April-2018
        '=====================================================================
        Try

            Dim objfrmSprintBacklog As New frmSprintBacklog
            Dim strQuery As String = ""
            Dim strMessage As String = ""
            Dim drGetValidation As IDataReader
            Dim strResult As String = ""

            strQuery = "usp_NG2_upd_tbl_PM_ScrumTaskStage " & StrTaskID & "," & StageID
            Try
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                strResult = "1"
            Catch ex As Exception
                strResult = ""
            End Try

            ' Return strResult
            Return strResult & "|| " & objfrmSprintBacklog.CardSectionPlotting(SprintID, "", AssignFilterChecked)
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveTask(ByVal AssignTaskData As Object, ByVal UserStoryId As String, ByVal SprintID As String, ByVal flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Create a task
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   4th-April-2018
        '=====================================================================
        Try

            Dim objfrmSprintBacklog As New frmSprintBacklog()
            Dim strReturnHTML As New StringBuilder("")
            Dim strReturnHTMLnew As New StringBuilder("")
            Dim CurrentIterationIDnew As String = ""
            CurrentIterationIDnew = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select dbo.fn_NG2_Sel_CurrentIterationOrRelease (" & HttpContext.Current.Session("IntprojectID") & ",'ITERATION')", True), "0")
            strReturnHTML.Append(objfrmSprintBacklog.SaveTaskDetails(AssignTaskData))
            If flag = "1" Then
                strReturnHTMLnew.Append(objfrmSprintBacklog.CardSectionPlotting(SprintID, UserStoryId, "", ""))
            Else
                strReturnHTMLnew.Append(objfrmSprintBacklog.CardSectionPlotting(SprintID, "", "", ""))

            End If

            Return strReturnHTMLnew.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Public Function SaveTaskDetails(ByVal AssignTaskData As Object) As String

        Dim strProjectID As String = HttpContext.Current.Session("intprojectid").ToString

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
        Dim StoryPoints As String
        Dim Objtasknote As String
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
        Objtasknote = AssignTaskData(0)("Objtasknote")
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
            StoryPoints = AssignTaskData(0)("StoryPoints")
        Catch ex As Exception
            temp = 1
        End Try
        If StoryPoints = 0 Then
            StoryPoints = "null"
        End If
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
                    strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & EmployeeID & "," & TaskID.ToString()
                Else
                    ''     strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                    strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks " & TaskID.ToString()
                End If
                blnIsNewTask = False
            Else
                '  strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks NULL"
                strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL"
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

            strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(Objtasknote) & "'"
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

            'strSQL = "EXEC Usp_App_Sel_WBSNames " & PhaseVal & "," & ModuleVal & "," & SubProjectVal & "," & MilestoneVal
            'Dim drNames As IDataReader = CommonFunction.Data.GetDataReader(strSQL, True)

            'If drNames.Read Then
            '    m_strPhase = CommonFunction.Data.CheckIsDBNull(drNames("Phase"), "")
            '    m_strModule = CommonFunction.Data.CheckIsDBNull(drNames("Module"), "")
            '    m_strSubProject = CommonFunction.Data.CheckIsDBNull(drNames("Subproject"), "")
            '    m_strMilestone = CommonFunction.Data.CheckIsDBNull(drNames("Milestone"), "")
            'End If

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



            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", 1"
            Else
                strQuery_2 &= ", 0"
            End If


            If UserStoryID <> "" Or Not UserStoryID Is Nothing Then
                strQuery_2 &= ", " & UserStoryID
            Else
                strQuery_2 &= ", NULL"
            End If

            strQuery_2 &= ",NULL"

            strQuery_2 &= "," & StoryPoints
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
                    Dim intCtr As Integer = 0
                    For intCtr = 0 To intNumberOfEmployees - 1

                        m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

                        'Insert the Child Tasks for each employee
                        'strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
                        strQuery_1 &= ", " & arrEmpId(intCtr)
                        strQuery_1 &= ", NULL"
                        strQuery = strQuery_1 & strQuery_2
                        m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                    Next
                Else

                    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)

                End If
                Dim dr As IDataReader
                Dim blnShowPopup As Boolean
                Dim blnSendMail As Boolean
                Dim strFromEmailID As String
                Dim strToMailID As String
                Dim strCCToMailID As String
                Dim strSubject, strMessage As String
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 20", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)


                'If blnShowPopup Then
                '    With Response
                '        .Write("<script language=javascript>")
                '        'Dim strToken As String = CommonFunctions.Security.Token.GetToken("1003" & m_lngQueryID & strTempIsShowToCustomer & HttpContext.Current.Session("intUserid") & "0")

                '        .Write(" window.open (""../EmailSettings/CRMSendEmail.aspx?MessageID=20&DiscussionID=0 &QueryID=0&IsShowToCustomer=0&MultipleRequests=0&EmployeeIDList=" & HttpContext.Current.Session("intUserid").ToString & "&PkToken=0"", """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")

                '        .Write("</script>")
                '    End With
                'Else
                ' silent mail
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_strTaskIDList, CType(HttpContext.Current.Session("intProjectID"), String))
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                'End If
            End If
        End If

        Return ""


    End Function


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

        'If strFlag = "Hidden" Then
        '    sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectStartDate", "hdnProjectStartDate", , , , CDate(m_strProjectStartDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
        '    sbTasksHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnProjectEndDate", "hdnProjectEndDate", , , , CDate(m_strProjectEndDate).ToString("MM/dd/yyyy"), , , , , , True, , True, EnableHTMLEncode:=True))
        '    sbTasksHTML.Append("<input type=hidden id='hdnResourceValidation' name='hdnResourceValidation' value='" & m_bitResourceValidation & "' />")
        '    strQuery2 = "EXEC usp_App_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",0"
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, , , , True, True, , , , True))
        '    strQuery2 = "EXEC usp_App_Sel_CurrentTeamMembers_ExpectedDate  " & strProjectID.ToString() & ",1"
        '    sbTasksHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, , , , True, True, , , , True))


        '    sbTasksHTML.Append("<input type=hidden id='hdnHolidays' name='hdnHolidays' value='" & m_strHolidays & "' />")
        '    sbTasksHTML.Append("<input type=hidden id='hdnApplyEffortDistribution' name='hdnApplyEffortDistribution' value='" & m_ApplyEffortDistribution & "' />")
        '    sbTasksHTML.Append("<input type=hidden id='hdnHaveSubTaskTypes' name='hdnHaveSubTaskTypes' value='" & m_HaveSubTaskTypes & "' />")
        '    GetProjectSettingsDetails = sbTasksHTML.ToString
        'End If

    End Function
End Class
