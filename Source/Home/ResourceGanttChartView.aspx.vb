Public Class ResourceGanttChartView
    Inherits WebPages.Template.WhizTemplate
#Region "Member Variables"
    Protected m_GlobalObject As New WebPages.Template.WhizGlobal
    Protected m_objAccessRights As New WebPage.Templates.AccessRights
    Protected sbHTML As StringBuilder
    Protected dsTask As DataSet
    Protected dsTemp As DataSet
    Protected drMonthHead As IDataReader
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
    Private strFillColor As String = "Red"
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
    Protected sbHTMLMenu As StringBuilder

    Protected m_intPageNumber As Integer = 1 '0
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


    Private m_strEmployee As String
    Private m_strBGID As String
    Private m_strOUID As String

    Private m_strDesignationID As String
    Private m_strSkillID As String
    Private m_strDUID As String
    Private m_strDTID As String
    Private m_strEmpTypeID As String

    Private m_strDepartmentID As String
    Private m_strDeployable As String
    Private m_strResourcePoolID As String
    Private m_strEmployeeFilter As String
    Private strAppliedFilters As String = "None"
    Private strResourcePoolName As String

#End Region
#Region "CONSTANTS"

    Protected Const PAGE_SIZE As Integer = 20
    Private Const TASKFILTER_ASSIGNED As String = "Assigned"
    Private Const TASKFILTER_DEFFERED As String = "Deffered"
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "BG"
                    Response.Write(GetBGwiseOU())
                Case "OU"
                    Response.Write(GetOUWiseDU())
                Case "DU"
                    Response.Write(GetDUWiseDT())
            End Select
            Response.End()
        Else
            'MyBase.Page_Load(sender, e)
            Call Initialize_Variables()
        End If

    End Sub
    Protected Sub PageInit()
        Initialize_Variables()

        DrawHiddenFields()

        If m_strMode.ToUpper = "SAVE" Then
            PerformAction()
        End If

        GetDatabasValues()

        'DrawMenu()

        DrawHeader()


        'If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
        'DrawTaskAttributes()
        WritePage()
        'Else
        'WriteWBSPage()
        'End If

        Call DrawMenu()

        DisposeNotUsedObjects()


    End Sub
    'Protected Sub DrawTaskAttributes()
    '    '=====================================================================
    '    ' Function  Name		:	DrawTaskAttributes()
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw task attribute.
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	PrashantSJ
    '    ' Created				:	March 05th, 2009
    '    ' Revisions				:	
    '    '=====================================================================
    '    sbHTML = New StringBuilder


    '    sbHTML.Append("<table id='tblTaskAttributes' class='clsTable' width=100% >")
    '    sbHTML.Append("<tr class='clsTRBlank' valign='left'>")

    '    sbHTML.Append("<td align='left' valign='middle' class='clsTDBlankNEW'>")
    '    DrawAttributePopUP(sbHTML, "hrAR", "divAR")
    '    sbHTML.Append("</td>")

    '    sbHTML.Append("<td align='middle' valign='middle' class='clsTDBlankNEW'>")
    '    DrawAttributePopUP(sbHTML, "hrATT", "divATT")
    '    sbHTML.Append("</td>")

    '    If IsCase3Project Then
    '        sbHTML.Append("<td align='right' valign='middle' class='clsTDBlankNEW'>")
    '        DrawAttributePopUP(sbHTML, "hrASTA", "divSTA")
    '        sbHTML.Append("</td>")
    '    End If

    '    sbHTML.Append("<td align='right' valign='middle' class='clsTDBlankNEW'>")
    '    DrawAttributePopUP(sbHTML, "hrAP", "divAP")
    '    sbHTML.Append("</td>")



    '    sbHTML.Append("</tr>")
    '    sbHTML.Append("</table>")
    '    sbHTML.Append("</br>")
    '    'hrView

    '    CommonFunction.Data.DisposeDataReader(drDeffered)

    '    Response.Write(sbHTML.ToString)
    '    sbHTML = Nothing
    'End Sub
    'Protected Sub DrawAttributePopUP(ByVal sbHTML As StringBuilder, ByVal HREFID As String, ByVal DIVID As String)
    '    '=====================================================================
    '    ' Function  Name		:	DrawAttributePopUP()
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw task attribute popup. 
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	PrashantSJ
    '    ' Created				:	March 05th, 2009
    '    ' Revisions				:	
    '    '=====================================================================
    '    Dim sSQL As String = ""
    '    Dim sText As String = ""
    '    Dim sID As String = ""
    '    Dim divHeight As String = ""
    '    Dim strToolTip As String = ""
    '    Dim strValue As String = "&nbsp;&nbsp;&nbsp;"

    '    Select Case HREFID.ToUpper
    '        Case "HRAR"
    '            sSQL = "EXEC usp_Sel_CurrentTeamMembers " & m_GlobalObject.ProjectID.ToString()
    '            sbHTML.Append("Assign Resource: ")
    '            strToolTip = "Assign Resource"
    '            divHeight = "height:250px;"

    '        Case "HRATT"
    '            sSQL = "EXEC usp_Sel_tbl_PM_Project_TaskTypes " & m_GlobalObject.ProjectID.ToString()
    '            sbHTML.Append("Assign Task Type: ")
    '            strToolTip = "Assign Task Type"
    '            divHeight = "height:250px;"
    '        Case "HRAP"
    '            sSQL = "usp_Sel_tbl_IB_Priorities"
    '            divHeight = "height:100px;"
    '            strToolTip = "Assign Priority"
    '            sbHTML.Append("Assign Priority: ")
    '        Case "HRVIEW"
    '            Select Case m_strTagID
    '                Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString
    '                    sSQL = "usp_Sel_tbl_UI_Views_ForGanttChart 3751," + m_GlobalObject.UserID.ToString
    '                    divHeight = "height:380px;"
    '                Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString, CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
    '                    divHeight = "height:100px;"
    '                    sSQL = "usp_Sel_tbl_UI_Views_ForGanttChart " + m_strTagID + "," + m_GlobalObject.UserID.ToString
    '            End Select

    '            strToolTip = "Default View"
    '            'sbHTML.Append("Assigned Priority: ")
    '        Case "HRASTA"
    '            sSQL = "EXEC usp_Sel_tbl_PM_Project_SubTaskTypes " & m_GlobalObject.ProjectID.ToString()
    '            sbHTML.Append("Assign Activity: ")
    '            strToolTip = "Assign Activity"
    '            divHeight = "height:250px;"
    '    End Select

    '    If sSQL <> "" Then
    '        drDeffered = CommonFunction.Data.GetDataReader(sSQL, MyBase.UseSQL)
    '    End If

    '    If HREFID.ToUpper <> "HRVIEW" Then
    '        ''sbHTML.Append("<a title='" + strToolTip + "' style='FONT-FAMILY: Verdana, Arial, sans-serif;' id='" + HREFID + "' class='navtabFilter' onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'>" + strValue + "</a>")
    '        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox(HREFID, HREFID, , 120, , , , "cursor:hand;", , True, , , "onclick='javascript:AHref_OnClick(""" + HREFID + """,event)'", True))
    '    End If
    '    sbHTML.Append("</br>")

    '    ''
    '    sbHTML.Append("<div id='" + DIVID + "' class='cxtMenu' style=""width:200px;" + divHeight + "overflow:auto;display:none;"" >")

    '    sbHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '    While drDeffered.Read
    '        Select Case HREFID.ToUpper
    '            Case "HRAR"
    '                sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("UserName")), String)
    '                sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("EmployeeID")), String)
    '            Case "HRATT"
    '                sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskType")), String)
    '                sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskTypeID")), String)
    '            Case "HRAP"
    '                sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("Priority")), String)
    '                sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("Priority")), String)
    '            Case "HRVIEW"
    '                sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("ViewName")), String)
    '                sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("FilterID")), String)
    '            Case "HRASTA"
    '                sText = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("SubTaskType")), String)
    '                sID = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("SubTaskTypeID")), String)
    '        End Select

    '        sText = sText.Replace("'", "&#39;")

    '        sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
    '        sbHTML.Append("<td align='left'   class='clsTDBlank'>")
    '        sbHTML.Append("<a style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;' href='javascript:Attribute_OnClick(""" + sID + """,""" + sText + """,""" + HREFID + """)'>")
    '        If (HREFID.ToUpper = "HRVIEW" And sID = m_strFilterID) Or (HREFID.ToUpper = "HRAR" And sID = m_strEmployeeID) Then
    '            sbHTML.Append("<font color='blue'><b>")
    '            sbHTML.Append(sText)
    '            sbHTML.Append("</b></font>")
    '        Else
    '            sbHTML.Append(sText)
    '        End If
    '        sbHTML.Append("</a>")
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("</tr>")
    '    End While

    '    CommonFunction.Data.DisposeDataReader(drDeffered)
    '    sbHTML.Append("</table>")
    '    sbHTML.Append("</div>")

    'End Sub
    'Protected Sub WriteDefferedTaskGrid()
    '    '=====================================================================
    '    ' Function  Name		:	WriteDefferedTaskGrid()
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw deffered task grid. 
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	PrashantSJ
    '    ' Created				:	March 05th, 2009
    '    ' Revisions				:	
    '    '=====================================================================
    '    sbHTML = New StringBuilder

    '    sbHTML.Append("<script>")
    '    sbHTML.Append("var arrVertRight = new Array();")
    '    sbHTML.Append("var arrVertLeft = new Array();")
    '    sbHTML.Append("</script>")

    '    sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
    '    sbHTML.Append("<table id='tblDefTask' cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
    '    sbHTML.Append("<tr class='clsTRBlank' valign='left'><b>")
    '    sbHTML.Append("<td align='left'   class='clsTDBlankNEW'>")
    '    sbHTML.Append("</td>")
    '    sbHTML.Append("<td align='left'   class='clsTDBlankNEW'>")
    '    sbHTML.Append("Task Name")
    '    sbHTML.Append("</td>")
    '    sbHTML.Append("<td align='right'  class='clsTDBlankNEW' style='text-align:right;'>")
    '    sbHTML.Append("Work (Hrs)")
    '    sbHTML.Append("</td>")
    '    sbHTML.Append("<td align='left'  class='clsTDBlankNEW'>")
    '    sbHTML.Append("Start Date")
    '    sbHTML.Append("</td>")
    '    sbHTML.Append("<td align='left'  class='clsTDBlankNEW'>")
    '    sbHTML.Append("End Date")
    '    sbHTML.Append("</td>")
    '    sbHTML.Append("</b></tr>")
    '    For Each drRow As DataRow In dsTask.Tables(0).Rows
    '        sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
    '        sbHTML.Append("<td align='center'   class='clsTDBlank'>")
    '        sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskID")), String), , , True))
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("<td align='left'   class='clsTDBlank'>")
    '        sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("TaskName")), String))
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("<td align='right'   class='clsTDBlank'>")
    '        sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), String))
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("<td align='left'   class='clsTDBlank'>")
    '        sbHTML.Append(CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)))
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("<td align='left'   class='clsTDBlank'>")
    '        sbHTML.Append(CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate")), Date)))
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("</tr>")
    '    Next
    '    sbHTML.Append("</table>")
    '    sbHTML.Append("<div>")

    '    Response.Write(sbHTML.ToString)
    '    sbHTML = Nothing
    'End Sub
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

        sbHTML.Append("<TD class='clsTDBlankNew' valign='Top' align='right'>")
        sbHTML.Append("<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous Months' src='../../Images/Home/ScrollLeft.gif' /></a>")
        sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'><Img Border=0 alt='Next Months' src='../../Images/Home/ScrollRight.gif' /></a>")


        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")
        sbHTML.Append("</br>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing
    End Sub
    Protected Function GetPagingString() As String
        strPaging = New StringBuilder


        strPaging.Append("<TD align='right' valign='bottom' >")

        'If m_intRowCount > 0 Then



        dblRatio = m_intRowCount / PAGE_SIZE

        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        strPaging.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
        strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        strPaging.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

        If m_intPageNumber = -1 Or dblRatio = 0 Then
            '    strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True))
            'Else
            '    strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True))
            strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
        Else
            strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))

        End If

        strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        strPaging.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
        strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        strPaging.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
        '''strPaging.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intIssueCountForAppliedQuery / 20)).ToString + ">"))



        strPaging.Append(" of " + Math.Ceiling(dblRatio).ToString)
        'strPaging.Append("|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")
        ''strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True))
        strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))

        strPaging.Append("&nbsp;")
        'End If


        Call DrawFilters()

        'strPaging.Append("<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous Months' src='../../Images/Home/ScrollLeft.gif' /></a>")
        'strPaging.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
        'strPaging.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'><Img Border=0 alt='Next Months' src='../../Images/Home/ScrollRight.gif' /></a>")

        'strPaging.Append("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>")

        strPaging.Append("</td>")

        Return strPaging.ToString

        strPaging = Nothing
    End Function
    Protected Sub DrawMenu()
        sbHTMLMenu = New StringBuilder

        sbHTMLMenu.Append("<table class='clsTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        sbHTMLMenu.Append("<TR class='clsTRMenu' width=99.9% >")
        sbHTMLMenu.Append("<TD align=right>")
        sbHTMLMenu.Append("|&nbsp;<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous Months' src='../../Images/Home/ScrollLeft.gif' />&nbsp;Previous</a>")
        sbHTMLMenu.Append("&nbsp;|&nbsp;")
        sbHTMLMenu.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'>Next &nbsp;<Img Border=0 alt='Next Months' src='../../Images/Home/ScrollRight.gif' /></a>")

        sbHTMLMenu.Append("&nbsp;|&nbsp;<a class='Menu' style='TEXT-DECORATION:None' ")
        sbHTMLMenu.Append("title='Project Allocation' Href='javascript:ProjectAllocation_clicked(""" + GantView_StartDt.ToString("dd-MMM-yyyy") + """,""" + GantView_EndDt.ToString("dd-MMM-yyyy") + """)'>")
        'CommonFunctions.General.WriteHTML("title='Project Allocation' Href='javascript:ProjectAllocation_clicked()'>")
        sbHTMLMenu.Append("&nbsp;Project Allocation")
        sbHTMLMenu.Append("</a>&nbsp;")


        sbHTMLMenu.Append("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>")

        sbHTMLMenu.Append("&nbsp;|</TD>")
        sbHTMLMenu.Append("</TR>")
        sbHTMLMenu.Append("</Table>")

        Response.Write(sbHTMLMenu)

        sbHTMLMenu = Nothing
    End Sub
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
                m_strPageCaption = m_strTaskType + " Task"
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString
                m_strPageCaption = "Milestones"
            Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString
                m_strPageCaption = "Sub Projects"
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                m_strPageCaption = "Deliverable"
            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                m_strPageCaption = "Resources"
        End Select

        'sBHTML.Append("<table class='clsTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        'sBHTML.Append("<TR class='clsTRMenu' width=99.9% >")
        'sBHTML.Append("<TD align=right>")
        'sBHTML.Append("|&nbsp;<a href='javascript:NextOrPrevPeriod(""PREV"")' style='text-decoration:none'><Img Border=0 alt='Previous Months' src='../../Images/Home/ScrollLeft.gif' />&nbsp;Previous</a>")
        'sBHTML.Append("&nbsp;|&nbsp;")
        'sBHTML.Append("<a href='javascript:NextOrPrevPeriod(""NEXT"")' style='text-decoration:none'>Next &nbsp;<Img Border=0 alt='Next Months' src='../../Images/Home/ScrollRight.gif' /></a>")

        'sBHTML.Append("&nbsp;|&nbsp;<a class='Menu' style='TEXT-DECORATION:None' ")
        'sBHTML.Append("title='Project Allocation' Href='javascript:ProjectAllocation_clicked(""" + GantView_StartDt.ToString("dd-MMM-yyyy") + """,""" + GantView_EndDt.ToString("dd-MMM-yyyy") + """)'>")
        ''CommonFunctions.General.WriteHTML("title='Project Allocation' Href='javascript:ProjectAllocation_clicked()'>")
        'sBHTML.Append("&nbsp;Project Allocation")
        'sBHTML.Append("</a>&nbsp;")


        'sBHTML.Append("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>")

        'sBHTML.Append("&nbsp;|</TD>")
        'sBHTML.Append("</TR>")
        'sBHTML.Append("</Table>")
        Call DrawMenu()
        sBHTML.Append("<BR>")


        sBHTML.Append("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        sBHTML.Append(" <TR class=clsTRPageCaption>")
        sBHTML.Append("<TD align=Left>")
        sBHTML.Append(m_strPageCaption)
        sBHTML.Append("</td>")

        'sBHTML.Append("<TD align=middle>")
        Call BuildFilterString()

        'For Applied Filters
        If Trim(strAppliedFilters & "") <> "" Then
            If strAppliedFilters.Length > 50 Then
                strAppliedFilters = strAppliedFilters.Substring(0, 50) + "..."
            End If

            If strAppliedFilters = "None" Then
                sBHTML.Append("<td align=left  >Current Filter : None")
            Else
                sBHTML.Append("<td align=left  >Current Filter : <A href='javascript:showFilters(1)' >" + strAppliedFilters + "</A>")
                If strAppliedFilters <> "None" Then
                    sBHTML.Append("<img id='imgFilter' style='text-decoration:none;' onMouseOver=this.style.cursor='hand' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
                End If
                sBHTML.Append("</td>")
            End If

        End If

        'End of Applied Filters


        'sBHTML.Append("Period : " + CommonFunction.Dates.CGetDate(GantView_StartDt) + " - " + CommonFunction.Dates.CGetDate(GantView_EndDt))

        'sBHTML.Append("</td>")

        sBHTML.Append(GetPagingString())
        sBHTML.Append("</tr>")
        sBHTML.Append("</table>")
        sBHTML.Append("</br>")
        Response.Write(sBHTML.ToString)


        sBHTML = Nothing
    End Sub
    Private Sub BuildFilterString()

        Dim strFilterQuery As String
        Dim dr As IDataReader
        Dim strForApplyFilter As String

        strFilterQuery = "usp_Sel_AppliedFilterString '" & m_strEmployee & "'," & m_strRoleID & "," & m_strDesignationID _
                            & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID & "," & m_strDUID _
                            & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID _
                            & ",'" & m_strDeployable & "'," & m_strResourcePoolID & ",'0'"

        dr = CommonFunction.Data.GetDataReader(strFilterQuery, MyBase.UseSQL)
        While dr.Read
            strAppliedFilters = CType(dr("FilterString"), String)
            'strResourcePoolName = CType(CommonFunction.Data.CheckIsDBNull(dr("ResourcePoolName"), ""), String)
        End While

        CommonFunction.Data.DisposeDataReader(dr)

        If strAppliedFilters = "" Then
            strAppliedFilters = "None"
        End If

    End Sub
    'Protected Sub DrawMenu()
    '    '=====================================================================
    '    ' Function  Name		:	DrawMenu()
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw Menu
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	PrashantSJ
    '    ' Created				:	March 05th, 2009
    '    ' Revisions				:	
    '    '=====================================================================
    '    sbHTML = New StringBuilder("")

    '    'm_strSQL = "SELECT 1,'Monthly Gantt Chart' UNION SELECT 2,'Weekly Gantt Chart' ORDER BY 2 DESC"

    '    sbHTML.Append("<table cellpadding=0 cellspacing=0 class='clsTable' width=100% >")
    '    sbHTML.Append("<tr class='clsTRBlank'>")

    '    If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then
    '        sbHTML.Append("<td align='left' class='clsTDBlankNew'>")
    '        ' sbHTML.Append("<a id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'>Views&nbsp;<Img Border=0 src='../../Images/Home/Views.gif' /></a>")
    '        sbHTML.Append("Views&nbsp;<Img id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'  Border=0 src='../../Images/Home/Views.gif' />")

    '        DrawAttributePopUP(sbHTML, "hrView", "divView")
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
    '        sbHTML.Append("Select Resource ")


    '        m_strSQL = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_GlobalObject.ProjectID.ToString
    '        m_strSQL += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()


    '        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", m_strSQL, 150, m_strEmployeeID.ToString(), "onchange=FilterTasks()", True, True))
    '        sbHTML.Append("</TD>")
    '        sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
    '        sbHTML.Append("Task Name ")
    '        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 150, , m_strTaskName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True))
    '        sbHTML.Append("</TD>")
    '    Else

    '        sbHTML.Append("<td align='left' class='clsTDBlankNew'>")
    '        If m_strTagID <> CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
    '            sbHTML.Append("Views&nbsp;<Img id=hrView title='Default View' onclick='javascript:AHref_OnClick(""hrView"",event)' style='text-decoration:none;cursor:hand;'  Border=0 src='../../Images/Home/Views.gif' />")

    '            DrawAttributePopUP(sbHTML, "hrView", "divView")
    '        Else
    '            sbHTML.Append("Show Active Resources ")
    '            m_strSQL = "SELECT 1,'Yes' UNION SELECT 0,'No' "
    '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboActiveResource", m_strSQL, 50, m_strIsActiveResource, "onchange=FilterTasks()", True, True))
    '        End If
    '        sbHTML.Append("</td>")

    '        sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
    '        If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Or m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString Then
    '            sbHTML.Append("Is Closed ")
    '            m_strSQL = "SELECT 1,'Yes' UNION SELECT 0,'No' "
    '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboClosed", m_strSQL, 50, m_strIsClosed, "onchange=FilterTasks()", True, True))
    '        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
    '            sbHTML.Append("Deliverable Type ")
    '            m_strSQL = "usp_Sel_DeliverableTypes " & m_GlobalObject.ProjectID.ToString
    '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", m_strSQL, 200, m_strDeliverableTypeId, "onchange=FilterTasks()", True, True))
    '        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
    '            sbHTML.Append("Role ")
    '            m_strSQL = "usp_Sel_tbl_PM_Role_PopulateCombo "
    '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", m_strSQL, 200, m_strRoleID, "onchange=FilterTasks()", True, True))
    '        End If

    '        sbHTML.Append("</TD>")

    '        sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
    '        If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Then
    '            sbHTML.Append("Milestone ")
    '        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString Then
    '            sbHTML.Append("Sub Project ")
    '        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
    '            sbHTML.Append("Deliverable ")
    '        ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
    '            sbHTML.Append("Employee Name ")
    '        End If
    '        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEntityName", "txtEntityName", , 150, , m_strEntityName, , , , , , , "onkeyup=EntityName_OnKeyup(event)", True))
    '        sbHTML.Append("</TD>")
    '    End If

    '    sbHTML.Append("<td align='right' class='clsTDBlankNew'>")

    '    If m_objAccessRights.Edit Then
    '        sbHTML.Append("<input type=button id='btnApply'  value='Save' onclick='javascript:Save_OnClick()'/>")
    '    End If

    '    sbHTML.Append("</td>")
    '    sbHTML.Append("</tr>")
    '    sbHTML.Append("</table>")
    '    sbHTML.Append("</br>")
    '    Response.Write(sbHTML.ToString)
    '    sbHTML = Nothing
    'End Sub
    'Private Sub GetValuesToValidateLCE(ByVal m_lTaskId As Long)
    '    '====================================================================
    '    ' Procedure Name       : ValidateLCE
    '    ' Parameters Passed    : None
    '    ' Returns              : None
    '    ' Parameters Affected  : None
    '    ' Purpose              : This procedure validates the LCE using some configuration information.
    '    ' Description          : 
    '    ' Assumptions          : 
    '    ' Dependencies         : 
    '    ' Author               : JayavantK
    '    ' Created              : May 10, 2004
    '    ' Revisions            : 
    '    '=====================================================================
    '    Dim drLCE As IDataReader
    '    Dim strQuery As String = ""
    '    Dim blnAllowLCEDistribution As Boolean = False
    '    Dim strMsg As String = ""

    '    m_lngTaskId = m_lTaskId

    '    If blnAllowLCEDistribution = True Then
    '        strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_GlobalObject.ProjectID.ToString()
    '        strQuery &= ", " ' & strDepartment
    '    Else
    '        strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_GlobalObject.ProjectID.ToString() & ", NULL"
    '    End If
    '    If m_lngTaskId > 0 Then
    '        strQuery &= ", " & m_lngTaskId.ToString()
    '    Else
    '        strQuery &= ", NULL"
    '    End If
    '    drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
    '    If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
    '        If drLCE.Read() Then
    '            m_dblTotalAllocatedTaskLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("AllocatedLCETotal"), "0"), Double)
    '            m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCETotal"), "0"), Double)
    '        End If
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(drLCE)

    'End Sub
    'Protected Sub WriteWBSPage()
    '    '=====================================================================
    '    ' Function  Name		:	WriteWBSPage()
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To draw the other WBS entity Gantt
    '    ' Description			:	
    '    ' Assumptions			:	None.
    '    ' Dependencies			:	None.
    '    ' Author				:	PrashantSJ
    '    ' Created				:	March 24, 2009
    '    ' Revisions				:	
    '    '=====================================================================
    '    sbHTML = New StringBuilder("")

    '    Dim objGanttChart_Month As cResGanttChart_Duration
    '    Dim arrStartDates_MonthWise As ArrayList
    '    Dim arrEndDates_MonthWise As ArrayList
    '    Dim strQuery As String = ""

    '    Dim hidRecPKIDs As String = ""
    '    Dim strEntityame As String = ""


    '    Dim strRecPKID As String
    '    Dim Record_StartDt As Date
    '    Dim Record_EndDt As Date


    '    Dim vertIndex As Integer = 0

    '    Dim strClass As String = "clsTRBlank"

    '    Dim strType As String = ""

    '    Dim IsFreezed As Boolean
    '    Dim WorkHrs As Double = 0.0
    '    Dim strParentTaskID As String = ""
    '    Dim strEmployeeName As String = ""
    '    Dim iGroupCount As Integer = 0

    '    'Record_StartDt = DateAdd(DateInterval.Day, 10, Date.Now)
    '    'Record_EndDt = DateAdd(DateInterval.Day, 20, Date.Now)
    '    RB_validateDT = GantView_EndDt

    '    sbHTML.Append("<div id=divList style=""width:100%;OVERFLOW:auto;"" >")
    '    sbHTML.Append("<table id='tblGanttTask' cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
    '    sbHTML.Append("<tr class='clsTRBlank' valign='left'>")

    '    sbHTML.Append("<td align='left' width=30%  class='clsTDBlankNEW'>")
    '    If m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Then
    '        sbHTML.Append("Milestone ")
    '    ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString Then
    '        sbHTML.Append("Sub Project ")
    '    ElseIf m_strTagID = CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString Then
    '        sbHTML.Append("Deliverable ")
    '    ElseIf CommonFunction.Constants.APP_TAG_RESOURCES.ToString Then
    '        sbHTML.Append("Resources ")
    '    End If
    '    sbHTML.Append("</td>")

    '    drawMonthNameHeadings(sbHTML)
    '    sbHTML.Append("</tr>")


    '    For Each drRow As DataRow In dsTask.Tables(0).Rows
    '        Select Case m_strTagID
    '            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString
    '                strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("MilestoneID")), String)

    '                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("PlannedCompletionDate")), Date)
    '                Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualCompletionDate")), Date)
    '                strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("MileStone")), String)

    '            Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString
    '                strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("SubProjectID")), String)
    '                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedStartDate")), Date)
    '                If CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), String) <> "" Then
    '                    Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EstimatedEndDate")), Date)
    '                Else
    '                    Record_EndDt = Record_StartDt
    '                End If
    '                strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("SubProjectName")), String)
    '            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
    '                strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ScheduleID")), String)
    '                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate")), Date)

    '                If CType(CommonFunction.Data.CheckIsDBNull(drRow("EarliestStartDate")), String) <> "" Then
    '                    Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EarliestStartDate")), Date)
    '                Else
    '                    Record_EndDt = Record_StartDt
    '                End If

    '                strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("Title")), String)
    '            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
    '                strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectEmployeeRoleID")), String)

    '                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ExpectedStartDate")), Date)
    '                Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("ExpectedEndDate")), Date)
    '                strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName")), String)
    '        End Select

    '        sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=showToolTip(this,event) onmouseout=hideToolTip(this,event) >")
    '        vertIndex += 1

    '        m_strToken = CommonFunctions.Security.Token.GetToken(strRecPKID + m_GlobalObject.UserID.ToString + "0" + m_strTagID)

    '        sbHTML.Append("<td align='left' width=30% id='Task' class='clsTDBlank' >")
    '        sbHTML.Append("<A href='JavaScript:ShowEntityEditMode(" & strRecPKID & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """)'>")
    '        sbHTML.Append(strEntityame.Replace("'", "&#39;"))
    '        sbHTML.Append("</A>")
    '        sbHTML.Append("</td>")


    '        strMonthStartIDs = ""
    '        strMonthEndIDs = ""

    '        ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
    '        ''''''''''''''TR must start with First columns before call this function
    '        'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
    '        objGanttChart_Month = New cResGanttChart_Duration(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, sbHTML)
    '        arrStartDates_MonthWise = New ArrayList(1)
    '        arrEndDates_MonthWise = New ArrayList(1)

    '        arrStartDates_MonthWise.Add(Record_StartDt)
    '        arrEndDates_MonthWise.Add(Record_EndDt)

    '        objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
    '        objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise
    '        objGanttChart_Month.drawMonthGantt(False)

    '        objGanttChart_Month = Nothing
    '        arrStartDates_MonthWise = Nothing
    '        arrEndDates_MonthWise = Nothing
    '        ''PrashantSJ on 13th March 2009
    '        'arrRVerticals = arrRVerticals + strRecPKID + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + ","
    '        If Record_EndDt >= GantView_StartDt And Record_EndDt <= GantView_EndDt Then
    '            arrRVerticals = arrRVerticals + strRecPKID + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + ","
    '        Else
    '            arrRVerticals = arrRVerticals + "0,"
    '        End If

    '        ''arrLVerticals = arrLVerticals + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
    '        If Record_StartDt >= GantView_StartDt And Record_StartDt <= GantView_EndDt Then
    '            arrLVerticals = arrLVerticals + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
    '        Else
    '            arrLVerticals = arrLVerticals + "0,"
    '        End If

    '        '''PrashantSJ 12th March 2009
    '        'strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
    '        strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + GantView_StartDt.Month.ToString + "|" + GantView_StartDt.Day.ToString + ","
    '        ''End of addition by PrashantSJ on 12th March 2009
    '        RB_validateDT = GantView_EndDt

    '        strVertRightRBs = strVertRightRBs + strRecPKID + "|" + RB_validateDT.Month.ToString + "|" + RB_validateDT.Day.ToString + ","

    '        'Hidden Controls 
    '        'strRecPKID, strRoleID, strSkillID
    '        hidRecPKIDs = hidRecPKIDs + strRecPKID + ","

    '        sbHTML.Append("<input type=hidden name='L|" + strRecPKID + "' id='L|" + strRecPKID + "' value='" + Record_StartDt.ToString("dd-MMM-yyyy") + "' >")
    '        sbHTML.Append("<input type=hidden name='R|" + strRecPKID + "' id='R|" + strRecPKID + "' value='" + Record_EndDt.ToString("dd-MMM-yyyy") + "' >")

    '        sbHTML.Append("</tr>")



    '    Next
    '    sbHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")



    '    sbHTML.Append("</table>")
    '    sbHTML.Append("</div>")


    '    arrRightVerticals = arrRVerticals.Split(","c)
    '    arrLeftVerticals = arrLVerticals.Split(","c)
    '    arrVertLeftLB = strVertLeftLBs.Split(","c)
    '    arrVertRightRB = strVertRightRBs.Split(","c)


    '    Dim arrCnt As Integer

    '    Response.Write(sbHTML.ToString)

    '    CommonFunction.General.WriteHTML("<script>")
    '    CommonFunction.General.WriteHTML("var arrVertRight = new Array();")
    '    CommonFunction.General.WriteHTML("var arrVertLeft = new Array();")
    '    CommonFunction.General.WriteHTML("var arrVertLeftLB = new Array();")
    '    CommonFunction.General.WriteHTML("var arrVertRightRB = new Array();")

    '    For arrCnt = 0 To arrRightVerticals.Length - 2
    '        CommonFunction.General.WriteHTML("arrVertRight[" + CType(arrCnt, String) + "]=""" + arrRightVerticals(arrCnt) + """;")
    '        CommonFunction.General.WriteHTML("arrVertLeft[" + CType(arrCnt, String) + "]=""" + arrLeftVerticals(arrCnt) + """;")
    '        CommonFunction.General.WriteHTML("arrVertLeftLB[" + CType(arrCnt, String) + "]=""" + arrVertLeftLB(arrCnt) + """;")
    '        CommonFunction.General.WriteHTML("arrVertRightRB[" + CType(arrCnt, String) + "]=""" + arrVertRightRB(arrCnt) + """;")

    '    Next

    '    CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
    '    CommonFunction.General.WriteHTML("var GantViewEndDay=" + DateTime.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month).ToString + ";")
    '    CommonFunction.General.WriteHTML("var GantViewStartDay=1;")
    '    CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")

    '    CommonFunction.General.WriteHTML("</script>")

    '    For arrCnt = 0 To arrRightVerticals.Length - 2
    '        CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
    '        CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
    '    Next

    '    sbHTML = Nothing

    'End Sub

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
        sbHTML = New StringBuilder("")

        Dim objGanttChart_Month As cResGanttChart_Duration
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
        'sbHTML.Append("<td align='left' width=2%  class='clsTDBlankNEW'>")
        'sbHTML.Append("</td>")
        sbHTML.Append("<td align='left' width=28%  class='clsTDBlankNEW'>")

        sbHTML.Append("Employee Name")

        sbHTML.Append("</td>")
        'sbHTML.Append("<td align='right' width=10%  class='clsTDBlankNEW' style='text-align:right;'>")
        'sbHTML.Append("Work (Hrs)")
        'sbHTML.Append("</td>")
        drawMonthNameHeadings(sbHTML)
        sbHTML.Append("</tr>")

        'If m_objAccessRights.Add And DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then

        '    sbHTML.Append("<Tr class=clsTRBlank id=""TRAdd"" >" + vbCrLf)
        '    sbHTML.Append("<td width=2% ALIGN='center' class='clsTDBlank'>" + vbCrLf)
        '    sbHTML.Append("<A href=""Javascript:CreateRowForTasks()""" + vbCrLf)
        '    sbHTML.Append("><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Create Task'></A>" + vbCrLf)
        '    sbHTML.Append("</td>" + vbCrLf)
        '    sbHTML.Append("<td ALIGN='center' colspan='20' class='clsTDBlank'> </td>" + vbCrLf)
        '    sbHTML.Append("</tr>" + vbCrLf)

        'End If

        For Each drRow As DataRow In dsTask.Tables(0).Rows

            strRecPKID = CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeID")), String)


            If IsDBNull(drRow("StartDate")) Then
                Record_StartDt = "-" 'CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate"), ""), Date)
            Else
                ' Record_StartDt = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drRow("StartDate"), "-"), String)))
                Record_StartDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDate"), ""), Date)
            End If

            If IsDBNull(drRow("EndDate")) Then
                Record_EndDt = "-" 'CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate"), ""), Date)
            Else
                'Record_EndDt = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drRow("EndDate"), "-"), String)))
                Record_EndDt = CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDate"), ""), Date)
            End If

            strEntityame = CType(CommonFunction.Data.CheckIsDBNull(drRow("EmployeeName"), "-"), String)
            'WorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), Double)
            'strParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ParentTask_UID")), String)


            ' If strParentTaskID <> "" Then

            If strEmployeeName <> CType(CommonFunction.Data.CheckIsDBNull(drRow("ReportingName")), String) Then
                sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
                sbHTML.Append("<td align='left'  class='clsTDBlank' colspan='20'><b>")
                sbHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ReportingName")), String))
                sbHTML.Append("</b></td>")
                sbHTML.Append("</tr>")
                iGroupCount += 1
            End If
            strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drRow("ReportingName")), String)
            ' End If

            sbHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=showToolTip(this,event) onmouseout=hideToolTip(this,event) >")
            vertIndex += 1
            'sbHTML.Append("<td align='left' width=2%  class='clsTDBlank'>")
            'If strParentTaskID = "" Then
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , strRecPKID, , "onclick=SelectOnClick(this)", True))
            'End If
            'sbHTML.Append("</td>")

            m_strToken = CommonFunctions.Security.Token.GetToken(IIf((strParentTaskID = ""), strRecPKID, strParentTaskID) + m_GlobalObject.UserID.ToString + "0" + CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString)

            sbHTML.Append("<td align='left' width=28% id='Task' class='clsTDBlank' >")
            sbHTML.Append("<A href='JavaScript:ShowEntityEditMode(" & IIf((strParentTaskID = ""), strRecPKID, strParentTaskID) & ",""" & CommonFunctions.General.CheckIsNothing(m_strToken) & """,""" + GantView_StartDt.ToString("dd-MMM-yyyy") + """,""" + GantView_EndDt.ToString("dd-MMM-yyyy") + """)'>")
            sbHTML.Append(strEntityame.Replace("'", "&#39;"))
            sbHTML.Append("</A>")
            sbHTML.Append("</td>")
            'sbHTML.Append("<td align='right' width=10% class='clsTDBlank'>")
            'If strParentTaskID = "" Then
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , , , , , "onblur=txtWork_OnBlur(this," + strRecPKID + ",0)", True, True))
            'Else
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtWork" + strRecPKID, "txtWork" + strRecPKID, , 50, , WorkHrs.ToString, "right", , , , , , "onblur=txtWork_OnBlur(this," + strRecPKID + "," + strParentTaskID + ")", True, True))
            'End If
            'sbHTML.Append("</td>")

            'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActualWork" + strRecPKID, "txtActualWork" + strRecPKID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualWork")), String), "right", , , , , True, , True, ))
            'If Not IsCaseOneProject And strParentTaskID <> "" Then
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidAllChildTaskWork" + strParentTaskID, "hidAllChildTaskWork" + strRecPKID + "_" + strParentTaskID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), String), "right", , , , , True, , True, ))
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidChildTaskWork" + strRecPKID, "hidChildTaskWork" + strRecPKID, , 50, , CType(CommonFunction.Data.CheckIsDBNull(drRow("Work")), String), "right", , , , , True, , True, ))
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskID" + strRecPKID, "hidParentTaskID" + strRecPKID, , , , strParentTaskID, "right", , , , , True, , True, ))
            'End If
            'm_strScript.Append("arrTaskID.push(" + strRecPKID + ");")
            strMonthStartIDs = ""
            strMonthEndIDs = ""

            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
            objGanttChart_Month = New cResGanttChart_Duration(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, sbHTML)
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
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("Work")).ToString, "right", , , , , True, , True, ))
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("StartDate")), Date)), "right", , , , , True, , True, ))
                    'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("EndDate")), Date)), "right", , , , , True, , True, ))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentTaskWork" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , 50, , CommonFunction.Data.CheckIsDBNull(drParentTask("Work")).ToString, "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentStartDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("StartDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))
                    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, "hidParentEndDate" + CommonFunction.Data.CheckIsDBNull(drParentTask("TaskID")).ToString, , , , CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drParentTask("EndDate")), Date)), "right", , , , , True, , True, , EnableHTMLEncode:=True))

                End If
                CommonFunction.Data.DisposeDataReader(drParentTask)

            End If


        Next
        sbHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")

        'If m_objAccessRights.Add And DateDiff(DateInterval.Day, Date.Today, CType(CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date)), Date)) >= 0 Then
        '    'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , (dsTask.Tables(0).Rows.Count + iGroupCount).ToString, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
        '    'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , (dsTask.Tables(0).Rows.Count + iGroupCount).ToString, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
        '    'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)

        '    'sbHTML.Append("<Tr class=clsTRBlank id=""TRAdd"" >" + vbCrLf)
        '    'sbHTML.Append("<td width=2% ALIGN='center' class='clsTDBlank'>" + vbCrLf)
        '    'sbHTML.Append("<A href=""Javascript:CreateRowForTasks()""" + vbCrLf)
        '    'sbHTML.Append("><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Create Task'></A>" + vbCrLf)
        '    'sbHTML.Append("</td>" + vbCrLf)
        '    'sbHTML.Append("<td ALIGN='center' colspan='20' class='clsTDBlank'> </td>" + vbCrLf)
        '    'sbHTML.Append("</tr>" + vbCrLf)

        '    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
        '    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , 0, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
        '    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , hidRecPKIDs, "RIGHT", IsHidden:=True, returnHTML:=True) + vbCrLf)
        'End If

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

        CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
        CommonFunction.General.WriteHTML("var GantViewEndDay=" + DateTime.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month).ToString + ";")
        CommonFunction.General.WriteHTML("var GantViewStartDay=1;")
        CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")

        CommonFunction.General.WriteHTML("</script>")

        For arrCnt = 0 To arrRightVerticals.Length - 2
            CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
            CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
        Next

        sbHTML = Nothing

    End Sub
    Private Sub drawMonthNameHeadings(ByRef objStringBuilder As System.Text.StringBuilder)

        Dim Iterator As Integer
        Dim StartYear As Integer
        Dim StartMonth As Integer
        Iterator = 1

        StartYear = GantView_StartDt.Year
        StartMonth = GantView_StartDt.Month

        While Iterator <= MonDiff

            objStringBuilder.Append("<TD id='Month" + StartMonth.ToString + "' align=center width=20% class='clsTDBlankNew'>  " + vbCrLf)
            'If m_strGanttView = "2" Then
            'objStringBuilder.Append(GetWeekHeading(StartMonth, StartYear) + vbCrLf)
            'Else
            objStringBuilder.Append(MonthName(StartMonth, True) + " (" + StartYear.ToString + " )" + vbCrLf)
            'End If

            If StartMonth = 12 Then
                StartMonth = 1
                StartYear += 1
            Else
                StartMonth = StartMonth + 1
            End If
            Iterator += 1

            objStringBuilder.Append("</TD>" + vbCrLf)
        End While
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
        Dim dtTempDate As Date
        m_strEmployeeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboFilter_EmployeeID"), ""), String)

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = CType(Request.QueryString("Mode"), String)
        Else
            m_strMode = CommonFunction.General.CheckIsNothing(Request.Form("hidMode"))
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

        If Not Request.Form("hidGanttStartDate") Is Nothing And Not Request.Form("hidGanttEndDate") Is Nothing Then
            GantView_StartDt = CType(Request.Form("hidGanttStartDate"), Date)
            GantView_EndDt = CType(Request.Form("hidGanttEndDate"), Date)

        Else
            GantView_StartDt = CType("1-" + MonthName(DateAdd(DateInterval.Month, -1, Date.Now).Month) + "-" + DateAdd(DateInterval.Month, -1, Date.Now).Year.ToString, Date)
            dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
            GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
        End If

        If m_strPeriod.ToUpper = "PREV" Then
            GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(GantView_StartDt.Year, GantView_StartDt.Month)) - 1, GantView_StartDt) ''DateAdd(DateInterval.Day, -1, GantView_StartDt)
            GantView_StartDt = DateAdd(DateInterval.Month, -(MonDiff - 1), GantView_EndDt)
            GantView_StartDt = CType("1-" + MonthName(GantView_StartDt.Month) + "-" + GantView_StartDt.Year.ToString, Date)
        ElseIf m_strPeriod.ToUpper = "NEXT" Then
            GantView_StartDt = CType("1-" + MonthName(GantView_EndDt.Month) + "-" + GantView_EndDt.Year.ToString, Date) ''DateAdd(DateInterval.Day, 1, GantView_EndDt)
            dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
            GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
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
            Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString(), CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString()
                m_strIsClosed = CommonFunction.General.CheckIsNothing(Request.Form("cboClosed"))
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString()
                m_strDeliverableTypeId = CommonFunction.General.CheckIsNothing(Request.Form("cboDeliverableType"))
            Case CommonFunction.Constants.APP_TAG_RESOURCES.ToString
                m_strIsActiveResource = CommonFunction.General.CheckIsNothing(Request.Form("cboActiveResource"))
                m_strRoleID = CommonFunction.General.CheckIsNothing(Request.Form("cboRole"))
        End Select

        If Not Request.QueryString("GanttChartType") Is Nothing Then

            m_strGanttView = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("GanttChartType"), "2"), String)
        Else
            m_strGanttView = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtGanttView"), "2"), String)
        End If

        m_strTaskType = CommonFunctions.General.CheckIsNothing(Request("optTaskType"), "Assigned")

        GetProjectSettingsDetails()

        'EmployeeID
        If Request.Form("txtResource") <> "" Then
            m_strEmployeeFilter = CType(Request.Form("txtResource"), String)
            m_strEmployee = m_strEmployeeFilter
            m_strEmployeeFilter = "'" + m_strEmployeeFilter + "'"


            'strAppliedFilters = "Resource : " & m_strEmployeeID
        Else
            m_strEmployeeFilter = "NULL"
            m_strEmployee = ""
        End If

        'Role ID
        If Request.Form("cboRole") <> "" Then
            m_strRoleID = CType(Request.Form("cboRole"), String)
            'strAppliedFilters = "Role : " & m_strRoleID
        Else
            m_strRoleID = "NULL"
        End If

        'DesignationID
        If Request.Form("cboDesignation") <> "" Then
            m_strDesignationID = CType(Request.Form("cboDesignation"), String)
            'strAppliedFilters = "Designation : " & m_strDesignationID
        Else
            m_strDesignationID = "NULL"
        End If

        'Skill ID
        If Request.Form("cboSkill") <> "" Then
            m_strSkillID = CType(Request.Form("cboSkill"), String)
            'strAppliedFilters = "Skill : " & m_strSkillID
        Else
            m_strSkillID = "NULL"
        End If


        'BG ID
        If Request.Form("cboBG") <> "" Then
            m_strBGID = CType(Request.Form("cboBG"), String)
            'strAppliedFilters = "BG : " & m_strBGID
        Else
            m_strBGID = "NULL"
        End If
        'OU ID
        If Request.Form("cboOU") <> "" Then
            m_strOUID = CType(Request.Form("cboOU"), String)
            'strAppliedFilters = "OU : " & m_strOUID
        Else
            m_strOUID = "NULL"
        End If

        'DU
        If Request.Form("cboDU") <> "" Then
            m_strDUID = CType(Request.Form("cboDU"), String)
            'strAppliedFilters = "DU : " & m_strDUID
        Else
            m_strDUID = "NULL"
        End If
        'DT
        If Request.Form("cboDT") <> "" Then
            m_strDTID = CType(Request.Form("cboDT"), String)
            'strAppliedFilters = "DT : " & m_strDTID
        Else
            m_strDTID = "NULL"
        End If
        'Employee Type
        If Request.Form("cboEmpType") <> "" Then
            m_strEmpTypeID = CType(Request.Form("cboEmpType"), String)
            'strAppliedFilters = "Employee Type : " & m_strEmpTypeID
        Else
            m_strEmpTypeID = ""
        End If

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If
        'm_strDepartmentID

        If Request.Form("cboDepartment") <> "" Then
            m_strDepartmentID = CType(Request.Form("cboDepartment"), String)
            'strAppliedFilters = "Department : " & m_strDepartmentID
        Else
            m_strDepartmentID = "NULL"
        End If

        'Deployable
        m_strDeployable = CType(Request.Form("cboDeployable"), String)

        If m_strDeployable = "D" Then
            'strAppliedFilters = "Deployable : Yes"
        End If

        If m_strDeployable Is Nothing Then
            m_strDeployable = ""
        End If

        'Resource Pool ID
        'ResourcePoolID
        m_strResourcePoolID = CType(Request.QueryString("ResourcePoolID"), String)
        If m_strResourcePoolID Is Nothing Then
            m_strResourcePoolID = CType(Request.Form("cboResourcePool"), String)
        End If

        'strAppliedFilters = "Resource Pool : " & m_strResourcePoolID

        If m_strResourcePoolID Is Nothing Or m_strResourcePoolID = "" Then
            m_strResourcePoolID = "NULL"
        End If


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
        End Select

        m_objAccessRights.GetAccess(m_GlobalObject)

    End Sub
    Private Sub GetDatabasValues()
        'Dim dsRecCount As DataSet

        m_strSQL = "usp_Sel_ProjectAllocationGanttView " & m_intPageNumber.ToString() & "," & m_strEmployeeFilter & ",'" & GantView_StartDt & "','" & GantView_EndDt & "'," & m_strBGID & "," & m_strOUID & "," & m_strRoleID & "," & m_strDesignationID & "," & m_strSkillID & "," & m_strDUID & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID & "," & Session("intUserID").ToString & ",0," & m_strResourcePoolID & ",'" & m_strDeployable & "'"


        dsTemp = CommonFunction.Data.GetDataSet(m_strSQL, "TEMP", , , MyBase.UseSQL)

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        If m_intPageNumber = -1 Then
            dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", , , MyBase.UseSQL)
        Else
            dsTask = CommonFunction.Data.GetDataSet(m_strSQL, "ENTITY", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        End If


        For Each drRow As DataRow In dsTask.Tables(1).Rows
            m_intRowCount = CType(drRow("CNTEmployee"), Integer) 'dsTemp.Tables(1).Rows.Count
        Next




        'm_strSQL = "usp_Sel_WeekNumbers_ForGanttChart '" + CommonFunction.Dates.GetDate(GantView_StartDt) + "','" + CommonFunction.Dates.GetDate(GantView_EndDt) + "'"

        'dsMonthHead = CommonFunction.Data.GetDataSet(m_strSQL, "MonthHead", , , MyBase.UseSQL)



        'm_strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_GlobalObject.ProjectID
        'drProject = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        'If drProject.Read Then
        '    m_strProjectStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProject("ExpectedStartDate")), Date))
        '    m_strProjectEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProject("ExpectedEndDate")), Date))
        'End If

        'CommonFunction.Data.DisposeDataReader(drProject)

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

        If m_HaveSubTaskTypes = False And m_ApplyEffortDistribution = False Then
            IsCaseOneProject = True
        End If
        If m_HaveSubTaskTypes And m_ApplyEffortDistribution Then
            IsCase3Project = True
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
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidMode", "hidMode", , , , m_strMode, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTagID", "hidTagID", , , , m_strTagID, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttStartDate", "hidGanttStartDate", , , , CommonFunction.Dates.GetDate(GantView_StartDt), , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttEndDate", "hidGanttEndDate", , , , CommonFunction.Dates.GetDate(GantView_EndDt), , , , , , True, , True))
        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGanttView", "txtGanttView", , , , m_strGanttView, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTTID", "hidTxtTTID", , , , , , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtARID", "hidTxtARID", , , , m_strEmployeeID, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtAPR", "hidTxtAPR", , , , , , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("cboViews", "cboViews", , , , m_strFilterID, , , , , , True, , True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtASTA", "hidTxtASTA", , , , , , , , , , True, , True))

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidMode", "hidMode", , , , m_strMode, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTagID", "hidTagID", , , , m_strTagID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttStartDate", "hidGanttStartDate", , , , CommonFunction.Dates.GetDate(GantView_StartDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidGanttEndDate", "hidGanttEndDate", , , , CommonFunction.Dates.GetDate(GantView_EndDt), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtGanttView", "txtGanttView", , , , m_strGanttView, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtTTID", "hidTxtTTID", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtARID", "hidTxtARID", , , , m_strEmployeeID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtAPR", "hidTxtAPR", , , , , , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("cboViews", "cboViews", , , , m_strFilterID, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidTxtASTA", "hidTxtASTA", , , , , , , , , , True, , True, EnableHTMLEncode:=True))

    End Sub
    Protected Sub DrawFilters()
        sbHTML = New StringBuilder("")
        'Filter Table 
        sbHTML.Append("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        'Note
        sbHTML.Append("<TR width=99.9%  class=clsTRPageCaption>")
        sbHTML.Append("<TD colspan=4 >Note : " + MyBase.GetResourceString("CAP_CORPORATEDAYS") + "</TD>")
        sbHTML.Append("</TR>")

        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")

        'strSql = "usp_Sel_AllResources_ForCombo '" & dtStartDate & "','" & dtEndDate & "'," & Session("intUserID").ToString & "," & strFrom & "," & strResourcePoolID

        sbHTML.Append("<td style='width:25%;text-align:right'align=right>Resource")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=left title='Starts with' >")
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", , 200, 50, m_strEmployee, returnHTML:=True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", , 200, 50, m_strEmployee, returnHTML:=True, EnableHTMLEncode:=True))
        'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, 200, m_strEmployeeID.ToString, True, True)
        'Grouping on combo SQL
        'Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
        'GroupingColName.DropdownGroupingColumn = "ReportingName"
        'GroupingColName.MatchFieldID = m_strEmployeeID
        'GroupingColName.WidthInPixel = 200
        'GroupingColName.ToBeInserted = True
        'GroupingColName.InsertBlankRow = True

        'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, GroupingColName)

        sbHTML.Append("</td>")
        'Fo Role Filter
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Role")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left>")
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, True, True, True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_RoleID_tbl_PM_Role", 200, m_strRoleID.ToString, True, True, True))
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        sbHTML.Append("</td></TR>")
        'For Designation Filter
        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Designation")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "select DesignationID,DesignationName from tbl_PM_DesignationMaster ORDER BY DesignationName", 200, m_strDesignationID.ToString, True, True, True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "usp_sel_tbl_PM_DesignationMaster_DesignationName", 200, m_strDesignationID.ToString, True, True, True))
        ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        sbHTML.Append("</td>")
        'For PrimarySkills
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Skill")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "select distinct T.ToolID,[Description] from tbl_PM_Tools T ORDER BY [Description]", 200, m_strSkillID.ToString, True, True, True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, m_strSkillID.ToString, True, True, True))
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        sbHTML.Append("</td></TR>")
        'For BG Filter 
        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Business Group")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_BusinessGroups_LevelWise_RCV " + Session("intUserID").ToString, 200, m_strBGID, "onChange= BG_onChange()", True, True))
        sbHTML.Append("</td>")
        'For OU Filter 
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Organization Unit")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%;' align=Left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_RCV " + m_strBGID + "," + Session("intUserID").ToString, 200, m_strOUID, "onChange=OU_onChange()", True, True))
        sbHTML.Append("</td></TR>")
        'For DU Filter
        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        sbHTML.Append("<td style='width:25%;text-align:right' align=right>Delivery Unit")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_sel_DeliveryUnits_LevelWise_RCV " + m_strBGID + "," + m_strOUID + "," + Session("intUserID").ToString, 200, m_strDUID, "onChange=DU_onChange()", True, True))
        sbHTML.Append("</td>")
        'For DT Filter
        sbHTML.Append("<td style='width:25%;text-align:right' >Delivery Team")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%;' align=Left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_sel_DeliveryTeams_LevelWise_RCV " + m_strBGID + "," + m_strOUID + "," + m_strDUID + "," + Session("intUserID").ToString, 200, m_strDTID, True, True, True))
        sbHTML.Append("</td></TR>")
        'Employee Type
        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        sbHTML.Append("<td style='width:25%;text-align:right' >Employee Type")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmpType", "usp_Sel_tbl_RTS_ProjectSpecificControlData  'EmployeeType'", 200, m_strEmpTypeID.ToString, True, True, True))
        sbHTML.Append("</td>")
        'SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department
        sbHTML.Append("<td style='width:25%;text-align:right' >Department")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department", 200, m_strDepartmentID.ToString, True, True, True))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_sel_Department_tbl_pm_Departmentmaster", 200, m_strDepartmentID.ToString, True, True, True))
        sbHTML.Append("</td></TR>")
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        'Deployable
        sbHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        sbHTML.Append("<td style='width:25%;text-align:right' >Deployable")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "SELECT 'N','No' UNION SELECT 'D','Yes' order by 2", 200, m_strDeployable, True, True, True))
        sbHTML.Append("</td>")
        'Resource Pool
        sbHTML.Append("<td style='width:25%;text-align:right' >Resource Pool")
        sbHTML.Append("</td>")
        sbHTML.Append("<td style='width:25%' align=Left >")

        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "usp_Sel_tbl_PM_ResourcePoolMaster " + Session("intUserID").ToString(), 200, m_strResourcePoolID, , True, True))


        sbHTML.Append("</td></TR>")
        'Apply Button
        sbHTML.Append("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'sbHTML.Append("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHTML.Append("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:ClearFilter()' ><Font Size=1>Clear</Font></a></TD>")
        sbHTML.Append("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<input type=button id=btnClose onclick='ClearFilter()' value=""Clear""></TD>")


        sbHTML.Append("</TR></TABLE>")
        sbHTML.Append("<BR>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing


        'If m_strTagID = "1038" Then
        '    sbHTML = New StringBuilder("")

        '    ' sbHTML.Append("<div id=divFilter style='width:100%;overflow:auto;display:none;'>")
        '    sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
        '    sbHTML.Append("<TR class='clsTRBlank'>")
        '    sbHTML.Append("<TD valign='Top' align='left' class='clsTDBlankNew'>")
        '    sbHTML.Append("Select Resource ")

        '    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        '    ' Added Parameter for AllowDeferredTaskCreation for Performance 

        '    m_strSQL = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_GlobalObject.ProjectID.ToString
        '    m_strSQL += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
        '    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        '    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", m_strSQL, 150, m_strEmployeeID.ToString(), "onchange=FilterTasks()", True, True))
        '    sbHTML.Append("</TD>")
        '    sbHTML.Append("<TD valign='Top' align='middle' class='clsTDBlankNew'>")
        '    sbHTML.Append("Task Name ")
        '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 150, , m_strTaskName, , , , , , , "onkeyup=TaskName_OnKeyup(event)", True))
        '    sbHTML.Append("</TD>")
        '    'sbHTML.Append("<TD valign='Top' align='right' class='clsTDBlankNew'>")
        '    'sbHTML.Append("Views ") ''"<Img Border=0 src='../../Images/View.gif' />&nbsp;")
        '    'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboViews", "usp_Sel_tbl_UI_Views_ForGanttChart 3751," + m_GlobalObject.UserID.ToString, 200, m_strFilterID, "onchange=Views_OnChange()", , True))
        '    'sbHTML.Append("</TD>")
        '    sbHTML.Append("</TR>")
        '    sbHTML.Append("</TABLE>")
        '    sbHTML.Append("</br>")

        '    Response.Write(sbHTML.ToString)
        '    sbHTML = Nothing
        'End If
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


        hidPKIDs = Request.Form("hidPKID")

        If hidPKIDs Is Nothing OrElse hidPKIDs = "" Then
            Exit Sub
        End If

        RowCnt = 0
        arrPKIDs = hidPKIDs.Split(","c)
        While RowCnt <= arrPKIDs.Length - 2
            startDate = Request.Form("L|" + arrPKIDs(RowCnt))
            EndDate = Request.Form("R|" + arrPKIDs(RowCnt))

            If m_strTagID = CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString Then

                dblWorkHrs = CType(Request.Form("txtWork" + arrPKIDs(RowCnt)), Double)

                strSQL = "usp_Update_ProjectTasks_GanttChart " + arrPKIDs(RowCnt) + ",'" + startDate + "'"
                strSQL += ",'" + EndDate + "'"
                strSQL += "," + dblWorkHrs.ToString
                strSQL += ",N'" + m_GlobalObject.UserName + "'"

                If IsCaseOneProject Then
                    strSQL += ",1"
                Else
                    strSQL += ",0"
                End If
            Else
                strSQL = "usp_Upd_WBS_Gantt_StartEndDate " & m_GlobalObject.ProjectID.ToString
                strSQL += "," + arrPKIDs(RowCnt)
                strSQL += "," + m_strTagID
                strSQL += ",'" + startDate + "'"
                strSQL += ",'" + EndDate + "'"
                strSQL += ",N'" + m_GlobalObject.UserName + "'"
            End If

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


            RowCnt = RowCnt + 1

        End While

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
        If strchkSelect <> "" Then
            sbSAVE = New StringBuilder("")
            Dim dblWorkHrs As Double, dtStartDate As String = "", dtEndDate As String = ""

            Dim arrchkSelect() As String = strchkSelect.Split(","c)
            Dim k As Integer = 0, lngTaskTypeID As Long, lngEmployeeID As Long, strPriority As String = ""
            Dim lngSubTaskTypeID As Long

            lngTaskTypeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtTTID")), Long)
            lngEmployeeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtARID")), Long)
            strPriority = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtAPR")), String)
            lngSubTaskTypeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidTxtASTA")), Long)


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


                CommonFunction.Data.InsertOrUpdateData(sbSAVE.ToString, MyBase.UseSQL)

                sbSAVE.Remove(0, sbSAVE.Length)
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
            Dim strTaskDate As String = CommonFunction.Dates.GetDate(Date.Today)
            Dim strTaskType As String = ""

            Dim i As Integer = 0, strTaskName As String = ""

            m_strSQL = "usp_Sel_tbl_PM_Project_TaskTypes " & m_GlobalObject.ProjectID.ToString & ",1"
            drDeffered = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drDeffered.Read Then
                strTaskType = CType(CommonFunction.Data.CheckIsDBNull(drDeffered("TaskType")), String)
            End If

            CommonFunction.Data.DisposeDataReader(drDeffered)

            Dim arrItem As String() = strtxtItems.Split(",")
            For i = 0 To arrItem.Length - 2
                strTaskName = CommonFunction.General.CheckIsNothing(Request.Form("txtTaskName_" + arrItem(i)))

                sbSAVE.Append("usp_Ins_tbl_PM_ProjectAssignedTasks " + vbCrLf)
                sbSAVE.Append(" NULL" + vbCrLf)
                sbSAVE.Append("," + m_GlobalObject.ProjectID.ToString + vbCrLf)
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'" + vbCrLf)
                '''Planned StartDate
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskDate) + "'" + vbCrLf)
                '''Planned EndDate
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskDate) + "'" + vbCrLf)
                ''Planned Work
                sbSAVE.Append(",1" + vbCrLf)
                sbSAVE.Append(",'O'" + vbCrLf)
                sbSAVE.Append(",0" + vbCrLf)
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskName) + "'" + vbCrLf)
                If strTaskType <> "" Then
                    sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskType) + "'" + vbCrLf)
                Else
                    sbSAVE.Append(",NULL" + vbCrLf)
                End If
                '''Baseline StartDate
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskDate) + "'" + vbCrLf)
                '''Baseline EndDate
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(strTaskDate) + "'" + vbCrLf)
                ''Baseline Work
                sbSAVE.Append(",0.0" + vbCrLf)
                sbSAVE.Append(",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0" + vbCrLf)
                sbSAVE.Append(",'" + CommonFunction.General.BuildQueryString(m_GlobalObject.UserName) + "'" + vbCrLf)

                CommonFunction.Data.InsertOrUpdateData(sbSAVE.ToString, MyBase.UseSQL)

                sbSAVE.Remove(0, sbSAVE.Length)
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
    Private Function GetBGwiseOU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If
        strQuery = "usp_sel_OrganizationUnits_LevelWise_RCV " + strBGID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("LocationID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetOUWiseDU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strOUID As String
        Dim strBGID As String
        Dim strJscript As String = "OU"

        If Request.QueryString("OUID") Is Nothing OrElse Request.QueryString("OUID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("OUID")
        End If
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If

        strQuery = "usp_sel_DeliveryUnits_LevelWise_RCV " + strBGID + "," + strOUID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ResourcePoolID"), String) + "$___#" + CType(dr("ResourcePoolName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetDUWiseDT() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDUID As String
        Dim strOUID As String
        Dim strBGID As String

        Dim strJscript As String = "DU"
        If Request.QueryString("DUID") Is Nothing OrElse Request.QueryString("DUID") = "" Then
            strDUID = "NULL"
        Else
            strDUID = Request.QueryString("DUID")
        End If
        If Request.QueryString("OUID") Is Nothing OrElse Request.QueryString("OUID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("OUID")
        End If
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If


        strQuery = "usp_sel_DeliveryTeams_LevelWise_RCV " + strBGID + "," + strOUID + "," + strDUID + "," + Session("intUserID").ToString

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("GroupID"), String) + "$___#" + CType(dr("GroupName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function

End Class

Class cResGanttChart_Duration

    Private m_PKID As String
    Private m_arrStartDt As System.Collections.ArrayList
    Private m_arrEndDt As System.Collections.ArrayList
    Private m_arrBench As System.Collections.ArrayList
    Private m_PlottingPeriod_BookPeriod_Color As String = "Red"
    Private m_PlottingPeriod_AvailabilityPeriod_Color As String = "Blue"
    Private m_AvailabilityPeriod_Color As String = "White"
    Private m_GanttStartDt As DateTime
    Private m_GanttEndDt As DateTime
    Private m_MonDiff As Integer
    Private m_ResponseWriter As System.Text.StringBuilder
    Private m_Ref_GanttStartDt As DateTime
    Private m_Ref_GanttEndDt As DateTime





    Sub New(ByVal GanttStartDate As DateTime, ByVal GanttEndDate As DateTime, ByVal MonDiff As Integer, ByVal PrimaryKey As String, ByRef ResponseWriter As System.Text.StringBuilder)
        m_GanttStartDt = GanttStartDate
        m_GanttEndDt = GanttEndDate
        m_MonDiff = MonDiff
        m_PKID = PrimaryKey
        m_ResponseWriter = ResponseWriter
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

        drawMonths()

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
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD class='clsTDBlank' Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD   Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
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
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
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

                m_ResponseWriter.Append("<TD  Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next

        End If
        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub

End Class