Imports Whizible

Public Class PMDashboard
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PMDashboard
    ' Purpose               : Creates the Project Manager's Dashboard
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

    ' Added code by SwapnilR on 14th Dec 2004
    ' Purpose : To show the critical task in red color
    'integrated by harshada d for whiziblesem Issue ID 989
    '==================================================================================================================================
    'Modified By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
    '==================================================================================================================================
    '    Private m_arrstrStyle() As String = {"style='width=0%'", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}
    'Private m_arrstrStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width:5px;'Title='Document'", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=1%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}
    Private m_arrstrStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width=1%' Title='Document'", "{}Title='[TaskNotes]' style='width=50%'", "style='width:20%' nowrap", " style='width:1%'", "style='width:1%'", "style='width:1%'", " style='width:1%'", "style='width:1%'", "style='width:1%'", "style='width=20%' align=right nowrap Title='Variance (hrs)' "}
    '==================================================================================================================================
    'End of Modified By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
    '==================================================================================================================================
    'end of integration on 21 DEC 2005 by harshada d for whiziblesem Issue ID 989
    '***** Modified by sandipL on 27 Feb 2006 -- to avoid page crash due to additional index for doc functionality
    'Private m_arrstrRedStyle() As String = {"style='width=0%'", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width:60%;color:red';", "style='width=10%;color:red'", "style='width=5%;color:red' nowrap", "style='width=5%;color:red' nowrap", "style='width=5%;color:red' nowrap align=right", "style='width:10%;color:red' nowrap align=right", "style='width:10%;color:red' nowrap", " nowrap style='color:red'", "align=right nowrap style='color:red'", "align=right nowrap style='color:red'", " nowrap style='color:red'", "align=right nowrap style='color:red'", "align=right nowrap Title='Variance (hrs)' style='color:red'"}
    'Modified By JyotiG(29-Aug-2006)
    'Issue Id : 5808
    'Start
    'Private m_arrstrRedStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width:5px;'Title='Document", "'Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%;color:red;'", "style='width=10%;color:red;'", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap", "style='width=5%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap align=right", "style='width:10%;color:red;' nowrap", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap style='color:red;'", " nowrap style='color:red;'", "align=right nowrap style='color:red;'", "align=right nowrap Title='Variance (hrs)' style='color:red;'"}
    Private m_arrstrRedStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width:1%;'Title='Document'", "{}Title='[TaskNotes]' style='width=50%;color:red;'", "style='width=20%;color:red;'", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width:1%;color:red;' nowrap", " style='width=20%' align=right nowrap Title='Variance (hrs)' style='color:red;'"}
    'End(JyotiG)
    '***** End modification by SandipL on 27 Feb 2006
    ' End of code addtion by SwapnilR on 14th Dec 2004

    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objIssuesGrid As New WebPage.Templates.AdvancedGrid
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objReviewListGrid As New WebPage.Templates.AdvancedGrid
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objRiskListGrid As New WebPage.Templates.AdvancedGrid
    ''-- Use the Grid class to plot the grid
    Private WithEvents m_objMilestoneGrid As New WebPage.Templates.AdvancedGrid
    Private WithEvents m_MyProjectsGrid As New WebPage.Templates.AdvancedGrid


    Protected m_intListNumber As Integer = 0
    Protected m_strDB_PageName As String
    Protected m_strPageTitle As String
    Protected strList1_DefaultSortField, strList1_DefaultSortOrder As String
    Protected strList2_DefaultSortField, strList2_DefaultSortOrder As String
    Protected strList3_DefaultSortField, strList3_DefaultSortOrder As String
    Protected strList4_DefaultSortField, strList4_DefaultSortOrder As String
    Protected strList5_DefaultSortField, strList5_DefaultSortOrder As String
    Protected strList6_DefaultSortField, strList6_DefaultSortOrder As String
    Protected strList7_DefaultSortField, strList7_DefaultSortOrder As String
    Protected strList8_DefaultSortField, strList8_DefaultSortOrder As String
    ' WhizibleE SP2
    ' Added By NitinVS on 5 March 2005 
    ' To Add Deliverable Reporting on Dashboard.

    Protected strList9_DefaultSortField, strList9_DefaultSortOrder As String
    Private WithEvents m_DeliverablesGrid As New WebPage.Templates.AdvancedGrid

    ' End Addition By NitinVS on 5 MArch 2005 
    ' WhizibleE SP2    
    Protected m_strIssueName As String
    Protected m_intProgressRpt As Integer
    Protected m_intProjectID As Integer

    'Addtion By PrachiK on 19 Feb 2005 for Issue ID. 15661
    'Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
    Protected m_TaskOnHold As String = "0"
    'Addtion ended
    Protected m_strDashboardID As String = ""

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
    <System.Web.Services.WebMethod>
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

        m_strDB_PageName = "../DB/PMDashboard.aspx"
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
        ' WhizibleE SP2
        ' Modified By NitinVS on 5 March 2005 
        ' To Add Deliverable Reporting on Dashboard.
        ' Changed the max list number from 8 to 9 

        'If (m_intListNumber < 1 Or m_intListNumber > 8) Then
        If (m_intListNumber < 1 Or m_intListNumber > 9) Then

            ' End Modification By NitinVS on 5 MArch 2005 
            ' WhizibleE SP2

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
            Case 5
                m_strListName = "DB_ETC_REQUEST_LIST"
            Case 6
                m_strListName = "DB_MILESTONE_LIST"
            Case 7
                m_strListName = "DB_RISKS_LIST"
            Case 8
                m_strListName = "DB_REVIEW_LIST"
                ' WhizibleE SP2
                ' Modified By NitinVS on 5 March 2005 
                ' To Add Deliverable Reporting on Dashboard.
                ' Added Case for Deliverables
            Case 9
                m_strListName = "DB_DELIVERABLE_LIST"
                ' End Modification By NitinVS on 5 MArch 2005 
                ' WhizibleE SP2
            Case Else
                m_strListName = "DB_TO_DO_LIST"
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

        '-- Get the in-use or default sort order for the Project List.	
        Call GetSortingDetails("DB_ETC_REQUEST_LIST", "", strList5_DefaultSortField, strList5_DefaultSortOrder)
        If Trim(strList5_DefaultSortField) = "" Then
            strList5_DefaultSortField = "ProjectName"
            strList5_DefaultSortOrder = "ASC"
        End If

        ' Get the in-use or default sort order for the Milestone List.	
        Call GetSortingDetails("DB_MILESTONE_LIST", "", strList6_DefaultSortField, strList6_DefaultSortOrder)
        If Trim(strList6_DefaultSortField) = "" Then
            strList6_DefaultSortField = "Milestone"
            strList6_DefaultSortOrder = "ASC"
        End If

        'Modified BY NitinVS on 5 July 2007 for WhizibleSEM 7 
        'Page crashes as actualcolumname is Risk_description
        ' Get the in-use or default sort order for the List of Risks.	
        Call GetSortingDetails("DB_RISKS_LIST", "", strList7_DefaultSortField, strList7_DefaultSortOrder)
        If Trim(strList7_DefaultSortField) = "" Then
            'strList7_DefaultSortField = "R.Description"
            strList7_DefaultSortField = "R.Risk_Description"
            strList7_DefaultSortOrder = "ASC"
        End If
        'End Modified BY NitinVS on 5 July 2007 for WhizibleSEM 7

        '-- Get the in-use or default sort order for the List of Reviews.	
        Call GetSortingDetails("DB_REVIEW_LIST", "", strList8_DefaultSortField, strList8_DefaultSortOrder)
        If Trim(strList8_DefaultSortField) = "" Then
            strList8_DefaultSortField = "R.ReviewType"
            strList8_DefaultSortOrder = "ASC"
        End If

        ' WhizibleE SP2
        ' Added By NitinVS on 5 March 2005 
        ' To Add Deliverable Reporting on Dashboard.

        '-- Get the in-use or default sort order for the List of Deliverables.	
        Call GetSortingDetails("DB_DELIVERABLE_LIST", "", strList9_DefaultSortField, strList9_DefaultSortOrder)
        If Trim(strList9_DefaultSortField) = "" Then
            strList9_DefaultSortField = "Title"
            strList9_DefaultSortOrder = "ASC"
        End If

        ' End Addition By NitinVS on 5 MArch 2005 
        ' WhizibleE SP2

        '-- Retrieve the currently active sort field, and sort order.
        Select Case m_strListName
            Case "DB_TO_DO_LIST"
                m_strSortByField = strList1_DefaultSortField
                m_strAscOrDesc = strList1_DefaultSortOrder
            Case "DB_ISSUE_LIST"
                m_strSortByField = strList2_DefaultSortField
                m_strAscOrDesc = strList2_DefaultSortOrder
            Case "DB_CRM_QUERY_LIST"
                m_strSortByField = strList3_DefaultSortField
                m_strAscOrDesc = strList3_DefaultSortOrder
            Case "DB_PROJECT_LIST"
                m_strSortByField = strList4_DefaultSortField
                m_strAscOrDesc = strList4_DefaultSortOrder
            Case "DB_ETC_REQUEST_LIST"
                m_strSortByField = strList5_DefaultSortField
                m_strAscOrDesc = strList5_DefaultSortOrder
            Case "DB_MILESTONE_LIST"
                m_strSortByField = strList6_DefaultSortField
                m_strAscOrDesc = strList6_DefaultSortOrder
            Case "DB_RISKS_LIST"
                m_strSortByField = strList7_DefaultSortField
                m_strAscOrDesc = strList7_DefaultSortOrder
                ' Added By RajaniR on 27th June 2002.
            Case "DB_REVIEW_LIST"
                m_strSortByField = strList8_DefaultSortField
                m_strAscOrDesc = strList8_DefaultSortOrder
                ' End Addition.

                ' WhizibleE SP2
                ' Added By NitinVS on 5 March 2005 
                ' To Add Deliverable Reporting on Dashboard.

            Case "DB_DELIVERABLE_LIST"
                m_strSortByField = strList9_DefaultSortField
                m_strAscOrDesc = strList9_DefaultSortOrder

                ' End Addition By NitinVS on 5 MArch 2005 
                ' WhizibleE SP2
        End Select

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
        ' Dependencies          : AppResources.PMDashboard
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
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        '' Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDashboardID", "txtDashboardID", , , , m_strDashboardID, , , , , , True, , True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDashboardID", "txtDashboardID", , , , m_strDashboardID, , , , , , True, , True, EnableHTMLEncode:=True))
        '--- End addition purvaj

        '--- End addition purvaj

        '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
        If m_blnHideCombo = False Then
            '--- End addition purvaj

            '--1. Write the Combo for e-Dashboard selections
            CommonFunctions.General.WriteHTML("<TABLE Class=clsTable CellSpacing=0 Width=99.9%>")
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD>")

            '-- Initialize the Resource File
            MyBase.InitializeResources("AppResources.PMDashboard", "AppResources")
            Response.Write("<b>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("PAGE_CAPTION"))

            '-- Combo box to select the Type of e-Dashboard
            If Trim(Session("intPostID").ToString) <> "" Then
                strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString
            Else
                strSQL = "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString
            End If

            CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , Trim(m_strDB_PageName & "") & "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
        End If

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
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 1, 2003
        ' Revisions             : 
        '=====================================================================

        '-- 2 sections in the page: e-Dashboard and Issue Ageing/Upcoming events
        Dim objDashboardSection As WebPages.Template.SectionTitle
        Dim strTabs As String

        objDashboardSection = New WebPages.Template.SectionTitle
        Response.Write("<DIV Id='divContainer' Style='Overflow:Auto;Height:100%;width:100%'>")

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
        'Commented and added by Yogesh J on 10/12/2015
        ' Response.Write("<DIV Id='DivBottomList' Style='Overflow:Auto;Height:130;width:100%'>")
        Response.Write("<DIV Id='DivBottomList' Style='Height:130px;width:100%'>")
        'End of addition by Yogesh J on on 10/12/2015
        'Modified by NiranjanK on Date June 20,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE class=clsTable style='Width:100%;Height:100%'>")
        'End of modification by NiranjanK June 09,2006 for WhzibleSEM Issue ID.4168

        Response.Write("<TR>")
        Call IssueAgeingAnalysis()

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
        ' Dependencies          : AppResources.PMDashboard
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

                '-- Draws the CRM List
            Case 3
                Call Display_CRM_Tab()

                '-- Draws the MY PROJECTS LIST
            Case 4
                Call Display_MyProjects_Tab()

                '--Etc Requests
            Case 5
                Call Display_ETCRequests_Tab()
                '-- Milestones
            Case 6
                Call Display_Milestones_Tab()

                '-- Risks
            Case 7
                Call Display_Risks_Tab()

                '-- Draws the REVIEWS LIST
            Case 8
                Call Display_ReviewsList_Tab()

                ' WhizibleE SP2
                ' Added By NitinVS on 5 March 2005 
                ' To Add Deliverable Reporting on Dashboard.
            Case 9
                Call Display_Deliverable_Tab()
                ' End Addition By NitinVS on 5 MArch 2005 
                ' WhizibleE SP2
            Case Else
                Call Display_ToDoList_Tab()

        End Select

    End Sub

    Private Sub Display_ETCRequests_Tab()
        '=====================================================================
        ' Page Name             : Display_ETCRequests_Tab
        ' Purpose               : Draws the ETC Requests LIST to be Authenticated
        ' Description           : Called from DisplayGrid() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 7, 2004
        ' Revisions             : 
        '=====================================================================

        ''-- Use the Grid class to plot the grid
        Dim objGrid As New WebPage.Templates.AdvancedGrid
        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "TotalTasks", "TotalHours"}
        Dim arrstrUserFriendlyList() As String = {"Project Name", "Total Tasks", "Total ETC hours"}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"Project Name", "Total Tasks", "Total ETC hours"}
        Dim arrstrRowLinkField() As String = {"DisplayETCDetails(ProjectID)", "", ""}
        Dim arrstrTDStyle() As String = {"", " align=center", " align=center"}

        Dim strGRID As String
        Dim strSQLQuery As String

        Response.Write("<TABLE ID='tblETC' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TR class=clsTREven ><TD align=center>")

        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",5"
        If m_intListNumber = 5 Then
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList5_DefaultSortField & " " & strList5_DefaultSortOrder & "'"
        End If

        'to filter on current Project.
        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'E.ProjectID = " & m_intProjectID.ToString & "'"
        End If

        '--Plotting the Grid 
        With objGrid
            '--Columns in the Grid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .RowLinkArray = arrstrRowLinkField
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .TDStyleArray = arrstrTDStyle
            .ColumnHeaderAlignment = "center"
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
    Private Sub Display_Milestones_Tab()
        '=====================================================================
        ' Page Name             : Display_Milestones_Tab
        ' Purpose               : Draws the Milestones LIST 
        ' Description           : Called from DisplayGrid() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 7, 2004
        ' Revisions             : 
        '=====================================================================
        'integrated by harshada d for issue id 989 whiziblesem
        '==================================================================================================================================
        'Modified By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
        '==================================================================================================================================
        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "MileStone", "PlannedCompletionDate", "ActualCompletionDate", "AnalysisStatus", "MilestoneStatus", "Show Report"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "Milestone", "Start Date", "End Date", "Analysis Status", "Milestone Status", "Show Report"}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"", "Flag", "Document", "Milestone", "Start Date", "End Date", "Analysis Status", "Milestone Status", "Show Report"}
        Dim arrstrRowLinkField() As String = {"", "Flag_MileStone_OnClick(ProjectID,MileStoneID,MileStone)", "DocumentLink_Milestone_OnClick(,ProjectID,MilestoneID)", "", "", "", "", "", "MilestoneReport_OnClick(AnalysisID)"}
        Dim arrstrTDStyle() As String = {"Align=1%", "style='width:1%;' Title='Flag'", "style='width:5px;' Title='Document'", "", "", "", "", "", " align=center"}
        Dim arrstrGroupByColumn(0) As String '= {"1"}
        Dim arrstrDisableLinkOnColumn() As String = {"", "", "", "", "", "", "ShowReport"}
        '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
        '==================================================================================================================================
        Dim arrstrIgnoreHTML() As String = {"", "1", "1"}
        '==================================================================================================================================
        'End of addition By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
        '==================================================================================================================================

        '==================================================================================================================================
        'eND OF Modified By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
        '==================================================================================================================================
        'end of integration by harshada d on 21 DEC 2005 whiziblesem issue ID 989
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupByColumn(0) = ("1")
        Else
            arrstrGroupByColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        Dim strGRID As String
        Dim strSQLQuery As String

        Response.Write("<TABLE ID='tblMilestones' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TR class=clsTREven ><TD align=center>")

        '--Form the SQL Query for Grid
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ", 6"
        If m_intListNumber = 6 Then
            'strSQLQuery = strSQLQuery & ",' ORDER BY ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",' ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",' ORDER BY ProjectName, " & strList6_DefaultSortField & " " & strList6_DefaultSortOrder & "'"
            strSQLQuery = strSQLQuery & ",' ORDER BY " & strList6_DefaultSortField & " " & strList6_DefaultSortOrder & "'"
        End If

        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'M.ProjectID = " & m_intProjectID.ToString & "'"
        End If

        '--Plotting the Grid 
        With m_objMilestoneGrid
            '--Columns in the Grid
            'integration by harshada d on 21 DEC 2005 whiziblesem issue ID 989
            '==================================================================================================================================
            'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
            '==================================================================================================================================
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            '==================================================================================================================================
            'End of addition By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached
            '==================================================================================================================================
            'end of integration by harshada d on 21 DEC 2005 whiziblesem issue ID 989
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .GroupOnColumn = arrstrGroupByColumn        '-- Grouped on ProjectName
            .RowLinkArray = arrstrRowLinkField          '-- Links from rows (Link For Milestone Report)
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .TDStyleArray = arrstrTDStyle               '-- Style for the table rows
            .ColumnHeaderAlignment = "left"           '-- Cloumn Header Alignment set to Center
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .RowLinkEnableOnColumn = arrstrDisableLinkOnColumn
            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL

            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")

        m_objMilestoneGrid = Nothing
    End Sub

    Private Sub Display_Risks_Tab()
        '=====================================================================
        ' Page Name             : Display_ETCRequests_Tab
        ' Purpose               : Draws the ETC Requests LIST to be Authenticated
        ' Description           : Called from DisplayGrid() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 7, 2004
        ' Revisions             : 
        '=====================================================================

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "Risk_Description", "DateIdentified", "Probability", "Severity", "Status", "PersonResponsible"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", MyBase.GetResourceString("GRD_RISK"), MyBase.GetResourceString("GRD_DATE_IDENTIFIED"), MyBase.GetResourceString("GRD_PROBABILITY"), MyBase.GetResourceString("GRD_SEVERITY"), MyBase.GetResourceString("GRD_STATUS"), MyBase.GetResourceString("GRD_RESPONSIBLE")}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"", "Flag", MyBase.GetResourceString("GRD_RISK"), MyBase.GetResourceString("GRD_DATE_IDENTIFIED"), MyBase.GetResourceString("GRD_PROBABILITY"), MyBase.GetResourceString("GRD_SEVERITY"), MyBase.GetResourceString("GRD_STATUS"), MyBase.GetResourceString("GRD_RESPONSIBLE")}
        Dim arrstrRowLinkField() As String = {"", "Flag_Risk_OnClick(ProjectID,RiskID,Risk_Description)", "", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"", "style='width=1%'", "", "", " align=right", " align=right", "align=right", "align=center"}
        Dim arrGroupOnColumn(0) As String '= {"1"}
        Dim arrstrIgnoreHTML() As String = {"", "1"}

        Dim strGRID As String
        Dim strSQLQuery As String
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrGroupOnColumn(0) = ("1")
        Else
            arrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        Response.Write("<TABLE ID='tblRisks' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TR class=clsTREven ><TD align=center>")

        strSQLQuery = "EXEC usp_DB_MenuOptions " + Session("intUserID").ToString + ", 7"

        If m_intListNumber = 7 Then
            'strSQLQuery = strSQLQuery + ",'ORDER BY P.ProjectName, " + m_strSortByField & " " + m_strAscOrDesc + "'"
            strSQLQuery = strSQLQuery + ",'ORDER BY " + m_strSortByField & " " + m_strAscOrDesc + "'"
        Else
            'strSQLQuery = strSQLQuery + ",'ORDER BY P.ProjectName, " + strList7_DefaultSortField + " " + strList7_DefaultSortOrder + "'"
            strSQLQuery = strSQLQuery + ",'ORDER BY " + strList7_DefaultSortField + " " + strList7_DefaultSortOrder + "'"
        End If

        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery + ", 'R.ProjectID = " + m_intProjectID.ToString + "'"
        End If

        '--Plotting the Grid 
        With m_objRiskListGrid
            '--Columns in the Grid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .RowLinkArray = arrstrRowLinkField          '-- Links from rows (Link For Milestone Report)
            .TDStyleArray = arrstrTDStyle
            .ColumnHeaderAlignment = "left"
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .GroupOnColumn = arrGroupOnColumn               '-- Group on Project Name
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

        m_objRiskListGrid = Nothing
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
        ' Dependencies          : AppResources.PMDashboard
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

        ' Get the previous settings for the Current column in the To do list.
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
            Response.Write(" width='100%'>")
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
        If m_strTaskListFilter <> "5" Then Response.Write("style='display:none'")
        Response.Write(">&nbsp;<font Face=verdana size=1> | ")
        Response.Write(MyBase.GetResourceString("FROM"))
        Response.Write("</font>&nbsp;<font Face=verdana size=1>")
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunctions.General.CheckIsNothing(Session("DB_FromDate"), ""), , "Graph", , , , , , , , True)
        Response.Write("</font>")

        Response.Write("&nbsp;<font Face=verdana size=1>")
        Response.Write(MyBase.GetResourceString("TO"))
        Response.Write("&nbsp;")
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunctions.General.CheckIsNothing(Session("DB_ToDate"), ""), , "Graph", , , , , , , , True)
        Response.Write("&nbsp;|</font> ")
        Response.Write("<a style='TEXT-DECORATION: none' HREF='javascript:FilterTaskList(5)'>")
        Response.Write("<font Size=1 Face=verdana color=black>")
        Response.Write("<b>Show")
        Response.Write("</a> |</b></font></td></tr>")

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
            If CommonFunctions.General.CheckIsNothing(Session("DB_FromDate")) <> "" Then
                dtmTaskList_FromDate = CommonFunctions.Dates.GetDate(CType(CommonFunctions.General.CheckIsNothing(Session("DB_FromDate")), Date))
            End If
            If CommonFunctions.General.CheckIsNothing(Session("DB_ToDate")) <> "" Then
                dtmTaskList_ToDate = CommonFunctions.Dates.GetDate(CType(CommonFunctions.General.CheckIsNothing(Session("DB_ToDate")), Date))
            End If

        End If

        'fire a query which will return you the all the tasks for a selected person for that particular day
        'it will also include the pending tasks for that particular person				

        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",1"
        'integrated by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '====================================================================================================================
        'Modified By Manishk On 16th Nov 2005 For Developer and Pm Dashboard functionality of No of Documents attached to the task
        '====================================================================================================================
        'If m_intListNumber = 1 Then
        If m_intListNumber = 2 Then
            '====================================================================================================================
            'End of Modified By Manishk On 16th Nov 2005 For Developer and Pm Dashboard functionality of No of Documents attached to the task
            '====================================================================================================================
            'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY  " & m_strSortByField & " " & m_strAscOrDesc & "'"
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

        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '====================================================================================================================
        'Modified By Manishk On 16th Nov 2005 For Developer and Pm Dashboard functionality of No of Documents attached to the task field added is DocumentLink
        '====================================================================================================================
        '-- define the Actual Array and UserFriendly array..
        'Dim arrstrActualList() As String = {"ProjectName", "DocumentLink", "TaskTypeLink", "TaskName", "Priority", "StartDate", "EndDate", "Duration", "Work", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}
        'Done by JyotiG For Issue Id :5342
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "TaskName", "Priority", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}

        'Dim arrstrUserFriendlyList() As String = {"", "", "", "Task Name", "Priority", "Start Date", "End Date", "Duration", "Work", "Start Date", "End Date", "Duration", "Work", "Start Date", "Work (hrs)", "Variance (hrs)"}
        'Done by JyotiG For Issue ID : 5342
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "Task Name", "Priority", "Start Date", "End Date", "Duration", "Work", "Start Date", "Work (hrs)", "Variance (hrs)"}

        Dim arrstrLinkArray() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", ""}

        '-- define the Tool Tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]'", "", "", "", "", "", "", "", "", "", "", "", "Variance (hrs)"}
        'Dim arrstrStyle() As String = {"style='width=0%'", "style='width:5px;' Title='Document'", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width=60%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}
        Dim arrstrStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width:5px;' Title='Document'", "{}Title='[TaskNotes]' style='width=1%'", "style='width=10%'", "style='width=5%' nowrap", "style='width=5%' nowrap", "style='width=5%' nowrap align=right", "style='width:10%' nowrap align=right", "style='width:10%' nowrap", " nowrap", "align=right nowrap", "align=right nowrap", " nowrap", "align=right nowrap", "align=right nowrap Title='Variance (hrs)' "}

        'Dim arrstrToolTipForGrid() As String = {"ProjectName", "Document", "TaskTypeLink", "TaskName", "Priority", "StartDate", "EndDate", "Duration", "Work", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}
        'Done By JyotiG For Issue ID : 5342
        Dim arrstrToolTipForGrid() As String = {"ProjectName", "Flag", "Document", "TaskName", "Priority", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}

        'Dim arrColGroup() As String = {"1-4", "5-8", "9-12", "13-14", "15"}

        'Dim arrColGroup() As String = {"1-5", "6-9", "10-13", "14-15", "16"}
        'Done By JyotiG For Issue ID : 5342
        Dim arrColGroup() As String = {"1-5", "6-9", "10-11", "12"}

        'Dim arrColGroupNames() As String = {"", "Current", "Baseline", "Actual", ""}
        'Done By JyotiG For Issue ID : 5342
        Dim arrColGroupNames() As String = {"", "Baseline", "Actual", ""}

        'Dim arrColGroupExpanded() As String = {"1", strShowCurrent, strShowBaseline, strShowActual, "1"}
        'Done By JyotiG For Issue ID : 5342
        Dim arrColGroupExpanded() As String = {"1", strShowBaseline, strShowActual, "1"}

        'Modified by MrugajaB on 13th April 2006
        'Purpose:for critical MPP tasks ,data display format was wrong
        'Dim arrstrGroupOnColumn() As String = {"1"}
        Dim arrstrGroupOnColumn(0) As String '= {"0"}

        'End Modification
        Dim arrstrIgnoreHTML() As String = {"", "1", "1", "1"}
        Dim arrstrRowLinkField() As String = {"", "Flag_OnClick(ProjectID,TaskID,TaskName)", "DocumentLink_OnClick(ProjectID,ParentTask_UID,TaskID,ApplyEffortDistribution,HaveSubTaskTypes)", "TaskLink_OnClick(ProjectID,TaskID)", "", "", "", "", "", "", "", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=0%'", "style='width=1%' Title='Document'", "{}Title='[TaskNotes]' style='width=50%'", "style='width:20%' nowrap", " style='width:1%'", "style='width:1%'", "style='width:1%'", " style='width:1%'", "style='width:1%'", "style='width:1%'", "style='width=20%' align=right nowrap Title='Variance (hrs)' "}
        Dim strGRID As String
        '====================================================================================================================
        'End of Modified By Manishk On 16th Nov 2005 For Developer and Pm Dashboard functionality of No of Documents attached to the task
        '====================================================================================================================
        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989

        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
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
            .TDStyleArray = arrstrTDStyle 'arrstrStyle
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .ColNameToolTipOnEachRow = True

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
            .StaticHeaderStyle = STATIC_HEADER_STYLE.ENABLED
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
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 7, 2004
        ' Revisions             : 
        '=====================================================================

        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989    
        '===================================================================== '=====================================================================
        'Modified By Manishk on 16th Nov 2005 for PM Dashboard No of Attached Documents Functionality
        '===================================================================== '=====================================================================

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "TaskName", "Issue_Priority", "Issue_Status", "Task_StartDate", "Task_EndDate", "Work", "Actualwork", "Task Entry"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "Issue", "Priority", "Status", "Start Date", "End Date", "Work (hrs)", "Actual Work(hrs)", "Task Entry"}
        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"style='width:0%", "Title='Task Type Timesheet'", "{}Title='[TaskNotes]' style='width:25%'", " nowrap ", "", "", "", " align=right ", " align=right ", " align=center "}
        Dim arrstrToolTipForGrid() As String = {"", "Title='Flag'", "Title='Document'", "{}Title='[TaskNotes]' style='width:25%'", " nowrap ", "", "", "", " align=right ", " align=right ", " align=center "}
        Dim arrstrRowLinkField() As String = {"", "Flag_Issue_OnClick(ProjectID,IssueID,TaskName)", "DocumentLink_Issue_OnClick(ProjectID,IssueID)", "BugDisplay(ProjectID,OtherTaskID)", "", "", "", "", "", "", "TaskLink_OnClick(ProjectID,TaskID)"}
        'Dim arrstrTDStyle() As String = {"style='width=0%'", "style='width=1%'", "style='width=20%'", "style='width=5%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'"}
        Dim arrstrGroupOnColumn(0) As String '= {"1"}
        Dim arrstrIgnoreHTML() As String = {"", "1", "1", "1"}
        '===================================================================== '=====================================================================
        'End of Modified By Manishk on 16th Nov 2005 for PM Dashboard No of Attached Documents Functionality
        '===================================================================== '=====================================================================
        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989

        Dim strGRID As String
        Dim strSQLQuery As String

        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        Response.Write("<TABLE ID='Bug' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
        Response.Write("<TR class=clsTREven ><TD align=center>")

        'fire a query which will return you the all the tasks for a selected person for that particular day

        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",2"
        If m_intListNumber = 2 Then
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName, " & strList2_DefaultSortField & " " & strList2_DefaultSortOrder & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList2_DefaultSortField & " " & strList2_DefaultSortOrder & "'"
        End If

        '-- If Show Selected Project has been checked .. we Add this filter
        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'A.ProjectID = " & m_intProjectID.ToString & "'"
        End If

        '--Plotting the Grid 
        With m_objIssuesGrid
            '--Columns in the Grid
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .RowLinkArray = arrstrRowLinkField
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            '==================================================================================================================================
            'Modified By ManishK on 15th Nov 2005 for pm Dashboard Functionality
            '==================================================================================================================================
            '.TDStyleArray = arrstrToolTipForGrid
            .TDStyleArray = arrstrToolTipForGrid
            '==================================================================================================================================
            'End of Modified By ManishK on 15th Nov 2005 for PM Dashboard Functionality
            '==================================================================================================================================

            'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            '.TDStyleArray = arrstrToolTipForGrid
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .SQL = strSQLQuery
            .EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True
            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortByField
            .SortOrder = m_strAscOrDesc
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL

            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")

        m_objIssuesGrid = Nothing
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
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQL As String
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Modified By ManishK on 16th Nov 2005 for pm Dashboard Functionality
        '==================================================================================================================================
        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"IsReviewee", "Flag", "DocumentLink", "ProjectName", "ReviewType", "ReviewedDate", "ReviewedBy", "Reviewee", "ReviewEffort", "ReviewStatus"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", "", MyBase.GetResourceString("REVIEW_TYPE"), MyBase.GetResourceString("REVIEW_DATE"), MyBase.GetResourceString("REVIEWER"), MyBase.GetResourceString("REVIEWEE"), MyBase.GetResourceString("WORK"), MyBase.GetResourceString("REVIEW_STATUS")}
        '-- define the Style/Tool tip for each column
        Dim arrstrRowLinkField() As String = {"", "Flag_Review_OnClick(ProjectID,ReviewStatisticsID,ReviewType)", "DocumentLink_Review_OnClick(ProjectID,ReviewStatisticsID,IssueIds)", "", "", "", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {" ", "style='width:1%;' Title='Flag'", "style='width:5px;' Title='Document'", "Title='Project Name' ", "style='width=25%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'"}
        Dim arrstrIgnoreHTML() As String = {"", "1", "1"}
        '==================================================================================================================================
        'End of Modified By ManishK on 16th Nov 2005 for pm Dashboard Functionality
        '==================================================================================================================================
        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        Dim arrstrGroupOnColumn(0) As String ' = {"1"}
        Dim strGRID As String
        Dim strSQLQuery As String
        Dim drReviews As IDataReader
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        Response.Write("<TABLE ID='tblReview' cellspacing=1 border=0 width=99.9% Style='VISIBILITY:hidden;DISPLAY:none' >")
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
        With m_objReviewListGrid
            '--Columns in the Grid
            'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            '==================================================================================================================================
            'Added By ManishK on 16th Nov 2005 for pm Dashboard Functionality
            '==================================================================================================================================
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .RowLinkArray = arrstrRowLinkField
            '==================================================================================================================================
            'End of addition By ManishK on 16th Nov 2005 for pm Dashboard Functionality
            '==================================================================================================================================
            'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .ColNameToolTipOnEachRow = True

            .SQL = strSQLQuery + strSQL
            .EmptyValueReplacement = m_strNotSpecified

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

        m_objReviewListGrid = Nothing
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
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        '-- My Projects Grid
        Dim strSQLQuery, strGRID As String
        'Dim objGrid As New WebPage.Templates.AdvancedGrid

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "ExpectedStartDate", "ExpectedEndDate",
                                            "ExpectedDuration", "EstimatedEfforts", "ActualEfforts", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("ISSUE_PROJ_NAME"), MyBase.GetResourceString("START_DATE"),
                                    MyBase.GetResourceString("END_DATE"), MyBase.GetResourceString("DURATION"),
                                    MyBase.GetResourceString("WORK"), MyBase.GetResourceString("ACT_WORK"),
                                    MyBase.GetResourceString("SHOW_REPORT")}

        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "style='width=5%';Title='Task Type Timesheet'", "{}Title='[TaskNotes]'", "", "", "", "", "", "", ""}

        Dim arrstrRowLinkField() As String = {"DisplayProjectDetails(ProjectID)", "", "", "", "", "", "ShowProjectReport_OnClick(ProjectID)"}
        Dim arrstrTDStyle() As String = {"", "style='width=20%'", "style='width=10%'", "style='width=10%;text-align:right;'", "style='width=10%;text-align:right;'", "style='width=10%;text-align:right;'", "style='width=10%;'"}

        '--'My Projects' List
        Response.Write("<TABLE ID='MyProject' border=0 cellspacing=1  width='99.9%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        Response.Write("<TR class=clsTREven ><td align=center >")

        '-- SQL Query for the 'My Projects' grid
        'strSQLQuery = "EXEC usp_Sel_Project_For_DA " & Session("intUserID").ToString
        strSQLQuery = "EXEC usp_Sel_ProjectStatus_ForEmployee " + Session("intUserID").ToString
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

        With m_MyProjectsGrid
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

            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)

        Response.Write("</td></tr>")
        Response.Write("</table>")
        m_MyProjectsGrid = Nothing
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
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery, strGRID As String
        Dim drGetTaskList As IDataReader
        Dim objGrid As New WebPage.Templates.AdvancedGrid

        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"Subject", "AssignDate", "ExpectedResolvedDate", "Priority", "Status"}
        Dim arrstrUserFriendlyList() As String = {"Subject", "Assigned On", "Expected Resolution Date", "Priority", "Status"}
        '-- define the Style/Tool tip for each column
        'Dim arrstrToolTipForGrid() As String = {"", "style='width=5%';Title='Task Type Timesheet'", "{}Title='[TaskNotes]'", "", "", "", "", "", "", ""}
        Dim arrstrRowLinkField() As String = {"CRMQuery_OnClick(QueryID)", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"", "", "", "", ""}

        Response.Write("<TABLE ID='CRM' border=0 cellspacing=1  width='99.9%'  style='VISIBILITY:hidden;DISPLAY:none'>")
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

        'Response.Write("<br>")
        Response.Write("<table id=tblBottom border=0 width=99.9%>")

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
            'Commented by Yogesh J on 10/12/2015
            ' Response.Write("<table border=0 class=clsTable width=99.9% style='border-style:double;'>")
            Response.Write("<table border=0 class=clsTable width=99.9% style='border:double;'>")
            'End of commented by Yogesh J on 10/12/2015
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
        Response.Write("<TABLE cellspacing=1 class=clsTable width=99.9%>")
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

        'Modified by VidyaJ -  SP4- IssueID - 82
        strSQLQuery = " EXEC usp_DB_Project_BTSAginganalysis " & Session("intUserID").ToString  '"EXEC usp_Sel_ProjectInfo " & Session("intUserID").ToString
        drGetProjectList = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)

        Response.Write("<div style='overflow:auto;height:100%;width:100%;'>")
        Response.Write("<table cellspacing=0 class=clsTable style='width:100%;'>")
        Response.Write("<tr class=clsTRColumnheader >")
        Response.Write("<td align=left><b>" + MyBase.GetResourceString("ISSUE_PROJ_NAME", True) + "</td>")
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_5_DAYS", True) + "</td>")
        'Modified by NiranjanK on Date June 06,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_5_10_DAYS", True) + "</td>")
        Response.Write("<td align=right><b>" + MyBase.GetResourceString("ISSUE_10_DAYS", True) + "</td>")
        'End of modification by NiranjanK on June 06,2006
        Response.Write("</tr>")
        intBugFlag = 0
        intCounter = 0
        strClassName = "clsTROdd"

        Do While drGetProjectList.Read


            'm_intProjectID = Session("intProjectID")
            If (m_blnSetProjectFilter And drGetProjectList("ProjectId").ToString = m_intProjectID.ToString) Or Not m_blnSetProjectFilter Then

                'Modified by VidyaJ -  SP4- IssueID - 82
                'Replace drGetBugReport with drGetProjectList as issue details are fetched in mail query itself

                ' strSQLQuery = "EXEC usp_DB_BTSAginganalysis " & drGetProjectList("ProjectId").ToString + "," + Session("intUserID").ToString
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

                    Response.Write(" <tr class=" + strClassName + ">")
                    Response.Write("<td align=left>")
                    CommonFunctions.General.WriteHTML(Trim(drGetProjectList("ProjectName").ToString + ""))
                    Response.Write("</td>")

                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("5"), "0"), Integer) <> 0 Then
                        Response.Write("<td align=Right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strPageCaption, True) + " assigned to you, that are less than 5 days old."">")
                        Response.Write("<a href='javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",1)'>")
                        Response.Write(drGetProjectList("5"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=Right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("5").ToString, "0"))
                        Response.Write("</td>")

                    End If
                    'Modified by NiranjanK on Date June 06,2006 for WhizibleSEM Issue ID.4168
                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("10"), "0"), Long) <> 0 Then
                        Response.Write("<td align=Right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strPageCaption, True) + " assigned to you, that are between 5 to 10 days old."">")
                        Response.Write("<a href=""javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",2)"">")
                        Response.Write(drGetProjectList("10"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=Right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("10"), "0"))
                        Response.Write("</td>")

                    End If

                    If CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("15"), "0"), Long) <> 0 Then
                        Response.Write("<td align=Right TITLE=""Click here to view the list of unresolved " + CommonFunctions.General.FormatString(m_strIssueName, True) + " assigned to you, that are more than 10 days old."">")
                        Response.Write("<a href=""javascript:BTSBugList(" + drGetProjectList("ProjectID").ToString + ",3)"">")
                        Response.Write(drGetProjectList("15"))
                        Response.Write("</a></td>")

                    Else
                        Response.Write("<td align=Right>")
                        Response.Write(CommonFunctions.Data.CheckIsDBNull(drGetProjectList("15"), "0"))
                        Response.Write("</td>")

                    End If
                    'End of modification by NiranjanK June 06,2006 for WhzibleSEM Issue ID.4168 

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
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If Session("ShowFlag") Is Nothing Then
            Session.Add("ShowFlag", Request.QueryString("SortFlag"))
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        strTabs = "<table cellspacing=0 border=0 width=99.9%>"
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
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Boolean) = True Then
            strTabs += "<Font Size=1 face=Arial;verdana color=navy>Sort Across</Font><INPUT id=" & strBtnName &
                           " name=" & strBtnName & " type=checkbox title='This will remove grouping and sort according to selected column.' class=clsCheckBox checked onClick ='javascript:ApplySort()'>"
        ElseIf CType(Session("ShowFlag"), Boolean) = False Then
            strTabs += "<Font Size=1 face=Arial;verdana color=navy>Sort Across</Font><INPUT id=" & strBtnName &
                           " name=" & strBtnName & " type=checkbox title='This will remove grouping and sort according to selected column.' class=clsCheckBox onClick ='javascript:ApplySort()'>"
        End If
        strTabs += "</b>"
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        '-- TO DO LIST
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " href='javascript:Assignments_clicked(1)' ><Font Size=1 face=Arial;verdana color=black><B>|"
        strTabs += "<img border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "<Font Size=1 face=Arial;verdana color=white>&nbsp;<b id=lblAssignedTasks>"
        strTabs += "<Font Size=1 face=Arial;verdana color=navy>&nbsp;<b id=lblAssignedTasks>"
        'End Modification
        strTabs += MyBase.GetResourceString("TAB_TO_DO") + "</font></b></font>"
        strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>|"

        '-- ISSUES LIST
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += "Href='javascript:Assignments_clicked(2)' >"
        strTabs += "<img SRC='../../images/arrowselect.gif' border=0 WIDTH=7 >"
        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblIssues>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblIssues>"
        'End Modification

        strTabs += m_strIssueName
        strTabs += "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

        '-- Reviews
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " Href='javascript:Assignments_clicked(8)' >"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblReview>" + MyBase.GetResourceString("TAB_REVIEWS")
        'End Modification

        strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

        '-- Risks
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " Href='javascript:Assignments_clicked(7)' >"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblRisks>" + MyBase.GetResourceString("TAB_RISKS") + "</b>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblRisks>" + MyBase.GetResourceString("TAB_RISKS") + "</b>"
        'End Modification

        strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>|"

        '-- Milestones
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " Href='javascript:Assignments_clicked(6)' >"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblMilestones>" + MyBase.GetResourceString("TAB_MILESTONES") + "</b>"
        'End Modification

        strTabs += "</a><Font Size=1 face=Arial;verdana color=black><B>|"

        ' WhizibleE SP2
        ' Added By NitinVS on 5 March 2005 
        ' To Add Deliverable Reporting on Dashboard.

        '-- Deliverables
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += " Href='javascript:Assignments_clicked(9)' >"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy>"
        'End Modification

        strTabs += "<b id=lblDeliverables>" + MyBase.GetResourceString("TAB_DELIVERABLES") + "</b></a><Font Size=1 face=Arial;verdana color=black><B>|"

        ' End Addition By NitinVS on 5 MArch 2005 
        ' WhizibleE SP2

        '-- ETC
        strTabs += "<a "
        strTabs += "Href='javascript:Assignments_clicked(5)' STYLE='TEXT-DECORATION:NONE;>"
        strTabs += "<img Border=0 SRC='../../images/arrowselect.gif' WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id='lblETC'>" + MyBase.GetResourceString("TAB_ETC") + "</b></a>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id='lblETC'>" + MyBase.GetResourceString("TAB_ETC") + "</b></a>"
        'End Modification
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

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
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id='lblCustomerQuery'>" + MyBase.GetResourceString("TAB_SUPPORT") + "</b></a>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id='lblCustomerQuery'>" + MyBase.GetResourceString("TAB_SUPPORT") + "</b></a>"
        'End Modification
        If CommonFunction.Constants.APP_CRM_MODULE_ENABLED = 1 Then strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"

        '-- MY PROJECTS
        strTabs += "<a style='TEXT-DECORATION:None' "
        strTabs += "Href='javascript:Assignments_clicked(4)' >"
        strTabs += "<img SRC='../../images/arrowselect.gif' Border=0 WIDTH=7 >"

        'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        'Changing color of tab links
        'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</b></font>"
        strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b id=lblMyProjects>" + MyBase.GetResourceString("TAB_PROJECTS") + "</b></font>"
        'End Modification
        strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"


        '-- Show All Projects/ Show Selected Projects
        If Not Session("intProjectID") Is Nothing Then
            If m_blnSetProjectFilter = True Then
                strTabs += "<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(0)'>"

                'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
                'Changing color of tab links
                'strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font></b>"
                strTabs += "&nbsp;<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_ALL_PROJECTS") + "</font></b>"
                'End Modification
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
            Else
                strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:SetProjectFilter(1)'>"

                'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
                'Changing color of tab links
                'strTabs += "<Font Size=1 face=Arial;verdana color=white><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</font></b>"
                strTabs += "<Font Size=1 face=Arial;verdana color=navy><b>" + MyBase.GetResourceString("TAB_SEL_PROJECTS") + "</font></b>"
                'End Modification
                strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
            End If
        End If

        '-- HELP
        If (Request("FromWhereDB") = "PM") Then
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:OpenPMPage()'>"

            'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
            'Changing color of tab links
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP") + "</font></b>"
            'End Modification
            strTabs += "</a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
        Else
            strTabs += "&nbsp;<a style='TEXT-DECORATION:None' Href='javascript:OpenPage()'>"

            'Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
            'Changing color of tab links
            'strTabs += "<Font Size=1 face=Arial;verdana color=white><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP")</font></b></a>&nbsp; <Font Size=1 face=Arial;verdana color=black><B>|"
            strTabs += "<Font Size=1 face=Arial;verdana color=navy><b Title='" + MyBase.GetResourceString("TAB_HELP_TOOLTIP") + "'>" + MyBase.GetResourceString("TAB_HELP")
            'End Modification

            strTabs += "</font></b></a>&nbsp;<Font Size=1 face=Arial;verdana color=black><B>|"
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
        MyBase.InitializeResources("AppResources.PMDashboard", "AppResources")

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
            'Dim arrClientSideFunctions() As String = {"ToDoList_OnClick()", "WeeklyView_OnClick()", "ProgressReport_OnClick()", "ShowBiggerView(2)", "MyGoals()"}
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
        MyBase.InitializeResources("AppResources.PMDashboard", "AppResources")
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
            Case 1 : strDay = "Sunday   "
            Case 2 : strDay = "Monday   "
            Case 3 : strDay = "Tuesday  "
            Case 4 : strDay = "Wednesday"
            Case 5 : strDay = "Thursday "
            Case 6 : strDay = "Friday   "
            Case 7 : strDay = "Saturday "
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
        strSQLQuery = strSQLQuery + "LoginID = " + CommonFunctions.General.CheckIsNothing(Session("intLoginID"), "")

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
            strSQLQuery = strSQLQuery & ", '" & CommonFunctions.General.BuildQueryString(strListName) & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        ' Pass the TagID (if applicable).
        If Trim(strTagID) <> "" Then
            strSQLQuery = strSQLQuery & ", " & CommonFunctions.General.BuildQueryString(strTagID)
        Else
            strSQLQuery = strSQLQuery & ", NULL"
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
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then
            ' Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        'Added  By ManishK on 16th Nov 2005 For Developer and pm Dashboard No of documents attached to task functionality
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========

        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False

        End If

        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========
        'End of addition By ManishK on 16th Nov 2005 For Developer and pm Dashboard No of documents attached to task functionality
        '=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='=========='==========

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
    End Sub

    Private Sub m_objIssuesGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objIssuesGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
    End Sub

    Private Sub m_objReviewListGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objReviewListGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "ISREVIEWEE" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 15th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
    End Sub

    Private Sub m_objRiskListGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRiskListGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If

        If Args.ColIndex = 3 Or Args.ColIndex = 4 Then
            Args.Alignment = "right"
        End If
        If Args.ColIndex = 5 Then
            Args.Alignment = "right"
        End If
        If Args.ColIndex = 6 Then
            Args.Alignment = "center"
        End If
    End Sub

    Private Sub m_objMilestoneGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMilestoneGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
    End Sub

    Private Sub m_MyProjectsGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_MyProjectsGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 6 Then
            Args.ApplySorting = False

        End If
    End Sub

    Private Sub m_objMilestoneGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMilestoneGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 7 Then
            If Not CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ShowReport"), "false"), Boolean) Then
                Args.StringToBeInserted = "<TD>&nbsp;</TD>"
                Cancel = True
            End If
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
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStone")) & "')"">"
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                'Start
                Dim strSql As String
                Dim strFlagTo As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='MileStone' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID"))
                strSql = "usp_sel_tbl_PM_FlagForTracking_MileStone " + CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                'Added By Usha Pandit On 15.07.2020 for getting/setting Token
                Dim strCurrentToken As String = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ProjectID"), String) + CType(Session("intUserID"), String) + "0" + "0" + CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")))
                'End Of Added By Usha Pandit On 15.07.2020 for getting/setting Token

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                'Commented And Added By Usha Pandit On 15.07.2020 for getting/setting Token
                'If strFlagTo = "1" Then
                '    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "')"">"
                'ElseIf strFlagTo = "0" Then
                '    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "')"">"
                'Else
                '    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                '                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "')"">"
                'End If

                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "','" & strCurrentToken & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "','" & strCurrentToken & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_MileStone_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("MileStoneID")) & "','" & strCurrentToken & "')"">"
                End If
                'End
                'End Of Added By Usha Pandit On 15.07.2020 for getting/setting Token
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
    End Sub

    Private Sub m_MyProjectsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_MyProjectsGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 6 Then

            Args.StringToBeInserted = "<TD Align=center><A Href='javascript:ShowProjectReport_OnClick(" + Args.DataReader("ProjectID").ToString + ")'>" + MyBase.GetResourceString("SHOW_REPORT") + "</A></TD>"
            Cancel = True
        End If

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'Added by DipaliS 20 Oct 2004
    Private Sub m_objReviewListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objReviewListGrid.DataRowTD_BeforePrint

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

                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Review' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("ReviewStatisticsID"))
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

    ' Code added by SwapnilR on 14th Dec 2004
    ' Purpose : To display critical task in red color
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strClass As String
        Dim txtOnHold As String
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

        'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        Dim m_strToken As String
        'End Addition

        'Modified By VidyaJ - Performance Issue -  SP4- IssueID - 82

        ''Addtion By VivekP On 2005  for Issue ID. 18389
        ''Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
        'txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
        'Dim strSQL As String = "select TaskOnHold from  tbl_PM_ProjectTasks where projectid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & " and Taskid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
        'Dim drAction As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'While drAction.Read
        '    m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(drAction("TaskOnHold")), String).ToString.ToLower
        '    Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
        'End While
        'CommonFunction.Data.DisposeDataReader(drAction)
        ''Addtion Ended
        If Args.DataField.ToUpper = "TASKNAME" Then
            txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold")), String).ToString.ToLower
            'Added By VarunA on 2-Sep-2008 
            'Purpose : To disable task for the project is on hold
            txtProjectOnHold = "txtProjectOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MapToProjectOnHold"), "0"), Boolean)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            'Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True))
            ''End By VarunA on 2-Sep-2008 
            'Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'End By VarunA on 2-Sep-2008 
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding

            ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
            ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
            ' Start_MV_21-Nov-2008
            blnProjectTimesheetBlocked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsProjectTimesheetBlocked"), "0"), Boolean)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True))
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True, EnableHTMLEncode:=True))
            ' End_MV_21-Nov-2008

            'Added by MrugajaB on 19th Sept 2006 for Whiziblesem Issue ID.6197
            'purpose: Added additional parameter 'Token' for TaskName
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsCritical"), "0"), Boolean) = False Then
                Cancel = True
                Args.TDStyle = m_arrstrStyle(Args.ColIndex)
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TaskID"), String) + CType(Session("intUserID"), String) + "0" + CType(1038, String))

                Args.StringToBeInserted = "<TD vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%';>" _
                                                            & "<A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"

                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")) & "</A></TD>"
                Args.ApplyHTMLEncode = False
            End If
            'End Addition

            'End If

            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsCritical"), "0"), Boolean) Then
                Args.TDStyle = m_arrstrRedStyle(Args.ColIndex)
                'Modified by MrugajaB on 13th April 2006
                'Purpose:for critical MPP tasks ,data display format was wrong
                'Modified By JyotiG(29-Aug-2006)
                'Issue ID : 5808
                'Strat
                'If Args.ColIndex = 3 Then
                If Args.ColIndex = 4 Then
                    'End (JyotiG)
                    'End Modification by MrugajaB
                    'If Args.ColIndex = 2 Then
                    If Args.NoOfRowsPrinted Mod 2 = 0 Then
                        strClass = "clsTDOdd"
                    Else
                        strClass = "clsTDEven"
                    End If

                    'Modified by MrugajaB on 19th Sept 2006 for Whiziblesem Issue ID.6197
                    'purpose: Added additional parameter 'Token' for TaskName
                    'Args.StringToBeInserted = "<TD class=" & strClass & " vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%;color:red';>" _
                    '                         & "<A style='color:red' href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"

                    Args.StringToBeInserted = "<TD class=" & strClass & " vAlign=top Title='" & Replace(Replace(CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskNotes")), "'", "''"), """", """""") & "' style='width:1%;color:red';>" _
                                              & "<A style='color:red' href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
                    'End Modification
                    Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskName")) & "</A></TD>"
                    Cancel = True
                End If
            Else
                Args.TDStyle = m_arrstrStyle(Args.ColIndex)
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
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                'Start
                Dim strSql As String
                Dim strFlagTo As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Task' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
                strSql = "usp_tbl_PM_FlagForTracking_Task_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"

                Else
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                & "<A href=""JavaScript:Flag_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "')"">"
                End If
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then
            ' Args.ReplacementValue = ""
            'Args.ColumnName = "" : Args.ApplySorting = False
        End If
    End Sub
    ' End of code addtion by SwapnilR on 14th Dec 2004

    Private Sub m_objRiskListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRiskListGrid.DataRowTD_BeforePrint
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
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_Risk_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("Risk_Description")) & "')"">"
                'Modified By Jyoti
                'Issue Id : 5820
                'Date : 04-Sep-2006
                'Start
                Dim strSql As String
                Dim strFlagTo As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Risk' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID"))
                strSql = "usp_sel_tbl_PM_FlagForTracking_Risk_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Risk_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID")) & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                & "<A href=""JavaScript:Flag_Risk_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID")) & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                                & "<A href=""JavaScript:Flag_Risk_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID")) & "')"">"
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

    Private Sub Display_Deliverable_Tab()
        '=====================================================================
        ' Page Name             : Display_Deliverable_Tab
        ' Purpose               : Draws the Deliverables LIST WhizibleE SP2
        ' Description           : Called from DisplayGrid() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.PMDashboard
        ' Author                : NitinVS
        ' Created               : March 5, 2005
        ' Revisions             : 
        '=====================================================================

        ''-- Use the Grid class to plot the grid
        Dim objGrid As New WebPage.Templates.AdvancedGrid
        Dim strSQLQuery As String
        Dim strGRID As String
        'Modified By nitinVs on 8 APr 2005 for WhizibleE SP2 Changed Column from ScheduleID to DocumentNo
        '-- define the Actual Array and UserFriendly array..
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Modified By ManishK on 16th Nov 2005 for PM Dashboard Functionality for no of documents attached functionality
        '==================================================================================================================================
        Dim arrstrActualList() As String = {"ProjectName", "Flag", "DocumentLink", "DocumentNo", "Title", "StartDate", "EarliestStartDate", "DeliverableLCE", "ActualEffort", "Show Report"}
        Dim arrstrUserFriendlyList() As String = {"", "Flag", "", MyBase.GetResourceString("COL_DELIVERABLE_CODE"),
            MyBase.GetResourceString("COL_TITLE"),
            MyBase.GetResourceString("COL_STARTDATE"),
            MyBase.GetResourceString("COL_ENDDATE"),
            MyBase.GetResourceString("COL_PLANNED_EFFORT"),
            MyBase.GetResourceString("COL_ACTUAL_EFFORT"),
            MyBase.GetResourceString("COL_SHOW_REPORT")}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"", "Flag", "Document", MyBase.GetResourceString("COL_DELIVERABLE_CODE"),
            MyBase.GetResourceString("COL_TITLE"),
            MyBase.GetResourceString("COL_STARTDATE"),
            MyBase.GetResourceString("COL_ENDDATE"),
            MyBase.GetResourceString("COL_PLANNED_EFFORT"),
            MyBase.GetResourceString("COL_ACTUAL_EFFORT"),
            MyBase.GetResourceString("COL_SHOW_REPORT")}
        Dim arrstrRowLinkField() As String = {"", "Flag_Deliverable_OnClick(ProjectID,ScheduleID,Title)", "DocumentLink_Deliverable_OnClick(ScheduleID)", "", "", "", "", "", "", "DisplayDeliverableReport(ScheduleID)"}
        Dim arrstrTDStyle() As String = {"Align=1%", "style='width:1%;' Title='Flag''", "style='width:2%;' Title='Document''", "style='width:10%;'", "style='width:20%;'", "style='width:12%;'", "style='width:20%;text-align:right;'", "style='width:12%;text-align:right;'", "style='width:12%;text-align:right;'", "style='width:12%;text-align:right;'"}
        '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality
        '==================================================================================================================================
        Dim arrstrIgnoreHTML() As String = {"", "1", "1"}
        '==================================================================================================================================
        'End of addition By ManishK on 16th Nov 2005 for PM Dashboard Functionality
        '==================================================================================================================================

        '==================================================================================================================================
        'End of Modified By ManishK on 16th Nov 2005 for PM Dashboard Functionality for no of documents attached functionality
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        Dim arrstrGroupByColumn(0) As String '= {"1"}
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by JyotiG. On 1st Aug 2006. 
        'Purpose : ----- For WhizibleSEM SP7
        'Issue ID : 5342 
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupByColumn(0) = ("1")
        Else
            arrstrGroupByColumn(0) = ""
        End If
        'End of addition by JyotiG
        '---------------------------------------------------------------------------------------------------------------

        '("tblDeliverables", "lblDeliverables");		
        '--'My Projects' List
        Response.Write("<TABLE ID='tblDeliverables' border=0 cellspacing=1  width='99.9%'  style='VISIBILITY:hidden;DISPLAY:none'>")
        Response.Write("<TR class=clsTREven ><td align=center >")

        '-- SQL Query for the 'My Projects' grid
        'strSQLQuery = "EXEC usp_Sel_Project_For_DA " & Session("intUserID").ToString
        strSQLQuery = "EXEC usp_sel_deliverable_details " + Session("intUserID").ToString
        If m_intListNumber = 4 Then
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName , " & m_strSortByField & " " & m_strAscOrDesc & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & m_strSortByField & " " & m_strAscOrDesc & "'"
        Else
            'strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName ,  " & strList9_DefaultSortField & " " & strList9_DefaultSortOrder & "'"
            strSQLQuery = strSQLQuery & ",'ORDER BY " & strList9_DefaultSortField & " " & strList9_DefaultSortOrder & "'"
        End If
        ' End Modification By NitinVS on 8 April 2005 for WhizibleE Changed Column ScheduleID TO DocumentNo
        'Added By VidyaJ - for issueid - 590 - SP4
        '-- If Show Selected Project has been checked .. we Add this filter
        If m_blnSetProjectFilter = True Then
            strSQLQuery = strSQLQuery & ", 'tbl_PM_Project.ProjectID = " & m_intProjectID.ToString & "'"
        End If
        'End Of Addition

        With m_DeliverablesGrid
            '--Columns in the Grid
            'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
            '==================================================================================================================================
            'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
            '==================================================================================================================================
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            '==================================================================================================================================
            'End of addition By ManishK on 16th Nov 2005 for PM Dashboard Functionality of number of documents attached to the task
            '==================================================================================================================================
            'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989

            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrstrTDStyle
            .GroupOnColumn = arrstrGroupByColumn        '-- Grouped on ProjectName

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
        m_MyProjectsGrid = Nothing


    End Sub

    ' WhizibleE SP2
    ' Added By NitinVS on 5 March 2005 
    ' To Add Deliverable Reporting on Dashboard.

    Private Sub m_DeliverablesGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_DeliverablesGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            '---------------------------------------------------------------------------------------------------------------
            'Code Added by JyotiG. On 1st Aug 2006. 
            'Purpose : ----- For WhizibleSEM SP7
            'Issue ID : 5342 
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        'integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
        '==================================================================================================================================
        'Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        '==================================================================================================================================
        'End of Added By ManishK on 16th Nov 2005 for PM Dashboard Functionality  of number of documents attached to the task
        '==================================================================================================================================

        'end of integration by harshada d on 21 DEC 2005 whiziblesem Issue ID 989
    End Sub

    ' End Addition By NitinVS on 5 MArch 2005 
    ' WhizibleE SP2  

    Private Sub m_objIssuesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objIssuesGrid.DataRowTD_BeforePrint
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


        ''Addtion By VivekP On 2005  for Issue ID. 18389
        ''Purpose: When an task is 'On Hold' ,an indication should be provided for the Resources on the Dashboard.
        'txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
        'Dim strSQL As String = "select TaskOnHold from  tbl_PM_ProjectTasks where projectid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & " and Taskid=" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID"))
        'Dim drAction As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'While drAction.Read
        '    m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(drAction("TaskOnHold")), String).ToString.ToLower
        '    Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
        'End While
        'CommonFunction.Data.DisposeDataReader(drAction)
        ''Addtion Ended
        If Args.DataField.ToUpper = "TASKNAME" Then
            txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold")), String).ToString.ToLower
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True, EnableHTMLEncode:=True))
            'Added By VarunA on 16-Sep-2008 
            'Purpose : To disable task for the project is on hold
            txtProjectOnHold = "txtProjectOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
            MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MapToProjectOnHold"), "0"), Boolean)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True))
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True, EnableHTMLEncode:=True))

            'End By VarunA on 16-Sep-2008 

            ' Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
            ' Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
            ' Start_MV_21-Nov-2008
            blnProjectTimesheetBlocked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsProjectTimesheetBlocked"), "0"), Boolean)
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            ''Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True))
            Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True, EnableHTMLEncode:=True))
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
                'Integrated by SandipL SP8 to SP9
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
                If strFlagTo = "1" Then
                    Args.StringToBeInserted = "<TD Title ='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                              & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                ElseIf strFlagTo = "0" Then
                    Args.StringToBeInserted = "<TD Title ='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                             & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                Else
                    Args.StringToBeInserted = "<TD Title ='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                             & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
                End If
                'End
                Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
                Cancel = True
            End If
        End If

        'End of addition by MonikaI
        'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864

        'Added by SavitaS on 21 Sept 2006 for Security Issue 6197
        If Args.DataField.ToUpper = "TASKNAME" Then
            Cancel = True
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("OtherTaskID"), String) + CType(Session("intUserID"), String) + "0" + "0")

            Args.StringToBeInserted = "<TD align=center  Title='Task Name'>" _
                          & "<A href=""JavaScript:BugDisplay('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("OtherTaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
            Args.StringToBeInserted = Args.StringToBeInserted & CType(Args.DataReader("TaskName"), String) & "</A></TD>"
        End If
        'End of Added by SavitaS on 21 Sept 2006 for Security Issue 6197
        '---------------------------------------------------------------------------------------------------------------
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

    Private Sub m_DeliverablesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_DeliverablesGrid.DataRowTD_BeforePrint
        Dim strClass As String
        ' Dim Title As String
        'Modified BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864
        'ContextName is not to be passed in query string, instead will be fetched from database 
        ' to avoid javscript errors because of Special characters '"#$%<> 
        '---------------------------------------------------------------------------------------------------------------
        'Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To open a popup window to maintain the tracking details.

        If Args.DataField.ToUpper = "FLAG" Then
            If Args.ColIndex = 1 Then
                'Args.StringToBeInserted = "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("Title")) & "')"">"
                'Modified By Jyoti, Date : 04-Sep-2006
                'Issue Id : 5820
                'Start
                'Start_JG_11516_14-Mar-2007
                'Issue : E-dashboard : Java Script Error --> PM Dashboard --> Deliverable section -->  click on Flag Icon (Click on deliverable having single quote) 
                'Added by Christinat for SP8 Upgrade Hexaware IssueID: 11392
                'Title = CommonFunctions.General.CheckIsNothing(Args.DataReader("Title"))
                'Title = Title.Replace(Chr(34), "\""")
                'Title = Title.Replace(Chr(39), "\'")
                'End of addition
                'End_JG_11516_14-Mar-2007
                Dim strSql As String
                Dim strFlagTo As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='Deliverable' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID"))
                strSql = "usp_sel_tbl_PM_FlagForTracking_Deliverable_FlagTo " + CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID"))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                If strFlagTo = "1" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_11516_14-Mar-2007
                    'Issue : E-dashboard : Java Script Error --> PM Dashboard --> Deliverable section -->  click on Flag Icon (Click on deliverable having single quote) 
                    'Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                    '                         & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("Title")) & "')"">"
                    Args.StringToBeInserted = "<TD Title='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                                             & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "')"">"
                    'End_JG_11516_14-Mar-2007

                ElseIf strFlagTo = "0" Then
                    'Commented and Modified By JyotiG
                    'Start_JG_11516_14-Mar-2007
                    'Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                    '                         & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("Title")) & "')"">"
                    Args.StringToBeInserted = "<TD Title='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                         & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "')"">"
                    'End_JG_11516_14-Mar-2007
                Else
                    'Commented and Modified By JyotiG
                    'Start_JG_11516_14-Mar-2007
                    'Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                    '                         & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("Title")) & "')"">"
                    Args.StringToBeInserted = "<TD Title='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
                         & "<A href=""JavaScript:Flag_Deliverable_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ScheduleID")) & "')"">"
                    'End_JG_11516_14-Mar-2007
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


End Class
