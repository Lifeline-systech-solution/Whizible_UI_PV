Public Class OverallSchedule_GanttView
    Inherits WebPages.Template.WhizTemplate
#Region "Member Variables"
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected m_objAccessRights As New WebPage.Templates.AccessRights
    Protected sbHTML As StringBuilder
    Protected dsTask As DataSet
    Protected dsTemp As DataSet
    Protected drMonthHead As IDataReader
    Protected dsWeekHead As DataSet
    Protected dtTempStartDate As String = ""
    Protected dtTempEndDate As String = ""

    Protected m_strScript As StringBuilder
    Protected sbSAVE As StringBuilder
    Protected drDeffered As IDataReader

    Protected m_strSQL As String = ""
    Protected MonDiff As Integer = 3
    Protected GantView_StartDt As Date
    Protected GantView_EndDt As Date

    Private arrRVerticals As String = ""
    Private arrRightVerticals() As String
    Private strMonthEndIDs As String

    Private arrLVerticals As String = ""
    Private arrLeftVerticals() As String
    Private strIsFreezed As String = ""
    Private arrIsFreezed() As String
    Private strMonthStartIDs As String
    Protected m_strMasterPK As String
    Private strFillColor As String = "blue"
    Private strNotFillColor As String = "White"
    Private strRangeColor As String = ""

    Private strVertRightRBs As String = ""
    Private arrVertRightRB() As String
    Private strVertLeftLBs As String = ""
    Private arrVertLeftLB() As String

    Private RB_validateDT As Date
    Private m_strEmployeeID As String = ""
    Private m_strPageCaption As String = ""
    Protected m_strTagID As String = ""
    Private m_strPeriod As String = ""

    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""
    Private drProject As IDataReader
    Protected m_strMode As String = ""
    Private drParentTask As IDataReader

    'Project Settings Related variables

    Private m_blnProjectActive As Boolean = False
    'Private m_blnAllowResourceAllocation As Boolean = False
    Private m_blnIsTaskComplete As Boolean = False
    Protected m_HaveSubTaskTypes As Boolean
    Protected m_ApplyEffortDistribution As Boolean
    Protected m_bitResourceValidation As Int16 = 1
    Protected m_blnSendEmail As Boolean = False
    'Task Details
    Protected m_strTaskIDList As String = ""
    Protected m_lngTaskId As Long = 0
    Private m_strTaskName As String = ""
    Private m_strTaskNotes As String = ""
    Private m_blnIsDeferredTask As Boolean = False
    Private m_strUserName As String = ""
    Protected m_lngReviewActionId As Long = 0
    Protected m_lngReviewStatisticsId As Long = 0
    Protected m_lngMitigationPlanId As Long = 0
    Protected m_lngRiskId As Long = 0
    Protected m_lngTrainingResourceId As Long = 0
    Protected m_lngTrainingId As Long = 0
    Private m_arrControlDetails(7, 1) As Boolean
    Private m_lngProjectEstimationTypeId As Long = 0
    Private m_blnBillable As Boolean = False
    Protected m_strCurrentWork As String = ""
    Private m_dblCurrentDuration As Double = 0
    Protected m_strCurrentStartDate As String = ""
    Protected m_strCurrentEndDate As String = ""
    Private m_strPriority As String = ""
    Protected m_strTaskType As String = "Assigned"
    Private m_lngPhaseId As Long = 0
    Private m_strPhase As String = ""
    Private m_lngModuleId As Long = 0
    Private m_strModule As String = ""
    Private m_lngSubProjectId As Long = 0
    Private m_strSubProject As String = ""
    Private m_lngMilestoneId As Long = 0
    Private m_strMilestone As String = ""
    Private m_lngChangeRequestId As Long = 0
    Private m_lngProjectFeatureId As Long = 0
    Private m_lngDeliverableId As Long = 0
    Private m_strDeliverableId As String = ""
    Private m_strBaselineStartDate As String = ""
    Private m_strBaselineEndDate As String = ""
    Private m_strBaselineWork As String = ""
    Private m_dblBaselineDuration As Double = 0
    Protected m_strActualStartDate As String = ""
    Private m_strActualEndDate As String = ""
    Private m_strActualWork As String = ""
    Private m_dblActualDuration As Double = 0
    Protected m_strHolidays As String = ""
    Private m_lngFilterEmployeeId As Long = 0
    'Private m_blnVoid As Boolean = False
    Private m_blnOnHold As Boolean = False
    Protected m_strProjectSetting As String = ""
    Protected blnIsNewTask As Boolean

    ''Email Msg
    Private m_blnSendMail As Boolean = False
    Protected m_blnShowPopup As Boolean = False

    Protected m_dblTotalAllocatedTaskLCE As Double = 0
    Protected m_dblTotalLCE As Double = 0

    Protected IsCaseOneProject As Boolean
    ''Protected IsCase2Project As Boolean
    Protected IsCase3Project As Boolean
    Protected IsCase2Project As Boolean = False

    Protected m_strFilterID As String = ""
    Protected strPaging As StringBuilder

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0
    Protected m_strGanttView As String = "2"
    Protected m_strEMPName As String = ""
    Protected m_strEntityName As String = ""
    Protected m_strIsClosed As String = ""
    Protected m_strDeliverableTypeId As String = ""
    Protected m_strIsActiveResource As String = ""
    Protected m_strRoleID As String = ""
    Protected m_strToken As String = ""
    Protected IsEditable As Boolean

    Protected m_lngNoOfDays As Long = 0

    Protected m_lngProjectLocationID As Long = 0

    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0
    Private strIsTaskClosed As String = ""
    Private arrIsTaskClosed() As String
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"

    Protected arrTaskType() As String = {"", ""}
    'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
    Protected arrUserStory() As String = {"", ""}
    Protected m_intFlag As String = "0"
    'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
    Protected m_dblOUWorkingHrs As Double = 0.0
    'Added By VijayD On 26 August
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0, m_strBaselineMessage As String = ""
    'End Addition By VijayD On 26 August
    Protected m_dblProjectTaskTotal As Double = 0.0
    Protected m_blnIsWorkflow As Boolean = False

    Protected strFlag As String = ""

    Protected strSubProject, strModule, strPhase, strDeliverable, strMilestone, strOSName As String

#End Region
#Region "CONSTANTS"

    Protected Const PAGE_SIZE As Integer = 15
    Private Const TASKFILTER_ASSIGNED As String = "Assigned"
    Private Const TASKFILTER_DEFFERED As String = "Deffered"
#End Region

    Private Property m_PlottingPeriod_BookPeriod_Color As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"), "NULL") = "" Then
            strSubProject = "NULL"
        Else
            strSubProject = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"), "NULL")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"), "NULL") = "" Then
            strModule = "NULL"
        Else
            strModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"), "NULL")
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"), "NULL") = "" Then
            strPhase = "NULL"
        Else
            strPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"), "NULL")
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Deliverable"), "NULL") = "" Then
            strDeliverable = "NULL"
        Else
            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("Deliverable"), "NULL")
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"), "NULL") = "" Then
            strMilestone = "NULL"
        Else
            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"), "NULL")
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("OS"), "NULL") = "" Then
            strOSName = ""
        Else
            strOSName = CommonFunctions.General.CheckIsNothing(Request.QueryString("OS"), "NULL")
        End If
    End Sub
    Protected Sub PageInit()
        Initialize_Variables()

        ' ''DrawHiddenFields()

        ' ''If m_strMode.ToUpper <> "" Then
        ' ''    PerformAction()
        ' ''End If

        GetDatabasValues()

        ' ''If m_strTagID <> CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
        ' ''    DrawHeader()
        ' ''End If

        ' ''DrawMenu()

        ' ''If m_strTagID <> CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
        ' ''    DrawNextPeriod()
        ' ''End If


        ' ''If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
        ' ''    DrawTaskAttributes()
        ' ''    WritePage()
        ' ''Else
        ' ''    WriteWBSPage()
        ' ''End If
        Call DrawLegends()
        WritePage()

        DisposeNotUsedObjects()


    End Sub
    Protected Sub DrawLegends()
        sbHTML = New StringBuilder("")

        sbHTML.Append("<Div id=pageTitle>")
        sbHTML.Append("<table id=tblDisclaimer class=clsTable width=99.9% >")
        sbHTML.Append("<tr class=clsTRPageHeader><td align=left> <strong>Gantt Chart View</strong> </td> </tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</Div>")

        sbHTML.Append("<Div id=legendDiv>")
        sbHTML.Append("<br /><table class=clsTable style='width:100%'>")

        sbHTML.Append("<tr><td align=left> <strong>Note:</strong> </td> </tr>")

        sbHTML.Append("<tr>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:Orange'></div>") '#F05E3D
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Current : Current/Revised plan for the WBS combination. </div>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr>")
        sbHTML.Append("<td>")
        sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:blue'></div>") '#EBC620
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Baseline : Original plan  ,where performance/Variances is  calculated  against Current /Actuals. </div>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right'>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr>")
        sbHTML.Append("<td>")
        sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:green'></div>") '#47BC7C
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Actual : Actual Start by the resources (If all tasks of combination are completed). </div>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' >")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr>")
        sbHTML.Append("<td>")
        sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:lightgreen'></div>") '#47BC7C
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> If Actual End Date is not present then max of daily activity entry date will be consider. </div>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' >")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
       
        sbHTML.Append("</table>")
        sbHTML.Append("</Div>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing

    End Sub
    Protected Sub DrawTaskAttributes()
        '=====================================================================
        ' Function  Name		:	DrawTaskAttributes()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw task attribute.
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder


        sbHTML.Append("<table id='tblTaskAttributes' cellpadding=0 cellspacing=0 class='clsTable'  width=100% >")
        sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
        sbHTML.Append("<td align='left' valign='middle' class='clsTDBlankNEW' >")
        sbHTML.Append("<Img Border=0 id='imgAssig' alt='Assignment' src='../../Images/plus.gif' style='cursor:hand;' onclick='HideShowAssignment()' />&nbsp;Assignment")
        sbHTML.Append("</td>")
        sbHTML.Append("<TD style='align:right;text-align:right;' class='clsTDBlankNEW' colspan='3'>")
        sbHTML.Append("<b>Period : " + CommonFunction.Dates.CGetDate(GantView_StartDt) + " - " + CommonFunction.Dates.CGetDate(GantView_EndDt) + "</b>")
        sBHTML.Append("</td>")
        sbHTML.Append("</tr>")

        sbHTML.Append("<tr id='trAssig' class='clsTRBlank' valign='left' style='display:none;'>")

        sbHTML.Append("<td align='left' valign='middle' class='clsTDBlankNEW'>")
        DrawAttributePopUP(sbHTML, "hrAR", "divAR")
        sbHTML.Append("</td>")

        sbHTML.Append("<td align='middle' valign='middle' class='clsTDBlankNEW'>")
        DrawAttributePopUP(sbHTML, "hrATT", "divATT")
        sbHTML.Append("</td>")

        If IsCase3Project Then
            sbHTML.Append("<td align='right' valign='middle' class='clsTDBlankNEW'>")
            DrawAttributePopUP(sbHTML, "hrASTA", "divSTA")
            sbHTML.Append("</td>")
        End If

        sbHTML.Append("<td align='right' valign='middle' class='clsTDBlankNEW'>")
        DrawAttributePopUP(sbHTML, "hrAP", "divAP")
        sbHTML.Append("</td>")

        sbHTML.Append("</tr>")
        'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        If m_intFlag = "1" Then
            sbHTML.Append("<tr id='trUSAssig' class='clsTRBlank' valign='left' style='display:none;'>")
            sbHTML.Append("<td align='left' valign='middle' class='clsTDBlankNEW'>")
            DrawAttributePopUP(sbHTML, "hrUS", "divUS")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align='middle' valign='middle' class='clsTDBlankNEW'>")
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='right' valign='middle' class='clsTDBlankNEW'>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        End If
        'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        sbHTML.Append("</table>")
        sbHTML.Append("</br>")
        'hrView

        CommonFunction.Data.DisposeDataReader(drDeffered)

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing

        'Added by ShraddhaM
        Call DrawValidationHiddenFields()
        'Ended by ShraddhaM
    End Sub
    Protected Sub DrawAttributePopUP(ByVal sbHTML As StringBuilder, ByVal HREFID As String, ByVal DIVID As String)
        '=====================================================================
        ' Function  Name		:	DrawAttributePopUP()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw task attribute popup. 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================
        Dim sSQL As String = ""
        Dim sText As String = ""
        Dim sID As String = ""
        Dim divHeight As String = ""
        Dim strToolTip As String = ""
        Dim strValue As String = "&nbsp;&nbsp;&nbsp;"
        Dim lngTxtBoxWidth As Long = 120
        Dim ResourceStartDate As String
        Dim ResourceEndDate As String
        Dim strDefaultValue As String = ""

        Select Case HREFID.ToUpper
            Case "HRAR"
                sSQL = "EXEC usp_Sel_CurrentTeamMembers " & m_GlobalObject.ProjectID.ToString()
                sbHTML.Append("Assign Resource: ")
                strToolTip = "Assign Resource"
                divHeight = "height:250px;"
                lngTxtBoxWidth = 120

            Case "HRATT"
                sSQL = "EXEC usp_Sel_tbl_PM_Project_TaskTypes " & m_GlobalObject.ProjectID.ToString()
                sbHTML.Append("Assign Task Type: ")
                strToolTip = "Assign Task Type"
                divHeight = "height:250px;"
                lngTxtBoxWidth = 175
                strDefaultValue = arrTaskType(1)
            Case "HRAP"
                sSQL = "usp_Sel_tbl_IB_Priorities"
                divHeight = "height:100px;"
                strToolTip = "Assign Priority"
                sbHTML.Append("Assign Priority: ")
                lngTxtBoxWidth = 120
                'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
            Case "HRUS"
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                '' sSQL = "SELECT UserStoryID,UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ProjectID =" & m_GlobalObject.ProjectID.ToString() & " AND ReleaseID IS NOT NULL AND (IsUserStoryComplete = 0 or  IsUserStoryComplete is null)"
                sSQL = "usp_sel_tbl_PM_ScrumUserStory " & m_GlobalObject.ProjectID.ToString()
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                'sSQL = "EXEC Usp_Sel_Scrum_UserStories 'cboUserStory'," & m_GlobalObject.ProjectID.ToString()
                sbHTML.Append("Assign User Story: ")
                strToolTip = "Assign User Story"
                divHeight = "height:250px;"
                lngTxtBoxWidth = 120
                strDefaultValue = arrUserStory(1)
                'End of added by NitinC on 08 Dec 2011  for WhizibleSEM 11.0 (Issue Fix : 55883)
            Case "HRVIEW"
                Select Case m_strTagID
                    Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                        sSQL = "usp_Sel_tbl_UI_Views_ForGanttChart 3751," + m_GlobalObject.UserID.ToString
                        divHeight = "height:380px;"
                    Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString, CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString, CommonFunction.Constants.APP_TAG_MODULES.ToString
                        divHeight = "height:380px;"
                        sSQL = "usp_Sel_tbl_UI_Views_ForGanttChart " + m_strTagID + "," + m_GlobalObject.UserID.ToString
                End Select

                strToolTip = "Default View"
                'sbHTML.Append("Assigned Priority: ")
            Case "HRASTA"
                sSQL = "EXEC usp_Sel_tbl_PM_Project_SubTaskTypes " & m_GlobalObject.ProjectID.ToString()
                sbHTML.Append("Assign Activity: ")
                strToolTip = "Assign Activity"
                divHeight = "height:250px;"
        End Select

        If sSQL <> "" Then
            drDeffered = CommonFunction.Data.GetDataReader(sSQL, MyBase.UseSQL)
        End If

        If HREFID.ToUpper <> "HRVIEW" Then
            ''sbHTML.Append("<a title='" + strToolTip + "' style='FONT-FAMILY: Verdana, Arial, sans-serif;' id='" + HREFID + "' class='navtabFilter' onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'>" + strValue + "</a>")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '' sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox(HREFID, HREFID, , lngTxtBoxWidth, , strDefaultValue, , "cursor:hand;", , True, , , "onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'", True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox(HREFID, HREFID, , lngTxtBoxWidth, , strDefaultValue, , "cursor:hand;", , True, , , "onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'", True, EnableHTMLEncode:=True))
            ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        End If
        sbHTML.Append("</br>")

        ''
        sbHTML.Append("<div id='" + DIVID + "' class='cxtMenu' style=""width:200px;" + divHeight + "overflow:auto;display:none;"" >")

        sbHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
        While drDeffered.Read
            Select Case HREFID.ToUpper
                Case "HRAR"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserName")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("EmployeeID")), String)
                    ResourceStartDate = CType(drDeffered("ExpectedStartDate"), Date).ToString("dd-MMM-yyyy")
                    ResourceEndDate = CType(drDeffered("ExpectedEndDate"), Date).ToString("dd-MMM-yyyy")
                    'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
                Case "HRUS"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserStoryName")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserStoryID")), String)
                    'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
                Case "HRATT"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskType")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskTypeID")), String)
                Case "HRAP"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("Priority")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("Priority")), String)
                Case "HRVIEW"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("ViewName")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("FilterID")), String)
                Case "HRASTA"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("SubTaskType")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("SubTaskTypeID")), String)
            End Select

            sText = sText.Replace("'", "&#39;")

            sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
            sbHTML.Append("<td align='left'   class='clsTDBlank'>")
            sbHTML.Append("<a style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;' href='javascript:Attribute_OnClick(""" + sID + """,""" + sText + """,""" + HREFID + """,""" + ResourceStartDate + """,""" + ResourceEndDate + """)'>")
            If (HREFID.ToUpper = "HRVIEW" And sID = m_strFilterID) Or (HREFID.ToUpper = "HRAR" And sID = m_strEmployeeID) Then
                sbHTML.Append("<font color='blue'><b>")
                sbHTML.Append(sText)
                sbHTML.Append("</b></font>")
            Else
                sbHTML.Append(sText)
            End If
            sbHTML.Append("</a>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        End While

        CommonFunction.Data.DisposeDataReader(drDeffered)
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

    End Sub
      
    

    Protected Sub WritePage()
        '=====================================================================
        ' Function  Name		:	WritePage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================


        Dim objGanttChart_Month As cOSGanttChart_Duration
        Dim arrStartDates_MonthWise As ArrayList
        Dim arrEndDates_MonthWise As ArrayList
        Dim strQuery As String = ""

        Dim hidRecPKIDs As String = ""
        Dim strEntityame As String = ""


        Dim strRecPKID As String
        Dim Record_StartDt As Date
        Dim Record_EndDt As Date


        Dim vertIndex As Integer = 0

        Dim strClass As String = "clsTRBlank"

        Dim strType As String = ""

        Dim IsFreezed As Boolean
        Dim WorkHrs As Double = 0.0
        Dim strParentTaskID As String = ""
        Dim strEmployeeName As String = ""
        Dim iGroupCount As Integer = 0
        Dim tempTaskID As String = ""
        Dim ExpectedStartDate As String
        Dim ExpectedEndDate As String
        Dim EmployeeID As String
        'Added by NitinC on 03 Feb 2012 For WhizibleSEM 11.0 (Issue Fix 58806)
        Dim ExpectedUserStoryStartDate As String
        Dim ExpectedUserStoryEndDate As String
        'End of Added by NitinC on 03 Feb 2012 For WhizibleSEM 11.0 (Issue Fix 58806)
        Dim strActualWorkHours As String = "0"

        Dim startTDId As String
        Dim endTDId As String


        'Record_StartDt = DateAdd(DateInterval.Day, 10, Date.Now)
        'Record_EndDt = DateAdd(DateInterval.Day, 20, Date.Now)
        RB_validateDT = GantView_EndDt

        For Each drRow1 As DataRow In dsTask.Tables(1).Rows
            If drRow1("MinStartDate") <> "" Then
                GantView_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow1("MinStartDate")), Date)
            Else
                GantView_StartDt = CommonFunction.Data.CheckIsDBNull(drRow1("MinStartDate"))
            End If

            If drRow1("MaxEndDate") <> "" Then
                GantView_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow1("MaxEndDate")), Date)
            Else
                GantView_EndDt = CommonFunction.Data.CheckIsDBNull(drRow1("MaxEndDate"))
            End If
        Next

        If GantView_StartDt = "01-Jan-1900" And GantView_EndDt = "01-Jan-1900" Then
            MonDiff = 1
        Else
            MonDiff = (DateDiff(DateInterval.Month, GantView_StartDt, GantView_EndDt)) + 1
        End If



        ' '' DrawAddTaskMenu()

        sbHTML = New StringBuilder("")

        sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
        sbHTML.Append("<table  id=tblGantt cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")

        If Request.Browser.Browser.ToUpper = "CHROME" Then
            sbHTML.Append("<tr class='clsTRBlank' valign='left' style='height:48px;'>")
        ElseIf Request.Browser.Browser.ToUpper = "MOZILLA" Or Request.Browser.Browser.ToUpper = "FIREFOX" Then
            sbHTML.Append("<tr class='clsTRBlank' valign='left' style='height:51px;'>")
        Else
            sbHTML.Append("<tr class='clsTRBlank' valign='left' style='height:48px;'>")
        End If

        ' ''sbHTML.Append("<td align='left' width=2.5%  class='clsTDBlankNEW'>")
        ' ''sbHTML.Append("Apr(2016)")
        ' ''sbHTML.Append("</td>")
        ' ''sbHTML.Append("<td align='left' width=28%  class='clsTDBlankNEW'>")
        ' ''sbHTML.Append("Task Name")
        ' ''sbHTML.Append("</td>")

        '' ''Added by GokulP on 10 Nov 2009 for Resource Column 
        ' ''sbHTML.Append("<td align='left' width=20%  class='clsTDBlankNEW'>")
        ' ''sbHTML.Append("Resource")
        ' ''sbHTML.Append("</td>")
        '' ''End of Addition by GokulP on 10 Nov 2009 for Resource Column 

        ' ''sbHTML.Append("<td align='right' width=10%  class='clsTDBlankNEW' style='text-align:right;'>")
        ' ''sbHTML.Append("Actual/Planned Work (Hrs)")
        ' ''sbHTML.Append("</td>")
        drawMonthNameHeadings(sbHTML)
        sbHTML.Append("</tr>")
        '''''''''PrashantSJ 2nd June 2009
        'If m_objAccessRights.Add And DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.CGetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then

        '    sbHTML.Append("<Tr class=clsTRBlank id=""TRAdd"" >" + vbCrLf)
        '    sbHTML.Append("<td width=2% ALIGN='center' class='clsTDBlank'>" + vbCrLf)
        '    sbHTML.Append("<A href=""Javascript:CreateRowForTasks()""" + vbCrLf)
        '    sbHTML.Append("><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Create Task'></A>" + vbCrLf)
        '    sbHTML.Append("</td>" + vbCrLf)
        '    sbHTML.Append("<td ALIGN='center' colspan='20' class='clsTDBlank'> </td>" + vbCrLf)
        '    sbHTML.Append("</tr>" + vbCrLf)

        'End If
        '''''''''PrashantSJ 2nd June 2009


        For Each drRow As DataRow In dsTask.Tables(0).Rows

            strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("OverallScheduleID")), String)

            If CommonFunction.Data.CheckIsDBNull(drRow("StartDate")) <> "" Then
                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)
            Else
                Record_StartDt = Nothing
            End If

            If CommonFunction.Data.CheckIsDBNull(drRow("EndDate")) <> "" Then
                Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), Date)
            Else
                Record_EndDt = Nothing
            End If


            strFlag = CommonFunction.Data.CheckIsDBNull(drRow("Flag"))

            strMonthStartIDs = ""
            strMonthEndIDs = ""

            If strFlag.ToUpper = "CURRENT" Then
                sbHTML.Append("<tbody class=TRGroup>")
            End If

            startTDId = strRecPKID & "|" & Record_StartDt.Month & "|" & Record_StartDt.Day
            endTDId = strRecPKID & "|" & Record_EndDt.Month & "|" & Record_EndDt.Day

            If strFlag.ToUpper = "ACTUAL" Or strFlag.ToUpper = "ACTUAL1" Then
                sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='clsTRVertIndex' onmouseover=showToolTip(this,event,'" + Record_StartDt.ToString("dd-MMM-yyyy") + "','" + Record_EndDt.ToString("dd-MMM-yyyy") + "','" & startTDId & "','" & endTDId & "') onmouseout=hideToolTip(this,event) style='border-bottom:1px solid black;' >")
            ElseIf strFlag.ToUpper = "CURRENT" Then
                sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='clsTRVertIndex' onmouseover=showToolTip(this,event,'" + Record_StartDt.ToString("dd-MMM-yyyy") + "','" + Record_EndDt.ToString("dd-MMM-yyyy") + "','" & startTDId & "','" & endTDId & "') onmouseout=hideToolTip(this,event) style='border-top:1px solid black;' >")
            Else
                sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='clsTRVertIndex' onmouseover=showToolTip(this,event,'" + Record_StartDt.ToString("dd-MMM-yyyy") + "','" + Record_EndDt.ToString("dd-MMM-yyyy") + "','" & startTDId & "','" & endTDId & "') onmouseout=hideToolTip(this,event) >")
            End If
            vertIndex += 1

            'Added By Bharat Tekade on 17th-may-2016 

            If strFlag.ToUpper = "CURRENT" Then
                sbHTML.Append("<td  rowspan=3 width=20% style='background-color:#f0d1a1 !important;white-space:nowrap;' class='clsTDBlankNew clsFreeze'> ")
                Dim strSql As String
                Dim drOS As IDataReader

                strSql = "usp_sel_OsName_Dates " & strRecPKID & "," & m_GlobalObject.ProjectID.ToString
                drOS = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

                While drOS.Read
                    sbHTML.Append("<strong>" & drOS("OSName") & "</strong><br />")
                    sbHTML.Append("C: " & CommonFunctions.Data.CheckIsDBNull(drOS("CurrentStartDate"), "") & "-" & CommonFunctions.Data.CheckIsDBNull(drOS("CurrentEndDate"), "") & "<br />")
                    sbHTML.Append("B: " & CommonFunctions.Data.CheckIsDBNull(drOS("BaselineStartDate"), "") & "-" & CommonFunctions.Data.CheckIsDBNull(drOS("BaselineEndDate"), "") & "<br />")
                    sbHTML.Append("A: " & CommonFunctions.Data.CheckIsDBNull(drOS("ActualStartDate"), "") & "-" & CommonFunctions.Data.CheckIsDBNull(drOS("ActualEndDate"), ""))
                End While
                sbHTML.Append("</td>")

            End If

            'sbHTML.Append("<TD align=center width=20% style='background-color:#f0d1a1 !important;' class='clsTDBlankNew'> Dates </TD>")
            'End of Added By Bharat Tekade on 17th-may-2016 
            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
            objGanttChart_Month = New cOSGanttChart_Duration(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, sbHTML, m_strGanttView, dsWeekHead, strFlag)
            arrStartDates_MonthWise = New ArrayList(1)
            arrEndDates_MonthWise = New ArrayList(1)

            arrStartDates_MonthWise.Add(Record_StartDt)
            arrEndDates_MonthWise.Add(Record_EndDt)

            objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
            objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise
            objGanttChart_Month.drawMonthGantt(False)

            objGanttChart_Month = Nothing
            arrStartDates_MonthWise = Nothing
            arrEndDates_MonthWise = Nothing
            ''PrashantSJ on 13th March 2009
            'arrRVerticals = arrRVerticals + strRecPKID + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + ","
            If Record_EndDt >= GantView_StartDt And Record_EndDt <= GantView_EndDt Then
                arrRVerticals = arrRVerticals + strRecPKID + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + ","
            Else
                arrRVerticals = arrRVerticals + "0,"
            End If

            ''arrLVerticals = arrLVerticals + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
            If Record_StartDt >= GantView_StartDt And Record_StartDt <= GantView_EndDt Then
                arrLVerticals = arrLVerticals + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
            Else
                arrLVerticals = arrLVerticals + "0,"
            End If

            '''PrashantSJ 12th March 2009
            'strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
            strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + GantView_StartDt.Month.ToString + "|" + GantView_StartDt.Day.ToString + ","
            ''End of addition by PrashantSJ on 12th March 2009
            RB_validateDT = GantView_EndDt

            strVertRightRBs = strVertRightRBs + strRecPKID + "|" + RB_validateDT.Month.ToString + "|" + RB_validateDT.Day.ToString + ","

            'Hidden Controls 
            'strRecPKID, strRoleID, strSkillID
            hidRecPKIDs = hidRecPKIDs + strRecPKID + ","

            sbHTML.Append("<input type=hidden name='L|" + strRecPKID + "' id='L|" + strRecPKID + "' value='" + Record_StartDt.ToString("dd-MMM-yyyy") + "' >")
            sbHTML.Append("<input type=hidden name='R|" + strRecPKID + "' id='R|" + strRecPKID + "' value='" + Record_EndDt.ToString("dd-MMM-yyyy") + "' >")

            sbHTML.Append("</tr>")

            If strFlag.ToUpper = "ACTUAL" Or strFlag.ToUpper = "ACTUAL1" Then
                sbHTML.Append("</tbody>")
            End If

            If Not IsCaseOneProject And strParentTaskID <> "" Then

                strQuery = "usp_Sel_ParentTaskDetails_ForGanttChart " & m_GlobalObject.ProjectID.ToString & "," & strParentTaskID
                drParentTask = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

                If drParentTask.Read Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("Work")).ToString, "right", , , , , True, , True, ))
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("StartDate")), Date)), "right", , , , , True, , True, ))
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("EndDate")), Date)), "right", , , , , True, , True, ))
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("ActualWork")).ToString, "right", , , , , True, , True, ))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("Work")).ToString, "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("StartDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("EndDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("ActualWork")).ToString, "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                End If
                CommonFunction.Data.DisposeDataReader(drParentTask)

            End If


        Next
        sbHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")


        If m_objAccessRights.Add And DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , (dsTask.Tables(0).Rows.Count + iGroupCount).ToString, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , (dsTask.Tables(0).Rows.Count + iGroupCount).ToString, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)

            'sbHTML.Append("<Tr class=clsTRBlank id=""TRAdd"" >" + vbCrLf)
            'sbHTML.Append("<td width=2% ALIGN='center' class='clsTDBlank'>" + vbCrLf)
            'sbHTML.Append("<A href=""Javascript:CreateRowForTasks()""" + vbCrLf)
            'sbHTML.Append("><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Create Task'></A>" + vbCrLf)
            'sbHTML.Append("</td>" + vbCrLf)
            'sbHTML.Append("<td ALIGN='center' colspan='20' class='clsTDBlank'> </td>" + vbCrLf)
            'sbHTML.Append("</tr>" + vbCrLf)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
            'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        End If

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")


        arrRightVerticals = arrRVerticals.Split(","c)
        arrLeftVerticals = arrLVerticals.Split(","c)
        arrVertLeftLB = strVertLeftLBs.Split(","c)
        arrVertRightRB = strVertRightRBs.Split(","c)

        arrIsTaskClosed = strIsTaskClosed.Split(","c)


        Dim arrCnt As Integer

        Response.Write(sbHTML.ToString)

        CommonFunction.General.WriteHTML("<script>")
        CommonFunction.General.WriteHTML("var arrVertRight = new Array();")
        CommonFunction.General.WriteHTML("var arrVertLeft = new Array();")
        CommonFunction.General.WriteHTML("var arrVertLeftLB = new Array();")
        CommonFunction.General.WriteHTML("var arrVertRightRB = new Array();")

        For arrCnt = 0 To arrRightVerticals.Length - 2
            CommonFunction.General.WriteHTML("arrVertRight[" + CType(arrCnt, String) + "]=""" + arrRightVerticals(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertLeft[" + CType(arrCnt, String) + "]=""" + arrLeftVerticals(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertLeftLB[" + CType(arrCnt, String) + "]=""" + arrVertLeftLB(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertRightRB[" + CType(arrCnt, String) + "]=""" + arrVertRightRB(arrCnt) + """;")

        Next

        If m_strGanttView = "1" Then
            CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
            CommonFunction.General.WriteHTML("var GantViewEndDay=" + DateTime.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month).ToString + ";")
            CommonFunction.General.WriteHTML("var GantViewStartDay=1;")
            CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")

        ElseIf m_strGanttView = "2" Or m_strGanttView = "5" Then

            CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
            CommonFunction.General.WriteHTML("var GantViewEndDay=" + GantView_EndDt.Day.ToString + ";")
            CommonFunction.General.WriteHTML("var GantViewStartDay=" + GantView_StartDt.Day.ToString + ";")
            CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")
        End If

        CommonFunction.General.WriteHTML("</script>")

        For arrCnt = 0 To arrRightVerticals.Length - 2
            'If arrIsTaskClosed(arrCnt) = True Then
            '    CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' ></div>")
            '    CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' ></div>")

            'Else
            'CommonFunction.General.WriteHTML("<div class=LRDiv id='verL" + arrCnt.ToString + "'  onmousedown=""clickDownVert(event)""></div>")
            'CommonFunction.General.WriteHTML("<img id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;' border='0' src='../../Images/InitiativeGreen.gif' onmousedown=""clickDownVert(event)""></img>")
            'style='cursor:e-resize;position:relative;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;'
            'CommonFunction.General.WriteHTML("<div class=LRDiv id='verR" + arrCnt.ToString + "'  onmousedown=""clickDownVert(event)""></div>")
            'CommonFunction.General.WriteHTML("<img id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;' border='0' src='../../Images/InitiativeGreen.gif' onmousedown=""clickDownVert(event)""></img>")

            'End If

        Next

        sbHTML = Nothing

    End Sub
    Private Sub drawMonthNameHeadings(ByRef objStringBuilder As System.Text.StringBuilder)

        If m_strGanttView = "1" Then

            Dim Iterator As Integer
            Dim StartYear As Integer
            Dim StartMonth As Integer
            Iterator = 1


            StartYear = GantView_StartDt.Year
            StartMonth = GantView_StartDt.Month
            'Added By Bharat Tekade on 17th-may-2016 
            objStringBuilder.Append("<TD align=center width=20% style='background-color:#f0d1a1 !important;' class='clsTDBlankNew clsFreeze'> WBS Combination </TD>")
            'objStringBuilder.Append("<TD align=center width=20% style='background-color:#f0d1a1 !important;' class='clsTDBlankNew'> Dates </TD>")
            'End of Added By Bharat Tekade on 17th-may-2016 

            While Iterator <= MonDiff

                objStringBuilder.Append("<TD id='Month" + StartMonth.ToString + "' align=center width=20% style='background-color:#f0d1a1 !important;' class='clsTDBlankNew'>  " + vbCrLf)

                If GantView_StartDt = "01-Jan-1900" And GantView_EndDt = "01-Jan-1900" Then
                Else
                    If m_strGanttView = "2" Then
                        objStringBuilder.Append(GetWeekHeading(StartMonth, StartYear) + vbCrLf)
                    Else
                        objStringBuilder.Append(MonthName(StartMonth, True) + " (" + StartYear.ToString + " )" + vbCrLf)
                    End If

                    If StartMonth = 12 Then
                        StartMonth = 1
                        StartYear += 1
                    Else
                        StartMonth = StartMonth + 1
                    End If
                End If
                Iterator += 1


                objStringBuilder.Append("</TD>" + vbCrLf)
            End While
        ElseIf m_strGanttView = "2" Then
            For Each drRow As DataRow In dsWeekHead.Tables(0).Rows
                objStringBuilder.Append("<TD id='Week' align=center width=5% class='clsTDBlankNew'>  " + vbCrLf)
                objStringBuilder.Append(CommonFunction.Data.CheckIsDBNull(drRow("WeekHeading")) + vbCrLf)
                objStringBuilder.Append("</TD>" + vbCrLf)
            Next
        ElseIf m_strGanttView = "5" Or m_strGanttView = "6" Then
            Dim dtSD, dtED As Date
            Dim dblTDWidth As Double = 0.0

            dtSD = GantView_StartDt
            dtED = GantView_EndDt

            If m_strGanttView = "6" Then
                dblTDWidth = 8.5 ''2 'CType(60 / (Date.DaysInMonth(dtSD.Year, dtSD.Month)), Double)
            Else
                dblTDWidth = 8.5 ''2 ''8.5
            End If

            While DateDiff(DateInterval.Day, dtSD, dtED) >= 0
                objStringBuilder.Append("<TD id='Day' align=center width=" + dblTDWidth.ToString + "% class='clsTDBlankNew'>  " + vbCrLf)
                objStringBuilder.Append(WeekdayName(Weekday(dtSD, CType(CommonFunction.Application.StartingDayofweek, Microsoft.VisualBasic.FirstDayOfWeek)), True, CommonFunction.Application.StartingDayofweek) + "&nbsp;" + CType(Day(dtSD), String) + vbCrLf)
                objStringBuilder.Append("</TD>" + vbCrLf)
                ''WeekdayName(Weekday(GantView_StartDt, CType(CommonFunction.Application.StartingDayofweek, Microsoft.VisualBasic.FirstDayOfWeek)), True) + "&nbsp;" + CType(Day(GantView_StartDt), String)
                dtSD = DateAdd(DateInterval.Day, 1, dtSD)
            End While

        End If
    End Sub
    Private Function GetWeekHeading(ByVal intMonth As Integer, ByVal intYear As Integer) As String
        Dim sbWeekHead As New StringBuilder("")
        Dim sQuery As String = ""

        sQuery = "usp_Sel_WeekNumbers_ForGanttChart " & intMonth.ToString & "," & intYear.ToString
        drMonthHead = CommonFunction.Data.GetDataReader(sQuery, MyBase.UseSQL)


        sbWeekHead.Append("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width=100% >" + vbCrLf)
        sbWeekHead.Append("<TR class='clsTRBlank'>" + vbCrLf)
        ''style='border-right:black 1px outset;'
        While drMonthHead.Read
            sbWeekHead.Append("<TD width='4%' colsapn='7' class='clsTDBlankNew' >")
            sbWeekHead.Append(CommonFunction.Data.CheckIsDBNull(drMonthHead("WeekNumber")).ToString)
            sbWeekHead.Append("</TD>")
        End While

        sbWeekHead.Append("</TR>")
        sbWeekHead.Append("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drMonthHead)

        Return sbWeekHead.ToString

        sbWeekHead = Nothing
    End Function
    Protected Sub Initialize_Variables()
        '=====================================================================
        ' Function  Name		:	Initialize_Variables
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================


        GetGlobalObject()
        'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_GlobalObject.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        Dim dtTempDate As Date
        m_strEmployeeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboFilter_EmployeeID"), ""), String)
        'Added By VijayD On 26 August 2009
        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(m_GlobalObject.ProjectID.ToString, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        'End Addition By VijayD On 26 August 2009
        If Not Request.QueryString("GanttChartType") Is Nothing Then
            m_strGanttView = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("GanttChartType"), "2"), String)
        Else
            m_strGanttView = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtGanttView"), "2"), String)
        End If

        If m_strGanttView.IndexOf(",") >= 0 Then
            m_strGanttView = m_strGanttView.Split(",")(0)
        End If

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = CType(Request.QueryString("Mode"), String)
            'Else
            '    m_strMode = CommonFunction.General.CheckIsNothing(Request.Form("hidMode"))
        End If
        If Not Request.QueryString("MasterTagID") Is Nothing Then
            m_strTagID = CType(Request.QueryString("MasterTagID"), String)
        Else
            m_strTagID = CommonFunction.General.CheckIsNothing(Request.Form("hidTagID"))
        End If

        GetTagAccessRights()

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Period")) <> "" Then
            m_strPeriod = CommonFunction.General.CheckIsNothing(Request.QueryString("Period"))
        Else
            m_strPeriod = CommonFunction.General.CheckIsNothing(Request.Form("hidPeriod"))
        End If

        If m_strGanttView = "2" Then
            m_strSQL = "usp_Sel_CalenderYear_Weeks_ForGantt "

            If Not Request.Form("hidGanttStartDate") Is Nothing And m_strPeriod.ToUpper = "PREV" Then
                m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, -56, CType(Request.Form("hidGanttStartDate"), Date))) & "'"
            ElseIf Not Request.Form("hidGanttEndDate") Is Nothing And m_strPeriod.ToUpper = "NEXT" Then
                m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, -27, CType(Request.Form("hidGanttEndDate"), Date))) & "'"
            ElseIf Not Request.Form("hidGanttStartDate") Is Nothing And m_strPeriod.ToUpper = "" Then
                m_strSQL &= "'" & CommonFunction.Dates.GetDate(CType(Request.Form("hidGanttStartDate"), Date)) & "'"
            Else
                m_strSQL &= "'" & CType("1-" + MonthName(Date.Today.Month) + "-" + Date.Today.Year.ToString, Date) & "'"
            End If

            m_strSQL &= "," & CommonFunction.Application.StartingDayofweek.ToString

            dsWeekHead = CommonFunction.Data.GetDataSet(m_strSQL, "Week", , , MyBase.UseSQL)

            For Each drRow As DataRow In dsWeekHead.Tables(0).Rows
                dtTempStartDate = CType(CommonFunction.Data.CheckIsDBNull(drRow("MinStartDate")), String)
                dtTempEndDate = CType(CommonFunction.Data.CheckIsDBNull(drRow("MaxEndDate")), String)
                Exit For
            Next
        ElseIf m_strGanttView = "5" Or m_strGanttView = "6" Then
            m_strSQL = "usp_Sel_CalenderYear_Daily_ForGantt "


            If Not Request.Form("hidGanttStartDate") Is Nothing And m_strPeriod.ToUpper = "PREV" Then
                If m_strGanttView = "5" Then
                    m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, -5, CType(Request.Form("hidGanttStartDate"), Date))) & "'"
                Else
                    m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, -1, CType(Request.Form("hidGanttStartDate"), Date))) & "'"
                End If
            ElseIf Not Request.Form("hidGanttEndDate") Is Nothing And m_strPeriod.ToUpper = "NEXT" Then
                If m_strGanttView = "5" Then
                    m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, 5, CType(Request.Form("hidGanttEndDate"), Date))) & "'"
                Else
                    m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CType(Request.Form("hidGanttEndDate"), Date))) & "'"
                End If
            ElseIf Not Request.Form("hidGanttStartDate") Is Nothing And m_strPeriod.ToUpper = "" Then
                m_strSQL &= "'" & CommonFunction.Dates.GetDate(CType(Request.Form("hidGanttStartDate"), Date)) & "'"
            Else
                m_strSQL &= "'" & CommonFunction.Dates.GetDate(Date.Now) & "'"
            End If

            If m_strGanttView = "6" Then
                m_strSQL &= ",3"
            End If

            dsWeekHead = CommonFunction.Data.GetDataSet(m_strSQL, "DAY", , , MyBase.UseSQL)

            For Each drRow As DataRow In dsWeekHead.Tables(0).Rows
                dtTempStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("WeekStartDate")), Date))
                dtTempEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("WeekEndDate")), Date))
            Next
        End If

        If Not Request.Form("hidGanttStartDate") Is Nothing And Not Request.Form("hidGanttEndDate") Is Nothing Then
            'If dtTempStartDate = "" And dtTempEndDate = "" Then
            GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(Request.Form("hidGanttStartDate"), Date)), Date)
            GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(Request.Form("hidGanttEndDate"), Date)), Date)
            'End If
        Else
            If dtTempStartDate <> "" And dtTempEndDate <> "" Then
                GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
                GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
            Else
                GantView_StartDt = CType("1-" + MonthName(DateAdd(DateInterval.Month, -1, Date.Now).Month) + "-" + DateAdd(DateInterval.Month, -1, Date.Now).Year.ToString, Date)
                dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
                GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
            End If
        End If

        If m_strPeriod.ToUpper = "PREV" Then
            If m_strGanttView = "1" Then
                GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(GantView_StartDt.Year, GantView_StartDt.Month)) - 1, GantView_StartDt) ''DateAdd(DateInterval.Day, -1, GantView_StartDt)
                GantView_StartDt = DateAdd(DateInterval.Month, -(MonDiff - 1), GantView_EndDt)
                GantView_StartDt = CType("1-" + MonthName(GantView_StartDt.Month) + "-" + GantView_StartDt.Year.ToString, Date)
            ElseIf m_strGanttView = "2" Then
                GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
                GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
            ElseIf m_strGanttView = "5" Or m_strGanttView = "6" Then
                GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
                GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
            End If
        ElseIf m_strPeriod.ToUpper = "NEXT" Then
            If m_strGanttView = "1" Then
                GantView_StartDt = CType("1-" + MonthName(GantView_EndDt.Month) + "-" + GantView_EndDt.Year.ToString, Date) ''DateAdd(DateInterval.Day, 1, GantView_EndDt)
                dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
                GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
            ElseIf m_strGanttView = "2" Then
                GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
                GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
            ElseIf m_strGanttView = "5" Or m_strGanttView = "6" Then
                GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
                GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
            End If
        End If

        m_strFilterID = CommonFunction.General.CheckIsNothing(Request.Form("cboViews"), "0")

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        m_strEntityName = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(Request.Form("txtEntityName")))

        Select Case m_strTagID
            Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                m_strTaskName = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(Request.Form("txtTaskName")))
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString(), CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString(), CommonFunction.Constants.APP_TAG_MODULES.ToString()
                m_strIsClosed = CommonFunction.General.CheckIsNothing(Request.Form("cboClosed"))
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString()
                m_strDeliverableTypeId = CommonFunction.General.CheckIsNothing(Request.Form("cboDeliverableType"))
            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                m_strIsActiveResource = CommonFunction.General.CheckIsNothing(Request.Form("cboActiveResource"))
                m_strRoleID = CommonFunction.General.CheckIsNothing(Request.Form("cboRole"))
        End Select


        m_strTaskType = CommonFunctions.General.CheckIsNothing(Request("optTaskType"), "Assigned")

        GetProjectSettingsDetails()

        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            m_strSQL = "usp_Sel_tbl_PM_Project_TaskTypes " & m_GlobalObject.ProjectID.ToString & ",1"
            drDeffered = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drDeffered.Read Then
                arrTaskType(0) = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskTypeID")), String)
                arrTaskType(1) = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskType")), String)
            End If
            CommonFunction.Data.DisposeDataReader(drDeffered)
        End If


        Select Case m_strTagID
            Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                Dim drEmail As IDataReader
                m_strSQL = "usp_Sel_tbl_PM_EmailMessages 20"
                drEmail = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
                    If drEmail.Read() Then
                        m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                        m_blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drEmail)
        End Select

    End Sub
    Private Sub GetTagAccessRights()
        Select Case m_strTagID
            Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_RESOURCES
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
            Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS
            Case CommonFunction.Constants.APP_TAG_MODULES.ToString
                m_GlobalObject.TagID = CommonFunction.Constants.APP_TAG_MODULES
        End Select

        m_objAccessRights.GetAccess(m_GlobalObject)

    End Sub
    Private Sub GetDatabasValues()

        If m_strMode = "OSFILTER" Then
            m_strSQL = "Usp_Sel_tbl_WPBN_PM_OverallSchedule_GanttView  " & m_GlobalObject.ProjectID.ToString & "," & strSubProject & "," & strModule & "," & strPhase & "," & strDeliverable & "," & strMilestone & ",'" & strOSName & "'"
        Else
            m_strSQL = "Usp_Sel_tbl_WPBN_PM_OverallSchedule_GanttView  " & m_GlobalObject.ProjectID.ToString & ",NULL,NULL,NULL,NULL,NULL,''"
        End If

        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)

        m_intRowCount = dsTemp.Tables(0).Rows.Count

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)


        'If m_intPageNumber = -1 Then
        '    dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", , , MyBase.UseSQL)
        'Else
        '    dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        'End If
        dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", , , MyBase.UseSQL)

    End Sub
    Private Sub GetProjectSettingsDetails()
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
        ' Author               : JayavantK
        ' Created              : May 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectSettings As IDataReader
        Dim blnUseActivities As Boolean = False
        Dim blnApplyEffortDistribution As Boolean = False

        'Modified BY NitinVS on 21 May 2007 for WhizibleSEM 7.0 
        ' Changed select to SP 
        strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_GlobalObject.ProjectID.ToString

        drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drProjectSettings.Read() Then

            m_strProjectStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedStartDate"), ""), Date).ToString("dd-MMM-yyyy")
            m_strProjectEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedEndDate"), ""), Date).ToString("dd-MMM-yyyy")
            m_lngProjectLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("LocationID"), "0"), Long)
            m_dblOUWorkingHrs = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("WorkingHours"), "0"), Double)
            'If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
            ''If m_strProjectStartDate <> "" Then m_strProjectStartDate = m_strProjectStartDate.ToString("dd-MMM-yyyy")

            'If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
            ''If m_strProjectEndDate <> "" Then m_strProjectEndDate = m_strProjectEndDate.ToString("dd-MMM-yyyy")

            m_HaveSubTaskTypes = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            m_ApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_bitResourceValidation = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ResourceValidation"), "False"), Short)
            ' True is treated as -1 
            If m_bitResourceValidation = -1 Then
                m_bitResourceValidation = 1
            End If
            m_blnBillable = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Billable"), "False"), Boolean)
            m_blnProjectActive = Not (CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Over"), "False"), Boolean))

            m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("EstimatedEfforts"), "0.0"), Double)
        End If

        CommonFunctions.Data.DisposeDataReader(drProjectSettings)

        If m_HaveSubTaskTypes = False And m_ApplyEffortDistribution = False Then
            IsCaseOneProject = True
            m_strProjectSetting = PROJECT_SETTING_NORMAL
        End If

        If m_HaveSubTaskTypes And m_ApplyEffortDistribution Then
            IsCase3Project = True
            m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION
        End If

        If m_HaveSubTaskTypes = False And m_ApplyEffortDistribution Then
            IsCase2Project = True
        End If

    End Sub
    Protected Sub DrawHiddenFields()
        '=====================================================================
        ' Proce  Name	    	:	DrawHiddenFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw hidden fields
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidMode", "hidMode", , , , m_strMode, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTagID", "hidTagID", , , , m_strTagID, , , , , , True, , True, EnableHTMLEncode:=True))
        '' Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidPeriod", "hidPeriod", , , , m_strPeriod, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttStartDate", "hidGanttStartDate", , , , CommonFunction.Dates.GetDate(GantView_StartDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttEndDate", "hidGanttEndDate", , , , CommonFunction.Dates.GetDate(GantView_EndDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))

        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGanttView", "txtGanttView", , , , m_strGanttView, , , , , , True, , True))

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTTID", "hidTxtTTID", , , , CType(arrTaskType(0), String), , , , , , True, , True, EnableHTMLEncode:=True))
        ''''cboFilter_EmployeeID
        'Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        If m_intFlag = "1" Then
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtUSID", "hidTxtUSID", , , , CType(arrTaskType(0), String), , , , , , True, , True, EnableHTMLEncode:=True))
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' Dim hidTxtTaskDate As String = CType(CommonFunction.Data.GetDataScalar("SELECT datename(dd,getdate())+'-'+substring(datename(mm,getdate()),1,3)+'-'+datename(yyyy,getdate())", MyBase.UseSQL), String)
            Dim hidTxtTaskDate As String = CType(CommonFunction.Data.GetDataScalar("sel_Toady_date", MyBase.UseSQL), String)
            ''End of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTaskDate", "hidTxtTaskDate", , , , hidTxtTaskDate, , , , , , True, , True, EnableHTMLEncode:=True))
        End If

        'End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtARID", "hidTxtARID", , , , m_strEmployeeID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtAPR", "hidTxtAPR", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("cboViews", "cboViews", , , , m_strFilterID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtASTA", "hidTxtASTA", , , , , , , , , , True, , True, EnableHTMLEncode:=True))

        DrawHolidayAlert()

    End Sub
    Private Sub DrawHolidayAlert()
        Dim sbHolidayAlert As New StringBuilder("")

        sbHolidayAlert.Append("<div id='hldAlert' class='ContextMenu' style='overlfow:auto;width:400px;height:100px;display:none;'>")
        sbHolidayAlert.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable' width='100%' >")
        sbHolidayAlert.Append("<tr class='clsTRBlank'>")
        sbHolidayAlert.Append("<td class='clsTDBlank' colsapn='2'>")
        sbHolidayAlert.Append("<label id='lblMsg'></label>")
        sbHolidayAlert.Append("</td>")
        sbHolidayAlert.Append("</tr>")

        sbHolidayAlert.Append("<tr class='clsTRBlank'>")
        sbHolidayAlert.Append("<td class='clsTDBlank' align='center'>")
        sbHolidayAlert.Append("<input type='button' value='Ok' text='Ok' onclick='javascript:OkCancel_OnClick(1)'>")
        'sbHolidayAlert.Append("&nbsp;&nbsp;")
        'sbHolidayAlert.Append("<input type='button' value='Cancel' text='Cancel' onclick='javascript:OkCancel_OnClick(2)'>")
        sbHolidayAlert.Append("</td>")
        sbHolidayAlert.Append("</tr>")

        sbHolidayAlert.Append("</table>")
        sbHolidayAlert.Append("</div>")

        Response.Write(sbHolidayAlert.ToString)
        sbHolidayAlert = Nothing
    End Sub
    Protected Sub DrawFilters()
        If m_strTagID = "1038" Then
            sbHTML = New StringBuilder("")

            ' sbHTML.Append("<div id=divFilter style='width:100%;overflow:auto;display:none;'>")
            sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
            sbHTML.Append("<TR class='clsTRBlank'>")
            sbHTML.Append("<TD valign='Top' align='left' class='clsTDBlankNew'>")
            sbHTML.Append("Show Task For Resource ")

            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation for Performance 

            m_strSQL = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_GlobalObject.ProjectID.ToString
            'm_strSQL += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
            m_strSQL += " ,Null , 1"
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", m_strSQL, 150, m_strEmployeeID.ToString(), "onchange=FilterTasks()", True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
            sbHTML.Append("Task Name ")
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 150, , m_strTaskName, , , , , , , "onkeyup=TaskName_OnKeyup(event)", True, EnableHTMLEncode:=True))
            sbHTML.Append("</TD>")
            'sbHTML.Append("<TD valign='Top' align='right' class='clsTDBlankNew'>")
            'sbHTML.Append("Views ") ''"<Img Border=0 src='../../Images/View.gif' />&nbsp;")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboViews", "usp_Sel_tbl_UI_Views_ForGanttChart 3751," + m_GlobalObject.UserID.ToString, 200, m_strFilterID, "onchange=Views_OnChange()", , True))
            'sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            sbHTML.Append("</TABLE>")
            sbHTML.Append("</br>")

            Response.Write(sbHTML.ToString)
            sbHTML = Nothing
        End If
    End Sub
    Protected Sub DisposeNotUsedObjects()
        '=====================================================================
        ' Function  Name		:	DisposeNotUsedObjects
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To destroy not used objects
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        dsTemp = Nothing
        dsTask = Nothing
        m_GlobalObject = Nothing
        m_objAccessRights = Nothing
        dsWeekHead = Nothing
    End Sub

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()



    End Sub


    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
    End Sub

    Protected Sub DrawValidationHiddenFields()
        '=====================================================================
        ' Proce  Name	    	:	DrawValidationHiddenFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw hidden fields for project validations
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Shraddha M
        ' Created				:	25,May 2009
        ' Revisions				:	
        '=====================================================================

        Dim IsProjectApproved As String
        Dim ResourceValidation As String
        Dim IsProjectOnHold As String
        Dim IsProjectOver As String
        Dim dr As IDataReader
        Dim strQuery As String

        strQuery = "usp_Sel_TaskGanttViewValidation " + Session("intProjectID").ToString()

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If dr.Read() Then
            IsProjectApproved = dr("IsProjectApproved").ToString()
            ResourceValidation = dr("ResourceValidation").ToString()
            IsProjectOnHold = dr("IsProjectOnHold").ToString()
            IsProjectOver = dr("IsProjectOver").ToString()
            m_intBaselineNumber = dr("BaselineNumber").ToString() 'Added By VijayD 0On 29 August 2009
        End If

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectApproved", "hidIsProjectApproved", , , , IsProjectApproved, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidResourceValidation", "hidResourceValidation", , , , ResourceValidation, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOnHold", "hidIsProjectOnHold", , , , IsProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOver", "hidIsProjectOver", , , , IsProjectOver, , , , , , True, , True, EnableHTMLEncode:=True))

        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
End Class

Class cOSGanttChart_Duration

    Private m_PKID As String
    Private m_arrStartDt As System.Collections.ArrayList
    Private m_arrEndDt As System.Collections.ArrayList
    Private m_arrBench As System.Collections.ArrayList
    Protected m_PlottingPeriod_BookPeriod_Color As String = "blue"
    Private m_PlottingPeriod_AvailabilityPeriod_Color As String = "red"
    Private m_AvailabilityPeriod_Color As String = "White"
    Private m_GanttStartDt As DateTime
    Private m_GanttEndDt As DateTime
    Private m_MonDiff As Integer
    Private m_ResponseWriter As System.Text.StringBuilder
    Private m_Ref_GanttStartDt As DateTime
    Private m_Ref_GanttEndDt As DateTime
    Private m_strGanttChartType As String = ""
    Private m_dsWeek As DataSet


    Sub New(ByVal GanttStartDate As DateTime, ByVal GanttEndDate As DateTime, ByVal MonDiff As Integer, ByVal PrimaryKey As String, ByRef ResponseWriter As System.Text.StringBuilder, ByVal m_strGanttView As String, ByVal dsWeekHead As DataSet, ByVal strFlag As String)
        m_GanttStartDt = GanttStartDate
        m_GanttEndDt = GanttEndDate
        m_MonDiff = MonDiff
        m_PKID = PrimaryKey
        m_ResponseWriter = ResponseWriter
        m_strGanttChartType = m_strGanttView
        m_dsWeek = dsWeekHead
        If strFlag = "Baseline" Then
            m_PlottingPeriod_BookPeriod_Color = "blue"
        ElseIf strFlag = "Current" Then
            m_PlottingPeriod_BookPeriod_Color = "Orange"
        ElseIf strFlag = "Actual" Then
            m_PlottingPeriod_BookPeriod_Color = "Green"
        ElseIf strFlag = "Actual1" Then
            m_PlottingPeriod_BookPeriod_Color = "lightgreen"
        End If


    End Sub
    Public WriteOnly Property Ref_GanttStartDate() As DateTime
        Set(ByVal Value As DateTime)
            m_Ref_GanttStartDt = Value
        End Set
    End Property
    Public WriteOnly Property Ref_GanttEndDate() As DateTime
        Set(ByVal Value As DateTime)
            m_Ref_GanttEndDt = Value
        End Set
    End Property
    Public WriteOnly Property PlottingStartDates() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrStartDt = Value
        End Set
    End Property

    Public WriteOnly Property PlottingEndDates() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrEndDt = Value
        End Set
    End Property

    Public WriteOnly Property OnBench() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrBench = Value
        End Set
    End Property

    Public Sub drawMonthGantt(ByVal BenchColor As Boolean)

        If BenchColor = True Then
            'If HR_PipelineGraphicalView.blnOnBenchForPlotting = True Then
            m_PlottingPeriod_BookPeriod_Color = "Green"
            'End If
        End If

        If m_arrStartDt Is Nothing OrElse m_arrEndDt Is Nothing Then
            Throw New Exception("Gantt Start Dates or End Dates are not initialized")
        End If
        If m_arrStartDt.Count <> m_arrEndDt.Count OrElse m_arrStartDt.Count = 0 Then
            Throw New Exception("Gantt Start Dates or End Dates are not properly initialized")
        End If
        If m_arrStartDt.Count > 1 And (m_Ref_GanttEndDt = New DateTime Or m_Ref_GanttStartDt = New DateTime) Then
            Throw New Exception("Gantt Reference chart Start Dates or End Dates are not initialized")
        End If

        If m_strGanttChartType = "1" Then
            drawMonths()
        ElseIf m_strGanttChartType = "2" Then
            DrawWeeks()
        ElseIf m_strGanttChartType = "5" Or m_strGanttChartType = "6" Then
            DrawDailyGanttChart(m_GanttStartDt, m_GanttEndDt)
        End If

    End Sub
    Private Sub DrawWeeks()
        For Each drRow As DataRow In m_dsWeek.Tables(0).Rows
            m_ResponseWriter.Append("<TD width=5% style=""padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
            DrawWeekGanttChart(CommonFunction.Dates.GetDate(CType(drRow("WeekStartDate"), Date)), CommonFunction.Dates.GetDate(CType(drRow("WeekEndDate"), Date)))
            m_ResponseWriter.Append("</TD>" + vbCrLf)
        Next
    End Sub
    Private Sub DrawDailyGanttChart(ByVal GanttSD As Date, ByVal GanttED As Date)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime
        Dim stringToBeInsterted As String = ""
        Dim dblTDWidth As Double = 0.0

        'm_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)
        'm_ResponseWriter.Append("<TR  Year='" + GanttSD.Year.ToString + "' >" + vbCrLf)
        If m_strGanttChartType = "6" Then
            dblTDWidth = 8.5 ''2 'CType(60 / (Date.DaysInMonth(GanttSD.Year, GanttSD.Month)), Double)
        Else
            dblTDWidth = 8.5 ''2 '' 8.5
        End If

        stringToBeInsterted = "width=" + dblTDWidth.ToString + "%"

        If m_Ref_GanttStartDt = New DateTime Then

            ' For cntDay = 1 To 31
            While DateDiff(DateInterval.Day, GanttSD, GanttED) >= 0

                m_ResponseWriter.Append("<TD " + stringToBeInsterted + " style=""padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
                m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)
                m_ResponseWriter.Append("<TR  Year='" + GanttSD.Year.ToString + "' >" + vbCrLf)

                dtForToolTip = GanttSD ''New Date(Year, 1, cntDay)
                cntDay = dtForToolTip.Day
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + " ></TD>" + vbCrLf)
                    'm_ResponseWriter.Append("<TD class='clsGanttChart' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "'  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

                GanttSD = DateAdd(DateInterval.Day, 1, GanttSD)
                ' Next
                m_ResponseWriter.Append("</tr></table>" + vbCrLf)
                m_ResponseWriter.Append("</TD>" + vbCrLf)
            End While
        Else

            While DateDiff(DateInterval.Day, GanttSD, GanttED) >= 0
                m_ResponseWriter.Append("<TD width=8.5% style=""padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)

                m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)
                m_ResponseWriter.Append("<TR  Year='" + GanttSD.Year.ToString + "' >" + vbCrLf)

                dtForToolTip = GanttSD ''New Date(Year, 1, cntDay)
                cntDay = dtForToolTip.Day
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And HR_PipelineGraphicalView.blnOnBench = False)) Then
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt) OrElse (HR_PipelineGraphicalView.blnOnBench = True And dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt)) Then
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If

                GanttSD = DateAdd(DateInterval.Day, 1, GanttSD)
                ' Next

                m_ResponseWriter.Append("</tr></table>" + vbCrLf)
                m_ResponseWriter.Append("</TD>" + vbCrLf)
            End While
        End If

        'm_ResponseWriter.Append("</tr></table>" + vbCrLf)

    End Sub
    Private Sub DrawWeekGanttChart(ByVal GanttSD As Date, ByVal GanttED As Date)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime
        Dim stringToBeInsterted As String = ""


        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)
        'm_ResponseWriter.Append("<TR width=33% Year='" + GanttSD.Year.ToString + "' height=45%>" + vbCrLf)
        m_ResponseWriter.Append("<TR  Year='" + GanttSD.Year.ToString + "' >" + vbCrLf)


        'If m_arrStartDt.Count = 1 Then
        If m_Ref_GanttStartDt = New DateTime Then

            ' For cntDay = 1 To 31
            While DateDiff(DateInterval.Day, GanttSD, GanttED) >= 0

                dtForToolTip = GanttSD ''New Date(Year, 1, cntDay)
                cntDay = dtForToolTip.Day
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + " ></TD>" + vbCrLf)
                    'm_ResponseWriter.Append("<TD class='clsGanttChart' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "'  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

                GanttSD = DateAdd(DateInterval.Day, 1, GanttSD)
                ' Next

            End While
        Else

            While DateDiff(DateInterval.Day, GanttSD, GanttED) >= 0

                dtForToolTip = GanttSD ''New Date(Year, 1, cntDay)
                cntDay = dtForToolTip.Day
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And HR_PipelineGraphicalView.blnOnBench = False)) Then
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt) OrElse (HR_PipelineGraphicalView.blnOnBench = True And dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt)) Then
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                ' If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                'm_ResponseWriter.Append("<TD class='clsGanttChart' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If

                GanttSD = DateAdd(DateInterval.Day, 1, GanttSD)
                ' Next

            End While
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)

    End Sub
    Private Sub drawMonths()
        Dim Iterator As Integer
        Dim StartMonth As Integer
        Dim Year As Integer

        If Not m_GanttStartDt = "01-Jan-1900" Then
            StartMonth = m_GanttStartDt.Month
            Year = m_GanttStartDt.Year
        Else
            StartMonth = 0
            Year = 0
        End If

        Iterator = 1
        While Iterator <= m_MonDiff
            'tblHTML.Append("<TD style=""border-bottom: thin solid gray"" id='MonthValues" + CType(jMonCounter, String) + "'>" + vbCrLf)
            'tblHTML.Append("<TD style=""border-bottom: thin solid gray;padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
            m_ResponseWriter.Append("<TD width=20% style=""padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
            'Jan

            Select Case StartMonth
                Case 1
                    Call DrawJan(Year)
                Case 2
                    Call DrawFeb(Year)
                Case 3
                    Call DrawMar(Year)
                Case 4
                    Call DrawApr(Year)
                Case 5
                    Call DrawMay(Year)
                Case 6
                    Call DrawJun(Year)
                Case 7
                    Call DrawJul(Year)
                Case 8
                    Call DrawAug(Year)
                Case 9
                    Call DrawSep(Year)
                Case 10
                    Call DrawOct(Year)
                Case 11
                    Call DrawNov(Year)
                Case 12
                    Call drawDec(Year)
            End Select
            'jMonCounter += 1
            m_ResponseWriter.Append("</TD>" + vbCrLf)

            If StartMonth = 12 Then
                Year = Year + 1
                StartMonth = 1
            Else
                StartMonth = StartMonth + 1
            End If
            Iterator += 1

        End While 'End of Month while Loop
    End Sub

    Private Sub DrawJan(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        'If m_arrStartDt.Count = 1 Then
        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 1, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                    'm_ResponseWriter.Append("<TD class='clsTDBlank' " + stringToBeInsterted + " Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|" + dtForToolTip.Month.ToString + "|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + " ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 1, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And HR_PipelineGraphicalView.blnOnBench = False)) Then
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt) OrElse (HR_PipelineGraphicalView.blnOnBench = True And dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt)) Then
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If
                ' If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                ' Else
                ' m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                ' End If
            Next
        End If
        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawFeb(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        'm_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)
        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To DateTime.DaysInMonth(Year, 2)
                dtForToolTip = New Date(Year, 2, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + " ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To DateTime.DaysInMonth(Year, 2)
                dtForToolTip = New Date(Year, 2, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If


                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                ' m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                ' End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawMar(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        'm_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)
        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 3, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then

                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 3, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                ' If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                'm_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawApr(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)
        'm_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)
        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 4, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 4, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                ' m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                ' End If
            Next
        End If


        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawMay(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 5, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 5, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawJun(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 6, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 6, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        '    Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawJul(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 7, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 7, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        '    Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawAug(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 8, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 8, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        '    Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawSep(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 9, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 9, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        '    Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawOct(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 10, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank'  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 10, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawNov(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 11, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 11, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If


                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub drawDec(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime


        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 12, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)
                'If cntDay >= MonthStartDay And cntDay <= MonthEndDay Then
                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "  ></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=5px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 12, cntDay)
                strForToolTip = "[" + WeekdayName(Weekday(dtForToolTip), True) + "] " + CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        'Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                'If Color = m_PlottingPeriod_AvailabilityPeriod_Color Then
                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=5px bgcolor=" + Color + "></TD>" + vbCrLf)
                'Else
                '    m_ResponseWriter.Append("<TD class='clsGanttChart' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' ></TD>" + vbCrLf)
                'End If
            Next

        End If
        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub

End Class