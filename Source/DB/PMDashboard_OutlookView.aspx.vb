Option Strict Off
#Region "Imports"
Imports GenericCalender.GenericCalender
Imports CommonFunctions
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports WebPages
Imports CommonEngines
Imports System
#End Region

Public Class PMDashboard_OutlookView
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PMDashboard_OutlookView
    ' Purpose               : Creates the Calender
    ' Description           : Same as above
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SandeepA
    ' Created               : 16 Dec,2005
    ' Revisions             : 
    '=====================================================================

    Private m_blnUseSQL, m_blnSetProjectFilter As Boolean
    Private m_strPageCaption As String

    Protected m_intListNumber As Integer = 0
    Protected m_strDB_PageName As String
    Protected m_strPageTitle As String
    Protected m_strIssueName As String = "Issues"
    Protected m_intProjectID As Integer

    'Added by PrashantSJ on 06-Dec-2005 for Outlook menu
    Public m_PageMode As String
    Protected m_intMonth As Integer
    Protected m_intYear As Integer
    'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
    Protected intWeekFlag As Integer
    Protected intThisMonth As Integer
    'Added by PurvaJ on 11 May 2006
    Protected intStartingDayOfWeek As Integer
    Public dtWeekDate As DateTime
    Protected m_intStartingDayOfWeek As Integer
    'End Addition PurvaJ
    'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
    'End of Addition by PrashantSJ on 06-Dec-2005

    'Added by SavitaS on 30 Aug 2006
    Protected m_intStartDayOfWeek As Integer = -1
    Protected StyleSheetName As String = ""
    'End Addition by SavitaS 
    'Added By JyotiG
    'Start_JG_7526_9-Nov-2006
    Protected m_strMonthLoc As String
    'End_JG_7526_9-Nov-2006
   
    'Added by PrashantSJ on 06-Dec-2005 for outlook menu
    Protected Enum PageModes
        NORMAL_DASHBORD = 0
        WHIZIBLE_TODAY = 1
        MY_PROJECT_LIST = 2
        DOCUMENTS = 3
        PENDING_TIMESHEET_ENTRY = 4
        CALENDER = 5
    End Enum


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
#Region "Member Variables"

    Private WithEvents m_objMenu As New Template.StaticMenu       'This variable is used for plotting static menu.
    Private strMenu As String                           'stores the static menu string.
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_strDB_PageName = "../DB/MetricDB_Dashboard.aspx"
        'Added By SandeepA on 12 Dec,2005 for XMLHTTP Calender Hover
        Dim strFromWhere As String
        Try
            strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
            If strFromWhere = "XMLHTTP" Then
                Exit Sub
            End If
        Catch ex As Exception
        End Try
        'End of Addition By SandeepA on 12 Dec,2005

        If Session("intProjectID") Is Nothing Then
            m_intProjectID = 0
        Else
            m_intProjectID = CType(Session("intProjectID"), Integer)
        End If
        ' Call to Init. Page settings and module-level variables
        Call Initialize()

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page
        ' Description           : Also gets the various User Preferences from the Database
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Jan 5th, 2004
        ' Revisions             : 
        '=====================================================================

        '-- Procedure to Initialize all the page level settings/variables
        '-- Also retries the various User settings saved in User Preferences
        'Added by PrashantSJ on 06-Dec-2005 for Outlook menu
        ' Get the Mode 
        m_strIssueName = MyBase.GetResourceString("TAB_ISSUES")

        If Not IsNothing(HttpContext.Current.Request.QueryString("MODE")) Then
            m_PageMode = HttpContext.Current.Request.QueryString("MODE")
            Session("m_PageMode") = m_PageMode
        End If
        'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
        If Not IsNothing(HttpContext.Current.Request.QueryString("WeekFlag")) Then
            intWeekFlag = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WeekFlag"), 0.ToString))
            Session("WeekFlag") = intWeekFlag
        End If

        'MonthFlag
        If Not IsNothing(HttpContext.Current.Request.QueryString("MonthFlag")) Then
            Session("WeekFlag") = 0
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("ThisMonth")) Then
            intThisMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ThisMonth"), 0.ToString))
        End If

        'Added by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)

        'End Addition PurvaJ
        'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
        m_intMonth = CType(Request.QueryString("Month"), Integer)
        m_intYear = CType(Request.QueryString("Year"), Integer)
        If m_intYear = 0 Or intThisMonth = 1 Then
            m_intYear = DateTime.Now.Year
        End If
        If m_intMonth = 0 Or intThisMonth = 1 Then
            m_intMonth = DateTime.Now.Month
        End If
        If m_intMonth = 13 Then
            m_intMonth = 1
            m_intYear = m_intYear + 1
        End If

        ''End of Addition by PrashantSJ on 06-Dec-2005

        'Added by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
        If Request.QueryString("Where") = "PREV" Then
            If Request.QueryString("WeekDate") <> "" Then
                dtWeekDate = DateAdd(DateInterval.Day, -7, CDate(Request.QueryString("WeekDate")))
            Else
                dtWeekDate = System.DateTime.Today
            End If
            'm_dtStartDateOfWeek = DateAdd(DateInterval.Day, -7, CDate(m_dtDate))
            'm_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        ElseIf Request.QueryString("Where") = "NEXT" Then
            If Request.QueryString("WeekDate") <> "" Then
                dtWeekDate = DateAdd(DateInterval.Day, 7, CDate(Request.QueryString("WeekDate")))
            Else
                dtWeekDate = System.DateTime.Today
            End If
            'm_dtStartDateOfWeek = DateAdd(DateInterval.Day, 7, CDate(strSDate))
            'm_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        Else
            'If Request.QueryString("Where") = "THIS" Then
            dtWeekDate = System.DateTime.Today
        End If

        'End Addition PurvaJ

        ' Store approprate value for the Project Filter Session Variable.
        If Not Session("intProjectID") Is Nothing Then
            If Request.QueryString("ProjectFilter") = "1" Then
                Session("DB_ProjectFilter") = True
            ElseIf Request.QueryString("ProjectFilter") = "0" Then
                Session("DB_ProjectFilter") = False
            End If
        End If

        'Added by SavitaS on 29 Aug 2006 for SP7 Integration IssueID 5778
        m_intStartDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        'End of Added by SavitaS on 29 Aug 2006 for SP7 Integration IssueID 5778
       
    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Page Name             : DrawPage
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SandeepA
        ' Created               : 14 Dec,2005
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String
        '--- To Show 'Dashboard Combo' in the Top Frame.
        If CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "NULL")) = "0" Then
            'Code Added By PradipK on 23 June 2006
            'Purpose: To Display DashBoard Name in Combo.
            Dim strDashBoardID As String = ""
            Dim match As String
            If m_strDB_PageName = "../DB/MetricDB_Dashboard.aspx" Then

                If Request.QueryString("DashboardID") <> "" Then
                    strDashBoardID = CommonFunctions.General.CheckIsNothing(Request.QueryString("DashboardID"), "")
                End If

            End If
            '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
            If CommonFunction.Application.NewUI = False Then
                '--- End addition purvaj
                CommonFunctions.General.WriteHTML("<TABLE Class=clsGridTable cellpadding=0 cellspacing=0 Width=100%>")
                CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                CommonFunctions.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))
                '-- Combo box to select the Type of e-Dashboard
                If Trim(Session("intPostID").ToString) <> "" Then
                    strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString
                Else
                    strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString
                End If

                If strDashBoardID <> "" And strDashBoardID <> "0" Then
                    'match = Trim(m_strDB_PageName & "") + "?ID=" + strDashBoardID + "&DB=|0"
                    CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , Trim(m_strDB_PageName & "") + "?ID=" + strDashBoardID + "&DB=|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
                    'End Addition By PradipK
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , Trim(m_strDB_PageName & "") & "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
                End If

                CommonFunctions.General.WriteHTML("</TD>")
            End If
            ''Modified BY NitinVS on 26 july 2007 for WhizibleSEM 7 
            ' Commnented for now as it doesnt work in current set up.Can be enabled once received the patch for Core team.
            ''To show Set / Reset Default dashbaord link 

            'Dim objDR As IDataReader
            'Dim dbID As String = ""
            'Dim PageName As String = ""

            '' if SETDEFAULT = 1 or 0 then call sp to set or reset the default dashbaord 

            'If Not IsNothing(HttpContext.Current.Request.QueryString("SETDEFAULT")) Then
            '    Dim setDefault As String = HttpContext.Current.Request.QueryString("SETDEFAULT").ToString()
            '    dbID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("dbID"), "").ToString()

            '    If setDefault = "1" Then
            '        CommonFunction.Data.InsertOrUpdateData("EXEC usp_Del_tbl_CDB_DefaultDashboard " + HttpContext.Current.Session("intUserID").ToString() + " ,'" + HttpContext.Current.Session("LoginType").ToString() + "'", MyBase.UseSQL)
            '        CommonFunction.Data.InsertOrUpdateData("EXEC usp_Ins_tbl_CDB_DefaultDashboard  " + HttpContext.Current.Session("intUserID").ToString() + "," + dbID + " ,'" + HttpContext.Current.Session("LoginType").ToString() + "'", MyBase.UseSQL)
            '    ElseIf setDefault = "0" Then
            '        CommonFunction.Data.InsertOrUpdateData("EXEC usp_Del_tbl_CDB_DefaultDashboard " + HttpContext.Current.Session("intUserID").ToString() + " ,'" + HttpContext.Current.Session("LoginType").ToString() + "'", MyBase.UseSQL)
            '    End If
            'End If

            'objDR = CommonFunction.Data.GetDataReader("usp_SEL_Tbl_MENU_Settings_Dashbaord " + strDashBoardID, MyBase.UseSQL)
            'If objDR.Read() Then
            '    dbID = CommonFunction.Data.CheckIsDBNull(objDR("DashboardID"), "").ToString()
            '    PageName = CommonFunction.Data.CheckIsDBNull(objDR("PageName"), "").ToString()
            'End If

            'Dim strDefaultDashboard As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Sel_tbl_CDB_DefaultDashboard	" + HttpContext.Current.Session("intUserID").ToString() + " ,'" + HttpContext.Current.Session("LoginType").ToString() + "'", MyBase.UseSQL), ""), "")

            '' if current dashboard is default dashbaord show reset dashbaord link

            'If dbID <> "" And strDefaultDashboard <> "" Then
            '    If dbID = strDefaultDashboard Then
            '        CommonFunctions.General.WriteHTML("<TD align=right>")
            '        CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:SetDefaultDashboard(" + dbID + ",'" + strDashBoardID + "',0)>")
            '        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black><b Title='" + MyBase.GetResourceString("MENU_RESET_DEFAULT_DASHBOARD") + "'>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("MENU_RESET_DEFAULT_DASHBOARD") + "</font></b>")
            '        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")

            '        CommonFunctions.General.WriteHTML("</TD>")
            '        ' if current dashboard is not default dashbaord show set default dashbaord link
            '    Else
            '        CommonFunctions.General.WriteHTML("<TD align=right>")
            '        'CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            '        CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:SetDefaultDashboard(" + dbID + ",'" + strDashBoardID + "',1)>")
            '        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black><b Title='" + MyBase.GetResourceString("MENU_DEFAULT_DASHBOARD") + "'>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("MENU_DEFAULT_DASHBOARD") + "</font></b>")
            '        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")

            '        CommonFunctions.General.WriteHTML("</TD>")

            '    End If

            'End If
            'End Addition By NitinVS on 27 July 2007 for whizibleSEM 7 

            'Code Added By PradipK on 3 August 2006
            'Purpose: To Hide Help for SLA dashboard.Help is present for each page.

            If strDashBoardID = "1003" Or strDashBoardID = "1004" Or strDashBoardID = "1005" Or strDashBoardID = "1007" Or strDashBoardID = "1008" Or strDashBoardID = "1009" Then
                'Hide Help
                'End Modification BY NitinVS on 26 july 2007 for WhizibleSEM 7 
            Else
                '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
                If CommonFunction.Application.NewUI = True Then
                    CommonFunctions.General.WriteHTML("<TABLE Class=clsGridTable cellpadding=0 cellspacing=0 Width=100%>")
                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                End If
                '--- End addition purvaj

                CommonFunctions.General.WriteHTML("<TD  align=right>")
                ' CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

                CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('PMDashboardOutlookView')>")
                CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("TAB_HELP") + "</font></b>")
                CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")

                CommonFunctions.General.WriteHTML("</TD>")
                '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
                If CommonFunction.Application.NewUI = True Then
                    CommonFunctions.General.WriteHTML("</TR>")
                    CommonFunctions.General.WriteHTML("</TABLE>")
                End If

            End If
            '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
            If CommonFunction.Application.NewUI = False Then
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")
            End If

            Exit Sub
        End If

        '--- Added By SandeepA on 15 Nov,2005 for XMLHTTP Hover (Tasks)
        Dim strFromWhere As String
        Try
            strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
            If strFromWhere = "XMLHTTP" Then
                Exit Sub
            End If
        Catch ex As Exception
            'Exception Handler
        End Try
        '--- End of Addition by SandeepA on 15 Nov,2005

        Call PrepareSections()

    End Sub


    Private Function PrepareSections() As String
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Draws the 2 main sections in the Page. (One For Top Grid and one for Bottom)
        ' Description           : Called from DrawPage() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================

        '-- 2 sections in the page: e-Dashboard 
        Dim objDashboardSection As WebPages.Template.SectionTitle
        Dim strTabs As String

        objDashboardSection = New WebPages.Template.SectionTitle
        Response.Write("<DIV Id='divContainer' Style='Height:100%;width:100%'>")

        '--2. Draw the Tabs
        strTabs = DrawTabs()

        With objDashboardSection
            Response.Write(.GetSectionTitle(" ", "DivOtherInfo", "", , strTabs, , "", "", ))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        If CType(Session("m_PageMode"), Double) <> PageModes.CALENDER Then
            Response.Write("<DIV Id='DivOtherInfo' Style='Overflow:Auto;Height:300;width:100%'>")
        End If
        '--call to display Grid
        Call DisplayGrid()
        If CType(Session("m_PageMode"), Double) <> PageModes.CALENDER Then
            Response.Write("</DIV>")
        End If

        Response.Write("</DIV>")

    End Function

    Private Sub DisplayGrid()
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Calls to the 4 Grids in the Top Section for the 4 grids
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : PrashantJ
        ' Created               : Dec 6, 2005
        ' Revisions             : 
        '=====================================================================

        If CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
            Call Display_Calender_Tab()
        End If

    End Sub

    Private Sub Display_Calender_Tab()
        '====================================================================
        ' Procedure Name        :   Display_Calender_Tab
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To Draw the Calender
        ' Description           :   same as above
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   15 Dec,2005
        ' Revisions             :   
        '=====================================================================
        Try
            Dim objCalender As New GenericCalender.GenericCalender

            Dim strSQL As String
            Dim intRowCount As Integer
            'Added By PurvaJ on 9 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
            Dim intRowCount1 As Integer
            Dim intRowCount2 As Integer
            'End Addition PurvaJ
            Dim drTasks, drHolidays As IDataReader
            Dim strCalenderHTML, strDate As String
            Dim intYear, intMonth As Integer
            Dim HolidayArray() As Integer = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
            'Added by PrashantSJ for Weekly view on 18-Feb-2006

            Dim m_dtWeekStartDate As Date
            Dim m_dtWeekEndDate As Date
            Dim m_strWeekStartDate As String
            Dim m_strWeekEndDate As String
            Dim dtHoliDate As Date
            Dim spDate As Date
            'End of Addition by PrashantSJ for Weekly view on 18-Feb-2006
            Dim strLeaves As String
            Dim strLeavesArray As String()
            Dim intMonthDays As Integer = 0
            Dim intCounter As Integer = 0
            Dim strList As String
            Dim strMode As String
            Dim days() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

            '--- Initialize Resources
            MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")


            '--- To Get the module.
            If CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"), "")) = "5" Then
                strMode = "TASKS"
                strList = ""
            Else
                strList = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("List"), ""))
                If strList = "" Then
                    strMode = CStr(CommonFunction.General.CheckIsNothing(Session("MODULE"), "TASKS"))
                Else
                    strMode = ""
                End If
            End If

            '--- Set Calender WeekEndColor and Start of the week
            objCalender.CalenderWeekEndColor = "#c0c0c0"
            objCalender.FirstDayOfWeek = Microsoft.VisualBasic.FirstDayOfWeek.Monday
            'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            objCalender.CalenderTodaysColor = "Aqua"
            objCalender.CalenderPrevoiusMonthColor = "LightBlue"
            objCalender.CalenderNextMonthColor = "LightBlue"

            If CType(Session("WeekFlag"), Integer) = 1 Then
                'GetWeekStartAndEndDates(m_strWeekStartDate, m_strWeekEndDate, objCalender.FirstDayOfWeek)
                'Commented and Added by SavitaS on 08 Sept 2006 for IssueID 5778 and 5780
                ' m_intStartingDayOfWeek = 2 'CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
                m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
                m_intStartingDayOfWeek = m_intStartingDayOfWeek + 1
                If m_intStartingDayOfWeek > 7 Then
                    m_intStartingDayOfWeek = 1
                End If
                'Ens of Commented and Added by SavitaS on 08 Sept 2006 for IssueID 5778 and 5780
                GetWeekStartAndEndDates(m_strWeekStartDate, m_strWeekEndDate, dtWeekDate, m_intStartingDayOfWeek)
                'End Addition PurvaJ
                m_dtWeekStartDate = CType(m_strWeekStartDate, Date)
                m_dtWeekEndDate = CType(m_strWeekEndDate, Date)
                strMode = "WEEK"
            End If
            'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            '-- Get the Year and Month ('Previous' or 'Next' clicked)
            'Condition For Week is Added By JyotiG
            'Start_JG_7431_02-Nov-2006
            If CType(Session("WeekFlag"), Integer) = 1 Then
                intMonth = CType(DatePart("M", dtWeekDate), String)
                intYear = CType(DatePart("YYYY", dtWeekDate), String)
            Else
                'End_JG_7431_02-Nov-2006
                intYear = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Year"), 0.ToString))
                intMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Month"), 0.ToString))
            End If

            If intMonth > 12 Then
                intMonth = 1
                intYear += 1
            End If

            If intYear = 0 Or intMonth = 0 Then
                intYear = m_intYear
                intMonth = m_intMonth
            End If


            '--- Check for Leap Year
            If ((((intYear Mod 4) = 0) And ((intYear Mod 100) <> 0)) Or ((intYear Mod 400) = 0)) Then
                days(2) = 29
            Else
                days(2) = 28
            End If

            dtHoliDate = New Date(intYear, intMonth, 1)

            '--- Get Days in a Month
            intMonthDays = days(intMonth)

            '--- Get Holidays for OU
            HolidayArray.Clear(HolidayArray, 0, 12)
            strSQL = "usp_sel_Holidays_For_OU '" & dtHoliDate & "'," & CInt(Session("intUserID"))
            drHolidays = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            intCounter = 0
            While drHolidays.Read
                HolidayArray(intCounter) = CInt(CommonFunctions.Data.CheckIsDBNull(drHolidays.Item("Holidays"), "0"))
                intCounter += 1
            End While
            CommonFunctions.Data.DisposeDataReader(drHolidays)
            objCalender.ArrayCalenderHolidays = HolidayArray
            objCalender.CalenderHolidayColor = "RED"
            '----------------------------------------------
            '--- Get Leaves for that Employee

            Dim dtStartDate As New Date(intYear, intMonth, 1)
            Dim dtEndDate As New Date(intYear, intMonth, days(intMonth))


            Dim LeavesArray() As Integer = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

            If intWeekFlag <> 1 Then
                'Commented and Modified By JyotiG
                'Start_JG_7425_03-Nov-2006
                'strSQL = "usp_Get_EmployeeLeaves_ForCalender " & CInt(Session("intUserID")) & ",'" & dtStartDate & "','" & dtEndDate & "'"
                strSQL = "usp_Get_EmployeeLeaves_ForCalender " & CInt(Session("intUserID")) & ",'" & dtStartDate & "','" & dtEndDate & "','A'"
                'End_JG_7425_03-Nov-2006
            Else
                'Commented and Modified By JyotiG
                'Start_JG_7425_03-Nov-2006
                'strSQL = "usp_Get_EmployeeLeaves_ForCalender " & CInt(Session("intUserID")) & ",'" & m_dtWeekStartDate & "','" & m_dtWeekEndDate & "'"
                strSQL = "usp_Get_EmployeeLeaves_ForCalender " & CInt(Session("intUserID")) & ",'" & m_dtWeekStartDate & "','" & m_dtWeekEndDate & "','A'"
                'End_JG_7425_03-Nov-2006
            End If
            strLeaves = CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)
            strLeavesArray = strLeaves.Split(",")

            ' Modified by NitinVS on 6 Aug 2007 for WhizibleSEM 7 
            ' Exception is generated when strLeavesArray is bigger than LeavesArrary
            If (strLeavesArray.Length - 1) > 0 Then
                ReDim LeavesArray(strLeavesArray.Length - 1)
            End If
            ' End Modification By NitinVS on 6 Aug 2007 for WhizibleSEM 7

            For intIterator As Integer = 0 To strLeavesArray.Length - 1
                If strLeavesArray(intIterator) = "" Then
                    LeavesArray(intIterator) = 0
                Else
                    LeavesArray(intIterator) = CInt(strLeavesArray(intIterator))
                End If
            Next
            objCalender.ArrayCalenderLeaves = LeavesArray
            objCalender.CalenderLeaveColor = "BLUE"
            '----------------------------------------------

            spDate = New Date(intYear, intMonth, days(intMonth))

            '=======================================================================================================
            '--- If the MODE=5 then Show the Task List for that Day
            If strList = "5" Or strMode.ToUpper = "TASKS" Then

                '--- Get the Count data reader
                'TODO :Here the performance will be degraded because of heavy SQL traffic.
                '      Same for Issues,Reviews,Milestones and Deliverables.


                '--- Get the Count data reader

                'Dim spDate As New Date(intYear, intMonth, days(intMonth))

                'Modified by SandipL on 6 Feb 2006 -- changed the SP for Performance
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks'," & CStr(Session("intUserID")) & ",'" & spDate & "'"

                'Added By PurvaJ on 9 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks_ForOutlookView_Calender'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'End Addition PurvaJ
                'End Modification by SandipL on 6 Feb 2006
                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count
                'Commented by PurvaJ on 18 May 2006 issue 3636
                'As per the changes done in SP.
                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next
                'End Comment PurvaJ

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays


                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString

                    drTasks.Read()
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))

                    'Added By PurvaJ on 9 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count2"), ""))
                    'End Addition

                    '--- Test for each cell
                    'objCalender.Days(intDay).Text = "<Table width=100%>"

                    'Modified By PurvaJ on 9 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            'objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"")'>" & "Tasks Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("TASK_LABEL")                        
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""S"")'>" & "Tasks Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("TASK_LABEL")                        
                        End If
                        If intRowCount2 <> 0 Then
                            'objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"")'>" & "Tasks End" & " : " & intRowCount2 & "</A></Font></TD></TR>"   'MyBase.GetResourceString("TASK_LABEL")                           
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )  
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""E"")'>" & "Tasks End" & " : " & intRowCount2 & "</A></Font></TD></TR>"   'MyBase.GetResourceString("TASK_LABEL")                           
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                        'End Modification PurvaJ
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "TASKS"

            End If
            '=======================================================================================================
            '--- For ISSUES
            If strList = "2" Or strMode.ToUpper = "ISSUES" Then

                '--- Get the Count data reader
                'Dim spDate As New Date(intYear, intMonth, days(intMonth))
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Issues'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'Modified by PurvaJ on 18 May 2006 whizibleSEM 6.1 issue 3636
                'New SP written to get the count of the issues.
                strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Issues_count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count
                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next
                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    drTasks.Read()
                    'Modified By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))
                    '--- Text for cells
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""ISSUES"",""S"")'>" & "Issues Start" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("ISSUE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""ISSUES"",""E"")'>" & "Issues End" & " : " & intRowCount2 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("ISSUE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "ISSUES"
            End If
            '=======================================================================================================
            '--- For REVIEWS
            If strList = "8" Or strMode.ToUpper = "REVIEWS" Then

                '--- Get the Count data reader
                ' Dim spDate As New Date(intYear, intMonth, days(intMonth))

                'Modified by MrugajaB on 06 Feb 2006
                'Purpose: New SP is added in order to give output parameter for review count
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Reviewes'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'strSQL = "USP_GET_TASK_COUNT  'usp_Sel_Reviews_Count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "USP_GET_TASK_COUNT  'usp_Sel_Reviews_Count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'End Modification

                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count
                For I As Integer = 1 To intMonthDays * 2
                    drTasks.NextResult()
                Next
                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    drTasks.Read()
                    'Modified By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))
                    '--- Text for each cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""REVIEWS"",""S"")'>" & "Reviews Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("REVIEW_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""REVIEWS"",""E"")'>" & "Reviews End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("REVIEW_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                    'End Modification PurvaJ
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "REVIEWS"
            End If
            '=======================================================================================================
            '--- For MILESTONE
            If strList = "6" Or strMode.ToUpper = "MILESTONES" Then

                '--- Get the Count data reader
                ' Dim spDate As New Date(intYear, intMonth, days(intMonth))
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Milestones'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                '''''''''''''''''''''''''''''''''''''''''''''''''''
                'Modified By : JyotiG  'Issue ID : 3636  'Date : 08-Aug-2006\
                'Start
                '''''''''''''''''''''''''''''''''''''''''''''''''''
                strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Milestones_count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'End

                'Modified by PurvaJ on 18 may 2006 issue 3636 WhizibleSEM 6.1
                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count

                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    drTasks.Read()
                    'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))
                    '--- Text for each cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MILESTONES"",""S"")'>" & "Milestones Start" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("MILESTONE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MILESTONES"",""E"")'>" & "Milestones End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("MILESTONE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "MILESTONES"
            End If
            '=======================================================================================================
            '--- For DELIVERABLES
            If strList = "9" Or strMode = "DELIVERABLES" Then

                '--- Get the Count data reader
                ' Dim spDate As New Date(intYear, intMonth, days(intMonth))
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                ' strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Deliverables'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Deliverable_count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    drTasks.Read()
                    'Modified by PUrvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))
                    '--- Text for each Cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""DELIVERABLES"",""S"")'>" & "Deliverables start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("DELIVERABLE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""DELIVERABLES"",""E"")'>" & "Deliverables End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("DELIVERABLE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "DELIVERABLES"
            End If
            '=======================================================================================================
            '--- For TO DO LIST
            If strList = "1" Or strMode = "TODO" Then
                '--- Get the Count data reader
                ' Dim spDate As New Date(intYear, intMonth, days(intMonth))
                strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks_ForOutlookView_Calender'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                '--- Increament the RecordSet to get the Count

                'Commented by PurvaJ on 18 May 2006 for WhizibleSEM 6.1 issue 3636 
                ' As per changes done in SP.
                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next
                'End Comment PurvaJ 

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    drTasks.Read()
                    'Modified by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 issue 3636(PM DashBoard Enhanced View Enhancement)
                    'intRowCount = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count"), ""))
                    intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))
                    '--- Text for Each Cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""S"")'>" & "Tasks Start" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("TASK_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""E"")'>" & "Tasks End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("TASK_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intday).Text = " "
                    End If
                    'End Mofification PurvaJ
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                Session("MODULE") = "TODO"
            End If

            '======================================================================================================================================================
            '====  Mode Added for WEEK 
            '==================================================================================================
            If strMode = "WEEK" Then
                'For intDay As Integer = 1 To intMonthDays
                For intDay As Integer = CType(DatePart("D", m_dtWeekStartDate), Integer) To CType(DatePart("D", m_dtWeekEndDate), Integer)
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    objCalender.Days(intDay).Text = "<Table width=100%><TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""WEEK"",""S"")'>" & "Details" & "</A></Font></TD></TR></TABLE>"   'MyBase.GetResourceString("TASK_LABEL")
                    'End Mofification PurvaJ
                Next
            End If
            '=======================================================================================================
            '--- Plot the Calender.
            objCalender.ReturnHTML = True
            'Call Plot calender which cretes the final calender in one string

            '' START : Commented and modified By ParagD 30-Aug-2006
            '' CommonFunctions.General.WriteHTML("<DIV style='overflow:auto'>")
            ''Modified by swapnil aswale on 9th Feb 2016
            CommonFunctions.General.WriteHTML("<DIV style='width:100%; overflow:auto;'>")
            ''Ended
            'CommonFunctions.General.WriteHTML("<DIV style='width:100%; Height:60%; overflow:auto;'>")
            '' END : Commented and modified By ParagD 30-Aug-2006


            objCalender.TRSectionHeader = "clsTROdd"
            'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            If CType(Session("WeekFlag"), Integer) <> 1 Then
                'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
                'Commented and Added by SavitaS  for SP7 Integration IssueID 5778
                'CommonFunction.General.WriteHTML(objCalender.PlotCalender(m_intMonth, m_intYear))
                CommonFunction.General.WriteHTML(objCalender.PlotCalender(m_intMonth, m_intYear, m_intStartDayOfWeek))
                'End of Addition by SavitaS

            Else
                'Commented and Added by SavitaS  for SP7 Integration IssueID 5778
                ''Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender              
                'CommonFunction.General.WriteHTML(objCalender.PlotWeeklyCalender(m_dtWeekStartDate, m_dtWeekEndDate))
                CommonFunction.General.WriteHTML(objCalender.PlotWeeklyCalender(m_dtWeekStartDate, m_dtWeekEndDate, m_intStartDayOfWeek))
                'end of Addition by SavitaS

            End If
            'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender

            CommonFunctions.General.WriteHTML("</DIV>")


            '====================================================================================
            'Added by PurvaJ on 15 May 2006 for PM Dashboard Enhaced view enhacements
            'This displayes the Resource Utilization of the current user for the displayed month
            '====================================================================================

            Dim dtCustomdate As New Date(intYear, intMonth, 1)
            Dim AvailableHrs As Double
            Dim PlannedHrs As Double
            Dim ActualHrs As Double
            Dim BillableHrs As Double
            Dim BenchHrs As Double
            Dim drResourceUtilization As IDataReader

            strSQL = "Exec usp_Sel_ResourceUtilization_Monthly_Calender " & CStr(Session("intUserID")) & ",'" & dtCustomdate & "'"
            drResourceUtilization = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drResourceUtilization.Read Then
                AvailableHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drResourceUtilization.Item("AvailableHrs"), ""))
                PlannedHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drResourceUtilization.Item("PlannedHrs"), ""))
                ActualHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drResourceUtilization.Item("ActualHrs"), ""))
                BillableHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drResourceUtilization.Item("BillableHrs"), ""))
                'BenchHrs = CInt(CommonFunctions.Data.CheckIsDBNull(drResourceUtilization.Item("Bench Hrs"), ""))
            End If
            CommonFunction.Data.DisposeDataReader(drResourceUtilization)
            '' START : Commented and modified By ParagD 30-Aug-2006 
            '' CommonFunctions.General.WriteHTML("<TABLE><TR><TD><BR></TD></TR></TABLE>")

            'Code Commented By PradipK on 15 Dec 2006
            'CommonFunctions.General.WriteHTML("<DIV style='width:100%; Height:50%; overflow:auto;'>")
            ''' END : Commented and modified By ParagD 30-Aug-2006

            'CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable'><TR class='clsTRPageCaption'><TD align='Left'><B>" & "Resource Utilization" & "</B></TD></TR></TABLE>")

            'CommonFunctions.General.WriteHTML("<table id='ResourceUtilization'  name='ResourceUtilization' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0'>")
            'CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td><font color=blue><b>Available Hrs : </b></font>" & AvailableHrs & "</td>")
            'CommonFunctions.General.WriteHTML("<td><font color=blue><b>Planned Hrs : </b></font>" & PlannedHrs & "</td>")
            'CommonFunctions.General.WriteHTML("<td><font color=blue><b>Actual Hrs : </b></font>" & ActualHrs & "</td>")
            'CommonFunctions.General.WriteHTML("<td><font color=blue><b>Billable Hrs : </b></font>" & BillableHrs & "</td></font></TR>")
            'CommonFunctions.General.WriteHTML("</font></TABLE>")
            'CommonFunctions.General.WriteHTML("</DIV>")
            'End Addition PurvaJ
            'End changes by PradipK
        Catch ex As Exception
            CommonFunctions.General.WriteHTML(ex.Message)
            'Exception Handler
        End Try

    End Sub

    Protected Sub XMLHTTP_GetTasks()
        '====================================================================
        ' Procedure Name        :   XMLHTTP_GetTasks
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To populate the data for the HOVER.
        ' Description           :   same as above
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   SandeepA
        ' Created               :   12 Dec,2005
        ' Revisions             :   
        '=====================================================================

        '######### Page Code starts here
        Dim strFromWhere As String
        strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        'Check if the Page is postback using XMLHTTP
        If strFromWhere = "XMLHTTP" Then
            'Try

            Dim strFromDate As String = "NULL"
            Dim strToDate As String = "NULL"
            Dim strEmployeeID As String
            Dim strXML As String = ""
            Dim strSQL As String
            Dim strSQLQuery As String
            Dim strProjectName As String = ""
            Dim strPrevProjectName As String = ""
            Dim drProjects, drIssues As IDataReader
            Dim drTasks As IDataReader
            Dim strTaskName As String
            Dim strStartDate As String
            Dim strEndDate As String
            'Added by PurvaJ on 10 May 2006 for issue 3636(WhizibleSEM 6.1)
            Dim strActualStart As String
            Dim strActualEnd As String
            'End addition purvaj
            Dim strWork As String
            Dim strActualWork As String
            Dim intcount As Integer = 0
            Dim blnFlag As Boolean = False
            Dim strDocumentLink As String
            Dim strParentTask_UID As String
            Dim strApplyEffortDistribution As String
            Dim strHaveSubTaskTypes As String
            Dim strProjectID As String
            Dim strTaskID As String
            Dim strModule As String
            Dim strStartEndDate As String
            '--- Initialize Resources
            MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")

    '--- Get Parameters from QueryString
            strEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "0"))
            strFromDate = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Date"), "1/1/2005"))
            strModule = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODULE"), "TASKS"))
            strStartEndDate = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("StartEnd"), "TASKS"))
    '--- Start filling the XML string
            strXML = strXML + "<table id='Tasks' class='clsGridTable' name=='Tasks' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"

    '==============================================================================================
    '--- For TASKS
            If strModule.ToUpper = "TASKS" Then
    '--- Plot Table Column Headers
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=10%>" & "Actual End" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'Commented and modified By JyotiG
                'Start
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & "Actual End" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End Of modification by JyotiG
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791

    'If strToDate = "NULL" Then
    '    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
    '    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "', NULL "
    'Else
    '    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
    '    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ", NULL,'" & strToDate & "'"
    'End If

    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
    'Start                
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                If strStartEndDate = "S" Then
    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
                    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
                ElseIf strStartEndDate = "E" Then
    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
                    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
    'End
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("TaskName"), ""))
                    If Not IsDBNull(drProjects("BaseLineStart")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineStart"), "1/1/2005")))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("BaseLineEnd")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineEnd"), "")))))
                    Else
                        strEndDate = ""
                    End If

    'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
    'Start                
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005")))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("EndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EndDate"), "1/1/2005")))))
                    Else
                        strActualEnd = ""
                    End If
    'End Addition
    'End Modification
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
    'End
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineWork"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strParentTask_UID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ParentTask_UID"), "0"))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("TaskID"), "0"))
                    strApplyEffortDistribution = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ApplyEffortDistribution"), "0"))
                    strHaveSubTaskTypes = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("HaveSubTaskTypes"), "0"))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strStartDate <> "" Then
                        strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                    End If
                    If strEndDate <> "" Then
                        strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                    End If
                    If strActualStart <> "" Then
                        strActualStart = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStart))
                    End If
                    If strActualEnd <> "" Then
                        strActualEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'Commented by JyotiG
                        'Start
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"
                        'End
                        'End Addition PurvaJ 
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        ''Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'Commented by JyotiG
                        'Start
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"
                        'End
                        'End Addition PurvaJ 
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drProjects)
            End If
    '==============================================================================================
    'For ISSUES
            If strModule.ToUpper = "ISSUES" Then


                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim dtIssueStartDate As String
                Dim dtIssueEndDate As String
                '--- Plot Table Column Headers
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=10%>" & MyBase.GetResourceString("COL_ISSUEID") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=65%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td></tr>"
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=10%>" & MyBase.GetResourceString("COL_ISSUEID") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=65%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td><td width=65%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=10%>" & MyBase.GetResourceString("COL_ISSUEID") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=65%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td><td width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'Commented and Modified By JyotiG
                'Start
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                'Else
                '    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL,NULL"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
                'End of modification By JyotiG
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strIssueID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueID"), ""))
                    strIssueStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Issue_Status"), ""))
                    strIssueSummary = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Summary"), ""))
                    'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'Start                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    If Not IsDBNull(drProjects("Task_StartDate")) Then
                        dtIssueStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Task_StartDate"), "01/01/2005"))))
                    Else
                        dtIssueStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("Task_EndDate")) Then
                        dtIssueEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Task_EndDate"), "01/01/2005"))))
                    Else
                        dtIssueEndDate = ""
                    End If
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'End                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Work"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    'End Addition PurvaJ
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If dtIssueStartDate <> "" Then
                        dtIssueStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueStartDate))
                    End If
                    If dtIssueEndDate <> "" Then
                        dtIssueEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueEndDate))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>" '</TR>
                        'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>" '</TR>                   

                        'End Addition PurvaJ
                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>" '</TR>
                        'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>" '</TR>
                        'End Addition PurvaJ
                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If

                End While
                CommonFunction.Data.DisposeDataReader(drProjects)
            End If
    '==============================================================================================
    'For REVIEWS
            If strModule.ToUpper = "REVIEWS" Then

                Dim strReviewTitle As String
                Dim strReviewType As String
                Dim strReviewStatus As String
                Dim strReviewedBy As String
                Dim strReviewee As String
                Dim strIssueIDs As String
                Dim strReviewStatisticsID As String
                Dim strReviewsStart As String
                Dim strReviewsEnd As String
                '--- Plot Table Column Headers
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=65%>" & "Actual Start" & "</td><td width=65%>" & "Actual End" & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_7409_01-Nov-2006
                'strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=15%>" & "Actual Start" & "</td><td width=15%>" & "Actual End" & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=15%>" & "Review Start" & "</td><td width=15%>" & "Review End" & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                'End_JG_7409_01-Nov-2006
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_7408_08-Nov-2006
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "'"
                'Else
                '    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "',NULL"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
                'End_JG_7408_08-Nov-2006
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strReviewTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewTitle"), ""))
                    strReviewType = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewType"), ""))
                    strReviewStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatus"), ""))
                    strReviewedBy = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewedBy"), ""))
                    strReviewee = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Reviewee"), ""))
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'Start                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    If Not IsDBNull(drProjects("ReviewStartDate")) Then
                        'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                        strReviewsStart = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStartDate"), "01/01/2005"))))
                    Else
                        strReviewsStart = ""
                    End If
                    If Not IsDBNull(drProjects("ReviewEndDate")) Then
                        strReviewsEnd = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewEndDate"), "01/01/2005"))))
                    Else
                        strReviewsEnd = ""
                    End If
                    'End Addition PurvaJ
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'End                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    strIssueIDs = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueIDs"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strReviewStatisticsID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatisticsID"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strReviewsStart <> "" Then
                        strReviewsStart = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsStart))
                    End If
                    If strReviewsEnd <> "" Then
                        strReviewsEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        'Added by purvaj on 12 may 2006 for WhizibleSEM 6.1 issue 3636 for PM dashboard enhancements
                        strXML += "<TD align='center'>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsEnd & "</TD>"
                        'End addition purvaj
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        'Added by purvaj on 12 may 2006 for WhizibleSEM 6.1 issue 3636 for PM dashboard enhancements
                        strXML += "<TD align='center'>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsEnd & "</TD>"
                        'End addition purvaj
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"
                    End If

                End While
                CommonFunction.Data.DisposeDataReader(drProjects)
            End If
    '==============================================================================================
    'For MILESTONE
            If strModule.ToUpper = "MILESTONES" Then
                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim strMileStoneID As String
                Dim strMileStone As String
                Dim strPlannedCompletionDate As String
                Dim strActualCompletionDate As String
                Dim strMileStoneStatus As String
                Dim strMilestoneStartDate As String
                Dim strMilestoneEndDate As String

                '--- Plot Table Column Headers
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td></tr>"
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                ' strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'Commented And Modified By JyotiG
                'Start_JG_13-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & "Actual End" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End_JG_13-Nov-2006
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'Commented and Modified By JyotiG
                'Start_JG_02-Nov-2006
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                'Else
                '    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL,NULL"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                End If
                'End_JG_02-Nov-2006
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strMileStoneID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStoneID"), ""))
                    strMileStone = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStone"), ""))
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'Start                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    If Not IsDBNull(drProjects("PlannedCompletionDate")) Then
                        strPlannedCompletionDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("PlannedCompletionDate"), "1/1/2005"))))
                    Else
                        strPlannedCompletionDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualCompletionDate")) Then
                        strActualCompletionDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualCompletionDate"), "1/1/2005"))))
                    Else
                        strActualCompletionDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStart")) Then
                        strMilestoneStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStart"), "1/1/2005"))))
                    Else
                        strMilestoneStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEnd")) Then
                        strMilestoneEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEnd"), "1/1/2005"))))
                    Else
                        strMilestoneEndDate = ""
                    End If
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'End                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    strMileStoneStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStoneStatus"), ""))

                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), "0"))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strPlannedCompletionDate <> "" Then
                        strPlannedCompletionDate = CommonFunctions.Dates.CGetDate(Date.Parse(strPlannedCompletionDate))
                    End If
                    If strActualCompletionDate <> "" Then
                        strActualCompletionDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualCompletionDate))
                    End If

                    If strMilestoneStartDate <> "" Then
                        strMilestoneStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strMilestoneStartDate))
                    End If
                    If strMilestoneEndDate <> "" Then
                        strMilestoneEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strMilestoneEndDate))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Milestone_OnClick(" & strProjectID & "," & strMileStoneID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strMileStone & "</TD>"
                        strXML += "<TD align='center'>" & strPlannedCompletionDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualCompletionDate & "</TD>"
                        'Added by PurvaJ on 12 May 2006 for WhizibleSEM 6.1 issue 3636 PM Dashboard Enhancements
                        strXML += "<TD align='center'>" & strMilestoneStartDate & "</TD>"
                        'strXML += "<TD align='center'>" & strMilestoneEndDate & "</TD>"
                        'End Addition  PurvaJ
                        strXML += "<TD align='center'>" & strMileStoneStatus & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Milestone_OnClick(" & strProjectID & "," & strMileStoneID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strMileStone & "</TD>"

                        strXML += "<TD align='center'>" & strPlannedCompletionDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualCompletionDate & "</TD>"
                        'Added by PurvaJ on 12 May 2006 for WhizibleSEM  6.1 issue 3636 PM Dashboard Enhancements
                        strXML += "<TD align='center'>" & strMilestoneStartDate & "</TD>"
                        'strXML += "<TD align='center'>" & strMilestoneEndDate & "</TD>"
                        'End Addition  PurvaJ
                        strXML += "<TD align='center'>" & strMileStoneStatus & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drProjects)
            End If
    '==============================================================================================
    'For DELIVERABLES
            If strModule.ToUpper = "DELIVERABLES" Then
                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim strScheduleID As String
                Dim strTitle As String
                'Dim strActualWork As String


                '--- Plot Table Column Headers
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & MyBase.GetResourceString("COL_TITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & MyBase.GetResourceString("COL_TITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'Commented and modified By JyotiG
                'Start_JG_13-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_TITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & "Actual End" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_TITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'End_JG_13-Nov-2006
                'End of Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791

                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'If strToDate = "NULL" Then
                If strStartEndDate = "S" Then
                    'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                    strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL,NULL"
                    'Else
                ElseIf strStartEndDate = "E" Then
                    'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                    strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                    'End of Commented by SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                End If

                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Title"), ""))
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'Start                
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005"))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("EarliestStartDate")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EarliestStartDate"), "1/1/2005"))))
                    Else
                        strEndDate = ""
                    End If
                    'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    If Not IsDBNull(drProjects("ActualStartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStartDate"), "1/1/2005"))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEndDate"), "1/1/2005"))))
                    Else
                        strActualEnd = ""
                    End If
                    'End Addition PUrvaJ
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                    'End
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    'Added By SandeepA on 23 Dec,2005 for Deliverables :Actual Work
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEffort"), "0"))
                    'End of Addition

                    strScheduleID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ScheduleID"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strStartDate <> "" Then
                        strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                    End If
                    If strEndDate <> "" Then
                        strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                    End If
                    If strActualStart <> "" Then
                        strActualStart = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStart))
                    End If
                    If strActualEnd <> "" Then
                        strActualEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Deliverable_OnClick(" & strScheduleID & ")'>" & strDocumentLink & "</a></TD>"
                        strXML += "<TD align='Left'>" & strTitle & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"
                        'End Modification PUrvaJ
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Deliverable_OnClick(" & strScheduleID & ")'>" & strDocumentLink & "</a></TD>"
                        strXML += "<TD align='Left'>" & strTitle & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"
                        'End Modification PUrvaJ
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(drProjects)
            End If

            If strModule.ToUpper = "WEEK" Then

                'Dim strActualWork As String
                Dim datareaderflag As Boolean

                strXML = ""
                strXML = strXML + "<table id='Tasks' class='clsGridTable' name=='Tasks' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"

                '=========== For TASKS 
                'Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                ' strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=10%>" & "Actual End" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_03-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End_JG_03-Nov-2006
                'End of Commented and Modified by SvaitaS on 29 Sept 2006 for SP7 IssueID 6466
                'Commented and Modified By JyotiG
                'Start_01-Nov-2006
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
                'Else
                '    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
                'End If
                If strStartEndDate = "S" Then
                    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
                    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "','" & strFromDate & "'"
                ElseIf strStartEndDate = "E" Then
                    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
                    strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
                'End_01-Nov-2006
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                datareaderflag = True
                'Added By JyotiG
                'Start_JG_03-Nov-2006
                strPrevProjectName = ""
                'End_JG-03-Nov-2006
                While drProjects.Read()
                    datareaderflag = False
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("TaskName"), ""))

                    If Not IsDBNull(drProjects("BaseLineStart")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineStart"), "1/1/2005")))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("BaseLineEnd")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineEnd"), "1/1/2005")))))
                    Else
                        strEndDate = ""
                    End If

                    'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005")))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("EndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EndDate"), "1/1/2005")))))
                    Else
                        strActualEnd = ""
                    End If

                    'End Addition
                    'End Modification
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineWork"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strParentTask_UID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ParentTask_UID"), "0"))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("TaskID"), "0"))
                    strApplyEffortDistribution = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ApplyEffortDistribution"), "0"))
                    strHaveSubTaskTypes = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("HaveSubTaskTypes"), "0"))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strStartDate <> "" Then
                        strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                    End If
                    If strEndDate <> "" Then
                        strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                    End If
                    If strActualStart <> "" Then
                        strActualStart = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStart))
                    End If
                    If strActualEnd <> "" Then
                        strActualEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        'blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"

                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)

                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"

                        'End Addition PurvaJ 
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        'blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"

                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"

                        'End Addition PurvaJ 
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                If datareaderflag = False Then
                    strXML += "<TR><TD><BR></TD></TR>"
                Else
                    strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD><BR></TD></TR>"
                    'strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD></TD></TR>"
                End If
                'drProjects.Dispose()
                CommonFunctions.Data.DisposeDataReader(drProjects)
                'Added By JyotiG 
                'Start_JG_7524_10-Nov-2006
                strXML += "</TABLE>"
                strXML = strXML + "<table id='Issues' class='clsGridTable' name=='Issues' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"
                'End_JG_7524_10-Nov-2006
                '=============================== for ISSUES (WEEK)
                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim dtIssueStartDate As String
                Dim dtIssueEndDate As String

                '--- Plot Table Column Headers
                'Commented and Modified by SvaitaS on 29 Sept 2006 for SP7 IssueID 6466
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=10%>" & MyBase.GetResourceString("COL_ISSUEID") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=65%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td><td width=65%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_ISSUEID") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=20%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td><td width=20%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td width=20%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td width=5%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td width=5%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End of Commented and Modified by SvaitaS on 29 Sept 2006 for SP7 IssueID 6466
                'Commented and Modified By JyotiG
                'start
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                'Else
                '    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",'" & strFromDate & "','" & strFromDate & "',NULL,NULL"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Issues " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                    'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
                'End of modification By JyotiG
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                datareaderflag = True
                'Start_JG_03-Nov-2006
                strPrevProjectName = ""
                'End_JG-03-Nov-2006
                While drProjects.Read()
                    datareaderflag = False
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strIssueID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueID"), ""))
                    strIssueStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Issue_Status"), ""))
                    strIssueSummary = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Summary"), ""))
                    'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                    If Not IsDBNull(drProjects("Task_StartDate")) Then
                        dtIssueStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Task_StartDate"), ""))))
                    Else
                        dtIssueStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("Task_EndDate")) Then
                        dtIssueEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Task_EndDate"), ""))))
                    Else
                        dtIssueEndDate = ""
                    End If

                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Work"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    'End Addition PurvaJ
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If dtIssueStartDate <> "" Then
                        dtIssueStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueStartDate))
                    End If
                    If dtIssueEndDate <> "" Then
                        dtIssueEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueEndDate))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If intcount Mod 2 = 0 Then
                        'blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        'Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                        'strXML += "<TD align='Left'>" & strIssueSummary & "</TD></TR>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>"
                        'End of Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                        'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements

                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>"
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>"

                        'End Addition PurvaJ
                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        'savita 29 sept
                        'strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD>"
                        'savita 29 sept
                    Else
                        'blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>"
                        'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements

                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>"
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>"

                        'End Addition PurvaJ
                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If
                End While

                If datareaderflag = False Then
                    strXML += "<TR><TD><BR></TD></TR>"
                Else
                    strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD><BR></TD></TR>"
                    'strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD></TD></TR>"
                End If

                CommonFunctions.Data.DisposeDataReader(drProjects)

                'For REVIEWS
                '================= REVIEWS
                Dim strReviewTitle As String
                Dim strReviewType As String
                Dim strReviewStatus As String
                Dim strReviewedBy As String
                Dim strReviewee As String
                Dim strIssueIDs As String
                Dim strReviewStatisticsID As String
                Dim strReviewsStart As String
                Dim strReviewsEnd As String

                '--- Plot Table Column Headers
                'Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                'strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=65%>" & "Actual Start" & "</td><td width=65%>" & "Actual End" & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_7409_01-Nov-2006
                'strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=20%>" & "Actual Start" & "</td><td width=20%>" & "Actual End" & "</td><td width=5%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=5%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=20%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=20%>" & "Review Start" & "</td><td width=20%>" & "Review End" & "</td><td width=5%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=5%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"
                'End_JG_7409_01-Nov-2006
                'End of Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                'Commented and Modified By JyotiG
                'Start_JG_7408_08-Nov-2006
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "'"
                'Else
                '    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "'"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "','" & strFromDate & "'"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                End If
                'End_JG_7408_08-Nov-2006
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                datareaderflag = True
                'Start_JG_03-Nov-2006
                strPrevProjectName = ""
                'End_JG-03-Nov-2006
                While drProjects.Read()
                    datareaderflag = False
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strReviewTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewTitle"), ""))
                    strReviewType = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewType"), ""))
                    strReviewStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatus"), ""))
                    strReviewedBy = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewedBy"), ""))
                    strReviewee = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Reviewee"), ""))
                    'Added by PurvaJ 12 May 2006 issue 3636 WhizibleSEM 6.1 PM Dashboard Enhanced View Enhancements
                    If Not IsDBNull(drProjects("ReviewStartDate")) Then
                        strReviewsStart = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStartDate"), ""))))
                    Else
                        strReviewsStart = ""
                    End If
                    If Not IsDBNull(drProjects("ReviewEndDate")) Then
                        strReviewsEnd = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewEndDate"), ""))))
                    Else
                        strReviewsEnd = ""
                    End If

                    'End Addition PurvaJ
                    strIssueIDs = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueIDs"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strReviewStatisticsID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatisticsID"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strReviewsStart <> "" Then
                        strReviewsStart = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsStart))
                    End If
                    If strReviewsEnd <> "" Then
                        strReviewsEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If intcount Mod 2 = 0 Then
                        ' blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        'Added by purvaj on 12 may 2006 for WhizibleSEM 6.1 issue 3636 for PM dashboard enhancements

                        strXML += "<TD align='center' width=10%>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center' width=10%>" & strReviewsEnd & "</TD>"

                        'End addition purvaj
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"

                    Else
                        'blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        'Added by purvaj on 12 may 2006 for WhizibleSEM 6.1 issue 3636 for PM dashboard enhancements

                        strXML += "<TD align='center'>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsEnd & "</TD>"

                        'End addition purvaj
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"

                    End If

                End While
                If datareaderflag = False Then
                    strXML += "<TR><TD><BR></TD></TR>"
                Else
                    strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TD><BR></TD></TR>"
                    'strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TD></TD></TR>"
                End If

                CommonFunctions.Data.DisposeDataReader(drProjects)
                'Added By JyotiG 
                'Start_13-Nov-2006
                strXML += "</TABLE>"
                strXML = strXML + "<table id='Milestone' class='clsGridTable' name=='Milestone' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"
                '=================
                '=======================For MILESTONE
                Dim strMileStoneID As String
                Dim strMileStone As String
                Dim strPlannedCompletionDate As String
                Dim strActualCompletionDate As String
                Dim strMileStoneStatus As String
                Dim strMilestoneStartDate As String
                Dim strMilestoneEndDate As String

                '--- Plot Table Column Headers
                'Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_13-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                'End_JG_13-Nov-2006
                'End of Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                'Commented By JyotiG
                'Start_JG_02-Nov-2006
                'If strToDate = "NULL" Then
                '    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                'Else
                '    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                'End If
                If strStartEndDate = "S" Then
                    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "','" & strFromDate & "',NULL,NULL"
                ElseIf strStartEndDate = "E" Then
                    strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                End If
                'End_JG_02-Nov-2006
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                datareaderflag = True
                'Start_JG_03-Nov-2006
                strPrevProjectName = ""
                'End_JG-03-Nov-2006
                While drProjects.Read()
                    datareaderflag = False
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strMileStoneID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStoneID"), ""))
                    strMileStone = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStone"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), "0"))
                    If Not IsDBNull(drProjects("PlannedCompletionDate")) Then
                        strPlannedCompletionDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("PlannedCompletionDate"), "1/1/2005"))))
                    Else
                        strPlannedCompletionDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualCompletionDate")) Then
                        strActualCompletionDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualCompletionDate"), "1/1/2005"))))
                    Else
                        strActualCompletionDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStart")) Then
                        strMilestoneStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStart"), "1/1/2005"))))
                    Else
                        strMilestoneStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEnd")) Then
                        strMilestoneEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEnd"), "1/1/2005"))))
                    Else
                        strMilestoneEndDate = ""
                    End If

                    strMileStoneStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("MileStoneStatus"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strPlannedCompletionDate <> "" Then
                        strPlannedCompletionDate = CommonFunctions.Dates.CGetDate(Date.Parse(strPlannedCompletionDate))
                    End If
                    If strActualCompletionDate <> "" Then
                        strActualCompletionDate = CommonFunctions.Dates.CGetDate(Date.Parse(strActualCompletionDate))
                    End If
                    If strMilestoneStartDate <> "" Then
                        strMilestoneStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strMilestoneStartDate))
                    End If
                    If strMilestoneEndDate <> "" Then
                        strMilestoneEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strMilestoneEndDate))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If intcount Mod 2 = 0 Then
                        ' blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Milestone_OnClick(" & strProjectID & "," & strMileStoneID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strMileStone & "</TD>"

                        strXML += "<TD align='center'>" & strPlannedCompletionDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualCompletionDate & "</TD>"
                        'Added by PurvaJ on 12 May 2006 for WhizibleSEM 6.1 issue 3636 PM Dashboard Enhancements
                        strXML += "<TD align='center'>" & strMilestoneStartDate & "</TD>"
                        'strXML += "<TD align='center'>" & strMilestoneEndDate & "</TD>"
                        'End Addition  PurvaJ
                        strXML += "<TD align='center'>" & strMileStoneStatus & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Milestone_OnClick(" & strProjectID & "," & strMileStoneID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strMileStone & "</TD>"

                        strXML += "<TD align='center'>" & strPlannedCompletionDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualCompletionDate & "</TD>"
                        'Added by PurvaJ on 12 May 2006 for WhizibleSEM 6.1 issue 3636 PM Dashboard Enhancements
                        strXML += "<TD align='center'>" & strMilestoneStartDate & "</TD>"
                        'strXML += "<TD align='center'>" & strMilestoneEndDate & "</TD>"

                        'End Addition  PurvaJ
                        strXML += "<TD align='center'>" & strMileStoneStatus & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                If datareaderflag = False Then
                    strXML += "<TR><TD><BR></TD></TR>"
                Else
                    strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD><BR></TD></TR>"
                    'strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD></TD></TR>"
                End If

                CommonFunctions.Data.DisposeDataReader(drProjects)
                'Added By JyotiG 
                'Start_JG_7524_10-Nov-2006
                strXML += "</TABLE>"
                strXML = strXML + "<table id='Deliverable' class='clsGridTable' name=='Deliverable' cellSpacing='1' cellPadding='0' width='100%' align='center' border='0' >"
                'End_JG_7524_10-Nov-2006
                '==============================================================================================
                '=========================For DELIVERABLES

                Dim strScheduleID As String
                Dim strTitle As String
                Dim strDeliverableLCE As String
                'Dim strActualWork As String


                '--- Plot Table Column Headers
                'Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466
                ' strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=50%>" & "Deliverable" & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & "Actual End" & "</td><td align='center' width=15%>" & "Planned Work" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_02-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & "Deliverable" & "</td><td width=20%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=5%>" & "Planned Work" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'Commented and Modified By JyotiG
                'Start_JG_13-Nov-2006
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & "Deliverable" & "</td><td width=20%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Actual End" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & "Deliverable" & "</td><td width=20%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=20%>" & "Actual Start" & "</td><td align='center' width=5%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"
                'End_JG_13-Nov-2006
                'End_JG_02-Nov-2006
                'End of Commented and Modified by SavitaS on 29 Sept 2006 for SP7 IssueID 6466

                'Commented by and Modified SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                'If strToDate = "NULL" Then
                If strStartEndDate = "S" Then
                    'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL"
                    strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "','" & strFromDate & "',NULL,NULL"
                    'Else
                ElseIf strStartEndDate = "E" Then
                    'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "','" & strToDate & "',NULL,NULL"
                    strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                    'End of Commented by SavitaS on 05 Sept 2006 for SP& Integration IssueID 5791
                End If

                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                datareaderflag = True
                'Start_JG_03-Nov-2006
                strPrevProjectName = ""
                'End_JG-03-Nov-2006
                While drProjects.Read()
                    datareaderflag = False

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Title"), ""))
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005"))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("EarliestStartDate")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EarliestStartDate"), "1/1/2005"))))
                    Else
                        strEndDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStartDate"), "1/1/2005"))))
                    Else
                        strActualStart = ""
                    End If
                    'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                    If Not IsDBNull(drProjects("ActualEndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEndDate"), "1/1/2005"))))
                    Else
                        strActualEnd = ""
                    End If

                    'strDeliverableLCE = strTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DelilverableLCE"), ""))
                    'End Addition PUrvaJ
                    'Added By SandeepA on 23 Dec,2005 for Deliverables :Actual Work
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEffort"), "0"))
                    'End of Addition

                    strScheduleID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ScheduleID"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))

                    If strProjectName <> strPrevProjectName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    End If
                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    'Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration
                    If strStartDate <> "" Then
                        strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(strStartDate))
                    End If
                    If strEndDate <> "" Then
                        strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(strEndDate))
                    End If
                    If strActualStart <> "" Then
                        strActualStart = CommonFunctions.Dates.CGetDate(Date.Parse(strActualStart))
                    End If
                    If strActualEnd <> "" Then
                        strActualEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strActualEnd))
                    End If
                    'End of Added by SavitaS on 30 Aug 2006 for IssueID 5787 for SP7 Integration

                    If intcount Mod 2 = 0 Then
                        ' blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Deliverable_OnClick(" & strScheduleID & ")'>" & strDocumentLink & "</a></TD>"
                        strXML += "<TD align='Left'>" & strTitle & "</TD>"

                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"

                        'End Modification PUrvaJ
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                        'strXML += "<TD align='center'>" & strDeliverableLCE & "</TD></TR>"

                    Else
                        ' blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Deliverable_OnClick(" & strScheduleID & ")'>" & strDocumentLink & "</a></TD>"
                        strXML += "<TD align='Left'>" & strTitle & "</TD>"

                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        'strXML += "<TD align='center'>" & strActualEnd & "</TD>"

                        'End Modification PUrvaJ
                        'strXML += "<TD align='center'>" & strDeliverableLCE & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If
                End While
                If datareaderflag = False Then
                    strXML += "<TR><TD><BR></TD></TR>"
                Else
                    strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD><BR></TD></TR>"
                    'strXML += "<TR class='clsTROdd'><TD colspan=8 align='center'>" & "There are no items to list" & "</TD></TR><TR><TD></TD></TR>"
                End If
                blnFlag = True
            End If '=========End "WEEK" Mode if
    '==============================================================================================

            If blnFlag = False Then
    Dim strSpace As String = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                strXML += "<TR class='clsTROdd'><TD colspan=5 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>"
            End If

            strXML += "</TABLE>"
            CommonFunctions.Data.DisposeDataReader(drTasks)
            CommonFunctions.Data.DisposeDataReader(drProjects)
    '--- Clear and return the RESPONSE.
            Response.Clear()
            Response.Write(strXML)

    'Catch ex As Exception
    '   MsgBox(ex.Message)
    'Handle for exceptions
    'End Try
        End If
    'End If
    End Sub
    'End of addition by SandeepA on 12 Dec,2005 for the Hover on Calender Date onClick

    Private Function DrawTabs() As String
        '=====================================================================
        ' Procedure Name        : DrawTabs
        ' Purpose               : Draws the Menu-like Tabs 
        ' Description           : To Do | Issues | Reviews | My Projects
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================

        '-- Generate the Menu-like 'Tabs' for the following
        '--To do list | Issues | Reviews | My Projects | Help

        Dim strTabs As String
        Dim strMode, strList As String
        'Added By SandeepA on 16 Dec,2005 for PMDashboard_OutlookView
        '--- Initialize Resources
        'MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")
        CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable'><TR class='clsTRPageCaption'><TD align='Left'><B>" & MyBase.GetResourceString("LBL_CALENDAR") & "</B></TD></TR></TABLE>")
        '--- Display Legends
        CommonFunctions.General.WriteHTML("<TABLE width=100%><TR class='clsTREven' align='Right'>")
        CommonFunctions.General.WriteHTML("<TD width=88.5%><B> " & MyBase.GetResourceString("HOLIDAYS_LABEL") & " &nbsp;&nbsp; </B></TD><TD width=25 height=7 bgcolor='RED' ></TD><TD align='Right'>&nbsp;&nbsp;&nbsp;&nbsp;<B>" & MyBase.GetResourceString("LEAVES_LABEL") & "&nbsp;&nbsp; </B></TD><TD width=25 height=7 bgcolor='BLUE' align='Right'></TD>")
        CommonFunctions.General.WriteHTML("</TR></TABLE>")

        '--- To Get the module.
        If CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"), "")) = "5" Then
            strMode = "TASKS"
            strList = ""
        Else
            strList = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("List"), ""))
            If strList = "" Then
                strMode = CStr(CommonFunction.General.CheckIsNothing(Session("MODULE"), "TASKS"))
            Else
                strMode = ""
            End If
        End If
        'End of addition by SandeepA on 16 Dec,2005 for PMDashboard_OutlookView

        strTabs = "<table cellspacing=0 border=0 width=100%>"
        strTabs += "<tr >"
        strTabs += "<td align=Left id='objTDCell' >"

        'Added By SandeepA on 16 Dec,2005 for Calender Dashboard (OutLook View)
        If CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
            'Added by PrashantSJ on 17-Feb-2006 for This month
            strTabs += "<a style='TEXT-DECORATION:None' "
            strTabs += " href='javascript:ThisMonth_clicked(""" & Session("MODULE") & """)' ><Font Size=1 face=Arial;verdana color=black><B>|"
            strTabs += "<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblThisMonth>"
            strTabs += "This Month" + "</font></b></font>"
            strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>"
            'End of Addition by PrashantSJ on 17-Feb-2006 for This month
            strTabs += "<a style='TEXT-DECORATION:None' "
            strTabs += " href='javascript:PreviousMonth_clicked(""" & Session("MODULE") & """)' ><Font Size=1 face=Arial;verdana color=black><B>|"
            strTabs += "<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblAssignedTasks>"
            strTabs += "Previous Month" + "</font></b></font>"
            strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>|"

            strTabs += "<a style='TEXT-DECORATION:None' "
            strTabs += " Href='javascript:NextMonth_clicked(""" & Session("MODULE") & """)' >"
            strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=Black><b id=lblReview>" + "Next Month "
            strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

            'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            strTabs += "<a style='TEXT-DECORATION:None' "
            strTabs += " Href='javascript:Week_clicked(""" & Session("MODULE") & """)' >"
            strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=Black><b id=lblWeek>" + "Week"
            strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
            'strTabs += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            If intWeekFlag = 1 Then
                'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                strTabs += "<a style='TEXT-DECORATION:None' "
                
                strTabs += " Href='javascript:PreviousWeek_clicked(""" & Session("MODULE") & """)' >"
                'strTabs += " Href='javascript:PreviousWeek_clicked(""" & Session("MODULE") & """,""" & dtWeekDate & """)' >"

                strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=Black><b id=lblWeek>" + "Previous Week"
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
                'strTabs += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                'End Addition PurvaJ

                'Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
                strTabs += "<a style='TEXT-DECORATION:None' "
                
                strTabs += " Href='javascript:NextWeek_clicked(""" & Session("MODULE") & """)' >"
                'strTabs += " Href='javascript:NextWeek_clicked(""" & Session("MODULE") & """,""" & dtWeekDate.ToString("dd-MM-yyyy") & """)' >"

                strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=Black><b id=lblWeek>" + "Next Week"
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
                strTabs += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                'End Addition PurvaJ
            End If
        End If

        'End of addition By Sandeep A on 16 Dec,2005 for PMDashoard_OutlookView

        strTabs += "</td>"
        strTabs += "<td align=right>"
        'Modified by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 issue 3636(PM DashBoard Enhanced View Enhacements)
        'The tabs are displayed only when month,previous month or next month is clicked.
        If intWeekFlag <> 1 Then
            If CType(Session("m_PageMode"), Double) = PageModes.WHIZIBLE_TODAY Or CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
                '-- TO DO LIST
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += " href='javascript:Assignments_clicked(1)' ><Font Size=1 face=Arial;verdana color=black><B>|"
                strTabs += "<img border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"
                If strList = "5" Or strList = "1" Or strMode.ToUpper = "TASKS" Or strMode.ToUpper = "TODO" Then
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "<Font Size=1 face=Arial;verdana color=black>&nbsp;<b id=lblAssignedTasks>"
                    strTabs += "<Font Size=1 face=Arial;verdana color=white>&nbsp;<b id=lblAssignedTasks>"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                Else
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "<Font Size=1 face=Arial;verdana color=white>&nbsp;<b id=lblAssignedTasks>"
                    strTabs += "<Font Size=1 face=Arial;verdana color=navy>&nbsp;<b id=lblAssignedTasks>"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                End If
                strTabs += MyBase.GetResourceString("TAB_TO_DO") + "</font></b></font>"
                'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>|"
                'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
            End If

            '-- ISSUES LIST
            If CType(Session("m_PageMode"), Double) = PageModes.WHIZIBLE_TODAY Or CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += "Href='javascript:Assignments_clicked(2)' >"
                strTabs += "<img SRC='../../images/arrowselect.gif' border=0 WIDTH=7 >"
                If strList = "2" Or strMode.ToUpper = "ISSUES" Then
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><b id=lblIssues>"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblIssues>"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                Else
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    ' strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblIssues>"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblIssues>"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                End If
                strTabs += m_strIssueName
                strTabs += "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

            End If

            '-- Reviews
            If CType(Session("m_PageMode"), Double) = PageModes.WHIZIBLE_TODAY Or CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += " Href='javascript:Assignments_clicked(8)' >"
                strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"
                If strList = "8" Or strMode.ToUpper = "REVIEWS" Then
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                Else
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                End If
                'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
                'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
            End If

            '-- Milestones
            If CType(Session("m_PageMode"), Double) = PageModes.WHIZIBLE_TODAY Or CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += " Href='javascript:Assignments_clicked(6)' >"
                strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"
                If strList = "6" Or strMode.ToUpper = "MILESTONES" Then
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                Else
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                End If
            End If


            ' To Add Deliverable Reporting on Dashboard.
            If CType(Session("m_PageMode"), Double) = PageModes.WHIZIBLE_TODAY Or CType(Session("m_PageMode"), Double) = PageModes.CALENDER Then
                '-- Deliverables
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += " Href='javascript:Assignments_clicked(9)' >"
                strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"
                If strList = "9" Or strMode.ToUpper = "DELIVERABLES" Then
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                Else
                    'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                    'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
                    'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                End If
            End If


            '-- MY PROJECTS
            If CType(Session("m_PageMode"), Double) = PageModes.MY_PROJECT_LIST Then
                strTabs += "<a style='TEXT-DECORATION:None' "
                strTabs += "Href='javascript:Assignments_clicked(4)' >"
                strTabs += "<img SRC='../../images/arrowselect.gif' Border=0 WIDTH=7 >"
                'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                ' strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</b></font>"
                strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</b></font>"
                'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"


                '-- Show All Projects/ Show Selected Projects
                If Not Session("intProjectID") Is Nothing Then
                    If m_blnSetProjectFilter = True Then
                        strTabs += "<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(0)'>"
                        'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font></b>"
                        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font></b>"
                        'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                        strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
                    Else
                        strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(1)'>"
                        'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                        ' strTabs += "<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</font></b>"
                        strTabs += "<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</font></b>"
                        'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
                        strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
                    End If
                End If
            End If
        End If
        'Commented By SandeepA on22 Dec,2005 to hide help
        '-- HELP
        If (Request("FromWhereDB") = "PM") Then
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:OpenPMPage()'>"
            'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
            strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

        Else
            If intWeekFlag = 1 Then
                strTabs += "<Font Size=1 face=Arial;verdana color=black>|</font>"
            End If
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('Calendar')>"
            'strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
            'Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
            'End of Commented and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueId 5779
        End If
        'end of comment by SandeepA on 22 Dec,2005.

        strTabs += "</td></tr></table>"

        Return strTabs
    End Function

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")


    End Sub

    Public Sub PlotHead()
        '--- Added By SandeepA on 15 Nov,2005 for XMLHTTP Hover (Tasks)
        Dim strFromWhere As String
        strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        If strFromWhere = "XMLHTTP" Then
            Exit Sub
        End If
        '--- End of Addition by SandeepA on 15 Nov,2005
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub GetWeekStartAndEndDates(ByRef dtmFromDate As String, ByRef dtmToDate As String, ByVal dtDate As DateTime, ByVal intStartingDayOfWeek As Integer)
        '#### NOTE: THIS FUNCTION Will Go Into Application's CommonFunctions ####
        '=====================================================================
        ' Procedure Name		:	GetWeekStartAndEndDates
        ' Purpose				:	To Retrieve the Date Range for the specified custom period.
        ' Description			:	Same as above.
        ' Parameters Passed		:	
        '							dtmFromDate :- The From Date will be returned in this varaible.
        '							dtmToDate	:- The To Date will be returned in this varaible.
        '							
        ' Parameters Affected	:	dtmFromDate, dtmToDate			
        ' Returns				:	No return Values.
        ' Assumptions			:
        ' Dependencies			:
        ' Author				:	PrashantSJ
        ' Created				:	Friday, February 18, 2006
        '=====================================================================
        Dim cmdDateRange As New SqlClient.SqlCommand
        'Try

        cmdDateRange.CommandType = CommandType.StoredProcedure


        cmdDateRange.CommandText = "usp_Get_WeekStartAndEndDatesForDate_FromMon_ForCalender"

        '-- Adding Parameters
        cmdDateRange.Parameters.Add(New SqlClient.SqlParameter("@dtmDate", SqlDbType.DateTime))
        'cmdDateRange.Parameters("@dtmDate").Value = CType(DateTime.Today.ToShortDateString, DateTime)
        'Added by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 issue 3636 (PM DashBoard Enhanced View Enhancements)
        cmdDateRange.Parameters("@dtmDate").Value = CType(dtDate, DateTime)
        'End Addition PurvaJ
        cmdDateRange.Parameters.Add(New SqlClient.SqlParameter("@dtmStart", SqlDbType.DateTime))
        cmdDateRange.Parameters("@dtmStart").Direction = ParameterDirection.Output

        cmdDateRange.Parameters.Add(New SqlClient.SqlParameter("@dtmEnd", SqlDbType.DateTime))
        cmdDateRange.Parameters("@dtmEnd").Direction = ParameterDirection.Output


        cmdDateRange.Parameters.Add(New SqlClient.SqlParameter("@blnMonthIndependent", SqlDbType.Bit))
        cmdDateRange.Parameters("@blnMonthIndependent").Value = 0

        cmdDateRange.Parameters.Add(New SqlClient.SqlParameter("@intStartingDayOfWeek", SqlDbType.Int))
        If Trim(intStartingDayOfWeek & "") <> "" Then
            cmdDateRange.Parameters("@intStartingDayOfWeek").Value = CType(intStartingDayOfWeek, Integer)
        Else
            cmdDateRange.Parameters("@intStartingDayOfWeek").Value = 2
        End If
        'Execute the Command and get the Command object
        cmdDateRange = CommonFunction.Data.GetSQLCommandExecute(cmdDateRange, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        dtmFromDate = cmdDateRange.Parameters("@dtmStart").Value.ToString 'CommonFunctions.Data.GetSQLCommandExecute(cmdDateRange.Parameters("@FromDate"))
        dtmToDate = cmdDateRange.Parameters("@dtmEnd").Value.ToString

        cmdDateRange.Dispose()
        cmdDateRange = Nothing
    End Sub
    'Added by SavitaS on 30 Aug 2006 for SP7 Integration IssueID 5784
    Protected Sub GetStyleSheetName()
        'StyleSheetName = CType(CommonFunction.Data.GetDataScalar("SELECT top 1 StyleSheetName FROM tbl_UI_UserSettings A INNER JOIN tbl_UI_StyleSheets B on A.StyleSheetID = B.StyleSheetID WHERE LoginID = (Select LoginID FROM tbl_PM_Login WHERE EmployeeID = " + Session("intUserID").ToString + ")", MyBase.UseSQL), String) & ""
        Dim strQuery As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strQuery = "SELECT top 1 StyleSheetName FROM tbl_UI_UserSettings A INNER JOIN tbl_UI_StyleSheets B on A.StyleSheetID = B.StyleSheetID WHERE LoginID = (Select LoginID FROM tbl_PM_Login WHERE EmployeeID = " + Session("intUserID").ToString + ")"
        strQuery = "usp_sel_tbl_UI_UserSettings_StyleSheetName  " + Session("intUserID").ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        StyleSheetName = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)
        If StyleSheetName = "" Then
            StyleSheetName = "StyleSheetChanakya.css"
        End If
    End Sub
    'End of Added by SavitaS on 30 Aug 2006 for SP7 Integration IssueID 5784
End Class