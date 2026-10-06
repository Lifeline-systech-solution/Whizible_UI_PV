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

Public Class HR_ResourceLeaveCalendarView
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmResourceLeaveCalenderView As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Protected m_intMonth As Integer
    Protected m_intYear As Integer
    Protected m_strEmployeeID As String
    Protected m_CurrYear As Integer
    Protected m_strDB_PageName As String
    Protected m_strOrganizationUnit As String
    Protected m_strPageTitle As String
    Private m_strPageCaption As String
    Protected intProjectEmployeeRoleID As Integer
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_strDB_PageName = "../HR/HR_ResourceLeaveCalendarView.aspx"
        Call Initialize()

    End Sub
    Private Sub Initialize()
        '=====================================================================
        ' Page Name             : HR_ResourceLeaveCalendarView.aspx.vb
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 24,Sep 2007
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
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' Dim strSql As String = "SELECT LocationID FROM tbl_PM_Employee WHERE EmployeeID=" + Session("intUserID").ToString
        Dim strSql As String = "usp_sel_tbl_PM_Employee_LocationID " + Session("intUserID").ToString
        ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
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

        '''Commented as Delivery team and unit combo is not required now
        ''If Request.QueryString("DeliveryUnitID") <> "" And Request.QueryString("OrganizationUnitID") <> "" Then
        ''    m_strDeliveryUnit = CType(Request.QueryString("DeliveryUnitID"), String)
        ''Else
        'm_strDeliveryUnit = "NULL"
        ''End If

        '''Commented as Delivery team and unit combo is not required now
        ''If Request.QueryString("DeliveryTeamID") <> "" And Request.QueryString("OrganizationUnitID") <> "" And Request.QueryString("DeliveryUnitID") <> "" Then
        ''    m_strDeliveryTeam = CType(Request.QueryString("DeliveryTeamID"), String)
        ''Else
        'm_strDeliveryTeam = "NULL"
        ''End If

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


    Public Sub DrawPage()
        '=====================================================================
        ' Page Name             : HR_ResourceLeaveCalendarView.aspx.vb
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 24,Sep 2007
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
        
        Response.Write("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")

        Call DrawTabs()

    End Sub
    Private Sub DrawTabs()
        '=====================================================================
        ' Procedure Name        : HR_ResourceLeaveCalendarView.aspx.vb
        ' Purpose               : Draws the Menu-like Tabs 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 24,Sep 2007  
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

        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' width=99.9% cellspacing='0'>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")


        strSql = "usp_Sel_Organization_Unit " + Session("intUserID").ToString

        'CommonFunctions.General.WriteHTML("<TD width=10%></TD>")
        CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_ORGANIZATION_UNIT") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD width=15% align='left'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboOrganizationUnit", strSql, 180, m_strOrganizationUnit.ToString, "onChange=OrganizationUnit_OnClick(" & m_intMonth & "," & m_intYear & ")")
        CommonFunctions.General.WriteHTML("</TD>")

        'GIves OU Wise Resources
        strSql = "usp_Sel_OUWiseResources_ForCombo " & m_strOrganizationUnit & ",null,'" & dtStartDate & "','" & dtEndDate & "'"
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

        CommonFunctions.General.WriteHTML("<td align=Left id='objTDCell' width=17%>")
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
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtMonth", "txtMonth", , 20, 2, m_intMonth.ToString, "right", EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_YEAR"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=3% align=right >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtYear", "txtYear", , 35, 4, m_intYear.ToString, "right", EnableHTMLEncode:=True)

        'ended by Shamkant s  for HTML encoding Date:06/10/15
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
        CommonFunctions.General.WriteHTML("<TD width=5% align='Right' title='Submitted Leave'>Submitted&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Pattern1.jpg' align='Right'></TD>")
        CommonFunctions.General.WriteHTML("<TD width=6% align='Right' title='Approved Leave'>Approved&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Purple_L.gif' align='Right'></TD>")

        
        CommonFunctions.General.WriteHTML("<TD width=7% align='Right' title='Rejected Leave'>Rejected&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Black_R.gif' align='Right'></TD>")

        CommonFunctions.General.WriteHTML("<TD width=8% align='Right' title='Cancelled Leave'>Cancelled&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=2% height=2% background = '../../Images/Calender Images/Cross_C.gif' align='Right'></TD>")

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


        CommonFunctions.General.WriteHTML("<td align=Left width='5%'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtOrganizationUnit", "txtOrganizationUnit", , 50, 2000, m_strOrganizationUnit, , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")


        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("</Table>")

        Response.Write("</DIV>")

    End Sub
    Private Sub DisplayGrid()
        Dim strSql As String
        Dim drForGrid, drForEmployee, drStartDayOfWeek, drLeave As IDataReader
        Dim intStartingDayOfWeek, intNoOfWeekDays As Integer
        Dim intYear, intMonth As Integer
        Dim intEmployeeID As String
        Dim strTemp As String = ""
        Dim days() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim intReportingID As Integer
        Dim intReportingID_old As Integer = 0
        Dim strReportingTo As String
        Dim strStatus As String
        Dim strLeaveIDs As String
        Dim arrstrStatus() As String
        Dim arrstrLeaveIDArray() As String
        Dim LeavesArray() As Integer
        Dim m_strPKToken_ResorceAllocation As String

        strSql = "usp_sel_OUWise_WorkingDays " & m_strOrganizationUnit

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

            Dim dtStartDate As New Date(intYear, intMonth, 1)
            Dim dtEndDate As New Date(intYear, intMonth, days(intMonth))

            strSql = "usp_Sel_OUWiseResources " & m_strOrganizationUnit & "," & m_strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"

            Response.Write("<DIV Id='divContainer' Style='height:410px; overflow:auto; width:100%' >")

            Response.Write(" <STYLE type=text/css> {TABLE  {TABLE-LAYOUT: fixed;} ")
            Response.Write(" TR TD.DivSub1Tag {POSITION: relative;} ")

            Response.Write(" TR TD.DivSub1Tag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divContainer').scrollTop -1)} ")

            Response.Write(" </STYLE>")

            CommonFunctions.General.WriteHTML("<table id='tblHeader' cellSpacing=1 bgcolor='#a9a9a9' cellPadding=0  width=100% border='0' Height=30px>")

            strTemp = "Resource Name"
            'CommonFunctions.General.WriteHTML("" + objCalender.PlotCalenderForResourceLeaveHeadings(m_intMonth, m_intYear, "" + strTemp + "") + "")


            'here objCalender is set to Nothing so that GC will collect it
            objCalender = Nothing

            drForGrid = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
            'CommonFunctions.General.WriteHTML("<table cellSpacing=1 bgcolor='#a9a9a9' cellPadding=0  width=100% border='0' Height=30px>")
            While (drForGrid.Read)
                'Token Security
                m_strPKToken_ResorceAllocation = CommonFunctions.Security.Token.GetToken(CType(intProjectEmployeeRoleID, String) + Session("intUserID").ToString + "0" + "1019")

                'Here we are plotting the Empty Calender control
                Dim objEmptyCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

                strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeID"), " "), String)
                strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeName"), "0"), String)
                intReportingID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingToID"), "0"), String)
                strReportingTo = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingTo"), "0"), String)

                'For Leave status
                strSql = "usp_sel_Monthly_LeaveStaus " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"

                drLeave = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                While drLeave.Read()
                    strStatus = drLeave("Status")
                    strLeaveIDs = drLeave("LeaveIDs")
                End While
                CommonFunction.Data.DisposeDataReader(drLeave)
                arrstrStatus = strStatus.Split(",")
                arrstrLeaveIDArray = strLeaveIDs.Split(",")

                Dim cntDays As Integer

                For cntDays = 0 To arrstrStatus.Length - 1
                    ReDim Preserve LeavesArray(cntDays)

                    If arrstrStatus(cntDays) = "S" Then
                        'objEmptyCalender.DaysForResource(cntDays + 1).mstrCellImage = "../../Images/Calender Images/Pattern1.jpg"

                    ElseIf arrstrStatus(cntDays) = "A" Then
                        ' objEmptyCalender.DaysForResource(cntDays + 1).mstrCellImage = "../../Images/Calender Images/Purple_L.gif"

                    ElseIf arrstrStatus(cntDays) = "R" Then
                        'objEmptyCalender.DaysForResource(cntDays + 1).mstrCellImage = "../../Images/Calender Images/Black_R.gif"

                    ElseIf arrstrStatus(cntDays) = "C" Then
                        'objEmptyCalender.DaysForResource(cntDays + 1).mstrCellImage = "../../Images/Calender Images/Cross_C.gif"
                        'objEmptyCalender.m_strLeaveType = "Leave"
                    ElseIf arrstrStatus(cntDays) = "H" Then
                        'objEmptyCalender.DaysForResource(cntDays + 1).mstrCellImage = "../../Images/Calender Images/Red_H.gif"
                    End If

                Next

                For cntDays = 0 To arrstrLeaveIDArray.Length - 1
                    'To store LeaveIDs
                    'objEmptyCalender.DaysForResource(cntDays + 1).intLeaveID = arrstrLeaveIDArray(cntDays).ToString()

                Next



                If intReportingID = intReportingID_old Then
                    'CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotResourceLeaveCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", CType(strEmployeeID, Integer), "" & m_strPKToken_ResorceAllocation & "", 0, "" & strReportingTo & "") + "")
                Else
                    'CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotResourceLeaveCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", CType(strEmployeeID, Integer), "" & m_strPKToken_ResorceAllocation & "", intReportingID, "" & strReportingTo & "") + "")
                End If
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
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.RPT_Calender", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
    End Sub
End Class
