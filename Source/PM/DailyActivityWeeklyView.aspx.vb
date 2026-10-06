
Public Class DailyActivityWeeklyView
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


    Dim objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objAdvGrid As New WebPage.Templates.AdvancedGrid
    Public dtmSelectedDate As String
    Public dtmFromDate As String, dtmFromDate1 As String
    Public dtmToDate As String, dtmToDate1 As String
    ' Added By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 for Editable Date Control IssueID 672
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected strInputdateFormat As String = CommonFunction.Application.InputeDateFormat
    ' End Addition By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 for Editable Date Control IssueID 672

    '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
    Protected IsHolidayOrLeave As Boolean() = {False, False, False, False, False, False, False}
    Protected intWorkingDays As Integer
    '--- End addition purvaJ


    Public Sub PageInit()
        '====================================================================
        ' Function Name       : PageInit
        ' Parameters Passed     : None
        ' Returns               : Boolean
        ' Parameters Affected   : None
        ' Purpose               : To Generate the daily activity view
        ' Description           : 
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : VivekP
        ' Created Date          : 29 Apr 2005
        ' Revisions             :
        '=====================================================================

        '######### Page Code starts here
        Dim intCnt As Integer, intWidth As Integer
        Dim strWeekDayName As String, strSQLQuery As String, strGRID As String
        Dim dtCounterDate As Date
        'Dim dtCounterDate As String
        Dim arrstrUserFriendlyList As New ArrayList, arrstrRowLinkField As New ArrayList
        Dim arrColGroupNames As New ArrayList, arrColGroupExpanded As New ArrayList
        Dim arrstrIgnoreHTML As New ArrayList, arrColGroup As New ArrayList
        Dim arrstrGroupOnColumn As New ArrayList, arrstrTDStyle As New ArrayList
        Dim arrstrActualList As New ArrayList, arrstrSummaryFunctionsList As New ArrayList
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strGroup As String, strIsExpanded As String, strPageCaption As String
        Dim drTimesheetStatus As IDataReader, drActualHrs As IDataReader
        Dim arrGroupSummaryFunctions As New ArrayList
        Dim dblActualHrs As Double, dblExpectedHrs As Double, dblTotalHrs As Double
        Dim arrIgnoreHTMLEncode As New ArrayList
        Dim strMessage As String
        Dim m_intNoOfDays As Integer
        Dim m_intDayCounter As Integer

        Dim arrMenu() As String = {"My Task List", "Previous Week", "Next Week", "?"}
        Dim arrClientSideFunctions() As String = {"MyTaskList_OnClick()", "PreviousWeek_OnClick()", "NextWeek_OnClick()", "Help_OnClick('PM_TASKLISTVIEW')"}
        Dim arrMenuToolTip() As String = {"My Task List", "Previous Week", "Next Week", " Help"}
        '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        '--- End modification purvaJ
        Dim StartingDayOfWeek As String
        Dim dr As IDataReader
        Dim status As Integer = 0

        '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
        Dim drHolidayLeave As IDataReader
        '--- End addition purvaJ

        Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
        Response.Write("<BR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><TR class=clsTRPageCaption><TD align=Left><b>Task List View</b></td></tr></table>")


        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True) + vbCrLf)

        If Request.QueryString("SelectedDate") <> "" Then
            dtmSelectedDate = Request.QueryString("SelectedDate")
        Else
            dtmSelectedDate = CommonFunction.Dates.GetDate(Now())
            'dtmSelectedDate = CDate(CommonFunction.Dates.GetDate(CDate(Session("ClientDate"))).ToString("dd-MMM-yyyy")
            'dtmSelectedDate = New Date
        End If

        'dtmSelectedDate = dtmToDate
        ' Response.Write(CommonFunctions.Dates.GetDate(CDate(Session("ClientDate"))))
        CommonFunction.Dates.GetFromAndToDates("1", dtmFromDate, dtmToDate, dtmSelectedDate)

        dtmFromDate1 = CommonFunctions.Dates.GetDate(CType(dtmFromDate, Date))
        'dtmToDate1 = CommonFunctions.Dates.GetDate(CType(dtmToDate, Date))
        'dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 2, Date.Parse(dtmFromDate)))
        'integrated by harshada d on 19092005 for issue id 299
        ' code commented and added by harshada d for ALLIANCE issue 20412 : to take into consideration the startday of the week and weekDays from the table tbl_pm_companyInformation .
        'dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 2, Date.Parse(dtmToDate)))
        Dim intdayDiff As Integer ' this variable stores the no of weekEnd days .
        intdayDiff = 6 - CType(DateDiff("d", CDate(dtmFromDate), CDate(dtmToDate)), Integer)
        dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", intdayDiff, Date.Parse(dtmToDate)))
        ' end of addition by harshada d for ALLIANCE issue 20412 
        'end of integration by harshada d on 19092005 for issue id 299

        If Request.QueryString("Next") = "true" Then
            dtmSelectedDate = CommonFunctions.Dates.GetDate(DateAdd("d", 7, Date.Parse(dtmSelectedDate)))
            dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 7, Date.Parse(dtmFromDate)))
            dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 9, Date.Parse(dtmToDate)))
        End If

        If Request.QueryString("Previous") = "true" Then
            dtmSelectedDate = CommonFunctions.Dates.GetDate(DateAdd("d", -7, Date.Parse(dtmSelectedDate)))
            dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", -7, Date.Parse(dtmFromDate)))
            dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", -5, Date.Parse(dtmToDate)))
        End If

        ' Modified by NitinVS on 7 Dec 2005 for WhizibleSEM  SP5 IssueID 672

        Response.Write("<table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='100%'><td width='100%'>")
        Response.Write("<center>     From Date " + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , dtmFromDate1, , "frmDailyActivityWeeklyView", "..\..\images\Calendar.gif", , , , , , True, True, "../../Images/Star.gif", " onKeyPress=FromDate_onKeyPress(event)") + "      ")

        'Response.Write("To Date " + CommonFunctions.HTMLControls.DrawTextBox("ToDate", "ToDate", , 80, , dtmToDate1, , , True, , , , , True, , ) + "</center>")
        Response.Write("To Date " + CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , 80, dtmToDate1, , "frmDailyActivityWeeklyView", , , , True, True, , True) + "</center>")
        ' End Modification by NitinVS on 7 Dec 2005 for WhizibleSEM  SP5 IssueID 672

        Response.Write("</td></tr></table>")
        Response.Write("<BR>")


        'If Request.QueryString("Show") = "true" Then
        'If Request.QueryString("Show") <> "true" Then
        If Request.QueryString("FromDate") <> "" Then
            dtmFromDate = Request.QueryString("FromDate")
        Else
            dtmFromDate = dtmFromDate1
        End If
        If Request.QueryString("ToDate") <> "" Then
            dtmToDate = Request.QueryString("ToDate")
        Else
            dtmToDate = dtmToDate1
        End If

        'dtmFromDate = Request.QueryString("FromDate")
        'dtmToDate = Request.QueryString("ToDate")
        strSQLQuery = "EXEC usp_Sel_tbl_PM_DailyActivity_WeeklyView " & Session("intUserID").ToString & ", '" & dtmFromDate & "', '" & dtmToDate & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'strSQLQuery = "EXEC usp_Sel_tbl_PM_DailyActivity_WeeklyView 586,'" & dtmFromDate & "', '" & dtmToDate & "'"
        '--- Get the No of days between the Start Date and End Date
        'm_intNoOfDays = CType(DateDiff("d", CDate(m_dtFromDate), CDate(m_dtToDate)) + 1, Integer)
        m_intNoOfDays = 7
        dtCounterDate = CType(dtmFromDate, Date)
        'dtCounterDate = CommonFunctions.Dates.CGetDate(CType(dtmFromDate, Date))
        m_intDayCounter = 1
        'Response.Write(CDate(dtCounterDate))
        'Response.Write(CommonFunctions.Dates.GetDate(Date.Parse("2 / 24 / 2004")))

        '--- Calculate the width of the Day columns using the number of columns
        intWidth = CType(70 / (m_intNoOfDays + 1), Integer)


        strGroupByField = "ProjectName"
        strGroupByFieldValue = ""

        '-- Define the Actual Array and UserFriendly array..
        arrstrActualList.Add("ProjectName")
        arrstrUserFriendlyList.Add("Project")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=10%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("TaskName")
        arrstrUserFriendlyList.Add("Task Name")
        arrstrRowLinkField.Add("")
        'arrstrTDStyle.Add("style='width=" + CStr(intWidth + 10) + "%' align=left")
        arrstrTDStyle.Add("style='width=20%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        StartingDayOfWeek = CType(CommonFunctions.Data.GetDataScalar("SELECT StartingDayOfWeek FROM tbl_PM_CompanyInformation", MyBase.UseSQL), String)
        'If StartingDayOfWeek = 1 Then
        '    strStartingDayOfWeek = CType(vbSunday, FirstDayOfWeek)
        'End If
        'If StartingDayOfWeek = 2 Then
        '    strStartingDayOfWeek = CType(vbMonday, FirstDayOfWeek)
        'End If
        'If StartingDayOfWeek = 3 Then
        '    strStartingDayOfWeek = CType(vbTuesday, FirstDayOfWeek)
        'End If
        'If StartingDayOfWeek = 4 Then
        '    strStartingDayOfWeek = CType(vbWednesday, FirstDayOfWeek)
        'End If

        '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
        drHolidayLeave = CommonFunction.Data.GetDataReader("usp_sel_WeeklyView_HolidayORLeaveStatus " + Session("intUserID").ToString + ",'" + dtmFromDate.ToUpper + "'", True)
        drHolidayLeave.Read()
        For intCnt = 1 To 7
            IsHolidayOrLeave(intCnt - 1) = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drHolidayLeave("Day" + intCnt.ToString), False), False)
        Next
        '--- End addition Purvaj
        intWorkingDays = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drHolidayLeave("WorkingDays"), "5"), "5")
        '--- End addition PurvaJ

        CommonFunction.Data.DisposeDataReader(drHolidayLeave)

        For intCnt = 1 To m_intNoOfDays

            'Modified By VidyaJ - For IssueID - 299 - SP4
            strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            ''-- Set the WeekDays
            'If StartingDayOfWeek = "7" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "1" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbMonday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "2" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbTuesday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "3" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "4" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbThursday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "5" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbFriday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If
            'If StartingDayOfWeek = "6" Then
            '    strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSaturday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"
            'End If

            ' strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + CStr(GetShortDate(dtCounterDate))
            arrstrUserFriendlyList.Add(strWeekDayName)
            dtCounterDate = DateAdd("d", 1, dtCounterDate)
            arrstrActualList.Add("Day" + CStr(intCnt))
            arrstrRowLinkField.Add("")

            'arrstrTDStyle.Add("style='width=15%'")
            arrstrSummaryFunctionsList.Add("SUM")
            arrGroupSummaryFunctions.Add("SUM")
            arrIgnoreHTMLEncode.Add("True")
        Next intCnt

        arrstrActualList.Add("NormalAMH")
        arrstrUserFriendlyList.Add("Actual Hrs")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
        'arrstrTDStyle.Add("style='width=6' align=right")
        'arrstrTDStyle.Add("style='width=9%'")
        arrstrSummaryFunctionsList.Add("SUM")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrGroupOnColumn.Add("2")

        If dr.Read Then
            '--Plotting the Timesheet Details Grid's properties
            With m_objAdvGrid

                .GroupOnColumn = GetArray(arrstrGroupOnColumn)
                .ActualColumnArray = GetArray(arrstrActualList)
                .TDStyleArray = GetArray(arrstrTDStyle)
                .UserFriendlyColumnArray = GetArray(arrstrUserFriendlyList)
                .ColNameToolTipOnEachRow = True
                .NoOfDataColumns = GetArray(arrstrUserFriendlyList).GetLength(0)
                .RowLinkArray = GetArray(arrstrRowLinkField)
                .SQL = strSQLQuery

                .GroupSummaryFunc = GetArray(arrGroupSummaryFunctions)
                .SummaryFunctions = GetArray(arrstrSummaryFunctionsList)
                .ShowSummaryFunctions = True
                .NoOfDataColumns = 10
                .DIVID = "DivList"
                '.DIVHeight = 450
                '.DIVStyle = "overflow:auto"
                ' Commented By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 IssueID 672
                '.DIVStyle = "overflow:auto;width:780"
                ' End Commenting By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 IssueID 672
                .DIVHeight = 450

                .IgnoreHTMLEncode = GetArray(arrIgnoreHTMLEncode)
                .returnHTML = True
                .UseSQL = MyBase.UseSQL
                strGRID = .DrawGrid()
                Response.Write(strGRID)
            End With
            status = 1
        End If

        If status = 0 Then
            Response.Write("<DIV id=DivList style='overflow:auto;Height:450'><table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=middle>There is no items in this view.</td></tr></table></div>")
        End If
        '--- added By purvaJ on 6 Nov 2008 for Holiday leave whiziblesem8.0 
        CommonFunction.General.WriteHTML("<TABLE class='clsTable' CellSpacing='0' width='99.9%'><tr class='clsTREven' width='99.9%'><td width='100%' align=left>Days in <FONT color=red>RED </FONT> indicates non-working day (Holiday, Leave or Weekend).</td></tr></table> ")
        '--- end addition purvaj

        Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))

        ' End If
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub

    Function GetShortDate(ByVal dTDate As Date) As String
        '=====================================================================
        ' Procedure Name        : GetShortDate()	
        ' Purpose               : Returns the day for the date passed to this function
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 25 Apr 2005
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True) + " " + CType(intDate, String)

        GetShortDate = strMonth

    End Function
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VivekP
        ' Created               : 25 Apr 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Public Sub New()
        MyBase.ApplySecurity()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    '--- added By purvaJ on 6 nov 2008 whiziblesem8.0 for Holiday or leave changes
    Private Sub m_objAdvGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objAdvGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex >= 2 And Args.ColIndex < 9 Then
            If IsHolidayOrLeave(Args.ColIndex - 2) = True Or Args.ColIndex - 2 > intWorkingDays - 1 Then
                Args.TDStyle = "style='color:red;text-align:right;'"
            End If
        End If
    End Sub
    '--- End addition purvaJ
End Class
