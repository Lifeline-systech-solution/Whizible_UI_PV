Imports System.Linq
Imports System.IO
Imports System.Xml
Imports System.Runtime.InteropServices

Public Class frmSprintPlanning
    Inherits WebPages.Template.WhizTemplate
    Protected objClsCommon As New clsCommon
    Protected Shared m_lngReportID As Integer = 20143
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport
#Region "Member Declaration"
    Private WithEvents m_objEmpGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid1 As New WebPages.Template.GenericGrid
    Protected WithEvents m_objNewTaskGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGridUS As New WebPages.Template.GenericGrid
    Private WithEvents objGridSprint As New WebPages.Template.GenericGrid
    Private WithEvents objGridUnmappedSprint As New WebPages.Template.GenericGrid
    Private WithEvents objGridRelease1 As New WebPages.Template.GenericGrid 'objGridUnmappedSprint
    Private WithEvents objGridComplete As New WebPages.Template.GenericGrid
    Private WithEvents objGridCancel As New WebPages.Template.GenericGrid
    Private WithEvents objCurrentSprintUS As New WebPages.Template.GenericGrid
    Private WithEvents objIssuesList As New WebPages.Template.GenericGrid
    Private WithEvents objIssuesListUS As New WebPage.Templates.GenericGrid
    Private WithEvents objReviewList As New WebPages.Template.GenericGrid
    Private WithEvents objReviewListUS As New WebPage.Templates.GenericGrid
    Private WithEvents objImpedimentsLogList As New WebPages.Template.GenericGrid
    Private WithEvents objRiskList As New WebPages.Template.GenericGrid
    Private WithEvents objtaskList As New WebPages.Template.GenericGrid
    Private WithEvents objHistorykList As New WebPages.Template.GenericGrid
    Private WithEvents objHistorykListUS As New WebPages.Template.GenericGrid

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected Shared TagID As String = ""
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""

#End Region
    Protected m_strUserName As String = ""
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

    'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
    Protected strIsSprintStarted As String = ""
    'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or UpdateTasknot


    'Added by Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String
    Protected m_MinHoursForDAEntry As String
    'End of adding by Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change

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

    Private m_strPhase As String = ""
    Private m_strModule As String = ""
    Private m_strSubProject As String = ""
    Private m_strMilestone As String = ""
    Protected m_strEmployeeId As String = ""
    Protected m_strHolidays As String = ""
    Protected m_ChkDeliverable As Integer = 0
    Public globalUSID As String = ""
    Protected Shared globalUSID1 As String = ""

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



    'For Custom Filed
    Protected m_blnShowDefaults As Boolean = True
    Private m_strCurrentType As String = ""
    Private m_strTaskType As String = ""
    Protected declarevariables As String = ""
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    Protected Shared strClientSideScript As String = ""
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
    ' Dim CurrentIterationID As String = ""

    'Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
    Protected strInputFormat As String
    Protected strDateFormat As String
    'End of adding by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        GetAccessRights()

        If Request.Params("Mode") = "Upload" Then
            If Request.Params("Flag") = "UserStory" Then
                UploadData("UserStory")
            ElseIf Request.Params("Flag") = "Sprint" Or Request.Params("Flag") = "Iteration" Then
                UploadData("Iteration")
            ElseIf Request.Params("") = "Release" Then
                UploadData("Release")
            End If
        End If
        If Request.Params("Mode") = "CustomField" Then 'DepartmentID

            Dim strSQLQuery As String = "usp_sel_tbl_PM_TaskTypes_TaskTypeWise_TaskTypeID '" & Request.QueryString("TaskTypeID") & "' "
            m_strCurrentType = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), String)
            PlotCustomFieldsDetails(Request.QueryString("UserStoryId"), m_strCurrentType)
        End If


        If Request.Params("Mode") = "Back" Then 'DepartmentID
            ' strHTML.Append(obj.PlotGrid("", "", flag, strSeletedIteration, tableFlag))
            ' Dim strIterationID As String = Request.Params("IterationID")
            PlotGrid("", "", "Filter", Request.QueryString("IterationID"), "SecondTable", "back")
        End If

        ''Added By Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
            m_MinHoursForDAEntry = CommonFunction.Data.CheckIsDBNull(drCompany("MinHoursForDAEntry"), "0")
        End If
        drCompany.Close()
        drCompany.Dispose()

        ''End of Added By Usha Pandit on 01-March-2019 Purpose::Whizible 2 Work field change

        'Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
        Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)

        Dim DateFormat As String = "usp_sel_tbl_pm_dateformats_FormatDate " + CType(dateFormatID, String)

        strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
        strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)
        'End of Added by Usha Pandit on 27-March-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date

    End Sub
    ''Added By Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getDecimalHours(ByVal HMHours As String) As String
        Try
            Dim fltHours As Decimal

            ''Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 
            If HMHours = "0" Or HMHours = "" Then
                HMHours = "00:00"
            End If

            If HMHours.IndexOf(":") = HMHours.Length - 1 Then
                HMHours = HMHours + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"))
            strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2)
            HMHours = strBeforeDecimal + ":" + strDecimal
            ''End of Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 

            fltHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2)", True)

            Return fltHours.ToString()

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''End of Added By Usha Pandit on 25-March-2019 Purpose::Whizible 2 Work field change

    Protected Function PlotHeader()

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12 fixed-top'>")
        strHTML.Append("<div class='col-md-4 col-sm-4 clsDivHeader' style='margin-left: 30px;margin-top: 7px;'>")
        'strHTML.Append(HttpContext.Current.Session("strProjectName").ToString() & " >> Sprint Planning")
        strHTML.Append("Sprint Planning")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-md-6' style='float:right;margin-right:14px;top: 5px;margin-top:-25px'>")


        ' strHTML.Append("<div class='dropdown' style='float:right'>")
        'strHTML.Append("<button type='button' class='btn btn-info'>")
        'strHTML.Append("Create")
        'strHTML.Append("</button>")
        GetAccessRights()
        'added by Dipali  V On 24th  april 2018 For Access check
        If strIsPrductOwner = 1 Then
            If m_objAccess.Add = True Then
                strHTML.Append("<div class='btn-group dropdown' style='float:right'>")
                strHTML.Append("<button type='button' class='btn btn-info'>")
                strHTML.Append("Create")
                strHTML.Append("</button>")

                'added by ashwini on 21-3-2023 for data-bs-toggle
                strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
                'End Of added by ashwini On 21-3-2023 for data-bs-toggle

                strHTML.Append("<i class='fa fa-sort-down'></i>")
                strHTML.Append("</button>")
                strHTML.Append("<ul class='dropdown-menu' id='ulmodal'>")
                strHTML.Append("<li class='dropdown-item' onclick=ShowModal('User','')>")
                strHTML.Append("User Story")
                strHTML.Append("</li>")
                strHTML.Append("<li class='dropdown-item' onclick=ShowAddSprint()>")
                strHTML.Append("Sprint")
                strHTML.Append("</li>")
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
            End If
        Else
            strHTML.Append("<div class='btn-group dropdown' style='float:right'>")
            strHTML.Append("<button type='button' class='btn btn-info'>")
            strHTML.Append("Create")
            strHTML.Append("</button>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<i class='fa fa-sort-down'></i>")
            strHTML.Append("</button>")
            strHTML.Append("<ul class='dropdown-menu' id='ulmodal'>")
            strHTML.Append("<li class='dropdown-item' onclick=ShowModal('User','')>")
            strHTML.Append("User Story")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")

        End If
        'End ofadded by Dipali V On 24th  april 2018 For Access check
        'strHTML.Append("</div>")

        strHTML.Append("<div class='input-group-btn' style='width: 170px;float:right;margin-right: 35px;display: inline-flex;'><input type='text' name='table_search' id='txtSearchPendingUS' class='txtBox form-control float-end' value=''  placeholder='Search...' style='font-size:14px;height: 34px;'><div class='input-group-btn'><button type='button' class='btn  fa fa-search' style='padding-left: 4px!important;height: 33px;background: #fff;'></button></div></div>") ''onkeyup=PerformSearchForUS() onclick=PerformSearchForUS()

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString()

    End Function

    'Public Function PlotGrid(Optional ByVal strPriorityF As String = "", Optional ByVal strPriorityS As String = "", Optional ByVal flag As String = "", Optional ByVal SelIterationID As String = "", Optional ByVal tableFlag As String = "")
    '    Try
    '        'If SelIterationID = "" Then
    '        '    CurrentIterationID = CommonFunctions.Data.GetDataScalar("select dbo.fn_NG2_Sel_CurrentIterationOrRelease (" & Session("intProjectID") & ",'ITERATION')", True)
    '        'Else
    '        '    CurrentIterationID = SelIterationID
    '        'End If

    '        Dim strHTML As New StringBuilder("")
    '        Dim strSql As String = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",UserStory"
    '        Dim dtSprintPlanningHeader As New DataTable()
    '        Dim hdnCategoryID As String = ""
    '        dtSprintPlanningHeader = CommonFunctions.Data.GetDataTable(strSql, True)

    '        For ph As Integer = 0 To dtSprintPlanningHeader.Rows.Count - 1

    '            If tableFlag = "" Then
    '                strHTML.Append("<div id='MainDiv2' class='col-md-12 col-sm-12'>")
    '                strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
    '            End If


    '            If tableFlag = "FirstTable" Then
    '                strHTML.Append("<div id='fDiv' class='col-md-6 col-sm-12' style='margin-top:30px;    MARGIN-LEFT: 6PX;'>")
    '                strHTML.Append("<div id='FirstDivTbl' c class='table-responsive card Activity' style='border: 1px solid #ccc!important;    border-radius: 5px;'>")
    '                strHTML.Append("<table id='tblFGrid' class='table'>")
    '                strHTML.Append("<thead style='padding: 6px 34PX!important;;' class='card-header card-header-tabs card-header-primary'>") ''display:table;
    '                strHTML.Append("<tr >")

    '                strHTML.Append("<th colspan='2' style='color: white;'><i style='font-weight:bold;font-style:normal;background:none'>Product Backlog</i></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='All' data-bs-placement='bottom'>All <span onclick=FilterGrid('null','') class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("All"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Must Have' data-bs-placement='bottom'>Must <span onclick=FilterGrid('M','') class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Must"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Should Have' data-bs-placement='bottom'>Should <span onclick=FilterGrid('S','') class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Should"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Could Have' data-bs-placement='bottom'>Could <span onclick=FilterGrid('C','') class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Could"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Wont Have' data-bs-placement='bottom'>Won't <span onclick=FilterGrid('W','') class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Wont"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th></th>")
    '                'strHTML.Append("<th></th>")
    '                strHTML.Append("</tr>")
    '                strHTML.Append("</thead>")
    '                strHTML.Append("<tbody id='mainbody1' class='tblCommonFont connectedSortable'>")
    '                'Plot TR
    '                Dim dtFirstTable As New DataTable()
    '                strSql = ""
    '                If strPriorityF = "" Then
    '                    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID")
    '                Else
    '                    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",null," & strPriorityF
    '                End If
    '                dtFirstTable = CommonFunctions.Data.GetDataTable(strSql, True)

    '                If dtFirstTable.Rows.Count > 0 Then

    '                    For PT As Integer = 0 To dtFirstTable.Rows.Count - 1
    '                        hdnCategoryID = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("CategoryID"), "")
    '                        Dim usrStoryID As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "")
    '                        Dim userStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryName"), "")
    '                        Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Description"), "")

    '                        strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver'>")
    '                        strHTML.Append("<td colspan='8'>")
    '                        strHTML.Append("<input type='hidden' name='hdnUserStoryID' id='hdnUserStoryID' value=" & usrStoryID & ">")
    '                        strHTML.Append("<input type='hidden' id='hdnCategoryIDs' name='hdnCategoryIDs' value=" & hdnCategoryID & ">")
    '                        strHTML.Append("<input type='hidden' id='hdnIterationID' name='hdnIterationID' value=" & SelIterationID & ">")
    '                        strHTML.Append("<div style='margin-top: 4px!important;'>")
    '                        strHTML.Append("<table class='table  sprint_card'>")
    '                        strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='bottom'><label class='lblIDS' id='lblUserStoryID'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "") & "</label></span></td>")
    '                        strHTML.Append("<td colspan='7'><span class='wordwrap' data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Feature Name</label> <br/> " & userStoryName & """ data-bs-placement='bottom'>")
    '                        strHTML.Append(userStoryName)
    '                        strHTML.Append("</span>")
    '                        strHTML.Append("</br><span data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Description</label> <br/> " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
    '                        strHTML.Append(Description)
    '                        strHTML.Append("</span></td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
    '                        'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
    '                        'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Story Point"), ""))
    '                        'strHTML.Append("</i></i></i></td>")
    '                        Dim sval As String = ""
    '                        sval = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("T1"), "")
    '                        Dim aVal() As String
    '                        aVal = sval.Split("$")
    '                        'strHTML.Append("<td>" & aVal(1) & "")
    '                        'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryPosition"), ""))
    '                        'strHTML.Append("</td>")
    '                        strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' title='Priority/Complexity/Ranking' data-bs-placement='bottom'>")
    '                        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("InitialRank"), ""))
    '                        strHTML.Append("</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Priority"), "") & "</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='bottom'><i class='far fa-comments' onclick=EditUserStory1(" & usrStoryID & ",'divDiscussions') style='font-size:16px'><span class='badge badge-notifytd' style='background: burlywood;'>0</span></i></span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i onclick=OpenAllSprint(" & usrStoryID & ") class='fas fa-unlink' style='font-size:15px'></i></span>&nbsp;&nbsp;<span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='bottom'><i style='cursor:pointer;' onclick=EditUserStory1(" & usrStoryID & ",'frmDetails')>Detailed..</i></span></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        If PT = 0 Then
    '                            strHTML.Append("<tr id='message1'>")
    '                            strHTML.Append("<td colspan='8'>")
    '                            strHTML.Append("<div>")
    '                            strHTML.Append("<table class='table'>")
    '                            strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("</table>")
    '                            strHTML.Append("</div>")
    '                            strHTML.Append("</td>")
    '                            strHTML.Append("</tr>")
    '                        End If
    '                    Next

    '                Else
    '                    strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver' >")
    '                    strHTML.Append("<td colspan='8'>")
    '                    strHTML.Append("<div>")
    '                    strHTML.Append("<table class='table'>")
    '                    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</td>")
    '                    strHTML.Append("</tr>")
    '                End If

    '                strHTML.Append("</tbody>")
    '                strHTML.Append("</table>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")

    '            ElseIf tableFlag = "" Then ''----------------------Else Part First Table -----------------------

    '                strHTML.Append("<div id='fDiv' class='col-md-6 col-sm-12' style='margin-top: 30px;    MARGIN-LEFT: 6PX;'>")
    '                strHTML.Append("<div id='FirstDivTbl' class='table-responsive card Activity' style='border: 1px solid #ccc!important;    border-radius: 5px;'>")
    '                strHTML.Append("<table id='tblFGrid' class='table ' style=''>")
    '                strHTML.Append("<thead style='padding: 6px 34PX!important;' class='card-header card-header-tabs card-header-primary'>")
    '                strHTML.Append("<tr style='padding: 15px!important;'>")

    '                strHTML.Append("<th colspan='2' style='color: white;'><i style='font-weight:bold;font-style:normal;background:none'>Product Backlog</i></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='All' onclick=FilterGrid('null','') data-bs-placement='bottom'>All <span  class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("All"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Must Have' onclick=FilterGrid('M','') data-bs-placement='bottom'>Must <span  class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Must"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Should Have' onclick=FilterGrid('S','') data-bs-placement='bottom'>Should <span  class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Should"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Could Have' onclick=FilterGrid('C','') data-bs-placement='bottom'>Could <span class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Could"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th><span data-bs-toggle='tooltip' title='Wont Have' onclick=FilterGrid('W','') data-bs-placement='bottom'>Won't <span class='badge badge-notify notifyThFirstTable thHeader'>")
    '                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(ph)("Wont"), ""))
    '                strHTML.Append("</span></span></th>")
    '                strHTML.Append("<th></th>")
    '                'strHTML.Append("<th></th>")
    '                strHTML.Append("</tr>")
    '                strHTML.Append("</thead>")
    '                strHTML.Append("<tbody id='mainbody1' class='tblCommonFont connectedSortable' >")
    '                'Plot TR
    '                Dim dtFirstTable As New DataTable()
    '                strSql = ""
    '                If strPriorityF = "" Then
    '                    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID")
    '                Else
    '                    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",null," & strPriorityF
    '                End If
    '                dtFirstTable = CommonFunctions.Data.GetDataTable(strSql, True)

    '                If dtFirstTable.Rows.Count > 0 Then

    '                    For PT As Integer = 0 To dtFirstTable.Rows.Count - 1
    '                        hdnCategoryID = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("CategoryID"), "")
    '                        Dim usrStoryID As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "")
    '                        Dim userStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryName"), "")
    '                        Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Description"), "")
    '                        strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver' style='' >")
    '                        strHTML.Append("<td colspan='8' >")
    '                        strHTML.Append("<input type='hidden' name='hdnUserStoryID' id='hdnUserStoryID' value=" & usrStoryID & ">")
    '                        strHTML.Append("<input type='hidden' id='hdnCategoryIDs' name='hdnCategoryIDs' value=" & hdnCategoryID & ">")
    '                        strHTML.Append("<input type='hidden' id='hdnIterationID' name='hdnIterationID' value=" & SelIterationID & ">")
    '                        strHTML.Append("<div style=''>")
    '                        strHTML.Append("<table class='table sprint_card'>")
    '                        strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='right'><label class='lblIDS' id='lblUserStoryID'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "") & "</label></span></td>")
    '                        strHTML.Append("<td colspan='7'><span class='wordwrap' data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Feature Name</label> <br/> " & userStoryName & """ data-bs-placement='bottom'>")
    '                        strHTML.Append(userStoryName) 'style='word-break:break-word;'
    '                        strHTML.Append("</span>")
    '                        strHTML.Append("</br><span data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Description</label> <br/> " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
    '                        strHTML.Append(Description)
    '                        strHTML.Append("</span></td>")
    '                        'strHTML.Append("<td colspan='7'><span data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Feature Name</label> <br/> " & Description & """ data-bs-placement='bottom'>")
    '                        'strHTML.Append(Description)
    '                        'strHTML.Append("</span></td>")

    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='right'><i class='fas fa-arrows-alt' style='font-size:16px!important'></i></span></td>")
    '                        'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
    '                        'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Story Point"), ""))
    '                        'strHTML.Append("</i></i></i></td>")
    '                        Dim sval As String = ""
    '                        sval = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("T1"), "")
    '                        Dim aVal() As String
    '                        aVal = sval.Split("$")
    '                        'strHTML.Append("<td>" & aVal(1) & "")
    '                        'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryPosition"), ""))
    '                        'strHTML.Append("</td>")
    '                        strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' title='Priority/Complexity/Ranking' data-bs-placement='bottom'>")
    '                        strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("InitialRank"), ""))
    '                        strHTML.Append("</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Priority"), "") & "</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='bottom'><i class='far fa-comments' onclick=EditUserStory1(" & usrStoryID & ",'divDiscussions') style='font-size:15px'><span class='badge badge-notifytd' style='background: burlywood;'>0</span></i></span></td>")
    '                        strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i onclick=OpenAllSprint(" & usrStoryID & ") class='fas fa-unlink' style='font-size:15px'></i></span>&nbsp;&nbsp;<span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='bottom'><i style='cursor:pointer;' onclick=EditUserStory1(" & usrStoryID & ",'frmDetails')>Detailed..</i></span></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        If PT = 0 Then
    '                            strHTML.Append("<tr id='message1' >")
    '                            strHTML.Append("<td colspan='8'>")
    '                            strHTML.Append("<div>")
    '                            strHTML.Append("<table class='table'>")
    '                            strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("</table>")
    '                            strHTML.Append("</div>")
    '                            strHTML.Append("</td>")
    '                            strHTML.Append("</tr>")
    '                        End If
    '                    Next

    '                Else
    '                    strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver' >")
    '                    strHTML.Append("<td colspan='8'>")
    '                    strHTML.Append("<div>")
    '                    strHTML.Append("<table class='table'>")
    '                    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</td>")
    '                    strHTML.Append("</tr>")
    '                End If

    '                strHTML.Append("</tbody>")
    '                strHTML.Append("</table>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")
    '            End If
    '            '-------------------------------------- 2 nd Table   --------------------------------
    '            '-------------------------------------- 2 nd Table   --------------------------------

    '            If tableFlag = "SecondTable" Then

    '                strHTML.Append("<div id='sDiv' class='col-md-6 col-sm-12' style='margin-top: 30px;    margin-left: 10px;'>")
    '                strHTML.Append("<div id='SecondDivTbl' class='table-responsive card Activity' style='border: 1px solid #ccc!important;    border-radius: 5px;' >")
    '                strHTML.Append("<table id='tblSGrid' class='table'>") 'table-hover table-bordered
    '                strHTML.Append("<thead style='padding: 6px 34PX!important;' class='card-header card-header-tabs card-header-primary'>")
    '                strHTML.Append("<tr  style='padding: 15px!important;'>")

    '                Dim dtSprintPlanningHeader2 As New DataTable()
    '                strSql = ""
    '                strSql = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",Sprint"
    '                dtSprintPlanningHeader2 = CommonFunctions.Data.GetDataTable(strSql, True)
    '                'TH
    '                If dtSprintPlanningHeader2.Rows.Count > 0 Then
    '                    strHTML.Append("<th style='color: white;'><i style='font-weight:bold;font-style:normal;'>Sprint</i></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Total Sprint' data-bs-placement='bottom'>Total <span onclick=FilterGrid2('','Total') class='badge badge-notify thHeader'>")
    '                    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("IterationCount"), ""))
    '                    strHTML.Append("</span></span></th>")
    '                    strHTML.Append("<th style='text-decoration: underline;cursor:pointer;' onclick=FilterGrid2('','Current')><span data-bs-toggle='tooltip' title='Current Sprint' data-bs-placement='bottom'>Current Sprint</span></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Completed' data-bs-placement='bottom'>Completed <span onclick=FilterGrid2('','Completed') class='badge badge-notify thHeader'>")
    '                    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("CompletedIterationCount"), ""))
    '                    strHTML.Append("</span><span></th>")
    '                    strHTML.Append("<th></th>")
    '                    strHTML.Append("<th></th>")
    '                    'strHTML.Append("<th></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Sprint List' data-bs-placement='bottom'><i onclick='ShowAllStoryList()' class='fa fa-list' style='font-size:24px;cursor: pointer;    margin-left: 38px;'></i></span></th>")
    '                    strHTML.Append("</tr>")
    '                End If

    '                strHTML.Append("</thead>")
    '                strHTML.Append("<tbody id='mainbody2' class='tblCommonFont connectedSortable'>")
    '                'Plot TR

    '                Dim dtScrumIterationData As New DataTable()
    '                Dim dtSecondTable As New DataTable()  ''206209154
    '                strSql = ""
    '                If SelIterationID <> "" Then
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData " & Session("intProjectID") & ", " & SelIterationID & ""
    '                ElseIf strPriorityS <> "" Then
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData " & Session("intProjectID") & ",null,'" & strPriorityS & "'"
    '                Else
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'Current'"
    '                End If
    '                dtScrumIterationData = CommonFunctions.Data.GetDataTable(strSql, True)
    '                If dtScrumIterationData.Rows.Count > 0 Then
    '                    For index As Integer = 0 To dtScrumIterationData.Rows.Count - 1
    '                        Dim IterationName As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationName"), "")
    '                        Dim IterationID1 As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationID"), "")
    '                        Dim startDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("StartDate"), "")
    '                        Dim endDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("EndDate"), "")
    '                        Dim PlannedEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("PlannedEffort"), "")
    '                        Dim actualEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ActualEffort"), "")
    '                        Dim TOdO As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoListCount"), "")
    '                        Dim inProgressCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("InProgressCount"), "")
    '                        Dim doneCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoneCount"), "")
    '                        Dim issueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IssueCount"), "")
    '                        Dim discussionCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DiscussionCount"), "")
    '                        Dim noOfDays As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("NoOfDays"), "")

    '                        Dim fchar As Char
    '                        Dim style As String = ""
    '                        fchar = noOfDays.Chars(0)
    '                        fchar = noOfDays.First()
    '                        If fchar = "-" Then
    '                            style = "<i style='background: #da4444;font-style: normal;color: white;padding: 4px;border-radius: 5px;'>"
    '                        Else
    '                            style = "<i style='background: #7aca7e;font-style: normal;color: #fff;padding: 4px;border-radius: 5px;'>"
    '                        End If
    '                        strHTML.Append("<tr class='header UndragFirstRow' colspan='7'  id='MouseOver'>")
    '                        ' strHTML.Append("<tr id='firstRow'>")
    '                        strHTML.Append("<td colspan='7'>")
    '                        strHTML.Append("<div>")
    '                        strHTML.Append("<table class='table sprint_card' style='   background: #fff5f2!important;'>")
    '                        strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                        strHTML.Append("<td colspan='2'><span data-bs-toggle='tooltip' title='Sprint Name' data-bs-placement='bottom'><i onclick=OpenSprintDetailHead('Iteration'," & IterationID1 & ",'div_details') class='setColor' style='cursor:pointer;'>" & IterationName & "</i></span>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & IterationID1 & ">")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td style='text-align:right;'><span data-bs-toggle='tooltip' title='Start Sprint' data-bs-placement='bottom'><button type='button' id='btnStartSprint' class='btn btn-primary' onclick=StartSprint(" & IterationID1 & ")><span class='fa fa-play'></span> Start Sprint</button></span>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & startDate & " To " & endDate & " &nbsp; T/A:" & PlannedEffort & "/" & actualEffort & " &nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;<br/>" & style & "" & noOfDays & "</i>")
    '                        strHTML.Append("</td>")
    '                        'strHTML.Append("<td>To 28 Feb 2018</td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>T/A: 0/0</td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>To Do</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>In Progress</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td>Done</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td><i class='fa fa-bug' style='font-size:20px'><span class='badge badge-notifytd' style='background: red;'>0</span></i>")

    '                        'strHTML.Append("<td><i class='far fa-comments' style='font-size:20px'></i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td><i class='fas fa-chart-bar'></i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        ''-------------------------------------------------------'Plot Sub User Story----------------------------
    '                        strSql = ""
    '                        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
    '                        'If strPriorityS = "" Then
    '                        '    'strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",37467419"
    '                        '    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
    '                        'Else
    '                        '    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & SelIterationID & "," & strPriorityS
    '                        '    'strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",'37467419'," & strPriority
    '                        'End If
    '                        dtSecondTable = CommonFunctions.Data.GetDataTable(strSql, True)
    '                        For PT2 As Integer = 0 To dtSecondTable.Rows.Count - 1
    '                            Dim usrStoryName = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryName"), "")
    '                            Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Description"), "")

    '                            strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver' >")
    '                            strHTML.Append("<td colspan='7'>")
    '                            strHTML.Append("<div style='margin-top: 4px!important;'>")
    '                            strHTML.Append("<table class='table sprint_card'>")
    '                            strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='bottom'><label id='lblUserStoryST'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "") & "</label></span></td>")
    '                            'strHTML.Append("<td colspan='6'><span data-bs-toggle='tooltip' title='Feature Name' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryName"), "") & "</span></td>")
    '                            strHTML.Append("<td colspan='6'><span class='wordwrap' data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Feature Name</label> <br/> " & usrStoryName & """ data-bs-placement='bottom'>" & usrStoryName & "")
    '                            strHTML.Append("</span>")
    '                            strHTML.Append("</br><span data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Description</label> <br/> " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
    '                            strHTML.Append(Description)
    '                            strHTML.Append("</span></td>")

    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("<tr>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
    '                            'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
    '                            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Story Point"), ""))
    '                            'strHTML.Append("</i></i></i></td>")
    '                            strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' title='Priority/Complexity/Ranking' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("InitialRank"), "") & "</span></td>&nbsp;")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Priority"), "") & "</span></td>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")

    '                            Dim ustoryID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "")
    '                            Dim iterationID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IterationID"), "")

    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='bottom'><i class='far fa-comments' onclick=EditUserStory1(" & ustoryID & ",'divDiscussions') style='font-size:15px'></i></span><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")

    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='bottom'><i style='cursor:pointer;' onclick=EditUserStory1(" & ustoryID & ",'frmDetails')>Detailed..</i></span></td>")
    '                            strHTML.Append("<input type='hidden' id='hdnUserStoryID2' name='hdnUserStoryID2' value=" & ustoryID & ">")
    '                            strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & iterationID & ">")
    '                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='Terminate Sprint' data-bs-placement='bottom'><i class='fa fa-share-square-o' style='font-size:16px;color:red;' onclick=CancelUserStory(" & ustoryID & "," & iterationID & ")></i><span></td>")
    '                            'strHTML.Append("<td><i class='fa fa-share-square-o' style='font-size:20px'></i></td>")
    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("</table>")
    '                            strHTML.Append("</div>")
    '                            strHTML.Append("</td>")
    '                            strHTML.Append("</tr>")

    '                            If PT2 = 0 Then
    '                                strHTML.Append("<tr id='message2' >")
    '                                strHTML.Append("<td colspan='7'>")
    '                                strHTML.Append("<div>")
    '                                strHTML.Append("<table class='table'>")
    '                                strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                                strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center;margin-left:136px;' >There are no items to show in this view.</p>")
    '                                strHTML.Append("</tr>")
    '                                strHTML.Append("</table>")
    '                                strHTML.Append("</div>")
    '                                strHTML.Append("</td>")
    '                                strHTML.Append("</tr>")
    '                            End If
    '                        Next
    '                    Next
    '                Else
    '                    strHTML.Append("<tr class='header' colspan='7'  id='MouseOver' >")
    '                    strHTML.Append("<tr id='firstRow'>")
    '                    strHTML.Append("<td colspan='7'>")
    '                    strHTML.Append("<div>")
    '                    strHTML.Append("<table class='table'>")
    '                    strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center;margin-left:136px;' >There are no items to show in this view.</p>")
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</td>")
    '                    strHTML.Append("</tr>")
    '                End If


    '                strHTML.Append("</tbody>")
    '                strHTML.Append("</table>")

    '                strHTML.Append("<div id='dummy'></div>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")

    '            ElseIf tableFlag = "" Then  '' -----------Else Part Second Table----------------------

    '                strHTML.Append("<div id='sDiv' class='col-md-6 col-sm-12' style='margin-top: 30px;    margin-left: 10px;' >")
    '                strHTML.Append("<div id='SecondDivTbl' class='table-responsive card Activity' style='border: 1px solid #ccc!important;    border-radius: 5px;'>")
    '                strHTML.Append("<table id='tblSGrid' class='table' style='border-right:1px inset!important'>") 'table-hover table-bordered
    '                strHTML.Append("<thead style=' padding: 6px 34PX!important;' class='card-header card-header-tabs card-header-primary'>")
    '                strHTML.Append("<tr >")

    '                Dim dtSprintPlanningHeader2 As New DataTable()
    '                strSql = ""
    '                strSql = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",Sprint"
    '                dtSprintPlanningHeader2 = CommonFunctions.Data.GetDataTable(strSql, True)

    '                If dtSprintPlanningHeader2.Rows.Count > 0 Then
    '                    strHTML.Append("<th style='color: white;'><i style='font-weight:bold;font-style:normal;'>Sprint</i></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Total Sprint' data-bs-placement='bottom'>Total <span onclick=FilterGrid2('','Total') class='badge badge-notify thHeader'>")
    '                    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("IterationCount"), ""))
    '                    strHTML.Append("</span></span></th>")
    '                    strHTML.Append("<th style='text-decoration: underline;cursor:pointer;' onclick=FilterGrid2('','Current')><span data-bs-toggle='tooltip' title='Current Sprint' data-bs-placement='bottom'>Current Sprint</span></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Completed' data-bs-placement='bottom'>Completed <span onclick=FilterGrid2('','Completed') class='badge badge-notify thHeader'>")
    '                    strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("CompletedIterationCount"), ""))
    '                    strHTML.Append("</span><span></th>")
    '                    strHTML.Append("<th></th>")
    '                    strHTML.Append("<th></th>")
    '                    'strHTML.Append("<th></th>")
    '                    strHTML.Append("<th><span data-bs-toggle='tooltip' title='Sprint List' data-bs-placement='bottom'><i onclick='ShowAllStoryList()' class='fa fa-list' style='font-size:24px;cursor: pointer;    margin-left: 38px;'></i></span></th>")
    '                    strHTML.Append("</tr>")
    '                End If

    '                strHTML.Append("</thead>")
    '                strHTML.Append("<tbody id='mainbody2' class='tblCommonFont connectedSortable' >")
    '                'Plot TR

    '                Dim dtScrumIterationData As New DataTable()
    '                Dim dtSecondTable As New DataTable()  ''206209154
    '                strSql = ""
    '                If SelIterationID <> "" Then
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ", " & SelIterationID & ""
    '                ElseIf strPriorityS <> "" Then
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'" & strPriorityS & "'"
    '                Else
    '                    strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'Current'"
    '                End If
    '                dtScrumIterationData = CommonFunctions.Data.GetDataTable(strSql, True)
    '                If dtScrumIterationData.Rows.Count > 0 Then
    '                    For index As Integer = 0 To dtScrumIterationData.Rows.Count - 1
    '                        Dim IterationName As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationName"), "")
    '                        Dim IterationID1 As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationID"), "")
    '                        Dim startDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("StartDate"), "")
    '                        Dim endDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("EndDate"), "")
    '                        Dim PlannedEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("PlannedEffort"), "")
    '                        Dim actualEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ActualEffort"), "")
    '                        Dim TOdO As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoListCount"), "")
    '                        Dim inProgressCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("InProgressCount"), "")
    '                        Dim doneCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoneCount"), "")
    '                        Dim issueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IssueCount"), "")
    '                        Dim discussionCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DiscussionCount"), "")
    '                        Dim noOfDays As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("NoOfDays"), "")

    '                        Dim fchar As Char
    '                        Dim style As String = ""
    '                        fchar = noOfDays.Chars(0)
    '                        fchar = noOfDays.First()
    '                        If fchar = "-" Then
    '                            style = "<i style='background:#da4444;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
    '                        Else
    '                            style = "<i style='background:#7aca7e;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
    '                        End If
    '                        strHTML.Append("<tr class='header UndragFirstRow' colspan='7'  id='MouseOver'>")
    '                        ' strHTML.Append("<tr class='UndragFirstRow'>")
    '                        strHTML.Append("<td colspan='7'>")
    '                        strHTML.Append("<div>")
    '                        strHTML.Append("<table class='table sprint_card' style='margin-top: 40px!important;background: #fff5f2!important;'>")

    '                        strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                        strHTML.Append("<td colspan='2'><span data-bs-toggle='tooltip' title='Sprint Name' data-bs-placement='bottom'><i onclick=OpenSprintDetailHead('Iteration'," & IterationID1 & ",'div_details') class='setColor' style='cursor:pointer;'>" & IterationName & "</i></span>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & IterationID1 & ">")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td></td>")
    '                        strHTML.Append("<td style='text-align:right;'><span data-bs-toggle='tooltip' title='Start Sprint' data-bs-placement='bottom'><button type='button' id='btnStartSprint' class='btn btn-primary' onclick=StartSprint(" & IterationID1 & ")><span class='fa fa-play'></span> Start Sprint</button></span>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & startDate & " To " & endDate & " &nbsp; T/A:" & PlannedEffort & "/" & actualEffort & " &nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;'>" & doneCount & "</span><i onclick=OpenSprintIssueHead(" & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead(" & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead(" & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;<br/>" & style & "" & noOfDays & "</i>")
    '                        strHTML.Append("</td>")
    '                        'strHTML.Append("<td>To 28 Feb 2018</td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>T/A: 0/0</td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>To Do</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td style='color: lightblue;'>In Progress</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td>Done</i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td><i class='fa fa-bug' style='font-size:20px'><span class='badge badge-notifytd' style='background: red;'>0</span></i>")

    '                        'strHTML.Append("<td><i class='far fa-comments' style='font-size:20px'></i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        'strHTML.Append("<td><i class='fas fa-chart-bar'></i><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")

    '                        ''-------------------------------------------------------'Plot Sub User Story----------------------------
    '                        strSql = ""
    '                        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
    '                        'If strPriorityS = "" Then
    '                        '    'strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",37467419"
    '                        '    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
    '                        'Else
    '                        '    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & SelIterationID & "," & strPriorityS
    '                        '    'strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",'37467419'," & strPriority
    '                        'End If
    '                        dtSecondTable = CommonFunctions.Data.GetDataTable(strSql, True)
    '                        For PT2 As Integer = 0 To dtSecondTable.Rows.Count - 1
    '                            Dim usrStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryName"), "")
    '                            Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Description"), "")

    '                            strHTML.Append("<tr data-bs-toggle='tooltip' title='Drag Or Click' id='MouseOver' >")
    '                            strHTML.Append("<td colspan='7'>")
    '                            strHTML.Append("<div style='margin-top: 4px!important;'>")
    '                            strHTML.Append("<table class='table  sprint_card'>")
    '                            strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='bottom'><label id='lblUserStoryST'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "") & "</label></span></td>")
    '                            strHTML.Append("<td colspan='6'><span class='wordwrap' data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Feature Name</label> <br/> " & usrStoryName & """ data-bs-placement='bottom'>" & usrStoryName & "")
    '                            strHTML.Append("</span>")
    '                            strHTML.Append("</br><span data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>Description</label> <br/> " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
    '                            strHTML.Append(Description)
    '                            strHTML.Append("</span></td>")

    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("<tr>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
    '                            'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
    '                            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Story Point"), ""))
    '                            'strHTML.Append("</i></i></i></td>")

    '                            strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' title='Priority/Complexity/Ranking' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("InitialRank"), "") & "</span></td>&nbsp;")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Priority"), "") & "</span></td>")
    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")

    '                            Dim ustoryID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "")
    '                            Dim iterationID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IterationID"), "")

    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='bottom'><i class='far fa-comments' onclick=EditUserStory1(" & ustoryID & ",'divDiscussions') style='font-size:15px'></i></span><span class='badge badge-notifytd' style='background: burlywood;'>0</span></td>")

    '                            strHTML.Append("<td><span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='bottom'><i style='cursor:pointer;' onclick=EditUserStory1(" & ustoryID & ",'frmDetails')>Detailed..</i></span></td>")
    '                            strHTML.Append("<input type='hidden' id='hdnUserStoryID2' name='hdnUserStoryID2' value=" & ustoryID & ">")
    '                            strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & iterationID & ">")
    '                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='Terminate Sprint' data-bs-placement='bottom'><i class='fa fa-share-square-o' style='font-size:16px;color:red;' onclick=CancelUserStory(" & ustoryID & "," & iterationID & ")></i><span></td>")
    '                            'strHTML.Append("<td><i class='fa fa-share-square-o' style='font-size:20px'></i></td>")
    '                            strHTML.Append("</tr>")
    '                            strHTML.Append("</table>")
    '                            strHTML.Append("</div>")
    '                            strHTML.Append("</td>")
    '                            strHTML.Append("</tr>")

    '                            If PT2 = 0 Then
    '                                strHTML.Append("<tr id='message2' >")
    '                                strHTML.Append("<td colspan='7'>")
    '                                strHTML.Append("<div>")
    '                                strHTML.Append("<table class='table'>")
    '                                strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                                strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center;margin-left:136px;' >There are no items to show in this view.</p>")
    '                                strHTML.Append("</tr>")
    '                                strHTML.Append("</table>")
    '                                strHTML.Append("</div>")
    '                                strHTML.Append("</td>")
    '                                strHTML.Append("</tr>")
    '                            End If
    '                        Next
    '                    Next
    '                Else
    '                    strHTML.Append("<tr class='header' colspan='7'  id='MouseOver' >")
    '                    strHTML.Append("<tr id='firstRow'>")
    '                    strHTML.Append("<td colspan='7'>")
    '                    strHTML.Append("<div>")
    '                    strHTML.Append("<table class='table'>")
    '                    strHTML.Append("<tr  style='border-bottom:hidden;border-top:hidden;'>")
    '                    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center;margin-left:136px;' >There are no items to show in this view.</p>")
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</td>")
    '                    strHTML.Append("</tr>")
    '                End If


    '                strHTML.Append("</tbody>")
    '                strHTML.Append("</table>")
    '                strHTML.Append("<div id='dummy'></div>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")
    '            End If


    '            If tableFlag = "" Then
    '                strHTML.Append("</div>")
    '            End If
    '        Next


    '        If flag = "Filter" Or SelIterationID <> "" Then
    '            Return strHTML.ToString()

    '        Else
    '            CommonFunctions.General.WriteHTML(strHTML.ToString())
    '        End If
    '        ''Plot Modal popup
    '        Modal_popupdashboard()
    '        Modal_AddSprint()
    '        Modal_AddRelease()


    '    Catch ex As Exception
    '    End Try
    'End Function

    Public Function PlotGrid(Optional ByVal strPriorityF As String = "", Optional ByVal strPriorityS As String = "", Optional ByVal flag As String = "", Optional ByVal SelIterationID As String = "", Optional ByVal tableFlag As String = "", Optional ByVal Frmwhere As String = "")
        Dim strHTML As New StringBuilder()
        'If Frmwhere = "back" Then
        '    strHTML.Append("<div id='Divmain'>")
        'End If
        ''Left Div
        If flag = "Filter" Then

        Else

            If CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "") = "Back" Then
                SelIterationID = Request.QueryString("IterationID")
            End If
        End If

        Dim strSql As String = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",UserStory"
        Dim dtSprintPlanningHeader As New DataTable()
        Dim hdnCategoryID As String = ""
        dtSprintPlanningHeader = CommonFunctions.Data.GetDataTable(strSql, True)

        strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
        'Added BY Dipali V On 26th April 2018 For Refresh Page
        If tableFlag <> "FirstTable" Then
            strHTML.Append("<div id='col-sm-6' style='width:50%'>")
            strHTML.Append("<div id='DivmainLeft'>")
        End If


        'End of Added BY Dipali V On 26th April 2018 For Refresh Page
        strHTML.Append("<div class='draggable' id='divLeft' style='width:97%'>")
        If (dtSprintPlanningHeader.Rows.Count > 0) Then
            strHTML.Append("<div class='card UndragFirstRow'>")
            strHTML.Append("<div id='divHeader1' class='card-header card-header-tabs card-header-primary'>")
            strHTML.Append("<div colspan='2' style='color: white;' class='col-sm-3'><i style='font-weight:bold;font-style:normal;background:none'>Product Backlog</i></div>")
            strHTML.Append("<div class='col-sm-2'><span data-bs-toggle='tooltip' onclick=FilterGrid('null','')>All <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("All"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('M','')>Must <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Must"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('S','')>Should <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Should"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('C','')>Could <span class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Could"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('W','')>Won't <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Wont"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        Dim dtFirstTable As New DataTable()
        strSql = ""
        If strPriorityF = "" Then
            strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID")
        Else
            strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",null," & strPriorityF
        End If
        dtFirstTable = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<div class='box1'>")
        strHTML.Append("<div class='OuterDiv'>")
        If dtFirstTable.Rows.Count > 0 Then

            For PT As Integer = 0 To dtFirstTable.Rows.Count - 1
                hdnCategoryID = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("CategoryID"), "")
                Dim usrStoryID As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "")
                Dim userStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryName"), "")
                Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Description"), "")
                strHTML.Append("<div class='connectedSortable'>")
                strHTML.Append("<div class='panel panel-default'>")
                strHTML.Append("<div class='panel-heading'>")
                strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-container='body' data-bs-placement='bottom'><label class='lblIDS' id='lblUserStoryID'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "") & "</label></span>")

                strHTML.Append("<input type='hidden' name='hdnUserStoryID' id='hdnUserStoryID' value=" & usrStoryID & ">")
                strHTML.Append("<input type='hidden' id='hdnCategoryIDs' name='hdnCategoryIDs' value=" & hdnCategoryID & ">")
                strHTML.Append("<input type='hidden' id='hdnIterationID' name='hdnIterationID' value=" & SelIterationID & ">")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-body'>")
                'Commented & Added By Dipali V On 19th Jan 2020 For Tooltip issue
                'strHTML.Append("<span class='wordwrap' data=container='body' data-bs-toggle='tooltip' title=""<label style='color:#f39c12 '>User Story</label> <br/> " & userStoryName & """ data-bs-placement='bottom'>")
                strHTML.Append("<span class='wordwrap' data=container='body' data-bs-toggle='tooltip' title=""User Story : " & userStoryName & """ data-bs-placement='bottom'>")
                'End of Commented & Added By Dipali V On 19th Jan 2020 For Tooltip issue
                If userStoryName.Length > 150 Then
                    strHTML.Append(userStoryName.Substring(0, 150) & "...")
                Else
                    strHTML.Append(userStoryName)
                End If
                strHTML.Append("</span>")
                'Commented and Added by Usha Pandit On 28 March 2019 for user story large description tooltip 
                'strHTML.Append("</br><span data-bs-toggle='tooltip'  data-bs-container='body' title=""<label style='color:#f39c12 '>Description</label> <br/> " & Description & """ class='Description wordwrap' data-bs-placement='bottom'>")
                strHTML.Append("</br><span data-bs-toggle='tooltip'  data-bs-container='body' title=""Description : " & Description & """ class='Description wordwrap tt_large' data-bs-placement='bottom'>")
                'End of Added by Usha Pandit On 28 March 2019 for user story large description tooltip 

                If Description.Length > 150 Then
                    strHTML.Append(Description.Substring(0, 150) & "...")
                Else
                    strHTML.Append(Description)
                End If
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-footer' >")
                strHTML.Append("<table class='table'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='top'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
                'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
                'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Story Point"), ""))
                'strHTML.Append("</i></i></i></td>")
                Dim sval As String = ""
                sval = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("T1"), "")
                Dim aVal() As String
                aVal = sval.Split("$")
                'strHTML.Append("<td>" & aVal(1) & "")
                'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryPosition"), ""))
                'strHTML.Append("</td>")
                strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' data-bs-container='body' title='Rank' data-bs-placement='top'>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("InitialRank"), ""))
                strHTML.Append("</span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='top' data-bs-container='body'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Priority"), "") & "</span></td>")
                'strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='top' data-bs-container='body'><i class='far fa-comments' onclick=EditUserStory1(" & usrStoryID & ",'divDiscussions') style='font-size:16px'><span class='badge badge-notifytd' style='background: burlywood;'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("DiscussionCount"), "") & "</span></i></span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='top' data-bs-container='body'><i onclick=OpenAllSprint(" & usrStoryID & ") class='fas fa-unlink' style='font-size:15px'></i></span>&nbsp;&nbsp;<span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='top'><i style='cursor:pointer;' onclick=EditUserStory1(" & usrStoryID & ",'frmDetails')>Detailed..</i></span></td>")
                strHTML.Append("<td></td>")
                strHTML.Append("</tr>")


                'If PT = 0 Then
                '    strHTML.Append("<tr id='message1'>")
                '    strHTML.Append("<td colspan='8'>")
                '    strHTML.Append("<div>")
                '    strHTML.Append("<table class='table'>")
                '    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
                '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                '    strHTML.Append("</tr>")
                '    strHTML.Append("</table>")
                '    strHTML.Append("</div>")
                '    strHTML.Append("</td>")
                '    strHTML.Append("</tr>")
                'End If

                strHTML.Append("</table>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
                'If PT = 0 Then

                '    strHTML.Append("<div id='message11'>")
                '    strHTML.Append("<table class='table'>")
                '    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
                '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                '    strHTML.Append("</tr>")
                '    strHTML.Append("</table>")
                '    strHTML.Append("</div>")

                'End If
                ''Commented by Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
            Next

        Else
            strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
            strHTML.Append("<div class='panel-heading'>")
            strHTML.Append("<span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='bottom' style='text-align:center'>There are no items to show in this view.</span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'Commented by yasmin on 21th Aug 2018
            'strHTML.Append("</div>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Added BY Dipali V On 26th April 2018 For Refresh Page
        If tableFlag <> "FirstTable" Then
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If


        'End of Added BY Dipali V On 26th April 2018 For Refresh Page
        ''Right Div

        ' If tableFlag <> "SecondTable" Then
        strHTML.Append("<div id='col-sm-6' style='width:50%'>")
        strHTML.Append("<div id='DivmainRight'>")
        'End If

        strHTML.Append("<div class='draggable' id='divRight' style='width:90%'>")
        Dim dtSprintPlanningHeader2 As New DataTable()
        strSql = ""
        strSql = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",Sprint"
        dtSprintPlanningHeader2 = CommonFunctions.Data.GetDataTable(strSql, True)

        If dtSprintPlanningHeader2.Rows.Count > 0 Then
            strHTML.Append("<div class='card UndragFirstRow'>")
            strHTML.Append("<div id='divHeader1' class='card-header card-header-tabs card-header-primary'>")
            strHTML.Append("<div colspan='2' style='color: white;' class='col-sm-2 col-sm-12'><i style='font-weight:bold;font-style:normal;'>Sprint</i></div>")
            'strHTML.Append("<div class='col-sm-2'><span data-bs-toggle='tooltip' title='Total Sprint' onclick=FilterGrid2('','Total')  data-bs-placement='bottom'>Total <span class='badge badge-notify thHeader notifyThFirstTable'>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("IterationCount"), ""))
            'strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-3'><span onclick=FilterGrid2('','Current')>Current Sprint</span></div>")
            strHTML.Append("<div class='col-sm-3'><span onclick=FilterGrid2('','Completed') >Completed <span  class='badge badge-notify thHeader notifyThFirstTable'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("CompletedIterationCount"), ""))
            strHTML.Append("</span><span></div>")
            strHTML.Append("<div class='col-sm-2 col-sm-3'><span data-bs-toggle='tooltip' title='Sprint List' data-bs-placement='bottom' data-bs-container='body'><i onclick='ShowAllStoryList()' class='fa fa-list' style='font-size:24px;cursor: pointer;    margin-left: 38px;'></i></span></div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        Dim dtScrumIterationData As New DataTable()
        Dim dtSecondTable As New DataTable()  ''206209154
        strSql = ""
        If SelIterationID <> "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ", " & SelIterationID & ""
        ElseIf strPriorityS <> "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'" & strPriorityS & "'"
        ElseIf SelIterationID = "" Or strPriorityS = "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'Latest'"
        Else
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData " & Session("intProjectID") & ",null,'Current'"
        End If
        strHTML.Append("<div class='box1'>")
        strHTML.Append("<div class='OuterDiv '>")
        dtScrumIterationData = CommonFunctions.Data.GetDataTable(strSql, True)
        If dtScrumIterationData.Rows.Count > 0 Then
            For index As Integer = 0 To dtScrumIterationData.Rows.Count - 1
                Dim IterationName As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationName"), "")
                Dim IterationID1 As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationID"), "")
                Dim startDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("StartDate"), "")
                Dim endDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("EndDate"), "")
                Dim PlannedEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("PlannedEffort"), "")
                Dim actualEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ActualEffort"), "")
                Dim TOdO As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoListCount"), "")
                Dim inProgressCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("InProgressCount"), "")
                Dim doneCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoneCount"), "")
                Dim issueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IssueCount"), "")
                Dim discussionCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DiscussionCount"), "")
                Dim noOfDays As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("NoOfDays"), "")
                Dim strIterationStatus As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationStatus"), "")

                'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                Dim strCurrentDate As String = DateTime.Now.ToShortDateString()
                Dim strTaskCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenTaskCount"), "")
                Dim strReviewCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ReviewCount"), "")
                Dim strOpenIssueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenIssueCount"), "")
                Dim result As Integer = DateTime.Compare(Convert.ToDateTime(strCurrentDate), Convert.ToDateTime(endDate))

                If TOdO = "" Then
                    TOdO = "0"
                End If

                If strTaskCount = "" Then
                    strTaskCount = "0"
                End If

                If issueCount = "" Then
                    issueCount = "0"
                End If

                If strReviewCount = "" Then
                    strReviewCount = "0"
                End If
                'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date


                'strHTML.Append("<div class='OuterDiv'>")
                If index = 0 Then
                    strHTML.Append("<div class='panel panel-default UndragFirstRow clsSprint'>")
                Else

                    strHTML.Append("<div class='panel panel-default '>")
                End If
                strHTML.Append("<div class='' style='display:flex;'>")
                Dim fchar As Char
                Dim style As String = ""
                fchar = noOfDays.Chars(0)
                fchar = noOfDays.First()
                If fchar = "-" Then
                    style = "<i style='background:#da4444;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
                Else
                    style = "<i style='background:#7aca7e;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
                End If
                strHTML.Append("<div class='col-sm-6' style='padding-top: 4px;'>")
                strHTML.Append("<span data-bs-toggle='tooltip' data-bs-container='body' title='Sprint Name' data-bs-placement='bottom' data-bs-container='body'><i onclick=OpenSprintDetailHead('Iteration'," & IterationID1 & ",'div_details') class='setColor' style='cursor:pointer;word-break:break-all;'>" & IterationName & "</i></span>") 'Added by Swapna
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-6' style='text-align: right;padding-top: 4px;' >")

                'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                Dim strFlag As String = "0"
                If result = "-1" Then
                    strFlag = "1"
                End If

                Dim blnODSPrintStatusFlag As Boolean = False
                blnODSPrintStatusFlag = checkDODSprintDetailsStatusNA()

                Dim strConfirmBoxMessage As New StringBuilder()

                strConfirmBoxMessage.Append("There are some planned activities for <br> Sprint Name - [" & IterationName & "] are listed below:<br>")
                strConfirmBoxMessage.Append("User Story Count : " & TOdO)
                strConfirmBoxMessage.Append("<br>Open Tasks Count : " & strTaskCount)
                strConfirmBoxMessage.Append("<br>Open Issues Count : " & strOpenIssueCount)
                strConfirmBoxMessage.Append("<br>Open Reviews Count : " & strReviewCount)
                strConfirmBoxMessage.Append("<br>Are you sure to complete the sprint before sprint end date " & endDate & "?")

                'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date


                If strIterationStatus = "Not Yet Started" Then
                    strHTML.Append("<span data-bs-toggle='tooltip' title='Start Sprint' data-bs-placement='bottom' data-bs-container='body'>")

                    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                    'strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick=StartSprint(" & IterationID1 & ")><span class='fa fa-play'></span> Start Sprint</button>")
                    ' strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick='StartSprint(" & IterationID1 & ",&quot;In Process&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><span class='fa fa-play'></span> Start Sprint</button>")
                    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick='StartSprint(" & IterationID1 & ",&quot;In Process&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><span class='fa fa-play'></span> Start Sprint</button>")
                    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                ElseIf strIterationStatus.ToUpper() = "READY TO COMPLETE" Then

                    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                    'strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID1 & ")'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</div>")
                    strHTML.Append("<button type='button' id='idStartItern' class='btn'  onclick='StartSprint(" & IterationID1 & ",&quot;Ready To Complete&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle='tooltip' style='color:rgb(60, 141, 188);' title='Click here to complete sprint' data-placemennt='bottom' data-bs-container='body'></i> Ready To Complete</button>")
                    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                Else
                    strHTML.Append("<span data-bs-toggle='tooltip' title='" & strIterationStatus & "' data-bs-placement='bottom' data-bs-container='body'>")
                    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-success'  disabled style='cursor:no-drop'>" & strIterationStatus & "</button>")
                End If


                strHTML.Append("</span>")
                strHTML.Append("</div>")
                strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & IterationID1 & ">")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-body'>")
                strHTML.Append("<table class='table'>")
                strHTML.Append("<tr>")
                'Commented and Added By Ankush T on 03-04-2019  company output dateformat
                'strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & startDate & " To " & endDate & " &nbsp; T/A:" & PlannedEffort & "/" & actualEffort & " ")

                ''Commented and Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change
                'strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & CommonFunctions.Dates.CGetDate(CType(startDate, Date)) & " To " & CommonFunctions.Dates.CGetDate(CType(endDate, Date)) & " &nbsp; T/A:" & PlannedEffort & "/" & actualEffort & " ")
                Dim HMPlannedEffort As String = ""
                Dim HMActualEffort As String = ""

                HMPlannedEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + PlannedEffort + "',1)", True)
                HMActualEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + actualEffort + "',1)", True)

                strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & CommonFunctions.Dates.CGetDate(CType(startDate, Date)) & " To " & CommonFunctions.Dates.CGetDate(CType(endDate, Date)) & " &nbsp; T/A:" & HMPlannedEffort & "/" & HMActualEffort & " ")
                ''End of Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change

                ' End of Commented and Added By Ankush T on 03-04-2019  company output dateformat
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")


                strHTML.Append("</div>")
                'Added By Ankush T on 21-06-2018  more link
                strHTML.Append("<div class='panel-footer' style='height: 46px;padding: 16px;'>")
                '  strHTML.Append("&nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='To Do'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='In Progress'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;' title='done'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'  title='Issues'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd'  title='Discussions' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;" & style & "" & noOfDays & "</i><a id='Showmore' onclick=""Showmore('Iteration'," & IterationID1 & ")"" title='Details' data-bs-toggle='tooltip' style='float:right;;'>More..</a>")
                strHTML.Append("&nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='To Do'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='In Progress'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;' title='done'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'  title='Issues'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd'  title='Discussions' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;" & style & "" & noOfDays & "</i><a id='Showmore' onclick=""Showmore('Iteration'," & IterationID1 & ")"" title='Details' data-bs-toggle='tooltip' style='float:right;;'>More..</a>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                '                        ''-------------------------------------------------------'Plot Sub User Story----------------------------
                strHTML.Append("<div class='outerRightdiv connectedSortable' id='divRight'>")
                strSql = ""
                strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
                dtSecondTable = CommonFunctions.Data.GetDataTable(strSql, True)
                For PT2 As Integer = 0 To dtSecondTable.Rows.Count - 1
                    strHTML.Append("<div class='outer connectedSortable'  id='divRight'>")
                    Dim usrStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryName"), "")
                    Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Description"), "")
                    strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
                    strHTML.Append("<div class='panel-heading'>")
                    strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-placement='top' data-bs-container='body'><label id='lblUserStoryST'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "") & "</label></span>")

                    strHTML.Append("</span>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='panel-body'>")
                    strHTML.Append("<span class='wordwrap' data-bs-toggle='tooltip' title=""User Story : " & usrStoryName & """ data-bs-placement='bottom'>" & usrStoryName & "</span>")
                    strHTML.Append("</br><span data-bs-toggle='tooltip' title=""Description : " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
                    strHTML.Append(Description)
                    strHTML.Append("</span>")
                    strHTML.Append("</div>")

                    strHTML.Append("<div class='panel-footer' >")
                    strHTML.Append("<table class='table'>")
                    strHTML.Append("<tr>")
                    'commented by Ankush T on 05/06/2018 for right div sprint icon remove
                    'strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
                    'End of commented by Ankush T on 05/06/2018 for right div sprint icon remove

                    strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' data-bs-container='body' title='Rank' data-bs-placement='top'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("InitialRank"), "") & "</span></td>")
                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='top' data-bs-container='body'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Priority"), "") & "</span></td>")
                    'strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")

                    Dim ustoryID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "")
                    Dim iterationID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IterationID"), "")

                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='top' data-bs-container='body'><i class='far fa-comments' onclick=EditUserStory1(" & ustoryID & ",'divDiscussions') style='font-size:15px'></i></span><span class='badge badge-notifytd' style='background: burlywood;'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("DiscussionCount"), "") & "</span></td>")

                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='top' data-bs-container='body'><i style='cursor:pointer;' onclick=EditUserStory1(" & ustoryID & ",'frmDetails')>Detailed..</i></span></td>")
                    strHTML.Append("<input type='hidden' id='hdnUserStoryID2' name='hdnUserStoryID2' value=" & ustoryID & ">")
                    strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & iterationID & ">")

                    Dim Checktaskhas As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Ng2_CheckHastaskornot " & ustoryID & "", True))

                    If CheckIsProductOwner(Session("intUserID")) = 0 Then

                    Else
                        If CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IsUserStoryComplete"), "") = "1" Then
                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='User Story is Completed you can not unmap User Story' data-bs-placement='top' data-bs-container='body'><i class='fa fa-share-square-o' style='font-size:16px;color:red;'></i><span></td>")
                        Else
                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='Unmap User Story' data-bs-placement='top' data-bs-container='body'><i class='fa fa-share-square-o' style='font-size:16px;color:red;' onclick=CancelUserStory(" & ustoryID & "," & iterationID & ")></i><span></td>")
                        End If

                    End If
                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Details' data-bs-placement='top' data-bs-container='body'><i class='moredetail' onclick=""MoreDetailOnClick(" & ustoryID & ")"">More..</i></span></td>")
                    strHTML.Append("</tr>")
                    strHTML.Append("</table>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")

                    ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists
                    'If PT2 = 0 Then
                    '    strHTML.Append("<div id='message22'>")
                    '    strHTML.Append("<table class='table'>")
                    '    strHTML.Append("<tr style='border-bottom:hidden;border-top:hidden;'>")
                    '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>")
                    '    strHTML.Append("</tr>")
                    '    strHTML.Append("</table>")
                    '    strHTML.Append("</div>")
                    'End If
                    ''Commented Usha Pandit on 05-April-2019 Purpose::There are no items message getting display even if records exists

                Next
                strHTML.Append("</div>")
            Next

        Else
            strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
            strHTML.Append("<div class='panel-heading'>")
            strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-placement='bottom' data-bs-container='body' style='text-align:center'>There are no items to show in this view.</span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        '  If tableFlag <> "SecondTable" Then
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ' End If
        'If Frmwhere = "back" Then
        '    strHTML.Append("</div>")
        'End If
        strHTML.Append(Modal_popupdashboard())
        strHTML.Append(Modal_AddSprint())
        strHTML.Append(Modal_AddRelease())
        If flag = "Filter" Then

            If flag = "Filter" Or SelIterationID <> "" Then
                Return strHTML.ToString()

            Else
                CommonFunctions.General.WriteHTML(strHTML.ToString())
            End If
        Else
            CommonFunctions.General.WriteHTML(strHTML.ToString())
        End If

        ''Plot Modal popup

    End Function
    'Added BY Dipali V On 26th April 2018 For Refresh Page
    Function PlotLeftDiv(Optional ByVal strPriorityF As String = "", Optional ByVal strPriorityS As String = "", Optional ByVal flag As String = "", Optional ByVal SelIterationID As String = "", Optional ByVal tableFlag As String = "")
        ''Left Div


        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",UserStory"
        Dim dtSprintPlanningHeader As New DataTable()
        Dim hdnCategoryID As String = ""
        dtSprintPlanningHeader = CommonFunctions.Data.GetDataTable(strSql, True)

        strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
        'If tableFlag <> "FirstTable" Then
        '    strHTML.Append("<div id='DivmainLeft'>")
        'End If
        strHTML.Append("<div class='draggable' id='divLeft' style='width:97%'>")
        If (dtSprintPlanningHeader.Rows.Count > 0) Then
            strHTML.Append("<div class='card UndragFirstRow'>")
            strHTML.Append("<div id='divHeader1' class='card-header card-header-tabs card-header-primary'>")
            strHTML.Append("<div colspan='' style='color: white;' class='col-sm-3'><i style='font-weight:bold;font-style:normal;background:none'>Product Backlog</i></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('null','')>All <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("All"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('M','')>Must <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Must"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('S','')>Should <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Should"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('C','')>Could <span class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Could"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-2'><span onclick=FilterGrid('W','')>Won't <span  class='badge badge-notify notifyThFirstTable thHeader'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader.Rows(0)("Wont"), ""))
            strHTML.Append("</span></span></div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        Dim dtFirstTable As New DataTable()
        strSql = ""
        If strPriorityF = "" Then
            strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID")
        Else
            strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & ",null," & strPriorityF
        End If
        dtFirstTable = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<div class='box1'>")
        strHTML.Append("<div class='OuterDiv'>")
        If dtFirstTable.Rows.Count > 0 Then

            For PT As Integer = 0 To dtFirstTable.Rows.Count - 1
                hdnCategoryID = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("CategoryID"), "")
                Dim usrStoryID As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "")
                Dim userStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryName"), "")
                Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Description"), "")
                strHTML.Append("<div class='connectedSortable'>")
                strHTML.Append("<div class='panel panel-default'>")
                strHTML.Append("<div class='panel-heading'>")
                strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-placement='bottom' data-bs-container='body'><label class='lblIDS' id='lblUserStoryID'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryID"), "") & "</label></span>")

                strHTML.Append("<input type='hidden' name='hdnUserStoryID' id='hdnUserStoryID' value=" & usrStoryID & ">")
                strHTML.Append("<input type='hidden' id='hdnCategoryIDs' name='hdnCategoryIDs' value=" & hdnCategoryID & ">")
                strHTML.Append("<input type='hidden' id='hdnIterationID' name='hdnIterationID' value=" & SelIterationID & ">")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-body'>")
                strHTML.Append("<span class='wordwrap' data-bs-toggle='tooltip' title=""User Story : " & userStoryName & """ data-bs-placement='bottom'>")
                If userStoryName.Length > 150 Then
                    strHTML.Append(userStoryName.Substring(0, 150) & "...")
                Else
                    strHTML.Append(userStoryName)
                End If
                strHTML.Append("</span>")
                strHTML.Append("</br><span data-bs-toggle='tooltip' title=""Description : " & Description & """ data-bs-placement='bottom' class='Description wordwrap'>")
                If Description.Length > 150 Then
                    strHTML.Append(Description.Substring(0, 150) & "...")
                Else
                    strHTML.Append(Description)
                End If
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-footer' >")
                strHTML.Append("<table class='table'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='top' data-bs-container='body'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
                'strHTML.Append("<td><i class='fa fa-arrow-up' style='font-size:20px;color:green'>&nbsp;&nbsp;<i style='color:dimgray;'><i style='font-style:normal!important;font-size:15px;'>")
                'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Story Point"), ""))
                'strHTML.Append("</i></i></i></td>")
                Dim sval As String = ""
                sval = CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("T1"), "")
                Dim aVal() As String
                aVal = sval.Split("$")
                'strHTML.Append("<td>" & aVal(1) & "")
                'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("UserStoryPosition"), ""))
                'strHTML.Append("</td>")
                strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' data-bs-container='body' title='Rank' data-bs-placement='top'>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("InitialRank"), ""))
                strHTML.Append("</span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='top' data-bs-container='body'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("Priority"), "") & "</span></td>")
                'strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='top' data-bs-container='body'><i class='far fa-comments' onclick=EditUserStory1(" & usrStoryID & ",'divDiscussions') style='font-size:16px'><span class='badge badge-notifytd' style='background: burlywood;'>" & CommonFunctions.Data.CheckIsDBNull(dtFirstTable.Rows(PT)("DiscussionCount"), "") & "</span></i></span></td>")
                strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='top' data-bs-container='body'><i onclick=OpenAllSprint(" & usrStoryID & ") class='fas fa-unlink' style='font-size:15px'></i></span>&nbsp;&nbsp;<span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='top'><i style='cursor:pointer;' onclick=EditUserStory1(" & usrStoryID & ",'frmDetails')>Detailed..</i></span></td>")
                strHTML.Append("<td></td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Next

        Else
            strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
            strHTML.Append("<div class='panel-heading'>")
            strHTML.Append("<span data-bs-toggle='tooltip' title='User Story Position' data-bs-placement='top' style='text-align:center'>There are no items to show in this view.</span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function
    'End of Added BY Dipali V On 26th April 2018 For Refresh Page

    'Added by Usha Pandit on 14 Aug 2018 For check DOD Sprint Details Status NA
    Function checkDODSprintDetailsStatusNA() As Boolean
        'usp_sel_tbl_NG2_DefinitionOfDone()
        Dim drGetIsProductOwner As IDataReader
        Dim strQuery As String = ""
        Dim strUserStoryDoneFlag As String = ""
        Dim strSprint_IssueFlag As String = ""
        Dim strSprint_ReviewFlag As String = ""
        strQuery = "usp_sel_tbl_NG2_DefinitionOfDone " & HttpContext.Current.Session("intProjectID")
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(strQuery, True)
        If drGetIsProductOwner.Read Then
            strUserStoryDoneFlag = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("UserStoryDoneFlag").ToString, "")
            strSprint_IssueFlag = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Sprint_IssueFlag").ToString, "")
            strSprint_ReviewFlag = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Sprint_ReviewFlag").ToString, "")

        End If
        If strUserStoryDoneFlag = "3" And strSprint_IssueFlag = "3" And strSprint_ReviewFlag = "3" Then
            Return True
        Else
            Return False
        End If
    End Function
    'End of Added by Usha Pandit on 14 Aug 2018 For check DOD Sprint Details Status NA

    'Added BY Dipali V On 26th April 2018 For Refresh Page
    Function PlotRightDiv(Optional ByVal strPriorityF As String = "", Optional ByVal strPriorityS As String = "", Optional ByVal flag As String = "", Optional ByVal SelIterationID As String = "", Optional ByVal tableFlag As String = "")
        ''Left Div


        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",UserStory"
        Dim dtSprintPlanningHeader As New DataTable()
        Dim hdnCategoryID As String = ""
        dtSprintPlanningHeader = CommonFunctions.Data.GetDataTable(strSql, True)

        strHTML.Append("<input type=hidden id=hdnProjectID value='" & Session("intProjectID") & "'>")
        'If tableFlag <> "FirstTable" Then
        '    strHTML.Append("<div id='DivmainLeft'>")
        'End If
        strHTML.Append("<div class='draggable' id='divRight' style='width:90%'>")
        Dim dtSprintPlanningHeader2 As New DataTable()
        strSql = ""
        strSql = "usp_NG2_sel_UserStoryCount " & Session("intProjectID") & ",Sprint"
        dtSprintPlanningHeader2 = CommonFunctions.Data.GetDataTable(strSql, True)

        If dtSprintPlanningHeader2.Rows.Count > 0 Then
            'strHTML.Append("<div class='box1'>")
            'strHTML.Append("<div class='OuterDiv '>")
            strHTML.Append("<div class='card UndragFirstRow'>")
            strHTML.Append("<div id='divHeader1' class='card-header card-header-tabs card-header-primary'>")
            strHTML.Append("<div colspan='2' style='color: white;' class='col-sm-2 col-sm-12'><i style='font-weight:bold;font-style:normal;'>Sprint</i></div>")
            'strHTML.Append("<div class='col-sm-2'><span data-bs-toggle='tooltip' title='Total Sprint' onclick=FilterGrid2('','Total')  data-bs-placement='bottom'>Total <span class='badge badge-notify thHeader notifyThFirstTable'>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("IterationCount"), ""))
            'strHTML.Append("</span></span></div>")
            strHTML.Append("<div class='col-sm-3'><span onclick=FilterGrid2('','Current')>Current Sprint</span></div>")
            strHTML.Append("<div class='col-sm-3'><span onclick=FilterGrid2('','Completed') >Completed <span  class='badge badge-notify thHeader notifyThFirstTable'>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("CompletedIterationCount"), ""))
            strHTML.Append("</span><span></div>")
            strHTML.Append("<div class='col-sm-2 col-sm-3'><span data-bs-toggle='tooltip' title='Sprint List' data-bs-placement='bottom' data-bs-container='body'><i onclick='ShowAllStoryList()' class='fa fa-list' style='font-size:24px;cursor: pointer;    margin-left: 38px;'></i></span></div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("<table id='tblSGrid' class='table card header_table'>")
            'strHTML.Append("<thead  class='card-header card-header-tabs card-header-primary'>")
            'strHTML.Append("<tr  style='padding: 15px!important;'>")


            'strHTML.Append("<th class='sprint_header'><i style='font-weight:bold;font-style:normal;'>Sprint</i></th>")
            'strHTML.Append("<th class='sprint_header'><span class='sprint_header'  data-bs-toggle='tooltip' title='Total Sprint' onclick=FilterGrid2('','Total')  data-bs-placement='bottom'>Total <span class='header_badge'>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("IterationCount"), ""))
            'strHTML.Append("</span></span></th>")
            'strHTML.Append("<th ><span span class='sprint_header' data-bs-toggle='tooltip' onclick=FilterGrid2('','Current') title='Current Sprint' data-bs-placement='bottom'>Current Sprint</span></th>")
            'strHTML.Append("<th><span class='sprint_header' data-bs-toggle='tooltip' title='Completed' data-bs-placement='bottom' onclick=FilterGrid2('','Completed'>Completed <span class='header_badge'>")
            'strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSprintPlanningHeader2.Rows(0)("CompletedIterationCount"), ""))
            'strHTML.Append("</span><span></th>")
            'strHTML.Append("<th></th>")
            'strHTML.Append("<th></th>")
            'strHTML.Append("<th></th>")
            'strHTML.Append("<th><span class='sprint_header' data-bs-toggle='tooltip' title='Sprint List' data-bs-placement='bottom'><i onclick='ShowAllStoryList()' class='fa fa-list' style='font-size:24px;cursor: pointer;    margin-left: 38px;'></i></span></th>")
            'strHTML.Append("</tr>")

            'strHTML.Append("</thead>")
            'strHTML.Append("</table>")
        End If

        Dim dtScrumIterationData As New DataTable()
        Dim dtSecondTable As New DataTable()  ''206209154
        strSql = ""
        If SelIterationID <> "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ", " & SelIterationID & ""
        ElseIf strPriorityS <> "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'" & strPriorityS & "'"
        ElseIf SelIterationID = "" Or strPriorityS = "" Then
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'Latest'"
        Else
            strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData  " & Session("intProjectID") & ",null,'Current'"
        End If
        strHTML.Append("<div class='box1'>")
        strHTML.Append("<div class='OuterDiv '>")
        strHTML.Append("<div class='outerdiv'>")
        dtScrumIterationData = CommonFunctions.Data.GetDataTable(strSql, True)
        If dtScrumIterationData.Rows.Count > 0 Then
            For index As Integer = 0 To dtScrumIterationData.Rows.Count - 1
                Dim IterationName As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationName"), "")
                Dim IterationID1 As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationID"), "")
                Dim startDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("StartDate"), "")
                Dim endDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("EndDate"), "")
                Dim PlannedEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("PlannedEffort"), "")
                Dim actualEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ActualEffort"), "")
                Dim TOdO As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoListCount"), "")
                Dim inProgressCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("InProgressCount"), "")
                Dim doneCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoneCount"), "")
                Dim issueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IssueCount"), "")
                Dim discussionCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DiscussionCount"), "")
                Dim noOfDays As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("NoOfDays"), "")
                Dim strIterationStatus As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationStatus"), "")

                'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                Dim strCurrentDate As String = DateTime.Now.ToShortDateString()
                Dim strTaskCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenTaskCount"), "")
                Dim strReviewCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ReviewCount"), "")
                Dim strOpenIssueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenIssueCount"), "")
                Dim result As Integer = DateTime.Compare(Convert.ToDateTime(strCurrentDate), Convert.ToDateTime(endDate))

                If TOdO = "" Then
                    TOdO = "0"
                End If

                If strTaskCount = "" Then
                    strTaskCount = "0"
                End If

                If issueCount = "" Then
                    issueCount = "0"
                End If

                If strReviewCount = "" Then
                    strReviewCount = "0"
                End If

                'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date


                If index = 0 Then
                    strHTML.Append("<div class='panel panel-default UndragFirstRow clsSprint'>")
                Else
                    strHTML.Append("<div class='panel panel-default '>")
                End If
                strHTML.Append("<div class='' style='display:flex;'>")
                Dim fchar As Char
                Dim style As String = ""
                fchar = noOfDays.Chars(0)
                fchar = noOfDays.First()
                If fchar = "-" Then
                    style = "<i style='background:#da4444;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
                Else
                    style = "<i style='background:#7aca7e;font-style:normal;color:#fff;padding:4px;border-radius:5px;'>"
                End If
                strHTML.Append("<div class='col-sm-6' style='padding-top: 4px;'>")
                strHTML.Append("<span data-bs-toggle='tooltip' title='Sprint Name' data-bs-placement='bottom' data-bs-container='body'><i onclick=OpenSprintDetailHead('Iteration'," & IterationID1 & ",'div_details') class='setColor' style='cursor:pointer;word-break: break-all;'>" & IterationName & "</i></span>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-6' style='text-align: right;padding-top: 4px;' >")

                'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                Dim strFlag As String = "0"
                If result = "-1" Then
                    strFlag = "1"
                End If

                Dim blnODSPrintStatusFlag As Boolean = False
                blnODSPrintStatusFlag = checkDODSprintDetailsStatusNA()

                Dim strConfirmBoxMessage As New StringBuilder()
                strConfirmBoxMessage.Append("There are some planned activities for <br> Sprint Name - [" & IterationName & "] are listed below:<br>")
                strConfirmBoxMessage.Append("User Story Count : " & TOdO)
                strConfirmBoxMessage.Append("<br>Open Tasks Count : " & strTaskCount)
                strConfirmBoxMessage.Append("<br>Open Issues Count : " & strOpenIssueCount)
                strConfirmBoxMessage.Append("<br>Open Reviews Count : " & strReviewCount)
                strConfirmBoxMessage.Append("<br>Are you sure to complete the sprint before sprint end date " & endDate & "?")


                'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date

                If strIterationStatus = "Not Yet Started" Then
                    strHTML.Append("<span data-bs-toggle='tooltip' title='Start Sprint' data-bs-placement='bottom'>")

                    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                    'strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick=StartSprint(" & IterationID1 & ")><span class='fa fa-play'></span> Start Sprint</button>")
                    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick='StartSprint(" & IterationID1 & ",&quot;In Process&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><span class='fa fa-play'></span> Start Sprint</button>")
                    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                ElseIf strIterationStatus.ToUpper() = "READY TO COMPLETE" Then

                    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                    'strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID1 & ")'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</div>")
                    strHTML.Append("<button type='button' id='idStartItern' class='btn readytorelease' onclick='StartSprint(" & IterationID1 & ",&quot;Ready To Complete&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle='tooltip'  style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</button>")
                    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                Else
                    strHTML.Append("<span data-bs-toggle='tooltip' title='" & strIterationStatus & "' data-bs-placement='bottom' data-bs-container='body'>")
                    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-success'  disabled style='cursor:no-drop'>" & strIterationStatus & "</button>")
                End If


                strHTML.Append("</span>")
                strHTML.Append("</div>")
                strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & IterationID1 & ">")
                strHTML.Append("</div>")

                strHTML.Append("<div class='panel-body'>")
                strHTML.Append("<table class='table'>")
                strHTML.Append("<tr>")

                ''Commented and Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change
                'strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & startDate & " To " & endDate & " &nbsp; T/A:" & PlannedEffort & "/" & actualEffort & " ")
                Dim HMPlannedEffort As String = ""
                Dim HMActualEffort As String = ""

                HMPlannedEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + PlannedEffort + "',1)", True)
                HMActualEffort = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + actualEffort + "',1)", True)

                strHTML.Append("<td colspan='6' style='font-size:12px!important;'>" & startDate & " To " & endDate & " &nbsp; T/A:" & HMPlannedEffort & "/" & HMActualEffort & " ")
                ''End of Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change

                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("</table>")


                strHTML.Append("</div>")
                'Added By Ankush T on 21-06-2018  more link
                strHTML.Append("<div class='panel-footer' style='height: 46px;padding: 16px;'>")
                'strHTML.Append("&nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='To Do'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='In Progress'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;' title='done'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'  title='Issues'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd'  title='Discussions' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;" & style & "" & noOfDays & "</i>")
                'strHTML.Append("&nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='To Do'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='In Progress'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;' title='done'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'  title='Issues'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd'  title='Discussions' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;" & style & "" & noOfDays & "</i><a id='Showmore' onclick=""Showmore('Iteration'," & IterationID1 & ")"" title='Details' data-bs-toggle='tooltip' style='margin-left: 20px;'>More..</a>")
                strHTML.Append("&nbsp; <i class=' fa fa-list-ol'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='To Do'>" & TOdO & "</span>&nbsp; <i class=' fa fa-spinner'></i></i><span class='badge badge-notifytd' style='background: burlywood;' title='In Progress'>" & inProgressCount & "</span> &nbsp; <i class=' far fa-check-square'></i><span  class='badge badge-notifytd' style='background: burlywood;' title='done'>" & doneCount & "</span><i onclick=OpenSprintIssueHead('Iteration'," & IterationID1 & ",'div_Issues') class='fa fa-bug' style='font-size:14px; color:black;'><span class='badge badge-notifytd' style='background: red;'  title='Issues'>" & issueCount & "</span></i> &nbsp; <i onclick=OpenSprintDiscussionHead('Iteration'," & IterationID1 & ",'div_Discussion') class='far fa-comments' style='font-size:15px;color:black;'></i><span class='badge badge-notifytd'  title='Discussions' style='background: burlywood;'>" & discussionCount & "</span>&nbsp;<i onclick=OpenSprintChartsHead('Iteration'," & IterationID1 & ",'div_graph') style='color:black;' class='fas fa-chart-bar'></i>&nbsp;" & style & "" & noOfDays & "</i><a id='Showmore' onclick=""Showmore('Iteration'," & IterationID1 & ")"" title='Details' data-bs-toggle='tooltip' style='float:right;;'>More..</a>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                ''-------------------------------------------------------'Plot Sub User Story----------------------------
                strHTML.Append("<div class='outerRightdiv connectedSortable' id='divRight'>")
                strSql = ""
                strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intProjectID") & "," & dtScrumIterationData.Rows(index).Item("IterationID") & ""
                dtSecondTable = CommonFunctions.Data.GetDataTable(strSql, True)
                For PT2 As Integer = 0 To dtSecondTable.Rows.Count - 1
                    Dim usrStoryName As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryName"), "")
                    Dim Description As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Description"), "")
                    strHTML.Append("<div class='outer connectedSortable' id='divRight'>")
                    strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
                    strHTML.Append("<div class='panel-heading'>")
                    strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-placement='bottom' data-bs-container='body'><label id='lblUserStoryST'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "") & "</label></span>")

                    strHTML.Append("</span>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='panel-body'>")
                    strHTML.Append("<span class='wordwrap' data-bs-toggle='tooltip' data-bs-container='body' title=""User Story : " & usrStoryName & """ data-bs-placement='bottom'>" & usrStoryName & "")
                    strHTML.Append("</br><span data-bs-toggle='tooltip' title=""Description : " & Description & """ data-bs-placement='bottom' data-bs-container='body' class='Description wordwrap'>")
                    strHTML.Append(Description)
                    strHTML.Append("</span>")
                    strHTML.Append("</div>")

                    strHTML.Append("<div class='panel-footer' >")
                    strHTML.Append("<table class='table'>")
                    strHTML.Append("<tr>")
                    'commented by Ankush T on 05/06/2018 for right div sprint icon remove
                    ' strHTML.Append("<td><span data-bs-toggle='tooltip' title='Map To Sprint' data-bs-placement='bottom'><i class='fas fa-arrows-alt' style='font-size:16px'></i></span></td>")
                    ' End of commented by Ankush T on 05/06/2018 for right div sprint icon remove

                    strHTML.Append("<td style='color: red;'><span data-bs-toggle='tooltip' data-bs-container='body' title='Rank' data-bs-placement='top'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("InitialRank"), "") & "</span></td>")
                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Priority' data-bs-placement='top'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("Priority"), "") & "</span></td>")
                    'strHTML.Append("<td><span data-bs-toggle='tooltip' title='Unassigned' data-bs-placement='bottom'>Unassigned</span></td>")

                    Dim ustoryID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("UserStoryID"), "")
                    Dim iterationID As String = CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IterationID"), "")

                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='User Story Discussion' data-bs-placement='top' data-bs-container='body'><i class='far fa-comments' onclick=EditUserStory1(" & ustoryID & ",'divDiscussions') style='font-size:15px'></i></span><span class='badge badge-notifytd' style='background: burlywood;'>" & CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("DiscussionCount"), "") & "</span></td>")

                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Detailed' data-bs-placement='top' data-bs-container='body'><i style='cursor:pointer;' onclick=EditUserStory1(" & ustoryID & ",'frmDetails')>Detailed..</i></span></td>")
                    strHTML.Append("<input type='hidden' id='hdnUserStoryID2' name='hdnUserStoryID2' value=" & ustoryID & ">")
                    strHTML.Append("<input type='hidden' id='hdnIterationID2' name='hdnIterationID2' value=" & iterationID & ">")

                    Dim Checktaskhas As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Ng2_CheckHastaskornot " & ustoryID & "", True))

                    If CheckIsProductOwner(Session("intUserID")) = 0 Then

                    Else
                        If CommonFunctions.Data.CheckIsDBNull(dtSecondTable.Rows(PT2)("IsUserStoryComplete"), "") = "1" Then
                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='User Story is Completed you can not unmap User Story' data-bs-placement='top' data-bs-container='body'><i class='fa fa-share-square-o' style='font-size:16px;color:red;'></i><span></td>")
                        Else
                            strHTML.Append("<td style='border-top-color:transparent'><span data-bs-toggle='tooltip' title='Unmap User Story' data-bs-placement='top' data-bs-container='body'><i class='fa fa-share-square-o' style='font-size:16px;color:red;' onclick=CancelUserStory(" & ustoryID & "," & iterationID & ")></i><span></td>")
                        End If

                    End If
                    strHTML.Append("<td><span data-bs-toggle='tooltip' title='Details' data-bs-placement='top' data-bs-container='body'><i class='moredetail' onclick=""MoreDetailOnClick(" & ustoryID & ")"">More..</i></span></td>")

                    strHTML.Append("</tr>")
                    strHTML.Append("</table>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                Next
                strHTML.Append("</div>")
            Next

        Else
            strHTML.Append("<div class='panel panel-default UndragFirstRow'>")
            strHTML.Append("<div class='panel-heading'>")
            strHTML.Append("<span data-bs-toggle='tooltip' title='User Story ID' data-bs-placement='top' data-bs-container='body' style='text-align:center'>There are no items to show in this view.</span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    'End of Added BY Dipali V On 26th April 2018 For Refresh Page



    <System.Web.Services.WebMethod()>
    Public Shared Function GetPriorityGrid(ByVal strPriorityF As String, ByVal strPriorityS As String, ByVal flag As String, ByVal tableFlag As String) As String
        '=====================================================================
        ' Procedure Name        : Product Backlog GetPriorityGrid()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 4 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder("")
            Dim dtFirstTable As New DataTable()
            'Added BY Dipali V On 26th April 2018 For Refresh Page'
            If tableFlag = "FirstTable" Then
                strHTML.Append(obj.PlotLeftDiv(strPriorityF, strPriorityS, flag, "", tableFlag))
                'End of Added BY Dipali V On 26th April 2018 For Refresh Page
                'Added BY Dipali V On 26th April 2018 For Refresh Page'SecondTable
            ElseIf tableFlag = "SecondTable" Then
                strHTML.Append(obj.PlotRightDiv(strPriorityF, strPriorityS, flag, "", tableFlag))
                'End of Added BY Dipali V On 26th April 2018 For Refresh Page
            Else
                strHTML.Append(obj.PlotGrid(strPriorityF, strPriorityS, flag, "", tableFlag))

            End If

            Return strHTML.ToString()

        Catch ex As Exception

            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetIterationFilterGrid(ByVal strSeletedIteration As String, ByVal flag As String, ByVal tableFlag As String) As String
        '=====================================================================
        ' Procedure Name        : Product Backlog GetIterationFilterGrid()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 6 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder("")
            Dim dtFirstTable As New DataTable()
            strHTML.Append(obj.PlotGrid("", "", flag, strSeletedIteration, tableFlag))
            'strHTML.Append(obj.PlotRightDiv("", "", flag, strSeletedIteration, tableFlag))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function InsertSortedRowsLeftTable(ByVal UserStoryID As String, ByVal CategoryVal As String, ByVal DragUserStoryID As String) As String
        '=====================================================================
        ' Procedure Name        : Product Backlog InsertSortedRowsLeftTable()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 2 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try
            UserStoryID = UserStoryID.Remove(UserStoryID.LastIndexOf(","))
            'CategoryVal = CategoryVal.Remove(CategoryVal.LastIndexOf(","))

            Dim strPos As String = ""
            Dim UserstoryIDs() As String
            Dim CategoryID() As String
            UserstoryIDs = UserStoryID.Split(",")
            'CategoryID = CategoryVal.Split(",")
            Dim category() As String
            'category = CategoryVal.Split(",")

            If CategoryVal = "" Then
                CategoryVal = "NULL"
            End If
            Dim strSql As String = ""
            strSql = "usp_NG2_upd_tbl_PM_ScrumUserStory "
            strSql = strSql & "" & CategoryVal & ","
            strSql = strSql & "" & DragUserStoryID & ","
            strSql = strSql & "'" & UserStoryID & "',"
            strSql = strSql & "" & HttpContext.Current.Session("intProjectID") & ""

            CommonFunctions.Data.InsertOrUpdateData(strSql, True)

            'For i As Integer = 0 To UserstoryIDs.Length - 1
            '    Dim strSql As String = ""
            '    strSql = "usp_NG2_upd_tbl_PM_ScrumUserStory "
            '    strSql = strSql & "" & CategoryID(i) & ","
            '    strSql = strSql & "" & DragUserStoryID & ","
            '    strSql = strSql & "'" & UserStoryID & "',"
            '    strSql = strSql & "" & HttpContext.Current.Session("intProjectID") & ""

            '    CommonFunctions.Data.InsertOrUpdateData(strSql, True)
            'Next
        Catch ex As Exception

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ScrumIterationList(ByVal Mode As String)
        '=====================================================================
        ' Procedure Name        : Sprint ScrumIterationList()	
        ' Purpose               : To Add Sprint Planning
        ' Description           : To Add Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 1 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try


            Dim strGridHTML As New StringBuilder("")

            Dim obj As New frmSprintPlanning()
            strGridHTML.Append(obj.WriteGrid("", Mode))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ScrumIterationListSearch(ByVal TextSearchVal As String) As String
        '=====================================================================
        ' Procedure Name        : Sprint ScrumIterationListSearch()	
        ' Purpose               : To Add Search Sprint Planning
        ' Description           : To Add Search Sprint Planning
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 8 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")

            Dim obj As New frmSprintPlanning()
            strGridHTML.Append(obj.WriteGrid(TextSearchVal, ""))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Private Function WriteGrid(Optional ByVal TextSearchVal As String = "", Optional ByVal Mode As String = "") As String
        '=====================================================================
        ' Procedure Name        : WriteGrid()	
        ' Purpose               : To Plot Sprint List Grid
        ' Description           :  To Plot Sprint List Grid
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : bALASAHEB
        ' Created               : 6th MArch 2018
        ' Revisions             : None
        '=====================================================================


        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        intNoOfDataColumn = 4
        strDivID = "DivSprintlist"
        If Mode <> "OnlyReady" Then
            If TextSearchVal = "" Then
                strSQLQuery = "usp_NG2_SEL_tbl_PM_ScrumIterationData " & HttpContext.Current.Session("IntProjectID") & ""
            Else
                strSQLQuery = "usp_NG2_SEL_tbl_PM_ScrumIterationData " & HttpContext.Current.Session("IntProjectID") & ",null,null," & TextSearchVal & ""
            End If

        Else
            If TextSearchVal = "" Then
                strSQLQuery = " usp_NG2_SEL_tbl_PM_ScrumIterationData_List  " & HttpContext.Current.Session("IntProjectID") & ""
            Else
                strSQLQuery = " usp_NG2_SEL_tbl_PM_ScrumIterationData_List  " & HttpContext.Current.Session("IntProjectID") & ",null,null," & TextSearchVal & ""
            End If
        End If

        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterListCount value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue


        arrstrActualList = {"IterationName", "StartDate", "EndDate", "IterationStatus", ""}
        'Added & Commented By Dipali V On 26th June 2019 For Column Header Issue
        'arrstrUserFriendlyList = {"Sprint Name", "Start Date", "End Date", "Sprint Status", "SELECT"}
        arrstrUserFriendlyList = {"Sprint Name", "Start Date", "End Date", "Sprint Status", "Select"}
        'End of Added & Commented By Dipali V On 26th June 2019 For Column Header Issue
        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

        'objGrid = m_objEmpGrid

        With m_objEmpGrid
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
        m_objEmpGrid = Nothing
        'End If
        Return strGridHTML.ToString


    End Function
    Private Sub m_objEmpGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objEmpGrid.DataRowTR_BeforePrint

        'Cancel = True
        'Args.clsTR.Remove()
        'Args.StringToBeInserted = "<tr role='row' class='" & strClass & "'></tr>"

        'If strClass = "clsTROdd" Then
        '    strClass = "clsTREvenRow"
        'End If
    End Sub

    'Private Sub m_objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEmpGrid.DataRowTD_BeforePrint

    '    If Args.DataField.ToUpper = "EDIT" Then
    '        Cancel = True

    '        Args.StringToBeInserted = "<td align='center'   title=" & Args.DataField & "><i class='fa fa-pencil-square-o' data-bs-placement='bottom' data-bs-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Customer_OnClick(" & Args.DataReader("LoginID") & ",'" & IsActiveLogin & "')""  title='Edit' id='Editdata_" & Args.DataReader("LoginID") & "'></i></td>"
    '    End If

    '    If Args.ColumnName.ToUpper = "DELETE" Then
    '        Cancel = True
    '        'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
    '        'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("LoginID") & " >" + "</TD>"
    '        Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("LoginID") & " >" + "</TD>"
    '        'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
    '    End If

    'End Sub
    Private Sub m_objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEmpGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Sprint Name' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "START DATE" Then
            Cancel = True
            'Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Start Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StartDate"), "") + "</p></TD>"
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Start Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(CType(Args.DataReader("StartDate"), Date)), "") + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "END DATE" Then
            Cancel = True
            'Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'End Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate"), "") + "</p></TD>"
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'End Date' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(CType(Args.DataReader("EndDate"), Date)), "") + "</p></TD>"

        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Select' data-bs-placement='bottom'><input type='checkbox' value='" & Args.DataReader("IterationID") & "' title='Select' name='chkIterationSel' class='clscheckbox' onclick='SelectOne(this)'>" + "</p></TD>"
        End If
        If Args.ColumnName.ToUpper = "SPRINT STATUS" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'><p data-bs-toggle='tooltip' Title = 'Sprint Status' data-bs-placement='bottom'>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationStatus"), "Not Specified") + "</p></TD>"
        End If

        'If Args.ColumnName.ToUpper = "ITERATION STATUS" Then
        '    If Not IsDBNull(Args.DataReader("IterationStatus")) Then
        '        Cancel = True
        '        ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-bs-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
        '        Args.StringToBeInserted = "<td align='center' ><p Title = 'Iteration Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationStatus"), "") & "</p></TD>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted = "<td align='center' ><p Title = 'Iteration Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</p></TD>"
        '    End If

        '    ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        'End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckActivityFilledAgainstIssueReview(ByVal userStoryID As String, ByVal IterationID As String) As String

        If userStoryID = "" Then
            userStoryID = "NULL"
        End If

        If IterationID = "" Then
            IterationID = "NULL"
        End If
        Dim strSql As String

        Try
            strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Chk_ActivityFilled_ReviewIssueTasks " & userStoryID & "," & IterationID, True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckTasksMappedToUserStory(ByVal userStoryID As String, ByVal IterationID As String) As String
        '=====================================================================
        ' Procedure Name        :  CheckTasksMappedToUserStory()	
        ' Purpose               : To Add Unmap User Story
        ' Description           : To Add Unmap User Story
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 5 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder()
            If userStoryID = "" Then
                userStoryID = "NULL"
            End If
            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Chk_Tasks_ForCancellingUS " & userStoryID & "," & IterationID & ",''", True), "0")
            If Not strSql Is Nothing Then
                strHTML.Append("<table style='width: 100%; padding-right: 2%;'>")
                strHTML.Append("<tbody>")
                strHTML.Append("<tr>")
                strHTML.Append("<td colspan='2'>")
                strHTML.Append("<p style='white-space: pre; text-align: left;'>")
                strHTML.Append(strSql)
                strHTML.Append("</p>")
                strHTML.Append("<td>")
                strHTML.Append("</tr>")
                strHTML.Append("<tr>")
                strHTML.Append("<td style='text-align: left;border: 0px!important;float: left;'>Unmap Remark : </td>")
                strHTML.Append("<td style='text-align: left;border: 0px!important'>")
                strHTML.Append("<textarea id='txtRemark" & IterationID & "' maxlength=2000 onkeyup=CheckTextLength(this,'smallRemark','spanRemark" & IterationID & "') onchange=ClearSpan('txtRemark" & IterationID & "','spantxtRemark') style='width:400px;margin-bottom: 20px;' data-autoresize></textarea>")
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark" & IterationID, "txtRemark" & IterationID, , "form-control", , , , , , 50, 2000, , , , , False, , , "onkeyup=CheckTextLength(this,'smallRemark','spanRemark" & IterationID & "') onKeyUp=CheckTextLength(this,'smallRemark', 'spanRemark" & IterationID & "') onchange=ClearSpan('txtRemark" & IterationID & "','spantxtRemark')", True, EnableHTMLEncode:=True))
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark" & IterationID & "", "txtRemark" & IterationID & "", , "form-control", , , , , , 50, 2000, , , , , False, , , "onkeyup=CheckTextLength(this,'smallRemark','spanRemark" & IterationID & "') onkeyup='javascript:limitText(this,'spanRemark" & IterationID & "',2000)' onchange=ClearSpan('txtRemark','spantxtRemark')", True, EnableHTMLEncode:=True))


                strHTML.Append("<span id='smallRemark'>2000</span>")
                strHTML.Append("</td>")

                strHTML.Append("</tr>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append("</td>")
                strHTML.Append("<td class='spnCss'>")
                strHTML.Append("<span id='spanRemark" & IterationID & "' style='color:red' >Please Enter Remark.</span>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")

                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append("</td>")
                strHTML.Append("<td style='text-align:right;'>")
                strHTML.Append("<button type='button' id='btnRemark" & userStoryID & "' class='btn btn-default clsterminate' style='width:auto;background-color: #3C8DBC!important;color: white;float:right;margin-top: 20px;' onclick=""TerminateUserStory(" & userStoryID & "," & IterationID & ", txtRemark" & IterationID & ",this)"" >Unmap From Sprint</button>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")

                strHTML.Append("</tbody>")
                strHTML.Append("</table>")
                Return strHTML.ToString()
            Else
                Return strSql
            End If

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'Added by Usha Pandit on 23 Aug 2018 for Refresh Tasks Review and issue count if any changes made
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckTasksMappedToSprint(ByVal IterationID As String) As String
        '=====================================================================
        ' Procedure Name        :  CheckTasksMappedToSprint()	
        ' Purpose               : To Add Unmap User Story
        ' Description           : To Add Unmap User Story
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 5 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try


            Dim strConfirmBoxMessage As New StringBuilder()
            Dim frmSprintPlanning As New frmSprintPlanning()
            Dim strHTML As New StringBuilder()
            Dim dtScrumIterationData As New DataTable()
            Dim strSql As String = ""
            Dim strPriorityS As String = ""


            Dim SprintStatus As String = ""
            Dim EndDateFlag As String = ""
            Dim DODSprintStatusFlag As String = ""

            If IterationID <> "" Then
                strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData_CompleteBeforeEndDate  " & HttpContext.Current.Session("intProjectID") & ", " & IterationID & ""
            ElseIf strPriorityS <> "" Then
                strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData_CompleteBeforeEndDate  " & HttpContext.Current.Session("intProjectID") & ",null,'" & strPriorityS & "'"
            ElseIf IterationID = "" Or strPriorityS = "" Then
                strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData_CompleteBeforeEndDate  " & HttpContext.Current.Session("intProjectID") & ",null,'Latest'"
            Else
                strSql = " usp_NG2_SEL_tbl_PM_ScrumIterationData_CompleteBeforeEndDate " & HttpContext.Current.Session("intProjectID") & ",null,'Current'"
            End If

            dtScrumIterationData = CommonFunctions.Data.GetDataTable(strSql, True)
            If dtScrumIterationData.Rows.Count > 0 Then
                For index As Integer = 0 To dtScrumIterationData.Rows.Count - 1
                    Dim IterationName As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationName"), "")
                    Dim IterationID1 As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationID"), "")
                    Dim startDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("StartDate"), "")
                    Dim endDate As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("EndDate"), "")
                    Dim PlannedEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("PlannedEffort"), "")
                    Dim actualEffort As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ActualEffort"), "")
                    Dim TOdO As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoListCount"), "")
                    Dim inProgressCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("InProgressCount"), "")
                    Dim doneCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DoneCount"), "")
                    Dim issueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IssueCount"), "")
                    Dim discussionCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("DiscussionCount"), "")
                    Dim noOfDays As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("NoOfDays"), "")
                    Dim strIterationStatus As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("IterationStatus"), "")

                    'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                    Dim strCurrentDate As String = DateTime.Now.ToShortDateString()
                    Dim strTaskCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenTaskCount"), "")
                    Dim strReviewCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("ReviewCount"), "")
                    Dim strOpenIssueCount As String = CommonFunctions.Data.CheckIsDBNull(dtScrumIterationData.Rows(index)("OpenIssueCount"), "")
                    Dim result As Integer = DateTime.Compare(Convert.ToDateTime(strCurrentDate), Convert.ToDateTime(endDate))

                    If TOdO = "" Then
                        TOdO = "0"
                    End If

                    If strTaskCount = "" Then
                        strTaskCount = "0"
                    End If

                    If issueCount = "" Then
                        issueCount = "0"
                    End If

                    If strReviewCount = "" Then
                        strReviewCount = "0"
                    End If
                    'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date


                    'strHTML.Append("<div class='OuterDiv'>")


                    'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
                    Dim strFlag As String = "0"
                    If result = "-1" Then
                        strFlag = "1"
                    End If


                    Dim blnODSPrintStatusFlag As Boolean = False
                    blnODSPrintStatusFlag = frmSprintPlanning.checkDODSprintDetailsStatusNA()

                    EndDateFlag = strFlag
                    DODSprintStatusFlag = blnODSPrintStatusFlag

                    strConfirmBoxMessage.Append("There are some planned activities for <br> Sprint Name - [" & IterationName & "] are listed below:<br>")
                    strConfirmBoxMessage.Append("User Story Count : " & TOdO)
                    strConfirmBoxMessage.Append("<br>Open Tasks Count : " & strTaskCount)
                    strConfirmBoxMessage.Append("<br>Open Issues Count : " & strOpenIssueCount)
                    strConfirmBoxMessage.Append("<br>Open Reviews Count : " & strReviewCount)
                    strConfirmBoxMessage.Append("<br>Are you sure to complete the sprint before sprint end date " & endDate & "?")
                    strConfirmBoxMessage.Append("<br><br>You may visit the DOD settings to bind the process for Sprint closure")

                    'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date


                    If strIterationStatus = "Not Yet Started" Then
                        'Added by Ankush T on 26 Mar 2018 For If US done is NA then status is displaying as Inprogress
                        'SprintStatus = "In Process"
                        Dim UserStoryDoneFlag As String = ""
                        Dim strQuery As String
                        Dim drUserStoryDone As IDataReader
                        strQuery = "usp_sel_tbl_NG2_DefinitionOfDone " & HttpContext.Current.Session("intProjectID")
                        drUserStoryDone = CommonFunctions.Data.GetDataReader(strQuery, True)
                        If drUserStoryDone.Read Then
                            UserStoryDoneFlag = CommonFunctions.Data.CheckIsDBNull(drUserStoryDone("UserStoryDoneFlag").ToString, "")
                        End If
                        If UserStoryDoneFlag = "3" Then
                            SprintStatus = "Not Yet Started"
                        Else
                            SprintStatus = "In Process"
                        End If
                        'End of Added by Ankush T on 26 Mar 2018 For If US done is NA then status is displaying as Inprogress

                        '    strHTML.Append("<span data-bs-toggle='tooltip' title='Start Sprint' data-bs-placement='bottom'>")

                        '    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                        '    'strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick=StartSprint(" & IterationID1 & ")><span class='fa fa-play'></span> Start Sprint</button>")
                        '    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-primary' onclick='StartSprint(" & IterationID1 & ",&quot;In Process&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><span class='fa fa-play'></span> Start Sprint</button>")
                        '    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                    ElseIf strIterationStatus.ToUpper() = "READY TO COMPLETE" Then
                        SprintStatus = "Ready To Complete"

                        '    'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                        '    'strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID1 & ")'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</div>")
                        '    strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID1 & ",&quot;Ready To Complete&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;,&quot;" & strConfirmBoxMessage.ToString() & "&quot;)'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</div>")
                        '    'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

                    Else
                        '    strHTML.Append("<span data-bs-toggle='tooltip' title='" & strIterationStatus & "' data-bs-placement='bottom'>")
                        '    strHTML.Append("<button type='button' id='btnStartSprint' class='btn btn-success'  disabled style='cursor:no-drop'>" & strIterationStatus & "</button>")
                    End If
                Next
            End If
            Return SprintStatus & "###" & EndDateFlag & "###" & DODSprintStatusFlag & "###" & strConfirmBoxMessage.ToString()


        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added by Usha Pandit on 23 Aug 2018 for Refresh Tasks Review and issue count if any changes made

    <System.Web.Services.WebMethod()>
    Public Shared Function IsCheckProductOwnerOnproject() As String
        Try

            Dim drGetIsProductOwner As IDataReader
            Dim strQuery As String = ""
            Dim strResult As String = ""
            strQuery = "usp_NG2_IsProductOwner " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ""
            drGetIsProductOwner = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetIsProductOwner.Read
                strResult = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")
            End While
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckTasksMappedToUserStory1(ByVal userStoryID As String, ByVal IterationID As String) As String
        If userStoryID = "" Then
            userStoryID = "NULL"
        End If
        Dim strSql As String
        Try
            strSql = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Chk_Tasks_ForCancellingUS " & userStoryID & "," & IterationID & ",'USMapping'", True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Save_IterationUserStories(ByVal UserStoryID As String, ByVal IterationID As String, ByVal strMapFlag As String) As String
        '=====================================================================
        ' Procedure Name        :  Save_IterationUserStories()	
        ' Purpose               : To Add save story product to sprint
        ' Description           : To Add save story product to sprint
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 5 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Dim strSQL As String = ""
        Dim strResult As String = ""

        Dim strPos As String = ""

        strSQL = "Usp_NG2_Upd_tbl_PM_ScrumUserStory_Iteration " & UserStoryID & "," & IterationID & ",'" & strMapFlag & "','" & HttpContext.Current.Session("strUserName") & "'"
        Try
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

        '''  RefreshGrid("")



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckUserStoryIsMappedOrNot(ByVal IterationID As String, ByVal userStoryID As String) As String
        Try

            Dim strResult As String = CommonFunctions.Data.GetDataScalar("usp_NG2_chk_AllowToCancelIteration " & IterationID & "," & userStoryID, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CancelUserStory(ByVal strUserSoryID As String, ByVal strRemark As String, ByVal iterationID As String, ByVal flag As String)
        '=====================================================================
        ' Procedure Name        :  CancelUserStory()	
        ' Purpose               : To Add save check Check Activity Filled Against Issue Review
        ' Description           : To Add sprint
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Balasaheb 
        ' Created               : 5 Mar -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim strIterationName As String
            strIterationName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_upd_CancelUserStory " & strUserSoryID & "," & HttpContext.Current.Session("intUserID") & ",'" & strRemark & "'," & flag, True), "")
            Return strIterationName
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


#Region "Add Release Model"
    Public Function Modal_AddRelease() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("  <div class='modal fade ' id='myModal_addRelease' role='dialog'>")
        strHTML.Append("  <div class='modal-dialog modal-lg'>")
        strHTML.Append("<div class='modal-content ' id='modalRelease' >")

        strHTML.Append("<div class='row' style='margin-right:0px; margin-left:0px;'>")
        strHTML.Append("<div class=''>")
        strHTML.Append(" <div id='ReleaseBody'>")
        strHTML.Append("</div>")
        'strHTML.Append(Release_form())

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function BindReleaseModal(ByVal Flag As String) As String
        Try
            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder()

            strHTML.Append(obj.Release_form())

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Public Function Release_form() As String


        Dim strHTML As New StringBuilder()

        strHTML.Append(" <div class='row' style='    margin-right: 0px; margin-left: 0px;'>")
        strHTML.Append(" <div class='modal-header'>")
        strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal'>&times;</button>")
        strHTML.Append("<h4 class='modal-title'>Create Release</h4>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='' >")
        strHTML.Append(" <form class='details_form'>")
        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Release Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", "form-control textbox", , 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtReleaseName','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append("<input  id='txtReleaseName'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-md-10'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionR", "txtDescriptionR", , "form-control textArea", , , , , , 50, 1000, strUserDesc, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1"), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtDescriptionR','spanUserDesc')", True, EnableHTMLEncode:=True))
        'strHTML.Append("<textarea  id='txtDescriptionR' onkeyup=limitText(this,countdown,100) class='form-control'style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;' ></textarea>")
        strHTML.Append("<p id='countdown' style='float:right;margin-top:-35px;'>1000</p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDateR", "txtStartDateR", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtStartDateR','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append("<input  id='txtStartDateR'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float: right;margin-top: -35px;color:#0099CC;' id='dpImg1R'></i>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")


        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDateR", "txtEndDateR", "form-control textbox", 140, 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEndDateR','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append("<input  id='txtEndDateR'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true'style='float: right;margin-top: -35px;color:#0099CC;' id='dpImg2R'></i>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;' >Calenders Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationCalendeR", "txtDurationCalendeR", "form-control textbox", 140, 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationCalendeR','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationCalendeR", "txtDurationCalendeR", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtDurationCalendeR','spanFunctionalNumber')", True, , , , , , True))


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Business Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationBusinessDayR", "txtDurationBusinessDayR", "form-control textbox", 140, 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationBusinessDayR','spanFunctionalNumber')", True, , , , , , True))
        'strHTML.Append("<input  id='txtDurationBusinessDayR'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("</form>")

        strHTML.Append("</div>")
        strHTML.Append("<div class='modal-footer'>")
        strHTML.Append("<button type='button' class='btn btn-info' onclick=AddRelease(); id='add_Release'>Save</button>")

        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function InsertReleaseRecords(ByVal strReleaseName As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal intBusinessDuration As Integer) As String
        Try
            Dim returnID As Integer = 0
            Dim intIterationID As String = ""
            Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
            Dim intReleaseID As String = ""
            Dim status As String = ""
            Dim strUserName As String = ""
            Dim dt As New DataTable()
            Dim strSQL As String = ""
            If intIterationID = "" Then
                intIterationID = "null"
            End If
            If intReleaseID = "" Then
                intReleaseID = "null"
            End If
            If status = "" Then
                status = "null"
            End If
            strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease "
            strSQL = strSQL & "" & intIterationID & ","
            strSQL = strSQL & "" & intProjectID & ","
            strSQL = strSQL & "'" & strReleaseName & "',"
            ' strSQL = strSQL & "" & intReleaseID & ","
            strSQL = strSQL & "'" & strDescription & "',"
            strSQL = strSQL & "'" & dtStartDate & "',"
            strSQL = strSQL & "'" & dtEndDate & "',"
            strSQL = strSQL & "" & intDuration & ","
            '  strSQL = strSQL & "" & fltVelocity & ","
            strSQL = strSQL & "" & intBusinessDuration & ","
            strSQL = strSQL & "" & status & ""

            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            returnID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return returnID
        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function
#End Region

#Region "Add Sprint Model"
    Public Function Modal_AddSprint() As String


        Dim strHTML As New StringBuilder("")
        strHTML.Append("  <div class='modal fade ' id='myModal_addSprint' role='dialog'>")
        strHTML.Append("  <div class='modal-dialog modal-lg'>")
        strHTML.Append("<div class='modal-content' id='modalsprint' >")
        strHTML.Append("<div class='modal-header'>")
        strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal' title='close' data-bs-container='body'  data-bs-toggle='tooltip' data-bs-placement='bottom'>&times;</button>")
        strHTML.Append(" <h4 class='modal-title'>Create Sprint</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row' style='margin-right: 0px;    margin-left: 0px;'>")
        strHTML.Append("<div class='col-sm-12'>")

        strHTML.Append(" <div id='SprintBody'>")
        strHTML.Append("</div>")
        'strHTML.Append(sprint_form())

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        CheckIsProductOwner(Session("intUserID"))
        strHTML.Append("<input type='hidden' value='" & strIsPrductOwner & "' id='hdnstrIsPrductOwner' />")
        Return (strHTML.ToString())

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function BindSprintModal(ByVal Flag As String) As String
        Try
            Dim strHTML As New StringBuilder()

            Dim obj As New frmSprintPlanning()
            strHTML.Append(obj.sprint_form())

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function

    'Public Function sprint_form() As String
    '    Dim strHTML As New StringBuilder("")

    '    strHTML.Append(" <div class='' id='SprintMainBody'>")
    '    strHTML.Append("<div class='modal-header'>")
    '    strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal'aria-label='Close'>&times;</button>")
    '    strHTML.Append(" <h4 class='modal-title'> Create Sprint</h4>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='' >")
    '    strHTML.Append(" <form class='details_form'>")
    '    strHTML.Append(" <div class='form-row'>")
    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSprintName", "txtSprintName", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSprintName','spanFunctionalNumber')", True, , , , , , True))

    '    strHTML.Append("</div>")
    '    strHTML.Append("<div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;'>Description</label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionS", "txtDescriptionS", , "form-control textArea", , , , , , 50, 100, strUserDesc, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1"), False, True), , , "onkeyup='javascript:limitText(this,countdown1,100)' onKeyUp='javascript:limitText(this,countdown1, 100)'onchange=ClearSpan('txtDescriptionS','spanUserDesc')", True, EnableHTMLEncode:=True))
    '    strHTML.Append("<textarea  id='txtDescriptionS' onkeyup=limitText(this,countdown1,100)  class='form-control'style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;' ></textarea>")
    '    strHTML.Append("<p id='countdown1' style='font-size: 11.5px;font-weight: 500;color: grey;float:right;margin-top:-35px;'>100</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDateS", "txtStartDateS", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtStartDateS','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("<input  id='txtStartDateS'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class=''>")
    '    strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: 12px;color:#0099CC;' id='dpImg1'></i>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='form-row'>")


    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDateS", "txtEndDateS", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEndDateS','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("<input  id='txtEndDateS'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class=''>")
    '    strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: 12px;color:#0099CC;' id='dpImg2'></i>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")


    '    strHTML.Append(" <div class='form-row'>")
    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Calendar Day's' >Calendar Day's Duration</label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationCalendeS", "txtDurationCalendeS", "form-control textbox", 140, 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationCalendeS','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("<input  id='txtDurationCalendeS'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")


    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Business Day's'>Business Day's Duration</label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationBusinessDayS", "txtDurationBusinessDayS", "form-control textbox", 140, 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationBusinessDayS','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("<input  id='txtDurationBusinessDayS'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='form-row'>")
    '    strHTML.Append(" <div class='col-md-6'>")
    '    strHTML.Append(" <div class='form-group '>")
    '    strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
    '    strHTML.Append(" <div class='col-md-6'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEffortsS", "txtEffortsS", "form-control textbox", 140, 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEffortsS','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("<input  id='txtEffortsS'  class='form-control'  type='text' style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("</div>")

    '    strHTML.Append("</form>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' onclick=AddSprint() id='add_sprint'>Save</button>")
    '    Return (strHTML.ToString())
    'End Function

    'New code for spprint
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
        ' Author                :	Yasmin Shaikh
        ' Created               :	14-Apr-2018
        ' Revisions             :
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim Disabled As String = ""

        ' strHTML.Append(" <form class='details_form'>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-9'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSprintName", "txtSprintName", "form-control textbox", , 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSprintName','spanFunctionalNumber') ", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-md-9'>")
        Dim len As Integer = 1000
        Dim len1 As Integer
        If strUserDesc.Length <> -1 Then
            len1 = strUserDesc.Length
            len = 1000 - len1
        End If
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionS", "txtDescriptionS", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1"), False, True), , , "onkeyup='javascript:limitText(this,countdown1,1000)' onKeyUp='javascript:limitText(this,countdown1, 1000)'onchange=ClearSpan('txtDescriptionS','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionS", "txtDescriptionS", , "form-control", , , , , , , 1000, strUserDesc, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1"), False, True), , , "onkeyup='javascript:limitText(this,countdown1,1000)' onKeyUp='javascript:limitText(this,countdown1, 1000)'onchange=ClearSpan('txtDescriptionS','spanUserDesc')  data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<p  id='countdown1' style='float: right;margin-top: -35px;'>1000</p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")    'added by Ashwini M on 27-3-2023
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDateS", "txtStartDateS", "form-control textbox", , 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtStartDateS','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -25px!important;color:#0099CC;' onclick=$('#txtStartDateS').datepicker();$('#txtStartDateS').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDateS", "txtEndDateS", "form-control textbox", , 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEndDateS','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -25px!important;color:#0099CC;' onclick=$('#txtEndDateS').datepicker();$('#txtEndDateS').datepicker('show');></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")    'End of added by Ashwini M on 27-3-2023


        strHTML.Append(" <div class='row'>")    'added by Ashwini M on 27-3-2023
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Calendar Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationCalendeS", "txtDurationCalendeS", "form-control textbox", , 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationCalendeS','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Business Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDurationBusinessDayS", "txtDurationBusinessDayS", "form-control textbox", , 100, , , , , True, , , "onkeyup=ClearSpan('txtDurationBusinessDayS','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")    'End of added by Ashwini M on 27-3-2023

        strHTML.Append(" <div class='row'>")    'added by Ashwini M on 27-3-2023
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEffortsS", "txtEffortsS", "form-control textbox", , 100, , , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEffortsS','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")    'End of added by Ashwini M on 27-3-2023





        'Added By Dipali V On 25th April 2018 
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <label class='col-md-6 control-label' style='white-space: nowrap;'>Story Points</label> ")
        'strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprinttxtStoryPoint", "SprinttxtStoryPoint", "form-control", , 100, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('SprinttxtStoryPoint','spanStoryPoint')", True, , , , , , True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'End of Added By Dipali V On 25th April 2018 


        strHTML.Append("<div class='row'>")

        strHTML.Append("<div class='col-md-12 align-right' style='margin-top: 20px;margin-bottom:60px;'>")
        strHTML.Append("<button type='button' class='btn btn-info' onclick=AddSprint(); id='add_sprint'>Save</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function

    ''Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
    '<System.Web.Services.WebMethod()>
    'Public Shared Function InsertSprintRecords(ByVal strIteration As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal fltVelocity As Decimal, ByVal intBusinessDuration As Integer) As String
    '    Try
    '        Dim returnID As Integer = 0
    '        Dim intIterationID As String = ""
    '        Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
    '        Dim intReleaseID As String = ""
    '        Dim strUserName As String = ""
    '        Dim dt As New DataTable()
    '        Dim strSQL As String = ""
    '        If intIterationID = "" Then
    '            intIterationID = "null"
    '        End If
    '        If intReleaseID = "" Then
    '            intReleaseID = "null"
    '        End If


    '        strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration "
    '        strSQL = strSQL & "" & intIterationID & ","
    '        strSQL = strSQL & "" & intProjectID & ","
    '        strSQL = strSQL & "'" & strIteration & "',"
    '        strSQL = strSQL & "" & intReleaseID & ","
    '        strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
    '        strSQL = strSQL & "'" & dtStartDate & "',"
    '        strSQL = strSQL & "'" & dtEndDate & "',"
    '        strSQL = strSQL & "" & intDuration & ","
    '        strSQL = strSQL & "" & fltVelocity & ","
    '        strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "',"
    '        strSQL = strSQL & "" & intBusinessDuration & ""

    '        'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        returnID = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '        Return returnID
    '    Catch ex As Exception

    '    End Try
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function InsertSprintRecords(ByVal strIteration As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal strVelocity As String, ByVal intBusinessDuration As Integer) As String
        Try
            Dim returnID As Integer = 0
            Dim intIterationID As String = ""
            Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
            Dim intReleaseID As String = ""
            Dim strUserName As String = ""
            Dim dt As New DataTable()
            Dim strSQL As String = ""
            If intIterationID = "" Then
                intIterationID = "null"
            End If
            If intReleaseID = "" Then
                intReleaseID = "null"
            End If

            Dim fltVelocity As Decimal

            If strVelocity = "0" Or strVelocity = "" Then
                strVelocity = "00:00"
            End If

            If strVelocity.IndexOf(":") = strVelocity.Length - 1 Then
                strVelocity = strVelocity + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = strVelocity.Substring(0, strVelocity.IndexOf(":"))
            strDecimal = strVelocity.Substring(strVelocity.IndexOf(":") + 1, 2)
            strVelocity = strBeforeDecimal + ":" + strDecimal

            fltVelocity = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strVelocity + "',2)", True)

            strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration "
            strSQL = strSQL & "" & intIterationID & ","
            strSQL = strSQL & "" & intProjectID & ","
            strSQL = strSQL & "'" & strIteration & "',"
            strSQL = strSQL & "" & intReleaseID & ","
            strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
            strSQL = strSQL & "'" & dtStartDate & "',"
            strSQL = strSQL & "'" & dtEndDate & "',"
            strSQL = strSQL & "" & intDuration & ","
            strSQL = strSQL & "" & fltVelocity & ","
            strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "',"
            strSQL = strSQL & "" & intBusinessDuration & ""

            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            returnID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return returnID
        Catch ex As Exception

            Return "Bad Request found"

        End Try
    End Function

    ''End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 

    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateSprintReleaseRecords(ByVal IterationID As String, ByVal strIteration As String, ByVal strDescription As String, ByVal dtStartDate As String, ByVal dtEndDate As String, ByVal intDuration As Integer, ByVal strVelocity As String, ByVal intBusinessDuration As Integer, ByVal flag As String) As String
        Try
            Dim intIterationID As String = IterationID
            Dim intProjectID As Integer = HttpContext.Current.Session("intProjectID")
            Dim intReleaseID As String = ""
            Dim status As String = ""
            Dim strUserName As String = ""
            Dim dt As New DataTable()
            Dim strSQL As String = ""
            If intIterationID = "" Then
                intIterationID = "null"
            End If
            If intReleaseID = "" Then
                intReleaseID = "null"
            End If
            If status = "" Then
                status = "null"
            End If
            '' Added By Ankush T on 26-Mar-2019 Purpose::Project Work field level changes 
            Dim fltVelocity As Decimal

            If strVelocity = "0" Or strVelocity = "" Then
                strVelocity = "00:00"
            End If

            If strVelocity.IndexOf(":") = strVelocity.Length - 1 Then
                strVelocity = strVelocity + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = strVelocity.Substring(0, strVelocity.IndexOf(":"))
            strDecimal = strVelocity.Substring(strVelocity.IndexOf(":") + 1, 2)
            strVelocity = strBeforeDecimal + ":" + strDecimal

            fltVelocity = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strVelocity + "',2)", True)
            ''End of Added By Ankush T on 26-Mar-2019 Purpose::Project Work field level changes 
            If flag = "Iteration" Then
                strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration "
                strSQL = strSQL & "" & intIterationID & ","
                strSQL = strSQL & "" & intProjectID & ","
                strSQL = strSQL & "'" & strIteration & "',"
                strSQL = strSQL & "" & intReleaseID & ","
                strSQL = strSQL & "'" & strDescription.Replace("'", "''") & "',"
                strSQL = strSQL & "'" & dtStartDate & "',"
                strSQL = strSQL & "'" & dtEndDate & "',"
                strSQL = strSQL & "" & intDuration & ","
                strSQL = strSQL & "" & fltVelocity & ","
                strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "',"
                strSQL = strSQL & "" & intBusinessDuration & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Else
                strSQL = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease "
                strSQL = strSQL & "" & intIterationID & ","
                strSQL = strSQL & "" & intProjectID & ","
                strSQL = strSQL & "'" & strIteration & "',"
                strSQL = strSQL & "'" & strDescription & "',"
                strSQL = strSQL & "'" & dtStartDate & "',"
                strSQL = strSQL & "'" & dtEndDate & "',"
                strSQL = strSQL & "" & intDuration & ","
                '  strSQL = strSQL & "" & fltVelocity & ","
                strSQL = strSQL & "" & intBusinessDuration & ","
                strSQL = strSQL & "" & status & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
        Catch ex As Exception

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSprintDetails(ByVal IterationValue As Integer, ByVal Flag As String) As String
        Try
            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder()
            Dim strSQL As String = ""
            Dim drReleaseDetails As IDataReader
            Dim strflag As String = ""
            If Flag = "Iteration" Then
                strflag = "Sprint"
            Else
                strflag = "Release"
            End If
            strSQL = "usp_NG2_GetSprintReleaseDetails " & IterationValue & "," & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",'" & strflag & "'"
            drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            Dim IterationID As String = ""
            Dim IterationName As String = ""
            Dim Description As String = ""
            Dim NoOfDays As String = ""
            Dim SprintStartDate As String = ""
            Dim SprintEndDate As String = ""
            Dim ReleaseID As String = ""
            Dim SprintVelocity As String = ""
            Dim SprintDuration As String = ""
            Dim BusinessDuration As String = ""
            Dim IterationStartDate As String = ""
            Dim IterationStatus As String = ""
            Dim IsIterationComplete As String = ""
            Dim StoryPoint As String = ""

            Dim DoListCount As String = ""
            Dim InProgressCount As String = ""
            Dim DoneCount As String = ""
            Dim TaskCount As String = ""
            Dim DiscussionCount As String = ""
            Dim IssueCount As String = ""

            Dim plannedEfforts As String = ""
            Dim actualEfforts = ""

            Dim Duration As String = ""
            Dim Velocity As String = ""

            If drReleaseDetails.Read Then
                If Flag = "Iteration" Then
                    IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationID"), "")
                    IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationName"), "")
                    Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                    NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                    SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                    SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                    ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")

                    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                    'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change


                    BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "0")
                    IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                    IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                    IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsIterationComplete"), "")


                    DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                    InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgressCount"), "")
                    DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoneCount"), "")
                    TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                    IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                    DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                    plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                    actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                    'Added by Ankush T on 25-March-2019 Purpose::Display Story Point modal popup for sprint planning
                    StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
                    'End of Added by Ankush T on 25-March-2019 Purpose::Display Story Point modal popup for sprint planning

                Else ''Release
                    IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
                    Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                    NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                    SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                    SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                    ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")

                    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                    'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

                    BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "0")
                    'IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                    'IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                    IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsReleaseComplete"), "")
                    plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                    actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                    Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")

                    ' DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                    InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
                    DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
                    TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                    IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                    DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                End If

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
            If Flag = "Iteration" Then
                title = "Sprint ID"
                editName = "Edit Sprint Name"
                ControlCaption = "Sprint Name"
                PageCaption = "Sprint Details"
            Else
                title = "Release ID"
                editName = "Edit Release Name"
                ControlCaption = "Release Name"
                PageCaption = "Release Details"
            End If


            strHTML.Append(obj.Graph_section(title, PageCaption, ControlCaption, editName, strColor, IterationID, Flag, IterationName, Description, NoOfDays, plannedEfforts, actualEfforts, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, IterationStartDate, IterationStatus, IsIterationComplete, DoListCount, InProgressCount, DoneCount, TaskCount, IssueCount, DiscussionCount, Duration, StoryPoint))

            Return strHTML.ToString()

        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function

    Public Function sprint_tab(ByVal UniqueID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Purpose				:	sprint_tab
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row ' id='Tabs'>")
        strHTML.Append("<ul class='' id='tab_link'>" & vbCrLf)
        strHTML.Append("<li   style='   border-left: transparent;'><a class='selected' href='#div_details' id='tab_content' style='   border-left: transparent;'  >Details</a></li>" & vbCrLf)
        strHTML.Append("<li ><a href='#graph' id='tab_content'>Graphs</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div1'  id='tab_content' >User Stories</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div2'  id='tab_content'>Comments</a></li>" & vbCrLf)
        strHTML.Append("<li ><a href='#div3'  id='tab_content' >Attachments</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div6'  id='tab_content'>Issues</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div9' id='tab_content' >Reviews</a></li>" & vbCrLf)
        strHTML.Append("</ul>")

        strHTML.Append("</div><br>")



        strHTML.Append("<div id='sprint_details' style='overflow-y:auto;overflow-x:hidden;height:280px;' class='clsBox'>")


        Return (strHTML.ToString())

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDuration(ByVal strStartDate As String, ByVal strEndDate As String)
        Try

            Dim strDuration As String
            Dim dtDuration As New DataTable
            dtDuration = CommonFunctions.Data.GetDataTable("usp_NG2_GetCalendarDaysCount '" & strStartDate & "','" & strEndDate & "'," & HttpContext.Current.Session("intProjectID"), True)
            If dtDuration.Rows.Count > 0 Then
                strDuration = dtDuration.Rows(0)("NoOfDays") & "|" & dtDuration.Rows(0)("BusinessDays")
            End If
            Return strDuration
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
#End Region

#Region "Start Sprint"
    <System.Web.Services.WebMethod()>
    Public Shared Function GetIterationMappedToUserStory(ByVal IterationID As String) As String
        Try
            Dim strResult As String = CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IterationMappedToUserStory " & IterationID, True)
            Return strResult

        Catch ex As Exception

            Return "Bad Request found"

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSprintStartDetails(ByVal IterationID As String) As String
        Try
            Dim strResult As String = CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_StartIteration " & HttpContext.Current.Session("IntProjectID") & "," & IterationID & ",'" & HttpContext.Current.Session("strUserName") & "'", True)

            Dim intMessageID As Integer
            Dim strMailTo As String = ""
            Dim strFromMail As String = ""
            Dim strMailCC As String = ""
            Dim strSubject As String = ""
            Dim strMessage As String = ""
            Dim drEmailMessage As IDataReader
            Dim strSQL As String
            Dim blnSendEmail As Boolean
            Dim blnShowPopup As Boolean

            intMessageID = 20045
            If strResult.IndexOf("Completed") > 0 Then
                If IterationID.ToString <> "" Then

                    strSQL = "EXEC usp_Sel_tbl_PM_EmailMessages " & CommonFunction.General.CheckIsNothing(intMessageID, "0").ToString()
                    drEmailMessage = CommonFunction.Data.GetDataReader(strSQL, True)

                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If

                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                    ''Silent mail for completion of sprint
                    If blnSendEmail = True Then
                        clsCommon.GetEmailMessage_20045(strFromMail, strMailTo, strMailCC, strSubject, strMessage, IterationID)
                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strMailCC, strFromMail, strSubject, strMessage)
                    End If
                End If
            End If

            Return strResult

        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function
#End Region

#Region "Discussion and Details Modal Popup"
    Public Function Modal_popupdashboard() As String


        Dim strHTML As New StringBuilder("")
        strHTML.Append("  <div class='modal fade' id='myModal_dash' data-keyboard='false' data-backdrop='static' tabindex='-1' role='dialog'>")
        strHTML.Append("  <div class='modal-dialog modal-lg'>")
        strHTML.Append("<div class='modal-content' >")

        strHTML.Append("<div id='dashBody' class='col-sm-12' style='margin-top: 10px;'>")
        'strHTML.Append(sprint_header())
        'strHTML.Append(sprint_status())
        'strHTML.Append(sprint_tab())
        'strHTML.Append(Graph_section())
        strHTML.Append("</div>")



        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function

    Public Function sprint_header() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row' style='margin-left: 2px;'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        strHTML.Append("<p class='col-sm-2' style=' color:#888888bf!important;  font-size: 16px;font-weight: 500;margin-left: -31px;word-break: break-all;' >Sprint Name</p>" & vbCrLf) 'Added by swapna
        strHTML.Append("<div class='col-sm-1' style='color: blue;'>" & vbCrLf)
        strHTML.Append(" <i class='fa fa-cog ' aria-hidden='true'></i> <i class='fa fa-chevron-down' aria-hidden='true' data-bs-toggle='collapse' href='#collapseExample' aria-expanded='false' aria-controls='collapseExample'></i>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("<div>" & vbCrLf)

        strHTML.Append("<a class='close' data-bs-dismiss='modal' style='padding: 0px; padding-right: 5px;'><i class='fas fa-times' style='color: black!important;' title='Close' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())


    End Function

    Public Function sprint_status() As String

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append(" <div class='col-sm-3'>" & vbCrLf)
        ' /* Modified By Madhuri.K On 03-04-2026 */ 
        strHTML.Append("  <p  style='color:  #428bca;    font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
        strHTML.Append("</div>&nbsp;")
        strHTML.Append(" <div class='col-sm-2'>" & vbCrLf)
        ' /* Modified By Madhuri.K On 03-04-2026 */ 
        strHTML.Append(" <p  style='color: #428bca; margin-left: -11px;  background-color: #868e9624 ;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
        strHTML.Append(" <p  style='color: #88888880;margin-left: 36px;white-space: nowrap;text-overflow: ellipsis;'>1 Week</p>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
        strHTML.Append(" <p  style='color: #88888880;    white-space: nowrap;text-overflow: ellipsis;'>50 Points </p>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
        strHTML.Append(" <p  style='     margin-left: -9px;  white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3' style='display:inline-flex;'>")
        strHTML.Append("<i class='fa fa-bug  fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
        strHTML.Append("<i class='fa fa-align-justify  fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
        strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
        strHTML.Append("<i class='fa fa-bar-chart' aria-hidden='true' style='    font-size: 16px;'></i>")
        ' /* Modified By Madhuri.K On 03-04-2026 */ 
        strHTML.Append("<button type='button' class='btn btn-outline-secondary' style='margin-top: -6px;font-size: 11.5px;font-weight: 500; height: 31px;  border-color: #ddd;margin-left: 8%;'><i class='fa fa-caret-square-o-right' aria-hidden='true' style='color:blue;'></i>&nbsp;Start Sprint</button>" & vbCrLf)

        strHTML.Append("</div>")

        strHTML.Append("</div><hr>")
        Return (strHTML.ToString())


    End Function

    Public Function sprint_tab() As String

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row' style='margin-left:15px;'>")
        strHTML.Append("<ul class='' id='tab_link'>" & vbCrLf)
        strHTML.Append("<li class='active' style='border-left: transparent;'><a class='selected' href='#div_details' style='   border-left: transparent;'  >Details</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#graph'>Graphs</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div1'>User Stories</a></li>" & vbCrLf)

        strHTML.Append("<li ><a href='#div2'>Discussion</a></li>" & vbCrLf)
        strHTML.Append("<li ><a href='#div3'>Attachments</a></li>" & vbCrLf)

        strHTML.Append("<li><a href='#div6'  >Issues</a></li>" & vbCrLf)

        strHTML.Append("<li><a href='#div9' style=' margin: .25em 0; padding: 4px 1em;margin-right: -29px;' >Reviews</a></li>" & vbCrLf)

        strHTML.Append("</ul>")

        strHTML.Append("</div><br>")

        strHTML.Append("<div style='overflow:auto;height:300px;'>")

        Return (strHTML.ToString())


    End Function


    Public Function Graph_section(ByVal title As String, ByVal PageCaption As String, ByVal ControlCaption As String, ByVal editName As String, ByVal strColor As String, IterationID As String, ByVal Flag As String, ByVal IterationName As String, ByVal Description As String, ByVal NoOfDays As String, ByVal plannedEfforts As String, ByVal ActualEfforts As String, ByVal SprintStartDate As String, ByVal SprintEndDate As String, ByVal SprintDuration As String, ByVal SprintVelocity As String, ByVal BusinessDuration As String, ByVal IterationStartDate As String, ByVal IterationStatus As String, ByVal IsIterationComplete As String, ByVal DoListCount As String, ByVal InProgressCount As String, ByVal DoneCount As String, ByVal TaskCount As String, ByVal IssueCount As String, ByVal DiscussionCount As String, ByVal Duration As String, ByVal StoryPoint As String) As String

        Dim strHTML As New StringBuilder("")
        Dim strSprintStatus As String = ""
        ''Header
        strHTML.Append("<div class='modal-header' >" & vbCrLf)

        strHTML.Append("<div class='col-md-1 col-sm-2'>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='padding: 0px 3px;font-size: 65px!important;color:" & strColor & ";'></i>")
        strHTML.Append("<p style='color: white;font-weight: 600;font-size: 15px;position: absolute;top: 10px;left: 12px;right: 0;text-align: center;'><Span data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'  title='" & title & "'>" & IterationID & "</span></p></div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-2 col-sm-3' style='margin-top:1%'>" & vbCrLf)
        strHTML.Append("<label class='headerPage'>" & PageCaption & " </label>")
        strHTML.Append("</div>")
        'strHTML.Append("<br><hr style='border:1px solid rgb(60, 141, 188)!important;width:97%;margin-right:21px;'>")

        'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
        Dim strCurrentDate As String = DateTime.Now.ToShortDateString()
        Dim result As Integer = DateTime.Compare(Convert.ToDateTime(strCurrentDate), Convert.ToDateTime(SprintEndDate))

        'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date

        strHTML.Append("<div class='col-md-8 col-sm-7 col-sm-6' >")
        If Flag = "Iteration" Then
            strHTML.Append("<div class='input-group' id='Export' style='float:right;'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button type='button' class='btn btn-info'  id='btnExport'  class='dropdown-toggle' data-bs-toggle='dropdown' title='' data-original-title='Export' title='Export' data-bs-container='body'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i></button>&nbsp;&nbsp;")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown-menu' >")
            strHTML.Append("  <li  href='#' onclick=Export_onclick('" & Flag & "','PDF'," & IterationID & ") >&nbsp;PDF</a><br/>")
            strHTML.Append("  <li  href='#' onclick=Export_onclick('" & Flag & "','Excel'," & IterationID & ")>&nbsp;Excel</a>")
            strHTML.Append("</div>")

            'Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date
            Dim strFlag As String = "0"
            If result = "-1" Then
                strFlag = "1"
            End If

            Dim blnODSPrintStatusFlag As Boolean = False
            blnODSPrintStatusFlag = checkDODSprintDetailsStatusNA()
            'End of Added by Usha Pandit on 14 Aug 2018 For check Current date less than Sprint End date

            If IterationStatus = "Not Yet Started" Then

                'Commented and Added by Ankush T  on 25 Mar 2019 For current status of Sprint
                'strHTML.Append("<button type='button' data-bs-toggle='tooltip' data-bs-placement='bottom' class='btn btn-info' onclick='StartSprint(" & IterationID & ")' title='Sprint Status'><i id='idStartIteration' class='fa fa-caret-square-o-right' aria-hidden='true' style='color:white;' ></i>&nbsp;Start Sprint</button>" & vbCrLf)

                strHTML.Append("<button type='button' data-bs-toggle='tooltip' data-bs-placement='bottom' class='btn btn-info' onclick='StartSprint(" & IterationID & ",&quot;In Process&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;)' title='Sprint Status'><i id='idStartIteration' class='fa fa-caret-square-o-right' aria-hidden='true' style='color:white;' ></i>&nbsp;Start Sprint</button>" & vbCrLf)

                'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

            ElseIf IterationStatus.ToUpper() = "READY TO COMPLETE" Then

                'Commented and Added by Usha Pandit on 14 Aug 2018 For current status of Sprint
                'strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID & ")'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To Complete</div>")
                strHTML.Append("<button type='button' id='idStartItern' class='btn readytorelease' onclick='StartSprint(" & IterationID & ",&quot;Ready To Complete&quot;,&quot;" & strFlag & "&quot;,&quot;" & blnODSPrintStatusFlag & "&quot;)'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-bs-toggle='tooltip' style='color:rgb(60, 141, 188);' title='Click here to complete sprint' data-bs-container='body' data-bs-placement='bottom'></i> Ready To Complete</button>")
                'End of Added by Usha Pandit on 14 Aug 2018 For current status of Sprint

            Else
                strHTML.Append("<button type='button' data-bs-toggle='tooltip' data-bs-placement='bottom' class='btn btn-info' title='" & IterationStatus & "' disabled>&nbsp;" & IterationStatus & "</button>" & vbCrLf)
            End If



            strHTML.Append("</div>")
        Else
            strHTML.Append("<div class='input-group'  id='Export' style='float:right;'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button type='button' class='btn btn-info'  id='btnExport'  data-bs-toggle='dropdown'  aria-haspopup='true' title='Export' data-original-title='Export' title='Export'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i></button>&nbsp;&nbsp;")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown-menu'>")
            strHTML.Append("<li class='' href='#' onclick=Export_onclick('" & Flag & "','PDF'," & IterationID & ") >&nbsp;PDF</li><br/>")
            strHTML.Append("<li class='' href='#' onclick=Export_onclick('" & Flag & "','Excel'," & IterationID & ")>&nbsp;Excel</li>")
            strHTML.Append("</div>")
            If IterationStatus <> "" Then
                strHTML.Append("<button type='button' class='btn btn-info'  id='btnRelease'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Release Status' data-original-title='Release' data-bs-container='body'>" & IterationStatus & "</button>")
            Else
                strHTML.Append("<button type='button' class='btn btn-info'  id='btnRelease'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Release Status' data-original-title='Release' data-bs-container='body'>Ready For Release</button>")

            End If
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")

        'strHTML.Append("<button type='button' class='close modal_close'  data-bs-dismiss='modal' aria-label='Close' title='Close' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' style='margin-top: -10px; margin-right: 10px;'>")
        If globalUSID = "" Then
            strHTML.Append("<button type='button' class='close modal_close'  data-bs-dismiss='modal' aria-label='Close' title='Close' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' style='margin-top: -10px; margin-right: 10px;' onclick='RefreshBothTable(&quot;" & globalUSID & "&quot;," & IterationID & ")'>")
        Else
            strHTML.Append("<button type='button' class='close modal_close'  data-bs-dismiss='modal' aria-label='Close' title='Close' onclick=""RefreshBothTable(" & globalUSID & "," & IterationID & ")"" data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' style='margin-top: -10px; margin-right: 10px;'>")
        End If


        'strHTML.Append("<span aria-hidden='true' style='font-size:20px;' onclick=""RefreshFirstTable('Close')"">&times;</span>") 'RefreshFirstTable

        'Commented And Added by Usha Pandit on 26 Mar 2019 for refresh tables
        'strHTML.Append("<span aria-hidden='true' style='font-size:20px;' onclick=""RefreshBothTable(" & globalUSID & "," & IterationID & ")"">&times;</span>")

        If globalUSID = "" Then
            strHTML.Append("<span aria-hidden='true' style='font-size:20px;' onclick=""RefreshBothTable('" & globalUSID & "'," & IterationID & ")"">&times;</span>")
        Else
            strHTML.Append("<span aria-hidden='true' style='font-size:20px;' onclick=""RefreshBothTable(" & globalUSID & "," & IterationID & ")"">&times;</span>")
        End If

        'End of Added by Usha Pandit on 26 Mar 2019 for refresh tables

        strHTML.Append("<input type=hidden id=hdnglobalUSID value='" & globalUSID & "'>")

        ''Commented and Added by Usha Pandit on 17.04.2019 for getting current IterationId
        'strHTML.Append("<input type=hidden id=hdnIterationID value='" & IterationID & "'>")
        strHTML.Append("<input class = 'clsIterationID' type=hidden id=hdnIterationID value='" & IterationID & "'>")
        ''End of Added by Usha Pandit on 17.04.2019 for getting current IterationId

        strHTML.Append("</div>")

        ''-----------------Status-------------------------------
        strHTML.Append("<div class='row' style='margin-top:1%;margin-bottom: 25px;'>" & vbCrLf)

        strHTML.Append("<div class='col-md-2 col-sm-4'>") 'id='divReleaseName'
        strHTML.Append("<label class='headerPage'>" & ControlCaption & ": </label>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-4 col-sm-6' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", , , , IterationName, , , True, , , , "onblur=""ChangeSprintName(" & IterationID & ",'" & Flag & "')"" data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' title='' data-original-title=" & editName & "", True, , , , , , True))
        strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Iteration'", True))
        If strSprintStatus = "1" Then
            strHTML.Append("<i class='fas fa-pencil-alt' data-bs-toggle='tooltip' data-bs-placement='bottom' id='editReleaseName' data-bs-container='body' title='Sprint Already started/completed,you do not have access to change data' ></i>")

        Else
            strHTML.Append("<i class='fas fa-pencil-alt' data-bs-toggle='tooltip' data-bs-placement='bottom' id='editReleaseName' onclick=""editSprintName('" & IterationName & "')"" title='" & editName & "' ></i>")
        End If
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-6 col-sm-12'>")
        strHTML.Append("<p  style='color:  #428bca;    font-size: 12px;white-space: nowrap;margin-bottom:0%;text-overflow: ellipsis;margin-left: 10px;margin-top:10px;' ><label class='labelclass' title='Start Date To End Date' data-bs-toggle='tooltip' data-bs-container='body'>" & SprintStartDate & "   To    " & SprintEndDate & "</label>&nbsp;&nbsp;&nbsp;")
        If Duration <> "" Then
            strHTML.Append("<label class='labelclass' title='Duration' data-bs-toggle='tooltip'>" & Duration & "</label>&nbsp;&nbsp;")
        Else
            strHTML.Append("<label class='labelclass' title='Duration' data-bs-toggle='tooltip'>0.00</label>&nbsp;&nbsp;")
        End If

        'Commented and Added by Ankush T on 25-March-2019 Purpose::Display Story Point modal popup for sprint planning

        'If Duration <> "" Then
        '    strHTML.Append("<label class='labelclass' title='Story Point' data-bs-toggle='tooltip'>" & StoryPoint & "</label>&nbsp;&nbsp;")
        'Else
        '    strHTML.Append("<label class='labelclass' title='Story Point' data-bs-toggle='tooltip'>0.00</label>&nbsp;&nbsp;")
        'End If

        If StoryPoint <> "" Then
            strHTML.Append("<label class='labelclass' title='Story Point' data-bs-toggle='tooltip'>" & StoryPoint & "</label>&nbsp;&nbsp;")
        Else
            strHTML.Append("<label class='labelclass' title='Story Point' data-bs-toggle='tooltip'>0.00</label>&nbsp;&nbsp;")
        End If
        'End of Added by Ankush T on 25-March-2019 Purpose::Display Story Point modal popup for sprint planning

        ''Commented and Added by Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change

        'If plannedEfforts <> "" And plannedEfforts <> "" Then
        '    strHTML.Append("<label class='labelclass' title='Planned Effort / Actual Effort' data-bs-toggle='tooltip'>" & plannedEfforts & "/" & ActualEfforts & "</label>")
        'Else
        '    strHTML.Append("<label class='labelclass' title='PlannedEffort / ActualEffort' data-bs-toggle='tooltip'>0.00/0.00</label>&nbsp;&nbsp;")
        'End If


        If plannedEfforts <> "" And plannedEfforts <> "" Then
            Dim HMPlan As String = ""
            Dim HMActual As String = ""

            HMPlan = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + plannedEfforts + "',1)", True)
            HMActual = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + ActualEfforts + "',1)", True)

            strHTML.Append("<label class='labelclass' title='Planned Effort / Actual Effort' data-bs-toggle='tooltip'>" & HMPlan & "/" & HMActual & "</label>")
        Else
            strHTML.Append("<label class='labelclass' title='PlannedEffort / ActualEffort' data-bs-toggle='tooltip'>00:00/00:00</label>&nbsp;&nbsp;")
        End If

        ''End of Added by Usha Pandit on 08-April-2019 Purpose::Whizible 2 Work field change

        strHTML.Append("&nbsp;&nbsp;</p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        ''-------------------Tab Section ---------------------------------------------------------

        strHTML.Append("<div class='row' style='margin-left:15px;' id='Tabs'>")
        'strHTML.Append("<i id='next' onclick=NextTab() class='btn' style='float:left;margin-top:-13px;background-color:white;color:darkcyan;margin-left:-19px;' id='ReleaseSprintPer' title='Previous Tab' onclick=""PreSprintRelease('" & Flag & "')""><<</i>")
        ' strHTML.Append("&nbsp;<i class='fa fa-angle-double-left' aria-hidden='true' style='margin-top:-10px;margin-left:-10px;background:#01579b!important;border-radius: 20px;color:#fff!important;font-size:20px!important;padding: 3px 6px;' id='ReleaseSprintPer' title='Previous Tab' onclick=""PreSprintRelease('" & Flag & "')""></i>" & vbCrLf)
        strHTML.Append("<ul class='' id='tab_link'>" & vbCrLf)
        strHTML.Append("<li style='border-left: transparent;'><a class='selected' href='#div_details' style='border-left: transparent;'>Details</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div_graph'>Charts</a></li>" & vbCrLf)
        If Flag = "Release" Then
            strHTML.Append("<li><a href='#div_Sprints'>Sprints</a></li>" & vbCrLf)
        End If

        strHTML.Append("<li><a href='#div_UserStory'>User Stories</a></li>" & vbCrLf)
        ''Commented and Added by Usha Pandit on 25.03.2019 for blank discussion validation
        'strHTML.Append("<li><a onclick=""RefreshTab('Teams','Sprint'," & IterationID & ",'div_Team')"" href='#div_Team'>Teams</a></li>" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Teams','Iteration'," & IterationID & ",'div_Team')"" href='#div_Team'>Teams</a></li>" & vbCrLf)
        ''End of Added by Usha Pandit on 25.03.2019 for blank discussion validation
        strHTML.Append("<li><a href='#div_Task'>Tasks</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#div_Issues'  >Issues</a></li>" & vbCrLf)


        ''Commented and Added by Usha Pandit on 25.03.2019 for blank discussion validation
        'strHTML.Append("<li ><a onclick=""RefreshTab('Discussions','Sprint'," & IterationID & ",'div_Discussion')"" href='#div_Discussion'>Discussions</a></li>" & vbCrLf)
        'strHTML.Append("<li><a onclick=""RefreshTab('Reviews','Sprint'," & IterationID & ",'div_Reviews')"" href='#div_Reviews'>Reviews</a></li>" & vbCrLf)
        strHTML.Append("<li ><a onclick=""RefreshTab('Discussions','Iteration'," & IterationID & ",'div_Discussion')"" href='#div_Discussion'>Discussions</a></li>" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Reviews','Iteration'," & IterationID & ",'div_Reviews')"" href='#div_Reviews'>Reviews</a></li>" & vbCrLf)
        ''End of Added by Usha Pandit on 25.03.2019 for blank discussion validation
        If Flag = "Release" Then
            strHTML.Append("<li ><a href='#div_Impedement'>Impedements Logs</a></li>" & vbCrLf)
        End If
        If Flag = "Release" Then
            strHTML.Append("<li ><a href='#div_Risks'>Risks</a></li>" & vbCrLf)
        End If

        ''Commented and Added by Usha Pandit on 25.03.2019 for blank discussion validation
        'strHTML.Append("<li ><a  onclick=""RefreshTab('History','Sprint'," & IterationID & ",'div_History')"" href='#div_History'>History</a></li>" & vbCrLf)
        strHTML.Append("<li ><a  onclick=""RefreshTab('History','Iteration'," & IterationID & ",'div_History')"" href='#div_History'>History</a></li>" & vbCrLf)
        ''End of Added by Usha Pandit on 25.03.2019 for blank discussion validation

        strHTML.Append("<li ><a href='#div_Attachment'>Attachments</a></li>" & vbCrLf)

        strHTML.Append("</ul>")

        'strHTML.Append("<i class='fa fa-angle-double-right' aria-hidden='true' style='margin-top:-10px; background:#01579b!important;border-radius: 20px;color:#fff!important;font-size:20px!important;padding:3px 6px;' id='ReleaseSprintNext' title='Next Tab' title='Next Tab' onclick=""NextSprintRelease('" & Flag & "')""></i>" & vbCrLf)

        strHTML.Append("</div>")

        strHTML.Append("<div id='ContainAllDivs'>")
        strHTML.Append("<div id='sprint_details' style='overflow-y:auto;overflow-x:hidden;margin-right: 2%;' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='20'>")

        strHTML.Append("<div class='detail col-md-12 col-sm-12' style='overflow:auto;height:480px;width:92%;'>")

        ''---------------------Details..Section.---------------------------------

        strHTML.Append("<div id='div_details' class=''>")

        If Flag = "Iteration" Then
            strHTML.Append("<h2 class=' clsDiscussion clsDiscussion_border_bottom'>Sprint Details</h2>")
        Else
            strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Release Details</h2>")
        End If


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        If Flag = "Iteration" Then
            strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Iteration'", True))
            strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
        Else
            strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Release'", True))
            strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Release Name<span class='required'>*</span></label> ")
        End If

        strHTML.Append(" <div class='col-md-10'>")

        ''Commented and Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRName", "txtSRName", "form-control textbox", 140, 100, IterationName, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRName','spanSRName')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRName", "txtSRName", "form-control textbox", 140, 100, IterationName, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRName','spanSRName')", True, , , , , , True))
        ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed

        'strHTML.Append("<input  id='txtSRName' value='" & IterationName & "'  class='form-control'  type='text' style='width:200px!important;box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-md-10'>")

        Dim len As Integer = 1000
        Dim len1 As Integer
        If Description.Length <> -1 Then
            len1 = Description.Length
            len = 1000 - len1
        End If

        ''Commented and Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSRDescription", "txtSRDescription", , "form-control", , , , , , , len, Description, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup='javascript:limitText(this,countDown,1000)' onKeyUp='javascript:limitText(this,countDown, 1000)'onchange=ClearSpan('txtSRDescription','spanSRDescription') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSRDescription", "txtSRDescription", , "form-control", , , , , , , len, Description, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup='javascript:limitText(this,countDown,1000)' onKeyUp='javascript:limitText(this,countDown, 1000)'onchange=ClearSpan('txtSRDescription','spanSRDescription') data-autoresize", True, EnableHTMLEncode:=True))
        ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed

        'strHTML.Append("<textarea  id='txtSRDescription' class='form-control'style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;' >" & Description & "</textarea>")
        strHTML.Append("<span id='countDown' >" & len & "</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        'Commented and Added by Ankush T on 27/03/2019 for Date is displaying in Output format
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRStartDate", "txtSRStartDate", "form-control textbox", , 100,SprintStartDate, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRStartDate','spanStartDate')", True, , , , , , True))
        'Commented and Added by Usha Pandit on 30.04.2019 for disabling date field only if sprint is started
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRStartDate", "txtSRStartDate", "form-control textbox", , 100, CommonFunctions.Dates.CGetDate(CType(SprintStartDate, Date)), , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRStartDate','spanStartDate')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRStartDate", "txtSRStartDate", "form-control textbox", , 100, CommonFunctions.Dates.CGetDate(CType(SprintStartDate, Date)), , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRStartDate','spanStartDate')", True, , , , , , True))
        'End of Commented and Added by Usha Pandit on 30.04.2019 for disabling date field only if sprint is started
        'End of Commented and Added by Ankush T on 27/03/2019 for Date is displaying in Output format

        'strHTML.Append("<input  id='txtSRStartDate' value=" & SprintStartDate & "  class='form-control'  type='text' style='width:200px!important;box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;'>")
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: -35px;float:right;color:#0099CC;' id='SRdpd1'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")




        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        'Commented and Added by Ankush T on 27/03/2019 for Date is displaying in Output format
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSREndDate", "txtSREndDate", "form-control textbox", , 100, SprintEndDate, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSREndDate','spanEndDate')", True, , , , , , True))
        'Commented and Added by Usha Pandit on 30.04.2019 for disabling date field only if sprint is started
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSREndDate", "txtSREndDate", "form-control textbox", , 100, CommonFunctions.Dates.CGetDate(CType(SprintEndDate, Date)), , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSREndDate','spanEndDate')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSREndDate", "txtSREndDate", "form-control textbox", , 100, CommonFunctions.Dates.CGetDate(CType(SprintEndDate, Date)), , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSREndDate','spanEndDate')", True, , , , , , True))
        'End of Commented and Added by Usha Pandit on 30.04.2019 for disabling date field only if sprint is started
        'End of Commented and Added by Ankush T on 27/03/2019 for Date is displaying in Output format
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: -35px;float:right;color:#0099CC;' id='SRdpd1'></i>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Calender Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")

        ''Commented and Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRCalendersDuration", "txtSRCalendersDuration", "form-control textbox", , 100, SprintDuration, , , , True, , , "onkeyup=ClearSpan('txtSRCalendersDuration','spanCalenderDuration')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRCalendersDuration", "txtSRCalendersDuration", "form-control textbox", , 100, SprintDuration, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRCalendersDuration','spanCalenderDuration')", True, , , , , , True))
        ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed

        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRCalendersDuration", "txtSRCalendersDuration", "form-control textbox", 140, 100, SprintDuration, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRCalendersDuration','spanCalenderDuration')", True, , , , , , True))


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Business Day's</label> ")
        strHTML.Append(" <div class='col-md-8'>")

        ''Commented and Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRBusinessDuration", "txtSRBusinessDuration", "form-control textbox", , 100, BusinessDuration, , , , True, , , "onkeyup=ClearSpan('txtSRBusinessDuration','spanBusinessDuration')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRBusinessDuration", "txtSRBusinessDuration", "form-control textbox", , 100, BusinessDuration, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRBusinessDuration','spanBusinessDuration')", True, , , , , , True))
        ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed

        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSRBusinessDuration", "txtSRBusinessDuration", "form-control textbox", 140, 100, BusinessDuration, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSRBusinessDuration','spanBusinessDuration')", True, , , , , , True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")

        ''Commented and Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSREfforts", "txtSREfforts", "form-control textbox", 200, 100, SprintVelocity, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSREfforts','spanSREfforts')", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSREfforts", "txtSREfforts", "form-control textbox", 200, 100, SprintVelocity, , , , IIf(strState <> "InActive" And strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtSREfforts','spanSREfforts')", True, , , , , , True))
        ''End of Added by Usha Pandit on 11.04.2019 for disabling sprint if Sprint is already started or completed

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-6'>")
        'strHTML.Append(" <label class='col-md-6 control-label' style='white-space: nowrap;'>Story Points</label> ")
        strHTML.Append(" <div class='col-md-6'>")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprinttxtStoryPoint", "SprinttxtStoryPoint", "form-control", , 100, strStoryPoint, , , , IIf(strState <> "InActive" And strSprintStatus = "1" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('SprinttxtStoryPoint','spanStoryPoint')", True, , , , , , True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        'End of Added By Dipali V On 25th April 2018 
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")


        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div><br>")
        strHTML.Append("<div class='col-md-12 align-right'>")
        strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & IterationID & ",'Iteration'", True))
        If strSprintStatus = "1" Then
            strHTML.Append("<button type='button'  class='btn btn-info updatebtnrls'  id='updateSprintRelease' title='Sprint Already started/completed,you do not have access to change data' data-bs-toggle='tooltip' data-bs-placement='top'>Update</button>")

        Else
            strHTML.Append("<button type='button'  class='btn btn-info updatebtnrls' onclick=UpdateSprintRelease('" & Flag & "','" & IterationID & "') data-bs-toggle='tooltip' data-bs-placement='top' id='updateSprintRelease'>Update</button>")

        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")

        ''--------------------Sprints -----------------------------
        If Flag = "Release" Then
            strHTML.Append("<div id='div_Sprints' class='clsBox' style='    height: 600px;overflow:auto;'>")
            strHTML.Append("<h2 style='margin-top:8px;'>Sprint Lists</h2>")
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-right:30px;'><a class='sprint_list' onclick=ShowData1('List'," & IterationID & ")>List</a> | <a  class='sprint_list' onclick=ShowData1('Form'," & IterationID & ")>Add</a></h2>")
            strHTML.Append("<Div class='col-sm-12 ' id='divSprintLists'>")
            strHTML.Append("</Div>")

            strHTML.Append(" <div class='col-sm-12' id='divUnmapSprint' style='display:none'>")
            strHTML.Append("<div class='row' style='margin-top:10px;'>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-2' style='margin-top:10px;'>")
            strHTML.Append("<label>Remark</label>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-5'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , "form-control textArea", , , , , , 50, 100, Description, , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1"), False, True), , , "onkeyup='javascript:limitText(this,countDown2,100)' onKeyUp='javascript:limitText(this,countDown2, 100)'onchange=ClearSpan('txtRemark','spanRemark')", True, EnableHTMLEncode:=True))
            ' /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p id='countDown2' style='font-size: 11.5px;font-weight: 500;color: grey;margin-left: 416px;margin-top:-19px;'>100</p>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='row'>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<button type='button' style='float:right;margin-top:10px;' class='btn btn-primary btn-lg' onclick=TerminateSprint1(" & IterationID & ",'txtRemark','" & Flag & "') id='UnmapSprint'>Unmap From Release</button>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("<Div class='col-sm-12' id='divSprintForm' style='display:none;'>")
            strHTML.Append(" <div class='col-sm-12'>")
            strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;margin-right:30px;' title='Save' onclick=MapMultipleSprint(" & IterationID & ") class='fa fa-save'></i>")
            strHTML.Append("</div><br>")
            strHTML.Append("<div id='divsprintFormRefresh' style='margin-left:15px;margin-right:25px;'>")
            strHTML.Append(PlotSprintList(IterationID))
            strHTML.Append("</div>")
            strHTML.Append("</Div>")
            strHTML.Append("</div>")
        End If
        ''--------------------Graph -----------------------------
        strHTML.Append("<div id='div_graph' style='height:600px;' class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Graph_SprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''-------------------User Story -----------------------
        strHTML.Append("<div id='div_UserStory' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(USerStories_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''------------------------Team --------------------------------
        strHTML.Append("<div id='div_Team' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Teams_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''------------------------Task---------------------------------------
        strHTML.Append("<div id='div_Task' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Tasks_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''----------------------Issue-----------------------------------
        strHTML.Append("<div id='div_Issues' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Issues_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''-----------------Discussion --------------------------------
        strHTML.Append("<div id='div_Discussion' style='height:550px!important;width:100%;'  class='clsBox col-md-12 col-sm-12'>")

        strHTML.Append(Discussion_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        'strHTML.Append("<div id='div_Discussion' style='height:500px;'>")
        'strHTML.Append("<p >Comments</p>")
        'strHTML.Append("<hr style='margin-right:30px;'>")
        'strHTML.Append("<div class='row'>" & vbCrLf)
        'strHTML.Append("<div class='col-sm-10'>" & vbCrLf)
        'strHTML.Append("<div id='txtContent'>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button id='btnSend' onclick=insertUserStorytDiscussion('" & IterationID & "','" & Flag & "',this) type='button' class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='divDiscussionListSR'>")
        'strHTML.Append(PlotDiscussionThreadBody(IterationID, strUserDesc, Flag))
        'strHTML.Append("</div>")

        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        ''--------------------div_Reviews-----------------------
        strHTML.Append("<div id='div_Reviews' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Reviews_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        '------------------------Impedements-------------------------------------
        If Flag <> "Iteration" Then
            strHTML.Append("<div id='div_Impedement' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
            strHTML.Append(ImpedimentsLogs_sectionSprintRelease(IterationID, Flag))
            strHTML.Append("</div>")
        End If

        If Flag <> "Iteration" Then
            strHTML.Append("<div id='div_Risks' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
            strHTML.Append(Risks_sectionSprintRelease(IterationID, Flag))
            strHTML.Append("</div>")
        End If

        '------------------------History-------------------------------
        strHTML.Append("<div id='div_History' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(History_sectionSprintRelease(IterationID, Flag))
        strHTML.Append("</div>")

        ''--------------------Attachment--------------------------
        strHTML.Append("<div id='div_Attachment' style='height:500px;'  class='clsBox col-md-12 col-sm-12'>")
        strHTML.Append(Attachment_sectionSprintRelease(IterationID, Flag, ""))
        strHTML.Append("</div>")

        'strHTML.Append("<div id='div_Attachment' style='height:500px;'>")
        'strHTML.Append("<div id='divAttachments' class='clsBox'>")
        'strHTML.Append("<p>Attachments</p>")
        'strHTML.Append("<hr style='margin-right:30px;'>")
        'strHTML.Append("<div id='divAttachmentList' class='col-sm-12'>")
        'strHTML.Append(" <h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'>")
        'strHTML.Append(" <div class='demo-droppable'>")
        'strHTML.Append(" <p>Drag files here or click to upload</p>")
        'strHTML.Append("<input type='file' multiple='true' style='display: none;'>")
        'strHTML.Append("  </div>")
        'strHTML.Append("<a onclick='UploadData(213)'>Upload</a>")
        'strHTML.Append("</h2>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")



        strHTML.Append("</div>")


        Return (strHTML.ToString())


    End Function


#End Region

    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeSprintName(ByVal IterationID As String, ByVal SprintName As String, ByVal Flag As String) As String
        Try

            Dim strSQL As String
            Dim Flags As String = ""
            Try
                Flags = 1
                strSQL = "usp_NG2_UPD_ReleaseNAme " & HttpContext.Current.Session("IntProjectID") & "," & IterationID & ",'" & SprintName & "','" & Flag & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Catch ex As Exception

            End Try

            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    Public Function Attachment_sectionSprintRelease(ByVal userStoryID As String, ByVal Flag As String, Optional Refreshflag As String = "") As String
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
        strHTML.Append("<div id='divAttachments' class='clsBox'>")
        strHTML.Append("<H2 class='clsDiscussion clsDiscussion_border_bottom'>Attachments</H2>")
        'strHTML.Append("<br><hr style='border:1px solid rgb(60, 141, 188)!important;width:97%;margin-right:21px;'>")
        strHTML.Append(GetAttachmentListSprintRelease(userStoryID, Flag, ""))
        strHTML.Append("</div>")
        If Refreshflag <> "" Then
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString


    End Function

    Public Function GetAttachmentListSprintRelease(userStoryID As String, ByVal Flag As String, Optional Refreshflag As String = "")
        '=====================================================================
        ' Procedure  Name		:	GetAttachmentList
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To Get GetAttachment List
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    6th-March-2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        If Flag = "Iteration" Then
            Flag = "Sprint"
        End If
        If Flag <> "AfterDelete" Then
            strHTML.Append(" <div id='AttachmentusSprintdelete'>")
        End If

        Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'" & Flag & "'"
        Dim dtAttachment As New DataTable

        dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        strHTML.Append("<h2 style='margin:2%'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a onclick=UploadDataSR(" & userStoryID & ",'" & Flag & "')   style='background: #01579b;padding: 8px;color: #fff; border-radius: 4px;    float: right;    margin-top: 10px;'><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
        strHTML.Append(" <div id='listattachment'>")
        If dtAttachment.Rows.Count - 1 < 0 Then
            strHTML.Append("<br><br><div class='NoData' style='text-align:center'>")
            strHTML.Append("<span style='text-align:center' > There are no items to show in this view </span>") 'There are no items to show in this view.
            strHTML.Append("</div>")
        Else
            For i As Integer = 0 To dtAttachment.Rows.Count - 1

                strHTML.Append(" <div class='row attachRow' id='Sprintattachmentdata'>")
                strHTML.Append(" <div class='form-group'  style='margin-top:2%'>")
                strHTML.Append(" <div class='col-sm-4 '>")
                strHTML.Append("<span  title='Original File Name'  data-bs-toggle='tooltip' style='word-break:break-all'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
                strHTML.Append("</div>")
                strHTML.Append(" <div class='col-sm-4 '>")
                strHTML.Append("<span   title='Attached By'  data-bs-toggle='tooltip'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
                strHTML.Append("</div>")
                strHTML.Append(" <div class='col-sm-2 ' >")

                'Commented and Added by Usha Pandit On 26 March 2019 for attachment tab javascript error

                'strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "')""></i>")
                strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "").ToString().Replace("\", "\\") & "')""></i>")

                'End of Added by Usha Pandit On 26 March 2019 for attachment tab javascript error

                strHTML.Append("</div>")
                strHTML.Append(" <div class='col-sm-3 ' style='float:right;'>")
                strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;margin-top:-10%' onclick=""Delete_AttachmentSR(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'" & Flag & "')""></i>")
                strHTML.Append("</div>")

                'strHTML.Append(" <div class='col-sm-4 ' style='float:right;margin-right:-26%'>")
                'strHTML.Append("<span title='Delete' data-bs-toggle='tooltip'><i class='fa fa-trash' style='color:red!important' onclick=""Delete_AttachmentSR(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'" & Flag & "' )"" ></i></span>")
                'strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            Next
        End If
        strHTML.Append("</div>")
        If Flag <> "AfterDelete" Then
            strHTML.Append(" </div>")
        End If
        Return strHTML.ToString()

    End Function

    Public Function History_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        If Flag = "UserStory" Then
            strHTML.Append("<div class='clsBox col-md-12 col-sm-12'>")
            strHTML.Append("<div id='divHistoryUS' class='clsBox'>")
        Else
            strHTML.Append("<div id='divHistory' class='clsBox'>")
        End If
        'strHTML.Append("<div id='divHistory' class='clsBox'>")
        strHTML.Append("<div class='' >")
        strHTML.Append("<div class=''>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' >History Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 col-sm-offset-9 searchus'>")
        If Flag = "UserStory" Then
            strHTML.Append("<input type='text' name='table_search' id='txtSearchhistoryUS' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        Else
            strHTML.Append("<input type='text' name='table_search' id='txtSearchhistory' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        '<hr style='border:1px solid rgb(60, 141, 188)!important;width:97%;margin-right:21px;'>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divhistoryList'>")
        strHTML.Append(WriteGrid("HistorykList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Private Sub objHistorykList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objHistorykList.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "DATE" Then 'Date
            If Not IsDBNull(Args.DataReader("Date")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Date") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "MODIFIED BY" Then 'Modified By
            If Not IsDBNull(Args.DataReader("ModifiedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Modified By' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ModifiedBy") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Modified By' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "FIELD NAME" Then 'Field Name
            If Not IsDBNull(Args.DataReader("FieldName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Field Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("FieldName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Field Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "OLD VALUE" Then 'Old Value
            If Not IsDBNull(Args.DataReader("OldValue")) Then
                Cancel = True
                'Commented and Added by Usha Pandit on 07 June 2018 for word wrap for long text
                'Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Old Value' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("OldValue") & "</span></p></td>"
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Old Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all;white-space: pre-line;width: 250px;'>" & Args.DataReader("OldValue") & "</span></p></td>"
                'End of Added by Usha Pandit on 07 June 2018 for word wrap for long text
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Old Value' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "NEW VALUE" Then 'New Value
            If Not IsDBNull(Args.DataReader("NewValue")) Then
                Cancel = True

                'Commented and Added by Usha Pandit on 07 June 2018 for word wrap for long text
                'Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'New Value' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("NewValue") & "</span></p></td>"
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'New Value' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break: break-all;white-space: pre-line;width: 250px;'>" & Args.DataReader("NewValue") & "</span></p></td>"
                'End of Added by Usha Pandit on 07 June 2018 for word wrap for long text
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'New Value' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    Public Function Risks_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divRisks' class='clsBox'>")
        strHTML.Append("<div class='modal-header'  style='border-bottom: 2px solid rgb(60, 141, 188)!important; margin-top: 0%;padding:0%!important;'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='clsDiscussion style='margin-top:0%'>Risks Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchRisks' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divRisksList'>")
        strHTML.Append(WriteGrid("RisksList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    ''For Risk Tab
    Private Sub objRiskList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objRiskList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "DATE IDENTIFIED" Then 'Date Identified
            If Not IsDBNull(Args.DataReader("DateIdentified")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Date Identified' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("DateIdentified") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Date Identified' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'sprint Name
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then 'Description
            If Not IsDBNull(Args.DataReader("Description")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "RISK CATEGORY" Then 'RiskCategory
            If Not IsDBNull(Args.DataReader("RiskCategory")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Risk Category' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("RiskCategory") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Risk Category' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    Public Function ImpedimentsLogs_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='modal-header'  style='border-bottom: 2px solid rgb(60, 141, 188)!important; margin-top: 0%;padding:0%!important;'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='clsDiscussion' style='margin-top:0%'>Impediments Logs Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchImpediments' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divImpedimentsList'>")
        strHTML.Append(WriteGrid("ImpedimentsLogsList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        ' strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    ''For Impediments Tab
    Private Sub objImpedimentsLogList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objImpedimentsLogList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "RAISED DATE" Then 'Raised Date
            If Not IsDBNull(Args.DataReader("RaisedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Raised Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("RaisedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Raised Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SPRINT NAME" Then '"Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Iteration Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Iteration Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then 'Description
            If Not IsDBNull(Args.DataReader("Description")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "CREATED BY" Then 'CreatedBy
            If Not IsDBNull(Args.DataReader("CreatedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'CreatedBy' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("CreatedBy") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'CreatedBy' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "CONVERSION" Then 'Conversion
            If Not IsDBNull(Args.DataReader("Conversion")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Conversion' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Conversion") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Conversion' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    Public Function Reviews_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='' >")
        strHTML.Append("<div class=''>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' style='margin-top:0%'>Reviews Details</h2>")

        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 col-sm-offset-9 searchus'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchReviews' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    ''For Review Tab
    Private Sub objReviewList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objReviewList.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "REVIEWED DATE" Then 'Reviewed Date
            If Not IsDBNull(Args.DataReader("ReviewedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewed Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewed Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Status
            If Not IsDBNull(Args.DataReader("ReviewStatus")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewStatus") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REVIEWTITLE" Then 'ReviewTitle
            If Not IsDBNull(Args.DataReader("ReviewTitle")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Review Title' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewTitle") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Review Title' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "REVIEWEDBY" Then 'ReviewedBy
            If Not IsDBNull(Args.DataReader("ReviewedBy")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reviewed By/Reviewee' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReviewedBy") & "/" & Args.DataReader("Reviewee") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reviewed By/Reviewee' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        'If Args.ColumnName.ToUpper = "REVIEWEE" Then 'ReviewedBy
        '    Cancel = True
        'End If

    End Sub

    Public Function Discussion_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussions' class='clsBox' style='height:500px;width:100%;overflow-y:auto'>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' style='margin-top:0%'>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10' style='margin-left:-1%;margin-top:2%'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this)><i class='far fa-comments' aria-hidden='true'></i>  Post</button>")

        ''strHTML.Append("<button id='SprintRelease' type='button' onclick=insertSprintReleaseDiscussion('" & SprintID & "','" & Flag & "',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        strHTML.Append("<div id='divDiscussionListSprintRelease'>") 'divDiscussionListSprintRelease
        ' strHTML.Append(PlotDiscussion(SprintID, Flag))
        strHTML.Append(PlotDiscussionThreadBodySR(IterationID, "", Flag))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Friend Function PlotDiscussionThreadBodySR(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)

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
        Dim strDiscussionID1 As String = ""
        Dim dtTable As New DataTable()
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
        drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intCounter As Integer = 0


        strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin:4px;margin-left:20px;    padding: 12px 3px!important;'>")


        While drGetUserStoryDicussion.Read
            intCounter += 1
            strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
            strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")

            ''Added by Usha Pandit on 25.03.2019 Purpose:Set Date format as per company details Output Date Format
            'strDiscussionDate = CommonFunctions.Dates.CGetDateTime(CType(strDiscussionDate, DateTime))
            ''End of Added by Usha Pandit on 25.03.2019 Purpose:Set Date format as per company details Output Date Format
            strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
            strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
            strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
            Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
            strHTMLDiscussion.Append("<li class=''>")
            strHTMLDiscussion.Append("<div class=''>")
            strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start'>")
            strHTMLDiscussion.Append("<img alt='User Avatar'  title='Employee Image' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'   class='img-circle empimg' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8'>")
            strHTMLDiscussion.Append("<p class='clsempname'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom' style='font-weight:600'> " & strEmployeeName & "</span></P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='row'>")

            strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
            strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description' style='word-break:break-all;overflow-wrap: break-word;'>")
            Dim strLessComment As String = ""
            Dim strRemaining As String = ""
            If strComment.Length > 200 Then
                strLessComment = strComment.Substring(0, 200)
                strRemaining = strComment.Substring(201, strComment.Length - 201)
            End If
            If strLessComment = "" Then
                strHTMLDiscussion.Append("" & strComment & "")
            Else
                strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
            End If
            If strComment.Length > 200 Then
                strHTMLDiscussion.Append("<a onclick='ShowMoreLessSR(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
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
            strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclickSR(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px;    vertical-align: middle;' title='Reply count' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'>" & dtTable.Rows.Count & "</label>")
            strHTMLDiscussion.Append("</small>")



            If dtTable.Rows.Count > 0 Then
                strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
                For i As Integer = 0 To dtTable.Rows.Count - 1
                    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
                    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
                    strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
                    strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
                    strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
                    strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

                    strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
                    strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
                    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
                    strHTMLDiscussion.Append("<div class='header'>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class=''>")
                    strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
                    strHTMLDiscussion.Append("<img alt='User Avatar' title='Employee Image' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'  class='img-circle empimg' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
                    strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
                    strHTMLDiscussion.Append("</span>")

                    strHTMLDiscussion.Append("<div class='col-md-9 col-sm-9' style='white-space:pre!important;float:right'>")
                    strHTMLDiscussion.Append("<p style='float:right;margin-top:24%' class='clsempname'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom' style='word-break:break-all;'> " & strEmployeeName & "</span></P>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<p style='color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom'  style='word-break:break-all;overflow-wrap: break-word;'>")
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
                        strHTMLDiscussion.Append(" <a onclick='ShowMoreLessSR(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
                    End If
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<small class='float-end text-muted'>")
                    strHTMLDiscussion.Append("<span style='font-size:12px!important;' title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclickSR(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>")
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
            strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin-top:8%;text-align:center;'>")
            ' strHTMLDiscussion.Append("<li class='col-sm-6'>")

            'Commented and Added by Usha Pandit On 28 March 2019 for Discussion placeholder
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , " data-autoresize", True, EnableHTMLEncode:=True))
            'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , " data-autoresize placeholder = 'Post New Discussion'", True, EnableHTMLEncode:=True))
            strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , " data-autoresize placeholder = 'Post New Discussion' maxlength ='2000'", True, EnableHTMLEncode:=True))
            'End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'End of Added by Usha Pandit On 28 March 2019 for Discussion placeholder

            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;' onclick=AddNewDiscussionSR(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New</span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertSprintReleaseDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions')><sup><i class='far fa-comments' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost'> Post</span></button>")

            'strHTMLDiscussion.Append("</li>")
            strHTMLDiscussion.Append("</ul>")
        End If


        'Dim drGetUserStoryDicussion As IDataReader
        'Dim drGetUserStoryDicussionCount As IDataReader
        'Dim drContactList As IDataReader
        'Dim strHTMLDiscussion As New StringBuilder
        'Dim StrQuery As String = ""
        'Dim StrUserStoryCountQuery As String = ""
        'Dim intDiscussionCount As Integer = 0
        'Dim strPhotoFileName As String = ""
        'Dim strDiscussionDate As String = ""
        'Dim strComment As String = ""
        'Dim strEmployeeName As String = ""
        'Dim flag As String = ""
        'Dim strUserName As String = ""
        'Dim strDiscussionID As String = ""
        'Dim dtTable As New DataTable()
        'StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
        'drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
        'Dim intCounter As Integer = 0

        'strHTMLDiscussion.Append("<ul class='col-sm-6 chat'>")

        'While drGetUserStoryDicussion.Read
        '    intCounter += 1
        '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
        '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
        '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
        '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
        '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
        '    strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
        '    Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
        '    strHTMLDiscussion.Append("<li class='col-sm-12'>")
        '    strHTMLDiscussion.Append("<span class='chat-img float-start'>")
        '    strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
        '    strHTMLDiscussion.Append("</span>")
        '    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd'>")
        '    strHTMLDiscussion.Append("<div class='header'>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("<div class='row'>")
        '    strHTMLDiscussion.Append("<div class='col-sm-8'>")
        '    strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
        '    strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;margin-left: 169px;margin-top:-18px;'> " & strSubmittedTime & "</P>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description'>")
        '    Dim strLessComment As String = ""
        '    Dim strRemaining As String = ""
        '    If strComment.Length > 200 Then
        '        strLessComment = strComment.Substring(0, 200)
        '        strRemaining = strComment.Substring(201, strComment.Length - 201)
        '    End If
        '    If strLessComment = "" Then
        '        strHTMLDiscussion.Append("" & strComment & "")
        '    Else
        '        strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
        '    End If
        '    If strComment.Length > 200 Then
        '        strHTMLDiscussion.Append("<a onclick='ShowMoreLessSR(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
        '    End If
        '    Dim ReplyFlag As String = ""
        '    strHTMLDiscussion.Append("</span></p>")
        '    If strFlag = "UserStory" Then
        '        ReplyFlag = "UserStoryReply"
        '    ElseIf strFlag = "Iteration" Then
        '        ReplyFlag = "IterationReply"
        '    Else
        '        ReplyFlag = "ReleaseReply"
        '    End If
        '    strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
        '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
        '    dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
        '    strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'>View all reply<span></label> <a class='clsReply' onclick=""reply_onclickSR(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'>Reply</a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Discussion count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
        '    strHTMLDiscussion.Append("</small>")
        '    strHTMLDiscussion.Append("</div>")


        '    If dtTable.Rows.Count > 0 Then
        '        strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse chatReply' style='float:right;margin-right:-36%'>")
        '        For i As Integer = 0 To dtTable.Rows.Count - 1
        '            strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
        '            strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
        '            strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
        '            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
        '            strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
        '            strDiscussionID = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
        '            strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

        '            strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
        '            strHTMLDiscussion.Append("<li class='col-sm-12' >") 'style='border-bottom:1px solid white!important'
        '            strHTMLDiscussion.Append("<div class='chat-body clearfix chatReply'>")
        '            strHTMLDiscussion.Append("<div class='header'>")
        '            strHTMLDiscussion.Append("</div>")
        '            strHTMLDiscussion.Append("<div class='row'>")
        '            strHTMLDiscussion.Append("<div class='col-sm-9' style='white-space:pre!important;margin-left:-14px;'>")
        '            strHTMLDiscussion.Append("<p class='Postedtime'><span style='margin-left:-90%;white-space:pre!important;font-size: 10px;margin-left: 39px;margin-top:-18px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
        '            strHTMLDiscussion.Append("</div>")
        '            strHTMLDiscussion.Append("<div class='col-sm-3' style='white-space:nowrap;margin-left:-29%'>")
        '            strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
        '            strHTMLDiscussion.Append("</div>")
        '            strHTMLDiscussion.Append("</div>")
        '            strHTMLDiscussion.Append("<p style='Margin-left:9%;Margin-top:0%;color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom'>")
        '            Dim strLessCommentInside As String = ""
        '            Dim strRemainingInside As String = ""
        '            If strComment.Length > 200 Then
        '                strLessCommentInside = strComment.Substring(0, 200)
        '                strRemainingInside = strComment.Substring(201, strComment.Length - 201)
        '            End If
        '            If strLessCommentInside = "" Then
        '                strHTMLDiscussion.Append("" & strComment & "")
        '            Else
        '                strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
        '            End If
        '            If strComment.Length > 200 Then
        '                strHTMLDiscussion.Append(" <a onclick='ShowMoreLessSR(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p>")
        '            End If
        '            strHTMLDiscussion.Append("<br><small class='float-end text-muted' style='margin-right:40%!important;float:right!important;'>")
        '            strHTMLDiscussion.Append("<span title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclickSR(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'>Reply</a>")
        '            strHTMLDiscussion.Append("</small>")
        '            strHTMLDiscussion.Append("</div>")
        '            strHTMLDiscussion.Append("<span class='chat-img float-start' style='margin-left:275px;margin-top:-21%'>")
        '            strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
        '            strHTMLDiscussion.Append("</span>")
        '            strHTMLDiscussion.Append("</li>")
        '        Next
        '        strHTMLDiscussion.Append("</ul>")
        '    End If
        '    strHTMLDiscussion.Append("</li>")
        '    If intCounter = 1 Then
        '        flag = "PlotTextArea"
        '    End If
        'End While
        'If intCounter = 0 Then
        '    flag = "PlotTextArea"
        '    strHTMLDiscussion.Append("<li class='col-sm-12'>")
        '    strHTMLDiscussion.Append("<span class='chat-img float-start'>")
        '    'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
        '    strHTMLDiscussion.Append("</span>")
        '    strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
        '    strHTMLDiscussion.Append("<div class='header'>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
        '    strHTMLDiscussion.Append("No records to view.")
        '    strHTMLDiscussion.Append("</p>")
        '    strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
        '    'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
        '    strHTMLDiscussion.Append("</small>")
        '    strHTMLDiscussion.Append("</div>")
        '    strHTMLDiscussion.Append("</li>")
        'End If

        'strHTMLDiscussion.Append("</ul>")
        ''End If

        'If flag = "PlotTextArea" Then
        '    strHTMLDiscussion.Append("<ul class='col-sm-6' style='margin-top:8%'>")
        '    ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
        '    strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
        '    strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintReleaseAddDiscussion'  style='' onclick=AddNewDiscussion(this,'txtDiscussions')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
        '    strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style=''   onclick=insertSprintReleaseDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions')><sup><i class='far fa-comments' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

        '    'strHTMLDiscussion.Append("</li>")
        '    strHTMLDiscussion.Append("</ul>")
        'End If



        Return strHTMLDiscussion.ToString()


    End Function


    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
    '    Dim strSQL As String
    '    Dim strREsult As String

    '    strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID
    '    strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '    If strREsult Then
    '        If HttpContext.Current.Session("intUserID") <> "0" Then
    '            CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
    '        Else
    '            CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)

    '        End If
    '    End If
    '    If Flag = "UserStory" Then
    '        Return New frmSprintPlanning().PlotDiscussionThreadBodyUS(strUserStoryID, "", Flag)
    '    Else
    '        Return New frmSprintPlanning().PlotDiscussionThreadBodySR(strUserStoryID, "", Flag)
    '    End If

    '    'PlotDiscussionThreadBody(strUserStoryID, "", "UserStory")
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussionSR(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        Try

            Dim strSQL As String
            Dim strREsult As String
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                End If
            End If

            Return New frmSprintPlanning().PlotDiscussionThreadBodySR(strUserStoryID, "", Flag)
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Public Function Issues_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='div_Issues' class='clsBox'>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' id='' style='margin-top:0%!important'>Issues Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3  col-sm-offset-9 searchus'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchIssues' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssuesList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    ''For Issue Tab
    Private Sub objIssuesList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objIssuesList.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "FLAG" Then 'Flag
            If Not IsDBNull(Args.DataReader("IsImpediment")) Then
                Cancel = True
                If (Args.DataReader("IsImpediment") = 1) Then

                    Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue by Impediment' data-bs-toggle='tooltip' data-bs-placement='bottom' ><i class='fa fa-star' aria-hidden='true' style='color:red !important'></i></span></p></td>"
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IssueID") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "REPORTED DATE" Then 'ReportedDate
            If Not IsDBNull(Args.DataReader("ReportedDate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Reported Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ReportedDate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Reported Date' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "TYPE" Then 'ReportedDate
            If Not IsDBNull(Args.DataReader("Type")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Issue Type' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Type") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Issue Type' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SUMMARY" Then 'Summary
            If Not IsDBNull(Args.DataReader("Summary")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Summary' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Summary") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Summary' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub

    Public Function Tasks_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divTasks' class='clsBox'>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<h5 class='clsDiscussion clsDiscussion_border_bottom' > Task Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3  col-sm-offset-9 searchus'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchTask' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divTaskList'>")
        strHTML.Append(WriteGrid("TaskList", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Private Sub objtaskList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objtaskList.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "ASSIGNED TO" Then 'AssignedTo
            If Not IsDBNull(Args.DataReader("AssignedTo")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Assigned To' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("AssignedTo") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Assigned To' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'Sprint Name
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "PLAN/EFFORT" Then 'Plan/Effort
            If Not IsDBNull(Args.DataReader("Effort")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Effort") & " / " & Args.DataReader("Actual") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Plan/Effort' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STATUS" Then 'Old Value
            If Not IsDBNull(Args.DataReader("IsActive")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("IsActive") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "TASK NAME" Then 'Task Name
            If Not IsDBNull(Args.DataReader("ScrumTaskName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Task Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("ScrumTaskName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Task Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub
    'Old Team code
    'Public Function Teams_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String
    '    Dim strHTML As New StringBuilder()
    '    Dim StrQuery As String = ""
    '    Dim EmployeeName As String = ""
    '    Dim EmployeeID As String = ""
    '    Dim ExpectedStartDate As String = ""
    '    Dim ExpectedEndDate As String = ""
    '    Dim RoleDescription As String = ""
    '    Dim SystemFilename As String = ""
    '    Dim TotalTasks As String = ""
    '    Dim InProgressTasks As String = ""
    '    Dim CompletedTasks As String = ""
    '    Dim TotalIssues As String = ""
    '    Dim ResourcePercentage As String = ""
    '    Dim TaskCompletionPercentage As String = ""
    '    Dim BarColor As String = ""
    '    Dim Clsprogressbar As String = ""
    '    Dim badgecolor As String = ""
    '    Dim drGetTeamDetails As IDataReader
    '    strHTML.Append("<div id='divTeams' class='clsBox'>")
    '    If Flag = "UserStory" Then
    '        strHTML.Append("<h2 class='clsDiscussion'>Resources</h2>")
    '    Else
    '        strHTML.Append("<h2 class='clsDiscussion'>Project Teams</h2>")
    '    End If
    '    strHTML.Append("<Div class='col-sm-12' id='divTeamsList'>")
    '    strHTML.Append("<table class='clsTeamTable'>")

    '    StrQuery = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("IntProjectID") & "," & IterationID & ",'" & Flag & "'"
    '    drGetTeamDetails = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intnewCounter As Integer = 0
    '    Dim IscheckDatahas As Integer = 0
    '    ' strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFileName").ToString, "")
    '    While drGetTeamDetails.Read
    '        intnewCounter += 1
    '        If intnewCounter = 1 Then
    '            IscheckDatahas = 1
    '            strHTML.Append("<tr>")
    '            strHTML.Append("<td>")
    '            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
    '            EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
    '            InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
    '            CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
    '            TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
    '            ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
    '            TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
    '            TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
    '            SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
    '            RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
    '            ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
    '            BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
    '            If BarColor = "Blue" Then
    '                Clsprogressbar = "active"
    '                badgecolor = "label label-primary"
    '            ElseIf BarColor = "Green" Then
    '                Clsprogressbar = "progress-bar-success"
    '                badgecolor = "label label-success"
    '            ElseIf BarColor = " Orange" Then
    '                Clsprogressbar = "progress-bar-warning"
    '                badgecolor = "label label-warning"
    '            ElseIf BarColor = " Red" Then
    '                Clsprogressbar = "progress-bar-danger"
    '                badgecolor = "label label-danger"
    '            End If


    '            strHTML.Append("<div class='card'>" & vbCrLf)
    '            'strHTML.Append("<div class='cardheader'>" & vbCrLf)
    '            strHTML.Append("<div class='Row' style='margin-top:3%'>")
    '            strHTML.Append("<div class='col-sm-2' style='margin-left:10px;'>")
    '            strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
    '            strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
    '            strHTML.Append("</span>")
    '            strHTML.Append("</div>")

    '            strHTML.Append("<div class='col-sm-10'>")

    '            Dim strLessComment As String = ""
    '            Dim strRemaining As String = ""
    '            If RoleDescription.Length > 10 Then
    '                strLessComment = RoleDescription.Substring(0, 10)

    '            End If
    '            strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
    '            strHTML.Append("<P class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
    '            strHTML.Append("<div class='progress' style='width:80%'>")
    '            'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
    '            strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -6%; margin-right: 15%;border-radius:10px' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</td>")

    '        End If
    '        If intnewCounter = 2 Then
    '            IscheckDatahas = 1
    '            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeName").ToString, "")
    '            EmployeeID = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("EmployeeID").ToString, "")
    '            InProgressTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("InProgressTasks").ToString, "")
    '            CompletedTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("CompletedTasks").ToString, "")
    '            TotalIssues = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalIssues").ToString, "")
    '            ResourcePercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ResourcePercentage").ToString, "")
    '            TaskCompletionPercentage = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TaskCompletionPercentage").ToString, "")
    '            TotalTasks = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("TotalTasks").ToString, "")
    '            SystemFilename = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFilename").ToString, "")
    '            RoleDescription = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("RoleDescription").ToString, "")
    '            ExpectedEndDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedEndDate").ToString, "")
    '            ExpectedStartDate = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("ExpectedStartDate").ToString, "")
    '            BarColor = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("BarColor").ToString, "")
    '            If BarColor = "Blue" Then
    '                Clsprogressbar = "active"
    '                badgecolor = "label label-primary"
    '            ElseIf BarColor = "Green" Then
    '                Clsprogressbar = "progress-bar-success"
    '                badgecolor = "label label-success"
    '            ElseIf BarColor = " Orange" Then
    '                Clsprogressbar = "progress-bar-warning"
    '                badgecolor = "label label-warning"
    '            ElseIf BarColor = " Red" Then
    '                Clsprogressbar = "progress-bar-danger"
    '                badgecolor = "label label-danger"
    '            End If

    '            strHTML.Append("<td>")
    '            strHTML.Append("<div class='card'>" & vbCrLf)
    '            'strHTML.Append("<div class='cardheader'>" & vbCrLf)
    '            strHTML.Append("<div class='Row' style='margin-top:3%'>")
    '            strHTML.Append("<div class='col-sm-2'>")
    '            strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
    '            strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
    '            strHTML.Append("</span>")
    '            strHTML.Append("</div>")
    '            Dim strLessComment As String = ""
    '            Dim strRemaining As String = ""
    '            If RoleDescription.Length > 10 Then
    '                strLessComment = RoleDescription.Substring(0, 10)
    '            End If

    '            strHTML.Append("<div class='col-sm-10'>")
    '            strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
    '            ' strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='top' title='Role Description'>" & RoleDescription & " </label></P>")
    '            strHTML.Append("<P class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
    '            strHTML.Append("<div class='progress' style='width:80%'>")
    '            'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
    '            strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -6%; margin-right: 15%;border-radius:10px' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</div>")
    '            strHTML.Append("</td>")
    '            strHTML.Append("</tr>")
    '            intnewCounter = 0
    '        End If

    '    End While
    '    If intnewCounter = 1 Then
    '        strHTML.Append("</tr>")
    '    End If

    '    If IscheckDatahas = 0 Then
    '        strHTML.Append("<tr>")
    '        strHTML.Append("<td>")
    '        strHTML.Append("<div class='NoTeam'>")
    '        strHTML.Append("<span style='text-align:center' > There are no items assign to resource </span>") 'There are no items to show in this view.
    '        strHTML.Append("</div>")
    '        strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '    End If

    '    strHTML.Append("</table>")
    '    strHTML.Append("</Div>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function



    'New team code
    Public Function Teams_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


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
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Project Teams</h2>")
        'strHTML.Append("<br><hr style='border:1px solid rgb(60, 141, 188)!important;width:97%;margin-right:21px;'>")
        strHTML.Append("<Div class='col-sm-12' id='divTeamsList' style='margin-top: 15px;'>")
        strHTML.Append("<div class='clsTeamTable'>")

        StrQuery = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("IntProjectID") & "," & SprintID & ",'" & Flag & "'"
        drGetTeamDetails = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        While drGetTeamDetails.Read
            intnewCounter += 1
            If intnewCounter = 1 Then
                IscheckDatahas = 1
                strHTML.Append("<div>")
                strHTML.Append("<div class='col-sm-12 sprint_card team_cards '>")
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
                strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-md-10 col-sm-10 col-sm-12'>")

                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)

                End If

                strHTML.Append("<p class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></p>")

                strHTML.Append("<p class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </p>")
                strHTML.Append("<div class='progress' style='width:80%'>")

                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -40px; margin-right: -13px;border-radius:10px' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
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



                strHTML.Append("<div class='col-sm-12 sprint_card team_cards '>")
                strHTML.Append("<div class=''>")
                strHTML.Append("<div class='col-md-2 col-sm-2 col-sm-12'>")
                strHTML.Append("<span class='chat-img float-start' data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Image'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")
                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)

                End If


                strHTML.Append("<div class='col-md-10 col-sm-10 col-sm-12'>")
                strHTML.Append("<P class='ClsTeamDetails'><span  data-bs-toggle='tooltip' data-bs-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-bs-toggle='tooltip' data-bs-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")

                strHTML.Append("<P class='ResourcePercentage'><span data-bs-toggle='tooltip' data-bs-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -12%; margin-right: 6%;border-radius:10px' data-bs-toggle='tooltip' data-bs-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
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
            strHTML.Append("<span style='text-align:center' > There are no items assign to resource </span>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        strHTML.Append("</div>")
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    Public Function USerStories_sectionSprintRelease(ByVal IterationID As String, ByVal Flag As String) As String

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divUserstories' class='clsBox'>")
        strHTML.Append("<div class='' >")
        strHTML.Append("<div class=''>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' id='' style='margin-top:0%!important;'>User stories Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 col-sm-offset-9 searchus'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchCurrntSprintUS' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divSprintList1'>")
        strHTML.Append(WriteGrid("CurrentSprintUS", IterationID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    ''For US Tab
    Private Sub objCurrentSprintUS_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objCurrentSprintUS.DataRowTD_BeforePrint

        Dim StatusColor As String = ""
        If Args.ColumnName.ToUpper = "STATUS" Then
            If Args.DataReader("Status") = "To-Do List" Then
                StatusColor = "label1 label-Yellow"
            ElseIf Args.DataReader("Status") = "In Progress" Then
                StatusColor = "label1 label-warning"
            ElseIf Args.DataReader("Status") = "Open" Then
                StatusColor = "label1 label-danger"
            ElseIf Args.DataReader("Status") = "Cancel" Then
                StatusColor = "label1 label-danger"
            ElseIf Args.DataReader("Status") = "Done" Then
                StatusColor = "label1 label-success"
                'Added by Usha Pandit on 08 June 2018 for giving color for completed status
            ElseIf Args.DataReader("Status") = "Completed" Then
                StatusColor = "label1 label-green"
                'End of Added by Usha Pandit on 08 June 2018 for giving color for completed status
            End If
            If Not IsDBNull(Args.DataReader("Status")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("Status") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Status' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "ID" Then 'UserStory ID
            If Not IsDBNull(Args.DataReader("UserStoryID")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("UserStoryID") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story ID' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If



        If Args.ColumnName.ToUpper = "USER STORY NAME" Then 'User StoryName
            If Not IsDBNull(Args.DataReader("UserStoryName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'User Story Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then 'User StoryName
            If Not IsDBNull(Args.DataReader("SprintName")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("SprintName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STORY POINTS" Then 'Story Points
            If Not IsDBNull(Args.DataReader("InitialEstimate")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Story Points' data-bs-toggle='tooltip' data-bs-placement='bottom' >" & Args.DataReader("InitialEstimate") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Story Points' data-bs-toggle='tooltip' data-bs-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

    End Sub


    Public Function Graph_SprintRelease(ByVal IterationID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='graph' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Chart</h2>")

        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='display:inline-flex'>")
        strHTML.Append("<nav class='col-sm-3 col-sm-2' id='myScrollspy'>")    ' style='width: 16%!important;' Added by Usha Pandit on 11 June 2018 for button position gets changed
        strHTML.Append("<ul class='nav nav-pills nav-stacked'>")
        'strHTML.Append("<div class='tab' style='margin-top:4%;margin-left:1%'>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")"" id='defaultOpen'>&nbsp;Burn Down</button>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")"">&nbsp;Velocity</button>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")"">&nbsp;Burn Up</button>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")"">&nbsp;Flow</button>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")"">&nbsp;Com-Sprint</button>")
        'strHTML.Append("<button type='button' class='tablinks1' onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")"">&nbsp;Can-Sprint</button>")
        'strHTML.Append("</div>")

        If Flag = "Release" Then
            strHTML.Append("<li><a href='#BurnDown' class='active'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
            strHTML.Append("<li><a href='#BurnUp'  >Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
            strHTML.Append("<li><a href='#Velocity' >Velocity</a></li>") 'onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")""
            strHTML.Append("<li><a href='#Flow' >Flow</a></li>") 'onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")""
            strHTML.Append("<li><a href='#ComSprint' >Com-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")""
            strHTML.Append("<li><a href='#CanSprint' >Can-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")""
        Else
            strHTML.Append("<li class='active'><a href='#BurnDown'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
            strHTML.Append("<li><a href='#BurnUp'  >Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
        End If

        strHTML.Append("</ul>")
        strHTML.Append(" </nav>")

        strHTML.Append("<div class='col-sm-9 col-sm-10 scrollspy-example' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='5'>")
        If Flag = "Release" Then
            strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnDown"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnUp"))
            strHTML.Append("</div>")

            'strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
            'strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
            'strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnDown"))
            'strHTML.Append("</div>")

            'strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
            'strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
            'strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnUp"))
            'strHTML.Append("</div>")

            strHTML.Append("<div id='Velocity' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Velocity</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "Velocity"))
            strHTML.Append("</div>")


            strHTML.Append("<div id='Flow' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Flow</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "Flow"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='ComSprint' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Com-Sprint</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "ComSprint"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='CanSprint' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Can-Sprint</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "CancelSprint"))
            strHTML.Append("</div>")
            strHTML.Append("<br>")

        Else

            strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnDown"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
            strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnUp"))
            strHTML.Append("</div>")
            strHTML.Append("<br>")

            'strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
            'strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
            'strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnDown"))
            'strHTML.Append("</div>")

            'strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
            'strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
            'strHTML.Append(PlotBurnDown(IterationID, Flag, "BurnUp"))
            'strHTML.Append("</div>")

        End If






        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString


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
    Public Function PlotBurnDown(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder()
        If GraphFlag = "BurnDown" Then
            strHTML.Append("<div class='divLineGraph' style='width:100%;height:547px'>")
            strHTML.Append(GetBurnDownGraph(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>") 'float:right;margin-top:-40%;margin-right:-4%'
            strHTML.Append(GetBurnupGraph(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Velocity" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            strHTML.Append(GetVelocityEffortBarGraph(SprintID, Flag, GraphFlag))
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetVelocitySToryPointsBarGraph(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "BurnUp" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            strHTML.Append(GetBurnupGraphEfforts(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetBurnupGraphStoryPoints(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Flow" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;height:126%!important'>")
            strHTML.Append(GetFlowGraphEfforts(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            ' strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            'strHTML.Append(GetFlowGraphStoryPoints(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")

        ElseIf GraphFlag = "ComSprint" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            ' strHTML.Append(GetComSprint(SprintID, Flag, GraphFlag))
            strHTML.Append("<div id='ComSprintGrid" & SprintID & "' class=''>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")

        ElseIf GraphFlag = "CancelSprint" Then
            strHTML.Append("<div class='divLineGraph' style='width: 100%;height:547px'>")
            strHTML.Append("<div class='' id='CanSprintGrid" & SprintID & "'>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString()


    End Function

    Public Function GetBurnDownGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>")
        If Flag = "UserStory" Then
            strHTML.Append("<canvas style='width:500px!important;' id='BurnDown" & SprintID & "'></canvas>")
            strHTML.Append("</div>")
        Else
            strHTML.Append("<canvas id='BurnDown" & SprintID & "'></canvas>")
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString()


    End Function
    Public Function GetBurnupGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)
        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnUp" & SprintID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()
    End Function

    'Flow graph
    Public Function GetFlowGraphEfforts(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)

        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='FlowGraphEfforts" & SprintID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function
    ' For Velocity Graph
    Public Function GetVelocityEffortBarGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)

        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocityEffortBar" & SprintID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function
    Public Function GetVelocitySToryPointsBarGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='VelocitySToryPoints" & SprintID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function

    Public Function GetBurnupGraphEfforts(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphEfforts" & SprintID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function
    Public Function GetBurnupGraphStoryPoints(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnupGraphStoryPoints" & SprintID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetailsForGraph(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
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
    Public Shared Function GetGetBurnUpChartGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnUpChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetGraphDetails(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_GetBurnDownChart " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & "," & UniqueID & ",'" & Flag & "'," & SelectedID
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetVelocityData(ByVal strGraphFilter As String, ByVal UniqueID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            strGraphSQL = "usp_NG2_GET_VelocityGraphAsperStory " & UniqueID & "," & HttpContext.Current.Session("IntProjectID") & ",'" & strGraphFilter & "'"


            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetFlowGraph(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_UserStoryFlowGraph " & UniqueID & "," & SelectedID & ""
            dtGraphTable = CommonFunctions.Data.GetDataTable(strSql, True)

            strResult = GetSerialized(dtGraphTable)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCompleteCancelGraphDetails(ByVal ReleaseID As String, ByVal GraphFlag As String)
        '=====================================================================
        ' Procedure Name        : GetCompleteCancelGraphDetails()	
        ' Purpose               : To Get Complete Cancel GraphDetails
        ' Description           : To  Get Complete Cancel GraphDetails
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 22th March -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim drReleaseDetails As IDataReader
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmReleasePlanning As New frmSprintPlanning()
            strGridHTML.Append(objfrmReleasePlanning.WriteGrid(GraphFlag, ReleaseID, ""))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

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
        Dim PageTagID As String = ""
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
            strGridHTML.Append("<input type=hidden id=FilterDivRelaseList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue

            With objGrid1
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
            objGrid1 = Nothing
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
            strGridHTML.Append("<input type=hidden id=FilterDivSprintlist value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivNoTMappedSprintlist value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivRelease1list value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivCompleteSprint value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivCancelSprint value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_Sel_CurrentSprintUSdetails " & SelectedReleaseID & ",'Sprint'"
            arrstrActualList = {"UserStoryID", "SprintName", "InitialEstimate", "Status", "UserStoryName"}
            arrstrUserFriendlyList = {"ID", "Sprint Name", "Story Points", "Status", "User Story Name"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivCurrentSprintUS value='" & dtListCount.Rows.Count & "'>")
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
            If FlagSprintRelease = "Sprint" Or FlagSprintRelease = "Iteration" Then
                FlagSprintRelease = "Iteration"
            Else
                FlagSprintRelease = "UserStory"
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
            strGridHTML.Append("<input type=hidden id=FilterDivSubTabIssuesList value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivImpedimentsLogsList value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id=FilterDivRisksList value='" & dtListCount.Rows.Count & "'>")
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
            intNoOfDataColumn = 5 '6
            strDivID = "DivReviewList"
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumReviews " & SelectedReleaseID & "," & FlagSprintRelease & ""
            'arrstrActualList = {"ReviewedDate", "IterationName", "ReviewStatus", "ReviewTitle", "ReviewedBy", "Reviewee"}
            'arrstrUserFriendlyList = {"Reviewed Date", "Sprint Name", "Status", "ReviewTitle", "ReviewedBy", "Reviewee"}
            arrstrActualList = {"ReviewedDate", "IterationName", "ReviewStatus", "ReviewTitle", "ReviewedBy"}
            arrstrUserFriendlyList = {"Reviewed Date", "Sprint Name", "Status", "Review Title", "Reviewer/Reviewee"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivReviewList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=center", "align=center", "align=center", "align=center", "align=center"}

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

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            'arrstrActualList = {"AssignedTo", "IterationName", "Effort", "IsActive", "ScrumTaskName"}
            arrstrActualList = {"AssignedTo", "IterationName", "HMEffort", "IsActive", "ScrumTaskName"}
            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            'arrstrUserFriendlyList = {"Assigned To", "Sprint Name", "Plan/Effort", "Status", "Task Name"}
            arrstrUserFriendlyList = {"Assigned To", "Sprint Name", "Plan/Effort (H:M)", "Status", "Task Name"}
            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivTaskList value='" & dtListCount.Rows.Count & "'>")
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

            If FlagSprintRelease = "Iteration" Or FlagSprintRelease = "Sprint" Then
                'FlagSprintRelease = "Iteration"
                PageTagID = 8084
            ElseIf FlagSprintRelease = "Release" Then
                PageTagID = 8083
            Else
                PageTagID = 8087
            End If
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrstrLinkArray() As String
            Dim arrCheckBoxArray() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 5

            strDivID = "DivHistorykList"

            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & "," & PageTagID & ""
            arrstrActualList = {"Date", "ModifiedBy", "FieldName", "OldValue", "NewValue"}
            arrstrUserFriendlyList = {"Date", "Modified By", "Field Name", "Old Value", "New Value"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDivHistorykList value='" & dtListCount.Rows.Count & "'>")
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
        End If

        'End If
        Return strGridHTML.ToString


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

    Function PlotSprintList(ByVal IterationID As String)

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        intNoOfDataColumn = 4
        strDivID = "divsprintFormRefresh"

        strSQLQuery = "usp_NG2_NotMappedSprint " & HttpContext.Current.Session("IntProjectID") & ",'Sprint'"

        arrstrActualList = {"IterationID", "IterationName", "IterationStatus", "IsMapped", ""}
        arrstrUserFriendlyList = {"IterationID", "Iteration Name", "Iteration Status", "IsMapped", "SELECT"}
        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterdivsprintFormRefresh value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
        ' objGrid = m_objEmpGrid
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
        'End If
        Return strGridHTML.ToString

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshSprintList(ByVal IterationID As String)
        Try

            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder()
            strHTML.Append(obj.PlotSprintList(IterationID))

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint

        'Cancel = True
        'Args.clsTR.Remove()
        'Args.StringToBeInserted = "<tr role='row' class='" & strClass & "'></tr>"

        'If strClass = "clsTROdd" Then
        '    strClass = "clsTREvenRow"
        'End If
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("IterationID") & "' title='Select' name='chkIterationSelect' class='clscheckbox'>" + "</TD>"
        End If
    End Sub

    <System.Web.Services.WebMethod()>
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
            Dim objfrmReleasePlanning As New frmSprintPlanning()
            strGridHTML.Append(objfrmReleasePlanning.PlotSprintListAdd(ReleaseID))
            Return insertSuccess & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Function PlotSprintListAdd(ByVal ReleaseID As String)
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
        Dim drSubstory As IDataReader
        Dim IterationID As String = ""
        Dim IterationName As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim PlannedEffort As String = ""
        Dim ActualEffort As String = ""
        Dim DoListCount As String = ""
        Dim InProgressCount As String = ""
        Dim DoneCount As String = ""
        Dim DiscussionCount As String = ""
        Dim ReviewCount As String = ""
        Dim NoOfDays As String = ""

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

            strHTML.Append("<div class='' >" & vbCrLf)

            strHTML.Append("<div class='col-sm-11'>" & vbCrLf)
            strHTML.Append("<div class='card clsUnmappendSprint sprint_card' id='SprintList_" & IterationID & "'>" & vbCrLf)
            strHTML.Append("<div class='card-header clsUnmappendheader'  >" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
            If CurrentIteration <> False Then
                strHTML.Append("<i class='fa fa-star' aria-hidden='true' style='color:#ffc107 !important' title='Current Sprint' style='margin-left:-31%'></i>")
                'Else

            End If


            'strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
            'strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")

            strHTML.Append("</div>")
        '    /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p class='iteration_name' title='Iteration Name' >" & IterationName & "<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px; background-color:white;font-size: 11.5px!important;'>")
            'strHTML.Append("<p style=' color:#428cf4!important;  font-size: 12px;font-weight: 700;' title='Sprint Name' >" & IterationName & "<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px; background-color:white;font-size: 11.5px!important;'>")
            strHTML.Append("</span></p>" & vbCrLf)
            'End If

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<br/>")
            strHTML.Append("<div class='card-block' style='margin-left:1%'>" & vbCrLf)
            strHTML.Append("<div class='row' style='margin-top:-2%'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
            strHTML.Append(" <p class='iteration_name' title='Iteration ID' >" & IterationID & "</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
            strHTML.Append("  <p class='card-text '  ><i class='fa fa-clock-o'></i><span title='" & StartDate & "  To  " & EndDate & "'></span>" & StartDate & "  To  " & EndDate & "</p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='col-sm-5 clsunmappedAllcounts'>")
            strHTML.Append("<i class='fa fa-bar-chart' aria-hidden='true' style='font-size: 16px;'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            If DiscussionCount <> "" Then
                strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='" & DiscussionCount & "'  onclick=""AfterRelaseSprintSave('div2'," & IterationID & ")""><span class='badge DiscussionCount' style='left:57!immportant;top:10px!immportant;    COLOR: #FFF!IMPORTANT'>" & DiscussionCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                strHTML.Append("<i class='far fa-comments fa-border icon-grey'  title='0' ><span class='badge DiscussionCount' style='left:57!immportant;top:10px!immportant;    COLOR: #FFF!IMPORTANT'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If ReviewCount <> "" Then
                strHTML.Append("<i class=' fa fa-area-chart  fa-border icon-grey' style='width:74px!important;' title='" & ReviewCount & "'><span class='badge reviewCount' style='margin-left: 11%!important; top: -28%!important;    COLOR: #FFF!IMPORTANT'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                strHTML.Append("<i class='	fa fa-area-chart  fa-border icon-grey' title='0'><span class='badge reviewCount' style='margin-left: 11%!important; top: -28%!important;width:7%!important;    COLOR: #FFF!IMPORTANT'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            'strHTML.Append("<i class='fa fa-pencil' aria-hidden='true' style='    font-size: 16px;' onclick=""AfterRelaseSprintSave('Sprint'," & IterationID & ")""></i>&nbsp;&nbsp;&nbsp;&nbsp;")

            IterationStatus = "Delayed"
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
            If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
                If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
                    strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-bs-toggle='Tooltip' data-bs-target='#Remark" & IterationID & "' onclick=""UnmappedSprint(" & IterationID & ", " & ReleaseID & ")""></i>")
                    'Dim objfrmReleasePlanning As New frmReleasePlanning()
                    'strHTML.Append(objfrmReleasePlanning.PlotTerminated(IterationID, ReleaseID))
                End If
            Else
                strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "'></i>")
            End If




            'strHTML.Append("<div class='col-sm-3' style='padding-left:50px;'>" & vbCrLf)

            strHTML.Append("</div>")


            strHTML.Append("<div class='col-sm-2 ClsStatus'>" & vbCrLf)
            If IterationStatus <> "" Then
                strHTML.Append(" <span class='label clsstatus' style='margin-top:-23%;background-color:" & Color & "' title='Sprint Status' >" & IterationStatus & "</span>")
            Else
                strHTML.Append(" <span class='label'  title='Sprint Status'></span>")
            End If

            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            strHTML.Append("<br/>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<hr style='margin-right:30px;'>")
            'strHTML.Append("</div>")
        End While

        If IsRecord = 0 Then
            strHTML.Append("<div class='card DivDetailss' >" & vbCrLf)
            strHTML.Append("<div class='card-header'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            ' /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString()

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckSprintIsMappedOrNot(ByVal strIterationID As String, ByVal strReleaseID As String)
        Try

            Dim strResult As String = CommonFunctions.Data.GetDataScalar("usp_NG2_chk_AllowToTerminateIteration " & strIterationID & "," & strReleaseID, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function TerminateSprint(ByVal strIterationID As String, ByVal strRemark As String, ByVal ReleaseID As String, ByVal Flag As String)
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder("")
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_upd_CancelSprint " & strIterationID & "," & HttpContext.Current.Session("intUserID") & ",'" & strRemark & "'", True), "")
            Dim objfrmReleasePlanning As New frmSprintPlanning()
            strGridHTML.Append(objfrmReleasePlanning.PlotSprintListAdd(ReleaseID))
            'If Flag <> "SprintUnmappedFromRelease" Then
            '    'strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID, ""))
            'Else
            '    strGridHTML.Append(objfrmReleasePlanning.PlotSprintList(ReleaseID))
            'End If

            Return strReleaseName & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''''User Story 

    <System.Web.Services.WebMethod()>
    Public Shared Function AddUserStoryModal(ByVal CategoryID As String)
        Try

            Dim objProduct As New frmSprintPlanning()
            objProduct.GetAccessRights()
            Dim strHTML As New StringBuilder()
            strHTML.Append("<div class='divBody'>")
            strHTML.Append("<div class='modal-header' style='display:block;'>")
            strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal' onclick='RefreshGrid(&quot;New&quot;)'>&times;</button>")
            strHTML.Append(" <h4 class='modal-title'>Create User Story</h4>")
            'If objProduct.m_objAccess.Add Then
            '    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
            'End If

            strHTML.Append("</div>")
            strHTML.Append("<hr />")
            strHTML.Append(objProduct.Form_section("0", CategoryID))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'Added by kashish On 4nd April 2018 For UI change 
            strHTML.Append("<div class='col-md-12 align-center' style='margin-bottom: 20px;text-align:right;'>")
            If objProduct.m_objAccess.Add Then
                strHTML.Append(" <button type='button' class='btn btn-info' onclick='SaveNew_UserStory()' id='addUser' title='' data-bs-toggle='tooltip' data-original-title='Save'>Save</button>")
            End If
            strHTML.Append("</div>")
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'create user story

    'Create User Story

    'Public Function Form_section(ByVal UserStoryId As String, Optional ByVal CategoryID As String = "") As String
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("")
    '    If CategoryID <> "" Then
    '        strCategory = CategoryID
    '    End If
    '    Try
    '        Dim drGetSelectedCheckBoxValue As IDataReader
    '        Dim SelectedCheckbox As String = ""
    '        Dim SelectedCheckboxSplit() As String
    '        Dim str As String = "usp_NG2_GetSelectedUserStoryColumnsForUser " & Session("intUserID") & ""
    '        drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
    '        While drGetSelectedCheckBoxValue.Read()
    '            SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
    '        End While
    '        SelectedCheckboxSplit = SelectedCheckbox.Split(",")


    '        strHTML.Append(" <Div id='frmDetails' class='clsBox'>")
    '        For Each SelectedCheckboxValues As String In SelectedCheckboxSplit
    '            Select Case SelectedCheckboxValues
    '                Case "FunctionalNo"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    Dim projectID As String = Session("intProjectID")
    '                    strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Functional No.</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFunctionalNumber", "txtFunctionalNumber", "form-control", 140, 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "")), False, True), , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "UserStoryName"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>User Story Name</label> ")
    '                    strHTML.Append(" <div class='col-sm-10'>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFeatureName", "txtFeatureName", "form-control", 190, 100, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('txtFeatureName','spanFeatureName')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanFeatureName' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Description"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Description<span class='required'>*</span></label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    Dim len As Integer = 1000
    '                    Dim len1 As Integer
    '                    If strUserDesc.Length <> -1 Then
    '                        len1 = strUserDesc.Length
    '                        len = 1000 - len1
    '                    End If
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , 50, len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownUD,1000)' onKeyUp='javascript:limitText(this,countdownUD, 1000)' onchange=ClearSpan('txtUserDesc','spanUserDesc')", True, EnableHTMLEncode:=True))
    '                    strHTML.Append("<small name='countdownUD' id='countdownUD'  style='border-style:None;float: left;margin-top:-3%;margin-left:100%'>" & len & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanUserDesc' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "BusinessValue"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Business Value</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , 190, , 200, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,200)' onKeyUp='javascript:limitText(this,countdownBU, 200)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))
    '                    strHTML.Append("<small name='countdownBU' Id='countdownBU'  style='border-style:None;float: left;margin-top:-13%;margin-left:100%'>" & (200 - strBusinesValue.Length) & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Priority"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority<span class='required'>*</span></label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", 190, strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("&nbsp;<a id='aPriority'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer' ><i id='iPriorityColor' style='color:" & strPriorityColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                    strHTML.Append("<table class='table' id='tblPriorityColor'>")
    '                    strHTML.Append("<tr>")
    '                    If UserStoryId <> "" Then
    '                        strHTML.Append(GetColorMaster(strPriority, "Priority"))
    '                    End If
    '                    strHTML.Append("</tr>")
    '                    strHTML.Append("</table>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanPriority' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "State"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>State</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", 190, strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanState' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Complexity"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Complexity</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", 190, strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanComplexity' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "Status"
    '                Case "Category"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Category</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID"), 190, strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;' />")
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' title='Add Category' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Category</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddCategory_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='cursor:pointer;width:7%;'>")

    '                        strHTML.Append("<i class='fas fa-times'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Category Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Category&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDCategory", "txtADDCategory", "form-control", 174, , , , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aCateColor' data-bs-toggle='dropdown' title='Select Category Color' style='cursor:pointer' ><i id='oColor' style='color:" & strCategoryColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblCategoryColor'>")
    '                        strHTML.Append("<tr>")
    '                        If UserStoryId <> "" Then
    '                            strHTML.Append(GetColorMaster(strCategory, "Category"))
    '                        End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;'></span>")
    '                Case "Version"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Version</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", 190, strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Version</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddVersion_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<i class='fas fa-times'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDVersion", "txtADDVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iVersion' style=' color:" & strVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblVersionColor'>")
    '                        strHTML.Append("<tr>")
    '                        If UserStoryId <> "" Then
    '                            strHTML.Append(GetColorMaster(strVersion, "Version"))
    '                        End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanVersion' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "CreatedBy"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created By</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(strCreatedBy)
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "CreatedDate"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created Date</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(strCreatedDate)
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                Case "InitialEstimate"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Story Point</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", 190, 100, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanStoryPoint' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "FixedVersion"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Fixed Version</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", 190, strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
    '                    If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then

    '                        strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Fixed Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table id='tblHeader'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Fixed Version</h4>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddFixedVersion_OnClick()'; >ADD</button>&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append("<i class='fas fa-times'></i>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
    '                        strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("<table style='width:300px;height:66px;'>")
    '                        strHTML.Append("<tr>")
    '                        strHTML.Append("<td style='text-align:right'>")
    '                        strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td>")
    '                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDFixedVersion", "txtADDFixedVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                        strHTML.Append("</td>")
    '                        strHTML.Append("<td style='position:relative'>")
    '                        strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iFVersion' style=' color:" & strFixedVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
    '                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
    '                        strHTML.Append("<table class='table' id='tblVersionColor2'>")
    '                        strHTML.Append("<tr>")
    '                        If UserStoryId <> "" Then
    '                            strHTML.Append(GetColorMaster(strVersion, "FVersion"))
    '                        End If
    '                        strHTML.Append("</tr>")
    '                        strHTML.Append("</table>")
    '                        strHTML.Append("</div>")
    '                    End If
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanFixedVersion' style='color: #dd1037; font-size: 12px;' ></span>")
    '                Case "AcceptanceCriteria"
    '                    strHTML.Append(" <div class='row'>")
    '                    strHTML.Append(" <div class='form-group'>")
    '                    strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Acceptance Criteria</label> ")
    '                    strHTML.Append(" <div class='col-sm-10 '>")
    '                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , 190, , 200, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownAC,200)' onKeyUp='javascript:limitText(this,countdownAC, 200)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria')", True, , , , , , , , , True))
    '                    strHTML.Append("<small name='countdownAC' Id='countdownAC'  style='border-style:None;float: left;margin-top:-13%;margin-left:100%'>" & (200 - strAcceptanceCriteria.Length) & "</small>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("</div>")
    '                    strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
    '            End Select
    '        Next

    '        strHTML.Append("<div class='row' style='padding-top:60px;text-align:right;'>")
    '        strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
    '        strHTML.Append("<button type='button' class='btn btn-primary' onclick='SaveNew_UserStory()' title='Save'>Save</button>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("</Div>")


    '    Catch ex As Exception
    '        Return ex.Message
    '    End Try
    '    Return (strHTML.ToString())
    'End Function

    'New code for user story
    Public Function Form_section(ByVal UserStoryId As String, Optional ByVal CategoryID As String = "") As String
        Dim strHTML As New StringBuilder()
        strHTML.Append("")
        If CategoryID <> "" Then
            strCategory = CategoryID
        End If
        Try
            Dim drGetSelectedCheckBoxValue As IDataReader
            Dim SelectedCheckbox As String = ""
            Dim SelectedCheckboxSplit() As String
            Dim str As String = "usp_NG2_GetSelectedUserStoryColumnsForUser " & Session("intUserID") & "," & Session("intProjectID")
            drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
            While drGetSelectedCheckBoxValue.Read()
                SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
            End While
            SelectedCheckboxSplit = SelectedCheckbox.Split(",")


            strHTML.Append("<Div id='frmDetails' class='clsBox'>")
            For Each SelectedCheckboxValues As String In SelectedCheckboxSplit
                Select Case SelectedCheckboxValues
                    Case "FunctionalNo"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Functional No.</label> ")
                        strHTML.Append(" <div class='col-md-8'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFunctionalNumber", "txtFunctionalNumber", "form-control", , 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "")), False, True), , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "UserStoryName"
                        Dim len As Integer = 200
                        Dim len1 As Integer
                        If strFeatureName.Length <> -1 Then
                            len1 = strFeatureName.Length
                            len = 200 - len1
                        End If
                        strHTML.Append(" <div class='form-group'>")   'Added by Ashwini M on 29-3-2023
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls'>User story <span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-10 col-sm-10'>")
                        'added by Dipali V On 24th  april 2018 For Validation
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFeatureName", "txtFeatureName", "form-control", , 100, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('txtFeatureName','spanFeatureName')", True, , , , , , True))
                        'strHTML.Append(" <span class='input-group-addon '>")
                        'strHTML.Append("<span id='spanFeatureName' style='color: #dd1037; font-size: 12px;' ></span>")
                        'strHTML.Append("</span>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , len, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN, 200)'  data-autoresize", True, EnableHTMLEncode:=True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeatureName", "txtFeatureName", , "form-control", , , , , , , len, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdownFN,200)' onKeyUp='javascript:limitText(this,countdownFN, 200)'  data-autoresize", True, EnableHTMLEncode:=True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<small name='countdownFN' Id='countdownFN'> " & len & " </small>")
                        strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
                        'End of added by Dipali V On 24th  april 2018 For Validation
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "Description"
                        strHTML.Append(" <div class='form-group'>")     'Added by Ashwini M on 29-3-2023
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls'>Description <span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-10 col-sm-10'>")
                        Dim len As Integer = 1000
                        Dim len1 As Integer
                        If strUserDesc.Length <> -1 Then
                            len1 = strUserDesc.Length
                            len = 1000 - len1
                        End If
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , , len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<small name='countdown' Id='countdown'>" & len & "</small>")
                        strHTML.Append("<span id='spanUserDesc' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "BusinessValue"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Business Value</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")
                        'added by Dipali V On 24th  april 2018 For Chnage ctrl
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , , , 200, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,200)' onKeyUp='javascript:limitText(this,countdownBU, 200)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))
                        'strHTML.Append(" <span class='input-group-addon '>")
                        'strHTML.Append("<small name='countdownBU' Id='countdownBU'>" & (200 - strBusinesValue.Length) & "</small>")
                        'strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , , , 1000, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,1000)' onKeyUp='javascript:limitText(this,countdownBU, 1000)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", True, , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusinessValue", "txtBusinessValue", "form-control", , 100, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup=ClearSpan('strBusinesValue','strBusinesValue')", True, , , , , , True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
                        'End of added by Dipali V On 24th  april 2018 For  Chnage ctrl
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Priority"
                        strHTML.Append(" <div class='form-group'>") 'Added by Ashwini M On 29-3-2023
                        'added by ashwini on 21-3-2023 for data-bs-toggle
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls'>Priority <span class='required'>*</span> &nbsp;<a id='aPriority'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer' ><i id='iPriorityColor' style='color:" & strPriorityColor & " !important;' class='fa fa-square' aria-hidden='true'></i></a></label> ")
                        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu'>")
                        strHTML.Append("<table class='table' id='tblPriorityColor'>")
                        strHTML.Append("<tr>")
                        If UserStoryId <> "" Then
                            strHTML.Append(GetColorMaster(strPriority, "Priority"))
                        End If
                        strHTML.Append("</tr>")
                        strHTML.Append("</table>")
                        strHTML.Append("</div>")

                        strHTML.Append("<span id='spanPriority' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                    Case "InitialEstimate"
                        'commented by Ashwini M on 29-3-2023
                        'strHTML.Append(" <div class=''>")
                        'End Of commented by Ashwini M On 29-3-2023
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls'>Story Point</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf((strState <> "InActive" And strIterationName = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<span id='spanStoryPoint' style='color: #dd1037; font-size: 12px;' ></span>")
                        'Commented and Added by Usha Pandit on 07 Jun 2018 for notes allignment
                        'strHTML.Append("<span> <p class='note' style='white-space: pre;!important'>[ It is recommended to enter story point in Fibonacci series ]</p></span>")
                        strHTML.Append("<span> <p class='note' style='white-space: pre;!important;float: right;'>[ It is recommended to enter story point in Fibonacci series ]</p></span>")
                        'End of Added by Usha Pandit on 07 Jun 2018 for notes allignment
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        'commented by Ashwini M on 29-3-2023
                        'strHTML.Append("</div>")
                        'End Of commented by Ashwini M On 29-3-2023
                    Case "State"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>State</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanState' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Complexity"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls'>Complexity</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf((strState <> "InActive" And strIterationName = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not

                        strHTML.Append("<span id='spanComplexity' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Status"
                    Case "Category"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Category</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")


                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID"), , strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID"), , strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;' />")
                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append(" <span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' title='Add Category' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Category</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddCategory_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='cursor:pointer;width:7%;'>")

                        '    strHTML.Append("<i class='fas fa-times'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Category Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Category&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDCategory", "txtADDCategory", "form-control", 174, , , , , , IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aCateColor' data-bs-toggle='dropdown' title='Select Category Color' style='cursor:pointer' ><i id='oColor' style='color:" & strCategoryColor & " !important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-bordered' id='tblCategoryColor' style='background:#fff; left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strCategory, "Category"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;'></span>")

                    Case "CreatedBy"
                        strHTML.Append(" <div class='row'>")
                        strHTML.Append(" <div class='form-group'>")
                        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created By</label> ")
                        strHTML.Append(" <div class='col-sm-10 '>")
                        strHTML.Append(strCreatedBy)
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "CreatedDate"
                        strHTML.Append(" <div class='row'>")
                        strHTML.Append(" <div class='form-group'>")
                        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Created Date</label> ")
                        strHTML.Append(" <div class='col-sm-10 '>")
                        strHTML.Append(strCreatedDate)
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Version"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Version</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not

                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append("<span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Version</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddVersion_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<i class='fas fa-times'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDVersion", "txtADDVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iVersion' style=' color:" & strVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-boredered' id='tblVersionColor' style='background:#fff;left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strVersion, "Version"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "FixedVersion"
                        strHTML.Append(" <div class=''>")
                        strHTML.Append(" <label class='col-md-2 col-sm-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Fixed Version</label> ")
                        strHTML.Append(" <div class='col-md-4 col-sm-4'>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", "", "disabled"), True, True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        'If strState <> "InActive" And strIterationName = "" And strIsPrductOwner = 1 Or (strIsPrductOwner <> 1 And UserStoryId = "") Then
                        '    strHTML.Append("<span class='input-group-addon'>")
                        '    strHTML.Append("&nbsp;<a data-bs-toggle='dropdown' data-bs-toggle='tooltip' title='Add Fixed Version' style='cursor:pointer' ><i style='font-size:16px' class='fa fa-plus-circle' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='dropdown-menu category' role='menu'>")
                        '    strHTML.Append("<table id='tblHeader'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<h4 style='font-weight:normal!important;margin-left:6%'>Create New Fixed Version</h4>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<button type='button' id='btnAdd' class='btn btn-block btn-default' onclick= 'AddFixedVersion_OnClick()'; >ADD</button>&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append("<i class='fas fa-times'></i>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("<div style='margin-left:3%; color:#dd4b39'>")
                        '    strHTML.Append("&nbsp; New Version Will available for addition  &nbsp;")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("<table style='width:300px;height:66px;'>")
                        '    strHTML.Append("<tr>")
                        '    strHTML.Append("<td style='text-align:right'>")
                        '    strHTML.Append("Version&nbsp;&nbsp;&nbsp;")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td>")
                        '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtADDFixedVersion", "txtADDFixedVersion", "form-control", 200, , , , , , , , , , True, , , , , , True))
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</td>")
                        '    strHTML.Append("<td style='position:relative'>")
                        '    strHTML.Append("&nbsp;<a id='aVersion' data-bs-toggle='dropdown' title='Select Version Color' style='cursor:pointer' ><i id='iFVersion' style=' color:" & strFixedVersionColor & "!important;font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                        '    strHTML.Append("<div class='cColorDropDown dropdown-menu' role='menu' style='left: unset!important;'>")
                        '    strHTML.Append("<table class='table table-bordered' id='tblVersionColor2' style='background:#fff;left: unset!important;'>")
                        '    strHTML.Append("<tr>")
                        '    If UserStoryId <> "" Then
                        '        strHTML.Append(GetColorMaster(strVersion, "FVersion"))
                        '    End If
                        '    strHTML.Append("</tr>")
                        '    strHTML.Append("</table>")
                        '    strHTML.Append("</div>")
                        '    strHTML.Append("</span>")
                        'End If
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanFixedVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "AcceptanceCriteria"
                        strHTML.Append(" <div class='col-sm-12' style='padding-left: 0px;padding-right: 0px;'>")
                        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;margin-top: 11px;'>Acceptance Criteria</label> ")
                        strHTML.Append(" <div class='col-md-10 '>")

                        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , , , 200, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownAC,200)' onKeyUp='javascript:limitText(this,countdownAC, 200)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria') data-autoresize", True, , , , , , , , , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , , , 1000, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "") Or strIsSprintStarted = "0", False, True), , , "onkeyup='javascript:limitText(this,countdownAC,1000)' onKeyUp='javascript:limitText(this,countdownAC, 1000)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria') data-autoresize", True, , , , , , , , , True))
                        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not


                        strHTML.Append("<small name='countdownAC' Id='countdownAC'>" & (1000 - strAcceptanceCriteria.Length) & "</small>")
                        strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                End Select
            Next

            strHTML.Append("</Div>")


        Catch ex As Exception
            ''Commented & Added By Dipali V on 28th March 2023 For US Model pop Should Display Details
            Return "Bad Request found"
            'End of Commented & Added By Dipali V on 28th March 2023 For US Model pop Should Display Details
        End Try
        'Commented & Added By Dipali V on 28th March 2023 For US Model pop Should Display Details
        'Return "Bad Request found"
        Return strHTML.ToString()
        'End of Commented & Added By Dipali V on 28th March 2023 For US Model pop Should Display Details

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)
        Try

            Dim StrColorQuery As String = ""
            Dim cnt As Integer = 0
            StrColorQuery = "EXEC usp_Ng2_sel_tbl_NG2_ColorMaster"
            Dim intColorID As Integer
            Dim strColor As String
            Dim drGetColorMaster As IDataReader
            Dim strHTML As New StringBuilder
            drGetColorMaster = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            strHTML.Append("<tr>")
            While drGetColorMaster.Read
                cnt = cnt + 1
                intColorID = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("ColorID").ToString, "")
                strColor = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("Color").ToString, "")
                strHTML.Append("<td style='padding:7px!important;'>")
                strHTML.Append("<a onclick=ChangeColor('" & Id & "','" & strColor & "','" & strMode & "') value=" & intColorID & "><i style='cursor:pointer;color:" & strColor & "!important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
                strHTML.Append("</td>")
                If cnt = 10 Then
                    cnt = 0
                    strHTML.Append("</tr>")
                    strHTML.Append("<tr>")
                End If
            End While
            strHTML.Append("</tr>")

            'While drGetColorMaster.Read
            '    intColorID = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("ColorID").ToString, "")
            '    strColor = CommonFunctions.Data.CheckIsDBNull(drGetColorMaster("Color").ToString, "")
            '    strHTML.Append("<td style='padding:7px!important;'>")
            '    strHTML.Append("<a onclick=ChangeColor('" & Id & "','" & strColor & "','" & strMode & "') value=" & intColorID & "><i style='cursor:pointer;color:" & strColor & "!important; font-size:16px' class='fa fa-square' aria-hidden='true'></i></a>")
            '    strHTML.Append("</td>")

            'End While

            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetVersionColor(ByVal versionID As String, ByVal Mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================

        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & versionID & ",'Version'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strCategoryColor As String = ""

            Dim drGetCategoryColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetCategoryColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetCategoryColor.Read
                strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetCategoryColor("Color").ToString, "")
            End While

            Dim strHtml2 As String
            strHtml2 = GetColorMaster(versionID, Mode)
            Return strCategoryColor + "||" + strHtml2
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeColor(ByVal ID As String, ByVal color As String, ByVal mode As String) As String
        '=====================================================================
        ' Procedure  Name		:	ChangeColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   30th-Dec-2016
        '=====================================================================

        If ID <> "" Then
            Dim strQuery As String = "usp_NG2_upd_tbl_NG2_ScrumCategoryVersion " & ID & ",'" & color & "','" & mode & "'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strUpdateColor As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

        End If

        If mode = "Priority" Then
            Return 1
        End If
        If mode = "Category" Then
            Return 2
        End If
        If mode = "Version" Then
            Return 3
        End If
        If mode = "FVersion" Then
            Return 4
        End If

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
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22232, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        strIsPrductOwner = CheckIsProductOwner(CType(Session("intUserID"), Integer))
    End Sub

    Function CheckIsProductOwner(ByVal strUserID As String)


        Dim drGetIsProductOwner As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        Dim strIsPrductOwner As Integer = 0
        StrQuery = "usp_NG2_IsProductOwner " & Session("intProjectID") & "," & strUserID & ""
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetIsProductOwner.Read
            strIsPrductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")

        End While
        Return strIsPrductOwner


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetExistingUniqueNumberFromDB(ByVal objComplexity As String, ByVal Priority As String, ByVal strUserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetExistingUniqueNumberFromDB
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   22-Feb-2017
        '=====================================================================
        Try


            If strUserStoryId = "" Then
                strUserStoryId = "NULL"
            End If
            If strUserStoryId = "NULL" Then
                strUserStoryId = 0
            End If
            Dim StrQuery As String = ""
            ' Dim StrQuery As String = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "'," & strUserStoryId & ""
            'added By Dipali V On 9th may For Sub Us Rank duplication
            If strUserStoryId = 0 Then
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "'," & strUserStoryId & ""
            Else
                StrQuery = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "',NULL," & strUserStoryId & ""
            End If
            'end of added By Dipali V On 9th may For Sub Us Rank duplication



            Dim intUniqueNo As String = ""

            Dim drGetUniqueNo As IDataReader
            Dim strHTML As New StringBuilder
            drGetUniqueNo = CommonFunctions.Data.GetDataReader(StrQuery, True)
            While drGetUniqueNo.Read
                intUniqueNo = CommonFunctions.Data.CheckIsDBNull(drGetUniqueNo("Result").ToString, "")
            End While

            Return intUniqueNo
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    'Commented and Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveSubStories(ByVal UserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String) As String
    '    Dim strSQL As String
    '    Try
    '        strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & UserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
    '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        Return New frmSprintPlanning().PlotSubUserStoryList(UserStoryID)
    '    Catch ex As Exception
    '        '  Return "0"
    '    End Try


    'End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSubStories(ByVal UserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String, ByVal Complexity As String, ByVal Category As String) As String
        Dim strSQL As String

        If Complexity = "" Or Complexity Is Nothing Then
            Complexity = "NULL"
        End If
        If Category = "" Or Category Is Nothing Then
            Category = "NULL"
        End If
        If Complexity = "NULL" Then
            strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & UserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', " & Complexity & ", " & Category
        Else
            strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & UserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "', '" & Complexity & "', " & Category
        End If


        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        Return New frmSprintPlanning().PlotSubUserStoryList(UserStoryID)



    End Function
    'End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUserStory(ByVal strUserStoryId As String, ByVal FunctionalNumber As String, ByVal FeatureName As String, ByVal UserDesc As String, ByVal Priority As String, ByVal Complexity As String, ByVal BusinessValue As String, ByVal State As String, ByVal StoryPoint As String, ByVal Category As String, ByVal Version As String, ByVal IterationName As String, ByVal ReleaseName As String, ByVal FixedVersion As String, ByVal AcceptanceCriteria As String, ByVal UniqueNo As String) As String

        '=====================================================================
        ' Procedure  Name		:	SaveUserStory
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save User Story
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   28th Dec 2016
        '=====================================================================
        Dim insertSuccess As Integer = 0

        Dim strUserID As String = HttpContext.Current.Session("intUserID")
        Dim intProjectId As Integer = HttpContext.Current.Session("intProjectID")
        Dim intProjectTypeId As Integer = HttpContext.Current.Session("ProjectTypeID")
        Dim strUserName As String = HttpContext.Current.Session("strUserName")


        Dim strUniqueID As String
        'Dim strUserStoryId As String

        Try
            If strUserID IsNot Nothing Then
                If strUserStoryId = "" Then
                    strUserStoryId = "NULL"
                End If
                If FunctionalNumber = "" Then
                    FunctionalNumber = "NULL"
                End If
                If BusinessValue = "" Then
                    BusinessValue = "NULL"
                End If
                If State = "" Then
                    State = "NULL"
                End If
                If StoryPoint = "" Then
                    StoryPoint = "NULL"
                End If
                If Category = "" Then
                    Category = "NULL"
                End If
                If Version = "" Then
                    Version = "NULL"
                End If
                If IterationName = "" Then
                    IterationName = "NULL"
                End If
                If ReleaseName = "" Then
                    ReleaseName = "NULL"
                End If
                If FixedVersion = "" Then
                    FixedVersion = "0"
                End If

                'Dim strQuery As String = "usp_NG2_INS_tbl_PM_ScrumUserStory " & strUserStoryId & "," & intProjectId & "," & intProjectTypeId & ",'" & FunctionalNumber.Replace("'", "''") & "','" & FeatureName.Replace("'", "''") & "','" & UserDesc.Replace("'", "''") & "','" & BusinessValue.Replace("'", "''") & "','" & Priority.Replace("'", "''") & "','" & State & "','" & Complexity & "'," & StoryPoint & "," & Category & "," & Version & "," & IterationName & "," & ReleaseName & ",'" & strUserName & "','" & AcceptanceCriteria.Replace("'", "''") & "'," & FixedVersion & ",'" & UniqueNo & "'"
                Dim strQuery As String = "usp_NG2_INS_tbl_PM_ScrumUserStory " & strUserStoryId & "," & intProjectId & ",'" & FunctionalNumber.Replace("'", "''") & "','" & FeatureName.Replace("'", "''") & "','" & UserDesc.Replace("'", "''") & "','" & BusinessValue.Replace("'", "''") & "','" & Priority.Replace("'", "''") & "','" & State & "','" & Complexity & "'," & StoryPoint & "," & Category & "," & Version & "," & IterationName & "," & ReleaseName & ",'" & strUserName & "','" & AcceptanceCriteria.Replace("'", "''") & "'," & FixedVersion & ",'" & UniqueNo & "'"
                strUniqueID = CommonFunctions.Data.GetDataScalar(strQuery, True)
                insertSuccess = strUniqueID
                'If strUserStoryId = "Null" Then
                Return insertSuccess
                'Else
                '    Return RefreshGrid(strUserStoryId)
                'End If

            Else
                Return "Session Expired"
            End If
            Return insertSuccess
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetUserStoryDetails(ByVal UserStoryId As String)
        Try

            Dim strHTML As New StringBuilder()
            Dim frmBackLog As New frmSprintPlanning()
            strHTML.Append("<div id='divUserStories'>")
            'strHTML.Append(frmBackLog.Table_Backlog())
            strHTML.Append("</div>")
            strHTML.Append(frmBackLog.Heading_section(UserStoryId))
            strHTML.Append(frmBackLog.Tab_section())
            strHTML.Append("<div style='overflow:hidden;width:100%'>")   'Added by Usha Pandit on 07 Jun 2018 for hiding scrollbar
            strHTML.Append("<div id='divUserStroryDetails' class='col-sm-12'>")
            strHTML.Append(frmBackLog.Form_section(UserStoryId))
            strHTML.Append(frmBackLog.Substories_section(UserStoryId))
            strHTML.Append(frmBackLog.Attachment_section(UserStoryId))
            strHTML.Append(frmBackLog.Discussion_section(UserStoryId))
            strHTML.Append(frmBackLog.Resource_section(UserStoryId))
            strHTML.Append(frmBackLog.History_section(UserStoryId))
            strHTML.Append(frmBackLog.Issues_section(UserStoryId))
            ''Commented  By Dipali V For  Remove review from sprint planning user story details
            strHTML.Append(frmBackLog.Reviews_section(UserStoryId))
            ''End of Commented  By Dipali V For  Remove review from sprint planning user story details
            strHTML.Append(frmBackLog.Tasks_section(UserStoryId, ""))
            strHTML.Append(frmBackLog.Chart_section(UserStoryId))

            strHTML.Append("</div>")
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Public Function Issues_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()


        'Added By kashish On For UI change
        strHTML.Append("<div id='divIssues' class='clsBox'>")
        'End of Added By kashish On For UI change
        strHTML.Append("<div class=''>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Issues Details</h2>")
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-placement='bottom' data-bs-container='body' onclick=ShowData('Form','subIssue','UserStory')>Add</a></h2>")
        Else

            'Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-right:7%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue','UserStory')>List</a> | <a data-bs-toggle='tooltip' style='cursor:no-drop' title='Issue can not be created as User Story/Sprint get completed/not started.' data-bs-placement='bottom' >Add</a></h2>")
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue','UserStory')>List</a> | <a data-bs-toggle='tooltip' style='cursor:no-drop' title='Issue can not be created as User Story/Sprint get completed/Not started.' data-bs-placement='bottom' data-bs-container='body'>Add</a></h2>")
            'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

        End If
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssuesList", userStoryID, "UserStory"))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")

        strHTML.Append("<Div class='col-sm-12' id='divIssueForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Issue',0) class='fa fa-save'></i>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;text-align:left'>Summary<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", , "form-control", , , , , , , 500, , , , , , , , "onkeyup='javascript:limitText(this,countdownSummary,500)' onKeyUp='javascript:limitText(this,countdownSummary, 500)'onchange=ClearSpan('txtSummary','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownSummary' Id='countdownSummary'  style='border-style:None;'>500</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;text-align:left'>Description<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , 1000, , , , , , , , "onkeyup='javascript:limitText(this,countdownDescription,1000)' onKeyUp='javascript:limitText(this,countdownDescription, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownDescription' Id='countdownDescription'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType", "SELECT ''", , , "onclick=GetSelectedSubtype(this) Class='form-control' style=''", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Sub Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSubIssueType", "SELECT ''", , " form-control", "Class='form-control' ", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")





        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Reported By<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")

        Dim StrReporter As String = HttpContext.Current.Session("intUserID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboreporter", "Select ''", , StrReporter, "form-control", True, True, "form-control style=''")).ToString.Replace("'", "\'")
        strHTML.Append("</div>")
        strHTML.Append("<input type=hidden id=hdnStrReporter value='" & StrReporter & "'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-6'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Status<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboStatus", "Select ''", , " form-control", "Class='form-control' style=''", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")






        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Resonsible Person<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10' style=''>")
        Dim ResponsibleIssue As String = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboResonsible", ResponsibleIssue, , , "Class='form-control' style=''", False, True, , , , ))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return strHTML.ToString


    End Function
    Public Function Reviews_section(ByVal userStoryID As String) As String

        Dim strHTML As New StringBuilder()
        'Added By kashish On For UI change
        strHTML.Append("<div id='divReviews' class='clsBox' style='height:555px!important'>")
        'End of Added By kashish On For UI change

        'strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Reviews Details</h2>")
        ''Commented  By Dipali V For  Remove review from sprint planning user story details
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-container='body' data-bs-placement='bottom' onclick=ShowData('Form','subReview','UserStory')>Add</a></h2>")
        Else
            'Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:0%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Review can not be created as User Story/Sprint get completed/not started.' data-bs-placement='bottom' >Add</a></h2>")
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Review can not be created as User Story/Sprint get completed/Not started.' data-bs-placement='bottom' >Add</a></h2>")
            'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        End If
        ''End of Commented  By Dipali V For  Remove review from sprint planning user story details
        'strHTML.Append("</div>")

        strHTML.Append("<div class=''>")
        strHTML.Append("<Div class='col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", userStoryID, "UserStory"))
        strHTML.Append("</Div>")
        strHTML.Append("</Div>")




        strHTML.Append("<Div class='col-sm-12' id='divReviewForm' style='display:none'>")

        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-bs-toggle='tooltip' style='float:right; ' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Review',0) class='fa fa-save'></i>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Review Title<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewtitle", "txtReviewtitle", "form-control", , 50, , , , , , , , "", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Review Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        Dim StrReviewtype As String = "usp_Sel_tbl_PM_ProjectReviewTypes " & Session("IntProjectID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewtype", StrReviewtype, , , "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>R.Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewStartDate", "txtReviewStartDate", "form-control", , 100, , , , , , , , "autocomplete='off' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float:right; margin-top: -35px;color:#0099CC;' id='#dpreviewstartdate'  onclick=""$('#txtReviewStartDate').datepicker();$('#txtReviewStartDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>R.End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewEnddate", "txtReviewEnddate", "form-control ", , 100, , , , , , , , "autocomplete='off' style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float:right;  margin-top: -35px;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#txtReviewEnddate').datepicker();$('#txtReviewEnddate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Reviewer<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append("<div class='btn-group dropdown' style='float:right;width: 100%;'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewer", "cboReviewer", "form-control ", , 100, Session("strusername"), , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu' style='min-width: 190px!important;'>")



        Dim ReviewerDetailsnew As IDataReader
        Dim strSQL As String = "usp_Sel_tbl_PM_ReviewStatistics_ReviewerList 'ReviewedBy', " & Session("IntProjectID") & ", NULL, NULL,NULL,NULL,Null,'-1',0"
        ReviewerDetailsnew = CommonFunctions.Data.GetDataReader(strSQL, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        Dim ReviwerName As String = ""
        Dim ReviwerID As String = ""
        While ReviewerDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ReviwerName = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("Resource Name").ToString, "")
            ReviwerID = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("EmployeeID").ToString, "")
            strHTML.Append("<li>")
            strHTML.Append("<input type=hidden id='hdnReviwerID" & ReviwerID & "' value='" & ReviwerID & "'>")
            strHTML.Append("<input type='checkbox' id='Reviwer" & ReviwerID & "' value='" & ReviwerName & "' class='k-checkboxcboReviewer' onclick=""SelectReviwer(this," & ReviwerID & ",'" & ReviwerName & "')"">")
            strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ReviwerName & "</label>")
            strHTML.Append("</li>")
            ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

            'strHTML.Append("</li>")

        End While

        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Reviewee<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")

        strHTML.Append("<div class='btn-group dropdown' style='float:right;    width: 100%;'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewee", "cboReviewee", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu'>")


        Dim ReviewDetailsnew As IDataReader
        Dim strSQL1 As String = "usp_Ng2_Sel_CurrentTeamMembers " & Session("IntProjectID") & ""
        ReviewDetailsnew = CommonFunctions.Data.GetDataReader(strSQL1, True)

        Dim ResourceName As String = ""
        Dim ResourceID As String = ""
        While ReviewDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ResourceName = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("UserName").ToString, "")
            ResourceID = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("EmployeeId").ToString, "")
            strHTML.Append("<li>")
            strHTML.Append("<input type=hidden id='hdnresourceID" & ResourceID & "' value='" & ResourceID & "'>")
            strHTML.Append("<input type='checkbox' id='Resource" & ResourceID & "' value='" & ResourceName & "' class='k-checkbox' onclick=""SelectResource(this," & ResourceID & ",'" & ResourceName & "')"">")
            strHTML.Append("<label class='k-checkbox-label' for='eq1' style='margin-left:9%;font-weight:100!important'>" & ResourceName & "</label>")
            strHTML.Append("</li>")
            ' strHTML.Append("<li class='dropdown-item' onclick=SelectResource('User','')>")

            'strHTML.Append("</li>")

        End While

        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboReviewee", strSQL, 190, , "class='form-control' ", True, True))


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Status<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        Dim sqlstatus As String = ""
        sqlstatus = "usp_Sel_tbl_RTS_ProjectSpecificControlData 'ReviewStatus_ADD_NEW'"
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRevieStatus", sqlstatus, , "Open", "class='form-control' ", False, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left;margin-left:0%'>Checklist<span class='required'></span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        Dim sqlChecklist As String = ""
        sqlChecklist = "usp_sel_GetProjectChecklistsAndGroups " & Session("intprojectID")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboChecklist", sqlChecklist, , , "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Work (H:M)<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' style=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewHrs", "txtReviewHrs", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString



    End Function
    'Public Function TasksDetails(ByVal userStoryID As String) As String
    '    Dim strHTML As New StringBuilder()
    '    Dim strSql As String = ""
    '    Dim Restult As String = ""
    '    Dim StrQuery As String = ""
    '    Dim ScrumTaskName As String = ""
    '    Dim Effort As String = ""
    '    Dim AssignedTo As String = ""
    '    Dim TaskID As String = ""
    '    Dim StartDate As String = ""
    '    Dim InitialEstimate As String = ""
    '    Dim TaskStoryPoint As String = ""
    '    Dim EndDate As String = ""
    '    Dim TasksDetailsnew As IDataReader
    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
    '    TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intnewCounter As Integer = 0
    '    Dim IscheckDatahas As Integer = 0
    '    While TasksDetailsnew.Read
    '        intnewCounter += 1
    '        IscheckDatahas = 1
    '        ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("ScrumTaskName").ToString, "")
    '        Effort = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("Effort").ToString, "")
    '        AssignedTo = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EmployeeID").ToString, "")
    '        TaskID = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("TaskID").ToString, "")
    '        InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
    '        StartDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StartDate").ToShortDateString(), "")
    '        EndDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate").ToShortDateString(), "")
    '        'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),
    '        TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")


    '        strHTML.Append("<tr class='trProjectDetailedit'>")
    '        strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' >")
    '        ' strHTML.Append("<A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%;cursor: not-allowed;'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A>")
    '        strHTML.Append("</td>")
    '        strHTML.Append("<Td style='width:20%'>")
    '        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName" & TaskID, "txtTaskName" & TaskID, "form-control", 100, 100, ScrumTaskName, , , True, , , , "  PlaceHolder='Task Name'", True, , , , , , True))
    '        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))


    '        strHTML.Append("<td style='width:15%'>")
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate" & TaskID, "txtStartDate" & TaskID, "form-control", 100, 100, StartDate, , , True, , , , " PlaceHolder='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
    '        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float: right;margin-top: -31px!important;color:#0099CC;' id='#dpstartdate" & TaskID & "' disabled></i>")
    '        strHTML.Append("</td>")


    '        'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
    '        'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
    '        'strHTML.Append("</td>")
    '        strHTML.Append("<td style='width:15%'>")
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate" & TaskID, "txtEndDate" & TaskID, "form-control", 190, 100, EndDate, , , True, , , , " PlaceHolder='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
    '        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float: right;margin-top: -16%!important;margin-right:32%!important;color:#0099CC;'  id='#dpEnddate" & TaskID & "' disabled></i>")
    '        strHTML.Append("</td>")

    '        strHTML.Append("<td style='width:13%'>")
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control", , , Effort, "Center", , True, , , , "style='text-align:center!important' PlaceHolder='Work Hrs' maxlength=4", True, , , , , , True))
    '        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")

    '        strHTML.Append("</td>")

    '        strHTML.Append("<td style='width:13%'>")
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints" & TaskID, "txtStoryPoints" & TaskID, "form-control", , , TaskStoryPoint, "Center", , , , , , "style='text-align:center!important' PlaceHolder='Story Pts' maxlength=4", True, , , , , , True))
    '        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")

    '        strHTML.Append("</td>")

    '        strHTML.Append("<td style='width:23%'>")
    '        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource" & TaskID, "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 120, AssignedTo, "class='form-control' style='margin-left:12%!Important;width:76%!Important' disabled", True, True, , , , True))
    '        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
    '        strHTML.Append("</td>")

    '        Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasks  " & Session("IntProjectId") & "," & TaskID & ""
    '        Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))

    '        strHTML.Append("<td style='width:3%;text-align:center'>")
    '        If TaskID <> "" Then
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & "," & TaskID & ")'></i>")

    '        Else
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
    '        End If

    '        strHTML.Append("</td>")



    '        strHTML.Append("<td style='width:3%;text-align:center'>")
    '        If Restult = "1" Then
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'  onclick='DeleteTask(" & userStoryID & "," & TaskID & ")' title='Delete Task' class='fa fa-trash' ></i>") '
    '        Else
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='you do not have access to delete Task' class='fa fa-trash' onclick='DeleteTask(" & userStoryID & "," & TaskID & ")' disabled></i>") '
    '        End If
    '        strHTML.Append("</td>")


    '        strHTML.Append("<td style='width:3%;text-align:center;'  id='Update" & TaskID & "'>")
    '        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
    '        If strAddLinkAccess = "1" Then
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
    '        Else
    '            strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='Map Relase and Sprint to Update task ' class='fa fa-save'></i>")

    '        End If
    '        'strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
    '        strHTML.Append("</td>")
    '        'strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
    '        'strHTML.Append("<i id='spanWorkHrs0' data-bs-toggle='tooltip' style='display:none;' title='Error Details' data-bs-toggle='popover' data-bs-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
    '        'strHTML.Append("</td>")
    '        'strHTML.Append("<td>")
    '        'strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
    '        'strHTML.Append("</td>")
    '        strHTML.Append("</tr>")
    '    End While





    '    Return strHTML.ToString
    'End Function

    Public Function TasksDetails(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""
        Dim Restult As String = ""
        Dim StrQuery As String = ""
        Dim ScrumTaskName As String = ""
        Dim Effort As String = ""
        Dim AssignedTo As String = ""
        Dim TaskID As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim TasksDetailsnew As IDataReader
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
        TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim InitialEstimate As String = ""
        Dim TaskStoryPoint As String = ""
        Dim Tasktype As String = ""
        Dim IscheckDatahas As Integer = 0
        While TasksDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("ScrumTaskName").ToString, "")
            Effort = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("Effort").ToString, "")

            'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            Effort = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("HMEffort").ToString, "")
            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            AssignedTo = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EmployeeID").ToString, "")
            TaskID = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("TaskID").ToString, "")
            InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
            Tasktype = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EntityTypeID").ToString, "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StartDate").ToShortDateString(), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate").ToShortDateString(), "")
            'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),
            TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")

            'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),


            strHTML.Append("<tr class='trProjectDetailedit'>")
            strHTML.Append("<td>")
            ' strHTML.Append("<A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%;cursor: not-allowed;'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A>")
            strHTML.Append("</td>")
            strHTML.Append("<td>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='d-inline-block'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='Task Name -  " & ScrumTaskName & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName" & TaskID, "txtTaskName" & TaskID, "form-control tooltip-inline", 90, 255, ScrumTaskName, , , True, , , , "  PlaceHolder='Task Name' ", True, , , , , , True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
            strHTML.Append("</td>&nbsp;&nbsp;")

            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='d-inline-block'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='Start Date  -  " & StartDate & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate" & TaskID, "txtStartDate" & TaskID, "form-control tooltip-inline", 90, 100, StartDate, , , True, , , , " style='margin-left: 9px!important;' PlaceHolder='Start Date'  onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' id='#dpstartdate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>&nbsp;&nbsp;")


            'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='d-inline-block' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();'title='End Date  -  " & EndDate & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate" & TaskID, "txtEndDate" & TaskID, "form-control tooltip-inline", 90, 100, EndDate, , , True, , , , " style='margin-left:9px!important;' PlaceHolder='End Date'  onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' id='#dpEnddate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>&nbsp;&nbsp;")

            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing

            'Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
            Dim strBeforeDecimal As String = ""
            Dim strDecimal As String = ""

            strBeforeDecimal = Effort.Substring(0, Effort.IndexOf(":"))
            If strBeforeDecimal.Length = 1 Then
                strBeforeDecimal = "0" + strBeforeDecimal
            End If
            strDecimal = Effort.Substring(Effort.IndexOf(":") + 1, 2)
            Effort = strBeforeDecimal + ":" + strDecimal
            'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

            strHTML.Append(" <span class='d-inline-block'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='Work Hrs  -  " & Effort & "'>")

            'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control tooltip-inline", 90, , Effort, "Center", , True, , , , "style='text-align:center!important' PlaceHolder='Work Hrs'  maxlength=4", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control tooltip-inline", 90, , Effort, "Center", , True, , , , "style='text-align:center!important' PlaceHolder='Work (H:M)'  maxlength=8", True, , , , , , True))
            'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>&nbsp;&nbsp;")


            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='d-inline-block' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'onmouseover='$(this).tooltip();' title='Story Pts -  " & TaskStoryPoint & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints" & TaskID, "txtStoryPoints" & TaskID, "form-control tooltip-inline", 90, 3, TaskStoryPoint, "Center", , True, , , , "style='text-align:center!important;margin-left:9px!important' PlaceHolder='Story Pts'  maxlength=4", True, , , , , , True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            ' strHTML.Append("<input type=hidden id=hdnInitialEstimate value='" & InitialEstimate & "'>")
            'strHTML.Append("<input type=hidden id=hdnSumEfforts value='" & SumEfforts & "'>")
            strHTML.Append("</td>&nbsp;&nbsp;")

            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='tooltip_span'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'onmouseover='$(this).tooltip();' title='Task Type -  " & Tasktype & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType" & TaskID, "usp_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 104, Tasktype, "class='form-control' style='width: 105px;margin-left:9px!important;'  disabled", True, True, , , , ))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>&nbsp;&nbsp;")

            strHTML.Append("<td>")
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" <span class='tooltip_span_resource'  data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'onmouseover='$(this).tooltip();' title='Resource Name -  " & AssignedTo & "'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource" & TaskID, "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 135, AssignedTo, "class='form-control' style='margin-left: 10px;width: 130px;margin-left:9px!important;'   disabled", True, True, , , , True))
            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append(" </span>")
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")

            strHTML.Append("</td>&nbsp;&nbsp;")

            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasks  " & Session("IntProjectId") & "," & TaskID & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))
            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))

            'Added By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append("<td style='width:9%;text-align:right;'id='Update" & TaskID & "'>")
            'commented By  Dipali V On 27th July 2020 For Restirct Save & Edit Task From Agile
            'Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            If strAddLinkAccess = "1" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='top'   data-bs-container='body' id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip'  title='Save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task', " & TaskID & ")"" disabled></i>|")

            Else

                'Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
                'strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='top' data-bs-container='body'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip'  class='fa fa-save'  style='cursor:no-drop'  title='Task can not be saved as User Story/ Sprint is completed/Not started.'></i>|")
                strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='top' data-bs-container='body'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip'  class='fa fa-save'  style='cursor:no-drop'  title='Task can not be saved as User Story/ Sprint is completed/Not started.'></i>|")
                'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

            End If
            'Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            'End of commented By  Dipali V On 27th July 2020 For Restirct Save & Edit Task From Agile
            strHTML.Append("</td>&nbsp;&nbsp;")




            strHTML.Append("<td style='width:4%;text-align:center'>")
            'commented By  Dipali V On 27th July 2020 For Restirct Save & Edit Task From Agile
            'Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            If strAddLinkAccess = "1" Then
                If TaskID <> "" Then
                    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='top'  data-bs-container='body'id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & "," & TaskID & ")'></i>|")

                Else
                    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='top' data-bs-container='body' id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)'></i>|")
                End If
            Else
                'Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
                'strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='top'  data-bs-container='body' id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' class='fa fa-pencil' ></i>|")
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='top'  data-bs-container='body' id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' class='fas fa-pencil-alt' ></i>|")
                'End of Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

            End If
            'Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            'End of commented By  Dipali V On 27th July 2020 For Restirct Save & Edit Task From Agile
            strHTML.Append("</td>&nbsp;&nbsp;")


            strHTML.Append("<td style='width:3%;'  >")

            If strAddLinkAccess = "1" Then
                If Restult = "1" Then
                    strHTML.Append("<i class='fa fa-trash' style='font-size:14px!important;text-align:center;color:red' data-bs-container='body' data-bs-placement='top' data-bs-toggle='tooltip' id='iddelete" & TaskID & "'  title='Delete Task'  onclick=""DeleteTask(" & userStoryID & "," & TaskID & ")""></i>")
                Else

                    'Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
                    'strHTML.Append("<i class='fa fa-trash' style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-container='body' data-bs-placement='top' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  ></i>")
                    strHTML.Append("<i class='fa fa-trash' style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-container='body' data-bs-placement='top' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  ></i>")
                    'End of Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

                End If

            Else

                'Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
                'strHTML.Append("<i class='fa fa-trash' style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-container='body' data-bs-placement='top' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  ></i>")
                strHTML.Append("<i class='fa fa-trash' style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-container='body' data-bs-placement='top' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  ></i>")
                'End of Added by Usha Pandit on 17 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated

            End If

            strHTML.Append("</td>&nbsp;&nbsp;")

            'End ofAdded By Kashish on 24 july 2018 for task detail  issue fixing

            'commented By Kashish on 24 july 2018 for task detail  issue fixing

            'strHTML.Append("<td style='width:9%;text-align:right'>")
            'If strAddLinkAccess = "1" Then
            '    If TaskID <> "" Then
            '        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & "," & TaskID & ")'></i>")

            '    Else
            '        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
            '    End If
            'Else
            '    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-placement='bottom'  id='idEdit" & TaskID & "' data-bs-toggle='tooltip' title='Task can not be edited as User Story/ Sprint is completed/Not started.' class='fa fa-pencil' disabled></i>")
            'End If


            'strHTML.Append("</td>&nbsp;&nbsp;")



            'strHTML.Append("<td style='width:3%;text-align:center'>")
            'If strAddLinkAccess = "1" Then
            '    If TaskID <> "" Then
            '        If Restult = "1" Then
            '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'  title='Delete Task' class='fa fa-trash' onclick='DeleteTask(" & userStoryID & "," & TaskID & ")'></i>")
            '        Else
            '            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  disabled></i>")
            '        End If
            '    Else
            '        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  disabled></i>")
            '    End If

            'Else

            '    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete" & TaskID & "'   title='Task can not be deleted as User Story/ Sprint is completed/Not started.' class='fa fa-trash'  disabled></i>")

            'End If

            'strHTML.Append("</td>&nbsp;&nbsp;")


            'strHTML.Append("<td style='width:3%;text-align:center;'  id='Update" & TaskID & "'>")
            'If strAddLinkAccess = "1" Then
            '    strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task', " & TaskID & ")""></i>")

            'Else
            '    strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-bs-toggle='tooltip' class='fa fa-save'  style='cursor:no-drop'  title='Task can not be saved as User Story/ Sprint is completed/Not started.'></i>")

            'End If

            'strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanWorkHrs0' data-bs-toggle='tooltip' style='display:none;' title='Error Details' data-bs-toggle='popover' data-bs-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            'strHTML.Append("<td>")
            'strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
            'strHTML.Append("</td>")

            'End ofcommented By Kashish on 24 july 2018 for task detail  issue fixing
            strHTML.Append("</tr>")
        End While





        Return strHTML.ToString


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
            StoryPoints = AssignTaskData(0)("StoryPoints")
        Catch ex As Exception
            temp = 1
        End Try


        If StoryPoints = 0 Then
            StoryPoints = "NULL"
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

            ''Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 
            If WorkHrs = "0" Or WorkHrs = "" Then
                WorkHrs = "00:00"
            End If

            If WorkHrs.IndexOf(":") = WorkHrs.Length - 1 Then
                WorkHrs = WorkHrs + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = WorkHrs.Substring(0, WorkHrs.IndexOf(":"))
            strDecimal = WorkHrs.Substring(WorkHrs.IndexOf(":") + 1, 2)
            WorkHrs = strBeforeDecimal + ":" + strDecimal
            ''End of Added By Usha Pandit on 15-Mar-2019 Purpose::Project Work field level changes 

            ''Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 
            WorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHrs + "',2)", True)
            ''End of Added By Usha Pandit on 04-Mar-2019 Purpose::Project Work field level changes 

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
                        'm_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                        Dim strData As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
                        If strData = "" Then
                            m_strTaskIDList = ""
                        Else
                            m_strTaskIDList &= strData & ", "
                        End If
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
                'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_strTaskIDList, CType(HttpContext.Current.Session("intProjectID"), String))
                'CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                If Not m_strTaskIDList = "" Then
                    Try
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_strTaskIDList, CType(HttpContext.Current.Session("intProjectID"), String))
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    Catch ex As Exception

                    End Try
                End If
                'End If
            End If
        End If

        Return ""


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveTask(ByVal AssignTaskData As Object, ByVal UserStoryId As String) As String
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

            Dim objfrmSprintPlanning As New frmSprintPlanning()
            Dim strReturnHTML As New StringBuilder("")

            strReturnHTML.Append(objfrmSprintPlanning.SaveTaskDetails(AssignTaskData))

            Return New frmSprintPlanning().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try

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
    'Public Function Tasks_section(ByVal userStoryID As String, ByVal Flag As String) As String
    '    Dim strHTML As New StringBuilder()
    '    Dim TasksDetailsnew As IDataReader
    '    Dim StrQuery As String = ""
    '    Dim InitialEstimate As String = ""
    '    Dim TaskStoryPoint As String = ""
    '    Dim SumEfforts As String = ""
    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
    '    TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intnewCounter As Integer = 0
    '    Dim IscheckDatahas As Integer = 0
    '    While TasksDetailsnew.Read
    '        InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
    '        SumEfforts = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("SumEfforts").ToString, "")
    '        TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")
    '    End While
    '    'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),
    '    Dim strSql As String = ""
    '    If Flag <> "aftersave" Then
    '        'Added By kashish On For UI change
    '        strHTML.Append("<div id='divTasksUS' class='clsBox' style='margin-left:5%'>")
    '        'End of Added By kashish On For UI change
    '    End If
    '    Dim TaskID As String = "0"
    '    strHTML.Append("<div class='row'>")
    '    strHTML.Append("<P>Tasks Details</p>")
    '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a onclick=ShowData('List','subTask')>List</a> | <a onclick=ShowData('Form','subTask')>Add</a></h2>")
    '    strHTML.Append("</div>")


    '    strHTML.Append("<div class='row'>")
    '    strHTML.Append("<Div class='col-sm-12' id='divTaskList'>")
    '    'strHTML.Append(WriteGrid("TaskList", userStoryID))
    '    strHTML.Append("<table id='tblProjectDetail' style='Width:100%;'>")
    '    strHTML.Append("<tbody>")

    '    strHTML.Append(TasksDetails(userStoryID))


    '    strHTML.Append("<tr class='trProjectDetail'>")
    '    'If InitialEstimate < SumEfforts Then
    '    '    strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' data-bs-placement='right' title='The sum of tasks was greater that Story point of User Story'></i></A></td>")
    '    'Else
    '    strHTML.Append("<td style='Width:4%;text-align:left;vertical-align:bottom' ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A></td>")

    '    ' End If

    '    strHTML.Append("<Td style='width:20%'>")
    '    ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName0", "txtTaskName0", "form-control", 100, 100, , , , , , , , "  PlaceHolder='Task Name'", True, , , , , , True))
    '    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
    '    strHTML.Append("<input type=hidden name='hdrownumber' value='0' /></Td>")

    '    strHTML.Append("<td style='width:15%'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate0", "txtStartDate0", "form-control", 100, 100, , , , , , , , " PlaceHolder='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
    '    strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float: right;margin-top: -31px!important;color:#0099CC;' id='#dpstartdate0'  onclick=""$('#txtStartDate0').datepicker();$('#txtStartDate0').datepicker('show');""></i>")
    '    strHTML.Append("</td>")


    '    'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
    '    'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
    '    'strHTML.Append("</td>")
    '    strHTML.Append("<td style='width:15%'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate0", "txtEndDate0", "form-control", 100, 100, , , , , , , , " PlaceHolder='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
    '    strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float: right;margin-top: -16%!important;margin-right:32%!important;color:#0099CC;' id='#dpEnddate0'  onclick=""$('#txtEndDate0').datepicker();$('#txtEndDate0').datepicker('show');""></i>")
    '    strHTML.Append("</td>")

    '    strHTML.Append("<td style='width:13%'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", , , , , , False, , , , "PlaceHolder='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') maxlength=4", True, , , , , , True))
    '    strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
    '    strHTML.Append("</td>")


    '    strHTML.Append("<td style='width:13%'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints0", "txtStoryPoints0", "form-control", , , , "Center", , , , , , "style='text-align:center!important' PlaceHolder='Story Pts' maxlength=4", True, , , , , , True))
    '    strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
    '    strHTML.Append("<input type=hidden id=hdnInitialEstimate value='" & InitialEstimate & "'>")
    '    strHTML.Append("<input type=hidden id=hdnSumEfforts value='" & SumEfforts & "'>")
    '    strHTML.Append("</td>")


    '    strHTML.Append("<td style='width:23%'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 104, , "class='form-control' style='margin-left:12%!Important;width:76%!Important'", True, True, , , , ))
    '    strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
    '    strHTML.Append("</td>")


    '    strHTML.Append("<td style='width:3%;text-align:center'>")
    '    If TaskID = "0" Then
    '        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-bs-placement='bottom'  id='idEdit0' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
    '    Else
    '        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-bs-placement='bottom' id='idEdit0' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask(" & userStoryID & ",0)'></i>")
    '    End If
    '    strHTML.Append("</td>")


    '    strHTML.Append("<td style='width:3%;text-align:center'>")
    '    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete0' title='Delete Task' class='fa fa-trash' ></i>") 'onclick='DeleteTask()'
    '    strHTML.Append("</td>")


    '    strHTML.Append("<td style='width:3%;text-align:center;'>")
    '    'If InitialEstimate < SumEfforts Then
    '    '    strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='The sum of tasks was greater that Story point of User Story' class='fa fa-save'></i>")
    '    'Else
    '    Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
    '    ' If strAddLinkAccess = "1" Then
    '    strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
    '    ' Else
    '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Review' data-bs-placement='bottom' >Add</a></h2>")
    '    ' strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Task' class='fa fa-save' ></i>")

    '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
    '    'End If
    '    'End If

    '    strHTML.Append("</td>")

    '    strHTML.Append("<td>")
    '    strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
    '    strHTML.Append("</td>")
    '    strHTML.Append("</tr>")
    '    strHTML.Append("</tbody>")
    '    strHTML.Append("</table>")



    '    strHTML.Append("</Div>")
    '    strHTML.Append("</div>")

    '    'strHTML.Append("<Div class='col-sm-12' id='divTaskForm' style='display:none'>")
    '    'strHTML.Append(" <div class='col-sm-12 '>")
    '    'strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save' onclick=Save_SubTab_Data(" & userStoryID & ",'Task') class='fa fa-save'></i>")
    '    'strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='row'>") '1ST
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Task Name</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 140, 100, , , , , , , , "", True, , , , , , True))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-12'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Task Name<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 140, 100, , , , , , , , "", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")


    '    ''strHTML.Append(" <div class='row'>") '1ST
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Description</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptiontask", "txtDescriptiontask", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdowntxtDescriptiontask,1000)' onKeyUp='javascript:limitText(this,countdowntxtDescriptiontask, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
    '    ''strHTML.Append("<small name='countdowntxtDescriptiontask' Id='countdowntxtDescriptiontask'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-12'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Description<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:73%;margin-left:-11%'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptiontask", "txtDescriptiontask", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdowntxtDescriptiontask,1000)' onKeyUp='javascript:limitText(this,countdowntxtDescriptiontask, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
    '    'strHTML.Append("<small name='countdowntxtDescriptiontask' Id='countdowntxtDescriptiontask'  style='border-style:None;float: left;margin-top:0%;margin-left:100%'>1000</small>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")


    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Start Date<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("<div class=''>")
    '    'strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate'  onclick=""$('#txtStartDate').datepicker();$('#txtStartDate').datepicker('show');""></i>")
    '    ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group SecControl' >")
    '    'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='margin-left:4%'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEnddate", "txtEnddate", "form-control ", 203, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("<div class=''>")
    '    'strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style=' margin-top: 12px;margin-left:42%;color:#0099CC;' id='#dpEnddate'  onclick=""$('#txtEnddate').datepicker();$('#txtEnddate').datepicker('show');""></i>")
    '    ''strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")



    '    ''strHTML.Append(" <div class='row'>") '1nd
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Assign To</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")


    '    ''strHTML.Append(" <div class='row'>") '1nd
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority	</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrioritytask", "usp_NG2_Sel_tbl_IB_Priorities", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")




    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group SecControl' >")
    '    'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Assign To<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='margin-left:8%'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 190, , "class='form-control' ", True, True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Priority<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrioritytask", "usp_NG2_Sel_tbl_IB_Priorities", 190, , "class='form-control' ", True, True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")


    '    ''strHTML.Append(" <div class='row'>") '3rd
    '    ''strHTML.Append(" <div class='form-group'>")

    '    ''strHTML.Append(" <div class='col-sm-3 '  style='Margin-left:7%!important'  id='group11'>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;  margin-left:10%!important;'>Work (hrs)</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-3 ' id='group'>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", "form-control", 130, 100, , , , , , , , "style='width:130px!important'", True, , , , , , True))
    '    ''strHTML.Append("</div>")

    '    ''strHTML.Append(" <div class='col-sm-3 ' style='Margin-left:-6%!important' id='group1'>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Story Points</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-3 ' style='Margin-left:-1%!important'  id='group2'>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 130, 100, , , , , , , , "style='width:130px!important'", True, , , , , , True))
    '    ''strHTML.Append("</div>")

    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Work (hrs)<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWork", "txtWork", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtWork','spantxtWork')", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group SecControl' >")
    '    'strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Story Points<span class='required'></span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='margin-left:9%'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 190, 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtStoryPoints','spantxtStoryPoints')", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    ''strHTML.Append(" <div class='row'>") '1nd
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Start Date</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")



    '    ''strHTML.Append(" <div class='row'>") '1nd
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>End Date</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")





    '    'strHTML.Append(" <div class='form-row'>")
    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group '>")
    '    'strHTML.Append(" <label class='col-md-3 control-label' style='white-space: nowrap;text-align:left'>Task Type<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3' style='width:66% '>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTtypetask", "usp_Ng2_Sel_tbl_PM_Project_TaskTypes_Names  " & Session("intprojectID") & "", 190, , "class='form-control'", True, True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append(" <div class='col-md-6'>")
    '    'strHTML.Append(" <div class='form-group SecControl' >")
    '    ''strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Story Points<span class='required'>*</span></label> ")
    '    'strHTML.Append(" <div class='col-md-3'>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints", "txtStoryPoints", "form-control", 190, 100, , , , , , , , "onkeyup=ClearSpan('txtStoryPoints','spantxtStoryPoints')", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")

    '    'strHTML.Append("</div>")






    '    ''strHTML.Append(" <div class='row'>") '1nd
    '    ''strHTML.Append(" <div class='form-group'>")
    '    ''strHTML.Append(" <div class='col-sm-4 '>")
    '    ''strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Story</label> ")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append(" <div class='col-sm-8 '>")
    '    ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUserStorytask", "Usp_Ng2_Sel_tbl_PM_ScrumUserStory_AssignTasks " & Session("intprojectID") & "", , userStoryID, "onChange=UserStoryID_OnChange(value) disabled", True, True, "form-control", , , , ))
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")
    '    ''strHTML.Append("</div>")


    '    ''strHTML.Append("</div>")
    '    'strHTML.Append("</div>")


    '    If Flag <> "aftersave" Then
    '        strHTML.Append("</div>")
    '    End If

    '    Return strHTML.ToString
    'End Function


    Public Function Tasks_section(ByVal userStoryID As String, ByVal Flag As String) As String

        Dim strHTML As New StringBuilder()

        Dim TasksDetailsnew As IDataReader
        Dim StrQuery As String = ""
        Dim InitialEstimate As String = ""
        Dim TaskStoryPoint As String = ""
        Dim SumEfforts As String = ""
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & userStoryID & ",'UserStory'"
        TasksDetailsnew = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        While TasksDetailsnew.Read
            InitialEstimate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("InitialEstimate").ToString, "")
            SumEfforts = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("SumEfforts").ToString, "")
            TaskStoryPoint = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StoryPoint").ToString, "")
        End While
        Dim strSql As String = ""
        If Flag <> "aftersave" Then
            'Added By kashish On For UI change
            strHTML.Append("<div id='divTasksUS' class='clsBox' style=''>")
            'End of Added By kashish On For UI change
        End If
        Dim TaskID As String = "0"
        strHTML.Append("<div class=''>")
        strHTML.Append("<p class='clsDiscussion clsDiscussion_border_bottom'>Tasks Details</p>")

        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            'Commented & Added By Dipali V On 25th June 2020 For Issue ID 25269
            'Uncommented And Commented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            strHTML.Append("<h2 style='text-align:right;padding:4px;border-bottom: 1px solid #ddd;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subTask','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Form View' data-bs-container='body' data-bs-placement='bottom' onclick=ShowData('Form','subTask','UserStory')>Add</a></h2>")
            'strHTML.Append("<h2 style='text-align:right;padding:4px;border-bottom: 1px solid #ddd;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subTask','UserStory')>List</a></h2>")
            'End Of Commented By Usha Pandit On 18.05.2021 For plotting Add link For agile project
            'End of Commented & Added By Dipali V On 25th June 2020 For Issue ID 25269
        Else
            'Commented & Added By Dipali V On 25th June 2020 For Issue ID 25269
            'Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'strHTML.Append("<h2 style='text-align:right;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subTask','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Task can not be created as User Story/Sprint is completed/not started.' data-bs-placement='bottom' >Add</a></h2>")
            'Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            strHTML.Append("<h2 style='text-align:right;padding:4px;border-bottom: 1px solid #ddd;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subTask','UserStory')>List</a> | <a data-bs-toggle='tooltip' title='Task can not be created as User Story/Sprint is completed/Not started.' data-bs-placement='bottom' >Add</a></h2>")
            'End Of Uncommented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'Commented And Commented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            'strHTML.Append("<h2 style='text-align:right;padding:4px;border-bottom: 1px solid #ddd;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subTask','UserStory')>List</a> </h2>")
            'End Of Commented And Commented By Usha Pandit On 18.05.2021 For plotting Add link for agile project
            'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'End of Commented & Added By Dipali V On 25th June 2020 For Issue ID 25269
        End If
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-11' id='divTaskList11'>") 'Added by Poonam S on 23/8/2018 for refresh grid
        'end of Poonam S on 23/8/2018 for refresh grid
        strHTML.Append("<table id='tblProjectDetail' style='Width:100%;'>")
        strHTML.Append("<tbody>")

        strHTML.Append(TasksDetails(userStoryID))

        strHTML.Append("<tr class='trProjectDetail'>")
        strHTML.Append("<td  ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;'  data-bs-toggle='tooltip' data-bs-placement='right' title='Click here to add new record'></i></A></td>")

        strHTML.Append("<td >")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName0", "txtTaskName0", "form-control tooltip-inline", , 255, , , , , , , , "  PlaceHolder='Task Name' data-bs-toggle='tooltip' data-bs-placement='top'  data-bs-container='body' onmouseover='$(this).tooltip();' title='Task Name'", True, , , , , , True))
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
        strHTML.Append("<input type=hidden name='hdrownumber' value='0' /></td>&nbsp;&nbsp;")

        strHTML.Append("<td>")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate0", "txtStartDate0", "form-control tooltip-inline", , 100, , , , , , , , "style='width:87%!important' PlaceHolder='Start Date' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'title='Start Date' onmouseover='$(this).tooltip();' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true'  onclick=""$('#txtStartDate0').datepicker();$('#txtStartDate0').datepicker('show');""></i>")
        strHTML.Append("</td>&nbsp;&nbsp;")


        'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
        'strHTML.Append("<i id='spanStartDate0' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
        'strHTML.Append("</td>")
        strHTML.Append("<td>")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate0", "txtEndDate0", "form-control tooltip-inline", , 100, , , , , , , , "style='width:87%!important' PlaceHolder='End Date' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' id='#dpEnddate0'  onclick=""$('#txtEndDate0').datepicker();$('#txtEndDate0').datepicker('show');""></i>")
        strHTML.Append("</td>&nbsp;&nbsp;")





        strHTML.Append("<td >")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing

        'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control tooltip-inline", , , , , , False, , , , "PlaceHolder='Work Hrs' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') maxlength=4", True, , , , , , True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control tooltip-inline", , , , , , False, , , , "PlaceHolder='Work Hrs' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();' title='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') maxlength=8", True, , , , , , True))
        'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>&nbsp;&nbsp;")



        strHTML.Append("<td>")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoints0", "txtStoryPoints0", "form-control tooltip-inline", , 3, , "Center", , , , , , "style='text-align:center!important' PlaceHolder='Story Pts' data-bs-toggle='tooltip'data-bs-container='body' data-bs-placement='top' onmouseover='$(this).tooltip();'title='Story Pts' maxlength=4", True, , , , , , True))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("<input type=hidden id=hdnInitialEstimate value='" & InitialEstimate & "'>")
        strHTML.Append("<input type=hidden id=hdnSumEfforts value='" & SumEfforts & "'>")
        strHTML.Append("</td>&nbsp;&nbsp;")

        strHTML.Append("<td>")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType0", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", 104, , "class='form-control' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' onmouseover='$(this).tooltip();'title='Task Type' style=''", False, True, , , , ))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")

        strHTML.Append("<td>")
        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_NG2_Sel_tbl_PM_ProjectEmployees " & Session("intprojectID") & "", 104, , "class='form-control' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body'title='Resource'  onmouseover='$(this).tooltip();'style=''", False, True, , , , ))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")



        'Added By Kashish on 24 july 2018 for task detail  issue fixing
        strHTML.Append("<td style='width:9%;text-align:right'>")

        'strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
        strAddLinkAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))

        If strAddLinkAccess = "1" Then
            'Commented By Dipali v On 25th June 2020 For Issue Id 25569
            'Uncommented By Usha Pandit On 19.05.2021 For plotting Add link for agile project
            strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='top' data-bs-container='body' id='SaveBtn0' data-bs-toggle='tooltip' title='Save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task',0)""></i>")
            'End Of Uncommented By Usha Pandit On 19.05.2021 For plotting Add link for agile project
            'End Commented By Dipali v On 25th June 2020 For Issue Id 25569
        Else
            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Task' data-bs-placement='bottom' >Add</a></h2>")
            'Commented By Dipali v On 25th June 2020 For Issue Id 25569
            'Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='top' data-bs-container='body' id='SaveBtn0'  title='Task can not be created as User Story/Sprint is completed/not started.' class='fa fa-save' ></i>")
            'Uncommented By Usha Pandit On 19.05.2021 For plotting Add link for agile project
            strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='top' data-bs-container='body' id='SaveBtn0'  title='Task can not be created as User Story/Sprint is completed/Not started.' class='fa fa-save' ></i>")
            'End Of Uncommented By Usha Pandit On 19.05.2021 For plotting Add link for agile project
            'End of Added by Usha Pandit on 16 Aug 2018 for disallowing edit the user story if Sprint is Started/In Progress/Ready To Complete/Completed/Sprint Terminated
            'End of Commented By Dipali v On 25th June 2020 For Issue Id 25569
            'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        End If





        strHTML.Append("</td>")



        Dim Restult As String = ""
        Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasks  " & Session("IntProjectId") & "," & TaskID & ""
        Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))



        'strHTML.Append("<td style='width:3%;text-align:center'>")
        '' 
        'strAddLinkAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        'If strAddLinkAccess = "1" Then
        '    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete0' title='Delete Task' class='fa fa-trash'  disabled></i>")
        'Else
        '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Task' data-bs-placement='bottom' >Add</a></h2>")
        '    strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='iddelete0'  title='Task can not be deleted as User Story/ Sprint is completed/Not started.' disabled class='fa fa-trash' ></i>")
        '    'strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-placement='bottom' data-bs-toggle='tooltip'  id='iddelete0' title='Delete Task' class='fa fa-trash'  disabled></i>")
        '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        'End If
        'strHTML.Append("</td>")


        'strHTML.Append("<td style='width:3%;text-align:center;'>")
        ''strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
        'strAddLinkAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))

        'If strAddLinkAccess = "1" Then
        '    strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task',0)""></i>")
        'Else
        '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-bs-toggle='tooltip' title='Map Relase and Sprint to Create Task' data-bs-placement='bottom' >Add</a></h2>")
        '    strHTML.Append("<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  data-bs-placement='bottom'  id='SaveBtn0'  title='Task can not be created as User Story/Sprint is completed/not started.' class='fa fa-save' ></i>")

        '    'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-bs-toggle='tooltip'  data-bs-placement='bottom' >Add</a></h2>")
        'End If
        'strHTML.Append("</td>")
        ''strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
        ''strHTML.Append("<i id='spanWorkHrs0' data-bs-toggle='tooltip' style='display:none;' title='Error Details' data-bs-toggle='popover' data-bs-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
        ''strHTML.Append("</td>")

        'End of Added By Kashish on 24 july 2018 for task detail  issue fixing



        strHTML.Append("<td>")
        strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-bs-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-bs-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")


        strHTML.Append("</Div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div>")
        strAddLinkAccess = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & userStoryID & ",'UserStory'", True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<i  style='font-size:14px!important;float:Right;margin-left:20px;margin-top: 2%;'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='AssignSaveBtn" & TaskID & "' data-bs-toggle='tooltip' title='Save Task' class='fa fa-save save' onclick=""SaveAssignTask(" & userStoryID & ")""></i>")

        Else
            strHTML.Append("<i  style='font-size:14px!important;float:Right;margin-left:20px;margin-top: 2%;'  data-bs-placement='bottom' data-bs-toggle='tooltip'  id='AssignSaveBtn" & TaskID & "' data-bs-toggle='tooltip' class='fa fa-save save'  style='cursor:no-drop'  onclick=""SaveAssignTask(" & userStoryID & ")""></i>") 'title='Map Relase and Sprint to Create Task'

        End If
        strHTML.Append("</div>")
        strHTML.Append("<Div class='col-sm-12' id='divtaskForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-11' style='border:1px solid #ddd;'>")

        Dim ObjAssignTask As New AssignTask()
        strHTML.Append(ObjAssignTask.PlotAssignTaskFields(Session("IntProjectID"), userStoryID, "AssignedTask", userStoryID))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")


        If Flag <> "aftersave" Then
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString

    End Function

    Public Function Chart_section(ByVal userStoryID As String) As String
        'Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='divChart' class='clsBox'>")
        'strHTML.Append("<P>divChart</p>")
        'strHTML.Append("</div>")
        'Return strHTML.ToString


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divChartUS' class='clsBox'>")

        strHTML.Append(Graph_SprintRelease(userStoryID, "UserStory"))
        strHTML.Append("</div>")
        Return strHTML.ToString


    End Function

    Public Function History_section(ByVal userStoryID As String) As String

        Dim strHTML As New StringBuilder()
        ' strHTML.Append("<div id='divHistoryUS' class='clsBox'>")
        strHTML.Append(History_sectionSprintRelease(userStoryID, "UserStory"))
        'strHTML.Append("</div>")
        Return strHTML.ToString




    End Function
    ''Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTeams(ByVal UserStoryID As String)
        Try
            Dim strHTML As New StringBuilder()
            strHTML.Append(New frmSprintPlanning().Teams_sectionSprintRelease(UserStoryID, "UserStory"))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation

    Public Function Resource_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divResourceUS' class='clsBox'>")
        strHTML.Append(Teams_sectionSprintRelease(userStoryID, "UserStory"))
        strHTML.Append("</div>")
        Return strHTML.ToString()



        'Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='divResource' class='clsBox'>")
        'strHTML.Append("<h2>Resources</h2>")
        'strHTML.Append("<div id='divResourceDetails1' style='overflow:auto;padding-right:3%;width:105.5%;' class='row text-center'>")
        ''strHTML.Append("<table class='tblResource'>")
        'Dim dtTable As New DataTable
        'Dim strSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        'dtTable = CommonFunctions.Data.GetDataTable(strSql, True)
        'For i As Integer = 0 To dtTable.Rows.Count - 1

        '    strHTML.Append("<div class='col-lg-3 col-md-6 mb-4'>")
        '    strHTML.Append("<div class='card'>")
        '    strHTML.Append("<img class='card-img-top' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFilename"), "") & "' alt=''>")
        '    strHTML.Append("<div class='card-body'>")
        '    strHTML.Append("<h4 class='card-title'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName"), "") & "</h4>")
        '    strHTML.Append("<p class='card-text'>Role : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("RoleDescription"), "") & "</p>")
        '    strHTML.Append("<p class='card-text'>Assignment Start Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedStartDate"), "") & "</p>")
        '    strHTML.Append("<p class='card-text'>Assignment End Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedEndDate"), "") & "</p>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='card-footer'>")
        '    strHTML.Append("<div class='counter'>")
        '    strHTML.Append("<div class='row'>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("TotalTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>Total Tasks</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("InProgressTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>In Progress</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
        '    strHTML.Append("<div class='employees'>")
        '    strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("CompletedTasks"), "") & "</p>")
        '    strHTML.Append("<p class='employee-p'>Completed</p>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")

        '    strHTML.Append("</div>")
        '    strHTML.Append("</div>")


        'Next
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'Return strHTML.ToString
    End Function

    Public Function Attachment_section(ByVal userStoryID As String) As String

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='div_Attachment' class='clsBox'>")
        ' strHTML.Append("<H2 class='clsDiscussion clsDiscussion_border_bottom'>Attachments</H2>")

        strHTML.Append("<div id='divAttachmentList' class=''>")
        strHTML.Append(GetAttachmentList1(userStoryID))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function GetAttachmentList1(userStoryID As String, Optional ByVal flag As String = "")


        Dim strHTML As New StringBuilder()
        If flag <> "AfterDelete" Then
            strHTML.Append(" <div id='Attachmentus'>")
        End If

        Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        Dim dtAttachment As New DataTable
        dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Attachments</h2><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='upload btn btn-info' data-bs-toggle='tooltip' title='Upload File' data-bs-placement='bottom' onclick=UploadData(" & userStoryID & ")><i class='fa fa-upload'></i> Upload</a>")
        ' strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a data-bs-toggle='tooltip' title='Upload File' data-bs-placement='bottom' onclick=UploadData(" & userStoryID & ")>Upload</a></h2>")
        strHTML.Append(" <div id='listattachment'>")
        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            strHTML.Append(" <div class='row attachRow'>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append(" <div class='col-sm-4 '>")
            strHTML.Append("<span  data-bs-toggle='tooltip' title='File Name' data-bs-placement='bottom' style='word-break:break-all'>" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-3 '>")
            strHTML.Append("<span  data-bs-toggle='tooltip' title='Attached By' data-bs-placement='bottom'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-2 ' >")

            'Commented and Added by Usha Pandit On 26 March 2019 for attachment tab javascript error

            'strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "')""></i>")
            strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Download Attachment' class='fa fa-download'  onclick=""Document_OnClick('" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("FilePath"), "") & "','" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "").ToString().Replace("\", "\\") & "')""></i>")

            'End of Added by Usha Pandit On 26 March 2019 for attachment tab javascript error

            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-3 ' style='float:right;'>")
            strHTML.Append("<i data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'Userstory')""></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Next
        strHTML.Append("</div>")
        If flag <> "AfterDelete" Then
            strHTML.Append(" </div>")
        End If

        Return strHTML.ToString()


    End Function

    Public Function GetAttachmentList(userStoryID As String)


        Dim strHTML As New StringBuilder()
        Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        Dim dtAttachment As New DataTable
        dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'>Attachment</h2><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='btn btn-info upload'onclick=UploadData(" & userStoryID & ")><i class='fa fa-upload'></i>Upload</a>")
        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            strHTML.Append(" <div class='row attachRow'>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append(" <div class='col-sm-4 '>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), ""))
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-4 '>")
            strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-4 '>")
            strHTML.Append("<i class='fa fa-trash' onclick='Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ")'></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Next
        Return strHTML.ToString()


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal strAttachmentID As String, ByVal strUserStoryID As String, ByVal strEntity As String)
        'Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
        'Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")
        'Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
        'If strEntity = "UserStory" Then
        '    Return strResult & "||" & New frmProductBacklog().GetAttachmentList1(strUserStoryID, "AfterDelete")
        'Else
        '    Return strResult & "||" & New frmSprintPlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity, "AfterDelete")
        'End If

        Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")

        Dim strResult As String
        Dim intFlag As Integer
        Dim drattach As IDataReader
        drattach = CommonFunctions.Data.GetDataReader(strSql, True)
        If drattach.Read() Then
            strResult = CommonFunction.Data.CheckIsDBNull(drattach("Result"), "")
            intFlag = CommonFunction.Data.CheckIsDBNull(drattach("intFlag"), "0")
        End If
        If strEntity = "UserStory" Then
            Return strResult & "||" & intFlag & "||" & New frmProductBacklog().GetAttachmentList1(strUserStoryID, "AfterDelete")
        Else
            Return strResult & "||" & intFlag & "||" & New frmSprintPlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity, "AfterDelete")
        End If
        'End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

    End Function

    Public Function Tab_section() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<ul id=ulTabs>" & vbCrLf)
        strHTML.Append("<li><a href='#frmDetails' class='active' style='text-decoration: underline;color:#5bc0de'>Details</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divSubstories'>Substories</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#div_Attachment'>Attachments</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li ><a href='#divDiscussionsUS'>Discussion</a></li>&nbsp;&nbsp;" & vbCrLf)

        ''Commented and Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation
        'strHTML.Append("<li><a href='#divResourceUS'>Teams</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divResourceUS' onclick='refreshTeams()'>Teams</a></li>&nbsp;&nbsp;" & vbCrLf)
        ''End of Added by Usha Pandit on 22.04.2019 for refreshing teams tab on task creation

        strHTML.Append("<li><a href='#divHistoryUS'>History</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divIssues'>Issues</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divReviews'>Reviews</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divTasksUS' onclick=TaskReFresh()>Task</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a href='#divChartUS'>Charts</a></li>&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("</ul>")
        strHTML.Append("</div><br>")
        Return (strHTML.ToString())


    End Function

    Public Function Heading_section(ByVal UserStoryId As String) As String


        GetAccessRights()
        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & UserStoryId
        Dim drGetUserStory As IDataReader
        drGetUserStory = CommonFunctions.Data.GetDataReader(strSql, True)

        If drGetUserStory.Read Then
            strFunctionalNumber = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FunctionalNo").ToString, "")
            strFeatureName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("UserStoryName").ToString, "")
            strUserDesc = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Description").ToString, "")
            strBusinesValue = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("BusinessValue").ToString, "")
            strPriority = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityID").ToString, "")
            strState = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("State").ToString, "")
            strComplexity = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Complexity").ToString, "")
            strCategory = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryID").ToString, "")
            strVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Version").ToString, "")
            strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            strReleaseName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("ReleaseID"), "")
            strCreatedDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedDate").ToString, "")
            strCreatedBy = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CreatedBy").ToString, "")
            strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("CategoryColor").ToString, "")
            strVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("VersionColor").ToString, "")
            strPriorityColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("PriorityColor").ToString, "")
            strStoryPoint = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialEstimate").ToString, "")
            strInitialRank = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("InitialRank").ToString, "") ''Added By Dipali V On 2nd March
            strStatus = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("Status").ToString, "")
            strAcceptanceCriteria = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("AcceptanceCriteria").ToString, "")
            strFixedVersion = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersion").ToString, "")
            strFixedVersionColor = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("FixedVersionColor").ToString, "")
        End If

        drGetUserStory.Dispose()
        If strIterationName = 0 Then
            strIterationName = ""
        End If

        strHTML.Append("<input type='hidden' value='" & UserStoryId & "' id='hdnusid' />")
        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='modal-header'>")
        strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
        'strHTML.Append("<div style='height:50px;width:50px;background-color:" & strPriorityColor & ";' class='img-circle' ></div>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;margin-top:10px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='padding: 0px 3px;font-size: 65px!important;color:" & strPriorityColor & ";'></i>")
        strHTML.Append("<p style='color: white;font-weight: 600;font-size: 14px;position: absolute;top: 10px;left: 12px;text-align: center;right: 0;' title='Userstory ID' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & UserStoryId & "</p></div>")

        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-1'>" & vbCrLf)

        'strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9' style='margin-top: 10px;margin-left:20px;'>" & vbCrLf)

        strHTML.Append("<p style='font-size: 16px; font-weight: 500;word-break:break-all;' >" & strFeatureName & "</p>" & vbCrLf)
        strHTML.Append("<label style='white-space:nowrap;font-weight:normal;font-size:11px'>Created By: " & strCreatedBy & " On " & Convert.ToDateTime(strCreatedDate).ToString("dd-MMM-yyyy") & "</label>" & vbCrLf)
        strHTML.Append("<p class='label label-warning' style='font-weight: 600;float:right;' title='Rank' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strInitialRank & "</p>" & vbCrLf)
        strHTML.Append("</div>")

        strHTML.Append("<div>" & vbCrLf)
        'Commented And Added by Usha Pandit on 26 Mar 2019 for refresh tables
        'strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal' onclick='RefreshGrid('Edit')'>&times;</button>")
        strHTML.Append("<button type='button' class='close' data-bs-dismiss='modal' onclick='RefreshGrid(&quot;Edit&quot;)'>&times;</button>")
        'End of Commented And Added by Usha Pandit on 26 Mar 2019 for refresh tables
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-2'>" & vbCrLf)
        strHTML.Append("")
        strHTML.Append("</div>")

        'strHTML.Append("<div class='row' id='creation_status'>")


        'strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='row '>")
        strHTML.Append("<div class='col-sm-11'>")
        strHTML.Append("")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-1 right'>")
        'commented & added BY Dipali V  24th April 2018 acess
        'If (UserStoryId <> "" Or UserStoryId <> "0") And strIterationName = 0 Then
        '    If m_objAccess.Edit Then
        '        strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
        '    End If
        'Else
        '    If strIterationName = 0 Then
        '        If m_objAccess.Add Then
        '            strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
        '        End If
        '    End If
        'End If
        'If m_objAccess.Delete Then
        '    strHTML.Append("<i class='fas fa-trash-alt' aria-hidden='true' onclick='Delete_UserStory(" & UserStoryId & ")'></i>")
        'End If


        Dim strIsSprintstatus As String = ""
        If (UserStoryId <> "" Or UserStoryId <> "0") Then

            strIsSprintstatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & UserStoryId & ",'UserStory'", True))
            If strIsSprintstatus = "0" Then
                If m_objAccess.Edit = True Then
                    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                End If '            strHTML.Append("<button type='button'  class='btn btn-info' onclick=UpdateSprintRelease('" & Flag & "','" & IterationID & "') data-bs-toggle='tooltip' data-bs-placement='top' id='updateSprintRelease'>Update</button>")

            End If
        Else
            If strIterationName = "" And strIsSprintstatus = "0" Then
                If m_objAccess.Add = True Then
                    strHTML.Append("<i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                End If
            End If
        End If

        'Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not
        strIsSprintStarted = strIsSprintstatus
        'End of Added by Usha Pandit on 17 Aug 2018 for checking if sprint is started or not

        If strIsSprintstatus = "0" Then
            If m_objAccess.Delete = True Then
                strHTML.Append("<i class='fas fa-trash-alt' style='color:red' aria-hidden='true' data-bs-toggle='tooltip' data-bs-placement='bottom' title='Delete User Story' data-bs-container='body' onclick=""Delete_UserStory(" & UserStoryId & ",'')""></i>")
            End If
        End If
        'End of commented & added BY Dipali V  24th April 2018 acess
        strHTML.Append("</div>")
        strHTML.Append("</div><hr>")
        Return (strHTML.ToString())

    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateStoryPointss(ByVal UserStoryID As String, ByVal StoryPoints As String, ByVal TaskID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim Restult As String = ""
            If TaskID = "" Then
                TaskID = "NULL"
            Else
                TaskID = TaskID
            End If
            Dim strQuery As String = "usp_NG2_chk_ValidateTaskStoryPoint '" + UserStoryID + "','" + StoryPoints + "'," + TaskID + ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function FilterData(ByVal strEntityID As String, ByVal strEntity As String)
        'Dim objBacklog As New frmSprintPlanning()
        'Return objBacklog.Table_Backlog(strEntityID, strEntity)
    End Function
    'Commented by yasmin to hide the product backlog detail
    'Public Function Table_Backlog(Optional ByVal strEntityID As String = "", Optional ByVal strEntity As String = "") As String
    '    Dim strHTML As New StringBuilder()
    '    Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID")

    '    If strEntity = "Category" Then
    '        strSql &= "," & strEntityID
    '    ElseIf strEntity = "Priority" Then
    '        strSql &= ",NULL," & strEntityID
    '    End If
    '    Dim dtProductBacklog As New DataTable()
    '    dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div class='table-responsive table-bordered col-sm-3' id='leftTree' style='overflow-y: scroll; height: 627px;padding-right: 0px;padding-left: 0px;'>   ")
    '    strHTML.Append(" <table class='table'>")
    '    strHTML.Append("	<thead>")
    '    strHTML.Append("	  <tr><th style='text-align: left!important;'>Backlogs</th><th style='position:absolute;right: 0px;'>")
    '    strSql = "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID")
    '    Dim dtCategory As New DataTable
    '    dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;'><i  data-bs-toggle='tooltip' title='Settings' data-bs-placement='left' style='font-size:16px!important' class='fa fa-align-justify Home'></i></div>")
    '    strHTML.Append("<ul class='dropdown-menu dropdown_category' role='menu'>")
    '    strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
    '    strHTML.Append("<b>Category</b>")
    '    strHTML.Append("</li>")
    '    For i As Integer = 0 To dtCategory.Rows.Count - 1
    '        If dtCategory.Rows(i)("CategoryID").ToString() = strEntityID And strEntity = "Category" Then
    '            strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
    '        Else
    '            strHTML.Append("<li onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
    '        End If
    '        strHTML.Append(dtCategory.Rows(i)("Category"))
    '        strHTML.Append("</li>")
    '    Next

    '    strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities"
    '    dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
    '    strHTML.Append("<b>Priority</b>")
    '    strHTML.Append("</li>")
    '    For i As Integer = 0 To dtCategory.Rows.Count - 1
    '        If dtCategory.Rows(i)("PriorityID").ToString() = strEntityID And strEntity = "Priority" Then
    '            strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
    '        Else
    '            strHTML.Append("<li onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
    '        End If
    '        strHTML.Append(dtCategory.Rows(i)("Priority"))
    '        strHTML.Append("</li>")
    '    Next
    '    strHTML.Append("</ul>")
    '    strHTML.Append("</th> </tr>")
    '    strHTML.Append("	</thead>")
    '    strHTML.Append("	<tbody id='tblUserStory_body'>")
    '    For i As Integer = 0 To dtProductBacklog.Rows.Count - 1
    '        If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) <> 0 Then
    '            strHTML.Append("<tr><td style='cursor:pointer;' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")
    '        End If
    '    Next
    '    strHTML.Append("	</tbody>")
    '    strHTML.Append("	</table>")
    '    strHTML.Append("</div>")

    '    Return (strHTML.ToString())
    'End Function


    Public Function Substories_section(ByVal userStoryID As String) As String

        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""

        strHTML.Append("<div id='divSubstories' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom'>Sub UserStories</h2>")
        'Added By Dipali V On 24th April 2018 For Access
        Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & userStoryID & ",'UserStory'", True))
        Dim strIsSubUS As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsSubUserStory " & userStoryID, True))
        If strAddLinkAccess = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' data-bs-container='body' onclick=ShowData('List','SubUS','UserStory')>List</a> | <a data-bs-toggle='tooltip' data-bs-container='body' title='Sprint already started/completed you can not add sub userstory' data-bs-placement='bottom' >Add</a></h2>")
        ElseIf strIsSubUS = "1" Then
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' data-bs-container='body' onclick=ShowData('List','SubUS','UserStory')>List</a> | <a data-bs-toggle='tooltip' data-bs-container='body' title='Sub User story can not be added against sub user story' data-bs-placement='bottom' >Add</a></h2>")
        Else
            strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a data-bs-toggle='tooltip' title='List View' data-bs-placement='bottom' data-bs-container='body' onclick=ShowData('List','SubUS','UserStory')>List</a> | <a data-bs-toggle='tooltip' data-bs-container='body' title='Form View' data-bs-container='body' data-bs-placement='bottom' onclick=ShowData('Form','SubUS','UserStory')>Add</a></h2>")

        End If
        'End of Added By Dipali V On 24th April 2018 For Access

        'strHTML.Append("<br><hr style='border:1px solid rgb(60, 141, 188)!important;width:97%;margin-right:21px;'>")

        strHTML.Append("<Div class='col-sm-12' id='divSubstoryList'>")
        strHTML.Append(PlotSubUserStoryList(userStoryID))
        strHTML.Append("</Div>")
        strHTML.Append("<Div class='col-sm-12' id='divSubstoryForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        'Added By Dipali V On 24th April 2018 For Access
        Dim objfrmSprintPlanning As New frmSprintPlanning
        objfrmSprintPlanning.GetAccessRights()
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' data-bs-container='body' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory',0) class='fa fa-save'></i>")
        End If

        'If m_objAccess.Edit = True Then
        '    strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save'  data-bs-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
        'End If
        'End of Added By Dipali V On 24th April 2018 For Access
        'strHTML.Append("<i data-bs-toggle='tooltip' style='float:right;' title='Save' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>User Story <span style='color:red;'>*</span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-10 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>Description <span style='color:red;'>*</span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-10 '>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubStoryDesc", "txtSubStoryDesc", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc')data-autoresize ", True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubStoryDesc", "txtSubStoryDesc", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:limitText(this,countSubUSdown,1000)' onKeyUp='javascript:limitText(this,countSubUSdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append(" <span class=''>")
        strHTML.Append("<small name='countSubUSdown' Id='countSubUSdown'>1000</small>")
        strHTML.Append("</span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>Priority <span style='color:red;'>*</span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-10 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>Complexity <span style='color:red;'></span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-10 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , , "class='form-control' onchange=ClearSpan('SubcboComplexity','spanPriority')", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-2 '>")
        strHTML.Append(" <label class='control-label' style='white-space: nowrap;margin-top: 11px;'>Category <span style='color:red;'></span></label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-10 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , , "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('SubcboCategory','spanPriority')", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        'End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

        strHTML.Append("</Div>")
        strHTML.Append("</div>")

        Return strHTML.ToString

    End Function

    Function PlotSubUserStoryList(ByVal userStoryID As String)

        Dim strHTML As New StringBuilder()
        Dim drSubstory As IDataReader
        Dim strSql As String = "usp_NG2_sel_tbl_PM_SubUserStory " & userStoryID
        drSubstory = CommonFunction.Data.GetDataReader(strSql, True)
        strHTML.Append("<ul class='col-sm-12 chat'>")
        While drSubstory.Read
            strHTML.Append("<li class='col-sm-12'>")
            strHTML.Append("<span class='chat-img float-start'>")
            'strHTML.Append("<div alt='User Avatar' class='img-circle' style='height:50px;width:50px;background-color:" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Color"), "") & "'></div>")
            strHTML.Append("<label class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</label>")
            strHTML.Append("<label class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("InitialRank"), "") & "</label>")
            strHTML.Append("</span>")
            strHTML.Append("<div class='chat-body clearfix'>")
            strHTML.Append("<div class='header'>")
            'strHTML.Append("<strong class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</strong>")
            strHTML.Append("</div>")
            strHTML.Append("<p title='Description'>")
            strHTML.Append("" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Description"), "") & "")
            strHTML.Append("</p>")
            strHTML.Append("<small class='float-end text-muted'>")
            'Added By Dipali V On 24th April 2018 For Access
            Dim objfrmSprintPlanning As New frmSprintPlanning
            objfrmSprintPlanning.GetAccessRights()
            If m_objAccess.Delete = True Then
                Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_checkUShasSprintnot " & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), 0) & ",'UserStory'", True))
                If strAddLinkAccess = "0" Then
                    strHTML.Append("<i title='Delete User Story'  style ='color:red' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' class='fa fa-trash' style='margin-right:13px!important' onclick=""Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & " ,'SubUS')""></i>")
                Else
                    strHTML.Append("<i title='User Story already Mapped to sprint,you do not have acess to delete' data-bs-container='body'  style ='color:red' data-bs-toggle='tooltip' data-bs-placement='bottom' class='fa fa-trash' style='margin-right:13px!important'></i>")
                End If

            End If
            'End of Added By Dipali V On 24th April 2018 For Access
            strHTML.Append("</small>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
        End While
        strHTML.Append("</ul>")
        Return strHTML.ToString()


    End Function
    Public Function Discussion_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussionsUS' class='clsBox' style='height:500px;overflow-y:auto'>")
        strHTML.Append("<h2 class='clsDiscussion clsDiscussion_border_bottom' style='margin-top:0%'>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10' style='margin-left:-1%;margin-top:2%'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this)><i class='far fa-comments' aria-hidden='true'></i>  Post</button>")

        ''strHTML.Append("<button id='SprintRelease' type='button' onclick=insertSprintReleaseDiscussion('" & SprintID & "','" & Flag & "',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        strHTML.Append("<div id='divDiscussionList'>") 'divDiscussionListSprintRelease
        ' strHTML.Append(PlotDiscussion(SprintID, Flag))
        strHTML.Append(PlotDiscussionThreadBodyUS(userStoryID, "", "UserStory"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

        'Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='divDiscussions' class='clsBox'>")
        'strHTML.Append("<h2>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & userStoryID & "','UserStory',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div id='divDiscussionList'>")
        'strHTML.Append(PlotDiscussionThreadBody(userStoryID, strUserDesc, "UserStory"))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'Return strHTML.ToString

    End Function

    'Friend Function PlotDiscussionThreadBodyUS(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)

    '    Dim drGetUserStoryDicussion As IDataReader
    '    Dim drGetUserStoryDicussionCount As IDataReader
    '    Dim drContactList As IDataReader
    '    Dim strHTMLDiscussion As New StringBuilder
    '    Dim StrQuery As String = ""
    '    Dim StrUserStoryCountQuery As String = ""
    '    Dim intDiscussionCount As Integer = 0
    '    Dim strPhotoFileName As String = ""
    '    Dim strDiscussionDate As String = ""
    '    Dim strComment As String = ""
    '    Dim strEmployeeName As String = ""
    '    Dim flag As String = ""
    '    Dim strUserName As String = ""
    '    Dim strDiscussionID As String = ""
    '    Dim strDiscussionID1 As String = ""
    '    Dim dtTable As New DataTable()
    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
    '    drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    Dim intCounter As Integer = 0

    '    strHTMLDiscussion.Append("<ul class='col-sm-6 col-sm-12 sprint_card'>")

    '    While drGetUserStoryDicussion.Read
    '        intCounter += 1
    '        strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '        strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '        strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '        strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '        strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
    '        strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
    '        Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
    '        strHTMLDiscussion.Append("<li class=''>")
    '        strHTMLDiscussion.Append("<div class=''>")
    '        strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start'>")
    '        strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8'>")
    '        strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<div class='row'>")

    '        strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
    '        strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description'>")
    '        Dim strLessComment As String = ""
    '        Dim strRemaining As String = ""
    '        If strComment.Length > 200 Then
    '            strLessComment = strComment.Substring(0, 200)
    '            strRemaining = strComment.Substring(201, strComment.Length - 201)
    '        End If
    '        If strLessComment = "" Then
    '            strHTMLDiscussion.Append("" & strComment & "")
    '        Else
    '            strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
    '        End If
    '        If strComment.Length > 200 Then
    '            strHTMLDiscussion.Append("<a onclick='ShowMoreLessUS(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
    '        End If
    '        Dim ReplyFlag As String = ""
    '        strHTMLDiscussion.Append("</span></p>")
    '        If strFlag = "UserStory" Then
    '            ReplyFlag = "UserStoryReply"
    '        ElseIf strFlag = "Iteration" Then
    '            ReplyFlag = "IterationReply"
    '        Else
    '            ReplyFlag = "ReleaseReply"
    '        End If
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:10px!important'>")
    '        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
    '        dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
    '        strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclickUS(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Discussion count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
    '        strHTMLDiscussion.Append("</small>")
    '        strHTMLDiscussion.Append("</div>")


    '        If dtTable.Rows.Count > 0 Then
    '            strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
    '            For i As Integer = 0 To dtTable.Rows.Count - 1
    '                strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
    '                strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
    '                strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
    '                strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
    '                strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
    '                strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
    '                strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

    '                strHTMLDiscussion.Append("<input type='hidden' id='panel-bodyDiscussionID' value=" & strDiscussionID & ">")
    '                strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
    '                strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
    '                strHTMLDiscussion.Append("<div class='header'>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class=''>")
    '                strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
    '                strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '                strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
    '                strHTMLDiscussion.Append("</span>")

    '                strHTMLDiscussion.Append("<div class='col-md-9 col-sm-9' style='white-space:pre!important'>")
    '                strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
    '                strHTMLDiscussion.Append("<p style='color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom'>")
    '                Dim strLessCommentInside As String = ""
    '                Dim strRemainingInside As String = ""
    '                If strComment.Length > 200 Then
    '                    strLessCommentInside = strComment.Substring(0, 200)
    '                    strRemainingInside = strComment.Substring(201, strComment.Length - 201)
    '                End If
    '                If strLessCommentInside = "" Then
    '                    strHTMLDiscussion.Append("" & strComment & "")
    '                Else
    '                    strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
    '                End If
    '                If strComment.Length > 200 Then
    '                    strHTMLDiscussion.Append(" <a onclick='ShowMoreLessUS(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
    '                End If
    '                strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
    '                strHTMLDiscussion.Append("<small class='float-end text-muted'>")
    '                strHTMLDiscussion.Append("<span title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclickUS(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>")
    '                strHTMLDiscussion.Append("</small>")
    '                strHTMLDiscussion.Append("</div>")
    '                strHTMLDiscussion.Append("</div>")

    '                strHTMLDiscussion.Append("</li>")
    '            Next
    '            strHTMLDiscussion.Append("</ul>")
    '        End If
    '        strHTMLDiscussion.Append("</li>")
    '        If intCounter = 1 Then
    '            flag = "PlotTextArea"
    '        End If
    '    End While
    '    If intCounter = 0 Then
    '        flag = "PlotTextArea"
    '        strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '        strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '        'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '        strHTMLDiscussion.Append("</span>")
    '        strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
    '        strHTMLDiscussion.Append("<div class='header'>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
    '        strHTMLDiscussion.Append("No records to view.")
    '        strHTMLDiscussion.Append("</p>")
    '        strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '        'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
    '        strHTMLDiscussion.Append("</small>")
    '        strHTMLDiscussion.Append("</div>")
    '        strHTMLDiscussion.Append("</li>")
    '    End If

    '    strHTMLDiscussion.Append("</ul>")
    '    'End If

    '    If flag = "PlotTextArea" Then
    '        strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin-top:8%;text-align:center;'>")
    '        ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
    '        strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussionsus", "txtDiscussionsus", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
    '        strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussionUS'  style='margin-right:10px;' onclick=AddNewDiscussionUS(this,'txtDiscussionsus')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
    '        strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseUS'  style=''   onclick=insertUserStorytDiscussionUS(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussionsus')><sup><i class='far fa-comments' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpostUS' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

    '        'strHTMLDiscussion.Append("</li>")
    '        strHTMLDiscussion.Append("</ul>")
    '    End If

    '    'Dim drGetUserStoryDicussion As IDataReader
    '    'Dim drGetUserStoryDicussionCount As IDataReader
    '    'Dim drContactList As IDataReader
    '    'Dim strHTMLDiscussion As New StringBuilder
    '    'Dim StrQuery As String = ""
    '    'Dim StrUserStoryCountQuery As String = ""
    '    'Dim intDiscussionCount As Integer = 0
    '    'Dim strPhotoFileName As String = ""
    '    'Dim strDiscussionDate As String = ""
    '    'Dim strComment As String = ""
    '    'Dim strEmployeeName As String = ""
    '    'Dim flag As String = ""
    '    'Dim strUserName As String = ""
    '    'Dim strDiscussionID As String = ""
    '    'Dim dtTable As New DataTable()
    '    'StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
    '    'drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
    '    'Dim intCounter As Integer = 0

    '    'strHTMLDiscussion.Append("<ul class='col-sm-6 chat'>")

    '    'While drGetUserStoryDicussion.Read
    '    '    intCounter += 1
    '    '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
    '    '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
    '    '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
    '    '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
    '    '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")
    '    '    strDiscussionID = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionID").ToString, "")
    '    '    Dim strSubmittedTime As String = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")
    '    '    strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '    '    strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '    '    strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '    '    strHTMLDiscussion.Append("</span>")
    '    '    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd'>")
    '    '    strHTMLDiscussion.Append("<div class='header'>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("<div class='row'>")
    '    '    strHTMLDiscussion.Append("<div class='col-sm-8'>")
    '    '    strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
    '    '    strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' style='white-space:pre!important;font-size: 10px;margin-left: 169px;margin-top:-18px;'> " & strSubmittedTime & "</P>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("<p  style='padding-left:24%;Margin-top:-2%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description'>")
    '    '    Dim strLessComment As String = ""
    '    '    Dim strRemaining As String = ""
    '    '    If strComment.Length > 200 Then
    '    '        strLessComment = strComment.Substring(0, 200)
    '    '        strRemaining = strComment.Substring(201, strComment.Length - 201)
    '    '    End If
    '    '    If strLessComment = "" Then
    '    '        strHTMLDiscussion.Append("" & strComment & "")
    '    '    Else
    '    '        strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
    '    '    End If
    '    '    If strComment.Length > 200 Then
    '    '        strHTMLDiscussion.Append("<a onclick='ShowMoreLessUS(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
    '    '    End If
    '    '    Dim ReplyFlag As String = ""
    '    '    strHTMLDiscussion.Append("</span></p>")
    '    '    If strFlag = "UserStory" Then
    '    '        ReplyFlag = "UserStoryReply"
    '    '    ElseIf strFlag = "Iteration" Then
    '    '        ReplyFlag = "IterationReply"
    '    '    Else
    '    '        ReplyFlag = "ReleaseReply"
    '    '    End If
    '    '    strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '    '    StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & ReplyFlag & "',1," & Session("intUserID") & "," & strDiscussionID
    '    '    dtTable = CommonFunctions.Data.GetDataTable(StrQuery, True)
    '    '    strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'>View all reply<span></label> <a class='clsReply' onclick=""reply_onclickUS(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'>Reply</a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Discussion count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
    '    '    strHTMLDiscussion.Append("</small>")
    '    '    strHTMLDiscussion.Append("</div>")


    '    '    If dtTable.Rows.Count > 0 Then
    '    '        strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse chatReply' style='float:right;margin-right:-12%'>")
    '    '        For i As Integer = 0 To dtTable.Rows.Count - 1
    '    '            strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
    '    '            strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
    '    '            strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
    '    '            strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
    '    '            strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
    '    '            strDiscussionID = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
    '    '            strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

    '    '            strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
    '    '            strHTMLDiscussion.Append("<li class='col-sm-12' >") 'style='border-bottom:1px solid white!important'
    '    '            strHTMLDiscussion.Append("<div class='chat-body clearfix chatReply'>")
    '    '            strHTMLDiscussion.Append("<div class='header'>")
    '    '            strHTMLDiscussion.Append("</div>")
    '    '            strHTMLDiscussion.Append("<div class='row'>")
    '    '            strHTMLDiscussion.Append("<div class='col-sm-9' style='white-space:pre!important;margin-left:-14px;'>")
    '    '            strHTMLDiscussion.Append("<p class='Postedtime'><span style='margin-left:-90%;white-space:pre!important;font-size: 10px;margin-left: 30px;margin-top:-18px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
    '    '            strHTMLDiscussion.Append("</div>")
    '    '            strHTMLDiscussion.Append("<div class='col-sm-3' style='white-space:nowrap;margin-left:-4%'>")
    '    '            strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
    '    '            strHTMLDiscussion.Append("</div>")
    '    '            strHTMLDiscussion.Append("</div>")
    '    '            strHTMLDiscussion.Append("<p style='Margin-left:9%;Margin-top:0%;color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom'>")
    '    '            Dim strLessCommentInside As String = ""
    '    '            Dim strRemainingInside As String = ""
    '    '            If strComment.Length > 200 Then
    '    '                strLessCommentInside = strComment.Substring(0, 200)
    '    '                strRemainingInside = strComment.Substring(201, strComment.Length - 201)
    '    '            End If
    '    '            If strLessCommentInside = "" Then
    '    '                strHTMLDiscussion.Append("" & strComment & "")
    '    '            Else
    '    '                strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
    '    '            End If
    '    '            If strComment.Length > 200 Then
    '    '                strHTMLDiscussion.Append(" <a onclick='ShowMoreLessUS(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p>")
    '    '            End If
    '    '            strHTMLDiscussion.Append("<br><small class='float-end text-muted' style='margin-right:14%!important;float:right!important;'>")
    '    '            strHTMLDiscussion.Append("<span title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclickUS(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'>Reply</a>")
    '    '            strHTMLDiscussion.Append("</small>")
    '    '            strHTMLDiscussion.Append("</div>")
    '    '            strHTMLDiscussion.Append("<span class='chat-img float-start' style='margin-left:275px;margin-top:-30%'>")
    '    '            strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '    '            strHTMLDiscussion.Append("</span>")
    '    '            strHTMLDiscussion.Append("</li>")
    '    '        Next
    '    '        strHTMLDiscussion.Append("</ul>")
    '    '    End If
    '    '    strHTMLDiscussion.Append("</li>")
    '    '    If intCounter = 1 Then
    '    '        flag = "PlotTextArea"
    '    '    End If
    '    'End While
    '    'If intCounter = 0 Then
    '    '    flag = "PlotTextArea"
    '    '    strHTMLDiscussion.Append("<li class='col-sm-12'>")
    '    '    strHTMLDiscussion.Append("<span class='chat-img float-start'>")
    '    '    'strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & strPhotoFileName & "' />")
    '    '    strHTMLDiscussion.Append("</span>")
    '    '    strHTMLDiscussion.Append("<div class='chat-body clearfix'>")
    '    '    strHTMLDiscussion.Append("<div class='header'>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("<p title='Description' style='text-align:center'>")
    '    '    strHTMLDiscussion.Append("No records to view.")
    '    '    strHTMLDiscussion.Append("</p>")
    '    '    strHTMLDiscussion.Append("<small class='float-end text-muted' style='margin-right:-1%!important'>")
    '    '    'strHTMLDiscussion.Append(strDiscussionDate & "<label onclick='reply_onclick(" & strIterationID & ")'></i>")
    '    '    strHTMLDiscussion.Append("</small>")
    '    '    strHTMLDiscussion.Append("</div>")
    '    '    strHTMLDiscussion.Append("</li>")
    '    'End If

    '    'strHTMLDiscussion.Append("</ul>")
    '    ''End If

    '    'If flag = "PlotTextArea" Then
    '    '    strHTMLDiscussion.Append("<ul class='col-sm-6' style='margin-top:8%'>")
    '    '    ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
    '    '    strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussionsus", "txtDiscussionsus", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
    '    '    strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintReleaseAddDiscussionUS'  style='' onclick=AddNewDiscussionUS(this,'txtDiscussionsus')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
    '    '    strHTMLDiscussion.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintReleaseUS'  style=''   onclick=insertUserStorytDiscussionUS(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussionsus')><sup><i class='far fa-comments' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpostUS' title='Post' data-bs-toggle='tooltip' data-bs-placement='top' > Post<span></button>")

    '    '    'strHTMLDiscussion.Append("</li>")
    '    '    strHTMLDiscussion.Append("</ul>")
    '    'End If

    '    Return strHTMLDiscussion.ToString()
    'End Function

    Friend Function PlotDiscussionThreadBodyUS(ByVal strIterationID As String, ByVal strIterationName As String, ByVal strFlag As String)


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
        Dim strDiscussionID1 As String = ""
        Dim dtTable As New DataTable()
        StrQuery = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & strIterationID & ",'" & strFlag & "',1," & Session("intUserID")
        drGetUserStoryDicussion = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intCounter As Integer = 0


        strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin-left:20px;'>")


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
            strHTMLDiscussion.Append("<img alt='User Avatar' title='Employee Image' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' class='img-circle empimg' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8'>")
            strHTMLDiscussion.Append("<p class='clsempname'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom' style ='font-weight:100!important' data-bs-container='body'> " & strEmployeeName & "</span></P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='row'>")

            strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
            strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            'Commented and Added by Usha Pandit on 08 June 2018 for wrapping large text
            'strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description' style='word-break:break-all;overflow-wrap: break-word;'>")
            strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%;word-break:break-all;overflow-wrap: break-word;' ><span data-bs-toggle='tooltip' data-bs-placement='bottom' title='Description' style='word-break:break-all;overflow-wrap: break-word;'>")
            'End of Added by Usha Pandit on 08 June 2018 for wrapping large text

            Dim strLessComment As String = ""
            Dim strRemaining As String = ""
            If strComment.Length > 200 Then
                strLessComment = strComment.Substring(0, 200)
                strRemaining = strComment.Substring(201, strComment.Length - 201)
            End If
            If strLessComment = "" Then
                strHTMLDiscussion.Append("" & strComment & "")
            Else
                'Commented and Added by Usha Pandit on 08 June 2018 for wrapping large text
                'strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important'>" & strRemaining & "</p>")
                strHTMLDiscussion.Append("" & strLessComment & " <p id='" & strDiscussionID & "' style='display:none;font-weight:100!important;word-break: break-all;overflow-wrap: break-word;'>" & strRemaining & "</p>")
                'End of Added by Usha Pandit on 08 June 2018 for wrapping large text
            End If
            If strComment.Length > 200 Then
                strHTMLDiscussion.Append("<a onclick='ShowMoreLess(" & strDiscussionID & ",this)' title='More' data-bs-toggle='tooltip' data-bs-placement='bottom'>More</a></p>")
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
            strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='padding: .1em .4em .2em!important;' title='Reply count' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'>" & dtTable.Rows.Count & "</label>")
            strHTMLDiscussion.Append("</small>")



            If dtTable.Rows.Count > 0 Then
                strHTMLDiscussion.Append("<ul id='collapse_" & strDiscussionID & "' class='col-sm-12 chat chat-inline collapse' >")
                For i As Integer = 0 To dtTable.Rows.Count - 1
                    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFileName").ToString, "")
                    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionDates").ToString, "")
                    strComment = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("Comments").ToString, "")
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName").ToString, "")
                    strUserName = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("UserName").ToString, "")
                    strDiscussionID1 = CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "")
                    strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Duration").ToString, "")

                    strHTMLDiscussion.Append("<input type='hidden' id='hdnstrDiscussionID' value=" & strDiscussionID & ">")
                    strHTMLDiscussion.Append("<li class='' >") 'style='border-bottom:1px solid white!important'
                    strHTMLDiscussion.Append("<div class='chat-body clearfix' style='padding:10px;margin-bottom:10px;background:#c6eab7;border-radius:5px;'>")
                    strHTMLDiscussion.Append("<div class='header'>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class=''>")
                    strHTMLDiscussion.Append("<span class='col-md-3 col-sm-3 col-sm-4 float-end' style='float:right!important;'>")
                    strHTMLDiscussion.Append("<img alt='User Avatar' title='Employee Image' data-bs-toggle='tooltip' data-bs-placement='bottom' data-bs-container='body'  class='img-circle empimg' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
                    strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-bs-toggle='tooltip' data-bs-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
                    strHTMLDiscussion.Append("</span>")

                    strHTMLDiscussion.Append("<div class='col-md-9 col-sm-9' style='white-space:pre!important;float: right;'>")
                    strHTMLDiscussion.Append("<p style='float: right;' class='clsempname'><span class='clsempname' title='Employee Name' data-bs-toggle='tooltip' data-bs-placement='bottom'> " & strEmployeeName & "</span></P>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<p style='color:#777!important' ><span title='Description' data-bs-toggle='tooltip' data-bs-placement='bottom' style='    word-break: break-all;'>")
                    Dim strLessCommentInside As String = ""
                    Dim strRemainingInside As String = ""
                    If strComment.Length > 200 Then
                        strLessCommentInside = strComment.Substring(0, 200)
                        strRemainingInside = strComment.Substring(201, strComment.Length - 201)
                    End If
                    If strLessCommentInside = "" Then
                        strHTMLDiscussion.Append("" & strComment & "")
                    Else
                        'Commented and Added by Usha Pandit on 08 June 2018 for wrapping large text
                        'strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important'>" & strRemainingInside & "</label>")
                        strHTMLDiscussion.Append("" & strLessCommentInside & "<label id='" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & "' style='display:none;font-weight:100!important;word-break: break-all;overflow-wrap: break-word;'>" & strRemainingInside & "</label>")
                        'End of Added by Usha Pandit on 08 June 2018 for wrapping large text
                    End If
                    If strComment.Length > 200 Then
                        strHTMLDiscussion.Append(" <a onclick='ShowMoreLess(" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("DiscussionID").ToString, "0") & ",this)' title='More'>More</a></span></p></div>")
                    End If
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<small class='float-end text-muted'>")
                    strHTMLDiscussion.Append("<span title='Discussion Date' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & strDiscussionDate & " &nbsp;&nbsp;</span><a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" title='Reply'  data-bs-toggle='tooltip' data-bs-placement='bottom'><i class='fa fa-reply' aria-hidden='true' style=''></i></a>")
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
            strHTMLDiscussion.Append("<ul class='col-sm-5 col-sm-12' style='margin-top:8%;text-align:center;'>")
            ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
            strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , " data-autoresize placeholder = 'Post New Discussion'", True, EnableHTMLEncode:=True))
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("DiscussionTextArea", "DiscussionTextArea", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
            'strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;' onclick=AddNewDiscussion(this,'txtDiscussions')><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-bs-toggle='tooltip' data-bs-placement='top'  >Add New<span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-primary' id='SprintReleaseAddDiscussion'  style='' onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span>Add New</span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertuserStoryDiscussion(" & strIterationID & ",'" & strFlag & "',this,'DiscussionTextArea')><sup><i class='far fa-comments' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost'> Post</span></button>")


            'strHTMLDiscussion.Append("</li>")
            strHTMLDiscussion.Append("</ul>")
        End If





        Return strHTMLDiscussion.ToString()

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussionUS(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
        Try

            Dim strSQL As String
            Dim strREsult As String
            strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                End If
            End If

            Return New frmSprintPlanning().PlotDiscussionThreadBodyUS(strUserStoryID, "", Flag)
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetPriorityColor(ByVal PriorityID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================
        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & PriorityID & ",'Priority'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strPriorityColor As String = ""

            Dim drGetPriorityColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetPriorityColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetPriorityColor.Read
                strPriorityColor = CommonFunctions.Data.CheckIsDBNull(drGetPriorityColor("Color").ToString, "")
            End While
            Dim strHtml2 As String
            strHtml2 = GetColorMaster(PriorityID, "Priority")

            Return strPriorityColor + "||" + strHtml2
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCategoryColor(ByVal categoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCategoryColor
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   29th-Dec-2016
        '=====================================================================
        Try

            Dim StrColorQuery As String = "usp_NG2_GETColorForUserStory " & categoryID & ",'category'," & HttpContext.Current.Session("intProjectID") & ""
            Dim strCategoryColor As String = ""

            Dim drGetCategoryColor As IDataReader
            Dim strHTML As New StringBuilder
            drGetCategoryColor = CommonFunctions.Data.GetDataReader(StrColorQuery, True)
            While drGetCategoryColor.Read
                strCategoryColor = CommonFunctions.Data.CheckIsDBNull(drGetCategoryColor("Color").ToString, "")
            End While
            Dim strHtml2 As String
            strHtml2 = GetColorMaster(categoryID, "Category")

            Return strCategoryColor + "||" + strHtml2

        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid1(ByVal ID As String)
        Try

            Dim obj As New frmSprintPlanning()
            Dim strHTML As New StringBuilder("")
            strHTML.Append(obj.PlotGrid("", "", "Filter"))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid(ByVal UserStoryID As String) As String
        Try

            Dim objBacklog As New frmSprintPlanning()
            'Return objBacklog.PlotGrid(
            Return objBacklog.PlotGrid("", "", "Filter")
            ' Return (objBacklog.PlotRightDiv("", "", "SecondTable", "", ""))
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    Public Function UploadData(ByVal Flag As String)
        If Request.Files.Count > 0 Then
            Dim strUserStoryID As String = Request.Params("UserStoryID")
            Dim strFileName As String
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim response As String = String.Empty
            Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim buffer As Byte() = New Byte(256) {}
            Dim MimeType As String

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
            Dim IsFileNameValid As Integer = 1
            Dim ExtensionList As String()
            ExtensionList = fileName.Split("."c)
            If ExtensionList.Length > 2 Then
                IsFileNameValid = 0
            End If
            If fileName = fileName1 And IsFileNameValid = 1 Then
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
                Dim strSql As String = ""
                If Flag = "Iteration" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL," & strUserStoryID & ", NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                ElseIf Flag = "UserStory" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                Else
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL,NULL," & strUserStoryID & "," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                End If

                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                If Flag = "UserStory" Then
                    Context.Response.Write(GetAttachmentList1(strUserStoryID, ""))
                Else
                    Context.Response.Write(GetAttachmentListSprintRelease(strUserStoryID, Flag))
                End If
            Else
                Context.Response.Write("Invalid")
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

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckComplexity(ByVal strUserStoryID As String, ByVal strIterationID As String)
        Try

            If strUserStoryID = "" Then
                strUserStoryID = "NULL"
            End If
            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IsComplexityMappedToUserStory " & strUserStoryID & "," & strIterationID, True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckSprintEfforts(ByVal strIterationID As String, ByVal strEfforts As String)
        Try

            If (strIterationID = "") Then
                strIterationID = "Null"
            End If

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            'Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_SprintEffortWithProject " & HttpContext.Current.Session("intProjectID") & "," & strEfforts & "," & strIterationID, True), "0")

            Dim fltEfforts As Decimal

            If strEfforts = "0" Or strEfforts = "" Then
                strEfforts = "00:00"
            End If

            If strEfforts.IndexOf(":") = strEfforts.Length - 1 Then
                strEfforts = strEfforts + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = strEfforts.Substring(0, strEfforts.IndexOf(":"))
            strDecimal = strEfforts.Substring(strEfforts.IndexOf(":") + 1, 2)
            strEfforts = strBeforeDecimal + ":" + strDecimal


            fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEfforts + "',2)", True)

            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_SprintEffortWithProject " & HttpContext.Current.Session("intProjectID") & "," & fltEfforts & "," & strIterationID, True), "0")

            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal Entity As String, ByVal EntityID As String)
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

            If Entity = "Iteration" Then
                m_lngReportID = 20244
                strSQL = "usp_NG2_Get_SprintDashboard_Report " & EntityID & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
            Else
                m_lngReportID = 20171
                strSQL = "usp_NG2_sel_tbl_PM_ScrumReleasesList_Report " & EntityID & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
            End If


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

            Dim frmObjSprintPlanning As New frmSprintPlanning
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjSprintPlanning.UseSQL
                .DefaultLCID = CType(frmObjSprintPlanning.DefaultUILCID, Integer)
                .LCID = frmObjSprintPlanning.CurrentThreadUICultureID
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
    Public Shared Function RefereshTask(ByVal UserStoryId As String) As String
        '=====================================================================
        ' Procedure  Name		:	RefereshTask
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To RefereshTask
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   7th-june-2018
        '=====================================================================
        Try

            Dim frmSprintPlanning As New frmSprintPlanning()
            Dim strReturnHTML As New StringBuilder("")
            Return New frmSprintPlanning().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AfterDeleteTask(ByVal taskId As String, ByVal UserStoryId As String) As String
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

            Dim frmSprintPlanning As New frmSprintPlanning()
            Dim strReturnHTML As New StringBuilder("")
            Dim Restult As String = ""
            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasksDailyActivity  " & HttpContext.Current.Session("IntProjectId") & "," & taskId & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))
            Return New frmSprintPlanning().Tasks_section(UserStoryId, "aftersave")
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationDates(ByVal strUserStoryID As String, ByVal strStartDate As String, ByVal strEndDate As String)
        Try

            If strUserStoryID = "" Then
                strUserStoryID = "NULL"
            End If


            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskPeriodFallsBetweenIteration " & strUserStoryID & ",'" & strStartDate & "','" & strEndDate & "'", True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationEfforts(ByVal strUserStoryID As String, ByVal strEfforts As String, ByVal strTaskID As String)

        Try

            If strUserStoryID = "" Then
                strUserStoryID = "NULL"
            End If

            If strTaskID = "" Then
                strTaskID = "NULL"
            End If

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            'If strEfforts = "" Then
            '    strEfforts = "0.00"
            'End If

            'Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsWithIteration " & strUserStoryID & "," & strEfforts & "," & strTaskID & "", True), "0")

            If strEfforts = "" Then
                strEfforts = "0:00"
            End If

            Dim fltEfforts As Decimal

            If strEfforts = "0" Or strEfforts = "" Then
                strEfforts = "00:00"
            End If

            If strEfforts.IndexOf(":") = strEfforts.Length - 1 Then
                strEfforts = strEfforts + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = strEfforts.Substring(0, strEfforts.IndexOf(":"))
            strDecimal = strEfforts.Substring(strEfforts.IndexOf(":") + 1, 2)
            strEfforts = strBeforeDecimal + ":" + strDecimal

            fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEfforts + "',2)", True)

            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_TaskEffortsWithIteration " & strUserStoryID & "," & fltEfforts & "," & strTaskID & "", True), "0")

            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    Private Sub PlotCustomFieldsDetails(ByVal UserStoryId As String, ByVal TaskTypeID As String)
        '==================================================================================
        ' Procedure Name		:	PlotCustomFieldsDetails
        ' Parameters Passed		:	To plot custom fields for Tasks
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	17th Jan 2018
        ' Revisions				:	
        '==================================================================================
        Dim m_lngQueryID As String
        'Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        'With ObjCustomFieldsSection
        '    'Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
        '    'Response.Write(.GetSectionTitle("Custom Fields", "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

        '    'Write ClientsideScript in order to show hide the section
        '    Response.Write("<SCRIPT Language=javascript>")
        '    Response.Write(.ClientsideScript)
        '    Response.Write("</SCRIPT>")
        'End With
        Response.Write("<DIV id=DivCustomFieldsSection width='99.9%' >")

        Dim strTaskID As String
        Dim strDummyTask As String
        Dim blnDummyDefaultValue As Boolean
        'strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
        If m_lngQueryID <> 0 Then
            strDummyTask = strTaskID
            blnDummyDefaultValue = False
        Else
            strDummyTask = m_lngTaskId.ToString()
            blnDummyDefaultValue = m_blnShowDefaults
        End If

        Dim objCustomFields As New frmSprintPlanning()

        With objCustomFields

            .EntityName = "Task"
            .FormName = "form1"
            .PrimaryKey = "TaskID"
            .PrimaryTable = "tbl_PM_ProjectTasks"
            .TypeID = TaskTypeID
            .IsAddNewMode = blnDummyDefaultValue
            .PrimaryKeyValue = 0
            .QueryStringForTypeChange = "TaskTypeID"
            .m_lngProjectId = Session("IntprojectID")
            .PlotCustomFields(UserStoryId, TaskTypeID)
            declarevariables = .VariableDeclarationScript
            strClientSideScript = .ValidationScript
            strDefaultScript = .DefaultValueScript
            m_strCustomFieldList = .AccesibleCustomFields
        End With

        Response.Write("</DIV>")


        HttpContext.Current.Response.Write("####")
        CommonFunctions.General.WriteHTML(vbCrLf)

        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("function ValidateCustomFields(){")
        If Not declarevariables Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(declarevariables)
        End If


        If Not strClientSideScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strClientSideScript)
        End If
        If Not strDefaultScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strDefaultScript)
        End If
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("return true;}")
        CommonFunctions.General.WriteHTML(vbCrLf)
        'CommonFunctions.General.WriteHTML("</script>")
        'End Addition
        Response.End()
    End Sub
    'Public Sub PlotCustomFields(Optional ByVal USID As Integer = 0, Optional ByVal TaskTYpeID As String = "")
    '    '==================================================================================
    '    ' Procedure Name		:	PlotCustomFields
    '    ' Parameters Passed		:	To plot custom fields for Tasks
    '    ' Returns				:	none
    '    ' Parameters Affected	:	none
    '    ' Purpose				:	
    '    ' Description			:	Same as above.
    '    ' Assumptions			:	
    '    ' Dependencies			:	None
    '    ' Author				:	SandipL
    '    ' Created				:	20 Jan 2006
    '    ' Revisions				:	
    '    '==================================================================================

    '    Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
    '    Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
    '    Dim intDestinationIndex, intSourceIndex As Integer
    '    Dim drLayout As IDataReader
    '    Dim drCustomAccess As IDataReader
    '    Dim strSQLForCustom As String
    '    Dim strCustomFieldIDs() As String
    '    Dim intCount As Integer
    '    Dim intCorporateRoleLevel As Integer
    '    'Declare variables needed for security
    '    m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)

    '    If Not m_lngProjectId > 0 Then
    '        m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
    '    Else
    '        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    '        ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
    '        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
    '        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    '        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
    '            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
    '            'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
    '            m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
    '            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
    '        End If
    '    End If
    '    If Not m_lngRoleId > 0 Then
    '        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
    '    End If

    '    Dim UserID As String = ""
    '    m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
    '    UserID = m_lngUserId
    '    If UserID = 0 Then
    '        UserID = CType(HttpContext.Current.Session("intUserID"), Integer)
    '    End If
    '    Dim LoginType As String = ""
    '    If LoginType = "" Then
    '        LoginType = Session("LoginType").ToString()
    '    End If

    '    'Added By Amol Changle On: 22 Jul 2009
    '    'Purpose: For Entity "Help-Desk" ProjectID is considered to be 0.
    '    'Modified By Syamantak Chavan on 21 Sept 2011 For Custom Field addition in whizible 10.0
    '    If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
    '        m_lngProjectId = 0
    '    End If
    '    'End Addition

    '    m_strCustomFieldList = ""
    '    m_strTypeInaccessibleCustomFieldList = ""

    '    MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    '    'Get Accesible CustomFieldIDs List
    '    strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + UserID.ToString
    '    If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    '        strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
    '    End If

    '    'Added By Amol Changle On: 19 Aug 2009
    '    'Purpose: To handle Login Type specific issues
    '    strSQLForCustom += ",'" + LoginType + "'"
    '    'End Addition

    '    drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
    '    While drCustomAccess.Read
    '        ReDim Preserve strCustomFieldIDs(intCount)
    '        strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
    '        intCount += 1
    '    End While
    '    CommonFunction.Data.DisposeDataReader(drCustomAccess)


    '    ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
    '    'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

    '    If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
    '        m_strCurrentType = "NULL"
    '    Else
    '        m_strCurrentType = TaskTYpeID
    '    End If

    '    strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + m_strCurrentType

    '    If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
    '        'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
    '        strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
    '    Else
    '        'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
    '        strSQLQuery = strSQLQuery + ",'Task'"
    '    End If
    '    strSQLQuery = strSQLQuery + ",1," + UserID.ToString()


    '    'Added By Amol Changle On: 19 Aug 2009
    '    'Purpose: To handle Login Type specific issues
    '    strSQLQuery += ",'" + LoginType + "'"
    '    'End Addition

    '    'usp_Sel_tbl_PM_CustomFields_Master_MaxRows

    '    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
    '    If drLayout.Read Then
    '        m_intMaxRows = CType(drLayout("MaxRows"), Integer)
    '        m_intMaxCols = CType(drLayout("MaxCols"), Integer)
    '    End If
    '    CommonFunction.Data.DisposeDataReader(drLayout)

    '    'Start Plotting of Custom Fields
    '    'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
    '    HttpContext.Current.Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
    '    strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


    '    If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

    '    If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
    '    If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"

    '    'Added by ShraddhaM
    '    strSQLQuery = strSQLQuery + "," + UserID.ToString()
    '    'Ended by ShraddhaM

    '    'Added By Amol Changle On: 19 Aug 2009
    '    'Purpose: To handle Login Type specific issues
    '    strSQLQuery += ",'" + LoginType + "'"
    '    'End Addition


    '    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
    '    Call GetValidationRules()

    '    If drLayout.Read Then
    '        For intRow = 1 To m_intMaxRows
    '            'declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf

    '            'Added By Amol Changle On: 22 Jul 2009
    '            'Purpose: Not to render blank rows
    '            If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
    '                'End Addition
    '                HttpContext.Current.Response.Write("<TR class=clsTREven >")
    '                For intCol = 1 To m_intMaxCols
    '                    intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
    '                    intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

    '                    If intCurrentCellNumber < intNextCellNumber Then
    '                        HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
    '                    ElseIf intCurrentCellNumber >= intNextCellNumber Then
    '                        declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
    '                        'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
    '                        HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")
    '                        'get value form form
    '                        'If m_blnShowFormContents = True Then


    '                        If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
    '                            strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

    '                            'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
    '                            ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
    '                            'Save Database value also

    '                            If m_strPrimaryKeyID > 0 Then
    '                                'If Not rsIssueDetails.EOF Then
    '                                Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    '                                strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    '                                'End If
    '                            Else
    '                                strDummyFieldValue = ""
    '                            End If

    '                        Else
    '                            If m_strPrimaryKeyID > 0 Then
    '                                'If Not rsIssueDetails.EOF Then
    '                                Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
    '                                strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
    '                                'End If
    '                            Else
    '                                strFieldValue = ""
    '                            End If
    '                            strDummyFieldValue = strFieldValue
    '                        End If

    '                        'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

    '                        ' Retrieve the attributes of the control to be displayed.
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
    '                        'Modified By VarunA on 27-Sep-2008
    '                        'Purpose : Security Issue
    '                        'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
    '                        'End By VarunA on 27-Sep-2008
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
    '                        If (drLayout("DataType").ToString = "1") Then
    '                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
    '                            End If
    '                        End If

    '                        ' Set the control type depending on the name of the custom field to be displayed.
    '                        ' For Text Area custom fields...

    '                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

    '                            ' Set the maxlengths of the textareas.
    '                            'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

    '                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    '                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
    '                            End If

    '                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                            End If
    '                            'End If

    '                            intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
    '                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                            ' For Text Box custom fields...
    '                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    '                            ' Set the maxlengths of the textboxes.
    '                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                            End If

    '                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                            End If

    '                            ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
    '                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
    '                            End If

    '                            intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    '                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                            ' For Combo Box custom fields...									
    '                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
    '                            ''Added By Amol Changle On: 21 Jul 2009
    '                            ''Purpose: To select field details Entity Specific
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
    '                            ''End Addition

    '                            ' Set the maxlengths of the combobox.
    '                            'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
    '                            'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                            'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
    '                            '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
    '                            'End If
    '                            'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
    '                            '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                            'End If

    '                            intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
    '                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

    '                            ' For Date Control custom fields...								
    '                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

    '                            intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
    '                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



    '                        End If

    '                        ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
    '                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
    '                        If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
    '                        End If

    '                        ' If the default value is to be retrieved from one of the common fields or custom fields, then...
    '                        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

    '                            ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
    '                            If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

    '                                ' Get the index of the custom fields.
    '                                If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
    '                                    ' Text Area Range	: 26 - 28.
    '                                    intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
    '                                ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
    '                                    ' Text box Range	: 1 - 10.
    '                                    intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
    '                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
    '                                    ' Combo box Range	: 11 - 20.
    '                                    intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
    '                                ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
    '                                    ' Date control Range: 21 - 25.
    '                                    intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
    '                                End If

    '                                strEventHandlers = ""
    '                                strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    '                                strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    '                                strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

    '                                If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                                    strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
    '                                Else
    '                                    strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    '                                End If

    '                                strEventHandlers = strEventHandlers + "}" + vbCrLf

    '                                arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

    '                            End If

    '                            strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
    '                            strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
    '                            strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
    '                            strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

    '                            'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                            strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
    '                            'Else
    '                            '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
    '                            'End If

    '                            strDefaultScript = strDefaultScript + "}" + vbCrLf
    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

    '                            ' For Numweric custom fields...
    '                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then

    '                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

    '                            ' Set the maxlengths of the textboxes.
    '                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
    '                            End If

    '                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
    '                            End If


    '                            'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
    '                            intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
    '                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
    '                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


    '                        End If

    '                        HttpContext.Current.Response.Write(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))

    '                        HttpContext.Current.Response.Write("</td>")
    '                        HttpContext.Current.Response.Write("<td valign=top style='width:15%'>")


    '                        'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
    '                        Dim blnShowControl As Boolean = False
    '                        Dim intCounter As Integer

    '                        intCounter = 0
    '                        'If length of array is greater than 0 that means security is explicitly set
    '                        'In that case check if it is accessible ,if yes then show the control, 
    '                        'otherwise show it as not applicable
    '                        If intCount > 0 Then

    '                            While intCounter < intCount
    '                                'Check if the current Custom Field ID is in the array
    '                                If strCustomFieldIDs(intCounter).ToLower.Trim = _
    '                                            CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
    '                                    blnShowControl = True
    '                                    Exit While
    '                                End If

    '                                intCounter = intCounter + 1

    '                            End While

    '                        Else
    '                        End If

    '                        If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
    '                            m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
    '                            Call DrawControl(ArrCtlAttr)
    '                            Call ClearAttributes(ArrCtlAttr)
    '                        Else

    '                            If IsAddNewMode = True Then
    '                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
    '                            End If

    '                            'The Custom Field is not defied for the Current Type
    '                            HttpContext.Current.Response.Write("( " + MyBase.GetResourceString("NbyA") + " )")

    '                            'Do not save value if the Custom Field is not applicable
    '                            If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
    '                                m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","

    '                                '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    '                                CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, IsHidden:=True, EnableHTMLEncode:=True)
    '                            Else
    '                                CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , IsHidden:=True, EnableHTMLEncode:=True)
    '                            End If
    '                            CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
    '                            '''End of Modification by Dhanashri S on 7 Oct 2015 

    '                            ' reset value of inactive custom fields before saving.
    '                            strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
    '                        End If
    '                        HttpContext.Current.Response.Write("</TD>")
    '                        If Not drLayout.Read() Then
    '                            Dim i As Integer
    '                            For i = intCol To m_intMaxCols - 1
    '                                HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
    '                            Next
    '                            Exit For
    '                        End If
    '                    Else
    '                        HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
    '                        'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
    '                        If Not drLayout.Read() Then
    '                            Dim i As Integer
    '                            For i = intCol To m_intMaxCols - 1
    '                                HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
    '                            Next
    '                            Exit For
    '                        End If
    '                    End If
    '                Next
    '                HttpContext.Current.Response.Write("</TR>")
    '            End If
    '        Next
    '        If m_strCustomFieldList <> "" Then
    '            m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
    '        End If
    '        If m_strTypeInaccessibleCustomFieldList <> "" Then
    '            m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
    '        End If
    '        HttpContext.Current.Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
    '        CommonFunction.Data.DisposeDataReader(drLayout)

    '        Dim intCtr As Integer
    '        ' Loop through the array to check if any event handlers need to be printed.
    '        For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

    '            ' If the control name is present and the event handler is present, then print it.
    '            ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
    '            ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
    '            ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
    '            If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
    '                If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
    '                    HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
    '                Else
    '                    HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
    '                End If
    '                HttpContext.Current.Response.Write(arrEventHandlers(intCtr, 2))
    '                HttpContext.Current.Response.Write("}" + vbCrLf)
    '            End If
    '        Next
    '        HttpContext.Current.Response.Write("</SCRIPT>" + vbCrLf)
    '    Else
    '        HttpContext.Current.Response.Write("<tr class=clsTREven>")
    '        HttpContext.Current.Response.Write("<td align=center valign=center>")
    '        HttpContext.Current.Response.Write("<b>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</b>")

    '        HttpContext.Current.Response.Write("</td>")
    '        HttpContext.Current.Response.Write("</tr>")
    '    End If
    '    CommonFunction.Data.DisposeDataReader(drLayout)
    '    '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
    '    CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
    '    CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
    '    '''End of Modification by Dhanashri S on 7 Oct 2015 
    '    HttpContext.Current.Response.Write("</TABLE>")

    'End Sub 'Plot all custom fields for Issue
    Public Sub PlotCustomFields(Optional ByVal USID As Integer = 0, Optional ByVal TASKTYPEID As String = "")
        '==================================================================================
        ' Procedure Name		:	PlotCustomFields
        ' Parameters Passed		:	To plot custom fields for Tasks
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	17th Jan 2018
        ' Revisions				:	
        '==================================================================================

        Dim strSQLQuery As String, intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordCellNumber, intRecordRow, intRecordCol, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer
        Dim drLayout As IDataReader
        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer
        Dim intCorporateRoleLevel As Integer

        Dim m_lngRoleId As String = ""
        Dim m_lngProjectId As Integer = 0
        Dim m_strEntityName As String = "Task"

        Dim m_lngUserId As String = ""
        'Dim strSQLQuery As String = ""
        Dim m_strCurrentType As String = ""
        Dim m_strTypeInaccessibleCustomFieldList As String
        Dim m_strCustomFieldList As String
        Dim m_intMaxRows As Integer
        Dim m_intMaxCols As Integer
        Dim ArrCtlAttr(20) As String
        Dim arrEventHandlers(30, 3) As String
        Dim strFieldValue As String = ""
        Dim strDummyFieldValue As String = ""
        Dim m_strPrimaryKey As String = "TaskID"         'can have value TaskID,ScheduleID,ReviewID etc
        Dim m_strPrimaryTable As String = "tbl_PM_ProjectTasks"        'Table From which Custom field Values  to be retrived
        Dim m_strPrimaryKeyID As Long = 0
        Dim strEventHandlers As String
        Dim strDefaultScript As String
        'Dim strClientSideScript As String
        Dim m_blnShowDefaults As Boolean = False
        Dim declarevariables As String = ""
        Dim IsAddNewMode As Boolean = True
        Dim m_strFormName As String = "form1"
        Dim LoginType As String = ""
        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        m_strCurrentType = TASKTYPEID
        If Not m_lngProjectId > 0 Then
            m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
        Else

            ''intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_EmployeeID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)

            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then

                'm_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)

            End If
        End If
        If Not m_lngRoleId > 0 Then
            m_lngRoleId = CType(HttpContext.Current.Session("intPostID"), Integer)
        End If


        m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)

        If m_lngUserId = 0 Then
            m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
        End If
        If LoginType = "" Then
            LoginType = Session("LoginType").ToString()
        End If


        ' For Custom Field addition in whizible 10.0
        If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Modified by NitinC on 14 April 2011 for WhizibleSEM 10.0
            m_lngProjectId = 0
        End If


        m_strCustomFieldList = ""
        m_strTypeInaccessibleCustomFieldList = ""

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        'Get Accesible CustomFieldIDs List
        strSQLForCustom = "Exec usp_sel_tbl_PM_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleId.ToString + "," + m_lngUserId.ToString
        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            strSQLForCustom = strSQLForCustom + ",'" + m_strEntityName + "'"
        End If


        'Purpose: To handle Login Type specific issues
        strSQLForCustom += ",'" + LoginType + "'"


        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)
        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While
        CommonFunction.Data.DisposeDataReader(drCustomAccess)


        ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.
        'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_PM_CustomFields_Master WHERE ProjectID = " + m_lngProjectId.ToString + " AND Active = 1"

        If m_strCurrentType Is Nothing OrElse m_strCurrentType = "" Then
            m_strCurrentType = "NULL"
        End If

        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master_MaxRows " + m_lngProjectId.ToString + "," + m_strCurrentType

        If (m_strEntityName <> "" Or Not m_strEntityName Is Nothing) Then
            'strSQLQuery = strSQLQuery + " And EntityName = '" & m_strEntityName & "'"
            strSQLQuery = strSQLQuery + " ,'" & m_strEntityName & "'"
        Else
            'strSQLQuery = strSQLQuery + " And EntityName = 'Task'"
            strSQLQuery = strSQLQuery + ",'Task'"
        End If
        strSQLQuery = strSQLQuery + ",1," + m_lngUserId.ToString()



        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"


        'usp_Sel_tbl_PM_CustomFields_Master_MaxRows

        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drLayout.Read Then
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        'Start Plotting of Custom Fields
        '



        'HttpContext.Current.Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable >")
        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " + m_lngProjectId.ToString + ", NULL, 1"


        If IsNothing(m_strCurrentType) = True Then m_strCurrentType = ""

        If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        If m_strEntityName.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strEntityName + "'"


        strSQLQuery = strSQLQuery + "," + m_lngUserId.ToString()



        'Purpose: To handle Login Type specific issues
        strSQLQuery += ",'" + LoginType + "'"



        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'Call GetValidationRules()

        If drLayout.Read Then
            For intRow = 1 To m_intMaxRows
                declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf

                'Added By Amol Changle On: 22 Jul 2009
                'Purpose: Not to render blank rows
                If CommonFunctions.Data.CheckIsDBNull(drLayout("RowNumber")) = intRow.ToString() Then
                    'End Addition


                    ' HttpContext.Current.Response.Write("<TR class=clsTREven >")

                    For intCol = 1 To m_intMaxCols
                        intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
                        intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

                        If intCurrentCellNumber < intNextCellNumber Then
                            ' HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")

                        ElseIf intCurrentCellNumber >= intNextCellNumber Then
                            declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('" & m_strFormName & "','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                            'HttpContext.Current.Response.Write("<td valign=top align=right style='width:10%'>")
                            'HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")

                            HttpContext.Current.Response.Write("<td valign=top align=right width='5%'>")


                            'If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                            '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                            'End If



                            'get value form form
                            'If m_blnShowFormContents = True Then


                            If Not HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString) Is Nothing Then
                                strFieldValue = HttpContext.Current.Request.Form(drLayout("DatabaseFieldName").ToString)

                                'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
                                ' Added checkisdbNull to get strDummyFieldValue and strFieldValue
                                'Save Database value also

                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strDummyFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strDummyFieldValue = ""
                                End If

                            Else
                                If m_strPrimaryKeyID > 0 Then
                                    'If Not rsIssueDetails.EOF Then
                                    Dim strSQL As String = " Select " & drLayout("DatabaseFieldName").ToString & " From " & m_strPrimaryTable & " where " & m_strPrimaryKey & " = " & m_strPrimaryKeyID
                                    strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "").ToString
                                    'End If
                                Else
                                    strFieldValue = ""
                                End If
                                strDummyFieldValue = strFieldValue
                            End If

                            'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes  

                            ' Retrieve the attributes of the control to be displayed.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
                            'Modified By VarunA on 27-Sep-2008
                            'Purpose : Security Issue
                            'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(Server.HtmlEncode(drLayout("UserGivenCaption")), "").ToString
                            'End By VarunA on 27-Sep-2008
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = strFieldValue
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"
                            If (drLayout("DataType").ToString = "1") Then
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "3,"
                                End If
                            End If

                            ' Set the control type depending on the name of the custom field to be displayed.
                            ' For Text Area custom fields...

                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

                                ' Set the maxlengths of the textareas.
                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 3800 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "3800"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If
                                'End If

                                intDestinationIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Text Box custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If

                                ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
                                If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"
                                End If

                                intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Combo Box custom fields...									
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_PM_CustomFields_Details '" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_lngProjectId.ToString
                                ''Added By Amol Changle On: 21 Jul 2009
                                ''Purpose: To select field details Entity Specific
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY) += ",1,'" + m_strEntityName + "'"
                                ''End Addition

                                ' Set the maxlengths of the combobox.
                                'If Not IsNumeric(ArrCtlAttr(ATTR_MAX_LENGTH)) Then
                                'ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                'ElseIf CInt(ArrCtlAttr(ATTR_MAX_LENGTH)) > 100 Then
                                '    ArrCtlAttr(ATTR_MAX_LENGTH) = 100
                                'End If
                                'If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                '    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                'End If

                                intDestinationIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

                                ' For Date Control custom fields...								
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH) = "80"

                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)



                            End If

                            ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
                            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "False"
                            If InStr("," + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                            End If



                            ' If the default value is to be retrieved from one of the common fields or custom fields, then...
                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

                                ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
                                If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) Then

                                    ' Get the index of the custom fields.
                                    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
                                        ' Text Area Range	: 26 - 28.
                                        intSourceIndex = 27 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
                                    ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
                                        ' Text box Range	: 1 - 10.
                                        intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
                                        ' Combo box Range	: 11 - 20.
                                        intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
                                    ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
                                        ' Date control Range: 21 - 25.
                                        intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
                                    End If

                                    strEventHandlers = ""
                                    strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                    strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

                                    If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                        strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
                                    Else
                                        strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                    End If

                                    strEventHandlers = strEventHandlers + "}" + vbCrLf

                                    arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

                                End If

                                strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('" & m_strFormName & "','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "');" + vbCrLf
                                strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
                                strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

                                'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                                strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
                                'Else
                                '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                                'End If

                                strDefaultScript = strDefaultScript + "}" + vbCrLf
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) = ""

                                ' For Numweric custom fields...
                            ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldNumeric", CompareMethod.Text) > 0 Then
                                HttpContext.Current.Response.Write("<div class='col-sm-6'>")
                                ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                                ' Set the maxlengths of the textboxes.
                                If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) Or ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "0" Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) > 100 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) = "100"
                                End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES), "3,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES) + "12,"
                                End If


                                'intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(Customer.CCommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                                intDestinationIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), Len("CustomFieldNumeric") + 1, 2))
                                arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
                                arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)


                            End If

                            'HttpContext.Current.Response.Write(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION))

                            If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
                                HttpContext.Current.Response.Write("<label class='clsCaption control-label labelcls'>" + drLayout("UserGivenCaption").ToString.Trim + " <span class='required'>*</span></label>") '  sbTasksHTML.Append("<span class='required'>*</span></TD>")
                            Else
                                HttpContext.Current.Response.Write("<label class='clsCaption control-label labelcls'>" + drLayout("UserGivenCaption").ToString.Trim + " </label>")
                            End If
                            'HttpContext.Current.Response.Write("</td>")
                            'HttpContext.Current.Response.Write("<td valign=top style='width:15%'>")


                            'HttpContext.Current.Response.Write("<td valign=top bgcolor=green >")
                            Dim blnShowControl As Boolean = False
                            Dim intCounter As Integer

                            intCounter = 0
                            'If length of array is greater than 0 that means security is explicitly set
                            'In that case check if it is accessible ,if yes then show the control, 
                            'otherwise show it as not applicable
                            If intCount > 0 Then

                                While intCounter < intCount
                                    'Check if the current Custom Field ID is in the array
                                    If strCustomFieldIDs(intCounter).ToLower.Trim =
                                                CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
                                        blnShowControl = True
                                        Exit While
                                    End If

                                    intCounter = intCounter + 1

                                End While

                            Else
                            End If

                            If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
                                m_strCustomFieldList = m_strCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","
                                Call DrawControl(ArrCtlAttr)
                                Call ClearAttributes(ArrCtlAttr)
                            Else

                                If IsAddNewMode = True Then
                                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
                                End If

                                'The Custom Field is not defied for the Current Type
                                HttpContext.Current.Response.Write("( " + MyBase.GetResourceString("NbyA") + " )")

                                'Do not save value if the Custom Field is not applicable
                                If drLayout("IsCustomFieldAssigned").ToString <> "1" And blnShowControl = True Then
                                    m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ","


                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , strDummyFieldValue, IsHidden:=True, EnableHTMLEncode:=True)
                                Else
                                    CommonFunction.HTMLControls.DrawTextBox("Dummy" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , , IsHidden:=True, EnableHTMLEncode:=True)
                                End If
                                CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)


                                ' reset value of inactive custom fields before saving.
                                strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
                            End If
                            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "Select 'Request Type'", , , "class='form-control' onchange=RequestType_OnChange(this)", False, True))
                            HttpContext.Current.Response.Write("</div>")


                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        Else
                            ' HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 style='width:20%'>&nbsp;</td>")
                            'HttpContext.Current.Response.Write("<td valign=top align=right colspan=2 >&nbsp;</td>")
                            If Not drLayout.Read() Then
                                Dim i As Integer
                                For i = intCol To m_intMaxCols - 1
                                    '  HttpContext.Current.Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        End If
                    Next
                    HttpContext.Current.Response.Write("</div>")
                    HttpContext.Current.Response.Write("</div>")
                    ' HttpContext.Current.Response.Write("</TR>")
                End If
            Next
            If m_strCustomFieldList <> "" Then
                m_strCustomFieldList = m_strCustomFieldList.Substring(0, m_strCustomFieldList.Length - 1)
            End If
            If m_strTypeInaccessibleCustomFieldList <> "" Then
                m_strTypeInaccessibleCustomFieldList = m_strTypeInaccessibleCustomFieldList.Substring(0, m_strTypeInaccessibleCustomFieldList.Length - 1)
            End If
            HttpContext.Current.Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
            CommonFunction.Data.DisposeDataReader(drLayout)

            Dim intCtr As Integer
            ' Loop through the array to check if any event handlers need to be printed.
            For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)

                ' If the control name is present and the event handler is present, then print it.
                ' arrEventHandlers(intCtr, 0) -> Custom Field Name.
                ' arrEventHandlers(intCtr, 1) -> Custom Field Control Type.
                ' arrEventHandlers(intCtr, 2) -> Custom Field Event Handler script.
                If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
                    If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
                    Else
                        HttpContext.Current.Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
                    End If
                    HttpContext.Current.Response.Write(arrEventHandlers(intCtr, 2))
                    HttpContext.Current.Response.Write("}" + vbCrLf)
                End If
            Next
            HttpContext.Current.Response.Write("</SCRIPT>" + vbCrLf)
        Else
            HttpContext.Current.Response.Write("<tr class=clsTREven>")
            HttpContext.Current.Response.Write("<td align=center valign=center>")
            HttpContext.Current.Response.Write("No Custom fields has be defined")

            HttpContext.Current.Response.Write("</td>")
            HttpContext.Current.Response.Write("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        CommonFunctions.HTMLControls.DrawTextBox("CustomFieldList", "CustomFieldList", , , , m_strCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("TypeInaccessibleCustomFieldList", "TypeInaccessibleCustomFieldList", , , , m_strTypeInaccessibleCustomFieldList, IsHidden:=True, EnableHTMLEncode:=True)

        HttpContext.Current.Response.Write("</TABLE>")


        HttpContext.Current.Response.Write("####")

        Dim objNewRequest As New frmSprintPlanning()
        Dim m_intCustomer As Integer = 0
        Dim m_intRequestedEmployee As Integer = 0
        Dim m_strMode As String = "NEW"



        Dim objAddNewRequest1 As New frmSprintPlanning
        Dim arrtemp(50) As String
        arrValidationMessages.CopyTo(arrtemp, 0)
        Dim drCustomField As IDataReader
        ' HttpContext.Current.Response.Write(objNewRequest.GenerateValidationScript1(ArrCtlAttr, arrtemp))
        strSQLQuery = "usp_Sel_tbl_PM_CustomFields_Master " & CType(HttpContext.Current.Session("intProjectID"), Integer) & ",NULL,1," & m_strCurrentType & ",'Task'," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & LoginType & "'"
        drCustomField = CommonFunction.Data.GetDataReader(strSQLQuery, True)


        objAddNewRequest1.GetValidationRules()
        objAddNewRequest1.arrValidationMessages.CopyTo(arrtemp, 0)
        Dim strControlName As String
        Dim intControlWidth As String
        Dim strControlCaption As String
        Dim strControlValue As String
        Dim intControlMaxLength As String
        Dim intControlHeight As String
        Dim strDataType As String
        Dim strControlValidationRules As String
        Dim intControlMinValue As String
        Dim intControlMaxValue As String
        Dim strToBeInserted As String
        Dim SQLQuey As String
        Dim blnIsMandatory As String
        Dim strControlValidations As New StringBuilder("")
        While drCustomField.Read

            strControlName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlWidth = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlWidth"), ""), "")
            strControlCaption = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("UserGivenCaption"), ""), "")
            strControlValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DefaultValue"), ""), "")
            'strToBeInserted = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            'blnIsMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DatabaseFieldName"), ""), "")
            intControlMaxLength = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxLength"), "0"), "0")
            intControlHeight = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ControlHeight"), "0"), "0")

            intControlMinValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MinValue"), "0"), "0")
            intControlMaxValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("MaxValue"), "0"), "0")
            strDataType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("DataType"), "0"), "0")

            strControlValidationRules = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drCustomField("ValidationRules"), ""), "")
            strToBeInserted = "disabled"
            SQLQuey = "Exec usp_Sel_tbl_PM_CustomFields_Details  " & strControlName & ",0,1,'Task'"
            blnIsMandatory = False

            If InStr("," + strControlValidationRules.ToString.Trim, ",1,") <> 0 Then
                blnIsMandatory = True
            End If

            If Not IsNumeric(intControlMaxLength) Or intControlMaxLength = "0" Then
                intControlMaxLength = "100"
            ElseIf InStr(drCustomField("DatabaseFieldName").ToString.Trim, "CustomFieldTextArea") > 0 Then
                If (intControlMaxLength > "3800") Then
                    intControlMaxLength = "3800"
                End If
            Else
                If (intControlMaxLength > "100") Then
                    intControlMaxLength = "100"
                End If
            End If


            If intControlWidth = "" Then
                intControlWidth = "200"
            End If


            Dim blnShowControl As Boolean = False
            Dim intCounter As Integer

            intCounter = 0
            'If length of array is greater than 0 that means security is explicitly set
            'In that case check if it is accessible ,if yes then show the control, 
            'otherwise show it as not applicable
            If intCount > 0 Then

                While intCounter < intCount
                    'Check if the current Custom Field ID is in the array
                    If strCustomFieldIDs(intCounter).ToLower.Trim =
                                CType(CommonFunction.General.CheckIsNothing(drCustomField("UniqueId")), String).ToLower.Trim Then
                        blnShowControl = True
                        Exit While
                    End If

                    intCounter = intCounter + 1

                End While

            Else
            End If



            HttpContext.Current.Response.Write(objAddNewRequest1.GenerateValidationScript(strControlValidationRules, strControlName, strControlCaption, intControlMinValue, intControlMaxValue, intControlMaxLength, strControlValidations, arrtemp))


        End While




    End Sub 'Plot all custom fields for Issue
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
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer
        Dim strControlCaption As String
        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False
        Dim IsAddNewMode As Boolean
        ' strControlCaption = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)

        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        '        If (IsAddNewMode = True And HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing) Then
        If (IsAddNewMode = True) Then
            ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE)

            'If strControlValue = "" And Not HttpContext.Current.Request(QueryStringForTypeChange) Is Nothing Then
            '    If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE) Is Nothing Then
            '        strControlValue = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_DEFAULT_VALUE)
            '    End If
            'End If

        Else
            strControlValue = ""
        End If

        ' Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH)) <> "" Then
            ' intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_WIDTH), Integer)
            intControlWidth = "200"
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" Then
            intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH), Integer)
            'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If


        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE)

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.

                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , False))

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SQL_QUERY)
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , False))

            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.

                'Modified By ShraddhaM on 27 July 2006
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , m_strFormName, , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft"))
                HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, strControlCaption, , , "", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , False, Wrap:="Soft", EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.PM_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" And strControlValue <> "0" Then
                    ' HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    HttpContext.Current.Response.Write("<input type='text' value='' class='form-control inp clsDateControl' id=" + strControlName + ">")
                    HttpContext.Current.Response.Write(" <div class='col-sm-4'>")
                    HttpContext.Current.Response.Write("<i class='fa fa-calendar fcalcustom' id='ContractDate1' style='font-size: 14px;' onclick=""$('#" + strControlName + "').datepicker();$('#" + strControlName + "').datepicker('show');""></i>")
                    HttpContext.Current.Response.Write("</div>")
                Else
                    'HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    HttpContext.Current.Response.Write("<input type='text' value='' class='form-control inp clsDateControl' id=" + strControlName + ">")
                    HttpContext.Current.Response.Write(" <div class='col-sm-4'>")
                    HttpContext.Current.Response.Write("<i class='fa fa-calendar fcalcustom' id=" + strControlName + " style='font-size: 14px;' onclick=""$('#" + strControlName + "').datepicker();$('#" + strControlName + "').datepicker('show');""></i>")
                    HttpContext.Current.Response.Write("</div>")
                End If

            Case Else
                HttpContext.Current.Response.Write("&nbsp;")

        End Select
        'Commented and added by Bharat T on 13th-Oct-2015
        'Dim arrtemp(30) As String
        Dim arrtemp(50) As String
        'End of Commented and added by Bharat T on 13th-Oct-2015
        arrValidationMessages.CopyTo(arrtemp, 0)

        'Generate the client side validation scripts for the control.		
        'Call GenerateValidationScript1(ArrCtlAttr, arrtemp)
        'HttpContext.Current.Response.Write(ArrCtlAttr(ATTR_CONTROL_NAME) + ArrCtlAttr(ATTR_READ_ONLY))

        ' If the control is disabled, then enable it before submitting.
        'If ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "True" Then
        '    If InStr(ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME).ToString.Trim, "Keywords") <> 0 Then
        '        strEnableControlsScript = "var obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "= GetObjectReference('frmTaskAssignment','" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "',1);" + vbCrLf
        '        For intCtr = 0 To 4
        '            strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + "(" + intCtr.ToString + ").disabled = false;" + vbCrLf
        '        Next
        '    Else
        '        strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ".disabled = false;" + vbCrLf
        '    End If
        'End If

    End Sub 'Draw the control 

    Public Function GenerateValidationScript1(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
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
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer
        Dim strCaption As String
        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_VALIDATION_RULES).Trim, ",")
        strCaption = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION)
        If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
            Exit Function
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)
            Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MIN_VALUE)
            Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_VALUE)

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														

                    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				

                    If InStr(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_CAPTION), "'") > 0 Then
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                    Else
                        strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                    End If

                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return;" + vbCrLf
                    strValidation = strValidation + "}}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "" And Trim(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)) <> "0" Then
                        strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_MAX_LENGTH) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.				
                    strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.

                    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                End If
                strValidation = strValidation + "return false;" + vbCrLf
                strValidation = strValidation + "}" + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
            strClientSideScript = strClientSideScript + strValidation
        ElseIf UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_NAME)) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        End If

    End Function
    'Private Sub GetValidationRules()
    '    '==================================================================================
    '    ' Procedure Name		:	GetValidationRules
    '    ' Parameters Passed		:	To get all the validation messages in an array
    '    ' Returns				:	none
    '    ' Parameters Affected	:	none
    '    ' Purpose				:	
    '    ' Description			:	Same as above.
    '    ' Assumptions			:	
    '    ' Dependencies			:	None
    '    ' Author				:	SandipL
    '    ' Created				:	20 Jan 2006
    '    ' Revisions				:	
    '    '==================================================================================		

    '    Dim drValidationRules As IDataReader

    '    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    '    ' Retrieve all the validation messages.
    '    '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
    '    drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

    '    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

    '    'Save all these validation messages in array
    '    Do While drValidationRules.Read
    '        arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
    '    Loop

    '    'Dispose data reader
    '    CommonFunction.Data.DisposeDataReader(drValidationRules)
    'End Sub 'Get all validation rules and generate array
    Private Function GetCaption(ByVal TagID As Long, ByVal ControlName As String) As String
        '=====================================================================
        ' Procedure Name        : GetCaption
        ' Description           : gets the caption for the control & tagid
        ' Purpose               : same as above
        ' Parameters Passed     : control name
        ' Returns               : the caption for the control name
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : usp_CRM_Get_Tag_Attribute_Caption
        ' Author                : Rajanikant
        ' Created               : Feb 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Tag_Attribute_Caption  " & TagID & ",'" & CommonFunctions.General.BuildQueryString(ControlName) & "'", True)
        If dr.Read Then
            ' the caption returned by the sp
            GetCaption = dr("ControlCaption").ToString
        Else
            ' send the same name back
            GetCaption = ControlName
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
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
        ' Author				:	SandipL
        ' Created				:	19 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes
    Public Function GenerateValidationScript(ByVal strControlValidationRules As String, ByVal strControlName1 As String, ByVal strControlCaption As String, ByVal intControlMinValue As String, ByVal intControlMaxValue As String, ByVal intControlMaxLength As Integer, ByRef strControlValidations As StringBuilder, ByVal arrValidations() As String)
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
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer
        Dim strCaption As String
        '   Dim strClientSideScript As String
        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(strControlValidationRules, ",")
        strCaption = strControlCaption
        If InStr(strControlName1, "Keywords") <> 0 Then
            Exit Function
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = arrValidationMessages(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", strCaption)
                'End If
            Else
                intValidationID = 0
            End If

            Dim blnLoopcheck As Boolean = False
            Dim strControlName As String = strControlName1
            Dim strMinValue As String = intControlMinValue
            Dim strMaxValue As String = intControlMaxValue
            If (CType(intValidationID, String) <> "" And CType(intValidationID, String) <> "0") Then
                strValidation = strValidation + "if(obj" + strControlName + " != null) " + vbCrLf
                strValidation = strValidation + "{ " + vbCrLf
            End If

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowBlank(obj" + strControlName + ")== true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(1), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + " return;" + vbCrLf
                    'arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_SHOW_AS_MANDATORY) = "True"
                    blnLoopcheck = True
                Case "2" ' Valid Date.				
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    If InStr(strControlCaption, "'") > 0 Then
                        ''  strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",""" + arrValidations(2) + """,false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + " ', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                    Else
                        ' strValidation = strValidation + "   if(!isDate(obj" + strControlName + ",'" + arrValidations(2) + "',false){" + vbCrLf
                        strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                    End If

                    strValidation = strValidation + "       if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf
                    '  'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                    '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    'End If

                    strValidation = strValidation + "      if(!isDate(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(2), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    strValidation = strValidation + "   }}}" + vbCrLf

                Case "3" ' Numeric Data.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonNumeric(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(3), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "9" ' Only Alphabets.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNonAlphabets(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(9), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "12" ' Max Length
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                    If Trim(intControlMaxLength) <> "" And Trim(intControlMaxLength) <> "0" Then
                        '  strValidation = strValidation + "   if(disallowMaxlengthViolation(obj" + strControlName + "," + CType(intControlMaxLength, String) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", intControlMaxLength), False) + "',false)){" + vbCrLf
                        strValidation = strValidation + "       if(disallowMaxlengthViolation(obj" + strControlName + ")==true){" + vbCrLf
                        strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                        strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(12), False) + "', 'error');" + vbCrLf
                        strValidation = strValidation + "       return;" + vbCrLf
                        strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + CType(intControlMaxLength, String) + ");" + vbCrLf
                        blnLoopcheck = True
                    End If

                    'End If

                Case "13" ' Positive Numeric Data.	
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowNegativeNumeric(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(13), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '     strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowSpecialCharacters(obj" + strControlName + ")==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(15), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "16" ' Minimum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMinValueViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(16), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case "17" ' Maximum Value Check.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    '  strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowMaxValueViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(17), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True
                Case "18" ' Value Range.
                    strValidation = strValidation + "   if(obj" + strControlName + ".disabled == false) " + vbCrLf
                    strValidation = strValidation + "   { " + vbCrLf
                    ' strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "       if(disallowValueRangeViolation(obj" + strControlName + "))==true){" + vbCrLf
                    strValidation = strValidation + "alertify.set('notifier', 'position', 'top-right');" + vbCrLf
                    strValidation = strValidation + "  alertify.notify('" + CommonFunction.General.FormatString(arrValidations(18), False) + "', 'error');" + vbCrLf
                    strValidation = strValidation + "       return;" + vbCrLf
                    blnLoopcheck = True

                Case Else
            End Select
            If blnLoopcheck = True Then

                'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
                '    strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                'End If
                strValidation = strValidation + "	        setFocus(obj" + strControlName + ");" + vbCrLf
                strValidation = strValidation + "           return false;" + vbCrLf
                strValidation = strValidation + "       }" + vbCrLf
                strValidation = strValidation + "   } " + vbCrLf
                strValidation = strValidation + "} " + vbCrLf
            End If
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        'If arrCtlAttr(CommonFunction.Constants.PM_ControlAttributes.APP_PM_ATTR_READ_ONLY) = "False" Then
        '    strClientSideScript = strClientSideScript + strValidation
        'Else
        If UCase(strControlName1) = "SUMMARY" Or UCase(strControlName1) = "REPORTEDBY" Or UCase(strControlName1) = "DESCRIPTION" Then
            strClientSideScript = strClientSideScript + strValidation
        Else
            strClientSideScript = strClientSideScript + strValidation
        End If

    End Function
    Protected Sub GetValidationRules()
        '==================================================================================
        ' Procedure Name		:	GetValidationRules
        ' Parameters Passed		:	To get all the validation messages in an array
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	SandipL
        ' Created				:	20 Jan 2006
        ' Revisions				:	
        '==================================================================================		

        Dim drValidationRules As IDataReader

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        ' Retrieve all the validation messages.
        '  drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
        drValidationRules = CommonFunction.Data.GetDataReader("usp_SEL_tbl_UI_Validation ", MyBase.UseSQL)

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'Save all these validation messages in array
        Do While drValidationRules.Read
            arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
        Loop

        'Dispose data reader
        CommonFunction.Data.DisposeDataReader(drValidationRules)
    End Sub 'Get all validation rules and generate array


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
            Dim objfrmReleasePlanning As New frmSprintPlanning()
            If (SelectedTab = "History") Then
                strHTML.Append(objfrmReleasePlanning.History_sectionSprintRelease(UniqueID, Flag))
            ElseIf (SelectedTab = "Discussions") Then
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

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntryValidation(ByVal UserStoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim ValidationResponseText As New StringBuilder
            ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            Dim strQuery As String
            Dim strMessage As String = ""
            strQuery = "Exec usp_ScrumEntityDeleteValidationNew 'UserStory','" + UserStoryID + "'"
            Dim drEntityValidation As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strQuery)
            If (drEntityValidation.HasRows) Then
                While (drEntityValidation.Read())
                    ValidationResponseText.Append(drEntityValidation(0).ToString())
                End While
            Else
            End If
            Return ValidationResponseText.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntry(ByVal UserStoryID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SwapnilA
        ' Created				:   4-JAN-2017
        '=====================================================================

        Dim strQuery As String = "usp_Del_ScrumEntity 'UserStory','" + UserStoryID + "'"
        Dim strDelete As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        Dim objBacklog As New frmProductBacklog
        'strHTML.Append(frmReleasePlanning.PlotSubUserStoryList(UserStoryID))
        If (Flag = "SubUS") Then
            Return New frmProductBacklog().PlotSubUserStoryList(UserStoryID)
        Else
            Return RefreshGrid(UserStoryID)
        End If

    End Function
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
