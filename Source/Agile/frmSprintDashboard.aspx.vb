Imports System.IO
Public Class frmSprintDashboard
    Inherits WebPages.Template.WhizTemplate

    Protected m_strIterationID As String = ""
    Protected Shared m_lngReportID As Integer = 20234
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strsql As String = ""
        strsql = "SELECT dbo.fn_NG2_Sel_CurrentIterationOrRelease(" & HttpContext.Current.Session("IntProjectID") & ",'Iteration')"
        m_strIterationID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, True), "0")

        If CommonFunction.General.CheckIsNothing(Request.QueryString("IterationID")) <> "" Then
            m_strIterationID = CommonFunction.General.CheckIsNothing(Request.QueryString("IterationID"))
        End If

        If m_strIterationID = "" Then
            m_strIterationID = 0
        End If
    End Sub
    Protected Sub WritePage(ByVal IterationID As String)
        '=====================================================================
        ' Procedure Name        :	WritePage
        ' Purpose               :	Write The page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yasmin Shaikh
        ' Created               :	12-APR-2018
        ' Revisions             : strHTML.Append("")
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='container-fluid' >")

        strHTML.Append("<div class='row category-wise-graph' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-xs-12 col-sm-12 fixed-top' >")
        strHTML.Append("<div class='col-md-6 clsDivHeader' style='color: #292828; font-weight: 500; font-size: 16px;'>Sprint Dashboard</div>")
        strHTML.Append("<div class='' style='text-align:right;margin-left: auto;'>")
        strHTML.Append("<div class='btn-group dropdown'>")

        'added by ashwini on 21-3-2023 data-bs-toggle
        strHTML.Append("<button type='button'  class='btn btn-info' data-bs-toggle='dropdown' data-bs-placement='bottom' title='Export' data-bs-container='body'>Export&nbsp;<i class='fa fa-download'></i></button>")
        strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle

        strHTML.Append("<i class='fa fa-sort-down'></i>")
        strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu'>")
        'strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('Excel')>Excel</li>")
        'strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('PDF')>PDF</li>")
        strHTML.Append("<li onclick=Excel_OnClick('Excel')>Excel</li>")
        strHTML.Append("<li onclick=Excel_OnClick('PDF')>PDF</li>")
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Row start here
        strHTML.Append("<div class='row align-top' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-xs-12 col-sm-12' style='display:flex' >")

        strHTML.Append(DrawTopSection())

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Row ends here

        'Second row start here
        strHTML.Append(DrawCategoryGraph())
        'Second row ends here

        'Third row start here
        strHTML.Append(DrawDownSection())

        strHTML.Append(DrawIssueSection())

        strHTML.Append(DrawFooterSection())

        strHTML.Append("</div>")
        CommonFunction.General.WriteHTML(strHTML.ToString)
    End Sub
    Protected Function DrawTopSection()



        Dim strHTML As New StringBuilder("")

        Dim strIterationName As String = ""
        Dim strStartDate As String = ""
        Dim strEndDate As String = ""
        Dim strTotalStoryPoint As String = ""
        Dim strPlan As String = ""
        Dim strActual As String = ""
        Dim strNoOfDays As String = ""

        Dim strSQL As String
        Dim drSprint As New DataTable
        strSQL = "EXEC usp_NG2_Get_OverallIterationProgress " & m_strIterationID & "," & HttpContext.Current.Session("intUserID")
        drSprint = CommonFunctions.Data.GetDataTable(strSQL, True)

        If drSprint.Rows.Count > 0 Then
            strIterationName = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("IterationName"), "")
            strStartDate = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("StartDate"), "")
            strEndDate = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("EndDate"), "")
            strTotalStoryPoint = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("TotalStoryPoint"), "")
            strPlan = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("PlanEffort"), "")
            strActual = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("ActualEffort"), "")
            strNoOfDays = CommonFunction.General.CheckIsNothing(drSprint.Rows(0)("NoOfDays"), "0")
        End If
        'First column start here
        strHTML.Append("<div class='col-lg-6 col-md-6 col-sm-6 col-xs-12' >")
        'First row start here
        strHTML.Append("<div class='first-row' >")
        'Dropdown start here
        strHTML.Append("<div class='float-end dropdown'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div data-bs-toggle='dropdown'>")
        strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Select Sprint' style='font-size: 16px!important' class='fa fa-bars'></i>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("<div class='dropdown-menu' id='filter-dropdown' role='menu'>")

        strHTML.Append("<div id='tblAdvHeader'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-10'>")
        strHTML.Append("<p class='grey-text' style='float: left; margin-left: 5%!important'>Select Sprint</p>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-2'>")
        strHTML.Append("<i class='fas fa-times' style='font-size: 14px!important; color: grey!important;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='dropdown-content'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSprint", "txtSprint", "form-control", , , , , , , , , , "autocomplete='off' onclick=myFunction() onkeyup=myFunction() data-bs-toggle='dropdown' placeholder='search'", True, , , , , , True))
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("<ul id='emplistUL' class='dropdown-menu' role='menu'>")
        strHTML.Append(SprintFilter())
        strHTML.Append("</ul>")
        strHTML.Append("<input type='hidden' id='hdntxtSprint' value='" & m_strIterationID & "'/>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Dropdown Ends here

        If m_strIterationID <> 0 Then
            strHTML.Append("<div class='sprint-header' >")
            strHTML.Append("<p class='sprint-name' style='border-bottom: 2px solid #337abd;width: 160px;' data-bs-toggle='tooltip' title='Sprint Name'>" & strIterationName & "</p>")

            strHTML.Append("</div>")
            strHTML.Append("<div class='date-section' >")
            strHTML.Append("<span data-bs-toggle='tooltip' title='Start Date To End Date'>Start Date:" & strStartDate & " To " & strEndDate & "</span>")
            strHTML.Append("&nbsp;<span data-bs-toggle='tooltip' title='Total Story Point'>Total Story Point: " & strTotalStoryPoint & "</span>")

            strHTML.Append("&nbsp;<span data-bs-toggle='tooltip' title='Planned Effort/Actual Effort'>" & strPlan & "/" & strActual & "</span>")

            strHTML.Append("</div>")

        Else
            strHTML.Append("<div class='sprint-header' >")
            strHTML.Append("<p class='sprint-name' style='border-bottom: 2px solid #337abd;width: 200px;' data-bs-toggle='tooltip'>Current Sprint is not present.</p>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")
        'First row ends here

        'Second row start here
        If m_strIterationID <> 0 Then
            strHTML.Append("<div class='second-row' >")
            strHTML.Append("<div class='col-md-9 col-sm-9 col-xs-10' style='display: inline-flex;'>")
            'Added by Usha Pandit on 06 Jun 2018 for highlighting User Story count when first time load - style ='text-decoration: underline !important;'
            strHTML.Append("<h5 class='sprint-progress-text ' style='margin-left:-18px;'>Overall Sprint Progress  (<a href='#' id='count' class='story_count' style ='text-decoration: underline !important;'>User Story Count</a> | <a href='#' id='point' class='story_count'>Story Point</a>)</h5>")
            strHTML.Append("</div>")
            If strNoOfDays <> "" Then
                If strNoOfDays > 0 Then
                    strHTML.Append("<h5 class='col-md-3 col-sm-3 col-xs-2 days_plus' data-bs-toggle='tooltip' title='" & strNoOfDays & " days left' >" & strNoOfDays & " days left</h5>")
                Else
                    strHTML.Append("<h5 class='col-md-3 col-sm-3 col-xs-2 days_left' data-bs-toggle='tooltip' title='" & strNoOfDays & " days left' >" & strNoOfDays & " days left</h5>")
                End If
            End If

            strHTML.Append("</div>")
        End If
        'Second row ends here

        strHTML.Append("<div class=' clearfix' ></div>")

        'Stage graph start here
        strHTML.Append("<div class='stage' id='showcountsection'>")
        For i As Integer = 0 To drSprint.Rows.Count - 1
            strHTML.Append("<div class='col-md-4 col-sm-4 col-xs-12 Stages' style='background:" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("Color"), "") & "' >")


            'strHTML.Append("<i class='fa " & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("Icon"), "") & " fa-icon'  data-bs-toggle='tooltip'  title='" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("StageName"), "") & "' ></i><br />")
            If (CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("StageName"), "") = "Completed") Then
                strHTML.Append("<i class='far fa-check-square fa-icon'  data-bs-toggle='tooltip'  title='" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("StageName"), "") & "' ></i><br />")
            Else
                strHTML.Append("<i class='fa " & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("Icon"), "") & " fa-icon'  data-bs-toggle='tooltip'  title='" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("StageName"), "") & "' ></i><br />")
            End If
            If drSprint.Rows.Count > 0 Then 'Added by Chetan M on 20 Nov 2020 for Crash issue
                strHTML.Append("<span>" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(i)("StageWiseCount"), "") & "</span>")
            End If

            strHTML.Append("</div>")
        Next
        strHTML.Append("</div>")
        strHTML.Append("<div class='clearfix' ></div>")

        strHTML.Append("<div class='stage' id='showpointsection'>")
        'For i As Integer = 0 To drSprint.Rows.Count - 1
        strHTML.Append("<div class='col-md-4 col-sm-4 col-xs-12 Stages' style='background:#00C6D7' >")
        strHTML.Append("<i class='fa fa-list-ol fa-icon'  data-bs-toggle='tooltip'  title='To-Do List' ></i><br />")
        If drSprint.Rows.Count > 0 Then 'Added by Chetan M on 20 Nov 2020 for Crash issue
            strHTML.Append("<span>" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(0)("ToDoStoryPoint"), "") & "</span>")
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-4 col-sm-4 col-xs-12 Stages' style='background:#FFCA28' >")
        strHTML.Append("<i class='fa fa-spinner fa-icon'  data-bs-toggle='tooltip'  title='In Progress' ></i><br />")
        If drSprint.Rows.Count > 0 Then 'Added by Chetan M on 20 Nov 2020 for Crash issue
            strHTML.Append("<span>" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(0)("InProgressStoryPoint"), "") & "</span>")
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-4 col-sm-4 col-xs-12 Stages' style='background:#8BC34A' >")
        strHTML.Append("<i class='far fa-check-square fa-icon'  data-bs-toggle='tooltip'  title='Completed' ></i><br />")
        If drSprint.Rows.Count > 0 Then 'Added by Chetan M on 20 Nov 2020 for Crash issue
            strHTML.Append("<span>" & CommonFunctions.Data.CheckIsDBNull(drSprint.Rows(0)("CompletedStoryPoint"), "") & "</span>")
        End If
        strHTML.Append("</div>")
        'Next
        strHTML.Append("</div>")
        strHTML.Append("<div class='clearfix' ></div>")
        'Stage graph ends here

        'Assignees section start here
        Dim strSQLAssignee As String
        Dim dtemployeeImage As New DataTable
        strSQLAssignee = "EXEC usp_NG2_sel_tbl_PM_AgileTeamDetails " & HttpContext.Current.Session("intProjectID") & "," & m_strIterationID & ",'Iteration'"
        dtemployeeImage = CommonFunctions.Data.GetDataTable(strSQLAssignee, True)
        strHTML.Append("<div class='assignees' >")
        strHTML.Append("<h5 class='sprint-progress-text' >Assignees in Sprint</h5>")
        strHTML.Append("<div class='assignee_i' >")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<div class='carousel slide multi-item-carousel' id='theCarousel'>")
        strHTML.Append(" <div class='carousel-inner'>")
        Dim cnt As Integer = 0
        Dim FlagActive As Boolean = False
        For i As Integer = 0 To dtemployeeImage.Rows.Count - 1
            If cnt = 0 And FlagActive = False Then
                FlagActive = True

                strHTML.Append("  <div class='item active'>")
                strHTML.Append("  <div class='col-xs-4' style='    margin-left: 90px;'>")
            ElseIf cnt = 0 And FlagActive = True Then
                strHTML.Append("  <div class='item'>")
                strHTML.Append("  <div class='col-xs-4' style='    margin-left: 90px;'>")
            End If
            'Commented And Added By Usha Pandit On 17.07.2020 for adding new tooltip
            'strHTML.Append("<a href='#1'><img src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("SystemFileName"), "") & "'  class=' assignees-img'  onerror=this.src='../../Images/Photo/no-photo.png' title='" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("EmployeeName"), "") & " : " & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("RoleDescription"), "") & "'  /></a>")
            strHTML.Append("<a href='#1'><img src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("SystemFileName"), "") & "'  class=' assignees-img'  onerror=this.src='../../Images/Photo/no-photo.png' data-bs-toggle='tooltip' data-bs-placement='right' title='" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("EmployeeName"), "") & " : " & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("RoleDescription"), "") & "'  /></a>")
            'End Of Added By Usha Pandit On 17.07.2020 for adding new tooltip

            cnt = cnt + 1
            If cnt = 10 Then
                cnt = 0
                strHTML.Append(" </div>")
                strHTML.Append(" </div>")
            End If
            'strHTML.Append("<img src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("SystemFileName"), "") & "'  class=' assignees-img'  data-bs-toggle='tooltip'  onerror=this.src='../../Images/Photo/no-photo.png' title='" & CommonFunctions.Data.CheckIsDBNull(dtemployeeImage.Rows(i)("EmployeeName"), "") & "'  />")
        Next
        If cnt < 10 Then
            strHTML.Append(" </div>")
            strHTML.Append(" </div>")
        End If
        If dtemployeeImage.Rows.Count = 0 Then

            strHTML.Append("<p>No data To Display</p>")

        End If

        If Not dtemployeeImage.Rows.Count = 0 Then
            strHTML.Append("</div>")
            If dtemployeeImage.Rows.Count > 10 Then
                strHTML.Append(" <a class='left carousel-control' href='#theCarousel' data-slide='prev'><i class='fa fa-angle-double-left'style='font-weight: 700; color: #003091; font-size: 32px;'></i></a>")
                strHTML.Append(" <a class='right carousel-control' href='#theCarousel' data-slide='next'><i class='fa fa-angle-double-right'style='font-weight: 700; color: #003091; font-size: 32px;'></i></a>")
            End If
            strHTML.Append("</div>")
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Assignees section ends here

        'Category Graph start here
        strHTML.Append("<div class='category-wise-graph category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12 no_padding' >")
        strHTML.Append("<div class='col-md-11 col-sm-11 col-xs-11' >")
        strHTML.Append("<span class='graph_header'>Category</span>")
        strHTML.Append("<canvas id='category'  width='600'  height='450' ></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalCategory' id='myModalCategory' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Category Graph ends here
        strHTML.Append("<div class='clearfix' ></div>")
        strHTML.Append("<div class='category-wise-graph category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-md-11 col-sm-11 col-xs-11' >")
        strHTML.Append("<span class='graph_header'>Impediments/Issues/Risks</span>")
        strHTML.Append("<canvas id='issues'  width='600'  height=' 250' ></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalRisk' id='myModalRisk' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'First column ends here

        'Second column start here

        strHTML.Append(" <div class='col-lg-6 col-md-6 col-sm-6 col-xs-12'  style=' margin-top: 20px;' >")
        strHTML.Append("  <div class='category-wise-graph category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("     <div class='col-md-11 col-sm-11 col-xs-11' >")
        strHTML.Append("<span class='graph_header'>BurnDown Chart</span>")
        strHTML.Append("     <canvas id='burndown'  width=' 600'  height=' 560' ></canvas>")
        strHTML.Append("  </div>")
        strHTML.Append(" <div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalBurnDown' id='myModalBurnDown' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("  </div>")
        strHTML.Append(" </div>")

        strHTML.Append(" <div class='category-wise-graph category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='col-md-11 col-sm-11 col-xs-11' >")
        strHTML.Append("<span class='graph_header'>Top 5 Resources</span>")
        strHTML.Append("<canvas id='resources'  width='600'  height='520' ></canvas>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalUSTrend' id='myModalUSTrend' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Second column ends here

        Return strHTML.ToString


    End Function
    Protected Function DrawCategoryGraph()


        Dim strHTML As New StringBuilder("")

        strHTML.Append(" <div class='row' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='col-md-11 col-sm-11 col-xs-11' >")
        strHTML.Append("<span class='graph_header'>Task Board</span>")
        strHTML.Append("  <canvas id='vertical'  class='col-lg-12 col-md-12 col-sm-12 col-xs-12'></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalTaskBoard' id='myModalTaskBoard' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='clearfix' ></div>")

        Return strHTML.ToString


    End Function
    Protected Function DrawDownSection()


        Dim strHTML As New StringBuilder("")

        strHTML.Append("<div class='row' >")
        strHTML.Append(" <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='display:flex;'>")
        strHTML.Append("  <div class='col-lg-6 col-md-6 col-sm-6 col-xs-12 category-wise-graph canvasborder Activity' >")
        strHTML.Append("    <div class=' ' >")
        strHTML.Append(" <ul class='nav nav-tabs'  style='margin: 20px;' >")
        strHTML.Append("<li>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("  <a href='#Activity' class='active' data-bs-toggle='tab' >Activity Feeds</a>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</li>")
        strHTML.Append("<li>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(" <a href='#Work'  data-bs-toggle='tab' >My Work</a>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append(" </li>")
        strHTML.Append("</ul>")
        strHTML.Append("<div class='tab-content'  style=' margin: 20px;' >")
        'Commented & Added By Dipali V On 12th May 2023 For Tab Show display bydefault
        'strHTML.Append("<div id='Activity'  class='tab-pane fade in active' >")
        strHTML.Append("<div id='Activity'  class='tab-pane fade in active show' >")
        'End of Commented & Added By Dipali V On 12th May 2023 For Tab Show display bydefault
        Dim strSQL As String
        Dim drActivity As IDataReader

        Dim strEmployeeName As String
        Dim strPhoto As String
        Dim strActivityDate As String
        Dim strActivityDescription As String
        strSQL = "EXEC usp_NG2_GET_EntityLevelActivities " & HttpContext.Current.Session("intProjectID") & "," & m_strIterationID & ",'Sprint'"
        drActivity = CommonFunction.Data.GetDataReader(strSQL, True)
        While drActivity.Read
            strEmployeeName = CommonFunction.General.CheckIsNothing(drActivity("EmployeeName"), "")
            strPhoto = CommonFunction.General.CheckIsNothing(drActivity("SystemFileName"), "")
            strActivityDate = CommonFunction.General.CheckIsNothing(drActivity("ActivityDate"), "")
            strActivityDescription = CommonFunction.General.CheckIsNothing(drActivity("ActivityDescription"), "")

            strHTML.Append("<div class='sprint_card col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
            strHTML.Append("<div class='sprint_card_detail' >")
            strHTML.Append("<div class='col-lg-2 col-md-2 col-sm-2 col-xs-2' >")
            strHTML.Append("<img src='../../Images/Photo/" & strPhoto & "'  class=' assignees-img' onerror=this.src='../../Images/Photo/no-photo.png' />")
            strHTML.Append("<p data-bs-toggle='tooltip'  title='Resource Name' >" & strEmployeeName & "</p>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-lg-8 col-md-8 col-sm-8 col-xs-8' >")
            strHTML.Append("<p class='task-content'  data-bs-toggle='tooltip'  title='Activity Description' >" & strActivityDescription & "</p>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-lg-2 col-md-2 col-sm-2 col-xs-2 sprint_date' >")
            strHTML.Append("<i class='fa fa-list' ></i>")
            strHTML.Append("<p>" & strActivityDate & "</p>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End While

        strHTML.Append("</div>")


        strHTML.Append("<div id='Work'  class='tab-pane fade' >")
        Dim strSQLTask As String
        Dim drTask As IDataReader

        Dim strTaskName As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strUserStoryID As String
        Dim strUserStoryName As String
        Dim strStatus As String
        strSQLTask = "EXEC usp_NG2_GET_SprintLevelResourceWork " & m_strIterationID & "," & HttpContext.Current.Session("intUserID")
        drTask = CommonFunction.Data.GetDataReader(strSQLTask, True)

        While drTask.Read
            strTaskName = CommonFunction.General.CheckIsNothing(drTask("TaskName"), "")
            strStartDate = CommonFunction.General.CheckIsNothing(drTask("StartDate"), "")
            strEndDate = CommonFunction.General.CheckIsNothing(drTask("EndDate"), "")
            strUserStoryID = CommonFunction.General.CheckIsNothing(drTask("UserStoryID"), "")
            strUserStoryName = CommonFunction.General.CheckIsNothing(drTask("UserStoryName"), "")
            strStatus = CommonFunction.General.CheckIsNothing(drTask("Status"), "")

            strHTML.Append("<div class='sprint_card col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
            strHTML.Append("<div class='sprint_card_detail' >")

            strHTML.Append("<div class='col-lg-8 col-md-8 col-sm-8 col-xs-8' >")
            strHTML.Append("<p class='task-content'  data-bs-toggle='tooltip'  title='UserStory Name' ><span class=' task_name' >US-" & strUserStoryID & "</span> " & strUserStoryName & "</p>")
            strHTML.Append("<p class='task-content'  data-bs-toggle='tooltip'  title='Task Name' >" & strTaskName & "</p>")
            strHTML.Append("<p class='team_name'  data-bs-toggle='tooltip'  title='Start Date To End Date' >" & strStartDate & " To " & strEndDate & "</p>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-lg-2 col-md-2 col-sm-2 col-xs-2 sprint_date' >")
            strHTML.Append("<i class='fa fa-list-ul'  aria-hidden=' true' ></i>")
            strHTML.Append("<p>" & strStatus & "</p>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End While

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-lg-6 col-md-5 col-md-offset-1 col-sm-5 col-sm-offset-1 col-xs-12 category-wise-graph canvasborder' style='height: 440px;'>")
        strHTML.Append("<div class=' col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-md-10 col-sm-10 col-xs-10' >")
        strHTML.Append("<span class='graph_header'>Issue In Detailed</span>")
        strHTML.Append("<canvas id='issueindetaild'  class=''  width='300'  height='380' ></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalIssue' id='myModalIssue' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString

    End Function
    Protected Function DrawIssueSection()


        Dim strHTML As New StringBuilder("")

        strHTML.Append(" <div class='row' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append(" <div class='category-wise-graph canvasborder col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div id='divFooter'>")
        strHTML.Append("<div id='divResourceList'>")
        strHTML.Append(GetIssueListResourceWise())
        strHTML.Append("</div>")
        'strHTML.Append("<table id='tblResourceFooter'>")
        'strHTML.Append("<tr>")
        'Dim dtTotal As New DataTable
        'dtTotal = CommonFunctions.Data.GetDataTable("usp_NG2_GetTypeWiseIssueCount " & m_strIterationID, True)
        'If dtTotal.Rows.Count > 0 Then
        '    For j As Integer = 0 To dtTotal.Columns.Count - 1

        '        strHTML.Append("<td>")
        '        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtTotal.Rows(0)(j), ""))
        '        strHTML.Append("</td>")
        '        If j = 0 Then
        '            strHTML.Append("<td>")
        '            strHTML.Append("&nbsp;")
        '            strHTML.Append("</td>")
        '        End If
        '    Next
        'End If
        'strHTML.Append("<td>")
        'If intGetSum <> 0 Then
        '    strHTML.Append(intGetSum)
        'Else
        '    strHTML.Append("&nbsp;")
        'End If
        'strHTML.Append("</td>")
        'strHTML.Append("</tr>")
        'strHTML.Append("</table>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='clearfix' ></div>")

        Return strHTML.ToString


    End Function
    Protected Function DrawFooterSection()

        Dim strHTML As New StringBuilder("")

        strHTML.Append("<div class='row' >")
        strHTML.Append(" <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 col-xs-12' style='display:flex;'>")

        strHTML.Append("<div class='col-lg-6 col-md-6 col-sm-6 col-xs-12 category-wise-graph canvasborder' >")
        strHTML.Append("<div class=' col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-md-10 col-sm-10 col-xs-10' >") 'style='display:table-caption;'
        strHTML.Append("<span class='graph_header'>Effort</span>")
        strHTML.Append("<canvas id='Velocity'  class=''  width='300'  height='380' ></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalVelocity' id='myModalVelocity' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-lg-6 col-md-5 col-md-offset-1 col-sm-5 col-sm-offset-1 col-xs-12 category-wise-graph canvasborder' >")
        strHTML.Append("<div class=' col-lg-12 col-md-12 col-sm-12 col-xs-12' >")
        strHTML.Append("<div class='col-md-10 col-sm-10 col-xs-10' >")
        strHTML.Append("<span class='graph_header'>Focus Factor</span>")
        strHTML.Append("<canvas id='FocusFactor'  class=''  width='300'  height='380' ></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='fullscreeicon' >")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<img src='images/fullscreen.png'  class='fullscreen_icon'  data-bs-toggle='modal' data-bs-target='.myModalFocusFactor' id='myModalFocusFactor' title='Full Screen'/>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString


    End Function
    Protected intGetSum As Integer
    Public Function GetIssueListResourceWise()


        intGetSum = 0
        Dim strHTML As New StringBuilder
        strHTML.Append("<table id=""tblSchedule"" >")
        Dim dtSVDATA As New DataTable
        dtSVDATA = CommonFunctions.Data.GetDataTable("usp_NG2_GET_ScrumResourcesIssues " & m_strIterationID, True)
        strHTML.Append("<thead>" & vbCrLf)
        strHTML.Append("<tr>" & vbCrLf)
        Dim flag As Integer = 0
        For i As Integer = 0 To dtSVDATA.Columns.Count - 1
            flag = 1
            strHTML.Append("<th  style='" & IIf(i > 0, "text-align:center;", "") & "' >" & vbCrLf)
            If i = 0 Then
                strHTML.Append("<i class='fa fa-image'></i>")
            Else
                strHTML.Append(dtSVDATA.Columns(i).ColumnName)
            End If

            'Else
            '    strHTML.Append("&nbsp;")
            'End If
            strHTML.Append("</th>" & vbCrLf)
        Next
        If flag = 1 Then
            strHTML.Append("<th  style='text-align:center;'>" & vbCrLf)
            strHTML.Append("Total")
            strHTML.Append("</th>" & vbCrLf)
        End If
        strHTML.Append("</tr>" & vbCrLf)
        strHTML.Append("</thead>" & vbCrLf)
        strHTML.Append("<tbody>" & vbCrLf)

        If dtSVDATA.Rows.Count > 0 Then
            For i As Integer = 0 To dtSVDATA.Rows.Count - 1
                Dim intSum As Integer = 0
                strHTML.Append("<tr>" & vbCrLf)
                For j As Integer = 0 To dtSVDATA.Columns.Count - 1
                    strHTML.Append("<td title='" & dtSVDATA.Columns(j).ColumnName & "' style='" & IIf(j > 0, "text-align:center;", "") & "'>" & vbCrLf)
                    If j = 0 Then
                        'If CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("SystemFilename"), "") <> "" Then
                        '    strHTML.Append("<img class=' assignees-img' title='" & CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("Assignee"), "") & "' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("SystemFilename"), "") & "' onerror=this.src='../../Images/Photo/no-photo.png'/>")
                        'Else
                        '    strHTML.Append("<img class=' assignees-img' title='" & CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("Assignee"), "") & "' src='../../Images/Photo/no-photo.png' onerror=this.src='../../Images/Photo/no-photo.png'/>")
                        'End If

                        strHTML.Append("<img src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("SystemFilename"), "") & "' data-bs-toggle='tooltip' title='" & CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)("Assignee"), "") & "' class=' assignees-img' onerror=this.src='../../Images/Photo/no-photo.png' />")
                    Else
                        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)(j), "0"))
                    End If

                    strHTML.Append("</td>" & vbCrLf)

                    If j > 1 Then
                        intSum += Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dtSVDATA.Rows(i)(j), "0"))
                    End If
                Next
                strHTML.Append("<td  style='text-align:center;'>")
                strHTML.Append(intSum)
                strHTML.Append("</td>")
                strHTML.Append("</tr>" & vbCrLf)
                intGetSum += intSum
            Next
        Else
            strHTML.Append("<tr>" & vbCrLf)
            strHTML.Append("<td colspan=" & dtSVDATA.Columns.Count + 1 & " align=""center"" >" & vbCrLf)
            strHTML.Append("There are no items to show in this view.")
            strHTML.Append("</td>" & vbCrLf)
            strHTML.Append("</tr>" & vbCrLf)
        End If
        strHTML.Append("</tbody>" & vbCrLf)
        strHTML.Append("</table>" & vbCrLf)

        Return strHTML.ToString()


    End Function
    Protected Function SprintFilter() As String


        Dim dtTable As DataTable
        Dim strListHTML As New StringBuilder("")

        Dim intIterationID As Integer = 0
        Dim currentIterationID As Integer = 0
        dtTable = CommonFunction.Data.GetDataTable("EXEC usp_NG2_GetScrumEntities 'UserStory','Iteration', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), True)

        currentIterationID = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_NG2_Sel_CurrentIterationOrRelease(" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'Iteration')", True), "0")
        For Each drRow As DataRow In dtTable.Rows
            intIterationID = CInt(CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldID"), "0"))

            If intIterationID <> currentIterationID Then
                strListHTML.Append("<li class='clsAssignedListItem dropdown-item'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "'>")
                strListHTML.Append("<a href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldID"), "") & "'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "'  onclick='AssignToListClick(this)' >" & vbCrLf)
                strListHTML.Append(CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "</a>" & vbCrLf)
                strListHTML.Append("</li>")
            Else
                strListHTML.Append("<li class='clsAssignedListItem dropdown-item'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "'>")
                strListHTML.Append("<a href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldID"), "") & "'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "'  onclick='AssignToListClick(this)' >" & vbCrLf)
                strListHTML.Append("<i class=' fa fa-star current-release-icon' aria-hidden=' true' style='color:#ff8c00;padding: -6px;margin-left:  -15px;' data-original-title='' title=''></i>" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FieldName"), "") & "</a>" & vbCrLf)
                strListHTML.Append("</li>")
            End If
        Next

        Return strListHTML.ToString


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCategoryGraphData(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_CategoryWiseGraph " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetRiskGraphData(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_IssueRiskImpedimentsGraph " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetBurnDownChart(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GetSprintBurnDownChart " & HttpContext.Current.Session("intProjectID") & "," & IterationID & "," & HttpContext.Current.Session("intUserID")
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUSTrend(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_ResourceWiseUSTrend " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetPlotTaskBoard(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_SprintLevelTaskBoard " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetPlotIssueGraph(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_SprintLevelResourceWiseIssues " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
            'Dim dt As New DataTable()
            'dt = CommonFunction.Data.GetDataTable(strGraphSQL, True)
            'Dim str As String = ""
            'Dim strColumnName As String = ""
            'Dim index As Integer
            'Dim columnCount As Integer
            'Dim X_axisValue As String
            'Dim X_axisLabel As String

            'For index = 0 To dt.Rows.Count - 1
            '    For columnCount = 0 To dt.Columns.Count - 1
            '        If columnCount = 0 Then
            '            X_axisValue &= CommonFunction.Data.CheckIsDBNull(dt.Rows(index)(columnCount), 0) & ","
            '            X_axisLabel &= dt.Columns(columnCount).ColumnName & ","
            '        Else
            '            str &= CommonFunction.Data.CheckIsDBNull(dt.Rows(index)(columnCount), 0) & ","
            '            strColumnName &= dt.Columns(columnCount).ColumnName & ","
            '        End If
            '    Next
            '    'str &= "|"
            '    'strColumnName &= "|"
            '    'X_axisValue &= "|"
            '    'X_axisLabel &= "|"
            'Next
            'Return str
            'Return X_axisValue & "??" & X_axisLabel & "^^" & str & "??" & strColumnName
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetVelocityGraph(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GET_IterationVelocity_Graph " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetFocusFactorGraph(ByVal IterationID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strGraphSQL = "EXEC usp_NG2_GetFocusFactorGraph " & IterationID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotFilterData(ByVal IterationID As String) As String
        Dim objSD As New frmSprintDashboard
        objSD.WritePage(IterationID)
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String


        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""

        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        jsonString = serializer.Serialize(rows)

        Return jsonString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal IterationID As String)
        Try

            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String

            strSQL = "usp_NG2_Get_SprintDashboard_Report " & IterationID & "," & HttpContext.Current.Session("intUserID")

            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case ReportFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            Dim frmObjSprintDashboard As New frmSprintDashboard
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjSprintDashboard.UseSQL
                .DefaultLCID = CType(frmObjSprintDashboard.DefaultUILCID, Integer)
                .LCID = frmObjSprintDashboard.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../Images/")

                ' generate the report in requested format

                Select Case ReportFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            Return (m_strFileName)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
End Class
