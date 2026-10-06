Imports System.Text

Public Class PM_ProjectTask
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

        'Added by Yogesh J on on 29-Jan-2016 to validate Token
        ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation

        'If Request.QueryString("TaskID") <> "" And Request.QueryString("PKToken") <> "" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TaskID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Task Mapping", 0, 0, "Task ID", CType(Request.QueryString("UniqueID"), String))
        '        Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            strToken = Request.QueryString("PKToken")
        End If
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            m_EmployeeID = Trim(Request.QueryString("EmployeeID") & "")
        End If

        If (Request.QueryString("TaskID") <> "" And Request.QueryString("MasterTagId") <> "") Then
            If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TaskID"), String) + CType(m_EmployeeID, String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False)) Then
                'Token is Invalid now redirect to the Invalid Access Page
                m_blnValidate = "False"
            End If
        End If
        If (m_blnValidate = "False") Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If

        ''End of Addition by Dhanashri S on 11 Aug 2016
        ''End of addition by Yogesh J on on 29-Jan-2016 to validate Token
    End Sub

#End Region

#Region " Constants Used in the Class "
    'User Preferences
    Protected Const GROUP_CURRENT As String = "_CURRENT"
    Protected Const GROUP_BASELINE As String = "_BASELINE"
    Protected Const GROUP_ACTUAL As String = "_ACTUAL"

    Private Const TASKTYPE_GENERAL As String = "GENERAL"
    Private Const TASKTYPE_MPP As String = "MPP"
    Private Const TASKTYPE_ASSIGNED As String = "ASSIGNED"

    Protected Const ACTIVEALL_ACTIVE As String = "Active"
    Protected Const ACTIVEALL_ALL As String = "All"
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_NEW As String = "New"
    Protected Const MODE_TASKTYPE As String = "TaskType"
    Protected Const OPERATION_SAVE As String = "Save"
    Protected Const OPERATION_SHOW_HIDE As String = "ShowHide"

    Private Enum MenuIndex
        SAVE
        SELECT_MORE
        SHOW_ACTIVE_TASKS
        SHOW_ALL_TASKS
        TASK_MAPPING
        CREATE_MPP
        SELECT_ALL
        CLOSE
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private m_strNbyA As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents objGrid As New WebPages.Template.AdvancedGrid
    Private m_blnTotalPrinted As Boolean = False

    'Added by SiddharthS on 15 Feb 2005
    Private strType As String
    'End Addition

    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(8) As String
    Private m_arrMenuTooltip(8) As String
    Private m_arrClientSideFunctions(8) As String

    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_lngTagId As Long = 0
    Private m_lngLogingId As Long = 0
    Private m_strPageTitle As String = ""
    Private m_lngProjectId As Long = 0
    Protected m_strPageNumber As String = ""
    Protected m_intSubPage As Integer = 0
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""

    'Task Related Field Variables
    Private m_strActiveAll As String = ""
    Private m_lngEmployeeID As Long = 0
    Protected m_strTaskType As String = ""
    Protected m_strType As String = ""
    Private m_strTaskIdList As String = ""  'Used to store all the Tasks Ids.
    Protected m_lngTaskId As Long = 0   'Used in the TaskType Mode only
    Private m_strCaller As String = ""  'Used in the TaskType Mode Only  
    'Used to dynamically generate the client side validation script
    Protected m_sbClientSideScript As New StringBuilder("")

    'Added by GokulP on 05 Jun 2009 for Checking whether Module and Deliverable is Baseline or not.
    Protected m_strModuleBaselineIDs As String = ""
    Protected m_strDeliverableBaselineIDs As String = ""
    Protected m_strSubProjectBaselineIDs As String = ""
    Protected m_strMilestoneBaselineIDs As String = ""
    'End of Addition by GokulP on 05 Jun 2009 for Checking whether Module and Deliverable  is Baseline or not.

    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    Protected m_blnValidate As Boolean = "True"
    Protected m_EmployeeID As String
    ''End of Addition by Dhanashri S on 11 Aug 2016
    ''Added by Yogesh Jalamkar on 22-Aug-2016
    Protected strToken As String
    ''End of addition by Yogesh Jalamkar on 22-Aug-2016

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        'Added by SiddharthS on 15 Feb 2005 For IssueID 15675
        strType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "") 'SiddharthS.15 Feb 2005
        'End addition
        If strType = "" Then
            strType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("txtType"), "")
        End If
        'If Condition Introduced By Paresh On Sep. 08, 2004
        ' For Corporate Projects
        If IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) = True Then
            m_lngProjectId = m_objGlobal.ProjectID
        Else
            m_lngProjectId = CType(HttpContext.Current.Request.QueryString("ProjectID").ToString, Long)
        End If
        m_lngTagId = m_objGlobal.TagID
        m_lngLogingId = m_objGlobal.LoginID
        m_strPageTitle = MyBase.GetResourceString("ASSIGNED_TASKS")
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

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSubPage")) <> "" Then
            m_intSubPage = CType(MyBase.GetFormValue("txthidSubPage"), Integer)
        Else
            m_intSubPage = 1
        End If

        'Sort Fields
        If Not Page.IsPostBack Then
            m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("SortByField"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("ASCorDESC"), "")
        Else
            m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        End If
        'Code Added By VidyaJ for Aspire Issue ID - 19352
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType")) = "A" And m_strSortBy = "UserName" Then
            m_strSortBy = ""
        End If
        'End Of addition
        If m_strSortBy = "" Then m_strSortBy = "TaskName"
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"
        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)

        'Modified by HarshK for sp4 issueid 272
        SetFilterPerfrence()
        'If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboEmployee")) <> "" Then
        '    m_lngEmployeeID = CType(MyBase.GetFormValue("cboEmployee"), Long)
        'Else
        '    m_lngEmployeeID = 0
        'End If
        'End Modified by HarshK for sp4 issueid 272
        If Not Page.IsPostBack Then
            m_strActiveAll = CommonFunctions.General.CheckIsNothing(Request.QueryString("ActiveAll"), "")
        Else
            m_strActiveAll = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidActiveAll"), "")
        End If
        'By default show only the Active tasks for the General Tasks
        If Trim(m_strActiveAll & "") = "" Then m_strActiveAll = ACTIVEALL_ACTIVE
        m_strActiveAll = CommonFunctions.General.UnBuildQueryString(m_strActiveAll)

        'problem is here -Sidh 
        'Commented by HarshK for sp4 issueid 272
        'm_strTaskType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optTask"), "")
        'If Trim(m_strTaskType) = "" Then m_strTaskType = "O"
        'End Commented by HarshK for sp4 issueid 272
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType")) <> "" Then
            m_strType = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"))
        End If


        'strType = HttpContext.Current.Request.QueryString("Type").ToString 'SiddharthS.15 Feb 2005

        InitPageMenu()

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode.Trim() = "" Then m_strMode = MODE_LIST
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Operation"))

        If m_strMode = MODE_TASKTYPE Then
            m_strCaller = UCase(Trim(Request("Caller") & ""))
        End If
        If m_strAction = OPERATION_SAVE Then
            If m_strMode = MODE_LIST Then
                UpdateTaskValue()
            ElseIf m_strMode = MODE_TASKTYPE Then
                UpdateTaskTypeValue()
            ElseIf m_strMode = MODE_NEW Then
                AddNewTask()
            End If
        ElseIf m_strAction = OPERATION_SHOW_HIDE Then
            SavePreferences()
        End If
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_ProjectTask", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ProjectTask : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        objGrid = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

#Region " Functions / Procedures Common to All Modes "
    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.SELECT_MORE) = MyBase.GetResourceString("MENU_PM_SELECT_MORE")
        m_arrMenuTooltip(MenuIndex.SELECT_MORE) = MyBase.GetResourceString("MENU_PM_SELECT_MORE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECT_MORE) = "SelectTaskEntry()"

        m_arrMenuItem(MenuIndex.SHOW_ACTIVE_TASKS) = MyBase.GetResourceString("MENU_PM_SHOW_ACTIVE_TASKS")
        m_arrMenuTooltip(MenuIndex.SHOW_ACTIVE_TASKS) = MyBase.GetResourceString("MENU_PM_SHOW_ACTIVE_TASKS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SHOW_ACTIVE_TASKS) = "ShowGeneralTasks()"

        m_arrMenuItem(MenuIndex.SHOW_ALL_TASKS) = MyBase.GetResourceString("MENU_PM_SHOW_ALL_TASKS")
        m_arrMenuTooltip(MenuIndex.SHOW_ALL_TASKS) = MyBase.GetResourceString("MENU_PM_SHOW_ALL_TASKS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SHOW_ALL_TASKS) = "ShowGeneralTasks()"

        m_arrMenuItem(MenuIndex.TASK_MAPPING) = MyBase.GetResourceString("MENU_PM_TASK_MAPPING")
        m_arrMenuTooltip(MenuIndex.TASK_MAPPING) = MyBase.GetResourceString("MENU_PM_TASK_MAPPING_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.TASK_MAPPING) = "Show_TaskDetails()"

        m_arrMenuItem(MenuIndex.CREATE_MPP) = MyBase.GetResourceString("MENU_PM_CREATE_MPP")
        m_arrMenuTooltip(MenuIndex.CREATE_MPP) = MyBase.GetResourceString("MENU_PM_CREATE_MPP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CREATE_MPP) = "CreateMPP()"

        m_arrMenuItem(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECT_ALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECT_ALL) = "SelectAll_OnClick('frmProjectTask', 'chkActiveList')"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"

        MyBase.InitializeResources("AppResources.PM_ProjectTask", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub
    ''Added by Yogesh J on 19-Jan-2016 for to generate and validate Token	

    ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RequestShow_TaskType(TaskId As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskId, String) + CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    '<System.Web.Services.WebMethod> _
    'Public Shared Function GenrateURLToken_RequestShow_TaskType(TaskId As String, EmployeeID As String, MasterTagId As String) As String
    '    Dim m_PKToken_Request_Multiple As String
    '    m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskId, String) + CType(EmployeeID, String) + CType(MasterTagId, String) + "0" + "0")

    '    Return m_PKToken_Request_Multiple

    'End Function
    ''End of Addition by Dhanashri S on 11 Aug 2016
    ''End of addition by Yogesh J on 19-Jan-2016
    Public Sub WritePage()
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Dim strQuery As String = ""
        Dim strPageAlphabets As String = ""
        Dim strTypeChar As String = ""

        If m_strMode = MODE_LIST Then
            If m_strTaskType = "M" Then
                strTypeChar = "M"
            ElseIf m_strTaskType = "A" Then
                strTypeChar = "O"
            Else
                strTypeChar = "D"
            End If
            If m_lngEmployeeID > 0 Then
                strQuery = "Exec usp_Sel_ProjectTasks_Links '" & strTypeChar & "'," & m_lngProjectId.ToString()
                strQuery &= "," & m_lngEmployeeID.ToString()
                If Not (m_strTaskType = "M" Or m_strTaskType = "A") Then
                    strQuery &= ",'" & m_strActiveAll & "'"
                End If
            Else
                strQuery = "Exec usp_Sel_ProjectTasks_Links '" & strTypeChar & "'," & m_lngProjectId.ToString()
                If Not (m_strTaskType = "M" Or m_strTaskType = "A") Then
                    strQuery &= ",NULL, '" & m_strActiveAll & "'"
                End If
            End If
            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, "Select ", , "Links", True)
            If strPageAlphabets = "" Then m_strPageNumber = "-1"
        End If

        'Display the Menu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, strPageAlphabets)

        'Display Page Header
        If m_strMode = MODE_LIST Then
            objHeaderFooter = New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
        End If

        CommonFunctions.General.WriteHTML("<br>")
        'Display Page Caption
        If m_strMode = MODE_LIST Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        ElseIf m_strMode = MODE_TASKTYPE Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("TASKMAPPING"), , , True))
            CommonFunctions.General.WriteHTML("<br>")
        ElseIf m_strMode = MODE_NEW Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("SELECT_OTHER_TASKS"), , , True))
            CommonFunctions.General.WriteHTML("<br>")
        End If

        'Display Page Body
        If m_strMode = MODE_NEW Then
            DisplayNewTask()
        ElseIf m_strMode = MODE_TASKTYPE Then
            DisplayTaskType()
        Else
            DisplayTaskList()
        End If

        'Display Page Footer
        If m_strMode = MODE_LIST Then
            objHeaderFooter = New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
        End If

        Response.Write("<BR>")
        'Display Menu at Footer
        m_objMenu = Nothing
        m_objMenu = New WebPages.Template.StaticMenu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False)

        If m_strMode = MODE_TASKTYPE And m_strAction = OPERATION_SAVE Then
            'Added By nitinVs on 26 Mar 2007 for WhizibleSEM SP 8 regression Issue 11935 
            ' to refresh parent when called from Task Mapping 
            HttpContext.Current.Response.Write("<script language='javascript'>" + vbCrLf)
            HttpContext.Current.Response.Write(" refreshParent('frmProjectTask' ,'PM_ProjectTask','../PM/PM_ProjectTask.aspx?FromWhere=PM&MasterTagId=406&Type=" + strType + "',true);" + vbCrLf)
            HttpContext.Current.Response.Write("</script>" + vbCrLf)
            'End Addition By nitinVs on 26 Mar 2007 for WhizibleSEM SP 8 regression Issue 11935 
        End If

    End Sub

#End Region

#Region " Functions / Procedures Specific to Task List Mode "
    Private Sub DisplayTaskList()
        Dim sbHTML As New StringBuilder("")
        Dim strQuery As String = ""

        'sbHTML.Append("<br>" & MyBase.GetResourceString("SELECT_AND_MARK_TASK"))
        sbHTML.Append("<br><FONT Face = Verdana SIZE = 1>" & MyBase.GetResourceString("SELECT_AND_MARK_TASK") & "</FONT>")

        sbHTML.Append("<TABLE Class=clsTable Width='99.9%'><TR><TD align = center>")
        If m_strTaskType = "O" Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , True, "O", , "OnClick=JavaScript:optTaskSelect('O')", True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , , "O", , "OnClick=JavaScript:optTaskSelect('O')", True))
        End If
        sbHTML.Append("<FONT Face = Verdana SIZE = 1>" & MyBase.GetResourceString("GENERAL_TASKS") & "</FONT>")
        If m_strTaskType = "M" Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , True, "M", , "OnClick=JavaScript:optTaskSelect('M')", True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , , "M", , "OnClick=JavaScript:optTaskSelect('M')", True))
        End If
        sbHTML.Append("<FONT Face = Verdana SIZE = 1>" & MyBase.GetResourceString("MPP_TASKS") & "</FONT>")
        If m_strTaskType = "A" Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , True, "A", , "OnClick=JavaScript:optTaskSelect('A')", True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawOptionButton("optTask", "optTask", , , "A", , "OnClick=JavaScript:optTaskSelect('A')", True))
        End If
        sbHTML.Append("<FONT Face = Verdana SIZE = 1>" & MyBase.GetResourceString("ASSIGNED_TASKS") & "</FONT>")
        sbHTML.Append("</TD></TR></TABLE>")
        sbHTML.Append("<TABLE Class=clsTable Width='99.9%'><TR>")
        sbHTML.Append("<TD align=right>" & MyBase.GetResourceString("SELECT_RESOURCE") & "</TD>")
        sbHTML.Append("<TD align=left>")
        strQuery = "EXEC usp_Sel_teammembers " & m_lngProjectId.ToString
        If m_strTaskType.Trim().ToUpper() = "M" Or m_strTaskType.Trim().ToUpper() = "A" Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 200, m_lngEmployeeID.ToString(), "OnChange='cboEmployeeChange()'", True, True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 200, , "disabled", True, True))
        End If
        sbHTML.Append("</TD>")
        sbHTML.Append("</TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        sbHTML.Remove(0, sbHTML.Length)

        'Display the List of Tasks
        DisplayTheTaskList()

        'Palce Hidden Controls
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidActiveAll", "txthidActiveAll", , , , m_strActiveAll, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSubPage", "txthidSubPage", , , , m_intSubPage.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Private Sub DisplayTheTaskList()
        Dim intIndex As Integer = 0
        Dim strQuery As String = ""

        'Modified By VidyaJ - Performance Issue - Tasks - 86
        'Dim intTotalColumns As Integer = 21
        'Dim intColumnsToShow As Integer = 17

        Dim intTotalColumns As Integer = 18
        Dim intColumnsToShow As Integer = 17

        'Modified By VidyaJ - Performance Issue - Tasks - 86
        If m_strTaskType = "A" Then
            'intTotalColumns = 19
            ''Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            'intTotalColumns = 17 '20
            'intColumnsToShow = 16 '16
            intTotalColumns = 20 '20
            intColumnsToShow = 18 '16
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        End If

        'Integration by SavitaS on 22 Mar 2006 
        'Code Added By PradipK 9 Dec 2005
        'To Display Billable,Void & Onhold Check box for General Tasks Only.
        If m_strTaskType = "O" Then
            ''Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            'intTotalColumns = 21
            'intColumnsToShow = 17
            intTotalColumns = 24
            intColumnsToShow = 19
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        End If
        'End Addition By PradipK 9 Dec 2005
        'End Integration by SavitaS 

        'Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        If m_strTaskType = "M" Then
            intTotalColumns = 21
            intColumnsToShow = 20
        End If
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrCheckBoxId(intTotalColumns - 1) As String
        Dim arrRowLink(intTotalColumns - 1) As String
        Dim arrRowLinkTooltip(intTotalColumns - 1) As String
        Dim arrSummaryFunctions(intTotalColumns - 1) As String
        Dim arrstrTDStyle(intTotalColumns - 1) As String

        'Column groupings
        Dim strShowCurrent, strShowBaseline, strShowActual As String
        Call GetPreferenceValue(GROUP_CURRENT, strShowCurrent)
        Call GetPreferenceValue(GROUP_BASELINE, strShowBaseline)
        Call GetPreferenceValue(GROUP_ACTUAL, strShowActual)
        If strShowCurrent.Trim() = "" Then strShowCurrent = "1"
        If strShowBaseline.Trim() = "" Then strShowBaseline = "1"
        If strShowActual.Trim() = "" Then strShowActual = "1"


        'Dim arrColumnGroupColumn() As String = {"1-4", "5-8", "9-12", "13-16", "17-21"}
        'Modified By VidyaJ - Performance Issue - Tasks - 86
        Dim arrColumnGroupColumn() As String = {"1-4", "5-8", "9-12", "13-16", "17-18"}

        If m_strTaskType = "A" Then
            arrColumnGroupColumn(0) = "1-3"
            arrColumnGroupColumn(1) = "4-7"
            arrColumnGroupColumn(2) = "8-11"
            arrColumnGroupColumn(3) = "12-15"
            'arrColumnGroupColumn(4) = "16-19"
            'Modified By VidyaJ - Performance Issue - Tasks - 86
            ''Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            'arrColumnGroupColumn(4) = "16-17"
            arrColumnGroupColumn(4) = "16-17"
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        End If
        'Integrated by SavitaS on 22 Mar 2006
        '' Added By ParagD On 6-Feb-2006
        '' Purpose : Foursoft 769 - General Tasks cannot be made Billable / NonBillable at Project Level.
        '' To Display Billable & Void Check box for General Tasks Only.
        If m_strTaskType = "O" Then
            arrColumnGroupColumn(0) = "1-4"
            arrColumnGroupColumn(1) = "5-8"
            arrColumnGroupColumn(2) = "9-12"
            arrColumnGroupColumn(3) = "13-16"
            arrColumnGroupColumn(4) = "17-21"
        End If
        '' END : Added By ParagD On 6-Feb-2006
        'End Integration by SavitaS

        Dim arrColumnGroupExpanded() As String = {"1", strShowCurrent, strShowBaseline, strShowActual, "1"}
        Dim arrColumnGroupName(4) As String

        'Get Column Groups Headers
        arrColumnGroupName(0) = ""
        arrColumnGroupName(1) = MyBase.GetResourceString("CURRENT")
        arrColumnGroupName(2) = MyBase.GetResourceString("BASELINE")
        arrColumnGroupName(3) = MyBase.GetResourceString("ACTUAL")
        arrColumnGroupName(4) = ""

        'Build the Query for the Grid
        If m_strTaskType = "M" Then
            strQuery = "Exec usp_Sel_ProjectTasks 'M'," & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
            If m_lngEmployeeID > 0 Then
                strQuery &= ", " & m_lngEmployeeID.ToString()
            Else
                strQuery &= ", NULL"
            End If
            strQuery &= ", ' ORDER BY " & m_strSortBy & " " & m_strSortOrder & "'"

        ElseIf m_strTaskType = "A" Then
            strQuery = "Exec usp_Sel_ProjectTasks 'O'," & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
            If m_lngEmployeeID > 0 Then
                strQuery &= ", " & m_lngEmployeeID.ToString()
            Else
                strQuery &= ", NULL"
            End If
            strQuery &= ", ' ORDER BY " & m_strSortBy & " " & m_strSortOrder & "'"

        Else
            strQuery = "Exec usp_Sel_ProjectTasks 'D'," & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
            If m_lngEmployeeID > 0 Then
                strQuery &= ", " & m_lngEmployeeID.ToString()
            Else
                strQuery &= ", NULL"
            End If
            strQuery &= ", ' ORDER BY " & m_strSortBy & " " & m_strSortOrder
            strQuery &= "', '" & m_strActiveAll & "' "
        End If

        'Initialize the Required arrays for the advanced grid
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_NAME")
        arrActualColumns(intIndex) = "TaskName"
        arrRowLink(intIndex) = "Show_TaskType(TaskID)"
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CHANGE_MAPPING_TOOLTIP")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "style='width=250' nowrap"
        intIndex += 1

        If m_strTaskType <> "A" Then
            arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("RESOURCE")
            arrActualColumns(intIndex) = "UserName"
            arrRowLink(intIndex) = ""
            arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("RESOURCE")
            arrCheckBoxId(intIndex) = ""
            arrSummaryFunctions(intIndex) = "nowrap"
            'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
            'arrstrTDStyle(intIndex) = ""
            arrstrTDStyle(intIndex) = "style='white-space:nowrap'"
            'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15 

            intIndex += 1
        End If

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("PRIORITY")
        arrActualColumns(intIndex) = "Priority"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("PRIORITY")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_TYPE")
        arrActualColumns(intIndex) = "ModuleName"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("TASK_TYPE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap"
        intIndex += 1

        ' Details of Current
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "CurrentStart"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CURRENT") & " " & MyBase.GetResourceString("STARTDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "CurrentEnd"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CURRENT") & " " & MyBase.GetResourceString("ENDDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "CurrentDuration"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CURRENT") & " " & MyBase.GetResourceString("DURATION_DAYS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        'arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right' "
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1

        'Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        arrUserFriendlyColumn(intIndex) = "CurrentDecimalWork"
        arrActualColumns(intIndex) = "CurrentDecimalWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CURRENT") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        ' arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;display:none;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("WORK_HRS")
        arrActualColumns(intIndex) = "CurrentWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CURRENT") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        'Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        'arrSummaryFunctions(intIndex) = "SUM"
        arrSummaryFunctions(intIndex - 1) = "SUM"
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        ' arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1

        ' Details of Baseline
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "BaseLineStart"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BASELINE") & " " & MyBase.GetResourceString("STARTDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "BaseLineEnd"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BASELINE") & " " & MyBase.GetResourceString("ENDDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "BaseLineDuration"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BASELINE") & " " & MyBase.GetResourceString("DURATION_DAYS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        'arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15 

        intIndex += 1
        'Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        arrUserFriendlyColumn(intIndex) = "BaseLineDecimalWork"
        arrActualColumns(intIndex) = "BaseLineDecimalWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BASELINE") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        ' arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;display:none;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  

        intIndex += 1
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("WORK_HRS")
        arrActualColumns(intIndex) = "BaseLineWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BASELINE") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        'Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        'arrSummaryFunctions(intIndex) = "SUM"
        arrSummaryFunctions(intIndex - 1) = "SUM"
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        ' arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  

        intIndex += 1

        ' Details of Active
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("STARTDATE")
        arrActualColumns(intIndex) = "ActualStart"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTUAL") & " " & MyBase.GetResourceString("STARTDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ENDDATE")
        arrActualColumns(intIndex) = "ActualEnd"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTUAL") & " " & MyBase.GetResourceString("ENDDATE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "nowrap align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DURATION_DAYS")
        arrActualColumns(intIndex) = "ActualDuration"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTUAL") & " " & MyBase.GetResourceString("DURATION_DAYS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""

        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        ' arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1

        'Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        arrUserFriendlyColumn(intIndex) = "ActualDecimalWork"
        arrActualColumns(intIndex) = "ActualDecimalWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTUAL") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=right"
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        'arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;display:none;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("WORK_HRS")
        arrActualColumns(intIndex) = "ActualWork"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTUAL") & " " & MyBase.GetResourceString("WORK_HRS")
        arrCheckBoxId(intIndex) = ""
        'Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        'arrSummaryFunctions(intIndex) = "SUM"
        arrSummaryFunctions(intIndex - 1) = "SUM"
        'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format

        arrstrTDStyle(intIndex) = "align=right"
        'Commented and Edited by KIRAN K K For column header text alignment     on 16-11-15
        'arrstrTDStyle(intIndex) = "align=right"
        arrstrTDStyle(intIndex) = "style='white-space:nowrap;' 'align=right' 'vertical-align: bottom;'"
        'Commented and Edited End by KIRAN K K For column header text alignment on 16-11-15  
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ACTUAL_PERCENT_COMPLETE")
        arrActualColumns(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        arrstrTDStyle(intIndex) = "align=center"
        intIndex += 1

        'Modified By VidyaJ - Performance Issue - Tasks - 86
        'Now Marking the task as void,onhold and billable can be done thro' Task Status Management screen only

        'Integrated by SavitaS on 22 Mar 2006
        '' Added By ParagD On 6-Feb-2006
        '' Purpose : Foursoft 769 - General Tasks cannot be made Billable / NonBillable at Project Level.
        If m_strTaskType = "O" Then
            arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("BILLABLE")
            arrActualColumns(intIndex) = ""
            arrRowLink(intIndex) = ""
            arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BILLABLE")
            arrCheckBoxId(intIndex) = "chkBillable"
            arrSummaryFunctions(intIndex) = ""
            arrstrTDStyle(intIndex) = "align=center"
            intIndex += 1

            arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ACTIVE")
            arrActualColumns(intIndex) = ""
            arrRowLink(intIndex) = ""
            arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTIVE")
            arrCheckBoxId(intIndex) = "chkActiveList"
            arrSummaryFunctions(intIndex) = ""
            arrstrTDStyle(intIndex) = "align=center"
            intIndex += 1
        End If
        '' END : Added By ParagD On 6-Feb-2006
        'End Integration by SavitaS on 22 Mar 2006

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("BILLABLE")
        'arrActualColumns(intIndex) = ""
        'arrRowLink(intIndex) = ""
        'arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("BILLABLE")
        'arrCheckBoxId(intIndex) = "chkBillable"
        'arrSummaryFunctions(intIndex) = ""
        'arrstrTDStyle(intIndex) = "align=center"
        'intIndex += 1

        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ACTIVE")
        'arrActualColumns(intIndex) = ""
        'arrRowLink(intIndex) = ""
        'arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ACTIVE")
        'arrCheckBoxId(intIndex) = "chkActiveList"
        'arrSummaryFunctions(intIndex) = ""
        'arrstrTDStyle(intIndex) = "align=center"
        'intIndex += 1

        ''Added by DipaliS 8 Nov 2004
        ''Purpose : To add On Hold functionality 
        'arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ONHOLD")
        'arrActualColumns(intIndex) = ""
        'arrRowLink(intIndex) = ""
        'arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("ONHOLD")
        'arrCheckBoxId(intIndex) = "chkOnHold"
        'arrSummaryFunctions(intIndex) = ""
        'arrstrTDStyle(intIndex) = "align=center"
        'intIndex += 1
        ''End addition by DipaliS

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SHOW_BASELINE")
        arrActualColumns(intIndex) = MyBase.GetResourceString("SHOW_BASELINE")
        arrRowLink(intIndex) = "ShowBaseline_OnClick(TaskId)"
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("SHOW_BASELINE")
        arrCheckBoxId(intIndex) = ""
        arrSummaryFunctions(intIndex) = ""
        'arrstrTDStyle(intIndex) = "align=center"
        arrstrTDStyle(intIndex) = "align=right"
        intIndex += 1

        'Make the Id List blank
        m_strTaskIdList = ""
        'Set the Advanced Grid Properties
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrRowLink
            .RowLinkToolTipArray = arrRowLinkTooltip
            .EmptyValueReplacement = m_strNbyA
            .PrimaryKey = "TaskId"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 240
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .ClientSideSortFunctionName = "Sort_OnClick"
            'Column Groupings
            .ColumnGroupColumnsArray = arrColumnGroupColumn
            .ColumnGroupExpandedArray = arrColumnGroupExpanded
            .ColumnGroupNameArray = arrColumnGroupName
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            'Column Summary 
            .SummaryFunctions = arrSummaryFunctions
            .ShowSummaryFunctions = True
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        'Put Hidden fields to store the Column Groups expanded or not
        If m_strTaskIdList <> "" Then
            m_strTaskIdList = Left(m_strTaskIdList, m_strTaskIdList.Length - 2)
        End If
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidTaskIdList", "txthidTaskIdList", , , , m_strTaskIdList, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Private Sub UpdateTaskValue()
        Dim strQuery As String = ""
        Dim arrTaskId() As String
        Dim lngTaskId As Long
        Dim strActualPercentComplete As String
        Dim intCnt As Integer
        Dim strTaskList As String

        Dim strActualPercentCompletetemp As String

        m_strTaskIdList = MyBase.FixString(MyBase.GetFormValue("txthidTaskIdList"), 0, False, True)
        If m_strTaskIdList <> "" Then
            arrTaskId = m_strTaskIdList.Split(CType(",", Char))
            For intCnt = 0 To arrTaskId.Length - 1
                lngTaskId = CType(arrTaskId(intCnt), Long)
                strActualPercentComplete = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtActualPercentComplete_" & lngTaskId.ToString()))

                'Modified By VidyaJ - Performance Issue - Tasks - 86
                strActualPercentCompletetemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtActualPercentComplete_" & lngTaskId.ToString() & "temp"))

                'Added strActualPercentCompletetemp <> strActualPercentComplete condition
                If strActualPercentComplete <> "" And strActualPercentCompletetemp <> strActualPercentComplete Then
                    If CInt(strActualPercentComplete) = 100 Then
                        strQuery = " EXEC usp_Upd_AssignedTasks_Updation  '" & lngTaskId.ToString() & "','" & m_strTaskType & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    Else
                        strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                        '-- ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0
                        strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                        '-- End addition PurvaJ
                        strQuery &= " WHERE TaskId = " & lngTaskId.ToString()
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                        '---ADded By PurvaJ on 18 Oct 2008 WhizibleSEM 8.0 TO UPDATE CHILD TASKS ALSO.
                        strQuery = "UPDATE tbl_PM_ProjectTasks SET ActualPercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                        strQuery &= ",ResourcePercentComplete = " & FormatNumber(strActualPercentComplete, , , , TriState.False)
                        strQuery &= " WHERE ParentTask_UID = " & lngTaskId.ToString()
                        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        '--- End addition PurvaJ

                    End If

                End If
                'End Of Modifications
            Next
        End If

        'Commented and Integrated by SavitaS on 22 Mar 2006
        '' Added By ParagD On 6-Feb-2006
        '' Purpose : Foursoft 769 - General Tasks cannot be made Billable / NonBillable at Project Level.
        '' To Display Billable,Void & Onhold Check box for General Tasks Only.

        'If m_strTaskType <> "M" Then
        If m_strTaskType = "O" Then
            strTaskList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkActiveList"))
            If strTaskList = "" Then

                If m_strTaskIdList <> "" Then

                    strQuery = "UPDATE tbl_PM_ProjectTasks SET  IsActive = 1 WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
                    'Also update the Child Tasks
                    strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=0 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
                    strQuery &= ") AND ProjectId=" & m_lngProjectId.ToString()
                    'End Addition by DipaliS
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                End If
            Else
                If m_strTaskIdList <> "" Then

                    strQuery = "UPDATE tbl_PM_ProjectTasks SET  IsActive = 0  WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ") "
                    'Also update the Child Tasks
                    strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & "))"
                    strQuery &= ")  AND ProjectId=" & m_lngProjectId.ToString()

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    'End uncomment by SavitaS on 22 Mar 2006

                    'Code uncomment by SavitaS on 22 Mar 2006
                    strQuery = "UPDATE tbl_PM_ProjectTasks SET IsActive = 1 WHERE ((TaskId IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
                    strQuery &= " AND TaskID NOT IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")) "
                    'Also update the Child Tasks
                    strQuery &= " OR (TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=0 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
                    strQuery &= " AND TaskID NOT IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=0 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")))"
                    strQuery &= ")  AND IsActive=0 AND ProjectId=" & m_lngProjectId.ToString()
                    'End addition by DipaliS 

                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                    'End Of Modifications
                    'End of Code uncomment by SavitaS on 22 Mar 2006

                End If
            End If

            'Code uncomment by SavitaS on 22 Mar 2006
            strTaskList = ""
            strTaskList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkBillable"))
            'End of  'Code uncomment by SavitaS on 22 Mar 2006
            ' Modified by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12298 
            ' Removed the Active = 1 Where Condition
            ''''strQuery = "EXEC usp_Upd_PM_ProjectTaskBillable '" & CommonFunctions.General.BuildQueryString(strTaskList) & "'"
            ''''strQuery &= "," & m_lngProjectId.ToString()
            ''''strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "'"
            ''''CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            If strTaskList = "" Then
                strQuery = "UPDATE tbl_PM_ProjectTasks SET BillableYN = 0 WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
                'Also update the Child Tasks
                strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
                strQuery &= ") AND ProjectId=" & m_lngProjectId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Else
                strQuery = "UPDATE tbl_PM_ProjectTasks SET BillableYN = 1  WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ") "
                'Also update the Child Tasks
                strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & "))"
                strQuery &= ") AND ProjectId=" & m_lngProjectId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                strQuery = "UPDATE tbl_PM_ProjectTasks SET BillableYN = 0  WHERE ((TaskId IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
                strQuery &= " AND TaskID NOT IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")) "
                'Also update the Child Tasks
                strQuery &= " OR (TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
                strQuery &= " AND TaskID NOT IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE IsActive=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")))"
                strQuery &= ")  AND ProjectId=" & m_lngProjectId.ToString()
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        End If
        'End addition by DipaliS
        '' END : Added By ParagD On 6-Feb-2006
        ''''Added by DipaliS 8 Nov 2004
        ''''Purpose : To save the OnHold flag for the tasks
        '''strTaskList = ""
        '''strTaskList = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkOnHold"))

        '''If strTaskList = "" Then
        '''    strQuery = "UPDATE tbl_PM_ProjectTasks SET TaskOnHold = 0 WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
        '''    'Also update the Child Tasks
        '''    strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE TaskOnHold=1 AND ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
        '''    strQuery &= ") AND TaskOnHold=1 AND ProjectId=" & m_lngProjectId.ToString()
        '''    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        '''Else
        '''    strQuery = "UPDATE tbl_PM_ProjectTasks SET TaskOnHold = 1  WHERE (TaskId  IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ") "
        '''    'Also update the Child Tasks
        '''    strQuery &= " OR TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & "))"
        '''    strQuery &= ") AND ProjectId=" & m_lngProjectId.ToString()
        '''    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        '''    strQuery = "UPDATE tbl_PM_ProjectTasks SET TaskOnHold = 0  WHERE ((TaskId IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & ") "
        '''    strQuery &= " AND TaskID NOT IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")) "
        '''    'Also update the Child Tasks
        '''    strQuery &= " OR (TaskID IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(m_strTaskIdList) & "))"
        '''    strQuery &= " AND TaskID NOT IN (SELECT DISTINCT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID IN (" & CommonFunctions.General.BuildQueryString(strTaskList) & ")))"
        '''    strQuery &= ")  AND ProjectId=" & m_lngProjectId.ToString()
        '''    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        '''End If


        'End addition by DipaliS
    End Sub
#End Region

#Region " Functions / Procedures Specific to New Task Mode "
    Private Sub DisplayNewTask()
        Dim strQuery As String
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim intTotalColumns As Integer = 2
        Dim arrActualColumns(intTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTotalColumns - 1) As String
        Dim arrCheckBoxId(intTotalColumns - 1) As String
        Dim arrCheckboxCheckOn(intTotalColumns - 1) As String
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Initialize the Required arrays for the advanced grid
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("TASK_NAME")
        arrActualColumns(intIndex) = "TaskName"
        arrCheckBoxId(intIndex) = ""
        arrCheckboxCheckOn(intIndex) = ""
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SELECT")
        arrActualColumns(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkActiveList"
        arrCheckboxCheckOn(intIndex) = "DefaultProjectTask"
        intIndex += 1

        strQuery = "EXEC usp_sel_tbl_PM_ProjectTasks " & m_lngProjectId.ToString()
        'Set the Advanced Grid Properties
        With objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .CheckboxCheckOnColumnArray = arrCheckboxCheckOn
            .EmptyValueReplacement = ""
            .PrimaryKey = "TaskId"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns - 1
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        objGrid = Nothing
    End Sub

    Private Sub AddNewTask()
        Dim strQuery As String = ""

        m_strTaskIdList = MyBase.FixString(MyBase.GetFormValue("chkActiveList"), 0, False, True)
        If m_strTaskIdList <> "" Then
            strQuery = "EXEC usp_ins_PM_ProjectTask '" & m_strTaskIdList & "'"
            strQuery &= ", " & m_lngProjectId.ToString()
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
        ' Modified by NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 regression Issue 11967 
        ' Added code to remove the opration=Save from Query string 
        m_sbClientSideScript.Remove(0, m_sbClientSideScript.Length)
        m_sbClientSideScript.Append("if(isSubstringExists(opener.location.href,'PM_ProjectTask') == true){" & vbCrLf)
        m_sbClientSideScript.Append(" var shref = opener.location.href;" + vbCrLf)
        m_sbClientSideScript.Append("if (shref != null ) " + vbCrLf)
        m_sbClientSideScript.Append(" shref = shref.replace('&Operation=Save',''); " + vbCrLf)
        m_sbClientSideScript.Append("opener.frmProjectTask.action = shref;" & vbCrLf)

        m_sbClientSideScript.Append("opener.frmProjectTask.submit();" & vbCrLf)
        m_sbClientSideScript.Append("window.close();}" & vbCrLf)
        ' End Modified by NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 regression Issue 11967 
    End Sub
#End Region

#Region " Functions / Procedures Specific to Task Type Mode "
    Private Sub DisplayTaskType()
        Dim lngProjectTypeId As Long = 0
        Dim sbHTML As New StringBuilder("")
        Dim strQuery As String = ""
        Dim drWork As IDataReader

        Dim blnPhase_Show As Boolean = False
        Dim blnModule_Show As Boolean = False
        Dim blnSubProject_Show As Boolean = False
        Dim blnMilestone_Show As Boolean = False
        Dim blnFeature_Show As Boolean = False

        Dim blnPhase_Mandatory As Boolean = False
        Dim blnModule_Mandatory As Boolean = False
        Dim blnSubProject_Mandatory As Boolean = False
        Dim blnMilestone_Mandatory As Boolean = False
        Dim blnFeature_Mandatory As Boolean = False

        Dim strTaskName As String = ""
        Dim strPhase As String = ""
        Dim strModule As String = ""
        Dim strSubProject As String = ""
        Dim strMilestone As String = ""
        Dim lngFeatureId As Long = 0
        Dim lngDeliverableID As Long = 0

        'Project Settings details
        Dim blnApplyEffortsDistribution As Boolean = False
        Dim blnApplySubTask As Boolean = False

        'Resource assigned to the Task or not
        Dim intChildTaskCount As Integer = 0

        'Make the Client Side script variable blank
        m_sbClientSideScript.Remove(0, m_sbClientSideScript.Length)

        strQuery = "EXEC usp_Sel_tbl_PM_Project " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                lngProjectTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectTypeID"), "0"), Long)
                blnApplyEffortsDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ApplyEffortDistribution"), "False"), Boolean)
                blnApplySubTask = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("HaveSubTaskTypes"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strQuery = " EXEC usp_Sel_tbl_PRS_ProjectTypes " & lngProjectTypeId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                blnPhase_Show = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowPhaseInAT"), "False"), Boolean)
                blnModule_Show = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowModuleInAT"), "False"), Boolean)
                blnSubProject_Show = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowSubProjectInAT"), "False"), Boolean)
                blnMilestone_Show = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowMilestoneInAT"), "False"), Boolean)
                blnFeature_Show = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ShowFeatureInAT"), "False"), Boolean)

                blnPhase_Mandatory = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("PhaseMandatoryInAT"), "False"), Boolean)
                blnModule_Mandatory = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ModuleMandatoryInAT"), "False"), Boolean)
                blnSubProject_Mandatory = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("SubProjectMandatoryInAT"), "False"), Boolean)
                blnMilestone_Mandatory = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("MilestoneMandatoryInAT"), "False"), Boolean)
                blnFeature_Mandatory = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("FeatureMandatoryInAT"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        m_lngTaskId = CType(MyBase.FixString(Request.QueryString("TaskId"), 0, True, True), Long)

        strQuery = " Exec usp_Sel_tbl_PM_ProjectTasks_TaskManagement " & m_lngTaskId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strTaskName = drWork.Item("TaskName").ToString()
                'Commeted by SavitaS on 22 MAr 2006
                strTaskName = CommonFunctions.General.UnBuildQueryString(strTaskName)
                'End Comment  by SavitaS on 22 MAr 2006
                'm_strTaskType = drWork.Item("ModuleName").ToString()
                'Commented & Added By AmitJ For COmsoft IssueId 3926
                'Project Module - Task Management - Task Mapping
                'm_strTaskType = drWork.Item("TaskTypeID").ToString() & "|" & drWork.Item("ModuleName").ToString()
                m_strTaskType = drWork.Item("TaskTypeID").ToString() & "|" & drWork.Item("TaskTypeName").ToString()
                'End of Modifications
                ' Commented by MahendraV On 10:26 AM 5/30/2007 for issue ,when task is open in edit it is not display select value if '' is there
                ' Start_MV_5/30/2007
                'm_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
                ' End_MV_5/30/2007
                strPhase = drWork.Item("PhaseId").ToString() & "|" & drWork.Item("Phase").ToString()
                strPhase = CommonFunctions.General.UnBuildQueryString(strPhase)
                strModule = drWork.Item("ModuleId").ToString() & "|" & drWork.Item("Module").ToString()
                strModule = CommonFunctions.General.UnBuildQueryString(strModule)
                strSubProject = drWork.Item("SubProjectID").ToString() & "|" & drWork.Item("SubProject").ToString()
                strSubProject = CommonFunctions.General.UnBuildQueryString(strSubProject)
                strMilestone = drWork.Item("MilestoneID").ToString() & "|" & drWork.Item("Milestone").ToString()
                strMilestone = CommonFunctions.General.UnBuildQueryString(strMilestone)
                lngFeatureId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ProjectFeatureID"), "0"), Long)
                lngDeliverableID = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("DeliverableID"), "0"), Long)
                intChildTaskCount = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ChildCount"), "0"), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        'Added by SiddharthS on 2 Apr 2005 for IssueID 15675.
        Dim strTemp As String
        strTemp = Request.QueryString("optTask")
        Dim strTaskType As String
        strTaskType = Request.QueryString("txtType")
        'End addition

        'Actualy putting the controls on the page 
        'Modified by NiranjanK on Date June 08,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<DIV ID=DivList Style='HEIGHT:500px;'>")
        'End of modification by NiranjanK June 08,2006 for WhzibleSEM Issue ID.4168

        sbHTML.Append("<TABLE cellspacing=0 cellpadding=0 Class=clsTable Width='99.9%'>")

        'Modified by SiddharthS on 15 Feb 2005 for IssueID 15675.
        'Purpose :To change the mapping for general task.It will be only mapped to task type.
        If (strType = "" Or strType = "O") And (strTaskType = "" Or strTaskType = "O") Then
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD>")
            sbHTML.Append(MyBase.GetResourceString("TASK_NAME"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            sbHTML.Append(Server.HtmlEncode(strTaskName))
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            'Task Type
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD>")
            sbHTML.Append(MyBase.GetResourceString("TASK_TYPE"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            strQuery = "usp_Sel_tbl_PM_Project_TaskTypes_Names_New " & m_lngProjectId.ToString()
            If (blnApplyEffortsDistribution = True Or blnApplySubTask) And intChildTaskCount > 0 Then
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 300, m_strTaskType, "disabled", True, ReturnAsHTML:=True, IsMandatory:=True))
            Else
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 300, m_strTaskType, , True, ReturnAsHTML:=True, IsMandatory:=True))
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            ' Modified by MahendraV on 10:26 AM 5/30/2007
            'Start_MV_5/30/2007
            m_strTaskType = CommonFunctions.General.UnBuildQueryString(m_strTaskType)
            'End_MV_5/30/2007
            'Added by SiddharthS 2 Apr 2005 for IssueID 15675.
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD colspan=2>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtType", "txtType", "clsTextBox", 100, , "O", , , , , , True, , , , , , EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            'end addition

        Else
            'Task Name
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD>")
            sbHTML.Append(MyBase.GetResourceString("TASK_NAME"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            sbHTML.Append(Server.HtmlEncode(strTaskName))
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            'Task Type
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD>")
            sbHTML.Append(MyBase.GetResourceString("TASK_TYPE"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            strQuery = "usp_Sel_tbl_PM_Project_TaskTypes_Names_New " & m_lngProjectId.ToString()
            If (blnApplyEffortsDistribution = True Or blnApplySubTask) And intChildTaskCount > 0 Then
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 300, m_strTaskType, "disabled", True, ReturnAsHTML:=True, IsMandatory:=True))
            Else
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", strQuery, 300, m_strTaskType, , True, ReturnAsHTML:=True, IsMandatory:=True))
            End If
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            'Phase
            If blnPhase_Show Then
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD>")
                sbHTML.Append(MyBase.GetResourceString("PHASE"))
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD>")
                strQuery = "Exec Usp_Sel_tbl_IB_Project_Phases " & m_lngProjectId.ToString() & ",null,0,'T'"
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPhase", strQuery, 300, strPhase, , True, ReturnAsHTML:=True, IsMandatory:=blnPhase_Mandatory))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                If blnPhase_Mandatory Then
                    m_sbClientSideScript.Append("objControl = GetObjectReference('frmProjectTask', 'cboPhase');" & vbCrLf)
                    m_sbClientSideScript.Append("if (disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_PHASE") & """))" & vbCrLf)
                    m_sbClientSideScript.Append("  return;" & vbCrLf)
                End If

            End If
            'Module
            If blnModule_Show Then
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD>")
                sbHTML.Append(MyBase.GetResourceString("MODULE"))
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD>")
                ' Added By MahendraV On 3:14 PM 5/14/2007 for SubProject closure impact in Task Management 
                ' strQuery = "Exec Usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ",NULL,'T'"
                ' Start_MV_5/14/2007
                If m_lngTaskId > 0 Then
                    strQuery = "Exec Usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ",NULL,'T'," & m_lngTaskId.ToString()
                Else
                    strQuery = "Exec Usp_Sel_tbl_PM_Module " & m_lngProjectId.ToString() & ",NULL,'T',NULL"
                End If
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", strQuery, 300, strModule, , True, ReturnAsHTML:=True, IsMandatory:=blnModule_Mandatory))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")

                'Added by GokulP on 05 Jun 2009 for Checking whether Module is Baseline or not.
                Dim drModuleBaseline As IDataReader
                Dim m_strModuleBaselineSQL As String = ""
                m_strModuleBaselineSQL = "Usp_Sel_Baseline_List " & m_lngProjectId.ToString() & ",'MODULE'"
                drModuleBaseline = CommonFunctions.Data.GetDataReader(m_strModuleBaselineSQL, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drModuleBaseline) <> "" Then
                    If (drModuleBaseline.Read()) Then
                        m_strModuleBaselineIDs = CType(CommonFunctions.Data.CheckIsDBNull(drModuleBaseline.Item("BaselineIDs"), ""), String)
                        If m_strModuleBaselineIDs.Trim = "" Then
                            m_strModuleBaselineIDs = ""
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drModuleBaseline)
                'End of Addition by GokulP on 05 Jun 2009 for Checking whether Module is Baseline or not.

                If blnModule_Mandatory Then
                    m_sbClientSideScript.Append("objControl = GetObjectReference('frmProjectTask', 'cboModule');" & vbCrLf)
                    m_sbClientSideScript.Append("if (disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MODULE") & """))" & vbCrLf)
                    m_sbClientSideScript.Append("  return;" & vbCrLf)
                End If
            End If
            'Sub Project
            If blnSubProject_Show Then
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD>")
                sbHTML.Append(MyBase.GetResourceString("SUBPROJECT"))
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD>")
                ' Added By MahendraV On 12:49 PM 5/14/2007 for SubProject closure impact in Task Management 
                'strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString()
                ' Start_MV_5/14/2007
                If m_lngTaskId > 0 Then
                    strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString() & ",NULL,'C'," & m_lngTaskId.ToString()
                Else
                    strQuery = "Exec usp_Sel_tbl_PM_SubProject " & m_lngProjectId.ToString()
                End If
                ' End_MV_5/14/2007
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubProject", strQuery, 300, strSubProject, , True, ReturnAsHTML:=True, IsMandatory:=blnSubProject_Mandatory))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                If blnSubProject_Mandatory Then
                    m_sbClientSideScript.Append("objControl = GetObjectReference('frmProjectTask', 'cboSubProject');" & vbCrLf)
                    m_sbClientSideScript.Append("if (disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_SUBPROJECT") & """))" & vbCrLf)
                    m_sbClientSideScript.Append("  return;" & vbCrLf)
                End If
                'Added by GokulP on 08 Jun 2009 for Checking whether SubProject is Baseline or not.
                Dim drSubProjectBaseline As IDataReader
                Dim m_strSubProjectBaselineSQL As String = ""
                m_strSubProjectBaselineSQL = "Usp_Sel_Baseline_List " & m_lngProjectId.ToString() & ",'SUBPROJECT'"
                drSubProjectBaseline = CommonFunctions.Data.GetDataReader(m_strSubProjectBaselineSQL, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drSubProjectBaseline) <> "" Then
                    If (drSubProjectBaseline.Read()) Then
                        m_strSubProjectBaselineIDs = CType(CommonFunctions.Data.CheckIsDBNull(drSubProjectBaseline.Item("BaselineIDs"), ""), String)
                        If m_strSubProjectBaselineIDs.Trim = "" Then
                            m_strSubProjectBaselineIDs = ""
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drSubProjectBaseline)
                'End of Addition by GokulP on 08 Jun 2009 for Checking whether SubProject is Baseline or not.

            End If
            'Milestone
            If blnMilestone_Show Then
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD>")
                sbHTML.Append(MyBase.GetResourceString("MILESTONE"))
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD>")

                ' Added By MahendraV On 5:51 PM 5/15/2007 for MileStone closure impact in Task Management 
                ' strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString()
                ' Start_MV_5/15/2007
                If m_lngTaskId > 0 Then
                    strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString() & ",'C'," & m_lngTaskId.ToString()
                Else
                    strQuery = "Exec usp_Sel_tbl_PM_Milestones " & m_lngProjectId.ToString()
                End If
                ' End_MV_5/15/2007

                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboMilestone", strQuery, 300, strMilestone, , True, ReturnAsHTML:=True, IsMandatory:=blnMilestone_Mandatory))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                If blnMilestone_Mandatory Then
                    m_sbClientSideScript.Append("objControl = GetObjectReference('frmProjectTask', 'cboMilestone');" & vbCrLf)
                    m_sbClientSideScript.Append("if (disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_MILESTONE") & """))" & vbCrLf)
                    m_sbClientSideScript.Append("  return;" & vbCrLf)
                End If

                'Added by GokulP on 08 Jun 2009 for Checking whether SubProject is Baseline or not.
                Dim drMilestoneBaseline As IDataReader
                Dim m_strMilestoneBaselineSQL As String = ""
                m_strMilestoneBaselineSQL = "Usp_Sel_Baseline_List " & m_lngProjectId.ToString() & ",'MILESTONE'"
                drMilestoneBaseline = CommonFunctions.Data.GetDataReader(m_strMilestoneBaselineSQL, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drMilestoneBaseline) <> "" Then
                    If (drMilestoneBaseline.Read()) Then
                        m_strMilestoneBaselineIDs = CType(CommonFunctions.Data.CheckIsDBNull(drMilestoneBaseline.Item("BaselineIDs"), ""), String)
                        If m_strMilestoneBaselineIDs.Trim = "" Then
                            m_strMilestoneBaselineIDs = ""
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drMilestoneBaseline)
                'End of Addition by GokulP on 08 Jun 2009 for Checking whether Milestone is Baseline or not.

            End If
            'Project Feature
            If blnFeature_Show Then
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD>")
                sbHTML.Append(MyBase.GetResourceString("FEATURE"))
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD>")
                strQuery = "Exec usp_Sel_tbl_PM_Project_Features NULL, " & m_lngProjectId.ToString()
                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeature", strQuery, 300, lngFeatureId.ToString(), , True, ReturnAsHTML:=True, IsMandatory:=blnFeature_Mandatory))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                If blnFeature_Mandatory Then
                    m_sbClientSideScript.Append("objControl = GetObjectReference('frmProjectTask', 'cboFeature');" & vbCrLf)
                    m_sbClientSideScript.Append("if (disallowBlank(objControl, """ & MyBase.GetResourceString("SELECT_FEATURE") & """))" & vbCrLf)
                    m_sbClientSideScript.Append("  return;" & vbCrLf)
                End If
            End If

            'Deliverable
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD>")
            sbHTML.Append(MyBase.GetResourceString("DELIVERABLE"))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            strQuery = "Exec usp_Sel_tbl_PM_OtherSchedules_FillCombo " & m_lngProjectId.ToString()
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable", strQuery, 300, lngDeliverableID.ToString(), , True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            'Added by GokulP on 08 Jun 2009 for Checking whether Deliverable is Baseline or not.
            Dim drDeliverableBaseline As IDataReader
            Dim m_strDeliverableBaselineSQL As String = ""
            m_strDeliverableBaselineSQL = "Usp_Sel_Baseline_List " & m_lngProjectId.ToString() & ",'DELIVERABLE'"
            drDeliverableBaseline = CommonFunctions.Data.GetDataReader(m_strDeliverableBaselineSQL, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drDeliverableBaseline) <> "" Then
                If (drDeliverableBaseline.Read()) Then
                    m_strDeliverableBaselineIDs = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableBaseline.Item("BaselineIDs"), ""), String)
                    If m_strDeliverableBaselineIDs.Trim = "" Then
                        m_strDeliverableBaselineIDs = ""
                    End If
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drDeliverableBaseline)
            'End of Addition by GokulP on 08 Jun 2009 for Checking whether Deliverable is Baseline or not.

            'SiddharthS 2 Apr 2005 for IssueID 15675.
            sbHTML.Append("<TR class='clsTREven'>")
            sbHTML.Append("<TD colspan=2>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtType", "txtType", "clsTextBox", 100, , "A", , , , , , True, , , , , , EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")
            'End addition

        End If
        'Modification ends SiddharthS.15 Feb 2005

        sbHTML.Append("</TABLE>")
        sbHTML.Append("</DIV>")
        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
        'Put Hidden Control
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("Caller", "Caller", , , , m_strCaller, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub

    Private Sub UpdateTaskTypeValue()
        Dim strQuery As String = ""
        Dim strPhase As String = ""
        Dim strModule As String = ""
        Dim strSubProject As String = ""
        Dim strMilestone As String = ""

        Dim strTaskTypeId As String = "NULL"
        Dim strPhaseId As String = "NULL"
        Dim strModuleId As String = "NULL"
        Dim strSubProjectId As String = "NULL"
        Dim strMilestoneId As String = "NULL"
        Dim strFeatureId As String = "NULL"
        Dim strDeliverableId As String = "NULL"
        'Modified By nitinVS on 23 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12275
        ' To Update DevliverableTypeID along with DeliverableID 
        Dim strDeliverableTypeID As String = "NULL"

        m_lngTaskId = CType(MyBase.FixString(Request.QueryString("TaskId"), 0, True, True), Long)
        m_strTaskType = MyBase.FixString(MyBase.GetFormValue("cboTaskType"), 0, False, True)
        strPhase = MyBase.FixString(MyBase.GetFormValue("cboPhase") & "", 0, False, False)
        strModule = MyBase.FixString(MyBase.GetFormValue("cboModule") & "", 0, False, False)
        strSubProject = MyBase.FixString(MyBase.GetFormValue("cboSubProject") & "", 0, False, False)
        strMilestone = MyBase.FixString(MyBase.GetFormValue("cboMilestone") & "", 0, False, False)
        strFeatureId = MyBase.FixString(MyBase.GetFormValue("cboFeature") & "", 0, True, False)
        If strFeatureId.Trim() = "" Then strFeatureId = "NULL"
        strDeliverableId = MyBase.FixString(MyBase.GetFormValue("cboDeliverable") & "", 0, True, False)
        If strDeliverableId.Trim() = "" Then
            strDeliverableId = "NULL"
        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strDeliverableTypeID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ScheduleTypeID FROM tbl_PM_OtherSchedules WHERE ScheduleID = " + strDeliverableId, MyBase.UseSQL), "0"), String)
            strDeliverableTypeID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_ScheduleTypeID " + strDeliverableId, MyBase.UseSQL), "0"), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If

        'Get the ID and the Value for SubTaskType
        If m_strTaskType <> "" Then
            strTaskTypeId = Left(m_strTaskType, InStr(m_strTaskType, "|") - 1)
            m_strTaskType = Mid(m_strTaskType, InStr(m_strTaskType, "|") + 1)
            m_strTaskType = Chr(39) & m_strTaskType & Chr(39)
        Else
            m_strTaskType = "NULL"
        End If
        'Get the ID and the Value for Phase
        If strPhase <> "" Then
            strPhaseId = Left(strPhase, InStr(strPhase, "|") - 1)
            strPhase = Mid(strPhase, InStr(strPhase, "|") + 1)
            strPhase = Chr(39) & strPhase & Chr(39)
        Else
            strPhase = "NULL"
        End If
        'Get the ID and the Value for module
        If strModule <> "" Then
            strModuleId = Left(strModule, InStr(strModule, "|") - 1)
            strModule = Mid(strModule, InStr(strModule, "|") + 1)
            strModule = Chr(39) & strModule & Chr(39)
        Else
            strModule = "NULL"
        End If

        'Get the ID and the Value for Sub Project
        If strSubProject <> "" Then
            strSubProjectId = Left(strSubProject, InStr(strSubProject, "|") - 1)
            strSubProject = Mid(strSubProject, InStr(strSubProject, "|") + 1)
            strSubProject = Chr(39) & strSubProject & Chr(39)
        Else
            strSubProject = "NULL"
        End If

        'Get the ID and the Value for Milestone
        If strMilestone <> "" Then
            strMilestoneId = Left(strMilestone, InStr(strMilestone, "|") - 1)
            strMilestone = Mid(strMilestone, InStr(strMilestone, "|") + 1)
            strMilestone = Chr(39) & strMilestone & Chr(39)
        Else
            strMilestone = "NULL"
        End If

        'Update the Module name for the selected task
        strQuery = "UPDATE tbl_PM_ProjectTasks SET "
        strQuery &= "	TaskTypeID = " & strTaskTypeId & ", ModuleName = " & m_strTaskType & ","
        strQuery &= "	PhaseID = " & strPhaseId & ",Phase = " & strPhase & ","
        strQuery &= "	ModuleID = " & strModuleId & ",Module = " & strModule & ","
        strQuery &= "	SubProjectID = " & strSubProjectId & ", SubProject = " & strSubProject & ","
        strQuery &= "	MilestoneID = " & strMilestoneId & ", Milestone = " & strMilestone & ","
        strQuery &= "	ProjectFeatureID = " & strFeatureId & ","
        strQuery &= "	DeliverableID = " & strDeliverableId
        strQuery &= "	, DeliverableTypeID = " & strDeliverableTypeID
        'Modified Code by VidyaJ - for issueid - 313 - SP4
        'strQuery &= " WHERE	IsActive=1 AND (TaskID = " & m_lngTaskId.ToString()
        strQuery &= " WHERE	 (TaskID = " & m_lngTaskId.ToString()
        strQuery &= " OR ParentTask_UID = " & m_lngTaskId.ToString() & ")"
        ' End Moficication By NitinVS on 23 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12275

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        m_sbClientSideScript.Remove(0, m_sbClientSideScript.Length)
        If m_strCaller = "TASK_MAPPING" Then
            'm_sbClientSideScript.Append("opener.frmTaskDetails.action = ""TaskDetails.asp""" & vbCrLf)
            'm_sbClientSideScript.Append("opener.frmTaskDetails.submit();" & vbCrLf)
        End If

    End Sub

#End Region

#Region " Objects Event Handlers "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strMode = MODE_LIST Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Then Cancel = True
            If Args.LinkName = m_arrMenuItem(MenuIndex.SELECT_ALL) Then Cancel = True
            'If Args.LinkName = m_arrMenuItem(MenuIndex.TASK_MAPPING) Then Cancel = True
            If Args.LinkName = m_arrMenuItem(MenuIndex.CREATE_MPP) Then Cancel = True
            If m_objAccessRights.Edit = False Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
            End If
            If Not (m_objAccessRights.Add = True And m_strTaskType = "O") Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.SELECT_MORE) Then Cancel = True
                'Modified & Commented By VarunA on 24-June-2009 RequestID-21197
                'Purpose : To have the link in view access mode also.
                'If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ACTIVE_TASKS) Then Cancel = True
                'If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ALL_TASKS) Then Cancel = True
                'Else
                '    If m_strActiveAll = ACTIVEALL_ACTIVE Then
                '        If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ACTIVE_TASKS) Then Cancel = True
                '    Else
                '        If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ALL_TASKS) Then Cancel = True
                '    End If
            End If
            If m_strTaskType = "O" Then
                If m_strActiveAll = ACTIVEALL_ACTIVE Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ACTIVE_TASKS) Then Cancel = True
                Else
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ALL_TASKS) Then Cancel = True
                End If
            Else
                If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ACTIVE_TASKS) Then Cancel = True
                If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_ALL_TASKS) Then Cancel = True
            End If

            'End By VarunA on 24-June-2009 RequestID-21197
        ElseIf m_strMode = MODE_TASKTYPE Then
            If Not (Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE)) Then
                Cancel = True
            End If

            'Modified By nitinVS on 3 Apr 2007 for WhizibleSEM SP 8 regression issue 11944 
            ' Not to save when user is not having edit access Changed the And To Or 
            'Code Added
            'Added by   :   DipaliS
            'Date       :   30 Sep 2004
            'Purpose    :   To show the Save link only if User has Add or Edit Access Set 
            If (m_objAccessRights.Edit = False) Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
            End If
            'End Addition by DipaliS

        ElseIf m_strMode = MODE_NEW Then
            If Not (Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                    Args.LinkName = m_arrMenuItem(MenuIndex.SELECT_ALL) Or _
                    Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Or _
                    Args.LinkName = m_arrMenuItem(MenuIndex.HELP)) Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objGrid.SummaryFunctionsTD_BeforePrint
        If m_blnTotalPrinted = False Then
            Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("TOTAL") & "</td>"
            Cancel = True
            m_blnTotalPrinted = True
        End If
        ''Added By Usha Pandit On 08.07.2020 To show work hour total in HH:MM format
        If Args.ColumnName = "CurrentDecimalWork" Then
            Dim strWork As String = Args.SummaryValue
            Args.StringToBeInserted = "<td align='left'>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWork + "',1)", True) & "</td>"
            Cancel = True
        End If
        If Args.ColumnName = "BaseLineDecimalWork" Then
            Dim strWork As String = Args.SummaryValue
            Args.StringToBeInserted = "<td align='left'>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWork + "',1)", True) & "</td>"
            Cancel = True
        End If
        If Args.ColumnName = "ActualDecimalWork" Then
            Dim strWork As String = Args.SummaryValue
            Args.StringToBeInserted = "<td align='left'>" & CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strWork + "',1)", True) & "</td>"
            Cancel = True
        End If
        ''End Of Added By Usha Pandit On 08.07.2020 To show work hour total in HH:MM format
        If m_strTaskType = "A" Then
            ''Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            If Args.ColIndex = 10 Then Cancel = True
            If Args.ColIndex = 14 Then Cancel = True
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        ElseIf m_strTaskType = "M" Then
            ''Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            If Args.ColIndex = 10 Then Cancel = True
            If Args.ColIndex = 14 Then Cancel = True
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        Else
            ''Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            If Args.ColIndex = 10 Then Cancel = True
            If Args.ColIndex = 14 Then Cancel = True
            ''End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            If Args.ColIndex = 16 Then Cancel = True
            If Args.ColIndex = 19 Then Cancel = True
        End If
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        'Added by NitinC on 09 June 2011 for WhizibleSEM v10.0 for Agile Methodology
        If Args.DataField.ToUpper = "TASKNAME" Then
            If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                Cancel = True
                Args.StringToBeInserted += "<TD  vAlign=top style='width=250' nowrap title=""Task Name"">"
                Args.StringToBeInserted += "<IMG src=""../../Images/Scrum/UserStory.gif""> <a href=""javascript:Show_TaskType('" + Args.DataReader("TaskID").ToString + "')"">" + Args.DataReader("TaskName") + "</a>"
                Args.StringToBeInserted += "</td>"
            End If
        End If
        'End - Added by NitinC on 09 June 2011 for WhizibleSEM v10.0 for Agile Methodology

        If Trim(Args.CheckBoxId & "") = "chkBillable" Then
            If m_objAccessRights.Edit = True Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("BillableYN"), "False"), Boolean) = True Then
                    Args.IsCheckBoxChecked = True
                End If
            Else
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("BillableYN"), "False"), Boolean) = True Then
                    Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("YES") & "</td>"
                Else
                    Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("NO") & "</td>"
                End If
                Cancel = True
            End If
        ElseIf Trim(Args.CheckBoxId & "") = "chkActiveList" Then
            If m_objAccessRights.Edit = True Then
                If m_strTaskType.Trim() = "M" Then
                    Args.StringToBeInserted = "<td>" & m_strNbyA & "</td>"
                    Cancel = True
                Else
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsActive"), "False"), Boolean) = False Then
                        ' Modified By nitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11925 
                        '' reset the checked =true for General Tasks  
                        ''Code Commented by DipaliS 6 Nov 2004
                        ''Purpose : IssueID 13568
                        ''Args.IsCheckBoxChecked = True
                        ''Code Added by DipaliS 6 Nov 2004
                        ''Purpose : IssueID 13568
                        'Args.IsCheckBoxChecked = False
                        ''End addition by DipaliS

                        Args.IsCheckBoxChecked = True

                        ' End Modification By  nitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11925 

                    End If
                End If
            Else
                If m_strTaskType.Trim() = "M" Then
                    Args.StringToBeInserted = "<td>" & m_strNbyA & "</td>"
                Else
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsActive"), "False"), Boolean) = True Then
                        Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("YES") & "</td>"
                    Else
                        Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("NO") & "</td>"
                    End If
                End If
                Cancel = True
            End If
            'Code Added by DipaliS 8 Nov 2004
        ElseIf Trim(Args.CheckBoxId & "").ToUpper = "CHKONHOLD" Then
            If m_objAccessRights.Edit = True Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskOnHold"), "False"), Boolean) = True Then
                    Args.IsCheckBoxChecked = True
                End If
            Else
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskOnHold"), "False"), Boolean) = True Then
                    Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("YES") & "</td>"
                Else
                    Args.StringToBeInserted = "<td>" & MyBase.GetResourceString("NO") & "</td>"
                End If
                Cancel = True
            End If
            'End addition by DipaliS
        End If

        If m_strTaskType = "A" Then
            ''Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            'If Args.ColIndex = 15 Then
            '    Dim strTemp As String = ""
            '    Dim strName As String = ""
            '    Dim lngTaskId As Long = 0
            '    Dim strValue As String

            '    strTemp &= "<td align='center'>"
            '    lngTaskId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= CommonFunctions.HTMLControls.DrawTextBox("txthidTaskId", "txthidTaskId", , , , lngTaskId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strName = "txtActualPercentComplete_" & lngTaskId.ToString()
            '    strValue = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "").ToString()
            '    If strValue.Trim() = "" Then
            '        strValue = "0.00"
            '    Else
            '        strValue = FormatNumber(strValue, 2, , , TriState.False)
            '    End If

            '    'Modified By VidyaJ - Performance Issue - Task - IssueID - 86
            '    'Plot a temp textbox to store ActualPercentcomplete value and use this to check if this value is changed


            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName & "temp", "txtActualPercentComplete", , 45, 6, strValue, "Right", , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean), ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, DisplayNone:=True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    'End Of Modifications
            '    '---- Modified by purvaj on 25 Nov 2008 for whiziblesem8.0 Actual % Complete can be now updated through Task status management only.
            '    '---- Actual % complete is disabled here.
            '    '---- IsDisabled:=True added
            '    '---Removed : CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean)
            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName, "txtActualPercentComplete", , 45, 6, strValue, "Right", , True, ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    '--- End Modification purvaj
            '    strTemp &= "</td>"
            '    Args.StringToBeInserted = strTemp
            '    Cancel = True
            'End If
            If Args.ColIndex = 18 Then
                Dim strTemp As String = ""
                Dim strName As String = ""
                Dim lngTaskId As Long = 0
                Dim strValue As String

                strTemp &= "<td align='center'>"
                lngTaskId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= CommonFunctions.HTMLControls.DrawTextBox("txthidTaskId", "txthidTaskId", , , , lngTaskId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strName = "txtActualPercentComplete_" & lngTaskId.ToString()
                strValue = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "").ToString()
                If strValue.Trim() = "" Then
                    strValue = "0.00"
                Else
                    strValue = FormatNumber(strValue, 2, , , TriState.False)
                End If

                'Modified By VidyaJ - Performance Issue - Task - IssueID - 86
                'Plot a temp textbox to store ActualPercentcomplete value and use this to check if this value is changed


                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName & "temp", "txtActualPercentComplete", , 45, 6, strValue, "Right", , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean), ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, DisplayNone:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'End Of Modifications
                '---- Modified by purvaj on 25 Nov 2008 for whiziblesem8.0 Actual % Complete can be now updated through Task status management only.
                '---- Actual % complete is disabled here.
                '---- IsDisabled:=True added
                '---Removed : CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean)
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName, "txtActualPercentComplete", , 45, 6, strValue, "Right", , True, ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                '--- End Modification purvaj
                strTemp &= "</td>"
                Args.StringToBeInserted = strTemp
                Cancel = True
            End If
            'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        ElseIf m_strTaskType = "M" Then
            ''Commented And Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
            'If Args.ColIndex = 16 Then
            '    Dim strTemp As String = ""
            '    Dim strName As String = ""
            '    Dim lngTaskId As Long = 0
            '    Dim strValue As String

            '    strTemp &= "<td align='center'>"
            '    lngTaskId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= CommonFunctions.HTMLControls.DrawTextBox("txthidTaskId", "txthidTaskId", , , , lngTaskId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strName = "txtActualPercentComplete_" & lngTaskId.ToString()
            '    strValue = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "").ToString()
            '    If strValue.Trim() = "" Then
            '        strValue = "0.00"
            '    Else
            '        strValue = FormatNumber(strValue, 2, , , TriState.False)
            '    End If
            '    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName, "txtActualPercentComplete", , 45, 6, strValue, "Right", , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean), ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
            '    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            '    strTemp &= "</td>"
            '    Args.StringToBeInserted = strTemp
            '    Cancel = True
            'End If
            If Args.ColIndex = 19 Then
                Dim strTemp As String = ""
                Dim strName As String = ""
                Dim lngTaskId As Long = 0
                Dim strValue As String

                strTemp &= "<td align='center'>"
                lngTaskId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= CommonFunctions.HTMLControls.DrawTextBox("txthidTaskId", "txthidTaskId", , , , lngTaskId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strName = "txtActualPercentComplete_" & lngTaskId.ToString()
                strValue = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualPercentComplete"), "").ToString()
                If strValue.Trim() = "" Then
                    strValue = "0.00"
                Else
                    strValue = FormatNumber(strValue, 2, , , TriState.False)
                End If
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= CommonFunctions.HTMLControls.DrawTextBox(strName, "txtActualPercentComplete", , 45, 6, strValue, "Right", , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsTaskComplete"), "False"), Boolean), ToBeInserted:="onblur='javascript:txtActualPercentComplete_onblur(this)'", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strTemp &= "</td>"
                Args.StringToBeInserted = strTemp
                Cancel = True
            End If
            'End Of Added By Usha Pandit On 18.07.2019 For showing work hours in H:M format
        Else
            If Args.ColIndex = 16 Then Cancel = True
            'Commneted and Integrated by SavitaS on 22 Mar 2006
            'If Args.ColIndex = 20 Then Cancel = True 
            '' Added By ParagD On 6-Feb-2006
            '' Purpose : Foursoft 769 - General Tasks cannot be made Billable / NonBillable at Project Level.
            '' To hide Actual % Complete & Show Baseline Column for GeneraL Tasks.
            If Args.ColIndex = 19 Then Cancel = True
            '' End Addition By ParagD On 6-Feb-2006
            'End Integration by SavitaS on 22 Mar 2006
            'Modified By VidyaJ - Performance Issue - Tasks - 86
            'If Args.ColIndex = 17 Then Cancel = True 'Commeted by SavitaS on 22 Mar 2006

        End If
    End Sub

    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint
        If m_strTaskType = "A" Then
            If Args.ColIndex = 15 Then Args.ApplySorting = False
        ElseIf m_strTaskType = "M" Then
            If Args.ColIndex = 16 Then Args.ApplySorting = False
        Else
            If Args.ColIndex = 16 Then Cancel = True
            'Commneted and Integrated by SavitaS on 22 Mar 2006
            'If Args.ColIndex = 20 Then Cancel = True 
            'Integrated by SavitaS on 22 Mar 2006
            'Added By ParagD On 6-Feb-2006.
            If Args.ColIndex = 19 Then Cancel = True
            '' END : Added By ParagD On 6-Feb-2006.
            'End Integration by SavitaS on 22 Mar 2006
            'Modified By VidyaJ - Performance Issue - Tasks - 86
            'If Args.ColIndex = 17 Then Cancel = True 'savita
        End If
    End Sub

    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        m_strTaskIdList = m_strTaskIdList & Args.DataReader.Item("TaskId").ToString() & ", "
        
    End Sub
#End Region

#Region " Procedures For User Prefrences "
    Private Sub SavePreferences()
        Dim strQuery As String
        Dim strGroup As String
        Dim strShow As String
        Dim strPref_For As String

        strGroup = MyBase.FixString(Request.QueryString("Group"), 10, False, True)
        strShow = MyBase.FixString(Request.QueryString("Show"), 1, False, False)
        If strShow.Trim() = "" Then strShow = "0"

        If m_strTaskType = "M" Then
            strPref_For = TASKTYPE_MPP
        ElseIf m_strTaskType = "A" Then
            strPref_For = TASKTYPE_ASSIGNED
        Else
            strPref_For = TASKTYPE_GENERAL
        End If
        strPref_For &= strGroup

        strQuery = "Exec usp_Upd_tbl_PM_UserPreferences " & m_lngLogingId.ToString()
        strQuery &= ", " & m_lngTagId.ToString()
        strQuery &= ", '" & strPref_For & "'"
        strQuery &= "," & strShow

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub GetPreferenceValue(ByVal strGroup As String, ByRef strValue As String)
        Dim drWork As IDataReader
        Dim strQuery As String
        Dim strPref_For As String
        Dim blnShow As Boolean

        strValue = "0"

        If m_strTaskType = "M" Then
            strPref_For = TASKTYPE_MPP
        ElseIf m_strTaskType = "A" Then
            strPref_For = TASKTYPE_ASSIGNED
        Else
            strPref_For = TASKTYPE_GENERAL
        End If
        strPref_For &= strGroup
        strQuery = "Exec usp_Sel_tbl_PM_UserPreferences " & m_lngLogingId.ToString()
        strQuery &= ", " & m_lngTagId.ToString()
        strQuery &= ", '" & strPref_For & "'"

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If (drWork.Read()) Then
                blnShow = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Show"), "False"), Boolean)
                If blnShow = True Then
                    strValue = "1"
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_CommitTransaction(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.CommitTransaction

    End Sub
    'Added by HarshK for sp4 issueID 272 on 16/09/2005 (Filter prefrence)
    Private Sub SetFilterPerfrence()

        Dim strSqlQuery As String, strLoginType As String, strUserID As String, strTagID As String
        Dim strEmployeeID As String
        strLoginType = CType(IIf(Session("LoginType") Is Nothing, "E", Session("LoginType")), String)
        strUserID = CType(Session("intUserID"), String)
        strTagID = "406"

        If Page.IsPostBack Then
            Dim strFixedValueForEmployee As String, strFixedValueForTaskType As String

            '------------------------------------
            strEmployeeID = CommonFunctions.General.CheckIsNothing(Request("cboEmployee"), "0")
            m_lngEmployeeID = CType(IIf(strEmployeeID = "", "0", strEmployeeID), Long)
            m_strTaskType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optTask"), "O")
            '------------------------------------
            strFixedValueForEmployee = CType(IIf(CType(m_lngEmployeeID, String) = "", "Null", "'" & CType(m_lngEmployeeID, String) & "'"), String)
            strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'EmployeeID',null,'F'," & strFixedValueForEmployee
            CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)

            strFixedValueForTaskType = CType(IIf(m_strTaskType = "", "Null", "'" & m_strTaskType & "'"), String)
            strSqlQuery = "Exec usp_Ins_tbl_UI_EmployeeFilterSettings_FieldDetails '" & strLoginType & "'," & strUserID & "," & strTagID & ",null,'TaskType',null,'F'," & strFixedValueForTaskType
            CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, MyBase.UseSQL)
            '------------------------------------
            m_strType = m_strTaskType
        Else
            strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'EmployeeID'"
            strEmployeeID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "0"))
            m_lngEmployeeID = CType(IIf(strEmployeeID = "", "0", strEmployeeID), Long)
            'resetting the filter value so that if resource is not on project then apply default filter

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSqlQuery = "SELECT EmployeeID FROM Tbl_PM_ProjectEmployeeRole WHERE ProjectID = " & CStr(Session("intProjectID")) & " AND EmployeeID = " & CStr(m_lngEmployeeID)
            ''Commented And Added By Usha Pandit On 07.01.2020 For crash if project is not in session
            'strSqlQuery = "usp_sel_Tbl_PM_ProjectEmployeeRole_ProjectWiseEmployeeID " & CStr(Session("intProjectID")) & "," & CStr(m_lngEmployeeID)
            strSqlQuery = "usp_sel_Tbl_PM_ProjectEmployeeRole_ProjectWiseEmployeeID " & CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0") & "," & CStr(m_lngEmployeeID)
            ''End Of Added By Usha Pandit On 07.01.2020 For crash if project is not in session
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            m_lngEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "0"), Long)
            m_lngEmployeeID = CLng(CommonFunctions.General.CheckIsNothing(m_lngEmployeeID, "0"))

            strSqlQuery = "usp_Sel_tbl_UI_EmployeeFilterSettings_FieldDetails_ForCustomPage  '" & strLoginType & "'," & strUserID & "," & strTagID & ",'TaskType'"
            m_strTaskType = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, MyBase.UseSQL), "O"), String)
            If m_strTaskType Is Nothing Then m_strTaskType = "O"
            m_strType = m_strTaskType

        End If

    End Sub
    'End Added by HarshK for sp4 issueID 272 on 16/09/2005 (Filter prefrence)
End Class
