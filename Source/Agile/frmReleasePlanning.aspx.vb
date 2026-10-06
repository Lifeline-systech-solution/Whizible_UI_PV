Imports System.Xml
Imports System.IO
Imports System.Runtime.InteropServices




Public Class frmReleasePlanning
    Inherits WebPages.Template.WhizTemplate
    Public projectID As String = ""
    Public IterationID As String = ""
    Public IterationName As String = ""
    Public tooltip As String = ""
    Public StartDate As String = ""
    Public EndDate As String = ""
    Public PlannedEffort As String = ""
    Public ActualEffort As String = ""
    Public DoListCount As String = ""
    Public InProgressCount As String = ""
    Public DoneCount As String = ""
    Public DiscussionCount As String = ""
    Public ReviewCount As String = ""
    Public ReleaseID As String = ""
    Public NoOfDays As String = ""
    Public UserID As String = ""
    Public IterationStatus As String = ""
    Public SelectedReleaseid As String = ""
    Public SelectedFlag As String = ""
    Public CurrentIterationID As String = ""
    'For Grid
    Private WithEvents objAttachList As New WebPages.Template.GenericGrid
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

    Protected Shared m_lngReportID As Integer = 20143
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    'End For Grid
    'For US
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
    Public globalUSID As String = ""
    Protected Shared globalUSID1 As String = ""
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
    Protected objClsCommon As New clsCommon

    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
    Protected HMSprintVelocity As String = ""
    Protected m_RestrictByMinHours As String
    Protected m_MinHoursForDAEntry As String
    'End of adding by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

    'Added by Usha Pandit on 08-Apr-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
    Protected strInputFormat As String
    Protected strDateFormat As String
    'End of Added by Usha Pandit on 08-Apr-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        projectID = Session("intProjectID")
        UserID = Session("intUserID")

        CurrentIterationID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select dbo.fn_NG2_Sel_CurrentIterationOrRelease (" & projectID & ",'RELEASE')", True), "")
        If Request.Params("Mode") = "Upload" Then
            If Request.Params("Flag") = "UserStory" Then
                UploadData("UserStory")
            ElseIf Request.Params("Flag") = "Sprint" Or Request.Params("Flag") = "Iteration" Then
                UploadData("Iteration")
            ElseIf Request.Params("Flag") = "Release" Then
                UploadData("Release")
            End If
        End If

        ''Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
            m_MinHoursForDAEntry = CommonFunction.Data.CheckIsDBNull(drCompany("MinHoursForDAEntry"), "0")
        End If
        drCompany.Close()
        drCompany.Dispose()

        ''End of Added By Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

        'Added by Usha Pandit on 08-Apr-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date
        Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)

        Dim DateFormat As String = "usp_sel_tbl_pm_dateformats_FormatDate " + CType(dateFormatID, String)

        strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
        strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)
        'End of Added by Usha Pandit on 08-Apr-2019 Purpose::Set Input Date Format for Sprint Start Date and End Date

    End Sub
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
    Public Function ReleasePlanning(ByVal Flag As String, ByVal IterationID As String, Optional ByVal USID As String = "", Optional ByVal FilterFlag As String = "") As String
        '*******************************************************************************'
        ' Function Name	        :	ReleasePlanning                                            '
        ' Purpose				:   Plotting Release                 '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande 
        'Date                   :   28th Feb 2018'
        '*******************************************************************************'
        Dim strHTML As New StringBuilder()
        GetAccessRights()
        projectID = Session("intProjectID")        'Added by Usha Pandit on 01 June 2018 to fix sprint / release save issue
        If CurrentIterationID <> "" Then
            IterationID = CurrentIterationID
        Else
            IterationID = IterationID
        End If

        If USID <> "" Then
            USID = USID
        Else
            USID = ""
        End If

        If FilterFlag <> "" Then
            FilterFlag = FilterFlag
        Else
            FilterFlag = ""
        End If
        If Flag <> "AfterTerminateSprint" Then
            strHTML.Append("<div id='MainDiv'>" & vbCrLf)
        End If

        strHTML.Append("<div class='container-fluid'>" & vbCrLf)
        strHTML.Append("<div class='row'>" & vbCrLf)
        strHTML.Append("<div class='col-sm-12 fixed-top'>" & vbCrLf)
        strHTML.Append("<div class='col-md-4 col-sm-12' style='margin-top: 13px;'>" & vbCrLf)
        strHTML.Append("<p class='title'>Release Planning</p>" & vbCrLf)
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-8 col-sm-12'  style='margin-top:10px; '>" & vbCrLf)
        strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")
        strHTML.Append("<input type='hidden' value='" & IterationID & "' id='hdnReleaseID' />")
        'Filter
        strHTML.Append("<div class='btn-group' style='float:right;margin-right: 4px;z-index:999;'>")
        strHTML.Append("<div class='dropdown' >")

        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<i class='fa fa-filter filter' data-bs-toggle='dropdown' title='Filter' data-placement='bottom' style='font-size: 16px !important;'></i>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle

        strHTML.Append("<ul class=' dropdown-menu filter-menu' >")
        strHTML.Append("<li class='clsli' onclick=FilterUSData('CurrentRelease')>")
        strHTML.Append("&nbsp;&nbsp;Current Release")
        strHTML.Append("</li>")
        strHTML.Append("<li class='clsli' onclick=FilterUSData('CurrentSprint',this)>")
        strHTML.Append("&nbsp;&nbsp;Current Sprint")
        strHTML.Append("</li>")
        strHTML.Append("<li class='clsli' onclick=FilterUSData('UserStory',this)>")
        strHTML.Append("&nbsp;&nbsp;User stories")
        strHTML.Append("</li>")
        strHTML.Append("<li class='clsli' onclick=FilterUSData('Sprint',this)>")
        strHTML.Append("&nbsp;&nbsp;Sprint")
        strHTML.Append("</li>")
        strHTML.Append("<li class='clsli' onclick=FilterUSData('Release1',this)>")
        strHTML.Append("&nbsp;&nbsp;Release")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Create dropdown
        If strIsPrductOwner = "1" Then

            strHTML.Append("<div class='dropdown'  style='float:right;    margin-right: 8px;' >")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button class='btn btn-info dropdown-toggle'  type='button'  data-bs-toggle='dropdown' style='margin-top: 8px;'>Create &nbsp;<span class='caret'></span> </button>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul class='dropdown-menu createbtn' style='margin-left: -55px;'>")
            'strHTML.Append("<li><a href='#' onclick=ShowModal('User','',this) >&nbsp;User Story</a></li>")
            strHTML.Append("<li onclick=ShowModal('Sprint','',this)>Sprint</li>")
            strHTML.Append("<li onclick=ShowModal('Release','',this)>Release</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")
        End If

        'legends

        strHTML.Append("  <div class='btn-group dropdown'  id='divHeaderLeftSection'  style=' float:right;margin-right: -27px;' >")
        strHTML.Append("<div class='row' >")
        strHTML.Append("  <div class='col-sm-12' style='display:flex;'>")
        ' /* Modified By Madhuri.K On 03-04-2026 */ 
        strHTML.Append("  <p class='col-sm-3'  style=' font-size: 11.5px; color: GREY;white-space: nowrap;' ><label class=' green_bar'  style=' width: 2px;height: 18px;background-color: #c73c14;margin-bottom: -4px!important;margin-left: -19px;border-radius: 9px;' ></label>&nbsp;Delayed With Issue </p>")
        strHTML.Append("    <p class='col-sm-2'  style=' font-size: 11.5px; color: grey;white-space: nowrap; width: 10.333333%!important;' ><label class=' green_bar'  style='    width:  2px;  height:  18px; background-color: orange;margin-bottom:  -4px!important; margin-left: -10px;  border-radius: 9px;' ></label>&nbsp;Issue </p>")
        strHTML.Append("<p class='col-sm-2'  style=' font-size: 11.5px; color: grey;white-space: nowrap;width: 13%!important;' ><label class=' green_bar'  style='    width:  2px;  height:  17px; background-color:#1497c7;margin-bottom:  -4px!important; margin-left: -10px;  border-radius: 9px;' ></label>&nbsp;Delayed </p>")
        strHTML.Append("  <p class='col-sm-2'  style=' font-size: 11.5px; color: grey;white-space: nowrap;width: 15%;!important' ><label class=' green_bar'  style='    width:  2px;  height: 17px; background-color: Yellow;margin-bottom:  -4px!important; margin-left: -10px;  border-radius: 9px;' ></label>&nbsp;In Control </p>")
        'Commented and Added By Usha Pandit on 05 Jun 2018 for changing caption Ready For Release with Ready To Complete
        'strHTML.Append("  <p class='col-sm-3'  style=' font-size: 11.5px; color: grey;white-space: nowrap;' ><label class=' green_bar'  style='    width:  2px;  height: 17px; background-color: #14c751;margin-bottom:  -4px; margin-left: -10px;  border-radius: 9px;' ></label>&nbsp;Ready For Release </p>")
        ' /* Modified By Madhuri.K On 03-04-2026 */ 
        strHTML.Append("  <p class='col-sm-3'  style=' font-size: 11.5px; color: grey;white-space: nowrap;' ><label class=' green_bar'  style='    width:  2px;  height: 17px; background-color: #14c751;margin-bottom:  -4px!important; margin-left: -10px;  border-radius: 9px;' ></label>&nbsp;Ready To Complete </p>")
        'End of Added By Usha Pandit on 05 Jun 2018 for changing caption Ready For Release with Ready To Complete

        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>") 'End row


        'strHTML.Append("<div class='row'>" & vbCrLf) 'row
        'strHTML.Append("<div class='col-sm-12 row''>" & vbCrLf) 'row
        'strHTML.Append("<div class='col-lg-6' style='margin-top: 17px;'>" & vbCrLf)
        'strHTML.Append("<p class='ClsPageheader'>Release Planning</p>" & vbCrLf)
        'strHTML.Append("</div>")
        'strHTML.Append("<input type='hidden' value='" & projectID & "' id='hdnProjectID' />")
        'strHTML.Append("<input type='hidden' value='" & IterationID & "' id='hdnReleaseID' />")
        'strHTML.Append("<div class='col-lg-6' style='margin-top: 17px;'>" & vbCrLf)
        'strHTML.Append("<div class='row' id='FilterWithCreate'>" & vbCrLf)
        ''strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        ''strHTML.Append("<p  class='col-sm-3'style='font-size: 12px; color: grey;white-space: nowrap;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #c73c14;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Delayed With Issue </p>" & vbCrLf)
        ''strHTML.Append("<p   class='col-sm-2'style='font-size: 12px;color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color:orange;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Issue </p>" & vbCrLf)
        ''strHTML.Append("<p  class='col-sm-2'style='font-size: 12px; color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #1497c7;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Delayed </p>" & vbCrLf)
        ''strHTML.Append("<p  class='col-sm-2'style='font-size: 12px; color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: yellow;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;In Control </p>" & vbCrLf)
        ''strHTML.Append("<p  class='col-sm-3'style='font-size: 12px; color: grey;white-space: nowrap;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #14c751;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Ready For Release </p>" & vbCrLf)
        ''strHTML.Append("</div>")




        strHTML.Append("<div class='row' id='MainDiv1'>" & vbCrLf)
        strHTML.Append("<div class='col-md-6'>" & vbCrLf)
        strHTML.Append("" & vbCrLf)
        strHTML.Append("</div>")

        'strHTML.Append("<div class='row'>" & vbCrLf) 'LeftDiv
        strHTML.Append("<div class='col-md-12' style='margin-top:15px;display:flex'>" & vbCrLf)
        strHTML.Append("<div class='col-lg-6 col-md-6 col-sm-12 card' style='margin-top: 8px; border: 1px solid #ccc;height:692px;' id='LeftDiv'>" & vbCrLf)
        strHTML.Append("<div id='tblFGrid' class='card-header card-header-tabs card-header-primary' ><div class=' current_release' > Sprint </div> </div>")


        strHTML.Append(WriteLeftDiv("", ""))
        'strHTML.Append("</div>")

        strHTML.Append("</div>")





        strHTML.Append("<div class='col-lg-6 col-md-6 col-sm-12 clsrightdiv card' style='margin-top: 8px;margin-left:15px;border: 1px solid #ccc;height:692px;' id='RightDiv'>" & vbCrLf) 'RightDiv
        strHTML.Append("<div id='tblRightDiv' class='card-header card-header-tabs card-header-primary' ><div class='current_release' > Release </div> </div>")
        'If FilterFlag = "CurrentRelease" Then
        '    FilterFlag = "null"
        'End If
        If USID <> "" Then
            strHTML.Append(WriteRightDiv(IterationID, "", FilterFlag, USID))
        Else
            strHTML.Append(WriteRightDiv(IterationID, "", FilterFlag, USID))
            'strHTML.Append(WriteRightDiv(IterationID, "", FilterFlag, ""))
        End If
        '(ReleaseID, "AfterAddRelease", FilterFlag, "")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        If Flag <> "AfterTerminateSprint" Then
            strHTML.Append("</div>" & vbCrLf)
        End If

        If Flag <> "AfterTerminateSprint" Then
            Response.Write(strHTML.ToString())
        Else
            Return strHTML.ToString()
        End If

    End Function



    'Public Function ReleasePlanning(ByVal Flag As String, ByVal IterationID As String, Optional ByVal USID As String = "", Optional ByVal FilterFlag As String = "") As String
    '    Dim strHTML As New StringBuilder()

    '    If CurrentIterationID <> "" Then
    '        IterationID = CurrentIterationID
    '    Else
    '        IterationID = IterationID
    '    End If

    '    If USID <> "" Then
    '        USID = USID
    '    Else
    '        USID = ""
    '    End If

    '    If FilterFlag <> "" Then
    '        FilterFlag = FilterFlag
    '    Else
    '        FilterFlag = ""
    '    End If
    '    If Flag <> "AfterTerminateSprint" Then
    '        strHTML.Append("<div id='MainDiv'>" & vbCrLf)
    '    End If


    '    strHTML.Append("<div class='container-fluid'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)

    '    strHTML.Append("<div class='col-lg-6' style='margin-top: 17px;'>" & vbCrLf)
    '    strHTML.Append("<p style='font-size: 15px;font-weight: 700; color: grey;    margin-left: 5px;'>Release Planning</p>" & vbCrLf)
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='col-lg-6' style='margin-top: 17px;'>" & vbCrLf)

    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p  class='col-sm-3'style='font-size: 12px; color: grey;white-space: nowrap;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #c73c14;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Delayed With Issue </p>" & vbCrLf)
    '    strHTML.Append("<p   class='col-sm-2'style='font-size: 12px;color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color:orange;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Issue </p>" & vbCrLf)
    '    strHTML.Append("<p  class='col-sm-2'style='font-size: 12px; color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #1497c7;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Delayed </p>" & vbCrLf)
    '    strHTML.Append("<p  class='col-sm-2'style='font-size: 12px; color: grey;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: yellow;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;In Control </p>" & vbCrLf)
    '    strHTML.Append("<p  class='col-sm-3'style='font-size: 12px; color: grey;white-space: nowrap;'><label class='green_bar' style='    width: 8px;  height: 21px; background-color: #14c751;margin-bottom: -7px; margin-left: -10px;  border-radius: 9px;'></label>&nbsp;Ready For Release </p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-md-6'>" & vbCrLf)
    '    strHTML.Append("" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-6' style='margin-left:-12px;'>" & vbCrLf)
    '    strHTML.Append("<div class='right'>" & vbCrLf)
    '    strHTML.Append("<div class='btn-group'>" & vbCrLf)
    '    strHTML.Append("<button type='button' class='btn btn-danger' style='background-color:  #5cb85c'>Create</button>" & vbCrLf)
    '    strHTML.Append(" <button type='button' class='btn btn-danger dropdown-toggle px-3' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'  style='background-color: #5cb85c'>" & vbCrLf)
    '    strHTML.Append("<span class='sr-only'>Toggle Dropdown</span>")
    '    strHTML.Append("</button>")
    '    strHTML.Append("<div class='dropdown-menu'>")
    '    strHTML.Append("  <a class='dropdown-item' href='#'><input type='radio' value='option1'/>&nbsp;Add User Story</a>")
    '    strHTML.Append("  <a class='dropdown-item' href='#'><input type='radio' value='option1'/>&nbsp;Create Sprint</a>")
    '    strHTML.Append("  <a class='dropdown-item' href='#'><input type='radio' value='option1'/>&nbsp;Create Release</a>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<i class='fa fa-ellipsis-h' aria-hidden='true' style='    margin-left: 46px;'></i>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")





    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-lg-6' style='margin-top: 8px;'>" & vbCrLf)

    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 1</p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-5'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text' style='color: #428bca;       margin-left: 41px;     background-color: lightgrey;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
    '    strHTML.Append("<i class='fa fa-arrows' aria-hidden='true'style='font-size:  15px;color: grey;'></i>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text ' style='   font-size: 11px;white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div><br>")


    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 2</p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-5'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text' style='color: #428bca;       margin-left: 41px;     background-color: lightgrey;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
    '    strHTML.Append("<i class='fa fa-arrows' aria-hidden='true'style='font-size:  15px;color: grey;'></i>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text ' style='   font-size: 11px;white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div><br>")


    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 3</p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-5'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text' style='color: #428bca;       margin-left: 41px;     background-color: lightgrey;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
    '    strHTML.Append("<i class='fa fa-arrows' aria-hidden='true'style='font-size:  15px;color: grey;'></i>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text ' style='   font-size: 11px;white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div><br>")

    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 4</p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-5'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text' style='color: #428bca;       margin-left: 41px;     background-color: lightgrey;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1' style='white-space: nowrap;text-overflow: ellipsis;'>" & vbCrLf)
    '    strHTML.Append("<i class='fa fa-arrows' aria-hidden='true'style='font-size:  15px;color: grey;'></i>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text ' style='   font-size: 11px;white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")



    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='vl'>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='vl1'>" & vbCrLf)
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='col-lg-6' style='margin-top: 8px;'>" & vbCrLf)


    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:grey!important;  font-size: 11.5px;font-weight: 700;' >Release Name<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px;     font-size: 11.5px!important;background-color:#b3a9a9;'>5</span></p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text' style='color: #428bca;       margin-left: 38px;       font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='col-sm-6' style='padding-left:130px;'>" & vbCrLf)
    '    strHTML.Append(" <p class='card-text ' style='   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;color: #428bca; '>More..</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div><br>")

    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 2<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px; background-color:white;font-size: 11.5px!important;'><i class='fa fa-star' aria-hidden='true' style='color:#5bc0de;'></i></span></p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey'><span class='badge'>0/0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;")
    '    strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='    font-size: 16px;color: #de1818;'></i>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-3' style='padding-left:50px;'>" & vbCrLf)
    '    strHTML.Append(" <button type='button' class='btn btn-danger' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div><br>")


    '    strHTML.Append("<div class='card'>" & vbCrLf)
    '    strHTML.Append("<div class='card-header'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    strHTML.Append("<p style=' color:#428cf4!important;  font-size: 11.5px;font-weight: 700;' >Sprint 3</p>" & vbCrLf)
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey'><span class='badge'>0/0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;")
    '    strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='    font-size: 16px;color: #de1818;'></i>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-3' style='padding-left:35px;'>" & vbCrLf)
    '    strHTML.Append(" <button type='button' class='btn btn-danger' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5cb85c; border-color: #5cb85c;'data-bs-toggle='modal' data-bs-target='#myModal'>Completed</button>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")




    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    Response.Write(strHTML.ToString())
    'End Function
    Public Function WriteLeftDiv(Optional ByVal FilterFlag As String = "", Optional ByVal FilterText As String = "")
        '*******************************************************************************'
        ' Function Name	        :	WriteLeftDiv                                            '
        ' Purpose				:   Plotting LeftDivDiv Section                          '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande 
        'Date                   :   28th Feb 2018'
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim drTabData As IDataReader
        Dim FiterValue As String = ""
        Dim IsFilter As String = ""
        Dim strSQL As String = ""
        Dim IsRecord As Integer = 0
        If FilterText <> "" Then
            FiterValue = FilterText
        Else
            FiterValue = "null"
        End If

        If FilterFlag <> "" Then
            IsFilter = FilterFlag
        Else
            IsFilter = ""
        End If


        If FiterValue <> "null" Then
            strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ",null," & Session("intUserID") & ",'" & FiterValue & "'"
        Else
            strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ",null ," & Session("intUserID") & "," & FiterValue & ""
        End If


        If IsFilter <> "ApplyFilter" Then
            strHTML.Append("<div id='SearchID' class='clsrightdiv Activity' >" & vbCrLf)
        End If

        drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
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

            strHTML.Append("<div class='sprint_card  ' id='LeftDiv_" & IterationID & "'>" & vbCrLf)
            strHTML.Append("<div class='card-header'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<p Title='Sprint Name' class='lblname'><span title='Sprint Name' data-toggle='tooltip'>" & IterationName & "</span></p>" & vbCrLf)
            strHTML.Append("<label class='lblIDS' id='lblIterationID'>" & IterationID & "</label>")
            strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>")
            strHTML.Append("<p class='card-text'><i class='far fa-clock'></i>&nbsp;<span title='Start Date to End Date' data-toggle='tooltip'>" & StartDate & "  To  " & EndDate & "</span></p>")
            strHTML.Append("</div>")


            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='card-block'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append(" <div class='col-sm-8'>" & vbCrLf)
            If DoListCount <> "" Then
                strHTML.Append("<p class='card-text clsCountDetails' ><i class='fa fa-list-ol' style='color:#3baddc;' data-toggle='tooltip' title='To Do List'></i><span class='label label-success backLabel' data-toggle='tooltip' Title='" & DoListCount & "'>" & DoListCount & "</span>")
            Else
                strHTML.Append("<p class='card-text clsCountDetails' ><i class='fa fa-list-ol' style='color:#3baddc;'  data-toggle='tooltip' title='To Do List'></i> <span class='label label-success backLabel' Title='" & DoListCount & "' data-toggle='tooltip'>0</span>")
            End If

            If InProgressCount <> "" Then
                strHTML.Append("&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-spinner' style='color:orange;'  data-toggle='tooltip' title='In Progress'></i> <span class='label label-success backLabel' style='' Title='" & InProgressCount & "' data-toggle='tooltip'>" & InProgressCount & "</span>")
            Else
                strHTML.Append("&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <i class='fa fa-spinner' style='color:orange;' data-toggle='tooltip' title='In Progress'></i><span class='label label-success backLabel' style='' Title='" & InProgressCount & "' data-toggle='tooltip'>0</span>")
            End If

            If DoneCount <> "" Then
                strHTML.Append("&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='far fa-check-square' style='color:green;' data-toggle='tooltip' title='Done'></i> <span class='label label-success backLabel' Title='" & DoneCount & "' data-toggle='tooltip'>" & DoneCount & "</span></p>")
            Else
                strHTML.Append("&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<i class='far fa-check-square' style='color:green;' data-toggle='tooltip' title='Done'><span class='label label-success backLabel' Title='" & DoneCount & "' data-toggle='tooltip'>0</span></p>")
            End If

            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-1' style='white-space: nowrap;text-overflow: ellipsis; margin-left:-3%;'>" & vbCrLf)
            'strHTML.Append("<i class='fa fa-arrows' title='Drag & Drop' aria-hidden='true'style='font-size:  15px;color: grey;' data-bs-toggle='modal' data-bs-target='.releaselist'></i>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>" & vbCrLf)

            If NoOfDays <> "" Then
                If Regex.IsMatch(NoOfDays, "-") Then
                    strHTML.Append(" <p class='card-text '><span   style='font-size: 11px!important;white-space: nowrap;text-overflow: ellipsis;background: #f55e5e; color: #FFF;padding:7px;border-radius:5px;' Title='" & NoOfDays & "' data-toggle='tooltip'>" & NoOfDays & "</span></p>")
                Else
                    strHTML.Append(" <p class='card-text '  <span  style='font-size: 11px!important;white-space: nowrap;text-overflow: ellipsis;background: #3ea73e;color: #FFF!important;padding:7px;border-radius:5px;'Title='" & NoOfDays & "' data-toggle='tooltip'>" & NoOfDays & "</span></p>")
                End If
            Else
                strHTML.Append(" <p class='card-text '  <span  style='font-size: 11px!important;white-space: nowrap;text-overflow: ellipsis;background: black;color: #FFF;padding:7px;border-radius:5px;' Title='0' data-toggle='tooltip'></span>0</p>")
            End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            'If flag <> "AfterTerminateSprint" Then
            '    strHTML.Append("</div>" & vbCrLf)
            'End If
            strHTML.Append("</div>")

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
        Else

        End If

        If IsFilter <> "ApplyFilter" Then
            strHTML.Append("</div>" & vbCrLf)
        End If


        Return strHTML.ToString

    End Function
    'Public Function WriteRightDiv(ByVal IterationID As String, Optional ByVal flag As String = "", Optional ByVal FilterFlag As String = "", Optional ByVal USID As String = "")
    '    '*******************************************************************************'
    '    ' Function Name	        :	WriteRightDiv                                            '
    '    ' Purpose				:   Plotting RightDiv Section                          '
    '    ' Parameters Passed     :   None                                                '
    '    ' Returns               :                                                       '
    '    ' Author                :   Dipali Vekhande 
    '    'Date                   :   28th Feb 2018'
    '    '*******************************************************************************'
    '    Dim strHTML As New StringBuilder()
    '    Dim strSQL As String = ""
    '    Dim ReleaseName As String = ""
    '    Dim ReleaseID As String = ""
    '    Dim UserStories As String = ""
    '    Dim InProgress As String = ""
    '    Dim Done As String = ""
    '    Dim NoOfDays As String = ""
    '    Dim StartDate As String = ""
    '    Dim EndDate As String = ""
    '    Dim PlannedEffort As String = ""
    '    Dim ActualEffort As String = ""
    '    Dim CurrentIteration As String = ""
    '    Dim IterationStatus As String = ""
    '    Dim drReleaseDetails As IDataReader
    '    Dim IsRecordRelease As Integer = 0
    '    If USID <> "" Then
    '        USID = USID
    '    Else
    '        USID = "Null"
    '    End If

    '    If FilterFlag <> "" Then
    '        FilterFlag = FilterFlag
    '    Else
    '        FilterFlag = "Null"
    '    End If

    '    If IterationID <> "" Then
    '        IterationID = IterationID
    '    Else
    '        IterationID = "Null"
    '    End If


    '    If ReleaseID <> "" Then
    '        ReleaseID = ReleaseID
    '    Else
    '        ReleaseID = "Null"
    '    End If
    '    ' IterationID = 74

    '    strSQL = "usp_NG2_GetReleaseDetails " & Session("intProjectID") & "," & IterationID & "," & Session("intUserID") & ",'" & FilterFlag & "'," & USID & ""
    '    drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
    '    'Dim CountOfRows As Integer = 0 'dt1.Rows.Count
    '    If drReleaseDetails.Read Then
    '        IsRecordRelease = 1
    '        ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
    '        ReleaseName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
    '        UserStories = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
    '        InProgress = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
    '        Done = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
    '        NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
    '        StartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
    '        EndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
    '        PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
    '        ActualEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
    '    End If

    '    Dim dtWorkFlow As New DataTable
    '    dtWorkFlow = CommonFunctions.Data.GetDataTable("usp_NG2_GetReleaseDetails  " & Session("intProjectID") & "," & IterationID & "," & Session("intUserID") & ",'" & FilterFlag & "'," & USID & "", True)

    '    'strSQL = "usp_NG2_GetReleaseDetails " & Session("intProjectID") & "," & IterationID & "," & Session("intUserID") & ",'" & FilterFlag & "'," & USID & ""
    '    ' drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)


    '    strHTML.Append("<table class='Table'>")
    '    strHTML.Append("<tr>")
    '    strHTML.Append("<td>")
    '    strHTML.Append("<ul class='ulWorkFlow'>")
    '    Dim IsRecord As Integer = 0
    '    Dim strClass1 As String = ""
    '    Dim intCounter As Integer = 0
    '    strClass1 = "label-warning"
    '    For Each drReader As DataRow In dtWorkFlow.Rows
    '        strHTML.Append("<li title='" & CommonFunctions.Data.CheckIsDBNull(drReader("ReleaseName"), "") & "'>")
    '        strHTML.Append(IIf(intCounter <> 0 And intCounter <> dtWorkFlow.Rows.Count - 1, "", "") & "<label class='" & strClass1 & "'>" & CommonFunctions.Data.CheckIsDBNull(drReader("ReleaseName"), "") & "")
    '        'strHTML.Append("<div class='card-header' id='detailsheader'>" & vbCrLf)
    '        'strHTML.Append("<div class='row'>" & vbCrLf)
    '        'strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '        'strHTML.Append("<p style=' color:grey!important;  font-size: 14px;font-weight: 700;' title='ReleaseName'>" & ReleaseName & "<span class='label label-success ReleaseSprintcount ' title='Mapped Sprint Count'></span></p>" & vbCrLf)
    '        'strHTML.Append("</div>")
    '        'strHTML.Append("</div>")
    '        'strHTML.Append("</div>")

    '        'strHTML.Append("<div class='card-block'>" & vbCrLf)
    '        'strHTML.Append("<div class='row'>" & vbCrLf)
    '        'strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '        'strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='Start Date To End Date'>" & StartDate & "  To  " & EndDate & " </p>")
    '        'strHTML.Append("</div>")
    '        'strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '        'If UserStories <> "" Then
    '        '    strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='" & UserStories & "'>To Do")
    '        'Else
    '        '    strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='0'>To Do")
    '        'End If

    '        'If InProgress <> "" Then
    '        '    strHTML.Append("&nbsp; &nbsp;&nbsp;  <span title='" & InProgress & "'>InProgress</span>")
    '        'Else
    '        '    strHTML.Append("&nbsp; &nbsp;&nbsp; <span title='0'>InProgress</span>")
    '        'End If

    '        'If Done <> "" Then
    '        '    strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='" & Done & "'>Done</span></p>")
    '        'Else
    '        '    strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='0'>Done</span></p>")
    '        'End If
    '        'strHTML.Append("</div>")

    '        'strHTML.Append("<div class='col-sm-4' style='padding-left:130px;'>" & vbCrLf)
    '        'strHTML.Append(" <p class='card-text ' style='   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;color: #428bca; '>More..</p>")
    '        'strHTML.Append("</div>")
    '        'strHTML.Append("</div>")
    '        'strHTML.Append("</div>")

    '        ReleaseID = 74

    '        strHTML.Append("<input type='hidden' name='hdnTeamID' value='" & CommonFunctions.Data.CheckIsDBNull(drReader("ReleaseID"), "") & "' />")
    '        strHTML.Append("</label>")
    '        strHTML.Append("</li>")
    '        'strHTML.Append("</div>")
    '        strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",NUll"
    '        Dim drTabData As IDataReader

    '        drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
    '        If intCounter = 0 Then
    '            strHTML.Append("<ul class='clsDrag'>")
    '            While drTabData.Read

    '                IsRecord = 1
    '                IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationID"), "")
    '                IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
    '                StartDate = CommonFunctions.Data.CheckIsDBNull(drTabData("StartDate"), "")
    '                EndDate = CommonFunctions.Data.CheckIsDBNull(drTabData("EndDate"), "")
    '                PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("PlannedEffort"), "")
    '                ActualEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("ActualEffort"), "")
    '                DoListCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoListCount"), "")
    '                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drTabData("InProgressCount"), "")
    '                DoneCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoneCount"), "")
    '                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DiscussionCount"), "")
    '                ReviewCount = CommonFunctions.Data.CheckIsDBNull(drTabData("ReviewCount"), "")
    '                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseID"), "")
    '                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drTabData("NoOfDays"), "")
    '                IterationStatus = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationStatus"), "")
    '                CurrentIteration = CommonFunctions.Data.CheckIsDBNull(drTabData("CurrentIteration"), "")

    '                strHTML.Append("<li title='" & CommonFunctions.Data.CheckIsDBNull(drReader("ReleaseName"), "") & "'>")
    '                strHTML.Append("<div class='card clsmappendSprint' id='RightDiv_" & IterationID & "'>" & vbCrLf)
    '                strHTML.Append("<div class='card-header' >" & vbCrLf)
    '                strHTML.Append("<div class='row'>" & vbCrLf)
    '                strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '                strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
    '                strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
    '                strHTML.Append("<p style=' color:#428cf4!important;  font-size: 12px;font-weight: 700;' title='Sprint Name' >" & IterationName & "<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px; background-color:white;font-size: 11.5px!important;'>")
    '                If CurrentIteration <> False Then
    '                    strHTML.Append("<i class='fa fa-star' aria-hidden='true' style='color:#5bc0de;' title='Current Sprint'></i></span></p>" & vbCrLf)
    '                Else
    '                    strHTML.Append("</span></p>" & vbCrLf)
    '                End If

    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")

    '                strHTML.Append("<div class='card-block'>" & vbCrLf)
    '                strHTML.Append("<div class='row'>" & vbCrLf)
    '                strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
    '                strHTML.Append("  <p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;margin-top:5%!important' title='Start Date To End Date'>" & StartDate & "  To  " & EndDate & "</p>")
    '                strHTML.Append("</div>")
    '                'strHTML.Append("<div class='col-sm-4'>")
    '                strHTML.Append("<div class='col-sm-5 clsAllcounts'>")
    '                strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='font-size: 16px;'></i>&nbsp;&nbsp")
    '                If DiscussionCount <> "" Then
    '                    strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='" & DiscussionCount & "'></i>&nbsp;&nbsp;")
    '                Else
    '                    strHTML.Append("<i class='far fa-comments fa-border icon-grey'  title='0'></i>&nbsp;&nbsp;")
    '                End If

    '                If ReviewCount <> "" Then
    '                    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='" & ReviewCount & "'></i>&nbsp;&nbsp;")
    '                Else
    '                    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='0'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '                End If
    '                strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;")
    '                Dim Color As String = ""
    '                If IterationStatus = "Delayed with issue" Then
    '                    Color = "#dd4b39"
    '                ElseIf IterationStatus = "Issue" Then
    '                    Color = "#f39c12"
    '                ElseIf IterationStatus = "Delayed" Then
    '                    Color = "#00c0ef"
    '                ElseIf IterationStatus = "In Control" Then
    '                    Color = "#FFFF00"
    '                ElseIf IterationStatus = "Ready For Release" Then
    '                    Color = "#00a65a"
    '                End If

    '                If IterationStatus <> "" Then
    '                    strHTML.Append(" <span class='label clsstatus' style='background-color:" & Color & "' title='Sprint Status' >" & IterationStatus & "</span>")
    '                Else
    '                    strHTML.Append(" <span class='label'  title='Sprint Status'></span>")
    '                End If

    '                strHTML.Append("</div>")

    '                'strHTML.Append("<div class='col-sm-3' style='padding-left:50px;'>" & vbCrLf)
    '                strHTML.Append("<div class='col-sm-1 ClsStatus'>" & vbCrLf)
    '                ' strHTML.Append(" <button type='button' class='btn btn-success' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
    '                If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
    '                    If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
    '                        strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='UnMapped Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "' onclick=""focusTextBox('txtRemark" & IterationID & "'," & IterationID & ", " & ReleaseID & ")""></i>")
    '                        'Dim objfrmReleasePlanning As New frmReleasePlanning()
    '                        'strHTML.Append(objfrmReleasePlanning.PlotTerminated(IterationID, ReleaseID))
    '                    End If
    '                Else
    '                    strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='UnMapped Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "'></i>")
    '                End If

    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")
    '                strHTML.Append("</div>")

    '                'If flag <> "AfterAddRelease" Then
    '                '    strHTML.Append("</div>")
    '                'End If
    '                strHTML.Append("</li>")
    '            End While
    '            '    If dtWorkFlow.Rows.Count = 2 Then
    '            '        strHTML.Append("</ul>")
    '            '    End If
    '            'ElseIf intCounter = dtWorkFlow.Rows.Count - 2 Then
    '            '    If dtWorkFlow.Rows.Count > 2 Then
    '            strHTML.Append("</ul>")
    '            'End If
    '            'strClass = "liLeft"
    '        End If
    '        intCounter += 1
    '    Next

    '    If IsRecord = 0 Then
    '        strHTML.Append("<li>")
    '        strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
    '        strHTML.Append("<div class='row'>" & vbCrLf)
    '        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '        strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</li>")
    '    End If


    '    strHTML.Append("</ul>")
    '    intCounter = 0
    '    strHTML.Append("</td>")
    '    strHTML.Append("</tr>")
    '    strHTML.Append("</table>")

    '    'strHTML.Append("</div>")









    '    '////////////////////////////////////////////////////
    '    'strSQL = "usp_NG2_GetReleaseDetails " & Session("intProjectID") & "," & IterationID & "," & Session("intUserID") & ",'" & FilterFlag & "'," & USID & ""
    '    ' drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
    '    ''Dim CountOfRows As Integer = 0 'dt1.Rows.Count
    '    'If drReleaseDetails.Read Then
    '    '    IsRecordRelease = 1
    '    '    ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
    '    '    ReleaseName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
    '    '    UserStories = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
    '    '    InProgress = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
    '    '    Done = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
    '    '    NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
    '    '    StartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
    '    '    EndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
    '    '    PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
    '    '    ActualEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
    '    'End If
    '    'If flag <> "AfterAddRelease" Then
    '    '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
    '    'End If
    '    'Dim strSQLnew As String = ""
    '    'If IsRecordRelease = 1 Then
    '    '    strSQLnew = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",Null"
    '    'Else
    '    '    strSQLnew = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", Null, " & Session("intUserID") & ",Null"
    '    'End If

    '    ''strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ",null," & Session("intUserID") & ",'" & FiterValue & "'"
    '    'Dim dt1 As New DataTable
    '    'dt1 = CommonFunctions.Data.GetDataTable(strSQLnew, True)
    '    'Dim CountOfRows As Integer = dt1.Rows.Count
    '    'If ReleaseName <> "" And IsRecordRelease <> 0 Then
    '    '    strHTML.Append("<div class='card-header' id='detailsheader'>" & vbCrLf)
    '    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    '    strHTML.Append("<p style=' color:grey!important;  font-size: 14px;font-weight: 700;' title='ReleaseName'>" & ReleaseName & "<span class='label label-success ReleaseSprintcount ' title='Mapped Sprint Count'>" & CountOfRows & "</span></p>" & vbCrLf)
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")

    '    '    strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    '    strHTML.Append("  <p class='card-text' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='Start Date To End Date'>" & StartDate & "  To  " & EndDate & " </p>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
    '    '    If UserStories <> "" Then
    '    '        strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='" & UserStories & "'>To Do")
    '    '    Else
    '    '        strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' title='0'>To Do")
    '    '    End If

    '    '    If InProgress <> "" Then
    '    '        strHTML.Append("&nbsp; &nbsp;&nbsp;  <span title='" & InProgress & "'>InProgress</span>")
    '    '    Else
    '    '        strHTML.Append("&nbsp; &nbsp;&nbsp; <span title='0'>InProgress</span>")
    '    '    End If

    '    '    If Done <> "" Then
    '    '        strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='" & Done & "'>Done</span></p>")
    '    '    Else
    '    '        strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='0'>Done</span></p>")
    '    '    End If
    '    '    strHTML.Append("</div>")

    '    '    strHTML.Append("<div class='col-sm-4' style='padding-left:130px;'>" & vbCrLf)
    '    '    strHTML.Append(" <p class='card-text ' style='   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;color: #428bca; '>More..</p>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")

    '    'End If


    '    'Dim IsRecord As Integer = 0
    '    ''  IterationID = 74
    '    'If IsRecordRelease = 1 Then
    '    '    strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",NUll"

    '    '    Dim drTabData As IDataReader

    '    '    drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

    '    '    While drTabData.Read
    '    '        IsRecord = 1
    '    '        IterationID = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationID"), "")
    '    '        IterationName = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationName"), "")
    '    '        StartDate = CommonFunctions.Data.CheckIsDBNull(drTabData("StartDate"), "")
    '    '        EndDate = CommonFunctions.Data.CheckIsDBNull(drTabData("EndDate"), "")
    '    '        PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("PlannedEffort"), "")
    '    '        ActualEffort = CommonFunctions.Data.CheckIsDBNull(drTabData("ActualEffort"), "")
    '    '        DoListCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoListCount"), "")
    '    '        InProgressCount = CommonFunctions.Data.CheckIsDBNull(drTabData("InProgressCount"), "")
    '    '        DoneCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DoneCount"), "")
    '    '        DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drTabData("DiscussionCount"), "")
    '    '        ReviewCount = CommonFunctions.Data.CheckIsDBNull(drTabData("ReviewCount"), "")
    '    '        ReleaseID = CommonFunctions.Data.CheckIsDBNull(drTabData("ReleaseID"), "")
    '    '        NoOfDays = CommonFunctions.Data.CheckIsDBNull(drTabData("NoOfDays"), "")
    '    '        IterationStatus = CommonFunctions.Data.CheckIsDBNull(drTabData("IterationStatus"), "")
    '    '        CurrentIteration = CommonFunctions.Data.CheckIsDBNull(drTabData("CurrentIteration"), "")

    '    '        strHTML.Append("<div class='card clsmappendSprint' id='RightDiv_" & IterationID & "'>" & vbCrLf)
    '    '        strHTML.Append("<div class='card-header' >" & vbCrLf)
    '    '        strHTML.Append("<div class='row'>" & vbCrLf)
    '    '        strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    '        strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
    '    '        strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
    '    '        strHTML.Append("<p style=' color:#428cf4!important;  font-size: 12px;font-weight: 700;' title='Sprint Name' >" & IterationName & "<span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;  margin-left: 5px; background-color:white;font-size: 11.5px!important;'>")
    '    '        If CurrentIteration <> False Then
    '    '            strHTML.Append("<i class='fa fa-star' aria-hidden='true' style='color:#5bc0de;' title='Current Sprint'></i></span></p>" & vbCrLf)
    '    '        Else
    '    '            strHTML.Append("</span></p>" & vbCrLf)
    '    '        End If

    '    '        strHTML.Append("</div>")
    '    '        strHTML.Append("</div>")
    '    '        strHTML.Append("</div>")

    '    '        strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    '        strHTML.Append("<div class='row'>" & vbCrLf)
    '    '        strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
    '    '        strHTML.Append("  <p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;margin-top:5%!important' title='Start Date To End Date'>" & StartDate & "  To  " & EndDate & "</p>")
    '    '        strHTML.Append("</div>")
    '    '        'strHTML.Append("<div class='col-sm-4'>")
    '    '        strHTML.Append("<div class='col-sm-5 clsAllcounts'>")
    '    '        strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='font-size: 16px;'></i>&nbsp;&nbsp")
    '    '        If DiscussionCount <> "" Then
    '    '            strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='" & DiscussionCount & "'></i>&nbsp;&nbsp;")
    '    '        Else
    '    '            strHTML.Append("<i class='far fa-comments fa-border icon-grey'  title='0'></i>&nbsp;&nbsp;")
    '    '        End If

    '    '        If ReviewCount <> "" Then
    '    '            strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='" & ReviewCount & "'></i>&nbsp;&nbsp;")
    '    '        Else
    '    '            strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='0'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    '        End If
    '    '        strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;'></i>&nbsp;&nbsp;")
    '    '        Dim Color As String = ""
    '    '        If IterationStatus = "Delayed with issue" Then
    '    '            Color = "#dd4b39"
    '    '        ElseIf IterationStatus = "Issue" Then
    '    '            Color = "#f39c12"
    '    '        ElseIf IterationStatus = "Delayed" Then
    '    '            Color = "#00c0ef"
    '    '        ElseIf IterationStatus = "In Control" Then
    '    '            Color = "#FFFF00"
    '    '        ElseIf IterationStatus = "Ready For Release" Then
    '    '            Color = "#00a65a"
    '    '        End If

    '    '        If IterationStatus <> "" Then
    '    '            strHTML.Append(" <span class='label clsstatus' style='background-color:" & Color & "' title='Sprint Status' >" & IterationStatus & "</span>")
    '    '        Else
    '    '            strHTML.Append(" <span class='label'  title='Sprint Status'></span>")
    '    '        End If

    '    '        strHTML.Append("</div>")

    '    '        'strHTML.Append("<div class='col-sm-3' style='padding-left:50px;'>" & vbCrLf)
    '    '        strHTML.Append("<div class='col-sm-1 ClsStatus'>" & vbCrLf)
    '    '        ' strHTML.Append(" <button type='button' class='btn btn-success' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
    '    '        If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
    '    '            If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
    '    '                strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='UnMapped Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "' onclick=""focusTextBox('txtRemark" & IterationID & "'," & IterationID & ", " & ReleaseID & ")""></i>")
    '    '                'Dim objfrmReleasePlanning As New frmReleasePlanning()
    '    '                'strHTML.Append(objfrmReleasePlanning.PlotTerminated(IterationID, ReleaseID))
    '    '            End If
    '    '        Else
    '    '            strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='UnMapped Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "'></i>")
    '    '        End If

    '    '        strHTML.Append("</div>")
    '    '        strHTML.Append("</div>")
    '    '        strHTML.Append("</div>")

    '    '        If flag <> "AfterAddRelease" Then
    '    '            strHTML.Append("</div>")
    '    '        End If

    '    '    End While
    '    'End If



    '    'If IsRecord = 0 And IsRecordRelease = 0 Then
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
    '    '    'End If

    '    '    strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
    '    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    'strHTML.Append("<div class='card-block'>" & vbCrLf)
    '    '    'strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    'strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
    '    '    'strHTML.Append("<p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;text-align:Center'>There are no items to show in this view.</p>")
    '    '    'strHTML.Append("</div>")
    '    '    'strHTML.Append("</div>")
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("</div>")
    '    '    'End If
    '    'ElseIf IsRecordRelease = 0 Then
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
    '    '    'End If

    '    '    strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
    '    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("</div>")
    '    '    'End If
    '    'ElseIf IsRecord = 0 Then
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
    '    '    'End If

    '    '    strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
    '    '    strHTML.Append("<div class='row'>" & vbCrLf)
    '    '    strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
    '    '    strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    strHTML.Append("</div>")
    '    '    'If flag <> "AfterAddRelease" Then
    '    '    '    strHTML.Append("</div>")
    '    '    'End If
    '    'End If


    '    Return strHTML.ToString
    'End Function


    Public Function WriteRightDiv(ByVal IterationID As String, Optional ByVal flag As String = "", Optional ByVal FilterFlag As String = "", Optional ByVal USID As String = "")
        '*******************************************************************************'
        ' Function Name	        :	WriteRightDiv                                            '
        ' Purpose				:   Plotting RightDiv Section                          '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande 
        'Date                   :   28th Feb 2018'
        '*******************************************************************************'


        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim ReleaseName As String = ""
        Dim ReleaseID As String = ""
        Dim UserStories As String = ""
        Dim InProgress As String = ""
        Dim Done As String = ""
        Dim NoOfDays As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim PlannedEffort As String = ""
        Dim ActualEffort As String = ""
        Dim CurrentIteration As String = ""
        Dim Color As String = ""
        Dim IterationStatus As String = ""
        Dim drReleaseDetails As IDataReader
        Dim IsRecordRelease As Integer = 0

        If USID <> "" Then
            USID = USID
        Else
            USID = "Null"
        End If

        If FilterFlag <> "" Then
            FilterFlag = FilterFlag
        Else
            FilterFlag = "Null"
        End If

        If IterationID <> "" Then
            IterationID = IterationID
        Else
            IterationID = "Null"
        End If
        ' IterationID = 74

        strSQL = "usp_NG2_GetReleaseDetails " & Session("intProjectID") & "," & IterationID & "," & Session("intUserID") & ",'" & FilterFlag & "'," & USID & ""
        drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)


        'Dim CountOfRows As Integer = 0 'dt1.Rows.Count
        If drReleaseDetails.Read Then
            IsRecordRelease = 1
            ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
            ReleaseName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
            UserStories = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
            InProgress = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
            Done = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
            NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
            PlannedEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
            ActualEffort = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
        End If
        strHTML.Append("<input type='hidden' value='" & ReleaseID & "' id='hdnReleaseIDUS' />")
        If flag <> "AfterAddRelease" Then
            strHTML.Append("<div class='col-md-12 col-sm-12'>")
            strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
        End If
        Dim strSQLnew As String = ""
        If IsRecordRelease = 1 Then
            strSQLnew = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",Null"
        Else
            strSQLnew = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", Null, " & Session("intUserID") & ",Null"
        End If

        'strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ",null," & Session("intUserID") & ",'" & FiterValue & "'"
        Dim dt1 As New DataTable
        dt1 = CommonFunctions.Data.GetDataTable(strSQLnew, True)
        Dim CountOfRows As Integer = dt1.Rows.Count
        If ReleaseName <> "" And IsRecordRelease <> 0 Then
            strHTML.Append("<div class='card-header' id='detailsheader'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            strHTML.Append("<p class='ClsCaptiontooltip' style=' color:#fff!important;  font-size: 14px;font-weight: 700;'><span title='Release Name' data-toggle='tooltip'>" & ReleaseName & "</span><span class='label label-success ReleaseSprintcount ' title='Mapped Sprint Count'>" & CountOfRows & "</span></p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='card-block' style='padding: 20px 14px 35px!important;'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append(" <div class='col-sm-4'>" & vbCrLf)
            strHTML.Append("  <p class='card-text'><i class='far fa-clock'></i>&nbsp;<span class='ClsCaptiontooltip' title=' Start Date  To   End Date ' data-toggle='tooltip'>" & StartDate & "  To  " & EndDate & "</span></p>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
            If UserStories <> "" Then
                strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis; margin-top: 0;'><span title='" & UserStories & "' data-toggle='tooltip'><i class='fa fa-list-ol' style='color:#3baddc'></i></span>")
            Else
                strHTML.Append(" <p class='card-text clsCountDetails' style='color: #428bca;float:right;font-size: 12px;white-space: nowrap;text-overflow: ellipsis;margin-top: 0;'><span title='0' data-toggle='tooltip'><i class='fa fa-list-ol' style='color:#3baddc' ></i></span>")
            End If

            If InProgress <> "" Then
                strHTML.Append("&nbsp; &nbsp;&nbsp;  <span title='" & InProgress & "' data-toggle='tooltip'><i class='fa fa-spinner' style='color:orange' ></i></span>")
            Else
                strHTML.Append("&nbsp; &nbsp;&nbsp; <span title='0' data-toggle='tooltip'><i class='fa fa-spinner' style='color:orange' ></i></span>")
            End If

            If Done <> "" Then
                strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='" & Done & "' data-toggle='tooltip'><i class='far fa-check-square' style='color:green' '></i></span></p>")
            Else
                strHTML.Append(" &nbsp; &nbsp;&nbsp;<span title='0' data-toggle='tooltip'><i class='far fa-check-square' style='color:green' ></i></span></p>")
            End If
            strHTML.Append("</div>")

            strHTML.Append("<div class='col-sm-2' style='text-align:right;'>" & vbCrLf)
            strHTML.Append(" <p class='card-text more'><a id='Showmore' onclick=""Showmore(" & ReleaseID & ",'Release')"" title='Details' data-toggle='tooltip'>More..</a></p>")
            strHTML.Append("</div>")
            strHTML.Append("<input type='hidden' value='" & ReleaseID & "' name='hdnReleaseIDnewup' id='hdnReleaseIDnewup' />")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")

        End If


        Dim IsRecord As Integer = 0
        '  IterationID = 74
        'If flag <> "AfterAddRelease" Then
        '    strHTML.Append("<div Id='Addfilterdata'>" & vbCrLf)
        'End If
        If IsRecordRelease = 1 Then
            strSQL = "usp_NG2_SEL_tbl_NG2_sel_tbl_PM_Iterations_RP " & Session("intProjectID") & ", " & ReleaseID & ", " & Session("intUserID") & ",NUll"

            Dim drTabData As IDataReader

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)
            strHTML.Append("<div class='Activity' style=''>" & vbCrLf)

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
                Color = CommonFunctions.Data.CheckIsDBNull(drTabData("T1"), "")
                tooltip = CommonFunctions.Data.CheckIsDBNull(drTabData("Tooltip"), "")

                strHTML.Append("<div class='row' style='margin-right: 0px; margin-left: 0px;overflow-x:hidden!important;'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-1' style='padding-top:65px;padding-left:5%'>" & vbCrLf)
                strHTML.Append("<i class='fa fa-angle-double-right' aria-hidden='true' style='color:#5bc0de;font-size:20px!important' data-toggle='tooltip' title='Sprint Mapped to Release' data-container='body'></i>" & vbCrLf)
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-11'>" & vbCrLf)
                strHTML.Append("<div class='card clsmappendSprint' style='border-left:3px solid " & Color & "!important' id='RightDiv_" & IterationID & "'>" & vbCrLf)
                strHTML.Append("<div class='card-header' >" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-5'>" & vbCrLf)
                strHTML.Append("<input type='hidden' value='" & IterationID & "' name='hdnIterationID' id='hdnhdnIterationID' />")
                strHTML.Append("<input type='hidden' value='" & ReleaseID & "' name='hdnIterationID' id='hdnReleaseIDnewup' />")
            '   /* Modified By Madhuri.K On 03-04-2026 */ 
                strHTML.Append("<p class='ClsCaptiontooltip' style=' color:#989292!important;  font-size: 12px;font-weight: 700;' ><span title='Sprint Name' data-toggle='tooltip' data-placement='bottom' style='display: inline-block;'>" & IterationName & "</span><span class='label label-success backLabel' style='border-radius: 7px;top:0px!important;background-color:white;font-size: 11.5px!important;'>")
                If CurrentIteration <> False Then
                    strHTML.Append("<i class='fa fa-star' aria-hidden='true' style='color:#5bc0de;' title='Current Sprint' data-placement='bottom' data-toggle='tooltip'></i></span></p>" & vbCrLf)
                Else
                    strHTML.Append("</span></p>" & vbCrLf)
                End If

                strHTML.Append("</div>")
                strHTML.Append(" <div class='col-sm-7'>" & vbCrLf)
                strHTML.Append("<p class='card-text' data-toggle='tooltip'><i class='far fa-clock'>&nbsp;</i><span title='Start Date To End Date ' data-placement='bottom'>" & StartDate & "  To  " & EndDate & "</span></p>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='card-block'>" & vbCrLf)
                strHTML.Append("<div class='row'>" & vbCrLf)

                strHTML.Append("<div class='col-sm-8 clsAllcounts'>")
                strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='font-size: 16px;' data-toggle='tooltip' title='Chart'></i>&nbsp;&nbsp")
                If DiscussionCount <> "" Then
                    ''Commented and Added by Usha Pandit on 06.05.2019 for showing discussion count
                    'strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='" & DiscussionCount & "'  onclick=""AfterRelaseSprintSave('div2'," & IterationID & ")"" data-toggle='tooltip'></i>&nbsp;&nbsp;")
                    strHTML.Append("<i class='far fa-comments fa-border icon-grey' title='" & DiscussionCount & "'  onclick=""AfterRelaseSprintSave('div2'," & IterationID & ")"" data-toggle='tooltip'></i><span class='label label-success backLabel' style ='background: burlywood;' >" & DiscussionCount & "</span>&nbsp;&nbsp;")
                    ''End of Added by Usha Pandit on 06.05.2019 for showing discussion count
                    '
                Else
                    strHTML.Append("<i class='far fa-comments fa-border icon-grey'  title='0' data-toggle='tooltip'></i>&nbsp;&nbsp;")
                End If

                If ReviewCount <> "" Then
                    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='" & ReviewCount & "' data-toggle='tooltip'></i>&nbsp;&nbsp;")
                Else
                    strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' title='0' data-toggle='tooltip'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
                strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;' onclick=""AfterRelaseSprintSave('Sprint'," & IterationID & ")"" data-toggle='tooltip' Title='Edit'></i>&nbsp;&nbsp;")



                If tooltip = "Delayed with issue" Then
                    Color = "#dd4b39"
                ElseIf tooltip = "Issue" Then
                    Color = "#f39c12"
                ElseIf tooltip = "Delayed" Then
                    Color = "#00c0ef"
                ElseIf tooltip = "In Control" Then
                    Color = "purple"
                ElseIf tooltip = "Ready For Release" Then
                    Color = "#00a65a"
                End If


                If IterationStatus <> "" Then
                    'Added by Usha Pandit on 06 Jun 2018 to show proper text for sprint having status Incontrol with yellow background
                    If Color = "yellow" Then
                        strHTML.Append(" <span class='label clsstatus' style='background-color:" & Color & ";color:darkgray;' title='Sprint Status'  data-toggle='tooltip'>" & IterationStatus & "</span>")
                    Else
                        'End of Added by Usha Pandit on 06 Jun 2018 to show proper text for sprint having status Incontrol with yellow background
                        strHTML.Append(" <span class='label clsstatus' style='background-color:" & Color & "' title='Sprint Status'  data-toggle='tooltip'>" & IterationStatus & "</span>")
                    End If
                Else
                    strHTML.Append(" <span class='label'  title='Sprint Status' data-toggle='tooltip'></span>")
                End If

                strHTML.Append("</div>")

                'strHTML.Append("<div class='col-sm-3' style='padding-left:50px;'>" & vbCrLf)
                strHTML.Append("<div class='col-sm-2 ClsStatus'>" & vbCrLf)
                ' strHTML.Append(" <button type='button' class='btn btn-success' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
                'added by ashwini on 21-3-2023 for data-bs-toggle
                If CheckIsProductOwner(Session("intUserID")) <> 0 Then
                    If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
                        If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
                            strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "' onclick=""focusTextBox('txtRemark" & IterationID & "'," & IterationID & ", " & ReleaseID & ")""></i>")
                            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                            'Dim objfrmReleasePlanning As New frmReleasePlanning()
                            'strHTML.Append(objfrmReleasePlanning.PlotTerminated(IterationID, ReleaseID))
                        End If
                    Else
                        'Commented and added by Chetan M on 12th Aug 2020 for Issue ID  = 25495
                        'strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "'></i>")
                        'added by ashwini on 21-3-2023 for data-bs-toggle
                        strHTML.Append("<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818; cursor:no-drop' title='Sprint can not be terminated as sprint get completed.' data-container='body' data-bs-toggle='modal' data-bs-target='#Remark" & IterationID & "'></i>")
                        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                        'End of Commented and added by Chetan M on 12th Aug 2020 for Issue ID  = 25495
                    End If
                End If

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                If flag <> "AfterAddRelease" Then
                    strHTML.Append("</div>")
                End If

            End While
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("</div>")
            'End If
            strHTML.Append("</div>")
        End If



        If IsRecord = 0 And IsRecordRelease = 0 Then
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
            'End If

            strHTML.Append("<div class='card-header DivDetailss' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
        '    /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='card-block'>" & vbCrLf)
            'strHTML.Append("<div class='row'>" & vbCrLf)
            'strHTML.Append(" <div class='col-sm-6'>" & vbCrLf)
            'strHTML.Append("<p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;text-align:Center'>There are no items to show in this view.</p>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("</div>")
            'End If
        ElseIf IsRecordRelease = 0 Then
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
            'End If

            strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            ' /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("</div>")
            'End If
        ElseIf IsRecord = 0 Then
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("<div class='card DivDetailss' id='DivDetailss'>" & vbCrLf)
            'End If

            strHTML.Append("<div class='card-header' id='rightNoddata' style='border-top:1px solid white!important'>" & vbCrLf)
            strHTML.Append("<div class='row'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-12'>" & vbCrLf)
            ' /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<p style='font-size: 11.5px;font-weight: 100;text-align:center' >There are no items to show in this view.</p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'If flag <> "AfterAddRelease" Then
            '    strHTML.Append("</div>")
            'End If
        End If


        Return strHTML.ToString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ReleaseList(ByVal Flag As String, ByVal SelectedReleaseID As String)
        '=====================================================================
        ' Procedure Name        : ReleaseList()	
        ' Purpose               : To Add Release
        ' Description           : To Add Release
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 28th Feb -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim drReleaseDetails As IDataReader
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.WriteGrid(Flag, SelectedReleaseID, ""))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

        'Dim strSQL As String = ""
        ''strSQL = "usp_NG2_GetReleaseDetails " & HttpContext.Current.Session("IntProjectID") & ""
        'drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
        'Dim ReleaseID1 As String = ""
        'Dim ReleaseName1 As String = ""
        'StrHtml.Append("<ul class='list-group'>")
        'While drReleaseDetails.Read
        '    ReleaseID1 = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
        '    ReleaseName1 = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
        '    StrHtml.Append("<li class='list-group-item' Title='Release Name'><span class='checkboxcls'><input type='checkbox' value='" & ReleaseID1 & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'></span>" & ReleaseName1 & "</li>")
        'End While
        'StrHtml.Append("</ul>")


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
            Dim objfrmReleasePlanning As New frmReleasePlanning()
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
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            arrstrUserFriendlyList = {"US StoryID", "User Story Name", "Priority", "Select"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", "checkUSmapped"}
            arrWidthArray = {"align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            intNoOfDataColumn = 4

            strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'Sprint'"
            strDivID = "DivSprintlist"


            arrstrActualList = {"IterationName", "StartDate", "EndDate", "IterationStatus", ""}
            arrstrUserFriendlyList = {"Sprint Name", "Start Date", "End Date", "Sprint Status", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "checkSprintmapped"}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=Center", "align=left"}

            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter_New" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            intNoOfDataColumn = 4
            strDivID = "DivRelease1list"
            strSQLQuery = "usp_NG2_GetUserStoriesForRelease " & HttpContext.Current.Session("IntProjectID") & ",'Release'"
            arrstrActualList = {"ReleaseName", "StartDate", "EndDate", "Status", ""}
            arrstrUserFriendlyList = {"Release Name", "Start Date", "End Date", "Status", "Select"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "checkReleasemapped"}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=Center", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_Sel_GetCompleteSprintDetails " & SelectedReleaseID & ",'" & HttpContext.Current.Session("IntProjectID") & "'"
            arrstrActualList = {"IterationID", "IterationName"}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_Sel_GetCancelSprintDetails " & SelectedReleaseID & ",'" & HttpContext.Current.Session("IntProjectID") & "'"
            arrstrActualList = {"IterationID", "IterationName"}
            arrstrUserFriendlyList = {"Sprint ID", "Sprint Name"}
            arrstrLinkArray = {"", ""}
            arrCheckBoxArray = {"", ""}
            arrWidthArray = {"align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            arrstrActualList = {"SprintName", "InitialEstimate", "Status", "UserStoryName"}
            If FlagSprintRelease = "Sprint" Then
                arrstrUserFriendlyList = {"Sprint Name", "Story Points", "Status", "User Story Name"}
            ElseIf FlagSprintRelease = "Release" Then
                arrstrUserFriendlyList = {"Release Name", "Story Points", "Status", "User Story Name"}
            End If

            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "' class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumRisks " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"DateIdentified", "IterationName", "Status", "Description", "RiskCategory"}
            arrstrUserFriendlyList = {"Date Identified ", "Sprint Name", "Status", "Description", "Risk Category"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "' class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumReviews " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"ReviewedDate", "IterationName", "ReviewStatus", "ReviewTitle", "ReviewedBy", "Reviewee"}
            arrstrUserFriendlyList = {"Reviewed Date", "Sprint Name", "Status", "Review Title", "Reviewed By", "Reviewee"}
            arrstrLinkArray = {"", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumTasks " & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            arrstrActualList = {"AssignedTo", "IterationName", "Effort", "IsActive", "ScrumTaskName"}
            arrstrUserFriendlyList = {"Assigned To", "Sprint Name", "Planned/Actual", "Status", "Task Name"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            If FlagSprintRelease = "Iteration" Then
                strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & ",8084"
            Else
                strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & ",8083"
            End If

            arrstrActualList = {"Date", "ModifiedBy", "FieldName", "OldValue", "NewValue"}
            arrstrUserFriendlyList = {"Date", "Modified By", "Field Name", "Old Value", "New Value"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
            strSQLQuery = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & SelectedReleaseID & ",'" & FlagSprintRelease & "'"
            ' strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & SelectedReleaseID & ",8083"
            arrstrActualList = {"OriginalFileName", "AttachedBy", "Duration", ""}
            arrstrUserFriendlyList = {"Original File Name", "Attached By", "Duration", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id='Filter" & Flag & "'  class=Listcount value='" & dtListCount.Rows.Count & "'>")
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
    ''For Un mapped Sprint 
    Private Sub objGridUnmappedSprint_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGridUnmappedSprint.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'><p title='Select' data-toggle='tooltip'><input type='checkbox' value='" & Args.DataReader("IterationID") & "' data-toggle='tooltip' data-placement='bottom' name='SelectUnmappedSprintList' class='clscheckbox' >" + "<p></TD>"

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
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Status' data-toggle='tooltip' data-placement='bottom' >Not yet Started</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If


        If Args.ColumnName.ToUpper = "SPRINT NAME" Then
            If Not IsDBNull(Args.DataReader("IterationName")) Then
                Cancel = True
                ' Args.StringToBeInserted = "<td align='center' Title = 'Release ID' data-toggle='tooltip'>" & Args.DataReader("ReleaseName") & "</td>"
                Args.StringToBeInserted = "<td align='center' ><p class='wrap' Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom'  >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IterationName"), "") & "</p></TD>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p class='wrap' Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>"
            End If

            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
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
                Args.StringToBeInserted = "<td align='left' style='word-break: break-all !important;white-space: pre-line !important; text-align:left !important' ><p Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UserStoryName"), "") & "</p></TD>" 'Added By Swapna
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='left' style='word-break: break-all !important;white-space: pre-line !important; text-align:left !important'><p Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</p></TD>" 'Added by Swapna
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

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' Title = 'Select' data-toggle='tooltip' data-placement='left' class='clscheckboxRelease' onclick='SelectMappedUS(this," & Args.DataReader("ReleaseID") & ",""Release"")'>" + "</p></TD>"
                Else

                    Args.StringToBeInserted = "<td align='center' ><p><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='User Story not mapped to Sprint/Release' data-toggle='tooltip' data-placement='left' name='SelectReleaseList' class='clscheckboxRelease' onclick='SelectMappedUS(this," & Args.DataReader("ReleaseID") & ",""Release"")' disabled>" + "</p></TD>"
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
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Release Name' data-toggle='tooltip' data-placement='bottom' style='white-space: pre-wrap;'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ReleaseName"), "") & "</p></TD>"
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
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important;><p ><span  Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("UserStoryName") & "</span></p></td>" 'Added by swapna
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important;><p ><span Title = 'User Story Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>" 'Added by Swapna
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
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important;'><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important;'><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "SUMMARY" Then 'Summary
            If Not IsDBNull(Args.DataReader("Summary")) Then
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important; ><p ><span  Title = 'Summary' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Summary") & "</span></p></td>" 'Added by Swapna
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' style='word-break: break-all !important;white-space: pre-line !important;'><p ><span Title = 'Summary' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>" 'Added by Swapna
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Iteration Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Iteration Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'>" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'>Not Specified</span></p></TD>"
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >" & Args.DataReader("Description") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Description' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;' >Not Specified</span></p></TD>"
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("IterationName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Sprint Name' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "PLANNED/ACTUAL" Then 'Plan/Effort
            If Not IsDBNull(Args.DataReader("Effort")) Then
                Cancel = True

                'Commented and Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
                'Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("Effort") & " / " & Args.DataReader("Actual") & "</span></p></td>"
                Dim strBeforeDecimal As String = ""
                Dim strDecimal As String = ""
                Dim curEfforts As String = Args.DataReader("Effort")
                Dim curActualEfforts As String = Args.DataReader("Actual")

                strBeforeDecimal = curEfforts.Substring(0, curEfforts.IndexOf(":"))
                If strBeforeDecimal.Length = 1 Then
                    strBeforeDecimal = "0" + strBeforeDecimal
                End If
                strDecimal = curEfforts.Substring(curEfforts.IndexOf(":") + 1, 2)
                curEfforts = strBeforeDecimal + ":" + strDecimal

                strBeforeDecimal = curActualEfforts.Substring(0, curActualEfforts.IndexOf(":"))
                If strBeforeDecimal.Length = 1 Then
                    strBeforeDecimal = "0" + strBeforeDecimal
                End If
                strDecimal = curActualEfforts.Substring(curActualEfforts.IndexOf(":") + 1, 2)
                curActualEfforts = strBeforeDecimal + ":" + strDecimal

                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Plan/Effort' data-toggle='tooltip' data-placement='bottom' >" & curEfforts & " / " & curActualEfforts & "</span></p></td>"
                'End of Added by Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Plan/Effort' data-toggle='tooltip' data-placement='bottom' >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If

        If Args.ColumnName.ToUpper = "STAUS" Then 'Old Value
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
                Args.StringToBeInserted = "<td align='center' ><p ><span  Title = 'Task Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'   >" & Args.DataReader("ScrumTaskName") & "</span></p></td>"
            Else
                Cancel = True
                Args.StringToBeInserted = "<td align='center' ><p ><span Title = 'Task Name' data-toggle='tooltip' data-placement='bottom' style='word-break: break-all !important;white-space: pre-line !important;'   >Not Specified</span></p></TD>"
            End If
            ' Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type='checkbox' value='" & Args.DataReader("ReleaseID") & "' title='Select' name='SelectReleaseList' class='clscheckbox' onclick='SelectOne(this)'>" + "</TD>"
        End If
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function PlotTerminated(ByVal IterationID As String, ByVal ReleaseID As String)
        '=====================================================================
        ' Procedure Name        : PlotTerminated()	
        ' Purpose               : To Terminated Sprint
        ' Description           : To Terminated Sprint
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 2nd March -2018
        ' Revisions             : None
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder()


            strHTML.Append("<table class='clsRemark' id='tblRemark" & IterationID & "' >")
            strHTML.Append("<tr>")
            strHTML.Append("<td style='text-align: left;border: 0px!important'>")
            strHTML.Append(" Remarks : ")
            strHTML.Append("</td>")
            strHTML.Append("<td style='text-align: left;border: 0px!important'>")
            strHTML.Append("<textarea id='txtRemark" & IterationID & "' maxlength=2000 data-autoresize onkeyup=CheckTextLength(this,'smallRemark_" & IterationID & "','spanRemark" & IterationID & "')   class='clsTextArea' ></textarea>")
            strHTML.Append("<small name='smallRemark' Id='smallRemark_" & IterationID & "'  class='clsSpanRemark'> 2000</small>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")

            strHTML.Append("<tr>")
            strHTML.Append("<td>")
            strHTML.Append("</td>")
            strHTML.Append("<td class='spnCss'>")
            strHTML.Append("<span id='spanRemark" & IterationID & "' style='color:red; display:none'>Please Enter Remark.</span>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")

            strHTML.Append("<tr>")
            strHTML.Append("<td>")
            strHTML.Append("</td>")
            strHTML.Append("<td style='text-align:right;'>")
            strHTML.Append("<button type='button' id='btnRemark" & IterationID & "' class='btn btn-default clsterminate' style='width:auto;background-color: #3C8DBC!important;color: white;float:right;' onclick=""TerminateSprint(" & IterationID & "," & ReleaseID & ",'txtRemark" & IterationID & "',this)"" >Unmap From Release</button>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")
            strHTML.Append("</table>")

            Return strHTML.ToString
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
    Public Shared Function SelectRelease(ByVal strSeletedRelease As String)
        '=====================================================================
        ' Purpose				:	To Select Release
        ' Author				:	Dipali V
        ' Created				:	5th March 2018
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder()


            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", strSeletedRelease, "", "")) 'WriteRightDiv
            ' strGridHTML.Append("input")
            strGridHTML.Append("<input type='hidden' value='" & strSeletedRelease & "' id='hdnReleaseIDSelected' />")
            'strGridHTML.Append(objfrmReleasePlanning.WriteRightDiv(strSeletedRelease, "AfterAddRelease"))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SelectUserStory(ByVal ReleaseID As String, ByVal strSeletedUS As String, ByVal FilterFlag As String)
        '=====================================================================
        ' Purpose				:	To Select Release
        ' Author				:	Dipali V
        ' Created				:	5th March 2018
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder()
            If FilterFlag = "" Then
                FilterFlag = "null"
            End If
            If strSeletedUS = "" Then
                strSeletedUS = "null"
            End If
            Dim objfrmReleasePlanning As New frmReleasePlanning()


            If FilterFlag = "CurrentSprint" Or FilterFlag = "CurrentRelease" Then
                ''Added By Aniruddh Gujar on 24-Aug-2018 Purpose::Agile Issue Fixing
                If FilterFlag = "CurrentRelease" Then
                    ReleaseID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select dbo.fn_NG2_Sel_CurrentIterationOrRelease (" & HttpContext.Current.Session("intProjectID") & ",'RELEASE')", True), "")
                End If
                ''End of Added By Aniruddh Gujar on 24-Aug-2018 Purpose::Agile Issue Fixing
                strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID, strSeletedUS, FilterFlag))
                ' strGridHTML.Append(objfrmReleasePlanning.WriteRightDiv(ReleaseID, "AfterAddRelease", FilterFlag, ""))
            Else
                '
                strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", "", strSeletedUS, FilterFlag))
            End If
            Return strGridHTML.ToString
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
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            If Flag <> "SprintUnmappedFromRelease" Then
                strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID, ""))
            Else
                strGridHTML.Append(objfrmReleasePlanning.PlotSprintList(ReleaseID))
                ' strGridHTML.Append(objfrmReleasePlanning.WriteGrid("NoTMapped"))


            End If

            'WriteLeftDiv("AfterTerminateSprint"))
            Return strReleaseName & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function MapSprintToRelease(ByVal strIterationID As String, ByVal ReleaseID As String) As String 'USDONE: USDONE, sprintDone: sprintDone
        '=====================================================================
        ' Procedure Name        : MapSprintToRelease
        ' Purpose               : 
        ' Description           : To Map Sprint To Release
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :1st March 2018
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")
            Dim insertSuccess As Integer = 0
            Dim strUniqueID As Integer = 0
            Try
                insertSuccess = 1
                Dim strQuery As String = "usp_NG2_MapSprintToRelease " & strIterationID & "," & ReleaseID & ",'" & HttpContext.Current.Session("strUserName") & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            Catch ex As Exception
            End Try
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID, ""))
            Return insertSuccess & "||" & strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function RefreshPage(ByVal ReleaseID As String) As String 'USDONE: USDONE, sprintDone: sprintDone
        '=====================================================================
        ' Procedure Name        : RefreshPage
        ' Purpose               : 
        ' Description           : To RefreshPage
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :1st March 2018
        '=====================================================================
        Try

            Dim strGridHTML As New StringBuilder("")

            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID, ""))
            Return strGridHTML.ToString
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
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.PlotSprintList(ReleaseID))
            Return insertSuccess & "||" & strGridHTML.ToString
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
            strQuery = "EXEC usp_NG2_SEL_tbl_PM_ScrumIterationData " & HttpContext.Current.Session("intProjectID") & "," & strIterationID & "," & HttpContext.Current.Session("intUserID")
            dtIterationInfo = CommonFunctions.Data.GetDataTable(strQuery, True)
            If dtIterationInfo.Rows.Count > 0 Then
                StartDate = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("StartDate"), 0)
                EndDate = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("EndDate"), 0)
                Duration = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("Duration"), 0)
                Velocity = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("Velocity"), 0)
                strIterationStatus = CommonFunctions.Data.CheckIsDBNull(dtIterationInfo.Rows(0)("IterationStatus"), 0)
            End If

            'Dim strFlag As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Sel_tbl_pm_scrumuserstory_CheckIterationMapping " & strIterationID, True), 0)
            Dim drGetIsProductOwner As IDataReader
            Dim strFlag As String
            strQuery = "usp_NG2_IsProductOwner " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ""
            drGetIsProductOwner = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drGetIsProductOwner.Read
                strFlag = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")
            End While

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
        ' Author                :	Dipali V
        ' Created               :	5th-March-2018
        ' Revisions             :
        '=====================================================================


        Dim drGetIsProductOwner As IDataReader
        Dim strHTML As New StringBuilder
        Dim StrQuery As String = ""
        Dim strIsPrductOwner As String
        StrQuery = "usp_NG2_IsProductOwner " & Session("intProjectID") & "," & strUserID & ""
        drGetIsProductOwner = CommonFunctions.Data.GetDataReader(StrQuery, True)
        While drGetIsProductOwner.Read
            strIsPrductOwner = CommonFunctions.Data.CheckIsDBNull(drGetIsProductOwner("Result").ToString, "")

        End While
        Return strIsPrductOwner

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddUserStoryModal(ByVal CategoryID As String, ByVal type As String)
        '=====================================================================
        ' Procedure Name        :	AddUserStoryModal
        ' Purpose               :	AddUserStoryModal
        ' Description           :	Open US
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	5th-March-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim objfrmReleasePlanning As New frmReleasePlanning
            objfrmReleasePlanning.GetAccessRights()
            Dim strHTML As New StringBuilder()
            If type = "User" Then
                strHTML.Append("<div class='divBody'>")
                'strHTML.Append("<hr />")
                strHTML.Append(objfrmReleasePlanning.Form_section("0", CategoryID))
                strHTML.Append("</div>")
            ElseIf type = "Sprint" Then
                strHTML.Append(objfrmReleasePlanning.sprint_form("", "", "", "", "", "", "", ""))
            ElseIf type = "Release" Then
                strHTML.Append(objfrmReleasePlanning.Release_form("", "", "", "", "", "", ""))
            End If

            '  strHTML.Append(sprint_form(IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Function sprint_form(Optional SprintID As String = "", Optional Sprintname As String = "", Optional Description As String = "", Optional SprintStartDate As String = "", Optional SprintEndDate As String = "", Optional SprintDuration As String = "", Optional SprintVelocity As String = "", Optional BusinessDuration As String = "", Optional Iterationstatus As String = "") As String
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
        ''Added by Usha Pandit on 02.05.2019 for placing at correct location 
        GetAccessRights()

        Dim strSprintStatus As String = ""
        If SprintID = "" Then
            strSprintStatus = "0"
        Else
            strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & SprintID & ",'Iteration'", True))
        End If

        ''End of Added by Usha Pandit on 02.05.2019 for placing at correct location 

        strHTML.Append(" <div class='editDetails' style='margin-top: 4%;'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Sprint Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-10'>")
        If Sprintname = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
        Else
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", , 100, Sprintname, , , , IIf(Sprintname = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sprintname", "Sprintname", "form-control", , 100, Sprintname, , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('Sprintname','spanSprintname')", True, , , , , , True))
            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <label class='col-md-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-md-10'>")
        Dim strDisabled As String = ""
        If strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")) Then
            strDisabled = ""
        Else
            strDisabled = "disabled"
        End If
        If Description = "" Then
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:ShowLength(this,countdownSprint,1000,""Sprint"")'  onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') ", True, EnableHTMLEncode:=True))

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , , "", , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup='javascript:ShowLength(this,countdownSprint,1000,""Sprint"")'  onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') " & strDisabled, True, EnableHTMLEncode:=True))

            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
            strHTML.Append("<p  id='countdownSprint' style='float: right;float: right; margin-top: -28px; margin-right: -43px;'>1000</p>")
        Else
            Dim len As Integer = 1000
            Dim len1 As Integer
            If Description.Length <> -1 Then
                len1 = Description.Length
                len = 1000 - len1
            End If
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , len, Description, , , , IIf(Description = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup='javascript:ShowLength(this,countdownSprint,1000,""Sprint"")' onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') ", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescriptionSprint", "txtDescriptionSprint", , "form-control", , , , , , , len, Description, , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup='javascript:ShowLength(this,countdownSprint,1000,""Sprint"")' onchange=ClearSpan('txtDescriptionSprint','spantxtDescriptionSprint') " & strDisabled, True, EnableHTMLEncode:=True))
            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
            strHTML.Append("<p  id='countdownSprint' style='float: right; margin-top: -28px; margin-right: -43px;'>" & len & "</p>")

        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-md-7'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-6'>")
        If strIsPrductOwner = 1 Then
            Disabled = "True"
        Else
            Disabled = "False"
        End If

        If SprintStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate') onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');", True, , , , , , True))
        Else
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", , 100, SprintStartDate, , , , IIf(SprintStartDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate')", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintStartdate", "SprintStartdate", "form-control", , 100, SprintStartDate, , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('SprintStartdate','spanSprintStartdate')", True, , , , , , True))
            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
        End If

        ''Commented and Added by Usha Pandit on 19.04.2019 for not showing calender if sprint is already started
        'strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');></i>")
        If strSprintStatus = "1" Then
        Else
            strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintStartdate').datepicker();$('#SprintStartdate').datepicker('show');></i>")
        End If
        ''End of Added by Usha Pandit on 19.04.2019 for not showing calender if sprint is already started

        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-5'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If SprintEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate') onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');", True, , , , , , True))
        Else
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", , 100, SprintEndDate, , , , IIf(SprintEndDate = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate')", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SprintEnddate", "SprintEnddate", "form-control", , 100, SprintEndDate, , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('SprintEnddate','spanSprintEnddate')", True, , , , , , True))
            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
        End If

        ''Commented and Added by Usha Pandit on 19.04.2019 for not showing calender if sprint is already started
        'strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');></i>")
        If strSprintStatus = "1" Then
        Else
            strHTML.Append("<i class='far fa-calendar-check' style='float: right;margin-top: -35px;color:#0099CC;' onclick=$('#SprintEnddate').datepicker();$('#SprintEnddate').datepicker('show');></i>")
        End If
        ''End of Added by Usha Pandit on 19.04.2019 for not showing calender if sprint is already started

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-md-7'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Calendar Day's' >Calendar Day</label> ")
        strHTML.Append(" <div class='col-md-6'>")
        If SprintDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCalendar", "txtCalendar", "form-control", , 100, SprintDuration, , , IIf(SprintDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), IIf(SprintDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtCalendar','spantxtCalendar')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-5'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;' data-toggle='tooltip' data-placement='bottom' title='Business Day's' >Business Day</label> ")
        strHTML.Append(" <div class='col-md-8'>")
        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtBusiness", "txtBusiness", "form-control", , 100, BusinessDuration, , , IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), IIf(BusinessDuration = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtBusiness','spantxtBusiness')", True, , , , , , True))
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='col-md-7'>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Efforts<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-6'>")
        If SprintVelocity = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
        Else
            ''Commented and Added by Usha Pandit on 02.05.2019 for disable field condition
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", , 100, SprintVelocity, , , , IIf(SprintVelocity = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UniqueID = "")), False, True), , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", "form-control", , 100, SprintVelocity, , , IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), IIf(strSprintStatus = "0" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1")), False, True), , , "onkeyup=ClearSpan('txtEfforts','spantxtEfforts')", True, , , , , , True))
            ''End of Added by Usha Pandit on 02.05.2019 for disable field condition
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")







        strHTML.Append("<div class='row'>")

        strHTML.Append("<div class='col-md-12 align-right' style='margin-top: 20px;margin-bottom:40px;'>")
        ''Commented by Usha Pandit on 02.05.2019 for placing at correct location 
        'GetAccessRights()
        ''End of Commented by Usha Pandit on 02.05.2019 for placing at correct location 
        If (UniqueID <> "" Or UniqueID <> "0") And Sprintname <> "" Then
            ''Commented and Added by Usha Pandit on 11.04.2019 for disabling Update button if Sprint is already started or completed
            'If m_objAccess.Edit Then
            '    If strIsPrductOwner = 1 Then
            '        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")'><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
            '    Else
            '        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
            '    End If
            'End If

            'If SprintID = "" Then
            '    strSprintStatus = "0"
            'Else
            '    strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & SprintID & ",'Iteration'", True))
            'End If

            If m_objAccess.Edit Then
                If strSprintStatus = "1" Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Sprint Already started/completed,you do not have access to change data' ><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                Else
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")'><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                    Else
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Sprint"")' ><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                    End If
                End If

            End If
            ''End of Added by Usha Pandit on 11.04.2019 for disabling Update button if Sprint is already started or completed
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
        strHTML.Append("</div>")
        Return (strHTML.ToString())

    End Function


    Public Function Release_form(Optional ReleaseID As String = "", Optional Releasename As String = "", Optional Description As String = "", Optional ReleaseStartDate As String = "", Optional ReleaseEndDate As String = "", Optional ReleaseDuration As String = "", Optional ReleaseVelocity As String = "", Optional BusinessDuration As String = "", Optional Iterationstatus As String = "") As String
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
        strHTML.Append(" <div class='form-row'  style='margin-top:4%;'>")
        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Release Name<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-10'>")
        If Releasename = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ReleaseName", "ReleaseName", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('ReleaseName','spanReleaseName')", True, , , , , , True))
        Else
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If Iterationstatus = "Not Planned" Then
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

        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Description</label> ")
        strHTML.Append(" <div class='col-sm-10'>")

        If Description = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right:-26px;' id='countdownRelease'>1000</p>")

        Else
            Dim len As Integer = 1000
            Dim len1 As Integer
            If Description.Length <> -1 Then
                len1 = Description.Length
                len = 1000 - len1
            End If
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If Iterationstatus = "Not Planned" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , , , , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')", True, EnableHTMLEncode:=True))
                    strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right:-26px;' id='countdownRelease'>" & len & "</p>")
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , True, True, , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')", True, EnableHTMLEncode:=True))
                    strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right -26px;' id='countdownRelease'>" & len & "</p>")

                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , len, Description, , , True, True, , , "onkeyup='javascript:ShowLength(this,countdownRelease,1000,""Release"")' onKeyUp='javascript:ShowLength(this,countdownRelease, 1000,""Release"")'onchange=ClearSpan('txtDescription','spantxtDescription')", True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 11px;font-weight: 500;color: grey;float:right;margin-top:-35px;margin-right -26px;' id='countdownRelease'>" & len & "</p>")

            End If
        End If
        'strHTML.Append("<textarea  name='txtDescription' Id='txtDescription'  class='form-control'style='box-shadow: none;border-left-color: transparent; border-top-color: transparent;border-right-color: transparent;' ></textarea>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Start Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-4'>")
        If ReleaseStartDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
        Else
            If strIsPrductOwner = "1" And UniqueID <> "" Then
                If Iterationstatus = "Not Planned" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , , , , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , True, True, , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))

                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RstartDate", "RstartDate", "form-control", , 100, ReleaseStartDate, , , True, True, , , "onkeyup=ClearSpan('RstartDate','spanRstartDate') onclick=$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');", True, , , , , , True))
            End If
        End If

        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: -35px; float:right;color:#0099CC;' id='#dpRSDate' onclick=""$('#RstartDate').datepicker();$('#RstartDate').datepicker('show');""></i>")
        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-sm-4'>")

        If ReleaseEndDate = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
        Else
            If Iterationstatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , , , , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , True, True, , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", "form-control", , 100, ReleaseEndDate, , , True, True, , , "onkeyup=ClearSpan('txtEndDate','spantxtEndDate')  onclick=$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');", True, , , , , , True))
            End If
        End If

        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='font-size: 16px; margin-top: -35px;float:right;color:#0099CC;' id='#dpRendate'  onclick=""$('#txtEndDate').datepicker();$('#txtEndDate').datepicker('show');""></i>")
        'strHTML.Append(" <i class='fa fa-asterisk' aria-hidden='true' style='margin-left:  3px;  font-size: 7px;  margin-top: 12px;color:red;'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")





        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Calendar Day</label> ")
        strHTML.Append(" <div class='col-sm-4'>")

        If ReleaseDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
        Else
            If Iterationstatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , True, , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , True, , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRelCalendar", "txtRelCalendar", "form-control", , 100, ReleaseDuration, , , True, , , , "onkeyup=ClearSpan('txtRelCalendar','spantxtRelCalendar')", True, , , , , , True))
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='' style='display:contents'>")
        strHTML.Append(" <label class='col-sm-2 control-label' style='white-space: nowrap;'>Business Day</label> ")
        strHTML.Append(" <div class='col-sm-4'>")

        If BusinessDuration = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, , , , , True, , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
        Else
            If Iterationstatus = "Not Planned" Then
                If strIsPrductOwner = "1" And UniqueID <> "" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , True, , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , True, , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
                End If
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRBusinessDuration", "txtRBusinessDuration", "form-control", , 100, BusinessDuration, , , True, , , , "onkeyup=ClearSpan('txtRBusinessDuration','spantxtRBusinessDuration')", True, , , , , , True))
            End If
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")





        strHTML.Append("<div class='row' style='margin-left:auto'>")
        strHTML.Append("<div class='col-md-12 align-right' style='margin-top: 20px;'>")
        GetAccessRights()
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addRelease'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='display:none' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")
        If (UniqueID <> "" Or UniqueID <> "0") And Releasename <> "" Then
            If m_objAccess.Edit Then
                If strIsPrductOwner = 1 Then
                    If Iterationstatus = "Not Planned" Then
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")'><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                    Else
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")

                    End If
                Else
                    strHTML.Append("<button type='button' class='btn btn-info' id='addUpdateRelease'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveSprintRelease(""Release"")' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>Update</button>&nbsp;&nbsp;&nbsp;")
                End If
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-right' aria-hidden='true'></i>Next</button>")
                'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addPrerelase'  style='display:none' title='Previous' onclick='NextSprintRelease(""Release"")'><i class='fa fa-angle-double-left' aria-hidden='true'></i>Previous</button>")
            End If
        Else
            If Releasename = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<button type='button' class='btn btn-info' id='addRelease'  data-toggle='tooltip' data-placement='top'  title='Save' onclick='SaveSprintRelease(""Release"")'>Save</button>&nbsp;&nbsp;&nbsp;")

                End If
            End If
        End If
        If m_objAccess.Delete Then
            ' strHTML.Append("&nbsp;&nbsp;<i class='fa fa-trash-o' aria-hidden='true' onclick='Delete_UserStory(" & UserStoryId & ")'></i>")
        End If
        'If UniqueID <> "" Then
        '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='addNext'  style='' title='Next' onclick='NextSprintRelease(""Release"")'>Next</button>")

        'End If
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return (strHTML.ToString())

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
        ' Author				:   Dipali V
        ' Created				:  6th-March-2018
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
    Public Shared Function FilterSprintsection(ByVal filtertext As String, ByVal ProjectID As String) As String
        '=====================================================================
        ' Procedure  Name		:	FilterSprintsection
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Filter Sprintsection
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   6th-March-2018
        '=====================================================================
        Try

            Dim StrHtml As New StringBuilder("")
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            StrHtml.Append(objfrmReleasePlanning.WriteLeftDiv("ApplyFilter", filtertext))
            Return StrHtml.ToString
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
        ' Author				:	Dipali V
        ' Created				:   6th-March-2018
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

        Catch ex As Exception

        End Try

        Return insertSuccess


    End Function

    'USER STORY DETAIL OLD CODE
    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetUserStoryDetails(ByVal UserStoryId As String)
    '    '=====================================================================
    '    ' Procedure  Name		:	GetUserStoryDetails
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To Get UserStory Details
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    Dim frmReleasePlanning As New frmReleasePlanning()
    '    strHTML.Append("<div id='divUserStories'>")
    '    strHTML.Append(frmReleasePlanning.Table_Backlog())
    '    strHTML.Append("</div>")
    '    strHTML.Append(frmReleasePlanning.Heading_section(UserStoryId))
    '    strHTML.Append(frmReleasePlanning.Tab_section())
    '    strHTML.Append("<div id='divUserStroryDetails'>")
    '    strHTML.Append(frmReleasePlanning.Form_section(UserStoryId))
    '    strHTML.Append(frmReleasePlanning.Substories_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Attachment_section(UserStoryId, ""))
    '    'strHTML.Append(frmReleasePlanning.Discussion_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Resource_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.History_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Issues_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Reviews_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Tasks_section(UserStoryId))
    '    'strHTML.Append(frmReleasePlanning.Chart_section(UserStoryId))
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString()
    'End Function


    'NEW USER STORY DEATIL
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUserStoryDetails(ByVal UserStoryId As String)
        Try

            Dim strHTML As New StringBuilder()
            Dim frmReleasePlanning As New frmReleasePlanning()
            strHTML.Append("<div id='divUserStories'>")
            strHTML.Append(frmReleasePlanning.Table_Backlog())
            strHTML.Append("</div>")
            strHTML.Append(frmReleasePlanning.Heading_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Tab_section())
            strHTML.Append("<div id='divUserStroryDetails'>")
            strHTML.Append(frmReleasePlanning.Form_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Substories_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Attachment_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Discussion_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Resource_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.History_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Issues_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Reviews_section(UserStoryId))
            strHTML.Append(frmReleasePlanning.Tasks_section(UserStoryId, ""))
            strHTML.Append(frmReleasePlanning.Chart_section(UserStoryId))
            strHTML.Append("</div>")
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'Public Function Table_Backlog(Optional ByVal strEntityID As String = "", Optional ByVal strEntity As String = "", Optional ByVal UserStoryID As String = "") As String
    '    Dim strHTML As New StringBuilder()
    '    Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID")

    '    If strEntity = "Category" Then
    '        strSql &= "," & strEntityID
    '    ElseIf strEntity = "Priority" Then
    '        strSql &= ",NULL," & strEntityID
    '    End If
    '    Dim dtProductBacklog As New DataTable()
    '    dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div class='table-responsive table-bordered col-sm-4' id='leftTree' style='overflow-y: scroll; height: 515px;padding-right: 0px;padding-left: 0px;'>   ")
    '    strHTML.Append(" <table class='table'>")
    '    strHTML.Append("	<thead>")
    '    strHTML.Append("	  <tr><th>Backlogs</th><th style='position:relative'>")
    '    strSql = "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & ""
    '    Dim dtCategory As New DataTable
    '    dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;'><i  data-toggle='tooltip' title='Settings' style='font-size:16px!important' data-placement='bottom' class='fa fa-align-justify Home'></i></div>")
    '    strHTML.Append("<ul class='dropdown-menu' role='menu'>")
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
    '            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "").ToString() = UserStoryID Then
    '                strHTML.Append("<tr><td style='cursor:pointer;color:#3c7dcf' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

    '            Else
    '                strHTML.Append("<tr><td style='cursor:pointer;' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

    '            End If
    '        End If
    '    Next
    '    strHTML.Append("	</tbody>")
    '    strHTML.Append("	</table>")
    '    strHTML.Append("</div>")

    '    Return (strHTML.ToString())
    'End Function

    'old substories
    'Public Function Substories_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Substories_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Substories section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    Dim strSql As String = ""

    '    strHTML.Append("<div id='divSubstories' class='clsBox'>")
    '    strHTML.Append("<h2 style='margin-top:8px;' class='clsDiscussion'>Sub UserStories</h2>")
    '    strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><a onclick=ShowData('List')>List</a> | <a onclick=ShowData('Form')>Add</a></h2>")
    '    strHTML.Append("<Div class='col-sm-12' id='divSubstoryList'>")
    '    strHTML.Append(PlotSubUserStoryList(userStoryID))
    '    strHTML.Append("</Div>")
    '    strHTML.Append("<Div class='col-sm-12' id='divSubstoryForm' style='display:none'>")
    '    strHTML.Append(" <div class='col-sm-12 '>")
    '    strHTML.Append("<i data-toggle='tooltip' style='float:right;' title='Save' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='row' style='display:block!important'>")
    '    strHTML.Append(" <div class='form-group'>")
    '    strHTML.Append(" <div class='col-sm-4 '>")
    '    strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Feature Name</label> ")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-8 '>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", 140, 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='row'>")
    '    strHTML.Append(" <div class='form-group'>")
    '    strHTML.Append(" <div class='col-sm-4 '>")
    '    strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Description</label> ")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-8 '>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubStoryDesc", "txtSubStoryDesc", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc')", True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <div class='row'>")
    '    strHTML.Append(" <div class='form-group'>")
    '    strHTML.Append(" <div class='col-sm-4 '>")
    '    strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority</label> ")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-8 '>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", 190, , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    strHTML.Append("</Div>")
    '    strHTML.Append("</div>")

    '    Return strHTML.ToString
    'End Function

    'Function PlotSubUserStoryList(ByVal userStoryID As String)
    '    '=====================================================================
    '    ' Procedure  Name		:	PlotSubUserStoryList
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot SubUserStoryList
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    Dim drSubstory As IDataReader
    '    Dim strSql As String = "usp_NG2_sel_tbl_PM_SubUserStory " & userStoryID
    '    drSubstory = CommonFunction.Data.GetDataReader(strSql, True)
    '    strHTML.Append("<ul class='col-sm-12 chat'>")
    '    While drSubstory.Read
    '        strHTML.Append("<li class='col-sm-12'>")
    '        strHTML.Append("<span class='chat-img float-start'>")
    '        'strHTML.Append("<div alt='User Avatar' class='img-circle' style='height:50px;width:50px;background-color:" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Color"), "") & "'></div>")
    '        strHTML.Append("<label class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</label>")
    '        strHTML.Append("<label class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("InitialRank"), "") & "</label>")
    '        strHTML.Append("</span>")
    '        strHTML.Append("<div class='chat-body clearfix'>")
    '        strHTML.Append("<div class='header'>")
    '        'strHTML.Append("<strong class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</strong>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("<p title='Description' style='margin-left:15%'>")
    '        strHTML.Append("" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Description"), "") & "")
    '        strHTML.Append("</p>")
    '        strHTML.Append("<small class='float-end text-muted' style='margin-top:-4%' >")
    '        strHTML.Append("<i class='fa fa-trash' onclick='Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & ")'></i>")
    '        strHTML.Append("</small>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</li>")
    '    End While
    '    strHTML.Append("</ul>")
    '    Return strHTML.ToString()
    'End Function

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
            strHTML.Append("<label class='primary-font' data-toggle='tooltip' data-placement='top' title='UserStory ID'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</label>")
            strHTML.Append("<label class='primary-font' data-toggle='tooltip' data-placement='top' title='Initial Rank'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("InitialRank"), "") & "</label>")
            strHTML.Append("</span>")
            strHTML.Append("<div class='chat-body clearfix'>")
            strHTML.Append("<div class='header'>")
            'strHTML.Append("<strong class='primary-font'>" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & "</strong>")
            strHTML.Append("</div>")
            strHTML.Append("<p  style='padding-left:22%'><span title='Description' data-toggle='tooltip' data-placement='top'>")
            strHTML.Append("" & CommonFunctions.Data.CheckIsDBNull(drSubstory("Description"), "") & "")
            strHTML.Append("</p>")
            strHTML.Append("<small class='float-end text-muted' style='margin-top:-2%;color:red'>")
            strHTML.Append("<i title='Delete' class='fa fa-trash' onclick='Delete_UserStory(" & CommonFunctions.Data.CheckIsDBNull(drSubstory("UserStoryID"), "") & ")'></i>")
            strHTML.Append("</small>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
        End While
        strHTML.Append("</ul>")
        Return strHTML.ToString()

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
            tooltip = CommonFunctions.Data.CheckIsDBNull(drTabData("Tooltip"), "")

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
            strHTML.Append("<p  class='wrap' style=' color:#777777!important;  font-size: 16px;font-weight: 700;' ><span data-toggle='tooltip' data-placement='bottom' title='Sprint Name'>" & IterationName & "</span>")
            strHTML.Append("</span></p>" & vbCrLf)
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-6'>" & vbCrLf)
            strHTML.Append("  <p class='card-text ' style='color: #428bca;   font-size: 12px;white-space: nowrap;text-overflow: ellipsis;' ><i class='far fa-clock'></i>&nbsp;<span data-toggle='tooltip' data-placement='bottom' title='Start Date  To  End Date '>" & StartDate & "  To  " & EndDate & "</span></p>")
            strHTML.Append("</div>")







            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='card-block' style='margin-left:1%'>" & vbCrLf)
            strHTML.Append("<div class='row' style='margin-top:3%;'>" & vbCrLf)
            strHTML.Append("<div class='col-sm-3' style='margin-top:5%;'>" & vbCrLf) 'added by ankush T 08/06/2018 style
            strHTML.Append(" <p style=' color:#777777!important;  font-size: 16px;font-weight: 700;white-space: nowrap;text-align:center' title='Sprint ID' data-toggle='tooltip' data-placement='bottom'>" & IterationID & "</p>" & vbCrLf)
            strHTML.Append("</div>")

            'strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='col-sm-7 clsunmappedAllcounts' style='margin-top:5%;'>") 'added by ankush T 08/06/2018 style 
            strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='font-size: 16px;'></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            If DiscussionCount <> "" Then
                strHTML.Append("<i class='far fa-comments fa-border icon-grey' data-toggle='tooltip' data-placement='bottom' data-original-title='Reply Count'  onclick=""AfterRelaseSprintSave('div2'," & IterationID & ")"">  <span class='label  discussioncount'  data-toggle='tooltip' data-placement='bottom' title='" & DiscussionCount & "'>" & DiscussionCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                strHTML.Append("<i class='far fa-comments fa-border icon-grey' data-toggle='tooltip' data-placement='bottom'  data-original-title='Reply Count ' ><span class='label discussioncount' data-placement='bottom' title='0'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If ReviewCount <> "" Then
                strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' data-toggle='tooltip' data-placement='bottom' data-original-title='Review Count '><span class='label discussioncount reviewCount'  data-toggle='tooltip' data-placement='bottom' title='" & ReviewCount & "'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                strHTML.Append("<i class='	fas fa-chart-area  fa-border icon-grey' data-toggle='tooltip' data-placement='bottom' data-original-title='Review Count '><span class='label discussioncount reviewCount'  data-toggle='tooltip' data-placement='bottom' title='0'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            'strHTML.Append("<i class='fas fa-pencil-alt' aria-hidden='true' style='    font-size: 16px;' onclick=""AfterRelaseSprintSave('Sprint'," & IterationID & ")""></i>&nbsp;&nbsp;&nbsp;&nbsp;")

            ' IterationStatus = "Delayed"
            Dim Color As String = ""
            If tooltip = "Delayed with issue" Then
                Color = "#dd4b39"
            ElseIf tooltip = "Issue" Then
                Color = "#f39c12"
            ElseIf tooltip = "Delayed" Then
                Color = "#00c0ef"
            ElseIf tooltip = "In Control" Then
                Color = "purple"
            ElseIf tooltip = "Ready For Release" Then
                Color = "#00a65a"
            End If


            ' strHTML.Append(" <button type='button' class='btn btn-success' style='font-size: 12px;height: 25px; padding-top: 3px;background-color: #5bc0de; border-color: #5bc0de;'>Delayed</button>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            If CheckIsProductOwner(Session("intUserID")) <> 0 Then
                If IterationStatus.ToString.ToUpper <> "COMPLETED" Then
                    If CommonFunctions.Data.CheckIsDBNull(IterationID, 0) <> 0 Then
                        strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-toggle='tooltip' data-placement='bottom'  data-bs-target='#Remark" & IterationID & "' onclick=""UnmappedSprint(" & IterationID & ", " & ReleaseID & ",'txtRemark" & ReleaseID & "')""></i>")
                    End If
                Else
                    strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='	fa fa-share-square-o' aria-hidden='true' style='font-size: 16px;color: #de1818;' title='Terminate Sprint' data-bs-toggle='modal tooltip' data-bs-target='#Remark" & IterationID & "'></i>")
                    'End Of added by ashwini On 21-3-2023 for data-bs-toggle
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
        ' Author				:	Dipali
        ' Created				:   4-March-2018
        '=====================================================================
        Try


            Dim ValidationResponseText As New StringBuilder
            ValidationResponseText.Remove(0, ValidationResponseText.Length) ''EMPTY STRING
            Dim strQuery As String
            Dim strMessage As String = ""
            strQuery = "Exec usp_ScrumEntityDeleteValidation 'UserStory','" + UserStoryID + "'"
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
    Public Shared Function DeleteEntry(ByVal UserStoryID As String) As String
        '=====================================================================
        ' Procedure  Name		:	DeleteEntry
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali
        ' Created				:   4-JAN-2017
        '=====================================================================
        Try

            Dim frmReleaseplanning As New frmReleasePlanning()
            Dim strHTML As New StringBuilder()
            Dim strQuery As String = "usp_Del_ScrumEntity 'UserStory','" + UserStoryID + "'"
            Dim strDelete As String = CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            strHTML.Append(frmReleaseplanning.PlotSubUserStoryList(UserStoryID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilterDataUS(ByVal strEntityID As String, ByVal strEntity As String)
        '=====================================================================
        ' Procedure  Name		:	FilterDataUS
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:   To Plot Table 
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:    12th-March-2018
        '=====================================================================
        Try

            Dim objBacklog As New frmReleasePlanning
            Return objBacklog.Table_Backlog(strEntityID, strEntity)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Public Function Attachment_section(ByVal userStoryID As String, Optional ByVal RefreshFlag As String = "") As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Attachment_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Attachment section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divAttachments' class='clsBox'>")
    '    strHTML.Append("<h2 class='clsDiscussion' style='height:34px'>Attachments</h2>")
    '    strHTML.Append("<div id='divAttachmentList' class='col-sm-12'>")
    '    strHTML.Append(GetAttachmentList(userStoryID, RefreshFlag))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'NEW aTTACHMENT SECTION
    Public Function Attachment_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divAttachments' class='clsBox col-sm-12'>")
        strHTML.Append("<H2 class='clsDiscussion1'>Attachments</H2>")
        strHTML.Append("<div id='divAttachmentList' class='col-sm-11 col-sm-11'>")
        strHTML.Append(GetAttachmentList1(userStoryID))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function GetAttachmentList(userStoryID As String, Optional ByVal RefreshFlag As String = "")
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
        If RefreshFlag <> "AfterDelete" Then
            strHTML.Append(" <div id='Attachmentus'>")
        End If

        Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        Dim dtAttachment As New DataTable
        dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-left:-1%'><div class='demo-droppable' style='margin-bottom:20px'><p>Drag files here or click to upload</p></div><a onclick=UploadData(" & userStoryID & ",'UserStory')  style='padding: 5px 10px;color: white;background: #00bcd4;'><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            strHTML.Append(" <div class='attachRow' id='attachmentdata'>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append(" <div class='col-sm-5 col-sm-5 attachment_table'>")
            strHTML.Append("<span  title='Original File Name'  data-toggle='tooltip'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-5 col-sm-5 attachment_table' >")
            strHTML.Append("<span  title='Attached By'  data-toggle='tooltip'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-2 attachment_table'>")
            strHTML.Append("<i class='fa fa-trash'  style='color:red!important' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'UserStory')"" data-toggle='tooltip' title='Delete Attachment'></i>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Next
        If RefreshFlag <> "AfterDelete" Then
            strHTML.Append(" </div>")
        End If
        Return strHTML.ToString()

    End Function

    'Public Function Discussion_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Discussion_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Get Discussion section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divDiscussions1' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Discussions</h2>")
    '    strHTML.Append("<div class='col-sm-10'>")
    '    strHTML.Append("<textarea id='DiscussionTextArea' name='DiscussionTextArea' class='form-control'></textarea>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-2'>")
    '    ' strHTML.Append("<button id='btnSend' type='button' onclick=insertSprintReleaseDiscussion(" & userStoryID & ",'UserStory',this) class='btn btn-default btn-flat'><i class='fa  fa-comment-o' aria-hidden='true'></i>  Post</button>")
    '    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='btnSend'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & userStoryID & ",'UserStory',this,'txtDiscussions')><i class='fa  fa-comment-o' aria-hidden='true'></i>  Post</button>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<div id='divDiscussionList'>")
    '    strHTML.Append(PlotDiscussionThreadBody(userStoryID, strUserDesc, "UserStory"))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function


    Public Function Discussion_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussions' class='clsBox col-sm-12'>")
        strHTML.Append("<h2 class='clsDiscussion1'>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & userStoryID & "','UserStory',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        strHTML.Append("<div id='divDiscussionList'>")
        strHTML.Append(PlotDiscussionThreadBody(userStoryID, strUserDesc, "UserStory"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    'Public Function Resource_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Resource_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Resource section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divResource' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Resources</h2>")
    '    strHTML.Append("<div id='divResourceDetails1' style='overflow:auto;padding-right:3%;width:105.5%;' class='row text-center'>")
    '    'strHTML.Append("<table class='tblResource'>")
    '    Dim dtTable As New DataTable
    '    Dim strSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
    '    dtTable = CommonFunctions.Data.GetDataTable(strSql, True)
    '    For i As Integer = 0 To dtTable.Rows.Count - 1

    '        strHTML.Append("<div class='col-lg-3 col-md-6 mb-4'>")
    '        strHTML.Append("<div class='card'>")
    '        strHTML.Append("<img class='card-img-top' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("SystemFilename"), "") & "' alt=''>")
    '        strHTML.Append("<div class='card-body'>")
    '        strHTML.Append("<h4 class='card-title'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("EmployeeName"), "") & "</h4>")
    '        strHTML.Append("<p class='card-text'>Role : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("RoleDescription"), "") & "</p>")
    '        strHTML.Append("<p class='card-text'>Assignment Start Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedStartDate"), "") & "</p>")
    '        strHTML.Append("<p class='card-text'>Assignment End Date : " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("ExpectedEndDate"), "") & "</p>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("<div class='card-footer'>")
    '        strHTML.Append("<div class='counter'>")
    '        strHTML.Append("<div class='row'>")

    '        strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
    '        strHTML.Append("<div class='employees'>")
    '        strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("TotalTasks"), "") & "</p>")
    '        strHTML.Append("<p class='employee-p'>Total Tasks</p>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
    '        strHTML.Append("<div class='employees'>")
    '        strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("InProgressTasks"), "") & "</p>")
    '        strHTML.Append("<p class='employee-p'>In Progress</p>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("<div class='col-lg-4 col-md-4 col-sm-4 col-sm-12'>")
    '        strHTML.Append("<div class='employees'>")
    '        strHTML.Append("<p class='counter-count'>" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("CompletedTasks"), "") & "</p>")
    '        strHTML.Append("<p class='employee-p'>Completed</p>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")

    '        strHTML.Append("</div>")
    '        strHTML.Append("</div>")


    '    Next
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'NEW RESOURCE SECTION
    Public Function Resource_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divResource' class='clsBox col-sm-12'>")
        strHTML.Append("<h2 class='clsDiscussion1'>Resources</h2>")
        'strHTML.Append("<div id='divResourceDetails1' style='overflow:auto;padding-right:3%;width:105.5%;' class='row text-center'>")
        ''strHTML.Append("<table class='tblResource'>")
        'Dim dtTable As New DataTable
        'Dim Flag As String = "0"
        'Dim strSql As String = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("intProjectID") & "," & userStoryID & ",'UserStory'"
        'dtTable = CommonFunctions.Data.GetDataTable(strSql, True)
        'For i As Integer = 0 To dtTable.Rows.Count - 1
        '    Flag = 1
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
        ''Added By Dipali V On 2nd April 2018 For If no Resource are there
        'If Flag = 0 Then
        '    strHTML.Append("<div class='col-lg-12'>")
        '    strHTML.Append("<p class='nodata'>There are no items assign to resource</p>")
        '    strHTML.Append("</div>")
        'End If
        ''End of Added By Dipali V On 2nd April 2018 For If no Resource are there
        'strHTML.Append("</div>")





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

        strHTML.Append("<Div class='col-sm-12' id='divTeamsList'>")
        strHTML.Append("<table class='clsTeamTable'>")

        StrQuery = "usp_NG2_sel_tbl_PM_AgileTeamDetails " & Session("IntProjectID") & "," & userStoryID & ",'UserStory'"
        drGetTeamDetails = CommonFunctions.Data.GetDataReader(StrQuery, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        ' strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetTeamDetails("SystemFileName").ToString, "")
        While drGetTeamDetails.Read
            intnewCounter += 1
            If intnewCounter = 1 Then
                IscheckDatahas = 1
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
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


                strHTML.Append("<div class='card'>" & vbCrLf)
                'strHTML.Append("<div class='cardheader'>" & vbCrLf)
                strHTML.Append("<div class='Row' style='margin-top:3%'>")
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Posted By -" & EmployeeName & "'>")
                strHTML.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:50px;width:50px;' src='../../Images/Photo/" & SystemFilename & "' />")
                strHTML.Append("</span>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-10'>")

                Dim strLessComment As String = ""
                Dim strRemaining As String = ""
                If RoleDescription.Length > 10 Then
                    strLessComment = RoleDescription.Substring(0, 10)
                Else
                    strLessComment = RoleDescription
                End If
                strHTML.Append("<P class='ClsTeamDetails'><span  data-toggle='tooltip' data-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-toggle='tooltip' data-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
                strHTML.Append("<P class='ResourcePercentage'><span data-toggle='tooltip' data-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -18px; margin-right: 17px;border-radius:10px;color:white!important;' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</td>")

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



                strHTML.Append("<td>")
                strHTML.Append("<div class='card'>" & vbCrLf)
                'strHTML.Append("<div class='cardheader'>" & vbCrLf)
                strHTML.Append("<div class='Row' style='margin-top:3%'>")
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Posted By -" & EmployeeName & "'>")
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


                strHTML.Append("<div class='col-sm-10'>")
                strHTML.Append("<P class='ClsTeamDetails'><span  data-toggle='tooltip' data-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-toggle='tooltip' data-placement='bottom' title='" & RoleDescription & "'>" & strLessComment & "... </label></P>")
                ' strHTML.Append("<P class='ClsTeamDetails'><span  data-toggle='tooltip' data-placement='top' title='Employee Name'>" & EmployeeName & "</span> | <label class='ClsRole' data-toggle='tooltip' data-placement='top' title='Role Description'>" & RoleDescription & " </label></P>")
                strHTML.Append("<P class='ResourcePercentage'><span data-toggle='tooltip' data-placement='top' title='Resource Percentage'>" & ResourcePercentage & " % Allocation</span> </P>")
                strHTML.Append("<div class='progress' style='width:80%'>")
                'strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("<div class='progress-bar progress-bar-striped " & Clsprogressbar & "' role='progressbar' aria-valuenow='" & TaskCompletionPercentage & "' aria-valuemin='0' aria-valuemax='100' style='width:" & TaskCompletionPercentage & "%'>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -18px; margin-right: 17px;border-radius:10px;color:white!important;' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                intnewCounter = 0
            End If



        End While
        If intnewCounter = 1 Then
            strHTML.Append("</tr>")
        End If

        If IscheckDatahas = 0 Then
            strHTML.Append("<tr>")
            strHTML.Append("<td>")
            strHTML.Append("<div class='NoTeam'>")
            strHTML.Append("<span style='text-align:center' > There are no items assign to resource </span>") 'There are no items to show in this view.
            strHTML.Append("</div>")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")
        End If

        strHTML.Append("</table>")
        strHTML.Append("</Div>")
        strHTML.Append("</Div>")
        Return strHTML.ToString

    End Function
    'NEW History_section
    Public Function History_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        'Added By kashish On For UI change
        strHTML.Append("<div id='divHistory' class='clsBox col-sm-12' style=''>")
        'End of Added By kashish On For UI change
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<p class='clsDiscussion1'>History Details</p>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' name='table_search' id='txtSearchhistory' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divhistoryList'>")
        strHTML.Append(WriteGrid("HistorykList", userStoryID, ""))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    'NEW Issues_section
    Public Function Issues_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='divIssues' class='clsBox' style='margin-left:2%'>")
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<P >Issues Details</p>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<Div class='col-sm-12' id='divIssuesList'>")
        'strHTML.Append(WriteGrid("IssueList", userStoryID))
        'strHTML.Append("</Div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")






        'Added By kashish On For UI change
        strHTML.Append("<div id='divIssues' class='clsBox col-sm-12' style=''>")
        'End of Added By kashish On For UI change
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<p class='clsDiscussion1'>Issues Details</p>")
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding-bottom:22px;'><a data-toggle='tooltip' title='List View' data-placement='bottom' onclick=ShowData('List','subIssue')>List</a> | <a data-toggle='tooltip' title='Form View' data-placement='bottom' onclick=ShowData('Form','subIssue')>Add</a></h2>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssueList", userStoryID, ""))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")

        strHTML.Append("<Div class='col-sm-12' id='divIssueForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-toggle='tooltip' style='float:right;margin-top: -10px;' title='Save'  data-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Issue') class='fa fa-save'></i>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Summary<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:limitText(this,countdownSummary,500)' onKeyUp='javascript:limitText(this,countdownSummary, 500)'onchange=ClearSpan('txtSummary','spanUserDesc')", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownSummary' Id='countdownSummary'  style='border-style:None;float: right;margin-top:-35px;'>500</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Description<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , , , , , , , , , , , , , , "onkeyup='javascript:limitText(this,countdownDescription,1000)' onKeyUp='javascript:limitText(this,countdownDescription, 1000)'onchange=ClearSpan('txtSummary','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
        strHTML.Append("<small name='countdownDescription' Id='countdownDescription'  style='float: right;margin-top:-35px;'>1000</small>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIssueType", "SELECT ''", , , "onclick=GetSelectedSubtype(this) Class='form-control' style=''", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Sub Type<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSubIssueType", "SELECT ''", , " form-control", "Class='form-control' style=''", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Reported By<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        Dim StrReporter As String = Session("strUserName")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboreporter", "Select ''", , Session("strUserName"), "form-control", True, True, "form-control style=''")).ToString.Replace("'", "\'")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Staus<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboStatus", "Select ''", , " form-control", "Class='form-control' style=''", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")




        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Resonsible Person<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        Dim ResponsibleIssue As String = "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
        strHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboResonsible", ResponsibleIssue, , Session("intUserID"), "Class='form-control' style=''", False, True, , , , ))
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
        strHTML.Append("<div id='divReviews' class='clsBox col-sm-12' style=''>")
        'End of Added By kashish On For UI change

        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<p class='clsDiscussion1'>Reviews Details</p>")
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding-bottom:22px;'><a data-toggle='tooltip' title='List View' data-placement='bottom' onclick=ShowData('List','subReview')>List</a> | <a data-toggle='tooltip' title='Form View' data-placement='bottom' onclick=ShowData('Form','subReview')>Add</a></h2>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", userStoryID, "UserStory"))
        strHTML.Append("</Div>")
        strHTML.Append("</Div>")




        strHTML.Append("<Div class='col-sm-12' id='divReviewForm' style='display:none'>")

        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-toggle='tooltip' style='float:right;    margin-top: -10px;' title='Save'  data-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'Review') class='fa fa-save'></i>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='form-row'>")
        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Review Title<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewtitle", "txtReviewtitle", "form-control", , 100, , , , , , , , "", True, , , , , , True))
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
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewStartDate", "txtReviewStartDate", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float:right; margin-top: -35px;color:#0099CC;' id='#dpreviewstartdate'  onclick=""$('#txtReviewStartDate').datepicker();$('#txtReviewStartDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group SecControl' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>R.End Date<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReviewEnddate", "txtReviewEnddate", "form-control ", , 100, , , , , , , , " style='width:203px!important' onkeyup=ClearSpan('txtEnddate','spantxtEnddate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='float:right;  margin-top: -35px;color:#0099CC;' id='#dpReviewEnddate'  onclick=""$('#txtReviewEnddate').datepicker();$('#txtReviewEnddate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")



        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group' >")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;'>Reviewer<span class='required'>*</span></label> ")
        strHTML.Append(" <div class='col-md-8' >")
        strHTML.Append("<div class='btn-group dropdown' style='float:right;width: 100%;'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewer", "cboReviewer", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu' style='min-width: 190px!important;'>")


        Dim ReviewerDetailsnew As IDataReader
        Dim strSQL As String = "usp_Ng2_Sel_CurrentTeamMembers " & Session("IntProjectID") & ""
        ReviewerDetailsnew = CommonFunctions.Data.GetDataReader(strSQL, True)
        Dim intnewCounter As Integer = 0
        Dim IscheckDatahas As Integer = 0
        Dim ReviwerName As String = ""
        Dim ReviwerID As String = ""
        While ReviewerDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ReviwerName = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("UserName").ToString, "")
            ReviwerID = CommonFunctions.Data.CheckIsDBNull(ReviewerDetailsnew("EmployeeId").ToString, "")
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




        strHTML.Append(" <div class='col-md-12'>")
        strHTML.Append(" <div class='form-group '>")
        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;text-align:left'>Reviewee<span class='required'></span></label> ")
        strHTML.Append(" <div class='col-md-8' >")

        strHTML.Append("<div class='btn-group dropdown' style='float:right;    width: 100%;'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboReviewee", "cboReviewee", "form-control ", , 100, , , , , , , , "autocomplete='off' style=''  data-bs-toggle='dropdown'", True, , , , , , True))
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        ' strHTML.Append("<button type='button' class='btn btn-secondary dropdown-toggle dropdown-toggle-split btn-Green' aria-haspopup='true' aria-expanded='false'>")
        strHTML.Append("</button>")
        strHTML.Append("<ul class='dropdown-menu'>")


        Dim ReviewDetailsnew As IDataReader
        Dim strSQL1 As String = "usp_NG2_Sel_tbl_PM_ReviewStatistics_RevieweeList 'ReviewedOf', " & Session("IntProjectID") & ", NULL, NULL,NULL,NULL,Null,'-1',0"
        ReviewDetailsnew = CommonFunctions.Data.GetDataReader(strSQL1, True)

        Dim ResourceName As String = ""
        Dim ResourceID As String = ""
        While ReviewDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ResourceName = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("Resource Name").ToString, "")
            ResourceID = CommonFunctions.Data.CheckIsDBNull(ReviewDetailsnew("EmployeeID").ToString, "")
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
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRevieStatus", "usp_NG2_Sel_tbl_IB_Priorities", , "Open", "class='form-control' ", True, True))
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


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function Tasks_section(ByVal userStoryID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""
        If Flag <> "aftersave" Then
            'Added By kashish On For UI change
            strHTML.Append("<div id='divTasks' class='clsBox col-sm-12' style=''>")
            'End of Added By kashish On For UI change
        End If
        Dim TaskID As String = "0"
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("<p class='clsDiscussion1'>Tasks Details</p>")
        'strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;margin-top:-3%'><a onclick=ShowData('List','subTask')>List</a> | <a onclick=ShowData('Form','subTask')>Add</a></h2>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divTaskList'>")
        'strHTML.Append(WriteGrid("TaskList", userStoryID))
        strHTML.Append("<table id='tblProjectDetail' style='Width:100%;'>")
        strHTML.Append("<tbody>")

        strHTML.Append(TasksDetails(userStoryID))

        strHTML.Append("<tr class='trProjectDetail'>")
        strHTML.Append("<td  ><A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;'  data-toggle='tooltip' data-placement='right' title='Click here to add new record'></i></A></td>")

        strHTML.Append("<td >")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName0", "txtTaskName0", "form-control", , 100, , , , , , , , "  PlaceHolder='Task Name'", True, , , , , , True))
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
        strHTML.Append("<input type=hidden name='hdrownumber' value='0' /></td>&nbsp;")

        strHTML.Append("<td>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate0", "txtStartDate0", "form-control", , 100, , , , , , , , " PlaceHolder='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px;float:right;color:#0099CC;' id='#dpstartdate0'  onclick=""$('#txtStartDate0').datepicker();$('#txtStartDate0').datepicker('show');""></i>")
        strHTML.Append("</td>&nbsp;")


        'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
        'strHTML.Append("<i id='spanStartDate0' data-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
        'strHTML.Append("</td>")
        strHTML.Append("<td>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate0", "txtEndDate0", "form-control", , 100, , , , , , , , " PlaceHolder='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
        strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px;float:right;color:#0099CC;' id='#dpEnddate0'  onclick=""$('#txtEndDate0').datepicker();$('#txtEndDate0').datepicker('show');""></i>")
        strHTML.Append("</td>&nbsp;")

        strHTML.Append("<td >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", , , , , , False, , , , "PlaceHolder='Work Hrs' onkeyup=ClearSpans(this.id,'SpantxtRresourceStartDate0','spanWorkHrs0','errorPopOver0') ShowLength=4", True, , , , , , True))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>&nbsp;")


        strHTML.Append("<td>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 104, , "class='form-control' style='margin-left:12%!Important;width:76%!Important'", True, True, , , , ))
        strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center'>")
        If TaskID = "0" Then
            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-placement='bottom'  id='idEdit0' data-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
        Else
            strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4;cursor:no-drop'  data-placement='bottom' id='idEdit0' data-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)'></i>")
        End If
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center'>")
        strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-placement='bottom' data-toggle='tooltip'  id='iddelete0' title='Delete Task' class='fa fa-trash' onclick='DeleteTask()'></i>")
        strHTML.Append("</td>")


        strHTML.Append("<td style='width:3%;text-align:center;'>")
        'strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
        strHTML.Append("<i style='font-size:14px!important;text-align:center' data-toggle='tooltip'  data-placement='bottom'  id='SaveBtn0' data-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
        strHTML.Append("</td>")
        'strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
        'strHTML.Append("<i id='spanWorkHrs0' data-toggle='tooltip' style='display:none;' title='Error Details' data-toggle='popover' data-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
        'strHTML.Append("</td>")





        strHTML.Append("<td>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")


        strHTML.Append("</Div>")
        strHTML.Append("</div>")




        If Flag <> "aftersave" Then
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString

    End Function

    Public Function Chart_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divChart' class='clsBox col-sm-12'>")
        strHTML.Append("<h2 class='clsDiscussion1'>Chart</h2>")
        strHTML.Append(Graph_US(userStoryID, "UserStory"))
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function


    'Public Function History_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	History_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot History section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divHistory' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>History</h1>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'Public Function Issues_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Issues_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Issues section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divIssues' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Issues</h2>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'Public Function Reviews_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Reviews_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Reviews section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divReviews' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Reviews</h2>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'Public Function Tasks_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Tasks_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Tasks section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divTasks' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Tasks</h2>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function

    'Public Function Chart_section(ByVal userStoryID As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Chart_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Chart section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divChart' class='clsBox'>")
    '    strHTML.Append("<h2  class='clsDiscussion'>Chart</h2>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function
    'Old Tab section
    'Public Function Table_Backlog(Optional ByVal strEntityID As String = "", Optional ByVal strEntity As String = "") As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Table_Backlog
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Plot Table 
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID")

    '    If strEntity = "Category" Then
    '        strSql &= "," & strEntityID
    '    ElseIf strEntity = "Priority" Then
    '        strSql &= ",NULL," & strEntityID
    '    End If
    '    Dim dtProductBacklog As New DataTable()
    '    dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div class='table-responsive table-bordered col-sm-4' id='leftTree' style='overflow-y: scroll; height: 433px;padding-right: 0px;padding-left: 0px;'>   ")
    '    strHTML.Append(" <table class='table'>")
    '    strHTML.Append("	<thead>")
    '    strHTML.Append("	  <tr><th>Backlogs</th><th style='position:relative'>")
    '    strSql = "usp_NG2_sel_tbl_APP_ScrumCategory"
    '    Dim dtCategory As New DataTable
    '    dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
    '    strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;'><i  data-toggle='tooltip' title='Settings' style='font-size:16px!important' class='fa fa-align-justify Home'></i></div>")
    '    strHTML.Append("<ul class='dropdown-menu' role='menu'>")
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

    'new tab section 
    Public Function Table_Backlog(Optional ByVal strEntityID As String = "", Optional ByVal strEntity As String = "", Optional ByVal UserStoryID As String = "") As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = "usp_NG2_sel_tbl_PM_ScrumUserStory_ProductBacklog " & Session("intProjectID")

        If strEntity = "Category" Then
            strSql &= "," & strEntityID
        ElseIf strEntity = "Priority" Then
            strSql &= ",NULL," & strEntityID
        End If
        Dim dtProductBacklog As New DataTable()
        dtProductBacklog = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<div class='table-responsive table-bordered col-sm-3' id='leftTree' style='overflow-y: scroll; height: 515px;padding:0;'>   ")
        strHTML.Append(" <table class='table'>")
        strHTML.Append("	<thead>")
        strHTML.Append("	  <tr><th>Backlogs</th><th style='position:relative'>")
        strSql = "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & ""
        Dim dtCategory As New DataTable
        dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div  data-bs-toggle='dropdown' style='cursor:pointer;'><i  data-toggle='tooltip' title='Settings' style='font-size:16px!important' data-placement='bottom' class='fa fa-align-justify Home'></i></div>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("<ul class='dropdown-menu' role='menu' style='margin-left: -88px;'>")
        strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
        strHTML.Append("<b>Category</b>")
        strHTML.Append("</li>")
        For i As Integer = 0 To dtCategory.Rows.Count - 1
            If dtCategory.Rows(i)("CategoryID").ToString() = strEntityID And strEntity = "Category" Then
                strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
            Else
                strHTML.Append("<li onclick=FilterData('Category'," & dtCategory.Rows(i)("CategoryID") & ",this)>")
            End If
            strHTML.Append(dtCategory.Rows(i)("Category"))
            strHTML.Append("</li>")

        Next

        strSql = "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities"
        dtCategory = CommonFunctions.Data.GetDataTable(strSql, True)
        strHTML.Append("<li style='border-bottom:1px solid #ddd;'>")
        strHTML.Append("<b>Priority</b>")
        strHTML.Append("</li>")
        For i As Integer = 0 To dtCategory.Rows.Count - 1
            If dtCategory.Rows(i)("PriorityID").ToString() = strEntityID And strEntity = "Priority" Then
                strHTML.Append("<li style='background-color:#ddd' onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
            Else
                strHTML.Append("<li onclick=FilterData('Priority'," & dtCategory.Rows(i)("PriorityID") & ",this)>")
            End If
            strHTML.Append(dtCategory.Rows(i)("Priority"))
            strHTML.Append("</li>")
        Next
        strHTML.Append("</ul>")
        strHTML.Append("</th> </tr>")
        strHTML.Append("	</thead>")
        strHTML.Append("	<tbody id='tblUserStory_body'>")
        For i As Integer = 0 To dtProductBacklog.Rows.Count - 1
            If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) <> 0 Then
                If CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), "").ToString() = UserStoryID Then
                    strHTML.Append("<tr><td style='cursor:pointer;color:#3c7dcf' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

                Else
                    strHTML.Append("<tr><td style='cursor:pointer;' colspan=2 onclick='EditUserStory(" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("UserStoryID"), 0) & ")'><small>" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("initialRank"), "").ToString() & "</small>&nbsp;&nbsp;" & CommonFunctions.Data.CheckIsDBNull(dtProductBacklog.Rows(i)("Description"), "").ToString() & "</td> </tr>")

                End If
            End If
        Next
        strHTML.Append("	</tbody>")
        strHTML.Append("	</table>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function



    'New heda section
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
            'Commented & Added By Dipali V On 10th April 2018 For Access Issue
            'strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            strIterationName = CommonFunctions.Data.CheckIsDBNull(drGetUserStory("IterationID"), 0)
            'End of Commented & Added By Dipali V On 10th April 2018 For Access Issue
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
        ' globalUSID = UserStoryId
        drGetUserStory.Dispose()
        If strIterationName = 0 Then
            strIterationName = ""
        End If
        strHTML.Append("<div class='col-sm-9'style='margin-top: 10px;'>")
        strHTML.Append("<input type='hidden' value='" & UserStoryId & "' id='hdnusid' />")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-2'>" & vbCrLf)
        'strHTML.Append("<div style='height:50px;width:50px;background-color:" & strPriorityColor & ";' class='img-circle' ></div>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='font-size: 50px;color:" & strPriorityColor & ";'></i>")
        strHTML.Append("<p style='color: white;font-weight: 600;font-size: 15px;position: absolute;width: 35px;transform: translate(20%, 0px);top: 9px;left: 2px;text-align: center;' title='User story ID' data-toggle='tooltip' data-placement='bottom'>" & UserStoryId & "</p></div>")

        strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-1'>" & vbCrLf)

        'strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-8'>" & vbCrLf)

        strHTML.Append("<p style='font-size: 16px; font-weight: 500;' ><sapn title='User Story Name' data-toggle='tooltip' data-placement='bottom'>" & strFeatureName & "</span></p>" & vbCrLf)
        strHTML.Append("<label style='white-space:nowrap;font-weight:normal;font-size:11px'>Created By: " & strCreatedBy & " On " & Convert.ToDateTime(strCreatedDate).ToString("dd-MMM-yyyy") & "</label>" & vbCrLf)
        strHTML.Append("<p class='label label-warning' style='font-weight: 600;font-size: 14px;position: fixed;margin-left:26px;' title='Rank' data-toggle='tooltip' data-placement='bottom'>" & strInitialRank & "</p>" & vbCrLf)
        strHTML.Append("</div>")

        strHTML.Append("<div>" & vbCrLf)
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
        strHTML.Append("<div class=''>")
        strHTML.Append("")
        strHTML.Append("</div>")
        strHTML.Append("<div class='' style='float:right;'>")
        If (UserStoryId <> "" Or UserStoryId <> "0") And strIterationName = "" Then
            If m_objAccess.Edit Then
                strHTML.Append("<i data-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
            End If
        Else
            If strIterationName = "" Then
                If m_objAccess.Add Then
                    strHTML.Append("<i data-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save'></i>")
                End If
            End If
        End If
        If m_objAccess.Delete Then
            strHTML.Append("&nbsp;&nbsp;<i class='fa fa-trash-o' aria-hidden='true' data-toggle='tooltip' data-placement='bottom' title='Delete User Story' onclick=""Delete_UserStory(" & UserStoryId & ",'')""></i>")
        End If
        strHTML.Append("</div>")
        strHTML.Append("</div><hr>")
        Return (strHTML.ToString())

    End Function

    'Tab Section
    'Public Function Tab_section() As String
    '    '=====================================================================
    '    ' Procedure  Name		:	Tab_section
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:   To Tab section
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Dipali V
    '    ' Created				:    6th-March-2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div class='row '>")
    '    strHTML.Append("<ul class='col-sm-12' id=ulTabs>" & vbCrLf)
    '    strHTML.Append("<li class='active' ><a href='#frmDetails' style='text-decoration: underline;color:#5bc0de'>Details</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divSubstories'>Substories</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divAttachments'>Attachments</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li ><a href='#divDiscussions1'>Discussion</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divResource'>Resources</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divHistory'>History</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divIssues'>Issues</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divReviews'>Reviews</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divTasks'>Task</a></li>&nbsp;&nbsp;" & vbCrLf)
    '    strHTML.Append("<li><a href='#divChart'>Charts</a></li>" & vbCrLf)
    '    strHTML.Append("</ul>")
    '    strHTML.Append("</div><br>")
    '    Return (strHTML.ToString())
    'End Function

    ' New tab section
    Public Function Tab_section() As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row '>")
        strHTML.Append("<ul class='col-sm-11' id=ulTabs>" & vbCrLf)
        strHTML.Append("<li class='active' ><a href='#frmDetails' style='text-decoration: underline;color:#5bc0de'>Details</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divSubstories'>Sub Stories</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divAttachments'>Attachments</a></li> " & vbCrLf)
        strHTML.Append("<li ><a href='#divDiscussions'>Discussion</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divResource'>Resources</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divHistory'>History</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divIssues'>Issues</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divReviews'>Reviews</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divTasks'>Task</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#divChart'>Charts</a></li>" & vbCrLf)
        strHTML.Append("</ul>")
        strHTML.Append("</div><br>")
        Return (strHTML.ToString())

    End Function

    'New form section
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
            Dim str As String = "usp_NG2_GetSelectedUserStoryColumnsForUser " & Session("intUserID") & ""
            drGetSelectedCheckBoxValue = CommonFunctions.Data.GetDataReader(str, True)
            While drGetSelectedCheckBoxValue.Read()
                SelectedCheckbox = CommonFunctions.Data.CheckIsDBNull(drGetSelectedCheckBoxValue("SelectedColumns").ToString, "")
            End While
            SelectedCheckboxSplit = SelectedCheckbox.Split(",")


            strHTML.Append(" <Div id='frmDetails' class='clsBox col-sm-12'>")

            For Each SelectedCheckboxValues As String In SelectedCheckboxSplit
                Select Case SelectedCheckboxValues
                    Case "FunctionalNo"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Functional No.</label> ")
                        strHTML.Append(" <div class='col-md-8'>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFunctionalNumber", "txtFunctionalNumber", "form-control", , 100, strFunctionalNumber, , , , IIf(strState <> "InActive" And strIterationName = "" And (strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = "")), False, True), , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "UserStoryName"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>User Story<span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtFeatureName", "txtFeatureName", "form-control", , 100, strFeatureName, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup=ClearSpan('txtFeatureName','spanFeatureName')", True, , , , , , True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<span id='spanFeatureName' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "Description"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>Description <span class='required'>*</span></label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        Dim len As Integer = 1000
                        Dim len1 As Integer
                        If strUserDesc.Length <> -1 Then
                            len1 = strUserDesc.Length
                            len = 1000 - len1
                        End If
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtUserDesc", "txtUserDesc", , "form-control", , , , , , 52, len, strUserDesc, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc') data-autoresize", True, EnableHTMLEncode:=True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<small name='countdown' Id='countdown'>" & len & "</small>")
                        strHTML.Append("<span id='spanUserDesc' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "BusinessValue"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Business Value</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtBusinessValue", "txtBusinessValue", , "form-control", , , , , , , 1000, strBusinesValue, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownBU,1000)' onKeyUp='javascript:limitText(this,countdownBU, 1000)' onkeyup=ClearSpan('txtUserDesc','spanUserDesc')", True, , , , , , , , , True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<small name='countdownBU' Id='countdownBU'>" & (1000 - strBusinesValue.Length) & "</small>")
                        strHTML.Append("<span id='spanBusinessValue' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Priority"
                        strHTML.Append(" <div class='col-md-6'>")
                        'added by ashwini on 21-3-2023 for data-bs-toggle
                        strHTML.Append("<div class='dropdown'> <label class='col-md-4 control-label labelcls'>Priority <span class='required'>*</span> &nbsp;<a id='aPriority'  data-bs-toggle='dropdown' title='Select Priority Color' style='cursor:pointer' ><i id='iPriorityColor' style='color:" & strPriorityColor & " !important;' class='fa fa-square' aria-hidden='true'></i></a></label> ")
                        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
                        strHTML.Append("<div class='dropdown-menu' role='menu'>")
                        strHTML.Append("<table class='table' id='tblPriorityColor'>")
                        strHTML.Append("<tr>")
                        If UserStoryId <> "" Then
                            strHTML.Append(GetColorMaster(strPriority, "Priority"))
                        End If
                        strHTML.Append("</tr>")
                        strHTML.Append("</table>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append(" <div class='col-md-8'>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , strPriority, "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))

                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<span id='spanPriority' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "State"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>State</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStateEdit", "usp_NG2_sel_tbl_PM_ScrumUserStory_State ", , strState, "class='form-control' onchange=ClearSpan('cboStateEdit','spanState') " & IIf(strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<span id='spanState' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Complexity"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>Complexity</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group '>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_NG2_sel_tbl_PM_ScrumUserStory_Complexity", , strComplexity, "class='form-control' onchange=ClearSpan('cboComplexity','spanComplexity') " & IIf(strState <> "InActive" And strIterationName = "", "", "disabled"), True, True))
                        strHTML.Append(" <span class='input-group-addon '>")
                        strHTML.Append("<span id='spanComplexity' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                    Case "Status"
                    Case "Category"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls' style='white-space: nowrap;margin-top: 11px;'>Category</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_NG2_sel_tbl_APP_ScrumCategory " & Session("intProjectID") & "", , strCategory, "class='form-control' onchange=SelectCategoryColor(this);ClearSpan('cboCategory','spanCategory') " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))
                        strHTML.Append("<span id='spanCategory' style='color: #dd1037; font-size: 12px;' />")

                        strHTML.Append("</div>")
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
                    Case "InitialEstimate"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label labelcls'>Story Point</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append(" <div class='input-group'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", , 3, strStoryPoint, , , , IIf(strState <> "InActive" And strIterationName = "", False, True), , , "onkeyup=ClearSpan('txtStoryPoint','spanStoryPoint')", True, , , , , , True))
                        strHTML.Append(" <span class='input-group-addon'>")
                        strHTML.Append("<span id='spanStoryPoint' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                    Case "Version"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Version</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append("<div class='input-group'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strVersion, "class='form-control' onchange=SelectVersionColor(this); ClearSpan('cboCategory','spanCategory')   " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "FixedVersion"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-4 control-label' style='white-space: nowrap;margin-top: 11px;'>Fixed Version</label> ")
                        strHTML.Append(" <div class='col-md-8 '>")
                        strHTML.Append("<div class='input-group'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFixedVersion", "usp_NG2_sel_tbl_APP_ScrumVersion " & Session("intProjectID") & "", , strFixedVersion, "class='form-control' onchange=SelectFVersionColor(this); ClearSpan('cboCategory','spanCategory')  " & IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), "", "disabled"), True, True))

                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("<span id='spanFixedVersion' style='color: #dd1037; font-size: 12px;' ></span>")
                    Case "AcceptanceCriteria"
                        strHTML.Append(" <div class='col-md-6'>")
                        strHTML.Append(" <label class='col-md-5 control-label' style='white-space: nowrap;margin-top: 11px;'>Acceptance Criteria</label> ")
                        strHTML.Append(" <div class='col-md-7 '>")
                        strHTML.Append(" <div class='input-group'>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAcceptanceCriteria", "txtAcceptanceCriteria", , "form-control", , , , , , , 1000, strAcceptanceCriteria, , , , IIf(strState <> "InActive" And strIterationName = "" And strIsPrductOwner = "1" Or (strIsPrductOwner <> "1" And UserStoryId = ""), False, True), , , "onkeyup='javascript:limitText(this,countdownAC,1000)' onKeyUp='javascript:limitText(this,countdownAC, 1000)' onkeyup=ClearSpan('txtAcceptanceCriteria','spanAcceptanceCriteria')", True, , , , , , , , , True))
                        strHTML.Append(" <span class='input-group-addon'>")
                        strHTML.Append("<small name='countdownAC' Id='countdownAC'>" & (1000 - strAcceptanceCriteria.Length) & "</small>")
                        strHTML.Append("<span id='spanAcceptanceCriteria' style='color: #dd1037; font-size: 12px;' ></span>")
                        strHTML.Append("</span>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")
                        strHTML.Append("</div>")

                End Select
            Next
            strHTML.Append("<div class='row'>")

            strHTML.Append("<div class='col-md-12 align-right'>")
            GetAccessRights()
            If (UniqueID <> "" Or UniqueID <> "0") And m_strUserName <> "" Then
                If m_objAccess.Edit Then
                    If strIsPrductOwner = 1 Then
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveNew_UserStory()'><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                    Else
                        strHTML.Append("<button type='button' class='btn btn-info' id='addUpdate'  data-toggle='tooltip' data-placement='top'  title='Update' onclick='SaveNew_UserStory()' disabled><i class='fa fa-request-update ' aria-hidden='true'></i>  Update</button>&nbsp;&nbsp;&nbsp;")
                    End If
                End If
            Else
                If m_strUserName = "" Then
                    If m_objAccess.Add Then
                        strHTML.Append("<button type='button' class='btn btn-info' id='addsprint'  data-toggle='tooltip' data-placement='top'  title='Save' onclick='SaveNew_UserStory()'>Save</button>&nbsp;&nbsp;&nbsp;")
                    End If
                End If
            End If
            If m_objAccess.Delete Then
            End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</Div>")





        Catch ex As Exception
            Return ex.Message
        End Try
        Return (strHTML.ToString())
    End Function

    'NEW SUBSTORIES
    Public Function Substories_section(ByVal userStoryID As String) As String


        Dim strHTML As New StringBuilder()
        Dim strSql As String = ""

        strHTML.Append("<div id='divSubstories' class='clsBox col-sm-12'>")
        strHTML.Append("<h2 class='clsDiscussion1'>Sub User Stories</h2>")
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:22px;'><a data-toggle='tooltip' title='List View' data-placement='bottom' onclick=ShowData('List','SubUS')>List</a> | <a data-toggle='tooltip' title='Form View' data-placement='bottom' onclick=ShowData('Form','SubUS')>Add</a></h2>")
        strHTML.Append("<Div class='col-sm-12' id='divSubstoryList'>")
        strHTML.Append(PlotSubUserStoryList(userStoryID))
        strHTML.Append("</Div>")
        strHTML.Append("<Div class='col-sm-12' id='divSubstoryForm' style='display:none'>")
        strHTML.Append(" <div class='col-sm-12 '>")
        strHTML.Append("<i data-toggle='tooltip' style='float:right;    margin-top: -10px;    margin-right: -20px;' title='Save'  data-placement='left' onclick=Save_SubTab_Data(" & userStoryID & ",'SubStory') class='fa fa-save'></i>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-4 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Story Name</label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubStoryName", "txtSubStoryName", "form-control", , 100, , , , , , , , "onkeyup=ClearSpan('txtFunctionalNumber','spanFunctionalNumber')", True, , , , , , True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-4 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>User Description</label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubStoryDesc", "txtSubStoryDesc", , "form-control", , , , , , 50, , , , , , , , , "onkeyup='javascript:limitText(this,countdown,1000)' onKeyUp='javascript:limitText(this,countdown, 1000)'onchange=ClearSpan('txtUserDesc','spanUserDesc')", True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append(" <div class='row'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <div class='col-sm-4 '>")
        strHTML.Append(" <label class='col-sm-12 control-label' style='white-space: nowrap;margin-top: 11px;'>Priority</label> ")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-8 '>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubcboPriority", "usp_NG2_sel_tbl_PM_ScrumUserStory_Priorities", , , "class='form-control' onchange=SelectPriorityColor(this);ClearSpan('cboPriority','spanPriority')", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</Div>")
        strHTML.Append("</div>")

        Return strHTML.ToString

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
        ' Author				:	Dipali V
        ' Created				:    6th-March-2018
        '=====================================================================
        Try

            If strUserStoryId = "" Then
                strUserStoryId = "NULL"
            End If
            ' Dim StrQuery As String = "usp_NG2_GetInitialRank " & HttpContext.Current.Session("intProjectID") & "," & Priority & ", '" & objComplexity & "'," & strUserStoryId & ""
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



    Public Shared Function GetColorMaster(ByVal Id As String, ByVal strMode As String)


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
        ' Author				:	Dipali V
        ' Created				:   5th-March-2018
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

    <System.Web.Services.WebMethod()>
    Public Shared Function FilterData(ByVal Entity As String, ByVal ReleaseID As String)
        '=====================================================================
        ' Purpose				:	FilterData
        ' Author				:	Dipali V
        ' Created				:	7th March 2018
        '=====================================================================
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder()

            Dim objfrmReleasePlanning As New frmReleasePlanning()
            strGridHTML.Append(objfrmReleasePlanning.WriteGrid(Entity, "", ""))

            'strGridHTML.Append(objfrmReleasePlanning.ReleasePlanning("AfterTerminateSprint", ReleaseID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function



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
        Dim IscheckDatahas As Integer = 0
        While TasksDetailsnew.Read
            intnewCounter += 1
            IscheckDatahas = 1
            ScrumTaskName = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("ScrumTaskName").ToString, "")
            Effort = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("Effort").ToString, "")
            AssignedTo = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EmployeeID").ToString, "")
            TaskID = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("TaskID").ToString, "")
            StartDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("StartDate").ToShortDateString(), "")
            EndDate = CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate").ToShortDateString(), "")
            'EndDate = CType(CommonFunctions.Data.CheckIsDBNull(TasksDetailsnew("EndDate"), "").ToShortDateString(),


            strHTML.Append("<tr class='trProjectDetailedit'>")
            strHTML.Append("<td>")
            ' strHTML.Append("<A href='javascript:ShowHide_SectionTR()'><i class='fa fa-plus' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%;cursor: not-allowed;'  data-toggle='tooltip' data-placement='right' title='Click here to add new record'></i></A>")
            strHTML.Append("</td>")
            strHTML.Append("<td>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cborole0", "Usp_App_Sel_tbl_PM_Roles", , , "class='form-control' onchange=ClearSpan('Cborole0','SpanCboPGroup')", False, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtTaskName" & TaskID, "txtTaskName" & TaskID, "form-control", , 100, ScrumTaskName, , , True, , , , "  PlaceHolder='Task Name'", True, , , , , , True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , 0, , , , , , True, , True))
            strHTML.Append("</td>")

            strHTML.Append("<td>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStartDate" & TaskID, "txtStartDate" & TaskID, "form-control", , 100, StartDate, , , True, , , , " PlaceHolder='Start Date' onkeyup=ClearSpan('txtStartDate','spantxtStartDate')", True, , , , , , True))
            strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px;float:right;color:#0099CC;' id='#dpstartdate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>")


            'strHTML.Append("<td  style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanStartDate0' data-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            strHTML.Append("<td>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEndDate" & TaskID, "txtEndDate" & TaskID, "form-control", , 100, EndDate, , , True, , , , " PlaceHolder='End Date' onkeyup=ClearSpan('txtEndDate0','spantxtEndDate0')", True, , , , , , True))
            strHTML.Append(" <i class='far fa-calendar-check' aria-hidden='true' style='margin-top: -35px;float:right;color:#0099CC;' id='#dpEnddate" & TaskID & "' disabled></i>")
            strHTML.Append("</td>")

            strHTML.Append("<td>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" & TaskID, "txtWorkHrs" & TaskID, "form-control", , , Effort, "Center", , True, , , , "style='text-align:center!important' PlaceHolder='Work Hrs' ShowLength=4", True, , , , , , True))
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>")


            strHTML.Append("<td>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboresource" & TaskID, "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 120, AssignedTo, "class='form-control' style='margin-left:12%!Important;width:76%!Important' disabled", True, True, , , , True))
            strHTML.Append("<span style='color: #dd1037; font-size: 12px;float:right;margin-right:43%' id='SpantxtWorkHrs'></span>")
            strHTML.Append("</td>")

            Dim strDelete As String = "usp_NG2_del_tbl_PM_ProjectTasks  " & Session("IntProjectId") & "," & TaskID & ""
            Restult = CStr(CommonFunction.Data.GetDataScalar(strDelete, True))

            strHTML.Append("<td style='width:3%;text-align:center'>")
            If TaskID <> "" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-placement='bottom'  id='idEdit" & TaskID & "' data-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & "," & TaskID & ")'></i>")

            Else
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:#429ad4' data-placement='bottom'  id='idEdit" & TaskID & "' data-toggle='tooltip' title='Edit Task' class='fas fa-pencil-alt' onclick='EditTask(" & userStoryID & ",0)' disabled></i>")
            End If

            strHTML.Append("</td>")



            strHTML.Append("<td style='width:3%;text-align:center'>")
            If Restult = "1" Then
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-placement='bottom' data-toggle='tooltip'  id='iddelete" & TaskID & "'  title='Delete Task' class='fa fa-trash' onclick='DeleteTask(" & userStoryID & "," & TaskID & ")'></i>")
            Else
                strHTML.Append("<i style='font-size:14px!important;text-align:center;color:red' data-placement='bottom' data-toggle='tooltip'  id='iddelete" & TaskID & "'   title='you do not have access to delete Task' class='fa fa-trash' onclick='DeleteTask(" & userStoryID & "," & TaskID & ")' disabled></i>")
            End If
            strHTML.Append("</td>")


            strHTML.Append("<td style='width:3%;text-align:center;'  id='Update" & TaskID & "'>")
            'strHTML.Append("<button type='button' id='SaveBtn0' style='width:50px;vertical-align: baseline;' class='btn btn-primary btn-flat' onclick='TaskSave_OnClick()';>Save</button>&nbsp;")
            strHTML.Append("<i style='font-size:14px!important;text-align:center'  data-placement='bottom' data-toggle='tooltip'  id='SaveBtn" & TaskID & "' data-toggle='tooltip' title='save Task' class='fa fa-save' onclick=""Save_SubTab_Data(" & userStoryID & ",'Task')""></i>")
            strHTML.Append("</td>")
            'strHTML.Append("<td style='color:#dd4b39;font-size:16px'>")
            'strHTML.Append("<i id='spanWorkHrs0' data-toggle='tooltip' style='display:none;' title='Error Details' data-toggle='popover' data-placement='left' data-content=''  class='fa fa-info-circle' aria-hidden='true'></i>")
            'strHTML.Append("</td>")
            'strHTML.Append("<td>")
            'strHTML.Append("<a id='errorPopOver0'  style='font-size:15px;display:none' title='Error Details' data-toggle='popover' data-bs-target='#popOverDiv' onmouseover=DataHover(this) data-placement='left' data-content='' class='btn btn-block btn-danger far fa-check-square errorList'></a>")
            'strHTML.Append("</td>")
            strHTML.Append("</tr>")
        End While





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
        strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:14px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='upload' data-toggle='tooltip' title='Upload File' data-placement='bottom' onclick=UploadData(" & userStoryID & ",'" & flag & "')><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
        strHTML.Append(" <div id='listattachment'>")
        For i As Integer = 0 To dtAttachment.Rows.Count - 1
            strHTML.Append(" <div class='attachRow'>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append(" <div class='col-sm-5 col-sm-5 attachment_table '>")
            strHTML.Append("<span  data-toggle='tooltip' title='File Name' data-placement='bottom' style='word-break:break-all'>" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("OriginalFileName"), "") & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-5 col-sm-5 attachment_table '>")
            strHTML.Append("<span  data-toggle='tooltip' title='Attached By' data-placement='bottom'> " & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachedBy"), "") & " [" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Duration"), "") & "]" & "</span>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='col-sm-2 attachment_table '>")
            strHTML.Append("<i data-toggle='tooltip' data-placement='bottom' title='Delete Attachment' class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("AttachmentID"), "") & "," & userStoryID & ",'Userstory')""></i>")
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

    Public Function Graph_US(ByVal userStoryID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='graph' class='clsBox'>")


        strHTML.Append("<div class=''>")
        strHTML.Append("<div class='' style='display:flex;'>")
        strHTML.Append("<nav class='col-sm-3 col-sm-12' id='myScrollspy'>")
        strHTML.Append("<ul class='nav nav-pills nav-stacked'>")


        strHTML.Append("<li><a href='#BurnDown' class='active'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
        strHTML.Append("<li><a href='#BurnUp'  >Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
        strHTML.Append("<li><a href='#Velocity' >Velocity</a></li>") 'onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")""
        'strHTML.Append("<li><a href='#Flow' >Flow</a></li>") 'onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")""
        'strHTML.Append("<li><a href='#ComSprint' >Com-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")""
        'strHTML.Append("<li><a href='#CanSprint' >Can-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")""

        strHTML.Append("</ul>")
        strHTML.Append(" </nav>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div class='col-sm-9 col-sm-12 scrollspy-example' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='5' style='width:66%!important'>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
        strHTML.Append(PlotBurnDown(userStoryID, Flag, "BurnDown"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
        strHTML.Append(PlotBurnDown(userStoryID, Flag, "BurnUp"))
        strHTML.Append("</div>")



        strHTML.Append("<div id='Velocity' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Velocity</h3>")
        strHTML.Append(PlotBurnDown(userStoryID, Flag, "Velocity"))
        strHTML.Append("</div>")


        'strHTML.Append("<div id='Flow' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Flow</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "Flow"))
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='ComSprint' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Com-Sprint</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "ComSprint"))
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='CanSprint' class='tabcontentChart'>")
        'strHTML.Append("<h3 class='ClsHeaderGraph'>Can-Sprint</h3>")
        'strHTML.Append(PlotBurnDown(SprintID, Flag, "CancelSprint"))
        'strHTML.Append("</div>")
        strHTML.Append("<br>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")




        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSprintRelease(ByVal Flag As String, ByVal SprintID As String, ByVal ProjectID As String, ByVal Sprintname As String, ByVal ReleaseID As String, ByVal txtDescriptionSprint As String, ByVal SprintStartdate As String, ByVal SprintEnddate As String, ByVal txtCalendar As String, ByVal txtEfforts As String, ByVal txtBusiness As String, ByVal strStatus As String)
        '=====================================================================
        ' Purpose				:	SaveSprintRelease
        ' Author				:	Dipali V
        ' Created				:	10th March 2018
        '=====================================================================
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder()
            Dim Restult As Integer = 0
            If SprintID = "0" Then
                SprintID = "Null"
            End If

            If ReleaseID = "0" Then
                ReleaseID = "Null"
            End If

            'Commented and Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
            'Try
            '    If Flag = "Sprint" Then
            '        Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration " & SprintID & "," & HttpContext.Current.Session("intprojectid") & ",'" & Sprintname & "'," & ReleaseID & ",'" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "'," & txtBusiness & ""
            '        ' CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
            '        Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))

            '    Else
            '        Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease  " & SprintID & "," & HttpContext.Current.Session("intprojectid") & ",'" & Sprintname & "','" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "','" & strStatus & "'"
            '        Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
            '    End If
            'Catch ex As Exception
            'End Try



            Try
                If Flag = "Sprint" Then

                    Dim fltEfforts As Decimal

                    If txtEfforts = "0" Or txtEfforts = "" Then
                        txtEfforts = "00:00"
                    End If

                    If txtEfforts.IndexOf(":") = txtEfforts.Length - 1 Then
                        txtEfforts = txtEfforts + "00"
                    End If

                    Dim strDecimal As String = ""
                    Dim strBeforeDecimal As String = ""
                    strBeforeDecimal = txtEfforts.Substring(0, txtEfforts.IndexOf(":"))
                    If strBeforeDecimal.Length = 1 Then
                        strBeforeDecimal = "0" + strBeforeDecimal
                    End If
                    strDecimal = txtEfforts.Substring(txtEfforts.IndexOf(":") + 1, 2)
                    txtEfforts = strBeforeDecimal + ":" + strDecimal

                    fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + txtEfforts + "',2)", True)


                    Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumIteration " & SprintID & "," & HttpContext.Current.Session("intprojectid") & ",'" & Sprintname & "'," & ReleaseID & ",'" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & fltEfforts & ",'" & HttpContext.Current.Session("strUserName") & "'," & txtBusiness & ""
                    ' CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                    Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))

                Else
                    Dim strQuery As String = "usp_NG2_Ins_Upd_tbl_PM_ScrumRelease  " & SprintID & "," & HttpContext.Current.Session("intprojectid") & ",'" & Sprintname & "','" & txtDescriptionSprint.Replace("'", "''") & "','" & SprintStartdate & "','" & SprintEnddate & "'," & txtCalendar & "," & txtEfforts & ",'" & HttpContext.Current.Session("strUserName") & "','" & strStatus & "'"
                    Restult = CStr(CommonFunction.Data.GetDataScalar(strQuery, True))
                End If
            Catch ex As Exception
            End Try

            'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'Added By Dipali V On 4th April 2018 For Get Subtype by type onchnage
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

            Dim objfrmReleasePlanning As New frmReleasePlanning()
            Dim strReturnHTML As New StringBuilder("")

            strReturnHTML.Append(objfrmReleasePlanning.SaveTaskDetails(AssignTaskData))

            'Return New frmProductBacklog().WriteGrid("TaskList", UserStoryId)
            Return objfrmReleasePlanning.Tasks_section(UserStoryId, "aftersave")
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
                        m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
                    Next
                Else
                    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
                End If
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
    <System.Web.Services.WebMethod()>
    Public Shared Function Modal_popupdashboard(ByVal UniqueID As String, ByVal Flag As String)
        '=====================================================================
        ' Purpose				:	Modal_popupdashboard
        ' Author				:	Dipali V
        ' Created				:	9th March 2018
        '=====================================================================
        Try

            Dim strReleaseName As String
            Dim strGridHTML As New StringBuilder()
            Dim strSQL As String = ""
            Dim drReleaseDetails As IDataReader
            strSQL = "usp_NG2_GetSprintReleaseDetails " & UniqueID & "," & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID") & ",'" & Flag & "'"
            drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            Dim IterationID As String = ""
            Dim IterationName As String = ""
            Dim Description As String = ""
            Dim SprintStartDate As String = ""
            Dim SprintEndDate As String = ""
            Dim ReleaseID As String = ""
            Dim SprintVelocity As String = ""
            Dim SprintDuration As String = ""
            Dim BusinessDuration As String = ""
            Dim IterationStartDate As String = ""
            Dim IterationStatus As String = ""
            Dim IsIterationComplete As String = ""
            Dim plannedEfforts As String = ""
            Dim actualEfforts = ""
            Dim DoListCount As String = ""
            Dim InProgressCount As String = ""
            Dim DoneCount As String = ""
            Dim TaskCount As String = ""
            Dim DiscussionCount As String = ""
            Dim IssueCount As String = ""
            Dim NoOfDays As String = ""
            Dim StoryPoint As String = ""
            If Flag = "Sprint" Then
                If drReleaseDetails.Read Then
                    IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationID"), "")
                    IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationName"), "")
                    Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                    SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                    SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                    ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                    'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                    BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "")
                    IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                    IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                    IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsIterationComplete"), "")

                    DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                    InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgressCount"), "")
                    DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoneCount"), "")
                    TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                    IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                    DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                    NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
                    StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
                    plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                    actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                End If
            Else
                If drReleaseDetails.Read Then
                    '  IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
                    Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                    SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                    SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                    ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                    SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                    'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                    SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                    'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change

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

            End If
            ''Added by Usha Pandit on 19.04.2019 for getting sprint status
            Dim strSprintStatus As String = "" ' CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & SprintID & ",'Iteration'", True))
            If UniqueID = "" Then
                strSprintStatus = "0"
            Else
                strSprintStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_SprintStatus " & UniqueID & ",'Iteration'", True))
            End If
            ''End of Added by Usha Pandit on 19.04.2019 for getting sprint status
            Dim strResult As String = ""
            ''Commented and Added by Usha Pandit on 19.04.2019 for passing sprint status
            'strResult = IterationName & "##" & Description & "##" & SprintStartDate & "##" & SprintEndDate & "##" & SprintDuration & "##" & SprintVelocity & "##" & BusinessDuration
            strResult = IterationName & "##" & Description & "##" & SprintStartDate & "##" & SprintEndDate & "##" & SprintDuration & "##" & SprintVelocity & "##" & BusinessDuration & "##" & strSprintStatus
            ''End of Added by Usha Pandit on 19.04.2019 for passing sprint status
            Dim objfrmReleasePlanning As New frmReleasePlanning()
            If Flag = "div2" Then
                Flag = "Sprint"
            End If
            strGridHTML.Append(objfrmReleasePlanning.Drawdashboard(UniqueID, Flag))
            Return strGridHTML.ToString & "||" & strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    Public Function Drawdashboard(ByVal UniqueID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Purpose				:	Drawdashboard
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()

        strHTML.Append("<div id='SprintDetails'>")
        strHTML.Append(sprint_header(UniqueID, Flag))
        'strHTML.Append(sprint_status(UniqueID, Flag))

        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateProjectDates(ByVal ProjectID As String, ByVal StartDate As String, ByVal EndDate As String) As String
        '=====================================================================
        ' Purpose				:	ValidateProjectDates
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================
        Dim strSQL As String
        Dim strResult As String

        Try
            strSQL = "Usp_NG2_Validate_ProjectDates_IterationRelease " & ProjectID & ",'" & StartDate & "','" & EndDate & "'"

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "")

            Return strResult
        Catch ex As Exception
            Return ""
        End Try

    End Function
    Public Function sprint_header(ByVal UniqueID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Purpose				:	sprint_header
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim drReleaseDetails As IDataReader
        strSQL = "usp_NG2_GetSprintReleaseDetails " & UniqueID & "," & Session("intProjectID") & "," & Session("intUserID") & ",'" & Flag & "'"
        drReleaseDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
        Dim IterationID As String = ""
        Dim IterationName As String = ""
        Dim Description As String = ""
        Dim SprintStartDate As String = ""
        Dim SprintEndDate As String = ""
        Dim ReleaseID As String = ""
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
        Dim plannedEfforts As String = ""
        Dim actualEfforts = ""

        Dim Duration As String = ""
        Dim Velocity As String = ""
        If Flag = "Sprint" Then
            If drReleaseDetails.Read Then
                IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationName"), "")
                Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "")
                IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStatus"), "")
                IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsIterationComplete"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                Velocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")
                plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoListCount"), "")
                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgressCount"), "")
                DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DoneCount"), "")
                TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
            End If
        Else
            If drReleaseDetails.Read Then
                IterationID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                IterationName = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseName"), "")
                Description = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Description"), "")
                SprintStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StartDate"), "")
                SprintEndDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("EndDate"), "")
                ReleaseID = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ReleaseID"), "")
                SprintDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                'Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                SprintVelocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("HMVelocity"), "")
                'End of Added by Usha Pandit on 04-March-2019 Purpose::Whizible 2 Work field change
                BusinessDuration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("BusinessDuration"), "")
                ' IterationStartDate = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IterationStartDate"), "")
                IterationStatus = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Status"), "")
                IsIterationComplete = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IsReleaseComplete"), "")
                Duration = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Duration"), "")
                Velocity = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Velocity"), "")
                StoryPoint = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("StoryPoint"), "")

                plannedEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("PlannedEffort"), "")
                actualEfforts = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("ActualEffort"), "")
                DoListCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("UserStories"), "")
                InProgressCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("InProgress"), "")
                DoneCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("Done"), "")
                TaskCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("TaskCount"), "")
                IssueCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("IssueCount"), "")
                DiscussionCount = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("DiscussionCount"), "")
                NoOfDays = CommonFunctions.Data.CheckIsDBNull(drReleaseDetails("NoOfDays"), "")
            End If

        End If
        'Dim CountOfRows As Integer = 0 'dt1.Rows.Count

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
        If Flag = "Sprint" Then
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



        strHTML.Append("<div class='row' style='border-bottom:1px solid #ddd'>" & vbCrLf)
        strHTML.Append("<div class='col-md-1 col-sm-2'>" & vbCrLf)
        'strHTML.Append("<div style='height:50px;width:50px;background-color:" & strPriorityColor & ";' class='img-circle' ></div>" & vbCrLf)
        strHTML.Append("<div style='height:50px;width:50px;position: relative;'><i class='fa fa-certificate' aria-hidden='true' style='font-size: 50px;color:" & strColor & ";'></i>")
        strHTML.Append("<p  style='color: white;font-weight: 600;font-size: 15px;position: absolute;width: 35px;transform: translate(20%, 0px);top: 9px;left: 2px;text-align: center;'><Span data-toggle='tooltip' data-placement='bottom'  title='" & title & "'>" & IterationID & "</span></p></div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-2 col-sm-3' style='margin-top:1%'>" & vbCrLf)
        strHTML.Append("<label class='headerPage'>" & PageCaption & " </label>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='' style='float:right;;margin-right:2%;width:auto;margin-left:auto;'>") 'style='float:right;margin-left:61%;margin-top:-2%'
        If Flag = "Sprint" Then
            'strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append("<i class='fa fa-bug  fa-border icon-grey' id='bugIcon'><span class='sprintbadge' title='Issue Count'>" & IssueCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            'strHTML.Append("<i class='fa fa-align-justify  fa-border icon-grey' id='justifyIcon'><span class='sprintbadge' title='Review Count'>" & ReviewCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            'strHTML.Append("<i class='far fa-comments fa-border icon-grey' id='commentIcon'><span class='sprintbadge' title='Discussion Count'>" & DiscussionCount & "</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
            'strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='    font-size: 16px;'></i>")
            'strHTML.Append("</div>")

            strHTML.Append("<div class='input-group' style='float:right;' id='Export'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown'><button type='button' class='btn btn-info dropdown-toggle'  id='btnExport'  class='dropdown-toggle' data-bs-toggle='dropdown' title='' data-original-title='Export' title='Export'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i></button>&nbsp;&nbsp;")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown-menu'>")
            strHTML.Append("  <li class='dropdown-item' href='#' onclick=Export_onclick('" & Flag & "','PDF'," & IterationID & ") >&nbsp;PDF</li>")
            strHTML.Append("  <li class='dropdown-item' href='#' onclick=Export_onclick('" & Flag & "','Excel'," & IterationID & ")>&nbsp;Excel</li>")
            strHTML.Append("</div></div>")
            'If IterationStatus = "Not Yet Started" Then
            '    strHTML.Append("<button type='button' data-toggle='tooltip' data-placement='bottom' class='btn btn-info' onclick='StartSprint(" & IterationID & ")' title='Sprint Status'><i id='idStartIteration' class='fa fa-caret-square-o-right' aria-hidden='true' style='color:white;' ></i>&nbsp;Start Sprint</button>" & vbCrLf)
            'ElseIf IterationStatus.ToUpper() = "READY TO COMPLETE" Then
            '    strHTML.Append("<div id='idStartItern' style='cursor:pointer;' onclick='StartSprint(" & IterationID & ")'><i id='idStartIteration' class='clsStatus fa fa-caret-square-o-right' data-toggle=modal style='color:rgb(60, 141, 188);' title='Click here to complete sprint'></i> Ready To <br/> &nbsp;&nbsp;&nbsp;&nbsp; Complete</div>")
            'Else
            '    strHTML.Append("<button type='button' data-toggle='tooltip' data-placement='bottom' class='btn btn-info' title='" & IterationStatus & "'>&nbsp;" & IterationStatus & "</button>" & vbCrLf)
            'End If
            'strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='bottom' onclick='RefreshAllPage()'>&times;</button>")

            ' Commented and Added by Sagar N on 03-May-2019 Purpose:: Tooltip alignment issue
            'strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='bottom' onclick='RefreshAllPage()'>&times;</button>")
            '//Commented and added by Chetan M on 1st August 2020 for Issue ID = 25477
            'strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='top' onclick='RefreshAllPage()'>&times;</button>")
            strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='top' onclick='RefreshAllPage(&quot;" & Flag & "&quot;)'>&times;</button>")
            '//End of Commented and added by Chetan M on 1st August 2020 for Issue ID = 25477
            ' End of Commented and Added by Sagar N on 03-May-2019 Purpose:: Tooltip alignment issue
            strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")

        Else


            'strHTML.Append("<div class='col-sm-6' style='float:right;margin-left:61%;margin-top:-2%'>")
            strHTML.Append("<div class='input-group' style='float:right;'  id='Export'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown'><button type='button' class='btn btn-info dropdown-toggle'  id='btnExport'  data-bs-toggle='dropdown'  aria-haspopup='true' title='Export' data-original-title='Export' title='Export'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i></button>&nbsp;&nbsp;")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<div class='dropdown-menu'>")
            strHTML.Append("<li class='dropdown-item' href='#' onclick=Export_onclick('" & Flag & "','PDF'," & IterationID & ") >&nbsp;PDF</li>")
            strHTML.Append("<li class='dropdown-item' href='#' onclick=Export_onclick('" & Flag & "','Excel'," & IterationID & ")>&nbsp;Excel</li>")

            strHTML.Append("</div></div>")
            strHTML.Append("<input type='hidden' value='" & IterationID & "' id='hdnReleaseID' />")
            'Added By Ankush T on 07/06/2018 for status
            If Flag = "Sprint" Then
            Else
                If IterationStatus <> "" Then
                    strHTML.Append("<button type='button' class='btnrelease btn'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release'>" & IterationStatus & "</button>") 'style added by Ankush T on 05/06/2018
                Else
                    strHTML.Append("<button type='button' class='btnrelease btn'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release'>Ready For Release</button>") 'style added by Ankush T on 05/06/2018

                End If
            End If




            'strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='bottom' onclick='RefreshAllPage()'>&times;</button>")


            ' Commented and Added by Sagar N on 03-May-2019 Purpose:: Tooltip alignment issue
            'strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='bottom' onclick='RefreshAllPage()'>&times;</button>")
            strHTML.Append("<button type='button' class='close modal_close' data-dismiss='modal' aria-label='Close' title='close' data-toggle='tooltip' data-placement='top' onclick='RefreshAllPage()'>&times;</button>")
            ' End of Commented and Added by Sagar N on 03-May-2019 Purpose:: Tooltip alignment issue
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")



        strHTML.Append("</div>")


        strHTML.Append("<div class='row' style='margin-top:1%'>" & vbCrLf)
        strHTML.Append("<div class='col-md-2 col-sm-4 col-sm-4'>") 'id='divReleaseName'
        strHTML.Append("<label class='headerPage'>" & ControlCaption & ": </label>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-3 col-sm-12' style='margin-bottom:10px;'>")
        'strHTML.Append("<label class='labelclassIterationID' title='Iteration ID'>" & IterationID & "</label>&nbsp;&nbsp;")

        ''Commented and Added by Usha Pandit on 19.04.2019 for wrong title for sprint name
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", , , , IterationName, , , True, , , , "onblur=""ChangeReleaseName(" & IterationID & ")"" data-toggle='tooltip' data-placement='top' title='' data-original-title='Release Name'", True, , , , , , True))
        'Commented and Added by Sagar N on 09-May-2019 Purpose:: Issue ID - 18753
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", , , , IterationName, , , True, , , , "onblur=""ChangeReleaseName(" & IterationID & ")"" data-toggle='tooltip' data-placement='top' title='' data-original-title='Sprint Name'", True, , , , , , True))

        If Flag = "Sprint" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSprintName", "txtSprintName", , , , IterationName, , , True, , , , "onblur=""ChangeSprintName(" & IterationID & ")"" data-toggle='tooltip' data-placement='top' title='' data-original-title='Sprint Name'", True, , , , , , True))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReleaseName", "txtReleaseName", , , , IterationName, , , True, , , , "onblur=""ChangeReleaseName(" & IterationID & ")"" data-toggle='tooltip' data-placement='top' title='' data-original-title='Release Name'", True, , , , , , True))
        End If
        'End of Commented and Added by Sagar N on 09-May-2019 Purpose:: Issue ID - 18753

        ''End of Added by Usha Pandit on 19.04.2019 for wrong title for sprint name

        strHTML.Append("<i class='fas fa-pencil-alt' id='editReleaseName' onclick=""editReleaseName('" & IterationName & "')"" title='" & editName & "' ></i>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='col-md-6 col-sm-12' style=''>")
        strHTML.Append("<p  style='color:  #428bca; font-size: 12px;white-space: nowrap;margin-bottom:0%;text-overflow: ellipsis;' ><label class='labelclass' title='Start Date To End Date' data-toggle='tooltip'>" & SprintStartDate & "   To    " & SprintEndDate & "</label>&nbsp;&nbsp;")
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

        'If plannedEfforts = 0 And actualEfforts <> "" Then
        '    strHTML.Append("<label class='labelclass' title='Planned Effort / Actual Effort' data-toggle='tooltip'>" & plannedEfforts & "/" & actualEfforts & "</label>")
        'Else
        '    strHTML.Append("<label class='labelclass' title='PlannedEffort / ActualEffort' data-toggle='tooltip'>0.00/0.00</label>&nbsp;&nbsp;&nbsp;&nbsp;")
        'End If


        strHTML.Append("</p>")

        'If Flag = "Sprint" Then
        'Else
        '    If IterationStatus <> "" Then
        '        strHTML.Append("<button type='button' class='btnrelease btn'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release' style='float: right; margin-top:-27px;'>" & IterationStatus & "</button>") 'style added by Ankush T on 05/06/2018
        '    Else
        '        strHTML.Append("<button type='button' class='btnrelease btn'  id='btnRelease'  data-toggle='tooltip' data-placement='bottom' title='Release Status' data-original-title='Release' style='float: right; margin-top:-27px;'>Ready For Release</button>") 'style added by Ankush T on 05/06/2018

        '    End If
        'End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")



        'strHTML.Append(" <div>" & vbCrLf)
        'strHTML.Append("  <p  style='color:  #428bca;    font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;' title='Start Date To End Date'>" & SprintStartDate & "  To  " & SprintEndDate & "</p>")
        'strHTML.Append("</div>&nbsp;&nbsp;&nbsp;&nbsp;")
        'strHTML.Append(" <div class='col-sm-2'>" & vbCrLf)
        'strHTML.Append(" <p  style='color: #428bca;     margin-left: -11px;      background-color: #868e9624 ;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success sprint_backLabel'>" & DoListCount & "</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success sprint_backLabel' style='   background-color: #dc3545;'>" & InProgressCount & "</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success sprint_backLabel'>" & DoneCount & "</span> </p>")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
        'strHTML.Append(" <p  style='color: #88888880;       margin-left: 13px;    font-size: 15px;white-space: nowrap;text-overflow: ellipsis;' title='No Of Days'>" & NoOfDays & "</p>")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
        'strHTML.Append(" <p  style='color: #88888880;          font-size: 15px;white-space: nowrap;text-overflow: ellipsis;' title='Story Point'>" & StoryPoint & "</p>")
        'strHTML.Append("</div>")


        'If Flag = "Sprint" Then
        '    strHTML.Append("<div class='col-sm-2'>" & vbCrLf)

        '    strHTML.Append(" <p  style='     margin-left: 18px;  font-size: 15px;white-space: nowrap;text-overflow: ellipsis;color: red;' title='No Of Days'>" & NoOfDays & "</p>")
        '    strHTML.Append("</div>")
        'End If

        'strHTML.Append("</div>")
        strHTML.Append("<hr id='dash_hr'>")





        strHTML.Append(sprint_tab(UniqueID, Flag))
        If Flag = "Sprint" Then

            strHTML.Append(Graph_section(UniqueID, Flag, IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, IterationStatus))
        Else
            strHTML.Append("<input type='hidden' value='" & UniqueID & "' id='hdnReleaseIDnew' />")
            strHTML.Append(Graph_section(UniqueID, Flag, IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, IterationStatus))

        End If
        Return (strHTML.ToString())

    End Function

    'Public Function sprint_status(ByVal UniqueID As String, ByVal Flag As String) As String
    '    '=====================================================================
    '    ' Purpose				:	sprint_status
    '    ' Author				:	Dipali V
    '    ' Created				:	10h March 2018
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div class='row' style='margin-left: 2px;'>" & vbCrLf)
    '    strHTML.Append(" <div>" & vbCrLf)
    '    strHTML.Append("  <p  style='color:  #428bca;    font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>22 Jan 2018 To 31 Jan 2018 T/A:0/0 </p>")
    '    strHTML.Append("</div>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append(" <div class='col-sm-2'>" & vbCrLf)
    '    strHTML.Append(" <p  style='color: #428bca;     margin-left: -11px;      background-color: #868e9624 ;   font-size: 11.5px;white-space: nowrap;text-overflow: ellipsis;'>To Do<span class='label label-success backLabel'>0</span>&nbsp; &nbsp;&nbsp;InProgress<span class='label label-success backLabel' style='   background-color: #dc3545;'>0</span>&nbsp; &nbsp;&nbsp;Done<span class='label label-success backLabel'>0</span> </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p  style='color: #88888880;       margin-left: 13px;    font-size: 15px;white-space: nowrap;text-overflow: ellipsis;'>1 Week</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p  style='color: #88888880;          font-size: 15px;white-space: nowrap;text-overflow: ellipsis;'>50 Points </p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-1'>" & vbCrLf)
    '    strHTML.Append(" <p  style='     margin-left: -9px;  font-size: 15px;white-space: nowrap;text-overflow: ellipsis;color: red;'>8 Day(s) Left</p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append("<i class='fa fa-bug  fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='fa fa-align-justify  fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='far fa-comments fa-border icon-grey'><span class='badge'>0</span></i>&nbsp;&nbsp;&nbsp;&nbsp;")
    '    strHTML.Append("<i class='fas fa-chart-bar' aria-hidden='true' style='    font-size: 16px;'></i>")
    '    strHTML.Append("<button type='button' class='btn btn-secondary' style='margin-top: -6px;font-size: 11.5px;font-weight: 500; height: 31px;  background-color: rgb(34, 177, 76);margin-left: 24px;border-radius: 4px;'><i class='fa fa-caret-square-o-right' aria-hidden='true' style='color:white;'></i>&nbsp;Start Sprint</button>" & vbCrLf)

    '    strHTML.Append("</div>")

    '    strHTML.Append("</div>")
    '    strHTML.Append("<hr id='dash_hr'>")
    '    Return (strHTML.ToString())
    'End Function

    Public Function sprint_tab(ByVal UniqueID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Purpose				:	sprint_tab
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div class='row ' id='Tabs'>")
        strHTML.Append("<div class='col-sm-12'>")
        'strHTML.Append("&nbsp;<i class='fa fa-angle-double-left' aria-hidden='true' style='color:#5bc0de;font-size:20px!important;' id='ReleaseSprintPer' title='Previous Tab' onclick=""PreSprintRelease('" & Flag & "')""></i>" & vbCrLf)

        If Flag <> "Sprint" Then
            strHTML.Append("<ul class='' id='tab_link' >" & vbCrLf)
        Else
            strHTML.Append("<ul class='' id='tab_link' >" & vbCrLf)
        End If
        strHTML.Append("<li   style='   border-left: transparent;'><a href='#div_details' id='tab_content' style='   border-left: transparent;'  >Details</a></li>" & vbCrLf)
        strHTML.Append("<li ><a href='#graph' id='tab_content' data-toggle='tooltip' data-placement='bottom' >Charts</a></li>" & vbCrLf)
        If Flag <> "Sprint" Then
            strHTML.Append("<li ><a href='#Sprints'  id='tab_content' >Sprints</a></li>" & vbCrLf)
        End If
        strHTML.Append("<li><a href='#div1'  id='tab_content'   >User Stories</a></li>" & vbCrLf)

        'If Flag <> "Sprint" Then
        ' strHTML.Append("<li ><a href='#Issues' id='tab_content'>Issues</a></li>&nbsp;&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Teams','" & Flag & "'," & UniqueID & ",'Teams')""  href='#Teams'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Teams</a></li>" & vbCrLf)
        strHTML.Append("<li><a href='#Tasks'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Tasks</a></li>" & vbCrLf)
        'End If
        strHTML.Append("<li><a href='#div6'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Issues</a></li>" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Discussion','" & Flag & "'," & UniqueID & ",'div2')""  href='#div2'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Discussions</a></li>" & vbCrLf)
        strHTML.Append("<li><a onclick=""RefreshTab('Reviews','" & Flag & "'," & UniqueID & ",'div9')"" href='#div9'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Reviews</a></li>" & vbCrLf)
        'If Flag <> "Sprint" Then
        If Flag <> "Sprint" Then
            strHTML.Append("<li ><a href='#ImpedimentsLogs'  id='tab_content' data-toggle='tooltip' data-placement='bottom' >Impediments Logs</a></li>" & vbCrLf)
        End If

        If Flag <> "Sprint" Then
            strHTML.Append("<li><a href='#Risks'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Risks</a></li>" & vbCrLf)
        End If
        strHTML.Append("<li><a  onclick=""RefreshTab('History','" & Flag & "'," & UniqueID & ",'History')"" href='#History'    id='tab_content' data-toggle='tooltip' data-placement='bottom' >History</a></li>" & vbCrLf)
        ' End If
        strHTML.Append("<li ><a href='#div3'   id='tab_content' data-toggle='tooltip' data-placement='bottom' >Attachments</a></li>" & vbCrLf)


        strHTML.Append("</ul>")
        'strHTML.Append("<i class='fa fa-angle-double-right' aria-hidden='true' style='color:#5bc0de;font-size:20px!important' id='ReleaseSprintNext' title='Next Tab' title='Next Tab' onclick=""NextSprintRelease('" & Flag & "')""></i>" & vbCrLf)
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div id='ContainAllDivs'>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div id='sprint_details' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='20'>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle


        Return (strHTML.ToString())

    End Function

    Public Function Graph_section(ByVal SprintID As String, ByVal Flag As String, ByVal IterationName As String, ByVal Description As String, ByVal SprintStartDate As String, ByVal SprintEndDate As String, ByVal SprintDuration As String, ByVal SprintVelocity As String, ByVal BusinessDuration As String, ByVal Iterationstatus As String) As String
        '=====================================================================
        ' Purpose				:	Graph_section
        ' Author				:	Dipali V
        ' Created				:	10h March 2018
        '=====================================================================

        Dim strHTML As New StringBuilder()

        strHTML.Append("<div id='div_details' style='height:600px;' class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        If Flag = "Sprint" Then
            'strHTML.Append("<p style='    margin-left: 15px;    font-size: 16px;'>Sprint Details</p>")
            strHTML.Append("<h2 class='clsDiscussion' >Sprint Details</h2>")

            '' Commented and Added by Usha Pandit on 19.04.2019 for getting correct sprint Id
            'strHTML.Append("<input type='hidden' value='" & UniqueID & "' id='hdnSprintIDnew' />")
            strHTML.Append("<input type='hidden' value='" & SprintID & "' id='hdnSprintIDnew' />")
            '' End of Added by Usha Pandit on 19.04.2019 for getting correct sprint Id

        Else
            ' strHTML.Append("<p style='margin-left: 15px;font-size: 16px;'>Release Details</p>")
            strHTML.Append("<h2 class='clsDiscussion' >Release Details</h2>")

        End If


        If Flag = "Sprint" Then
            strHTML.Append(sprint_form(SprintID, IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, Iterationstatus))
        Else
            strHTML.Append(Release_form(SprintID, IterationName, Description, SprintStartDate, SprintEndDate, SprintDuration, SprintVelocity, BusinessDuration, Iterationstatus))

        End If
        strHTML.Append("</div>")

        strHTML.Append("<div id='graph' style='height:600px!important;margin-top:40px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>") ' Graph
        strHTML.Append(Graph_SprintRelease(SprintID, Flag))
        strHTML.Append("</div>") 'End Graph

        If Flag <> "Sprint" Then
            strHTML.Append("<div id='Sprints' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
            ' strHTML.Append("<p>User Stories</p>")
            strHTML.Append(Sprints_sectionSprintRelease(SprintID, Flag))
            strHTML.Append("</div>")
        End If

        strHTML.Append("<div id='div1' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        ' strHTML.Append("<p>User Stories</p>")
        strHTML.Append(USerStories_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='Teams' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(Teams_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")

        strHTML.Append("<div id='Tasks' style='height:500px;'  class='clsBo col-lg-12 col-md-12 col-sm-12x'>")
        strHTML.Append(Tasks_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='div6' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(Issues_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")

        strHTML.Append("<div id='div2' style='height:550px!important;width:100%;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(Discussion_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")






        'strHTML.Append("<div id='div1' style='height:500px;'  class='clsBox'>")
        '' strHTML.Append("<p>User Stories</p>")
        'strHTML.Append(USerStories_sectionSprintRelease(SprintID, Flag))
        'strHTML.Append("</div>")


        strHTML.Append("<div id='div9' style='height:500px;margin-bottom:50px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(Reviews_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")


        If Flag <> "Sprint" Then
            strHTML.Append("<div id='ImpedimentsLogs' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
            strHTML.Append(ImpedimentsLogs_sectionSprintRelease(SprintID, Flag))
            strHTML.Append("</div>")
        End If

        If Flag <> "Sprint" Then
            strHTML.Append("<div id='Risks' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
            strHTML.Append(Risks_sectionSprintRelease(SprintID, Flag))
            strHTML.Append("</div>")
        End If






        strHTML.Append("<div id='History' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(History_sectionSprintRelease(SprintID, Flag))
        strHTML.Append("</div>")


        strHTML.Append("<div id='div3' style='height:500px;'  class='clsBox col-lg-12 col-md-12 col-sm-12'>")
        strHTML.Append(Attachment_sectionSprintRelease(SprintID, Flag, ""))
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        Return (strHTML.ToString())

    End Function

    Public Function Tasks_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divTasks' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h5 class='' id='' > Task Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchTask' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divTaskList'>")
        strHTML.Append(WriteGrid("TaskList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function USerStories_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divUserstories' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h5 class='' id=''  >User stories Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchCurrntSprintUS' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divSprintList' style='margin-top:15px;'>")
        strHTML.Append(WriteGrid("CurrentSprintUS", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
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
        strHTML.Append("<h2 class='clsDiscussion'>Project Teams</h2>")
        strHTML.Append("<Div class='col-sm-11 col-sm-11' id='divTeamsList' style='margin-top: 15px;'>")
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


                strHTML.Append("<div class='' style='display:flex'>")
                strHTML.Append("<div class='col-md-2 col-sm-2 col-sm-12 discussionbox'>")
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Posted By - " & EmployeeName & "'>")
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
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -18px; margin-right: 17px;border-radius:10px' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
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
                strHTML.Append("<span class='chat-img float-start' data-toggle='tooltip' data-placement='top' title='Posted By - " & EmployeeName & "'>")
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
                strHTML.Append("<span class='" & badgecolor & "' style='float: right;margin-top: -18px; margin-right: 17px;border-radius:10px' data-toggle='tooltip' data-placement='top' title='Task Completion Percentage'>" & TaskCompletionPercentage & "%</span><br>")
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


    Public Function ImpedimentsLogs_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divImpedimentsLogs' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='' style=''>Impediments Logs Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchImpediments' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divImpedimentsList'>")
        strHTML.Append(WriteGrid("ImpedimentsLogsList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function Risks_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divRisks' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='' style=''>Risks Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchRisks' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divRisksList'>")
        strHTML.Append(WriteGrid("RisksList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function History_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divHistory' class='clsBox'>")

        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='' style=''>History Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchhistory' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divhistoryList'>")
        strHTML.Append(WriteGrid("HistorykList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function Sprints_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String
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
        strHTML.Append("<h2 class='clsDiscussion'>Sprints Details</h2>")

        If strIsPrductOwner = 1 Then
            strHTML.Append("<h2 class='HeaderLine' style=''><a onclick=ShowSprintData('List') title='Mapped Sprint Details' data-toggle='tooltip' data-placement='bottom' >List</a> | <a onclick=ShowSprintData('Form') title='Mapped Sprint' data-toggle='tooltip' data-placement='bottom' >Add</a></h2>")
        Else
            strHTML.Append("<h2 class='HeaderLine' style=''><a onclick=ShowSprintData('List') title='Mapped Sprint Details' data-toggle='tooltip' data-placement='bottom' >List</a></h2>")
        End If
        'strHTML.Append("<h2 class='HeaderLine' style=''><a onclick=ShowSprintData('List') title='Mapped Sprint Details' data-toggle='tooltip' data-placement='bottom' >List</a> | <a onclick=ShowSprintData('Form') title='Mapped Sprint' data-toggle='tooltip' data-placement='bottom' >Add</a></h2>")
        strHTML.Append("<Div class='col-sm-12' id='divSprintList'>")
        strHTML.Append(PlotSprintList(SprintID))
        strHTML.Append("</Div>")
        strHTML.Append("<Div class='col-sm-12' id='divRemarks' style='display:none'>")
        strHTML.Append("<table class='clsRemark' id='tblRemark" & SprintID & "' >")
        strHTML.Append("<tr>")
        strHTML.Append("<td style='text-align: left;border: 0px!important'>")
        strHTML.Append(" Remarks : ")
        strHTML.Append("</td>")
        strHTML.Append("<td style='text-align: left;border: 0px!important'>")
        strHTML.Append("<textarea id='txtRemark" & SprintID & "' maxlength=2000  data-autoresize onkeyup=CheckTextLength(this,'smallRemark_" & SprintID & "','spanRemark" & SprintID & "')   class='clsTextArea' ></textarea>")
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

        strHTML.Append("<Div class='col-sm-12' id='divSprintForm' style='display:none'>")
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
    Public Shared Function GetFlowGraph(ByVal UniqueID As String, ByVal Flag As String, ByVal SelectedID As String)
        Try

            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""

            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")

            Dim strSql As String = "usp_NG2_UserStoryFlowGraph " & UniqueID & ",'" & Flag & "'"
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
    Public Function Graph_SprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        'strHTML.Append("<div id='graph' class='clsBox'>")
        strHTML.Append("<h2 class='clsDiscussion'>Chart</h2>")

        strHTML.Append("<div style='display:flex;'>")
        strHTML.Append("<nav class='col-sm-3' id='myScrollspy'>")
        strHTML.Append("<ul class='nav nav-pills nav-stacked'>")



        strHTML.Append("<li class='active'><a href='#BurnDown'  data-toggle='tooltip' title='Burn Down'>Burn Down</a></li>") 'onclick=""Tab_onclick(event, 'BurnDown'," & SprintID & ")""
        strHTML.Append("<li><a href='#BurnUp'  data-toggle='tooltip' title='Burn Up'>Burn Up</a></li>") 'onclick=""Tab_onclick(event, 'BurnUp'," & SprintID & ")""
        If Flag = "Release" Then
            strHTML.Append("<li><a href='#Velocity' data-toggle='tooltip' title='Velocity'>Velocity</a></li>") 'onclick=""Tab_onclick(event, 'Velocity'," & SprintID & ")""
            strHTML.Append("<li><a href='#Flow' data-toggle='tooltip' title='Flow'>Flow</a></li>") 'onclick=""Tab_onclick(event, 'Flow'," & SprintID & ")""
            strHTML.Append("<li><a href='#ComSprint' data-toggle='tooltip' title='Completed Sprint'>Com-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CompSprint'," & SprintID & ")""
            strHTML.Append("<li><a href='#CanSprint' data-toggle='tooltip' title='Canceled Sprint'>Can-Sprint</a></li>") 'onclick=""Tab_onclick(event, 'CanSprint'," & SprintID & ")""
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </nav>")
        'added by ashwini on 21-3-2023 for data-bs-toggle
        strHTML.Append("<div class='col-sm-9  col-sm-9 scrollspy-example' data-spy='scroll' data-bs-target='#myScrollspy' data-offset='5'>")
        'End Of added by ashwini On 21-3-2023 for data-bs-toggle
        strHTML.Append("<div id='BurnDown' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Down</h3>")
        strHTML.Append(PlotBurnDown(SprintID, Flag, "BurnDown"))
        strHTML.Append("</div>")

        strHTML.Append("<div id='BurnUp' class='tabcontentChart'>")
        strHTML.Append("<h3 class='ClsHeaderGraph'>Burn Up</h3>")
        strHTML.Append(PlotBurnDown(SprintID, Flag, "BurnUp"))
        strHTML.Append("</div>")


        If Flag = "Release" Then

            strHTML.Append("<div id='Velocity' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Velocity</h3>")
            strHTML.Append(PlotBurnDown(SprintID, Flag, "Velocity"))
            strHTML.Append("</div>")


            strHTML.Append("<div id='Flow' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Flow</h3>")
            strHTML.Append(PlotBurnDown(SprintID, Flag, "Flow"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='ComSprint' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Completed Sprint</h3>")
            strHTML.Append(PlotBurnDown(SprintID, Flag, "ComSprint"))
            strHTML.Append("</div>")

            strHTML.Append("<div id='CanSprint' class='tabcontentChart'>")
            strHTML.Append("<h3 class='ClsHeaderGraph'>Canceled Sprint</h3>")
            strHTML.Append(PlotBurnDown(SprintID, Flag, "CancelSprint"))
            strHTML.Append("</div>")
            strHTML.Append("<br>")

        End If

        strHTML.Append("</div>")
        strHTML.Append("</div>")




        ' strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    Public Function PlotBurnDown(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder()
        If GraphFlag = "BurnDown" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append(GetBurnDownGraph(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>") 'float:right;margin-top:-40%;margin-right:-4%'
            strHTML.Append(GetBurnupGraph(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Velocity" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append(GetVelocityEffortBarGraph(SprintID, Flag, GraphFlag))
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetVelocitySToryPointsBarGraph(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "BurnUp" Then
            strHTML.Append("<div class='divLineGraph' style=height:547px'>")
            strHTML.Append(GetBurnupGraphEfforts(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            'strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            strHTML.Append(GetBurnupGraphStoryPoints(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")
        ElseIf GraphFlag = "Flow" Then
            strHTML.Append("<div class='divLineGraph' style='height:126%!important'>")
            strHTML.Append(GetFlowGraphEfforts(SprintID, Flag, GraphFlag))
            ' strHTML.Append("</div>")
            ' strHTML.Append("<div class='divLineGraph' style='width: 100%;height:430px'>")
            'strHTML.Append(GetFlowGraphStoryPoints(SprintID, Flag, GraphFlag))
            strHTML.Append("</div>")

        ElseIf GraphFlag = "ComSprint" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            ' strHTML.Append(GetComSprint(SprintID, Flag, GraphFlag))
            strHTML.Append("<div id='ComSprintGrid" & SprintID & "' class=''>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")

        ElseIf GraphFlag = "CancelSprint" Then
            strHTML.Append("<div class='divLineGraph' style='height:547px'>")
            strHTML.Append("<div class='' id='CanSprintGrid" & SprintID & "'>") 'chart-container

            strHTML.Append("</div>")
            strHTML.Append("</div>")
        End If

        Return strHTML.ToString()

    End Function
    ''' <summary>
    ''' For BurnDown/DurnUP Graph
    ''' </summary>
    ''' <param name="SprintID"></param>
    ''' <param name="Flag"></param>
    ''' <param name="GraphFlag"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function GetBurnDownGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)

        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnDown" & SprintID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function
    Public Function GetBurnupGraph(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)

        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='BurnUp" & SprintID & "'></canvas>")
        strHTML.Append("</div>")
        Return strHTML.ToString()


    End Function

    '''End of BurnDown/DurnUP Graph


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
    'End of Velocity Graph

    'For Com Sprint & cancel
    'Public Function GetComSprint(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)
    '    Dim strHTML As New StringBuilder
    '    strHTML.Append("<div id='ComSprint" & SprintID & "' class=''>") 'chart-container
    '    'strHTML.Append("<canvas ></canvas>") 'style='height:370;width:119%;margin-left:-11%'
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString()
    'End Function
    'Public Function GetCancelSprint(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)
    '    Dim strHTML As New StringBuilder
    '    strHTML.Append("<div class='' id='CancelSprint" & SprintID & "'>") 'chart-container
    '    'strHTML.Append("<canvas ></canvas>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString()
    'End Function

    'End of For Com Sprint & cancel
    ''' BurnDown/DurnUP Graph
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
    '''End of BurnDown/DurnUP Graph

    'Flow graph
    Public Function GetFlowGraphEfforts(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)


        Dim strHTML As New StringBuilder
        strHTML.Append("<div class=''>") 'chart-container
        strHTML.Append("<canvas id='FlowGraphEfforts" & SprintID & "'></canvas>") 'style='height:370;width:119%;margin-left:-11%'
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    'Public Function GetFlowGraphStoryPoints(ByVal SprintID As String, ByVal Flag As String, ByVal GraphFlag As String)
    '    Dim strHTML As New StringBuilder
    '    strHTML.Append("<div class=''>") 'chart-container
    '    strHTML.Append("<canvas id='FlowGraphStoryPoints" & SprintID & "'></canvas>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString()
    'End Function
    'End of Flow graph

    Public Function Issues_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divIssues' class='clsBox'>")
        ' strHTML.Append("<h2 class='clsDiscussion'>Issues</h2>")
        '  strHTML.Append("<div id='divIssues' class='clsBox'>")
        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h5 class='' id='' style=''>Issues Details</h5>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchIssues' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divIssuesList'>")
        strHTML.Append(WriteGrid("IssuesList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function
    'Public Function Reviews_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div id='divReview' class='clsBox'>")
    '    strHTML.Append("<h2 class='clsDiscussion'>Reviews</h2>")

    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function


    Public Function Reviews_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divReview' class='clsBox'>")

        strHTML.Append("<div class='clsDiscussion'>")
        strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<h2 class='' >Reviews Details</h2>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='searchbox'>")
        strHTML.Append("<input type='text' name='table_search' id='txtSearchReviews' class='txtBox form-control float-end' placeholder='Search' /><i class='fa fa-search SprintSeach'aria-hidden='true'></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<Div class='col-sm-12' id='divReviewList'>")
        strHTML.Append(WriteGrid("ReviewList", SprintID, Flag))
        strHTML.Append("</Div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function Discussion_sectionSprintRelease(ByVal SprintID As String, ByVal Flag As String) As String


        ''Added by Usha Pandit on 13.04.2019 for disabling Update button if Sprint is already started or completed
        If Flag = "Sprint" Then
            Flag = "Iteration"
        End If
        ''End of Added by Usha Pandit on 13.04.2019 for disabling Update button if Sprint is already started or completed

        Dim strHTML As New StringBuilder()
        strHTML.Append("<div id='divDiscussions'>")
        strHTML.Append("<h2 class='clsDiscussion'>Discussions</h2>")
        'strHTML.Append("<div class='col-sm-10' style='margin-left:-1%;margin-top:2%'>")
        'strHTML.Append("<textarea id='txtDiscussion' name='txtDiscussion' class='form-control'></textarea>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this)><i class='fa  fa-comment-o' aria-hidden='true'></i>  Post</button>")

        ''strHTML.Append("<button id='SprintRelease' type='button' onclick=insertSprintReleaseDiscussion('" & SprintID & "','" & Flag & "',this) class='btn btn-default btn-flat'>Post</button>")
        'strHTML.Append("</div>")
        strHTML.Append("<div id='divDiscussionListSprintRelease' class='row'   style='margin-top:15px;'>") 'divDiscussionListSprintRelease
        ' strHTML.Append(PlotDiscussion(SprintID, Flag))
        strHTML.Append(PlotDiscussionThreadBody(SprintID, "", Flag))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString

    End Function

    Public Function PlotDiscussion(ByVal SprintID As String, ByVal Flag As String)

        Dim strHTML As New StringBuilder()
        Dim drDiscussions As New DataTable
        Dim strDiscussions As String = ""
        Dim SystemFileName As String = ""
        Dim SubmittedDate As String = ""
        Dim DiscussionThread As String = ""
        Dim SubmittedBy As String = ""
        Dim Counter As Integer = 0
        If Flag = "Sprint" Then
            Flag = "Iteration"
        End If
        Dim DiscussionID As String = ""
        Dim strSubmittedTime As String = ""

        Dim EmployeeName As String = ""
        Dim FlagCount As String = ""
        Dim strUserNameOfSubmittedDis As String = ""
        strDiscussions = "usp_NG2_sel_tbl_PM_ScrumDiscussions " & SprintID & ",'" & Flag & "',null," & Session("intUserID") & ",null"
        drDiscussions = CommonFunctions.Data.GetDataTable(strDiscussions, True)

        For i As Integer = 0 To drDiscussions.Rows.Count - 1
            FlagCount = "1"

            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("SystemFileName").ToString, "")
            DiscussionID = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("DiscussionID").ToString, "")
            SubmittedDate = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("DiscussionDate").ToString(), "")
            DiscussionThread = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("Comments").ToString, "")
            strUserNameOfSubmittedDis = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("UserName").ToString, "")
            EmployeeName = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("EmployeeName").ToString, "0")
            strSubmittedTime = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("Duration").ToString, "")
            SubmittedBy = CommonFunctions.Data.CheckIsDBNull(drDiscussions.Rows(i)("UserName").ToString, "")
            Dim strEmployeeImage As String = ""
            Dim strCustomerImage As String = ""
            Dim strEmployeeFilePath As String = ""
            Dim strCustomerFilePath As String = ""
            Dim k As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
            strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, k - 1)
            strEmployeeImage = strEmployeeImage.Replace("\", "/")




            If Not SystemFileName Is Nothing Then
                strEmployeeFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), SystemFileName)
                '' strEmployeeFilePath = strEmployeeImage + "/Images/Photo/" + SystemFileName
            End If


            If CommonFunctions.General.CheckIsNothing(SystemFileName) = "" Then
                strEmployeeImage = "../../Images/Photo/no-photo.png"
            Else
                strEmployeeImage = "../../Images/Photo/" + SystemFileName
                'strEmployeeImage(+"/Images/Photo/" + SystemFileName)
            End If

            If SubmittedBy = HttpContext.Current.Session("strUserName") Then
                'If (IsShowToCustomer <> 1) Then
                Dim styleClass As String = ""
                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<div class='discus-part odd-discus-part'>")
                strHTML.Append("<div class='discus-chat odd-discus-chat'> ")

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-2' >")
                strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strEmployeeImage & "'></div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-md-9'>")
                strHTML.Append("<div class='odd-chat'>")
                strHTML.Append("<div class='col-md-12'>")
                strHTML.Append("<div class='text text-l'><p>")
                Dim DiscussionThreadless As String = ""
                Dim DiscussionThreadMore As String = ""
                If DiscussionThread.Length < 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length = 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                    ''Commented And Added By Vaijat K ON 12/12/2017
                    ''ElseIf DiscussionThread.Length > 200 Then
                ElseIf DiscussionThread.Length > 100 Then
                    ''End of Commented And Added By Vaijat K ON 12/12/2017
                    DiscussionThreadless = DiscussionThread.Substring(0, 100)
                    ''Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 101)
                    DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 100)
                    ''ENd Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadless += "..."
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "<span class='read-more-target'>" & DiscussionThreadMore & "</span></pre>")
                    strHTML.Append("<label for='post-" & Counter & "' class='read-more-trigger' style='width: 16%;background-color: #bfc5ce;'></label>")
                End If
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append("<div class='col-md-1'>")
                strHTML.Append("<ul class='left'>")
                strHTML.Append("<li><span>" & SubmittedDate & "</span></li>") '"  " & SubmittedDate & "&nbsp;&nbsp;
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("</div>") 'eND ROW


                strHTML.Append("<div class='row'>")
                strHTML.Append("<ul class='left'>")
                'strHTML.Append("<li><span>" & strUserNameOfSubmittedDis & "</span></li>")
                strHTML.Append("<li><span>" & strSubmittedTime & "</span></li>") '"  " & SubmittedDate & "&nbsp;&nbsp;
                strHTML.Append("</ul>")
                strHTML.Append("</div>")


                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append("<div class='col-md-6'>")
                If Counter = 1 Then
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control' data-autoresize", True))
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion'", True, EnableHTMLEncode:=True))
                    'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , 2000, , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion'", True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion' maxlength ='2000'", True, EnableHTMLEncode:=True))
                    'End of commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
                    'Commented & Added By Dipsli V On 25th Jun 2020 For Issue id  25259
                    'strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this,'txtDiscussions')><i class='fa  fa-comment-o' aria-hidden='true'></i>  Post</button>")
                    strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post' data-toggle='tooltip'  data-placement='top' data-container='body'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this,'txtDiscussions')><i class='far fa-comment' aria-hidden='true'></i>  Post</button>")
                    'End of Commented & Added By Dipsli V On 25th Jun 2020 For Issue id  25259
                End If
                strHTML.Append("</div>")
                strHTML.Append("</div>")

            ElseIf (SubmittedBy <> HttpContext.Current.Session("strUserName")) Then 'For Employee
                Dim styleClass As String = ""

                strHTML.Append("<div class='col-md-6'>")
                strHTML.Append("<div class='discus-part odd-discus-part'>")
                strHTML.Append("<div class='discus-chat odd-discus-chat'> ")

                strHTML.Append("<div class='row'>")
                strHTML.Append("<div class='col-md-2' >")
                strHTML.Append("<div class='avatar'><img class='img-circle'   src='" & strEmployeeImage & "'></div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-md-9'>")
                strHTML.Append("<div class='odd-chat'>")
                strHTML.Append("<div class='col-md-12'>")
                strHTML.Append("<div class='text text-l'><p>")
                Dim DiscussionThreadless As String = ""
                Dim DiscussionThreadMore As String = ""
                If DiscussionThread.Length < 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                ElseIf DiscussionThread.Length = 100 Then
                    DiscussionThreadless = DiscussionThread
                    DiscussionThreadMore = ""
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "</pre>")
                    ''Commented And Added By Vaijat K ON 12/12/2017
                    ''ElseIf DiscussionThread.Length > 200 Then
                ElseIf DiscussionThread.Length > 100 Then
                    ''End of Commented And Added By Vaijat K ON 12/12/2017
                    DiscussionThreadless = DiscussionThread.Substring(0, 100)
                    ''Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 101)
                    DiscussionThreadMore = DiscussionThread.Substring(100, DiscussionThread.Length - 100)
                    ''ENd Commented And Added By Vajiat K ON 12/12/2017 For Production issue
                    ''DiscussionThreadless += "..."
                    ''Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing 
                    strHTML.Append("<pre class='read-more-wrap readWrap'>" & DiscussionThreadless & "<span class='read-more-target'>" & DiscussionThreadMore & "</span></pre>")
                    strHTML.Append("<label for='post-" & Counter & "' class='read-more-trigger' style='width: 16%;background-color: #bfc5ce;'></label>")
                End If
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append("<div class='col-md-1'>")
                strHTML.Append("<ul class='left'>")
                strHTML.Append("<li><span>" & SubmittedDate & "</span></li>") '"  " & SubmittedDate & "&nbsp;&nbsp;
                strHTML.Append("</ul>")
                strHTML.Append("</div>")
                strHTML.Append("</div>") 'eND ROW


                strHTML.Append("<div class='row'>")
                strHTML.Append("<ul class='left'>")
                'strHTML.Append("<li><span>" & strUserNameOfSubmittedDis & "</span></li>")
                strHTML.Append("<li><span>" & strSubmittedTime & "</span></li>") '"  " & SubmittedDate & "&nbsp;&nbsp;
                strHTML.Append("</ul>")
                strHTML.Append("</div>")


                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append("<div class='col-md-6'>")
                ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")



            Else


            End If



            Counter += 1
        Next


        'strHTML.Append("<div class='col-md-6'   style='margin-top:5%;'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control'", True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        If FlagCount <> "1" Then

            strHTML.Append("<div class='row'>")
            strHTML.Append("<div class='col-md-6'>")
            ' /* Modified By Madhuri.K On 03-04-2026 */ 
            strHTML.Append("<label class='lblnodatadiscussion' style='font-size: 11.5px;'>There are no items to show in this view.</label>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-md-6' style='margin-top:6%'>")
            'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion'", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)' placeholder='Post New Discussion' maxlength ='2000'", True, EnableHTMLEncode:=True))
            ' End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "class='form-control'  data-autoresize", True))
            strHTML.Append("<button type='button' class='btn btn-primary btn-lg' id='SprintRelease'  style='' title='Post'  onclick=insertSprintReleaseDiscussion(" & SprintID & ",'" & Flag & "',this,'txtDiscussions')><i class='far fa-comment' aria-hidden='true'></i>  Post</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

        End If

        Return strHTML.ToString

    End Function
    ''Commented and Added by Usha Pandit on 08.05.2019 for wrong discussion count display
    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String)
    '    Dim strSQL As String
    '    Dim strREsult As String
    '    If Flag = "Sprint" Then
    '        Flag = "Iteration"
    '    End If
    '    strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID

    '    strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '    If strREsult Then
    '        If HttpContext.Current.Session("intUserID") <> "0" Then
    '            CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
    '        Else
    '            CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)

    '        End If
    '    End If

    '    Return New frmReleasePlanning().PlotDiscussionThreadBody(strUserStoryID, "", Flag)
    '    ' Return New frmReleasePlanning().PlotDiscussion(strUserStoryID, Flag)
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDiscussion(ByVal strUserStoryID As String, ByVal DiscussionComment As String, ByVal DiscussionID As String, ByVal Flag As String, ByVal curReleaseId As String)

        Try
            Dim strSQL As String
            Dim strREsult As String
            If Flag = "Sprint" Then
                Flag = "Iteration"
            End If
            If Flag = "Iteration" Then
                strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID & "," & curReleaseId
            Else
                strSQL = "usp_NG2_INS_tbl_NG2_ScrumDiscussion " & HttpContext.Current.Session("intProjectID") & "," & strUserStoryID & ",'" & Flag & "','" & DiscussionComment.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "'," & DiscussionID
            End If


            strREsult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If strREsult Then
                If HttpContext.Current.Session("intUserID") <> "0" Then
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)
                Else
                    CommonFunctions.Data.InsertOrUpdateData("usp_NG2_INS_tbl_NG2_ScrumDiscussionHolders " & strREsult & ", '" & Flag & "'", True)

                End If
            End If

            Return New frmReleasePlanning().PlotDiscussionThreadBody(strUserStoryID, "", Flag)
            ' Return New frmReleasePlanning().PlotDiscussion(strUserStoryID, Flag)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''End of Added by Usha Pandit on 08.05.2019 for wrong discussion count display
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
        'If strFlag = "sprint" Then
        '    strFlag = "Iteration"
        'End If


        'If strFlag = "Sprint" Then
        '    strFlag = "Iteration"
        'Else
        '    strFlag = strFlag
        'End If
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
            strHTMLDiscussion.Append("<span class='col-md-2 col-sm-2 col-sm-4 float-start discussionbox' data-toggle='tooltip' data-placement='bottom' title='Posted By - " & strEmployeeName & "'>")
            strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
            strHTMLDiscussion.Append("</span>")
            strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8 col-sm-8 discussionbox'>")
            strHTMLDiscussion.Append("<p ><span class='clsempname' title='Employee Name' data-toggle='tooltip' data-placement='bottom'> " & strEmployeeName & "</span></P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='chat-body clearfix' style='border-bottom:1px solid #ddd;background: #b2d5f5;padding: 10px;margin-bottom:10px;border-radius:5px;'>")
            strHTMLDiscussion.Append("<div class='header'>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<div class='row'>")

            strHTMLDiscussion.Append("<div class='col-sm-4' style='white-space:pre!important'>")
            strHTMLDiscussion.Append("<p class='Postedtime' title='Posted Time' data-toggle='tooltip' data-placement='bottom' style='white-space:pre!important;font-size: 10px;'> " & strSubmittedTime & "</P>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("</div>")
            strHTMLDiscussion.Append("<p  style='padding-left:18%;Margin-top:-3%;word-break:break-all;' ><span data-toggle='tooltip' data-placement='bottom' title='Description'style='word-break: break-all;'>")
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
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTMLDiscussion.Append(strDiscussionDate & " &nbsp;&nbsp; <label data-bs-toggle='collapse' data-bs-target='#collapse_" & strDiscussionID & "' style='cursor:pointer' ><span title='View all reply' class='clsReply' data-bs-toggle='tooltip' data-placement='bottom'><i class='fa fa-eye' aria-hidden='true' style='color: #EF5350;'></i><span></label> <a class='clsReply' onclick=""reply_onclick(" & strIterationID & "," & strDiscussionID & ",'" & strFlag & "')"" data-bs-toggle='tooltip' data-bs-placement='bottom' title='Reply'><i class='fa fa-reply' aria-hidden='true' style='font-size:17px!important;'></i></a>&nbsp;&nbsp;&nbsp;<label class='label label-warning' style='font-size:9px' title='Reply count' data-bs-toggle='tooltip' data-bs-placement='bottom'>" & dtTable.Rows.Count & "</label>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTMLDiscussion.Append("</small>")


            Dim strDiscussionID1 As String = ""
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
                    strHTMLDiscussion.Append("<span class='col-md-4 col-sm-4 col-sm-4 float-end' style='float:right!important;' data-toggle='tooltip' data-placement='bottom' title='Posted By - " & strEmployeeName & "'>")
                    strHTMLDiscussion.Append("<img alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px!important;width:30px!important;' src='../../Images/Photo/" & strPhotoFileName & "' />")
                    strHTMLDiscussion.Append("<p class='Postedtime'><span style='white-space:pre!important;font-size: 10px;'  data-toggle='tooltip' data-placement='bottom' title='Posted Time' > " & strSubmittedTime & "</span></P>")
                    strHTMLDiscussion.Append("</span>")

                    strHTMLDiscussion.Append("<div class='col-md-8 col-sm-8' style='white-space:pre!important;float:right'>")
                    strHTMLDiscussion.Append("<p style='float:right'><span class='clsempname' title='Employee Name' data-toggle='tooltip' data-placement='bottom'> " & strEmployeeName & "</span></P>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("</div>")
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
                    strHTMLDiscussion.Append("<p style='color:#777!important;word-break:break-all;' ><span title='Description' data-toggle='tooltip' data-placement='bottom'style='word-break: break-all;'>")
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
                    strHTMLDiscussion.Append("<div class='col-md-12 col-sm-12'>")
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
            strHTMLDiscussion.Append("<ul class='col-sm-5 col-xs-12' style='margin-top:8%;text-align:center;'>")
            ' strHTMLDiscussion.Append("<li class='col-sm-6'>")
            'Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            'strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , , , , , , , , , , , "onkeyup='AutoGrowTextArea(this)'placeholder='Post New Discussion'", True))
            strHTMLDiscussion.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDiscussions", "txtDiscussions", , "form-control", , , , , ,, , , , , , , , , "onkeyup='AutoGrowTextArea(this)'placeholder='Post New Discussion' maxlength ='2000'", True))
            'End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintReleaseAddDiscussion'  style='margin-right:10px;' onclick=AddNewDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions') disabled><sup><i class='fa  fa-plus' aria-hidden='true' style='font-size:9px!important'></i></sup><span title='Add New' data-toggle='tooltip' data-placement='top'  >Add New<span></button>")
            strHTMLDiscussion.Append("<button type='button' class='btn btn-info' id='SprintRelease'  style=''   onclick=insertSprintReleaseDiscussion(" & strIterationID & ",'" & strFlag & "',this,'txtDiscussions')><sup><i class='far fa-comment' aria-hidden='true' style='font-size:9px!important'></i></sup><span id='spanpost' title='Post' data-toggle='tooltip' data-placement='top' > Post<span></button>")

            'strHTMLDiscussion.Append("</li>")
            strHTMLDiscussion.Append("</ul>")
        End If





        'strHTMLDiscussion.Append("  <div id='footerBoxFooter' class='box-footer'>")
        'strHTMLDiscussion.Append("    <div id='footerInputGroup' class='input-group'>")
        'If strFlag = "UserStory" Then

        '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
        '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
        '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','asd',1) class='btn btn-warning btn-flat'>Post</button>")
        '    strHTMLDiscussion.Append("       </span>")
        'Else
        '    strHTMLDiscussion.Append("     <input placeholder='Type message...'  onkeyup=sendKey(event,'" & strIterationID & "','" & strFlag & "',1) id='footerInputGroupText_" & strIterationID & "' type='text' name='message'  class='InputGroupText form-control'>")
        '    strHTMLDiscussion.Append("        <span class='input-group-btn'>")
        '    strHTMLDiscussion.Append("         <button id='btnSend' type='button' onclick=insertUserStorytDiscussion('" & strIterationID & "','" & strFlag & "','sad',1) class='btn btn-warning btn-flat'>Post</button>")
        '    strHTMLDiscussion.Append("       </span>")
        'End If
        'strHTMLDiscussion.Append(" </div>")
        'strHTMLDiscussion.Append(" </div>")


        'strHTMLDiscussion.Append(" <div  id='chatMessage_" & strIterationID & "' class='direct-chat-messages' style='border: 1px solid #ddd;'>")



        'Dim strHTML As New StringBuilder
        'While drGetUserStoryDicussion.Read
        '    flag = 1
        '    strPhotoFileName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("SystemFileName").ToString, "")
        '    strDiscussionDate = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("DiscussionDates").ToString, "")
        '    strComment = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("Comments").ToString, "")
        '    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("EmployeeName").ToString, "")
        '    strUserName = CommonFunctions.Data.CheckIsDBNull(drGetUserStoryDicussion("UserName").ToString, "")


        '    If strPhotoFileName = "" Then
        '        strPhotoFileName = "no-photo.png"
        '    End If
        '    If strUserName = "" & HttpContext.Current.Session("strUserName") & "" Then
        '        strHTML.Append("    <div class='direct-chat-msg right'>")
        '        strHTML.Append("<div class='direct-chat-info clearfix'>")
        '        strHTML.Append("<span class='direct-chat-name float-end' style=' float:right!important;'>" & strEmployeeName & "</span>")
        '        strHTML.Append("<span class='direct-chat-timestamp float-start'>" & strDiscussionDate & "</span>")
        '        strHTML.Append("   </div>")

        '        strHTML.Append("   <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
        '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")

        '        strHTML.Append("   </div>")

        '        strHTML.Append("    </div>")
        '    Else
        '        strHTML.Append("   <div class='direct-chat-msg'>")
        '        strHTML.Append("    <div class='direct-chat-info clearfix'>")
        '        strHTML.Append("      <span class='direct-chat-name float-start'>" & strEmployeeName & "</span>")
        '        strHTML.Append("     <span class='direct-chat-timestamp float-end' style=' float:right!important;'>" & strDiscussionDate & "</span>")
        '        strHTML.Append("   </div>")

        '        strHTML.Append("  <img class='direct-chat-img' src='../../Images/Photo/" & strPhotoFileName & "' alt = 'Message User Image'>")
        '        strHTML.Append(" <div class='direct-chat-text'> " & strComment & "")
        '        strHTML.Append(" </div>")

        '        strHTML.Append("    </div>")

        '    End If
        'End While

        'If flag = 0 Then
        '    strHTMLDiscussion.Append("<label style='font-size:14px;text-align:center'>No Discussion Available</label>")
        '    strHTMLDiscussion.Append("   </div>")
        'Else
        '    strHTMLDiscussion.Append(strHTML.ToString)
        '    strHTMLDiscussion.Append("   </div>")

        'End If

        Return strHTMLDiscussion.ToString()

    End Function

    Public Function UploadData(ByVal flag As String)
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
                'Dim strSql As String = ""
                'If Flag = "Iteration" Then
                '    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL," & strUserStoryID & ", NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                'ElseIf Flag = "UserStory" Then
                '    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                'Else
                '    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL,NULL," & strUserStoryID & "," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName & "','" & file.FileName & "','" & file.ContentLength & "'"
                'End If
                Dim strSql As String = ""
                If flag = "Iteration" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL," & strUserStoryID & ", NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName + Path.GetExtension(file.FileName) & "','" & file.FileName & "','" & file.ContentLength & "'"
                ElseIf flag = "UserStory" Then
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments " & strUserStoryID & ",NULL,NULL," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName + Path.GetExtension(file.FileName) & "','" & file.FileName & "','" & file.ContentLength & "'"
                Else
                    strSql = "usp_NG2_INS_tbl_NG2_ScrumAttachments NULL,NULL," & strUserStoryID & "," & Session("intProjectID") & ",NULL,'" & Session("strUserName") & "','" & strFileName + Path.GetExtension(file.FileName) & "','" & file.FileName & "','" & file.ContentLength & "'"
                End If
                CommonFunctions.Data.InsertOrUpdateData(strSql, True)
                If Flag = "UserStory" Then
                    Context.Response.Write(GetAttachmentList1(strUserStoryID, ""))
                Else
                    Context.Response.Write(GetAttachmentListSprintRelease(strUserStoryID, flag, ""))
                End If
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
        strHTML.Append("<div id='divAttachments'>")
        strHTML.Append("<H2 class='clsDiscussion'>Attachments</H2>")
        strHTML.Append("<div id='divAttachmentList' class='col-sm-12'>")
        strHTML.Append(GetAttachmentListSprintRelease(userStoryID, Flag, Refreshflag))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            Return strHTML.ToString

    End Function


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
            Dim objfrmReleasePlanning As New frmReleasePlanning()
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
            Dim strAttachmentSql As String = "usp_NG2_sel_tbl_NG2_ScrumAttachments " & Session("intProjectID") & "," & userStoryID & ",'" & Flag & "'"
            Dim dtAttachment As New DataTable
            dtAttachment = CommonFunctions.Data.GetDataTable(strAttachmentSql, True)
            If Refreshflag <> "AfterDelete" Then
                strHTML.Append(" <div id='Attachmentus'>")
            End If
            SelectedReleaseid = userStoryID
            SelectedFlag = Flag

            If IterationStatus.ToUpper <> "RELEASED" Then
                strHTML.Append("<h2 style='text-align:right;border-bottom: 1px solid #ddd;padding:4px;'><div class='demo-droppable'><p>Drag files here or click to upload</p></div><a class='btn btn-info' data-toggle='tooltip' title='Upload File' data-placement='bottom' onclick=UploadData(" & userStoryID & ",'" & Flag & "')><i class='fa fa-upload' aria-hidden='true'></i>Upload</a></h2>")
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
            strHTML.Append(WriteGrid("AttachmentList", userStoryID, Flag))
            ' strHTML.Append(WriteGrid())
            strHTML.Append("</div>")
            If Refreshflag <> "AfterDelete" Then
                strHTML.Append(" </div>")
            End If

            Return strHTML.ToString()

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteAttachment(ByVal strAttachmentID As String, ByVal strUserStoryID As String, ByVal strEntity As String)
        'Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

        'Dim strSql As String = "usp_NG2_del_tbl_NG2_ScrumAttachments " & strAttachmentID & "," & strUserStoryID & ",'" & strEntity & "'," & HttpContext.Current.Session("intUserID")
        'Dim strResult As String = CommonFunctions.Data.GetDataScalar(strSql, True)
        'Dim strHTML As New StringBuilder()
        'If strEntity <> "UserStory" Then
        '    strHTML.Append(New frmReleasePlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity, "AfterDelete"))
        '    Return strResult.ToString & "||" & strHTML.ToString
        '    ' Return strResult & "||" & New frmReleasePlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity)

        'Else
        '    ' Dim objfrmReleasePlanning New frmReleasePlanning()
        '    strHTML.Append(New frmReleasePlanning().GetAttachmentList(strUserStoryID, "AfterDelete"))
        '    Return strResult.ToString & "||" & strHTML.ToString
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
        Dim strHTML As New StringBuilder()
        If strEntity <> "UserStory" Then
            strHTML.Append(New frmReleasePlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity, "AfterDelete"))
            Return strResult & "||" & intFlag & "||" & strHTML.ToString
            ' Return strResult & "||" & New frmReleasePlanning().GetAttachmentListSprintRelease(strUserStoryID, strEntity)

        Else
            ' Dim objfrmReleasePlanning New frmReleasePlanning()
            strHTML.Append(New frmReleasePlanning().GetAttachmentList(strUserStoryID, "AfterDelete"))
            Return strResult & "||" & intFlag & "||" & strHTML.ToString
            'End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red

        End If
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveSubStories(ByVal UserStoryID As String, ByVal SubStoryName As String, ByVal SubStoryDesc As String, ByVal strPriority As String, ByVal strRank As String) As String
        Dim strSQL As String
        Try
            strSQL = "usp_NG2_INS_tbl_PM_ScrumSubUserStory NULL," & UserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Return New frmReleasePlanning().PlotSubUserStoryList(UserStoryID)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeReleaseName(ByVal IterationID As String, ByVal ReleaseName As String) As String

        Try
            Dim strSQL As String
            Dim Flags As String
            Try
                Flags = 1
                strSQL = "usp_NG2_UPD_ReleaseNAme " & HttpContext.Current.Session("IntProjectID") & "," & IterationID & ",'" & ReleaseName & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Catch ex As Exception

            End Try

            Return Flags

        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    ''Added by Usha Pandit on 09.05.2019 for Sprint Name Save Issue on blur
    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeSprintName(ByVal IterationID As String, ByVal SprintName As String) As String

        Try
            Dim strSQL As String
            Dim Flags As String
            Try
                Flags = 1
                strSQL = "usp_NG2_UPD_SprintNAme " & HttpContext.Current.Session("IntProjectID") & "," & IterationID & ",'" & SprintName & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Catch ex As Exception

            End Try

            Return Flags
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''End of Added by Usha Pandit on 09.05.2019 for Sprint Name Save Issue on blur

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIterationMappedToUserStory(ByVal intIterationID As String)
        Try

            If intIterationID = "" Then
                intIterationID = "NULL"
            End If
            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_chk_IterationMappedToUserStory " & intIterationID, True), "0")
            Return strSql
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function StartIteration(ByVal IterationID As String, ByVal ProjectID As String)
        Try

            Dim strResultforStatus As String = ""
            Dim strSql As String = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_StartIteration " & ProjectID & "," & IterationID & ",'" & HttpContext.Current.Session("strUserName") & "'", True), "0")

            strResultforStatus = strSql
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

            If Entity = "Sprint" Then
                m_lngReportID = 20244
                strSQL = "usp_NG2_Get_SprintDashboard_Report " & EntityID & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
            Else
                m_lngReportID = 20171
                strSQL = "usp_NG2_sel_tbl_PM_ScrumReleasesList_Report " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & EntityID
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
            Args.StringToBeInserted = "<td align='center' ><p Title = 'Delete Attachment' data-toggle='tooltip' data-placement='bottom' ><i  class='fa fa-trash' style='color:red;' onclick=""Delete_Attachment(" & Args.DataReader("AttachmentID") & "," & SelectedReleaseid & ",'" & SelectedFlag & "')""></i></p></TD>"

        End If



    End Sub
End Class