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

Public Class Home_OutlookView
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


    ''''Added By Amol Changle On: 23 Mar 2009
    Private m_strPageMode As String = ""
    Private m_strModule As String = ""
    Private m_strWeekFlag As String = "0"
    Private m_strDBProjectFilter As String = ""
    Protected m_strList As String = ""
    Private m_strLoggedInUserID As String = "0"
    Private m_strSelectedProjectID As String = "0"
    Private arrTagID As Long() = {1038, 0, 0, 0, 0, 34, 0, 1036, 2133, 661, 1019, 454}
    ''''End Addition


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

        'Commented By Amol Changle On: 24 Mar 2009
        'Added By SandeepA on 12 Dec,2005 for XMLHTTP Calender Hover
        'Dim strFromWhere As String
        'Try
        '    strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        '    If strFromWhere = "XMLHTTP" Then
        '        Exit Sub
        '    End If
        'Catch ex As Exception
        'End Try
        'End of Addition By SandeepA on 12 Dec,2005
        'End Commemts By Amol Changle On: 24 Mar 2009

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

        'Commented By Amol Changle On: 20 MAr 2009
        'If Not IsNothing(HttpContext.Current.Request.QueryString("MODE")) Then
        '    m_PageMode = HttpContext.Current.Request.QueryString("MODE")

        'Session("m_PageMode") = "5"
        m_strPageMode = "5"

        'End If

        'Added By Amol Changle On: 20 Mar 2009

        m_strList = CommonFunctions.General.CheckIsNothing(Request.QueryString("List")).ToString()
        If m_strList = "" Then
            m_strList = CommonFunctions.General.CheckIsNothing(Request.Form("List")).ToString()
        End If

        Select Case m_strList
            Case "1"
                'Session("MODULE") = "TODO"
                'Session("MODULE") = "TASKS"
                m_strModule = "TASKS"
            Case "2"
                'Session("MODULE") = "ISSUES"
                m_strModule = "ISSUES"
            Case "8"
                'Session("MODULE") = "REVIEWS"
                m_strModule = "REVIEWS"
            Case "6"
                'Session("MODULE") = "MILESTONES"
                m_strModule = "MILESTONES"
            Case "9"
                'Session("MODULE") = "DELIVERABLES"
                m_strModule = "DELIVERABLES"
            Case "10"
                m_strModule = "SUBPROJECTS"
            Case "11"
                m_strModule = "RESOURCES"
            Case "12"
                m_strModule = "MODULES"
        End Select
        'End Addition

        'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
        If Not IsNothing(HttpContext.Current.Request.QueryString("WeekFlag")) Then
            intWeekFlag = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WeekFlag"), 0.ToString))
            'Session("WeekFlag") = intWeekFlag
            m_strWeekFlag = intWeekFlag.ToString()
        End If

        'MonthFlag
        If Not IsNothing(HttpContext.Current.Request.QueryString("MonthFlag")) Then
            'Session("WeekFlag") = 0
            m_strWeekFlag = "0"
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


        'Commented By Amol Changle On: 24 Mar 2009
        'purpose: Not used in code
        ' Store approprate value for the Project Filter Session Variable.
        'If Not Session("intProjectID") Is Nothing Then
        '    If Request.QueryString("ProjectFilter") = "1" Then
        '        'Session("DB_ProjectFilter") = True
        '        m_strDBProjectFilter = "True"

        '    ElseIf Request.QueryString("ProjectFilter") = "0" Then
        '        'Session("DB_ProjectFilter") = False
        '        m_strDBProjectFilter = "False"
        '    End If
        'End If
        'End Comments

        'Added by SavitaS on 29 Aug 2006 for SP7 Integration IssueID 5778
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        '' m_intStartDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        m_intStartDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_StartingDayofweek", MyBase.UseSQL), "0"))
        ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        'End of Added by SavitaS on 29 Aug 2006 for SP7 Integration IssueID 5778

        m_strSelectedProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
        m_strLoggedInUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

    End Sub

    Private Sub DrawHiddenFields()
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("List", "List", value:=m_strList, DisplayNone:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("WeekFlag", "WeekFlag", value:=m_strWeekFlag, DisplayNone:=True))

        'Added By VijaYD On 29 August 2009
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
            ' m_intBaselineNumber = dr("BaselineNumber").ToString() 'Added By VijayD 0On 29 August 2009
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectApproved", "hidIsProjectApproved", , , , IsProjectApproved, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidResourceValidation", "hidResourceValidation", , , , ResourceValidation, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOnHold", "hidIsProjectOnHold", , , , IsProjectOnHold, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidIsProjectOver", "hidIsProjectOver", , , , IsProjectOver, , , , , , True, , True))
        'End Addition By VijaYD 

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

        ''''Added By Amol Changle On: 23 Mar 2009
        DrawHiddenFields()
        ''''End Addition

        Dim strFromWhere As String
        Try
            strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
            If strFromWhere = "XMLHTTP" Then
                Call DrawDetails()
            Else
                Call PrepareSections()
            End If
        Catch ex As Exception
            'Exception Handler
        End Try
    End Sub

    Private Sub DrawDetails()
        Dim strModule As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module")).ToString()
        Dim strDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Date")).ToString()

        CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=100%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu'>")
        CommonFunctions.General.WriteHTML("<TD align=right> ")
        CommonFunctions.General.WriteHTML("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A> ")
        CommonFunctions.General.WriteHTML("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF='javascript:Help_OnClick()' Title='Help' >? </A>|")
        CommonFunctions.General.WriteHTML(" </TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<Table width=100% cellspacing=0 cellpadding=0><TR class='clsTRSectionHeader' >")
        CommonFunctions.General.WriteHTML("<TD align='Left'>" + GetEntityName(strModule) + " details for " + CommonFunctions.Dates.GetDate(CType(strDate, Date)) + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align='right'>Project : " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strProjectName")).ToString() + "</TD>")
        CommonFunctions.General.WriteHTML("</TR></Table><BR>")
        CommonFunctions.General.WriteHTML("<Div style='overflow:auto;height:250'>")
        Call XMLHTTP_GetTasks()
        CommonFunctions.General.WriteHTML("</Div>")
        CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=100% >")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu'>")
        CommonFunctions.General.WriteHTML("<TD align=right>")
        CommonFunctions.General.WriteHTML(" | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A>")
        CommonFunctions.General.WriteHTML("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF='javascript:Help_OnClick()' Title='Help' >? </A>|")
        CommonFunctions.General.WriteHTML(" </TD></TR></TABLE>")
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
        Response.Write("<div id='divContainer' style='Height:675px;width:99.99%;overflow:auto'>")

        ''--2. Draw the Tabs
        'strTabs = DrawTabs()

        'With objDashboardSection
        '    Response.Write(.GetSectionTitle(" ", "DivOtherInfo", "", , strTabs, , "", "", ))
        '    Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
        '    Response.Write(.ClientsideScript())
        '    Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        'End With

        '--call to display Grid
        Call Display_Calender_Tab()

        Response.Write("</div>")

    End Function

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
            Dim intRowCount1 As Integer
            Dim intRowCount2 As Integer
            Dim drTasks, drHolidays As IDataReader
            Dim strCalenderHTML, strDate As String
            Dim intYear, intMonth As Integer
            Dim HolidayArray() As Integer = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}

            Dim m_dtWeekStartDate As Date
            Dim m_dtWeekEndDate As Date
            Dim m_strWeekStartDate As String
            Dim m_strWeekEndDate As String
            Dim dtHoliDate As Date
            Dim spDate As Date
            Dim strLeaves As String
            Dim intMonthDays As Integer = 0
            Dim intCounter As Integer = 0
            Dim days() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
            Dim strMode As String = ""

            Dim m_objAccessRights As WebPages.Security.cAccessRights
            Dim m_objGlobal As WebPages.Template.IGlobal

            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
            m_objGlobal = MyBase.GlobalObject()
            m_objGlobal.ParentTagID = 0
            m_objGlobal.TagID = arrTagID(CType(m_strList, Integer) - 1)
            m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
            m_objAccessRights.GetAccess()

            '--- Initialize Resources
            MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")

            '--- Set Calender WeekEndColor and Start of the week
            objCalender.FirstDayOfWeek = Microsoft.VisualBasic.FirstDayOfWeek.Monday
            objCalender.CalenderTodaysColor = "White"
            objCalender.TRHeaderStyle = "clsTRColumnHeader"
            If m_objAccessRights.Add And arrTagID(CType(m_strList, Integer) - 1) <> 1019 And arrTagID(CType(m_strList, Integer) - 1) <> 2133 And arrTagID(CType(m_strList, Integer) - 1) <> 1038 Then
                objCalender.LeftCaptionToBeInserted = "<a href='javascript:Add_OnClick(" + m_strList + ")' style='TEXT-DECORATION:None;font-family:Verdana;font-size:8;vertical-align:middle' ><img src='../../Images/Home/AddSection.gif' border=0>&nbsp;<font size=1><b>Add</b></font>&nbsp;&nbsp;</a>"
            End If
            objCalender.RightCaptionToBeInserted = DrawTabs()

            Dim dsEntity As DataSet

            If CType(m_strWeekFlag, Integer) = 1 Then
                ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                '' m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
                m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_StartingDayofweek", MyBase.UseSQL), "0"))
                ''end of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
                m_intStartingDayOfWeek = m_intStartingDayOfWeek + 1
                If m_intStartingDayOfWeek > 7 Then
                    m_intStartingDayOfWeek = 1
                End If
                GetWeekStartAndEndDates(m_strWeekStartDate, m_strWeekEndDate, dtWeekDate, m_intStartingDayOfWeek)
                m_dtWeekStartDate = CType(m_strWeekStartDate, Date)
                m_dtWeekEndDate = CType(m_strWeekEndDate, Date)
                strMode = "WEEK"
            End If
            If CType(m_strWeekFlag, Integer) = 1 Then
                intMonth = CType(DatePart("M", dtWeekDate), String)
                intYear = CType(DatePart("YYYY", dtWeekDate), String)
            Else
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



            spDate = New Date(intYear, intMonth, days(intMonth))

            '--- For ISSUES
            If m_strList = "2" Then

                '--- Get the Count data reader
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Issues_count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_Issues_Count_Home_Calender '" + spDate + "'," + m_strSelectedProjectID

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Issues", UseSQL:=True)

                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString

                    strDate = CommonFunctions.Dates.GetDate(dtDate)

                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("ReportedDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("ClosedDate='" + strDate + "'").Length

                    '--- Text for cells
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""ISSUES"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Issues Reported" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("ISSUE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""ISSUES"",""E"")'  style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Issues Closed" & " : " & intRowCount2 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("ISSUE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
            End If

            '=======================================================================================================
            '--- For REVIEWS
            If m_strList = "8" Then
                '--- Get the Count data reader

                'strSQL = "USP_GET_TASK_COUNT  'usp_Sel_Reviews_Count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_Reviews_Count_Home_Calender '" & spDate & "'," & m_strSelectedProjectID & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next

                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Reviews", UseSQL:=True)

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    'drTasks.Read()

                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("ReviewStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("ReviewEndDate='" + strDate + "'").Length

                    '--- Text for each cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""REVIEWS"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Reviews Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("REVIEW_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""REVIEWS"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Reviews End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("REVIEW_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
            End If
            '=======================================================================================================
            '--- For MILESTONE
            If m_strList = "6" Then

                '--- Get the Count data reader

                strSQL = "usp_Sel_MileStones_Count_Home_Calender  '" & spDate & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString() & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_MileStone", UseSQL:=True)

                '--- Increament the RecordSet to get the Count

                'For I As Integer = 1 To intMonthDays * 2
                '    drTasks.NextResult()
                'Next

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    'drTasks.Read()

                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("MileStoneStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("MileStoneEndDate='" + strDate + "'").Length

                    '--- Text for each cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MILESTONES"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Milestones Start" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("MILESTONE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MILESTONES"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Milestones End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("MILESTONE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                'Session("MODULE") = "MILESTONES"
            End If
            '=======================================================================================================
            '--- For DELIVERABLES
            If m_strList = "9" Then

                '--- Get the Count data reader
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Deliverable_count'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_Deliverables_Count_Home_Calender '" & spDate & "'," & m_strSelectedProjectID & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Deliverables", UseSQL:=True)

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)

                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)


                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("DeliverableStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("DeliverableEndDate='" + strDate + "'").Length

                    '--- Text for each Cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""DELIVERABLES"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Deliverables start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("DELIVERABLE_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""DELIVERABLES"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Deliverables End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("DELIVERABLE_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                'Session("MODULE") = "DELIVERABLES"
            End If

            '=======================================================================================================
            '--- For TO DO LIST
            If m_strList = "1" Then
                '--- Get the Count data reader
                ' Dim spDate As New Date(intYear, intMonth, days(intMonth))

                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks_ForOutlookView_Calender'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_Tasks_Count_Home_Calender  '" & spDate & "'," + m_strSelectedProjectID + ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Tasks", UseSQL:=True)

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
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)

                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("Count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select(" StartDate = '" + strDate + "' ").Length
                    intRowCount2 = dsEntity.Tables(0).Select(" EndDate = '" + strDate + "' ").Length


                    '--- Text for Each Cell
                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a class='clsLinkChildNavMenu' href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""S"")'  style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Tasks Start" & " : " & intRowCount1 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("TASK_LABEL")
                        End If
                        If intRowCount2 <> 0 Then
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            'Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                            '(New Parameter for ShowDetailsFun )                
                            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a class='clsLinkChildNavMenu' href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"",""E"")'  style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "'  >" & "Tasks End" & " : " & intRowCount2 & "</A></Font></TD></TR>" 'MyBase.GetResourceString("TASK_LABEL")
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                    'End Mofification PurvaJ
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                'Session("MODULE") = "TODO"
            End If

            '=======================================================================================================
            '--- If the MODE=10 then Show the Sub Project List for that Day
            If m_strList = "10" Then
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks_ForOutlookView_Calender'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_SubProjects_Count_Home_Calender '" & spDate & "'," & m_strSelectedProjectID & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_SubProjects", UseSQL:=True)

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("SubProjectStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("SubProjectEndDate='" + strDate + "'").Length

                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""SUBPROJECTS"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Sub Projects Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("TASK_LABEL")                        
                        End If
                        If intRowCount2 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""SUBPROJECTS"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Sub Projects End" & " : " & intRowCount2 & "</A></Font></TD></TR>"   'MyBase.GetResourceString("TASK_LABEL")                           
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                ' Session("MODULE") = "TASKS"
            End If
            '=======================================================================================================

            '=======================================================================================================
            '--- If the MODE=11 then Show the Resources List for that Day
            If m_strList = "11" Then
                strSQL = "usp_Sel_Resources_Count_Home_Calender '" & spDate & "'," & m_strSelectedProjectID & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Resources", UseSQL:=True)

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("ExpectedStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("ExpectedEndDate='" + strDate + "'").Length

                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""RESOURCES"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Resources Assigned" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("TASK_LABEL")                        
                        End If
                        If intRowCount2 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""RESOURCES"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Resources Released" & " : " & intRowCount2 & "</A></Font></TD></TR>"   'MyBase.GetResourceString("TASK_LABEL")                           
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                ' Session("MODULE") = "TASKS"
            End If
            '=======================================================================================================
            '=======================================================================================================
            '--- Modules
            If m_strList = "12" Then
                'strSQL = "USP_GET_TASK_COUNT  'usp_db_Sel_Tasks_ForOutlookView_Calender'," & CStr(Session("intUserID")) & ",'" & spDate & "'"
                strSQL = "usp_Sel_Modules_Count_Home_Calender '" & spDate & "'," & m_strSelectedProjectID & ",NULL"

                'drTasks = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                dsEntity = CommonFunctions.Data.GetDataSet(strSQL, "Tbl_Modules", UseSQL:=True)

                '--- For Number of days in a Month Plot the Cells
                For intDay As Integer = 1 To intMonthDays
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    'drTasks.Read()
                    'intRowCount1 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count1"), ""))
                    'intRowCount2 = CInt(CommonFunctions.Data.CheckIsDBNull(drTasks.Item("count2"), ""))

                    intRowCount1 = dsEntity.Tables(0).Select("ModuleStartDate='" + strDate + "'").Length
                    intRowCount2 = dsEntity.Tables(0).Select("ModuleEndDate='" + strDate + "'").Length

                    If intRowCount1 <> 0 Or intRowCount2 <> 0 Then
                        objCalender.Days(intDay).Text = "<Table width=100%>"
                        If intRowCount1 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MODULES"",""S"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Module Start" & " : " & intRowCount1 & "</A></Font></TD></TR>"  'MyBase.GetResourceString("TASK_LABEL")                        
                        End If
                        If intRowCount2 <> 0 Then
                            objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "<TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""MODULES"",""E"")' style='" + IIf(intDay = Date.Now.Day, "color:white", "") + "' >" & "Module End" & " : " & intRowCount2 & "</A></Font></TD></TR>"   'MyBase.GetResourceString("TASK_LABEL")                           
                        End If
                        objCalender.Days(intDay).Text = objCalender.Days(intDay).Text & "</TABLE>"
                    Else
                        objCalender.Days(intDay).Text = " "
                    End If
                Next
                '--- Dispose the Data Reader
                CommonFunctions.Data.DisposeDataReader(drTasks)
                ' Session("MODULE") = "TASKS"
            End If
            '=======================================================================================================


            '======================================================================================================================================================
            '====  Mode Added for WEEK 
            '==================================================================================================
            If strMode = "WEEK" Then

                Dim drEntities As DataRow()
                Dim strTitle As String = ""
                For intDay As Integer = CType(DatePart("D", m_dtWeekStartDate), Integer) To CType(DatePart("D", m_dtWeekEndDate), Integer)
                    Dim dtDate As New Date(intYear, intMonth, intDay)
                    'strDate = intMonth.ToString + "/" + intDay.ToString + "/" + intYear.ToString
                    strDate = CommonFunctions.Dates.GetDate(dtDate)
                    objCalender.Days(intDay).Text = "<Table width=99.99% class='clsTable'>"

                    If m_strList = "1" Then
                        drEntities = dsEntity.Tables(0).Select("StartDate='" + strDate + "' OR EndDate='" + strDate + "'")
                    ElseIf m_strList = "2" Then
                        drEntities = dsEntity.Tables(0).Select("ReportedDate='" + strDate + "' OR ClosedDate='" + strDate + "'")
                    ElseIf m_strList = "6" Then
                        drEntities = dsEntity.Tables(0).Select("MileStoneStartDate='" + strDate + "' OR MileStoneEndDate='" + strDate + "'")
                    ElseIf m_strList = "8" Then
                        drEntities = dsEntity.Tables(0).Select("ReviewStartDate='" + strDate + "' OR ReviewEndDate='" + strDate + "'")
                    ElseIf m_strList = "9" Then
                        drEntities = dsEntity.Tables(0).Select("DeliverableStartDate='" + strDate + "' OR DeliverableEndDate='" + strDate + "'")
                    ElseIf m_strList = "10" Then
                        drEntities = dsEntity.Tables(0).Select("SubProjectStartDate='" + strDate + "' OR SubProjectEndDate='" + strDate + "'")
                    ElseIf m_strList = "11" Then
                        drEntities = dsEntity.Tables(0).Select("ExpectedStartDate='" + strDate + "' OR ExpectedEndDate='" + strDate + "'")
                    ElseIf m_strList = "12" Then
                        drEntities = dsEntity.Tables(0).Select("ModuleStartDate='" + strDate + "' OR ModuleEndDate='" + strDate + "'")
                    End If

                    For intIndex As Integer = 1 To 5
                        If intIndex <= drEntities.Length Then
                            strTitle = CommonFunctions.Data.CheckIsDBNull(drEntities(intIndex - 1)(1), "").ToString()
                            objCalender.Days(intDay).Text += "<TR ><TD align='Left' title='" + strTitle + "' style=font-family: Verdana; font-size:8 ><font size=1 " + IIf(intDay = Date.Now.Day, "color=white", "").ToString() + " >" + strTitle.Substring(0, IIf(strTitle.Length > 20, 20, strTitle.Length)) + IIf(strTitle.Length > 20, "...", "").ToString() + "</font></td></tr>"
                        Else
                            objCalender.Days(intDay).Text += "<TR ><TD align='Left'>&nbsp;</td></tr>"
                        End If
                    Next

                    If drEntities.Length > 0 Then
                        objCalender.Days(intDay).Text += "<TR style=""vertical-align:bottom""><TD align='Left'><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""WEEK"",""S"")' style=font-family: Verdana; font-size:8 >" & "<font size=1 " + IIf(intDay = Date.Now.Day, "color=white", "").ToString() + " >Details</font>" & "</A></TD></TR>"
                    End If
                    objCalender.Days(intDay).Text += ("</TABLE>")

                Next
            End If
            '=======================================================================================================
            '--- Plot the Calender.
            objCalender.ReturnHTML = True
            'Call Plot calender which cretes the final calender in one string

            '' START : Commented and modified By ParagD 30-Aug-2006
            '' CommonFunctions.General.WriteHTML("<DIV style='overflow:auto'>")
            CommonFunctions.General.WriteHTML("<DIV style='width:100%; Height:60%; overflow:auto;'>")
            '' END : Commented and modified By ParagD 30-Aug-2006


            objCalender.TRSectionHeader = "clsTROdd"
            'Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender
            If CType(m_strWeekFlag, Integer) <> 1 Then
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

            Dim strEmployeeName As String = ""
            Dim strPreviousEmployeeName As String = ""

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
            If strModule.ToUpper = "TASKS" Or (strModule.ToUpper = "WEEK" And m_strList = "1") Then
                '--- Plot Table Column Headers

                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_TASKNAME") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & "Planned Work (H:M)" & "</td><td align='center' width=10%>" & "Actual Work (H:M)" & "</td></tr>"
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Tasks_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",'" & strFromDate & "'," & strToDate
                        strSQL = "Usp_Sel_Tasks_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "'"
                    ElseIf strStartEndDate = "E" Then
                        'strSQL = "usp_db_Sel_Tasks " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                        strSQL = "Usp_Sel_Tasks_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
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
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BaseLineWork"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strParentTask_UID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ParentTask_UID"), "0"))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("TaskID"), "0"))
                    strApplyEffortDistribution = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ApplyEffortDistribution"), "0"))
                    strHaveSubTaskTypes = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("HaveSubTaskTypes"), "0"))

                    If strEmployeeName <> strPreviousEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
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
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
            End If
            '==============================================================================================
            'For ISSUES
            If strModule.ToUpper = "ISSUES" Or (strModule.ToUpper = "WEEK" And m_strList = "2") Then


                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim dtIssueStartDate As String
                Dim dtIssueEndDate As String
                '--- Plot Table Column Headers
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=10%>Issue ID</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ISSUESTATUS") & "</td><td width=65%>" & MyBase.GetResourceString("COL_SUMMARY") & "</td><td width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td width=65%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td width=65%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Issues_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        strSQL = "Usp_Sel_Issues_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "',NULL"
                    ElseIf strStartEndDate = "E" Then
                        strSQL = "Usp_Sel_Issues_Home_Calendar " & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If

                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                strPreviousEmployeeName = ""
                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strIssueID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueID"), ""))
                    strIssueStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Status"), ""))
                    strIssueSummary = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Summary"), ""))
                    If Not IsDBNull(drProjects("ReportedDate")) Then
                        dtIssueStartDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReportedDate"), "01/01/2005"))))
                    Else
                        dtIssueStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("ClosedDate")) Then
                        dtIssueEndDate = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ClosedDate"), "01/01/2005"))))
                    Else
                        dtIssueEndDate = ""
                    End If
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Work"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))

                    If strPreviousEmployeeName <> strEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

                    intcount += 1
                    If dtIssueStartDate <> "" Then
                        dtIssueStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueStartDate))
                    End If
                    If dtIssueEndDate <> "" Then
                        dtIssueEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtIssueEndDate))
                    End If
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>" '</TR>                   

                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Issue_OnClick(" & strProjectID & "," & strIssueID & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strIssueID & "</TD>"
                        strXML += "<TD align='center'>" & strIssueStatus & "</TD>"
                        strXML += "<TD align='Left'>" & strIssueSummary & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueStartDate & "</TD>" '</TR>
                        strXML += "<TD align='Left'>" & dtIssueEndDate & "</TD>" '</TR>
                        strXML += "<TD align='center'>" & strWork & "</TD>"
                        strXML += "<TD align='center'>" & strActualWork & "</TD></TR>"
                    End If

                End While
            End If
                '==============================================================================================
                'For REVIEWS
                If strModule.ToUpper = "REVIEWS" Or (strModule.ToUpper = "WEEK" And m_strList = "8") Then

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
                strXML = strXML + "<tr class='clsTRSectionHeader'><td width=5%></td><td width=30%>" & MyBase.GetResourceString("COL_REVIEWTITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWTYPE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWSTATUS") & "</td><td width=15%>" & "Review Start" & "</td><td width=15%>" & "Review End" & "</td><td width=10%>" & MyBase.GetResourceString("COL_REVIEWEDBY") & "</td><td width=15%>" & MyBase.GetResourceString("COL_REVIEWEE") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Reviews_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        'strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",'" & strFromDate & "',NULL"
                        strSQL = "Usp_Sel_Reviews_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "',NULL"
                    ElseIf strStartEndDate = "E" Then
                        'strSQL = "usp_db_Sel_Reviewes " & strEmployeeID & ",NULL,'" & strFromDate & "'"
                        strSQL = "Usp_Sel_Reviews_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If

                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strReviewTitle = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewTitle"), ""))
                    strReviewType = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewType"), ""))
                    strReviewStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatus"), ""))
                    strReviewedBy = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewedBy"), ""))
                    strReviewee = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("Reviewee"), ""))
                    If Not IsDBNull(drProjects("ReviewStartDate")) Then
                        strReviewsStart = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStartDate"), "01/01/2005"))))
                    Else
                        strReviewsStart = ""
                    End If
                    If Not IsDBNull(drProjects("ReviewEndDate")) Then
                        strReviewsEnd = CStr(CommonFunctions.Dates.GetDate(CDate(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewEndDate"), "01/01/2005"))))
                    Else
                        strReviewsEnd = ""
                    End If
                    strIssueIDs = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("IssueIDs"), ""))
                    strDocumentLink = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("DocumentLink"), ""))
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), ""))
                    strReviewStatisticsID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ReviewStatisticsID"), ""))

                    'If strProjectName <> strPrevProjectName Then
                    '    strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    'End If
                    'strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
                    If strReviewsStart <> "" Then
                        strReviewsStart = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsStart))
                    End If
                    If strReviewsEnd <> "" Then
                        strReviewsEnd = CommonFunctions.Dates.CGetDate(Date.Parse(strReviewsEnd))
                    End If
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsEnd & "</TD>"
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_Review_OnClick(" & strProjectID & "," & strReviewStatisticsID & "," & strIssueIDs & ")'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strReviewTitle & "</TD>"
                        strXML += "<TD align='center'>" & strReviewType & "</TD>"
                        strXML += "<TD align='center'>" & strReviewStatus & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsStart & "</TD>"
                        strXML += "<TD align='center'>" & strReviewsEnd & "</TD>"
                        strXML += "<TD align='center'>" & strReviewedBy & "</TD>"
                        strXML += "<TD align='center'>" & strReviewee & "</TD></TR>"
                    End If

                End While
            End If
            '==============================================================================================
            'For MILESTONE
            If strModule.ToUpper = "MILESTONES" Or (strModule.ToUpper = "WEEK" And m_strList = "6") Then
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
                strPreviousEmployeeName = ""

                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_MILESTONE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_PLANNEDCOMPLETIONDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUALCOMPLETIONDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_MILESTONESTATUS") & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_MileStones_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        'strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL,NULL"
                        strSQL = "Usp_Sel_MileStones_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,'" & strFromDate & "',NULL"
                    ElseIf strStartEndDate = "E" Then
                        'strSQL = "usp_db_Sel_Milestones " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                        strSQL = "Usp_Sel_MileStones_Home_Calendar " & m_strLoggedInUserID & "," & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()
                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
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

                    If strEmployeeName <> strPreviousEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

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
            End If
            '==============================================================================================
            'For DELIVERABLES
            If strModule.ToUpper = "DELIVERABLES" Or (strModule.ToUpper = "WEEK" And m_strList = "9") Then
                Dim strIssueID As String
                Dim strIssueStatus As String
                Dim strIssueSummary As String
                Dim strScheduleID As String
                Dim strTitle As String
                'Dim strActualWork As String

                strPreviousEmployeeName = ""
                '--- Plot Table Column Headers
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=35%>" & MyBase.GetResourceString("COL_TITLE") & "</td><td width=15%>" & MyBase.GetResourceString("COL_DELIVERABLESTARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_DELIVERABLEENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ACTUAL_WORK_DELIVERABLES") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Deliverables_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",'" & strFromDate & "',NULL,NULL,NULL"
                        strSQL = "Usp_Sel_Deliverables_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "',NULL"
                    ElseIf strStartEndDate = "E" Then
                        'strSQL = "usp_db_Sel_Deliverables " & strEmployeeID & ",NULL,'" & strFromDate & "',NULL,NULL"
                        strSQL = "Usp_Sel_Deliverables_Home_Calendar " & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
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

                    If strEmployeeName <> strPreviousEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

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
            End If

            '==============================================================================================
            '--- For Subprojects
            If strModule.ToUpper = "SUBPROJECTS" Or (strModule.ToUpper = "WEEK" And m_strList = "10") Then
                strPreviousEmployeeName = ""
                '--- Plot Table Column Headers
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>Sub Project</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_SubProjects_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        strSQL = "Usp_Sel_SubProjects_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "'"
                    ElseIf strStartEndDate = "E" Then
                        strSQL = "Usp_Sel_SubProjects_Home_Calendar " & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
                    strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("SubProjectName"), ""))
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005")))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("EarliestStartDate")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EarliestStartDate"), "")))))
                    Else
                        strEndDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStartDate"), "1/1/2005")))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEndDate"), "1/1/2005")))))
                    Else
                        strActualEnd = ""
                    End If
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("PlannedWork"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = ""
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), "0"))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("SubProjectID"), "0"))

                    If strEmployeeName <> strPreviousEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
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
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
            End If

            '==============================================================================================
            '--- For Resources
            If strModule.ToUpper = "RESOURCES" Or (strModule.ToUpper = "WEEK" And m_strList = "11") Then
                '--- Plot Table Column Headers
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=30%>Employee Name</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Resources_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        strSQL = "Usp_Sel_Resources_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "'"
                    ElseIf strStartEndDate = "E" Then
                        strSQL = "Usp_Sel_Resources_Home_Calendar " & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
                    If Not IsDBNull(drProjects("ExpectedStartDate")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ExpectedStartDate"), "1/1/2005")))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("ExpectedEndDate")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ExpectedEndDate"), "")))))
                    Else
                        strEndDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStartDate"), "1/1/2005")))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEndDate"), "1/1/2005")))))
                    Else
                        strActualEnd = ""
                    End If
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("BudgetedHours"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualHours"), ""))
                    strDocumentLink = ""
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), "0"))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectEmployeeRoleID"), "0"))

                    'If strProjectName <> strPrevProjectName Then
                    '    strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strProjectName & "</TD></TR>"
                    'End If

                    strPrevProjectName = strProjectName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
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
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
            End If


            '=========================================
            '--- For Modules
            If strModule.ToUpper = "MODULES" Or (strModule.ToUpper = "WEEK" And m_strList = "12") Then
                strPreviousEmployeeName = ""
                '--- Plot Table Column Headers
                strXML = strXML + "<tr class='clsTRColumnHeader'><td width=5%></td><td width=30%>Module</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_STARTDATE") & "</td><td align='center' width=15%>" & MyBase.GetResourceString("COL_ENDDATE") & "</td><td align='center' width=15%>" & "Actual Start" & "</td><td align='center' width=20%>" & MyBase.GetResourceString("COL_PLANNEDWORK") & "</td><td align='center' width=10%>" & MyBase.GetResourceString("COL_ACTUALWORK") & "</td></tr>"

                If strModule.ToUpper = "WEEK" Then
                    strSQL = "Usp_Sel_Modules_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "','" & strFromDate & "'"
                Else
                    If strStartEndDate = "S" Then
                        strSQL = "Usp_Sel_Modules_Home_Calendar " & m_strSelectedProjectID & ",NULL,'" & strFromDate & "'"
                    ElseIf strStartEndDate = "E" Then
                        strSQL = "Usp_Sel_Modules_Home_Calendar " & m_strSelectedProjectID & ",NULL,NULL,'" & strFromDate & "'"
                    End If
                End If
                drProjects = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                While drProjects.Read()

                    strProjectName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectName"), ""))
                    strEmployeeName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EmployeeName"), "-"))
                    strTaskName = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ModuleName"), ""))
                    If Not IsDBNull(drProjects("StartDate")) Then
                        strStartDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("StartDate"), "1/1/2005")))))
                    Else
                        strStartDate = ""
                    End If
                    If Not IsDBNull(drProjects("EarliestStartDate")) Then
                        strEndDate = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("EarliestStartDate"), "")))))
                    Else
                        strEndDate = ""
                    End If
                    If Not IsDBNull(drProjects("ActualStartDate")) Then
                        strActualStart = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualStartDate"), "1/1/2005")))))
                    Else
                        strActualStart = ""
                    End If
                    If Not IsDBNull(drProjects("ActualEndDate")) Then
                        strActualEnd = CStr(CommonFunctions.Dates.GetDate(CDate((CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualEndDate"), "1/1/2005")))))
                    Else
                        strActualEnd = ""
                    End If
                    strWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("PlannedWork"), ""))
                    strActualWork = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ActualWork"), ""))
                    strDocumentLink = ""
                    strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ProjectID"), "0"))
                    strTaskID = CStr(CommonFunctions.Data.CheckIsDBNull(drProjects.Item("ModuleID"), "0"))

                    If strEmployeeName <> strPreviousEmployeeName Then
                        strXML += "<TR class='clsTRSectionHeader'><TD colspan=8>" & strEmployeeName & "</TD></TR>"
                    End If
                    strPreviousEmployeeName = strEmployeeName

                    intcount += 1
                    '--- Plot for clsTROdd or clsTREven
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
                    If intcount Mod 2 = 0 Then
                        blnFlag = True
                        strXML += "<TR class='clsTROdd'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    Else
                        blnFlag = True
                        strXML += "<TR class='clsTREven'><TD align='center'><a href='javascript:DocumentLink_OnClick(" & strProjectID & "," & strParentTask_UID & "," & strTaskID & ",""" & strApplyEffortDistribution & """,""" & strHaveSubTaskTypes & """)'>" & strDocumentLink & "</a></TD><TD align='Left'>" & strTaskName & "</TD>"
                        strXML += "<TD align='center'>" & strStartDate & "</TD>"
                        strXML += "<TD align='center'>" & strEndDate & "</TD>"
                        strXML += "<TD align='center'>" & strActualStart & "</TD>"
                        strXML += "<TD align='Right'>" & strWork & "</TD>"
                        strXML += "<TD align='Right'>" & strActualWork & "</TD></TR>"
                    End If
                End While
            End If
         

            strXML += "</TABLE>"


            CommonFunctions.Data.DisposeDataReader(drTasks)
            CommonFunctions.Data.DisposeDataReader(drProjects)

            'Commented And Added By Amol Changle On: 24 Mar 2009
            '--- Clear and return the RESPONSE.
            'Response.Clear()
            'Response.Write(strXML)
            CommonFunctions.General.WriteHTML(strXML)
            'End Comments and Addition

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
        Dim strTabs As String
        Dim strTheme As String = ""

        strTheme += "<td align='center' class='clsTDBlankNew'>"
        strTheme += "View:&nbsp;"
        strTheme += CommonFunction.HTMLControls.DrawComboBox("txtGanttView", "usp_Sel_HomeThemes 2133, 61", "150", , "onchange=javascript:Period_OnChange(this)", , True)
        strTheme += "</td>"

        CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable' cellspacing=0 cellpadding=0><TR class='clsTRPageCaption'><TD align='Left'><B>" & MyBase.GetResourceString("LBL_CALENDAR") & "</B></TD>" + strTheme + "<TD align='right'><B>" & GetEntityName(m_strModule) & " : " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strProjectName")).ToString() & "</B></TD></TR></TABLE><br>")

        If CType(m_strWeekFlag, Integer) = 1 Then
            'strTabs += "<a style='TEXT-DECORATION:None;font-family:Verdana;font-size:smaller;font-weight:bold' "
            strTabs += "<a style='TEXT-DECORATION:None;font-family:Verdana;font-size:8' "
            strTabs += " Href='javascript:ThisMonth_clicked(""" & m_strModule & """)' >"
            strTabs += "&nbsp;<font size=1><b>Month View</b></font>"
            strTabs += "</a>&nbsp;|"
            strTabs += "&nbsp;&nbsp;"
            strTabs += "<a style='TEXT-DECORATION:None' title='Previous Week'"
            strTabs += " href='javascript:PreviousWeek_clicked(""" & m_strModule & """)' >"
            strTabs += "<img src='../../Images/Home/ScrollLeft.gif' border=0>"
            strTabs += "</a>&nbsp;&nbsp;"
            strTabs += "<a style='TEXT-DECORATION:None' title='Next Week'"
            strTabs += " Href='javascript:NextWeek_clicked(""" & m_strModule & """)' >"
            strTabs += "<img src='../../Images/Home/ScrollRight.gif' border=0>"
            strTabs += "</a>"
        Else
            strTabs += "<a style='TEXT-DECORATION:None;font-family:Verdana;font-size:8'  "
            strTabs += " Href='javascript:Week_clicked(""" & m_strModule & """)' >"
            strTabs += "&nbsp;<font size=1><b>Week View</b></font>"
            strTabs += "</a>&nbsp;|"
            strTabs += "&nbsp;&nbsp;"
            strTabs += "<a style='TEXT-DECORATION:None' title='Previous Month'"
            strTabs += " href='javascript:PreviousMonth_clicked(""" & m_strModule & """)' >"
            strTabs += "<img src='../../Images/Home/ScrollLeft.gif' border=0>"
            strTabs += "</a>&nbsp;&nbsp;"
            strTabs += "<a style='TEXT-DECORATION:None' title='Next Month'"
            strTabs += " Href='javascript:NextMonth_clicked(""" & m_strModule & """)' >"
            strTabs += "<img src='../../Images/Home/ScrollRight.gif' border=0>"
            strTabs += "</a>"
        End If

        Return strTabs
    End Function

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.DB_Calender", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
    End Sub

    Public Sub PlotHead()

        Dim strFromWhere As String
        strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        If strFromWhere = "XMLHTTP" Then
            Dim strModule As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module")).ToString()
            Dim strDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Date")).ToString()
            CommonFunction.General.PlotPageHeadTag(GetEntityName(strModule) + " : " + CommonFunctions.Dates.GetDate(CType(strDate, Date)))
        Else
         

            CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
        End If


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
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''strQuery = "SELECT top 1 StyleSheetName FROM tbl_UI_UserSettings A INNER JOIN tbl_UI_StyleSheets B on A.StyleSheetID = B.StyleSheetID WHERE LoginID = (Select LoginID FROM tbl_PM_Login WHERE EmployeeID = " + Session("intUserID").ToString + ")"
        strQuery = "usp_sel_tbl_UI_UserSettings_StyleSheetName " + Session("intUserID").ToString
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        StyleSheetName = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)
        If StyleSheetName = "" Then
            StyleSheetName = "StyleSheetChanakya.css"
        End If
    End Sub
    'End of Added by SavitaS on 30 Aug 2006 for SP7 Integration IssueID 5784

    Private Function GetEntityName(ByVal strModule As String) As String
        Select Case strModule.ToUpper()
            Case "TODO"
                GetEntityName = "Tasks"
            Case "TASKS"
                GetEntityName = "Tasks"
            Case "ISSUES"
                GetEntityName = "Issues"
            Case "REVIEWS"
                GetEntityName = "Reviews"
            Case "MILESTONES"
                GetEntityName = "Milestones"
            Case "DELIVERABLES"
                GetEntityName = "Deliverables"
            Case "WEEK"
                GetEntityName = "Week"
            Case "MONTH"
                GetEntityName = "Month"
            Case "SUBPROJECTS"
                GetEntityName = "Sub Projects"
            Case "RESOURCES"
                GetEntityName = "Resources"
            Case "MODULES"
                GetEntityName = "Modules"
            Case Else
                GetEntityName = "Tasks"
        End Select
    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class