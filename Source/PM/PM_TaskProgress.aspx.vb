#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_TaskProgress
    Inherits WebPages.Template.WhizTemplate

    Protected strFromDate As String
    Protected strToDate As String
    Protected intProjectID As String
    Protected intRowCount As Integer
    Protected intTaskCount As Integer
    Protected intTaskCountForCalPercentage As Integer
    Protected intTaskCountForEnterPercentage As Integer
    Public m_dtFromDate As String
    Public m_dtToDate As String
    Public m_intProjectID As Integer
    Protected WithEvents frmPBNWebForm1 As System.Web.UI.HtmlControls.HtmlForm
    Protected WithEvents frmProjectDetails As System.Web.UI.HtmlControls.HtmlForm
    ' Code added by SwapnilR on 20th April 2005
    ' Purpose : To display task in different color and disabled text box of percent progress
    '           when the task in 100% complete and flag is set at project level for allowing employee for task
    '           completion
    Protected m_blAllowEmployee As Boolean
    ' End of code addtion by SwapnilR on 20th April 2005
    Dim dtDate As Date



    '=====================================================================
    ' Page Name 	        :	Task Progress
    ' Purpose				:	To show Assigntask Progress,to regenerate Task Progress ,Freezed Task Progress.  
    ' Description			:	same above
    ' Author				:	PradipK
    ' Created				:	5th April 2005
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

#End Region

#Region "PageEvents"
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Initialize()
    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        ' Code added by SwapnilR on 20th April 2005
            Dim strSQL As String
            Dim objDr As IDataReader

        'strSQL = "SELECT * FROM tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString
        strSQL = "usp_sel_All_tbl_PM_Project_ProjectID " + HttpContext.Current.Session("intProjectID").ToString
            objDr = CommonFunction.Data.GetDataReader(strSQL, True)
        If objDr.Read Then
            m_blAllowEmployee = CType(CommonFunction.Data.CheckIsDBNull(objDr("ResourceLevelTaskCompletion"), "true"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(objDr)
            ' End of code addition by SwapnilR on 20th April 2005

            dtDate = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate")), Date)
            strFromDate = CType(dtDate, String)
            dtDate = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate")), Date)
            strToDate = CType(dtDate, String)
            intProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"))
            GetGlobalObject()
            m_blnUseClientDateForDA = CommonFunction.Application.UseClientDateForDA()
            'This will strore the constructed menu string in a string variable.   
            DrawMenu()
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")
            Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto;Height=420px'>")
            DisplaySelectionHeader()
            '--- Display Grid with tasks for updation
        DisplayGrid()

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("txtRowCount", "txtRowCount", , , , CStr(intRowCount), , , , , , True, , , , , , , EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtParentTaskID", "txtParentTaskID", , , , CStr(m_intParentTask_UID), , , , , , True, , , , , , , EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015

            HttpContext.Current.Response.Write("</DIV>")
            'Display the Menu at the Bottom
            CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML(strMenu)
            CommonFunctions.General.WriteHTML("<BR>")
        
        DisposeObjects()
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================
        Dim strSQLQuery As String
        Dim strTaskIDs As String
        Dim drCompanyInformation As IDataReader
        Dim intFirstDay As Integer
        Dim dtFromDate As Date
        Dim drDates As IDataReader
        m_lngTagId = m_objGlobal.TagID
        m_strWindowTitle = "HEADING_TASK_UPDATION"
        intRowCount = 0
        intTaskCount = 0
        intTaskCountForEnterPercentage = 0
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        m_dtFromDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate"))
        m_dtToDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate"))

        If m_strMode = MODE_SAVE Or m_strMode = MODE_FREEZE Then
            strTaskIDs = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskIDs"), "")
            UpdateTaskPercentage()
            m_strMode = MODE_LIST
        End If
    End Sub
#End Region
#Region "Constants"
    '--- Constants for the Task Types
    Private Const TASK_TYPE_ASSIGNED As String = "O"
    Private Const TASK_TYPE_MPP As String = "M"
    Private Const TASK_TYPE_ISSUE As String = "B"
    Private Const TASK_TYPE_REVIEW As String = "R"
    '--- Constants for Mode
    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"
    Private Const MODE_FREEZE As String = "Freeze"
    Private Const MODE_REGENERATE As String = "REGENERATE"
#End Region

#Region "Member Variables"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmTaskUpdation As System.Web.UI.HtmlControls.HtmlForm
    Private strMenu As String                           'stores the static menu string.
    Private m_strTaskType As String                     'Stores the Task Type
    Protected m_strWindowTitle As String                'Page Title
    Protected m_lngTagId As Long = 0                    'Tag ID
    Private m_strMode As String                         'Mode
    Private m_intParentTask_UID As Integer
    Private m_intCount As Integer
    Private m_blnUseClientDateForDA As Boolean

#End Region

#Region "General Functions"

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
    Private Sub UpdateTaskPercentage()
        '====================================================================
        ' Procedure Name        : UpdateTaskPercentage
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : to update all tasks' percentages.
        ' Description           : this procedure will update the ActualPercentagecompleted 
        '                         field for particular task
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NiranjanK
        ' Created               : 19 Jan 2005
        ' Revisions             :
        '=====================================================================
        Dim intTotalRows As Integer
        Dim intParentTaskID As Integer
        Dim intTempCount As Integer
        Dim strSQL As String
        Dim strTaskControl As String
        Dim strPercentControl As String
        Dim strCalPercent As String
        Dim strEnteredPercent As String
        Dim intUpdateResult As Integer
        Dim drSaveSiteResourceTimesheet As IDataReader
        Dim strMode As String
        Dim m_strFromDate As String
        Dim m_strToDate As String
        'Dim m_intProjectID As Integer
        m_strFromDate = Request.QueryString("FromDate")
        m_strToDate = Request.QueryString("ToDate")
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        intTempCount = 1
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        strMode = ""
        If m_strMode = MODE_SAVE Then
            strMode = "S"
        End If
        If m_strMode = MODE_FREEZE Then
            strMode = "F"
        End If
        For intTempCount = 1 To CType(MyBase.GetFormValue("txtRowCount"), Integer)
            strTaskControl = "txtTask" + CType(intTempCount, String)
            strPercentControl = "txtPercent" + CType(intTempCount, String)
            strCalPercent = "txtCalPercent" + CType(intTempCount, String)
            strEnteredPercent = "txtEnteredPercent" + CType(intTempCount, String)
            strSQL = "EXEC usp_upd_tbl_pm_Taskprogress " + CType(m_intProjectID, String) + "," + strMode + "," + MyBase.GetFormValue(strTaskControl).ToString + "," + MyBase.GetFormValue(strEnteredPercent).ToString + ", '" + CType(m_strFromDate, String) + "' , '" + CType(m_strToDate, String) + " '"
            intUpdateResult = CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        Next
        intTempCount = 0
    End Sub
#End Region

#Region "Functions & Procedures"
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String
        Dim strSQLQuery As String
        Dim drReportingTo As IDataReader
        'strSQLQuery = "SELECT COUNT(Freezed) AS Freezed FROM tbl_pm_TaskProgress WHERE tbl_PM_TaskProgress.ProjectID ='" + m_intProjectID.ToString + "'AND tbl_PM_TaskProgress.FromDate='" + m_dtFromDate + "' AND tbl_PM_TaskProgress.ToDate='" + m_dtToDate + "' AND  tbl_pm_TaskProgress.Freezed = 1 "
        strSQLQuery = "usp_sel_tbl_pm_TaskProgress_Freezed '" + m_intProjectID.ToString + "','" + m_dtFromDate + "','" + m_dtToDate + "'"
        drReportingTo = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drReportingTo.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drReportingTo("Freezed"), "0"), String) = "0" Then
                arrMenuList.Add(MyBase.GetResourceString("SAVE"))
                ' PradipK
                'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("SAVE"))
                arrClientSideFunctionList.Add("Save_OnClick()")
                ' PradipK
                'arrMenuList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK"))
                arrMenuList.Add(MyBase.GetResourceString("REGENERATE"))
                'PradipK
                'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_PREVIOUS_WEEK_TOOLTIP"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("REGENERATE"))
                arrClientSideFunctionList.Add("Regenerate_OnClick()")

                arrMenuList.Add(MyBase.GetResourceString("APPROVE"))
                ' Pradipk
                'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK_TOOLTIP"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("APPROVE"))
                'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK_TOOLTIP"))
                arrClientSideFunctionList.Add("Freeze_OnClick()")

                'Added By MrugajaB on 16th May 2005 
                'Purpose:To display 'Show History' link on Task Progress page
                arrMenuList.Add(MyBase.GetResourceString("SHOWHISTORY"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("SHOWHISTORY"))
                arrClientSideFunctionList.Add("ShowHistory_OnClick()")
                'End Addition
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drReportingTo)
        ' PradipK
        '        arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
        'PradipK
        'arrMenuList.Add(MyBase.GetResourceString("MENU_NEXT_WEEK"))

        'PradipK
        'arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuList.Add(MyBase.GetResourceString("BACK"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("BACK"))
        arrClientSideFunctionList.Add("Back_OnClick()")
        arrMenuList.Add(MyBase.GetResourceString("HELP"))
        ' PradipK
        'arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("HELP"))
        arrClientSideFunctionList.Add("Help_OnClick()")
        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)
    End Sub
    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub


    Private Sub DisplaySelectionHeader()
        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        Dim drProjectInfo As IDataReader
        Dim strFromDate As String
        Dim strToDate As String
        Dim dtDate As Date
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Task Progress", , , True))
        m_dtFromDate = CType(Request.QueryString("FromDate"), String)
        m_dtToDate = CType(Request.QueryString("ToDate"), String)
        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
        'To Do: Get dates
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + "&nbsp;&nbsp;</B></td>")
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.CGetDate(CType(m_dtFromDate, DateTime)) + "&nbsp;" + "To" + "&nbsp;" + CommonFunctions.Dates.CGetDate(CType(m_dtToDate, DateTime)) + "</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

    End Sub

    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""

        'Modified by PardipK
        'Purpose : Display ResourcePercent,CalculatedPercentage according to Project setting

        Dim intNoOfDataColumns As Integer
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstUFN As Collections.ArrayList
        Dim arrlstTDStyle As Collections.ArrayList
        Dim strSQL As String
        Dim drDefaultPercentProgress As IDataReader
        'End Addition

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If (m_strMode = MODE_REGENERATE) Then
            m_strTaskType = "R"
        End If

        strSQLQuery = "EXEC usp_Sel_tbl_PM_TasksForTaskProgress " & CType(intProjectID, String) & ", '" & CType(strFromDate, String) & "', '" & CType(strToDate, String) & "','" & m_strTaskType & "'"

        ''Dim arrActualColumns() As String = {"TaskName", "EmployeeName", "StartDate", "EndDate", _
        ''                                    "PlannedWork", "ActualWork", "ResourcePercent", "CalculatedPercentage", "PercentageEntered"}
        'Dim arrActualColumns() As String = {"TaskType", "TaskName", "EmployeeName", "StartDate", "EndDate", _
        '                                            "ActualStartDate", "ActualEndDate", "PlannedWork", "ActualWork", "ResourcePercent", "CalculatedPercentage", "PercentageEntered"}

        'Dim arrUserFriendlyColumn() As String = {"", MyBase.GetResourceString("TASK_NAME"), MyBase.GetResourceString("RESOURCE_NAME"), _
        '                                         MyBase.GetResourceString("START_DATE"), MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("ACTUAL_START_DATE"), MyBase.GetResourceString("ACTUAL_END_DATE"), _
        '                                         MyBase.GetResourceString("EFFORTS"), MyBase.GetResourceString("ACTUAL_EFFORTS"), _
        '                                         MyBase.GetResourceString("RESOURCEPERCENT"), MyBase.GetResourceString("CALCULATEDPERCNET"), MyBase.GetResourceString("PERCENTAGE_ENTERED")}
        'Dim arrstrTDStyle() As String = {"align='left' width=0%", "align='left' width=40%", "align='left' width=10%", "align='left' width=5%", _
        '                                 "align='left' width=5%", "align='right' width=5%", _
        '                                 "align='right' width=5%", "align='center' width=5%", "align='center' width=5%", "align='center' width=5%", "align='center' width=5%", "align='center' width=5%"}

        ''Added By MrugajaB on 6th May,2005 for grouping tasks displayed on task progress task type wise i.e.to differentiate Assigned tasks and MPP Tasks
        'Dim arrstrGroupOnColumn() As String = {"1"}

        ''Set the Advanced Grid Properties
        'With m_objGrid

        '    .UserFriendlyColumnArray = arrUserFriendlyColumn
        '    .ActualColumnArray = arrActualColumns
        '    .EmptyValueReplacement = "&nbsp;"
        '    .SQL = strSQLQuery
        '    .DIVID = "divList"
        '    .DIVHeight = 600
        '    .DIVStyle = "overflow:auto;width:100%;"
        '    .NoOfDataColumns = 12
        '    .TDStyleArray = arrstrTDStyle
        '    .ColNameToolTipOnEachRow = True

        '    'Added By MrugajaB on 6th May,2005 for grouping tasks displayed on task progress task type wise i.e.to differentiate Assigned tasks and MPP Tasks
        '    .GroupOnColumn = arrstrGroupOnColumn
        '    .UseSQL = True
        '    .DrawGrid()
        'End With

        'Added By MrugajaB on 6th May,2005 for grouping tasks displayed on task progress task type wise i.e.to differentiate Assigned tasks and MPP Tasks
        Dim arrstrGroupOnColumn() As String = {"1"}

        arrlstAN = New Collections.ArrayList
        arrlstUFN = New Collections.ArrayList
        arrlstTDStyle = New Collections.ArrayList

        arrlstAN.Add("TaskType")
        arrlstAN.Add("TaskName")
        arrlstAN.Add("EmployeeName")
        arrlstAN.Add("StartDate")
        arrlstAN.Add("EndDate")
        arrlstAN.Add("PlannedWork")
        arrlstAN.Add("ActualWork")
        arrlstAN.Add("ActualStartDate")
        arrlstAN.Add("ActualEndDate")

        arrlstUFN.Add("TaskType")
        arrlstUFN.Add(MyBase.GetResourceString("TASK_NAME"))
        arrlstUFN.Add(MyBase.GetResourceString("RESOURCE_NAME"))
        arrlstUFN.Add(MyBase.GetResourceString("START_DATE"))
        arrlstUFN.Add(MyBase.GetResourceString("END_DATE"))
        arrlstUFN.Add(MyBase.GetResourceString("EFFORTS"))
        arrlstUFN.Add(MyBase.GetResourceString("ACTUAL_EFFORTS"))
        arrlstUFN.Add(MyBase.GetResourceString("ACTUAL_START_DATE"))
        arrlstUFN.Add(MyBase.GetResourceString("ACTUAL_END_DATE"))

        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=25%")
        arrlstTDStyle.Add("align='left' width=25%")
        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=5%")
        arrlstTDStyle.Add("align='left' width=5%")
        'Code Added By PradipK on 5 May 2005
        'Purpose : Display ResourcePercent,CalculatedPercentage according to Project setting.
        strSQL = "SELECT DefaultPercentProgress FROM tbl_PM_Project WHERE ProjectID=" + m_intProjectID.ToString
        drDefaultPercentProgress = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        ' If DefaultPercentProgress for Project is Entered by Resource 
        'Then Show ResourcePercent .And Hide CalculatedPercentage.
        If drDefaultPercentProgress.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drDefaultPercentProgress("DefaultPercentProgress"), "0"), String) = "E" Then
                arrlstAN.Add("ResourcePercent")
                arrlstAN.Add("PercentageEntered")
                arrlstUFN.Add(MyBase.GetResourceString("RESOURCEPERCENT"))
                arrlstUFN.Add(MyBase.GetResourceString("PERCENTAGE_ENTERED"))
                arrlstTDStyle.Add("align='left' width=5%")
                arrlstTDStyle.Add("align='left' width=5%")
                intNoOfDataColumns = 11
            End If
            ' If DefaultPercentProgress for Project is Calculated from actuals 
            'Then Show CalculatedPercentage .And Hide ResourcePercent.
            If CType(CommonFunctions.Data.CheckIsDBNull(drDefaultPercentProgress("DefaultPercentProgress"), "0"), String) = "C" Then
                arrlstAN.Add("CalculatedPercentage")
                arrlstAN.Add("PercentageEntered")
                arrlstUFN.Add(MyBase.GetResourceString("CALCULATEDPERCNET"))
                arrlstUFN.Add(MyBase.GetResourceString("PERCENTAGE_ENTERED"))
                arrlstTDStyle.Add("align='left' width=5%")
                arrlstTDStyle.Add("align='left' width=5%")
                intNoOfDataColumns = 11
            End If
            ' If DefaultPercentProgress for Project is Last progress entered/authenticated 
            'Then Show PercentageEntered And Hide CalculatedPercentage and ResourcePercent.
            If CType(CommonFunctions.Data.CheckIsDBNull(drDefaultPercentProgress("DefaultPercentProgress"), "0"), String) = "L" Then
                arrlstAN.Add("PercentageEntered")
                arrlstUFN.Add(MyBase.GetResourceString("PERCENTAGE_ENTERED"))
                arrlstTDStyle.Add("align='left' width=5%")
                intNoOfDataColumns = 10
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drDefaultPercentProgress)
        'Set the Advanced Grid Properties
        Dim arrAN(arrlstAN.Count) As String
        Dim arrUFN(arrlstUFN.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String
        arrlstAN.CopyTo(arrAN)
        arrlstAN = Nothing
        arrlstUFN.CopyTo(arrUFN)
        arrlstUFN = Nothing
        arrlstTDStyle.CopyTo(arrTDStyle)
        arrlstTDStyle = Nothing
        With m_objGrid
            .UserFriendlyColumnArray = arrUFN
            .ActualColumnArray = arrAN
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 470
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intNoOfDataColumns
            .TDStyleArray = arrTDStyle
            .ColNameToolTipOnEachRow = True
            'Added By MrugajaB on 6th May,2005 for grouping tasks displayed on task progress task type wise i.e.to differentiate Assigned tasks and MPP Tasks
            .GroupOnColumn = arrstrGroupOnColumn
            'End Addition
            .UseSQL = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

    End Sub



#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.PM_TaskProgress", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid Events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strTxtPercent As String
        'Dim strTxtName As String
        Dim strTxtTask As String

        ' Display Textbox Only To Child Tasks For PercentageEntered Column.

        If Args.ColumnName = "Percentage Entered" And ((CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), String) <> "0") Or (CType(Args.DataReader("TaskType"), String) = "MPP Tasks")) Then
            Cancel = True
            strTxtPercent = "txtEnteredPercent" + CType(intTaskCountForEnterPercentage, String)
            strTxtTask = "txtTask" + CType(intTaskCountForEnterPercentage, String)
            intRowCount = intRowCount + 1
            intTaskCountForEnterPercentage = intTaskCountForEnterPercentage + 1
            strTxtPercent = "txtEnteredPercent" + CType(intTaskCountForEnterPercentage, String)
            strTxtTask = "txtTask" + CType(intTaskCountForEnterPercentage, String)
            m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
            If m_strMode = MODE_FREEZE Or CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Freezed"), "0"), String) = "True" Then
                Args.StringToBeInserted = "<td align='left' width=10%><input class='clsTextBox' id='" + strTxtPercent + "' name='" + strTxtPercent + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageEntered"), "0"), String) + "' size='6' MaxLength='6' Style='text-align:right' readOnly='True'>%</td>"
            Else
                Args.StringToBeInserted = "<td align='left' width=10%><input class='clsTextBox' id='" + strTxtPercent + "' name='" + strTxtPercent + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageEntered"), "0"), String) + "' size='6' MaxLength='6' Style='text-align:right'>%</td>"
            End If
            Args.StringToBeInserted = Args.StringToBeInserted + "<input type='hidden' id='" + strTxtTask + "' name='" + strTxtTask + "' value=" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + ">"
        End If

    End Sub
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If (CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), String) = "0") And (CType(Args.DataReader("TaskType"), String) <> "MPP Tasks") Then
            m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Integer)
            Args.clsTR = "clsTRSectionHeader"
        End If

        ' Code added by SwapnilR on 20th April 2005
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim dblPercent As Double
        Dim strTxtPercent As String
        Dim strTxtTask As String
        Dim strFromDate As String
        Dim strToDate As String
        Dim dtFromDate As DateTime
        Dim dtToDate As DateTime

        dblPercent = 0
        'strSQL = "SELECT * FROM tbl_PM_ProjectTasks WHERE TaskID = " + CType(Args.DataReader("TaskID"), String) + " AND ActualEndDate BETWEEN '" + m_dtFromDate + "' AND '" + m_dtToDate + "'"
        strSQL = "usp_sel_tbl_PM_ProjectTasks_TaskID_ActualEndDate " + CType(Args.DataReader("TaskID"), String) + ",'" + m_dtFromDate + "','" + m_dtToDate + "'"

        objDr = CommonFunction.Data.GetDataReader(strSQL, True)

        If objDr.Read Then
            dblPercent = CType(CommonFunction.Data.CheckIsDBNull(objDr("ActualPercentComplete"), "0"), Double)
        End If

        If dblPercent = 100 And m_blAllowEmployee = True And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ParentTask_UID"), "0"), String) <> "0" Then
            Cancel = True

            strTxtPercent = "txtEnteredPercent" + CType(intTaskCountForEnterPercentage, String)
            strTxtTask = "txtTask" + CType(intTaskCountForEnterPercentage, String)
            intRowCount = intRowCount + 1
            intTaskCountForEnterPercentage = intTaskCountForEnterPercentage + 1
            strTxtPercent = "txtEnteredPercent" + CType(intTaskCountForEnterPercentage, String)
            strTxtTask = "txtTask" + CType(intTaskCountForEnterPercentage, String)

            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StartDate"), ""), String)
            If strFromDate <> "" Then dtFromDate = CType(strFromDate, DateTime)

            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndDate"), ""), String)
            If strToDate <> "" Then dtToDate = CType(strToDate, DateTime)


            Args.StringToBeInserted += "<tr class = 'clsTREven' style = 'color:Red'>"
            Args.StringToBeInserted += "<td align='left' width=40%>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskName"), ""), String) + "</td>"
            Args.StringToBeInserted += "<td align='left' width=10%>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String) + "</td>"
            Args.StringToBeInserted += "<td align='left' width=5%>" + CommonFunction.Dates.CGetDate(dtFromDate) + "</td>"
            Args.StringToBeInserted += "<td align='left' width=5%>" + CommonFunction.Dates.CGetDate(dtToDate) + "</td>"
            Args.StringToBeInserted += "<td align='right' width=5%>" + FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Work"), "0"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='right' width=5%>" + FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualWork"), "0"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='center' width=5%>" + FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ResourcePercentage"), "0"), String), 2) + "</td>"
            Args.StringToBeInserted += "<td align='center' width=5%>" + FormatNumber(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CalculatedPercentage"), "0"), String), 2) + "</td>"
            'Args.StringToBeInserted += "<td align='left' width=10%><input class='clsTextBox' id='" + strTxtPercent + "' name='" + strTxtPercent + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PercentageEntered"), "0"), String) + "' size='6' MaxLength='6' Style='text-align:right' readOnly='True'>"
            Args.StringToBeInserted += "<td align='left' width=10%><input class='clsTextBox' id='" + strTxtPercent + "' name='" + strTxtPercent + "' value='100' size='6' MaxLength='6' Style='text-align:right' readOnly='True'>"
            Args.StringToBeInserted += "<input type='hidden' id='" + strTxtTask + "' name='" + strTxtTask + "' value=" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), String) + ">"
            Args.StringToBeInserted += "</td></tr>"
        End If

        strSQL = Nothing
        CommonFunction.Data.DisposeDataReader(objDr)
        ' End of code addition by SwapnilR on 20th April 2005
    End Sub
#End Region


    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'Code added by MrugajaB on 9th May,2005
        'Purpose:To hide Column name of column 'Task Type'
        If Args.DataField.Trim.ToUpper = "TASKTYPE" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Added by MrugajaB on 16th May 2005 
        'Purpose:To display history of task progress page
        If (m_strMode <> MODE_FREEZE) Then
            If Args.LinkName = MyBase.GetResourceString("SHOWHISTORY") Then
                Cancel = True
                Return
            End If
        End If
        If Args.LinkName = MyBase.GetResourceString("SHOWHISTORY") Then
            '            Args.FunctionName = "ShowHistory_OnClick(" & m_lngTagId & ",'" & strFromDate & "','" & strToDate & "'," & intProjectID & ")"

            Args.FunctionName = "ShowHistory_OnClick(" & m_lngTagId & "," & intProjectID & ")"
        End If
        'End Addition
    End Sub
End Class
