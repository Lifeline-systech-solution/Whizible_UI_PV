Public Class WBS_GanttChartView
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
    Protected m_intDeliverableCount As Integer = 0
    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0
    Private strIsTaskClosed As String = ""
    Private arrIsTaskClosed() As String
    Protected Const PROJECT_SETTING_NORMAL As String = "Normal"
    Protected Const PROJECT_SETTING_ACTIVITY As String = "Activity"
    Protected Const PROJECT_SETTING_EFFORT_DISTRIBUTION As String = "Effort_Distribution"

    Protected arrTaskType() As String = {"", ""}

    'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
    Protected arrUserStory() As String = {"", ""}
    Protected m_intFlag As String = "0"
    'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)

    Protected m_dblOUWorkingHrs As Double = 0.0
    'Added By VijayD On 26 August
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0, m_strBaselineMessage As String = ""
    'End Addition By VijayD On 26 August
    Protected m_dblProjectTaskTotal As Double = 0.0
    Protected m_strDelivName As String = ""
    Protected m_blnIsWorkflow As Boolean = False

#End Region
#Region "CONSTANTS"

    Protected Const PAGE_SIZE As Integer = 15
    Private Const TASKFILTER_ASSIGNED As String = "Assigned"
    Private Const TASKFILTER_DEFFERED As String = "Deffered"
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub PageInit()
        Initialize_Variables()

        DrawHiddenFields()

        If m_strMode.ToUpper = "SAVE" Then
            PerformAction()
        End If

        GetDatabasValues()

        If m_strTagID <> CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            DrawHeader()
        End If

        DrawMenu()

        If m_strTagID <> CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            DrawNextPeriod()
        End If


        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            DrawTaskAttributes()
            WritePage()
        Else
            WriteWBSPage()
        End If



        DisposeNotUsedObjects()


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
        sbHTML.Append("<Img Border=0 id='imgAssig' alt='Task Assignment' src='../../Images/plus.gif' style='cursor:hand;' onclick='HideShowAssignment()' />&nbsp;Task Assignment")
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
        'Added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)
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
        'End of added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)

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
                'Added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)
            Case "HRUS"
                ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                '' sSQL = "SELECT UserStoryID,UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ProjectID =" & m_GlobalObject.ProjectID.ToString() & " AND ReleaseID IS NOT NULL AND (IsUserStoryComplete = 0 or  IsUserStoryComplete is null)"
                sSQL = "usp_sel_tbl_PM_ScrumUserStory_UserStoryID " & m_GlobalObject.ProjectID.ToString()
                ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                'sSQL = "EXEC Usp_Sel_Scrum_UserStories 'cboUserStory'," & m_GlobalObject.ProjectID.ToString()
                sbHTML.Append("Assign User Story: ")
                strToolTip = "Assign User Story"
                divHeight = "height:250px;"
                lngTxtBoxWidth = 120
                strDefaultValue = arrUserStory(1)
                'End of added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)
            Case "HRVIEW"
                Select Case m_strTagID
                    Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                        sSQL = "usp_Sel_tbl_UI_Views_ForGanttChart 2133," + m_GlobalObject.UserID.ToString
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
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox(HREFID, HREFID, , lngTxtBoxWidth, , strDefaultValue, , "cursor:hand;", , True, , , "onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'", True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox(HREFID, HREFID, , lngTxtBoxWidth, , strDefaultValue, , "cursor:hand;", , True, , , "onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'", True, EnableHTMLEncode:=True))
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
                    'Added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)
                Case "HRUS"
                    sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserStoryName")), String)
                    sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserStoryID")), String)
                    'End of added by NitinC on 05 April 2012 For WhizibleSEM 11.0 (Issue Fix : 61089)
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
    Protected Sub WriteDefferedTaskGrid()
        '=====================================================================
        ' Function  Name		:	WriteDefferedTaskGrid()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw deffered task grid. 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder

        sbHTML.Append("<script>")
        sbHTML.Append("var arrVertRight = new Array();")
        sbHTML.Append("var arrVertLeft = new Array();")
        sbHTML.Append("</script>")

        sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
        sbHTML.Append("<table id='tblDefTask' cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
        sbHTML.Append("<tr class='clsTRBlank' valign='left'><b>")
        sbHTML.Append("<td align='left'   class='clsTDBlankNEW'>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='left'   class='clsTDBlankNEW'>")
        sbHTML.Append("Task Name")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right'  class='clsTDBlankNEW' style='text-align:right;'>")
        sbHTML.Append("Work (Hrs)")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='left'  class='clsTDBlankNEW'>")
        sbHTML.Append("Start Date")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='left'  class='clsTDBlankNEW'>")
        sbHTML.Append("End Date")
        sbHTML.Append("</td>")
        sbHTML.Append("</b></tr>")
        For Each drRow As DataRow In dsTask.Tables(0).Rows
            sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
            sbHTML.Append("<td align='center'   class='clsTDBlank'>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskID")), String), , , True))
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='left'   class='clsTDBlank'>")
            sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskName")), String))
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='right'   class='clsTDBlank'>")
            sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), String))
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='left'   class='clsTDBlank'>")
            sbHTML.Append(CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)))
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='left'   class='clsTDBlank'>")
            sbHTML.Append(CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), Date)))
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        Next
        sbHTML.Append("</table>")
        sbHTML.Append("<div>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Protected Sub DrawNextPeriod()
        '=====================================================================
        ' Function  Name		:	DrawNextPeriod()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw next period controls. 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder("")

        sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
        sbHTML.Append("<TR class='clsTRBlank'>")

        sbHTML.Append(GetPagingString())

        'sbHTML.Append("<TD class='clsTDBlankNew' valign='Top' align='right'>")
        'sbHTML.Append("<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous Months' src='../../Images/Home/ScrollLeft.gif' /></a>")
        'sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHTML.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'><Img Border=0 alt='Next Months' src='../../Images/Home/ScrollRight.gif' /></a>")
        'sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")
        sbHTML.Append("</br>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Protected Function GetPagingString() As String
        strPaging = New StringBuilder


        strPaging.Append("<TD align='right' valign='bottom' class='clsTDBlankNew' >")

        If m_intRowCount > 0 Then



            dblRatio = m_intRowCount / PAGE_SIZE

            If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
                m_intPageNumber = 1
            End If

            strPaging.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

            If m_intPageNumber = -1 Or dblRatio = 0 Then
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                '    strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True))
                'Else
                '    strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True))
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
                ''END O F Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            End If

            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
            '''strPaging.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intIssueCountForAppliedQuery / 20)).ToString + ">"))



            strPaging.Append(" of " + Math.Ceiling(dblRatio).ToString)
            'strPaging.Append("|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '' strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True))
            strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))

            strPaging.Append("&nbsp;|&nbsp;")
        End If

        Dim strPeriodToolTip As String = "Days"
        If m_strGanttView = "1" Then
            strPeriodToolTip = "Months"
        ElseIf m_strGanttView = "2" Then
            strPeriodToolTip = "Weeks"
        End If

        'strPaging.Append("<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous " + strPeriodToolTip + "' src='../../Images/Home/ScrollLeft.gif' /></a>")
        strPaging.Append("<a href='javascript:NextOrPrevPeriod(""PREV"")' style='color:blue;'>Previous " + strPeriodToolTip + "</a>")
        strPaging.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
        'strPaging.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'><Img Border=0 alt='Next " + strPeriodToolTip + "' src='../../Images/Home/ScrollRight.gif' /></a>")
        strPaging.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='color:blue;'>Next " + strPeriodToolTip + "</a>")
        strPaging.Append("</td>")

        Return strPaging.ToString

        strPaging = Nothing
    End Function
    Protected Sub DrawHeader()
        '=====================================================================
        ' Function  Name		:	DrawHeader()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw page header
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================

        Dim sBHTML As New StringBuilder

        Select Case m_strTagID
            Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
                m_strPageCaption = " Deliverable Tasks"
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString
                m_strPageCaption = "Milestones"
            Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString
                m_strPageCaption = "Sub Projects"
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                m_strPageCaption = "Deliverable"
            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                m_strPageCaption = "Resources"
            Case CommonFunction.Constants.APP_TAG_MODULES.ToString
                m_strPageCaption = "Modules"
        End Select

        sBHTML.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        sBHTML.Append(" <TR class=clsTRPageCaption>")
        sBHTML.Append("<TD align=Left>")
        sBHTML.Append(m_strPageCaption)
        sBHTML.Append("</td>")

        sBHTML.Append("<TD style='align:center;text-align:center;'>")
        sBHTML.Append("Period : " + CommonFunction.Dates.CGetDate(GantView_StartDt) + " - " + CommonFunction.Dates.CGetDate(GantView_EndDt))
        sBHTML.Append("</td>")

        'sBHTML.Append(GetPagingString())
        sBHTML.Append("</tr>")
        sBHTML.Append("</table>")
        '' sBHTML.Append("</br>")
        Response.Write(sBHTML.ToString)


        sBHTML = Nothing
    End Sub
    Protected Sub DrawMenu()
        '=====================================================================
        ' Function  Name		:	DrawMenu()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw Menu
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 05th, 2009
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder("")
        Dim strImgSrc As String = "../../Images/plus.gif"
        Dim strDisplayStatus As String = "none"

        If m_strEmployeeID <> "" Or m_strTaskName <> "" Or m_strFilterID <> "0" Then
            strImgSrc = "../../Images/minus.gif"
            strDisplayStatus = "''"
        End If

        'm_strSQL = "SELECT 1,'Monthly Gantt Chart' UNION SELECT 2,'Weekly Gantt Chart' ORDER BY 2 DESC"

        sbHTML.Append("<table cellpadding=0 cellspacing=0 class='clsTable' width=100% >")

        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
            sbHTML.Append("<td align='left' valign='middle' class='clsTDBlankNEW' >")
            sbHTML.Append("<Img Border=0 id='imgFilter' alt='Filters' src='" + strImgSrc + "' style='cursor:hand;' onclick='HideShowFilter()' />&nbsp;Filters")
            sbHTML.Append("</td>")

            ''''''''''''''''''''''PrashantSJ 27th July 2009'''''''''''''''''''''''''''''''''''''''''
            sbHTML.Append("<td align='center' class='clsTDBlankNew'>")
            sbHTML.Append("View:&nbsp;")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("txtGanttView", "usp_Sel_HomeThemes " + m_strTagID + "," + m_GlobalObject.UserID.ToString, "150", m_strGanttView, "onchange=javascript:Period_OnChange(this)", , True))
            sbHTML.Append("</td>")
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

            sbHTML.Append("<TD style='align:right;text-align:right;' class='clsTDBlankNEW' colspan='3'>")
            sbHTML.Append("<b>Deliverable Tasks<b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        Else
            strDisplayStatus = "''"
        End If


        sbHTML.Append("<tr id='trFilter' class='clsTRBlank' style='display:" + strDisplayStatus + ";'>")

        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            sbHTML.Append("<td align='left' class='clsTDBlankNew'>")
            ' sbHTML.Append("<a id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'>Views&nbsp;<Img Border=0 src='../../Images/Home/Views.gif' /></a>")
            sbHTML.Append("Filter&nbsp;<Img id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'  Border=0 src='../../Images/cssImages/Link images/Filter.gif' />")

            DrawAttributePopUP(sbHTML, "hrView", "divView")
            sbHTML.Append("</td>")


            sbHTML.Append("<TD valign='Top' align='left' class='clsTDBlankNew'>")
            sbHTML.Append("Show Task For Resource ")


            m_strSQL = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_GlobalObject.ProjectID.ToString
            '            m_strSQL += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
            m_strSQL += " ,Null , 1"

            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", m_strSQL, 150, m_strEmployeeID.ToString(), "onchange=FilterTasks()", True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign='Top' align='left' class='clsTDBlankNew'>")

            sbHTML.Append("Deliverable ")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtDeliName", "txtDeliName", , 100, , m_strDelivName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtDeliName", "txtDeliName", , 100, , m_strDelivName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True, EnableHTMLEncode:=True))

            sbHTML.Append("&nbsp;Task Name ")
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 100, , m_strTaskName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 100, , m_strTaskName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True, EnableHTMLEncode:=True))
            sbHTML.Append("</TD>")
        Else

            sbHTML.Append("<td align='left' class='clsTDBlankNew'>")
            If m_strTagID <> CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                sbHTML.Append("Filter&nbsp;<Img id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'  Border=0 src='../../Images/cssImages/Link images/Filter.gif' />")

                DrawAttributePopUP(sbHTML, "hrView", "divView")
            Else
                sbHTML.Append("Show Active Resources ")
                m_strSQL = "SELECT 1,'Yes' UNION SELECT 0,'No' "
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboActiveResource", m_strSQL, 50, m_strIsActiveResource, "onchange=FilterTasks()", True, True))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
            If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Or m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString Or m_strTagID = CommonFunction.Constants.APP_TAG_MODULES.ToString Then
                sbHTML.Append("Is Closed ")
                m_strSQL = "SELECT 1,'Yes' UNION SELECT 0,'No' "
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboClosed", m_strSQL, 50, m_strIsClosed, "onchange=FilterTasks()", True, True))
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
                sbHTML.Append("Deliverable Type ")
                m_strSQL = "usp_Sel_DeliverableTypes " & m_GlobalObject.ProjectID.ToString
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", m_strSQL, 200, m_strDeliverableTypeId, "onchange=FilterTasks()", True, True))
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                sbHTML.Append("Role ")
                m_strSQL = "usp_Sel_tbl_PM_Role_PopulateCombo "
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", m_strSQL, 200, m_strRoleID, "onchange=FilterTasks()", True, True))
            End If

            sbHTML.Append("</TD>")

            sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
            If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Then
                sbHTML.Append("Milestone ")
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString Then
                sbHTML.Append("Sub Project ")
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
                sbHTML.Append("Deliverable ")
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                sbHTML.Append("Employee Name ")
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_MODULES.ToString Then
                sbHTML.Append("Module Name ")
            End If
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '' sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEntityName", "txtEntityName", , 150, , m_strEntityName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEntityName", "txtEntityName", , 150, , m_strEntityName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True, EnableHTMLEncode:=True))
            sbHTML.Append("</TD>")
        End If

        sbHTML.Append("<td align='right' class='clsTDBlankNew'>")



        If m_objAccessRights.Edit And m_strTagID <> CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            sbHTML.Append("<input type=button id='btnApply'  value='Save' onclick='javascript:Save_OnClick()'/>")
        End If

        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</br>")
        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Private Sub GetValuesToValidateLCE(ByVal m_lTaskId As Long)
        '====================================================================
        ' Procedure Name       : ValidateLCE
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure validates the LCE using some configuration information.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 10, 2004
        ' Revisions            : 
        '=====================================================================
        Dim drLCE As IDataReader
        Dim strQuery As String = ""
        Dim blnAllowLCEDistribution As Boolean = False
        Dim strMsg As String = ""

        m_lngTaskId = m_lTaskId

        If blnAllowLCEDistribution = True Then
            strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_GlobalObject.ProjectID.ToString()
            strQuery &= ", " ' & strDepartment
        Else
            strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_GlobalObject.ProjectID.ToString() & ", NULL"
        End If
        If m_lngTaskId > 0 Then
            strQuery &= ", " & m_lngTaskId.ToString()
        Else
            strQuery &= ", NULL"
        End If
        drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
            If drLCE.Read() Then
                m_dblTotalAllocatedTaskLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("AllocatedLCETotal"), "0"), Double)
                m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCETotal"), "0"), Double)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drLCE)

    End Sub
    Protected Sub WriteWBSPage()
        '=====================================================================
        ' Function  Name		:	WriteWBSPage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the other WBS entity Gantt
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 24, 2009
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder("")

        Dim objGanttChart_Month As clsGanttChart_Duration
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

        'Record_StartDt = DateAdd(DateInterval.Day, 10, Date.Now)
        'Record_EndDt = DateAdd(DateInterval.Day, 20, Date.Now)
        RB_validateDT = GantView_EndDt

        sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
        sbHTML.Append("<table id='tblGanttTask' cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
        sbHTML.Append("<tr class='clsTRBlank' valign='left'>")

        sbHTML.Append("<td align='left' width=30%  class='clsTDBlankNEW'>")
        If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Then
            sbHTML.Append("Milestone ")
        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString Then
            sbHTML.Append("Sub Project ")
        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
            sbHTML.Append("Deliverable ")
        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
            sbHTML.Append("Resources ")
        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_MODULES.ToString Then
            sbHTML.Append("Modules ")
        End If
        sbHTML.Append("</td>")

        drawMonthNameHeadings(sbHTML)
        sbHTML.Append("</tr>")


        For Each drRow As DataRow In dsTask.Tables(0).Rows
            Select Case m_strTagID
                Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString
                    strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("MilestoneID")), String)

                    Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("PlannedCompletionDate")), Date)
                    Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualCompletionDate")), Date)
                    strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("MileStone")), String)

                Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString
                    strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("SubProjectID")), String)
                    Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedStartDate")), Date)
                    If CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), String) <> "" Then
                        Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), Date)
                    Else
                        Record_EndDt = Record_StartDt
                    End If
                    strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("SubProjectName")), String)
                Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                    strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleID")), String)
                    Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)

                    If CType(CommonFunction.Data.CheckIsDBNull(drRow("EarliestStartDate")), String) <> "" Then
                        Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EarliestStartDate")), Date)
                    Else
                        Record_EndDt = Record_StartDt
                    End If

                    strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("Title")), String)
                Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                    strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectEmployeeRoleID")), String)

                    Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ExpectedStartDate")), Date)
                    Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ExpectedEndDate")), Date)
                    strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName")), String)
                Case CommonFunction.Constants.APP_TAG_MODULES.ToString
                    strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ModuleID")), String)
                    Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedStartDate")), Date)
                    If CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), String) <> "" Then
                        Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), Date)
                    Else
                        Record_EndDt = Record_StartDt
                    End If
                    strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("ModuleName")), String)
            End Select

            sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=showToolTip(this,event) onmouseout=hideToolTip(this,event) >")
            vertIndex += 1

            m_strToken = CommonFunctions.Security.Token.GetToken(strRecPKID + m_GlobalObject.UserID.ToString + "0" + m_strTagID)

            sbHTML.Append("<td align='left' width=30% id='Task' class='clsTDBlank' >")
            sbHTML.Append("<A href='JavaScript:ShowEntityEditMode(" & strRecPKID & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """)'>")
            sbHTML.Append(strEntityame.Replace("'", "&#39;"))
            sbHTML.Append("</A>")
            sbHTML.Append("</td>")


            strMonthStartIDs = ""
            strMonthEndIDs = ""

            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
            objGanttChart_Month = New clsGanttChart_Duration(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, sbHTML, m_strGanttView, dsWeekHead)
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



        Next
        sbHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")

        If dsTask.Tables(0).Rows.Count = 0 Then
            sbHTML.Append("<tr class='clsTRBlank' valign='middle'>")
            sbHTML.Append("<td align='center' colspan='20'  class='clsTDBlank'>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        End If

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")


        arrRightVerticals = arrRVerticals.Split(","c)
        arrLeftVerticals = arrLVerticals.Split(","c)
        arrVertLeftLB = strVertLeftLBs.Split(","c)
        arrVertRightRB = strVertRightRBs.Split(","c)


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

        'CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
        'CommonFunction.General.WriteHTML("var GantViewEndDay=" + DateTime.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month).ToString + ";")
        'CommonFunction.General.WriteHTML("var GantViewStartDay=1;")
        'CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")
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
            CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' onmousedown=""clickDownVert(event)""></div>")
            CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' onmousedown=""clickDownVert(event)""></div>")
        Next

        sbHTML = Nothing

    End Sub
    Protected Sub DrawAddTaskMenu()
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
        sbHTML = New StringBuilder("")

        sbHTML.Append("<table  cellpadding=0 cellspacing=0 class='clsTable' width=100% >")
        sbHTML.Append("<Tr class=clsTRBlank id=""TRAdd"" >" + vbCrLf)
        'sbHTML.Append("<td ALIGN='left' class='clsTDBlankNew' >" + vbCrLf) ''colspan='20'
        'If m_objAccessRights.Add And DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then
        '    sbHTML.Append("<A href=""Javascript:CreateRowForTasks()""" + vbCrLf)
        '    sbHTML.Append(" style='color:blue;' ><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Create Task'>Create New Task</A>" + vbCrLf)
        'End If
        'sbHTML.Append("</td>" + vbCrLf)
        sbHTML.Append("<td align='left' class='clsTDBlankNew'>")



        If m_objAccessRights.Add Then
            sbHTML.Append("<input type=button id='btnAddDEL'  value='Add Deliverable' onclick='javascript:Add_OnClick()'/>&nbsp;")
        End If

        'GetTagAccessRights(CommonFunction.Constants.APP_TAG_ASSIGNED_TASK)

        If m_objAccessRights.Edit Then
            sbHTML.Append("<input type=button id='btnApply'  value='Save' onclick='javascript:Save_OnClick()'/>")
        End If

        sbHTML.Append("</td>")

        sbHTML.Append("<td align='right' class='clsTDBlankNew'>")
        sbHTML.Append("Total Tasks : <label id='taskTotal'>" + m_intRowCount.ToString + "</lable>")
        sbHTML.Append("</td>")
        sbHTML.Append(GetPagingString())
        'sbHTML.Append("<td ALIGN='center' colspan='20' class='clsTDBlank'> </td>" + vbCrLf)
        sbHTML.Append("</tr>" + vbCrLf)
        sbHTML.Append("</table>")
        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
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


        Dim objGanttChart_Month As clsGanttChart_Duration
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

        ''Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 
        Dim HourMinWorkHrs As String = ""
        ''End of Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

        Dim strParentTaskID As String = ""
        Dim strEmployeeName As String = ""
        Dim iGroupCount As Integer = 0
        Dim tempTaskID As String = ""
        Dim ExpectedStartDate As String
        Dim ExpectedEndDate As String
        Dim EmployeeID As String
        Dim blnIsDeliverable As Boolean
        Dim strTDClassName As String = "clsTDBlank"
        Dim strColspan As String = ""
        Dim strScheduleID As String = ""
        Dim strTRID As String = ""
        Dim strDisplay As String = ""
        Dim strDeliverableIDs As String = ""
        Dim arrDeliverableIDs() As String
        Dim strFunctionScript As String = ""
        Dim sbScript As New StringBuilder("")
        Dim strISDeliverable As String = ""
        Dim arrIsDeliverable() As String

        'Added by GokulP on 11 Nov 2009 for Work Hrs Column 
        Dim strActualWorkHours As String = "0"
        'End of Addition by GokulP on 11 Nov 2009 for Work Hrs Column 

        'Record_StartDt = DateAdd(DateInterval.Day, 10, Date.Now)
        'Record_EndDt = DateAdd(DateInterval.Day, 20, Date.Now)
        RB_validateDT = GantView_EndDt

        sbScript.Append("<script language='javascript'>")
        sbScript.Append("var arrScheduleID = new Array();")

        DrawAddTaskMenu()

        sbHTML = New StringBuilder("")

        sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
        sbHTML.Append("<table id='tblGanttTask' cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
        sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
        sbHTML.Append("<td align='left' width=2%  class='clsTDBlankNEW'>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='left' width=28%  class='clsTDBlankNEW'>")

        sbHTML.Append("Deliverable / Task Name")

        sbHTML.Append("</td>")

        'Added by GokulP on 11 Nov 2009 for Resource Column 
        sbHTML.Append("<td align='left' width=20%  class='clsTDBlankNEW'>")
        sbHTML.Append("Resource")
        sbHTML.Append("</td>")
        'End of Addition by GokulP on 11 Nov 2009 for Resource Column 

        sbHTML.Append("<td align='right' width=10%  class='clsTDBlankNEW' style='text-align:right;'>")
        sbHTML.Append("Actual/Planned Work (Hrs)")
        sbHTML.Append("</td>")
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

            If strScheduleID <> "" And (strScheduleID <> CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleID")), String)) Then
                If DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 And GetTABAccessRights(CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_TASKS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE) Then
                    sbHTML.Append("<Tr class=clsTRBlank id='TRAdd_" + strScheduleID + "' >" + vbCrLf)

                    sbHTML.Append("<td ALIGN='left' class='clsTDBlank' >" + vbCrLf) ''colspan='20'

                    sbHTML.Append("<A href='Javascript:CreateRowForTasks(" + strScheduleID + ")'" + vbCrLf)
                    sbHTML.Append(" style='color:blue;' ><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Create Task'></A>" + vbCrLf)

                    sbHTML.Append("</td>" + vbCrLf)
                    sbHTML.Append("<td ALIGN='left' class='clsTDBlank' colspan='20' ></td>" + vbCrLf)

                    sbHTML.Append("</tr>" + vbCrLf)
                End If

                sbScript.Append("arrScheduleID.push(" + strScheduleID + ");")

            End If

            strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskID")), String)
            blnIsDeliverable = CType(CommonFunction.Data.CheckIsDBNull(drRow("IsDeliverable"), "0"), Boolean)
            Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)
            Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), Date)
            strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskName")), String)
            WorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), Double)

            ''Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

            HourMinWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drRow("Work (H:M)")), String)

            ''End of Added By Usha Pandit on 22-Feb-2019 Purpose::Project Work field level changes 

            strParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ParentTask_UID")), String)
            'ShraddhaM
            EmployeeID = CommonFunction.Data.CheckIsDBNull(drRow("EmployeeID"), "-").ToString()
            strScheduleID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleID")), String)

            m_blnIsTaskComplete = CType(CommonFunction.Data.CheckIsDBNull(drRow("IsTaskComplete"), "0"), Boolean)
            strIsTaskClosed = strIsTaskClosed + CType(CommonFunction.Data.CheckIsDBNull(drRow("IsTaskComplete"), "0"), String) + ","

            strISDeliverable += blnIsDeliverable.ToString + ","

            'Added by GokulP on 10 Nov 2009 to show Actual Work Hrs 
            strActualWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualWork")), String)
            'End of Addition by GokulP on 10 Nov 2009 to show Actual Work Hrs 

            If EmployeeID <> "-" Then
                If Not IsDBNull(drRow("ExpectedStartDate")) Then
                    ExpectedStartDate = CType(drRow("ExpectedStartDate"), Date).ToString("dd-MMM-yyyy")
                End If
                If Not IsDBNull(drRow("ExpectedEndDate")) Then
                    ExpectedEndDate = CType(drRow("ExpectedEndDate"), Date).ToString("dd-MMM-yyyy")
                End If
            End If


            'Ended by ShraddhaM

            m_dblTotalAllocatedTaskLCE = CType(CommonFunction.Data.CheckIsDBNull(drRow("TotalAllocatedLCE"), "0"), Double)
            'Commented and Modified by AmitJ on 331-Mar-2010 for Hotfix 9.0.008
            'Purpose:Planned Work hrs become 0 when click on save button.
            'Rootcause:txtOrgWork object is not found in save_onclick event.Hence validation fails.
            'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrgWork" + strRecPKID, "txtOrgWork" + strRecPKID, , 50, , m_dblTotalAllocatedTaskLCE.ToString, "right", , , , , True, , True, ))
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrgWork" + strRecPKID, "txtOrgWork", , 50, , m_dblTotalAllocatedTaskLCE.ToString, "right", , , , , True, , True, ))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrgWork" + strRecPKID, "txtOrgWork", , 50, , m_dblTotalAllocatedTaskLCE.ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            'End of Modificaitons.
            ' If strParentTaskID <> "" Then
            '''''''''PrashantSJ 2nd June 2009
            'If strEmployeeName <> CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName")), String) Then
            '    sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
            '    sbHTML.Append("<td align='left'  class='clsTDBlank' colspan='20'><b>")
            '    sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName")), String))
            '    sbHTML.Append("</b></td>")
            '    sbHTML.Append("</tr>")
            '    iGroupCount += 1
            'End If
            '''''''''PrashantSJ 2nd June 2009
            strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName")), String)
            ' End If
            If blnIsDeliverable Then
                ' strColspan = "colspan='2'"
                strTRID = "trDel_" + strScheduleID
                strDisplay = ""
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                ''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtIsDeliverable" + strRecPKID, "txtIsDeliverable" + strRecPKID, , 50, , blnIsDeliverable, "right", , , , , True, , True, ))
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtIsDeliverable" + strRecPKID, "txtIsDeliverable" + strRecPKID, , 50, , blnIsDeliverable, "right", , , , , True, , True, , EnableHTMLEncode:=True))

                m_strToken = CommonFunctions.Security.Token.GetToken(strScheduleID + m_GlobalObject.UserID.ToString + "0" + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString)
                strFunctionScript = "onmouseover='SetRolledOverTD(this,""divMNPopup"")' onclick='JavaScript:ShowContextMenu(" & strScheduleID & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """,event)' style='cursor:hand;' "
                m_intDeliverableCount += 1
            Else
                strColspan = ""
                strTRID = "trDelTask_" + strScheduleID
                ''strDisplay = "style='display:none;'"
                strDisplay = ""
                strFunctionScript = ""
            End If

            sbHTML.Append("<TR id='" + strTRID + "' name='" + strTRID + "' vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=showToolTip(this,event) onmouseout=hideToolTip(this,event) " + strDisplay + ">")
            vertIndex += 1
            sbHTML.Append("<td align='left' width=2%  class='clsTDBlank'>")
            If strParentTaskID = "" And Not blnIsDeliverable And GetTABAccessRights(CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_TASKS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE) Then
                sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , strRecPKID, , "onclick=SelectOnClick(this)", True))
            ElseIf blnIsDeliverable Then
                sbHTML.Append("<Img Border=0 id='imgDel_" + strScheduleID + "' alt='Show Task List' src='../../images/minus.gif' style='cursor:hand;' onclick='javascript:ShowHideDelivTasks(" + strScheduleID + ",0)' />")
            End If
            sbHTML.Append("</td>")

            If IsCase3Project Then
                If strParentTaskID <> "" Then
                    tempTaskID = strParentTaskID
                Else
                    tempTaskID = strRecPKID
                End If
            Else
                tempTaskID = strRecPKID
            End If





            sbHTML.Append("<td align='left' width=28% id='Task" + strRecPKID + "' class='" + strTDClassName + "' EmployeeID='" + EmployeeID + "' ResourceStartDate='" + ExpectedStartDate + "' ResourceEndDate='" + ExpectedEndDate + "' " + strColspan + " " + strFunctionScript + ">")

            If Not blnIsDeliverable Then
                If IsCaseOneProject And strParentTaskID = "" Then
                    sbHTML.Append(strEntityame.Replace("'", "&#39;"))
                Else
                    m_strToken = CommonFunctions.Security.Token.GetToken(tempTaskID + m_GlobalObject.UserID.ToString + "0" + CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString)

                    sbHTML.Append("<A href='JavaScript:ShowEntityEditMode(" & tempTaskID & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """)'>")
                    sbHTML.Append(strEntityame.Replace("'", "&#39;"))
                    sbHTML.Append("</A>")
                End If
            Else

                sbHTML.Append("<A onclick='JavaScript:ShowContextMenu(" & strScheduleID & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """,event)' style='cursor:hand;text-decoration:underline;'>")
                sbHTML.Append(strEntityame.Replace("'", "&#39;"))
                sbHTML.Append("</A>")
            End If

            sbHTML.Append("</td>")

            'Added by GokulP on 11 Nov 2009 for Resource Column 
            sbHTML.Append("<td align='left' id='strEmployeeName" + strRecPKID + "' class='clsTDBlank' EmployeeID='" + EmployeeID + "' ResourceStartDate='" + ExpectedStartDate + "' ResourceEndDate='" + ExpectedEndDate + "' >")
            sbHTML.Append(strEmployeeName.Replace("'", "&#39;"))
            sbHTML.Append("</td>")
            'End of Addition by GokulP on 11 Nov 2009 for Resource Column 

            sbHTML.Append("<td align='right' width=10% class='clsTDBlank'>")
            If Not blnIsDeliverable Then
                'ShraddhaM
                If m_blnIsTaskComplete = True Then
                    If strParentTaskID = "" Then
                        'Added by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        sbHTML.Append(strActualWorkHours.ToString + " / ")
                        'End of Addition by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                        '' sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , True, , , , "onblur=txtWork_OnBlur(this," + strRecPKID + ",0)", True, True))
                        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , True, , , , "onblur=txtWork_OnBlur(this," + strRecPKID + ",0)", True, True, EnableHTMLEncode:=True))
                    Else
                        'Added by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        sbHTML.Append(strActualWorkHours.ToString + " / ")
                        'End of Addition by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , True, , , , "onblur=txtWork_OnBlur(this," + strRecPKID + "," + strParentTaskID + ")", True, True, EnableHTMLEncode:=True))
                    End If
                Else
                    If strParentTaskID = "" Then
                        'Added by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        sbHTML.Append(strActualWorkHours.ToString + " / ")
                        'End of Addition by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , , , , , "onblur=txtWork_OnBlur(this," + strRecPKID + ",0)", True, True, EnableHTMLEncode:=True))
                    Else
                        'Added by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        sbHTML.Append(strActualWorkHours.ToString + " / ")
                        'End of Addition by GokulP on 11 Nov 2009 to show Actual Work Hrs 
                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , , , , , "onblur=txtWork_OnBlur(this," + strRecPKID + "," + strParentTaskID + ")", True, True, EnableHTMLEncode:=True))
                    End If
                End If
            Else
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strScheduleID, "txtWork" + strScheduleID, , 50, , WorkHrs.ToString, "right", , , m_blnIsWorkflow, , , "onblur=txtDELWork_OnBlur(this," + strScheduleID + ",0)", True, True, EnableHTMLEncode:=True))

                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidDelSD" + strRecPKID, "txtHidDelSD" + strRecPKID, , 50, , CommonFunction.Dates.GetDate(CType(Record_StartDt, Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidDelED" + strRecPKID, "txtHidDelED" + strRecPKID, , 50, , CommonFunction.Dates.GetDate(CType(Record_EndDt, Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActualWork" + strRecPKID, "txtActualWork" + strRecPKID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualWork")), String), "right", , , , , True, , True, , EnableHTMLEncode:=True))


            If Not IsCaseOneProject And strParentTaskID <> "" Then

                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidChildTaskWork" + strRecPKID, "hidChildTaskWork" + strRecPKID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), String), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskID" + strRecPKID, "hidParentTaskID" + strRecPKID, , , , strParentTaskID, "right", , , , , True, , True, , EnableHTMLEncode:=True))
            End If
            'm_strScript.Append("arrTaskID.push(" + strRecPKID + ");")
            strMonthStartIDs = ""
            strMonthEndIDs = ""

            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
            objGanttChart_Month = New clsGanttChart_Duration(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, sbHTML, m_strGanttView, dsWeekHead)
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

            If Not IsCaseOneProject And strParentTaskID <> "" Then

                strQuery = "usp_Sel_ParentTaskDetails_ForGanttChart " & m_GlobalObject.ProjectID.ToString & "," & strParentTaskID
                drParentTask = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

                If drParentTask.Read Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidAllChildTaskWork" + strParentTaskID, "hidAllChildTaskWork" + strRecPKID + "_" + strParentTaskID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drParentTask("TotalChildTaskWork")), String), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("Work")).ToString, "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("StartDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("EndDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskActualWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("ActualWork")).ToString, "right", , , , , True, , True, , EnableHTMLEncode:=True))
                End If
                CommonFunction.Data.DisposeDataReader(drParentTask)

            End If




        Next
        If DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 And GetTABAccessRights(CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_TASKS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE) Then
            sbHTML.Append("<Tr class=clsTRBlank id='TRAdd_" + strScheduleID + "' >" + vbCrLf)
            sbHTML.Append("<td ALIGN='left' class='clsTDBlank' >" + vbCrLf) ''colspan='20'

            sbHTML.Append("<A href='Javascript:CreateRowForTasks(" + strScheduleID + ")'" + vbCrLf)
            sbHTML.Append(" style='color:blue;' ><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Create Task'></A>" + vbCrLf)

            sbHTML.Append("</td>" + vbCrLf)
            sbHTML.Append("<td ALIGN='left' class='clsTDBlank' colspan='20' ></td>" + vbCrLf)
            sbHTML.Append("</tr>" + vbCrLf)
        End If

        sbHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")


        If DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then
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
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
        End If

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")


        arrRightVerticals = arrRVerticals.Split(","c)
        arrLeftVerticals = arrLVerticals.Split(","c)
        arrVertLeftLB = strVertLeftLBs.Split(","c)
        arrVertRightRB = strVertRightRBs.Split(","c)

        arrIsTaskClosed = strIsTaskClosed.Split(","c)

        If strISDeliverable <> "" Then
            arrIsDeliverable = strISDeliverable.Substring(0, strISDeliverable.Length - 1).Split(","c)
        End If


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
            If arrIsTaskClosed(arrCnt) = True Or (CType(arrIsDeliverable(arrCnt), Boolean) And m_blnIsWorkflow) Then
                CommonFunction.General.WriteHTML("<div  id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' ></div>")
                CommonFunction.General.WriteHTML("<div  id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' ></div>")
                'CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;' ></div>")
                'CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;' ></div>")
            Else
                CommonFunction.General.WriteHTML("<div  id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' onmousedown=""clickDownVert(event)""></div>")
                CommonFunction.General.WriteHTML("<div  id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 1px red;' onmousedown=""clickDownVert(event)""></div>")
                'CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;' onmousedown=""clickDownVert(event)""></div>")
                'CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;' onmousedown=""clickDownVert(event)""></div>")
            End If

        Next
        sbScript.Append("</script>")
        Response.Write(sbScript.ToString)

        sbHTML = Nothing
        sbScript = Nothing

    End Sub
    Private Sub drawMonthNameHeadings(ByRef objStringBuilder As System.Text.StringBuilder)

        If m_strGanttView = "1" Then

            Dim Iterator As Integer
            Dim StartYear As Integer
            Dim StartMonth As Integer
            Iterator = 1

            StartYear = GantView_StartDt.Year
            StartMonth = GantView_StartDt.Month

            While Iterator <= MonDiff

                objStringBuilder.Append("<TD id='Month" + StartMonth.ToString + "' align=center width=20% class='clsTDBlankNew'>  " + vbCrLf)
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
                dblTDWidth = 8.5 'CType(60 / (Date.DaysInMonth(dtSD.Year, dtSD.Month)), Double)
            Else
                dblTDWidth = 8.5
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
        'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_GlobalObject.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
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

        GetTagAccessRights(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE)

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
                m_strDelivName = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(Request.Form("txtDeliName")))
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
    Private Sub GetTagAccessRights(ByVal TagID As Long)
        Select Case TagID
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
        End Select

        m_objAccessRights.GetAccess(m_GlobalObject)

    End Sub
    Private Function GetTABAccessRights(ByVal lngTagID As Long, ByVal ParentTagID As Long, Optional ByVal IsModuleAccess As Boolean = True) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim objWebPages As New WebPages.Template.WhizTemplate
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights
        objWebPages.FillGlobalObject(objWebPages.CurrentThreadUICultureID)
        objGlobal = objWebPages.GlobalObject()
        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.ParentTagID = ParentTagID
        objAccessRights.TagID = lngTagID
        objAccessRights.GetAccess()

        Dim IsAccessForNode As Boolean


        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            If objAccessRights.Add = True OrElse objAccessRights.Edit = True Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function
    Private Sub GetDatabasValues()


        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then

            Dim drWork As IDataReader

            Dim strQuery As String
            Dim strTemp As String = ""

            m_strSQL = "usp_Sel_DeliverableTasks_ForGanttChart  " & m_GlobalObject.ProjectID.ToString


            If m_strEmployeeID <> "" Then
                m_strSQL &= "," & m_strEmployeeID
            Else
                m_strSQL &= ",NULL"
            End If

            m_strSQL &= ", NULL, 'ORDER BY Title,A.DeliverableID,A.StartDate,TaskName ASC', '-1',0 "
            m_strSQL &= ",'" + CommonFunction.Dates.GetDate(GantView_StartDt) + "'"
            m_strSQL &= ",'" + CommonFunction.Dates.GetDate(GantView_EndDt) + "'"

            If m_strFilterID <> "" And m_strFilterID <> "0" Then
                m_strSQL &= "," + m_strFilterID
            Else
                m_strSQL &= ",0"
            End If

            If m_strTaskName <> "" Then
                m_strSQL &= ",N'" + CommonFunction.General.BuildQueryString(m_strTaskName) + "'"
            Else
                m_strSQL &= ",NULL"
            End If

            If m_strDelivName <> "" Then
                m_strSQL &= ",N'" + CommonFunction.General.BuildQueryString(m_strDelivName) + "'"
            Else
                m_strSQL &= ",NULL"
            End If

            If m_strTaskType = TASKFILTER_DEFFERED Then
                m_strSQL &= ",1"
            Else
                m_strSQL &= ",NULL"
            End If

            'ShraddhaM

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


            strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & Session("intProjectID").ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                    m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)



            'Ended by ShraddhaM

            m_dblProjectTaskTotal = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_ProjectTasks_PlannedHrs " + Session("intProjectID").ToString(), MyBase.UseSQL), "0.0"), Double)

        Else
            If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString() Then
                m_strSQL = "usp_Sel_Home_Milestones  "
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString() Then
                m_strSQL = "usp_Sel_Home_Gantt_SubProjects  "
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString() Then
                m_strSQL = "usp_Sel_Home_Gantt_Deliverables  "
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                m_strSQL = "usp_Sel_Home_Gantt_Resources  "
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_MODULES.ToString Then
                m_strSQL = "usp_Sel_Home_Gantt_Modules  "
            End If
            m_strSQL &= " " + m_GlobalObject.ProjectID.ToString
            m_strSQL &= ",'" + CommonFunction.Dates.GetDate(GantView_StartDt) + "'"
            m_strSQL &= ",'" + CommonFunction.Dates.GetDate(GantView_EndDt) + "'"

            If m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                If m_strIsActiveResource <> "" Then
                    m_strSQL &= "," + m_strIsActiveResource
                Else
                    m_strSQL &= ",NULL"
                End If
            Else
                If m_strFilterID <> "" And m_strFilterID <> "0" Then
                    m_strSQL &= "," + m_strFilterID
                Else
                    m_strSQL &= ",0"
                End If
            End If
            If m_strEntityName <> "" Then
                m_strSQL &= ",N'" + CommonFunction.General.BuildQueryString(m_strEntityName) + "'"
            Else
                m_strSQL &= ",NULL"
            End If

            If m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString() Then
                If m_strDeliverableTypeId <> "" Then

                    m_strSQL &= "," + m_strDeliverableTypeId
                Else
                    m_strSQL &= ",NULL"
                End If
            ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
                If m_strRoleID <> "" Then
                    m_strSQL &= "," + m_strRoleID
                Else
                    m_strSQL &= ",NULL"
                End If
            Else
                If m_strIsClosed <> "" Then
                    m_strSQL &= "," + m_strIsClosed
                Else
                    m_strSQL &= ",NULL"
                End If
            End If
        End If

        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)

        m_intRowCount = dsTemp.Tables(0).Rows.Count

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)


        If m_intPageNumber = -1 Then
            dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", , , MyBase.UseSQL)
        Else
            dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        End If

        'm_strSQL = "usp_Sel_WeekNumbers_ForGanttChart '" + CommonFunction.Dates.GetDate(GantView_StartDt) + "','" + CommonFunction.Dates.GetDate(GantView_EndDt) + "'"

        'dsMonthHead = CommonFunction.Data.GetDataSet(m_strSQL, "MonthHead", , , MyBase.UseSQL)



        'm_strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_GlobalObject.ProjectID
        'drProject = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        'If drProject.Read Then
        '    m_strProjectStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProject("ExpectedStartDate")), Date))
        '    m_strProjectEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProject("ExpectedEndDate")), Date))
        'End If

        'CommonFunction.Data.DisposeDataReader(drProject)

        m_strSQL = "usp_Sel_WBS_Workflow_Applicable " + m_GlobalObject.ProjectID.ToString + "," + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString()
        m_blnIsWorkflow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(m_strSQL, MyBase.UseSQL), "0"), Boolean)


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
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidMode", "hidMode", , , , m_strMode, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTagID", "hidTagID", , , , m_strTagID, , , , , , True, , True, EnableHTMLEncode:=True))
        '' Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidPeriod", "hidPeriod", , , , m_strPeriod, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttStartDate", "hidGanttStartDate", , , , CommonFunction.Dates.GetDate(GantView_StartDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttEndDate", "hidGanttEndDate", , , , CommonFunction.Dates.GetDate(GantView_EndDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGanttView", "txtGanttView", , , , m_strGanttView, , , , , , True, , True, EnableHTMLEncode:=True))

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTTID", "hidTxtTTID", , , , CType(arrTaskType(0), String), , , , , , True, , True, EnableHTMLEncode:=True))
        ''''cboFilter_EmployeeID

        'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
        If m_intFlag = "1" Then
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtUSID", "hidTxtUSID", , , , CType(arrTaskType(0), String), , , , , , True, , True, EnableHTMLEncode:=True))
            Dim hidTxtTaskDate As String = CType(CommonFunction.Data.GetDataScalar("SELECT datename(dd,getdate())+'-'+substring(datename(mm,getdate()),1,3)+'-'+datename(yyyy,getdate())", MyBase.UseSQL), String)
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTaskDate", "hidTxtTaskDate", , , , hidTxtTaskDate, , , , , , True, , True, EnableHTMLEncode:=True))
        End If
        'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtARID", "hidTxtARID", , , , m_strEmployeeID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtAPR", "hidTxtAPR", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("cboViews", "cboViews", , , , m_strFilterID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtASTA", "hidTxtASTA", , , , , , , , , , True, , True, EnableHTMLEncode:=True))

        DrawHolidayAlert()
        DrawContextMenu()
    End Sub
    Private Sub DrawContextMenu()
        Dim sbContextMenu As New StringBuilder("")

        sbContextMenu.Append("<div id='divMNPopup' class='ContextMenu' style='display:none;cursor:pointer;' >")
        sbContextMenu.Append("<TABLE id=tblMNPopup class=clsTable cellpadding=3 cellspacing=0 style='cursor:default;' >")
        sbContextMenu.Append("<TR class='clsTRBlank' onmouseover='javascript:mouseOverPopupMenu(event)' onmousedown='javascript:mouseDownPopupMenu(""V"")'><TD class='CtMn_LeftFill'></TD><TD>&nbsp;View/Edit</TD></TR>")
        sbContextMenu.Append("<TR><TD class='CtMn_LeftFill_Hr'></TD><TD class='CtMn_Hr'></TD></TR>")
        sbContextMenu.Append("<TR class='clsTRBlank' onmouseover='javascript:mouseOverPopupMenu(event)' onmousedown='javascript:mouseDownPopupMenu(""P"")'><TD class='CtMn_LeftFill'></TD><TD>&nbsp;Plan Deliverables</TD></TR>")
        sbContextMenu.Append("</TABLE>")
        sbContextMenu.Append("</div>")

        Response.Write(sbContextMenu.ToString)
        sbContextMenu = Nothing
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
            sbHTML.Append("Deliverable / Task Name ")
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
#Region "Database functions"
    Private Sub PerformAction()
        '=====================================================================
        ' Function  Name		:	PerformAction
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To perform task save action.
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        Dim RowCnt As Integer
        Dim startDate As String
        Dim EndDate As String
        Dim UpdateQuery As String
        Dim hidPKIDs As String
        Dim arrPKIDs As String()
        Dim strSQL As String
        Dim dblWorkHrs As Double = 0.0
        Dim blnIsDELIV As Boolean = False

        hidPKIDs = CommonFunction.General.CheckIsNothing(Request.Form("hidPKID"))

        If hidPKIDs <> "" Then



            RowCnt = 0
            arrPKIDs = hidPKIDs.Split(","c)
            While RowCnt <= arrPKIDs.Length - 2
                startDate = Request.Form("L|" + arrPKIDs(RowCnt))
                EndDate = Request.Form("R|" + arrPKIDs(RowCnt))

                blnIsDELIV = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtIsDeliverable" + arrPKIDs(RowCnt)), "0"), Boolean)

                If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString And Not blnIsDELIV Then

                    dblWorkHrs = CType(Request.Form("txtWork" + arrPKIDs(RowCnt)), Double)

                    strSQL = "usp_Update_ProjectTasks_GanttChart " + arrPKIDs(RowCnt) + ",'" + startDate + "'"
                    strSQL += ",'" + EndDate + "'"
                    strSQL += "," + dblWorkHrs.ToString
                    strSQL += ",N'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "'"

                    If IsCaseOneProject Then
                        strSQL += ",1"
                    Else
                        strSQL += ",0"
                    End If
                Else
                    If CommonFunction.General.CheckIsNothing(Request.Form("txtWork" + arrPKIDs(RowCnt))) = "" Then
                        dblWorkHrs = 0.0
                    Else
                        dblWorkHrs = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtWork" + arrPKIDs(RowCnt)), "0"), Double)
                    End If

                    strSQL = "usp_Upd_WBS_Gantt_StartEndDate " & m_GlobalObject.ProjectID.ToString
                    strSQL += "," + arrPKIDs(RowCnt)
                    strSQL += ",2133"
                    strSQL += ",'" + startDate + "'"
                    strSQL += ",'" + EndDate + "'"

                    If dblWorkHrs <> 0 Then
                        strSQL += "," + dblWorkHrs.ToString
                    Else
                        strSQL += ",0.0"
                    End If

                    strSQL += ",N'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "'"
                End If

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


                RowCnt = RowCnt + 1

            End While
        End If


        If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
            Save_DefferedTasks()
            Create_ChildTasks()
        End If


    End Sub
    Private Sub Create_ChildTasks()
        '=====================================================================
        ' Function  Name		:	Create_ChildTasks
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To save and create child task for  deffered tasks
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 20 2009
        ' Revisions				:	
        '=====================================================================
        Dim strchkSelect As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "")
        Dim lngTaskID As Long = 0
        Dim strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage As String
        If strchkSelect <> "" Then
            sbSAVE = New StringBuilder("")
            Dim dblWorkHrs As Double, dtStartDate As String = "", dtEndDate As String = ""

            Dim arrchkSelect() As String = strchkSelect.Split(","c)
            Dim k As Integer = 0, lngTaskTypeID As Long, lngEmployeeID As Long, strPriority As String = ""
            Dim lngSubTaskTypeID As String = ""

            'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
            Dim lngUserStoryID As Long
            Dim lngIsUserStoryTask As Long = 1
            'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)

            lngTaskTypeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtTTID")), Long)
            lngEmployeeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtARID")), Long)
            strPriority = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtAPR")), String)
            lngSubTaskTypeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtASTA"), ""), String)

            'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
            If m_intFlag = "1" Then
                lngUserStoryID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtUSID")), Long)
            End If
            'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)

            For k = 0 To arrchkSelect.Length - 1
                dtStartDate = Request.Form("L|" + arrchkSelect(k))
                dtEndDate = Request.Form("R|" + arrchkSelect(k))
                dblWorkHrs = CType(Request.Form("txtWork" + arrchkSelect(k)), Double)

                sbSAVE.Append("usp_Upd_ParentTasks_CreateNewTask ")

                sbSAVE.Append(m_GlobalObject.ProjectID.ToString)
                sbSAVE.Append("," + arrchkSelect(k))
                sbSAVE.Append("," + lngEmployeeID.ToString)
                sbSAVE.Append("," + lngTaskTypeID.ToString)
                If IsCase3Project Then
                    sbSAVE.Append("," + lngSubTaskTypeID.ToString)
                Else
                    sbSAVE.Append(",NULL")
                End If
                sbSAVE.Append(",'" + strPriority + "'")
                sbSAVE.Append("," + FormatNumber(dblWorkHrs, 2))
                sbSAVE.Append(",'" + CommonFunction.Dates.GetDate(CType(dtStartDate, Date)) + "'")
                sbSAVE.Append(",'" + CommonFunction.Dates.GetDate(CType(dtEndDate, Date)) + "'")
                sbSAVE.Append(",'" + m_GlobalObject.UserName + "'")

                'Added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)
                If m_intFlag = "1" Then
                    sbSAVE.Append("," + lngIsUserStoryTask.ToString)
                    sbSAVE.Append("," + lngUserStoryID.ToString)
                End If
                'End of added by NitinC on 05 April 2011 for WhizibleSEM 11.0 (Issue Fix : 61089)


                lngTaskID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sbSAVE.ToString, MyBase.UseSQL), "0"), Long)

                sbSAVE.Remove(0, sbSAVE.Length)

                If m_blnSendMail = True Then
                    If m_blnShowPopup = True Then
                        Response.Write("<script language='javascript'>")
                        Response.Write("window.open(""../General/SendEmail.aspx?MessageID=20&TaskID=" + lngTaskID.ToString + "&MasterTagID=1038"", """", ""resizable=no,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                        Response.Write("</script>")
                    Else
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage, lngTaskID, m_GlobalObject.ProjectID.ToString)
                        '        'End Of addition by vivekP on 3 jun 2005
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                    End If
                End If

            Next
            sbSAVE = Nothing
        End If

    End Sub
    Private Sub Save_DefferedTasks()
        '=====================================================================
        ' Function  Name		:	Save_DefferedTasks
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To save deffered tasks
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	March 20 2009
        ' Revisions				:	
        '=====================================================================
        Dim strtxtItems As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtItems"), "")
        sbSAVE = New StringBuilder("")

        If strtxtItems <> "" Then
            Dim strTaskStartDate As String = ""
            Dim strTaskEndDate As String = ""
            Dim strTaskType As String = ""
            Dim strDeliverableID As String = ""
            Dim i As Integer = 0, strTaskName As String = ""

            'm_strSQL = "usp_Sel_tbl_PM_Project_TaskTypes " & m_GlobalObject.ProjectID.ToString & ",1"
            'drDeffered = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            'If drDeffered.Read Then
            '    strTaskType = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskType")), String)
            'End If
            'CommonFunction.Data.DisposeDataReader(drDeffered)
            'txtHidDelSD
            strTaskType = arrTaskType(1)

            Dim arrItem As String() = strtxtItems.Split(",")
            For i = 0 To arrItem.Length - 2
                strTaskName = CommonFunction.General.CheckIsNothing(Request.Form("txtTaskName_" + arrItem(i)))
                strDeliverableID = CommonFunction.General.CheckIsNothing(Request.Form("txtDELID_" + arrItem(i)))
                strTaskStartDate = CommonFunction.General.CheckIsNothing(Request.Form("txtHidDelSD" + strDeliverableID))
                strTaskEndDate = CommonFunction.General.CheckIsNothing(Request.Form("txtHidDelED" + strDeliverableID))

                If strTaskName <> "" Then
                    sbSAVE.Append("usp_Ins_tbl_PM_ProjectAssignedTasks " + vbCrLf)
                    sbSAVE.Append(" NULL" + vbCrLf)
                    sbSAVE.Append("," + m_GlobalObject.ProjectID.ToString + vbCrLf)
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'" + vbCrLf)
                    '''Planned StartDate
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskStartDate) + "'" + vbCrLf)
                    '''Planned EndDate
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskEndDate) + "'" + vbCrLf)
                    ''Planned Work
                    sbSAVE.Append("," + m_dblOUWorkingHrs.ToString + vbCrLf)
                    sbSAVE.Append(",'O'" + vbCrLf)
                    sbSAVE.Append(",0" + vbCrLf)
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'" + vbCrLf)
                    If strTaskType <> "" Then
                        sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskType) + "'" + vbCrLf)
                    Else
                        sbSAVE.Append(",NULL" + vbCrLf)
                    End If
                    '''Baseline StartDate
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskStartDate) + "'" + vbCrLf)
                    '''Baseline EndDate
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskEndDate) + "'" + vbCrLf)
                    ''Baseline Work
                    sbSAVE.Append(",0.0" + vbCrLf)
                    sbSAVE.Append(",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," + strDeliverableID + ",NULL,NULL,0,1,0" + vbCrLf)

                    ''Commented and Added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)
                    'sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "'" + vbCrLf)
                    If m_intFlag = "1" Then
                        sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "',1" + vbCrLf)
                    Else
                        sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "'" + vbCrLf)
                    End If
                    ''End of added by NitinC on 08 Dec 2011 for WhizibleSEM 11.0 (Issue Fix : 55883)

                    CommonFunction.Data.InsertOrUpdateData(sbSAVE.ToString, MyBase.UseSQL)

                    sbSAVE.Remove(0, sbSAVE.Length)
                End If
            Next
        End If
        sbSAVE = Nothing
    End Sub
    'Private Sub SaveTaskDetails()

    '    '' ***************************************************************************/
    '    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

    '    '' Added By ParagD On 11-Jan-2006
    '    '' Purpose : DSS - 289 => 
    '    '' When task details are modified and click on "SEND MAIL" link ,message contains as "NEW Task"
    '    '' and not "MODIFIED Task" 
    '    '' commented & shifted to declaration part.
    '    '' Dim blnIsNewTask As Boolean
    '    '' END : Added By ParagD On 11-Jan-2006

    '    '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
    '    '' ***************************************************************************/

    '    Dim arrEmpId() As String
    '    Dim intCtr As Integer
    '    Dim intNumberOfEmployees As Integer = 0
    '    Dim dblTempWork As Double = 0
    '    Dim drReview As IDataReader

    '    Dim strQuery As String = ""
    '    Dim strQuery_1 As String = ""
    '    Dim strQuery_2 As String = ""
    '    'Email Related Variables
    '    Dim strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage As String
    '    Dim lngTaskTypeID As Long = 0
    '    Dim strTempQuery As String = ""

    '    Dim strEmployeeNames As String = ""
    '    Dim strTempName As String = ""

    '    'Save Parent Task
    '    '----------------------
    '    ' SQL QUERY : PART 1
    '    '----------------------
    '    If m_lngTaskId > 0 Then
    '        If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
    '            strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks NULL, " & m_strEmployeeId & "," & m_lngTaskId.ToString()
    '        Else
    '            strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks " & m_lngTaskId.ToString()
    '        End If
    '    End If
    '    strQuery_2 &= ", " & m_GlobalObject.ProjectID.ToString
    '    '----------------------
    '    ' SQL QUERY : PART 2
    '    '----------------------
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskName) & "'"
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strCurrentStartDate) & "'"
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strCurrentEndDate) & "'"

    '    'Work
    '    strQuery_2 &= ", [WORK], 'O'"

    '    If m_blnBillable = True Then
    '        strQuery_2 &= ", 1"
    '    Else
    '        strQuery_2 &= ", 0"
    '    End If
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskNotes) & "'"
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskType) & "'"
    '    If m_strBaselineStartDate <> "" Then
    '        strQuery_2 &= ", '" & m_strBaselineStartDate.ToString() & "'"
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    If m_strBaselineEndDate <> "" Then
    '        strQuery_2 &= ", '" & m_strBaselineEndDate.ToString() & "'"
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    If m_strBaselineWork <> "" Then
    '        strQuery_2 &= ", " & FormatNumber(m_strBaselineWork, , , , TriState.False)
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strPriority) & "'"

    '    If m_lngPhaseId > 0 Then
    '        strQuery_2 &= ", " & m_lngPhaseId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strPhase) & "'"
    '    Else
    '        strQuery_2 &= ", NULL, NULL"
    '    End If
    '    If m_lngModuleId > 0 Then
    '        strQuery_2 &= ", " & m_lngModuleId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strModule) & "'"
    '    Else
    '        strQuery_2 &= ", NULL, NULL"
    '    End If
    '    If m_lngSubProjectId > 0 Then
    '        strQuery_2 &= ", " & m_lngSubProjectId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strSubProject) & "'"
    '    Else
    '        strQuery_2 &= ", NULL, NULL"
    '    End If
    '    If m_lngMilestoneId > 0 Then
    '        strQuery_2 &= ", " & m_lngMilestoneId.ToString() & ", '" & CommonFunctions.General.BuildQueryString(m_strMilestone) & "'"
    '    Else
    '        strQuery_2 &= ", NULL, NULL"
    '    End If

    '    'ReviewActionId
    '    If m_lngReviewActionId > 0 Then
    '        strQuery_2 &= "," & m_lngReviewActionId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If

    '    If m_lngChangeRequestId > 0 Then
    '        strQuery_2 &= ", " & m_lngChangeRequestId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    If m_lngProjectFeatureId > 0 Then
    '        strQuery_2 &= ", " & m_lngProjectFeatureId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    If m_lngProjectEstimationTypeId > 0 Then
    '        strQuery_2 &= ", " & m_lngProjectEstimationTypeId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    'Deliverable ID
    '    If m_lngDeliverableId > 0 Then
    '        strQuery_2 &= ", " & m_lngDeliverableId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If

    '    'Mitigation Plans
    '    If m_lngMitigationPlanId > 0 Then
    '        strQuery_2 &= "," & m_lngMitigationPlanId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    'Training Plans
    '    If m_lngTrainingResourceId > 0 Then
    '        strQuery_2 &= "," & m_lngTrainingResourceId.ToString()
    '    Else
    '        strQuery_2 &= ", NULL"
    '    End If
    '    'Training ID
    '    strQuery_2 &= "," & m_lngTrainingId.ToString()

    '    'Void and On Hold
    '    'If m_blnVoid = True Then
    '    '    strQuery_2 &= ", 0"
    '    'Else
    '    strQuery_2 &= ", 1"
    '    'End If

    '    If m_blnOnHold = True Then
    '        strQuery_2 &= ", 1"
    '    Else
    '        strQuery_2 &= ", 0"
    '    End If
    '    strQuery_2 &= ", '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"

    '    dblTempWork = CType(m_strCurrentWork, Double)
    '    strTempQuery = strQuery_2
    '    strTempQuery = Replace(strTempQuery, "[WORK]", FormatNumber(dblTempWork, , , , TriState.False))
    '    strQuery = strQuery_1 & strTempQuery

    '    If Not m_strProjectSetting = PROJECT_SETTING_NORMAL Then
    '        m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
    '        m_strTaskIDList = m_lngTaskId.ToString() & ", "
    '        'Insert the SubTasks for each Resource when new Task is created
    '    ElseIf m_strProjectSetting = PROJECT_SETTING_NORMAL Then
    '        If blnIsNewTask = True Then
    '            arrEmpId = m_strEmployeeID.Split(CType(",", Char))
    '            intNumberOfEmployees = arrEmpId.Length()
    '            strQuery_2 = strTempQuery
    '            strTempQuery = strQuery
    '            strEmployeeNames = ""
    '            For intCtr = 0 To intNumberOfEmployees - 1
    '                ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
    '                ''Check if there is any leave(s) between the start date and end date
    '                'strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), m_strCurrentStartDate, m_strCurrentEndDate)
    '                'If strTempName <> "" Then strEmployeeNames &= strTempName & ", "
    '                ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box

    '                'Insert the Parent Task 
    '                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTempQuery, MyBase.UseSQL), "0"), Long)

    '                'Insert the Child Tasks for each employee
    '                strQuery_1 = "Exec usp_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId.ToString()
    '                strQuery_1 &= ", " & arrEmpId(intCtr)
    '                strQuery_1 &= ", NULL"
    '                strQuery = strQuery_1 & strQuery_2
    '                m_strTaskIDList &= CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) & ", "
    '            Next
    '            ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
    '            'If strEmployeeNames <> "" Then
    '            '    strEmployeeNames = strEmployeeNames.Trim()
    '            '    strEmployeeNames = Left(strEmployeeNames, strEmployeeNames.Length - 1)
    '            '    m_strLeaveMessage = MyBase.GetResourceString("LEAVES_IN_BETWEEN")
    '            '    '"Following resources have leave(s) between task start date and end date,\n"
    '            '    m_strLeaveMessage &= strEmployeeNames
    '            'End If
    '            ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
    '        Else
    '            ''Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
    '            'Check if there is any leave(s) between the start date and end date
    '            'strTempName = CheckLeaves(CType(m_strEmployeeId, Long), m_strCurrentStartDate, m_strCurrentEndDate)
    '            'If strTempName <> "" Then
    '            '    m_strLeaveMessage = MyBase.GetResourceString("RESOURCE_HAS_LEAVES")
    '            '    m_strLeaveMessage = m_strLeaveMessage.Replace("<=>", strTempName)

    '            '    'Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH
    '            '    m_strLeaveMessage = m_strLeaveMessage.Replace("<==>", strFromDate)
    '            '    m_strLeaveMessage = m_strLeaveMessage.Replace("<>", strToDate)
    '            '    'End of Added By ManishK on 6th Feb 06 for WhizibleSem 6.0 Issue for WFH
    '            'End If
    '            ''End of Commented by ManishK on 7th Feb 2006 for SP 6 WFH/ Leave Confirm box
    '            m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Long)
    '        End If
    '    End If
    '    If m_strTaskIDList <> "" Then m_strTaskIDList = Left(m_strTaskIDList, InStrRev(m_strTaskIDList, ",") - 1)

    '    If m_strProjectSetting = PROJECT_SETTING_NORMAL Then
    '        If Trim(m_strTaskIDList) <> "" And m_strEmployeeID <> "" Then
    '            If MyBase.GetFormValue("txthidIsDeferredTask") = "1" Then
    '                If m_blnSendMail = True Then
    '                    m_blnSendEmail = True
    '                    If m_blnShowPopup = False Then
    '                        'Added by vivekP On 3 jun 2005
    '                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage, m_strTaskIDList, CType(m_GlobalObject.ProjectID, String))
    '                        'End Of addition by vivekP on 3 jun 2005
    '                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
    '                    End If
    '                End If
    '            End If
    '        End If
    '    End If

    '    If m_lngReviewActionId > 0 Then
    '        If m_lngTaskId > 0 Then
    '            strQuery = "UPDATE tbl_PM_ReviewActions SET TaskID = " & m_lngTaskId.ToString()
    '            strQuery &= " , WorkInHours = " & dblTempWork.ToString()
    '            strQuery &= " WHERE ReviewActionID = " & m_lngReviewActionId.ToString()
    '            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    '        End If

    '    End If

    '    If m_lngMitigationPlanId > 0 Then
    '        'If m_lngTaskId > 0 And blnIsNewTask = True Then
    '        If m_lngTaskId > 0 Then
    '            strQuery = "UPDATE tbl_PM_MitigationPlans SET TaskID = " & m_lngTaskId.ToString()
    '            strQuery &= " , Responsibility = (SELECT UserName FROM tbl_PM_Employee WHERE EmployeeID = " & m_strEmployeeID & ")"
    '            strQuery &= " WHERE MitigationPlanID = " & m_lngMitigationPlanId.ToString()
    '            'Modified BY NitinVS on 20 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12466
    '            ' If Task is already mapped to the Mitigation plan no need to update 
    '            strQuery &= " AND TaskID IS Null "
    '            'End Modification BY NitinVS on 20 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12466

    '            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    '        End If

    '    End If

    '    If m_lngTrainingResourceId > 0 Then
    '        'If m_lngTaskId > 0 And blnIsNewTask = True Then
    '        If m_lngTaskId > 0 Then
    '            'Modified By VarunA on 28-Feb-2008 IssueID-19003
    '            'Purpose : To persist the data while editing in the training plan, as TaskID used to change by Child TaskID
    '            'strQuery = "UPDATE tbl_PM_Training_Resources SET TaskID = " & m_lngTaskId.ToString() 
    '            strQuery = "UPDATE tbl_PM_Training_Resources SET TaskID = ISNULL(TaskID," & m_lngTaskId.ToString() + ")"
    '            'End By VarunA on 28-Feb-2008
    '            strQuery &= " , StartDate = '" & m_strCurrentStartDate & "'"
    '            strQuery &= " , EndDate = '" & m_strCurrentEndDate & "'"
    '            strQuery &= " , Hours = " & dblTempWork.ToString()
    '            strQuery &= " WHERE TrainingResourceID = " & m_lngTrainingResourceId.ToString()
    '            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    '            strQuery = "UPDATE tbl_PRS_Training_Needs SET TaskID = " & m_lngTaskId.ToString()
    '            strQuery &= " WHERE TrainingID = " & m_lngTrainingId.ToString()
    '            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    '        End If

    '    End If

    'End Sub
#End Region

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
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectApproved", "hidIsProjectApproved", , , , IsProjectApproved, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidResourceValidation", "hidResourceValidation", , , , ResourceValidation, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOnHold", "hidIsProjectOnHold", , , , IsProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOver", "hidIsProjectOver", , , , IsProjectOver, , , , , , True, , True, EnableHTMLEncode:=True))

        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
End Class

Class clsGanttChart_Duration

    Private m_PKID As String
    Private m_arrStartDt As System.Collections.ArrayList
    Private m_arrEndDt As System.Collections.ArrayList
    Private m_arrBench As System.Collections.ArrayList
    Private m_PlottingPeriod_BookPeriod_Color As String = "blue"
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
    Private m_strScheduleID As String = ""
    Private m_blnIsDeliverable As Boolean = False





    Sub New(ByVal GanttStartDate As DateTime, ByVal GanttEndDate As DateTime, ByVal MonDiff As Integer, ByVal PrimaryKey As String, ByRef ResponseWriter As System.Text.StringBuilder, ByVal m_strGanttView As String, ByVal dsWeekHead As DataSet)
        m_GanttStartDt = GanttStartDate
        m_GanttEndDt = GanttEndDate
        m_MonDiff = MonDiff
        m_PKID = PrimaryKey
        m_ResponseWriter = ResponseWriter
        m_strGanttChartType = m_strGanttView
        m_dsWeek = dsWeekHead


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
            dblTDWidth = 8.5 'CType(60 / (Date.DaysInMonth(GanttSD.Year, GanttSD.Month)), Double)
        Else
            dblTDWidth = 8.5 ''8.5
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
        StartMonth = m_GanttStartDt.Month
        Year = m_GanttStartDt.Year

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