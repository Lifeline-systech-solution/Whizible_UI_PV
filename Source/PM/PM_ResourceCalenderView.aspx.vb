Option Strict Off
#Region "Imports"
Imports GenericCalender.GenericCalender
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports WebPages
Imports WebPages.Template
Imports WebPages.Security
Imports CommonEngines
Imports System
#End Region

Public Class PM_ResourceCalenderView
    Inherits WebPages.Template.WhizTemplate


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents GraphOutlook As System.Web.UI.HtmlControls.HtmlForm
    Protected WithEvents frmResourceCalenderView As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Variable Declaration"

    Private m_blnUseSQL, m_blnSetProjectFilter As Boolean
    Private m_strPageCaption As String
    Protected m_intListNumber As Integer = 0
    Protected m_strDB_PageName As String
    Protected m_strPageTitle As String
    Protected m_strOrganizationUnit As String
    Protected m_strDeliveryUnit As String
    Protected m_strDeliveryTeam As String
    Protected m_strEmployeeID As String
    'Protected m_strYear As String
    Protected m_strHoliDate As String
    Public m_PageMode As String
    Protected m_intMonth As Integer
    Protected m_intYear As Integer

    Protected m_CurrYear As Integer
    Protected strProjectName As String
    Protected intProjectID As Integer
    Protected dblResourcePrecentage As Double
    Protected ProjectStartDate As DateTime
    Protected ProjectEndDate As DateTime
    Protected fltEmpTask As Double
    Protected fltWorkingHrs As Double
    Protected fltTotalWorkingHrs As Double
    Protected intProjectEmployeeRoleID As Integer
    Protected blnSendMail As Boolean = False
#End Region

#Region "Page Initialization"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_strDB_PageName = "../PM/PM_ResourceCalenderView.aspx"

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
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js,GenericCalender
        ' Author                : ManishK
        ' Created               : 14 Dec, 2005
        ' Revisions             : 
        '=====================================================================

        '-- Procedure to Initialize all the page level settings/variables
        If Request.QueryString("Month") <> "" Then
            m_intMonth = CType(Request.QueryString("Month"), Integer)
            m_intYear = CType(Request.QueryString("Year"), Integer)
        Else
            m_intMonth = Now.Month
            m_intYear = Now.Year
        End If

        Dim drLocation As IDataReader

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strSql As String = "SELECT LocationID FROM tbl_PM_Employee WHERE EmployeeID=" + Session("intUserID").ToString
        Dim strSql As String = "usp_sel_tbl_PM_Employee_LocationID " + Session("intUserID").ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Dim strLocationID As String

        drLocation = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

        While drLocation.Read
            strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drLocation("LocationID"), "0"), Integer)
        End While
        CommonFunctions.Data.DisposeDataReader(drLocation)


        If Request.QueryString("OrganizationUnitID") <> "" Then
            m_strOrganizationUnit = CType(Request.QueryString("OrganizationUnitID"), String)
        Else
            m_strOrganizationUnit = strLocationID
            'm_strDeliveryUnit = "NULL"
            'm_strDeliveryTeam = "NULL"    
        End If

        ''Commented as Delivery team and unit combo is not required now
        'If Request.QueryString("DeliveryUnitID") <> "" And Request.QueryString("OrganizationUnitID") <> "" Then
        '    m_strDeliveryUnit = CType(Request.QueryString("DeliveryUnitID"), String)
        'Else
        m_strDeliveryUnit = "NULL"
        'End If

        ''Commented as Delivery team and unit combo is not required now
        'If Request.QueryString("DeliveryTeamID") <> "" And Request.QueryString("OrganizationUnitID") <> "" And Request.QueryString("DeliveryUnitID") <> "" Then
        '    m_strDeliveryTeam = CType(Request.QueryString("DeliveryTeamID"), String)
        'Else
        m_strDeliveryTeam = "NULL"
        'End If

        If Request.QueryString("EmployeeID") <> "" Then
            m_strEmployeeID = CType(Request.QueryString("EmployeeID"), String)
        Else
            m_strEmployeeID = "NULL"
        End If



        If m_intYear = 0 Then
            m_intYear = DateTime.Now.Year
        End If
        If m_intMonth = 0 Then
            m_intMonth = DateTime.Now.Month
        End If
        If m_intMonth = 13 Then
            m_intMonth = 1
            m_intYear = m_intYear + 1
        End If

        m_CurrYear = Now.Year

    End Sub
#End Region

#Region "Draw Page"
    Public Sub DrawPage()
        '=====================================================================
        ' Page Name             : DrawPage
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : 14 Dec,2005
        ' Revisions             : 
        '=====================================================================
        '  DropdownMenu

        Dim strAccess As String
        
        strAccess = "usp_GetAccess " & Session("intUserID") & "," & Session("intProjectID").ToString

        strAccess = CType(CommonFunctions.Data.GetDataScalar(strAccess, MyBase.UseSQL), String)
       
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Dim dtStartDate As New Date(m_intYear, m_intMonth, 1)
        Dim dtTodaysDate As Date
        dtTodaysDate = Now

       
        Response.Write("<Div id='divContextMenu' class='DropdownMenu'  >")
        Response.Write("<Table cellspacing='0' cellpadding='3' >")

        If dtTodaysDate >= dtStartDate Then

            Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
            Response.Write("<td class='CtMn_LeftFill' ></td>")
            Response.Write("<td id='tdSendMail' title='Send Mail'>&nbsp;&nbsp;&nbsp;Defaulter Mail</td></tr>")
            Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
            Response.Write("<td id='tdHrLineForMail' class='CtMn_Hr'></td></tr>")

        End If

        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")

        'Response.Write("<td class='CtMn_LeftFill' ></td>")
        'Response.Write("<td id='tdSendMail' title='Send Mail'>&nbsp;&nbsp;&nbsp;Defaulter Mail</td></tr>")
        'Response.Write("<TR><td class='CtMn_LeftFill' ></td>")

        'Response.Write("<td id='tdHrLineForMail' class='CtMn_Hr'></td></tr>")


        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<td class='CtMn_LeftFill' ></td>")

        Response.Write("<td id='tdShowTasks' title='ShowTasks' >&nbsp;&nbsp;&nbsp;Show Tasks")
        Response.Write("</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        Response.Write("<td class='CtMn_Hr'></td></tr>")

        If strAccess = 1 Then
            Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
            Response.Write("<td class='CtMn_LeftFill' ></td>")

            Response.Write("<td id='tdUpdateSkill' title='Update Skills' >&nbsp;&nbsp;&nbsp;Update Skills</td></tr>")
            Response.Write("<TR><td class='CtMn_LeftFill' ></td>")

            Response.Write("<td id='tdHrLine' class='CtMn_Hr'></td></tr>")

            Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
            Response.Write("<td class='CtMn_LeftFill' ></td>")

            Response.Write("<td id='tdDelegateTasks' title='Delegate Tasks' >&nbsp;&nbsp;&nbsp;Delegate Tasks</td></tr>")
            Response.Write("<TR><td class='CtMn_LeftFill' ></td>")

            Response.Write("<td class='CtMn_Hr'></td></tr>")
        End If
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<td class='CtMn_LeftFill' ></td>")

        Response.Write("<td id='tdResourceLoading' title='Resource Loading' >&nbsp;&nbsp;&nbsp;Resource Loading</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")

        Response.Write("<td class='CtMn_Hr'></td></tr>")


        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<td class='CtMn_LeftFill' ></td>")

        Response.Write("<td id='tdResourceAllocation' title='Allocation Details' >&nbsp;&nbsp;&nbsp;Allocation Details</td></tr></table></Div>")


        Response.Write("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")

        Call DrawTabs()

    End Sub

    Private Sub DrawTabs()
        '=====================================================================
        ' Procedure Name        : DrawTabs
        ' Purpose               : Draws the Menu-like Tabs 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Jan 28,2006   
        ' Revisions             :
        '=====================================================================
        Dim strTabs As String
        Dim strSql As String
        Dim days1() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        '-----------------Added on 19th Jan 06 as Employee Combo was showing employee whose leaveing date is less than curr date
        Dim intYear, intMonth As Integer
        intYear = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Year"), 0.ToString))
        intMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Month"), 0.ToString))


        If intMonth > 12 Then
            intMonth = 1
            intYear += 1
        End If

        If intYear = 0 Or intMonth = 0 Then
            intYear = m_intYear
            intMonth = m_intMonth
        End If

        '--- Check for Leap Year
        'If ((((intYear Mod 4) = 0) And ((intYear Mod 100) <> 0)) Or ((intYear Mod 400) = 0)) Then
        If DateTime.IsLeapYear(intYear) Then
            days1(2) = 29
        Else
            days1(2) = 28
        End If

        '    '--- Get Leaves for that Employee
        Dim dtStartDate As New Date(intYear, intMonth, 1)
        Dim dtEndDate As New Date(intYear, intMonth, days1(intMonth))

        '---End of addition by ManishK on 19th jan 06
        ''Added on 19th Jan 06 to show Dashboard combo on the page, so that we can move on the PM or any Dashboard page
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")

        CommonFunctions.General.WriteHTML("<TD align=right>")

        CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:Close_OnClick()>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;Close</font>")
        CommonFunctions.General.WriteHTML("</a>")

        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('ResourceCalendar')>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("MENU_QUESTION_MARK") + "</font>")
        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' width=99.9% cellspacing='0'>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")


        Dim strQuery As String

        Dim drprojectName As IDataReader

        intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "select ProjectName,ExpectedStartDate,ExpectedEnddate from tbl_pm_project where projectID = " & intProjectID.ToString
        strQuery = " usp_sel_tbl_pm_project_ProjectName_ExpectedStartDate_ExpectedEnddate " & intProjectID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drprojectName = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While drprojectName.Read
            strProjectName = CType(drprojectName("ProjectName"), String)
            ProjectStartDate = CType(drprojectName("ExpectedStartDate"), Date)
            ProjectEndDate = CType(drprojectName("ExpectedEnddate"), Date)
        End While
        CommonFunction.Data.DisposeDataReader(drprojectName)
        CommonFunctions.General.WriteHTML("<TD width=17%>Project Name :  </TD>")
        CommonFunctions.General.WriteHTML("<TD width=4%>&nbsp;&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD align = left>" & strProjectName & "</TD>")
        'GIves Project Wise Resources
        strSql = "usp_Sel_ProjectwiseResources_ForCombo " & intProjectID & ",null,'" & dtStartDate & "','" & dtEndDate & "'"
        CommonFunctions.General.WriteHTML("<td width=2% align=right>Resource")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=10% align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, 200, m_strEmployeeID.ToString, "onChange= Employee_OnClick(" & m_intMonth & "," & m_intYear & ")", True)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")
        ''Here Previous page and Next Page links are plot

        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing=0 border=0 width=99.9%>")

        CommonFunctions.General.WriteHTML("<tr class=clsTRPageCaption width=99.9%>")

        'Commented and added by bharat t on 16th-Oct-2015
        'CommonFunctions.General.WriteHTML("<td align=Left id='objTDCell' width=17%>")
        CommonFunctions.General.WriteHTML("<td align=Left id='objTDCell' width=18%>")
        'End of Commented and added by bharat t on 16th-Oct-2015
        CommonFunctions.General.WriteHTML("|<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" href='javascript:PreviousMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_PREVIOUS_MONTH") & "" + "")
        CommonFunctions.General.WriteHTML("</a>|")

        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" Href='javascript:NextMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_NEXT_MONTH") & " ")
        CommonFunctions.General.WriteHTML("</a>&nbsp;|")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_MONTH"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=2% align=right >")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtMonth", "txtMonth", , 20, 2, m_intMonth.ToString, "right", EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_YEAR"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=3% align=right >")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtYear", "txtYear", , 35, 4, m_intYear.ToString, "right", EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")

        'Here show link will plot

        CommonFunctions.General.WriteHTML("<td width=6% align=Left id='objTDCell'>&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("|<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" href='javascript:Show_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;<b>Show</b>")
        CommonFunctions.General.WriteHTML("</a>|</td>")

        CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_LEGENDS") & ": </TD>")

        CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_HOLIDAYS") & " &nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Red_H.gif' ></TD>")
        CommonFunctions.General.WriteHTML("<TD width=5% align='Right'>" & MyBase.GetResourceString("CAP_WORK_FROM_HOME") & " &nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Green_WFH.gif' align='Right'></TD>")
        CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_LEAVES") & "&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Purple_L.gif' align='Right'></TD>")

        'Addition done by SuchitraP on 8-MAY-2007 for CleanupActivity
        'Purpose:To show half day leave on Resource Calender View
        CommonFunctions.General.WriteHTML("<TD width=7% align='Right'>Half Day&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Pink_P.gif' align='Right'></TD>")
        'End of addition by SuchitraP on 8-MAY-2007 for CleanupActivity
        CommonFunctions.General.WriteHTML("<TD width=8% align='Right'>Planned Day&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Pattern1.jpg' align='Right'></TD>")

        CommonFunctions.General.WriteHTML("</tr></table>")

        CommonFunctions.General.WriteHTML("<BR>")

        Call DisplayGrid()


        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")

        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")

        CommonFunctions.General.WriteHTML("<TD align=right>")

        CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:Close_OnClick()>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;Close</font>")
        CommonFunctions.General.WriteHTML("</a>")

        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('ResourceCalendar')>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("MENU_QUESTION_MARK") + "</font>")
        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("</Table>")

        Response.Write("</DIV>")

    End Sub

    Private Sub DisplayGrid()
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Calls to the 4 Grids in the Top Section for the 4 grids
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Dec 6, 2005
        ' Revisions             : 
        '=====================================================================

        Dim strSql As String
        Dim drForGrid, drForEmployee, drStartDayOfWeek As IDataReader
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim intStartingDayOfWeek, intNoOfWeekDays As Integer
        Dim intRowCount As Integer
        Dim drHolidays As IDataReader
        Dim strCalenderHTML, strDate As String
        Dim intYear, intMonth As Integer
        Dim HolidayArray() As Integer = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        Dim strLeaves As String
        Dim strLeavesArray As String()
        Dim intMonthDays As Integer = 0
        Dim intCounter As Integer = 0
        Dim intIterator As Integer = 0
        Dim intLoop As Integer = 0
        Dim strList As String
        Dim strMode As String
        Dim dtDate As Date
        Dim days() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        Dim HalfDay As String
        Dim HalfDayArray() As String

        Dim ActualHrs As String
        Dim drActualHrs As IDataReader
        Dim ActualHrsArray() As String
        Dim PlannedColor As String
        Dim arrPlannedColor() As String
        Dim intEmployeeID As String
        Dim strWorkingHrs As String
        Dim intReportingID As Integer
        Dim intReportingID_old As Integer = 0
        Dim strReportingName As String
        Dim blnIsOnProject As Boolean
        Dim m_strPKToken_ResorceAllocation As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql = "SELECT weekDays,StartingDayOfWeek FROM tbl_PM_CompanyInformation"
        strSql = "usp_sel_tbl_PM_CompanyInformation_StartingDayOfWeekEWeekDays"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Try
            drStartDayOfWeek = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

            While drStartDayOfWeek.Read
                intNoOfWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drStartDayOfWeek("WeekDays"), "0"), Integer)
                intStartingDayOfWeek = CType(CommonFunctions.Data.CheckIsDBNull(drStartDayOfWeek("StartingDayOfWeek"), "0"), Integer) + 1
            End While
            CommonFunctions.Data.DisposeDataReader(drStartDayOfWeek)

            If intStartingDayOfWeek = 8 Then
                intStartingDayOfWeek = 1
            End If

            Dim objCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

            '-- Get the Year and Month ('Previous' or 'Next' clicked)
            intYear = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Year"), 0.ToString))
            intMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Month"), 0.ToString))
            intEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")

            If intMonth > 12 Then
                intMonth = 1
                intYear += 1
            End If

            If intYear = 0 Or intMonth = 0 Then
                intYear = m_intYear
                intMonth = m_intMonth
            End If

            '--- Check for Leap Year
            'If ((((intYear Mod 4) = 0) And ((intYear Mod 100) <> 0)) Or ((intYear Mod 400) = 0)) Then
            If DateTime.IsLeapYear(intYear) Then
                days(2) = 29
            Else
                days(2) = 28
            End If

            '    '--- Get Leaves for that Employee
            Dim dtStartDate As New Date(intYear, intMonth, 1)
            Dim dtEndDate As New Date(intYear, intMonth, days(intMonth))
            Dim LeavesArray() As Integer '= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            Dim dtHoliDate As New Date(intYear, intMonth, 1)
            Dim strTemp As String = ""

            '--- Get Holidays for OU
            HolidayArray.Clear(HolidayArray, 0, 12)
            'strSql = "usp_Sel_Resource " + m_strOrganizationUnit + ", " + m_strDeliveryUnit + ", " + m_strDeliveryTeam + ", '" + dtHoliDate + "' ," + m_strEmployeeID
            'strSql = ""
            If intEmployeeID Is Nothing Or intEmployeeID = "" Then
                strSql = "usp_Sel_ProjectwiseResources " & intProjectID & ",null,'" & dtStartDate & "','" & dtEndDate & "'"
            Else
                strSql = "usp_Sel_ProjectwiseResources " & intProjectID & "," & intEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
            End If


            'strWorkingHrs = "select WorkingHours from tbl_pm_location where LocationID in (SELECT LocationID  FROM tbl_pm_Project WHERE projectID = " & intProjectID & " )"
            'fltWorkingHrs = CType(CommonFunctions.Data.GetDataScalar(strWorkingHrs, MyBase.UseSQL), Double)
            'strWorkingHrs = ""
            'strWorkingHrs = "declare @dDays FLOAT  exec usp_GetWorkingDays '" & dtStartDate & "','" & dtEndDate & "',@dDays OUTPUT,null,null "
            'strWorkingHrs &= vbCrLf
            'strWorkingHrs &= "SELECT 'fltTotalWorkingHrs' = @dDays" & vbCrLf
            'fltTotalWorkingHrs = CType(CommonFunctions.Data.GetDataScalar(strWorkingHrs, MyBase.UseSQL), Double)

            Response.Write("<DIV Id='divContainer' Style='height:410px; overflow:auto; width:100%' >")

            Response.Write(" <STYLE type=text/css> {TABLE  {TABLE-LAYOUT: fixed;} ")
            Response.Write(" TR TD.DivSub1Tag {POSITION: relative;} ")

            Response.Write(" TR TD.DivSub1Tag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divContainer').scrollTop -1)} ")

            Response.Write(" </STYLE>")

            CommonFunctions.General.WriteHTML("<table id='tblHeader' cellSpacing=1 bgcolor='#a9a9a9' cellPadding=0  width=100% border='0' Height=30px>")

            strTemp = "Resource Name"
            CommonFunctions.General.WriteHTML("" + objCalender.PlotCalenderForResourceHeadings(m_intMonth, m_intYear, "" + strTemp + "", "%") + "")


            'here objCalender is set to Nothing so that GC will collect it
            objCalender = Nothing

            drForGrid = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
            'CommonFunctions.General.WriteHTML("<table cellSpacing=1 bgcolor='#a9a9a9' cellPadding=0  width=100% border='0' Height=30px>")
            While (drForGrid.Read)
                'Here we are plotting the Empty Calender control
                Dim objEmptyCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

                strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeID"), " "), String)
                strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeName"), "0"), String)
                dblResourcePrecentage = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ResourcePercentage"), 0.0), Double)
                intProjectEmployeeRoleID = CType(drForGrid("ProjectEmployeeRoleID"), Integer)
                intReportingID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingTo"), "0"), Integer)
                strReportingName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingName"), " "), String)
                blnIsOnProject = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("IsOnProject"), "0"), Boolean)
                'For Send MAil Validation
                Dim strQuery As String
                Dim drDefaulters As IDataReader
                Dim dtDefaultDates As String
                strQuery = "usp_Sel_Resource_Defaulter_Days '" & dtStartDate & "'," & intProjectID & "," & strEmployeeID & "," & Session("intUserID").ToString
                drDefaulters = CommonFunctions.Data.GetDataReader(strQuery, True)
                If drDefaulters.Read() Then
                    dtDefaultDates = CType(drDefaulters("Dates"), String)
                    If dtDefaultDates <> "" Then
                        blnSendMail = True
                    Else
                        blnSendMail = False
                    End If
                Else
                    blnSendMail = False
                End If
                CommonFunction.Data.DisposeDataReader(drDefaulters)
                'End of Send Mail Validation
                'Token Security
                m_strPKToken_ResorceAllocation = CommonFunctions.Security.Token.GetToken(CType(intProjectEmployeeRoleID, String) + Session("intUserID").ToString + "0" + "1019")

                'End of Token Security
                strSql = "usp_Sel_Resource_Monthly_Tasks " & intProjectID & "," & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                drActualHrs = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                While drActualHrs.Read
                    ActualHrs = CType(drActualHrs("ActualHrs"), String)
                    ActualHrsArray = ActualHrs.Split(",")
                    'fltEmpTask = CType(drActualHrs("ActualTotalHrs"), Double)

                End While
                CommonFunction.Data.DisposeDataReader(drActualHrs)
                ''***************************For holiday *********************************

                strSql = "usp_sel_Holidays_For_ProjectOU '" & dtHoliDate & "'," & intProjectID
                drHolidays = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                intCounter = 0
                While drHolidays.Read
                    HolidayArray(intCounter) = CInt(CommonFunctions.Data.CheckIsDBNull(drHolidays.Item("Holidays"), "0"))
                    objEmptyCalender.DaysForResource(HolidayArray(intCounter)).mstrCellBackColor = "#cc0000"
                    intCounter += 1
                End While
                CommonFunctions.Data.DisposeDataReader(drHolidays)

                ''***************************End of Holiday*********************************
                '*******************************************

                strSql = "usp_Sel_Resource_Monthly_Tasks_Color " & intProjectID & "," & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"

                PlannedColor = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                arrPlannedColor = PlannedColor.Split(",")
                Dim icolor As Integer

                For icolor = 0 To arrPlannedColor.Length - 1
                    ReDim Preserve LeavesArray(icolor)

                    If arrPlannedColor(icolor) = "2" Or arrPlannedColor(icolor) = "1" Then
                        objEmptyCalender.DaysForResource(icolor + 1).mstrCellBackColor = "#DDA0DD"
                    End If

                Next

                '*******************************************End of Color*********************



                '**********************************/////////////////////////***********************************
                ReDim LeavesArray(-1)
                ''''''''********''''''This is for Employee Leaves****************************
                strSql = "usp_Get_EmployeeLeaves_ForCalender " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'," & "'L'"
                strLeaves = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                strLeavesArray = strLeaves.Split(",")

                For intIterator = 0 To strLeavesArray.Length - 1

                    'Modified By : SujataK
                    'Modified On : 6/4/2006
                    'For         : Resource Calender View
                    'Issue ID    : 3106
                    ReDim Preserve LeavesArray(intIterator)
                    'End of Modification
                    'Here "-1" is checked to control the Employee name cell color 
                    If strLeavesArray(intIterator) = "" Or strLeavesArray(intIterator) = "-1" Or strLeavesArray(intIterator) = "0" Then
                        LeavesArray(intIterator) = 0
                    Else

                        LeavesArray(intIterator) = CInt(strLeavesArray(intIterator))
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).mstrCellBackColor = "BlueViolet"

                    End If
                Next

                'Addition done by SuchitraP on 15-MAY-2007 for Cleanup Activity
                'Purpose:To show half day leaves on Resource view calender
                strSql = "usp_Get_HalfDay " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                HalfDay = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                HalfDayArray = HalfDay.Split(",")
                Dim i As Integer

                For i = 0 To HalfDayArray.Length - 1
                    ReDim Preserve LeavesArray(i)
                    If HalfDayArray(i) = "" Or HalfDayArray(i) = "-1" Or HalfDayArray(i) = "0" Then
                        LeavesArray(i) = 0
                    Else
                        LeavesArray(i) = CInt(HalfDayArray(i))
                        objEmptyCalender.DaysForResource(LeavesArray(i)).mstrCellBackColor = "CC0099"
                    End If

                Next
                'End of addition by SuchitraP on 15-MAY-2007 for Cleanup Activity




                '**********************************/////////////////////////***********************************

                '''''''********''''''This is for Employee Work From Home Request(WFH) ****************************
                strSql = "usp_Get_EmployeeLeaves_ForCalender " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                strLeaves = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                strLeavesArray = strLeaves.Split(",")
                For intIterator = 0 To strLeavesArray.Length - 1
                    'Modified By : SujataK
                    'Modified On : 6/4/2006
                    'For         : Resource Calender View
                    'Issue ID    : 3106
                    ReDim Preserve LeavesArray(intIterator)
                    'End of Modification
                    If strLeavesArray(intIterator) = "" Or strLeavesArray(intIterator) = "-1" Or strLeavesArray(intIterator) = "0" Then
                        LeavesArray(intIterator) = 0
                    Else

                        LeavesArray(intIterator) = CInt(strLeavesArray(intIterator))
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).mstrCellBackColor = "#00cc33"
                        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).Text = "<Table width=99.9%><TR><TD align='Left'><Font size=1>B</Font></TD></TR></TABLE>"
                        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    End If
                Next


                ''***************************End Planed Day Color *********************************

                If intReportingID = intReportingID_old Then
                    CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotResourceHoursCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", "" & ActualHrs & "", CType(strEmployeeID, Integer), intProjectID, dblResourcePrecentage, intProjectEmployeeRoleID, blnIsOnProject, blnSendMail, 0, "0", "" & PlannedColor & "", "" & m_strPKToken_ResorceAllocation & "") + "")
                Else

                    CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotResourceHoursCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", "" & ActualHrs & "", CType(strEmployeeID, Integer), intProjectID, dblResourcePrecentage, intProjectEmployeeRoleID, blnIsOnProject, blnSendMail, intReportingID, "" & strReportingName & "", "" & PlannedColor & "", "" & m_strPKToken_ResorceAllocation & "") + "")
                End If
                'CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotResourceHoursCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", "" & ActualHrs & "", CType(strEmployeeID, Integer), intProjectID, dblResourcePrecentage, intProjectEmployeeRoleID, "" & PlannedColor & "") + "")
                intReportingID_old = intReportingID

                objEmptyCalender = Nothing
            End While
            CommonFunctions.General.WriteHTML("</table>")
        Catch ex As Exception

        End Try
        CommonFunctions.Data.DisposeDataReader(drForGrid)
        CommonFunctions.General.WriteHTML("</TABLE>")

        Response.Write("</DIV>")

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.RPT_Calender", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
    End Sub
#End Region

    Private Sub frmResourceCalenderView_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles frmResourceCalenderView.Load

    End Sub

    ''Added by Dhanashri S on 29 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateShowTasksToken(EmployeeID As String, ProjectID As String, FromDate As String, ToDate As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(ProjectID, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition by Dhanashri S on 29 Mar 2016
End Class
