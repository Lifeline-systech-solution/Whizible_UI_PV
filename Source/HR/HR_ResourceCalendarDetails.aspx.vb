Imports CommonFunctions
Public Class HR_ResourceCalendarDetails
    Inherits WebPages.Template.WhizTemplate

    Protected m_strWindowTitle As String
    Protected m_strEmployeeID As String
    Private m_strFromDate As String
    Private m_strToDate As String
    Private m_strEmployeeName As String
    Private WithEvents objGrid As WebPage.Templates.GenericGrid
    Private m_strProjectName As String
    Private m_strResourceName As String
    Protected intProjectID As Integer
    Private strTaskType As String
    Private strProjectName As String
    Protected m_lngQueryID As String
    Protected m_TokenKEY As String
    Protected m_PKToken_FromDT As String = ""
    ''Added by Dhanashri S on 1 Sept 2016 for PKtoken
    Protected m_PKToken_FromWhereFlag As String
    ''End of Addition by Dhanashri S on 1 Sept 2016




#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Shamkant S on 15 Feb 2016 to Generate and Validate Token
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("EmployeeID"), String)
        Else
            m_lngQueryID = 0
        End If


        If Not Request.QueryString("PKToken") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")
        End If

        If Not Request.QueryString("FromWhereFlag") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromWhereFlag = CType(Request.QueryString("FromWhereFlag"), String)
        End If
        'If m_PKToken_FromDT <> "" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + "0" + "0", m_PKToken_FromDT) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '    End If

        'End If

        ''Added by Yogesh J on 05/02/2016 to validate Token
        ''Trial Comment
        'If (Request.QueryString("Token") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    ''End of Addition by Dhanashri S on 11 Aug 2016
        'Else
        '    If (Request.QueryString("Token") <> "" And Request.QueryString("FromDate") <> "" And Request.QueryString("EmployeeID") <> "") Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("FromDate"), String) + CType(Request.QueryString("ToDate"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '        End If

        '    End If
        'End If
        ''Trial Comment
        ''End of addiotion by Yogesh J on 05/02/2016 to validate Token

        ''Added by Dhanashri S on 1 Sept 2016 for PkToken
        If (m_PKToken_FromWhereFlag <> "cboTaskType") Then
            ''End of Addition by Dhanashri S on 1 Sept 2016

            ''Added by Dhanashri S on 28 Mar 2016
            ''Added by Dhanashri S on 11 Aug 2016
            If (Request.QueryString("PkToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                ''End of Addition by Dhanashri S on 11 Aug 2016
            Else
                If (Request.QueryString("PkToken") <> "") Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("FromDate"), String) + CType(Request.QueryString("ToDate"), String) + "0" + "0", Request.QueryString("PkToken")) = False) Then
                        ''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If

                End If
            End If
            ''End of Addition by Dhanashri S on 28 MAr 2016
            ''Added by Dhanashri S on 1 Sept 2016 for PkToken
        End If
        ''End of Addition by Dhanashri S on 1 Sept 2016



        'End of addition by Shamkant S on 28-Jan-2016 to Generate and Validate Token

        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security
        '==============================================================
        'Page is Added By ShraddhaM To Display Details of Task in Resource Calender View on 17,May 2007
        '==============================================================
        m_strEmployeeID = Request.QueryString("EmployeeID")
        If m_strEmployeeID Is Nothing Or m_strEmployeeID = "" Then
            m_strEmployeeID = Request.Form("hidEmployeeID")
        End If

        m_strFromDate = Request.QueryString("FromDate")
        If m_strFromDate Is Nothing Or m_strFromDate = "" Then
            m_strFromDate = Request.Form("hidStartDate")
        End If

        m_strToDate = Request.QueryString("ToDate")
        If m_strToDate Is Nothing Or m_strToDate = "" Then
            m_strToDate = Request.Form("hidEndDate")
        End If

    End Sub
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strToDate As String
        Dim objFromDate As Date
        Dim objToDate As Date

        'If Not IsPostBack Then
        '    m_strEmployeeID = Request.QueryString("EmployeeID") + ""

        '    m_strToDate = Request.QueryString("ToDate") + ""
        '    m_strFromDate = Request.QueryString("FromDate") + ""
        'Else
        '    m_strFromDate = MyBase.GetFormValue("txtFromDate") + ""

        'End If

        

        intProjectID = CType(Request.QueryString("ProjectID"), Integer)

        strTaskType = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboTaskType"), "NULL"), String)
        strProjectName = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtProjectName"), ""), String)

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim strQuery As String

        Dim drEmployeeName As IDataReader
        Dim strEmployeeName As String
        Dim strPageHeading As String
        Dim strPageHeading_Right As String
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' strQuery = "select EmployeeName from tbl_pm_Employee where EmployeeID = " & m_strEmployeeID
        strQuery = "usp_sel_tbl_pm_Employee_EmployeeName " & m_strEmployeeID
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        drEmployeeName = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While drEmployeeName.Read
            strEmployeeName = CType(drEmployeeName("EmployeeName"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drEmployeeName)
        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('RESOURCE_SCHEDULE')")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")

        'initialize the resource file for HR_EmployeeSelection page.
        MyBase.InitializeResources("AppResources.PM_ResourceSchedule", "AppResources")

        'Draw Filters
        Call drawFilters()
        'End of  Filters
        'draw page caption 
        'WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        If m_strToDate Is Nothing Or m_strToDate = "" Then
            strPageHeading = "Tasks Details For : " + strEmployeeName '+ " On Date : " + m_strFromDate
            strPageHeading_Right = "Date : " + CommonFunctions.Dates.CGetDate(Date.Parse(m_strFromDate))
        Else
            strPageHeading = "Tasks Details For : " + strEmployeeName '+ "        " + " From Date : " + m_strFromDate + " To Date : " + m_strToDate
            strPageHeading_Right = " From Date  :  " + CommonFunctions.Dates.CGetDate(Date.Parse(m_strFromDate)) + "   To  :  " + CommonFunctions.Dates.CGetDate(Date.Parse(m_strToDate))
        End If

        WebPage.Templates.PageCaption.GetPageCaptions(, strPageHeading, strPageHeading_Right)

        General.WriteHTML("<BR>")

        'plot the screen with data
        Call plotResourceHrsScreen()
        CommonFunctions.General.WriteHTML("</div>" & _
                                                      "</br></br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD>Activities marked as <font color='red'>RED</font> are Void and <font color='blue'>BLUE</font> are OnHold</TD><td widht=50%></td>" & _
                                                      "</TR></Table><BR>")
        CommonFunctions.General.WriteHTML("</Div>")
        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

        CommonFunction.General.WriteHTML("<input type=hidden name='hidEmployeeID' id='hidEmployeeID' value=" + m_strEmployeeID + " >")
        CommonFunction.General.WriteHTML("<input type=hidden name='hidStartDate' id='hidStartDate' value='" + m_strFromDate + "' >")
        CommonFunction.General.WriteHTML("<input type=hidden name='hidEndDate' id='hidEndDate' value='" + m_strToDate + "' >")

    End Sub
    Private Sub drawFilters()

       
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR align=Left class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right>Project Name")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left title='Contains' >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtProjectName", "txtProjectName", , 200, , strProjectName, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15


        CommonFunctions.General.WriteHTML("</TD>")
        'usp_sel_TaskTypes
        CommonFunctions.General.WriteHTML("<TD align=right>Task Type")
        CommonFunctions.General.WriteHTML("<TD align=left title='Task Type' >")
        CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "usp_sel_TaskTypes", 200, strTaskType, "OnChange='JavaScript:cboTaskType_OnChange()'", True)

        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")

    End Sub
    Private Sub plotResourceHrsScreen1()
        Dim strSQL_InProgressTasks As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim blnIsPeriodElapsed As Boolean
        Dim strSQL_NotStarted As String
        blnIsPeriodElapsed = False

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>In Progress Tasks </TD></TR>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<BR>")
        'plot the grid for InProgressTasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_InProgressTasks = "usp_Sel_Monthly_InProgressTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_InProgressTasks += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_InProgressTasks += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_InProgressTasks += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_InProgressTasks += ",Null"
        End If

        Dim arrColHeader_InProgressTasks() As String = {"Task Name", "Start Date", "End Date", "Description", "Work", "Actual Hrs", "Actuals Till Date"}
        Dim arrAN_InProgressTasks() As String = {"TaskName", "StartDate", "EndDate", "Description", "work", "Actual", "TillDateDuration"}


        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN_InProgressTasks
        objGrid.UserFriendlyColumnArray = arrColHeader_InProgressTasks
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 200
        objGrid.DIVStyle = "overflow:auto"
        objGrid.NoOfDataColumns = 7
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL_InProgressTasks
        objGrid.UseSQL = MyBase.UseSQL

        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>Not Started Tasks </TD></TR>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<BR>")
        'plot the grid for Not Started Tasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_NotStarted = "usp_Sel_Monthly_NotStartedTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_NotStarted += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_NotStarted += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If

        'Dim arrColHeader() As String = {MyBase.GetResourceString("COL_RESOURCE_NAME"), MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_TASK_NAME"), MyBase.GetResourceString("COL_START_DATE"), MyBase.GetResourceString("COL_END_DATE"), MyBase.GetResourceString("COL_WORKHRS"), MyBase.GetResourceString("COL_ACTUAL_WORKHRS")}
        'Dim arrAN() As String = {"EmployeeName", "ProjectName", "TaskName", "StartDate", "EndDate", "Work", "ActualWork"}
        Dim arrColHeader_NotStarted() As String = {"Task Name", "Start Date", "End Date", "Description", "Work", "Actual Hrs", "Actuals Till Date"}
        Dim arrAN_NotStarted() As String = {"TaskName", "StartDate", "EndDate", "Description", "work", "Actual", "TillDateDuration"}


        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN_NotStarted
        objGrid.UserFriendlyColumnArray = arrColHeader_NotStarted
        objGrid.DIVID = "DivList1"
        objGrid.DIVHeight = 200
        objGrid.DIVStyle = "overflow:auto"
        objGrid.NoOfDataColumns = 7
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL_NotStarted
        objGrid.UseSQL = MyBase.UseSQL

        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
        'plot the grid for Not Started Tasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_NotStarted = "usp_Sel_Monthly_CompletedTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_NotStarted += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_NotStarted += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If

        'Dim arrColHeader() As String = {MyBase.GetResourceString("COL_RESOURCE_NAME"), MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_TASK_NAME"), MyBase.GetResourceString("COL_START_DATE"), MyBase.GetResourceString("COL_END_DATE"), MyBase.GetResourceString("COL_WORKHRS"), MyBase.GetResourceString("COL_ACTUAL_WORKHRS")}
        'Dim arrAN() As String = {"EmployeeName", "ProjectName", "TaskName", "StartDate", "EndDate", "Work", "ActualWork"}
        Dim arrColHeader_Completed() As String = {"Task Name", "Start Date", "End Date", "Description", "Work", "Actual Hrs", "Actuals Till Date"}
        Dim arrAN_Completed() As String = {"TaskName", "StartDate", "EndDate", "Description", "work", "Actual", "TillDateDuration"}


        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN_Completed
        objGrid.UserFriendlyColumnArray = arrColHeader_Completed
        objGrid.DIVID = "DivList2"
        objGrid.DIVHeight = 200
        objGrid.DIVStyle = "overflow:auto"
        objGrid.NoOfDataColumns = 7
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL_NotStarted
        objGrid.UseSQL = MyBase.UseSQL

        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
    End Sub
    Private Sub plotResourceHrsScreen()
        Dim strSQL_InProgressTasks As String
        Dim drInProgressTasks As IDataReader
        Dim drNotStartedTasks As IDataReader
        Dim drCompletedTasks As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim blnIsPeriodElapsed As Boolean
        Dim strSQL_NotStarted As String
        blnIsPeriodElapsed = False
        Dim ProjectName As String
        Dim TaskName As String
        Dim PlanStartDate As String
        Dim PlanEndDate As String
        Dim ActualStartDate As String
        Dim ActualEndDate As String
        Dim work As String
        Dim Actual As String
        Dim TillDateDuration As String
        Dim cntInProgress As Integer
        Dim strColor As String
        Dim IsActive As Boolean
        Dim TaskOnHold As Boolean
        Dim IsRecordPresent As Boolean

        'Added by NitinC on 09 June 2011 for WhizibleSEM 10.0 for Agile Methodology
        Dim IsUserStoryTask As Boolean
        'End - Added by NitinC on 09 June 2011 for WhizibleSEM 10.0 for Agile Methodology

        IsRecordPresent = False

        'Commented And Added By Yogesh J on 27th-Nov-2015
        ' CommonFunctions.General.WriteHTML("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")
        CommonFunctions.General.WriteHTML("<DIV Id='divPage' Style=' overflow:auto; width:99.99%' >")
        'Commented And Added By Yogesh J on 27th-Nov-2015

        'plot the grid for InProgressTasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim

        strSQL_InProgressTasks = "usp_Sel_Monthly_InProgressTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_InProgressTasks += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_InProgressTasks += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_InProgressTasks += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_InProgressTasks += ",Null"
        End If

        strSQL_InProgressTasks += ",'" + strTaskType + "','" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strProjectName.Trim())) + "'"


        drInProgressTasks = CommonFunctions.Data.GetDataReader(strSQL_InProgressTasks, MyBase.UseSQL)

        cntInProgress = 1
        While drInProgressTasks.Read

            IsRecordPresent = True
            'Plotting Heading of Task
            If cntInProgress = 1 Then


                CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>In Progress Tasks </TD></TR>")
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("<BR>")

                CommonFunctions.General.WriteHTML("<table class='clsGridTable'  CellSpacing=1 CellPadding=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'    align=Left >Project Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'    align=Left >Task Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Actual Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Actual End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")

            End If
            'End of Headings Plotting

            ProjectName = CType(drInProgressTasks("ProjectName"), String)
            TaskName = CType(drInProgressTasks("TaskName"), String)

            'Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
            IsUserStoryTask = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("IsUserStoryTask"), "0"), Boolean)
            'End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

            If IsDBNull(drInProgressTasks("PlanStartDate")) Then
                PlanStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("PlanStartDate"), "-"), String)
            Else
                PlanStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("PlanStartDate"), "-"), String)))
            End If

            If IsDBNull(drInProgressTasks("PlanEndDate")) Then
                PlanEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("PlanEndDate"), "-"), String)
            Else
                PlanEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("PlanEndDate"), "-"), String)))

            End If
            If IsDBNull(drInProgressTasks("ActualStartDate")) Then
                ActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("ActualStartDate"), "-"), String)
            Else
                ActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("ActualStartDate"), "-"), String)))
            End If
            If IsDBNull(drInProgressTasks("ActualEndDate")) Then
                ActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("ActualEndDate"), "-"), String)
            Else
                ActualEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("ActualEndDate"), "-"), String)))

            End If





            work = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("work"), "0"), String)
            Actual = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("Actual"), "0"), String)
            TillDateDuration = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("TillDateDuration"), "0"), String)
            IsActive = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("IsActive"), "0"), Boolean)
            TaskOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drInProgressTasks("TaskOnHold"), "0"), Boolean)
            If IsActive = False Then
                strColor = "Red"
            ElseIf TaskOnHold = True Then
                strColor = "blue"
            Else
                strColor = "Black"
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ProjectName)
            CommonFunctions.General.WriteHTML("</TD>")
            ''Commented and Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

            'CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & TaskName)
            'CommonFunctions.General.WriteHTML("</TD>")
            If IsUserStoryTask = True Then
                CommonFunctions.General.WriteHTML("<TD  align = left ><IMG src=""../../Images/Scrum/UserStory.gif""><FONT color=" & strColor & "> " & TaskName)
                CommonFunctions.General.WriteHTML("</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & TaskName)
                CommonFunctions.General.WriteHTML("</TD>")
            End If

            ''End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

            
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & work)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & Actual)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & TillDateDuration)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR></FONT>")
            cntInProgress = cntInProgress + 1
        End While
        CommonFunction.Data.DisposeDataReader(drInProgressTasks)
        CommonFunctions.General.WriteHTML("</Table>")
        cntInProgress = 1

        'Not Started 
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_NotStarted = "usp_Sel_Monthly_NotStartedTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_NotStarted += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_NotStarted += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If

        strSQL_NotStarted += ",'" + strTaskType + "','" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strProjectName.Trim())) + "'"

        drNotStartedTasks = CommonFunctions.Data.GetDataReader(strSQL_NotStarted, MyBase.UseSQL)



        'plot the grid for Not Started Tasks

        While drNotStartedTasks.Read
            IsRecordPresent = True
            If cntInProgress = 1 Then


                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>Not Started Tasks </TD></TR>")
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("<BR>")
                'Plotting Heading of Task

                CommonFunctions.General.WriteHTML("<table class='clsGridTable'  CellSpacing=1 CellPadding=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'    align=Left >Project Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'  nowrap  align=Left >Task Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'   align=Left>Actual Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Actual End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'   align=Left >Work")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Headings Plotting
            ProjectName = CType(drNotStartedTasks("ProjectName"), String)
            TaskName = CType(drNotStartedTasks("TaskName"), String)

            'Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
            IsUserStoryTask = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("IsUserStoryTask"), "0"), Boolean)
            'End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology


            If IsDBNull(drNotStartedTasks("PlanStartDate")) Then
                PlanStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("PlanStartDate"), "-"), String)
            Else
                PlanStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("PlanStartDate"), "-"), String)))
            End If

            If IsDBNull(drNotStartedTasks("PlanEndDate")) Then
                PlanEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("PlanEndDate"), "-"), String)
            Else
                PlanEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("PlanEndDate"), "-"), String)))

            End If
            If IsDBNull(drNotStartedTasks("ActualStartDate")) Then
                ActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("ActualStartDate"), "-"), String)
            Else
                ActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("ActualStartDate"), "-"), String)))
            End If
            If IsDBNull(drNotStartedTasks("ActualEndDate")) Then
                ActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("ActualEndDate"), "-"), String)
            Else
                ActualEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("ActualEndDate"), "-"), String)))

            End If


            work = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("work"), "0"), String)
            Actual = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("Actual"), "0"), String)
            TillDateDuration = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("TillDateDuration"), "0"), String)
            TaskOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drNotStartedTasks("TaskOnHold"), "0"), Boolean)
            If TaskOnHold = True Then
                strColor = "blue"
            Else
                strColor = "Black"
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ProjectName)
            CommonFunctions.General.WriteHTML("</TD>")
            ''Commented and Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

            'CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & TaskName)
            'CommonFunctions.General.WriteHTML("</TD>")
            If IsUserStoryTask = True Then
                CommonFunctions.General.WriteHTML("<TD  align = left ><IMG src=""../../Images/Scrum/UserStory.gif""><FONT color=" & strColor & "> " & TaskName)
                CommonFunctions.General.WriteHTML("</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & TaskName)
                CommonFunctions.General.WriteHTML("</TD>")
            End If

            ''End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & work)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & Actual)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & TillDateDuration)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR></FONT>")

            cntInProgress = cntInProgress + 1
        End While
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunction.Data.DisposeDataReader(drNotStartedTasks)

        ' END OF NOT STARTED
        cntInProgress = 1

        'Completed
        strSQL_NotStarted = "usp_Sel_Monthly_CompletedTasks_Details_ForAllResources " & m_strEmployeeID
        If m_strFromDate <> "" Then
            strSQL_NotStarted += ",'" + m_strFromDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If
        If m_strToDate <> "" Then
            strSQL_NotStarted += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL_NotStarted += ",Null"
        End If

        strSQL_NotStarted += ",'" + strTaskType + "','" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strProjectName.Trim())) + "'"

        drCompletedTasks = CommonFunctions.Data.GetDataReader(strSQL_NotStarted, MyBase.UseSQL)



        'plot the grid for Completed Tasks

        While drCompletedTasks.Read
            IsRecordPresent = True
            If cntInProgress = 1 Then


                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>Completed Tasks </TD></TR>")
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("<BR>")
                'Plotting Heading of Task

                CommonFunctions.General.WriteHTML("<table class='clsGridTable'  CellSpacing=1 CellPadding=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'    align=Left >Project Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD  class='Locked'    align=Left >Task Name")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Planned End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Actual Start Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left>Actual End Date")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Headings Plotting
            ProjectName = CType(drCompletedTasks("ProjectName"), String)
            TaskName = CType(drCompletedTasks("TaskName"), String)

            If IsDBNull(drCompletedTasks("PlanStartDate")) Then
                PlanStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("PlanStartDate"), "-"), String)
            Else
                PlanStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("PlanStartDate"), "-"), String)))
            End If

            If IsDBNull(drCompletedTasks("PlanEndDate")) Then
                PlanEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("PlanEndDate"), "-"), String)
            Else
                PlanEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("PlanEndDate"), "-"), String)))

            End If
            If IsDBNull(drCompletedTasks("ActualStartDate")) Then
                ActualStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("ActualStartDate"), "-"), String)
            Else
                ActualStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("ActualStartDate"), "-"), String)))
            End If
            If IsDBNull(drCompletedTasks("ActualEndDate")) Then
                ActualEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("ActualEndDate"), "-"), String)
            Else
                ActualEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("ActualEndDate"), "-"), String)))

            End If


            work = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("work"), "0"), String)
            Actual = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("Actual"), "0"), String)
            TillDateDuration = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("TillDateDuration"), "0"), String)
            IsActive = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("IsActive"), "0"), Boolean)
            TaskOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drCompletedTasks("TaskOnHold"), "0"), Boolean)

            If IsActive = False Then
                strColor = "Red"
            ElseIf TaskOnHold = True Then
                strColor = "Blue"
            Else
                strColor = "Black"
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ProjectName)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & TaskName)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & PlanEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualStartDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = left ><FONT color=" & strColor & ">" & ActualEndDate)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & work)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & Actual)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD  align = right ><FONT color=" & strColor & ">" & TillDateDuration)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR></FONT>")

            cntInProgress = cntInProgress + 1
        End While
        CommonFunction.Data.DisposeDataReader(drCompletedTasks)
        CommonFunctions.General.WriteHTML("</Table>")
        'If record is not present
        If IsRecordPresent = False Then
            CommonFunctions.General.WriteHTML("<Table width=99.9%><TR class='clsTREvenRow'><TD align=Center colspan=9>There are no items to show in this view.</TD></TR></Table>")
        End If
        CommonFunctions.General.WriteHTML("</DIV>")


    End Sub




    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
        'CommonFunction.General.WriteHTML("<input type=hidden name='hidEmployeeID' id='hidEmployeeID' value=" + m_strEmployeeID + " >")
        'CommonFunction.General.WriteHTML("<input type=hidden name='hidStartDate' id='hidStartDate' value='" + m_strFromDate + "' >")
        'CommonFunction.General.WriteHTML("<input type=hidden name='hidEndDate' id='hidEndDate' value='" + m_strToDate + "' >")
    End Sub
End Class
