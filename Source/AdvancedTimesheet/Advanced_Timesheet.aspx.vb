'=====================================================================
' Module Name   :   Advance Timesheet
' Purpose       :   To Display the Details of timesheet (DA)
' Description   :   Same as above
' Dependencies  :   Resource file for the same
' Author        :   PrashantSJ
' Created       :   Jan 21, 2009
' Revisions     :
'=====================================================================
#Region " Imports "
Imports System.Text
#End Region
Public Class Advanced_Timesheet
    Inherits WebPages.Template.WhizTemplate
#Region " Member variables "

    Protected m_SBHTML As StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights

    Private dsDayHeader As DataSet

    Protected strSQL As String = ""
    Protected m_strSQL As String = ""
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strUserName As String = ""
    Protected m_strProjectID As String = ""
    Protected WithEvents calendar As System.Web.UI.WebControls.Calendar
    Protected m_strTabSection As String = "1"
    Protected m_strInputDate As String = ""

    Protected m_arrDateList As New ArrayList
    Protected m_arrActualDates As New ArrayList

    Protected dsTask As DataSet
    Protected dsTemp As DataSet
    Protected htTab As New Hashtable
    Protected m_strPeriod As String = ""

    Private m_strSelectedTaskType As String = ""
    Private m_strTaskFilter As String = ""
    Public m_strSessionUserID As String = ""
    Public m_strFromWhere As String
    Private m_strSessionPostID As String = ""
    Private m_strSessionProjectID As String = ""
    Private m_strDefaultProjectID As String = ""
    Private m_strProjectFilters As String = ""
    Private m_strWhere As String = ""
    Private m_strReqStartDate As String = ""

    Protected m_intPageNumber As Integer = 0
    Protected m_intRowCount As Integer = 0
    Protected dblRatio As Double = 0.0

    Private m_blnTaskEditable As Boolean
    Private m_strTSAction As String = "" 'Timesheet action (GS for generate and save,RS for Regenerate and save,G for generate and R for Regenerate,S for send for approval)
    Private m_blnTimesheetEntryCombo As Boolean
    Private m_strTimesheetFrequency As String = ""
    '---   Protected Variables   ---
    Protected m_strWindowTitle As String
    Protected strPaging As New StringBuilder

    Protected m_whichGrid As String
    Protected m_strHtmlAfterForm As New System.Text.StringBuilder
    Protected m_intStartingDayOfWeek As Integer = 0
    Protected m_intCurrentDayOfWeek As Integer = 0
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date
    Protected m_strCurrentDate As String = ""
    Protected m_strProjectsOnHold As String = ""
    Protected m_strProjectsOnHoldMsg As String = ""
    Protected m_strBackdatingExpiry As String = ""
    Protected m_strFwddatingExpiry As String = ""
    Protected m_strHoursValidation As String = ""
    Protected m_TotalWeekHours As Double = 0
    Protected m_strJavaScript As String = ""
    Protected m_blnRestrict_MPPTasks As Boolean
    Protected m_blnRestrict_AssignedTasks As Boolean
    Protected m_strDAID As String 'DailyActivityEntryID
    Protected m_strShowDetails As String = ""
    Protected m_strDetail As String = ""
    Protected m_blnActualWorkHrs As Boolean = CommonFunction.Application.TimesheetEntryCombo
    Protected m_blnProjectBackdateEntry As Boolean
    Protected m_blnProjectFwddateEntry As Boolean
    Protected m_strDay As String = ""
    Protected m_strTimeSheetID As String = ""
    Protected m_strBrowserName As String
    Protected m_dblActualHrs As Double = 0
    Protected m_dblExpectedHrs As Double = 0
    Protected m_strDivHeight As String = ""

    Protected m_blnRedirectToDA As Boolean

    Protected m_strshowDetailTaskID As String
    Protected mstrStatus As String

    Protected m_strListWeekHrs As New StringBuilder
    Protected m_arrNWHrs() As String
    Protected j As Integer = 0
    Protected arrTaskHrs() As String
    Protected htNWTaskHrs As New Hashtable

    Protected m_dblEntryDay1 As Double = 0
    Protected m_dblEntryDay2 As Double = 0
    Protected m_dblEntryDay3 As Double = 0
    Protected m_dblEntryDay4 As Double = 0
    Protected m_dblEntryDay5 As Double = 0
    Protected m_dblEntryDay6 As Double = 0
    Protected m_dblEntryDay7 As Double = 0
    Protected m_htListHoliday As New Hashtable
    Protected m_strFromDate As String = ""
    Protected m_strIsFilter As String = ""
    Protected dsTheme As DataSet
    Protected m_strThemeID As String = ""
    Protected m_arrThemeCOL As New ArrayList
    Protected m_arrCOL() As String
    Protected blnIsGrouping As Boolean

    Protected m_iStartingDayOfWeek As Integer = CommonFunction.Application.StartingDayofweek
    Protected m_intWorkingDays As Integer = 5
    Protected drUserHolidays As IDataReader
    Protected m_strHolidayList As String = ""
    Protected m_arrHolidays() As String

    Protected m_strLeaveList As String = ""
    Protected m_arrLeaves() As String
    Protected m_arrLeavesFromTo() As String
    Protected m_strHidInputDate As String = ""
    Protected m_blnIsCalenderDateSelected As Boolean = False

#End Region
#Region "Constants"
    Protected Const TD_WIDTH_1 As String = "96"
    Protected Const TD_WIDTH_2 As String = "40"
    Protected Const TD_WIDTH_3 As String = "145"
    Protected Const TD_WIDTH_4 As String = "45"
    Protected Const TD_HEIGHT_1 As String = "66"
    Protected Const TD_HEIGHT_2 As String = "25"
    Protected Const TD_HEIGHT_3 As String = "0"

    '---   Constants   ---
    Private Const TASKS_FOR_THE_WEEK As Integer = 6
    Private Const PROJECT_SPECIFIC_TASKS As String = "M"
    Private Const ALL_TASKS As Integer = 5
    Private Const GENERAL_TASKS As String = "D"
    Private Const ASSIGNED_TASKS As String = "O"
    Private Const DEFECTS_ASSIGNED As String = "B"
    Private Const ALL_TASK_TYPES As String = "A"
    Private Const DEFAULT_TIMESHEET_FREQUENCY As String = "W"
    '-----------------------------------------------------
    Protected Const ERROR_COLOR As String = "#ff0000"
    Protected Const WARNING_COLOR As String = "#ffff00"
    Protected Const DISABLED_COLOR As String = "white" ''"#d3d3d3"
    Protected Const CellColor As String = "#b0c4de"  '"#a9a9a9"   ' 
    Protected Const MOVE_PREVIOUS As String = "PREV"
    Protected Const MOVE_NEXT As String = "NEXT"
    Protected Const SAVE_MOVE_NEXT As String = "SAVE_NEXT"
    Protected Const SAVE_MOVE_PREVIOUS As String = "SAVE_PREV"
    Protected Const ERROR_IMAGE As String = "../../Images/red.gif"
    Protected Const WARNING_IMAGE As String = "../../Images/green.gif"

    Protected Const PAGE_SIZE As Integer = 10


#End Region
#Region "Tab Enum"
    Protected Enum TabIndex
        Day
        Week
        NextWeek
        PreviousWeek
        ToDay
        ApplyToNextWeek
    End Enum
#End Region
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        '====================================================================
        ' Procedure Name    :      PageInit
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        GetGlobalObject()

        'GetTagAccessRights()

        InitializeVariables()

        If m_strMode.ToUpper = "SAVE" Then
            ProcessSave()
            'RedirectToDA
            'If m_blnRedirectToDA = True Then
            '    Server.Transfer("../PM/PM_DailyActivity.aspx", False)
        ElseIf m_strMode.ToUpper = "DEFAULTTHEME" Then
            ProcessDefaultTheme()
        End If

        GetDatabaseValues()

        Response.Write("<div Id=divPage Style='OVERFLOW:auto; width:100%;'>")

        DrawHiddenFields()

        DrawThemes()

        ''''Master 
        ' DrawMenu()
        ' DrawSections()

        'GetPageLegend()

        'DrawHeader()

        ' DrawPageCaption()

        DrawFilters()



        DrawPaging()


        DrawCurrentFilters()

        ' DrawTotalWeekTitle()

        Response.Write(GenerateTabSections.ToString)
        'DrawPage()

        'DrawMenu()

    End Sub
    'Added By Nilesh g ON 28-01-2016 For PkToken Validation 
    ''Commented and Added by Dhanashri S on 11 Aug 2016
    '<System.Web.Services.WebMethod> _
    'Public Shared Function GenrateURLToken_ShowDetails_OnClick(TaskDAID As String, Detail As String, hdnStartDate As String, Day As String, ShowDetails As String, MasterTagID As String) As String
    '    Dim m_PKToken_ShowDetails_Multiple As String
    '    m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskDAID, String) + CType(Detail, String) + CType(hdnStartDate, String) + CType(Day, String) + CType(ShowDetails, String) + CType(MasterTagID, String) + "0" + "0")

    '    Return m_PKToken_ShowDetails_Multiple

    'End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowDetails_OnClick(TaskDAID As String, EmployeeID As String, MasterTagID As String, Detail As String, hdnStartDate As String, Day As String, ShowDetails As String) As String
        Try
            Dim m_PKToken_ShowDetails_Multiple As String
            m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskDAID, String) + CType(EmployeeID, String) + CType(MasterTagID, String) + "0" + "0" + CType(Detail, String) + CType(hdnStartDate, String) + CType(Day, String) + CType(ShowDetails, String))

            Return m_PKToken_ShowDetails_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Addition by Dhanashri S on 11 Aug 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowDetail_OnClick(TaskDAID As String, EmployeeID As String, Detail As String, hdnStartDate As String) As String
        Try
            Dim m_PKToken_ShowDetails As String
            m_PKToken_ShowDetails = CommonFunctions.Security.Token.GetToken(CType(TaskDAID, String) + CType(EmployeeID, String) + "0" + "0" + CType(Detail, String) + CType(hdnStartDate, String))

            Return m_PKToken_ShowDetails
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    'End Of Addition By Nilesh g ON 28-01-2016 For PkToken Validation 
    Private Sub DrawSections()
        m_SBHTML = New StringBuilder
        Dim arrSection() As String = {"DA", "My Timesheet", "Timesheet Approval"}
        Dim i As Integer = 0

        m_SBHTML.Append("<TABLE  BORDER=0 cellspacing=0   class=clsTable><TR> ")

        For i = 0 To arrSection.Length - 1
            m_SBHTML.Append("<TD  class='clsTDBlank' valign='bottom' align=center noWrap Title='" + arrSection(i) + "'>")
            m_SBHTML.Append("<A id=hrf_" + arrSection(i).ToString + " class='ADVnavtab' href='JavaScript:Section_OnClick()'>" + arrSection(i) + "</A>")
            m_SBHTML.Append("</TD>&nbsp;&nbsp;&nbsp;")
        Next
        m_SBHTML.Append("<hr style='color:lightblue;height:1px' valign='top'>")
        m_SBHTML.Append("</TR></TABLE>")



        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawCurrentFilters()
        '====================================================================
        ' Procedure Name    :      DrawCurrentFilters
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get current filters
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        m_SBHTML.Append("<table id='tblFilter'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")

        m_SBHTML.Append("<td class='clsTDBlankNew'  align='left' valign='bottom' >")
        m_SBHTML.Append("<a id='imgFilter' onclick='javascript:Filter_OnClick(1,event)' title='Apply Filter' style='text-decoration:underline;'><b>Filters :</b></a>")
        m_SBHTML.Append("&nbsp;<label id='lblFilter' ></label>")
        m_SBHTML.Append("&nbsp;<a href='javascript:applyFilter(1)' ><Img Border=0 style='text-decoration:none;'  src='../../Images/cssImages/Link images/Clearfilter.gif' alt='Clear Filter' /></a>")
        m_SBHTML.Append("</td>")
        'm_SBHTML.Append("<td class='clsTDBlankNew'  align='right' valign='bottom' >")
        'm_SBHTML.Append("<a href='javascript:DefaultTheme_OnClick()'/><font color='blue'>Set As Default View</font></a>")
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("</tr>")
        'm_SBHTML.Append("<tr class='clsTRBlank'>")
        m_SBHTML.Append(GetPagingString())
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        ''m_SBHTML.Append("</br>")
        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub GetDatabaseValues()
        '====================================================================
        ' Procedure Name    :      GetDatabaseValues
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get database values (e.g. after SAVE)
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================


        strSQL = "usp_Sel_tbl_PM_ProjectTasks_WeeklyView " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString & "','" & m_dtEndDateOfWeek.ToString & "'"


        If m_strSelectedTaskType = ALL_TASK_TYPES Then

            strSQL = strSQL + ",NULL"
        Else
            strSQL = strSQL + ",'" & m_strSelectedTaskType & "'"
        End If
        strSQL = strSQL + "," & m_strTaskFilter & ",'" & m_strProjectFilters & "'"

        dsTemp = CommonFunction.Data.GetDataSet(strSQL, "TEMP", , , MyBase.UseSQL)

        m_intRowCount = dsTemp.Tables(0).Rows.Count

        ''  If m_intRowCount < PAGE_SIZE Then : m_intPageNumber = 0 : End If

        Dim intStartRecord As Integer = 0

        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)


        If m_intPageNumber = -1 Then
            dsTask = CommonFunction.Data.GetDataSet(strSQL, "TASK", , , MyBase.UseSQL)
        Else
            dsTask = CommonFunction.Data.GetDataSet(strSQL, "TASK", intStartRecord, PAGE_SIZE, MyBase.UseSQL)
        End If



        strSQL = "usp_Sel_Timesheet_Themes " & m_strSessionUserID
        dsTheme = CommonFunction.Data.GetDataSet(strSQL, "THEME", , , MyBase.UseSQL)

        strSQL = "usp_Sel_Employee_Holidays " & m_strSessionUserID & ",'" & m_strInputDate & "'"
        drUserHolidays = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drUserHolidays.Read Then
            m_intWorkingDays = CType(CommonFunction.Data.CheckIsDBNull(drUserHolidays("WorkingDays"), "5"), Integer)
            m_strHolidayList = CType(CommonFunction.Data.CheckIsDBNull(drUserHolidays("HolidayList"), ""), String)
            m_strLeaveList = CType(CommonFunction.Data.CheckIsDBNull(drUserHolidays("LeaveList"), ""), String)
        End If

        CommonFunction.Data.DisposeDataReader(drUserHolidays)
        If m_strHolidayList <> "" Then
            m_arrHolidays = m_strHolidayList.Split(","c)
        End If

        If m_strLeaveList <> "" Then
            m_arrLeaves = m_strLeaveList.Split(","c)
        End If

    End Sub
    Protected Function GenerateTabSections() As String
        '====================================================================
        ' Procedure Name    :      GenerateTabSections
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw tab sections (e.g. Day,Week etc.).
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        'Dim arrTabName() As String = {"Day", "Previous Week", "Week", "Next Week", "Pull Previous Week"}
        'Dim arrTabToolTip() As String = {"Day", "Previous Week", "Week", "Next Week", "Pull Previous Week"}
        'Dim arrTabOnClickFun() As String = {"Tab_OnClick(0)", "Tab_OnClick(2)", "Tab_OnClick(1)", "Tab_OnClick(3)", "Tab_OnClick(5)"}
        Dim arrTabName() As String = {"Today", "Day", "<img src='../../Images/Home/ScrollLeft.gif' border=0 />", "Week", "<img src='../../Images/Home/ScrollRight.gif' border=0 />", "Pull Previous Week"}
        Dim arrTabToolTip() As String = {"Today", "Day", "Previous Week", "Week", "Next Week", "Pull Previous Week"}
        Dim arrTabOnClickFun() As String = {"Tab_OnClick(4)", "Tab_OnClick(0)", "Tab_OnClick(2)", "Tab_OnClick(1)", "Tab_OnClick(3)", "Tab_OnClick(5)"}

        Dim m_SB As New System.Text.StringBuilder
        Dim strTabSection As String = ""

        If m_strTabSection = "2" Or m_strTabSection = "3" Then
            strTabSection = "1"
        Else
            strTabSection = m_strTabSection
        End If

        'If m_strThemeID = "3" Then
        '    ReDim arrTabName(1), arrTabToolTip(1), arrTabOnClickFun(1)
        '    arrTabName(0) = "Previous Week"
        '    arrTabName(1) = "Week"

        '    arrTabToolTip(0) = "Previous Week"
        '    arrTabToolTip(1) = "Week"

        '    arrTabOnClickFun(0) = "Tab_OnClick(2)"
        '    arrTabOnClickFun(1) = "Tab_OnClick(1)"
        'End If

        Dim i As Integer = 0

        m_SB.Append("<TABLE class=clsTable cellspacing=0 width='100%' cellpadding=0>")
        m_SB.Append("<TR>")
        ''width='20%'
        m_SB.Append("<td valign='bottom' align='left'  class='clsTDBlank' width='25%'><a onclick='Pane_Onclick()' style='cursor:pointer;'><img id=imgPane src='../../Images/cssImages/arrow_blue_left.gif' border=0 align='center' alt='Hide Calendar' /></a> ")
        ' m_SB.Append("&nbsp;&nbsp;<input type=button valign='top' id='btnToday' title='" + CommonFunction.Dates.GetDate(Date.Today) + "' value='Today' onclick='Tab_OnClick(4)'/>&nbsp;")

        '' 

        ''PrashantSJ on 10th Feb 2009
        ''m_SB.Append("<td valign='bottom' align='right' width='20%' noWrap Title='Timesheet Period' class='clsTDBlank' >")
        m_SB.Append("&nbsp;<b><label title='Timesheet Period'><b>")
        '' m_SB.Append("<input type=button valign='top' id='btnToday' title='" + CommonFunction.Dates.CGetDate(Date.Today) + "' value='Today' onclick='Tab_OnClick(4)'/>&nbsp;<b>")
        m_SB.Append(m_strPeriod)
        m_SB.Append("</b></label>")
        m_SB.Append("</td>")
        ''
        '''' m_SB.Append(GetPagingString())

        m_SB.Append("<td class='clsTDBlank' valign='bottom' align='left' noWrap  width='20%'  title='Apply given number (hrs) to all tasks' >Actual Work (hrs)&nbsp;")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        m_SB.Append(CommonFunction.HTMLControls.DrawTextBox("txtWorkHours", "txtWorkHours", , 50, , , "right", , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        'm_SB.Append("&nbsp;<input type=button id='btnApply' width=20 hight=20 value='Apply To All' onclick='Apply_OnClick()'/>&nbsp;")
        m_SB.Append("&nbsp;|<a href='javascript:Apply_OnClick(0)'/><font color='blue'>Apply To All</font></a>|")
        m_SB.Append("&nbsp;<a href='javascript:Apply_OnClick(1)'/><font color='blue'>Clear All</font></a>|")
        m_SB.Append("</td>")

        'm_SB.Append("<td class='clsTDEven' valign=bottom align='right' noWrap  width='20%' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        'm_SB.Append(DrawPaging())
        'm_SB.Append("</td>")

        m_SB.Append("<TD valign='bottom' align=right width='40%'>")
        m_SB.Append("<TABLE  cellSpacing=2 cellPadding=1 border=0 class='clsTable'><TR> ")

        For i = 0 To arrTabName.Length - 1

            'If i = 4 And (m_objGlobal.LoginType.ToUpper = "E" And m_objGlobal.RoleLevel = 3) Then
            '    Exit For
            'End If

            'id=td_" + arrTabName(i).ToString + "
            m_SB.Append("<TD valign='baseline'  align=center noWrap Title='" + arrTabToolTip(i) + "'>")
            ' m_SB.Append("<TD class='navMenu' align='center'  >")
            If CommonFunction.General.CheckIsNothing(htTab.Item(strTabSection)).ToString = arrTabName(i).ToString Then
                If m_strTabSection = "2" Or m_strTabSection = "3" Then
                    m_SB.Append("<A id='select'  style='text-decoration:none;' href='JavaScript:" + arrTabOnClickFun(i) + "'>" + arrTabName(i) + "</A>")
                Else
                    m_SB.Append("<span id='select'>" + arrTabName(i).ToString + "</span>")
                End If
            Else
                ' class='navtab'
                'id=hrf_" + arrTabName(i).ToString + "
                m_SB.Append("<A  class='NEWnavtab' style='text-decoration:none;' href='JavaScript:" + arrTabOnClickFun(i) + "'>" + arrTabName(i) + "</A>")
            End If
            m_SB.Append("</TD>")

        Next
        ' m_SB.Append(GetPagingString())
        m_SB.Append("</TR></TABLE>")
        m_SB.Append("</TD></TR>")

        m_SB.Append("</TABLE>")


        Return m_SB.ToString

        m_SB = Nothing

    End Function
    Private Sub DrawPaging()
        '====================================================================
        ' Procedure Name    :      DrawPaging
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw paging for DA part.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================


        strPaging = New StringBuilder


        strPaging.Append("<TABLE id='tblCurrentFilter'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        strPaging.Append("<TR class=clsTRBlank>")

        strPaging.Append(GetPageCaption())

        strPaging.Append("<td valign='top' class=clsTDBlankNEW align='center' >")
        'strPaging.Append("|&nbsp;")
        'strPaging.Append("<a  class='navtabMenu' onclick='javascript:Filter_OnClick(1,event)' ><Img  Border=0 id=imgFilter src='../../Images/cssImages/Link images/Filter.gif' alt='Show Filter' /></a>")
        'strPaging.Append("&nbsp;")
        strPaging.Append("<a  onclick='javascript:ShowTheme(1,event)' ><Img  Border=0 id=imgTheme src='../../Images/TreeNodeImages/Expense-Report.gif' alt='Select view' /></a>")
        strPaging.Append("&nbsp;")
        'strPaging.Append("<a  class='navtabMenu' href='javascript:Help_OnClick(""3986 "")' ><Img  Border=0 src='../../Images/cssImages/Link images/help.gif' alt='Help'></a>&nbsp;")
        'strPaging.Append("&nbsp;")
        'strPaging.Append("</td>")

        'strPaging.Append("<td class='clsTDBlankNew'  align='right' valign='bottom' >")
        strPaging.Append("<a href='javascript:DefaultTheme_OnClick()'/><font color='blue'>Set As Default View</font></a>")
        strPaging.Append("</td>")

        strPaging.Append("<td valign='bottom' class=clsTDBlankNEW align='right' >")
        ' If m_objAccessRights.Add Or m_objAccessRights.Edit Then
        strPaging.Append("<label id=lblSave ><input type=button id='btnApply'  value='Save' onclick='Save_OnClick()'/>")
        strPaging.Append("&nbsp;</label>")
        ' End If
        strPaging.Append("</td>")


        strPaging.Append("</tr>")
        strPaging.Append("</table>")
        strPaging.Append("</br>")

        Response.Write(strPaging.ToString)

        strPaging = Nothing
        ' End If
    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name    :      DrawHeader
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw heade part.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        Dim sbHeader As New StringBuilder

        sbHeader.Append("<div Id=divHeader Style='OVERFLOW:auto; width:100%; display:none;'>")
        sbHeader.Append("<table id=tblHeader cellpadding=0 cellspacing=1 class='clsTable' style='OVERFLOW:auto;width:100%;' >")
        sbHeader.Append("<tr class='clsTRBlank' >")
        sbHeader.Append("<td valign='top' class='clsTDBlank' align='left'>")
        sbHeader.Append(DrawCommonQuestion())
        sbHeader.Append("</td>")
        sbHeader.Append("&nbsp;&nbsp;<td valign='top' class='clsTDBlank' align='center'>")
        sbHeader.Append(DrawAlerts())
        sbHeader.Append("</td>")
        sbHeader.Append("</tr>")
        sbHeader.Append("</table>")
        sbHeader.Append("</div>")

        Response.Write(sbHeader.ToString)
        sbHeader = Nothing
    End Sub
    Private Function DrawCommonQuestion() As String
        '====================================================================
        ' Procedure Name    :      DrawCommonQuestion
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw common question.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================

        Dim m_HTML As New StringBuilder

        ''m_SBHTML.Append("<div Id=divCQ Style='OVERFLOW:auto; width:100px; height:100px;'>")
        m_HTML.Append("<table id=tblCQ cellpadding=0 cellspacing=1 class='clsGridTable' width='200px' height='150px' >")
        m_HTML.Append("<tr class='clsTREven' >")
        m_HTML.Append("<td height='20px' align='left'>")
        m_HTML.Append("&nbsp;<b>Common Questions</b></td>")
        m_HTML.Append("</tr>")
        m_HTML.Append("<tr class='clsTRBlank'>")
        m_HTML.Append("<td align='left' class='clsTDBlank' >")
        m_HTML.Append("&nbsp;</td>")
        m_HTML.Append("</tr>")
        m_HTML.Append("</table>")
        '' m_SBHTML.Append("</div>")

        Return m_HTML.ToString

        m_HTML = Nothing

    End Function
    Private Function DrawAlerts() As String
        '====================================================================
        ' Procedure Name    :      DrawAlerts
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw alert.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<table id='tblAlert' cellpadding=0 cellspacing=1 class='clsGridTable' width='700px' height='75px' >")
        m_SBHTML.Append("<tr align='left' class='clsTRBlank' >")
        m_SBHTML.Append("<td valign='top' align='left' class='clsTDBlankNEW' >")
        m_SBHTML.Append("<img border=0 	src='../../Images/warning_32.gif' width='32' height='32' /><br><br><br><br><br>")
        m_SBHTML.Append("|&nbsp;<a valign='bottom' align='left' href='javascript:RemoveAlert_OnClick()' ><font color='blue' >Remove message</font></a>&nbsp;|")
        m_SBHTML.Append("&nbsp;</td>")
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")

        Return m_SBHTML.ToString
        m_SBHTML = Nothing
    End Function
    Protected Sub DrawPage()
        '====================================================================
        ' Procedure Name    :      DrawPage
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw detail page with calender and calender details view.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder


        Dim i As Integer = 0, j As Integer = 0
        Dim TBC As Integer = 1

        Dim blnRecordPresent As Boolean = False
        Dim drGrid As IDataReader
        Dim strOldProjectName As String = "", strProjectName As String = "", strOldProjectID As String = ""
        Dim strOldTaskType As String = "", strTaskType As String = ""
        Dim strProjectID As String = "", strTaskName As String = "", strTaskID As String = ""
        Dim strActualPercentComplete As String = ""
        Dim strWhichTask As String
        Dim strTaskStartDate As String
        Dim strTaskEndDate As String
        Dim strTaskActualStartDate As String
        Dim strActualEndDate As String
        Dim strMaxEntryDate As String
        Dim strConstraintType As String
        Dim strConstraintDate As String
        Dim blnTaskComplete As Boolean
        Dim dblAllocatedWork As Double
        Dim dblActualWork As Double
        Dim dblWorkDone As Double
        Dim dblActualTotal As Double = 0
        Dim dblActualTotalAll As Double = 0
        Dim blnResourceLevelTaskCompletion As Boolean

        Dim lngRowNo As Long = -1, lngTaskRowNo As Long = 0
        Dim arrTaskTotal() As Double = {0, 0, 0, 0, 0, 0, 0}
        Dim arrProjectTotal() As Double = {0, 0, 0, 0, 0, 0, 0}
        Dim arrDA_ID() As Double = {0, 0, 0, 0, 0, 0, 0} 'array for dailyActivityEntryID
        Dim blnTimeBookedAgainstTask As Boolean

        FillThemeColumns()

        Dim strTStatus As String
        strTStatus = mstrStatus

        If IsNothing(strTStatus) = True Or strTStatus = "" Then
            strTStatus = "N"
        End If
        If m_strThemeID = "1" Then
            blnIsGrouping = True
        End If

        'm_SBHTML.Append(GenerateTabSections.ToString)
        ' m_SBHTML.Append("<div Id=divPage Style='OVERFLOW:auto; width:100%;'>")
        m_SBHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
        m_SBHTML.Append("<tr class='clsTRBlank' valign='middle'>")

        For j = 0 To m_arrCOL.Length - 1

            If m_arrCOL(j).ToUpper = "<WEEK_DAYS>" Then
                For i = 0 To m_arrDateList.Count - 1
                    m_SBHTML.Append("<td width='" + TD_WIDTH_2 + "' align=center  title='" + CommonFunction.Dates.GetDate(CType(m_arrActualDates.Item(i), Date)) + "' height='" & TD_HEIGHT_1 & "' class='clsTDBlankNew'>")
                    m_SBHTML.Append(m_arrDateList.Item(i).ToString)
                    m_SBHTML.Append("</td>")
                Next
            Else
                m_SBHTML.Append("<td width='" + TD_WIDTH_1 + "' align=center height='" & TD_HEIGHT_1 & "' class='clsTDBlankNew'>")
                If m_strTabSection = "0" Or m_strTabSection = "4" And m_arrThemeCOL.Contains("Actual<br>Work (hrs) this week") Then
                    m_SBHTML.Append(m_arrCOL(j).Replace("week", "day"))
                Else
                    m_SBHTML.Append(m_arrCOL(j))
                End If
                m_SBHTML.Append("</td>")
            End If
        Next

        m_SBHTML.Append("</tr>")

        For Each drTask As DataRow In dsTask.Tables(0).Rows
            blnRecordPresent = True
            '-----Reading from data reader------------------------------
            Dim arrDA(m_arrDateList.Count) As String

            strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), ""))
            strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), "0"))
            strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drTask("TaskName"), ""))
            strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drTask("TaskID"), "0"))
            strTaskType = CStr(CommonFunctions.Data.CheckIsDBNull(drTask("WhichTask"), "0"))
            blnResourceLevelTaskCompletion = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ResourceLevelTaskCompletion"), "0"), Boolean)
            strMaxEntryDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("MaxEntryDate"), "0"), String)
            '---------------------------------------------------------------------
            strTaskStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("StartDate"), ""), String)
            strTaskEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("EndDate"), ""), String)
            strTaskActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualStartDate"), ""), String)
            strActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualEndDate"), ""), String)
            blnTaskComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTask("IsTaskComplete"), "0"), Boolean)
            dblAllocatedWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("Work"), "0"), Double)
            dblActualWork = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), "0"), Double)
            dblWorkDone = CType(CommonFunctions.Data.CheckIsDBNull(drTask("WorkDone"), "0"), Double)
            strConstraintType = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ConstraintType"), ""), String)
            strConstraintDate = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ConstraintDate"), ""), String)

            If m_strDefaultProjectID = "" Then
                m_strDefaultProjectID = strProjectID
            End If
            '-------Draw Task Total----------------------------------------------------------------
            If strOldProjectID <> strProjectID And blnIsGrouping Then
                If strOldProjectID <> "" Then
                    lngRowNo += 1
                    m_SBHTML.Append(DrawTaskTotal_2(strProjectID, arrTaskTotal, dblActualTotal, strOldProjectName))
                    ResetToZero(arrTaskTotal)  ' reset task total array
                    dblActualTotal = 0
                End If
            End If
            '-----------------------------------------------------------------------
            For i = 0 To m_arrDateList.Count - 1
                ' For i = 0 To 6
                arrDA(i) = CStr(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drTask((i + 1).ToString), ""), ""))
                arrDA_ID(i) = 0 'CDbl(CommonFunctions.Data.CheckIsDBNull(drGrid("DA" + (i + 1).ToString), "0")) 'DailyActivityEntryID
                If blnIsGrouping Then
                    dblActualTotal += CDbl(IIf(arrDA(i) = "", 0, arrDA(i))) 'project wise total
                    dblActualTotalAll += CDbl(IIf(arrDA(i) = "", 0, arrDA(i))) 'Total for all projects
                    'Modified By VidyaJ - SP8 Performance
                    arrTaskTotal(i) += CDbl(CommonFunctions.Data.CheckIsDBNull(drTask((i + 1).ToString), "0")) 'project wise total
                    arrProjectTotal(i) += CDbl(CommonFunctions.Data.CheckIsDBNull(drTask((i + 1).ToString), "0")) 'Total for all projects
                End If
            Next
            '-----------------------------------------------------------------------
            If blnResourceLevelTaskCompletion Then
                strActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualPercentComplete"), "0"), String)
            Else
                strActualPercentComplete = CType(CommonFunctions.Data.CheckIsDBNull(drTask("ResourcePercentComplete"), "0"), String)
            End If
            '-------------------------------
            If strTaskActualStartDate <> "" Then
                blnTimeBookedAgainstTask = True
            Else
                blnTimeBookedAgainstTask = False
            End If
            '------Project Grouping--------------------------------------
            If strOldProjectID <> strProjectID Then
                m_SBHTML.Append("<TR class='clsTRSectionHeader' >")
                m_SBHTML.Append("<TD align='left' colspan='13' class='clsTDBlankNew'>")
                m_SBHTML.Append("<b>" + strProjectName)
                m_SBHTML.Append("</TD>")
                m_SBHTML.Append("</TR>")
            End If

            m_SBHTML.Append(DrawTaskDetail_2(strProjectID, strTaskName, strTaskID, strActualPercentComplete, lngRowNo, arrDA, dblAllocatedWork, dblActualWork, dblWorkDone, blnTaskComplete, strTaskStartDate, strTaskEndDate, strTaskType _
               , strMaxEntryDate, blnResourceLevelTaskCompletion, strTaskActualStartDate, strActualEndDate _
               , strConstraintType, strConstraintDate, False, arrDA_ID, strProjectName, strTStatus))

            'm_SBHTML.Append("<tr class='clsTRBlank'>")
            'm_SBHTML.Append("<td class='clsTDBlank' align='left' width='" + TD_WIDTH_3 + "'>")
            'm_SBHTML.Append(CommonFunction.Data.CheckIsDBNull(drTask("TaskName")).ToString)
            'm_SBHTML.Append("</td>")
            'm_SBHTML.Append("<td align='center' width='" + TD_WIDTH_4 + "'>")
            'm_SBHTML.Append("&nbsp;</td>")
            'm_SBHTML.Append("<td align='center' width='" + TD_WIDTH_4 + "'>")
            'm_SBHTML.Append("&nbsp;</td>")
            'For i = 0 To m_arrDateList.Count - 1
            '    m_SBHTML.Append("<td align='center' width='" + TD_WIDTH_4 + "'>")
            '    m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHr" + TBC.ToString, "txtHours", , 45, , , "right", , , , , , "onfocus=txtHr_OnFocus(this) onblur=txtHr_OnBlur(this)", True))
            '    TBC += 1
            '    'If i <> 0 Then
            '    '    m_SBHTML.Append("&nbsp;<a href=CopyHr('L') title='Copy To Left'><img src='../../Images/arrow_left.gif' border=0 /></a>")
            '    'End If

            '    'If i <> m_arrDateList.Count - 1 Then
            '    '    m_SBHTML.Append("<a href=CopyHr('R') title='Copy To Right'><img src='../../Images/arrow_right.gif' border=0 /></a>")
            '    'End If

            '    m_SBHTML.Append("</td>")
            'Next
            'm_SBHTML.Append("<td align='center'width='" + TD_WIDTH_4 + "' >")
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtAPC", "txtAPC", , 40, , "0.00", "right", , , , , , "align=right", True, True))
            'm_SBHTML.Append("</td>")

            'm_SBHTML.Append("<td align='center' width='" + TD_WIDTH_2 + "'>")
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkIsTaskComplete", "chkIsTaskComplete", , , , , , True))
            'm_SBHTML.Append("</td>")

            'm_SBHTML.Append("<td align='right' width='" + TD_WIDTH_4 + "'>")
            'm_SBHTML.Append("&nbsp;</td>")
            'm_SBHTML.Append("</tr>")

            strOldProjectID = strProjectID
            strOldProjectName = strProjectName
            strOldTaskType = strTaskType

            'Added By VidyaJ - SP8 Performance
            Dim strBackDating As String
            Dim strForwardating As String
            If CType(CommonFunctions.Data.CheckIsDBNull(drTask("IsBackDating"), "0"), Boolean) = False Then
                strBackDating = "false"
            Else
                strBackDating = "true"
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drTask("IsForwardDating"), "0"), Boolean) = False Then
                strForwardating = "false"
            Else
                strForwardating = "true"
            End If


            m_strJavaScript += " arrProjectTasks.push(new ProjectTasks(" & strProjectID & "," _
                                & strTaskID & "," _
                                & getMaxEntry(strProjectID) & "," _
                                & strBackDating & "," _
                                & strForwardating & "," _
                                & "'" & CStr(CommonFunctions.Data.CheckIsDBNull(drTask("ConstraintType"), "")) & "'," _
                                & "'" & CStr(CommonFunctions.Data.CheckIsDBNull(drTask("ConstraintDate"), "")) & "'," _
                                & "'" & strTaskType & "'," _
                                & CStr(IIf(CBool(CommonFunctions.Data.CheckIsDBNull(drTask("EnforceConstraints"), "0")) = True, "true", "false")) & "," _
                                & CStr(IIf(blnTimeBookedAgainstTask = True, "true", "false")) _
                                & "));" & vbCrLf

        Next

        If blnRecordPresent = True Then
            If blnIsGrouping Then
                m_SBHTML.Append(DrawTaskTotal_2(strProjectID, arrTaskTotal, dblActualTotal, strProjectName))
                'DrawTotalAll_2(strProjectID, arrProjectTotal, dblActualTotalAll)
                m_SBHTML.Append(DrawTotalAll_2(strProjectID, arrProjectTotal, dblActualTotalAll))
            End If
        Else
            m_SBHTML.Append("<TR class='clsTRBlank'><TD align=center colspan=13 class='clsTDBlank'>")
            m_SBHTML.Append(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MSG_NORECORD"), "There are no items to show in this view."))
            m_SBHTML.Append("</TD></TR>")
        End If


        m_SBHTML.Append("</table>")
        ' m_SBHTML.Append("</div>")

        If m_strListWeekHrs.ToString <> "" Then

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hdnWeekHrs", "hdnWeekHrs", , , , m_strListWeekHrs.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If

        'm_SBHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable' width=100% >")
        'm_SBHTML.Append("<tr class='clsTRColumnHeader' valign=top>")
        'm_SBHTML.Append("<td  align=left colspan='3'>")
        'm_SBHTML.Append("<b>Total for all projects</b>")
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("<td colspan='10' align='center' width='" + TD_WIDTH_4 + "'>&nbsp;")
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("</tr>")

        m_SBHTML.Append("</div>")


        Response.Write(m_SBHTML.ToString)


        m_SBHTML = Nothing
        DisposeNotUsedObjects()

    End Sub
    Protected Sub FillThemeColumns()
        '====================================================================
        ' Procedure Name    :      FillThemeColumns
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get theme columns.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_arrThemeCOL.Add("Task Name")

        If m_strThemeID = "1" Or m_strThemeID = "4" Then
            m_arrThemeCOL.Add("Allocated Work(hrs)")
            m_arrThemeCOL.Add("Actual<br>Work (hrs)")
        End If

        m_arrThemeCOL.Add("<WEEK_DAYS>")

        If m_strThemeID <> "2" Then
            m_arrThemeCOL.Add("Actual % Complete")
            m_arrThemeCOL.Add("Task Complete?")
        End If

        If m_strThemeID = "1" Or m_strThemeID = "4" Then
            m_arrThemeCOL.Add("Actual<br>Work (hrs) this week")

        End If

        ' m_arrThemeCOL.Add("IsGrouping")

        GetArray()

    End Sub
    Protected Function GetPagingString() As String
        strPaging = New StringBuilder

        strPaging.Append("<TD align='right' style='float:right;' valign='bottom' colspan='2' class='clsTDBlankNew'>")
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
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) onblur=javascript:validateNumPaging() ", returnHTML:=True, EnableHTMLEncode:=True))
            Else
                strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) onblur=javascript:validateNumPaging()", returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
            End If

            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
            strPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
            strPaging.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
            '''strPaging.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intIssueCountForAppliedQuery / 20)).ToString + ">"))



            strPaging.Append(" of " + Math.Ceiling(dblRatio).ToString)
            'strPaging.Append("|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))

            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If

        strPaging.Append("</td>")

        Return strPaging.ToString

        strPaging = Nothing
    End Function
    Protected Sub DrawAfterForm()
        '=====================================================================
        ' Procedure Name        : DrawAfterForm
        ' Purpose               : To draw controls after form tag
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        'm_strHtmlAfterForm.Append("<div  id='com3_' style='visibility: hidden;position: absolute;top:-10000;left:-10000;width: 66%;background: infobackground;z-index: 100;'")
        'm_strHtmlAfterForm.Append("onmouseover=""msoCommentPersist('com3_')"" onmouseout=""msoCommentReset('com3_')"" >")
        'm_strHtmlAfterForm.Append("</div> " & vbCrLf)
        'CommonFunctions.General.WriteHTML(m_strHtmlAfterForm.ToString)
        CommonFunctions.General.WriteHTML(" <script> " & m_strJavaScript & " </script> ")
        'm_strHtmlAfterForm = Nothing
    End Sub
    Private Function DrawTaskDetail_2(ByVal strProjectID As String, ByVal strTaskName As String, ByVal strTaskID As String, ByVal strActualPercentCompleteas As String, ByRef lngRowNo As Long, ByVal arrDA() As String, ByVal dblAllocatedWork As Double, ByVal dblActualWork As Double, ByVal dblWorkDone As Double, ByVal blnTaskComplete As Boolean, ByVal strTaskStartDate As String, ByVal strTaskEndDate As String, ByVal strTaskType As String, ByVal strMaxEntryDate As String, ByVal blnResourceLevelTaskCompletion As Boolean, ByVal strTaskActualStartDate As String, ByVal strActualEndDate As String, ByVal strConstraintType As String, ByVal strConstraintDate As String, ByVal openSection As Boolean, ByVal arrDA_ID() As Double, ByVal strProjectName As String, ByVal strTStatus As String) As String
        '=====================================================================
        ' Procedure Name        : DrawTaskDetail_2
        ' Purpose               : To draw actual grid
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim strRowStyle As String
        Dim i As Integer
        Dim dblWeekTotal As Double = 0
        Dim intColIndex As Integer = 0
        Dim strTitle As New System.Text.StringBuilder
        Dim strTooltipConstraintType As String
        Dim strTaskHrsValue As String = ""

        Dim sTaskHTML As New StringBuilder
        'If openSection = True Then
        '    strRowStyle = ""
        'Else
        '    strRowStyle = "style='display:none'"
        'End If


        If strConstraintType <> "" Then
            Select Case strConstraintType
                Case "0" 'as soon as possible
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_ASAP")
                Case "1" 'as late as possible
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_ALAP")
                Case "2" 'Must Start on 
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_MSO")
                Case "3" 'Must Finish on
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_MFO")
                Case "4" 'start no earlier than 
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_NET")
                Case "5" 'Start no later than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_SNLT")
                Case "6" 'Finish no eariler than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_FNET")
                Case "7" 'finish no later than
                    strTooltipConstraintType = MyBase.GetResourceString("CAP_FNLT")
            End Select
        Else
            strTooltipConstraintType = MyBase.GetResourceString("CAP_NOCONSTRAINT")
        End If

        'Modified By VidyaJ - issueid - 11819
        strTitle.Append("[Project : " + strProjectName.Replace("\'", "/'/g") + "]")
        strTitle.Append(vbCrLf & "[Task : " + strTaskName.Replace("\'", "/'/g") + "]")
        If strTaskType <> GENERAL_TASKS Then
            strTitle.Append(vbCrLf & "Status" & vbTab & vbTab & vbTab & " = ")
            If blnTaskComplete Then
                strTitle.Append("Complete")
            Else
                strTitle.Append("InProgress")
            End If
            If strTaskStartDate <> "" Then strTitle.Append(vbCrLf & "Start Date" & vbTab & vbTab & " = " & CDate(strTaskStartDate).ToString("dd-MMM-yyyy"))
            If strTaskEndDate <> "" Then strTitle.Append(vbCrLf & "End Date" & vbTab & vbTab & " = " & CDate(strTaskEndDate).ToString("dd-MMM-yyyy"))
            If strTaskActualStartDate <> "" Then strTitle.Append(vbCrLf & "Actual Start Date" & vbTab & " = " & CDate(strTaskActualStartDate).ToString("dd-MMM-yyyy"))
            If strActualEndDate <> "" Then strTitle.Append(vbCrLf & "Actual End Date" & vbTab & vbTab & " = " & CDate(strActualEndDate).ToString("dd-MMM-yyyy"))

            If strTaskType = PROJECT_SPECIFIC_TASKS Then
                strTitle.Append(vbCrLf & vbCrLf & "Constraint : " & strTooltipConstraintType)
                If strConstraintType <> "" Then
                    If CInt(strConstraintType) > 1 Then
                        strTitle.Append(CommonFunction.General.FormatString(" '" & strConstraintDate & "'"))
                    End If
                End If
            End If
        End If
        ''////////////////////////////////////
        sTaskHTML.Append("<TR id=TRD_" + strProjectID + "_" + strTaskID + " name = TRD_" + strProjectID + "_" + strTaskID + " class='clsTRBlank'  " & strRowStyle & ">")

        '------------Task detail like start date

        ''Added by Dhanashri S on 28 Jan 2016
        Dim m_PKToken_TaskLink_ATS As String
        ''Commented and Added by Dhanashri S on 11 Aug 2016
        ''m_PKToken_TaskLink_ATS = CommonFunctions.Security.Token.GetToken(CType(strProjectID, String) + CType(strTaskID, String) + "0" + "0")
        m_PKToken_TaskLink_ATS = CommonFunctions.Security.Token.GetToken(CType(strTaskID, String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0" + CType(strProjectID, String) + "1")
        ''End of Comment and Addition by Dhanashri S on 11 Aug 2016
        ''End of Addition by Dhanashri S on 28 Jan 2016


        If strTaskType <> GENERAL_TASKS Then
            intColIndex = 2
            lngRowNo += 1
            '    sTaskHTML.Append("<TR id=TRS_" + strTaskID + " class='clsTRBlank' " & strRowStyle & ">")
            '---Task name column-------------------------------
            sTaskHTML.Append("<TD title ='" & CommonFunction.General.FormatString(Server.HtmlEncode(strTitle.ToString)) & "' id = TDS0_" + strTaskID + "  class='clsTDBlank' width='" + TD_WIDTH_3 + "' >")
            'Status Comparison code added by JyotiG
            'Issue ID : 6850
            If blnTaskComplete = False And strTStatus <> "V" Then
                sTaskHTML.Append("<a href=""javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "','" & m_PKToken_TaskLink_ATS & "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                'shraddha
                'sTaskHTML.Append("<a href=javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')>" + CommonFunction.General.FormatString(strTaskName) + "</a>")
            Else
                sTaskHTML.Append(CommonFunction.General.FormatString(strTaskName))
            End If
            sTaskHTML.Append(DrawTaskProgressBar(dblActualWork, dblAllocatedWork))
            sTaskHTML.Append("</TD>")

            'End Modification
            'Mpp Hours
            'sTaskHTML.Append("<TD id = TDS2_" + strTaskID + "  colspan=5 >")
            'If dblWorkDone <> 0 Then sTaskHTML.Append("<font color=blue><b>(" + FormatNumber(dblWorkDone, 2) + " hrs uploaded from the MPP.)</b>")
            'sTaskHTML.Append("</b></TD>")
            ' sTaskHTML.Append("</TR>")
        End If

        '--**************************************
        lngRowNo += 1
        'sTaskHTML.Append("<TR id=TRD_" + strProjectID + "_" + strTaskID + " name = TRD_" + strProjectID + "_" + strTaskID + " class='clsTRBlank'  " & strRowStyle & ">")
        If strTaskType = GENERAL_TASKS Then
            '---Task name column-------------------------------
            intColIndex = 3
            sTaskHTML.Append("<TD class='clTDBlank' title ='" & strTitle.ToString & "' id = TDS0_" + strTaskID + "  width='" + TD_WIDTH_3 + "' >")
            'Status Comparison code added by JyotiG
            'Issue ID : 6850
            If blnTaskComplete = False And strTStatus <> "V" Then
                sTaskHTML.Append("<a href=""javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "','" & m_PKToken_TaskLink_ATS & "')"">" + CommonFunction.General.FormatString(strTaskName) + "</a>")
                'shraddha
                'sTaskHTML.Append("<A href=javascript:TaskLink_OnClick('" + strTaskID + "','" & strProjectID & "')>" + CommonFunction.General.FormatString(strTaskName) + "</A>")
            Else
                sTaskHTML.Append(CommonFunction.General.FormatString(strTaskName))
            End If
            sTaskHTML.Append("</TD>")
        End If

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        sTaskHTML.Append(CommonFunction.HTMLControls.DrawTextBox("TDS1_" + strTaskID, "TDS1_" + strTaskID, "", , , strTaskStartDate, , , , , , True, , True, EnableHTMLEncode:=True))
        sTaskHTML.Append(CommonFunction.HTMLControls.DrawTextBox("TDS2_" + strTaskID, "TDS2_" + strTaskID, "", , , strTaskEndDate, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        '---Allocated hours column-------------------------
        If m_arrThemeCOL.Contains("Allocated Work(hrs)") Then
            sTaskHTML.Append("<TD id=TDA_" + strTaskID + "  width='" + TD_WIDTH_4 + "' align=right class='clsTDBlank'>")
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                sTaskHTML.Append(FormatNumber(dblAllocatedWork, 2))
            End If
            sTaskHTML.Append("</TD>")
        Else
            sTaskHTML.Append("<TD id=TDA_" + strTaskID + " style='display:none;' >")
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                sTaskHTML.Append(FormatNumber(dblAllocatedWork, 2))
            End If
            sTaskHTML.Append("</TD>")
        End If
        '---Actual hours column----------------------------
        If m_arrThemeCOL.Contains("Actual<br>Work (hrs)") Then
            sTaskHTML.Append("<TD id=TDB_" + strTaskID + "  width='" + TD_WIDTH_4 + "' align=right class='clsTDBlank'>")

            'Commented and Modified By JyotiG
            'Issue Id : 6801
            'Date : 09-Oct-2006
            'Start
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                If dblActualWork = 0 Then
                    sTaskHTML.Append("<b>" + CStr(dblActualWork) + "</b>")
                Else
                    sTaskHTML.Append("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",1)""><b>" + FormatNumber(dblActualWork, 2) + "</b></a>")
                End If
                If dblWorkDone <> 0 Then
                    sTaskHTML.Append("<a HREF='javascript:ShowWorkDone(" + FormatNumber(dblWorkDone, 1) + ")'><font color='blue'><b>" + FormatNumber(dblWorkDone, 2) + "</b></font></a>")
                End If
            End If
            'If dblActualWork = 0 Then
            '    sTaskHTML.Append("<b>" + CStr(dblActualWork) + "</b>")
            'Else
            '    sTaskHTML.Append("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",1)""><b>" + FormatNumber(dblActualWork, 2) + "</b></a>")
            'End If
            'If dblWorkDone <> 0 Then
            '    sTaskHTML.Append("<a HREF='javascript:ShowWorkDone(" + FormatNumber(dblWorkDone, 1) + ")'><font color='blue'><b>" + FormatNumber(dblWorkDone, 2) + "</b></font></a>")
            'End If
            'End of Modification By JyotiG

            sTaskHTML.Append("</TD>")
        Else
            sTaskHTML.Append("<TD id=TDB_" + strTaskID + " style='display:none;' >")
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                sTaskHTML.Append(FormatNumber(dblActualWork, 2))
            End If
            sTaskHTML.Append("</TD>")
        End If

        Dim strDate As String
        '---7 Days column----------------------------------
        For i = 0 To m_arrDateList.Count - 1


            If arrDA(i) <> "" Then
                sTaskHTML.Append("<TD id=TDB_" + strTaskID + "  title='" + CommonFunction.Dates.GetDate(CType(m_arrActualDates.Item(i), Date)) + "' width='" + TD_WIDTH_4 + "' align=center class='clsTDBlank'>")
                If m_arrThemeCOL.Contains("Actual<br>Work (hrs) this week") Then
                    dblWeekTotal += CDbl(arrDA(i))
                End If
                strDate = CType(DateAdd(DateInterval.Day, i, m_dtStartDateOfWeek).ToString("dd-MMM-yyyy"), String)
                sTaskHTML.Append("<a HREF=""javascript:ShowDetails_OnClick(" & strTaskID & ",0,'" & strDate & "' )"">")

                sTaskHTML.Append(FormatNumber(CDbl(arrDA(i)), 2))
                sTaskHTML.Append("</a>")
                If m_strTabSection <> "5" Then
                    m_strListWeekHrs.Append((i + 3).ToString + "_" + strTaskID + "_" + FormatNumber(CDbl(arrDA(i)), 2) + ";")
                End If
            Else
                If blnTaskComplete = True And strTaskType <> GENERAL_TASKS Then 'completed tasks are disabled
                    sTaskHTML.Append("<TD style='BORDER-TOP:" & DISABLED_COLOR & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + DISABLED_COLOR + "' align=center title='" + CommonFunction.Dates.GetDate(CType(m_arrActualDates.Item(i), Date)) + "' >")
                    'ElseIf blnTaskComplete = False And m_objAccessRights.Add = False Then
                    '    sTaskHTML.Append("<TD style='BORDER-TOP:" & CellColor & "' id=TDD" & (i + 3).ToString & "_" + strTaskID + "  width='" + TD_WIDTH_4 + "' bgcolor='" + CellColor + "' align=center  >")
                Else
                    sTaskHTML.Append("<TD id=TDB_" + strTaskID + "  width='" + TD_WIDTH_4 + "' align=center class='clsTDBlank' title='" + CommonFunction.Dates.GetDate(CType(m_arrActualDates.Item(i), Date)) + "' >")
                    strTaskHrsValue = CommonFunction.General.CheckIsNothing(htNWTaskHrs.Item((i + 3).ToString & "_" + strTaskID), "")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    sTaskHTML.Append(CommonFunction.HTMLControls.DrawTextBox("ctr" + (i + 3).ToString & "_" + strTaskID, "ctr" + (i + 3).ToString & "_" + strTaskID, , 45, , strTaskHrsValue, "right", , , , , , "onfocus=txtHr_OnFocus(this) onblur=SendXMLHTTP_Save(this)", True, EnableHTMLEncode:=True))

                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    m_strJavaScript += "arrAlltxtboxIDs.push('ctr" + (i + 3).ToString & "_" + strTaskID + "');"
                End If
            End If

            sTaskHTML.Append("</TD>")
        Next
        '---actual percent complete column ----------------
        If m_arrThemeCOL.Contains("Actual % Complete") Then
            sTaskHTML.Append("<TD  align=center width='" + TD_WIDTH_4 + "' id=TDS4_" + strTaskID + " align=center title='" & MyBase.GetResourceString("COL_ACTUAL_PERCENT") & "' class='clsTDBlank'>")
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                If blnTaskComplete = True Then
                    sTaskHTML.Append(FormatNumber(strActualPercentCompleteas, 2, , , TriState.False))
                Else

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15

                    sTaskHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPercentComplete_" + strTaskID, "txtPercentComplete_" + strTaskID, , 40, 7, FormatNumber(strActualPercentCompleteas, 2, , , TriState.False), "Right", , , , , , "align=right  onblur='javascript:txtPercentComplete_OnBlur(this)' OnChange='javascript:txtPercentComplete_OnChange(this)'", True, True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                End If
            End If
            sTaskHTML.Append("</TD>")
        End If
        '---Task complete checkbox column------------------
        If m_arrThemeCOL.Contains("Task Complete?") Then
            sTaskHTML.Append("<TD  align=center width='" + TD_WIDTH_4 + "'  id=TDS5_" + strTaskID + " align=center title='" & MyBase.GetResourceString("COL_TASK_COMPLETE") & "' class='clsTDBlank'>")
            If strTaskType = GENERAL_TASKS Then
                sTaskHTML.Append("N/A")
            Else
                If blnResourceLevelTaskCompletion Then
                    If strMaxEntryDate <> "0" Then
                        sTaskHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted_" + strTaskID, "chkTaskCompleted_" + strTaskID, , blnTaskComplete, strTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this,'" + Date.Parse(strMaxEntryDate).ToString("MM/dd/yyyy") + "') ", True))
                    Else
                        sTaskHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkTaskCompleted_" + strTaskID, "chkTaskCompleted_" + strTaskID, , blnTaskComplete, strTaskID, blnTaskComplete, " Language=Javascript onclick=chkTaskCompleted_OnClick(this) ", True))
                    End If
                Else
                    sTaskHTML.Append("N/A")
                End If
            End If
            sTaskHTML.Append("</TD>")
        End If
        '---work hours this week column---------------------
        If m_arrThemeCOL.Contains("Actual<br>Work (hrs) this week") Then
            sTaskHTML.Append("<TD  align=center id=TDS6_" + strTaskID + "  width='" + TD_WIDTH_4 + "' class='clsTDBlank' >")
            If dblWeekTotal = 0 Then
                sTaskHTML.Append("<B>" + CStr(dblWeekTotal) + "</B>")
            Else
                sTaskHTML.Append("<a HREF=""javascript:ShowDetails_OnClick(" + strTaskID + ",2)"">")
                sTaskHTML.Append("<b>" + FormatNumber(dblWeekTotal, 2) + "</b>")
                sTaskHTML.Append("</a>")
            End If
            sTaskHTML.Append("</TD>")
        End If

        sTaskHTML.Append("</TR>")

        Return sTaskHTML.ToString

        strTitle = Nothing
        sTaskHTML = Nothing

    End Function
    Private Function getMaxEntry(ByVal strProjectID As String) As String
        '=====================================================================
        ' Function Name         : getMaxEntry()	
        ' Purpose               : returns maximum entry per day
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        'Dim drTotalHours As IDataReader
        'Dim dblTotalWorkHours As Double
        'drTotalHours = CommonFunction.Data.GetDataReader("EXEC usp_Sel_Daily_WorkingHours_Office " & strProjectID & ", '" & m_strHoursValidation & "'", MyBase.UseSQL)
        'If drTotalHours.Read() Then
        '    dblTotalWorkHours = CType(CommonFunction.Data.CheckIsDBNull(drTotalHours("WorkingHours"), "0"), Double)
        'End If
        'CommonFunction.Data.DisposeDataReader(drTotalHours)
        'Return dblTotalWorkHours.ToString
        Return "24"
    End Function
    Private Sub ResetToZero(ByRef arr() As Double)
        '=====================================================================
        ' Procedure Name        : ResetToZero()	
        ' Purpose               : set all elements of array to zero
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        For i = 0 To arr.Length - 1
            arr(i) = 0
        Next
    End Sub
    Private Function DrawTotalAll_2(ByVal strProjectID As String, ByVal arrProjectTotal() As Double, ByVal dblActualTotalAll As Double) As String
        '=====================================================================
        ' Procedure Name        : DrawTotalAll_2
        ' Purpose               : To draw Total of all projects
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        Dim sTaskHTML As New StringBuilder
        ' sTaskHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable' width='99.9%'  >") ''Style=""table-layout:fixed;""
        sTaskHTML.Append("<TR class='clsTRBlank'>") ''clsTRSectionHeader

        sTaskHTML.Append("<TD colspan='3' align='left' class='clsTDBlank' >")
        sTaskHTML.Append("<b>" & MyBase.GetResourceString("CAP_PROJECT_TOTAL_ALL") & "</b>")
        sTaskHTML.Append("</TD>")

        For i = 0 To m_arrDateList.Count - 1
            ' For i = 0 To 6
            sTaskHTML.Append("<TD   class='clsTDBlank' width='" + TD_WIDTH_2 + "' align=right id=TDA" & (i + 3).ToString & " >")
            If arrProjectTotal(i) = 0 Then
                sTaskHTML.Append("<b>" + FormatNumber(arrProjectTotal(i), 2) + "</b>")
            Else
                sTaskHTML.Append("<a HREF=""javascript:ShowDetails_OnClick(0,3,'" & (i + 1).ToString & "')""><b>" + FormatNumber(arrProjectTotal(i), 2) + "</b></a>")
            End If
            sTaskHTML.Append("</TD>")
        Next

        sTaskHTML.Append("<TD  class='clsTDBlank' width='" + TD_WIDTH_2 + "' align=right ></TD>")
        sTaskHTML.Append("<TD  class='clsTDBlank' width='" + TD_WIDTH_2 + "' align=right ></TD>")
        sTaskHTML.Append("<TD  class='clsTDBlank' width='" + TD_WIDTH_2 + "' align=right >")
        sTaskHTML.Append(FormatNumber(dblActualTotalAll, 2))
        '' sTaskHTML.Append(" / " + FormatNumber(m_TotalWeekHours, 2)) '' + " " + MyBase.GetResourceString("HRS"))
        sTaskHTML.Append("</b></TD>")

        sTaskHTML.Append("</TR>")

        ' sTaskHTML.Append("</Table>")

        Return sTaskHTML.ToString

        sTaskHTML = Nothing
    End Function
    Private Function DrawTaskTotal_2(ByVal strProjectID As String, ByVal arrTaskTotal() As Double, ByVal dblActualTotal As Double, ByVal strProjectName As String) As String
        '=====================================================================
        ' Procedure Name        : DrawTaskTotal_2
        ' Purpose               : To draw Total project wise for each day
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim i As Integer = 0
        Dim sTaskHTML As New StringBuilder
        sTaskHTML.Append("<TR id=TRP_" + strProjectID + "  class='clsTROdd'>")
        sTaskHTML.Append("<TD colspan=3 class='clsTDBlankNew'>")
        sTaskHTML.Append("<b>" & MyBase.GetResourceString("CAP_PROJECT_TOTAL") & "-" & strProjectName & "</b>")
        sTaskHTML.Append("</TD>")
        ' For i = 0 To 6
        For i = 0 To m_arrDateList.Count - 1
            sTaskHTML.Append("<TD class='clsTDBlankNew' width=" & TD_WIDTH_2 & " align=right id=TDP3_" + strProjectID + " align=right>")
            sTaskHTML.Append(FormatNumber(arrTaskTotal(i), 2))
            sTaskHTML.Append("</TD>")
        Next
        sTaskHTML.Append("<TD class='clsTDBlankNew' width='" + TD_WIDTH_2 + "' align=right ></TD>")
        sTaskHTML.Append("<TD class='clsTDBlankNew' width='" + TD_WIDTH_2 + "' align=right ></TD>")
        sTaskHTML.Append("<TD class='clsTDBlankNew' width='" + TD_WIDTH_2 + "' align=right >")
        sTaskHTML.Append(FormatNumber(dblActualTotal, 2))
        sTaskHTML.Append("</TD>")
        sTaskHTML.Append("</TR>")
        Return sTaskHTML.ToString
        sTaskHTML = Nothing
    End Function
    'Private Sub DrawPageCaption()
    '    '=====================================================================
    '    ' Procedure Name        : DrawPageCaption
    '    ' Purpose               : To draw Page caption
    '    ' Returns               : None
    '    ' Author                : HarshK
    '    ' Created               : 11 NOV 2005 To 30 NOV 2005
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim dblTotal As Double
    '    Dim strSql As String
    '    Dim m_SBHeader As New StringBuilder
    '    'Modified By VidyaJ - SP8 Performance
    '    Dim drWeekTotal As IDataReader
    '    Dim intCounter As Integer
    '    strSql = "usp_sel_tbl_PM_DailyActivity_WeeklyTotal " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"

    '    ' dblTotal = CDbl(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), "0"))

    '    drWeekTotal = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)
    '    intCounter = 0
    '    Dim strDate As Date
    '    Dim strDateComp As Date

    '    While drWeekTotal.Read()

    '        strDate = DateAdd(DateInterval.Day, 0, CType(drWeekTotal("EntryDate"), DateTime))
    '        'strDateComp = m_dtStartDateOfWeek

    '        Dim intDayCount As Long
    '        intDayCount = DateDiff(DateInterval.Day, m_dtStartDateOfWeek.Date, strDate)

    '        'If strDate = strDateComp Then

    '        Select Case intDayCount
    '            Case 0
    '                m_dblEntryDay1 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
    '            Case 1
    '                m_dblEntryDay2 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

    '            Case 2
    '                m_dblEntryDay3 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

    '            Case 3
    '                m_dblEntryDay4 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

    '            Case 4
    '                m_dblEntryDay5 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
    '            Case 5
    '                m_dblEntryDay6 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

    '            Case 6
    '                m_dblEntryDay7 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

    '        End Select
    '        ' End If

    '        intCounter = intCounter + 1

    '    End While
    '    CommonFunction.Data.DisposeDataReader(drWeekTotal)
    '    dblTotal = m_dblEntryDay1 + m_dblEntryDay2 + m_dblEntryDay3 + m_dblEntryDay4 + m_dblEntryDay5 + m_dblEntryDay6 + m_dblEntryDay7
    '    m_dblActualHrs = dblTotal

    '    m_SBHeader.Append("<Table  cellspacing=0  Width='100%'  class='clsTable'>")
    '    m_SBHeader.Append("<Tr class='clsTRBlank'>")

    '    ' m_SBHeader.Append("<Td align='left' class='clsTDBlankNew' valign='bottom'  width='20%'>")
    '    '''Added By PrashantSJ on 2nd Feb 2009

    '    'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))

    '    ''' START : Modified By ParagD On 29-Aug-2006
    '    ''' Purpose : The date format is not dsiplayed as per the format set at the 
    '    '''           "Company Information -> Date Format"

    '    ''' CommonFunctions.General.WriteHTML(" (" + m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") + " - " + m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") + ")")
    '    'CommonFunctions.General.WriteHTML(" (" + CommonFunctions.Dates.CGetDate(Date.Parse(m_dtStartDateOfWeek.ToString)) + " - " + CommonFunctions.Dates.CGetDate(Date.Parse(m_dtEndDateOfWeek.ToString)) + ")")
    '    '' END : Modified By ParagD On 29-Aug-2006 

    '    'm_SBHeader.Append("</Td>")

    '    m_SBHeader.Append("<TD class='clsTDBlankNew' colspan='4' align='left' valign='bottom' ><b>")

    '    If m_strTabSection = "0" Or m_strTabSection = "4" Then
    '        m_SBHeader.Append(MyBase.GetResourceString("PAGE_CAPTION_TOTAL").Replace("week", "day"))
    '    Else
    '        m_SBHeader.Append(MyBase.GetResourceString("PAGE_CAPTION_TOTAL"))
    '    End If

    '    m_SBHeader.Append(FormatNumber(dblTotal, 2))
    '    m_SBHeader.Append(" / " + FormatNumber(m_TotalWeekHours, 2) + " " + MyBase.GetResourceString("HRS"))
    '    m_SBHeader.Append("</b></td>")

    '    m_SBHeader.Append("</Tr>")
    '    m_SBHeader.Append("</Table>")
    '    m_SBHeader.Append("</br>")

    '    Response.Write(m_SBHeader.ToString)

    '    m_SBHeader = Nothing
    'End Sub

    Private Function GetPageCaption() As String
        '=====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Purpose               : To draw Page caption
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '=====================================================================
        Dim dblTotal As Double
        Dim strSql As String
        Dim m_SBHeader As New StringBuilder
        'Modified By VidyaJ - SP8 Performance
        Dim drWeekTotal As IDataReader
        Dim intCounter As Integer
        strSql = "usp_sel_tbl_PM_DailyActivity_WeeklyTotal " & m_strSessionUserID & ",'" & m_dtStartDateOfWeek.ToString("dd-MMM-yyyy") & "','" & m_dtEndDateOfWeek.ToString("dd-MMM-yyyy") & "'"

        ' dblTotal = CDbl(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), "0"))

        drWeekTotal = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)
        intCounter = 0
        Dim strDate As Date
        Dim strDateComp As Date

        While drWeekTotal.Read()

            strDate = DateAdd(DateInterval.Day, 0, CType(drWeekTotal("EntryDate"), DateTime))
            'strDateComp = m_dtStartDateOfWeek

            Dim intDayCount As Long
            intDayCount = DateDiff(DateInterval.Day, m_dtStartDateOfWeek.Date, strDate)

            'If strDate = strDateComp Then

            Select Case intDayCount
                Case 0
                    m_dblEntryDay1 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
                Case 1
                    m_dblEntryDay2 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 2
                    m_dblEntryDay3 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 3
                    m_dblEntryDay4 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 4
                    m_dblEntryDay5 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)
                Case 5
                    m_dblEntryDay6 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

                Case 6
                    m_dblEntryDay7 = CType(CommonFunctions.Data.CheckIsDBNull(drWeekTotal("DayTotal"), "0"), Double)

            End Select
            ' End If

            intCounter = intCounter + 1

        End While
        CommonFunction.Data.DisposeDataReader(drWeekTotal)
        dblTotal = m_dblEntryDay1 + m_dblEntryDay2 + m_dblEntryDay3 + m_dblEntryDay4 + m_dblEntryDay5 + m_dblEntryDay6 + m_dblEntryDay7
        m_dblActualHrs = dblTotal



        m_SBHeader.Append("<TD class='clsTDBlankNew'  align='left' valign='bottom' ><b>")

        'If m_strTabSection = "0" Or m_strTabSection = "4" Then
        '    m_SBHeader.Append(MyBase.GetResourceString("PAGE_CAPTION_TOTAL").Replace("week", "day"))
        'Else
        '    m_SBHeader.Append(MyBase.GetResourceString("PAGE_CAPTION_TOTAL"))
        'End If

        m_TotalWeekHours = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_ExpectedWorkHours " + m_strSessionUserID.ToString + ",'" + CommonFunctions.Dates.GetDate(m_dtStartDateOfWeek).ToString + "','" + CommonFunctions.Dates.GetDate(m_dtEndDateOfWeek).ToString + "'", True), "0")

        m_SBHeader.Append(FormatNumber(dblTotal, 2))
        m_SBHeader.Append(" / " + FormatNumber(m_TotalWeekHours, 2) + " " + MyBase.GetResourceString("HRS"))
        m_SBHeader.Append("</b></td>")



        Return m_SBHeader.ToString

        m_SBHeader = Nothing

    End Function

    Private Sub GetPageLegend()
        '=====================================================================
        ' Procedure Name        : GetPageLegend()	
        ' Purpose               : Function To draw page legend (e.g. Mandatory)
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Jan 25, 2009
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder
        'Dim strLegend As String
        ''Legend
        'Dim objLegend As WebPages.Template.PageLegends
        'objLegend = New WebPages.Template.PageLegends
        'Dim arrLegend() As String = {"Mandatory"}
        'Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'strLegend = objLegend.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
        'objLegend = Nothing
        'Response.Write(strLegend)
        m_SBHTML.Append("<table id='tblPL00' CellSpacing=0 width='99.9%' class=clsTable>")
        m_SBHTML.Append("<tr class=clsTRBlank>")
        'm_SBHTML.Append("<td align='left'>")
        'm_SBHTML.Append("<a href='javascript:AlertShow_Onclick()'><img id=imgAS src='../../Images/cssImages/arrow_blue_left.gif' border=0 align='center' alt='Show/Hide Alert' /></a>")
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("<td align='left' colspan='2' valign='top' class='clsTDBlank'>")
        'm_SBHTML.Append("&nbsp;|&nbsp;")
        'm_SBHTML.Append("<a  href='javascript:GTS_OnClick()' /><font color='blue'>&nbsp;Generate Timesheet&nbsp;</font></a>")
        'm_SBHTML.Append("&nbsp;|&nbsp;")
        'm_SBHTML.Append("<a  href='javascript:ScheduleTS_OnClick()' /><font color='blue'>&nbsp;Schedule Timesheet&nbsp;</font></a>")
        'm_SBHTML.Append("&nbsp;|&nbsp;")
        'm_SBHTML.Append("</td>")

        m_SBHTML.Append("<td align='Right' valign='top' >")
        m_SBHTML.Append("<B>(<img src='../../images/star.gif'> Mandatory)</B>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("<hr style='color:lightblue;height:1px;'/>")

        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing
    End Sub


    Protected Sub InitializeVariables()
        '====================================================================
        ' Procedure Name    :      InitializeVariables
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page varaibles
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim intRoleLevel As Integer
        Dim strFilter As String


        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)

        If m_strMode <> "DateChanged" Then
            m_strMode = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), ""))
        End If

        If m_strFromDate <> "123" Then
            m_strFromDate = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"), ""), String)
        End If
        m_strIsFilter = CommonFunction.General.CheckIsNothing(Request.QueryString("Filter"))

        If Not Request.QueryString("TabSection") Is Nothing Then
            m_strTabSection = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.QueryString("TabSection"), "1"))
        Else
            m_strTabSection = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("txtTabSection"), "1"))
        End If


        If m_strMode = "" Or m_strMode = "DateChanged" Then
            If m_strFromDate <> "" And m_strFromDate <> "123" Then
                m_strInputDate = CommonFunction.Dates.GetDate(CType(m_strFromDate, Date))
            Else
                If calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM" And m_strMode.ToUpper <> "SAVE" Then
                    m_strInputDate = CommonFunction.Dates.GetDate(calendar.SelectedDate.Date)
                    m_strIsFilter = ""

                Else
                    If CommonFunction.General.CheckIsNothing(Request.Form("txtInputDate")) = "" Then
                        m_strInputDate = CommonFunction.Dates.GetDate(Date.Today)
                    Else
                        m_strInputDate = CommonFunction.Dates.GetDate(CommonFunction.General.CheckIsNothing(Request.Form("txtInputDate")))
                    End If
                End If
            End If

            ''Commented and Added By Vidya J 14 Jun 2016 For SBI-ITFO Issue Fixing
            ''Added and commented by PrashantSJ on 13th May 2009
            'If (m_strTabSection = "4" Or m_strTabSection = "1" Or m_strTabSection = "5") Then
            '    'If m_strTabSection = "1" Or m_strTabSection = "5" Then
            '    ''end of addition by PrashantSJ on 13th May 2009
            '    m_strInputDate = CommonFunction.Dates.GetDate(Date.Today)
            'End If

            'If (m_strTabSection = "1" And calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM") Or (m_strTabSection = "2" And calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM" And m_strFromDate = "123") Or (m_strTabSection = "3" And calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM" And m_strFromDate = "123") Then
            '    m_strInputDate = CommonFunction.Dates.GetDate(calendar.SelectedDate.Date)
            '    m_strTabSection = "1"
            'End If

            If (((m_strTabSection = "1") And (CommonFunction.General.CheckIsNothing(Request.QueryString("FromPaging"), "") = "1")) And (m_strFromDate <> "123")) Then
                m_strInputDate = m_strFromDate
            ElseIf ((((m_strTabSection = "4") Or (m_strTabSection = "1")) Or (m_strTabSection = "5")) Or (m_strFromDate = "123")) Then
                m_strInputDate = CommonFunction.Dates.GetDate(Date.Today)
            End If
            If (((m_strTabSection = "1") And (CommonFunction.General.CheckIsNothing(Request.QueryString("FromPaging"), "") = "1")) And (m_strFromDate <> "123")) Then
                m_strInputDate = m_strFromDate
            ElseIf ((((m_strTabSection = "1") And (calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM")) Or (((m_strTabSection = "2") And (calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM")) And (m_strFromDate = "123"))) Or (((m_strTabSection = "3") And (calendar.SelectedDate.Date.ToString <> "1/1/0001 12:00:00 AM")) And (m_strFromDate = "123"))) Then
                m_strInputDate = CommonFunction.Dates.GetDate(calendar.SelectedDate.Date)
                m_strTabSection = "1"
            End If

            ''End Of Commented and Added By Vidya J ON 14 Jun 2016 For SBI-ITFO Issue Fixing

        Else

            m_strInputDate = CommonFunction.Dates.GetDate(CommonFunction.General.CheckIsNothing(Request.Form("txtInputDate")))
        End If

        '' m_strHidInputDate = m_strInputDate

        m_strSessionUserID = CType(CommonFunction.General.CheckIsNothing(Session("intUserID")), String)
        m_strSessionPostID = CType(CommonFunction.General.CheckIsNothing(Session("intPostID")), String)
        m_strUserName = CType(CommonFunction.General.CheckIsNothing(Session("strUserName")), String)

        If (m_strMode.ToUpper = "SAVE" And (m_strTabSection = "2" Or m_strTabSection = "3")) Or ((m_strTabSection = "2" Or m_strTabSection = "3") And m_strIsFilter = "1") Or (CommonFunction.General.CheckIsNothing(Request.QueryString("FromPaging")) = "1") Then
            m_strSQL = "usp_Get_TaskCalenderHeader '" & m_strInputDate & "',1," & m_strSessionUserID
        Else
            m_strSQL = "usp_Get_TaskCalenderHeader '" & m_strInputDate & "'," & m_strTabSection & "," & m_strSessionUserID
        End If


        dsDayHeader = CommonFunction.Data.GetDataSet(m_strSQL, "Header", , , MyBase.UseSQL)

        For Each drRow As DataRow In dsDayHeader.Tables(0).Rows
            m_arrDateList.Add(CommonFunction.Data.CheckIsDBNull(drRow("DisplayDate"), ""))

            m_arrActualDates.Add(CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualDate"), ""), Date)))

            m_strPeriod = CommonFunction.Data.CheckIsDBNull(drRow("Period"), "0").ToString

            m_dtStartDateOfWeek = CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDayOfWeek"), ""), Date)
            m_dtEndDateOfWeek = CType(CommonFunction.Data.CheckIsDBNull(drRow("EndDayOfWeek"), ""), Date)
            ' m_htListHoliday.Add(CommonFunction.Dates.cGetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("ActualDate"), ""), Date)), CType(CommonFunction.Data.CheckIsDBNull(drRow("IsHoliday"), "0"), String))
            ' If m_strTabSection <> "2" And m_strTabSection <> "3" Then
            ''COMMEnted by PrashantSJ on 20th Feb 2009
            m_strInputDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drRow("StartDayOfWeek"), ""), Date))
            ''End of addtiion by PrashantSJ 
            ' End If
        Next

        htTab.Add("0", "Day")
        htTab.Add("1", "Week")
        htTab.Add("2", "Previous Week")
        htTab.Add("3", "Next Week")
        htTab.Add("4", "Today")
        htTab.Add("5", "Pull Previous Week")


        '-----Project Filter---------

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        If intRoleLevel = 2 Then
            m_strProjectFilters = ""
            strFilter = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Trim
        End If

        m_strSessionProjectID = CStr(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"))


        m_strSelectedTaskType = CommonFunction.General.CheckIsNothing(Request.Form("cboTaskTypeFilter"), CStr(ASSIGNED_TASKS))
        m_strTaskFilter = CommonFunction.General.CheckIsNothing(Request.Form("cboOtherFilter"), CStr(TASKS_FOR_THE_WEEK))
        m_strProjectID = CommonFunction.General.CheckIsNothing(Request.Form("cboProject"), "")

        If m_strProjectID <> "" Or m_strProjectID <> "0" Then
            m_strProjectFilters = m_strProjectID
        End If

        If m_strSelectedTaskType = GENERAL_TASKS Then
            m_strTaskFilter = ALL_TASKS
        End If

        m_strBackdatingExpiry = CommonFunction.Application.BackdatingNoDays.ToString()
        m_strFwddatingExpiry = CommonFunction.Application.ForwardDatingNoDays.ToString()
        m_strHoursValidation = CommonFunction.Application.HoursValidation.ToString()

        If m_strTabSection = "0" Or m_strTabSection = "4" Then
            m_TotalWeekHours = 24.0
        Else
            m_TotalWeekHours = CommonFunction.Application.weekhours
        End If

        m_blnRestrict_MPPTasks = CommonFunctions.Application.RestrictDurationChange_M
        m_blnRestrict_AssignedTasks = CommonFunctions.Application.RestrictDurationChange_O

        m_blnTimesheetEntryCombo = CommonFunction.Application.TimesheetEntryCombo
        m_strTimesheetFrequency = CommonFunction.Application.ResourceTimeSheetFrequency

        m_blnRedirectToDA = CBool(CommonFunctions.General.CheckIsNothing(Request("RedirectToDA"), "0"))

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber")) <> "" Then
            m_intPageNumber = CType(Request.Form("txtPageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        If CommonFunction.General.CheckIsNothing(Request.Form("hdnWeekHrs")) <> "" Then
            m_arrNWHrs = CType(Request.Form("hdnWeekHrs"), String).Split(";"c)

            If m_strTabSection = "5" Then
                For j = 0 To m_arrNWHrs.Length - 2
                    arrTaskHrs = m_arrNWHrs(j).ToString.Split("_"c)
                    htNWTaskHrs.Add(arrTaskHrs(0) + "_" + arrTaskHrs(1), arrTaskHrs(2))
                Next
            End If
        End If

        If Not Request.QueryString("ThemeID") Is Nothing Then
            m_strThemeID = CType(Request.QueryString("ThemeID"), String)
        Else
            m_strThemeID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtHidThemeID")), String)
        End If

        ''PrashantSJ on 18th Sep 2009
        If m_strTabSection = "2" Or m_strTabSection = "3" Then
            m_strTabSection = "1"
        End If
        ''PrashantSJ on 18th Sep 2009
    End Sub

    Protected Sub DrawHiddenFields()
        '====================================================================
        ' Procedure Name    :      DrawHiddenFields
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Hidden data fields.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTabSection", "txtTabSection", , , , m_strTabSection, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtInputDate", "txtInputDate", , , , m_strInputDate, , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHidThemeID", "txtHidThemeID", , , , m_strThemeID, , , , , , True, , True, EnableHTMLEncode:=True))

        CommonFunctions.HTMLControls.DrawTextBox("hdnStartDate", "hdnStartDate", , , , m_dtStartDateOfWeek.ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnEndDate", "hdnEndDate", , , , m_dtEndDateOfWeek.ToString("dd-MMM-yyyy"), , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnQueryString", "hdnQueryString", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnTP", "hdnTP", , , , , , , , , , True, EnableHTMLEncode:=True) 'for txtPercentComplete
        CommonFunctions.HTMLControls.DrawTextBox("hdnChk", "hdnChk", , , , , , , , , , True, EnableHTMLEncode:=True) 'for check box values
        'ended by Yogesh J for HTML encoding Date:05/10/15
    End Sub

    'Protected Sub DrawMenu()
    '    '====================================================================
    '    ' Procedure Name    :      DrawMenu
    '    ' Parameters Passed :      None
    '    ' Returns           :      None 
    '    ' Parameters Affected :    None
    '    ' Purpose           :      To draw menu  details.
    '    ' Description       :      Same as purpose.
    '    ' Assumptions       :      None 
    '    ' Dependencies      :      None  
    '    ' Author            :      PrashantSJ
    '    ' Created           :      Sept 08, 2008
    '    ' Revisions         :
    '    '=====================================================================
    '    Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
    '    Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
    '    Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

    '    m_SBHTML = New StringBuilder

    '    m_SBHTML.Append("<Table class='clsTable' cellspacing=0 cellpadding=0 width='100%'>")
    '    m_SBHTML.Append("<TR class=clsTRBlank>")
    '    m_SBHTML.Append("<td class='clsTDBlank' align='left' >" + DrawCommonQuestion() + "</td>")
    '    m_SBHTML.Append("<td valign='top' class=clsTDBlankNEW align='right' >")
    '    ''m_SBHTML.Append("<div Id=divMenu class='HeaderMenu'>")
    '    m_SBHTML.Append("|&nbsp;")
    '    m_SBHTML.Append("<input type=button id='btnSave' value='Save' onclick='Save_OnClick()'/>&nbsp;")
    '    m_SBHTML.Append("|&nbsp;")
    '    m_SBHTML.Append("<input type=button id='btnGTS' value='Generate Timesheet' onclick='GTS_OnClick()'/>&nbsp;")
    '    m_SBHTML.Append("|&nbsp;")
    '    m_SBHTML.Append("<a href='javascript:Help_OnClick(""AT "")' ><Img Border=0 src='../../Images/cssImages/Link images/help.gif' alt='Help'></a>&nbsp;")
    '    ''m_SBHTML.Append("</div>")
    '    m_SBHTML.Append("</td>")


    '    m_SBHTML.Append("</tr>")
    '    m_SBHTML.Append("</table>")

    '    'ArrMenuCaptionsList.Add("<Img Border=0 id=imgFilter src='../../Images/cssImages/Link images/Filter.gif'>")
    '    'ArrMenuToolTipsList.Add("Filter")
    '    'ArrClientSideFunctionsList.Add("Filter_OnClick(1)")

    '    'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;Save")
    '    'ArrMenuToolTipsList.Add("Save")
    '    'ArrClientSideFunctionsList.Add("Save_OnClick()")

    '    '''''..\..\images\Filter.gif'
    '    'ArrMenuCaptionsList.Add("Schedule Timesheet")
    '    'ArrMenuToolTipsList.Add("Schedule Timesheet")
    '    'ArrClientSideFunctionsList.Add("ScheduleTS_OnClick()")

    '    'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;")
    '    'ArrMenuToolTipsList.Add("Help")
    '    'ArrClientSideFunctionsList.Add("Help_OnClick('AT')")

    '    'Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
    '    'ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
    '    'ArrMenuCaptionsList = Nothing

    '    ''Convert arraylist to array - Client side functions
    '    'Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
    '    'ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
    '    'ArrClientSideFunctionsList = Nothing

    '    ''Convert arraylist to array - Menu tooltips
    '    'Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
    '    'ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
    '    'ArrMenuToolTipsList = Nothing

    '    'm_objMenu = New WebPage.Templates.StaticMenu
    '    'm_SBHTML.Append(m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True))

    '    Response.Write(m_SBHTML.ToString)
    '    m_SBHTML = Nothing
    'End Sub
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 3986 ''CommonFunction.Constants.APP_Tag_TIMESHEET_MYTIMESHEETS
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()

    End Sub
    Protected Sub DrawTotalWeekTitle()
        '=====================================================================
        ' Procedure Name        : DrawTotalWeekTitle()	
        ' Purpose               : Function To draw week total
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Jan 25, 2009
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<br>")
        m_SBHTML.Append("<TABLE  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        m_SBHTML.Append("<tr class='clsTRPageCaption'>")
        m_SBHTML.Append("<td align=right noWrap>")
        m_SBHTML.Append("Total Actual Work (hrs) this week [ All Projects ] : 11.00 / 48.00 hrs")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        m_SBHTML.Append("</table>")
        ' m_SBHTML.Append("<br>")

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing

    End Sub
    Protected Sub DrawFilters()
        '=====================================================================
        ' Procedure Name        : DrawFilters()	
        ' Purpose               : Function To draw filter
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Jan 25, 2009
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<div id='divFilter' class='ContextMenu' style='display:none;' >")
        m_SBHTML.Append("<table   class='clsTable'>")
        m_SBHTML.Append("<tr class='clsTRBlank'>")
        m_SBHTML.Append("<td align=right noWrap class='clsTDBlankNew'> ")
        m_SBHTML.Append("Project Name")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left title='Search Project'>")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtProject", "txtProject", , 300, , , , , , , , , "onkeyup=Project_OnKeyUp(this,event)", True, EnableHTMLEncode:=True))

        'ended by Yogesh J for HTML encoding Date:05/10/15
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<tr class='clsTRBlank'>")
        m_SBHTML.Append("<td align=right noWrap class='clsTDBlankNew'>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left>")

        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee_NEWTS " & m_strSessionUserID & ",1,1", 300, m_strProjectID, , True, True))
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        m_SBHTML.Append("<tr class='clsTRBlank'>")
        m_SBHTML.Append("<td align=right noWrap class='clsTDBlankNew'> ")
        m_SBHTML.Append("Task Type")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td align=left>")
        m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboTaskTypeFilter", "usp_Get_TaskFilter_Attributes 'TT'", 200, m_strSelectedTaskType, , , True))
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")

        'm_SBHTML.Append("<tr class='clsTRPageFilters'>")
        'm_SBHTML.Append("<td align=right noWrap>")
        'm_SBHTML.Append("Duration")
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("<td align=left>")
        'm_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboOtherFilter", "usp_Get_TaskFilter_Attributes ", 200, m_strTaskFilter, , , True))
        'm_SBHTML.Append("</td>")
        'm_SBHTML.Append("</tr>")

        m_SBHTML.Append("<tr class='clsTRBlank'>")
        m_SBHTML.Append("<td>&nbsp;")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td colspan='2'  style='text-align:center;' class='clsTDBlankNew'>")
        m_SBHTML.Append("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter(0)' >Apply</a>")
        m_SBHTML.Append("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Filter_OnClick(1)' >Cancel</a>")
        m_SBHTML.Append("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter(1)' >Clear</a>")
        m_SBHTML.Append("</td>")

        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("</div>")

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing

    End Sub
    Public Sub New()
        'MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.TS_WeeklyTimesheet", "AppResources")
    End Sub
#Region "Calender Event"
    Private Sub calendar_DayRender(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DayRenderEventArgs) Handles calendar.DayRender
        If m_strTabSection <> "0" Then
            If m_arrActualDates.Contains(CommonFunction.Dates.GetDate(e.Day.Date)) Then
                e.Cell.BackColor = Drawing.Color.Lavender

            End If
        End If

        If Not e.Day.IsOtherMonth Then

            Dim WeekEnds As Integer, currentDateWeek As Integer, NoOfWeekEnds As Integer

            currentDateWeek = Weekday(CType(CommonFunction.Dates.GetDate(e.Day.Date), Date), CType(CommonFunction.Application.StartingDayofweek, System.Web.UI.WebControls.FirstDayOfWeek)) - 1

            If currentDateWeek = 0 Then : currentDateWeek = 7 : End If


            If currentDateWeek > m_intWorkingDays Then 'WeekEnds
                e.Cell.ForeColor = Drawing.Color.Red
            End If
            Dim k As Integer, l As Integer

            If Not m_arrHolidays Is Nothing Then
                For k = 0 To m_arrHolidays.Length - 1
                    If DateDiff(DateInterval.Day, CType(CommonFunction.Dates.GetDate(m_arrHolidays(k)), Date), CType(CommonFunction.Dates.GetDate(e.Day.Date), Date)) = 0 Then
                        e.Cell.ForeColor = Drawing.Color.Red
                    End If
                Next
            End If

            If Not m_arrLeaves Is Nothing Then
                For l = 0 To m_arrLeaves.Length - 1
                    m_arrLeavesFromTo = m_arrLeaves(l).Split("_"c)
                    If DateDiff(DateInterval.Day, CType(CommonFunction.Dates.GetDate(m_arrLeavesFromTo(0)), Date), CType(CommonFunction.Dates.GetDate(e.Day.Date), Date)) >= 0 And DateDiff(DateInterval.Day, CType(CommonFunction.Dates.GetDate(e.Day.Date), Date), CType(CommonFunction.Dates.GetDate(m_arrLeavesFromTo(1)), Date)) >= 0 Then
                        e.Cell.ForeColor = Drawing.Color.Red
                    End If
                Next
            End If
        End If

    End Sub
    Private Sub calendar_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles calendar.Load
        calendar.FirstDayOfWeek = CType(CommonFunction.Application.StartingDayofweek, System.Web.UI.WebControls.FirstDayOfWeek)

    End Sub

#End Region

#Region "DataBase Function"
    Private Sub ProcessSave()
        '=====================================================================
        ' Procedure Name        : ProcessSave
        ' Purpose               : To Process save action
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 11 NOV 2005 To 30 NOV 2005
        ' Revisions             :
        '====================================================================
        Dim strQueryString As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnQueryString")))
        Dim arrQueryString() As String = strQueryString.Split(CChar(";")) 'Edited cells
        '------------------------
        Dim strHdnTP As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnTP")))
        Dim arrHdnTP() As String = strHdnTP.Split(CChar(";")) 'edited text box of percent complete
        '------------------------
        Dim strHdnChk As String = CStr(CommonFunctions.General.CheckIsNothing(Request("hdnChk")))
        Dim arrHdnChk() As String = strHdnChk.Split(CChar(";")) 'edited check box
        '------------------------
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim strSQL2 As String = ""
        Dim strUpdatedTasks As String = ","
        Dim strCompletedTasks As String = ","
        Dim i As Integer

        For i = 0 To arrQueryString.Length - 1
            Dim arrValues() As String = arrQueryString(i).Split(CChar(":"))
            If arrValues.length = 5 Then
                Dim strCellvalue As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), ""))
                Dim strCellIndex As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))
                Dim strCellTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(2), "0"))
                Dim strCellProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(3), "0"))
                Dim strIsDurationChange As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(4), "0"))
                Dim strPercentComplete As String = CStr(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtPercentComplete_" + strCellTaskID), ""))
                Dim dtEntryDate As Date = DateAdd(DateInterval.Day, CDbl(strCellIndex) - 3, m_dtStartDateOfWeek)
                Dim blnResourceLevelTaskCompletion As Boolean

                If strCellvalue <> "" And strCellvalue.ToUpper <> "NULL" And strCellvalue.ToUpper <> "NAN" Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Inline Query
                    '' strSQL2 = "SELECT ResourceLevelTaskCompletion FROM tbl_PM_Project WHERE ProjectID =  " & strCellProjectID
                    strSQL2 = "usp_sel_ResourceLevelTaskCompletion_tbl_PM_Project  " & strCellProjectID
                    ''end of Commented and added by Nilesh g on 3/8/2016 for Inline Query
                    blnResourceLevelTaskCompletion = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "0"))

                    strUpdatedTasks += strCellTaskID + ","
                    strSQLQuery.Append("Exec usp_Ins_tbl_PM_DailyActivity  NULL," & strCellTaskID & "," & strCellProjectID & "," & m_strSessionUserID & "," & m_strSessionPostID & ",'" & dtEntryDate.ToString("dd-MMM-yyyy") & "'," & strCellvalue & ", NULL,NULL,NULL")
                    'Booleon flag indicating whether this entry has caused the duration of the task to change
                    If strIsDurationChange = "1" Then
                        strSQLQuery.Append(",1")
                    Else
                        strSQLQuery.Append(",0")
                    End If
                    '-------------------------
                    If MyBase.GetFormValue("chkTaskCompleted_" & strCellTaskID) <> "" Then
                        strSQLQuery.Append(",1")
                    Else
                        strSQLQuery.Append(",0")
                    End If
                    If MyBase.GetFormValue("txtPercentComplete_" + strCellTaskID) <> "" Then
                        If blnResourceLevelTaskCompletion Then
                            strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strCellTaskID), 0, False, True), , , , TriState.False) & ",1")
                        Else
                            strSQLQuery.Append("," & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strCellTaskID), 0, False, True), , , , TriState.False) & ",0")
                        End If
                    End If
                    strSQLQuery.Append(vbCrLf)
                End If
            End If
        Next
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If
        '------------------------------------
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        For i = 0 To arrHdnTP.Length - 1
            Dim arrValues() As String = arrHdnTP(i).Split(CChar(":"))
            If arrValues.Length = 2 Then
                Dim strTPTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), "0"))
                Dim strTPProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))
                Dim blnResourceLevelTaskCompletion As Boolean
                Dim blntaskCompleted As Boolean = False
                If MyBase.GetFormValue("txtPercentComplete_" + strTPTaskID) <> "" And strUpdatedTasks.IndexOf("," + strTPTaskID + ",") = -1 Then
                    If CType(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), Integer) <> 0 Then
                        ''Commented and added by Nilesh g on 3/8/2016 for Inline Query
                        ''strSQL2 = "SELECT ResourceLevelTaskCompletion FROM tbl_PM_Project WHERE ProjectID =  " & strTPProjectID
                        strSQL2 = "usp_sel_ResourceLevelTaskCompletion_tbl_PM_Project  " & strTPProjectID
                        ''end of Commented and added by Nilesh g on 3/8/2016 for Inline Query
                        blnResourceLevelTaskCompletion = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL2, MyBase.UseSQL), "0"))
                        If blnResourceLevelTaskCompletion Then
                            If CType(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), Integer) <> 100 Then
                                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                                ''CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTPTaskID, MyBase.UseSQL)
                                CommonFunctions.Data.InsertOrUpdateData("Exec usp_upd_tbl_PM_ProjectTasks_ActualPercentComplete " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & "," & strTPTaskID, MyBase.UseSQL)
                                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                            Else
                                strCompletedTasks += strTPTaskID + ","
                                blntaskCompleted = True
                            End If
                        Else
                            ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                            ''CommonFunctions.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectTasks SET ResourcePercentComplete = " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & " WHERE TaskID = " & strTPTaskID, MyBase.UseSQL)
                            CommonFunctions.Data.InsertOrUpdateData("Exec usp_upd_tbl_PM_ProjectTasks_ResourcePercentComplete " & FormatNumber(FixString(MyBase.GetFormValue("txtPercentComplete_" & strTPTaskID), 0, False, True), , , , TriState.False) & "," & strTPTaskID, MyBase.UseSQL)
                            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                        End If

                        If (MyBase.GetFormValue("chkTaskCompleted_" & strTPTaskID) <> "" And strUpdatedTasks.IndexOf("," + strTPTaskID + ",") = -1) Or blntaskCompleted = True Then
                            strSQLQuery.Append("Exec usp_Upd_ProjectTaskComplete " & strTPTaskID & ", 1 " + vbCrLf)
                        End If
                    End If
                End If
            End If
        Next
        '---------------------------------
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If
        '---------------------------------
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        For i = 0 To arrHdnChk.Length - 1
            Dim arrValues() As String = arrHdnChk(i).Split(CChar(":"))
            If arrValues.Length = 2 Then
                Dim strCKTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(0), "0"))
                Dim strCKProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(arrValues(1), "0"))

                If MyBase.GetFormValue("chkTaskCompleted_" & strCKTaskID) <> "" And strUpdatedTasks.IndexOf("," + strCKTaskID + ",") = -1 And strCompletedTasks.IndexOf("," + strCKTaskID + ",") = -1 Then
                    strSQLQuery.Append("Exec usp_Upd_ProjectTaskComplete " & strCKTaskID & ", 1 " + vbCrLf)
                End If
            End If
        Next
        If strSQLQuery.ToString.Trim <> "" Then
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
        End If

        strSQLQuery = Nothing
    End Sub
    Private Sub ProcessDefaultTheme()
        '====================================================================
        ' Procedure Name    :      ProcessDefaultTheme
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To perform default theme action
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_strSQL = "usp_Ins_Upd_Timesheet_Themes " & m_strThemeID & "," & m_strSessionUserID & ",N'" & m_strUserName & "'"
        Try

            CommonFunction.Data.InsertOrUpdateData(m_strSQL, MyBase.UseSQL)

        Catch

        End Try

    End Sub
#End Region
    Protected Sub DrawThemes()
        '====================================================================
        ' Procedure Name    :      DrawThemes
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw timesheet themes
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        m_SBHTML = New StringBuilder
        Dim blnIsDefaultTheme As Boolean
        Dim tempThemeID As String = ""

        m_SBHTML.Append("<div id='divTheme' class='ContextMenu' style='display:none;' >")
        m_SBHTML.Append("<table  cellpadding=0 cellspacing=1 class='clsGridTable' >")
        m_SBHTML.Append("<tr class='clsTREven'>")
        m_SBHTML.Append("<td colspan='2' valign='top' align='right'>")
        m_SBHTML.Append("<a valign='top' align='right' href='javascript:ShowTheme(0)' ><Img valign='top' align='right' Border=0  src='../../Images/cssImages/Link images/Close.gif' alt='Close' /></a>")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")
        m_SBHTML.Append("<tr class='clsTREven'>")
        m_SBHTML.Append("<td valign='bottom' align='center'>")
        m_SBHTML.Append("Sr.No.")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("<td valign='bottom' align='left'>")
        m_SBHTML.Append("Views")
        m_SBHTML.Append("</td>")
        m_SBHTML.Append("</tr>")
        For Each drRow As DataRow In dsTheme.Tables(0).Rows
            m_SBHTML.Append("<tr class='clsTRBlank'>")
            m_SBHTML.Append("<td align='center' class='clsTDBlank'>")

            blnIsDefaultTheme = False

            If CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeID")), String) = m_strThemeID Then
                blnIsDefaultTheme = True
            Else
                If CType(CommonFunction.Data.CheckIsDBNull(drRow("IsDefaultTheme"), "0"), Boolean) And m_strThemeID = "" Then
                    blnIsDefaultTheme = True
                    tempThemeID = CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeID")), String)
                End If
            End If
            If blnIsDefaultTheme Then
                m_SBHTML.Append("<font color='blue'><b>")

                m_SBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeID")), String))

                m_SBHTML.Append("</b></font>")
            Else

                m_SBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeID")), String))

            End If
            m_SBHTML.Append("</td>")

            m_SBHTML.Append("<td align='left' class='clsTDBlank' style='cursor:hand;font-weight: bolder; font-size: 10px;font-family:verdana;'>")
            m_SBHTML.Append("<a  style='text-decoration:none;font-weight: normal; font-size: 10px;font-family:verdana;' href='javascript:ThemeOnClick(" + CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeID")), String) + ")'>")
            If blnIsDefaultTheme Then
                m_SBHTML.Append("<font color='blue'><b>")
                m_SBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeName")), String))
                m_SBHTML.Append("</b></font>")
            Else
                m_SBHTML.Append(CType(CommonFunction.Data.CheckIsDBNull(drRow("ThemeName")), String))

            End If
            m_SBHTML.Append("</a>")
            m_SBHTML.Append("</td>")


            m_SBHTML.Append("</tr>")
        Next
        m_SBHTML.Append("</table>")
        m_SBHTML.Append("</div>")

        If m_strThemeID = "" Then
            m_strThemeID = tempThemeID
        End If

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub GetArray()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        ReDim m_arrCOL(m_arrThemeCOL.Count - 1)
        m_arrThemeCOL.ToArray.CopyTo(m_arrCOL, 0)

    End Sub
    Private Function DrawTaskProgressBar(ByVal ActualWorkHrs As Double, ByVal AllocatedWorkHrs As Double) As String
        '====================================================================
        ' Procedure Name    :      DrawTaskProgressBar
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw task progress bar..actual vs planned
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        Dim sbProgressBar As New StringBuilder("")


        If m_strThemeID = "2" Or m_strThemeID = "3" Then

            Dim HrsPercentage As Double
            Dim LeftWidth As Double
            Dim RightWidth As Double
            Dim LeftTDColor As String = "Green"
            Dim strStyle As String = ""
            Dim dblRemainingHrs As Double = 0.0
            Dim strTooltip As String = ""

            dblRemainingHrs = (AllocatedWorkHrs - ActualWorkHrs)

            strTooltip = "Allocated Work (Hrs)" & vbTab & "=" + FormatNumber(AllocatedWorkHrs, 2) + vbCrLf
            strTooltip += "Actual Work (Hrs) " & vbTab & "=" + FormatNumber(ActualWorkHrs, 2) + vbCrLf
            strTooltip += "Remaining Work (Hrs)" & vbTab & "=" + FormatNumber(dblRemainingHrs, 2)

            HrsPercentage = (ActualWorkHrs / AllocatedWorkHrs) * 100
            If HrsPercentage > 100 Then
                HrsPercentage = 100
                LeftTDColor = "Red"
            End If
            LeftWidth = HrsPercentage
            RightWidth = 100 - HrsPercentage



            sbProgressBar.Append("<br><br>")
            sbProgressBar.Append("<table width=99.99% cellspacing=0 cellpadding=0 title='" + strTooltip + "'>")
            sbProgressBar.Append("<tr height=10px style='font-size: 2pt;font-family: Verdana, Arial' >")
            If HrsPercentage >= 100 Then
                strStyle = " border-right: 1px groove black; colspan=2 "
            Else
                strStyle = ""
            End If
            sbProgressBar.Append("<td width=" + LeftWidth.ToString() + "% bgcolor='" + LeftTDColor + "' style='border-bottom: 1px groove black;border-left: 1px groove black;border-top: 1px groove black; " + strStyle + "' >")
            sbProgressBar.Append("&nbsp;</td>")

            If strStyle = "" Then
                sbProgressBar.Append("<td width=" + RightWidth.ToString() + "% bgcolor='white' style='border-right: 1px groove black;border-bottom: 1px groove black;border-top: 1px groove black' >")
            End If

            sbProgressBar.Append("&nbsp;</td>")
            sbProgressBar.Append("</tr>")
            sbProgressBar.Append("<tr style='font-size: 8pt;font-family: Verdana, Arial;text-align:center;text-decoration:underline;color:black;'>")
            sbProgressBar.Append("<td  colspan=2 style='color:black;text-decoration:underline;'><Font color=" + LeftTDColor + "> " + ActualWorkHrs.ToString() + "</Font> / " + AllocatedWorkHrs.ToString())
            sbProgressBar.Append("</td>")
            sbProgressBar.Append("</tr>")
            sbProgressBar.Append("</table>")
        End If

        Return sbProgressBar.ToString
        sbProgressBar = Nothing

    End Function


#Region "Object Cleanup PROC"
    Protected Sub DisposeNotUsedObjects()
        '====================================================================
        ' Procedure Name    :      DisposeNotUsedObjects
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To destroy not used objects
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Jan 21, 2009
        ' Revisions         :
        '=====================================================================
        htNWTaskHrs = Nothing
        m_strListWeekHrs = Nothing
        m_arrActualDates = Nothing
        dsTask = Nothing
        dsTemp = Nothing
        m_htListHoliday = Nothing
        m_arrThemeCOL = Nothing
    End Sub
#End Region

    Private Sub calendar_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles calendar.SelectionChanged
        m_strFromDate = "123"
        m_strMode = "DateChanged"
    End Sub

    Private Sub calendar_VisibleMonthChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MonthChangedEventArgs) Handles calendar.VisibleMonthChanged

    End Sub
End Class
