Public Class DeveloperDB
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : DeveloperDB
    ' Purpose               : Creates the Developers Dashboard
    ' Description           : Same as above
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Feb 4th, 2004
    ' Revisions             : 
    '=====================================================================

    '=====================================================================
    ' The SESSION VARIABLES set on this page.
    '=====================================================================
    ' DB_ProjectFilter	:-	Flag indicating whether the Filter for the selected project must be set.
    '						1 : Set the Project Filter.
    '						0 : Show All the Projects.
    ' DB_ListNumber		:-	Stores the currently active list number.
    ' DB_TodoListFilter	:-	Stores the currently selected filter for the To do list.
    ' DB_FromDate		:-	Stores the From Date if the Date Range filter is applicable.
    ' DB_ToDate			:-	Stores the To Date if the Date Range filter is applicable.
    '=====================================================================	

    '=====================================================================
    ' The QUERY STRING Parameters for this page.
    '=====================================================================
    ' List			:-	The Active List Number.
    '					1 : The To do List.
    '					2 : The Issue List.
    '					3 : The CRM Query List.
    '					4 : The Project List.
    ' Field			:-	The Field by which the active list must be sorted.
    ' Order			:-	The Sort Order.
    ' ProjectFilter	:-	Flag indicating that the filter for the currently 
    '					selected project must be applied.
    '					1 : The filter must be applied.
    '					0 : The filter must be removed.
    ' Mode			:-	Mode.
    '					"PerformanceGraph" : Show "My Performance" Graph.
    '					"TaskDistribution" : Show "Task Distribution" Graph.
    ' FromWhere		:-	Used for the Graphs.
    '					"PM" : Request from PM Dashboard.
    '					"DB" : Request from Developer Dashboard.
    ' ShowGraph		:-	Flag indicating that the selected Graph must be show.
    '					1 : Show Graph.
    '					All other cases : Show Dashboard.
    ' TodoListFilter:-	Flag to store the selected To do list filter.
    ' FromDate		:-	Store the From date, in case the Date Range option has been selected.
    ' ToDate		:-	Store the To date, in case the Date Range option has been selected.
    '=====================================================================	

    Private m_blnUseSQL, m_blnSetProjectFilter As Boolean
    Private m_strTaskListFilter, m_strListName As String
    Private m_blnShowWeeklyView, m_blnShowTaskTypeTimesheet As Boolean
    Private m_strPageCaption As String
    Private m_strSortByField, m_strAscOrDesc As String
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strNotSpecified As String

    Private Const TAB_TO_DO_LIST As Integer = 1
    Private Const TAB_ISSUES As Integer = 2
    Private Const TAB_REVIEWS As Integer = 8
    Private Const TAB_PROJECTS As Integer = 4
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objGrid As New WebPage.Templates.AdvancedGrid
    ' Added By NitinVS on 15 Dec 2004 
    ' To make a task red if it is critical
'integrated by harshada d for whiziblesem issue id 989
      '==================================================================================================================================
    'Added By ManishK on 15th Nov 2005 for Developer Dashboard Functionality  of number of documents attached to the task
    '==================================================================================================================================
    'Private m_arrstrToolTipForGrid() As String = {"style='width=0%'", "style='width=1%' Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}
    'Private m_arrstrToolTipForGrid() As String = {"style='width=0%'", "style='width:5px;' Title='Document'", "style='width=10px' Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=1%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}
    Private m_arrstrToolTipForGrid() As String = {"style='width=0%'", "style='width=0%'", "style='width=1%' Title='Document'", "{}Title='[TaskNotes]' style='width=50%'", "style='width:20%' nowrap", " style='width:1%'", "style='width:1%'", "style='width:1%'", " style='width:1%'", "style='width:1%'", "style='width:1%'", "style='width=20%' align=right nowrap Title='Variance (hrs)' "}
    '==================================================================================================================================
    'End of Modified By ManishK on 15th Nov 2005 for developer Dashboard Functionality  of number of documents attached to the task
    '==================================================================================================================================
'end of integration by harshada d for whiziblesem issue id 989 
    '***** Modiifed by SandipL on 31 Jan 2006 for WhizibleSEM_Whiz2 SP6-- to solve problem of Page Crash in case of critical Issue 
    'Private m_arrstrRedToolTipForGrid() As String = {"style='width=0%;color:red;'", "style='width=1%;color:red;' Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%;color:red;'", "style='width=10%;color:red;'", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap style='color:red;'", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap Title='Variance (hrs)' style='color:red;'"}
    'Modified By JyotiG (29-Aug-2006)
    'Issue Id : 5808
    'Start
    'Private m_arrstrRedToolTipForGrid() As String = {"style='width=0%;color:red;'", "style='width=1%;color:red;' Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=0%;color:red;'", "style='width=10%;color:red;'", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap style='color:red;'", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap Title='Variance (hrs)' style='color:red;'", "style='width=0%;color:red;'"}
    Private m_arrstrRedToolTipForGrid() As String = {"style='width=0%'", "style='width=0%'", "style='width:1%;'Title='Document'", "{}Title='[TaskNotes]' style='width=50%;color:red;'", "style='width=20%;color:red;'", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width=20%' align=right nowrap Title='Variance (hrs)' style='color:red;'"}
    'End(JyotiG)
    '***** End Modification by SandipL  on 31 Jan 2006
    ' End Addition
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objGridIssueList As New WebPage.Templates.AdvancedGrid
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objGridReviewList As New WebPage.Templates.AdvancedGrid
    '-- Use the Grid class to plot the 'My Projects' grid
    Private WithEvents m_objMyProjects_Grid As New WebPage.Templates.AdvancedGrid

    Protected m_intListNumber As Integer = 0
    Protected m_strDB_PageName As String
    Protected m_strPageTitle As String
    Protected strList1_DefaultSortField, strList1_DefaultSortOrder As String
    Protected strList2_DefaultSortField, strList2_DefaultSortOrder As String
    Protected strList3_DefaultSortField, strList3_DefaultSortOrder As String
    Protected strList4_DefaultSortField, strList4_DefaultSortOrder As String
    Protected strList8_DefaultSortField, strList8_DefaultSortOrder As String
    Protected m_strIssueName As String
    Protected m_intProgressRpt As Integer
    Protected m_intProjectID As Integer

    'Addtion By MrugajaB on 4th June 2005 for Issue ID.18389
    'Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
    Protected m_TaskOnHold As String = "0"
    'Addition ended
    Protected m_strDashboardID As String = ""
    Protected arrIgnoreHTMLEncode() As String = {"0"}

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
    ''added by Nilesh g on 2/2/2016 for url issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(intProjectID As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(intProjectID, String) + CType(EmployeeID, String) + "0" + "0")
            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''ENDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_strDB_PageName = "../DB/DeveloperDB.aspx"
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

        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_strNotSpecified = MyBase.GetResourceString("NOT_SPECIFIED")
        m_strIssueName = MyBase.GetResourceString("TAB_ISSUES")
        m_intProgressRpt = CommonFunction.Constants.PROJ_PROGRESS_RPT
        m_blnShowWeeklyView = CommonFunctions.Application.ShowWeeklyView
        m_blnShowTaskTypeTimesheet = CommonFunctions.Application.ShowTaskTypeTimesheet

        ' Store approprate value for the Project Filter Session Variable.
        If Not Session("intProjectID") Is Nothing Then
            If Request.QueryString("ProjectFilter") = "1" Then
                Session("DB_ProjectFilter") = True
            ElseIf Request.QueryString("ProjectFilter") = "0" Then
                Session("DB_ProjectFilter") = False
            End If
        End If

        m_blnSetProjectFilter = False
        If CType(Session("DB_ProjectFilter"), Boolean) Then
            m_blnSetProjectFilter = True
        End If

        ' Store the approprate value for the TodoListFilter Session Variable.
        If Request.QueryString("TodoListFilter") <> "" Then
            Session("DB_TodoListFilter") = Trim(Request.QueryString("TodoListFilter"))
            If Session("DB_TodoListFilter").ToString = "5" Then
                Session("DB_FromDate") = Trim(Request.QueryString("FromDate"))
                Session("DB_ToDate") = Trim(Request.QueryString("ToDate"))
            End If
        End If

        '-- Filter for Filtering records in the TO DO LIST Drid
        If Trim(CommonFunctions.General.CheckIsNothing(Session("DB_TodoListFilter"), "")) = "" Then
            Session("DB_TodoListFilter") = "4"
        End If
        m_strTaskListFilter = Session("DB_TodoListFilter").ToString

        '-- Store the approprate value for the ListNumber Session Variable. 	
        If Trim(Request.QueryString("List")) <> "" Then
            m_intListNumber = CInt(Trim(Request.QueryString("List")))
            Session("DB_ListNumber") = m_intListNumber
        End If

        '-- If the Session value was not set, then set it to default list number. 
        '-- (This case can arise on entering the Dashboard for the first time.)
        If Trim(CommonFunctions.General.CheckIsNothing(Session("DB_ListNumber"), "")) = "" Then
            m_intListNumber = 1
            Session("DB_ListNumber") = m_intListNumber
        Else
            m_intListNumber = CType(Trim(Session("DB_ListNumber").ToString), Integer)
        End If

        If (m_intListNumber < 1 Or m_intListNumber > 4) And m_intListNumber <> 8 Then
            m_intListNumber = 1
            Session("DB_ListNumber") = m_intListNumber
        End If

        '-- Get the corresponding list name.
        Select Case m_intListNumber
            Case 1
                m_strListName = "DB_TO_DO_LIST"
            Case 2
                m_strListName = "DB_ISSUE_LIST"
            Case 3
                m_strListName = "DB_CRM_QUERY_LIST"
            Case 4
                m_strListName = "DB_PROJECT_LIST"
            Case 8
                m_strListName = "DB_REVIEW_LIST"
        End Select

        '-- Save the selected Sort Field, and Sort order in the database, if it has changed.	
        If Trim(Request.QueryString("Field")) <> "" Then
            Call SaveSortingDetails(m_strListName, "", Trim(Request.QueryString("Field")), Trim(Request.QueryString("Order")))
        End If

        '-- Get the in-use or default sort order for the To do List.
        Call GetSortingDetails("DB_TO_DO_LIST", "", strList1_DefaultSortField, strList1_DefaultSortOrder)
        If Trim(strList1_DefaultSortField) = "" Then
            strList1_DefaultSortField = "StartDate"
            strList1_DefaultSortOrder = "ASC"
        End If

        '-- Get the in-use or default sort order for the Issue List.
        Call GetSortingDetails("DB_ISSUE_LIST", "", strList2_DefaultSortField, strList2_DefaultSortOrder)
        If Trim(strList2_DefaultSortField) = "" Then
            strList2_DefaultSortField = "Task_StartDate"
            strList2_DefaultSortOrder = "DESC"
        End If

        '-- Get the in-use or default sort order for the CRM Query List.
        Call GetSortingDetails("DB_CRM_QUERY_LIST", "", strList3_DefaultSortField, strList3_DefaultSortOrder)
        If Trim(strList3_DefaultSortField) = "" Then
            strList3_DefaultSortField = "Subject"
            strList3_DefaultSortOrder = "ASC"
        End If

        '-- Get the in-use or default sort order for the Project List.	
        Call GetSortingDetails("DB_PROJECT_LIST", "", strList4_DefaultSortField, strList4_DefaultSortOrder)
        If Trim(strList4_DefaultSortField) = "" Then
            strList4_DefaultSortField = "ProjectName"
            strList4_DefaultSortOrder = "ASC"
        End If

        '-- Get the in-use or default sort order for the List of Reviews.	
        Call GetSortingDetails("DB_REVIEW_LIST", "", strList8_DefaultSortField, strList8_DefaultSortOrder)
        If Trim(strList8_DefaultSortField) = "" Then
            strList8_DefaultSortField = "R.ReviewType"
            strList8_DefaultSortOrder = "ASC"
        End If


        '-- Retrieve the currently active sort field, and sort order.
        If m_strListName = "DB_TO_DO_LIST" Then
            m_strSortByField = strList1_DefaultSortField
            m_strAscOrDesc = strList1_DefaultSortOrder
        ElseIf m_strListName = "DB_ISSUE_LIST" Then
            m_strSortByField = strList2_DefaultSortField
            m_strAscOrDesc = strList2_DefaultSortOrder
        ElseIf m_strListName = "DB_CRM_QUERY_LIST" Then
            m_strSortByField = strList3_DefaultSortField
            m_strAscOrDesc = strList3_DefaultSortOrder
        ElseIf m_strListName = "DB_PROJECT_LIST" Then
            m_strSortByField = strList4_DefaultSortField
            m_strAscOrDesc = strList4_DefaultSortOrder
        ElseIf m_strListName = "DB_REVIEW_LIST" Then
            m_strSortByField = strList8_DefaultSortField
            m_strAscOrDesc = strList8_DefaultSortOrder
        End If

        If m_intListNumber = 0 Then
            m_intListNumber = 1
        End If
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
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 5th, 2003
        ' Revisions             : 
        '=====================================================================

        Dim strSQL As String
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

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDashboardID", "txtDashboardID", , , , m_strDashboardID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        '--- End addition purvaj
        '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
        If m_blnHideCombo = False Then
            '--- End addition purvaj
            '--1. Write the Combo for e-Dashboard selections
            'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
            'CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width=100%>")
            CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width=99.9%>")
            'End Modification
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD>")

            '-- Initialize the Resource File
            MyBase.InitializeResources("AppResources.DeveloperDB", "AppResources")
            Response.Write("<b>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))

            '-- Combo box to select the Type of e-Dashboard
            If Trim(Session("intPostID").ToString) <> "" Then
                strSQL = "usp_CDB_GetUserDashboardsForCombo  " + Session("intUserID").ToString + "," + Session("intPostID").ToString
            Else
                strSQL = "usp_CDB_GetUserDashboardsForCombo  " + Session("intUserID").ToString
            End If

            CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , Trim(m_strDB_PageName + "") + "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
        End If
        'Response.Write("<br>")

        '--3. Draw the 2 main sections: 1st Section in turn consist of 4 Grids (Todo list, Issues, Reviews and My Projects)
        '-- 2nd section consists of 2 tables : Issue Aging Analysis and Events
        Call PrepareSections()

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
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================

        '-- 2 sections in the page: e-Dashboard and Issue Ageing/Upcoming events
        Dim objDashboardSection As WebPages.Template.SectionTitle
        Dim strTabs As String

        objDashboardSection = New WebPages.Template.SectionTitle
        Response.Write("<DIV Id='divContainer' Style='Overflow:Auto;Height:100%'>")

        '--2. Draw the Tabs
        strTabs = DrawTabs()

        With objDashboardSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("PAGE_CAPTION"), "DivOtherInfo", "ShowHideOtherInfo", , strTabs))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivOtherInfo' Style='Overflow:Auto;Height:260;width:100%'>")
        '--call to display Grid
        Call DisplayGrid()
        Response.Write("</DIV>")

        '-- Draw table for Pending Timesheets
        Call ShowPendingTimesheet()

        '-- Call Issue Ageing grids
        Dim objDashboardBottomSection As WebPages.Template.SectionTitle
        objDashboardBottomSection = New WebPages.Template.SectionTitle
        With objDashboardBottomSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("ISSUE_AGEING"), "DivBottomList", "ShowHideBottomList"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '-- Div and Tables for Bottom List
        Response.Write("<DIV Id='DivBottomList' Style='Overflow:Auto;Height:130;width:100%'>")
        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Modified by NiranjanK on Date June 20,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE class=clsTable style='Width:100%;Height:100%'>")
        'End of modification by NiranjanK June 09,2006 for WhzibleSEM Issue ID.4168
        Response.Write("<TR>")
        Call IssueAgeingAnalysis()
        'Call EventsList()
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("</DIV>")

        Response.Write("</DIV>")
        '-- Draw Bottom menu...
        Response.Write(PrepareMenu())
        If Not IsNothing(Session("ShowFlag")) Then
            Session("ShowFlag") = Nothing
        End If

    End Function

    Private Sub DisplayGrid()
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Calls to the 4 Grids in the Top Section for the 4 grids
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================
        '-- Draws the TO DO LIST
        Select Case m_intListNumber

            Case 1
                Call Display_ToDoList_Tab()

                '-- Draws the Issues LIST
            Case 2
                Call Display_IssuesList_Tab()

                '-- Draws the MY PROJECTS LIST
            Case 4
                Call Display_MyProjects_Tab()

                '-- Draws the CRM List
            Case 3
                Call Display_CRM_Tab()

                '-- Draws the REVIEWS LIST
            Case 8
                Call Display_ReviewsList_Tab()

            Case Else
                Call Display_ToDoList_Tab()

        End Select

    End Sub

    Private Sub Display_ToDoList_Tab()
        '=====================================================================
        ' Page Name             : Display_ToDoList_Tab
        ' Purpose               : Draws the TO DO List which displays the Task List for times week
        '                         and also the Pending tasks 
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================

        Dim blnShowCurrent, blnShowBaseline, blnShowActual As Boolean
        Dim blnIsChecked As Boolean
        Dim dtmTaskList_FromDate, dtmTaskList_ToDate As String
        Dim strSQLQuery As String
        Dim strSortByField, strAscOrDesc As String
        Dim drProjectCount As IDataReader
        Dim intProjectCount As Integer
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strShowCurrent, strShowBaseline As String
        Dim strShowActual As String
        'Dim strTemp As String

        ' If the settings have to be saved, then...
        If Request.QueryString("ColumnType") <> "" Then
            Call SaveSortingDetails("DB_TO_DO_LIST_" & Request.QueryString("ColumnType"), "", Request.QueryString("Show"), "")
        End If

        '' Get the previous settings for the Current column in the To do list.
        'If Not blnShowCurrent Then strShowCurrent = ""
        'Call GetSortingDetails("DB_TO_DO_LIST_C", "", strShowCurrent, "")
        'If strShowCurrent = "0" Then
        '    blnShowCurrent = True
        '    strShowCurrent = "1"
        'Else
        '    blnShowCurrent = CType(blnShowCurrent, Boolean)
        '    strShowCurrent = "0"
        'End If

        ' Get the previous settings for the Baseline column in the To do`` list.
        If Not blnShowBaseline Then strShowBaseline = ""
        Call GetSortingDetails("DB_TO_DO_LIST_B", "", strShowBaseline, "")
        If strShowBaseline = "0" Then
            blnShowBaseline = True
            strShowBaseline = "1"
        Else
            blnShowBaseline = CType(blnShowBaseline, Boolean)
            strShowBaseline = "0"
        End If

        ' Get the previous settings for the Actual column in the To do list.
        If Not blnShowActual Then strShowActual = ""
        Call GetSortingDetails("DB_TO_DO_LIST_A", "", strShowActual, "")
        If strShowActual = "0" Then
            blnShowActual = True
            strShowActual = "1"
        Else
            blnShowActual = CType(blnShowActual, Boolean)
            strShowActual = "0"
        End If
        ' End Addition.

        Response.Write("<TABLE ID='Task' style='VISIBILITY:hidden;DISPLAY:none' cellspacing=1 ")
        If blnShowCurrent And blnShowBaseline And blnShowActual Then
            Response.Write(" width='110%'>")
        Else
            'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
            'Response.Write(" width='100%'>")
            Response.Write(" width='99.9%'>")
        End If
        Response.Write("<tr><td colspan=18>")
        Response.Write("<table cellspacing=0>")
        Response.Write("<tr><td >")
        Response.Write("<font size=1>")
        If m_strTaskListFilter = "4" Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskFilter", "optToday", , blnIsChecked, "4", , " onclick='javascript:FilterTaskList(4)'")
        Response.Write(MyBase.GetResourceString("OPT_TODAY"))
        Response.Write("</font>")
        Response.Write("</td>")

        Response.Write("<td noWrap>")
        Response.Write("<font size='1'>")
        If m_strTaskListFilter = "2" Then blnIsChecked = True Else blnIsChecked = False
        Response.Write("<font size=1>")
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskFilter", "optPrevWeek", , blnIsChecked, "2", , " onclick='javascript:FilterTaskList(2)'")
        Response.Write(MyBase.GetResourceString("OPT_PREVIOUS"))
        Response.Write("</font>")
        Response.Write("</td>")

        Response.Write("<td noWrap>")
        Response.Write("<font size=1>")
        If m_strTaskListFilter = "1" Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskFilter", "optThisWeek", , blnIsChecked, "1", , " onclick='javascript:FilterTaskList(1)'")
        Response.Write(MyBase.GetResourceString("OPT_THISWEEK"))
        Response.Write("</font>")
        Response.Write("</td>")

        Response.Write("<td noWrap>")
        Response.Write("<font size=1>")
        If m_strTaskListFilter = "3" Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskFilter", "optNextWeek", , blnIsChecked, "3", , " onclick='javascript:FilterTaskList(3)'")
        Response.Write(MyBase.GetResourceString("OPT_NEXTWEEK"))
        Response.Write("</font>")
        Response.Write("</td>")

        '-- Date Range (inside TO DO List)
        Response.Write("<td>")
        Response.Write("<font size=1>")
        If m_strTaskListFilter = "5" Then blnIsChecked = True Else blnIsChecked = False
        CommonFunctions.HTMLControls.DrawOptionButton("optTaskFilter", "optDateRange", , blnIsChecked, "5", , " onclick='javascript:optDateRange_OnClick()'")
        Response.Write(MyBase.GetResourceString("OPT_DATERANGE"))
        Response.Write("</font>")
        Response.Write("</td>")

        Response.Write("<td id='cellDateRange' ")
        If m_strTaskListFilter <> "5" Then Response.Write("style='display:none' ")
        Response.Write(">|&nbsp;")
        Response.Write("<font size=1>")
        Response.Write(MyBase.GetResourceString("FROM"))
        Response.Write("</font>")
        Response.Write("&nbsp;")
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunctions.General.CheckIsNothing(Session("DB_FromDate"), ""), , "Graph", , , , , , , , True)

        Response.Write("&nbsp;")
        Response.Write("<font size=1>")
        Response.Write(MyBase.GetResourceString("To"))
        Response.Write("&nbsp;")
        Response.Write("</font>")
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunctions.General.CheckIsNothing(Session("DB_ToDate"), ""), , "Graph", , , , , , , , True)
        Response.Write("&nbsp;")
        Response.Write("<font Size=1 Face=verdana color=black>")
        Response.Write("| <a style='TEXT-DECORATION: none' HREF='javascript:FilterTaskList(5)'>")
        Response.Write("<b>Show</b>")
        Response.Write("</a> | </font></td></tr>")

        ' Get the Actual Date Range of the Tasks List Filter.
        If m_strTaskListFilter = "1" Or m_strTaskListFilter = "2" Or m_strTaskListFilter = "3" Then

            ' Pass the parameters required to pass to the stored procedure.			
            If m_strTaskListFilter = "3" Then
                Call CommonFunction.Dates.GetFromAndToDates("1", dtmTaskList_FromDate, dtmTaskList_ToDate, Now().ToString)

            Else
                Call CommonFunction.Dates.GetFromAndToDates(m_strTaskListFilter, dtmTaskList_FromDate, dtmTaskList_ToDate, Now().ToString)

            End If

            dtmTaskList_ToDate = DateAdd("d", 6, CType(dtmTaskList_FromDate, Date)).ToString

            If m_strTaskListFilter = "3" Then

                dtmTaskList_FromDate = DateAdd("d", 7, CType(dtmTaskList_FromDate, Date)).ToString
                dtmTaskList_ToDate = DateAdd("d", 7, CType(dtmTaskList_ToDate, Date)).ToString
            End If

        ElseIf m_strTaskListFilter = "4" Then

            dtmTaskList_ToDate = CommonFunctions.Dates.GetDate(Now())
        Else
            '-- For Date Range Selection option 
            If Session("DB_ToDate").ToString = "" Then Session("DB_ToDate") = Now()
            If CommonFunctions.General.CheckIsNothing(Session("DB_FromDate")) <> "" Then
                dtmTaskList_FromDate = CommonFunctions.Dates.GetDate(CType(CommonFunctions.General.CheckIsNothing(Session("DB_FromDate")), Date))
            End If

            dtmTaskList_ToDate = CommonFunctions.Dates.GetDate(CType(Session("DB_ToDate"), Date))

        End If

        'fire a query which will return you the all the tasks for a selected person for that particular day
        'it will also include the pending tasks for that particular person				

        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",1"
        If m_intListNumber = 1 Then
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & strList1_DefaultSortField & " " & strList1_DefaultSortOrder & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList1_DefaultSortField & " " & strList1_DefaultSortOrder & "'"
        End If

        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'A.ProjectID = " & m_intProjectID.ToString & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLQuery & ", 1", m_blnUseSQL)
        If drProjectCount.Read Then
            intProjectCount = CType(drProjectCount("ProjectCount"), Integer)
        Else
            intProjectCount = 10
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectCount)

        strSQLQuery = strSQLQuery & ", 0"

        If Trim(dtmTaskList_FromDate) <> "" Then
            strSQLQuery = strSQLQuery & ", '" & dtmTaskList_FromDate & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        If Trim(dtmTaskList_ToDate) <> "" Then
            strSQLQuery = strSQLQuery & ", '" & dtmTaskList_ToDate & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        strGroupByField = "ProjectName"
        strGroupByFieldValue = ""

        '-- define the Actual Array and UserFriendly array..
        'integrated by harshada d for whiziblesem Issue ID 989 
        '======================================================================================================================
        'Modified By Manishk on 15th Nov 2005 For Developer Dashboard , field added is "DocumentLink"
        '======================================================================================================================

        'Dim arrstrActualList() As String = {"ProjectName", "DocumentLink", "TaskTypelink", "TaskName", "Priority", "StartDate", "EndDate", "Duration", "Work", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}
        'Done By JyotiG For Issue ID : 5342
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "TaskName", "Priority", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}

        'Dim arrstrUserFriendlyList() As String = {"", "", "", "Task Name", "Priority", "Start Date", "End Date", "Duration", "Work", "Start Date", "End Date", "Duration", "Work", "Start Date", "Work (hrs)", "Variance (hrs)"}
        'Done By JyotiG For Issue ID : 5342
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "Task Name", "Priority", "Start Date", "End Date", "Duration", "Work", "Start Date", "Work (hrs)", "Variance (hrs)"}

        'Dim arrstrLinkArray() As String = {"", "", "", "", "", "", "", "", "", "", "", "", ""}
        Dim arrstrLinkArray() As String = {"", "", "", "", "", "", "", "", "", "", "", ""}
        '-- define the Tool Tip for each column
        ' Commented By NitinVS on 15 Dec 2004 
        'Dim arrstrToolTipForGrid() As String = {"style='width=0%'", "style='width=1%' Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}

        'Dim arrColGroup() As String = {"1-4", "5-8", "9-12", "13-14", "15"}

        'Dim arrColGroup() As String = {"1-5", "6-9", "10-13", "14-15", "16"}
        'Done By JyotiG For Issue ID : 5342
        ' Dim arrColGroup() As String = {"1-6", "7-10", "11-12", "13"}
        Dim arrColGroup() As String = {"1-5", "6-9", "10-11", "12"}


        '======================================================================================================================
        'End of Modified By Manishk on 15th Nov 2005 For Developer Dashboard , field added is "DocumentLink"
        '======================================================================================================================
        'integrated by harshada d for whiziblesem Issue ID 989

        'Dim arrColGroupNames() As String = {"", "Current", "Baseline", "Actual", ""}
        'Done By JyotiG For Issue ID : 5342
        Dim arrColGroupNames() As String = {"", "Baseline", "Actual", ""}

        'Done By JyotiG For Issue ID : 5342
        'Dim arrColGroupExpanded() As String = {"1", strShowCurrent, strShowBaseline, strShowActual, "1"}
        Dim arrColGroupExpanded() As String = {"1", strShowBaseline, strShowActual, "1"}

        'Modified by MrugajaB on 13th April 2006
        'Purpose:for critical MPP tasks ,data display format was wrong
        'Dim arrstrGroupOnColumn() As String = {"1"}
        Dim arrstrGroupOnColumn(0) As String '= {"0"}
        'End Modification
        'integrated by harshada d on 21 DEC 2005 for whiziblesem Issue ID 989
        'Modified By ManishK on 15th Nov 2005 For Developer Dashboard Functionality
        'Dim arrstrIgnoreHTML() As String = {"", "1"}
        Dim arrstrIgnoreHTML() As String = {"", "1", "1", "1"}
        'End of Modified By ManishK on 15th Nov 2005 For Developer Dashboard Functionality

        '======================================================================================================================
        'Modified By ManishK on 15th Nov 2005
        '======================================================================================================================
        'Dim arrstrRowLinkField() As String = {"", "TaskTypeTimesheet_OnClick(TaskID)", "TaskLink_OnClick(ProjectID,TaskID)", "", "", "", "", "", "", "", "", "", "", "", ""}

        'Here ParentTask_UID is send as Documents gets attached to Parent of the Child i.e. entries in tbl_pm_projectDocuments are of Parents tasks
        Dim arrstrRowLinkField() As String = {"", "Flag_OnClick(ProjectID,TaskID,TaskName)", "DocumentLink_OnClick(ProjectID,ParentTask_UID,TaskID,ApplyEffortDistribution,HaveSubTaskTypes)", "TaskLink_OnClick(ProjectID,TaskID)", "", "", "", "", "", "", "", "", "", "", ""}

        '======================================================================================================================
        'end of modification by ManishK on 15th Nov 2005
        '======================================================================================================================

        'Dim arrstrTDStyle() As String = {"style='width=2%'", "style='width=20%'", "style='width=5%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"style='width=1%'", "style='width=0%'", "style='width=1%'", "style='width=5%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "", "", "", ""}

        'end of integration by harshada d on 21 DEC 2005 for issue id 989
        Dim strGRID As String
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006
        'Purpose : ----- WhizibleSEM SP7
        'Issue ID : 5342
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("0")
        Else
            arrstrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        '--Plotting the TO DO Grid's properties
        With m_objGrid
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            ' Commented by NitinVS on 15 Dec 2004
            ' To make apply different style based on IsCritical 
            '.TDStyleArray = arrstrToolTipForGrid
            .TDStyleArray = m_arrstrToolTipForGrid

            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            '-- Column Grouping
            .ColumnGroupNameArray = arrColGroupNames
            .ColumnGroupColumnsArray = arrColGroup
            .ColumnGroupExpandedArray = arrColGroupExpanded
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .RowLinkArray = arrstrRowLinkField
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid() ' Called from within the section below
        End With
        Response.Write(strGRID)
        Response.Write("</table></td></tr>")      '</table></td></tr>
        Response.Write("</td></tr></table>")
        m_objGrid = Nothing
    End Sub

    Private Sub Display_IssuesList_Tab()
        '=====================================================================
        ' Page Name             : Display_IssuesList_Tab
        ' Purpose               : Draws the ISSUE LIST Assigned to the user
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 7, 2004
        ' Revisions             : 
        '=====================================================================
	'integrated by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
  '===================================================================== '=====================================================================
        'Modified By Manishk on 16th Nov 2005 for PM Dashboard No of Attached Documents Functionality
        '===================================================================== '=====================================================================

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "TaskName", "Issue_Priority", "Issue_Status", "Task_StartDate", "Task_EndDate", "Work", "Actualwork", "Task Entry"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", MyBase.GetResourceString("ISSUE"), MyBase.GetResourceString("PRIORITY"), MyBase.GetResourceString("STATUS"), MyBase.GetResourceString("START_DATE"), MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("WORK"), MyBase.GetResourceString("ACT_WORK"), MyBase.GetResourceString("TASK_ENTRY")}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"style='width:1%", "Title='Flag'", "Title='Document'", "{}Title='[TaskNotes]' style='width:25%'", " nowrap ", "", "", "", " align=right ", " align=right ", " align=center "}
        Dim arrstrRowLinkField() As String = {"", "Flag_Issue_OnClick(ProjectID,IssueID,TaskName)", "DocumentLink_Issue_OnClick(ProjectID,IssueID)", "BugDisplay(ProjectID,OtherTaskID)", "", "", "", "", "", "", "TaskLink_OnClick(ProjectID,TaskID)"}

        Dim arrstrTDStyle() As String = {"", "style='width:0%", "Title='Document'", "{}Title='[TaskNotes]' style='width:25%'", " nowrap ", "", "", "", " align=right ", " align=right ", " align=center "}
        Dim arrstrGroupOnColumn(0) As String '= {"1"}
        Dim arrstrIgnoreHTML() As String = {"", "1", "1", "1"}

        '===================================================================== '=====================================================================
        'End of Modified By Manishk on 16th Nov 2005 for PM Dashboard No of Attached Documents Functionality
        '===================================================================== '=====================================================================
		'end of integration by harshada d on 21 DEC 2005 for Issue ID 989
        Dim strGRID As String
        Dim strSQLQuery As String
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006
        'Purpose : ----- WhizibleSEM SP7
        'Issue ID : 5342
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<TABLE ID='Bug' cellspacing=1 border=0 width=100% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TABLE ID='Bug' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        'End Modification
        Response.Write("<TR class=clsTREven ><TD align=center>")

        'fire a query which will return you the all the tasks for a selected person for that particular day
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",2"
        If m_intListNumber = 2 Then
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & strList2_DefaultSortField & " " & strList2_DefaultSortOrder & "'"\
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList2_DefaultSortField & " " & strList2_DefaultSortOrder & "'"
        End If

        '-- If Show Selected Project has been checked .. we Add this filter
        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'A.ProjectID = " & m_intProjectID.ToString & "'"
        End If

        '--Plotting the Grid 
        With m_objGridIssueList
            '--Columns in the Grid
            .GroupOnColumn = arrstrGroupOnColumn
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .RowLinkArray = arrstrRowLinkField
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True

            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc

            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")

        m_objGridIssueList = Nothing
    End Sub

    Private Sub Display_ReviewsList_Tab()
        '=====================================================================
        ' Page Name             : Display_ReviewsList_Tab
        ' Purpose               : Draws the REVIEWS LIST Assigned to the user
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        
        Dim strSQL As String
	'integrated by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
  '==================================================================================================================================
        'Modified By ManishK on 15th Nov 2005 for Developer Dashboard Functionality
        '==================================================================================================================================

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"IsReviewee", "Flag", "DocumentLink", "ProjectName", "ReviewType", "ReviewedDate", "ReviewedBy", "Reviewee", "ReviewEffort", "ReviewStatus"}
        'Modified by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
        'Purpose:Corrected spelling mistake in word 'Reviewwee'
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "Project Name", "Review Type", "Review Date", "Reviewer(s)", "Reviewee", "Work (hrs)", "Review Status"}
        'End modification

        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "", "", "", "", "", "", "", "", ""}
        'Dim arrstrRowLinkField() As String = {"", "", "BugDisplay(ProjectID,OtherTaskID)", "", "", "", "", "", "", "TaskLink_OnClick(ProjectID,TaskID)"}
        'Dim arrstrTDStyle() As String = {"", "", "style='width=25%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'"}
	 '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
        '==================================================================================================================================
        Dim arrstrRowLinkField() As String = {"", "Flag_Review_OnClick(ProjectID,ReviewStatisticsID,ReviewType)", "DocumentLink_Review_OnClick(ProjectID,ReviewStatisticsID,IssueIds)", "", "", "", "", "", "", "", ""}
        '==================================================================================================================================
        'End of addition By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
        '=================================================================================
        Dim arrstrTDStyle() As String = {"", "style='width:0%;' Title='Flag'", "style='width:5px;' Title='Document'", "Title='Project Name' ", "style='width=25%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'"}
        '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
        '==================================================================================================================================
        Dim arrstrIgnoreHTML() As String = {"", "1", "1"}
        '==================================================================================================================================
        'End of addition By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
        '==================================================================================================================================
        '==================================================================================================================================
        'End of Modified By ManishK on 15th Nov 2005 for Developer Dashboard Functionality
        '==================================================================================================================================
	'end of integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
        Dim arrstrGroupOnColumn(0) As String '= {"1"}
        Dim strGRID As String
        Dim strSQLQuery As String
        Dim drReviews As IDataReader
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006
        'Purpose : ----- WhizibleSEM SP7
        'Issue ID : 5342
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<TABLE ID='tblReview' cellspacing=1 border=0 width=100% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TABLE ID='tblReview' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        'End Modification
        Response.Write("<TR class=clsTREven><TD align=center>")

        ' Build the query to retrieve the list of reviews.
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ", 8"
        If m_intListNumber = 8 Then
            'strSQLQuery = strSQLQuery & ",' ORDER BY [IsReviewee], P.ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",' ORDER BY [IsReviewee], " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",' ORDER BY [IsReviewee], P.ProjectName, " & strList8_DefaultSortField & " " & strList8_DefaultSortOrder & "'"
            strSQLQuery = strSQLQuery & ",' ORDER BY [IsReviewee], " & strList8_DefaultSortField & " " & strList8_DefaultSortOrder & "'"
        End If

        ' Apply the Project filter.
        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'R.ProjectID = " & m_intProjectID.ToString & " AND "
        Else
            strSQLQuery = strSQLQuery & ", '1 = 1 AND "
        End If

        ' Apply the filtering criteria such that all the reviews where the concerned user is either the reviewer of the reviewee will be returned.						

        'Commented and modified by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
        'Purpose:To display list of reviewees on dashboard
        'strSQL = " Reviewee =''" + Replace(Session("strUserName").ToString, "'", "''''") + "'' OR (ReviewedBy +'','' Like ''%" + Replace(Session("strUserName").ToString, "'", "''''") + ",%'')'"
        strSQL = " (Reviewee +'','' Like ''%" + Replace(Session("strUserName").ToString, "'", "''''") + ",%'') OR (ReviewedBy +'','' Like ''%" + Replace(Session("strUserName").ToString, "'", "''''") + ",%'')'"
        'End odification

        '--Plotting the Grid 
        With m_objGridReviewList
            '--Columns in the Grid
            'integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
            '==================================================================================================================================
            'Added By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
            '==================================================================================================================================
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .RowLinkArray = arrstrRowLinkField
            '==================================================================================================================================
            'End of addition By ManishK on 16th Nov 2005 for Developer Dashboard Functionality
            '==================================================================================================================================
            'end of integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery + strSQL
            .EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True
            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .DIVHeight = 0

            .returnHTML = True
            .UseSQL = m_blnUseSQL

            '--Sorting in Grid
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            '.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")

        m_objGridReviewList = Nothing
    End Sub

    Private Sub Display_MyProjects_Tab()
        '=====================================================================
        ' Page Name             : Display_MyProjects_Tab
        ' Purpose               : Draws the MY PROJECTS LIST of projects Assigned to the user in the Grid
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        '-- My Projects Grid
        Dim strSQLQuery, strGRID As String

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "ExpectedStartDate", "ExpectedEndDate", _
                                            "ExpectedDuration", "EstimatedEfforts", "ActualEfforts", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("ISSUE_PROJ_NAME"), MyBase.GetResourceString("START_DATE"), _
                                    MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("DURATION"), _
                                    MyBase.GetResourceString("WORK"), MyBase.GetResourceString("ACT_WORK"), _
                                    MyBase.GetResourceString("SHOW_REPORT")}

        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "style='width=5%';Title='Task Type Timesheet'", "{}Title='[TaskNotes]'", "", "", "", "", "", "", ""}

        Dim arrstrRowLinkField() As String = {"", "", "", "", "", "", "ShowProjectReport_OnClick(ProjectID)"}
        Dim arrstrTDStyle() As String = {"", "style='width=20%'", "style='width=10%'", "style='width=10%;text-align=right'", "style='width=10%;text-align=right'", "style='width=10%;text-align=right'", "style='width=10%;'"}

        '--'My Projects' List
        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<TABLE ID='MyProject' border=0 cellspacing=1  width='100%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        Response.Write("<TABLE ID='MyProject' border=0 cellspacing=1  width='99.9%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        'End Modification
        Response.Write("<TR class=clsTREven ><td align=center >")

        '-- SQL Query for the 'My Projects' grid
        'strSQLQuery = "EXEC usp_Sel_Project_For_DA " & Session("intUserID").ToString
        strSQLQuery = " EXEC usp_Sel_ProjectStatus_ForEmployee " + Session("intUserID").ToString

        If m_intListNumber = 4 Then
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList4_DefaultSortField & " " & strList4_DefaultSortOrder & "'"
        End If

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        ' Added By SujataK on 18 May 2006 For WhizEnggSP6 For IssueID-3706
        ' Purpose : Not To display global projects in the list hence appened 0 
        strSQLQuery = strSQLQuery & "," & 0
        ' End of Addition By SujataK
        'End Integration

        With m_objMyProjects_Grid
            '--Columns in the Grid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrstrTDStyle
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True
            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .DIVHeight = 0

            .returnHTML = True
            .UseSQL = m_blnUseSQL

            '--Sorting in Grid
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc

            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)

        Response.Write("</td></tr>")
        Response.Write("</table>")
        m_objMyProjects_Grid = Nothing
    End Sub

    Private Sub Display_CRM_Tab()
        '=====================================================================
        ' Page Name             : Display_CRM_Tab
        ' Purpose               : Grid list for CRM Support queries assigned to user
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery, strGRID As String
        Dim drGetTaskList As IDataReader
        Dim objGrid As New WebPage.Templates.AdvancedGrid

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"Subject", "AssignDate", "ExpectedResolvedDate", "Priority", "Status"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("SUBJECT"), MyBase.GetResourceString("ASSGN_ON"), MyBase.GetResourceString("EXP_RES_DATE"), MyBase.GetResourceString("PRIORITY"), MyBase.GetResourceString("STATUS")}
        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "style='width=5%';Title='Task Type Timesheet'", "{}Title='[TaskNotes]'", "", "", "", "", "", "", ""}
        Dim arrstrRowLinkField() As String = {"CRMQuery_OnClick(QueryID)", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"", "", "", "", ""}

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<TABLE ID='CRM' border=0 cellspacing=1  width='100%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        Response.Write("<TABLE ID='CRM' border=0 cellspacing=1  width='99.9%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        'End Modification
        Response.Write("<TR class=clsTREven ><td align=center >")

        strSQLQuery = "usp_Sel_CRM_IncidentList 'E'," & Session("intUserID").ToString
        If m_intListNumber = 3 Then
            strSQLQuery = strSQLQuery & ",'" & m_strSortByField & "'"
            If m_strAscOrDesc = "ASC" Then
                strSQLQuery = strSQLQuery & ",1"
            Else
                strSQLQuery = strSQLQuery & ",0"
            End If
        Else
            strSQLQuery = strSQLQuery & ",'" & strList3_DefaultSortField & "'"
            If strList3_DefaultSortOrder = "ASC" Then
                strSQLQuery = strSQLQuery & ",1"
            Else
                strSQLQuery = strSQLQuery & ",0"
            End If
        End If
        strSQLQuery = strSQLQuery & ",' and Closed <> 1 '"

        'drGetTaskList = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

        With objGrid
            '--Columns in the Grid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True

            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .DIVHeight = 0

            .returnHTML = True
            .UseSQL = m_blnUseSQL

            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)

        Response.Write("</td></tr>")
        Response.Write("</table>")
        objGrid = Nothing

    End Sub

    Private Sub ShowPendingTimesheet()
        '=====================================================================
        ' Procedure Name        : ShowPendingTimesheet
        ' Purpose               : Draws the Table for displaying Pending Timeseet links (last 7 days..max)
        ' Description           : To Do | Issues | Reviews | My Projects
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 10,2004   
        ' Revisions             :
        '=====================================================================

        ' Show the days for which timesheet is pending in the last 7 days
        Dim strSQLQuery As String
        Dim drTimesheetLog As IDataReader
        Dim intCount As Integer
        Dim strPendingTaskEntries As String
        Dim strDateArray() As String
        Dim strMessage As String

        'Response.Write("br>")

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<table id=tblBottom border=0 width=100%>")
        Response.Write("<table id=tblBottom border=0 width=99.9%>")
        'End Modification
        '-- Get data for building Pending dates string..
        strSQLQuery = "EXEC usp_Missing_DA_Dates_for_Employee " & Session("intUserId").ToString
        drTimesheetLog = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
        If drTimesheetLog.Read Then
            strDateArray = Split(drTimesheetLog(0).ToString, ",")
        End If
        intCount = UBound(strDateArray)
        CommonFunctions.Data.DisposeDataReader(drTimesheetLog)

        strPendingTaskEntries = ""

        For intCount = LBound(strDateArray) To UBound(strDateArray) - 1
            'Integrated by SuchitraP on 18-may-2009
            'Commented By VarunA on 23-Jan-2009 RequestID-17945
            'Purpose : To have sunday as weekday before we were leaving sunday.
            'If Weekday(CType(strDateArray(intCount), Date)) <> 1 Then
            'End By VarunA on 23-Jan-2009 RequestID-17945
            strPendingTaskEntries = strPendingTaskEntries & "<a href='javascript:MissingTaskEntry_OnClick(""" & CommonFunctions.Dates.GetDate(CType(strDateArray(intCount), Date)) & """)' TITLE='" & CommonFunctions.Dates.CGetDate(CType(strDateArray(intCount), Date)) & "'>"
            strPendingTaskEntries = strPendingTaskEntries & GetWeekDay(CommonFunctions.Dates.GetDate(CType(strDateArray(intCount), Date)))
            strPendingTaskEntries = strPendingTaskEntries & "</a>|"
            'Commented By VarunA on 23-Jan-2009 RequestID-17945
            'Purpose : To have sunday as weekday before we were leaving sunday.
            'End If
            'End By VarunA on 23-Jan-2009 RequestID-17945
            'End of integration by SuchitraP
        Next

        strMessage = MyBase.GetResourceString("PENDING")
        If Trim(strMessage) = "" Then strMessage = "Pending Task Entries for last 7 days."

        If Trim(strPendingTaskEntries) <> "" Then
            'If Ubound(strDateArray) > 0 Then
            Response.Write("<tr height=10>")
            Response.Write("<td valign=top colspan=2>")

            'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
            'Response.Write("<table border=0 class=clsTable width=100% style='border-style:double;'>")
            Response.Write("<table border=0 class=clsTable width=99.9% style='border-style:double;'>")
            'End Modification
            Response.Write("<tr>")
            Response.Write("<td class=clsTDOdd>")
            Response.Write("<b>" + strMessage + "</b>")
            Response.Write("</td>")
            Response.Write("<td class=clsTDOdd colspan=2 nowrap>|")

            Response.Write(strPendingTaskEntries)

            Response.Write("</td></tr></table></td></tr>")
        End If

        Response.Write("</table>")
    End Sub

    Private Sub EventsList()
        '=====================================================================
        ' Procedure Name        : EventsList
        ' Purpose               : THIS FUNCTIONS IS NOT IN USE  FOR NOW
        ' Description           : To Do | Issues | Reviews | My Projects
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 10,2004   
        ' Revisions             :
        '=====================================================================

        '-- THIS FUCTIONALITY IS GOING TO CHANGE

        Dim strSQLQuery As String
        Response.Write("<td width='50%' valign=top style='border-style:double;'>")

        'Here we will execute one SP which will return recordset for a selected project

        Response.Write("<DIV style='overflow:scroll;width=100%;height:150px'>")
        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<TABLE cellspacing=1 class=clsTable width=100%>")
        Response.Write("<TABLE cellspacing=1 class=clsTable width=99.9%>")
        'End Modification
        Response.Write("<TR class=clsTRColumnHeader ><TD colspan=4 align=center>")
        Response.Write("<b><font style='TEXT-TRANSFORM:capitalize'>" + CommonFunctions.General.FormatString(MyBase.GetResourceString("UPCOMING_EVENTS"), True) + "</b>")
        Response.Write("</TD></TR>")
        Response.Write("<TR>")
        Response.Write("<td class=clsTDEven align=Left>" + MyBase.GetResourceString("EVENT", True) + "</td>")
        Response.Write("<td class=clsTDEven align=Left>" + MyBase.GetResourceString("START_DATE", True) + "</td>")
        Response.Write("<td class=clsTDEven align=Left>" + MyBase.GetResourceString("END_DATE", True) + "</td>")
        Response.Write("<td class=clsTDEven align=Left>" + MyBase.GetResourceString("ACKNOWLEDGE", True) + "</td>")
        Response.Write("</tr>")
        Response.Write("<tr>")
        Response.Write("<td class=clsTDOdd align=center colspan=4>" + MyBase.GetResourceString("NO_ITEMS") + "</td>")
        Response.Write("</tr>")
        Response.Write("</table></div></td>")

    End Sub

    Private Sub IssueAgeingAnalysis()
        '=====================================================================
        ' Procedure Name        : IssueAgeingAnalysis
        ' Purpose               : Draws the Issue Ageing Analysis table
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        '-- Purpose: Issue Ageing Analysis grid

        Dim strSQLQuery As String
        Dim arrstrActualFields() As String = {"Project Name"}
        Dim drGetProjectList, drGetBugReport As IDataReader
        Dim intBugFlag, intCounter As Integer
        Dim strClassName As String

        Response.Write("<td width='100%' valign=top style='border-style:double;'>")

        'Here we will execute one SP which will return recordset for a selected project

        'Modified by VidyaJ - SP4- IssueID -  82
        strSQLQuery = " EXEC usp_DB_Project_BTSAginganalysis " & Session("intUserID").ToString  '"EXEC usp_Sel_ProjectInfo " & Session("intUserID").ToString
        drGetProjectList = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)


        Response.Write("<div style='overflow:auto;height:100%;width:100%;'>")

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<table cellspacing=0 class=clsTable style='width:100%;'>")
        Response.Write("<table cellspacing=0 class=clsTable style='width:99.9%;'>")
        'End Modification
        Response.Write("<tr class=clsTRColumnheader >")
        Response.Write("<td align=Left><b>" + MyBase.GetResourceString("ISSUE_PROJ_NAME", True) + "</td>")
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_5_DAYS", True) + "</td>")
        'Modified by NiranjanK on Date June 07,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_5_10_DAYS", True) + "</td>")
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_10_DAYS", True) + "</td>")
        'End of modification on June 07,2006 Issue ID.4168
        Response.Write("</tr>")
        intBugFlag = 0
        intCounter = 0
        strClassName = "clsTROdd"

        Do While drGetProjectList.Read

            If ((m_blnSetProjectFilter And drGetProjectList("ProjectId").ToString = m_intProjectID.ToString) Or Not m_blnSetProjectFilter) Then
                'Modified by VidyaJ -SP4- IssueID - 82
                'Replace drGetBugReport with drGetProjectList as issue details are fetched in mail query itself
                'strSQLQuery = "EXEC usp_DB_BTSAginganalysis " + drGetProjectList("ProjectId").ToString + "," + Session("intUserID").ToString
                'drGetBugReport = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

                'drGetBugReport.Read()
                If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("5"), "0"), Long) + CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("10"), "0"), Long) + CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("15"), "0"), Long) > 0 Then
                    '-- Logic for Checking which style class to use for TR tag
                    If intCounter Mod 2 = 0 Then
                        strClassName = "clsTROdd"
                    Else
                        strClassName = "clsTREven"
                    End If
                    intCounter = intCounter + 1

                    Response.Write(" <TR class=" + strClassName + ">")
                    Response.Write("<td align=Left>")
                    CommonFunctions.General.WriteHTML(Trim(drGetProjectList("ProjectName").ToString + ""))
                    Response.Write("</td>")

                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("5"), "0"), Integer) <> 0 Then
                        Response.Write("<td align=right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strPageCaption, True) + " assigned to you, that are less than 5 days old."">")
                        Response.Write("<a href='javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",1)'>")
                        Response.Write(drGetProjectList("5"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("5").ToString, "0"))
                        Response.Write("</td>")

                    End If
                    'Modified by NiranjanK on Date June 07,2006 for WhizibleSEM Issue ID.4168
                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("10"), "0"), Long) <> 0 Then
                        Response.Write("<td align=right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strPageCaption, True) + " assigned to you, that are between 5 to 10 days old."">")
                        Response.Write("<a href=""javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",2)"">")
                        Response.Write(drGetProjectList("10"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("10"), "0"))
                        Response.Write("</td>")

                    End If

                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("15"), "0"), Long) <> 0 Then
                        Response.Write("<td align=right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strIssueName, True) + " assigned to you, that are more than 10 days old."">")
                        Response.Write("<a href=""javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",3)"">")
                        Response.Write(drGetProjectList("15"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("15"), "0"))
                        Response.Write("</td>")

                    End If
                    'End of modification by NiranjanK June 07,2006 for WhzibleSEM Issue ID.4168

                    Response.Write("</tr>")

                    intBugFlag = 1
                End If

            End If

            ' CommonFunctions.Data.DisposeDataReader(drGetBugReport)
        Loop

        If intBugFlag = 0 Then
            Response.Write("<tr>")
            Response.Write("<td class=clsTDOdd align=center colspan=4>" + MyBase.GetResourceString("NO_ITEMS") + "</td>")
            Response.Write("</tr>")

        End If

        CommonFunctions.Data.DisposeDataReader(drGetProjectList)
        ' CommonFunctions.Data.DisposeDataReader(drGetBugReport)
        Response.Write("</table></div></td>")
        'End Of Modification

    End Sub

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

        '-- Generate the Menu-like 'Tabs' for the following
        '--To do list | Issues | Reviews | My Projects | Help
        Dim strTabs As String
        Dim strBtnName As String = ""
        strBtnName = "chkSort"
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID:5342
        If Session("ShowFlag") Is Nothing Then
            Session.Add("ShowFlag", Request.QueryString("SortFlag"))
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        'Modified by MrugajaB on 20th June 2006 for WhizibleSEM Issue ID.4168
        'strTabs = "<table cellspacing=0 border=0 width=100%>"
        strTabs = "<table cellspacing=0 border=0 width=99.9%>"
        'End Modification
        strTabs += "<tr >"
        strTabs += "<td align=Left id='objTDCell' >"

        'Select Case m_intListNumber
        '    Case TAB_TO_DO_LIST
        '        strTabs += (MyBase.GetResourceString("TAB_TO_DO"))
        '    Case TAB_ISSUES
        '        strTabs += (MyBase.GetResourceString("TAB_ISSUES"))
        '    Case TAB_REVIEWS
        '        strTabs += (MyBase.GetResourceString("TAB_REVIEWS"))
        '    Case TAB_PROJECTS
        '        strTabs += (MyBase.GetResourceString("TAB_PROJECTS"))
        '    Case Else
        '        strTabs += (MyBase.GetResourceString("TAB_TO_DO"))
        'End Select

        strTabs += "</td>"
        strTabs += "<td align=right>"
        strTabs += "<b>"
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID:5342
        If CType(Session("ShowFlag"), Boolean) = True Then
            strTabs += "<Font Size=1 face=Arial;verdana color=navy>Sort Across</Font><INPUT id=" & strBtnName & _
                           " name=" & strBtnName & " type=checkbox title='This will remove grouping and sort according to selected column.' class=clsCheckBox checked onClick ='javascript:ApplySort()'>"
        ElseIf CType(Session("ShowFlag"), Boolean) = False Then
            strTabs += "<Font Size=1 face=Arial;verdana color=navy>Sort Across</Font><INPUT id=" & strBtnName & _
                           " name=" & strBtnName & " type=checkbox title='This will remove grouping and sort according to selected column.' class=clsCheckBox onClick ='javascript:ApplySort()'>"
        End If
        strTabs += "</b>"
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        strTabs += "<Font Size=1 face=Arial;verdana color=black><b>|"

        '-- TO DO LIST
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " href='javascript:Assignments_clicked(1)' >"
        strTabs += "<img border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "<Font Size=1 face=Arial;verdana color=white>&nbsp;<b id=lblAssignedTasks>" + MyBase.GetResourceString("TAB_TO_DO") + "</font>"
        strTabs += "<Font Size=1 face=Arial;verdana color=navy>&nbsp;<b id=lblAssignedTasks>" + MyBase.GetResourceString("TAB_TO_DO") + "</font>"
        'End Modification
        strTabs += "</b></a><Font Size=1 face=Arial;verdana color=black><b>|</b>"

        '-- ISSUES LIST
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += "Href='javascript:Assignments_clicked(2)' >"
        strTabs += "<img SRC='../../images/arrowselect.gif' border=0 WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblIssues>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblIssues>"
        strTabs += m_strIssueName
        strTabs += "</font></a></b>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
        'End Modification

        '-- Reviews
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " Href='javascript:Assignments_clicked(8)' >"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
        'End Modification
        strTabs += "</b>"
        strTabs += "</a>&nbsp;<b><Font Size=1 face=Arial;verdana color=black>|</b>"

        '-- CRM
        strTabs += "<a "
        strTabs += "Href='javascript:Assignments_clicked(3)' STYLE='TEXT-DECORATION:NONE;"

        If CommonFunction.Constants.APP_CRM_MODULE_ENABLED = 0 Then
            strTabs += "display:none;'>"
        Else
            strTabs += "'>"
        End If
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id='lblCustomerQuery'>" + MyBase.GetResourceString("TAB_SUPPORT") + "</a></b>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id='lblCustomerQuery'>" + MyBase.GetResourceString("TAB_SUPPORT") + "</a></b>"
        'End Modification

        If CommonFunction.Constants.APP_CRM_MODULE_ENABLED = 1 Then strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"

        '-- MY PROJECTS
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += "Href='javascript:Assignments_clicked(4)' >"
        strTabs += "<img SRC='../../images/arrowselect.gif' Border=0 WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</font>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</font>"
        'End Modification

        strTabs += "</a>&nbsp;|</b>"

        '-- Show All Projects/ Show Selected Projects
        If Not Session("intProjectID") Is Nothing Then
            If m_blnSetProjectFilter = True Then
                strTabs += "<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(0)'>"

                'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
                'Changing color of tab links
                'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font>"
                strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font>"
                'End Modification
                strTabs += "</b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
            Else
                strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(1)'>"

                'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
                'Changing color of tab links
                'strTabs += "<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</b></font>"
                strTabs += "<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</b></font>"
                'End Modification

                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
            End If
        End If

        '-- HELP
        If (Request("FromWhereDB") = "PM") Then
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:OpenPMPage()'>"

            'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
            'Changing color of tab links
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            'End Modification
            strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
        Else
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:OpenPage()'>"


            'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
            'Changing color of tab links
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_HELP") + "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_HELP") + "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><b>|</b>"
            'End Modification
        End If

        strTabs += "</td></tr></table>"

        Return strTabs
    End Function

    Private Function PrepareMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : Function used to draw the Bottom menu..
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.DeveloperDB", "AppResources")

        '' Commented and modified By ParagD on 28-Sept-2005
        '' IssueID 21281 - Mascon
        '' To check if the Show Weekly View in the corporate Settings is True or False
        '' And Show the Weekly View link accordingly

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_WEEKLY_VIEW"), MyBase.GetResourceString("MENU_TASK_DIST")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_WEEKLY_VIEW_TOOLTIP"), MyBase.GetResourceString("MENU_TASK_DIST")}
        'Dim arrClientSideFunctions() As String = {"ToDoList_OnClick()", "WeeklyView_OnClick()", "ShowBiggerView(2)"}
        'Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        'Return strMenu

        If m_blnShowWeeklyView = True Then
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_WEEKLY_VIEW"), MyBase.GetResourceString("MENU_TASK_DIST")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_WEEKLY_VIEW_TOOLTIP"), MyBase.GetResourceString("MENU_TASK_DIST")}
        'Dim arrClientSideFunctions() As String = {"ToDoList_OnClick()", , "ProgressReport_OnClick()", "ShowBiggerView(2)", "MyGoals()"}
        Dim arrClientSideFunctions() As String = {"ToDoList_OnClick()", "WeeklyView_OnClick()", "ShowBiggerView(2)"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
        Else
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_TASK_DIST")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_TO_DO_LIST"), MyBase.GetResourceString("MENU_TASK_DIST")}
            Dim arrClientSideFunctions() As String = {"ToDoList_OnClick()", "ShowBiggerView(2)"}
            Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            Return strMenu
        End If
        '' End Of Addition By ParagD on 28-Sept-2005

    End Function

    Public Sub New()
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.DeveloperDB", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")

    End Sub

    Private Function GetWeekDay(ByVal dTDate As String) As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : Function used to draw the Botom menu..
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================

        '-- Functions returns Weekdays when passed the Date
        Dim strDay As String
        Select Case Weekday(CType(dTDate, Date))
            Case 1 : strDay = MyBase.GetResourceString("Sunday") + "   "
            Case 2 : strDay = MyBase.GetResourceString("Monday") + "   "
            Case 3 : strDay = MyBase.GetResourceString("Tuesday") + "  "
            Case 4 : strDay = MyBase.GetResourceString("Wednesday")
            Case 5 : strDay = MyBase.GetResourceString("Thursday") + " "
            Case 6 : strDay = MyBase.GetResourceString("Friday") + "   "
            Case 7 : strDay = MyBase.GetResourceString("Saturday") + " "
        End Select

        GetWeekDay = strDay
    End Function

    Private Sub GetSortingDetails(ByVal strListName As String, ByVal strTagID As String, ByRef strFieldName As String, ByRef strSortOrder As String)

        '=====================================================================
        ' Procedure Name        : GetSortingDetails
        ' Purpose               : Gets the User Preferences for Sorting from Database
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String
        Dim drSortDetails As IDataReader

        ' Build the query to retrieve the previously selected sort order.
        strSQLQuery = "SELECT * FROM tbl_PM_UserPreferences WHERE "
        strSQLQuery = strSQLQuery + "LoginID = " + Session("intLoginID").ToString

        If Trim(strListName) <> "" Then
            strSQLQuery = strSQLQuery + " AND ListName = '" + CommonFunctions.General.BuildQueryString(strListName) + "'"
        End If

        If Trim(strTagID) <> "" Then
            strSQLQuery = strSQLQuery + " AND TagID = " + strTagID
        End If

        drSortDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
        If drSortDetails.Read Then
            strFieldName = Trim(CommonFunctions.Data.CheckIsDBNull(drSortDetails("FieldName"), "").ToString + "")
            strSortOrder = Trim(CommonFunctions.Data.CheckIsDBNull(drSortDetails("SortOrder"), "").ToString + "")
        End If

        CommonFunctions.Data.DisposeDataReader(drSortDetails)

    End Sub


    Sub SaveSortingDetails(ByVal strListName As String, ByVal strTagID As String, ByVal strFieldName As String, ByVal strSortOrder As String)
        '=====================================================================
        ' Procedure Name        :	SaveSortingDetails
        ' Purpose               :	function saves the User Preferences into the Database 
        ' Description           :	Same as above
        ' Parameters Passed     :	strListName , strTagID , ByVal strFieldName , ByVal strSortOrder 
        ' Parameters Affected   :	strFieldName and strSortOrder 
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String

        ' Build the query to retrieve the previously selected sort order.
        strSQLQuery = "Exec usp_Ins_tbl_PM_UserPreferences " & Session("intLoginID").ToString

        ' Pass the List Name (if applicable).
        If Trim(strListName) <> "" Then
            strSQLQuery = strSQLQuery & ", '" + CommonFunctions.General.BuildQueryString(strListName) + "'"
        Else
            strSQLQuery = strSQLQuery + ", NULL"
        End If

        ' Pass the TagID (if applicable).
        If Trim(strTagID) <> "" Then
            strSQLQuery = strSQLQuery + ", " + CommonFunctions.General.BuildQueryString(strTagID)
        Else
            strSQLQuery = strSQLQuery + ", NULL"
        End If

        ' Pass the Field Name.
        If Trim(strFieldName) <> "" Then
            strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(strFieldName) & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        ' Pass the Sort Order.
        If Trim(strSortOrder) <> "" Then
            strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(strSortOrder) & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)

    End Sub

    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub


    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006
            'Purpose : ----- WhizibleSEM SP7
            'Issue ID: 5342
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If

        End If
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then

            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        'Modified By ManishK on 16th Nov 2005 For Developer and pm Dashboard No of documents attached to task functionality
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then

            Args.ColumnName = "" : Args.ApplySorting = False

        End If
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        'End of Modified By ManishK on 16th Nov 2005 For Developer and pm Dashboard No of documents attached to task functionality
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        'end of integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989


    End Sub

    Private Sub m_objGridIssueList_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridIssueList.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006
            'Purpose : ----- WhizibleSEM SP7
            'Issue ID :5342
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 15th Nov 2005 for Developer Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 15th Nov 2005 for Developer Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
    End Sub

    Private Sub m_objGridReviewList_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridReviewList.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 25th July 2006. For Cornell University.
            'Purpose : ----- Set "Project Name" Caption
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "ISREVIEWEE" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 15th Nov 2005 for Developer Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 15th Nov 2005 for Developer Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        'end of integration by harshada d on 21 DEC 2005 for Whizibleble SEM Issue ID 989
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        ' Added By NitinVS on 15 Dec 2004
        ' To Make A task red if IsCritical is 1
        Dim strClass As String
        Dim txtOnHold As String

        'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        Dim m_strToken As String
        'End Addition
        'Added By VarunA on 2-Sep-2008 
        'Purpose : To disable task for the project is on hold
        Dim txtProjectOnHold As String
        Dim MapToProjectOnHold As Boolean
        'End By VarunA on 2-Sep-2008 
        ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
        ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
        ' Start_MV_21-Nov-2008
        Dim blnProjectTimesheetBlocked As Boolean = False
        ' End_MV_21-Nov-2008
        ''Modified By VidyaJ - Performance Issue - SP4- IssueID - 82

        ''Addtion By MrugajaB On 4th June 2005  for Issue ID. 18389
        ''Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
        'txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
        'Dim strSQL As String = "select TaskOnHold from  tbl_PM_ProjectTasks where projectid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & " and Taskid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
        'Dim drAction As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'While drAction.Read
        '    m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(drAction("TaskOnHold")), String).ToString.ToLower
        '    Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
        'End While
        'CommonFunction.Data.DisposeDataReader(drAction)
        ''End Addition

        
        If Args.DataField.ToUpper = "TASKNAME" Then
            txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold")), String).ToString.ToLower
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'Added By VarunA on 2-Sep-2008 
            'Purpose : To disable task for the project is on hold
            txtProjectOnHold = "txtProjectOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MapToProjectOnHold"), "0"), Boolean)
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'End By VarunA on 2-Sep-2008 
            'End If
            'End Of Modifications

            ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
            ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
            ' Start_MV_21-Nov-2008
            blnProjectTimesheetBlocked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsProjectTimesheetBlocked"), "0"), Boolean)
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            ' End_MV_21-Nov-2008

            'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
            'purpose: Added additional parameter 'Token' for TaskName
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsCritical"), "0"), Boolean) = False Then
                Cancel = True
                Args.TDStyle = m_arrstrToolTipForGrid(Args.ColIndex)
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TaskID"), String) + CType(Session("intUserID"), String) + "0" + CType(1038, String))

                ''Commented and Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology

                'Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%';>" _
                '                                                & "<A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"

                'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"


                If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                    Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%';>" _
                                                                & "<IMG src=""../../Images/Scrum/UserStory.gif""> <A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"

                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"

                Else

                    Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%';>" _
                                                                & "<A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"

                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"

                    ''End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
                End If
                Args.ApplyHTMLEncode = False
            End If
            'End Addition



            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsCritical"), "0"), Boolean) Then
                Args.TDStyle = m_arrstrRedToolTipForGrid(Args.ColIndex)
                'Modified by MrugajaB on 13th April 2006
                'Purpose:for critical MPP tasks ,data display format was wrong
                'Modified By JyotiG(29-Aug-2006)
                'Issue ID : 5808
                'Start
                'If Args.ColIndex = 3 Then
                If Args.ColIndex = 4 Then
                    'End(JyotiG)
                    'If Args.ColIndex = 2 Then
                    'End Modification by MrugajaB
                    If Args.NoOfRowsPrinted Mod 2 = 0 Then
                        strClass = "clsTDOdd"
                    Else
                        strClass = "clsTDEven"
                    End If

                    'Modified by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
                    'purpose: Added additional parameter 'Token' for TaskName
                    Args.StringToBeInserted = "<TD class=" & strClass & " vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%;color:red';>" _
                                              & "<A style='color:red' href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
                    'End Modification
                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName"))) & "</A></TD>"
                    Cancel = True
                End If
            Else
                Args.TDStyle = m_arrstrToolTipForGrid(Args.ColIndex)
            End If
        End If
        'Modified BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
        'ContextName is not to be passed in query string, instead will be fetched from database 
        ' to avoid javscript errors because of Special characters '"#$%<> 

        '---------------------------------------------------------------------------------------------------------------
        'Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To open a popup window to maintain the tracking details.

        If Args.DataField.ToUpper = "FLAG" Then
            If Args.ColIndex = 1 Then
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")) & "')"">"\
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                Dim strSql As String
                Dim strFlagTo As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Task' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
                strSql = "usp_tbl_PM_FlagForTracking_Task_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                'Added By Usha Pandit On 08.07.2020 for getting/setting Token
                Dim strCurrentToken As String = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ProjectID"), String) + CType(Session("intUserID"), String) + "0" + "0" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")))
                'End Of Added By Usha Pandit On 08.07.2020 For getting/setting Token

                'Commented And Added By Usha Pandit On 08.07.2020 for getting/setting Token
                'If strFlagTo = "1" Then
                '    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"
                'ElseIf strFlagTo = "0" Then
                '    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"
                'Else
                '    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                                & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"

                'End If

                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & strCurrentToken & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & strCurrentToken & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & strCurrentToken & "')"">"
                End If
                'End Of Added By Usha Pandit On 08.07.2020 For getting/setting Token
                'End
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864

    End Sub

    Private Sub m_objMyProjects_Grid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMyProjects_Grid.ColumnHeaderTD_BeforePrint
        '-- Disable Sorting for Show Report Column header
        If Args.ColIndex = 6 Then
            Args.ApplySorting = False

        End If
    End Sub

    Private Sub m_objGridReviewList_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGridReviewList.DataRowTR_BeforePrint
        'If m_strUserName <> Args.DataReader("EmployeeName").ToString.Trim Then

        'End If
    End Sub

    Private Sub m_objMyProjects_Grid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMyProjects_Grid.DataRowTD_BeforePrint
        
        If Args.ColIndex = 6 Then
            Args.StringToBeInserted = "<TD Align=center><A Href='javascript:ShowProjectReport_OnClick(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("SHOW_REPORT") + "</A></TD>"
            Cancel = True
        End If

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'Added by DipaliS 20 Oct 2004
    Private Sub m_objGridReviewList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridReviewList.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "REVIEWEDDATE" Then
            Args.ReplacementValue = CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewStartDate"), Args.DataReader("ReviewedDate").ToString), Date)) + "-" + CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewEndDate"), Args.DataReader("ReviewedDate").ToString), Date))
        End If

        'Modified BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
        'ContextName is not to be passed in query string, instead will be fetched from database 
        ' to avoid javscript errors because of Special characters '"#$%<> 
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To open a popup window to maintain the tracking details.
        Dim strClass As String

        If Args.DataField.ToUpper = "FLAG" Then
            If Args.ColIndex = 1 Then
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_Review_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewType")) & "')"">"
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                'Start
                Dim strSql As String
                Dim strFlagTo As String
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Review' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID"))
                strSql = "usp_sel_tbl_PM_FlagForTracking_Review_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Review_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID")) & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Review_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID")) & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Review_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID")) & "')"">"
                End If
                'End
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
    End Sub
    'End addition by DipaliS

    Private Sub m_objGridIssueList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridIssueList.DataRowTD_BeforePrint
        Dim txtOnHold As String

        'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        Dim m_strToken As String
        'End Addition
        'Added By VarunA on 16-Sep-2008 
        'Purpose : To disable task for the project is on hold
        Dim txtProjectOnHold As String
        Dim MapToProjectOnHold As Boolean
        'End By VarunA on 16-Sep-2008 
        ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
        ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
        ' Start_MV_21-Nov-2008
        Dim blnProjectTimesheetBlocked As Boolean = False
        ' End_MV_21-Nov-2008
        'Modified By VidyaJ - Performance Issue - SP4- IssueID - 82

        ''Addtion By MrugajaB On 4th June 2005  for Issue ID. 18389
        ''Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
        'txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
        'Dim strSQL As String = "select TaskOnHold from  tbl_PM_ProjectTasks where projectid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & " and Taskid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
        'Dim drAction As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'While drAction.Read
        '    m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(drAction("TaskOnHold")), String).ToString.ToLower
        '    Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
        'End While
        'CommonFunction.Data.DisposeDataReader(drAction)
        ''End Addition

        'Added by SavitaS on 21 Sept 2006 for Security Issue 6197
        If Args.DataField.ToUpper = "TASKNAME" Then
            Cancel = True
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("OtherTaskID"), String) + CType(Session("intUserID"), String) + "0" + "0")

            Args.StringToBeInserted = "<TD align=center>" _
                          & "<A href=""JavaScript:BugDisplay('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("OtherTaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
            Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CType(Args.DataReader("TaskName"), String)) & "</A></TD>"
        End If
        'End of Added by SavitaS on 21 Sept 2006 for Security Issue 6197

        If Args.DataField.ToUpper = "TASKNAME" Then
            txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold")), String).ToString.ToLower
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'Added By VarunA on 16-Sep-2008 
            'Purpose : To disable task for the project is on hold
            txtProjectOnHold = "txtProjectOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MapToProjectOnHold"), "0"), Boolean)
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'End By VarunA on 16-Sep-2008 

            ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
            ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
            ' Start_MV_21-Nov-2008
            blnProjectTimesheetBlocked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsProjectTimesheetBlocked"), "0"), Boolean)
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            ' End_MV_21-Nov-2008
        End If
        'End Of Modifications

        'Modified BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
        'ContextName is not to be passed in query string, instead will be fetched from database 
        ' to avoid javscript errors because of Special characters '"#$%<> 

        '---------------------------------------------------------------------------------------------------------------
        'Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To open a popup window to maintain the tracking details.
        Dim strClass As String

        If Args.DataField.ToUpper = "FLAG" Then
            If Args.ColIndex = 1 Then
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")) & "')"">"
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                'Start
                Dim strSql As String
                Dim strFlagTo As String
                'Integrated by SandipL
               'Commented and Modified By JyotiG
                'Start_JG_9237_05-Jan-2007
                'strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Issue' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID"))

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='IB' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID"))
                strSql = "usp_sel_tbl_PM_FlagForTracking_IB_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                'End_JG_9237_05-Jan-2007
                'End Integration
                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                'Added By Usha Pandit On 08.07.2020 for getting/setting Token
                Dim strCurrentToken As String = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ProjectID"), String) + CType(Session("intUserID"), String) + "0" + "0" + CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")))
                'End Of Added By Usha Pandit On 08.07.2020 for getting/setting Token

                'Commented And Added By Usha Pandit On 08.07.2020 for getting/setting Token
                'If strFlagTo = "1" Then
                '    Args.StringToBeInserted = "<TD Title ='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                'ElseIf strFlagTo = "0" Then
                '    Args.StringToBeInserted = "<TD Title ='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                                & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                'Else
                '    Args.StringToBeInserted = "<TD Title ='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                                 & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                'End If

                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title ='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "','" & strCurrentToken & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title ='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "','" & strCurrentToken & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title ='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                 & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "','" & strCurrentToken & "')"">"
                End If
                'End Of Added By Usha Pandit On 08.07.2020 for getting/setting Token
                'End
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864

        'Modified by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        'purpose: Added additional parameter 'Token' for TaskName
        If Args.DataField.ToUpper = "TASK ENTRY" Then
            Cancel = True
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TaskID"), String) + CType(Session("intUserID"), String) + "0" + CType(1038, String))

            Args.StringToBeInserted = "<TD align=center>" _
                          & "<A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
            Args.StringToBeInserted = Args.StringToBeInserted & "Task Entry" & "</A></TD>"

        End If
        'End Modification
    End Sub

End Class
