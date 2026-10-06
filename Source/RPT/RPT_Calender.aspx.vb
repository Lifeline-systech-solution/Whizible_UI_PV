Option Strict Off
#Region "Imports"
Imports GenericCalender.GenericCalender
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports WebPages
Imports CommonEngines
Imports System
#End Region

Public Class RPT_Calender
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents GraphOutlook As System.Web.UI.HtmlControls.HtmlForm

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

    Protected m_strDashboardID As String = ""

#End Region

#Region "Page Initialization"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

       

        m_strDB_PageName = "../RPT/RPT_Calender.aspx"

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
        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'Dim strSql As String = "SELECT LocationID FROM tbl_PM_Employee WHERE EmployeeID=" + Session("intUserID").ToString
        Dim strSql As String = "usp_sel_tbl_PM_Employee_LocationID " + Session("intUserID").ToString
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

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

        ''Commented as Delivery team and unit combo is not required now
        'If Request.QueryString("OrganizationUnitID") <> "" Then
        '    If Request.QueryString("txtOrganizationUnit").Trim <> Request.QueryString("OrganizationUnitID").Trim And Request.QueryString("txtDeliveryUnit").Trim = Request.QueryString("DeliveryUnitID").Trim Then
        '        m_strDeliveryUnit = "NULL"
        '        m_strDeliveryTeam = "NULL"
        '    End If
        'End If

        ''Commented as Delivery team and unit combo is not required now
        'If Request.QueryString("DeliveryUnitID") <> "" Then
        '    If Request.QueryString("txtDeliveryUnit").Trim <> Request.QueryString("DeliveryUnitID").Trim Then
        '        m_strDeliveryTeam = "NULL"
        '    End If
        'End If

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
        Response.Write("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")
        Call DrawTabs()
        Call DisplayGrid()
        Response.Write("</DIV>")
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

        Dim dtCurrDate As New Date(intYear, intMonth, 1)

        '---End of addition by ManishK on 19th jan 06
        ''Added on 19th Jan 06 to show Dashboard combo on the page, so that we can move on the PM or any Dashboard page
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        '--- Added By purvaj on 15 Jul 2009
        Dim m_blnHideCombo As Boolean = False

        '--- Added By purvaj on 15 Jul 2009
        m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.QueryString("DashboardID"), "0")

        If m_strDashboardID = "" Or m_strDashboardID = "0" Then
            m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.Form("txtDashboardID"), "0")
        End If

        If m_strDashboardID.ToString <> "" And m_strDashboardID.ToString <> "0" Then
            m_blnHideCombo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ShowOrHide_DashboardCombo " + m_strDashboardID.ToString, True), False), False)
        End If
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDashboardID", "txtDashboardID", , , , m_strDashboardID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        If m_blnHideCombo = False Then
            '--- End addition purvaj
            CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader' width=100% >")
            CommonFunctions.General.WriteHTML("<TD width=20% align='Left'><B>e-Dashboard &nbsp;</B>")
            If Trim(Session("intPostID").ToString) <> "" Then
                strSql = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString
            Else
                strSql = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString
            End If

            CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSql, , Trim(m_strDB_PageName & "") & "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD width=30% align=right>")
            'CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            CommonFunctions.General.WriteHTML("&nbsp;<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('ResourceCalendar')>")
            CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black><b Title='" + MyBase.GetResourceString("MENU_HELP") + "'>" + "|&nbsp;&nbsp;" + MyBase.GetResourceString("MENU_QUESTION_MARK") + "</font></b>")
            CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("</Table>")
        End If
        ''End of addition On 19th jan 06

        ''THIS WILL PLOT HEADER CONTAINING HELP
        'CommonFunctions.General.WriteHTML("<TABLE width=100% class='clsTable' cellspacing='0'>")
        ''CommonFunctions.General.WriteHTML("<TR  class='clsTRSectionHeader'>")
        'CommonFunctions.General.WriteHTML("<TR  class='clsTRMenu'>")
        'CommonFunctions.General.WriteHTML("<TD colspan='2' align='Left'><B>&nbsp;" & MyBase.GetResourceString("CAP_CALENDER") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD colspan='2' align='right'>|")
        'CommonFunctions.General.WriteHTML("<Font color='white'><a class='Menu' href=javascript:Help_OnClick('ResourceCalendar')>" & MyBase.GetResourceString("MENU_QUESTION_MARK") & "</a></font>|</td>")
        'CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")



        CommonFunctions.General.WriteHTML("<BR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=99.9% cellspacing='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR width=100% colspan=6 class=clsTRColumnHeader align='Right'>")
        'CommonFunctions.General.WriteHTML("<TD width=85.5%><B>Legends : " & MyBase.GetResourceString("HOLIDAYS_LABEL") & " &nbsp;&nbsp; </B></TD><TD width=25 height=7 bgcolor='RED' ></TD><TD align='Right'>&nbsp;&nbsp;&nbsp;&nbsp;<B>" & MyBase.GetResourceString("LEAVES_LABEL") & "&nbsp;&nbsp; </B></TD><TD width=25 height=7 bgcolor='BLUE' align='Right'></TD>")

        'Organization Unit
        'strSql = "SELECT LocationID, Location FROM tbl_PM_Location ORDER BY 2"
        strSql = "usp_Sel_Organization_Unit " + Session("intUserID").ToString

        CommonFunctions.General.WriteHTML("<TD width=10%></TD>")
        CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_ORGANIZATION_UNIT") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD width=15% align='left'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboOrganizationUnit", strSql, 180, m_strOrganizationUnit.ToString, "onChange=OrganizationUnit_OnClick(" & m_intMonth & "," & m_intYear & ")")
        CommonFunctions.General.WriteHTML("</TD>")

        strSql = "usp_Get_EmployeeName_For_Filter " + m_strOrganizationUnit + ", " + m_strDeliveryUnit + ", " + m_strDeliveryTeam + ", '" + dtCurrDate + "'"
        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_EMPLOYEE"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=10% align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, 200, m_strEmployeeID.ToString, "onChange= Employee_OnClick(" & m_intMonth & "," & m_intYear & ")", True)
        CommonFunctions.General.WriteHTML("</td>")

        'strSql = "usp_Get_Month_For_Calender"
        'CommonFunctions.General.WriteHTML("<td align=right>" & MyBase.GetResourceString("CAP_MONTH"))
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td align=Left >")
        'CommonFunctions.HTMLControls.DrawComboBox("cboMonth", strSql, 100, m_intMonth.ToString, "onChange= Month_OnClick(" & m_intMonth & "," & m_intYear & ")")
        'CommonFunctions.General.WriteHTML("</td>")


        'strSql = "usp_Get_Year_For_Calender"
        'CommonFunctions.General.WriteHTML("<td align=right>" & MyBase.GetResourceString("CAP_YEAR"))
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td align=Left >")
        'CommonFunctions.HTMLControls.DrawComboBox("cboYear", strSql, 100, m_intYear.ToString, "onChange= Year_OnClick(" & m_intMonth & "," & m_intYear & ")")
        'CommonFunctions.General.WriteHTML("</td>")

        'Delivery Unit
        'strSql = "usp_Sel_Delivery_Unit " + m_strOrganizationUnit
        'CommonFunctions.General.WriteHTML("<TD width=11% align='Right' width=10%><B>" & MyBase.GetResourceString("CAP_DELIVERY_UNIT") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=20% align='left' width=12%>")
        'CommonFunctions.HTMLControls.DrawComboBox("cboDeliveryUnit", strSql, 180, m_strDeliveryUnit.ToString, "onChange= DeliveryUnit_OnClick(" & m_intMonth & "," & m_intYear & ")", True)
        'CommonFunctions.General.WriteHTML("</TD>")

        ''Delivery Team 
        'strSql = "usp_Sel_Delivery_Team " + m_strOrganizationUnit + "," + m_strDeliveryUnit
        'CommonFunctions.General.WriteHTML("<TD width=11% align='Right' width=10%><B>" & MyBase.GetResourceString("CAP_DELIVERY_TEAM") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=21% align='left' width=12%>")
        'CommonFunctions.HTMLControls.DrawComboBox("cboDeliveryTeam", strSql, 180, m_strDeliveryTeam.ToString, "onChange= DeliveryTeam_OnClick(" & m_intMonth & "," & m_intYear & ")", True)
        'CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("</TR></TABLE>")


        'CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=100% cellspacing='0'>")
        ''CommonFunctions.General.WriteHTML("<TR width=100% height=10px >")
        ''CommonFunctions.General.WriteHTML("<TD width=30% align='Right'></TD>")
        ''CommonFunctions.General.WriteHTML("<TD width=70% align='Right'>")
        ''CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=100% >")

        'CommonFunctions.General.WriteHTML("<TR colspan=10 width=100% class='clsTRColumnHeader'>")
        'CommonFunctions.General.WriteHTML("<TD width=5% align='Right'><B>" & MyBase.GetResourceString("CAP_LEGENDS") & ": </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'>&nbsp;<B>" & MyBase.GetResourceString("CAP_WORKING_DAYS") & "&nbsp; </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='ghostwhite' align='Right'></TD>")

        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'>&nbsp;<B>" & MyBase.GetResourceString("CAP_WEEKEND_DAYS") & "&nbsp; </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='Gray' align='Right'></TD>")

        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'><B>" & MyBase.GetResourceString("CAP_HOLIDAYS") & " &nbsp;</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=2px bgcolor='#cc0000' ></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=14% align='Right'><B>" & MyBase.GetResourceString("CAP_WORK_FROM_HOME") & " &nbsp;</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='#00cc33' align='Right'></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'>&nbsp;<B>" & MyBase.GetResourceString("CAP_LEAVES") & "&nbsp; </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='BlueViolet' align='Right'></TD>")
        ''CommonFunctions.General.WriteHTML("<TR><br></TR>")
        'CommonFunctions.General.WriteHTML("</TR></TABLE>")

        'CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='1' cellpadding=0 border=0 width=100%>")
        'CommonFunctions.General.WriteHTML("<TR><TD></TD></TR>")
        'CommonFunctions.General.WriteHTML("</table>")

        ''Here Previous page and Next Page links are plot
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing=0 border=0 width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<tr class=clsTRSectionHeader width=100%>")

        CommonFunctions.General.WriteHTML("<td align=Left id='objTDCell' width=20%>")
        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" href='javascript:PreviousMonth_clicked()' >|")
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
        CommonFunctions.General.WriteHTML("<td width=2% align=Left >")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtMonth", "txtMonth", , 20, 2, m_intMonth.ToString, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_YEAR"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=3% align=Left >")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtYear", "txtYear", , 35, 4, m_intYear.ToString, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")

        'Here show link will plot

        CommonFunctions.General.WriteHTML("<td width=6% align=Left id='objTDCell'>&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" href='javascript:Show_clicked()' >|")
        CommonFunctions.General.WriteHTML("&nbsp;Show")
        CommonFunctions.General.WriteHTML("</a>|</td>")

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=100% cellspacing='0'>")
        'CommonFunctions.General.WriteHTML("<TR colspan=10 width=100% class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<TD width=5% align='Right'>" & MyBase.GetResourceString("CAP_LEGENDS") & ": </TD>")
        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'>&nbsp;<B>" & MyBase.GetResourceString("CAP_WORKING_DAYS") & "&nbsp; </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='ghostwhite' align='Right'></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=10% align='Right'>&nbsp;<B>" & MyBase.GetResourceString("CAP_WEEKEND_DAYS") & "&nbsp; </B></TD>")
        'CommonFunctions.General.WriteHTML("<TD width=2% height=5 bgcolor='Gray' align='Right'></TD>")

        CommonFunctions.General.WriteHTML("<TD width=5% align='Right'>" & MyBase.GetResourceString("CAP_HOLIDAYS") & " &nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=1% height=2px bgcolor='#cc0000' ></TD>")
        CommonFunctions.General.WriteHTML("<TD width=3% align='Right'>" & MyBase.GetResourceString("CAP_WORK_FROM_HOME") & " &nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=1% height=5 bgcolor='#00cc33' align='Right'></TD>")
        CommonFunctions.General.WriteHTML("<TD width=4% align='Right'>" & MyBase.GetResourceString("CAP_LEAVES") & "&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=1% height=2px bgcolor='BlueViolet' align='Right'></TD>")

        'Addition done by SuchitraP on 8-MAY-2007 for CleanupActivity
        'Purpose:To show half day leave on Resource Calender View
        CommonFunctions.General.WriteHTML("<TD width=5% align='Right'>" & MyBase.GetResourceString("CAP_HALF_DAY") & "&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD width=1% height=2px bgcolor='CC0099' align='Right'></TD>")
        'End of addition by SuchitraP on 8-MAY-2007 for CleanupActivity

        'CommonFunctions.General.WriteHTML("</TR></TABLE>")

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        CommonFunctions.General.WriteHTML("<td align=Left width='5%'>")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtOrganizationUnit", "txtOrganizationUnit", , 50, 2000, m_strOrganizationUnit, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")

        'CommonFunctions.General.WriteHTML("<td align=Left >")
        'CommonFunctions.HTMLControls.DrawTextBox("txtDeliveryUnit", "txtOrganizationUnit", , 50, 2000, m_strDeliveryUnit, , , , , , True)
        'CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</tr></table>")

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

        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'strSql = "SELECT weekDays,StartingDayOfWeek FROM tbl_PM_CompanyInformation"
        strSql = "usp_sel_tbl_PM_CompanyInformation_StartingDayOfWeekEWeekDays"
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
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
            strSql = "usp_Sel_Resource " + m_strOrganizationUnit + ", " + m_strDeliveryUnit + ", " + m_strDeliveryTeam + ", '" + dtHoliDate + "' ," + m_strEmployeeID

            Response.Write("<DIV Id='divContainer' Style='height:410px; overflow:auto; width:100%' >")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE id='tblHeader' cellSpacing=0 cellPadding=0  width=99.9% border='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            ''Commented on 20th jan 06
            'CommonFunctions.General.WriteHTML("<TR class='clsTREven' align='Right' width ='100%'>")
            'CommonFunctions.General.WriteHTML("<TD align='Left' width='20%'>")
            'CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("CAP_EMPLOYEE_NAME") & "</B>")
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD align='Left' width='88%'>")
            'CommonFunctions.General.WriteHTML("" & objCalender.PlotCalenderForResourceView(m_intMonth, m_intYear, """") & "")
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("</TR>")
            ''End Of commented on 20th Jan 06

            strTemp = MyBase.GetResourceString("CAP_EMPLOYEE_NAME")
            CommonFunctions.General.WriteHTML("<TR width ='100%'>")
            CommonFunctions.General.WriteHTML("<TD align='Left' width='100%'>")
            'CommonFunctions.General.WriteHTML("' & objCalender.PlotCalenderForResourceView(m_intMonth, m_intYear,'" + MyBase.GetResourceString("'CAP_EMPLOYEE_NAME'") + "') & ")
            CommonFunctions.General.WriteHTML("" + objCalender.PlotCalenderForResourceView(m_intMonth, m_intYear, "" + strTemp + "") + "")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR></TABLE>")

            'objCalender.Days(0).Text = "hi"

            'here objCalender is set to Nothing so that GC will collect it
            objCalender = Nothing

            drForGrid = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

            While (drForGrid.Read)
                'Here we are plotting the Empty Calender control
                Dim objEmptyCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

                strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeID"), " "), String)
                strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeName"), "0"), String)

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
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).Text = "<Table width=99.9%><TR><TD align='Left'><Font size=1>A</Font></TD></TR></TABLE>"
                        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    End If
                Next
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

                ''***************************For holiday *********************************

                strSql = "usp_sel_Holidays_For_OU '" & dtHoliDate & "'," & strEmployeeID
                drHolidays = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                intCounter = 0
                While drHolidays.Read
                    HolidayArray(intCounter) = CInt(CommonFunctions.Data.CheckIsDBNull(drHolidays.Item("Holidays"), "0"))
                    objEmptyCalender.DaysForResource(HolidayArray(intCounter)).mstrCellBackColor = "#cc0000"
                    intCounter += 1
                End While
                CommonFunctions.Data.DisposeDataReader(drHolidays)

                ''***************************End of Holiday*********************************
                CommonFunctions.General.WriteHTML("<TR  width='100%'>")

                ''''''''************For Leaves **************************************
                'objEmptyCalender.ArrayCalenderLeaves = LeavesArray
                'objEmptyCalender.CalenderLeaveColor = "BLUE"
                '''''************************* End of Leaves ****************************

                'CommonFunctions.General.WriteHTML("<TD align='left' width=20% Title='Employee Name'>")
                'CommonFunctions.General.WriteHTML("" & strEmployeeName & "")
                'CommonFunctions.General.WriteHTML("</TD>")
                'CommonFunctions.General.WriteHTML("<TD align='left'width=88%>")
                'CommonFunctions.General.WriteHTML("" & objEmptyCalender.PlotEmptyCalender(m_intMonth, m_intYear, """") & "")
                'CommonFunctions.General.WriteHTML("</TD>")
                'CommonFunctions.General.WriteHTML("</TR>")

                'objEmptyCalender.Days(intIterator).Text = "<Table width=100%><TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"")'>" & "A" & " : " & intRowCount & "</A></Font></TD></TR></TABLE>"
                'For intLoop = 1 To days(intMonth)
                'objEmptyCalender.Days(intLoop).Text = "<Table width=100%><TR><TD align='Left'><Font size=1><a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"")'>" & "A" & " : " & intRowCount & "</A></Font></TD></TR></TABLE>"
                ' objEmptyCalender.DaysForResource(intLoop).Text = "<Table width=100%><TR><TD align='Left'><Font size=1>A</Font></TD></TR></TABLE>"
                'objEmptyCalender.Days(intLoop).Text = "hi"
                'Next

                '"<a href='javascript:LoadDetails(""" & strDate & """," & Session("intUserID") & ",""" & dtDate.ToString("dd-MMM-yyyy") & """,""TASKS"")'>" & "A" & " : " & intRowCount & "</A>
                'spDate = New Date(m_intYear, m_intMonth, days(intMonth))

                CommonFunctions.General.WriteHTML("<TD align='Left' width='100%'>")
                CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotEmptyCalender(m_intMonth, m_intYear, "" + strEmployeeName + "", "A", CType(strEmployeeID, Integer)) + "")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")

                objEmptyCalender = Nothing
            End While

        Catch ex As Exception

        End Try
        CommonFunctions.Data.DisposeDataReader(drForGrid)
        CommonFunctions.General.WriteHTML("</TABLE>")
        Response.Write("</DIV>")

    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RPT_Calender", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
    End Sub
#End Region

End Class