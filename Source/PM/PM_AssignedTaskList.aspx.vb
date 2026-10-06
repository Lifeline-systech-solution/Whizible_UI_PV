'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise
' Module Name      :    Task Assignment
' Purpose          :    
' Description      :    This page shows the list of Assigned Tasks.
' Assumptions      :    
' Dependencies     :    
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 30, 2004
' Revisions        :    
'******************************************************************
Imports System.Text

Public Class PM_AssignedTaskList
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Constants Used in the Class "
    'User Preferences
    Protected Const GROUP_CURRENT As String = "_CURRENT"
    Protected Const GROUP_BASELINE As String = "_BASELINE"
    Protected Const GROUP_ACTUAL As String = "_ACTUAL"

    Private Const TASKFILTER_ASSIGNED As String = "Assigned"
    Private Const TASKFILTER_DEFFERED As String = "Deffered"
    Private Const TASKFILTER_ALL As String = "All"
    Private Const TASKFILTER_ONHOLD As String = "OnHold"

    Private Const TASKSTATUSFILTER_YETTOSTART As String = "YetToStart"
    Private Const TASKSTATUSFILTER_INPROGRESS As String = "InProgress"
    Private Const TASKSTATUSFILTER_COMPLETED As String = "Completed"

    Protected Const OPERATION_VOID As String = "Void"
    Protected Const OPERATION_SHOW_HIDE As String = "ShowHide"

    Private Enum MenuIndex
        ''Added by PrashantSJ on 24th July 2009 Purpose: To have Ganttchart view SEM 9.0
        GRAPHICHAL_VIEW
        ''End of addition by PrashantSJ on 24th July 2009
        ADD_DEFERRED_TASK
        ASSIGN_NEW_TASK
        VOID_TASKS
        SHOW_VOID_TASKS
        SELECT_ALL
        CLEAR_ALL
        HELP
    End Enum

    ''Added and commented by PrashantSJ on 24th July 2009 Purpose: To have Ganttchart view SEM 9.0
    'Private Const MENUITEM_COUNT As Integer = 7
    Private Const MENUITEM_COUNT As Integer = 8
    ''End of addition by PrashantSJ on 24th July 2009
#End Region

#Region " Class scope Variables Declarations "
    Private m_strNbyA As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.AdvancedGrid
    Private m_blnTotalPrinted As Boolean = False

    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(MENUITEM_COUNT - 1) As String
    Private m_arrMenuTooltip(MENUITEM_COUNT - 1) As String
    Private m_arrClientSideFunctions(MENUITEM_COUNT - 1) As String

    Protected m_strAction As String = ""
    Protected m_lngTagId As Long = 0
    Private m_lngLogingId As Long = 0

    Private m_lngProjectId As Long = 0
    Private m_blnProjectActive As Boolean = False
    Private m_blnAllowDeferredTaskCreation As Boolean = CommonFunctions.Application.AllowDeferredTaskCreation
    Private m_blnUseActivities As Boolean = False
    Private m_blnApplyEffortDistribution As Boolean = False

    Protected m_strPageNumber As String = ""
    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""

    Private m_lngEmployeeID As Long = 0
    Private m_lngDepartmentID As Long = 0
    Private m_lngDeliverableID As Long = 0
    Private m_lngGroupID As Long = 0
    Private m_strTask As String = ""
    Private m_strTaskStatus As String = ""
    Private m_strIsTaskCompleted As String = ""
    'The RevisionNo
    Protected m_intRevisionNo As Integer = 0

    '--- Added by Priyanka, 6th Sep 2004
    '--- Check if the Project Status 
    Protected m_blnProjectOnHold As Boolean = False
    Protected m_strProjectOnHoldMsg As String = ""
    '--- End of Addition


    'Added by VidyaJ on  Jan 12, 2005
    Protected m_intBaselineNumber As Integer = 0, m_strBaselineMessage As String = ""
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    'End of addition 

    'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
    Dim m_strToken As String
    Dim m_lngParentTagID As Long
    Dim m_lngUserId As Integer
    'End Addition

    ''Added by NitinC on 26 August 2011 For WhizibleSEM v10.0 (Agile Methodology)
    Public m_dtScrumTaskDetails As DataTable
    ''End 


#End Region

#Region " Page Related Event Handlers "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Put user code to initialize the page here
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        m_lngProjectId = m_objGlobal.ProjectID
        m_lngTagId = m_objGlobal.TagID
        m_lngLogingId = m_objGlobal.LoginID
        'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
        m_lngParentTagID = 583
        'End Addition
        'Get the status of 'Project creation workflow required' flag

        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(m_lngProjectId, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

        '--- Added by Priyanka, 6th Sep 2004
        '--- Get the Project Status. If the Status is OnHold do not allow to add new tasks
        Call IsProjectOnHold()

        '-- End Of Addition


        'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197
        m_lngUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
        'End Addition

        InitPageMenu()
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' Merged the project releated calls in GetProjectSettingsDetails
        'm_blnProjectActive = IsProjectActive(m_lngProjectId)
        Call GetProjectSettingsDetails()

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        m_strNbyA = MyBase.GetResourceString("NBYA")
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If

        'Sort Fields
        If Not Page.IsPostBack Then
            m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortOrder"), "")
        Else
            m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        End If
        If m_strSortBy = "" Then m_strSortBy = "A.TaskName"
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

        'Get the submitted the values
        GetFilterValues()

        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Operation"))
        Select Case m_strAction
            Case OPERATION_VOID
                DeleteTasksSelected()

            Case OPERATION_SHOW_HIDE
                SavePreferences()
        End Select

        ''Added by NitinC on 26 August 2011 For WhizibleSEM v10.0 (Agile Methodology)
        Dim strQry As String
        strQry = "Exec Usp_Sel_Scrum_TaskDetails " + CType(m_lngProjectId, String)
        m_dtScrumTaskDetails = CommonFunctions.Data.GetDataTable(strQry, True)
        ''End 


    End Sub

    Public Sub PageInit()
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Dim strPageAlphabets As String = ""
        Dim strQuery As String = ""

        'Build the Query for the Grid
        strQuery = BuildQueryForGrid(True)
        strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT") & " ", , "Alphabet", True)
        If strPageAlphabets = "" Then m_strPageNumber = "-1"

        'Display the Menu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, strPageAlphabets)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Header
        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Filter controls
        DisplayFilters()
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the List of Assigned Tasks
        DisplayAssignedTasksList()

        'Display the Page Footer
        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Menu at Bottom
        m_objMenu = Nothing
        m_objMenu = New WebPages.Template.StaticMenu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False)

        'Put Hidden Controls
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_AssignedTaskList", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_AssignedTaskList : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Menu Initialization "
    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure initializes the arrays used to plot the menu links.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 30, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        ''Added by PrashantSJ on 24th July 2009 Purpose: To have Ganttchart view SEM 9.0
        m_arrMenuItem(MenuIndex.GRAPHICHAL_VIEW) = "Graphical View"
        m_arrMenuTooltip(MenuIndex.GRAPHICHAL_VIEW) = "Graphical View"
        m_arrClientSideFunctions(MenuIndex.GRAPHICHAL_VIEW) = "GraphicalView_OnClick()"
        ''End of addition by PrashantSJ on 24th July 2009
        m_arrMenuItem(MenuIndex.ADD_DEFERRED_TASK) = MyBase.GetResourceString("MENU_ADD_DEFERRED_TASK")
        m_arrMenuTooltip(MenuIndex.ADD_DEFERRED_TASK) = MyBase.GetResourceString("MENU_ADD_DEFERRED_TASK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_DEFERRED_TASK) = "AddDeferredTask_OnClick()"

        m_arrMenuItem(MenuIndex.ASSIGN_NEW_TASK) = MyBase.GetResourceString("MENU_ASSIGN_NEW_TASK")
        m_arrMenuTooltip(MenuIndex.ASSIGN_NEW_TASK) = MyBase.GetResourceString("MENU_ASSIGN_NEW_TASK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ASSIGN_NEW_TASK) = "AssignNewTask_OnClick()"

        m_arrMenuItem(MenuIndex.VOID_TASKS) = MyBase.GetResourceString("MENU_VOID_TASKS")
        m_arrMenuTooltip(MenuIndex.VOID_TASKS) = MyBase.GetResourceString("MENU_VOID_TASKS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.VOID_TASKS) = "VoidTasks_OnClick()"

        'Added by DipaliS 5 Nov 2004
        'Purpose  : to view the voided tasks for the project
        m_arrMenuItem(MenuIndex.SHOW_VOID_TASKS) = MyBase.GetResourceString("MENU_SHOW_VOID_TASKS")
        m_arrMenuTooltip(MenuIndex.SHOW_VOID_TASKS) = MyBase.GetResourceString("MENU_SHOW_VOID_TASKS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SHOW_VOID_TASKS) = "ShowVoidedTasks()"
        'End addition by DipaliS

        m_arrMenuItem(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECT_ALL) = "SelectAll_OnClick('frmProjectTask', 'chkVoid')"

        m_arrMenuItem(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL")
        m_arrMenuTooltip(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEAR_ALL) = "ClearAll_OnClick('frmProjectTask', 'chkVoid')"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"

        MyBase.InitializeResources("AppResources.PM_AssignedTaskList", "AppResources")
    End Sub
#End Region

#Region " List Related Procedures "
    Private Sub DisplayAssignedTasksList()
        Dim intIndex As Integer = 0
        ' Code added by SwapnilR on 7th Nov 2006
        ' Purpose : Array lengh will be increased from 16 to 17 for copytask functionality
        Dim intTotalColumns As Integer = 17
        ' End of code addition by SwapnilR on 7th Nov 2006
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrCheckBoxId(intTotalColumns - 1) As String
        Dim arrRowLink(intTotalColumns - 1) As String
        Dim arrstrTDStyle(intTotalColumns - 1) As String

        'Column groupings
        Dim strShowCurrent As String = ""
        Dim strShowBaseline As String = ""
        Dim strShowActual As String = ""
       
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        'Call GetPreferenceValue(GROUP_CURRENT, strShowCurrent)
        'Call GetPreferenceValue(GROUP_BASELINE, strShowBaseline)
        'Call GetPreferenceValue(GROUP_ACTUAL, strShowActual)

        'Commented by Chakshuta H on 4th-Feb-2016 Purpose::Expand functionality not working properly
        'GetPreferenceValue(strShowCurrent, strShowBaseline, strShowActual)
        Call GetPreferenceValue(GROUP_CURRENT, strShowCurrent, strShowBaseline, strShowActual)
        Call GetPreferenceValue(GROUP_BASELINE, strShowCurrent, strShowBaseline, strShowActual)
        Call GetPreferenceValue(GROUP_ACTUAL, strShowCurrent, strShowBaseline, strShowActual)
        'End Of commented by Chakshuta H on 4th-Feb-2016 Purpose::Expand functionality not working properly
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 


        If strShowCurrent.Trim() = "" Then strShowCurrent = "1"
        If strShowBaseline.Trim() = "" Then strShowBaseline = "1"
        If strShowActual.Trim() = "" Then strShowActual = "1"

        'Dim arrColumnGroupColumn() As String = {"1-4", "5-8", "9-12", "13-16", "17"}
        'Dim arrColumnGroupColumn() As String = {"1-3", "4-7", "8-11", "12-15", "16-17"}
        Dim arrColumnGroupColumn(4) As String

        ' Code added by SwapnilR on 7th Nov 2006
        ' Purpose : As img tag is used for displaying copy image and that value is coming from db,
        '           this array will use value for displaying the same value that is coming from db.
        'Commented And Added By Chakshuta H on 7th-Oct-2015 Purpose:HTML Encoding
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"1"}
        'End Of Commented And Added By Chakshuta H on 7th-Oct-2015 Purpose:HTML Encoding
        ' End of code addition by SwapnilR on 7th Nov 2006

        Dim arrColumnGroupExpanded() As String = {"1", strShowCurrent, strShowBaseline, strShowActual, "1"}
        Dim arrColumnGroupName(4) As String
        Dim strQuery As String = ""

        'If m_blnUseActivities = False And m_blnApplyEffortDistribution = False Then
        '    arrColumnGroupColumn(0) = "1-3"
        '    arrColumnGroupColumn(1) = "4-7"
        '    arrColumnGroupColumn(2) = "8-11"
        '    arrColumnGroupColumn(3) = "12-15"
        '    arrColumnGroupColumn(4) = "16-17"
        'Else
        '    arrColumnGroupColumn(0) = "1-2"
        '    arrColumnGroupColumn(1) = "4-7"
        '    arrColumnGroupColumn(2) = "8-11"
        '    arrColumnGroupColumn(3) = "12-15"
        '    arrColumnGroupColumn(4) = "16-17"
        'End If

        ' Code added by SwapnilR on 7th Nov 2006
        ' Purpose : Grouping of column is changed due to copy task functionality

        'arrColumnGroupColumn(0) = "1-2"
        'arrColumnGroupColumn(1) = "3-6"
        'arrColumnGroupColumn(2) = "7-10"
        'arrColumnGroupColumn(3) = "11-14"
        'arrColumnGroupColumn(4) = "15-16"

        arrColumnGroupColumn(0) = "1-3"
        arrColumnGroupColumn(1) = "4-7"
        arrColumnGroupColumn(2) = "8-11"
        arrColumnGroupColumn(3) = "12-15"
        arrColumnGroupColumn(4) = "16-17"

        ' End of of code addition by SwapnilR on 7th Nov 2006

        'Build the Query for the Grid
        strQuery = BuildQueryForGrid()

        'Get Column Groups Headers
        arrColumnGroupName(0) = ""
        arrColumnGroupName(1) = MyBase.GetResourceString("CURRENT")
        arrColumnGroupName(2) = MyBase.GetResourceString("BASELINE")
        arrColumnGroupName(3) = MyBase.GetResourceString("ACTUAL")
        arrColumnGroupName(4) = ""

        'Initialize the Required arrays for the advanced grid

        ' Code added by SwapnilR on 7th Nov 2006
        ' Purpose : Added new column in the grid copy task
        arrUserFriendlyColumn(intIndex) = "Copy"
        arrActualColumns(intIndex) = "Copy"
        arrRowLink(intIndex) = "Copy_Task(TaskID)"
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "style='width=65' nowrap align=center"
        intIndex += 1
        ' End of code addition by SwapnilR on 7th Nov 2006

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_NAME")
        arrActualColumns(intIndex) = "TaskName"
        arrRowLink(intIndex) = "ShowAssignedTask(TaskID)"
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "style='width=225' nowrap"
        intIndex += 1

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("RESOURCE")
        'arrActualColumns(intIndex) = "UserName"
        'arrRowLink(intIndex) = ""
        'arrCheckBoxId(intIndex) = ""
        'arrstrTDStyle(intIndex) = ""
        'intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("PRIORITY")
        arrActualColumns(intIndex) = "Priority"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap"
        intIndex += 1

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("LCE")
        'arrActualColumns(intIndex) = "Work"
        'arrRowLink(intIndex) = ""
        'arrCheckBoxId(intIndex) = ""
        'arrstrTDStyle(intIndex) = ""
        'intIndex += 1

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        'arrActualColumns(intIndex) = "StartDate"
        'arrRowLink(intIndex) = ""
        'arrCheckBoxId(intIndex) = ""
        'arrstrTDStyle(intIndex) = "nowrap"
        'intIndex += 1

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        'arrActualColumns(intIndex) = "EndDate"
        'arrRowLink(intIndex) = ""
        'arrCheckBoxId(intIndex) = ""
        'arrstrTDStyle(intIndex) = "nowrap"
        'intIndex += 1

        ' Details of Current
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "StartDate"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "EndDate"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "Duration"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1


        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        '' arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_HRS")
        ''arrActualColumns(intIndex) = "Work"
        arrUserFriendlyColumn(intIndex) = "Work(H:M)"
        arrActualColumns(intIndex) = "WorkHourMinute"
        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1

        ' Details of Baseline
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "BaseLineStart"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "BaseLineEnd"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "BaseLineDuration"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1


        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        ''arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_HRS")
        ''arrActualColumns(intIndex) = "BaselineWork"
        arrUserFriendlyColumn(intIndex) = "Work(H:M)"
        arrActualColumns(intIndex) = "BaselineWorkHourMinute"
        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1

        ' Details of Active
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "ActualStartDate"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "ActualEndDate"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "ActualDuration"
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1


        ''Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        ''arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_HRS")
        ''arrActualColumns(intIndex) = "ActualWork"
        arrUserFriendlyColumn(intIndex) = "Work(H:M)"
        arrActualColumns(intIndex) = "ActualWorkHourMinute"
        ''End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SHOW_BASELINE")
        arrActualColumns(intIndex) = MyBase.GetResourceString("SHOW_BASELINE")
        arrRowLink(intIndex) = "ShowBaseline(TaskID)"
        arrCheckBoxId(intIndex) = ""
        arrstrTDStyle(intIndex) = "style='width=100' align='center' nowrap"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("VOID")
        arrActualColumns(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkVoid"
        arrstrTDStyle(intIndex) = "align=center"
        intIndex += 1

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrRowLink
            .EmptyValueReplacement = m_strNbyA
            .PrimaryKey = "TaskId"
            .SortBy = m_strSortBy.Replace("A.", "")
            .SortOrder = m_strSortOrder
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 240
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns - 2
            .ClientSideSortFunctionName = "Sort_OnClick"
            'Column Groupings
            .ColumnGroupColumnsArray = arrColumnGroupColumn
            .ColumnGroupExpandedArray = arrColumnGroupExpanded
            .ColumnGroupNameArray = arrColumnGroupName
            ' Code added by SwapnilR on 7th Nov 2006
            ' Purpose : As img tag is used for displaying copy image and that value is coming from db,
            '           this array will use value for displaying the same value that is coming from db.
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ' End of code addition by SwapnilR on 7th Nov 2006
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            CommonFunctions.General.WriteHTML(.DrawGrid())
            .DrawGrid()
        End With
    End Sub

    Private Function BuildQueryForGrid(Optional ByVal blnForPaging As Boolean = False) As String
        '====================================================================
        ' Function Name        : BuildQueryForGrid
        ' Parameters Passed    : Boolean value specifying that the query is built for Paging alphabets or for Grid.
        ' Returns              : The built Query for selecting the assigned tasks.
        ' Parameters Affected  : None
        ' Purpose              : This procedure bulds the query string depending upon the filters applied.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : April 30, 2004
        ' Revisions            : 
        '=====================================================================

        Dim strQuery As String = ""

        If m_blnUseActivities = False And m_blnApplyEffortDistribution = False Then
            strQuery = "EXEC usp_Sel_tbl_PM_ProjectTasks_SubTasks " & m_lngProjectId.ToString()
            If m_lngEmployeeID <> 0 Then
                strQuery &= ", " & m_lngEmployeeID.ToString()
            Else
                strQuery &= ", NULL"
            End If

            'Is Task Complete
            If m_strIsTaskCompleted = "YES" Then
                strQuery &= ", 1"
            ElseIf m_strIsTaskCompleted = "NO" Then
                strQuery &= ", 0"
            Else
                strQuery &= ", NULL"
            End If

            strQuery &= ", 'ORDER BY " & CommonFunctions.General.BuildQueryString(m_strSortBy) & " " & m_strSortOrder & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
            If blnForPaging = True Then
                strQuery &= ", 1"
            End If
        Else
            If blnForPaging = False Then
                strQuery = "Exec usp_Sel_tbl_PM_ProjectTasks_TaskAssignment NULL, " & m_lngProjectId.ToString()
            Else
                strQuery = "Exec usp_Sel_tbl_PM_ProjectTasks_TaskAssignment_Paging NULL, " & m_lngProjectId.ToString()
            End If
            If m_lngEmployeeID <> 0 Then
                strQuery &= ", " & m_lngEmployeeID.ToString()
            Else
                strQuery &= ", NULL"
            End If

            If m_lngDepartmentID <> 0 Then
                strQuery &= ", " & m_lngDepartmentID.ToString()
            Else
                strQuery &= ", NULL"
            End If

            If m_lngDeliverableID <> 0 Then
                strQuery &= ", " & m_lngDeliverableID.ToString()
            Else
                strQuery &= ", NULL"
            End If

            If m_lngGroupID <> 0 Then
                strQuery &= ", " & m_lngGroupID.ToString()
            Else
                strQuery &= ", NULL"
            End If

            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strTask) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskStatus) & "'"
            strQuery &= ", 'ORDER BY " & CommonFunctions.General.BuildQueryString(m_strSortBy) & " " & m_strSortOrder & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        End If

        Return strQuery
    End Function

#Region " Procedures For User Prefrences "
    Private Sub SavePreferences()
        Dim strQuery As String
        Dim strGroup As String
        Dim strShow As String
        Dim strPref_For As String

        strGroup = MyBase.FixString(Request.QueryString("Group"), 10, False, True)
        strShow = MyBase.FixString(Request.QueryString("Show"), 1, False, False)
        If strShow.Trim() = "" Then strShow = "0"

        strPref_For = "ASSIGNEDTASKS_"
        strPref_For &= strGroup

        strQuery = "Exec usp_Upd_tbl_PM_UserPreferences " & m_lngLogingId.ToString()
        strQuery &= ", " & m_lngTagId.ToString()
        strQuery &= ", '" & strPref_For & "'"
        strQuery &= "," & strShow

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    'Private Sub GetPreferenceValue(ByVal strGroup As String, ByRef strValue As String)
    '    Dim drWork As IDataReader
    '    Dim strQuery As String
    '    Dim strPref_For As String
    '    Dim blnShow As Boolean

    '    strValue = "0"

    '    strPref_For = "ASSIGNEDTASKS_"
    '    'strPref_For &= strGroup
    '    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
    '    ' replaced usp_Sel_tbl_PM_UserPreferences with usp_SEL_Tbl_PM_UserPreferences_AssignedTask for performance 
    '    strQuery = "Exec usp_Sel_tbl_PM_UserPreferences " & m_lngLogingId.ToString()
    '    strQuery &= ", " & m_lngTagId.ToString()
    '    strQuery &= ", '" & strPref_For & "'"
    '    'strQuery = "Exec usp_SEL_Tbl_PM_UserPreferences_AssignedTask " & m_lngLogingId.ToString()

    '    drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
    '    If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
    '        If (drWork.Read()) Then
    '            blnShow = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Show"), "False"), Boolean)
    '            If blnShow = True Then
    '                strValue = "1"
    '            End If
    '        End If
    '    End If


    '    CommonFunctions.Data.DisposeDataReader(drWork)
    'End Sub
    ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
    'Commented and Added by Chakshuta h on 4th-Feb-2016 added Parameter strGroup
    'Private Sub GetPreferenceValue(ByRef strShowCurrent As String, ByRef strShowBaseline As String, ByRef strShowActual As String)
    Private Sub GetPreferenceValue(ByVal strGroup As String, ByRef strShowCurrent As String, ByRef strShowBaseline As String, ByRef strShowActual As String)
        'End Of Commented and Added by Chakshuta h on 4th-Feb-2016 added Parameter strGroup
        Dim drWork As IDataReader
        Dim strQuery As String
        Dim strPref_For As String
        Dim blnShow As Boolean

        'Commented and Added by Chakshuta h on 4th-Feb-2016 
        'strPref_For = "ASSIGNEDTASKS_" 
        strPref_For = "ASSIGNEDTASKS_" + strGroup + ""
        'End Of Commented and Added by Chakshuta h on 4th-Feb-2016 

        'strPref_For &= strGroup
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        ' replaced usp_Sel_tbl_PM_UserPreferences with usp_SEL_Tbl_PM_UserPreferences_AssignedTask for performance 
        'Uncommented and commented by Chakshuta H on 4th-Feb-2016 Purpose::Expand functionality not working properly
        strQuery = "Exec usp_Sel_tbl_PM_UserPreferences " & m_lngLogingId.ToString()
        strQuery &= ", " & m_lngTagId.ToString()
        strQuery &= ", '" & strPref_For & "'"
        'strQuery = "Exec usp_SEL_Tbl_PM_UserPreferences_AssignedTask " & m_lngLogingId.ToString()
        'End Of Uncommented and commented by Chakshuta H on 4th-Feb-2016 Purpose::Expand functionality not working properly

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
        '    If (drWork.Read()) Then
        '        blnShow = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Show"), "False"), Boolean)
        '        If blnShow = True Then
        '            strValue = "1"
        '        End If
        '    End If
        'End If
        While drWork.Read()
            strPref_For = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ListName"), ""), String)
            blnShow = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Show"), "False"), Boolean)

            If strPref_For.ToUpper = "ASSIGNEDTASKS__CURRENT" Then
                If blnShow = True Then
                    strShowCurrent = "1"
                Else
                    strShowCurrent = "0"
                End If

            ElseIf strPref_For.ToUpper = "ASSIGNEDTASKS__BASELINE" Then

                If blnShow = True Then
                    strShowBaseline = "1"
                Else
                    strShowBaseline = "0"
                End If

            ElseIf strPref_For.ToUpper = "ASSIGNEDTASKS__ACTUAL" Then
                If blnShow = True Then
                    strShowActual = "1"
                Else
                    strShowActual = "0"
                End If

            End If

        End While

        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub
    ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
#End Region
#End Region

    Private Sub GetFilterValues()
        '====================================================================
        ' Procedure Name       : GetFilterValues
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure gets the Filter controls values from the submitted.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : April 30, 2004
        ' Revisions            : NitinVS on 28 May 2007 for WhizibleSEM 7 performance 
        '=====================================================================
        'Modified by HarshK on 16/09/2005 for issueid 272 (Setting User prefrence)
        Dim strSqlQuery As String, strLoginType As String, strUserID As String, strTagID As String
        Dim strEmployeeID As String

        Dim ObjDr As IDataReader
        Dim strFieldName As String

        strLoginType = CType(IIf(Session("LoginType") Is Nothing, "E", Session("LoginType")), String)
        strUserID = CType(Session("intUserID"), String)
        strTagID = "1038"

        If Page.IsPostBack Then
            Dim strFixedValueForEmployee As String, strFixedValueForTask As String, strFixedValueForTaskStatus As String
            Dim strFixedValueForTaskCompleted As String
            
            '------------------------------------
            strEmployeeID = CommonFunctions.General.CheckIsNothing(Request("cboFilter_EmployeeID"), "0")
            m_lngEmployeeID = CType(IIf(strEmployeeID = "", "0", strEmployeeID), Long)
            m_strTask = CommonFunctions.General.CheckIsNothing(Request("optTasks"), "")
            m_strTask = CommonFunctions.General.UnBuildQueryString(m_strTask)
            m_strTaskStatus = CommonFunctions.General.CheckIsNothing(Request("optStatus"), "")
            m_strTaskStatus = CommonFunctions.General.UnBuildQueryString(m_strTaskStatus)
            m_strIsTaskCompleted = CommonFunctions.General.CheckIsNothing(Request("cboFilter_IsTaskCompleted"), "")
            m_strIsTaskCompleted = CommonFunctions.General.UnBuildQueryString(m_strIsTaskCompleted)
            '------------------------------------
            strFixedValueForEmployee = CType(IIf(CType(m_lngEmployeeID, String) = "", "Null", "'" & CType(m_lngEmployeeID, String) & "'"), String)
            strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'EmployeeID',null,'F'," & strFixedValueForEmployee
            CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)

            If m_strTask <> "" And m_strTaskStatus <> "" Then
                strFixedValueForTask = m_strTask
                strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'Task',null,'F','" & strFixedValueForTask & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)

                strFixedValueForTaskStatus = m_strTaskStatus
                strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'TaskStatus',null,'F','" & strFixedValueForTaskStatus & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)
            Else
                strFixedValueForTaskCompleted = CType(IIf(m_strIsTaskCompleted = "", "Null", "'" & m_strIsTaskCompleted & "'"), String)
                strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'TaskCompleted',null,'F'," & strFixedValueForTaskCompleted
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)
            End If

            '------------------------------------
        Else
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            'strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'EmployeeID'"
            'strEmployeeID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "0"))
            'm_lngEmployeeID = CType(IIf(strEmployeeID = "", "0", strEmployeeID), Long)
            ''resetting the filter value so that if resource is not on project then apply default filter
            'strSqlQuery = "SELECT EmployeeID FROM Tbl_PM_ProjectEmployeeRole WHERE ProjectID = " & CStr(Session("intProjectID")) & " AND EmployeeID = " & CStr(m_lngEmployeeID)
            'm_lngEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "0"), Long)

            'strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'Task'"
            'm_strTask = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), TASKFILTER_ALL), String)

            'strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'TaskStatus'"
            'm_strTaskStatus = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), TASKSTATUSFILTER_YETTOSTART), String)

            'strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'TaskCompleted'"
            'm_strIsTaskCompleted = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), ""))


            strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_AssignedTask  '" & strLoginType & "'," & strUserID
            ObjDr = CommonFunction.Data.GetDataReader(strSqlQuery, MyBase.UseSQL)

            While ObjDr.Read()
                strFieldName = CStr(CommonFunctions.Data.CheckIsDBNull(ObjDr("ControlName"), ""))
                Select Case strFieldName
                    Case "EmployeeID"
                        strEmployeeID = CommonFunction.Data.CheckIsDBNull(ObjDr("Value"), "0").ToString
                        m_lngEmployeeID = CType(strEmployeeID, Long)
                        'resetting the filter value so that if resource is not on project then apply default filter

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''strSqlQuery = "SELECT EmployeeID FROM Tbl_PM_ProjectEmployeeRole WHERE ProjectID = " & CStr(Session("intProjectID")) & " AND EmployeeID = " & CStr(m_lngEmployeeID)
                        strSqlQuery = "usp_sel_Tbl_PM_ProjectEmployeeRole_ProjectWiseEmployeeID " & CStr(Session("intProjectID")) & "," & CStr(m_lngEmployeeID)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        m_lngEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "0"), Long)

                    Case "Task"
                        m_strTask = CommonFunction.Data.CheckIsDBNull(ObjDr("Value"), TASKFILTER_ALL).ToString
                    Case "TaskCompleted"
                        m_strIsTaskCompleted = CommonFunction.Data.CheckIsDBNull(ObjDr("Value"), "0").ToString
                    Case "TaskStatus"
                        m_strTaskStatus = CommonFunction.Data.CheckIsDBNull(ObjDr("Value"), TASKSTATUSFILTER_YETTOSTART).ToString
                End Select
            End While
            CommonFunction.Data.DisposeDataReader(ObjDr)
        End If
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        m_lngEmployeeID = CLng(CommonFunctions.General.CheckIsNothing(m_lngEmployeeID, "0"))
        m_strTask = CommonFunctions.General.CheckIsNothing(m_strTask, TASKFILTER_ALL)
        m_strTaskStatus = CommonFunctions.General.CheckIsNothing(m_strTaskStatus, TASKSTATUSFILTER_YETTOSTART)
        m_strIsTaskCompleted = CommonFunctions.General.CheckIsNothing(m_strIsTaskCompleted)
        '"Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails 'LoginType', UserID, TagID, null, 'ControlName', 'ControlCaption' , 'F', 'FixedValue', 'UserFriendlyFixedValue'"

        'm_lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing("0" & Request("cboFilter_EmployeeID"), "0"), Long)
        ''m_lngDepartmentID = CType(CommonFunctions.General.CheckIsNothing("0" & Request("cboFilter_DepartmentID"), "0"), Long)
        ''      m_lngDeliverableID = CType(CommonFunctions.General.CheckIsNothing("0" & Request("cboFilter_DeliverableID"), "0"), Long)
        ''      m_lngGroupID = CType(CommonFunctions.General.CheckIsNothing("0" & Request("cboFilter_GroupID"), "0"), Long)
        'm_strTask = CommonFunctions.General.CheckIsNothing(Request("optTasks"))
        'm_strTask = CommonFunctions.General.UnBuildQueryString(m_strTask)
        'm_strTaskStatus = CommonFunctions.General.CheckIsNothing(Request("optStatus"))
        'm_strTaskStatus = CommonFunctions.General.UnBuildQueryString(m_strTaskStatus)
        'm_strIsTaskCompleted = CommonFunctions.General.CheckIsNothing(Request("cboFilter_IsTaskCompleted"))
        'm_strIsTaskCompleted = CommonFunctions.General.UnBuildQueryString(m_strIsTaskCompleted)

        'If m_strTask = "" Then m_strTask = TASKFILTER_ALL
        'If m_strTaskStatus = "" Then m_strTaskStatus = TASKSTATUSFILTER_YETTOSTART

        'End Modified by HarshK on 16/09/2005 for issueid 272 
    End Sub

    Private Sub DisplayFilters()
        '====================================================================
        ' Procedure Name       : DisplayFilters
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This Procedure displays the controls which are used for filters.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : April 30, 2004
        ' Revisions            : 
        '=====================================================================

        Dim sbHTML As New StringBuilder("")
        Dim strTempHTML As String = ""
        Dim strQuery As String = ""

        If m_blnUseActivities = False And m_blnApplyEffortDistribution = False Then
            sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD valign='Top' align='Left'>")
            sbHTML.Append(MyBase.GetResourceString("SELECT_RESOURCE") & " : ")
            sbHTML.Append("</TD><TD valign='Top' align='Left'>")

            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation for Performance 

            strQuery = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_lngProjectId.ToString()
            strQuery += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", strQuery, 200, m_lngEmployeeID.ToString(), "onchange=FilterTasks()", True, True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            sbHTML.Append(MyBase.GetResourceString("ISTASKCOMPLETED") & " : ")
            sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            strQuery = "EXEC usp_Get_IsTaskCompleted_Values"
            strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_IsTaskCompleted", strQuery, 100, m_strIsTaskCompleted, "onchange=FilterTasks()", True, True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR></TABLE>")
        Else
            sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD valign='Top' align='Left'>")
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optTasks", , (m_strTask = TASKFILTER_ASSIGNED), TASKFILTER_ASSIGNED, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("ASSIGNED"))
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optTasks", , (m_strTask = TASKFILTER_DEFFERED), TASKFILTER_DEFFERED, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("DEFERRED"))
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optTasks", , (m_strTask = TASKFILTER_ONHOLD), TASKFILTER_ONHOLD, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("ONHOLD"))
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optTasks", "optTasks", , (m_strTask = TASKFILTER_ALL), TASKFILTER_ALL, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("ALL"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD valign='Top' align='Left'>")
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , (m_strTaskStatus = TASKSTATUSFILTER_YETTOSTART), TASKSTATUSFILTER_YETTOSTART, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("YET_TO_START"))
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , (m_strTaskStatus = TASKSTATUSFILTER_INPROGRESS), TASKSTATUSFILTER_INPROGRESS, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("INPROGRESS"))
            strTempHTML = CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , (m_strTaskStatus = TASKSTATUSFILTER_COMPLETED), TASKSTATUSFILTER_COMPLETED, , "OnClick='FilterTasks()'", True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append(MyBase.GetResourceString("COMPLETED"))
            sbHTML.Append("</TD></TR></TABLE>")

            sbHTML.Append("<TABLE Class=clsTable Width='99.9%' cellpadding=0 cellspacing=0>")
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD valign='Top' align='Left'>")
            sbHTML.Append(MyBase.GetResourceString("SELECT_RESOURCE") & " : ")
            sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            ' Added Parameter for AllowDeferredTaskCreation for Performance 

            strQuery = "EXEC usp_Sel_TeamMembers_TaskAssignment " & m_lngProjectId.ToString()
            strQuery += " ,Null , " + IIf(CommonFunction.Application.AllowDeferredTaskCreation, 1, 0).ToString()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_EmployeeID", strQuery, 200, m_lngEmployeeID.ToString(), "onchange=FilterTasks()", True, True)
            sbHTML.Append(strTempHTML)
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD valign='Top' align='Left'>")
            'sbHTML.Append(MyBase.GetResourceString("DEPARTMENT") & " : ")
            sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            'strQuery = "EXEC usp_Sel_PM_DepartmentList "
            'strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_DepartmentID", strQuery, 200, m_lngDepartmentID.ToString(), "onchange=FilterTasks()", True, True)
            'sbHTML.Append(strTempHTML)
            sbHTML.Append("</TD>")

            sbHTML.Append("</TR>")

            'sbHTML.Append("<TR class='clsTREven'>")
            'sbHTML.Append("<TD valign='Top' align='Left'>")
            'sbHTML.Append(MyBase.GetResourceString("GROUP") & " : ")
            'sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            'strQuery = "EXEC usp_Sel_PM_GroupList "
            'strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_GroupID", strQuery, 200, m_lngGroupID.ToString(), "onchange=FilterTasks()", True, True)
            'sbHTML.Append(strTempHTML)
            'sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            'sbHTML.Append(MyBase.GetResourceString("DELIVERABLE_TYPE") & " : ")
            'sbHTML.Append("</TD><TD valign='Top' align='Left'>")
            'strQuery = "EXEC usp_Sel_tbl_PM_Schedules " & m_lngProjectId.ToString()
            'strTempHTML = CommonFunctions.HTMLControls.DrawComboBox("cboFilter_DeliverableID", strQuery, 200, m_lngDeliverableID.ToString(), "onchange=FilterTasks()", True, True)
            'sbHTML.Append(strTempHTML)
            'sbHTML.Append("</TD></TR>")

            sbHTML.Append("</TABLE>")
        End If
        CommonFunctions.General.WriteHTML(sbHTML.ToString())
    End Sub

    Private Sub DeleteTasksSelected()
        '====================================================================
        ' Procedure Name       : DeleteTasksSelected
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure voids the Tasks selected.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : April 30, 2004
		' Revisions            : Changed by Santosh Pawar on 01-Dec-2004 
		' Purpose			   : Void task one at a time to allow trigger to execute at row level instead of statement level.
        '=====================================================================
        Dim strSelectedTaskIds As String = ""
        Dim strQuery As String = ""
        Dim arrIds() As String
        Dim intActiveTasks As Integer = 0
		Dim intCounter As Integer = 0
		Dim strTaskIDs() As String


        strSelectedTaskIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkVoid")).Trim()
        If strSelectedTaskIds <> "" Then

            'Modified By VidyaJ - DA Performance IssueID - 89 (SP4)
            strQuery = " EXEC usp_upd_UpdateTaskStatus '" & CommonFunctions.General.BuildQueryString(strSelectedTaskIds) & "',0" & "," & m_lngProjectId.ToString()
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strTaskIDs = Split(strSelectedTaskIds, ",")
            'For intCounter = 0 To strTaskIDs.Length - 1
            '	 strQuery = "UPDATE tbl_PM_ProjectTasks Set IsActive = 0 "
            '	 strQuery &= " WHERE TaskID = " & strTaskIDs(intCounter)
            '	 strQuery &= " OR ParentTask_UID = " & strTaskIDs(intCounter)
            '	 CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            'Next

            'strQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 0, Void = 1, ActualEndDate=GetDate() WHERE ParentTask_UID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 0, Void = 1, ActualEndDate=GetDate() WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_PreliminaryEnggSchedule SET TaskId = NULL WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_DrawingEnggSchedule SET TaskId = NULL WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_OutsourceSchedule SET TaskId = NULL WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_SpecificationSchedules_Details SET TaskId = NULL WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'strQuery = "UPDATE tbl_PM_OtherSchedules SET TaskId = NULL WHERE TaskID IN (" & strSelectedTaskIds & ")"
            'CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            ' For Normal Mode
            'If m_blnUseActivities = False And m_blnApplyEffortDistribution = False Then
            '    arrIds = Split(strSelectedTaskIds, ",")
            '    For intCounter = 0 To arrIds.Length() - 1
            '        intActiveTasks = 0
            '        strQuery = "SELECT COUNT(TaskID) FROM tbl_PM_ProjectTasks WHERE IsActive = 1 "
            '        strQuery &= " AND ParentTask_UID = (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE TaskID = " & arrIds(intCounter) & ")"
            '        intActiveTasks = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Integer)
            '        If intActiveTasks = 0 Then
            '            strQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 0 WHERE TaskID = (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE TaskID = " & arrIds(intCounter) & ")"
            '            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            '        End If
            '    Next
            'End If
        End If
    End Sub

    Public Shared Function IsProjectActive(ByVal lngProjectID As Long) As Boolean
        '====================================================================
        ' Function Name        : IsProjectActive
        ' Parameters Passed    : Id of the Project.
        ' Returns              : Boolean value true or false depending upon the project is over or not.
        ' Parameters Affected  : None
        ' Purpose              : This procedure check the over flag from the db against the Project and returns 
        '                        true if it is true else false.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim blnReturn As Boolean = False

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "Select [Over] IsOver from tbl_PM_Project where ProjectID=" & lngProjectID.ToString()
        strQuery = "usp_sel_tbl_PM_Project_IsOver " & lngProjectID.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        blnReturn = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), Boolean)
        Return (Not blnReturn)
    End Function

    Private Sub IsProjectOnHold()
        '====================================================================
        ' Function Name        : IsProjectOnHold
        ' Parameters Passed    : Id of the Project.
        ' Returns              : Boolean value true or false depending upon the project is over or not.
        ' Parameters Affected  : None
        ' Purpose              : This procedure check the Status flag for the Project and returns 
        '                        true if it is true else false.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : PriyankaN
        ' Created              : Sep 6, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectStatus As IDataReader

        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & m_lngProjectId.ToString()
        drProjectStatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
            If drProjectStatus.Read() Then
                m_blnProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(drProjectStatus.Item("ProjectOnHold"), "0"), Boolean)
                m_strProjectOnHoldMsg = CType(CommonFunctions.Data.CheckIsDBNull(drProjectStatus.Item("ProjectOnHoldMsg"), "0"), String)
                'Added by VidyaJ on  Jan 12, 2005
                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                m_strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaseLineMessage"), ""), ""), String)
                'End of addition 
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectStatus)

    End Sub

    Private Sub GetProjectSettingsDetails()
        '====================================================================
        ' Procedure Name       : GetProjectSettingsDetails
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : This procedure gets the Project settings information from the database.
        ' Description          : The UseActivities and ApplyEffortDistribution flags are used while assigning the
        '                        Tasks to the resources and while distributing the work hours between them.
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim drProjectSettings As IDataReader

        strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_lngProjectId.ToString()

        drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drProjectSettings.Read() Then
            m_blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
            m_blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
            m_intRevisionNo = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("RevisionNo"), "0"), Integer)
            m_blnProjectActive = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("Over"), "False"), Boolean)
            m_blnProjectActive = Not m_blnProjectActive
        End If

        CommonFunctions.Data.DisposeDataReader(drProjectSettings)
    End Sub

#Region " Grid / Menu Related Event Handlers "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Select Case Args.MenuColIndex
            Case MenuIndex.ADD_DEFERRED_TASK
                If Not (m_objAccessRights.Add = True And _
                        m_blnProjectActive = True And _
                        m_blnAllowDeferredTaskCreation = True) Then Cancel = True

            Case MenuIndex.ASSIGN_NEW_TASK
                If Not (m_objAccessRights.Add = True And m_blnProjectActive = True) Then Cancel = True

            Case MenuIndex.VOID_TASKS, MenuIndex.SELECT_ALL, MenuIndex.CLEAR_ALL
                If Not (m_objAccessRights.Delete = True And m_blnProjectActive = True) Then Cancel = True

        End Select
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            'Case 1  'Do not show Resource if not normal mode
            '    If Not (m_blnUseActivities = False And m_blnApplyEffortDistribution = False) Then Cancel = True

            'Added by MrugajaB on 12th Sept 2006 for whiziblesem SP7 issue ID.6197

            ' Code added by SwapnilR on 7th Nov 2006
            ' Purpose : Cases are changed as the grid columns are changed.
        Case 1
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TaskID"), String) + CType(m_lngUserId, String) + CType(0, String) + CType(m_lngTagId, String))
                ''Commented by NitinC on 17 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61331]
                ''Added by NitinC on 09 June 2011 for WhizibleSEM v10.0 for Agile Methodology

                'Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")), "'", "&#39;"), """", "&#34;") & "' style='width=225' nowrap;>" _
                '                       & "<A href=""JavaScript:ShowAssignedTask('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
                'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"
                'If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                '    Dim dv As New DataView
                '    Dim dtScrumTaskDetails As DataTable
                '    dv = m_dtScrumTaskDetails.DefaultView
                '    dv.RowFilter = "TaskID=" + Args.DataReader("TaskID").ToString
                '    dtScrumTaskDetails = dv.Table
                '    Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")), "'", "&#39;"), """", "&#34;") & "' style='width=225' nowrap;>" _
                '                           & "<IMG src=""../../Images/Scrum/UserStory.gif""> <A href=""JavaScript:ShowAssignedTask('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
                '    ''Commented and added by NitinC on 26 August 2011 For WhizibleSEM v10.0 (Agile Methodology)
                '    'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"
                '    'FOR RELEASE 
                '    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A>"
                '    Args.StringToBeInserted = Args.StringToBeInserted & "<br>&nbsp;&nbsp;&nbsp;&nbsp;<IMG src=""../../Images/join.gif""><IMG src=""../../Images/Scrum/Release.gif""> "
                '    'Args.StringToBeInserted = Args.StringToBeInserted & "<A href=""JavaScript:ShowEntityPage('" + dtScrumTaskDetails.Rows(0)(3).ToString + "','RELEASE')"">"
                '    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(dtScrumTaskDetails.Rows(0)(5).ToString)) '& "</A>"
                '    'FOR ITERATION
                '    Args.StringToBeInserted = Args.StringToBeInserted & "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<IMG src=""../../Images/join.gif""><IMG src=""../../Images/Scrum/Iteration.gif""> "
                '    'Args.StringToBeInserted = Args.StringToBeInserted & "<A href=""JavaScript:ShowEntityPage('" + dtScrumTaskDetails.Rows(0)(4).ToString + "','ITERATION')"">"
                '    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(dtScrumTaskDetails.Rows(0)(6).ToString)) '& "</A>"

                '    Args.StringToBeInserted = Args.StringToBeInserted & "</TD>"
                '    ''End 

                'Else
                Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")), "'", "&#39;"), """", "&#34;") & "' style='width=225' nowrap;>" _
                   & "<A href=""JavaScript:ShowAssignedTask('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
                Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"
                'End If

                ''End - Added by NitinC on 09 June 2011 for WhizibleSEM v10.0 for Agile Methodology
                ''End of Commented by NitinC on 17 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61331]
                Cancel = True
                'End Addition
                ' SMR
            Case 16 '16
                If m_objAccessRights.Delete = False Then Cancel = True
                ' If user is not having access to add new task, he won't able to copy that task
            Case 0
                If m_objAccessRights.Add = False Then
                    Args.StringToBeInserted = "<TD> </TD>"
                    Cancel = True
                End If
                ' End of code addition by SwapnilR on 7th Nov 2006
        End Select
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case Args.ColIndex
            'Case 1  'Do not show Resource if not normal mode
            '    If Not (m_blnUseActivities = False And m_blnApplyEffortDistribution = False) Then Cancel = True
            ' Code added by SwapnilR on 7th Nov 2006
            ' Purpose : Cases are changed as the grid columns are changed.
        Case 16 '16
                If m_objAccessRights.Delete = False Then Cancel = True

                ' If user is not having access to add new task, he won't able to copy that task
            Case 0
                Args.ApplySorting = False
                If m_objAccessRights.Add = False Then
                    Args.StringToBeInserted = "<TD> </TD>"
                    Cancel = True

                End If
                ' End of code addition by SwapnilR on 7th Nov 2006
        End Select
    End Sub
#End Region

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        Args.clsTR = "clsTROdd"
    End Sub
    ''Added by Yogesh J on 02-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowBaseline_OnClick(TaskID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskID, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    ''End of addition by Yogesh J on 02-Feb-2016
End Class
