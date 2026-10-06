Imports CommonFunctions

Public Class PM_ResourceCalenderViewDetails
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

        '==============================================================
        'Page is Added By ShraddhaM To Display Details of Task in Resource Calender View on 17,May 2007
        '==============================================================

    End Sub
    Public Sub PageInit()

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strToDate As String
        Dim objFromDate As Date
        Dim objToDate As Date

        If Not IsPostBack Then
            m_strEmployeeID = Request.QueryString("EmployeeID") + ""

            m_strToDate = Request.QueryString("ToDate") + ""
            m_strFromDate = Request.QueryString("FromDate") + ""
        Else
            m_strFromDate = MyBase.GetFormValue("txtFromDate") + ""

        End If
        intProjectID = CType(Request.QueryString("ProjectID"), Integer)

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim strQuery As String

        Dim drEmployeeName As IDataReader
        Dim strEmployeeName As String
        Dim strPageHeading As String
        Dim strPageHeading_Right As String

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "select EmployeeName from tbl_pm_Employee where EmployeeID = " & m_strEmployeeID
        strQuery = "usp_sel_tbl_PM_Employee_EmployeeName " & m_strEmployeeID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


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

        'draw page caption 
        'WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        If m_strToDate Is Nothing Or m_strToDate = "" Then
            strPageHeading = "Tasks Details For : " + strEmployeeName '+ " On Date : " + m_strFromDate
            strPageHeading_Right = "Date : " + m_strFromDate
        Else
            strPageHeading = "Tasks Details For : " + strEmployeeName '+ "        " + " From Date : " + m_strFromDate + " To Date : " + m_strToDate
            strPageHeading_Right = " From Date  :  " + m_strFromDate + "   To  :  " + m_strToDate
        End If

        WebPage.Templates.PageCaption.GetPageCaptions(, strPageHeading, strPageHeading_Right)

        General.WriteHTML("<BR>")

        'plot the screen with data
        Call plotResourceHrsScreen1()
        CommonFunctions.General.WriteHTML("</div>" & _
                                                      "</br></br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD>Activities marked as <font color='red'>RED</font> are Void and <font color='blue'>BLUE</font> are OnHold</TD><td widht=50%></td>" & _
                                                      "</TR></Table><BR>")
        CommonFunctions.General.WriteHTML("</Div>")
        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)


        ''Added by Dhanashri S on 28 Mar 2016
        If (Request.QueryString("PKShowTasksToken") <> "" And Request.QueryString("FromDate") <> "" And Request.QueryString("ToDate") <> "" And Request.QueryString("EmployeeID") <> "" And Request.QueryString("ProjectID") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("FromDate"), String) + CType(Request.QueryString("ToDate"), String) + "0" + "0", Request.QueryString("PKShowTasksToken")) = False) Then

                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If
        ''End of Addition by Dhanashri S on 28 MAr 2016

    End Sub
    Private Sub plotResourceHrsScreen()
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
        strSQL_InProgressTasks = "usp_Sel_Resource_Monthly_Tasks_Details_InProgress " & intProjectID & "," & m_strEmployeeID
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
        Dim arrIgnoreHTMLEncode() As String = {"0"}

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
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
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
        strSQL_NotStarted = "usp_Sel_Resource_Monthly_Tasks_Details_NotStarted " & intProjectID & "," & m_strEmployeeID
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
        Dim arrIgnoreHTMLEncode1() As String = {"0"}

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
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode1
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
        'plot the grid for Not Started Tasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_NotStarted = "usp_Sel_Resource_Monthly_Tasks_Details_Completed " & intProjectID & "," & m_strEmployeeID
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
        Dim arrIgnoreHTMLEncode2() As String = {"0"}

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
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode2
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
    End Sub
    Private Sub plotResourceHrsScreen1()
        Dim strSQL_InProgressTasks As String
        Dim drInProgressTasks As IDataReader
        Dim drNotStartedTasks As IDataReader
        Dim drCompletedTasks As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim blnIsPeriodElapsed As Boolean
        Dim strSQL_NotStarted As String
        blnIsPeriodElapsed = False

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
        'Commented And Added By Vaijat K ON 28/12/2015
        'CommonFunctions.General.WriteHTML("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")
        CommonFunctions.General.WriteHTML("<DIV Id='divPage' Style='overflow:auto; width:99.99%' >")
        'Ended
        'plot the grid for InProgressTasks
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
       
        strSQL_InProgressTasks = "usp_Sel_Resource_Monthly_Tasks_Details_InProgress " & intProjectID & "," & m_strEmployeeID
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
       
       

        drInProgressTasks = CommonFunctions.Data.GetDataReader(strSQL_InProgressTasks, MyBase.UseSQL)

        cntInProgress = 1
        While drInProgressTasks.Read

            'Plotting Heading of Task
            If cntInProgress = 1 Then


            CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing=0 border=0 width=99.9%>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% ><TD>In Progress Tasks </TD></TR>")
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("<BR>")

                CommonFunctions.General.WriteHTML("<table class='clsGridTable'  CellSpacing=1 CellPadding=0 width=99.9%>")


            CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
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
                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                CommonFunctions.General.WriteHTML("</TD>")

                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

            CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            End If
            'End of Headings Plotting


            TaskName = CType(drInProgressTasks("TaskName"), String)

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

        CommonFunction.Data.DisposeDataReader(drInProgressTasks)
        CommonFunctions.General.WriteHTML("</Table>")
        cntInProgress = 1

        'Not Started 
        ''strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        strSQL_NotStarted = "usp_Sel_Resource_Monthly_Tasks_Details_NotStarted " & intProjectID & "," & m_strEmployeeID
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

        drNotStartedTasks = CommonFunctions.Data.GetDataReader(strSQL_NotStarted, MyBase.UseSQL)



        'plot the grid for Not Started Tasks

        While drNotStartedTasks.Read

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
                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'   align=Left >Work")
                CommonFunctions.General.WriteHTML("<TD class='Locked'   align=Left >Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                CommonFunctions.General.WriteHTML("</TD>")

                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Headings Plotting
            TaskName = CType(drNotStartedTasks("TaskName"), String)

           

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
            'CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & TaskName)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & PlanStartDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & PlanEndDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & ActualStartDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & ActualEndDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = right >" & work)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = right >" & Actual)
            'CommonFunctions.General.WriteHTML("</TD>")

            'CommonFunctions.General.WriteHTML("<TD  align = right >" & TillDateDuration)
            'CommonFunctions.General.WriteHTML("</TD>")

            'CommonFunctions.General.WriteHTML("</TR>")
            cntInProgress = cntInProgress + 1
        End While
        CommonFunction.Data.DisposeDataReader(drNotStartedTasks)
        CommonFunctions.General.WriteHTML("</Table>")


        ' END OF NOT STARTED
        cntInProgress = 1

        'Completed
        strSQL_NotStarted = "usp_Sel_Resource_Monthly_Tasks_Details_Completed " & intProjectID & "," & m_strEmployeeID
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

        drCompletedTasks = CommonFunctions.Data.GetDataReader(strSQL_NotStarted, MyBase.UseSQL)



        'plot the grid for Completed Tasks

        While drCompletedTasks.Read

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

                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                CommonFunctions.General.WriteHTML("</TD>")

                ''Commented and Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change
                'CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Hrs")
                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actual Work (H:M)")
                ''End of Added by Usha Pandit on 08 Mar 2019 Purpose::Whizible 2 Work field change

                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("<TD class='Locked'    align=Left >Actuals Till Date")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Headings Plotting
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
            'CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & TaskName)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & PlanStartDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & PlanEndDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & ActualStartDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = left >" & ActualEndDate)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = right >" & work)
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD  align = right >" & Actual)
            'CommonFunctions.General.WriteHTML("</TD>")

            'CommonFunctions.General.WriteHTML("<TD  align = right >" & TillDateDuration)
            'CommonFunctions.General.WriteHTML("</TD>")

            'CommonFunctions.General.WriteHTML("</TR>")
            cntInProgress = cntInProgress + 1
        End While
        CommonFunction.Data.DisposeDataReader(drCompletedTasks)
        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunctions.General.WriteHTML("</DIV>")


    End Sub

    ''These two events are used for grouping. Group on EmployeeName and ProjectName is done here.
    ''in this event group header is plotted, when new employeename or new project name is found, by
    ''inserting new TR for each group
    'Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
    '    If m_strResourceName <> Args.DataReader("EmployeeName").ToString.Trim Then
    '        m_strResourceName = Args.DataReader("EmployeeName").ToString + ""
    '        Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=7>" + Args.DataReader("EmployeeName").ToString + "</TD></TR>"
    '        m_strProjectName = ""
    '    End If
    '    If m_strProjectName <> Args.DataReader("ProjectName").ToString.Trim Then
    '        m_strProjectName = Args.DataReader("ProjectName").ToString + ""
    '        Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left' colspan=6>" + Args.DataReader("ProjectName").ToString + "</TD></TR>"
    '    End If
    'End Sub

    ''in this event the EmployeeName and project name columns are plotted blank as employee name and project name 
    ''are displayed only once in the group header. Here blank TD is inserted inplace of actual employee name and project name
    ''column and original columns are canceled.
    'Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
    '    If Args.ColIndex = 1 Then
    '        Args.StringToBeInserted = "<TD align='left'></TD>"
    '        Cancel = True
    '    ElseIf Args.ColIndex = 0 Then
    '        If Args.NoOfRowsPrinted Mod 2 = 0 Then
    '            Args.StringToBeInserted = "<TD align='left'></TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align='left'></TD>"
    '        End If
    '        Cancel = True
    '    End If
    'End Sub

End Class
