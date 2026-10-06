Imports CommonFunction
Imports Whizible
Public Class ProjectTasksDetails
    Inherits WebPages.Template.WhizTemplate
    'Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objGrid1 As New WebPages.Template.GenericGrid
    Protected m_intProjectID As Integer
    Protected m_strAction As String
    Protected m_strMode As String
    Protected m_strLoginType As String
    Protected m_lngEmployeeID As Integer
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights          'This variable is for access rights of page.
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strTemplate As String = "0"
    Protected m_TotalPlannedHours As Double = 0.0
    Protected AvailableWorkHours As Double = 0.0
    Protected Const m_MismatchAlert As String = "Available hours have exhausted, Please replan."

    Private m_TotalRecords As Integer
    Public m_RecruiterID As String
    Public m_BGID As String
    Public m_HiringManager As String
    Public m_strRecruiterId As String
    Public m_strPipelineId As String
    Public m_strFlag As String
    Public m_strChkd As String
    Public m_RecruiterFilterID As String
    Public m_BGFilterID As String
    Public m_HMFilterID As String
    'Chakshuta
    Public intCapValue As String
    Public CapPeriodID As String
    Public CapUnitID As String
    Public BillingCalendarID As String
    'Chakshuta
    'Code Added By Bharat Tekade On 25th-May-2015
    Protected m_strStartDate As String = ""
    Protected m_strEndDate As String = ""
    Public m_AssignedOn As String
    Protected m_strModifiedField As String = ""
    Protected m_strModifiedBy As String = ""
    Protected m_strUniqueID As String = ""
    Protected CustomerID As String
    Protected intUniqueID As String = ""
    'Code Ended By Bharat Tekade On 25th-May-2015
    Protected m_TimeSheetNo As String

    Protected intOverallScheduleID As String
    Protected strWhichTask As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'm_strLoginType = Session("LoginType").ToString
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        'm_intProjectID = Session("intProjectID").ToString

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        ''2 Apr
        If Not Request.QueryString("RecruiterID") Is Nothing Then
            m_strRecruiterId = HttpContext.Current.Request.QueryString("RecruiterID")
        Else
            m_strRecruiterId = ""
        End If

        If Not Request.QueryString("PipelineID") Is Nothing Then
            m_strPipelineId = HttpContext.Current.Request.QueryString("PipelineID")
        Else
            m_strPipelineId = ""
        End If


        If Not Request.QueryString("Flag") Is Nothing Then
            m_strFlag = Request.QueryString("Flag").ToString
        Else
            m_strFlag = ""
        End If

        If Not Request.QueryString("strPipelineID") Is Nothing Then
            m_strChkd = Request.QueryString("strPipelineID").ToString
        Else
            m_strChkd = ""
        End If


        If Not Request.QueryString("RecruiterID") Is Nothing Then
            m_RecruiterFilterID = Request.QueryString("RecruiterID").ToString
        Else
            m_RecruiterFilterID = ""
        End If

        If Not Request.QueryString("BusinessGroupID") Is Nothing Then
            m_BGFilterID = Request.QueryString("BusinessGroupID").ToString
        Else
            m_BGFilterID = ""
        End If

        If Not Request.QueryString("HiringManagerID") Is Nothing Then
            m_HMFilterID = Request.QueryString("HiringManagerID").ToString
        Else
            m_HMFilterID = ""
        End If

        If Not Request.QueryString("ModifiedBy") Is Nothing Then
            m_strModifiedBy = Request.QueryString("ModifiedBy").ToString
        Else
            m_strModifiedBy = ""
        End If
        If Not Request.QueryString("ModifiedField") Is Nothing Then
            m_strModifiedField = Request.QueryString("ModifiedField").ToString
        Else
            m_strModifiedField = ""
        End If
        If Not Request.QueryString("UniqueID") Is Nothing Then
            m_strUniqueID = Request.QueryString("UniqueID").ToString
        Else
            m_strUniqueID = ""
        End If
        'ProjCustomerCapDetailsID_PK
        If Not Request.QueryString("ProjCustomerCapDetailsID_PK") Is Nothing Then
            intUniqueID = Request.QueryString("ProjCustomerCapDetailsID_PK").ToString
        Else
            intUniqueID = ""
        End If
        ''Aniruddh
        If Not Request.QueryString("TimeSheetNo") Is Nothing Then
            m_TimeSheetNo = Request.QueryString("TimeSheetNo").ToString
        Else
            m_TimeSheetNo = ""
        End If
        ''End
        'Bharat on 05th-May-2016
        If Not Request.QueryString("WhichTask") Is Nothing Then
            strWhichTask = Request.QueryString("WhichTask").ToString
        Else
            strWhichTask = ""
        End If
        'End Bharat on 05th-May-2016
    End Sub

    Public Sub PageInit()
        GetGlobalObject()
        'InitVariables()
        'WriteMenu_Filters()
        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
            'WritePage()
            WriteMenu_Filters()
        ElseIf m_strAction.ToUpper = "TASKDETAILS" Then
            'InheritData()
            WriteMenu_Filters()
        ElseIf m_strAction = "SETBASELINE" Then
            Call SetBaseline()
            WriteMenu_Filters()
        ElseIf m_strAction = "CLOSETASK" Then
            Call CloseTasks()
            WriteMenu_Filters()
            'WritePage()
            ''ElseIf m_strAction.ToUpper = "BASELINETASKS" Then
            ''    'DisplayMasterData_Grid()
            ''    WriteMenu_Filters()
            ''    'WritePage()
            ''ElseIf m_strAction.ToUpper = "INHERITCAP" Then
            ''    WriteMenu_Filters()
            ''ElseIf m_strAction.ToUpper = "CAPHISTORY" Then
            ''    WriteMenu_Filters()
            ''ElseIf m_strAction.ToUpper = "CUSTOMERHOLIDAYS" Then
            ''    WriteMenu_Filters()
            ''ElseIf m_strAction.ToUpper = "FILTERONCHANGE" Then
            ''    WriteMenu_Filters()
            ''    ''Aniruddh
            ''ElseIf m_strAction.ToUpper = "PROJECT_TIMESHEET" Then
            ''    WriteMenu_Filters()
            ''end
        End If

    End Sub
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Private Sub InitVariables()
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        m_intProjectID = CInt(Session("intProjectID"))
    End Sub

    Protected Sub WriteMenu_Filters()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder

        Dim strQuery As String
        Dim strActiveTAManager As String

        'Dim m_arrMenu() As String = {"Save", "Edit", "Select All", "Clear All"}
        'Dim m_arrMenu() As String = {"Save", "Close"}
        'Dim m_arrMenuToolTip() As String = {"Save", "Close"}
        'Dim m_arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()"}
        Dim m_arrMenu() As String = {"Set Baseline", "Close Tasks", "Select All", "Clear All", "Close"}
        Dim m_arrMenuToolTip() As String = {"Set Baseline", "Close Tasks", "Select All", "Clear All", "Close"}
        Dim m_arrCSFunction() As String = {"SetBaseline_OnClick()", "CloseTasks_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()"}
        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        Dim strMenu, strLegend As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        strMenu = Replace(strMenu, ">Save", "id=Save>Save")

        ''sbSTRHTML.Append("<div id='divList' name='divList' style='overflow:auto;width:100%'>") ''overflow:auto;
        sbSTRHTML.Append(strMenu)

        'DrawFilters(sbSTRHTML)

        'sbSTRHTML.Append("<br>")

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Task Details", , , True))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "", , , True))

        CommonFunction.General.WriteHTML("<br>")
        'If m_strAction.ToUpper = "BASELINETASKS" Then
        '    ' PlotNote()
        '    CommonFunctions.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks which are affecting the overall schedule plan.</TD></TR></TABLE>" + vbCrLf)
        'Else
        '    'PlotNote1()
        '    CommonFunctions.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks in the Combination which are not Baselined.</TD></TR></TABLE>" + vbCrLf)
        'End If
        CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD id='tdShowHide_showHide_divSection1'><b>Filters:</b></TD></TR></TABLE>")
        PlotFilters()
        'CommonFunctions.General.WriteHTML("<br><TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks which are affecting the overall schedule plan.</TD></TR></TABLE>" + vbCrLf)
        Call DrawLegends()
        DisplayData_Grid()

        'Commented By Bharat Tekade on 05th-May-2016 remove the second table and this task will be displayed in above table
        'CommonFunctions.General.WriteHTML("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks in the Combination which are not Baselined.</TD></TR></TABLE>" + vbCrLf)
        'DisplayNotBaselineData_Grid()
        'End of Commented By Bharat Tekade on 05th-May-2016 remove the second table and this task will be displayed in above table

        CommonFunction.General.WriteHTML("<br>")
        WritePage()

        CommonFunction.General.WriteHTML("<br>")
    End Sub
    Protected Function PlotNote() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks which are not baselined.</TD></TR></TABLE>"
        Return CStr(strPlot)
    End Function
    Protected Function PlotNote1() As String
        Dim strPlot As String = "<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader><TD align=Left><b>Note : </b> The following are the tasks which have Baseline End Date greater than Baseline end date of the Combination.</TD></TR></TABLE>"
        Return CStr(strPlot)
    End Function
    Protected Sub WritePage()

        Dim sbSTRHTML As New System.Text.StringBuilder

        sbSTRHTML.Append("<div id='divList' name='divList' style='overflow:auto;width:100%'>") ''overflow:auto;


        'DisplayData_Grid()
        'sbSTRHTML.Append("<br>")
        'DisplayNotBaselineData_Grid()

        sbSTRHTML.Append("</div>")

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub
    Protected Sub PlotFilters()
        Dim sbHTML As New System.Text.StringBuilder
        Dim strQuery As String

        sbHTML.Append("<TABLE Class=clsTable Width='99.9%'><TR>")
        sbHTML.Append("<TD align=right>Tasks Which Are : </TD>")
        sbHTML.Append("<TD align=left>")
        strQuery = "EXEC usp_sel_value_ForTasks "
        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTasks", strQuery, 200, strWhichTask, "OnChange='cboTasksChange(this)'", True, True))
        sbHTML.Append("</TD>")
        sbHTML.Append("</TD></TR></TABLE>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub

    Protected Sub DrawLegends()
        Dim sbHTML As New System.Text.StringBuilder

        sbHTML = New StringBuilder("")
        sbHTML.Append("<Div id=legendDiv>")
        sbHTML.Append("<br /><table style='width:100%'>")

        sbHTML.Append("<tr>")
        sbHTML.Append("<td>")
        sbHTML.Append("<div style='border-radius:50%;width:10px;height:10px;border:1px solid #CCC;background-color:green'></div>") '#F05E3D
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Baseline </div>")
        sbHTML.Append("</td>")

        sbHTML.Append("<td>")
        sbHTML.Append("</td>")

        sbHTML.Append("<td>")
        sbHTML.Append("<div style='border-radius:50%;width:10px;height:10px;border:1px solid #CCC;background-color:Orange'></div>") '#EBC620
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Not Baseline </div>")
        sbHTML.Append("</td>")

        sbHTML.Append("<td>")
        sbHTML.Append("</td>")

        sbHTML.Append("<td>")
        sbHTML.Append("<div style='border-radius:50%;width:10px;height:10px;border:1px solid #CCC;background-color:red'></div>") '#47BC7C
        sbHTML.Append("</td>")
        sbHTML.Append("<td >")
        sbHTML.Append("<div class='clsdisplay'> Beyond Schedule </div>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' style='width:65%'>")
        sbHTML.Append("</td>")

        sbHTML.Append("</tr>")

        'sbHTML.Append("<tr>")
        'sbHTML.Append("<td>")
        'sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:blue'></div>") '#EBC620
        'sbHTML.Append("</td>")
        'sbHTML.Append("<td style='width:26%'>")
        'sbHTML.Append("<div class='clsdisplay'> Baseline </div>")
        'sbHTML.Append("</td>")
        'sbHTML.Append("<td align='right' style='width:70%'>")
        'sbHTML.Append("</td>")
        'sbHTML.Append("</tr>")

        'sbHTML.Append("<tr>")
        'sbHTML.Append("<td>")
        'sbHTML.Append("<div style='width:10px;height:10px;border:1px solid #CCC;background-color:green'></div>") '#47BC7C
        'sbHTML.Append("</td>")
        'sbHTML.Append("<td style='width:26%'>")
        'sbHTML.Append("<div class='clsdisplay'> Actual </div>")
        'sbHTML.Append("</td>")
        'sbHTML.Append("<td align='right' style='width:70%'>")
        'sbHTML.Append("</td>")
        'sbHTML.Append("</tr>")

        sbHTML.Append("</table>")
        sbHTML.Append("</Div>")

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing

    End Sub



    Private Sub DisplayData_Grid()
        Dim strQuery As String = ""
        Dim strSQLQuery1 As String = ""

        m_intProjectID = CInt(Session("intProjectID"))
        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)
        intOverallScheduleID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OverallScheduleID"), ""), String)



        'Commented and Added By Bharat Tekade on 05th-may-2015 to add some extra columns
        ''Dim arrActualColumns() As String = {"TaskName", "BaselineStart", "BaselineEnd", "BaselineWork"}
        ''Dim arrUserFriendlyColumn() As String = {"Task Name", "Baseline Start Date", "Baseline End Date", "Baseline Work"}
        ''Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "Align=Center", "Align=Center"}

        'strQuery = "EXEC Usp_sel_baseline_task_details 'BASELINETASKS'," & intOverallScheduleID & "," & m_intProjectID

        Dim arrActualColumns() As String = {"", "TaskName", "TaskDescription", "ResourceName", "Duration", "CurrentStartDate", "CurrentEndDate", "CurrentWork", "BaselineStart", "BaselineEnd", "BaselineWork", "ActualStartDate", "ActualEndDate", "ActualWork", ""}
        Dim arrUserFriendlyColumn() As String = {"Task Indication", "Task Name", "Task Description", "Resource Name", "Duration", "Current Start Date", "Current End Date", "Current Work", "Baseline Start", "Baseline End", "Baseline Work", "Actual Start Date", "Actual End Date", "Actual Work", "Select"}
        Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center", "Align=Center"}

        'End of Commented and Added By Bharat Tekade on 05th-may-2015 to add some extra columns

        strQuery = "EXEC Usp_sel_baseline_task_details '" & strWhichTask & "'," & intOverallScheduleID & "," & m_intProjectID


        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle

            '.PrimaryKey = "BillingCalendarDetailsID"
            .SQL = strQuery
            .UseSQL = True
            .DIVID = "divList"
            .DIVHeight = 110
            'Commented and added By Bharat Tekade on 25th-Jun-2015
            '.DIVStyle = "overflow:auto;width:100%;height:400px;"
            ''Commented and Modified By Aniruddh Gujar on 21-Oct-2015 Purpose::EASi UAT Issue fixing
            .DIVStyle = "overflow:auto;width:100%;height:355px;"
            ''End of Commented and Modified By Aniruddh Gujar on 21-Oct-2015 Purpose::EASi UAT Issue fixing
            'Ended By Bharat Tekade on 25th-Jun-2015
            .NoOfDataColumns = 14
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        m_objGrid = Nothing

    End Sub
    ''''''''''''''''''''''''''''''''''''
    Private Sub DisplayNotBaselineData_Grid()
        Dim strQuery As String = ""
        Dim strSQLQuery1 As String = ""

        m_intProjectID = CInt(Session("intProjectID"))
        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)
        intOverallScheduleID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OverallScheduleID"), ""), String)



        Dim arrActualColumns() As String = {"TaskName", "StartDate", "EndDate", "Work"}
        Dim arrUserFriendlyColumn() As String = {"Task Name", "Start Date", "End Date", "Work"}
        Dim arrTDStyle() As String = {"Align=Center", "Align=Center", "Align=Center", "Align=Center"}
        strQuery = "EXEC Usp_sel_not_baseline_task_details 'TASKDETAILS'," & intOverallScheduleID & "," & m_intProjectID

        With m_objGrid1
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            '.PrimaryKey = "BillingCalendarDetailsID"
            .SQL = strQuery
            .UseSQL = True
            .DIVID = "divList"
            .DIVHeight = 110
            'Commented and added By Bharat Tekade on 25th-Jun-2015
            '.DIVStyle = "overflow:auto;width:100%;height:400px;"
            ''Commented and Modified By Aniruddh Gujar on 21-Oct-2015 Purpose::EASi UAT Issue fixing
            .DIVStyle = "overflow:auto;width:100%;height:355px;"
            ''End of Commented and Modified By Aniruddh Gujar on 21-Oct-2015 Purpose::EASi UAT Issue fixing
            'Ended By Bharat Tekade on 25th-Jun-2015
            .NoOfDataColumns = 4
            .EmptyValueReplacement = "&nbsp;"
            .returnHTML = True
            m_TotalRecords = .NoOfRows
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        m_objGrid1 = Nothing




    End Sub

    ''''''''''''''''''''''''''''''''''''''''''''''''''

    Private Sub SaveData()

        Dim CapPeriodNew, CapValueNew, CalUnitNew As String
        Dim strSQLQuery As New System.Text.StringBuilder

        m_intProjectID = CInt(Session("intProjectID"))

        CapPeriodNew = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCapPeriodID"), "NULL")
        CapValueNew = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCapValue"), "NULL")
        CalUnitNew = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCapUnitID"), "NULL")


        If (CapPeriodNew <> "") Then
            CapPeriodNew = CapPeriodNew
        Else
            CapPeriodNew = "NULL"
        End If
        If (CapValueNew <> "") Then
            CapValueNew = CapValueNew
        Else
            CapValueNew = "NULL"
        End If

        If (CalUnitNew <> "") Then
            CalUnitNew = CalUnitNew
        Else
            CalUnitNew = "NULL"
        End If

        If CapPeriodNew <> "" And CapValueNew <> "" And CalUnitNew <> "NULL" Then
            strSQLQuery.Append("Exec usp_INS_tbl_PM_Project_BillingDetails ")

            strSQLQuery.Append("" & CapPeriodNew & "")
            strSQLQuery.Append("," & CapValueNew & "")
            strSQLQuery.Append("," & CalUnitNew & ",")
            strSQLQuery.Append(m_intProjectID)
            strSQLQuery.Append(" " & vbCrLf)
        End If


        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If
    End Sub
    Protected Sub SetBaseline()
        Dim strTaskIdList As String
        Dim arrTaskId() As String
        Dim intRowCount As Integer = 0
        Dim strTaskID As String
        Dim strQuery As String

        strTaskIdList = Request.Form("chkSelect")
        arrTaskId = Split(strTaskIdList, ",")

        For intRowCount = 0 To arrTaskId.Length - 1
            strTaskID = arrTaskId(intRowCount)

            strQuery = "Exec Usp_Upd_tbl_PM_ProjectTasks_Baseline " & strTaskID & ",'" & Session("strUserName") & "'"

            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        Next

        CommonFunctions.General.WriteHTML("<script type=text/javascript>")
        Response.Write("window.opener.location.href=window.opener.location.href;")
        CommonFunctions.General.WriteHTML("</script>")

    End Sub
    Protected Sub CloseTasks()
        Dim strTaskIdList As String
        Dim arrTaskId() As String
        Dim intRowCount As Integer = 0
        Dim strTaskID As String
        Dim strQuery As String

        strTaskIdList = Request.Form("chkSelect")
        arrTaskId = Split(strTaskIdList, ",")

        For intRowCount = 0 To arrTaskId.Length - 1
            strTaskID = arrTaskId(intRowCount)

            strQuery = "Exec Usp_Upd_tbl_PM_ProjectTasks_CloseTasks " & strTaskID & ",'" & Session("strUserName") & "'"

            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        Next
        CommonFunctions.General.WriteHTML("<script type=text/javascript>")
        Response.Write("window.opener.location.href=window.opener.location.href;")
        CommonFunctions.General.WriteHTML("</script>")
    End Sub
    Private Sub InheritData()

        Dim intRowCount As Integer = 0
        Dim strRecruiterID As String = ""
        Dim strRecruiterIDValues As String = ""
        m_intProjectID = CInt(Session("intProjectID"))
        'Dim regDate As Date = Date.Now()
        'Dim strDate As String = regDate.ToString("ddMMMyyyy")

        Dim strSQLQuery As New System.Text.StringBuilder

        'If m_intProjectID <> "" Then
        strSQLQuery.Append("Exec usp_Upd_CapDetails_And_Calendar ")

        strSQLQuery.Append("" & m_intProjectID & "")
        strSQLQuery.Append(" " & vbCrLf)
        'End If


        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If

    End Sub





#Region " General Events Definition"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "TASK NAME" Then
            Cancel = True
            Dim strTaskName As String
            Dim intTaskID As String
            Dim m_strToken As String

            strTaskName = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskName"), "")
            intTaskID = Args.DataReader("TaskID")

            m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))

            Args.StringToBeInserted = "<TD align=center valign=top> <a href=""javascript:TaskName_OnClick('" & intTaskID & "','" & m_strToken & "')"">" & strTaskName & "</a></TD>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim intTaskID As String
            Dim ActualEndDate As String

            intTaskID = Args.DataReader("TaskID")
            ActualEndDate = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualEndDate"), "")

            If ActualEndDate <> "" Then
                Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelect' id='chkSelect_" + intTaskID.ToString + "' class='clsCheckBox' value=" + intTaskID.ToString + " disabled=true  ></td>"
            Else
                Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelect' id='chkSelect_" + intTaskID.ToString + "' class='clsCheckBox' value=" + intTaskID.ToString + " ></td>"
            End If
            'End Of Modified By Chakshuta H pn 3rd-July-2015 Purpose::EASI Issue Fixing
        End If
        If Args.ColumnName.ToUpper = "TASK INDICATION" Then
            Cancel = True
            Dim intTaskID As String
            Dim strWhichTask As String
            Dim strQuery As String
            Dim color As String

            intTaskID = Args.DataReader("TaskID")

            strQuery = "Usp_Check_Task_IsBaslinedOROverSchedule " & intTaskID
            strWhichTask = CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strQuery, True))

            If strWhichTask.ToUpper = "BASELINE" Then
                color = "Green"
            ElseIf strWhichTask.ToUpper = "NOT BASELINE" Then
                color = "Orange"
            Else
                color = "Red"
            End If

            Args.StringToBeInserted = "<td  align=center><div style='border-radius:50%;width:10px;height:10px;border:1px solid #CCC;background-color:" & color & "'></div></td>"
            'End Of Modified By Chakshuta H pn 3rd-July-2015 Purpose::EASI Issue Fixing
        End If
    End Sub
#End Region

    Private Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad

    End Sub
End Class



