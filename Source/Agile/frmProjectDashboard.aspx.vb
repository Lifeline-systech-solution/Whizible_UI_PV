Public Class frmProjectDashboard
    Inherits WebPages.Template.WhizTemplate
    Protected TotalReleases As String = ""
    Protected TotalIteration As String = ""
    Protected TotalUserStories As String = ""
    Protected Shared m_lngReportID As Integer = 20157
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

    End Sub
    Public Function ProductDashBoard() As String
        Dim strHTML As New StringBuilder()

        Dim strSql As String = ""
        Dim IsRecord As Integer = 0
        Dim drSubstory As IDataReader
        strSql = "usp_NG2_GetAgileProjectDetails " & Session("intProjectID") & ""
        Dim drTabData As IDataReader
        Dim ProjectID As String = ""
        Dim ProjectName As String = ""
        Dim ExpectedStartDate As String = ""
        Dim ExpectedEndDate As String = ""
        Dim ProductOwner As String = ""
        Dim RemainingDays As String = ""
        Dim ScrumMaster As String = ""
        Dim TotalDays As String = ""

        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        While drTabData.Read

            ProjectID = CommonFunctions.Data.CheckIsDBNull(drTabData("ProjectID"), "")
            ProjectName = CommonFunctions.Data.CheckIsDBNull(drTabData("ProjectName"), "")
            ExpectedStartDate = CommonFunctions.Data.CheckIsDBNull(drTabData("ExpectedStartDate"), "")
            ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drTabData("ExpectedEndDate"), "")
            ProductOwner = CommonFunctions.Data.CheckIsDBNull(drTabData("ProductOwner"), "")
            RemainingDays = CommonFunctions.Data.CheckIsDBNull(drTabData("RemainingDays"), "")
            ScrumMaster = CommonFunctions.Data.CheckIsDBNull(drTabData("ScrumMaster"), "")
            TotalUserStories = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalUserStories"), "")
            TotalIteration = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalIteration"), "")
            TotalReleases = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalReleases"), "")
            TotalDays = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalDays"), "")
        End While

        strHTML.Append("<input type='hidden' id='hdnRemainingDays' value=" & RemainingDays & ">")
        strHTML.Append("<input type='hidden' id='hdnTotalDays' value=" & TotalDays & ">")
        strHTML.Append("<section class='main'>")
        strHTML.Append("  <div class='container-fluid'style='margin-left: 36px; margin-right: 15px;'>")
        ''Added By Aniruddh Gujar on 24-Apr-2018 for Export option
        strHTML.Append("<div class='col-lg-12 col-md-12 col-xs-12 col-sm-12 fixed-top'>")
        strHTML.Append("<div class='Pageheader col-xs-6'>Project Dashboard</div>")
        strHTML.Append("<div class='' style='text-align: right;margin-right: 15px;'>")
        strHTML.Append("<div class='btn-group dropdown' style='float:right;'>")

        'added by ashwini on 21-3-2023
        strHTML.Append("<button type='button'  class='btn btn-info' data-bs-toggle='dropdown' data-placement='bottom'  data-container='body'>Export&nbsp;<i class='fa fa-download'></i></button>")
        strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
        'End Of added by ashwini On 21-3-2023

        strHTML.Append("<i class='fa fa-sort-down'></i>")
        strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu'>")
        strHTML.Append("<li onclick=Excel_OnClick('Excel')>Excel</li>")
        strHTML.Append("<li onclick=Excel_OnClick('PDF')>PDF</li>")
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''End of Added By Aniruddh Gujar on 24-Apr-2018 for Export option
        strHTML.Append("  <div class='row HeaderFreeze'  style='margin-left:-10px;'>")
        'strHTML.Append(" <div class='col-md-12' style='margin-left:-10px;'>")
        strHTML.Append("  <div class='row HeaderFreeze' style='margin-top: 20px;'>")
        strHTML.Append(" <div class='col-md-9'>")


        strHTML.Append(" <div class='row HeaderFreeze' style='margin-top: 25px;'>")

        strHTML.Append("<div class='col-md-2 clsDivHeader' style='color: #888888b8; font-weight: 500; white-space: nowrap;font-size: 15px;' data-toggle='tooltip' data-placement='bottom'> Project Name -</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append("     <p style='white-space: nowrap;color: #888888b8; font-weight: 500; font-size: 15px;'><span data-toggle='tooltip' data-placement='bottom' title='Project Name'> " & ProjectName & "</span></p>")
        strHTML.Append("</div>")
        strHTML.Append("   </div>")
        strHTML.Append("  <div class='row HeaderFreeze'>")
        strHTML.Append(" <div class='col-md-2 clsDivHeader' style='white-space: nowrap;color: #888888b8; font-weight: 500; font-size: 15px;'data-toggle='tooltip' data-placement='bottom'>Product Owner -</div>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append("     <p style='color: #888888b8; font-weight: 500; font-size: 15px;'><span data-toggle='tooltip' data-placement='bottom' title='Product Owner'>" & ProductOwner & "</span></p>")
        strHTML.Append("</div>")
        strHTML.Append("      </div>")
        strHTML.Append("</div>")
        strHTML.Append("      </div>")

        strHTML.Append("   <div class='row HeaderFreeze'>")
        strHTML.Append("    <div class='col-md-2 clsDivHeader' style='white-space: nowrap;color: #888888b8; margin-right: -47px;font-weight: 500; font-size: 15px;white-space:nowrap;width:11%!important;'data-toggle='tooltip' data-container='body' data-placement='bottom' >Scrum Master -</div>")
        strHTML.Append("     <div class='col-md-3' style='margin-left: 65px;'>")
        strHTML.Append("     <p style='color: #888888b8; font-weight: 500; font-size: 15px;'><span data-toggle='tooltip' data-placement='bottom' title='Scum Master'>" & ScrumMaster & "</span></p>")
        strHTML.Append("</div>")

        'Commented and added by Nilesh Pingale on 17th June 2020 to fix emty string conversion issue
        If (ExpectedStartDate = "" And ExpectedEndDate <> "") Then
            strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'><span data-toggle='tooltip' data-placement='bottom' title='Project Start Date and End Date'>Start Date:-NA  To End Date:- " & CommonFunction.Dates.CGetDate(ExpectedEndDate) & "</span></div>")
        ElseIf (ExpectedStartDate <> "" And ExpectedEndDate = "") Then
            strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'><span data-toggle='tooltip' data-placement='bottom' title='Project Start Date and End Date'>Start Date:- " & CommonFunction.Dates.CGetDate(ExpectedStartDate) & " To End Date:- NA</span></div>")
        ElseIf (ExpectedStartDate = "" And ExpectedEndDate = "") Then
            strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'><span data-toggle='tooltip' data-placement='bottom' title='Project Start Date and End Date'>Start Date:- NA To End Date:- NA </span></div>")
        Else
            strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'><span data-toggle='tooltip' data-placement='bottom' title='Project Start Date and End Date'>Start Date:- " & CommonFunction.Dates.CGetDate(ExpectedStartDate) & " To End Date:- " & CommonFunction.Dates.CGetDate(ExpectedEndDate) & "</span></div>")
        End If
        'strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'><span data-toggle='tooltip' data-placement='bottom' title='Project Start Date and End Date'>Start Date:- " & CommonFunction.Dates.CGetDate(ExpectedStartDate) & " To End Date:- " & CommonFunction.Dates.CGetDate(ExpectedEndDate) & "</span></div>")
        'End of Commented and added by Nilesh Pingale on 17th June 2020 to fix emty string conversion issue

        'strHTML.Append("<div class='col-md-4' style='color: blue;font-size: 12px;   white-space: nowrap; text-overflow: ellipsis;'data-toggle='tooltip' data-placement='bottom' title='Start Date and End Date'>Start Date:- " & CommonFunction.Dates.CGetDate(ExpectedStartDate) & "</div>")
        'strHTML.Append(" <div class='col-md-2' style='color: blue; font-size: 12px; white-space: nowrap; text-overflow: ellipsis;'data-toggle='tooltip' data-placement='bottom' title='End Date'>End Date:- " & CommonFunction.Dates.CGetDate(ExpectedEndDate) & "</div>")

        strHTML.Append(" <div class='col-md-3'>")

        If RemainingDays <> "" Then
            If RemainingDays > 0 Then
                strHTML.Append("<h5 class='col-md-3 col-sm-3 col-xs-2 days_plus' data-toggle='tooltip' title='" & RemainingDays & "    days remaining' >" & RemainingDays & " days remaining</h5>")
            Else
                strHTML.Append("<h5 class='col-md-3 col-sm-3 col-xs-2 days_left' data-toggle='tooltip' title='" & RemainingDays & "   days remaining' >" & RemainingDays & " days remaining</h5>")
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div class='clearfix' ></div>")


        strHTML.Append("   </div>")



        strHTML.Append("</div>")
        strHTML.Append("  <div class='row HeaderFreeze'>")
        strHTML.Append("  <div class='col-md-8 no-padding' style=''>")
        strHTML.Append(" <div class='widget' id='widget_burn'style='  height:389px;'>")
        'strHTML.Append("    <div class='widget-header clearfix'>")
        ''strHTML.Append("	<h3>SALES AND VISITS STAT</h3>")

        'strHTML.Append("	</div>")
        strHTML.Append("  <div id='dashboard-stat-tab-content' class='widget-content tab-content'>")

        strHTML.Append("   <div class='row HeaderFreeze'>")
        strHTML.Append(" <div id='tab-sales' class='col-md-9'>")
        'Commented and added by Reshma for font size IssueID-18708
        'strHTML.Append("	<h3 style='margin-left: 182px;margin-top: -8px;font-size: 15px; color: #6a6a6a;'>Burn Down Chart</h3>")
        strHTML.Append("	<h3 style='margin-left: 182px;margin-top: -8px;font-size: 14px; color: #6a6a6a;'>Burn Down Chart</h3>")
        'End added by Reshma for font size IssueID-18708

        strHTML.Append(" <canvas id='container'></canvas>")
        strHTML.Append("  </div>")
        strHTML.Append("  <div class='col-md-3' style='margin-left:-23px;'>")
        strHTML.Append("<ul id='dashboard-stat-tab' class='nav nav-pills nav-justified'>")
        strHTML.Append("	<li class='tab_s' id='USTab'><a  id='status_tab' data-cid='#dashboard-sales-chart'  style='white-space: nowrap; color: #808080b5; font-weight: 600;'onclick=""Filterflag(this,'User')"">User Stories</a></li>")
        strHTML.Append("	<li class='tab_s' id='sprintTab'><a  id='status_tab' data-cid='#dashboard-visits-chart'style='white-space: nowrap; color: #808080b5; font-weight: 600;' onclick=""Filterflag(this,'Sprint')"">Sprint</a></li>")
        strHTML.Append("	<li class='tab_s' id='ReleaseTab'><a   id='status_tab' data-cid='#dashboard-visits-chart'style='white-space: nowrap; color: #808080b5; font-weight: 600;' onclick=""Filterflag(this,'Release')"">Release</a></li>")
        strHTML.Append("	</ul>")
        'strHTML.Append("   <div style='overflow:auto;height:410px;'>")

        Dim SQLRelease As String = ""
        SQLRelease = "usp_NG2_Sel_Product_FilterSprintRelease " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",Release"
        Dim SQL As String = ""
        'SQL = "usp_NG2_GetScrumEntities UserStory" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",Iteration"
        strHTML.Append(" <div id='DivcboRelease'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRelease", "select ''", , , "form-control onChange=CboReleaseonChange(this.value) data-toggle='tooltip' title='Select Release'", True, True, "form-select style='margin-left: 16px;box-shadow: none!important; border-top-color: transparent;  border-left-color: transparent;border-right-color: transparent;'")).ToString.Replace("'", "\'")
        strHTML.Append("  </div>")
        strHTML.Append(" <div id='DivcboSprint'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSprint", "select ''", , , "form-control onChange=CboSprintonChange(this.value) data-toggle='tooltip' title='Select Sprint'", True, True, "form-select style='margin-left: 16px;box-shadow: none!important; border-top-color: transparent;  border-left-color: transparent;border-right-color: transparent;'")).ToString.Replace("'", "\'")
        strHTML.Append("  </div>")
        strHTML.Append(" <div id='DivcboUS'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUS", "Select ''", , Session("intuserID"), "form-control onChange=ChangeUserStory(this.value) data-toggle='tooltip' title='Select UserStory'", True, True, "form-control style='margin-left: 16px;box-shadow: none!important; border-top-color: transparent;  border-left-color: transparent;border-right-color: transparent;'")).ToString.Replace("'", "\'")

        strHTML.Append("  </div>")
        strHTML.Append("  </div>")
        strHTML.Append("  </div>")
        'strHTML.Append("  <div id='tab-visits' style='height:500px;'>")
        'strHTML.Append(" <p >Sprint</p>")
        'strHTML.Append(" </div>")
        'strHTML.Append("   <div id='tab-release' style='height:500px;'>")
        'strHTML.Append("  <p >Release</p>")
        'strHTML.Append("   </div>")
        'strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")


        strHTML.Append("  <div class='col-md-4 no-padding'>")
        strHTML.Append("  <div class='widget'>")
        strHTML.Append(" <div class='widget-header clearfix'>")
        strHTML.Append("	<h3>Overall Product Backlog Status (in %)</h3>")
        strHTML.Append("</div> ")
        strHTML.Append(" <canvas id='myChart' width='348' height='174'></canvas>")
        strHTML.Append(" </div> ")
        strHTML.Append("  <div class='row' style='margin-bottom: 5px;'>")
        strHTML.Append("  <div class='col-md-12'>")
        strHTML.Append("		<div class='panel panel-default'style='text-align:center' >")
        strHTML.Append("<div class='panel-heading col-md-6'>User Stories</div>")
        strHTML.Append(" <div class='panel-body  col-md-6' id='panel-details' style='height: 45px;font-weight: 600;background-color:#33ccff;text-align:center; color: white;'>" & TotalUserStories & "</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("  <div class='row'style='margin-bottom: 5px;'>")
        strHTML.Append("  <div class='col-md-12'>")
        strHTML.Append("		<div class='panel panel-default'style='text-align:center' >")
        strHTML.Append("<div class='panel-heading col-md-6'>Sprint</div>")
        strHTML.Append(" <div class='panel-body  col-md-6'  id='panel-details'style='height: 45px;font-weight: 600;background-color:#33ccff;text-align:center; color: white;'>" & TotalIteration & "</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("  <div class='row'>")
        strHTML.Append("  <div class='col-md-12'>")
        strHTML.Append("		<div class='panel panel-default'style='text-align:center' >")
        strHTML.Append("<div class='panel-heading col-md-6'>Release</div>")
        strHTML.Append(" <div class='panel-body  col-md-6' id='panel-details' style='height: 45px;font-weight: 600;background-color:#33ccff;text-align:center; color: white;'>" & TotalReleases & "</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("  </div>")
        strHTML.Append("  </div>")

        strHTML.Append("  <div class='row HeaderFreeze'>")
        strHTML.Append("  <div class='col-md-8 no-padding'>")
        strHTML.Append("  <div class='widget' style='    height: 430px;'>")
        strHTML.Append(" <div class='widget-header clearfix'>")
        strHTML.Append("	<h3><i class='icon ion-person'></i> Product Backlog </h3><br>")
        strHTML.Append("	<h3 style='    margin-left: -102px;font-size: 12px!important'>User Stories On Monthly Basis</h3>")
        strHTML.Append("		<div class='btn-group widget-header-toolbar'>")
        strHTML.Append("	<a href='#' title='Expand/Collapse' class='btn btn-link btn-toggle-expand'><i class='icon ion-ios-arrow-up'></i></a>")
        strHTML.Append("	<a href='#' title='Remove' class='btn btn-link btn-remove'><i class='icon ion-ios-close-empty'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div> ")
        strHTML.Append(" <div class='widget-body'>")
        strHTML.Append("	<canvas id='chartContainer'></canvas>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strSql = "usp_NG2_sel_tbl_PM_ProjectResources " & Session("intProjectID") & ""
        Dim EmployeeName As String = ""
        Dim EmployeeID As String = ""
        Dim SystemFileName As String = ""
        Dim role As String = ""
        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        strHTML.Append("  <div class='col-md-4 no-padding'>")
        strHTML.Append("  <div class='widget' style='    height: 430px;'>")
        strHTML.Append(" <div class='widget-header clearfix'>")
        strHTML.Append("	<h3><i class='icon ion-person'></i> <span>Project Team Members</span></h3>")
        strHTML.Append("		<div class='btn-group widget-header-toolbar'>")
        strHTML.Append("	<a href='#' title='Expand/Collapse' class='btn btn-link btn-toggle-expand'><i class='icon ion-ios-arrow-up'></i></a>")
        strHTML.Append("	<a href='#' title='Remove' class='btn btn-link btn-remove'><i class='icon ion-ios-close-empty'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("   <div class='card-body p-b-20' style='height: 346px;overflow-y:auto;'>")
        strHTML.Append("   <div class='list-group'>")

        strHTML.Append("   <ul class='users-list clearfix'>")
        Dim Counter As Integer
        Counter = 0
        While drTabData.Read
            Counter = Counter + 1
            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drTabData("EmployeeName"), "")
            EmployeeID = CommonFunctions.Data.CheckIsDBNull(drTabData("EmployeeID"), "")
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drTabData("SystemFileName"), "")
            role = CommonFunctions.Data.CheckIsDBNull(drTabData("RoleDescription"), "")
            If Counter <= 12 Then
                strHTML.Append("<li id='Employee_'" & EmployeeID & ">")
                strHTML.Append("<img src='../../Images/Photo/" & SystemFileName & "' onerror=this.src='../../Images/Photo/no-photo.png' data-toggle='tooltip' title='" & EmployeeName & " - " & role & "'>")
                strHTML.Append("<div class='users-list-name'>" & EmployeeName & "</div>")
                'strHTML.Append("  <span class='users-list-date'>" & role & "</span>")
                strHTML.Append("  </li>")
            Else
                If Counter = 13 Then
                    strHTML.Append("<div class='collapse' id='collapseExample2'>" & vbCrLf)
                    strHTML.Append("<ul class='users-list clearfix'>")
                End If

                strHTML.Append("<li id='Employee_'" & EmployeeID & ">")
                strHTML.Append("<img src='../../Images/Photo/" & SystemFileName & "' onerror=this.src='../../Images/Photo/no-photo.png' data-toggle='tooltip' title='" & EmployeeName & " - " & role & "'>")
                strHTML.Append("<div class='users-list-name'>" & EmployeeName & "</div>")
                'strHTML.Append("  <span class='users-list-date'>" & role & "</span>")
                strHTML.Append("  </li>")


            End If
        End While
        If Counter > 12 Then
            strHTML.Append("   </ul>")
            strHTML.Append("  </div>")
        End If

        strHTML.Append(" </ul>")
        strHTML.Append("  </div>")
        strHTML.Append("  </div>")
        If Counter > 12 Then
            strHTML.Append(" <div class='box-footer text-center'>")
            strHTML.Append("<a  class='uppercase' class='btn btn-link collapsed' data-toggle='collapse' href='#collapseExample2' aria-expanded='false' aria-controls='collapseExample' onclick='showallviews(this)'><span id='SpnAllUsers'>View All Users</span></a>")
            strHTML.Append("  </div>")
        End If

        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        '//Activity Risk//
        strSql = "usp_NG2_sel_tbl_PM_ProjectRisks " & Session("intProjectID") & ""
        Dim RiskID As String = ""
        Dim Description As String = ""
        Dim Duration As String = ""
        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        strHTML.Append("  <div class='row HeaderFreeze'>")
        strHTML.Append("  <div class='col-md-6 no-padding'>")
        strHTML.Append("  <div class='widget' id='widget_activ'>")
        strHTML.Append(" <div class='widget-header clearfix'>")
        strHTML.Append("	<h3><i class='fa fa-book'></i> <span>Active Risk</span></h3>")

        strHTML.Append("		<div class='btn-group widget-header-toolbar'>")
        strHTML.Append("	<a href='#' title='Expand/Collapse' class='btn btn-link btn-toggle-expand'><i class='icon ion-ios-arrow-up'></i></a>")
        strHTML.Append("	<a href='#' title='Remove' class='btn btn-link btn-remove'><i class='icon ion-ios-close-empty'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div> ")
        'strHTML.Append("	<div id='jar1'>")
        strHTML.Append(" <div class='pagination' id='pagination_active'></div>")
        strHTML.Append("  <div class='clearfix'></div>")
        'strHTML.Append("	</div>")

        'strHTML.Append("   <nav>")
        'strHTML.Append(" <ul class='pagination pg-red'> ")


        'strHTML.Append("  <li class='page-item'><a class='page-link'>1</a></li> ")
        'strHTML.Append(" <li class='page-item'><a class='page-link'>2</a></li> ")
        'strHTML.Append("  <li class='page-item'><a class='page-link'>3</a></li> ")
        'strHTML.Append("  <li class='page-item'><a class='page-link'>4</a></li> ")

        'strHTML.Append(" </ul> ")
        'strHTML.Append("</nav ")
        Dim IsRiskPresent As String = "0"
        While drTabData.Read
            IsRiskPresent = "1"
            RiskID = CommonFunctions.Data.CheckIsDBNull(drTabData("RiskID"), "")
            Description = CommonFunctions.Data.CheckIsDBNull(drTabData("Description"), "")
            Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
            strHTML.Append("	<div id='jar'>")
            strHTML.Append("	<div class='activity-row' id='Risk_'" & RiskID & ">")
            strHTML.Append("<div class='col-xs-9 activity-desc1' data-toggle='tooltip' title = '" & Description & "'>")
            strHTML.Append("<h6>" & Replace(Description, "'", "''") & "</h6>")

            strHTML.Append("	</div>")
            strHTML.Append("	<div class='col-xs-3 activity-desc1' data-toggle='tooltip' title = 'Risk Aging'><h6  id='time_status'> <i class='fa fa-clock-o' aria-hidden='true'></i>&nbsp;" & Duration & " </h6></div>")
            strHTML.Append("	<div class='clearfix'> </div>")
            strHTML.Append("	</div>")
            strHTML.Append("	</div>")
        End While
        If IsRiskPresent <> "1" Then
            strHTML.Append("<div align='center'>")
            strHTML.Append("There are no items to show in this view.")
            strHTML.Append("</div>")
        End If
        strHTML.Append("	</div>")
        strHTML.Append("	</div>")



        '//Impedement Open//
        strSql = "usp_NG2_sel_tbl_PM_ProjectImpediments " & Session("intProjectID") & ""
        Dim ImpedimentID As String = ""
        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        strHTML.Append("  <div class='col-md-6 no-padding' style='width:45.5%'>")
        strHTML.Append("  <div class='widget' id='widget_impe'>")
        strHTML.Append(" <div class='widget-header clearfix'>")
        strHTML.Append("	<h3><i class='fa fa-book'></i> <span>Impedement Open</span></h3>")
        strHTML.Append("		<div class='btn-group widget-header-toolbar'>")
        strHTML.Append("	<a href='#' title='Expand/Collapse' class='btn btn-link btn-toggle-expand'><i class='icon ion-ios-arrow-up'></i></a>")
        strHTML.Append("	<a href='#' title='Remove' class='btn btn-link btn-remove'><i class='icon ion-ios-close-empty'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div> ")
        strHTML.Append("	<div id='jar2'>")
        strHTML.Append(" <div class='pagination' id='pagination_imped'>")
        strHTML.Append("	</div>")
        strHTML.Append("  <div class='clearfix'></div>")
        'strHTML.Append("	<div class='scrollbar scrollbar1'>")
        Dim IsImpedimentPresent As String = "0"
        While drTabData.Read
            IsImpedimentPresent = "1"
            ImpedimentID = CommonFunctions.Data.CheckIsDBNull(drTabData("ImpedimentID"), "")
            Description = CommonFunctions.Data.CheckIsDBNull(drTabData("Description"), "")
            Duration = CommonFunctions.Data.CheckIsDBNull(drTabData("Duration"), "")
            strHTML.Append("	<div id='jar_imped'>")
            strHTML.Append("	<div class='activity-row' id='Impediment_'" & ImpedimentID & ">")
            strHTML.Append("<div class='col-xs-9 activity-desc1' data-toggle='tooltip' title = '" & Description & "'>")
            strHTML.Append("<h6>" & Replace(Description, "'", "''") & "</h6>")

            strHTML.Append("	</div>")
            strHTML.Append("	<div class='col-xs-3 activity-desc1' data-toggle='tooltip' title = 'Aging'><h6  id='time_status'><i class='fa fa-clock-o' aria-hidden='true'></i>&nbsp;" & Duration & "</h6></div>")
            strHTML.Append("	<div class='clearfix'> </div>")
            strHTML.Append("	</div>")
            strHTML.Append("	</div>")
        End While
        If IsImpedimentPresent <> "1" Then
            strHTML.Append("<div align='center'>")
            strHTML.Append("There are no items to show in this view.")
            strHTML.Append("</div>")
        End If
        strHTML.Append("	</div>")
        strHTML.Append("	</div>")
        strHTML.Append("	</div>")
        strHTML.Append("	</div>")





        '//Current Sprint Details//
        strSql = "usp_NG2_GetCurrentSprintDetails " & Session("intProjectID") & ""
        Dim IterationName As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim WorkCompleted As String = ""
        Dim TotalIssues As String = ""
        Dim TotalReviews As String = ""
        Dim StageName As String = ""
        Dim TotalTasks As String = ""
        Dim IterationStatus As String = ""
        Dim StageWiseCount As String = ""
        Dim TotalUs As String = ""
        Dim strColor As String = ""
        Dim strIcon As String = ""

        Dim Stages As New List(Of Dictionary(Of String, String))()
        Dim StageStyles As New List(Of Dictionary(Of String, String))()

        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        While drTabData.Read
            IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(drTabData("StartDate"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drTabData("EndDate"), "")
            WorkCompleted = CommonFunctions.Data.CheckIsDBNull(drTabData("WorkCompleted"), "")
            TotalIssues = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalIssues"), "")
            TotalReviews = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalReviews"), "")
            StageName = CommonFunctions.Data.CheckIsDBNull(drTabData("StageName"), "")
            TotalTasks = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalTasks"), "")
            IterationStatus = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationStatus"), "")
            StageWiseCount = CommonFunctions.Data.CheckIsDBNull(drTabData("StageWiseCount"), "")
            TotalUs = CommonFunctions.Data.CheckIsDBNull(drTabData("TotalUS"), "")
            strColor = CommonFunctions.Data.CheckIsDBNull(drTabData("Color"), "")
            strIcon = CommonFunctions.Data.CheckIsDBNull(drTabData("Icon"), "")

            Stages.Add(New Dictionary(Of String, String)() From {{"StageName", StageName}, {"StageCount", StageWiseCount}})
            StageStyles.Add(New Dictionary(Of String, String)() From {{"StageColor", strColor}, {"StageIcon", strIcon}})
        End While
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-lg-12 col-md-12 col-sm-12 no-padding' style='width: 95.5%;'>")
        strHTML.Append("<div class='widget_current'>")
        strHTML.Append("<div class='widget-header_current'>")
        strHTML.Append("<p><span>Current Sprint </span></p>")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='panel-body'>")
        strHTML.Append("  <div class='widget-content_current'>")

        If IterationName = "" Then
            strHTML.Append("   <h6 class='bigstats'><p class='col-md-6 text-info' style='font-size:14px;'data-toggle='tooltip' data-placement='top'>There are no items to display.</p></h6>")
        Else
            strHTML.Append("   <h6 class='bigstats'><p class='col-md-6 text-info' style='font-size:14px;'data-toggle='tooltip' data-placement='top'>Sprint Name: " & IterationName & "</p> <p class='col-md-6 text-info' style='font-size:14px;'data-toggle='tooltip' data-placement='top' title='Sprint Start Date and End Date'>From Date:" & CommonFunction.Dates.CGetDate(StartDate) & " To Date:  " & CommonFunction.Dates.CGetDate(EndDate) & "</p></h6>")
        End If


        strHTML.Append("  <div class='shortcuts' id='map'>")

        strHTML.Append("  <a class='shortcut' data-toggle='tooltip' data-placement='top' title='Total User Stories'>")
        strHTML.Append("<i class='fa fa-th icon' aria-hidden='true' style='color:#b92e2e;font-size: 2.5em;'></i>")
        strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>User Stories</p></span>")
        strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & TotalUs & "</h3></span> </a>")

        For i As Integer = 0 To Stages.Count - 1
            Dim value As Dictionary(Of String, String) = Stages(i)
            Dim style As Dictionary(Of String, String) = StageStyles(i)
            Dim strStageName As String = value("StageName")
            Dim strStageCount As String = value("StageCount")
            Dim strStageColor As String = style("StageColor")
            Dim strStageIcon As String = style("StageIcon")

            If strStageName = "To-Do List" Then
                strHTML.Append("  <a class='shortcut' data-toggle='tooltip' data-placement='top' title='To Do-List'>")
                strHTML.Append("  <i class='fa " & strStageIcon & " icon' aria-hidden='true' style='color:" & strStageColor & ";font-size: 2.5em;'></i>")
                strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>" & strStageName & "</p></span>")
                strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & strStageCount & "</h3></span> </a>")
            ElseIf strStageName = "In Progress" Then
                strHTML.Append("  <a class='shortcut' data-toggle='tooltip' data-placement='top' title='In Progress'>")
                strHTML.Append("  <i class='fa " & strStageIcon & " icon' aria-hidden='true' style='color:" & strStageColor & ";font-size: 2.5em;'></i>")
                strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>" & strStageName & "</p></span>")
                strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & strStageCount & "</h3></span> </a>")

                If Stages.Count > 3 Then
                    strHTML.Append(" <span id='SpnAllUsers1'><i class='fa fa-arrow-right' id='icnShow' data-toggle='tooltip' data-placement='bottom' title='Click to get More Stages'></i></span>")
                End If

            ElseIf strStageName = "Completed" Then
                strHTML.Append("  <a class='shortcut' data-toggle='tooltip' data-placement='top' title='Completed'>")
                strHTML.Append("  <i class='far fa-check-square icon" & strStageIcon & " icon' aria-hidden='true' style='color:" & strStageColor & ";font-size: 2.5em;'></i>")
                strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>" & strStageName & "</p></span>")
                strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & strStageCount & "</h3></span> </a>")
            Else
                strHTML.Append("<a class='shortcut' id='sidebar' data-toggle='tooltip' data-placement='top' title='" & strStageName & "'>")
                strHTML.Append("  <i class='far fa-check-square icon" & strStageIcon & " icon' aria-hidden='true' style='color:" & strStageColor & ";font-size: 2.5em;'></i>")
                strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>" & strStageName & "</p></span>")
                strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & strStageCount & "</h3></span> </a>")
            End If
        Next

        strHTML.Append("<a class='shortcut'data-toggle='tooltip' data-placement='top' title='Total Reviews'>")
        strHTML.Append(" <i class='far fa-file-alt icon' aria-hidden='true' style='color:#663300;font-size: 2.5em;'></i>")
        strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>Reviews</p></span>")
        strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & TotalReviews & "</h3></span> </a>")

        strHTML.Append("<a class='shortcut' data-toggle='tooltip' data-placement='top' title='Total Issues'>")
        strHTML.Append("  <i class='fa fa-bug icon' aria-hidden='true' style='color:#993399;font-size: 2.5em;'></i>")
        strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>Issues</p></span> ")
        strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & TotalIssues & "</h3></span> </a>")

        strHTML.Append("<a class='shortcut' id='Overall'  data-toggle='tooltip' data-placement='top' title='Overall % Completed'>")
        strHTML.Append("  <i class='fa fa-percent icon' aria-hidden='true' style='color:#006666;font-size: 2.5em;'></i>")
        strHTML.Append("<span class='shortcut-label'> <p class='text-grey'>Overall Completion</p></span>")
        strHTML.Append("<span class='shortcut-label'><h3 class='text-info'>" & WorkCompleted & "%</h3></span> </a>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</section>")

        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetails(ByVal EntityID As String, ByVal Entity As String)
        Dim strGraphSQL As String = ""
        Dim strUserID As String
        Dim strLoginType As String
        Dim dtGraphTable As DataTable
        Dim strResult As String = ""
        Try
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetOverallBurnDownChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intuserID") & "," & EntityID & ",'" & Entity & "',null"
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetStackData()
        Dim strGraphSQL As String = ""
        Dim strUserID As String
        Dim strLoginType As String
        Dim dtGraphTable As DataTable
        Dim strResult As String = ""
        Try
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            strGraphSQL = "usp_NG2_GetProductBacklogGraph " & HttpContext.Current.Session("IntProjectID") & ""


            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetOverallDetails()
        Dim strsql As String = ""
        Dim index As Integer
        Dim columnCount As Integer
        Try
            strsql = "usp_NG2_AgileProjectOverallStatusGraph " & HttpContext.Current.Session("IntProjectID")

            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable(strsql, True)
            Dim str As String = ""
            Dim strColumnName As String = ""
            For index = 0 To dt.Rows.Count - 1
                For columnCount = 0 To dt.Columns.Count - 1
                    str &= dt.Rows(index)(columnCount) & ","
                    strColumnName &= dt.Columns(columnCount).ColumnName & ","
                Next
            Next

            Return str & "|" & strColumnName
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''===================================================
    '' Created By: Nikhil A 
    '' Created On: 9-March-2019
    '' Purpose : To Show the User story on sprint change
    ''===================================================
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDropDownValues(ByVal Type As String, ByVal Entity As String, ByVal UserStoryID As String, ByVal IterationID As String, ByVal ReleaseID As String)
        Dim strsql As String = ""
        Dim strResult As String = ""
        Try
            strsql = "usp_NG2_GetScrumEntities '" & Type & "','" & Entity & "'," & HttpContext.Current.Session("IntProjectID") & "," & UserStoryID & "," & IterationID & "," & ReleaseID

            Dim dt As New DataTable()
            dt = CommonFunctions.Data.GetDataTable(strsql, True)
            strResult = GetSerialized(dt)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDefaultDropDownValues(ByVal Type As String)
        Dim strsql As String = ""
        Dim strResult As String = ""
        Try
            If Type = "Sprint" Then
                Type = "Iteration"
            End If
            strsql = "SELECT dbo.fn_NG2_Sel_CurrentIterationOrRelease(" & HttpContext.Current.Session("IntProjectID") & ",'" & Type & "')"

            strResult = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strsql, True), "")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""
        Try
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
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String)
        Dim strSQL As String
        Dim strFilePath As String
        Dim strFormat As String
        Dim strCaptions As String
        Try
            strSQL = "usp_sel_NG2_ProjectDashboard_Report " & HttpContext.Current.Session("intProjectID")

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

            Dim frmObjProjectDashBoard As New frmProjectDashboard
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjProjectDashBoard.UseSQL
                .DefaultLCID = CType(frmObjProjectDashBoard.DefaultUILCID, Integer)
                .LCID = frmObjProjectDashBoard.CurrentThreadUICultureID
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
