Public Class RT_UpdateTaskCompletePerc
    Inherits WebPages.Template.WhizTemplate

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

#Region "CSPL Code Header"
    '**********************************************************************************
    '                  CSPL Code Header
    ' Project Name     :	Bhageerath
    ' Module Name      :	UpdateTaskCompletePerc.aspx
    ' Purpose          :	Update Percentage Complete for tasks performed by the user during the date range 
    ' Description      :	This page is displayed on clicking "Ready for Verification"
    '						link on ResourceTimesheetDetails page. This page displays
    '						list of tasks against which the current user has filled DA during
    '						the period. It lists Tasks and perecentage complete entered by the user during
    '						filling his DA against the task. User can edit the % value 
    ' Assumptions      :	The stored procedures, and tables are present.
    ' Dependencies     :	CommonFunctions.asp
    ' Author           :	AmitD
    ' Reviewed         :	
    ' Tested           :	
    ' Created          :	21 JUL 2004
    ' Revisions        :	
    '**********************************************************************************
#End Region

#Region "Initialised Variables"

    'Class Members
    Protected m_strWindowTitle As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_intTagID As Integer
    Private m_intAccessAdd As Integer
    Private m_intAccessDelete As Integer
    Private m_intIndex As Integer



    'Variables to store sorting Query string values
    Protected strSortByField As String
    Protected strAscOrDesc As String


    Protected strStartDate As String
    Protected strEndDate As String
    Dim strDeliverableTypeID As String
    Dim strSystem As String
    Dim strDepartmentID As String
    Dim intProjectID As Integer
    Protected strMode As String
    Dim strSource As String
    Dim blnIsAuthenticated As Boolean

    'Variables related to Default Sorting
    Protected strDefaultSortField As String
    Protected strDefaultSortOrder As String

    Dim strFilterString As String 'Stores Filter string containing 
    ' Deliverable Type and/or System

    Dim strQuery As String    'String storing SQL Query for execution

    'Variables to store access details
    Dim strNodeAccess As String



    Dim drProjectTasks As IDataReader    'Recordset to store Resource Timesheets 

    Dim strTaskID As String
    Dim flActualAMH As Double
    Dim flPercentage As Double
    Dim strProjectIDNext As String
    Dim strProjectID As String
    Dim strProjectName As String

#End Region

#Region "Page Load Functions"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strWindowTitle = MyBase.GetResourceString("UPDATE_TASK_COMPLETION_PERC")
        m_intIndex = 1
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 9 , 2004
        ' Revisions             :
        '=====================================================================


        ' Get the sorting order.
        strDefaultSortField = "TaskName"
        strDefaultSortOrder = "ASC"

        strStartDate = CType(Request.QueryString("StartDate"), String)
        strEndDate = CType(Request.QueryString("EndDate"), String)

        intProjectID = CType(Session("intProjectID"), Integer)

        strSortByField = Request.QueryString("SortField")
        strAscOrDesc = Request.QueryString("SortOrder")

        If strSortByField = "" Then
            strSortByField = strDefaultSortField
            strAscOrDesc = strDefaultSortOrder
        End If

        strMode = Request.QueryString("Mode")

        'Added by Yogesh J on 08-Aug-2016 to validate Token
        If Request.QueryString("StartDate") IsNot Nothing And Request.QueryString("EndDate") IsNot Nothing And Request.QueryString("RTtimesheetToken") IsNot Nothing Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("StartDate"), String) + CType(Request.QueryString("EndDate"), String) + CType(0, String) + CType(0, String), Request.QueryString("RTtimesheetToken")) = False) Then
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        ''End of addition by Yogesh J on on 08-Aug-2016 to validate Token
        'GETS THE ACCESS FOR THE USER	
        m_intTagID = 2029 'This is TagID for this page    




        DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")
        'Modified Code By VidyaJ - IssueID - 86 - SP4
        'Change in message
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Right'><B><font Face='Verdana' color='#cc0000' size='1'>If the task is a General Task , then it is not allowed to edit task completion percentage.</FONT></B></TD></TR></TABLE>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("UPDATE_TASK_COMPLETION_PERC"))
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;'>")
        CheckRoleAccess()

        Select Case strMode
            Case "Save"
                SaveTaskProgress()
        End Select

        DrawGridOfEmployeeProfile()
        DrawProjectTasksGrid()
        CommonFunctions.General.WriteHTML("</DIV>")
        DrawMenu()

    End Sub

    Public Sub CheckRoleAccess()
        Dim drAccess As IDataReader


        'Check if Project is Selected
        If Not CType(Session("intProjectID"), String) = "" Then
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'," + CType(Session("intProjectID"), String)
        Else
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'"
        End If

        '##### Get the Default Approver
        drAccess = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drAccess.Read Then
            m_intAccessAdd = CType(CommonFunctions.Data.CheckIsDBNull(drAccess("A"), "0"), Integer)
            m_intAccessDelete = CType(CommonFunctions.Data.CheckIsDBNull(drAccess("D"), "0"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drAccess)
        '##### End 
    End Sub


#End Region

#Region " Generic Functions "
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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region "Plotting Of Grids"
    Public Sub DrawGridOfEmployeeProfile()
        '=====================================================================
        ' Procedure Name        : DrawGridOfEmployeeProfile()	
        ' Purpose               : Plots the grid displaying information of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 20,20004
        ' Revisions             :
        '=====================================================================

        '--- Variables related to Employee Details
        Dim drEmployee As IDataReader
        Dim strEmployeeCode As String
        Dim strEmployeeName As String
        Dim strRole As String
        Dim strDepartment As String
        Dim strWorkingOffice As String


        '##### Get Employee Details of the current user
        strQuery = "Exec usp_Sel_tbl_PM_EmployeeProfile " + CType(Session("intUserID"), String)
        drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drEmployee.Read Then
            strEmployeeCode = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeCode"), ""), String)
            strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
            strRole = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("RoleDescription"), ""), String)
            strDepartment = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("Department"), ""), String)
            strWorkingOffice = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("Location"), ""), String)

        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
        '##### End    


        '##### Plotting The Table For Header Of Timesheet Period
        CommonFunctions.General.WriteHTML("<DIV id='DivTimesheetInfo' style='Overflow:auto;width=100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='99.9%' border='0' id='TABLE1'>" + vbCrLf)
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<tbody>" + vbCrLf)
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageHeader'>" + vbCrLf)
        'Use Resources Solution
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + MyBase.GetResourceString("TASK_DETAILS") + strEmployeeName + "</B></td>" + vbCrLf)
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.CGetDate(CType(strStartDate, Date)) + "&nbsp;" + MyBase.GetResourceString("TO") + "&nbsp;" + CommonFunctions.Dates.CGetDate(CType(strEndDate, Date)) + "</B></td>")
        CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        CommonFunctions.General.WriteHTML("</tbody>" + vbCrLf)
        CommonFunctions.General.WriteHTML("</table>" + vbCrLf)
        CommonFunction.General.WriteHTML("</div>" + vbCrLf)
        '##### End Employee Grid Plotting


        ''##### Plotting The grid For Employee Details
        'CommonFunctions.General.WriteHTML("<BR><DIV id='DivEmployeeProfile' style='Overflow:auto;width=100%;'>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tbody>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("RESOURCE_NAME") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strEmployeeName + "</td>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("ROLE") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strRole + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resource Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("EMPLOYEE_NO") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strEmployeeCode + "</td>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("WORKING_DEPT") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strDepartment + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("WORKING_OFFICE") + "</td>")
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strWorkingOffice + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'></td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'></td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tbody>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</table>" + vbCrLf)
        'CommonFunction.General.WriteHTML("</div>")

        '##### End 
    End Sub

    Public Sub DrawProjectTasksGrid()
        '=====================================================================
        ' Procedure Name        : DrawTimesheetGrid()	
        ' Purpose               : Plots the grid displaying tasks of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 20,20004
        ' Revisions             :
        '=====================================================================


        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrGroupColumnNames As New ArrayList        'To store grouping column names

        'To store the link details while clicking on Links in grid
        'Dim arrWidthArray() As String = {"", "style='width:25%' align='left'", "style='width:8%' align='left'", "style='width:10%' align='left'", "style='width:10%' align='right'", "style='width:10%' align='right'", "style='width:28%' align='center'"}
        Dim arrWidthArray() As String = {"", "style='width:30%' align='left'", "style='width:15%' align='right'", "style='width:20%' align='right'", "style='width:15%' align='right'", "style='width:30%' align='center'"}
        Dim arrColRowLinks() As String = {"", "", "", "", "", ""}
        Dim arrAlignment() As String = {"left", "left", "left", "right", "right", "center"}


        strQuery = "Exec usp_Sel_tbl_PM_ProjectTasks_PercComplete " + CType(Session("intUserID"), String) + ",'" + CType(strStartDate, String) + "','" + CType(strEndDate, String) + "'" '+ strSortByField + "','" + strAscOrDesc + "'"

        CommonFunctions.General.WriteHTML("<br><DIV id='DivProjectTasksList' style='Overflow:auto;width=100%;Height:400'>")




        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("LCE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("AMH_TILL_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_HOURS"))
        'arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_AMH"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_PERCENTAGE"))
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("TaskName")
        arrActualColumnNames.Add("LCE")
        arrActualColumnNames.Add("ActualAMH")
        arrActualColumnNames.Add("NormalAMH")
        'arrActualColumnNames.Add("ExtraAMH")
        arrActualColumnNames.Add("PercentageComplete")
        '##### End

        '##### Grouping column names list
        arrGroupColumnNames.Add("Project Name")
        '##### End 
        Dim arrIgnoreHTMLEncode() As String = {"0"}



        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 5
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .GroupOnColumn = GetArray(arrGroupColumnNames)
            '.ColumnHeaderAlignment = arrAlignment
            '.FooterHTML = sbFooterHTML.ToString
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()


        End With
        m_objGrid = Nothing

        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("RowCount", "RowCount", , , , CType(m_intIndex - 1, String), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.General.WriteHTML("</div>")


    End Sub

#End Region

#Region "Event Handling"

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If

        If Args.ColumnName = "Actual Work (hrs)" Then
            Cancel = True
            Args.StringToBeInserted = "<TD style='width:15%' align='right'>" + "<font color='#cc0000'>" + MyBase.GetResourceString("ACTUAL_HOURS") + "</font></TD>"
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '=================================================
        'Modified By    :   HiteshS on 11th Jan.2005
        'Description    :   Set the MaxLength for control txtPercentage to 6
        '                   For IssueID - 15217
        '=================================================

        Dim strPercentageComplete As String
        Dim strTaskType As String

        If Args.DataField = "PercentageComplete" Then
            Cancel = True
            strPercentageComplete = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageComplete"), ""), String)

            strTaskType = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("WhichTask"), ""), String)

            If strTaskType = "D" Then
                Args.StringToBeInserted = "<td align='center'><input type='hidden' name='txtTaskID" + CType(m_intIndex, String) + "' id='txtTaskID" + CType(m_intIndex, String) + "' value='" + CType(Args.DataReader("TaskID"), String) + "'><input class='clsTextBox' name='txtPercentage" + CType(m_intIndex, String) + "' id='txtPercentage" + CType(m_intIndex, String) + "' size='6' MaxLength='6' Style='text-align:right' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageComplete"), ""), String) + "' onkeypress='Javascript:OnlyNumeric(1)'  disabled><input type='hidden' id='txtPercentageHidden' name='txtPercentageHidden' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageComplete"), ""), String) + "'></td>"
            Else
                Args.StringToBeInserted = "<td align='center'><input type='hidden' name='txtTaskID" + CType(m_intIndex, String) + "' id='txtTaskID" + CType(m_intIndex, String) + "' value='" + CType(Args.DataReader("TaskID"), String) + "'><input class='clsTextBox' name='txtPercentage" + CType(m_intIndex, String) + "' id='txtPercentage" + CType(m_intIndex, String) + "' size='6' MaxLength='6' Style='text-align:right' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageComplete"), ""), String) + "' onkeypress='Javascript:OnlyNumeric(1)'><input type='hidden' id='txtPercentageHidden' name='Hidden' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageComplete"), ""), String) + "'></td>"
            End If


        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        m_intIndex = m_intIndex + 1
    End Sub
#End Region

#Region "SaveTaskProgress"
    Public Sub SaveTaskProgress()
        Dim intCtr As Integer
        Dim intRowCount As Integer
        'Dim drSaveProjectTasks As IDataReader

        intRowCount = CType(Request.Form("RowCount"), Integer)

        For intCtr = 1 To intRowCount
            strTaskID = CType(Request.Form("txtTaskID" + CType(intCtr, String)), String)
            flPercentage = CType(Request.Form("txtPercentage" + CType(intCtr, String)), Double)

            strQuery = "Exec usp_upd_tbl_PM_ProjectTasks_PercentComplete " + CType(strTaskID, String) + "," + CType(flPercentage, String)

            ' Modified By NitinVS on 20 Sep 2006 for WhizibleSEM SP7  IssueID 6341 
            ' Replaced Data Reader with insertorupdate 

            'drSaveProjectTasks = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            'CommonFunctions.Data.DisposeDataReader(drSaveProjectTasks)

            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            ' End Modified By NitinVS on 20 Sep 2006 for WhizibleSEM SP7  IssueID 6341 


        Next

        If Request.QueryString("Link") = "Close" Then
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)


        End If
    End Sub
#End Region

#Region "DrawMenu"
    Public Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 21, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu

        'Use Resource Solution
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        arrClientSideFunctionList.Add("SaveTaskProgress()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("SaveCloseTaskProgress()")


        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("ShowHelp()")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub
#End Region

#Region " Constructor "
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RT_UpdateTaskCompletePerc", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

End Class
