Imports System.Xml
Imports System.IO
'Excel upload
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Runtime.InteropServices

Public Class frmReleaseMonitoring

    Inherits WebPages.Template.WhizTemplate
    Protected WithEvents m_objGid As New WebPages.Template.GenericGrid
    Protected Shared m_lngReportID As Integer = 20189
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected Shared m_strIsProductOwner As String = ""
    Public PlannedEffort As String = ""
    Public projectID As String = ""
    Public ActualEffort As String = ""
    Public DoListCount As String = ""
    Public InProgressCount As String = ""
    Public DoneCount As String = ""
    Public DiscussionCount As String = ""
    Public ReviewCount As String = ""
    Public ReleaseID As String = ""
    Public NoOfDays As String = ""
    Public UserID As String = ""
    Public CurrentIterationID As String = ""
    Protected strFunctionalNumber As String = ""
    Protected strFeatureName As String = ""
    Protected strUserDesc As String = ""
    Protected strBusinesValue As String = ""
    Protected strPriority As String = ""
    Protected strState As String = ""
    Protected strComplexity As String = ""
    Protected strStoryPoint As String = ""
    Protected strCategory As String = ""
    Protected strVersion As String = ""
    Protected strIterationName As String = ""
    Protected strReleaseName As String = ""
    Protected strCreatedDate As String = ""
    Protected strCreatedBy As String = ""
    Protected strInitialRank As String = ""
    Protected strCategoryColor As String = "#DDD"
    Protected strVersionColor As String = "#DDD"
    Protected strPriorityColor As String = "#DDD"
    Protected strStatus As String = ""
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected strIsPrductOwner As String
    Protected strAcceptanceCriteria As String = ""
    Protected strFixedVersion As String = ""
    Protected strFixedVersionColor As String = "#DDD"
    Public SelectedReleaselistReleaseID As String = ""
    Public SelectedReleaseid As String = ""
    Private WithEvents objAttachList As New WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private WithEvents objGrid As New WebPages.Template.GenericGrid
    Private WithEvents objHistorykList As New WebPages.Template.GenericGrid
    Private WithEvents objGridUS As New WebPages.Template.GenericGrid
    Private WithEvents objGridRelease1 As New WebPages.Template.GenericGrid 'objGridUnmappedSprint
    Private WithEvents objGridUnmappedSprint As New WebPages.Template.GenericGrid
    Private WithEvents objGridSprint As New WebPages.Template.GenericGrid
    Private WithEvents objGridComplete As New WebPages.Template.GenericGrid
    Private WithEvents objGridCancel As New WebPages.Template.GenericGrid
    Private WithEvents objCurrentSprintUS As New WebPages.Template.GenericGrid
    Private WithEvents objIssuesList As New WebPages.Template.GenericGrid
    Private WithEvents objReviewList As New WebPages.Template.GenericGrid
    Private WithEvents objImpedimentsLogList As New WebPages.Template.GenericGrid
    Private WithEvents objRiskList As New WebPages.Template.GenericGrid
    Private WithEvents objtaskList As New WebPages.Template.GenericGrid


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_strIsProductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
        projectID = Session("intProjectID")
        If Request.Params("Mode") = "Upload" Then
            UploadData()
        End If


    End Sub
    Protected Function WritePage(Optional ByVal flag As String = "")
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
        ' Created               :	29-MAR-2018
        ' Revisions             : strHTML.Append("")
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        'Legends for release status'
        If flag = "load" Then
            strHTML.Append("<div id='PlotDetails'>")
        End If

        strHTML.Append("<div class='row' style='margin-top:10px;'>")
        strHTML.Append(" <div class='col-md-12 co-sm-12 fixed-top' style='display:flex'><div class='col-md-3 col-sm-3 col-sm-12 releasetitle' >Release Monitoring</div><div class='col-md-5 col-sm-6'><div  style='float: right;display:flex' id='divlendegends'><p class='col-sm-3'  style='font-size: 12px!important; white-space: nowrap;width: 29%!important;' ><label class='bar delayed-issue'  style=''></label> &nbsp;Delayed With Issue</p><p class='col-sm-2'  style='font-size: 12px!important; white-space: nowrap;width: 11%!important;' > <label class='bar issue' ></label>&nbsp;Issue</p> <p class='col-sm-2'  style='font-size: 12px!important; white-space: nowrap;width: 15%!important;' ><label class=' bar delayed' ></label>&nbsp;Delayed</p><p class='col-sm-2'  style='font-size: 12px!important; white-space: nowrap;width: 18%!important;' ><label class='bar planned' ></label>&nbsp;As Planned  </p> <p class='col-sm-2'  style='font-size: 12px!important; white-space: nowrap;width: 17%!important;' ><label class='bar ready' ></label>&nbsp;Released</p></div></div></div>")
        strHTML.Append("</div>")

        'Filters'
        strHTML.Append(DrawFilters())
        'Filter Ends Here'

        'Release Content'

        strHTML.Append("<div class='col-md-12' id='ReleaseDetailsall'>")
        strHTML.Append(DrawLeftSection())
        strHTML.Append("<div class='col-md-8 col-sm-12 col-sm-12'>")
        strHTML.Append("<div class='table-responsive release_table' id='ReleaseDetails'>")
        strHTML.Append(DrawRightSection(""))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")

        If flag = "load" Then
            strHTML.Append("</div>")

        End If


        If flag = "load" Then
            CommonFunction.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If

    End Function
    Protected Function DrawFilters()


        Dim strHTML As New StringBuilder("")

        strHTML.Append("<div class='col-md-3 col-sm-4' style='z-index: 1030;float: right;position:relative;'>")
        strHTML.Append("<div class=''  style='display: inline-flex; float: right;' >") 'margin-right: 43px;
        strHTML.Append("<div class='searchbox'><input type='text'  name=' search'  placeholder=' Search...' id='txtSearchRelease'  class=' search_release ' style='margin-left:24px;' /><i class='fa fa-search SprintSeachMain' aria-hidden=' true'  ></i></div>")
        'Commented and Added by Usha Pandit on 30.04.2019 For IssueID-18743 
        'strHTML.Append("<div class='dropdown'  style='margin-right: 15px;' >")
        'strHTML.Append("<button class='btn btn-info dropdown-toggle'  type='button' data-bs-toggle='dropdown' id='btncreate' >Create&nbsp;<span class='caret'></span> </button>")
        'GetAccessRights()
        GetAccessRights()

        'added by ashwini on 21-3-2023 for data-bs-toggle
        If strIsPrductOwner = 1 Then
            strHTML.Append("<div class='dropdown'  style='margin-right: 15px;' >")
            strHTML.Append("<button class='btn btn-info dropdown-toggle'  type='button' data-bs-toggle='dropdown' id='btncreate' >Create&nbsp;<span class='caret'></span> </button>")
        Else
            strHTML.Append("<div class='dropdown'  style='margin-right: 15px;' >")
            strHTML.Append("<button class='btn btn-info dropdown-toggle' style='display:none!important;' type='button' data-bs-toggle='dropdown' id='btncreate' >Create&nbsp;<span class='caret'></span> </button>")
        End If
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle

        'End of Commented and Added by Usha Pandit on 30.04.2019 For IssueID-18743 


        If strIsPrductOwner = 1 Then
            If m_objAccess.Add = True Then

                strHTML.Append("<ul class='dropdown-menu'>")
                'commented By Dipali V On 19th April 2018 For Release M Issue 
                ' strHTML.Append("<li><a  onclick=ShowModal('User','',this) >&nbsp;User Story</a></li>")
                'strHTML.Append("<li>  <a  href='#' onclick=ShowModal('Sprint','',this)>&nbsp;Sprint</a></li>")
                strHTML.Append("<li onclick=ShowModal('Release','',this)>&nbsp;Release</li>")
                strHTML.Append("</ul>")
                'End of commented By Dipali V On 19th April 2018 For Release M Issue 
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("<div>")



        strHTML.Append("<div class='dropdown'  ><i class='fa fa-filter dropdown-toggle' title='Filter' data-bs-toggle='dropdown'  data-placement='bottom' style='font-size: 16px !important;color: #01579b;margin-top: -5px;'></i>")
        'End of Commented By Dipali V On 20th April 2018 For Alignment Changes
        strHTML.Append("<ul class=' dropdown-menu filter-dropdown' id='ulFilters'>")
        strHTML.Append("<li onclick=""ShowFilter('DelayedwithIssue')"">Delayed with Issue</li>")
        strHTML.Append("<li onclick=""ShowFilter('HaveIssue')"">Have Issue</li>")
        strHTML.Append("<li onclick=""ShowFilter('AsPlanned')"">As Planned</li>")
        strHTML.Append("<li onclick=""ShowFilter('CurrentRelease')"">Current Release</li>")
        strHTML.Append("<li onclick=""ShowFilter('Released')"">Released</li>")
        strHTML.Append("<li onclick=""ShowFilter('All')"">All</li>")
        strHTML.Append("</ul></div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")
        Return strHTML.ToString

    End Function
    Protected Function DrawLeftSection()


        Dim strHTML As New StringBuilder("")

        Dim drCurrentRelease As IDataReader
        Dim strSQL As String
        Dim strReleaseID As String = ""
        Dim strReleaseName As String = ""
        Dim strDescription As String = ""
        Dim strStartDate As String = ""
        Dim strEndDate As String = ""
        Dim strStoryPoint As String = ""
        Dim strPlan As String = ""
        Dim strActual As String = ""
        Dim strCurrentSprint As String = ""
        Dim strReleaseStatus As String = ""
        Dim strOpenSprint As String = ""
        Dim strCloseSprint As String = ""
        Dim strIssueCOunt As String = ""
        Dim strDiscussionCount As String = ""
        Dim strTodoCount As String = ""
        Dim strInProgressCount As String = ""
        Dim strCompletedCount As String = ""
        Dim Percentage As String = ""
        strSQL = "EXEC usp_NG2_GetCurrentReleaseDetails " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID")
        drCurrentRelease = CommonFunction.Data.GetDataReader(strSQL, True)
        Dim isData As Integer
        isData = 0
        While drCurrentRelease.Read
            isData = 1
            strReleaseID = CommonFunction.General.CheckIsNothing(drCurrentRelease("ReleaseID"), "")
            strReleaseName = CommonFunction.General.CheckIsNothing(drCurrentRelease("ReleaseName"), "")
            strDescription = CommonFunction.General.CheckIsNothing(drCurrentRelease("Description"), "")
            strStartDate = CommonFunction.General.CheckIsNothing(drCurrentRelease("StartDate"), "")
            strEndDate = CommonFunction.General.CheckIsNothing(drCurrentRelease("EndDate"), "")
            strStoryPoint = CommonFunction.General.CheckIsNothing(drCurrentRelease("StoryPoint"), "")
            strPlan = CommonFunction.General.CheckIsNothing(drCurrentRelease("PlanVelocity"), "")
            strActual = CommonFunction.General.CheckIsNothing(drCurrentRelease("ActualVelocity"), "")
            strCurrentSprint = CommonFunction.General.CheckIsNothing(drCurrentRelease("CurrentSprint"), "")
            strReleaseStatus = CommonFunction.General.CheckIsNothing(drCurrentRelease("Status"), "")
            Percentage = CommonFunction.General.CheckIsNothing(drCurrentRelease("Percentage"), "")
            strOpenSprint = CommonFunction.General.CheckIsNothing(drCurrentRelease("OpenIterations"), "")
            strCloseSprint = CommonFunction.General.CheckIsNothing(drCurrentRelease("CloseIterations"), "")
            strIssueCOunt = CommonFunction.General.CheckIsNothing(drCurrentRelease("IssueCount"), "")
            strDiscussionCount = CommonFunction.General.CheckIsNothing(drCurrentRelease("DiscussionCount"), "")
            strTodoCount = CommonFunction.General.CheckIsNothing(drCurrentRelease("DoListCount"), "")
            strInProgressCount = CommonFunction.General.CheckIsNothing(drCurrentRelease("InProgressCount"), "")
            strCompletedCount = CommonFunction.General.CheckIsNothing(drCurrentRelease("DoneCount"), "")
        End While
        'Current Release'
        strHTML.Append("<div class='col-md-4 col-sm-12 col-sm-12'>")
        'Card Start Here'
        strHTML.Append("<div class='card'>")
        strHTML.Append("<div class=' card-header card-header-tabs card-header-primary' style='padding: 15px;!important'><div class=' current_release' > Current Release</div></div>")
        'Card Body'
        If isData = 1 Then
            strHTML.Append("<div class='card-body'>")
            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12' ><i class=' fa fa-star current-release-icon'  aria-hidden=' true' style='color:#ff8c00;' ></i></div>")
            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class=' release_header' >Release Name</p> </div>")
            If strReleaseName = "" Then
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='ReleaseName'>Not Specified</p> </div>")
            Else
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='ReleaseName'>" & strReleaseName & "</p> </div>")
            End If
            strHTML.Append("</div>")
            Dim strLessDescription As String = ""
            If strDescription.Length > 200 Then
                strLessDescription = strDescription.Substring(0, 100)
            End If

            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class=' release_header' >Description</p> </div>")
            If strDescription = "" Then
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Description'>Not Specified</p> </div>")
            Else
                If strDescription.Length > 200 Then
                    strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Description'>" & strLessDescription & "</p> </div>")
                Else
                    strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Description'>" & strDescription & "</p> </div>")
                End If
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='release_date' style='margin-left: 12px;'>")
            If strStartDate = "" Then
                strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12'><p data-toggle='tooltip'  title='Start Date To End Date'><i class=' far fa-clock' ></i>   Not Specified  To " & strEndDate & "</p></div>")
            Else
                strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12'><p data-toggle='tooltip'  title='Start Date To End Date'><i class=' far fa-clock' ></i>   " & strStartDate & " To " & strEndDate & "</p></div>")

            End If
            'If strStoryPoint = "" Then
            '    strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12'><p><span data-toggle='tooltip'  title='Story Points'>Not Specified</span></p></div>")
            'Else
            '    strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12' ><p><span data-toggle='tooltip'  title='Story Points'>" & strStoryPoint & "</span></p></div>")

            'End If
            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' style='margin-left:-5%' ><p class=' release_header' >Story Point</p> </div>")
            If strStoryPoint = "" Then
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Story Points'>Not Specified</p> </div>")
            Else
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Story Points'>" & strStoryPoint & "</p> </div>")
            End If
            strHTML.Append("</div>")


            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6'  style='margin-left:-5%'><p class=' release_header' >Planned/Actual</p> </div>")
            If strPlan = "" And strActual = "" Then
                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Planned/Actual'>Not Specified</p> </div>")
            Else
                ''Commented and Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
                'strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Planned/Actual'>" & strPlan & "/" & strActual & "</p> </div>")
                Dim HMPlan As String = ""
                Dim HMActual As String = ""

                HMPlan = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strPlan + "',1)", True)
                HMActual = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strActual + "',1)", True)

                strHTML.Append("<div class=' col-md-6 col-sm-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Planned/Actual'>" & HMPlan & "/" & HMActual & "</p> </div>")
                ''End of Added by Usha Pandit on 05-April-2019 Purpose::Whizible 2 Work field change
            End If
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12'><p data-toggle='tooltip'  title='Start Date To End Date'><i class=' far fa-clock' ></i>" & strStartDate & " To " & strEndDate & "</p></div>")
            ' strHTML.Append("<div class='col-md-12 col-sm-4 col-sm-12'><p><span data-toggle='tooltip'  title='Planned/Actual'>" & strPlan & "/" & strActual & "</span></p></div>")


            strHTML.Append("</div>")

            strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12'>")
            strHTML.Append("<div class=' col-md-6 col-sm-6' ><p class=' release_header' >Current Sprint</p> </div>")
            strHTML.Append("<div class=' col-md-6 col-sm-6' ><p class='release_content' data-toggle='tooltip'  title='Current Sprint'>" & strCurrentSprint & "</p> </div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12' >")
            strHTML.Append("<div class='progress' >")
            If Percentage = "0.00" Then
                strHTML.Append("<div class='progress-bar progress-bar-striped progress-bar-success'  role='progressbar'  aria-valuenow='" & Percentage & "' aria-valuemin=' 0'  aria-valuemax=' 100'  style=' width:100%; color:black; text-align: center !important; background-color: #ddd !important;'  data-toggle='tooltip' title=' Story Points progress bar(" & Percentage & "%)' >" & Percentage & "%</div>")
            Else
                strHTML.Append("<div class='progress-bar progress-bar-striped progress-bar-success'  role='progressbar'  aria-valuenow='" & Percentage & "' aria-valuemin=' 0'  aria-valuemax=' 100'  style=' width:" & Percentage & "%'  data-toggle='tooltip' title=' Story Points progress bar(" & Percentage & "%)' >" & Percentage & "%</div>")
            End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-md-12 col-sm-12 col-sm-12 align-center' >")
            strHTML.Append("<button type='button'  class='release' data-toggle='tooltip'  title='Status' style='background-color:white!important;color:black!important;cursor:text!important'>" & strReleaseStatus & "</button><button type='button'  class='release' data-toggle='tooltip' title='View More'  onclick='EditRelease(" & strReleaseID & " ," & projectID & ")'>View More</button>")
            strHTML.Append("</div>")

            ''Release Icons'
            'strHTML.Append("<div class=' col-md-12 col-sm-12 col-sm-12 release-icons'  style=' margin-top: 15px;' >")
            'strHTML.Append("<i class='fa fa-delicious'  aria-hidden=' true' ><span class='badge danger'  data-toggle='tooltip'  title='Sprints Open'>" & strOpenSprint & "</span></i>")
            'strHTML.Append("<i class='fa fa-delicious'  aria-hidden=' true' ><span class= 'badge complete'  data-toggle='tooltip'  title='Sprints Closed'>" & strCloseSprint & "</span></i>")
            'strHTML.Append("<i class='fa fa-bug'  aria-hidden=' true'  data-toggle='tooltip'  title='Issue' ><span class='badge danger'>" & strIssueCOunt & "</span></i>")
            'strHTML.Append("<i class='fa fa-comments'  aria-hidden=' true'  data-toggle='tooltip'  title= 'Discussion' ><span class='badge warning'>" & strDiscussionCount & "</span></i>")
            'strHTML.Append("<i class='fas fa-chart-bar'  aria-hidden=' true'  data-toggle='tooltip'  title='Chart' ></i>")
            'strHTML.Append("<i class='fa fa-list-ol' ><span class='badge danger'  data-toggle='tooltip'  title='To do'>" & strTodoCount & "</span></i>")
            'strHTML.Append("<i class='fa fa-spinner' ><span class='badge danger'  data-toggle='tooltip'  title='In Progress'>" & strInProgressCount & "</span></i>")
            'strHTML.Append("<i class='fa fa-check-square-o' ><span class='badge complete'  data-toggle='tooltip'  title='Completed' >" & strCompletedCount & "</span></i>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
        ElseIf isData = 0 Then
            strHTML.Append("<div class='card-body'>")
            strHTML.Append("<div class='col-sm-12' ><p class='release_content' data-toggle='tooltip'>There is no current Release</p> </div>")
            strHTML.Append("</div>")
        End If


        'Card Body End'
        strHTML.Append("</div>")
        'Card Ends Here'
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Protected Function DrawRightSection(ByVal strFilter As String)


        Dim strHTML As New StringBuilder("")
        Dim sbGridHTML As New StringBuilder("")
        Dim ArrActualNameList As New ArrayList
        Dim ArrColHeadingsList As New ArrayList
        Dim ArrCheckboxlist As New ArrayList
        Dim drUserFriendlyColumns As IDataReader

        Dim GridSQL As String = ""
        Dim intNoOfDataColumnCount As Integer = 0
        GridSQL = "usp_NG2_sel_tbl_PM_ScrumReleasesList " & Session("intProjectID") & ",Null," & Session("intUserID") & IIf(strFilter = "", strFilter, ",'" & strFilter & "'")


        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(GridSQL, True)
        sbGridHTML.Append("<input type=hidden id=FilterListCount value='" & dtListCount.Rows.Count & "'>")
        sbGridHTML.Append("<input type=hidden id='Filter" & strFilter & "' value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue

        ArrActualNameList.Add("T1")
        ArrColHeadingsList.Add("")
        ArrCheckboxlist.Add("")

        'ArrActualNameList.Add("UniqueID")
        'ArrColHeadingsList.Add("UniqueID")
        'ArrCheckboxlist.Add("")

        ArrActualNameList.Add("ReleaseName")
        ArrColHeadingsList.Add("Release Name")
        ArrCheckboxlist.Add("")

        'ArrActualNameList.Add("Description")
        'ArrColHeadingsList.Add("Description")
        'ArrCheckboxlist.Add("")

        ArrActualNameList.Add("StartDate")
        ArrColHeadingsList.Add("Start Date")
        ArrCheckboxlist.Add("")

        ArrActualNameList.Add("EndDate")
        ArrColHeadingsList.Add("End Date")
        ArrCheckboxlist.Add("")

        ArrActualNameList.Add("CalendarDuration")
        ArrColHeadingsList.Add("Calendar Duration")
        ArrCheckboxlist.Add("")

        'ArrActualNameList.Add("BusinessDuration")
        'ArrColHeadingsList.Add("Business Duration")
        'ArrCheckboxlist.Add("")

        'ArrActualNameList.Add("StoryPoint")
        'ArrColHeadingsList.Add("StoryPoint")
        'ArrCheckboxlist.Add("")

        'ArrActualNameList.Add("PlanVelocity")
        'ArrColHeadingsList.Add("Planned Effort/Actual Effort")
        'ArrCheckboxlist.Add("")

        ArrActualNameList.Add("Edit")
        ArrColHeadingsList.Add("")
        ArrCheckboxlist.Add("")

        ArrActualNameList.Add("Delete")
        ArrColHeadingsList.Add("")
        ArrCheckboxlist.Add("")

        'Convert arraylist to actual array - Actual Column Names
        Dim ArrActualName(ArrActualNameList.Count - 1) As String
        ArrActualNameList.ToArray.CopyTo(ArrActualName, 0)
        ArrActualNameList = Nothing

        'Convert arraylist to actual array - User Friendly column headings
        Dim ArrColHeadings(ArrColHeadingsList.Count - 1) As String
        ArrColHeadingsList.ToArray.CopyTo(ArrColHeadings, 0)
        ArrColHeadingsList = Nothing
        Dim arrCheckBox(ArrCheckboxlist.Count - 1) As String
        ArrCheckboxlist.ToArray.CopyTo(arrCheckBox, 0)
        ArrCheckboxlist = Nothing

        With m_objGid
            .ActualColumnArray = ArrActualName
            .UserFriendlyColumnArray = ArrColHeadings
            .CheckBoxIDArray = arrCheckBox
            .NoOfDataColumns = 9
            .PrimaryKey = "ReleaseID"
            .returnHTML = True
            .UseSQL = MyBase.UseSQL
            .ColNameToolTipOnEachRow = True
            .DIVID = "divReleases"
            .DIVStyle = ""
            .SQL = GridSQL
            sbGridHTML.Append(.DrawGrid())
        End With

        'Data Table

        strHTML.Append(sbGridHTML.ToString)


        Return strHTML.ToString

    End Function
    Function CheckIsProductOwner(ByVal strUserID As String)
        '=====================================================================
        ' Procedure Name        :	CheckIsProductOwner
        ' Purpose               :	CheckIsProductOwner
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Aniruddh GUjar
        ' Created               :	3-April-2018
        ' Revisions             :
        '=====================================================================


        Dim drGetIsProductOwner As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""

        StrQuery = "usp_NG2_IsProductOwner " & Session("intProjectID") & "," & strUserID & ""
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetIsProductOwner.Read
            m_strIsProductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")
        End While
        Return m_strIsProductOwner

    End Function
    Private Sub m_objGid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "T1" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='position:relative' ><div  data-toggle='tooltip' data-placement='right' title='" & Args.DataReader("Tooltip") & "' style='width:6px;border:1px solid #CCC;background-color:" & Args.DataReader("T1") & ";height:24px' class='tdlengends'></div></td>"
        End If

        If Args.DataField.ToUpper = "UNIQUEID" Then
            Cancel = True
            If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "") <> "" Then
                Args.StringToBeInserted = "<td style='border-left: 3px solid " & Args.DataReader("T1") & ";'><span title='Unique Key' data-toggle='tooltip' data-placement='bottom'>" & Args.DataReader("UniqueID") & "</span></td>"
            Else
                Args.StringToBeInserted = "<td></td>"
            End If
        End If

        If Args.DataField.ToUpper = "RELEASENAME" Then
            Cancel = True
            If Args.DataReader("ReleaseName").ToString().Length > 20 Then

                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReleaseName"), "") = "" Then
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' style='white-space:pre-line;' data-placement='bottom' title='Release Name " & Args.DataReader("ReleaseName") & "' class='textUStory'>Not Specified</div></td>"
                Else
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "> <div data-toggle='tooltip' style='white-space:pre-line;' data-placement='bottom' title='Release Name " & Args.DataReader("ReleaseName") & "' class='textUStory'>" & Args.DataReader("ReleaseName").ToString().Substring(0, 20) & "....</div></td>"
                End If

            Else
                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReleaseName"), "") = "" Then
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' style='white-space:pre-line;' data-placement='bottom' title='Release Name " & Args.DataReader("ReleaseName") & "' class='textUStory'>Not Specified</div></td>"
                Else
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' style='white-space:pre-line;' data-placement='bottom' title='Release Name " & Args.DataReader("ReleaseName") & "' class='textUStory'>" & Args.DataReader("ReleaseName") & "</div></td>"

                End If
            End If
        End If

        If Args.DataField.ToUpper = "DESCRIPTION" Then
            Cancel = True
            If Args.DataReader("Description").ToString().Length > 15 Then

                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "") = "" Then
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' data-placement='bottom' title='" & Args.DataReader("Description") & "' class='textUStory'>Not Specified</div></td>"
                Else
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "> <div data-toggle='tooltip' data-placement='bottom' title='" & Args.DataReader("Description") & "' class='textUStory'>" & Args.DataReader("Description").ToString().Substring(0, 15) & "....</div></td>"
                End If
            Else
                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "") = "" Then
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' data-placement='bottom' title='" & Args.DataReader("Description") & "' class='textUStory'>Not Specified</div></td>"
                Else
                    Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' data-placement='bottom' title='" & Args.DataReader("Description") & "' class='textUStory'>" & Args.DataReader("Description") & "</div></td>"

                End If
            End If
        End If

        If Args.DataField.ToUpper = "CALENDARDURATION" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='position:relative' ><span title='Calendar Duration' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("CalendarDuration") & "</span></td>"
        End If

        If Args.DataField.ToUpper = "BUSINESSDURATION" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='position:relative' ><span title='Business Duration' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("BusinessDuration") & "</span></td>"
        End If

        If Args.ColumnName.ToUpper = "STORYPOINT" Then
            Cancel = True
            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("StoryPoint"), 0) <> 0 Then
                Args.StringToBeInserted = "<td style='position:relative' ><span title='Story Point' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("StoryPoint") & "</span></td>"
            Else
                Args.StringToBeInserted = "<td></td>"
            End If
        End If

        If Args.DataField.ToUpper = "STARTDATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='position:relative' ><span title='Start Date' data-toggle='tooltip' data-placement='bottom' class='release_startdate'>" & Args.DataReader("StartDate") & "</span></td>"
        End If

        If Args.DataField.ToUpper = "ENDDATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='position:relative' ><span title='End Date' data-toggle='tooltip' data-placement='bottom' class='release_startdate'>" & Args.DataReader("EndDate") & "</span></td>"
        End If

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            If m_strIsProductOwner = "1" Then 'title='You do not have access to edit Release'
                Args.StringToBeInserted = "<td class='tdstyle' style='text-align:center;'  title=" & Args.DataField & "><i class='fas fa-pencil-alt edit_release' data-toggle='tooltip'  data-placement='bottom' onclick='EditRelease(" & Args.DataReader("ReleaseID") & "," & Session("intProjectID") & ")' title='Edit Release' id='Editdata' data-container='body'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>"
            Else
                Args.StringToBeInserted = "<td class='tdstyle' style='text-align:center;'  title=" & Args.DataField & "><i class='fas fa-pencil-alt edit_release' data-toggle='tooltip'  data-placement='bottom'  onclick='EditRelease(" & Args.DataReader("ReleaseID") & "," & Session("intProjectID") & ")' title='Edit Release' id='Editdata' data-container='body'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>"

            End If
        End If

        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True
            If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ReleaseID"), 0) <> 0 Then
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsMappedToIteration"), 0) = "1" Then
                    If m_strIsProductOwner = "1" Then
                        Args.StringToBeInserted = "<td class='tdstyle' style='text-align:center;'  title=" & Args.DataField & "><i style='color:red' class='fas fa-trash-alt delete_release' data-toggle='tooltip' data-placement='left' data-container='body'  title=""Sprint Is Mapped For Release,You Can Not Delete"" id='Editdata' onclick='delete_release(" & Args.DataReader("ReleaseID") & ")'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>" ' onclick='DeleteIterations(" & Args.DataReader("IterationID") & ")'
                    Else
                        Args.StringToBeInserted = "<td class='tdstyle' style='text-align:center;'><i style='color:red;' class='fas fa-trash-alt delete_release' data-toggle='tooltip' data-placement='left'   title='Delete' data-container='body' id='Editdata' onclick='delete_release(" & Args.DataReader("ReleaseID") & ")'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>"
                    End If

                Else
                    If m_strIsProductOwner = "1" Then
                        Args.StringToBeInserted = "<td  class='tdstyle' style='text-align:center;'  ><i style='color:red;' class='fas fa-trash-alt delete_release' data-toggle='tooltip' data-placement='left' data-container='body'  onclick='delete_release(" & Args.DataReader("ReleaseID") & ")' title='Delete' id='Editdata'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>"
                    Else
                        Args.StringToBeInserted = "<td  class='tdstyle' style='text-align:center;'  ><i  style='color:red;' class='fas fa-trash-alt delete_release' data-toggle='tooltip' data-placement='left' data-container='body'   title='Delete' id='Editdata' onclick='delete_release(" & Args.DataReader("ReleaseID") & ")'></i><input type='hidden' name='hdnUserStoryID' value='hdn_" & Args.DataReader("ReleaseID") & "' /></td>"
                    End If
                End If
            Else
                Args.StringToBeInserted = "<td></td>"
            End If
        End If
        If Args.DataField.ToUpper = "PLANVELOCITY" Then
            Cancel = True
            Dim PlanVelocity As String
            Dim ActualVelocity As String
            PlanVelocity = Args.DataReader("PlanVelocity").ToString()
            ActualVelocity = Args.DataReader("ActualVelocity").ToString()
            If PlanVelocity = "" Or ActualVelocity = "" Then
                If PlanVelocity = "" Then
                    PlanVelocity = 0
                End If
                If ActualVelocity = "" Then
                    ActualVelocity = 0
                End If
                Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' data-placement='top' title=""Planned Effort / Actual Effort " & PlanVelocity & "&nbsp;/&nbsp;" & ActualVelocity & """ class='textUStory'><span>" & PlanVelocity & "<span class='lblclass'>/</span>" & ActualVelocity & "</span></div></td>"
            Else
                Args.StringToBeInserted = "<td  title=" & Args.DataField & "><div data-toggle='tooltip' data-placement='bottom' title=""Planned Effort / Actual Effort " & Args.DataReader("PlanVelocity") & "/" & Args.DataReader("ActualVelocity") & """ class='textUStory'><span>" & PlanVelocity & "<span class='lblclass'>/</span>" & ActualVelocity & "</span></div></td>"
            End If
        End If
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function FilterPlotGrid(ByVal Flag As String) As String
        Try

            Dim objReleases As New frmReleaseMonitoring
            If Flag = "AfterLoad" Then
                Return objReleases.WritePage(Flag)
            Else
                Return objReleases.DrawRightSection(Flag)
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    Public Function UploadData()
        If Request.Files.Count > 0 Then
            Dim MimeType As String
            Dim strUserStoryID As String = Request.Params("UserStoryID")
            Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim strFileName As String
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

            Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
            Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
            Dim CharList As String()
            CharList = ValidateFileName.Split(","c)
            For k As Integer = 0 To CharList.Length - 1
                If fileName.Contains(CharList(k).ToString) Then
                    fileName1 = fileName1.Replace(CharList(k).ToString, "")
                End If
            Next
            Dim IsValidFileName As Integer = 1
            Dim ExtensionList As String()
            ExtensionList = fileName.Split("."c)
            If ExtensionList.Length > 2 Then
                IsValidFileName = 0
            End If
            If fileName = fileName1 And IsValidFileName = 1 Then

                Dim response As String = String.Empty
                Dim buffer As Byte() = New Byte(256) {}

                file.InputStream.Read(buffer, 0, 256)
                file.InputStream.Position = 0
                Dim logpath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                'Added By Dipali V On 31st Oct 2022 For File Content Type
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
                Dim magicNumber As String = BitConverter.ToString(buffer)
                magicNumber = magicNumber.Replace("-", " ")
                Dim xmlDoc As New XmlDocument()
                Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                xmlDoc.Load(xmlPath + "MIMEType.xml")
                Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                'Added by imran on 02-01-2023
                'Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
                'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                'Dim count As Integer = ext1.Split("."c).Length - 1
                'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                'If count > 1 Then
                '    MimeType = ""
                'End If

                'If count = 1 Or count2 = 1 Then
                For Each node As XmlNode In nodes
                    xContentType = node.SelectSingleNode("ContentType").InnerText
                    If strFileType = xContentType Then
                        fileName = HttpContext.Current.Request.Files(0).FileName

                        Dim ext As String = Path.GetExtension(fileName)
                        ext = ext.Substring(1, ext.Length - 1).ToLower()
                        extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                        If extfromContentType.IndexOf(ext) > -1 Then
                            MimeType = strFileType
                            Exit For
                        End If
                    End If
                Next
                'End If
                'End of comment by imran on 02-01-2022
            Else
                MimeType = ""
            End If

            If MimeType Is Nothing Or MimeType = "" Then
                MimeType = "unknown/unknowns"
            End If

            If strListofTypes.IndexOf(MimeType) >= 0 Then
                Dim strFullPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "/Attachments/Agile/"

                If Not Directory.Exists(strFullPath) Then
                    Directory.CreateDirectory(strFullPath)
                End If

                file.SaveAs(strFullPath + strFileName + Path.GetExtension(file.FileName))
                Dim strSql As String = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL,NULL," & strUserStoryID & "," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName + Path.GetExtension(file.FileName) & "','" & file.FileName & "','" & file.ContentLength & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                Context.Response.Write(GetAttachmentList1(strUserStoryID, ""))
            Else
                Return "Invalid"
            End If
        End If
        Context.Response.End()
    End Function

    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        If MaxContent > 200 Then MaxContent = 200
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        file.InputStream.Read(buf, 0, MaxContent)
        Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

        If result <> 0 Then
            Marshal.FreeCoTaskMem(mimeout)
            Return ""
        End If

        Dim mime As String = Marshal.PtrToStringUni(mimeout)
        Marshal.FreeCoTaskMem(mimeout)
        Return mime.ToLower()
    End Function
    Public Function sprint_form(Optional SprintID As String = "", Optional Sprintname As String = "", Optional Description As String = "", Optional SprintStartDate As String = "", Optional SprintEndDate As String = "", Optional SprintDuration As String = "", Optional SprintVelocity As String = "", Optional BusinessDuration As String = "") As String
        '=====================================================================
        ' Procedure Name        :	sprint_form
        ' Purpose               :	sprint_form
        ' Description           :	Open Sprint
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	9h-March-2018
        ' Revisions             :
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim Disabled As String = ""
        GetAccessRights()
        ' strHTML.Append(" <form class='details_form'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If Sprintname = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", , 100, Sprintname, , , , IIf(Sprintname = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If strIsPrductOwner = 1 Then
            Disabled = "True"
        Else
            Disabled = "False"
        End If
        If SprintStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate') onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", , 100, SprintStartDate, , , , IIf(SprintStartDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate')", True, , , , , , True))
        End If
        strHTML.Append("<i class='fa fa-calendar-check-o' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If SprintEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate') onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", , 100, SprintEndDate, , , , IIf(SprintEndDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate')", True, , , , , , True))
        End If
        strHTML.Append("<i class='fa fa-calendar-check-o' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-6 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Calendar Day's' >Calendar Day's Duration</label> ")
        strHTML.Append(" <div class='col-md-6'>")
        If SprintDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", , 100, SprintDuration, , , , IIf(SprintDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-6 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Business Day's' >Business Day's Duration</label> ")
        strHTML.Append(" <div class='col-md-6'>")
        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, BusinessDuration, , , , IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If SprintVelocity = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", , 100, SprintVelocity, , , , IIf(SprintVelocity = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")







        strHTML.Append("<div class='row'>")

        strHTML.Append("<div class='col-md-12 align-center' style='margin-top: 20px;margin-bottom:40px;'>")
        GetAccessRights()
        If (UniqueID <> "" Or UniqueID <> "0") And Sprintname <> "" Then
            If m_objAccess.Edit Then
                If strIsPrductOwner = 1 Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")'><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                Else
                    strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                End If
            End If
        Else
            If Sprintname = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addsprint'  data-toggle='tooltip' data-placement='top'  title='Save' onclick='SaveSprintRelease(""Sprint"")'>Save</button>&nbsp;&nbsp;&nbsp;")
                End If
            End If
        End If
        If m_objAccess.Delete Then
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	5th-March-2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)
        Try

            Dim StrColorQuery As String = ""
            StrColorQuery = "EXEC usp_Ng2_sel_tbl_NG2_ColorMaster"
            Dim intColorID As Integer
            Dim strColor As String
            Dim drGetColorMaster As IDataReader
            Dim index As Integer = 0
            Dim strHTML As New StringBuilder
            drGetColorMaster = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            strHTML.Append("<tr>")
            While drGetColorMaster.Read
                intColorID = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("ColorID").ToString, "")
                strColor = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("Color").ToString, "")
                index = index + 1
                strHTML.Append("<td style='padding:7px!important;'>")
                strHTML.Append("<a onclick=ChangeColor('" & Id & "','" & strColor & "','" & strMode & "') value=" & intColorID & "><i style='cursor:pointer;color:" & strColor & "!important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                strHTML.Append("</td>")
                If index = 15 Then
                    strHTML.Append("</tr>")
                    strHTML.Append("<tr>")
                    index = 0
                End If


            End While
            strHTML.Append("</tr>")


            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'For Release Details Page
    <System.Web.Services.WebMethod()>
    Public Shared Function Modal_popupdashboard(ByVal ReleaseID As String)
        '=====================================================================
        ' Purpose				:	Modal_popupdashboard
        ' Author				:	Dipali V
        ' Created				:	19th April 2018
        '=====================================================================
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder()
            Dim strSQL As String = ""
            Dim drReleaseDetails As IDataReader
            Dim Flag As String = "Release"
            strSQL = "usp_NG2_GetSprintReleaseDetails " & ReleaseID & "," & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",'" & Flag & "'"
            drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            Dim IterationID As String = ""
            Dim IterationName As String = ""
            Dim Description As String = ""
            Dim SprintStartDate As String = ""
            Dim SprintEndDate As String = ""
            'Dim ReleaseID As String = ""
            Dim SprintVelocity As String = ""
            Dim SprintDuration As String = ""
            Dim BusinessDuration As String = ""
            Dim IterationStartDate As String = ""
            Dim IterationStatus As String = ""
            Dim IsIterationComplete As String = ""

            Dim DoListCount As String = ""
            Dim InProgressCount As String = ""
            Dim DoneCount As String = ""
            Dim TaskCount As String = ""
            Dim DiscussionCount As String = ""
            Dim IssueCount As String = ""
            Dim NoOfDays As String = ""
            Dim StoryPoint As String = ""
            If drReleaseDetails.Read Then
                '  IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
                Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                ' BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "")
                ' IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Status"), "")
                IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsReleaseComplete"), "")

                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
                DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
                TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
            End If
            Dim strResult As String = ""
            strResult = IterationName & "##" & Description & "##" & SprintStartDate & "##" & SprintEndDate & "##" & SprintDuration & "##" & SprintVelocity & "##" & BusinessDuration

            Dim objfrmReleaseMonitoring As New frmReleaseMonitoring()

            strGridHTML.Append(objfrmReleaseMonitoring.Drawdashboard(ReleaseID))
            Return strGridHTML.ToString & "||" & strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Public Function Drawdashboard(ByVal UniqueID As String) As String
        '=====================================================================
        ' Purpose				:	Drawdashboard
        ' Author				:	Dipali V
        ' Created				:	19th April 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()

        strHTML.Append("<div id='SprintDetails'>")
        strHTML.Append(Release_header(UniqueID))
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function

    Public Function Release_header(ByVal UniqueID As String) As String
        '=====================================================================
        ' Purpose				:	sprint_header
        ' Author				:	Dipali V
        ' Created				:	19th April 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim Flag As String = "Release"
        Dim drReleaseDetails As IDataReader
        strSQL = "usp_NG2_GetSprintReleaseDetails " & UniqueID & "," & Session("intProjectID") & "," & Session("intUserID") & ",'" & Flag & "'"
        drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
        Dim ReleaseID As String = ""
        Dim ReleaseName As String = ""
        Dim IterationName As String = ""
        Dim Description As String = ""
        Dim SprintStartDate As String = ""
        Dim SprintEndDate As String = ""
        Dim SprintVelocity As String = ""
        Dim SprintDuration As String = ""
        Dim BusinessDuration As String = ""
        Dim IterationStartDate As String = ""
        Dim IterationStatus As String = ""
        Dim IsIterationComplete As String = ""
        Dim NoOfDays As String = ""
        Dim StoryPoint As String = ""
        Dim DoListCount As String = ""
        Dim InProgressCount As String = ""
        Dim DoneCount As String = ""
        Dim TaskCount As String = ""
        Dim DiscussionCount As String = ""
        Dim IssueCount As String = ""
        Dim ReviewCount As String = ""
        Flag = "Release"

        Dim plannedEfforts As String = ""
        Dim actualEfforts = ""
        Dim Duration As String = ""
        Dim Velocity As String = ""

        If drReleaseDetails.Read Then
            ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
            ReleaseName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
            Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
            SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
            SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
            ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
            SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
            SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
            BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "")
            ' IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
            IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Status"), "")
            IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsReleaseComplete"), "")
            Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
            Velocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
            StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
            plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
            actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
            'IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
            DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
            InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
            DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
            TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
            IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
            DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
            NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
        End If




        If DoListCount = "" Then
            DoListCount = "0"
        Else
            DoListCount = DoListCount
        End If


        If InProgressCount = "" Then
            InProgressCount = "0"
        Else
            InProgressCount = InProgressCount
        End If


        If DoneCount = "" Then
            DoneCount = "0"
        Else
            DoneCount = DoneCount
        End If


        If ReviewCount = "" Then
            ReviewCount = "0"
        Else
            ReviewCount = ReviewCount
        End If


        If DiscussionCount = "" Then
            DiscussionCount = "0"
        Else
            DiscussionCount = DiscussionCount
        End If


        If IssueCount = "" Then
            IssueCount = "0"
        Else
            IssueCount = IssueCount
        End If


        Dim title As String = ""
        Dim editName As String = ""
        Dim ControlCaption As String = ""
        Dim PageCaption As String = ""
        Dim strColor As String = "#449d44"

        title = "Release ID"
        editName = "Edit Release Name"
        ControlCaption = "Release Name"
        PageCaption = "Release Details"




        strHTML.Append("<div class='row' style='border-bottom:1px solid #ddd'>" & vbCrLf)
        strHTML.Append("<div class='col-md-1 col-sm-2 col-sm-2'>" & vbCrLf)
        'strHTML.Append("<div style='height:50px;width:50px;background-color:" & strPriorityColor & ";' class='img-circle' ></div>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='font-size: 50px;color:" & strColor & ";'></i>")
        strHTML.Append("<p style='color: white;font-weight: 600;font-size: 15px;position: absolute;top: 9px;left: 3px;width: 35px;    transform: translate(20%, 0); text-align: center;'><Span data-toggle='tooltip' data-placement='bottom'  title='" & title & "'>" & ReleaseID & "</span></p></div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-2 col-sm-3' style='margin-top:1%'>" & vbCrLf)
        strHTML.Append("<label class='headerPage'>" & PageCaption & " </label>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='col-md-8 col-sm-7' style='float:right;margin-left: auto;width: 19%;'>") 'style='float:right;margin-left:61%;margin-top:-2%'
        'strHTML.Append("<div class='col-sm-6' style='float:right;margin-left:61%;margin-top:-2%'>")
        strHTML.Append("<div class='input-group' style='float:right;'  id='Export'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div class='dropdown'><button type='button' class='btn btn-info dropdown-toggle'  id='btnExport'  data-bs-toggle='dropdown'  aria-haspopup='true' title='Export' data-original-title='Export' title='Export'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i></button>&nbsp;&nbsp;")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("<div class='dropdown-menu''>")
        strHTML.Append("<ul>")
        strHTML.Append("<li  onclick=Export_onclick(" & ReleaseID & ",'PDF') >&nbsp;PDF</li>")
        'strHTML.Append("<a class='dropdown-item' href='#' onclick=Export_onclick('Release','Excel')>&nbsp;Excel</a>")
        strHTML.Append("<li onclick=Export_onclick(" & ReleaseID & ",'Excel') >&nbsp;Excel</li>")
        'strHTML.Append("<a class='dropdown-item' href='#' onclick=Export_onclick('Release','Excel')>&nbsp;Excel</a>")
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='bottom' onclick='RefreshAllPage()'>&times;</button>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")



        strHTML.Append("</div>")


        strHTML.Append("<div class='row' style='margin-top:1%'>" & vbCrLf)
        strHTML.Append("<div class='col-md-2 col-sm-4 col-sm-4'>") 'id='divReleaseName'
        strHTML.Append("<label class='headerPage'>" & ControlCaption & ": </label>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-3 col-sm-12' style='margin-bottom:10px;'>")
        'strHTML.Append("<label class='labelclassIterationID' title='Iteration ID'>" & IterationID & "</label>&nbsp;&nbsp;")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", , , , ReleaseName, , , True, , , , "onblur=""ChangeReleaseName(" & ReleaseID & ")"" data-toggle='tooltip' data-placement='top' title='' data-original-title='Release Name'", True, , , , , , True))
        strHTML.Append("<i class='fas fa-pencil-alt' id='editReleaseName' onclick=""editReleaseName('" & ReleaseName & "')"" title='" & editName & "' ></i>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='col-md-6 col-sm-12 col-sm-12' style='display:inline-flex;'>")
        strHTML.Append("<p  style='color:  #428bca;    font-size: 12px;white-space: nowrap;margin-bottom:0%;text-overflow: ellipsis;' ><label class='labelclass' title='Start Date To End Date' data-toggle='tooltip'>" & SprintStartDate & "   To    " & SprintEndDate & "</label>&nbsp;&nbsp;")
        If Duration <> "" Then
            strHTML.Append("<label class='labelclass' title='Duration' data-toggle='tooltip'>" & Duration & "</label>&nbsp;&nbsp;")
        Else
            strHTML.Append("<label class='labelclass' title='Duration' data-toggle='tooltip'>0.00</label>&nbsp;&nbsp;")
        End If


        If Duration <> "" Then
            strHTML.Append("<label class='labelclass' title='Story Point' data-toggle='tooltip'>" & StoryPoint & "</label>&nbsp;&nbsp;")
        Else
            strHTML.Append("<label class='labelclass' title='Story Point' data-toggle='tooltip'>0.00</label>&nbsp;&nbsp;")
        End If

        'If plannedEfforts <> "" And actualEfforts <> "" Then
        '    strHTML.Append("<label class='labelclass' title='Planned Effort / Actual Effort' data-toggle='tooltip'>" & plannedEfforts & "/" & actualEfforts & "</label>")
        'Else
        '    strHTML.Append("<label class='labelclass' title='PlannedEffort / ActualEffort' data-toggle='tooltip'>0.00/0.00</label>&nbsp;&nbsp;")
        'End If


        strHTML.Append("&nbsp;&nbsp;</p>")
        If IterationStatus <> "" Then
            If IterationStatus.ToUpper = "READY FOR RELEASE" Then
                strHTML.Append("<div id='divBtn' class='btn-group' style='display:inline-flex;'>" + vbCrLf)
                strHTML.Append("<div class='btn btnrelease btnType' id='btnStatus'>" & IterationStatus & "</div>" + vbCrLf)
                strHTML.Append("<button class='btn btn-info dropdown-toggle' aria-expanded=false type=button data-bs-toggle=dropdown  onclick=OpenDropDown('divBtn')>" + vbCrLf)
                strHTML.Append("<span><i id='iChevTimesheet' style='white-space:normal;font-size:12px!important;' class='fa fa-chevron-down'></i></span>" + vbCrLf)
                strHTML.Append("<span class=sr-only>Toggle Dropdown</span>" + vbCrLf)
                strHTML.Append("</button>" + vbCrLf)
                strHTML.Append("<ul class=dropdown-menu role=menu>" + vbCrLf)
                strHTML.Append("<li><a onClick=Status_onChange('Released')>Released</a></li>" + vbCrLf)
                strHTML.Append("</ul>" + vbCrLf)
                strHTML.Append("</div>" + vbCrLf)
            Else
                strHTML.Append("<button type='button' class='btn btnrelease'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release' style='cursor:text!important'>" & IterationStatus & "</button>")
            End If
            'Else
            '    strHTML.Append("<button type='button' class='btn btn-info'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release' style='cursor:text!important'>Ready For Release</button>")

        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<hr id='dash_hr'>")

        strHTML.Append(sprint_tab(UniqueID))
        strHTML.Append("<input type='hidden' value='" & UniqueID & "' id='hdnReleaseIDnew' />")
        strHTML.Append(Graph_section(UniqueID, "Release", ReleaseName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, IterationStatus))


        Return (strHTML.ToString())

    End Function
    Public Function sprint_tab(ByVal UniqueID As String) As String
        '=====================================================================
        ' Purpose				:	sprint_tab
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row ' id='Tabs'>")
        '  strHTML.Append("&nbsp;<i class='fa fa-angle-double-left' aria-hidden='true' style='color:#5bc0de;font-size:20px!important;' id='ReleaseSprintPer' title='Previous Tab' onclick=""PreSprintRelease('Release')""></i>" & vbCrLf)


        strHTML.Append("<ul class='' id='tab_link' style=''>" & vbCrLf)

        strHTML.Append("<li   style='   border-left: transparent;'><a href='#div_details' id='tab_content' title='Details' style='   border-left: transparent;'  >Details</a></li>" & vbCrLf)
        strHTML.Append("<li ><a href='#graph' id='tab_content' title='Charts' data-toggle='tooltip' data-placement='bottom' >Charts</a></li>" & vbCrLf)

        strHTML.Append("<li ><a href='#Sprints' title='Sprints' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Sprints</a></li>" & vbCrLf)

        strHTML.Append("<li><a href='#div1'  title='User Stories'  id='tab_content'  data-toggle='tooltip' data-placement='bottom' >User Stories</a></li>" & vbCrLf)

        'If Flag <> "Sprint" Then
        ' strHTML.Append("<li ><a href='#Issues' id='tab_content'>Issues</a></li>&nbsp;&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a  onclick=""RefreshTab('Teams','Release'," & UniqueID & ",'Teams')"" href='#Teams'   title='Teams' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Teams</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#Tasks'  title='Tasks'  id='tab_content' data-toggle='tooltip' data-placement='bottom' >Tasks</a></li>" & vbCrLf)
        'End If
        strHTML.Append("<li><a href='#div6'  title='Issues' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Issues</a></li>" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Discussion','Release'," & UniqueID & ",'div2')"" href='#div2'  title='Discussions'  id='tab_content' data-toggle='tooltip' data-placement='bottom' >Discussions</a></li>" & vbCrLf)
        strHTML.Append("<li><a  onclick=""RefreshTab('Reviews','Release'," & UniqueID & ",'div9')"" href='#div9'  title='Reviews' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Reviews</a></li>" & vbCrLf)
        'If Flag <> "Sprint" Then

        strHTML.Append("<li ><a href='#ImpedimentsLogs'  title='Impediments Logs' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Impediments Logs</a></li>" & vbCrLf)


        strHTML.Append("<li><a href='#Risks'   title='Risks' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Risks</a></li>" & vbCrLf)

        strHTML.Append("<li><a  onclick=""RefreshTab('History','Release'," & UniqueID & ",'History')"" href='#History'   title='History' id='tab_content' data-toggle='tooltip' data-placement='bottom' >History</a></li>" & vbCrLf)
        ' End If
        strHTML.Append("<li ><a href='#div3'   title='Attachments' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Attachments</a></li>" & vbCrLf)


        strHTML.Append("</ul>")
        '   strHTML.Append("<i class='fa fa-angle-double-right' aria-hidden='true' style='color:#5bc0de;font-size:20px!important' id='ReleaseSprintNext' title='Next Tab' title='Next Tab' onclick=""NextSprintRelease('Release')""></i>" & vbCrLf)
        strHTML.Append("</div>")


        strHTML.Append("<div id='ContainAllDivs'>")
        strHTML.Append("<div id='sprint_details' style='overflow-y:auto;overflow-x:hidden;height:280px; ' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='20'>")


        Return (strHTML.ToString())

    End Function
    Public Function Graph_section(ByVal ReleaseID As String, ByVal Flag As String, ByVal IterationName As String, ByVal Description As String, ByVal SprintStartDate As String, ByVal SprintEndDate As String, ByVal SprintDuration As String, ByVal SprintVelocity As String, ByVal BusinessDuration As String, ByVal IterationStatus As String) As String
        '=====================================================================
        ' Purpose				:	Graph_section
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()

        strHTML.Append("<div id='div_details' style='height:600px;' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion' style='  border-bottom: 2px solid rgb(60, 141, 188)!important;' >Release Details</h2>")
        'strHTML.Append("<hr/>")
        strHTML.Append(Release_form(ReleaseID, IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, IterationStatus))
        strHTML.Append("</div>")

        strHTML.Append("<div id='graph' style='height:600px!important;margin-top:40px;'  class='clsBox'>") ' Graph
        strHTML.Append(Graph_SprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>") 'End Graph

        If Flag <> "Sprint" Then
            strHTML.Append("<div id='Sprints' style='height:500px;'  class='clsBox'>")
            ' strHTML.Append("<p>User Stories</p>")
            strHTML.Append(Sprints_sectionSprintRelease(ReleaseID, Flag, IterationStatus))
            strHTML.Append("</div>")
        End If

        strHTML.Append("<div id='div1' style='height:500px;'  class='clsBox'>")
        ' strHTML.Append("<p>User Stories</p>")
        strHTML.Append(USerStories_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='Teams' style='height:500px;'  class='clsBox'>")
        strHTML.Append(Teams_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")

        strHTML.Append("<div id='Tasks' style='height:500px;'  class='clsBox'>")
        strHTML.Append(Tasks_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='div6' style='height:500px;'  class='clsBox'>")
        strHTML.Append(Issues_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")

        strHTML.Append("<div id='div2' style='height:550px!important;width:100%;'  class='clsBox'>")
        strHTML.Append(Discussion_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='div9' style='height:500px;margin-bottom:50px;'  class='clsBox'>")
        strHTML.Append(Reviews_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")


        If Flag <> "Sprint" Then
            strHTML.Append("<div id='ImpedimentsLogs' style='height:500px;'  class='clsBox'>")
            strHTML.Append(ImpedimentsLogs_sectionSprintRelease(ReleaseID, Flag))
            strHTML.Append("</div>")
        End If

        If Flag <> "Sprint" Then
            strHTML.Append("<div id='Risks' style='height:500px;'  class='clsBox'>")
            strHTML.Append(Risks_sectionSprintRelease(ReleaseID, Flag))
            strHTML.Append("</div>")
        End If


        strHTML.Append("<div id='History' style='height:500px;'  class='clsBox'>")
        strHTML.Append(History_sectionSprintRelease(ReleaseID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='div3' style='height:500px;'  class='clsBox'>")
        strHTML.Append(Attachment_sectionSprintRelease(ReleaseID, Flag, "", IterationStatus))
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function
    Public Function Release_form(Optional ReleaseID As String = "", Optional Releasename As String = "", Optional Description As String = "", Optional ReleaseStartDate As String = "", Optional ReleaseEndDate As String = "", Optional ReleaseDuration As String = "", Optional ReleaseVelocity As String = "", Optional BusinessDuration As String = "", Optional IterationStatus As String = "") As String
        '=====================================================================
        ' Procedure Name        :	Release_form
        ' Purpose               :	Release_form
        ' Description           :	Open Release
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	9h-March-2018
        ' Revisions             :
        '=====================================================================


        Dim strHTML As New StringBuilder()
        GetAccessRights()

        ' strHTML.Append(" <form class='details_form'>")
        strHTML.Append(" <div class='details_tab'  style='margin-top:4%;height: 400px;overflow-y:auto;overflow-x:hidden;'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Release Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10'>")
        'IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = ""), False, True)
        If Releasename = "" And UniqueID = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        Else
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If IterationStatus = "Not Planned" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", , 100, Releasename, , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", , 100, Releasename, , , True, , True, , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", , 100, Releasename, , , True, , True, , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
            End If
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-md-10'>")




        If Description = "" And UniqueID = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , ,  ,, 1000, , , , , , , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription') data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right:-26px;' id='countdownRelease'>1000</p>")

        Else
            Dim len As Integer = 1000
            Dim len1 As Integer
            If Description.Length <> -1 Then
                len1 = Description.Length
                len = 1000 - len1
            End If
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If IterationStatus = "Not Planned" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , , , , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')  data-autoresize", True, EnableHTMLEncode:=True))
                    strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right:-26px;' id='countdownRelease'>" & len & "</p>")
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , True, True, , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')  data-autoresize", True, EnableHTMLEncode:=True))
                    strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right -26px;' id='countdownRelease'>" & len & "</p>")

                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , True, True, , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')  data-autoresize", True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right -26px;' id='countdownRelease'>" & len & "</p>")

            End If
        End If



        'strHTML.Append("<textarea  name='txtDescription' Id='txtDescription'  class='form-control'style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;' ></textarea>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div style='display:flex'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")

        'If ReleaseStartDate = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
        'Else
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = ""), False, True), , , "onkeyup=ClearSpan('RstartDate','spanRstartDate')", True, , , , , , True))

        'End If
        If ReleaseStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
        Else
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If IterationStatus = "Not Planned" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , True, True, , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))

                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , True, True, , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
            End If
        End If

        ''Commented and Added by Usha Pandit on 22.04.2019 for not showing calender if release is already started
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -35px; float:right;color:#0099CC;' id='#dpRSDate' onclick=""$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');""></i>")
        If IterationStatus = "Not Planned" Then
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -35px; float:right;color:#0099CC;' id='#dpRSDate' onclick=""$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');""></i>")
        End If
        ''End of Added by Usha Pandit on 22.04.2019 for not showing calender if release is already started

        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")

        'If ReleaseEndDate = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
        'Else
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = ""), False, True), , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')", True, , , , , , True))
        'End If

        If ReleaseEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
        Else
            If IterationStatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , True, True, , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , True, True, , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
            End If
        End If

        ''Commented and Added by Usha Pandit on 22.04.2019 for not showing calender if release is already started
        'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -35px;float:right;color:#0099CC;' id='#dpRendate'  onclick=""$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');""></i>")
        If IterationStatus = "Not Planned" Then
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; margin-top: -35px;float:right;color:#0099CC;' id='#dpRendate'  onclick=""$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');""></i>")
        End If
        ''End of Added by Usha Pandit on 22.04.2019 for not showing calender if release is already started

        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div style='display:flex'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Calendar Day's' >Calendar Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")

        If ReleaseDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        Else
            If IterationStatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , , , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , True, , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , True, , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Business Day's' >Business Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")

        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        Else
            If IterationStatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , , , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , True, , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , True, , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")





        strHTML.Append("<div class='row' style='float:right'>")
        strHTML.Append("<div class='col-md-12 update_btn'>")
        GetAccessRights()
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addRelease'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='display:none' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")
        If (UniqueID <> "" Or UniqueID <> "0") And Releasename <> "" Then
            'If IterationStatus.ToUpper = "Not Planned" Then
            If m_objAccess.Edit Then
                'If strIsPrductOwner = 1 Then
                '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")'><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                'Else
                '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")

                'End If

                If strIsPrductOwner = 1 Then
                    If IterationStatus = "Not Planned" Then
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")'><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                    Else
                        ''Commented and Added by Usha Pandit on 22.04.2019 for disabling release if it is started
                        'strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")'><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' ><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                        ''End of Added by Usha Pandit on 22.04.2019 for disabling release if it is started
                    End If
                Else
                    strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' ><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")

                End If
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-right' aria-hidden='true'></i>Next</button>")
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addPrerelase'  style='display:none' title='Previous' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-left' aria-hidden='true'></i>Previous</button>")
            End If
            'End If
        Else
            If Releasename = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addRelease'  data-toggle='tooltip' data-placement='top'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")

                End If
            End If
        End If
        If m_objAccess.Delete Then
            ' strHTML.Append("&nbsp;&nbsp;<i class='fas fa-trash-alt' aria-hidden='true' onclick='Delete_UserStory(" & UserStoryId & ")'></i>")
        End If
        'If UniqueID <> "" Then
        '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")

        'End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function
    Public Function Graph_SprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='graph' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion' style='border-bottom: 2px solid rgb(60, 141, 188)!important;'>Chart</h2>")

        strHTML.Append("<div style='display:flex'>")
        strHTML.Append("<nav class='col-sm-3' id='myScrollspy'>")
        strHTML.Append("<ul class='nav nav-pills nav-stacked'>")



        strHTML.Append("<li><a href='#BurnDown' class='active'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
        strHTML.Append("<li><a href='#BurnUp'  >Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
        strHTML.Append("<li><a href='#Velocity' >Velocity</a></li>") 'onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")""
        strHTML.Append("<li><a href='#Flow' >Flow</a></li>") 'onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")""
        strHTML.Append("<li><a href='#ComSprint' >Com-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")""
        strHTML.Append("<li><a href='#CanSprint' >Can-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")""

        strHTML.Append("</ul>")
        strHTML.Append(" </nav>")
        strHTML.Append("<div class='col-sm-9  col-sm-9 scrollspy-example' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='5' style=''>")

        strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "BurnDown"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "BurnUp"))
        strHTML.Append("</div>")



        strHTML.Append("<div id='Velocity' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Velocity</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "Velocity"))
        strHTML.Append("</div>")


        strHTML.Append("<div id='Flow' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Flow</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "Flow"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='ComSprint' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Com-Sprint</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "ComSprint"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='CanSprint' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Can-Sprint</h3>")
        strHTML.Append(PlotBurnDown(ReleaseID, Flag, "CancelSprint"))
        strHTML.Append("</div>")
        strHTML.Append("<br>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")




        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function PlotBurnDown(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder()
        If GraphFlag = "BurnDown" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append(GetBurnDownGraph(ReleaseID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>") 'float:right;margin-top:-40%;margin-right:-4%'
            strHTML.Append(GetBurnupGraph(ReleaseID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Velocity" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append(GetVelocityEffortBarGraph(ReleaseID, Flag, GraphFlag))
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetVelocitySToryPointsBarGraph(ReleaseID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "BurnUp" Then
            strHTML.Append("<div class='divLineGraph' style=height:547px'>")
            strHTML.Append(GetBurnupGraphEfforts(ReleaseID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetBurnupGraphStoryPoints(ReleaseID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Flow" Then
            strHTML.Append("<div class='divLineGraph' style='height:126%!important'>")
            strHTML.Append(GetFlowGraphEfforts(ReleaseID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            ' strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            'strHTML.Append(GetFlowGraphStoryPoints(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")

        ElseIf GraphFlag = "ComSprint" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            ' strHTML.Append(GetComSprint(SprintID, Flag, GraphFlag))
            strHTML.Append("<div id='ComSprintGrid" & ReleaseID & "' class=''>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")

        ElseIf GraphFlag = "CancelSprint" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append("<div class='' id='CanSprintGrid" & ReleaseID & "'>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString()

    End Function
    Public Function GetFlowGraphEfforts(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='FlowGraphEfforts" & ReleaseID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnupGraphEfforts(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphEfforts" & ReleaseID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnupGraphStoryPoints(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphStoryPoints" & ReleaseID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnDownGraph(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnDown" & ReleaseID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetBurnupGraph(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnUp" & ReleaseID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    '''End of BurnDown/DurnUP Graph
    ' For Velocity Graph
    Public Function GetVelocityEffortBarGraph(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)

        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocityEffortBar" & ReleaseID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function GetVelocitySToryPointsBarGraph(ByVal ReleaseID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocitySToryPoints" & ReleaseID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function

    Public Function Sprints_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String, ByVal IterationStatus As String) As String
        '=====================================================================
        ' Procedure  Name		:	Sprints_sectionSprintRelease
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To Plot Sprints
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    6th-March-2018
        '=====================================================================

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divSprints' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'     style='border-bottom: 2px solid rgb(60, 141, 188)!important; margin-top: 0%;'>Sprints Details</h2>")

        If IterationStatus.ToUpper <> "RELEASED" Then
            strHTML.Append("<h2 class='HeaderLine' style=''><a onclick=ShowSprintData('List') title='Mapped Sprint Details' data-toggle='tooltip' data-placement='bottom' >List</a> | <a onclick=ShowSprintData('Form') title='Mapped Sprint' data-toggle='tooltip' data-placement='bottom' >Add</a></h2>")
        Else
            strHTML.Append("<h2 class='HeaderLine' style=''><a onclick=ShowSprintData('List') title='Mapped Sprint Details' data-toggle='tooltip' data-placement='bottom' >List</a></h2>")
        End If

        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divSprintList'>")
        strHTML.Append(PlotSprintList(SprintID))
        strHTML.Append("</Div>")
        strHTML.Append("<Div class='col-sm-12' id='divRemarks' style='display:none'>")
        strHTML.Append("<table class='clsRemark' id='tblRemark" & SprintID & "'  >")
        strHTML.Append("<tr>")
        strHTML.Append("<td style='text-align: left;border: 0px!important'>")
        strHTML.Append(" Remarks : ")
        strHTML.Append("</td>")
        strHTML.Append("<td style='text-align: left;border: 0px!important'>")
        'Added & Commented By Dipali V On 15th july 2020 For max length restriction
        'strHTML.Append("<textarea id='txtRemark" & SprintID & "'  ShowLength=2000 data-autoresize onkeyup=CheckTextLength(this,'smallRemark_" & SprintID & "','spanRemark" & SprintID & "')   class='clsTextArea' ></textarea>")
        strHTML.Append("<textarea id='txtRemark" & SprintID & "'  maxlength='2000' ShowLength=2000 data-autoresize onkeyup=CheckTextLength(this,'smallRemark_" & SprintID & "','spanRemark" & SprintID & "')   class='clsTextArea' ></textarea>")
        'End of Added & Commented By Dipali V On 15th july 2020 For max length restriction
        strHTML.Append("<small name='smallRemark' Id='smallRemark_" & SprintID & "'  class='clsSpanRemark'> -2000</small>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("<tr>")
        strHTML.Append("<td>")
        strHTML.Append("</td>")
        strHTML.Append("<td class='spnCss'>")
        strHTML.Append("<span id='spanRemark" & SprintID & "' style='color:red; display:none'>Please Enter Remark.</span>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("<tr>")
        strHTML.Append("<td>")
        strHTML.Append("</td>")
        strHTML.Append("<td style='text-align:right;'>")
        strHTML.Append("<button type='button' id='btnRemark" & SprintID & "' class='btn btn-default clsterminate' style='width:auto;background-color: #3C8DBC!important;color: white;float:right;' onclick=""TerminateSprint1(" & SprintID & ",'txtRemark" & SprintID & "','SprintUnmappedFromRelease')"" >Unmap From Release</button>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")

        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divSprintForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-toggle='tooltip' style='float:right;margin-top: 1%; margin-right: -1%' title='Save' onclick=Save_SubTab_Data(" & SprintID & ",'MappedSprint') class='fa fa-save'></i>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row' style='display:block!important' id='ListGridUnmapped'>")
        strHTML.Append(WriteGrid("NoTMapped", "", ""))
        strHTML.Append("</div>")
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Function PlotSprintList(ByVal ReleaseID As String)
        '=====================================================================
        ' Procedure  Name		:	PlotSprintList
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To Plot SprintList
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   6th-March-2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""
        Dim IsRecord As Integer = 0
        Dim IterationID As String = ""
        Dim IterationName As String = ""
        ' Dim IterationID As String = ""
        Dim EndDate As String = ""
        Dim StartDate As String = ""
        Dim drSubstory As IDataReader
        strSql = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",NUll"
        Dim drTabData As IDataReader
        Dim IterationStatus As String = ""
        Dim CurrentIteration As String = ""
        drTabData = CommonFunctions.Data.GetDataReader(strSql, True)
        While drTabData.Read
            IsRecord = 1
            IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationID"), "")
            IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(drTabData("StartDate"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drTabData("EndDate"), "")
            PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("PlannedEffort"), "")
            ActualEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("ActualEffort"), "")
            DoListCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoListCount"), "")
            InProgressCount = CommonFunctions.Data.CheckIsDBNull(drTabData("InProgressCount"), "")
            DoneCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoneCount"), "")
            DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DiscussionCount"), "")
            ReviewCount = CommonFunctions.Data.CheckIsDBNull(drTabData("ReviewCount"), "")
            ReleaseID = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseID"), "")
            NoOfDays = CommonFunctions.Data.CheckIsDBNull(drTabData("NoOfDays"), "")
            IterationStatus = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationStatus"), "")
            CurrentIteration = CommonFunctions.Data.CheckIsDBNull(drTabData("CurrentIteration"), "")

            strHTML.Append("<div class=''>" & vbCrLf)

            strHTML.Append("<div class='col-sm-12 team_cards'>" & vbCrLf)
            strHTML.Append("<div class='sprint_card' id='SprintList_" & IterationID & "'>" & vbCrLf)
            strHTML.Append("<div class='card-header clsUnmappendheader'  >" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
            If CurrentIteration <> False Then
                strHTML.Append("<i class='fa fa-star' aria-hidden='true' style='color:#ffc107 !important' title='Current Sprint'  data-toggle='tooltip' data-placement='bottom'></i>")

            End If
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>" & vbCrLf)
            strHTML.Append("<p style=' color:#777777!important;  font-size: 16px;font-weight: 700;' ><span data-toggle='tooltip' data-placement='bottom' title='Sprint Name'>" & IterationName & "</span>")
            strHTML.Append("</span></p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>" & vbCrLf)
            strHTML.Append("  <p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' ><i class='far fa-clock'></i>&nbsp;<span data-toggle='tooltip' data-placement='bottom' title='Start Date  To  End Date '>" & StartDate & "  To  " & EndDate & "</span></p>")
            strHTML.Append("</div>")







            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='card-block' style='margin-left:1%'>" & vbCrLf)
            strHTML.Append("<div class='row' style='margin-top:60px'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3 align-top'>" & vbCrLf)
            strHTML.Append(" <p style=' color:#777777!important;  font-size: 16px;font-weight: 700;white-space: nowrap;text-align:center' title='Sprint ID' data-toggle='tooltip' data-placement='bottom'>" & IterationID & "</p>" & vbCrLf)
            strHTML.Append("</div>")

            'strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='col-sm-7 align-top clsunmappedAllcounts'>")
            strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='font-size: 16px;'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            If DiscussionCount <> "" Then
                ''Commented and Added by Usha Pandit on 29 Apr 2019 for AfterRelaseSprintSave undefined javascript
                'strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='Reply Count'  onclick=""AfterRelaseSprintSave('div2'," & IterationID & ")"">  <span class='label  discussioncount'  data-toggle='tooltip' data-placement='bottom' title='" & DiscussionCount & "'>" & DiscussionCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")


                'Commented And added by Chetan M on 30th Jully 2020 for Issue ID = 25477
                '    strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='Reply Count'>  <span class='label  discussioncount'  data-toggle='tooltip' data-placement='bottom' title='" & DiscussionCount & "'>" & DiscussionCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
                '    ''End of Added by Usha Pandit on 29 Apr 2019 for AfterRelaseSprintSave undefined javascript
                'Else
                '    strHTML.Append("<i class='far fa-comments fa-border icon-grey'  title='Reply Count ' ><span class='label discussioncount' data-placement='bottom' title='0'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
                'End If

                'If ReviewCount <> "" Then
                '    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='Review Count '><span class='label discussioncount reviewCount'  data-toggle='tooltip' data-placement='bottom' title='" & ReviewCount & "'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
                'Else
                '    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='Review Count '><span class='label discussioncount reviewCount'  data-toggle='tooltip' data-placement='bottom' title='0'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                'End If
                strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='label discussioncount' data-original-title='Reply Count' data-toggle='tooltip' data-placement='top' title='" & DiscussionCount & "'>" & DiscussionCount & "</span></i>")
                ''End of Added by Usha Pandit on 29 Apr 2019 for AfterRelaseSprintSave undefined javascript
            Else
                strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='label discussioncount' data-placement='top' data-original-title='Reply Count' title='0'>0</span></i>")
            End If

            If ReviewCount <> "" Then
                strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey'><span class='label discussioncount reviewCount'  data-original-title='Review Count ' data-toggle='tooltip' data-placement='bottom' title='" & ReviewCount & "'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey'><span class='label discussioncount reviewCount' data-original-title='Review Count ' data-toggle='tooltip' data-placement='bottom' title='0'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            'End of Commented And added by Chetan M on 30th Jully 2020 for Issue ID = 25477


            'strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;' onclick=""AfterRelaseSprintSave('Sprint'," & IterationID & ")""></i>&nbsp;&nbsp;&nbsp;&nbsp;")

            ' IterationStatus = "Delayed"
            Dim Color As String = ""
            If IterationStatus = "Delayed with issue" Then
                Color = "#dd4b39"
            ElseIf IterationStatus = "Issue" Then
                Color = "#f39c12"
            ElseIf IterationStatus = "Delayed" Then
                Color = "#00c0ef"
            ElseIf IterationStatus = "In Control" Then
                Color = "#FFFF00"
            ElseIf IterationStatus = "Ready For Release" Then
                Color = "#00a65a"
            End If


            ' strHTML.Append(" <button type='button' class='btn btn-success' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
            If CheckIsProductOwner(Session("intUserID")) <> 0 Then
                If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
                    If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
                        strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-toggle='tooltip' data-placement='bottom'  data-bs-target='#Remark" & IterationID & "' onclick=""UnmappedSprint(" & IterationID & ", " & ReleaseID & ",'txtRemark" & ReleaseID & "')""></i>")
                    End If
                Else
                    strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-toggle='tooltip' data-bs-target='#Remark" & IterationID & "'></i>")
                End If

            End If



            strHTML.Append("</div>")


            strHTML.Append("<div class='col-sm-2 ClsStatusSprints'>" & vbCrLf)
            If IterationStatus <> "" Then
                strHTML.Append(" <span class='label clsstatus' style='margin-top:-23%;background-color:" & Color & "' title='Sprint Status'  data-toggle='tooltip' data-placement='bottom'  >" & IterationStatus & "</span>")
            Else
                strHTML.Append(" <span class='label'  title='Sprint Status'  data-toggle='tooltip' data-placement='bottom' ></span>")
            End If

            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("</div>")
        End While

        If IsRecord = 0 Then
            strHTML.Append("<div class='card DivDetailss' >" & vbCrLf)
            strHTML.Append("<div class='card-header' style='border:none'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            ' <!-- /* Modified By Madhuri.K On 03-04-2026 */ -->
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString()

    End Function

    Private Function WriteGrid(ByVal Flag As String, Optional ByVal SelectedReleaseID As String = "", Optional ByVal FlagSprintRelease As String = "") As String
        '=====================================================================
        ' Procedure Name        : WriteGrid()	
        ' Purpose               : To Plot Release List Grid
        ' Description           :  To Plot Release List Grid
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 6th MArch 2018
        ' Revisions             : None
        '=====================================================================


        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        If SelectedReleaseID = "" Then
            SelectedReleaseID = "0"
        End If


        If Flag = "Release" Then
            SelectedReleaselistReleaseID = SelectedReleaseID
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 4
            strDivID = "DivRelaseList"
            strSQLQuery = "usp_NG2_GetReleaseDetails " & HttpContext.Current.Session("IntProjectID") & ""
            arrstrActualList = {"ReleaseName", "StartDate", "EndDate", "Status", ""}
            arrstrUserFriendlyList = {"Release Name", "Start Date", "End Date", "Release Status", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterRelease value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGrid = Nothing
        ElseIf Flag = "UserStory" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 3
            strDivID = "DivUSlist"
            strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'UserStory'"
            arrstrActualList = {"UserStoryID", "UserStoryName", "Priority", ""}
            arrstrUserFriendlyList = {"User StoryID", "User Story Name", "Priority", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", "checkUSmapped"}
            arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterUserStory value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridUS
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridUS = Nothing
        ElseIf Flag = "Sprint" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 3

            strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'Sprint'"
            strDivID = "DivSprintlist"


            arrstrActualList = {"IterationID", "IterationName", "IterationStatus", ""}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name", "Sprint Status", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", "checkSprintmapped"}
            arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterSprint value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridSprint
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridSprint = Nothing


        ElseIf Flag = "NoTMapped" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 3

            strSQLQuery = "usp_NG2_NotMappedSprint " & HttpContext.Current.Session("IntProjectID") & ",'Sprint'"
            strDivID = "DivNoTMappedSprintlist"


            arrstrActualList = {"IterationID", "IterationName", "IterationStatus", ""}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name", "Sprint Status", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", "checkSprintmapped"}
            arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterNoTMapped value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridUnmappedSprint
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridUnmappedSprint = Nothing

        ElseIf Flag = "Release1" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 3
            strDivID = "DivRelease1list"
            strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'Release'"
            arrstrActualList = {"ReleaseID", "ReleaseName", "Status", ""}
            arrstrUserFriendlyList = {"Release ID", "Release Name", "Status", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", "checkReleasemapped"}
            arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterRelease1 value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridRelease1
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridRelease1 = Nothing

        ElseIf Flag = "Complete" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 2
            strDivID = "DivCompleteSprint"
            strSQLQuery = "usp_NG2_Sel_GetCompleteSprintDetails " & SelectedReleaseID & "," & HttpContext.Current.Session("IntProjectID") & ""
            arrstrActualList = {"IterationID", "IterationName"}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterComplete value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridComplete
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridComplete = Nothing


        ElseIf Flag = "Cancel" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 2
            strDivID = "DivCancelSprint"
            strSQLQuery = "usp_NG2_Sel_GetCancelSprintDetails " & SelectedReleaseID & "," & HttpContext.Current.Session("IntProjectID") & ""
            arrstrActualList = {"IterationID", "IterationName"}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterCancel value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGridCancel
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGridCancel = Nothing

        ElseIf Flag = "CurrentSprintUS" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivCurrentSprintUS"
            strSQLQuery = "usp_NG2_Sel_CurrentSprintUSdetails " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"UserStoryID", "SprintName", "InitialEstimate", "Status", "UserStoryName"}
            arrstrUserFriendlyList = {"ID", "Sprint Name", "Story Points", "Status", "User Story Name"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterCurrentSprintUS value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue

            With objCurrentSprintUS
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objCurrentSprintUS = Nothing
        ElseIf Flag = "IssuesList" Then
            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If

            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 6
            strDivID = "DivSubTabIssuesList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumIssues " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"IsImpediment", "IssueID", "ReportedDate", "Type", "IterationName", "Summary"}
            arrstrUserFriendlyList = {"Flag", "ID", "Reported Date", "Type", "Sprint Name", "Summary"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterIssuesList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objIssuesList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objIssuesList = Nothing

        ElseIf Flag = "ImpedimentsLogsList" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 6
            strDivID = "DivImpedimentsLogsList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumImpedimentLogs " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"RaisedDate", "IterationName", "Status", "Description", "CreatedBy", "Conversion"}
            arrstrUserFriendlyList = {"Raised Date", "Sprint Name", "Status", "Description", "Created By", "Conversion"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterImpedimentsLogsList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objImpedimentsLogList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objImpedimentsLogList = Nothing


            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If
        ElseIf Flag = "RisksList" Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivRisksList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumRisks " & SelectedReleaseID & "," & FlagSprintRelease & ""
            arrstrActualList = {"DateIdentified", "IterationName", "Status", "Description", "RiskCategory"}
            arrstrUserFriendlyList = {"Date Identified ", "Sprint Name", "Status", "Description", "Risk Category"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterRisksList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objRiskList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objRiskList = Nothing

        ElseIf Flag = "ReviewList" Then
            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 6
            strDivID = "DivReviewList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumReviews " & SelectedReleaseID & "," & FlagSprintRelease & ""
            arrstrActualList = {"ReviewedDate", "IterationName", "ReviewStatus", "ReviewTitle", "ReviewedBy", "Reviewee"}
            arrstrUserFriendlyList = {"Reviewed Date", "Sprint Name", "Status", "Review Title", "Reviewed By", "Reviewee"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterReviewList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objReviewList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objReviewList = Nothing

        ElseIf Flag = "TaskList" Then
            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivTaskList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & SelectedReleaseID & "," & FlagSprintRelease & ""
            arrstrActualList = {"AssignedTo", "IterationName", "Effort", "IsActive", "ScrumTaskName"}
            arrstrUserFriendlyList = {"Assigned To", "Sprint Name", "Planned/Actual", "Status", "Task Name"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterTaskList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objtaskList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objtaskList = Nothing

        ElseIf Flag = "HistorykList" Then
            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5
            strDivID = "DivHistorykList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & ",8083"
            arrstrActualList = {"Date", "ModifiedBy", "FieldName", "OldValue", "NewValue"}
            arrstrUserFriendlyList = {"Date", "Modified By", "Field Name", "Old Value", "New Value"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterHistorykList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objHistorykList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objHistorykList = Nothing

        ElseIf Flag = "AttachmentList" Then
            If FlagSprintRelease = "Sprint" Then
                FlagSprintRelease = "Iteration"
            End If
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 4
            strDivID = "DivAttachmentList"
            strSQLQuery = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & SelectedReleaseID & ",'Release'"
            ' strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & ",8083"
            arrstrActualList = {"OriginalFileName", "AttachedBy", "Duration", ""}
            arrstrUserFriendlyList = {"Original File Name", "Attached By", "Duration", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterAttachmentList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objAttachList
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objAttachList = Nothing
        End If



        'End If
        Return strGridHTML.ToString

    End Function

    Public Function USerStories_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divUserstories' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h2 class=''>User stories Details</h2>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchCurrntSprintUS' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchCurrntSprintUS' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divSprintList'>")
        strHTML.Append(WriteGrid("CurrentSprintUS", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function Teams_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        Dim StrQuery As String = ""
        Dim EmployeeName As String = ""
        Dim EmployeeID As String = ""
        Dim ExpectedStartDate As String = ""
        Dim ExpectedEndDate As String = ""
        Dim RoleDescription As String = ""
        Dim SystemFilename As String = ""
        Dim TotalTasks As String = ""
        Dim InProgressTasks As String = ""
        Dim CompletedTasks As String = ""
        Dim TotalIssues As String = ""
        Dim ResourcePercentage As String = ""
        Dim TaskCompletionPercentage As String = ""
        Dim BarColor As String = ""
        Dim Clsprogressbar As String = ""
        Dim badgecolor As String = ""
        Dim drGetTeamDetails As IDataReader
        strHTML.Append("<div id='divTeams' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion' style='border-bottom: 2px solid rgb(60, 141, 188)!important;'>Project Teams</h2>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divTeamsList' style='margin-top: 15px;'>")
        strHTML.Append("<div class='clsTeamTable'>")

        StrQuery = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("IntProjectID") & "," & ReleaseID & ",'" & Flag & "'"
        drGetTeamDetails = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        While drGetTeamDetails.Read
            intnewCounter += 1
            If intnewCounter = 1 Then
                IscheckDatahas = 1
                strHTML.Append("<div>")
                strHTML.Append("<div class='col-sm-12 col-sm-12 sprint_card team_cards '>")
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
                EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
                InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
                CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
                TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
                ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
                TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
                TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
                RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
                ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
                BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
                If BarColor = "Blue" Then
                    Clsprogressbar = "active"
                    badgecolor = "label label-primary"
                ElseIf BarColor = "Green" Then
                    Clsprogressbar = "progress-bar-success"
                    badgecolor = "label label-success"
                ElseIf BarColor = " Orange" Then
                    Clsprogressbar = "progress-bar-warning"
                    badgecolor = "label label-warning"
                ElseIf BarColor = " Red" Then
                    Clsprogressbar = "progress-bar-danger"
                    badgecolor = "label label-danger"
                End If


                strHTML.Append("<div class=''>")
                strHTML.Append("<div class='col-md-2 col-sm-2 col-sm-12'>")
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-md-10 col-sm-10 col-sm-12'>")

                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)
                Else
                    strLessComment = RoleDescription
                End If

                strHTML.Append("<p class='ClsTeamDetails'><span  data-toggle='tooltip' data-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-toggle='tooltip' data-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></p>")

                strHTML.Append("<p class='ResourcePercentage'><span data-toggle='tooltip' data-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </p>")
                strHTML.Append("<div class='progress' style='width:80%'>")

                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -38px; margin-right: 3px;border-radius:10px' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

            End If
            If intnewCounter = 2 Then
                IscheckDatahas = 1
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
                EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
                InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
                CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
                TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
                ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
                TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
                TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
                RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
                ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
                ExpectedStartDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedStartDate").ToString, "")
                BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
                If BarColor = "Blue" Then
                    Clsprogressbar = "active"
                    badgecolor = "label label-primary"
                ElseIf BarColor = "Green" Then
                    Clsprogressbar = "progress-bar-success"
                    badgecolor = "label label-success"
                ElseIf BarColor = " Orange" Then
                    Clsprogressbar = "progress-bar-warning"
                    badgecolor = "label label-warning"
                ElseIf BarColor = " Red" Then
                    Clsprogressbar = "progress-bar-danger"
                    badgecolor = "label label-danger"
                End If



                strHTML.Append("<div class='col-sm-12 col-sm-12 sprint_card team_cards '>")
                strHTML.Append("<div class=''>")
                strHTML.Append("<div class='col-md-2 col-sm-2 col-sm-12'>")
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")
                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)
                Else
                    strLessComment = RoleDescription
                End If


                strHTML.Append("<div class='col-md-10 col-sm-10 col-sm-12'>")
                strHTML.Append("<P class='ClsTeamDetails'><span  data-toggle='tooltip' data-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-toggle='tooltip' data-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")

                strHTML.Append("<P class='ResourcePercentage'><span data-toggle='tooltip' data-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -38px; margin-right: 3px;border-radius:10px' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                intnewCounter = 0
            End If



        End While
        If intnewCounter = 1 Then
            strHTML.Append("</div>")
        End If

        If IscheckDatahas = 0 Then
            strHTML.Append("<div>")
            strHTML.Append("<div>")
            strHTML.Append("<div class='NoTeam'>")
            strHTML.Append("<span style='text-align:center' > There are no one resource associated to release </span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    Public Function ImpedimentsLogs_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divImpedimentsLogs' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h2 class='' style=''>Impediments Logs Details</h2>")
        strHTML.Append("</div>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchImpediments' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchImpediments' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divImpedimentsList'>")
        strHTML.Append(WriteGrid("ImpedimentsLogsList", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function Risks_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divRisks' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6' >")
        strHTML.Append("<h2 class=''>Risks Details</h2>")
        strHTML.Append("</div>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchRisks' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")

        'strHTML.Append("<input type='text' name='table_search' id='txtSearchRisks' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='col-sm-12 col-sm-12' id='divRisksList'>")
        strHTML.Append(WriteGrid("RisksList", ReleaseID, Flag))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function History_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divHistory' class='clsBox'>")

        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h2 class=''>History Details</h2>")
        strHTML.Append("</div>")
        'strHTML.Append("<H2 class='clsDiscussion' style='line-height:1.7'>History Details</H2>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchhistory' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchhistory' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divhistoryList'>")
        strHTML.Append(WriteGrid("HistorykList", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    Public Function Attachment_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String, Optional Refreshflag As String = "", Optional IterationStatus As String = "") As String
        '=====================================================================
        ' Procedure  Name		:	Attachment_section
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To Plot Attachment section
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    6th-March-2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='divAttachments' class='clsBox'>")
        'strHTML.Append("<H2 class='clsDiscussion' style='line-height:1.7'>Attachments</H2>")
        'If Refreshflag <> "AfterDelete" Then
        '    strHTML.Append("<div id='divAttachmentList' class='col-sm-12'>")
        'End If

        'strHTML.Append(GetAttachmentListSprintRelease(userStoryID, Flag, ""))
        'strHTML.Append("</div>")
        'If Refreshflag <> "AfterDelete" Then
        '    strHTML.Append("</div>")
        'End If
        strHTML.Append("<div id='divAttachments' class='clsBox'>")
        strHTML.Append("<H2 class='clsDiscussion' style='  border-bottom: 2px solid rgb(60, 141, 188)!important;'>Attachments</H2>")
        strHTML.Append("<div id='divAttachmentList' class='col-sm-12 col-sm-12'>")
        strHTML.Append(GetAttachmentList1(ReleaseID, Refreshflag, IterationStatus))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    'Public Function GetAttachmentListSprintRelease(userStoryID As String, ByVal Flag As String, Optional Refreshflag As String = "")
    '    '=====================================================================
    '    ' Procedure  Name		:	GetAttachmentList
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Get GetAttachment List
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & "," & Flag & ""
    '    Dim dtAttachment As New DataTable
    '    dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
    '    strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:15px;margin-left:-1%'><div class='demo-droppable' style='margin-bottom:20px;'><p>Drag files here or click to upload</p></div><a onclick=UploadData(" & userStoryID & ")   style='background: #01579b;padding:8px;color:#fff; border-radius: 4px;'><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
    '    strHTML.Append(" <div id='listattachment'>")
    '    For i As Integer = 0 To dtAttachment.Rows.Count - 1
    '        strHTML.Append(" <div class='row attachRow' id='Sprintattachmentdata'>")
    '        strHTML.Append(" <div class='form-group'  style='margin-top:2%'>")
    '        strHTML.Append(" <div class='col-sm-4 '>")
    '        strHTML.Append("<span  title='Original File Name'  data-toggle='tooltip'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
    '        strHTML.Append("</div>")
    '        strHTML.Append(" <div class='col-sm-4 '>")
    '        strHTML.Append("<span   title='Attached By'  data-toggle='tooltip'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
    '        strHTML.Append("</div>")
    '        strHTML.Append(" <div class='col-sm-4 ' style='float:right;margin-right:-26%'>")
    '        strHTML.Append("<span title='Delete' data-toggle='tooltip'><i class='fa fa-trash' style='color:red!important' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'" & Flag & "' )"" ></i></span>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")
    '    Next
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString()
    'End Function
    Public Function GetAttachmentList1(ReleaseID As String, Optional ByVal flag As String = "", Optional ByVal IterationStatus As String = "")


        Dim strHTML As New StringBuilder()
        If flag <> "AfterDelete" Then
            strHTML.Append(" <div id='Attachmentus'>")
        End If
        SelectedReleaseid = ReleaseID
        ' Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & ReleaseID & ",'Release'"
        Dim dtAttachment As New DataTable
        ' dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        If IterationStatus.ToUpper <> "RELEASED" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='btn btn-info' data-toggle='tooltip' title='Upload File' data-placement='bottom' onclick=UploadData(" & ReleaseID & ")><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
        Else
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div></h2>")
        End If

        strHTML.Append(" <div id='listattachment'>")
        'For i As Integer = 0 To dtAttachment.Rows.Count - 1
        '    strHTML.Append(" <div class='row attachRow'>")
        '    strHTML.Append(" <div class='form-group'>")
        '    strHTML.Append(" <div class='col-sm-4 '>")
        '    strHTML.Append("<span  data-toggle='tooltip' title='File Name' data-placement='bottom' style='word-break:break-all'>" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
        '    strHTML.Append("</div>")
        '    strHTML.Append(" <div class='col-sm-4 '>")
        '    strHTML.Append("<span  data-toggle='tooltip' title='Attached By' data-placement='bottom'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
        '    strHTML.Append("</div>")
        '    strHTML.Append(" <div class='col-sm-4 ' style='float:right;'>")
        '    strHTML.Append("<i data-toggle='tooltip' data-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;float:right!important;margin-right:8%!important;' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & ReleaseID & ",'Release')""></i>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        'Next
        strHTML.Append(WriteGrid("AttachmentList", ReleaseID, flag))
        ' strHTML.Append(WriteGrid())
        strHTML.Append("</div>")
        If flag <> "AfterDelete" Then
            strHTML.Append(" </div>")
        End If

        Return strHTML.ToString()

    End Function
    Public Function Tasks_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divTasks' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h5 class=''> Task Details</h5>")
        strHTML.Append("</div>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchTask' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchTask' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divTaskList'>")
        strHTML.Append(WriteGrid("TaskList", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function Issues_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divIssues' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h5 class=''>Issues Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control' name='table_search' id='txtSearchIssues' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchIssues' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssuesList", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    Public Function Reviews_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divReview' class='clsBox'>")

        strHTML.Append("<div class='clsDiscussion1'>")
        strHTML.Append("<div class='col-sm-6 col-sm-6'>")
        strHTML.Append("<h2 class='' >Reviews Details</h2>")
        strHTML.Append("</div>")
        'Added By Yasmin on 4-3-19
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='releasesearchbox'>")
        strHTML.Append("<input type='text' class='form-control'  name='table_search' id='txtSearchReviews' placeholder='Search'/>")
        strHTML.Append("<i class='fa fa-search releasesearch'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-5' style='float:right'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchReviews' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12 col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", ReleaseID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function Discussion_sectionSprintRelease(ByVal ReleaseID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussions' class='clsBox' style='height:100%;width:100%;overflow:auto'>")
        strHTML.Append("<h2 class='clsDiscussion' style=' border-bottom: 2px solid rgb(60, 141, 188)!important;'>Discussions</h2>")
        strHTML.Append("<div id='divDiscussionListSprintRelease'  class='row'  class='col-sm-11 col-sm-11'  style='margin-top:15px;'>") 'divDiscussionListSprintRelease
        strHTML.Append(PlotDiscussionThreadBody(ReleaseID, "", Flag))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Friend Function PlotDiscussionThreadBody(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)


        Dim drGetUserStoryDicussion As IDataReader
        Dim drGetUserStoryDicussionCount As IDataReader
        Dim drContactList As IDataReader
        Dim strHTMLDiscussion As New StringBuilder
        Dim StrQuery As String = ""
        Dim StrUserStoryCountQuery As String = ""
        Dim intDiscussionCount As Integer = 0
        Dim strPhotoFileName As String = ""
        Dim strDiscussionDate As String = ""
        Dim strComment As String = ""
        Dim strEmployeeName As String = ""
        Dim flag As String = ""
        Dim strUserName As String = ""
        Dim strDiscussionID As String = ""
        Dim dtTable As New DataTable()
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
        drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intCounter As Integer = 0


        strHTMLDiscussion.Append("<ul class='col-sm-5 col-xs-12' style='margin-top: 20px;'>")


        While drGetUserStoryDicussion.Read
            intCounter += 1
            strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
            strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
            strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
            strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
            strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
            Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
            strHTMLDiscussion.Append("<li class=''>")
            strHTMLDiscussion.Append("<div class=''>")
            strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start'>")
            strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-8'>")
            strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-toggle='tooltip' data-placement='bottom'> " & strEmployeeName & "</span></P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='row'>")

            strHTMLDiscussion.Append("<div class='col-sm-4 col-sm-4' style='white-space:pre!important'>")
            strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-toggle='tooltip' data-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%;word-break: break-all;' ><span data-toggle='tooltip' data-placement='bottom' title='Description' style='word-break: break-all;'>")
            Dim strLessComment As String = ""
            Dim strRemaining As String = ""
            If strComment.Length > 200 Then
                strLessComment = strComment.Substring(0, 200)
                strRemaining = strComment.Substring(201, strComment.Length - 201)
            End If
            If strLessComment = "" Then
                strHTMLDiscussion.Append("" & strComment & "")
            Else
                strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important;word-break: break-all;'>" & strRemaining & "</p>")
            End If
            If strComment.Length > 200 Then
                strHTMLDiscussion.Append("<a onclick='ShowMoreLess(" & strDiscussionID & ",this)' title='More' data-toggle='tooltip' data-placement='bottom'>More</a></p>")
            End If
            Dim ReplyFlag As String = ""
            strHTMLDiscussion.Append("</span></p>")
            If strFlag = "UserStory" Then
                ReplyFlag = "UserStoryReply"
            ElseIf strFlag = "Iteration" Then
                ReplyFlag = "IterationReply"
            Else
                ReplyFlag = "ReleaseReply"
            End If
            strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:10px!important'>")
            StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
            dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
            strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-toggle='tooltip' data-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-toggle='tooltip' data-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Reply count' data-toggle='tooltip' data-placement='bottom'>" & dtTable.Rows.Count & "</label>")
            strHTMLDiscussion.Append("</small>")



            If dtTable.Rows.Count > 0 Then
                strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
                For i As Integer = 0 To dtTable.Rows.Count - 1
                    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
                    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
                    strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
                    strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
                    'strDiscussionID = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
                    strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

                    strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
                    strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
                    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
                    strHTMLDiscussion.Append("<div class='header'>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class=''>")
                    strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
                    strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
                    strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-toggle='tooltip' data-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
                    strHTMLDiscussion.Append("</span>")

                    strHTMLDiscussion.Append("<div class='col-md-9 col-sm-9' style='white-space:pre!important;float: right;'>")
                    strHTMLDiscussion.Append("<p style='float: right;'><span class='clsempname' title='Employee Name' data-toggle='tooltip' data-placement='bottom'> " & strEmployeeName & "</span></P>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<p style='color:#777!important;word-break: break-all;' ><span title='Description' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all;'>")
                    Dim strLessCommentInside As String = ""
                    Dim strRemainingInside As String = ""
                    If strComment.Length > 200 Then
                        strLessCommentInside = strComment.Substring(0, 200)
                        strRemainingInside = strComment.Substring(201, strComment.Length - 201)
                    End If
                    If strLessCommentInside = "" Then
                        strHTMLDiscussion.Append("" & strComment & "")
                    Else
                        strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
                    End If
                    If strComment.Length > 200 Then
                        strHTMLDiscussion.Append(" <a onclick='ShowMoreLess(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
                    End If
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<small class='float-end text-muted'>")
                    strHTMLDiscussion.Append("<span style='font-size:12px!important;' title='Discussion Date' data-toggle='tooltip' data-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-toggle='tooltip' data-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>")
                    strHTMLDiscussion.Append("</small>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")

                    strHTMLDiscussion.Append("</li>")
                Next
                strHTMLDiscussion.Append("</ul>")
            End If
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</li>")
            If intCounter = 1 Then
                flag = "PlotTextArea"
            End If
        End While
        If intCounter = 0 Then
            flag = "PlotTextArea"
            strHTMLDiscussion.Append("<li class='col-sm-12'>")
            strHTMLDiscussion.Append("<span class='chat-img float-start'>")
            'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
            strHTMLDiscussion.Append("No records to view.")
            strHTMLDiscussion.Append("</p>")
            strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
            'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
            strHTMLDiscussion.Append("</small>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</li>")
        End If

        strHTMLDiscussion.Append("</ul>")
        'End If

        If flag = "PlotTextArea" Then
            strHTMLDiscussion.Append("<ul class='col-sm-5 col-xs-12' style='margin-top:8%;text-align:right;'>")
            ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
            'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion'", True))
            strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion' maxlength ='2000'", True))
            '//End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;'  onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-toggle='tooltip' data-placement='top'  >Add New<span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertSprintReleaseDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions')><sup><i class='far fa-comment' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-toggle='tooltip' data-placement='top' > Post<span></button>")

            'strHTMLDiscussion.Append("</li>")
            strHTMLDiscussion.Append("</ul>")
        End If





        Return strHTMLDiscussion.ToString()

    End Function
    ''For Un mapped Sprint 
    Private Sub objGridUnmappedSprint_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridUnmappedSprint.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'><p Title = 'Select' data-toggle='tooltip' data-placement='bottom' ><input type='checkbox' value='" & Args.DataReader("IterationID") & "' name='SelectUnmappedSprintList' class='clscheckbox' >" + "<p></TD>"

        End If

        If Args.ColumnName.ToUpper = "SPRINT ID" Then
            If Not IsDBNull(Args.DataReader("IterationID")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT STATUS" Then
            If Not IsDBNull(Args.DataReader("IterationStatus")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Status' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationStatus"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



    End Sub

    Private Sub objAttachList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objAttachList.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "ORIGINAL FILE NAME" Then 'Original File Name
            If Not IsDBNull(Args.DataReader("OriginalFileName")) Then 'User StoryID
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Original File Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OriginalFileName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Original File Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "ATTACHED BY" Then 'AttachedBy
            If Not IsDBNull(Args.DataReader("AttachedBy")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Attached By' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AttachedBy"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Attached By' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "DURATION" Then 'Duration
            If Not IsDBNull(Args.DataReader("Duration")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Duration' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Duration"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Duration' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then 'Delete

            Cancel = True
            ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
            'Commented And Added By Usha Pandit On 12.08.2020 For correct tooltip display issue
            'Args.StringToBeInserted = "<td align='center' ><p Title = 'Duration' data-toggle='tooltip' data-placement='bottom' ><i data-toggle='tooltip' data-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & Args.DataReader("AttachmentID") & "," & SelectedReleaseid & ",'Release')""></i></p></TD>"
            Args.StringToBeInserted = "<td align='center' ><p data-toggle='tooltip' data-placement='bottom' ><i data-toggle='tooltip' data-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & Args.DataReader("AttachmentID") & "," & SelectedReleaseid & ",'Release')""></i></p></TD>"
            'End Of Added By Usha Pandit On 12.08.2020 For correct tooltip display issue




        End If



    End Sub
    ''For US Filter
    Private Sub objGridUS_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridUS.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If Not IsDBNull(Args.DataReader("IsMapped")) Then
                If (Args.DataReader("IsMapped") = "1") Then

                    Args.StringToBeInserted = "<td align='center'><p Title = 'Select' ><input type='checkbox' value='" & Args.DataReader("UserStoryID") & "' title='Select' name='SelectUSList' class='clscheckbox' data-toggle='tooltip' data-placement='bottom' onclick='SelectMappedUS(this," & Args.DataReader("UserStoryID") & ",""Us"")'>" + "</p></TD>"
                Else

                    Args.StringToBeInserted = "<td align='center'><p Title = 'Select' ><input type='checkbox' value='" & Args.DataReader("UserStoryID") & "' title='User Story not mapped to Sprint/Release' name='SelectUSList' class='clscheckbox' data-toggle='tooltip' data-placement='bottom' onclick='SelectMappedUS(this," & Args.DataReader("UserStoryID") & ",""Us"")' disabled>" + "</p></TD>"
                End If


            End If
        End If





        If Args.ColumnName.ToUpper = "USER STORYID" Then 'User StoryID
            If Not IsDBNull(Args.DataReader("UserStoryID")) Then 'User StoryID
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'User Story ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UserStoryID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'User Story ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "USER STORY NAME" Then
            If Not IsDBNull(Args.DataReader("UserStoryName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                'Commented and Added by Usha Pandit on 08 JUNE 2018 for wrap large text
                'Args.StringToBeInserted = "<td align='center' ><p Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UserStoryName"), "") & "</p></TD>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' style = 'word-break: break-all;'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UserStoryName"), "") & "</p></TD>"
                'End of Added by Usha Pandit on 08 JUNE 2018 for wrap large text
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "PRIORITY" Then
            If Not IsDBNull(Args.DataReader("Priority")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Priority' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Priority"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Priority' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



    End Sub

    ''For Select Release List
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If SelectedReleaselistReleaseID <> "0" Then
                If (SelectedReleaselistReleaseID = Args.DataReader("ReleaseID")) Then
                    ' Args.StringToBeInserted = "<td align='center' Title = 'Select' data-toggle='tooltip'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' data-toggle='tooltip' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)' checked>" + "</TD>"
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Select' ><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' data-toggle='tooltip' data-placement='Right' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)' checked>" + "</p></TD>"

                Else
                    ' Args.StringToBeInserted = "<td align='center' Title = 'Select' data-toggle='tooltip'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' data-toggle='tooltip' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Select' ><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' data-toggle='tooltip' data-placement='Right' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</p></TD>"


                End If
            Else
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Select' ><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' data-toggle='tooltip'  data-placement='Right' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</p></TD>"

            End If
        End If



        If Args.ColumnName.ToUpper = "RELEASE NAME" Then
            If Not IsDBNull(Args.DataReader("ReleaseName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Name' data-toggle='tooltip' data-placement='Right' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ReleaseName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Name' data-toggle='tooltip' data-placement='Right' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "START DATE" Then
            If Not IsDBNull(Args.DataReader("Startdate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Start date' data-toggle='tooltip' data-placement='Right' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Startdate"), "") & "</p></TD>"
            Else
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Start Date' data-toggle='tooltip'>Not Specified</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Start date' data-toggle='tooltip' data-placement='Right' >Not Specified</p></TD>"

            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "END DATE" Then
            If Not IsDBNull(Args.DataReader("EndDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'End Date' data-toggle='tooltip' data-placement='Right' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate"), "") & "</p></TD>"
            Else
                Cancel = True
                'Args.StringToBeInserted = "<td align='center' Title = 'End Date' data-toggle='tooltip'>Not Specified</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'End Date' data-toggle='tooltip' data-placement='Right' >Not Specified</p></TD>"

            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "RELEASE STATUS" Then
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release Status' data-toggle='tooltip'>" & Args.DataReader("Status") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Status' data-toggle='tooltip' data-placement='Right' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate"), "") & "</p></TD>"

            Else
                Cancel = True
                'Args.StringToBeInserted = "<td align='center' Title = 'Release Status' data-toggle='tooltip'>Not Specified</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Status' data-toggle='tooltip' data-placement='Right' >Not Specified</p></TD>"

            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    ''For Release Filter 
    Private Sub objGridRelease1_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridRelease1.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If Not IsDBNull(Args.DataReader("IsMapped")) Then
                If (Args.DataReader("IsMapped") = "1") Then

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' Title = 'Select' data-toggle='tooltip' data-placement='bottom' class='clscheckboxRelease' onclick='SelectMappedUS(this," & Args.DataReader("ReleaseID") & ",""Release"")'>" + "</p></TD>"
                Else

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='User Story not mapped to Sprint/Release' data-toggle='tooltip' data-placement='bottom' name='SelectReleaseList' class='clscheckboxRelease' onclick='SelectMappedUS(this," & Args.DataReader("ReleaseID") & ",""Release"")' disabled>" + "</p></TD>"
                End If


            End If
        End If



        If Args.ColumnName.ToUpper = "STATUS" Then
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Status' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RELEASE ID" Then
            If Not IsDBNull(Args.DataReader("ReleaseID")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ReleaseID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RELEASE NAME" Then
            If Not IsDBNull(Args.DataReader("ReleaseName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ReleaseName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If





    End Sub

    ''For Sprint Filter
    Private Sub objGridSprint_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridSprint.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If Not IsDBNull(Args.DataReader("IsMapped")) Then
                If (Args.DataReader("IsMapped") = "1") Then

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("IterationID") & "' title='Select' name='SelectSprintList' data-toggle='tooltip' data-placement='bottom' class='clscheckboxSprint' onclick='SelectMappedUS(this," & Args.DataReader("IterationID") & ",""Sprint"")'>" + "</p></TD>"
                Else

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("IterationID") & "' title='User Story not mapped to Sprint/Release' name='SelectSprintList' data-toggle='tooltip' data-placement='bottom' class='clscheckboxSprint' onclick='SelectMappedUS(this," & Args.DataReader("IterationID") & ",""Sprint"")' disabled>" + "</p></TD>"
                End If


            End If
        End If



        If Args.ColumnName.ToUpper = "SPRINT ID" Then
            If Not IsDBNull(Args.DataReader("IterationID")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT STATUS" Then
            If Not IsDBNull(Args.DataReader("IterationStatus")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Status' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationStatus"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If





    End Sub


    ''For Cancel Sprint Graph Tab
    Private Sub objGridCancel_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridCancel.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "SPRINT ID" Then
            If Not IsDBNull(Args.DataReader("IterationID")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If




        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



    End Sub

    ''For Complete Sprint Graph Tab
    Private Sub objGridComplete_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridComplete.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "SPRINT ID" Then
            If Not IsDBNull(Args.DataReader("IterationID")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationID"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If




        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



    End Sub
    ''For US Tab
    Private Sub objCurrentSprintUS_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objCurrentSprintUS.DataRowTD_BeforePrint

        Dim StatusColor As String = ""
        If Args.ColumnName.ToUpper = "STATUS" Then
            If Args.DataReader("Status") = "To Do-List" Then
                StatusColor = "label1 label-Yellow"
            ElseIf Args.DataReader("Status") = "In Progress" Then
                StatusColor = "label1 label-warning"
            ElseIf Args.DataReader("Status") = "Open" Then
                StatusColor = "label1 label-danger"
            ElseIf Args.DataReader("Status") = "Cancel" Then
                StatusColor = "label1 label-danger"
            ElseIf Args.DataReader("Status") = "Done" Then
                StatusColor = "label1 label-success"
            End If
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Status' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "ID" Then 'UserStory ID
            If Not IsDBNull(Args.DataReader("UserStoryID")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story ID' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("UserStoryID") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



        If Args.ColumnName.ToUpper = "USER STORY NAME" Then 'User StoryName
            If Not IsDBNull(Args.DataReader("UserStoryName")) Then
                Cancel = True
                'Commented and Added by Usha Pandit on 08 JUNE 2018 for wrap large text
                'Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
                Args.StringToBeInserted = "<td align='center'><p style = 'word-break: break-all;padding-right: 20px;'><span  Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
                'End of Added by Usha Pandit on 08 JUNE 2018 for wrap large text
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'User StoryName
            If Not IsDBNull(Args.DataReader("SprintName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("SprintName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STORY POINTS" Then 'Story Points
            If Not IsDBNull(Args.DataReader("InitialEstimate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Story Points' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("InitialEstimate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Story Points' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub

    ''For Issue Tab
    Private Sub objIssuesList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objIssuesList.DataRowTD_BeforePrint



        If Args.ColumnName.ToUpper = "FLAG" Then 'Flag
            If Not IsDBNull(Args.DataReader("IsImpediment")) Then
                Cancel = True
                If (Args.DataReader("IsImpediment") = 1) Then

                    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue by Impediment' data-toggle='tooltip' data-placement='bottom' ><i class='fa fa-star' aria-hidden='true' style='color:red !important'></i></span></p></td>"
                Else

                    Args.StringToBeInserted = "<td align='center' ><p ></p></TD>"
                End If
            Else

                Args.StringToBeInserted = "<td align='center' ><p ></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "ID" Then 'Story Points
            If Not IsDBNull(Args.DataReader("IssueID")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue ID' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IssueID") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue ID' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REPORTED DATE" Then 'ReportedDate
            If Not IsDBNull(Args.DataReader("ReportedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reported Date' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ReportedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reported Date' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "TYPE" Then 'ReportedDate
            If Not IsDBNull(Args.DataReader("Type")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue Type' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Type") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue Type' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SUMMARY" Then 'Summary
            If Not IsDBNull(Args.DataReader("Summary")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Summary' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >" & Args.DataReader("Summary") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Summary' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub

    ''For Review Tab
    Private Sub objReviewList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objReviewList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "REVIEWEDDATE" Then 'Reviewed Date
            If Not IsDBNull(Args.DataReader("ReviewedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewed Date' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ReviewedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewed Date' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SPRINTNAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("ReviewStatus")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ReviewStatus") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REVIEWTITLE" Then 'ReviewTitle
            If Not IsDBNull(Args.DataReader("ReviewTitle")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Review Title' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ReviewTitle") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Review Title' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REVIEWBY" Then 'ReviewedBy
            If Not IsDBNull(Args.DataReader("ReviewedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewed By/Reviewee' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ReviewedBy") & "/" & Args.DataReader("Reviewee") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewed By/Reviewee' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub
    ''For Impediments Tab
    Private Sub objImpedimentsLogList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objImpedimentsLogList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "RAISED DATE" Then 'Raised Date
            If Not IsDBNull(Args.DataReader("RaisedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Raised Date' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("RaisedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Raised Date' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SPRINT NAME" Then '"Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Iteration Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Iteration Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then 'Description
            If Not IsDBNull(Args.DataReader("Description")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='width:20%!important'><p ><span  Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break: white-space: pre-line !important;' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='width:20%!important'><p ><span Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break:white-space: pre-line !important;' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "CREATED BY" Then 'CreatedBy
            If Not IsDBNull(Args.DataReader("CreatedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'CreatedBy' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("CreatedBy") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'CreatedBy' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "CONVERSION" Then 'Conversion
            If Not IsDBNull(Args.DataReader("Conversion")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Conversion' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Conversion") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Conversion' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub
    ''For Risk Tab
    Private Sub objRiskList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objRiskList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "DATE IDENTIFIED" Then 'Date Identified
            If Not IsDBNull(Args.DataReader("DateIdentified")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Date Identified' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("DateIdentified") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Date Identified' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'sprint Name
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then 'Description
            If Not IsDBNull(Args.DataReader("Description")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RISK CATEGORY" Then 'RiskCategory
            If Not IsDBNull(Args.DataReader("RiskCategory")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Risk Category' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("RiskCategory") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Risk Category' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub


    Private Sub objHistorykList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objHistorykList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "DATE" Then 'Date
            If Not IsDBNull(Args.DataReader("Date")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Date' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Date") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Date' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "MODIFIEDBY" Then 'Modified By
            If Not IsDBNull(Args.DataReader("ModifiedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Modified By' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ModifiedBy") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Modified By' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "FIELD NAME" Then 'Field Name
            If Not IsDBNull(Args.DataReader("FieldName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Field Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("FieldName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Field Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "OLD VALUE" Then 'Old Value
            If Not IsDBNull(Args.DataReader("OldValue")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Old Value' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("OldValue") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Old Value' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "NEW VALUE" Then 'New Value
            If Not IsDBNull(Args.DataReader("NewValue")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'New Value' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("NewValue") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'New Value' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub



    Private Sub objtaskList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objtaskList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "ASSIGNED TO" Then 'AssignedTo
            If Not IsDBNull(Args.DataReader("AssignedTo")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Assigned To' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("AssignedTo") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Assigned To' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'  >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "PLAN/ACTUAL EFFORT" Then 'Plan/Actual Effort
            If Not IsDBNull(Args.DataReader("Effort")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Effort") & " / " & Args.DataReader("Actual") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Plan/Effort' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Old Value
            If Not IsDBNull(Args.DataReader("IsActive")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IsActive") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "TASK NAME" Then 'Task Name
            If Not IsDBNull(Args.DataReader("ScrumTaskName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Task Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >" & Args.DataReader("ScrumTaskName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Task Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeReleaseName(ByVal ReleaseID As String, ByVal ReleaseName As String) As String

        Try
            Dim strSQL As String
            Dim Flags As String
            Try
                Flags = 1
                strSQL = "usp_NG2_UPD_ReleaseNAme " & HttpContext.Current.Session("IntProjectID") & "," & ReleaseID & ",'" & ReleaseName & "','Release'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Catch ex As Exception

            End Try

            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod>
    Public Shared Function SaveUnmappedSprinttoRelease(ByVal SelectedSprint As String, ByVal ReleaseID As String) As String 'USDONE: USDONE, sprintDone: sprintDone
        '=====================================================================
        ' Procedure Name        : SaveUnmappedSprinttoRelease
        ' Purpose               : 
        ' Description           : To Map Sprint To Release
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :15st March 2018
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")
            Dim insertSuccess As Integer = 0
            Dim strUniqueID As Integer = 0
            Dim arrStrselectedIDs() As String
            Dim index As Integer = 0
            Dim Flag As String = "0"
            arrStrselectedIDs = SelectedSprint.Split(",")
            Try

                For index = 0 To arrStrselectedIDs.Length - 1

                    Dim strQuery As String = "usp_NG2_MapSprintToRelease " & arrStrselectedIDs(index) & "," & ReleaseID & ",'" & HttpContext.Current.Session("strUserName") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                    insertSuccess = 1
                    Flag = 1
                Next
            Catch ex As Exception
            End Try
            Dim objfrmReleaseMonitoring As New frmReleaseMonitoring()
            strGridHTML.Append(objfrmReleaseMonitoring.PlotSprintList(ReleaseID))
            Return insertSuccess & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateIterationDate(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String, ByVal Flag As String)

        Try
            Dim strSql As String = ""

            strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsReleaseFallsBetweenPeriod " & HttpContext.Current.Session("intprojectid") & ",'" & StartDate & "','" & EndDate & "'", True), "0")

            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)

        Try
            Dim strSQL As String
            Dim strREsult As String
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'Release','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'Release'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", 'Release'", True)

                End If
            End If

            Return New frmReleaseMonitoring().PlotDiscussionThreadBody(strUserStoryID, "", "Release")
            'PlotDiscussionThreadBody(strUserStoryID, "", "UserStory")
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckReleaseDates(ByVal strIterationID As String, ByVal strReleaseID As String, ByVal strProjectID As String)
        '=====================================================================
        ' Procedure Name        : CheckReleaseDates
        ' Purpose               : 
        ' Description           : To Check Release Dates
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :1st March 2018
        '=====================================================================
        Try

            Dim strQuery As String
            Dim StartDate As String
            Dim EndDate As String
            Dim Duration As String
            Dim Velocity As String
            Dim strIterationStatus As String
            Dim dtIterationInfo As New DataTable
            strQuery = "EXEC usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & HttpContext.Current.Session("intProjectID") & "," & strReleaseID & "," & HttpContext.Current.Session("intUserID")
            dtIterationInfo = CommonFunctions.Data.GetDataTable(strQuery, True)
            If dtIterationInfo.Rows.Count > 0 Then
                StartDate = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("StartDate"), 0)
                EndDate = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("EndDate"), 0)
                Duration = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("Duration"), 0)
                Velocity = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("Velocity"), 0)
                strIterationStatus = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("IterationStatus"), 0)
            End If

            Dim strFlag As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Sel_tbl_pm_scrumuserstory_CheckIterationMapping " & strIterationID, True), 0)

            ' For DOD Functionality
            Dim strMsg As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Sel_MappingStatusSprint " & strReleaseID, True), 0)
            ''For DOD Functionality
            If Duration <> "" Then
                Duration = Duration
            Else
                Duration = "null"
            End If

            If Velocity <> "" Then
                Velocity = Velocity
            Else
                Velocity = "null"
            End If
            'strQuery = "Exec usp_IterationSDEDvalidations 'Release'," & strReleaseID & ",'" & StartDate & "','" & EndDate & "'," + Duration + "," + Velocity
            strQuery = "Exec usp_NG2_IterationSDEDvalidationsNew 'Release'," & strReleaseID & ",'" & StartDate & "','" & EndDate & "'," + Duration + "," + Velocity
            dtIterationInfo = New DataTable
            dtIterationInfo = CommonFunctions.Data.GetDataTable(strQuery, True)
            Dim ValidationResponseText As New StringBuilder
            For Each dRow As DataRow In dtIterationInfo.Rows
                ValidationResponseText.Append(dRow(0).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(dRow(1).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(dRow(2).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(dRow(3).ToString())
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(strFlag)
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(strIterationStatus)
                ' For DOD Functionality
                ValidationResponseText.Append(",")
                ValidationResponseText.Append(strMsg)
                'For DOD Functionality
            Next

            Return ValidationResponseText.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckSprintIsMappedOrNot(ByVal strIterationID As String, ByVal strReleaseID As String)
        '=====================================================================
        ' Purpose				:	To Cancel Sprint
        ' Author				:	Dipali V
        ' Created				:	2nd March 2018
        '=====================================================================
        Try

            Dim strResult As String = CommonFunctions.Data.GetDataScalar("usp_NG2_chk_AllowToTerminateIteration " & strIterationID & "," & strReleaseID, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function TerminateSprint(ByVal strIterationID As String, ByVal strRemark As String, ByVal ReleaseID As String, ByVal Flag As String)
        '=====================================================================
        ' Purpose				:	To Cancel Sprint
        ' Author				:	Dipali V
        ' Created				:	2nd March 2018
        '=====================================================================
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder()
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_upd_CancelSprint " & strIterationID & "," & HttpContext.Current.Session("intUserID") & ",'" & strRemark & "'", True), "")
            Dim objfrmReleaseMonitoring As New frmReleaseMonitoring()
            strGridHTML.Append(objfrmReleaseMonitoring.PlotSprintList(ReleaseID))
            Return strReleaseName & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal strAttachmentID As String, ByVal strUserStoryID As String, ByVal strEntity As String)
        'Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
        'Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")
        'Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
        'Return strResult & "||" & New frmReleaseMonitoring().GetAttachmentList1(strUserStoryID, "AfterDelete")
        Try

            Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")

            Dim strResult As String
            Dim intFlag As Integer
            Dim drattach As IDataReader
            drattach = CommonFunctions.Data.GetDataReader(strSql, True)
            If drattach.Read() Then
                strResult = CommonFunction.Data.CheckIsDBNull(drattach("Result"), "")
                intFlag = CommonFunction.Data.CheckIsDBNull(drattach("intFlag"), "0")
            End If
            Return strResult & "||" & intFlag & "||" & New frmReleaseMonitoring().GetAttachmentList1(strUserStoryID, "AfterDelete")
            'End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationName(ByVal strIterationName As String, ByVal strProjectID As String, ByVal flag As String, ByVal EntityID As String)

        Try
            Dim strSql As String = ""
            If flag = "Sprint" Then
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_IterationNameExists " & HttpContext.Current.Session("intprojectid") & ",'" & strIterationName & "'", True), "0")

            Else
                If EntityID = "0" Then
                    EntityID = "NULL"
                End If
                strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Ng2_chk_ReleaseNameExists " & HttpContext.Current.Session("intprojectid") & ",'" & strIterationName & "'," & EntityID, True), "0")

            End If
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntryValidation(ByVal ReleaseID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   10-April-2018
        '=====================================================================
        Try

            Dim ValidationResponseText As New StringBuilder
            ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            Dim strQuery As String
            Dim strMessage As String = ""
            Dim objReleases As New frmReleaseMonitoring
            strQuery = "Exec usp_ScrumEntityDeleteValidation 'Release','" + ReleaseID + "'"
            Dim drEntityValidation As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
            If (drEntityValidation.HasRows) Then
                While (drEntityValidation.Read())
                    ValidationResponseText.Append(drEntityValidation(0).ToString())
                End While
            Else
            End If
            If ValidationResponseText.ToString = "0" Then
                Dim strQueryDelete As String = "usp_Del_ScrumEntity 'Release','" + ReleaseID + "'"
                Dim strDelete As String = CommonFunctions.Data.InsertOrUpdateData(strQueryDelete, True)


            End If

            Return ValidationResponseText.ToString & "||" & objReleases.DrawRightSection("")
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckAllIssues(ByVal strReleaseID As String)
        Try

            Dim strResult As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IssueClosedForRelease " & strReleaseID, True), "")
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal EntityID As String)
        '====================================================================
        ' Function  Name        : ExportToExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export Impediment Log Details to excel
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 07-Apr-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String


            strSQL = "usp_NG2_sel_tbl_PM_ScrumReleasesList_Report " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & EntityID


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

            Dim frmObjReleaseMonitoring As New frmReleaseMonitoring
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjReleaseMonitoring.UseSQL
                .DefaultLCID = CType(frmObjReleaseMonitoring.DefaultUILCID, Integer)
                .LCID = frmObjReleaseMonitoring.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
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

        'End With
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetailsStoryPoint(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetBurnUpStoryPoint(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart_StoryPoint " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

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
    ''End of Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development


    <System.Web.Services.WebMethod()>
    Public Shared Function ReFreshTab(ByVal SelectedTab As String, ByVal Flag As String, ByVal UniqueID As String) As String
        '=====================================================================
        ' Procedure  Name		:	ReFreshTab
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To ReFreshTab
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    8th-June-2018
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder()
            Dim objfrmReleasePlanning As New frmReleaseMonitoring()
            If (SelectedTab = "History") Then
                strHTML.Append(objfrmReleasePlanning.History_sectionSprintRelease(UniqueID, Flag))
            ElseIf (SelectedTab = "Discussion") Then
                strHTML.Append(objfrmReleasePlanning.Discussion_sectionSprintRelease(UniqueID, Flag))
            ElseIf (SelectedTab = "Teams") Then
                strHTML.Append(objfrmReleasePlanning.Teams_sectionSprintRelease(UniqueID, Flag))
            ElseIf (SelectedTab = "Reviews") Then
                strHTML.Append(objfrmReleasePlanning.Reviews_sectionSprintRelease(UniqueID, Flag))
            End If
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
End Class